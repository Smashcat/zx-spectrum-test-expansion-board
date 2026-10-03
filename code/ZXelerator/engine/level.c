#include "level.h"
#include "lzUnpack.h"
#include "TileLayer.h"
#include "Sprite.h"

#include <string.h>

// The window of level tiles kept in each engine layer: all 64x64 of it, centred on the middle of the screen
#define WINDOW_SIZE         TILE_LAYER_WIDTH
#define MAX_LEVEL_TILESETS  4
#define MAX_LEVEL_ANIMS     64

typedef struct LevelLayerState {
    const LevelLayer *def;
    uint8_t *tiles;
    // Foreground tiles: a bit per tile, the count of foreground tiles before each row, and the tiles themselves
    const uint32_t *fgBits;
    uint16_t *fgRowStart;
    const uint8_t *fgList;
    int rowWords;
    const LevelTileSet *tileSet;
    const LevelTileSet *fgTileSet;
    // Top left tile of the window held in the engine layer, and whether it's been filled yet
    int winX;
    int winY;
    bool filled;
} LevelLayerState;

typedef struct LevelAnimState {
    const LevelAnim *anim;
    const uint8_t *src;     // The tile set in flash, to copy frames from
    uint8_t *dst;           // Its copy in RAM, which the layers draw from
    uint8_t frame;
    uint8_t ticksLeft;
    uint8_t tileBytes;      // 8 for 8x8 tiles, 32 for 16x16
} LevelAnimState;

// The loaded level's tiles are 16x16: each fills 2x2 cells of the engine layers
static bool level16=false;

static inline int tileSetBytes(const LevelTileSet *ts)
{
    return (ts->tileSize==16)?32:8;
}

static uint8_t levelRam[LEVEL_RAM_SIZE] __attribute__((aligned(4)));
static const LevelDef *level=NULL;
static LevelLayerState layers[MAX_TILE_LAYERS];
static int layerCount=0;
static uint8_t *tileSetRam[MAX_LEVEL_TILESETS];

// Added to the camera every frame: the game's own offset (setLevelCameraOffset), and the shake (shakeLevel) - its frame
// (-1 for none), size and direction
static int cameraOffsetX, cameraOffsetY;
static int shakeFrame=-1;
static float shakeSize, shakeDirX, shakeDirY;
#define SHAKE_FRAMES    8
// The shake as a fraction of its size each frame: away with the weight of the impact, bouncing back, settling
static const float shakeCurve[SHAKE_FRAMES]={0.6f,1.0f,0.6f,0.0f,-0.5f,-0.5f,-0.2f,0.0f};
static LevelAnimState anims[MAX_LEVEL_ANIMS];
static int animCount=0;

// Actors: one per object, in the level's RAM
static LevelActor *actors=NULL;
static int objectCount=0;
static LevelShowFn showFn=NULL;
static LevelHideFn hideFn=NULL;
static int showMargin=32, hideMargin=96, wakeMargin=0;
static int8_t classSet[256];
static uint8_t classCollisions[256];
// The layer object sprites go on if their object layer doesn't say (the level layer players would be on)
static int mainLayer=0;

// What's remembered about every level: a byte per persistent object, each level's after the one before's (in levelList
// order). The loaded level's part, if it has one
static uint8_t levelState[LEVEL_STATE_SIZE];
static uint8_t *stateBlock=NULL;
static int currentID=-1;
static LevelSetupFn setupFn=NULL;
static LevelSwitchFn switchFn=NULL;
#define STATE_ON        0x01    // A switch that's on
#define STATE_GONE      0x02    // Killed or collected
#define STATE_SET       0x04    // Has been set (the level's been entered, or the game set it) - otherwise it's as placed
#define STATE_MEMORY    3       // The game's own 5 bits start here

static inline int popCount(uint32_t v)
{
    v=v-((v>>1)&0x55555555u);
    v=(v&0x33333333u)+((v>>2)&0x33333333u);
    return (int)((((v+(v>>4))&0x0f0f0f0fu)*0x01010101u)>>24);
}

static inline int floorDiv(int a, int b)
{
    return (a>=0)?(a/b):-((-a+b-1)/b);
}

static inline int wrapTo(int a, int n)
{
    const int m=a%n;
    return (m<0)?m+n:m;
}

static LevelLayerState *stateOf(int layerIX)
{
    for(int n=0;n<layerCount;n++){
        if(layers[n].def->layer==layerIX){
            return layers+n;
        }
    }
    return NULL;
}

// A level tile position to a position in the layer's stored area - false if it's outside it (and doesn't wrap)
static inline bool localPos(const LevelLayerState *L, int tileX, int tileY, int *lx, int *ly)
{
    const LevelLayer *d=L->def;
    int x=tileX-d->tileX;
    int y=tileY-d->tileY;
    if(d->flags&LEVEL_WRAP_X){
        x=wrapTo(x,d->width);
    }else if(x<0 || x>=d->width){
        return false;
    }
    if(d->flags&LEVEL_WRAP_Y){
        y=wrapTo(y,d->height);
    }else if(y<0 || y>=d->height){
        return false;
    }
    *lx=x;
    *ly=y;
    return true;
}

// The foreground tile at a stored position (0 if none): its bit, then its place in the list - the count of set bits
// before it, from the row's start count and the words before it in the row
static inline int foregroundAt(const LevelLayerState *L, int lx, int ly)
{
    if(!L->fgBits){
        return 0;
    }
    const uint32_t *row=L->fgBits+(ly*L->rowWords);
    const int w=lx>>5;
    const uint32_t bit=1u<<(lx&31);
    if(!(row[w]&bit)){
        return 0;
    }
    int ix=L->fgRowStart[ly];
    for(int n=0;n<w;n++){
        ix+=popCount(row[n]);
    }
    ix+=popCount(row[w]&(bit-1));
    return L->fgList[ix];
}

