#include "Sprite.h"
#include "TileLayer.h"
#include <math.h>
#include "pico.h"

Sprite *spriteList=NULL;
int totalSprites=0;
static uint8_t pixLineBuffer[256] __attribute__((aligned(4)));
static uint8_t maskLineBuffer[256] __attribute__((aligned(4)));

SpriteSet spriteSets[MAX_SPRITE_SETS];

void initSprites(int numSprites)
{
    if(totalSprites){
        deleteSprites();
    }
    deleteSpriteSets();
    // Cleared first, so everything not set below starts at 0 (e.g. the palette, until setSpritePalette)
    spriteList=(Sprite *)calloc((size_t)numSprites,sizeof(Sprite));
    totalSprites=numSprites;
    for(int n=0;n<numSprites;n++){
        Sprite *s=spriteList+n;
        s->x=500;
        s->y=0;
        s->offX=500;
        s->offY=0;
        s->defPtr=NULL;
        s->frame=0;
        s->isScaled=0;
        s->scaleX=1.0f;
        s->scaleY=1.0f;
        s->angle=0.0f;
        s->isRotated=0;
        s->delay=0;
        s->collideWith=COLLIDE_NONE;
        s->spriteHitCount=0;
        s->tileHitCount=0;
        s->space=SPRITE_SPACE_SCREEN;
        s->parentLayer=-1;
        s->rotateWithLayer=1;
        s->rotCos=1.0f;
        s->rotSin=0.0f;
        s->set=SPRITE_SET_NONE;
        s->setNext=-1;
        s->setPrev=-1;
        s->inUse=0;
        s->levelObject=-1;
        s->solid=0;
    }
}

// A sprite back to how initSprites leaves it (keeping its set links, which removeSpriteFromSet has already cleared)
static void resetSprite(Sprite *s)
{
    s->space=SPRITE_SPACE_SCREEN;
    s->parentLayer=-1;
    s->rotateWithLayer=1;
    s->frame=0;
    s->delay=0;
    s->isScaled=0;
    s->scaleX=1.0f;
    s->scaleY=1.0f;
    s->angle=0.0f;
    s->isRotated=0;
    s->rotCos=1.0f;
    s->rotSin=0.0f;
    s->collideWith=COLLIDE_NONE;
    s->spriteHitCount=0;
    s->tileHitCount=0;
    s->levelObject=-1;
    s->solid=0;
    s->xF=500.0f;
    s->yF=0.0f;
    s->x=500;
    s->y=0;
    s->offX=500;
    s->offY=0;
}

int allocateSprite(void)
{
    for(int n=0;n<totalSprites;n++){
        Sprite *s=spriteList+n;
        if(!s->inUse){
            removeSpriteFromSet(n);
            resetSprite(s);
            s->inUse=1;
            return n;
        }
    }
    return -1;
}

void freeSprite(int ix)
{
    Sprite *s=spriteList+ix;
    removeSpriteFromSet(ix);
    resetSprite(s);
    s->inUse=0;
}

void deleteSprites(void)
{
    // The sets list sprites that are going
    for(int n=0;n<MAX_SPRITE_SETS;n++){
        spriteSets[n].used=false;
    }
    totalSprites=0;
    if(spriteList==NULL){
        return;
    }
    free(spriteList);
    spriteList=NULL;
}

// ---------------------------------------------------------------------------
// Sprite sets
// ---------------------------------------------------------------------------

int createSpriteSet(void)
{
    for(int n=0;n<MAX_SPRITE_SETS;n++){
        SpriteSet *set=spriteSets+n;
        if(!set->used){
            set->used=true;
            set->solid=false;
            set->first=-1;
            set->last=-1;
            set->count=0;
            return n;
        }
    }
    return SPRITE_SET_NONE;
}

void removeSpriteFromSet(int ix)
{
    Sprite *s=spriteList+ix;
    if(s->set<0){
        return;
    }
    SpriteSet *set=spriteSets+s->set;
    if(s->setPrev>=0){
        spriteList[s->setPrev].setNext=s->setNext;
    }else{
        set->first=s->setNext;
    }
    if(s->setNext>=0){
        spriteList[s->setNext].setPrev=s->setPrev;
    }else{
        set->last=s->setPrev;
    }
    --set->count;
    s->set=SPRITE_SET_NONE;
    s->setNext=-1;
    s->setPrev=-1;
    s->solid=0;
}

void addSpriteToSet(int ix, int setIX)
{
    removeSpriteFromSet(ix);
    if(setIX<0 || setIX>=MAX_SPRITE_SETS || !spriteSets[setIX].used){
        return;
    }
    Sprite *s=spriteList+ix;
    SpriteSet *set=spriteSets+setIX;
    s->set=(int8_t)setIX;
    s->setPrev=set->last;
    s->setNext=-1;
    if(set->last>=0){
        spriteList[set->last].setNext=(int16_t)ix;
    }else{
        set->first=(int16_t)ix;
    }
    set->last=(int16_t)ix;
    ++set->count;
    s->solid=set->solid?1:0;
}

