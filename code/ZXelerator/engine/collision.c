#include "collision.h"
#include "pico.h"

// A sprite as drawn this frame, with what's needed to find its pixels on any screen line
typedef struct SpriteShape {
    const Sprite *s;
    int16_t ix;
    // The screen area it's drawn in (clipped to the screen, end exclusive)
    int16_t x0, y0, x1, y1;
    // The pixel data of its current frame
    const uint8_t *def;
    // Rotated sprites: the sprite position (16.16) at the centre of screen pixel (x0,y0), as the renderer uses
    int32_t rowU, rowV;
} SpriteShape;

static SpriteShape shapes[MAX_COLLIDING_SPRITES];

/// @brief Bits for screen pixels [from,to) in a 32 pixel window starting at x (bit 31 = x)
static inline uint32_t rangeMask(int x, int from, int to)
{
    int lo=from-x;
    int hi=to-x;
    if(lo<0){
        lo=0;
    }
    if(hi>32){
        hi=32;
    }
    if(lo>=hi){
        return 0;
    }
    const uint32_t fromLo=0xffffffffu>>lo;
    const uint32_t toHi=(hi==32)?0xffffffffu:~(0xffffffffu>>hi);
    return fromLo&toHi;
}

/// @brief One row of a sprite's source pixels, pixel 0 in bit 31
static inline uint32_t sourceRow(const Sprite *s, const uint8_t *def, int row)
{
    const uint8_t *p=def+(row*s->bytesPerRow);
    uint32_t bits=(uint32_t)p[0]<<24;
    if(s->bytesPerRow>1){
        bits|=(uint32_t)p[1]<<16;
    }
    if(s->bytesPerRow>2){
        bits|=((uint32_t)p[2]<<8)|p[3];    // 24 pixel wide sprites have a blank 4th byte
    }
    return bits;
}

/// @brief Set up a sprite's shape, if it's drawn this frame (the same tests as blitSpritesToRenderBuffer)
static bool buildShape(const Sprite *s, int ix, SpriteShape *sh)
{
    if(s->layer<0 || s->layer>=MAX_TILE_LAYERS || s->defPtr==NULL ||
        (s->offY>=SCREEN_HEIGHT_LINES) || (s->offY<=-(s->scaledHeight)) ||
        (s->offX<=-(s->scaledWidth)) || (s->offX>=SCREEN_WIDTH_PIXELS)){
        return false;
    }
    const int w=(s->isRotated || s->isScaled)?s->scaledWidth:s->width;
    const int h=(s->isRotated || s->isScaled)?s->scaledHeight:s->height;
    int x0=s->offX, y0=s->offY, x1=s->offX+w, y1=s->offY+h;
    if(x0<0){
        x0=0;
    }
    if(y0<0){
        y0=0;
    }
    if(x1>SCREEN_WIDTH_PIXELS){
        x1=SCREEN_WIDTH_PIXELS;
    }
    if(y1>SCREEN_HEIGHT_LINES){
        y1=SCREEN_HEIGHT_LINES;
    }
    if(x0>=x1 || y0>=y1){
        return false;
    }
    sh->s=s;
    sh->ix=(int16_t)ix;
    sh->x0=(int16_t)x0;
    sh->y0=(int16_t)y0;
    sh->x1=(int16_t)x1;
    sh->y1=(int16_t)y1;
    sh->def=s->defPtr+(s->frame*s->height*s->bytesPerRow);
    if(s->isRotated){
        spriteTransformOrigin(s,x0,y0,&sh->rowU,&sh->rowV);
    }
    return true;
}

/// @brief 32 pixels of a sprite's shape at screen x..x+31 on line y, sampled exactly as its renderer draws them
static uint32_t __not_in_flash_func(shapePixels32)(const SpriteShape *sh, int x, int y)
{
    if(y<sh->y0 || y>=sh->y1 || x>=sh->x1 || x+32<=sh->x0){
        return 0;
    }
    const Sprite *s=sh->s;
    const uint32_t inArea=rangeMask(x,sh->x0,sh->x1);
    uint32_t bits=0;

    if(s->isRotated){
        // As blitSpriteTransformedToRenderBuffer: step from (x0,y0), and only pixels inside the sprite are drawn
        const int32_t limU=s->width<<16;
        const int32_t limV=s->height<<16;
        const int bpr=s->bytesPerRow;
        const uint32_t dy=(uint32_t)(y-sh->y0);
        const int first=(x>sh->x0)?x:sh->x0;
        const int last=(x+32<sh->x1)?x+32:sh->x1;
        const uint32_t dx=(uint32_t)(first-sh->x0);
        int32_t u=(int32_t)((uint32_t)sh->rowU+(dy*(uint32_t)s->invDudy)+(dx*(uint32_t)s->invDudx));
        int32_t v=(int32_t)((uint32_t)sh->rowV+(dy*(uint32_t)s->invDvdy)+(dx*(uint32_t)s->invDvdx));
        for(int px=first;px<last;px++){
            if(u>=0 && u<limU && v>=0 && v<limV){
                const int32_t ui=u>>16;
                if((sh->def[((v>>16)*bpr)+(ui>>3)]<<(ui&7))&0x80){
                    bits|=0x80000000u>>(px-x);
                }
            }
            u+=s->invDudx;
            v+=s->invDvdx;
        }
        return bits;
    }

    if(s->isScaled){
        // As blitSpriteScaledToRenderBuffer: line k of the sprite shows source row (k*heightAdder)>>16, and column
        // c shows source pixel (c*widthAdder)>>16
        const uint32_t k=(uint32_t)(y-s->offY);
        const int row=(int)(((k*s->scaledHeightAdder.u32)>>16)&0xff);
        if(row>=s->height){
            return 0;
        }
        const uint32_t src=sourceRow(s,sh->def,row);
        const int first=(x>sh->x0)?x:sh->x0;
        const int last=(x+32<sh->x1)?x+32:sh->x1;
        for(int px=first;px<last;px++){
            const uint32_t sx=((uint32_t)(px-s->offX)*s->scaledWidthAdder.u32)>>16;
            if(sx<32 && ((src<<sx)&0x80000000u)){
                bits|=0x80000000u>>(px-x);
            }
        }
        return bits;
    }

    // Unscaled: the source row, shifted into place
    const uint32_t src=sourceRow(s,sh->def,y-s->offY);
    const int d=x-s->offX;
    if(d>=32 || d<=-32){
        return 0;
    }
    bits=(d>=0)?(src<<d):(src>>(-d));
    return bits&inArea;
}