// Copy a level tile into a cell of the engine layer (and its foreground tile into the foreground layer). On 16x16
// levels, a cell is a quarter of a level tile: the cell holds the tile's number (the engine layer draws the quarter its
// position gives), with that quarter's colours
static void fillCell(const LevelLayerState *L, int cellX, int cellY)
{
    const LevelLayer *d=L->def;
    const int r=((cellY&(TILE_LAYER_HEIGHT-1))*TILE_LAYER_WIDTH)+(cellX&(TILE_LAYER_WIDTH-1));
    const int a=((cellY&(TILE_LAYER_HEIGHT-1))*TILE_LAYER_WIDTH*2)+(cellX&(TILE_LAYER_WIDTH-1));
    const int tileX=level16?(cellX>>1):cellX;
    const int tileY=level16?(cellY>>1):cellY;
    // Index of the cell's two attributes (top, bottom) for tile 0 - add the tile number times attrStep
    const int quarter=level16?((((cellY&1)<<1)|(cellX&1))*2):0;
    const int attrStep=level16?8:2;
    int lx, ly;
    const bool inside=localPos(L,tileX,tileY,&lx,&ly);

    TileLayer *t=tileLayer+d->layer;
    const int tile=inside?L->tiles[(ly*d->width)+lx]:0;
    t->tileMap[r]=(uint8_t)tile;
    // (a single colour layer, and its foreground, don't use their cells' colours - so they aren't copied)
    if(!d->singleColour){
        const uint8_t *at=L->tileSet->attrs+(tile*attrStep)+quarter;
        t->attrMap[a]=at[0];
        t->attrMap[a+TILE_LAYER_WIDTH]=at[1];
    }

    if(d->fgLayer>=0){
        TileLayer *f=tileLayer+d->fgLayer;
        const int fg=inside?foregroundAt(L,lx,ly):0;
        f->tileMap[r]=(uint8_t)fg;
        if(!d->singleColour){
            const uint8_t *fa=L->fgTileSet->attrs+(fg*attrStep)+quarter;
            f->attrMap[a]=fa[0];
            f->attrMap[a+TILE_LAYER_WIDTH]=fa[1];
        }
    }
}

static void fillColumn(const LevelLayerState *L, int tileX, int winY)
{
    for(int y=winY;y<winY+WINDOW_SIZE;y++){
        fillCell(L,tileX,y);
    }
}

static void fillRow(const LevelLayerState *L, int winX, int tileY)
{
    for(int x=winX;x<winX+WINDOW_SIZE;x++){
        fillCell(L,x,tileY);
    }
}

// Move a layer's window, copying in the columns and rows that come into it
static void streamLayer(LevelLayerState *L, int winX, int winY)
{
    if(!L->filled || winX<=L->winX-WINDOW_SIZE || winX>=L->winX+WINDOW_SIZE ||
        winY<=L->winY-WINDOW_SIZE || winY>=L->winY+WINDOW_SIZE){
        for(int y=winY;y<winY+WINDOW_SIZE;y++){
            fillRow(L,winX,y);
        }
        L->filled=true;
    }else{
        if(winX>L->winX){
            for(int x=L->winX+WINDOW_SIZE;x<winX+WINDOW_SIZE;x++){
                fillColumn(L,x,winY);
            }
        }else{
            for(int x=winX;x<L->winX;x++){
                fillColumn(L,x,winY);
            }
        }
        if(winY>L->winY){
            for(int y=L->winY+WINDOW_SIZE;y<winY+WINDOW_SIZE;y++){
                fillRow(L,winX,y);
            }
        }else{
            for(int y=winY;y<L->winY;y++){
                fillRow(L,winX,y);
            }
        }
    }
    L->winX=winX;
    L->winY=winY;
}

static void showAnimFrame(const LevelAnimState *s)
{
    const int def=s->anim->def;
    const int src=s->anim->frames[s->frame].def;
    const int b=s->tileBytes;
    memcpy(s->dst+(def*b),s->src+(src*b),(size_t)b);
    memcpy(s->dst+(256*b)+(def*b),s->src+(256*b)+(src*b),(size_t)b);
}

static uint32_t align4(uint32_t n)
{
    return (n+3u)&~3u;
}

// Take an actor's sprite away (telling the game first)
static void hideActor(int objectIX)
{
    LevelActor *a=actors+objectIX;
    const int ix=a->sprite;
    if(ix<0){
        return;
    }
    a->sprite=-1;
    // Only if it's still this actor's (the game may have reset the sprites since)
    if(ix<totalSprites && spriteList[ix].inUse && spriteList[ix].levelObject==objectIX){
        if(hideFn){
            hideFn(objectIX,ix);
        }
        freeSprite(ix);
    }
}

// The frame a switch shows when it's on: the last of its sprite sheet (e.g. a door fully open - the game can play the
// frames in between as it opens). A level tile shows the next tile along
static uint8_t onFrame(const LevelDef *lv, const LevelObject *o)
{
    if(o->sheet<0){
        return o->frame;
    }
    const LevelSpriteSheet *sh=lv->sheets+o->sheet;
    return (sh->tileSet)?(uint8_t)(o->frame+1):(uint8_t)(sh->frames-1);
}

// Where a level's part of the remembered state starts (after the levels before it in levelList), or -1 if it doesn't
// fit in LEVEL_STATE_SIZE
static int levelStateOffset(int levelID)
{
    int offset=0;
    for(int n=0;n<levelID;n++){
        offset+=levelList[n]?levelList[n]->stateBytes:0;
    }
    const int size=levelList[levelID]?levelList[levelID]->stateBytes:0;
    return (offset+size<=LEVEL_STATE_SIZE)?offset:-1;
}