void setSpriteSetSolid(int setIX, bool solid)
{
    if(setIX<0 || setIX>=MAX_SPRITE_SETS || !spriteSets[setIX].used){
        return;
    }
    spriteSets[setIX].solid=solid;
    for(int ix=firstSpriteInSet(setIX);ix>=0;ix=nextSpriteInSet(ix)){
        spriteList[ix].solid=solid?1:0;
    }
}

void setSpriteSolid(int ix, bool solid)
{
    spriteList[ix].solid=solid?1:0;
}

int getSolidSpriteAt(int layerIX, int x0, int y0, int x1, int y1)
{
    for(int n=0;n<MAX_SPRITE_SETS;n++){
        if(!spriteSets[n].used || !spriteSets[n].solid){
            continue;
        }
        for(int ix=spriteSets[n].first;ix>=0;ix=spriteList[ix].setNext){
            const Sprite *s=spriteList+ix;
            const int parent=(s->parentLayer>=0)?s->parentLayer:s->layer;
            if(!s->solid || s->space!=SPRITE_SPACE_LAYER || parent!=layerIX){
                continue;
            }
            const int w=s->isScaled?(int)((float)s->width*s->scaleX):s->width;
            const int h=s->isScaled?(int)((float)s->height*s->scaleY):s->height;
            const int sx0=(int)floorf(s->xF)-(w/2), sy0=(int)floorf(s->yF)-(h/2);
            if(x1>=sx0 && x0<sx0+w && y1>=sy0 && y0<sy0+h){
                return ix;
            }
        }
    }
    return -1;
}

void deleteSpriteSet(int setIX)
{
    if(setIX<0 || setIX>=MAX_SPRITE_SETS || !spriteSets[setIX].used){
        return;
    }
    while(spriteSets[setIX].first>=0){
        removeSpriteFromSet(spriteSets[setIX].first);
    }
    spriteSets[setIX].used=false;
}

void deleteSpriteSets(void)
{
    for(int n=0;n<MAX_SPRITE_SETS;n++){
        deleteSpriteSet(n);
    }
}

void setSpriteSetCollisions(int setIX, uint8_t flags)
{
    for(int ix=firstSpriteInSet(setIX);ix>=0;ix=nextSpriteInSet(ix)){
        setSpriteCollisions(ix,flags);
    }
}

int getSpriteHitInSet(int ix, int setIX)
{
    const Sprite *s=spriteList+ix;
    for(int n=0;n<s->spriteHitCount;n++){
        if(isSpriteInSet(s->spriteHits[n],setIX)){
            return s->spriteHits[n];
        }
    }
    return -1;
}

void setSpriteSize(int ix, SpriteSize st){
    Sprite *s=spriteList+ix;
    switch(st){
        case SIZE_8X4:
        s->width=8;
        s->height=4;
        break;
        case SIZE_8X8:
        s->width=8;
        s->height=8;
        break;
        case SIZE_8X12:
        s->width=8;
        s->height=12;
        break;
        case SIZE_8X16:
        s->width=8;
        s->height=16;
        break;

        case SIZE_16X8:
        s->width=16;
        s->height=8;
        break;
        case SIZE_16X12:
        s->width=16;
        s->height=12;
        break;
        case SIZE_16X16:
        s->width=16;
        s->height=16;
        break;
        case SIZE_16X24:
        s->width=16;
        s->height=24;
        break;
        
        case SIZE_24X24:
        s->width=24;
        s->height=24;
        break;
        case SIZE_24X32:
        s->width=24;
        s->height=32;
        break;
        case SIZE_24X40:
        s->width=24;
        s->height=40;
        break;
        case SIZE_24X48:
        s->width=24;
        s->height=48;
        break;
        case SIZE_24X64:
        s->width=24;
        s->height=64;
        break;

        case SIZE_32X40:
        s->width=32;
        s->height=40;
        break;
        case SIZE_32X8:
        s->width=32;
        s->height=8;
        break;
        case SIZE_16X32:
        s->width=16;
        s->height=32;
        break;
    }
    s->size=st;
    s->scaledWidth=s->width;
    s->scaledHeight=s->height;
    s->offX=s->x-(s->scaledWidth/2);
    s->offY=s->y-(s->scaledHeight/2);
    s->isScaled=0;
    s->bytesPerRow = (s->width==24?4:(s->width >> 3));  // 24bit wide sprites actually span 4 bytes for faster 32-bit aligned reads
    if(s->isRotated){
        updateSpriteTransform(s);
    }
    if(s->space==SPRITE_SPACE_LAYER){
        placeSprite(s);
    }
}

bool setSpriteTile(int ix, int layerIX, int tile)
{
    if(layerIX<0 || layerIX>=MAX_TILE_LAYERS || tileLayer[layerIX].tileDefPtr==NULL){
        return false;
    }
    const TileLayer *tL=tileLayer+layerIX;
    const SpriteSize size=tL->tile16?SIZE_16X16:SIZE_8X8;
    const int w=tL->tile16?16:8;
    if(spriteList[ix].width!=w || spriteList[ix].height!=w){
        setSpriteSize(ix,size);
    }
    setSpriteDef(ix,tL->tileDefPtr,tL->tileDefPtr+(256*(w*w/8)));      // Masks follow the 256 tiles
    spriteList[ix].frame=(int16_t)(tile&0xff);
    return true;
}