uint32_t getSpritePixels32(const Sprite *s, int x, int y)
{
    SpriteShape sh;
    if(!buildShape(s,(int)(s-spriteList),&sh)){
        return 0;
    }
    return shapePixels32(&sh,x,y);
}

static void addSpriteHit(Sprite *s, int hitIX)
{
    for(int n=0;n<s->spriteHitCount;n++){
        if(s->spriteHits[n]==hitIX){
            return;
        }
    }
    if(s->spriteHitCount<MAX_COLLISION_HITS){
        s->spriteHits[s->spriteHitCount++]=(int16_t)hitIX;
    }
}

/// @return False once the sprite's tile hit list is full
static bool addTileHit(Sprite *s, int tileX, int tileY)
{
    for(int n=0;n<s->tileHitCount;n++){
        const TileHit *t=s->tileHits+n;
        if(t->x==tileX && t->y==tileY){
            return true;
        }
    }
    if(s->tileHitCount>=MAX_COLLISION_HITS){
        return false;
    }
    TileHit *t=s->tileHits+s->tileHitCount++;
    t->x=(uint8_t)tileX;
    t->y=(uint8_t)tileY;
    return true;
}

/// @brief Pixel test of two sprites where their drawn areas overlap
static bool __no_inline_not_in_flash_func(shapesOverlap)(const SpriteShape *a, const SpriteShape *b)
{
    const int x0=(a->x0>b->x0)?a->x0:b->x0;
    const int x1=(a->x1<b->x1)?a->x1:b->x1;
    const int y0=(a->y0>b->y0)?a->y0:b->y0;
    const int y1=(a->y1<b->y1)?a->y1:b->y1;
    if(x0>=x1 || y0>=y1){
        return false;
    }
    for(int y=y0;y<y1;y++){
        for(int x=x0;x<x1;x+=32){
            const uint32_t pa=shapePixels32(a,x,y);
            if(pa && (pa&shapePixels32(b,x,y))){
                return true;
            }
        }
    }
    return false;
}

/// @brief Pixel test of a sprite against a tile layer, recording the tiles hit
static void __no_inline_not_in_flash_func(shapeHitsLayer)(const SpriteShape *sh, Sprite *s, int layerIX)
{
    if(!isLayerCollidable(layerIX)){
        return;
    }
    for(int y=sh->y0;y<sh->y1;y++){
        for(int x=sh->x0;x<sh->x1;x+=32){
            const uint32_t ps=shapePixels32(sh,x,y);
            if(ps==0){
                continue;
            }
            uint32_t hit=ps&getLayerPixels32(layerIX,x,y);
            while(hit){
                // Leftmost pixel still to check
                int bit=31;
                while(((hit>>bit)&1)==0){
                    --bit;
                }
                hit&=~(1u<<bit);
                int tileX, tileY;
                if(getLayerTileAt(layerIX,x+(31-bit),y,&tileX,&tileY)){
                    if(!addTileHit(s,tileX,tileY)){
                        return;
                    }
                }
            }
        }
    }
}

void detectCollisions(void)
{
    int numShapes=0;
    int numSpriteColliders=0;
    for(int n=0;n<totalSprites;n++){
        Sprite *s=spriteList+n;
        s->spriteHitCount=0;
        s->tileHitCount=0;
        if(s->collideWith!=COLLIDE_NONE && numShapes<MAX_COLLIDING_SPRITES && buildShape(s,n,shapes+numShapes)){
            if(s->collideWith&COLLIDE_SPRITES){
                ++numSpriteColliders;
            }
            ++numShapes;
        }
    }

    // Sprite to sprite - both need COLLIDE_SPRITES
    if(numSpriteColliders>1){
        for(int a=0;a<numShapes;a++){
            Sprite *sa=(Sprite *)shapes[a].s;
            if((sa->collideWith&COLLIDE_SPRITES)==0){
                continue;
            }
            for(int b=a+1;b<numShapes;b++){
                Sprite *sb=(Sprite *)shapes[b].s;
                if((sb->collideWith&COLLIDE_SPRITES) && shapesOverlap(shapes+a,shapes+b)){
                    addSpriteHit(sa,shapes[b].ix);
                    addSpriteHit(sb,shapes[a].ix);
                }
            }
        }
    }

    // Sprite to the tile layer drawn just before it (the layer it's drawn over)
    for(int n=0;n<numShapes;n++){
        Sprite *s=(Sprite *)shapes[n].s;
        if(s->collideWith&COLLIDE_LAYER){
            shapeHitsLayer(shapes+n,s,s->layer);
        }
    }
}