bool loadLevel(const LevelDef *lv)
{
    shakeFrame=-1;          // (a new level starts still)
    // Sprites the last level's actors had go back, and its layers are emptied and hidden (the new level may not use them
    // all, e.g. one with no parallax background)
    if(level && actors){
        for(int n=0;n<objectCount;n++){
            hideActor(n);
        }
    }
    if(level){
        for(int n=0;n<level->layerCount;n++){
            const int ids[2]={level->layers[n].layer,level->layers[n].fgLayer};
            for(int k=0;k<2;k++){
                if(ids[k]>=0){
                    setLayerFollow(ids[k],-1);
                    clearLayerTransform(ids[k]);
                    clearLayerLines(ids[k],0,TILE_LAYER_HEIGHT);
                    setLayerPos(ids[k],SCREEN_WIDTH_PIXELS,0);
                    setLayerTileSize(ids[k],8);
                    setLayerColour(ids[k],LAYER_COLOUR_CELLS);
                }
            }
        }
    }
    actors=NULL;
    objectCount=0;
    stateBlock=NULL;
    currentID=-1;
    showFn=NULL;
    hideFn=NULL;
    showMargin=32;
    hideMargin=96;
    wakeMargin=0;
    memset(classSet,SPRITE_SET_NONE,sizeof(classSet));
    memset(classCollisions,0,sizeof(classCollisions));
    level=NULL;
    layerCount=0;
    animCount=0;
    if(lv->ramSize>LEVEL_RAM_SIZE || lv->tileSetCount>MAX_LEVEL_TILESETS || lv->layerCount>MAX_TILE_LAYERS){
        return false;
    }
    uint32_t used=0;
    level16=(lv->tileSize==16);

    // Tile sets are copied to RAM - animated tiles are animated by rewriting their graphics there (and the layers draw
    // faster from RAM than flash). 4KB for 8x8 tiles, 16KB for 16x16
    for(int n=0;n<lv->tileSetCount;n++){
        const LevelTileSet *ts=lv->tileSets[n];
        const uint32_t setSize=256u*(uint32_t)tileSetBytes(ts)*2u;
        if(used+setSize>LEVEL_RAM_SIZE){
            return false;
        }
        tileSetRam[n]=levelRam+used;
        memcpy(tileSetRam[n],ts->tiles,setSize);
        used+=setSize;
        for(int a=0;a<ts->animCount && animCount<MAX_LEVEL_ANIMS;a++){
            LevelAnimState *s=anims+animCount++;
            s->anim=ts->anims+a;
            s->src=ts->tiles;
            s->dst=tileSetRam[n];
            s->tileBytes=(uint8_t)tileSetBytes(ts);
            s->frame=0;
            s->ticksLeft=s->anim->frames[0].ticks;
            showAnimFrame(s);
        }
    }

    for(int n=0;n<lv->layerCount;n++){
        const LevelLayer *d=lv->layers+n;
        LevelLayerState *L=layers+n;
        memset(L,0,sizeof(*L));
        L->def=d;
        L->tileSet=lv->tileSets[d->tileSet];
        L->fgTileSet=lv->tileSets[d->fgTileSet];

        // Unpack the tiles, then the foreground bits and tiles after them
        const uint32_t tileBytes=align4((uint32_t)d->width*d->height);
        L->rowWords=(d->width+31)>>5;
        const uint32_t bitBytes=d->fgCount?(uint32_t)d->height*(uint32_t)L->rowWords*4u:0u;
        const uint32_t size=tileBytes+bitBytes+d->fgCount;
        if(used+align4(size)+(d->fgCount?align4(d->height*2u):0u)>LEVEL_RAM_SIZE){
            return false;
        }
        L->tiles=levelRam+used;
        if(lzUnpack(d->data,(int)d->dataSize,L->tiles,(int)size)<0){
            return false;
        }
        used+=align4(size);
        if(d->fgCount){
            L->fgBits=(const uint32_t *)(L->tiles+tileBytes);
            L->fgList=L->tiles+tileBytes+bitBytes;
            L->fgRowStart=(uint16_t *)(levelRam+used);
            used+=align4(d->height*2u);
            int count=0;
            for(int y=0;y<d->height;y++){
                L->fgRowStart[y]=(uint16_t)count;
                for(int w=0;w<L->rowWords;w++){
                    count+=popCount(L->fgBits[(y*L->rowWords)+w]);
                }
            }
            if(count!=d->fgCount){
                return false;
            }
        }

        // The engine layers: a tile layer drawing from the RAM tile set, emptied until the camera fills it
        setLayerType(d->layer,LT_TILE);
        setTileDefSet(d->layer,tileSetRam[d->tileSet]);
        setLayerTileSize(d->layer,level16?16:8);
        setLayerColour(d->layer,d->singleColour?d->colour:LAYER_COLOUR_CELLS);
        clearLayerLines(d->layer,0,TILE_LAYER_HEIGHT);
        if(d->fgLayer>=0){
            setLayerType(d->fgLayer,LT_TILE);
            setTileDefSet(d->fgLayer,tileSetRam[d->fgTileSet]);
            setLayerTileSize(d->fgLayer,level16?16:8);
            setLayerColour(d->fgLayer,d->singleColour?LAYER_COLOUR_NONE:LAYER_COLOUR_CELLS);
            clearLayerLines(d->fgLayer,0,TILE_LAYER_HEIGHT);
            setLayerFollow(d->fgLayer,d->layer);
        }
    }
    layerCount=lv->layerCount;

    // Object sprites go on the front most layer that moves with the camera, unless their object layer says otherwise
    // (preferring one with foreground tiles - the layer a player walks on)
    mainLayer=lv->layers[0].layer;
    int best=-1;
    for(int n=0;n<lv->layerCount;n++){
        const LevelLayer *d=lv->layers+n;
        if(d->parallaxX!=256 || d->parallaxY!=256){
            continue;
        }
        const int score=(d->fgLayer>=0?100:0)+(MAX_TILE_LAYERS-d->layer);
        if(score>best){
            best=score;
            mainLayer=d->layer;
        }
    }

    // This level's remembered state (only levels in levelList have one)
    stateBlock=NULL;
    currentID=-1;
    if(lv->id<levelCount && levelList[lv->id]==lv){
        currentID=lv->id;
        const int offset=levelStateOffset(lv->id);
        if(offset>=0){
            stateBlock=levelState+offset;
        }
    }

    // An actor for every object, where it was placed - or as it was left: collected and killed things stay gone, and
    // switches stay as they were
    const uint32_t actorBytes=(uint32_t)lv->objectCount*(uint32_t)sizeof(LevelActor);
    if(used+actorBytes>LEVEL_RAM_SIZE){
        return false;
    }
    actors=(LevelActor *)(levelRam+used);
    used+=actorBytes;
    objectCount=lv->objectCount;
    for(int n=0;n<objectCount;n++){
        const LevelObject *o=lv->objects+n;
        LevelActor *a=actors+n;
        memset(a,0,sizeof(*a));
        a->x=(float)o->x;
        a->y=(float)o->y;
        a->dir=(o->flags&LEVEL_OBJ_FLIP_X)?-1:1;
        a->frame=o->frame;
        a->flags=LEVEL_ACTOR_ALIVE|((o->flags&LEVEL_OBJ_WAIT)?LEVEL_ACTOR_DORMANT:0);
        a->sprite=-1;
        bool on=o->startOn!=0, gone=false;
        if(o->slot>=0 && stateBlock){
            const uint8_t s=stateBlock[o->slot];
            if(s&STATE_SET){
                on=(s&STATE_ON)!=0;
                gone=(s&STATE_GONE)!=0;
            }
        }
        if((o->flags&LEVEL_OBJ_SWITCH) && on){
            a->flags|=LEVEL_ACTOR_ON;
            a->frame=onFrame(lv,o);
        }
        if(gone){
            a->flags=0;
        }
    }

    level=lv;
    tileSetsChanged();
    return true;
}