void setSpriteRotation(int ix, float angle)
{
    Sprite *s=spriteList+ix;
    const float twoPi=2.0f*(float)M_PI;
    angle=fmodf(angle,twoPi);
    if(angle>(float)M_PI){
        angle-=twoPi;
    }else if(angle<-(float)M_PI){
        angle+=twoPi;
    }
    s->angle=angle;
    s->isRotated=(fabsf(angle)>0.0001f)?1:0;
    s->rotCos=s->isRotated?cosf(angle):1.0f;
    s->rotSin=s->isRotated?sinf(angle):0.0f;
    if(s->isRotated){
        updateSpriteTransform(s);
        if(s->space==SPRITE_SPACE_LAYER){
            placeSprite(s);
        }
    }else{
        // Back to the unrotated renderers - restore the unrotated scaled size and position (placing it, if in layer space)
        setSpriteScale(ix,s->isScaled?s->scaleX:0.0f,s->isScaled?s->scaleY:0.0f);
    }
}

/// @brief Set a sprite to be drawn with the rotated renderer, with a forward transform (sprite pixels to screen pixels,
/// including scale): screen offset = (a*u + b*v, c*u + d*v) for sprite offset (u,v) from its centre
static void setSpriteMatrix(Sprite *s, float a, float b, float c, float d)
{
    float det=(a*d)-(b*c);
    if(fabsf(det)<0.000001f){
        det=0.000001f;
    }
    s->fDudx=d/det;
    s->fDudy=-b/det;
    s->fDvdx=-c/det;
    s->fDvdy=a/det;
    s->invDudx=FIXED16(s->fDudx);
    s->invDudy=FIXED16(s->fDudy);
    s->invDvdx=FIXED16(s->fDvdx);
    s->invDvdy=FIXED16(s->fDvdy);
    // Bounding box of the transformed sprite (plus a pixel of margin)
    const float hw=(float)s->width*0.5f;
    const float hh=(float)s->height*0.5f;
    const int ex=(int)ceilf((fabsf(a)*hw)+(fabsf(b)*hh))+1;
    const int ey=(int)ceilf((fabsf(c)*hw)+(fabsf(d)*hh))+1;
    s->scaledWidth=(int16_t)(ex*2);
    s->scaledHeight=(int16_t)(ey*2);
    s->offX=(int16_t)(s->x-ex);
    s->offY=(int16_t)(s->y-ey);
    s->isRotated=1;
}

void placeSprite(Sprite *s)
{
    const int parent=(s->parentLayer>=0)?s->parentLayer:s->layer;
    if(parent<0 || parent>=MAX_TILE_LAYERS){
        return;
    }
    const TileLayer *tL=tileLayer+parent;

    // Its centre on screen
    // (to the pixel as a screen space sprite's position would be, allowing for float rounding in the conversion)
    float sx, sy;
    layerToScreen(parent,s->xF,s->yF,&sx,&sy);
    s->x=(int16_t)floorf(sx+0.001f);
    s->y=(int16_t)floorf(sy+0.001f);

    // Its own rotation and scale, as a forward transform
    const float scx=s->isScaled?s->scaleX:1.0f;
    const float scy=s->isScaled?s->scaleY:1.0f;
    const float a=s->rotCos*scx;
    const float b=-s->rotSin*scy;
    const float c=s->rotSin*scx;
    const float d=s->rotCos*scy;

    if(s->rotateWithLayer && tL->transformed){
        // Rotating and scaling with the layer - combine the layer's transform with its own
        setSpriteMatrix(s,(tL->fwdXX*a)+(tL->fwdXY*c),(tL->fwdXX*b)+(tL->fwdXY*d),
            (tL->fwdYX*a)+(tL->fwdYY*c),(tL->fwdYX*b)+(tL->fwdYY*d));
    }else if(fabsf(s->angle)>0.0001f){
        // Its own rotation only - exactly as a screen space sprite
        s->isRotated=1;
        updateSpriteTransform(s);
    }else{
        // Not rotated - the fast (or scaled) renderers, as setSpriteScale sets up
        s->isRotated=0;
        s->scaledWidth=s->isScaled?(int16_t)((float)s->width*s->scaleX):s->width;
        s->scaledHeight=s->isScaled?(int16_t)((float)s->height*s->scaleY):s->height;
        s->offX=s->x-(s->scaledWidth/2);
        s->offY=s->y-(s->scaledHeight/2);
    }
}

void placeLayerSprites(void)
{
    for(int n=0;n<totalSprites;n++){
        if(spriteList[n].space==SPRITE_SPACE_LAYER){
            placeSprite(spriteList+n);
        }
    }
}