void setLevelCameraOffset(int x, int y)
{
    cameraOffsetX=x;
    cameraOffsetY=y;
}

void shakeLevel(float size, float dirX, float dirY)
{
    shakeSize=size;
    shakeDirX=dirX;
    shakeDirY=dirY;
    shakeFrame=0;
}

void getLevelShake(int *x, int *y)
{
    const float s=(shakeFrame>=0)?shakeCurve[shakeFrame]*shakeSize:0.0f;
    *x=(int)floorf((s*shakeDirX)+0.5f);
    *y=(int)floorf((s*shakeDirY)+0.5f);
}

void setLevelCamera(int x, int y)
{
    // (the level moving one way with the shake is the camera moving the other)
    int sx, sy;
    getLevelShake(&sx,&sy);
    x+=cameraOffsetX-sx;
    y+=cameraOffsetY-sy;
    for(int n=0;n<layerCount;n++){
        LevelLayerState *L=layers+n;
        const LevelLayer *d=L->def;

        // Where the layer goes on screen: its offset, less how far it's scrolled. The engine hides layers placed at or
        // beyond the right or bottom of the screen, and tile layers repeat every 512 pixels, so move it back a
        // whole repeat if it would be there (only its layer space coordinates change)
        const int levelX=d->offsetX-((x*d->parallaxX)>>8);
        const int levelY=d->offsetY-((y*d->parallaxY)>>8);
        int px=levelX, py=levelY;
        while(px>=SCREEN_WIDTH_PIXELS){
            px-=TILE_LAYER_WIDTH*8;
        }
        while(py>=SCREEN_HEIGHT_LINES){
            py-=TILE_LAYER_HEIGHT*8;
        }
        setLayerPos(d->layer,px,py);
        if(d->fgLayer>=0){
            syncFollowingLayer(d->fgLayer);
        }

        // Keep the tiles around the middle of the screen in the layer - the level's tiles there, so in the level's
        // coordinates (the layer's less any whole repeats it was moved back by above)
        float cu, cv;
        screenToLayer(d->layer,SCREEN_WIDTH_PIXELS/2,SCREEN_HEIGHT_LINES/2,&cu,&cv);
        cu-=(float)(levelX-px);
        cv-=(float)(levelY-py);
        const int winX=floorDiv((int)floorf(cu),8)-(WINDOW_SIZE/2);
        const int winY=floorDiv((int)floorf(cv),8)-(WINDOW_SIZE/2);
        streamLayer(L,winX,winY);
    }
}

// The area of a layer on screen, in its coordinates (a box around it, if the layer's rotated)
typedef struct ViewBox {
    float x0, y0, x1, y1;
} ViewBox;

static ViewBox viewOf(int layerIX)
{
    static const float cx[4]={0.0f,SCREEN_WIDTH_PIXELS,0.0f,SCREEN_WIDTH_PIXELS};
    static const float cy[4]={0.0f,0.0f,SCREEN_HEIGHT_LINES,SCREEN_HEIGHT_LINES};
    ViewBox b={1e9f,1e9f,-1e9f,-1e9f};
    for(int n=0;n<4;n++){
        float u, v;
        screenToLayer(layerIX,cx[n],cy[n],&u,&v);
        b.x0=(u<b.x0)?u:b.x0;
        b.y0=(v<b.y0)?v:b.y0;
        b.x1=(u>b.x1)?u:b.x1;
        b.y1=(v>b.y1)?v:b.y1;
    }
    return b;
}