void setSpriteSpace(int ix, SpriteSpace space, int parentLayer)
{
    Sprite *s=spriteList+ix;
    const int parent=(parentLayer>=0)?parentLayer:s->layer;
    s->parentLayer=(int8_t)parentLayer;
    if(parent<0 || parent>=MAX_TILE_LAYERS){
        return;
    }
    if(space==SPRITE_SPACE_LAYER){
        if(s->space!=SPRITE_SPACE_LAYER){
            // Keep it where it is on screen
            float u, v;
            screenToLayer(parent,s->xF,s->yF,&u,&v);
            s->xF=u;
            s->yF=v;
        }
        s->space=SPRITE_SPACE_LAYER;
        placeSprite(s);
    }else if(s->space==SPRITE_SPACE_LAYER){
        // Keep it where it is on screen (the pixel it's drawn at, and its position within it)
        float sx, sy;
        layerToScreen(parent,s->xF,s->yF,&sx,&sy);
        const int16_t px=s->x, py=s->y;
        s->space=SPRITE_SPACE_SCREEN;
        setSpritePos(ix,sx,sy);
        s->x=px;
        s->y=py;
        // Back to its own rotation and scale
        setSpriteRotation(ix,s->angle);
    }
}

/// @brief A point near a sprite - its offset in the sprite's own pixels, scaled and rotated as the sprite is drawn
/// @param px,py Set to the point: in its layer's coordinates for a layer space sprite, on screen for a screen space one
/// @return The layer to look in (the sprite's parent layer, or the layer it's drawn over)
static int spritePointOf(const Sprite *s, float dx, float dy, float *px, float *py)
{
    float ox=dx, oy=dy;
    if(s->rotSin!=0.0f || s->isScaled){
        // Its own rotation and scale (rotSin is exactly 0 when it isn't rotated)
        const float scx=s->isScaled?s->scaleX:1.0f;
        const float scy=s->isScaled?s->scaleY:1.0f;
        ox=(s->rotCos*dx*scx)-(s->rotSin*dy*scy);
        oy=(s->rotSin*dx*scx)+(s->rotCos*dy*scy);
    }
    if(s->space==SPRITE_SPACE_LAYER){
        const int parent=(s->parentLayer>=0)?s->parentLayer:s->layer;
        if(s->rotateWithLayer || parent<0 || parent>=MAX_TILE_LAYERS || !tileLayer[parent].transformed){
            // The sprite turns with the layer, so its own frame is already in the layer's coordinates
            *px=s->xF+ox;
            *py=s->yF+oy;
        }else{
            // Upright on screen - turn the offset from the screen's direction into the layer's
            float lx, ly;
            screenToLayerVector(parent,ox,oy,&lx,&ly);
            *px=s->xF+lx;
            *py=s->yF+ly;
        }
        return parent;
    }
    *px=(float)s->x+ox;
    *py=(float)s->y+oy;
    return s->layer;
}

int getSpritePoint(int ix, float dx, float dy, float *x, float *y)
{
    return spritePointOf(spriteList+ix,dx,dy,x,y);
}

int getSpriteTileAt(int ix, float dx, float dy, int *tileX, int *tileY)
{
    const Sprite *s=spriteList+ix;
    float px, py;
    const int layer=spritePointOf(s,dx,dy,&px,&py);
    if(layer<0 || layer>=MAX_TILE_LAYERS){
        return -1;
    }
    const int x=(int)floorf(px);
    const int y=(int)floorf(py);
    // Layer space: straight from the tile map. Screen space: through the layer's mapping to the screen
    return (s->space==SPRITE_SPACE_LAYER)?getLayerMapTileNumber(layer,x,y,tileX,tileY):
        getLayerTileNumberAt(layer,x,y,tileX,tileY);
}

bool isSpritePointSolid(int ix, float dx, float dy)
{
    const Sprite *s=spriteList+ix;
    float px, py;
    const int layer=spritePointOf(s,dx,dy,&px,&py);
    if(layer<0 || layer>=MAX_TILE_LAYERS){
        return false;
    }
    const int x=(int)floorf(px);
    const int y=(int)floorf(py);
    return (s->space==SPRITE_SPACE_LAYER)?isLayerMapPixelSet(layer,x,y):isLayerPixelSetAt(layer,x,y);
}

// If a whole pixel offset from a sprite needs no rotating or scaling (the sprite isn't rotated or scaled itself, and a
// layer space sprite either turns with its layer or its layer isn't transformed), sets the sprite's own pixel and
// returns the layer to look in - otherwise returns -1 and the float route is used
static inline int __attribute__((always_inline)) spritePlainBase(const Sprite *s, int *bx, int *by)
{
    if(s->rotSin!=0.0f || s->isScaled){
        return -1;
    }
    if(s->space==SPRITE_SPACE_LAYER){
        const int parent=(s->parentLayer>=0)?s->parentLayer:s->layer;
        if(parent<0 || parent>=MAX_TILE_LAYERS || (!s->rotateWithLayer && tileLayer[parent].transformed)){
            return -1;
        }
        // floor(xF+dx) is floor(xF)+dx for a whole dx
        *bx=(int)floorf(s->xF);
        *by=(int)floorf(s->yF);
        return parent;
    }
    *bx=s->x;
    *by=s->y;
    return s->layer;
}