// Is a box (centre x,y, half size hw,hh) within margin pixels of the view?
static inline bool nearView(const ViewBox *b, float x, float y, float hw, float hh, int margin)
{
    const float m=(float)margin;
    return x+hw>=b->x0-m && x-hw<=b->x1+m && y+hh>=b->y0-m && y-hh<=b->y1+m;
}

static int actorLayer(const LevelObject *o)
{
    return (o->layer>=0)?o->layer:mainLayer;
}

// Give an actor a sprite from its sprite sheet, on its layer, in layer space
static void showActor(int objectIX)
{
    const LevelObject *o=level->objects+objectIX;
    LevelActor *a=actors+objectIX;
    const int ix=allocateSprite();
    if(ix<0){
        return;     // None free - it'll try again next frame
    }
    const LevelSpriteSheet *sh=level->sheets+o->sheet;
    setSpriteSize(ix,(SpriteSize)sh->size);
    if(sh->tileSet){
        // Level tiles: the tile set's RAM copy (so animated tiles animate), masks after its 256 tiles
        const uint8_t *tiles=tileSetRam[sh->tileSet-1];
        setSpriteDef(ix,tiles,tiles+(256*tileSetBytes(level->tileSets[sh->tileSet-1])));
    }else{
        setSpriteDef(ix,sh->def,sh->mask);
    }
    setSpritePalette(ix,sh->palette);
    setSpriteLayer(ix,actorLayer(o));
    setSpriteSpace(ix,SPRITE_SPACE_LAYER,-1);
    spriteList[ix].frame=a->frame;
    spriteList[ix].levelObject=(int16_t)objectIX;
    setSpritePos(ix,a->x,a->y);
    if(classSet[o->cls]!=SPRITE_SET_NONE){
        addSpriteToSet(ix,classSet[o->cls]);
    }
    setSpriteCollisions(ix,classCollisions[o->cls]);
    a->sprite=(int16_t)ix;
    if(showFn){
        showFn(objectIX,ix);
    }
}

// Remember an object's state, if it persists
static void storeState(int objectIX)
{
    const LevelObject *o=level->objects+objectIX;
    if(o->slot<0 || !stateBlock){
        return;
    }
    const LevelActor *a=actors+objectIX;
    uint8_t *s=stateBlock+o->slot;
    *s=(uint8_t)((*s&~(STATE_ON|STATE_GONE))|STATE_SET|((a->flags&LEVEL_ACTOR_ON)?STATE_ON:0)|
        ((a->flags&LEVEL_ACTOR_ALIVE)?0:STATE_GONE));
}

// Turn a switch on or off: its frame follows (the next one along in its sprite sheet when on), it's remembered, and the
// game's handler is told
static bool changeSwitch(int objectIX, bool on, uint8_t why)
{
    const LevelObject *o=level->objects+objectIX;
    LevelActor *a=actors+objectIX;
    if(!(o->flags&LEVEL_OBJ_SWITCH) || ((a->flags&LEVEL_ACTOR_ON)!=0)==on){
        return false;
    }
    a->flags=(uint8_t)(on?(a->flags|LEVEL_ACTOR_ON):(a->flags&~LEVEL_ACTOR_ON));
    if(o->sheet>=0){
        a->frame=on?onFrame(level,o):o->frame;
    }
    storeState(objectIX);
    if(switchFn){
        switchFn(o->value,on,objectIX,why);
    }
    return true;
}

static void updateActors(void)
{
    ViewBox views[MAX_TILE_LAYERS];
    bool haveView[MAX_TILE_LAYERS]={false};
    for(int n=0;n<objectCount;n++){
        LevelActor *a=actors+n;
        a->flags&=(uint8_t)~LEVEL_ACTOR_WOKE;
        if(!(a->flags&LEVEL_ACTOR_ALIVE)){
            continue;
        }
        const LevelObject *o=level->objects+n;

        // Timed switches turn themselves off
        if((a->flags&LEVEL_ACTOR_ON) && o->mode==LEVEL_SWITCH_TIMED && a->switchTimer>0 && --a->switchTimer==0){
            changeSwitch(n,false,LEVEL_SWITCH_EXPIRED);
        }
        const int layer=actorLayer(o);
        if(!haveView[layer]){
            views[layer]=viewOf(layer);
            haveView[layer]=true;
        }
        const ViewBox *view=views+layer;
        const float hw=(float)o->width*0.5f, hh=(float)o->height*0.5f;

        // Waiting for the camera to reach it
        if(a->flags&LEVEL_ACTOR_DORMANT){
            if(!nearView(view,a->x,a->y,hw,hh,wakeMargin)){
                continue;
            }
            a->flags=(uint8_t)((a->flags&~LEVEL_ACTOR_DORMANT)|LEVEL_ACTOR_WOKE);
        }
        if(o->sheet<0){
            continue;
        }

        // A sprite near the camera, none far from it
        if(a->sprite<0){
            if(nearView(view,a->x,a->y,hw,hh,showMargin)){
                showActor(n);
            }
        }else if(!nearView(view,a->x,a->y,hw,hh,hideMargin)){
            hideActor(n);
        }
        if(a->sprite>=0){
            spriteList[a->sprite].frame=a->frame;
            setSpritePos(a->sprite,a->x,a->y);
        }
    }
}