int __not_in_flash_func(getSpriteTileAtI)(int ix, int dx, int dy, int *tileX, int *tileY)
{
    const Sprite *s=spriteList+ix;
    int bx, by;
    const int layer=spritePlainBase(s,&bx,&by);
    if(layer<0){
        return getSpriteTileAt(ix,(float)dx,(float)dy,tileX,tileY);
    }
    return (s->space==SPRITE_SPACE_LAYER)?getLayerMapTileNumber(layer,bx+dx,by+dy,tileX,tileY):
        getLayerTileNumberAt(layer,bx+dx,by+dy,tileX,tileY);
}

bool __not_in_flash_func(isSpritePointSolidI)(int ix, int dx, int dy)
{
    const Sprite *s=spriteList+ix;
    int bx, by;
    const int layer=spritePlainBase(s,&bx,&by);
    if(layer<0){
        return isSpritePointSolid(ix,(float)dx,(float)dy);
    }
    return (s->space==SPRITE_SPACE_LAYER)?isLayerMapPixelSet(layer,bx+dx,by+dy):isLayerPixelSetAt(layer,bx+dx,by+dy);
}

void setSpriteRotateWithLayer(int ix, bool rotate)
{
    Sprite *s=spriteList+ix;
    s->rotateWithLayer=rotate?1:0;
    if(s->space==SPRITE_SPACE_LAYER){
        placeSprite(s);
    }
}

void updateSpriteTransform(Sprite *s)
{
    const float sx=s->isScaled?s->scaleX:1.0f;
    const float sy=s->isScaled?s->scaleY:1.0f;
    // The cosine and sine of its angle, worked out once in setSpriteRotation
    const float c=s->rotCos;
    const float sn=s->rotSin;

    // Inverse of rotate then scale, so each screen pixel can be mapped back to a sprite pixel
    s->fDudx=c/sx;
    s->fDudy=sn/sx;
    s->fDvdx=-sn/sy;
    s->fDvdy=c/sy;
    s->invDudx=FIXED16(s->fDudx);
    s->invDudy=FIXED16(s->fDudy);
    s->invDvdx=FIXED16(s->fDvdx);
    s->invDvdy=FIXED16(s->fDvdy);

    // Bounding box of the rotated sprite (plus a pixel of margin), used for clipping and culling
    const float hw=(float)s->width*sx*0.5f;
    const float hh=(float)s->height*sy*0.5f;
    const int ex=(int)ceilf((fabsf(c)*hw)+(fabsf(sn)*hh))+1;
    const int ey=(int)ceilf((fabsf(sn)*hw)+(fabsf(c)*hh))+1;
    s->scaledWidth=ex*2;
    s->scaledHeight=ey*2;
    s->offX=s->x-ex;
    s->offY=s->y-ey;
}

void blitSpritesToRenderBuffer(int layerIX)
{
    for(int n=totalSprites-1;n>-1;n--){
        Sprite *s=spriteList+n;
        // If sprite is not in this layer, it's not shown
        // Also if it's not within the visible screen, it's not shown
        if(
            (s->layer!=layerIX) || 
            (s->offY>=SCREEN_HEIGHT_LINES) || 
            (s->offY<=-(s->scaledHeight)) || 
            (s->offX<=-(s->scaledWidth)) || 
            (s->offX>=SCREEN_WIDTH_PIXELS)
        ){
            continue;
        }

        if(s->isRotated){
            blitSpriteTransformedToRenderBuffer(s);
        }else if(s->isScaled){
            blitSpriteScaledToRenderBuffer(s);
        }else{
            switch(s->width){
                case 8:
                    blitSprite8ToRenderBuffer(s);
                    break;
                case 16:
                    blitSprite16ToRenderBuffer(s);
                    break;
                case 24:
                case 32:
                    blitSprite24ToRenderBuffer(s);
                    break;
            }
        }
    }
}

void blitSprite8ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->offX>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->offX&0x07;
    const uint8_t *sDef=(uint8_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint8_t *mDef=(uint8_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->offY*SCREEN_WIDTH_CELLS);

    for(int y=s->offY;y<s->offY+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint16_t src16=  (*sDef<<8)>>shiftRight;
            uint16_t mask16=(((*mDef<<8)+0xff)>>shiftRight)|(0xffffu<<(16-shiftRight));
            if(xS>-1){
                *(rP+xS)&=(uint8_t)(mask16>>8);
                *(rP+xS)|=(uint8_t)(src16>>8);
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(rP+xS+1)&=(uint8_t)(mask16);
                *(rP+xS+1)|=(uint8_t)(src16);
            }
        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->offY/ATTR_HEIGHT_PIXELS);
    uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
    const uint8_t *apSrc=palette[s->paletteIX];
    for(int y=startY;y<startY+(spriteHeight/ATTR_HEIGHT_PIXELS);y++){
        const uint8_t apS=*apSrc;
        if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
            if(xS>-1){
                *(aP+xS)=apS;
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)  && (shiftRight>0)){
                *(aP+xS+1)=apS;
            }
        }
        ++apSrc;
        aP+=SCREEN_WIDTH_CELLS;
    }
}