void updateLevel(void)
{
    // The shake moves on a frame (setLevelCamera, called before this each frame, used this one)
    if(shakeFrame>=0 && ++shakeFrame>=SHAKE_FRAMES){
        shakeFrame=-1;
    }
    bool changed=false;
    for(int n=0;n<animCount;n++){
        LevelAnimState *s=anims+n;
        if(s->ticksLeft>1){
            --s->ticksLeft;
            continue;
        }
        if(++s->frame>=s->anim->frameCount){
            s->frame=0;
        }
        s->ticksLeft=s->anim->frames[s->frame].ticks;
        showAnimFrame(s);
        changed=true;
    }
    if(changed){
        tileSetsChanged();
    }
    updateActors();
}

const LevelDef *getLevel(void)
{
    return level;
}

int getLevelTileSize(void)
{
    return level16?16:8;
}

int getLevelWidth(void)
{
    return level?level->width*getLevelTileSize():0;
}

int getLevelHeight(void)
{
    return level?level->height*getLevelTileSize():0;
}

int getLevelTile(int layerIX, int tileX, int tileY)
{
    const LevelLayerState *L=stateOf(layerIX);
    if(!L){
        return -1;
    }
    int lx, ly;
    return localPos(L,tileX,tileY,&lx,&ly)?L->tiles[(ly*L->def->width)+lx]:0;
}

int getLevelForegroundTile(int layerIX, int tileX, int tileY)
{
    const LevelLayerState *L=stateOf(layerIX);
    if(!L){
        return -1;
    }
    int lx, ly;
    return localPos(L,tileX,tileY,&lx,&ly)?foregroundAt(L,lx,ly):0;
}

uint8_t getLevelTileFlags(int layerIX, int tileX, int tileY)
{
    const LevelLayerState *L=stateOf(layerIX);
    if(!L){
        return 0;
    }
    int lx, ly;
    return localPos(L,tileX,tileY,&lx,&ly)?L->tileSet->flags[L->tiles[(ly*L->def->width)+lx]]:0;
}

uint8_t getLevelTileSetFlags(int layerIX, uint8_t tile)
{
    const LevelLayerState *L=stateOf(layerIX);
    return L?L->tileSet->flags[tile]:0;
}

// The tile at a level pixel, if its flags include any of mask (0: any tile), or -1
static inline int tilePixel(int layerIX, int x, int y, uint8_t mask)
{
    const LevelLayerState *L=stateOf(layerIX);
    if(!L){
        return -1;
    }
    const int shift=level16?4:3;
    int lx, ly;
    if(!localPos(L,x>>shift,y>>shift,&lx,&ly)){
        return -1;
    }
    const int tile=L->tiles[(ly*L->def->width)+lx];
    return (mask==0 || (L->tileSet->flags[tile]&mask))?tile:-1;
}

// A pixel of a tile's graphic as drawn now (animated tiles included): 8x8 tiles a byte a row, 16x16 two (left, right)
static inline bool tileGraphicPixel(int layerIX, int tile, int x, int y)
{
    const uint8_t *g=tileLayer[layerIX].tileDefPtr;
    const uint8_t b=level16?g[(tile*32)+((y&15)*2)+((x>>3)&1)]:g[(tile*8)+(y&7)];
    return (b&(0x80u>>(x&7)))!=0;
}

bool isLevelPixelSet(int layerIX, int x, int y)
{
    const int tile=tilePixel(layerIX,x,y,0);
    return tile>0 && tileGraphicPixel(layerIX,tile,x,y);
}

bool isLevelPixelSolid(int layerIX, int x, int y)
{
    const int tile=tilePixel(layerIX,x,y,LEVEL_TILE_SOLID);
    return tile>0 && tileGraphicPixel(layerIX,tile,x,y);
}

void setLevelTile(int layerIX, int tileX, int tileY, uint8_t tile)
{
    LevelLayerState *L=stateOf(layerIX);
    int lx, ly;
    if(!L || !localPos(L,tileX,tileY,&lx,&ly)){
        return;
    }
    L->tiles[(ly*L->def->width)+lx]=tile;
    if(!L->filled){
        return;
    }
    // Refresh its cells in the window (2x2 of them for a 16x16 tile) - everywhere it appears there, if the layer repeats
    const LevelLayer *d=L->def;
    const int cells=level16?2:1;
    const int stepX=(d->flags&LEVEL_WRAP_X)?d->width*cells:WINDOW_SIZE*2;
    const int stepY=(d->flags&LEVEL_WRAP_Y)?d->height*cells:WINDOW_SIZE*2;
    for(int cy=0;cy<cells;cy++){
        for(int cx=0;cx<cells;cx++){
            const int firstX=L->winX+wrapTo((tileX*cells)+cx-L->winX,stepX);
            const int firstY=L->winY+wrapTo((tileY*cells)+cy-L->winY,stepY);
            for(int y=firstY;y<L->winY+WINDOW_SIZE;y+=stepY){
                for(int x=firstX;x<L->winX+WINDOW_SIZE;x+=stepX){
                    fillCell(L,x,y);
                }
            }
        }
    }
}

// ---------------------------------------------------------------------------
// Objects and actors
// ---------------------------------------------------------------------------

int getLevelObjectCount(void)
{
    return objectCount;
}

const LevelObject *getLevelObject(int objectIX)
{
    return (objectIX>=0 && objectIX<objectCount)?level->objects+objectIX:NULL;
}

LevelActor *getLevelActor(int objectIX)
{
    return (objectIX>=0 && objectIX<objectCount)?actors+objectIX:NULL;
}

bool isLevelActorActive(int objectIX)
{
    return objectIX>=0 && objectIX<objectCount &&
        (actors[objectIX].flags&(LEVEL_ACTOR_ALIVE|LEVEL_ACTOR_DORMANT))==LEVEL_ACTOR_ALIVE;
}