void blitSprite16ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->offX>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->offX&0x07;
    const uint16_t *sDef=(uint16_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint16_t *mDef=(uint16_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->offY*SCREEN_WIDTH_CELLS);

    for(int y=s->offY;y<s->offY+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint32_t src32= *sDef;
            uint32_t mask32=*mDef;
            src32=  ((src32<<24)  |((src32&0xff00)<<8))>>shiftRight;
            mask32= (((mask32<<24)|((mask32&0xff00)<<8)|0xffff)>>shiftRight)|(shiftRight?(0xffffffffu<<(32-shiftRight)):0);
            if(xS>-1){
                *(rP+xS)&=(uint8_t)(mask32>>24);
                *(rP+xS)|=(uint8_t)(src32>>24);
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(rP+xS+1)&=(uint8_t)(mask32>>16);
                *(rP+xS+1)|=(uint8_t)(src32>>16);
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)){
                *(rP+xS+2)&=(uint8_t)(mask32>>8);
                *(rP+xS+2)|=(uint8_t)(src32>>8);
            }
        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->offY/ATTR_HEIGHT_PIXELS);
    uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
    const uint8_t *apSrc=palette[s->paletteIX];
    for(int y=startY;y<startY+(spriteHeight/ATTR_HEIGHT_PIXELS);y++){
        const uint8_t apS=*apSrc;
        if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
            if(xS>-1){
                *(aP+xS)=apS;
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(aP+xS+1)=apS;
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)  && (shiftRight>0)){
                *(aP+xS+2)=apS;
            }
        }
        ++apSrc;
        aP+=SCREEN_WIDTH_CELLS;
    }
}

void blitSprite24ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->offX>>3;                                                    // Character cell to start in is the xPos/8
    const int shiftRight=s->offX&0x07;
    const bool is32=(s->width==32);
    const uint32_t *sDef=(uint32_t *)s->defPtr+(s->frame*spriteHeight);         // Point to start of sprite foreground data
    const uint32_t *mDef=(uint32_t *)s->maskPtr+(s->frame*spriteHeight);        // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->offY*SCREEN_WIDTH_CELLS);

    for(int y=s->offY;y<s->offY+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint32_t src32= ((*sDef<<24)+((*sDef&0x0000ff00)<<8)+((*sDef&0x00ff0000)>>8)+(*sDef>>24))>>shiftRight;
            uint32_t mask32=(((*mDef<<24)+((*mDef&0x0000ff00)<<8)+((*mDef&0x00ff0000)>>8)+(*mDef>>24))>>shiftRight)|(shiftRight?(0xffffffffu<<(32-shiftRight)):0);
            if(xS>-1){
                *(rP+xS)&=(uint8_t)(mask32>>24);
                *(rP+xS)|=(uint8_t)(src32>>24);
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(rP+xS+1)&=(uint8_t)(mask32>>16);
                *(rP+xS+1)|=(uint8_t)(src32>>16);
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)){
                *(rP+xS+2)&=(uint8_t)(mask32>>8);
                *(rP+xS+2)|=(uint8_t)(src32>>8);
            }
            if(xS>-4 && xS<(SCREEN_WIDTH_CELLS-3)){
                *(rP+xS+3)&=(uint8_t)(mask32);
                *(rP+xS+3)|=(uint8_t)(src32);
            }
            // 32 pixel wide sprites spill into a 5th byte when not character aligned - these are the bits shifted
            // out of the right of the 32 bit word above (the last source byte is the top byte of the word)
            if(is32 && shiftRight && xS>-5 && xS<(SCREEN_WIDTH_CELLS-4)){
                *(rP+xS+4)&=(uint8_t)(((*mDef>>24)<<(8-shiftRight))|(0xffu>>shiftRight));
                *(rP+xS+4)|=(uint8_t)((*sDef>>24)<<(8-shiftRight));
            }

        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->offY/ATTR_HEIGHT_PIXELS);
    uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
    const uint8_t *apSrc=palette[s->paletteIX];
    for(int y=startY;y<startY+(spriteHeight/ATTR_HEIGHT_PIXELS);y++){
        const uint8_t apS=*apSrc;
        if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
            if(xS>-1){
                *(aP+xS)=apS;
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(aP+xS+1)=apS;
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)){
                *(aP+xS+2)=apS;
            }
            if(xS>-4 && xS<(SCREEN_WIDTH_CELLS-3)  && ((shiftRight>0) || is32)){
                *(aP+xS+3)=apS;
            }
            if(xS>-5 && xS<(SCREEN_WIDTH_CELLS-4) && is32 && (shiftRight>0)){
                *(aP+xS+4)=apS;
            }
        }
        ++apSrc;
        aP+=SCREEN_WIDTH_CELLS;
    }
}