int findLevelObject(int cls)
{
    for(int n=0;n<objectCount;n++){
        if(level->objects[n].cls==cls){
            return n;
        }
    }
    return -1;
}

static const LevelProp *findProp(int objectIX, int prop)
{
    if(objectIX<0 || objectIX>=objectCount){
        return NULL;
    }
    const LevelObject *o=level->objects+objectIX;
    for(int n=0;n<o->propCount;n++){
        if(o->props[n].id==prop){
            return o->props+n;
        }
    }
    return NULL;
}

int32_t getLevelObjectInt(int objectIX, int prop, int32_t def)
{
    const LevelProp *p=findProp(objectIX,prop);
    if(!p || p->type==LEVEL_PROP_TYPE_STRING){
        return def;
    }
    return (p->type==LEVEL_PROP_TYPE_FLOAT)?(int32_t)p->v.f:p->v.i;
}

float getLevelObjectFloat(int objectIX, int prop, float def)
{
    const LevelProp *p=findProp(objectIX,prop);
    if(!p || p->type==LEVEL_PROP_TYPE_STRING){
        return def;
    }
    return (p->type==LEVEL_PROP_TYPE_FLOAT)?p->v.f:(float)p->v.i;
}

const char *getLevelObjectString(int objectIX, int prop, const char *def)
{
    const LevelProp *p=findProp(objectIX,prop);
    return (p && p->type==LEVEL_PROP_TYPE_STRING)?p->v.s:def;
}

int getSpriteLevelObject(int spriteIX)
{
    if(spriteIX<0 || spriteIX>=totalSprites || !spriteList[spriteIX].inUse){
        return -1;
    }
    const int o=spriteList[spriteIX].levelObject;
    return (o>=0 && o<objectCount && actors[o].sprite==spriteIX)?o:-1;
}

void killLevelActor(int objectIX)
{
    if(objectIX<0 || objectIX>=objectCount){
        return;
    }
    hideActor(objectIX);
    actors[objectIX].flags=0;
    storeState(objectIX);
}

int findLevelObjectByName(const char *name)
{
    for(int n=0;n<objectCount && name;n++){
        if(level->objects[n].name && strcmp(level->objects[n].name,name)==0){
            return n;
        }
    }
    return -1;
}

// ---------------------------------------------------------------------------
// Moving between levels, switches, and what's remembered
// ---------------------------------------------------------------------------

void setLevelHandlers(LevelSetupFn setup, LevelSwitchFn onSwitch)
{
    setupFn=setup;
    switchFn=onSwitch;
}

void replayLevelSwitches(void)
{
    for(int n=0;n<objectCount;n++){
        const LevelObject *o=level->objects+n;
        const LevelActor *a=actors+n;
        if((o->flags&LEVEL_OBJ_SWITCH) && (a->flags&LEVEL_ACTOR_ON) && switchFn){
            switchFn(o->value,true,n,LEVEL_SWITCH_REPLAY);
        }
    }
}

int enterLevel(int levelID, const char *entrance)
{
    if(levelID<0 || levelID>=levelCount || !levelList[levelID] || !loadLevel(levelList[levelID])){
        return -2;
    }
    if(setupFn){
        setupFn(level);
    }
    replayLevelSwitches();
    return findLevelObjectByName(entrance?entrance:"start");
}

int getLevelID(void)
{
    return currentID;
}

int getLevelType(void)
{
    return level?level->type:0;
}

static const LevelProp *findLevelProp(const LevelDef *lv, int prop)
{
    for(int n=0;lv && n<lv->propCount;n++){
        if(lv->props[n].id==prop){
            return lv->props+n;
        }
    }
    return NULL;
}

int32_t getLevelDefInt(const LevelDef *lv, int prop, int32_t def)
{
    const LevelProp *p=findLevelProp(lv,prop);
    if(!p || p->type==LEVEL_PROP_TYPE_STRING){
        return def;
    }
    return (p->type==LEVEL_PROP_TYPE_FLOAT)?(int32_t)p->v.f:p->v.i;
}

const char *getLevelDefString(const LevelDef *lv, int prop, const char *def)
{
    const LevelProp *p=findLevelProp(lv,prop);
    return (p && p->type==LEVEL_PROP_TYPE_STRING)?p->v.s:def;
}

int32_t getLevelPropInt(int prop, int32_t def)
{
    return getLevelDefInt(level,prop,def);
}

float getLevelPropFloat(int prop, float def)
{
    const LevelProp *p=findLevelProp(level,prop);
    if(!p || p->type==LEVEL_PROP_TYPE_STRING){
        return def;
    }
    return (p->type==LEVEL_PROP_TYPE_FLOAT)?p->v.f:(float)p->v.i;
}

const char *getLevelPropString(int prop, const char *def)
{
    return getLevelDefString(level,prop,def);
}

bool useLevelSwitch(int objectIX)
{
    if(objectIX<0 || objectIX>=objectCount || !(level->objects[objectIX].flags&LEVEL_OBJ_SWITCH)){
        return false;
    }
    const LevelObject *o=level->objects+objectIX;
    LevelActor *a=actors+objectIX;
    const bool on=(a->flags&LEVEL_ACTOR_ON)!=0;
    switch(o->mode){
        case LEVEL_SWITCH_TOGGLE:
            return changeSwitch(objectIX,!on,LEVEL_SWITCH_USED);
        case LEVEL_SWITCH_TIMED:
            a->switchTimer=(int16_t)((o->time>0)?o->time:1);
            return changeSwitch(objectIX,true,LEVEL_SWITCH_USED);
        default:
            return changeSwitch(objectIX,true,LEVEL_SWITCH_USED);
    }
}

void setLevelSwitch(int objectIX, bool on)
{
    if(objectIX>=0 && objectIX<objectCount){
        changeSwitch(objectIX,on,LEVEL_SWITCH_SET);
    }
}

bool getLevelSwitch(int objectIX)
{
    return objectIX>=0 && objectIX<objectCount && (actors[objectIX].flags&LEVEL_ACTOR_ON);
}

int findLevelSwitch(int value)
{
    for(int n=0;n<objectCount;n++){
        if((level->objects[n].flags&LEVEL_OBJ_SWITCH) && level->objects[n].value==value){
            return n;
        }
    }
    return -1;
}

uint8_t getLevelObjectMemory(int objectIX)
{
    if(objectIX<0 || objectIX>=objectCount || level->objects[objectIX].slot<0 || !stateBlock){
        return 0;
    }
    return (uint8_t)(stateBlock[level->objects[objectIX].slot]>>STATE_MEMORY);
}

void setLevelObjectMemory(int objectIX, uint8_t value)
{
    if(objectIX<0 || objectIX>=objectCount || level->objects[objectIX].slot<0 || !stateBlock){
        return;
    }
    uint8_t *s=stateBlock+level->objects[objectIX].slot;
    storeState(objectIX);
    *s=(uint8_t)((*s&((1u<<STATE_MEMORY)-1u))|(value<<STATE_MEMORY));
}

uint8_t *getLevelStateStore(void)
{
    return levelState;
}

void clearLevelStateStore(void)
{
    memset(levelState,0,sizeof(levelState));
}

// The object with a slot in a level
static const LevelObject *slotObject(int levelID, int slot, int *objectIX)
{
    const LevelDef *lv=levelList[levelID];
    for(int n=0;n<lv->objectCount;n++){
        if(lv->objects[n].slot==slot){
            *objectIX=n;
            return lv->objects+n;
        }
    }
    return NULL;
}

void setLevelSwitchState(int levelID, int slot, bool on)
{
    if(levelID<0 || levelID>=levelCount || !levelList[levelID] || slot<0 || slot>=levelList[levelID]->stateBytes){
        return;
    }
    int objectIX;
    if(!slotObject(levelID,slot,&objectIX)){
        return;
    }
    if(levelID==currentID){
        // The level's loaded - change it live (the handler puts its effect in place)
        setLevelSwitch(objectIX,on);
        return;
    }
    const int offset=levelStateOffset(levelID);
    if(offset<0){
        return;
    }
    uint8_t *s=levelState+offset+slot;
    *s=(uint8_t)((*s&~STATE_ON)|STATE_SET|(on?STATE_ON:0));
}

bool getLevelSwitchState(int levelID, int slot)
{
    if(levelID<0 || levelID>=levelCount || !levelList[levelID]){
        return false;
    }
    int objectIX;
    const LevelObject *o=slotObject(levelID,slot,&objectIX);
    if(!o){
        return false;
    }
    if(levelID==currentID){
        return getLevelSwitch(objectIX);
    }
    const int offset=levelStateOffset(levelID);
    const uint8_t s=(offset>=0)?levelState[offset+slot]:0;
    return (s&STATE_SET)?(s&STATE_ON)!=0:o->startOn!=0;
}

void setLevelActorCallbacks(LevelShowFn show, LevelHideFn hide)
{
    showFn=show;
    hideFn=hide;
}

void setLevelActorMargins(int show, int hide, int wake)
{
    showMargin=show;
    hideMargin=(hide>show)?hide:show;
    wakeMargin=wake;
}

void setLevelClassSprites(int cls, int setIX, uint8_t collisions)
{
    if(cls<0 || cls>255){
        return;
    }
    classSet[cls]=(int8_t)setIX;
    classCollisions[cls]=collisions;
}

// A path's segment from point n to the next (the last joins back to the first on a polygon)
static float segmentLength(const LevelObject *o, int n, float *dx, float *dy)
{
    const LevelPoint *a=o->points+n;
    const LevelPoint *b=o->points+((n+1)%o->pointCount);
    *dx=(float)(b->x-a->x);
    *dy=(float)(b->y-a->y);
    return sqrtf((*dx*(*dx))+(*dy*(*dy)));
}

static int segmentCount(const LevelObject *o)
{
    return (o->flags&LEVEL_OBJ_CLOSED)?o->pointCount:o->pointCount-1;
}

float getLevelPathLength(int objectIX)
{
    const LevelObject *o=getLevelObject(objectIX);
    if(!o || o->pointCount<2){
        return 0.0f;
    }
    float len=0.0f, dx, dy;
    for(int n=0;n<segmentCount(o);n++){
        len+=segmentLength(o,n,&dx,&dy);
    }
    return len;
}

bool getLevelPathPoint(int objectIX, float distance, float *x, float *y)
{
    const LevelObject *o=getLevelObject(objectIX);
    if(!o || o->pointCount<1){
        return false;
    }
    *x=(float)o->points[0].x;
    *y=(float)o->points[0].y;
    if(o->pointCount<2){
        return true;
    }
    if(o->flags&LEVEL_OBJ_CLOSED){
        const float len=getLevelPathLength(objectIX);
        if(len>0.0f){
            distance=fmodf(distance,len);
            distance+=(distance<0.0f)?len:0.0f;
        }
    }else if(distance<=0.0f){
        return true;
    }
    float dx, dy;
    for(int n=0;n<segmentCount(o);n++){
        const float l=segmentLength(o,n,&dx,&dy);
        if(distance<=l || n==segmentCount(o)-1){
            const float t=(l>0.0f)?((distance<l)?distance/l:1.0f):0.0f;
            *x=(float)o->points[n].x+(dx*t);
            *y=(float)o->points[n].y+(dy*t);
            return true;
        }
        distance-=l;
    }
    return true;
}