void blitSpriteScaledToRenderBuffer(Sprite *s)
{
    const int lineBufferLen = 256;
    const int sHeight=s->scaledHeight;
    const int sWidth=s->scaledWidth;
    const int sY=s->offY;
    const int bpr=s->bytesPerRow;
    const int xS=s->offX>>3;                                                  // Character cell to start in is the xPos/8
    const int dstStartBitPos=7-(s->offX&0x07);
    const uint8_t *sDefBase=(uint8_t *)s->defPtr+(s->frame*s->height*s->bytesPerRow);       // Point to start of sprite foreground data
    const uint8_t *mDefBase=(uint8_t *)s->maskPtr+(s->frame*s->height*s->bytesPerRow);      // Point to start of sprite mask data
    const uint8_t *apSrc=palette[s->paletteIX];
    const int endLine=(sY+sHeight>SCREEN_HEIGHT_LINES?SCREEN_HEIGHT_LINES:sY+sHeight);
    // Bytes the scaled line covers, including the start position within the first byte
    const int sWidthChars=((s->offX&0x07)+sWidth+7)>>3;

    U32u8 xAdd,yAdd;
    yAdd.u32 = 0;
    uint8_t lByte = 255;

    // If the sprite starts above the screen, skip the source rows that are off screen, so drawing starts at the top
    // line of the buffers (and not before them)
    int firstLine=sY;
    if(firstLine<0){
        yAdd.u32=(uint32_t)(-firstLine)*s->scaledHeightAdder.u32;
        firstLine=0;
    }
    uint8_t *rP=(uint8_t *)renderBuffer+(firstLine*SCREEN_WIDTH_CELLS);
    uint8_t *aP=renderAttrBuffer+((firstLine/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS);
    int attrCountDown=1;

    memset(pixLineBuffer,0,lineBufferLen);
    memset(maskLineBuffer,0xff,lineBufferLen);
    for(int y=firstLine;y<endLine;y++){
        if(y>-1){
            if(lByte!=yAdd.u8[2]){
                lByte = yAdd.u8[2];
                int dstBitPos=dstStartBitPos;
                xAdd.u32=0;
                const uint8_t *src=sDefBase+((int)yAdd.u8[2] * bpr);
                const uint8_t *mSrc=mDefBase+((int)yAdd.u8[2] * bpr);
                int srcBitPos=7;
                int plbIX=0;
                pixLineBuffer[plbIX]=0;
                maskLineBuffer[plbIX]=0xff;
                for (int x = 0; x < sWidth; x++) {
                    if(*src&(1<<srcBitPos)){
                        pixLineBuffer[plbIX]|=(1<<dstBitPos);
                    }
                    if((*mSrc&(1<<srcBitPos))==0){
                        maskLineBuffer[plbIX]&=~(1<<dstBitPos);
                    }
                    if(--dstBitPos<0){
                        ++plbIX;
                        pixLineBuffer[plbIX]=0;
                        maskLineBuffer[plbIX]=0xff;
                        dstBitPos+=8;
                    }
                    xAdd.u32 += s->scaledWidthAdder.u32;
                    if (xAdd.u8[2] > 0) {
                        srcBitPos -= xAdd.u8[2];
                        xAdd.u8[2] = 0;
                        if (srcBitPos < 0) {
                            srcBitPos += 8;
                            ++src;
                            ++mSrc;
                        }
                    }
                }
            }

            yAdd.u32 += s->scaledHeightAdder.u32;
            for(int lIX=0;lIX<sWidthChars;lIX++){
                int dstChar=lIX+xS;
                if(dstChar>-1 && dstChar<SCREEN_WIDTH_CELLS){
                    *(rP+dstChar)&=maskLineBuffer[lIX];
                    *(rP+dstChar)|=pixLineBuffer[lIX];
                }
            }

            // Add attributes if flash bit not set - only once every 4 rows of pixels - always draw on last line to ensure we cover the bottom row of the sprite
            if(--attrCountDown==0){
                uint8_t c=*(apSrc+(yAdd.u8[2]>>2));
                if( (c&0x80)==0 ){
                    for(int lIX=0;lIX<sWidthChars;lIX++){
                        int dstChar=lIX+xS;
                        if(dstChar>-1 && dstChar<SCREEN_WIDTH_CELLS){
                            *(aP+dstChar)=c;
                        }
                    }
                }
                aP+=SCREEN_WIDTH_CELLS;
                if(endLine-y>3){
                    attrCountDown=4;                    
                }else{
                    attrCountDown=endLine-y;
                }
            }
            rP+=SCREEN_WIDTH_CELLS;

        }
    }
}


// Not inlined, so the renderer and collision tests run the same compiled code, and get bit identical results (the
// compiler may otherwise combine the multiply-adds differently in each place)
__attribute__((noinline)) void spriteTransformOrigin(const Sprite *s, int x0, int y0, int32_t *u, int32_t *v)
{
    const float centreU=(float)s->width*0.5f;
    const float centreV=(float)s->height*0.5f;
    const float relX=((float)x0+0.5f)-(float)s->x;
    const float relY=((float)y0+0.5f)-(float)s->y;
    *u=FIXED16(centreU+(s->fDudx*relX)+(s->fDudy*relY));
    *v=FIXED16(centreV+(s->fDvdx*relX)+(s->fDvdy*relY));
}

void __no_inline_not_in_flash_func(blitSpriteTransformedToRenderBuffer)(Sprite *s)
{
    const int w=s->width;
    const int h=s->height;
    const int bpr=s->bytesPerRow;
    const uint8_t *sDef=s->defPtr+(s->frame*h*bpr);      // Point to start of sprite foreground data
    const uint8_t *mDef=s->maskPtr+(s->frame*h*bpr);     // Point to start of sprite mask data
    const uint8_t *apSrc=palette[s->paletteIX];
    const int maxPaletteIX=(int)sizeof(palette[0])-1;
    const int32_t limU=w<<16;
    const int32_t limV=h<<16;
    const int32_t du=s->invDudx;
    const int32_t dv=s->invDvdx;

    // Bounding box, clipped to the screen
    int x0=s->offX;
    int x1=s->offX+s->scaledWidth;
    int y0=s->offY;
    int y1=s->offY+s->scaledHeight;
    if(x0<0){
        x0=0;
    }
    if(x1>SCREEN_WIDTH_PIXELS){
        x1=SCREEN_WIDTH_PIXELS;
    }
    if(y0<0){
        y0=0;
    }
    if(y1>SCREEN_HEIGHT_LINES){
        y1=SCREEN_HEIGHT_LINES;
    }
    if(x0>=x1 || y0>=y1){
        return;
    }

    // Sprite position sampled at the centre of screen pixel (x0,y0), stepped along each line and down each row
    const float centreV=(float)h*0.5f;
    int32_t rowU, rowV;
    spriteTransformOrigin(s,x0,y0,&rowU,&rowV);

    uint8_t *rP=(uint8_t *)renderBuffer+(y0*SCREEN_WIDTH_CELLS);
    uint32_t cellsUsed=0;   // One bit per character column the sprite drew solid pixels in, for the current attribute row

    for(int y=y0;y<y1;y++){
        // Only visit the pixels on this line that land inside the sprite
        int start=0, end=x1-x0;
        clipSpan(rowU,du,limU,&start,&end);
        clipSpan(rowV,dv,limV,&start,&end);
        if(start<end){
            int32_t u=rowU+(start*du);
            int32_t v=rowV+(start*dv);
            int x=x0+start;
            const int xEnd=x0+end;
            while(x<xEnd){
                // Build up to 8 pixels for this character cell, then combine with the render buffer using the mask
                const int cell=x>>3;
                const int cellEnd=((cell+1)*8<xEnd)?(cell+1)*8:xEnd;
                uint32_t pix=0;
                uint32_t keep=0xff;
                for(;x<cellEnd;x++){
                    const int32_t ui=u>>16;
                    const int off=((v>>16)*bpr)+(ui>>3);
                    const int sh=ui&7;
                    const uint32_t bit=0x80>>(x&7);
                    if((sDef[off]<<sh)&0x80){
                        pix|=bit;
                    }
                    if(((mDef[off]<<sh)&0x80)==0){
                        keep&=~bit;
                    }
                    u+=du;
                    v+=dv;
                }
                rP[cell]=(uint8_t)((rP[cell]&keep)|pix);
                if(keep!=0xff){
                    cellsUsed|=1u<<cell;
                }
            }
        }
        rowU+=s->invDudy;
        rowV+=s->invDvdy;
        rP+=SCREEN_WIDTH_CELLS;

        // At the end of each 8x4 attribute row, colour the cells the sprite covered, using the palette entry for
        // the sprite row found at the centre of each cell (flash bit set means leave the cell alone)
        if((((y&(ATTR_HEIGHT_PIXELS-1))==(ATTR_HEIGHT_PIXELS-1)) || (y==y1-1)) && cellsUsed){
            const int cy=y/ATTR_HEIGHT_PIXELS;
            uint8_t *aP=renderAttrBuffer+(cy*SCREEN_WIDTH_CELLS);
            const float relCY=((float)((cy*ATTR_HEIGHT_PIXELS)+(ATTR_HEIGHT_PIXELS/2))+0.5f)-(float)s->y;
            for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                if((cellsUsed&(1u<<cx))==0){
                    continue;
                }
                const float relCX=((float)((cx*8)+4)+0.5f)-(float)s->x;
                int srcRow=(int)floorf(centreV+(s->fDvdx*relCX)+(s->fDvdy*relCY));
                if(srcRow<0){
                    srcRow=0;
                }else if(srcRow>=h){
                    srcRow=h-1;
                }
                int pIX=srcRow/ATTR_HEIGHT_PIXELS;
                if(pIX>maxPaletteIX){
                    pIX=maxPaletteIX;
                }
                const uint8_t c=apSrc[pIX];
                if((c&0x80)==0){
                    aP[cx]=c;
                }
            }
            cellsUsed=0;
        }
    }
}
