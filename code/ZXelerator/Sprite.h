#pragma once

#include "defs.h"
#include <stdint.h>
#include <stdbool.h>
#include "shared.h"
#include "displayMemoryOffsets.h"
#include "spriteDefs.h"
#include "palette.h"


/// @brief Structure containing data for a single Sprite object
typedef struct Sprite {
    // Bit field to associate sprite with groups
    uint32_t    groupBits;
    // Sprites that can collide with this, based on their bit fields (OR'd with this sprites bit field)
    uint32_t    collideGroupBits;
    // Integer position in X axis
    int16_t     x;
    // Integer position in Y axis
    int16_t     y;
    // The sprite definition base index currently pointed to by this sprite
    int16_t     defIX;
    // The sprite frame, relative to the base defIX
    int16_t     frame;
    // Tile layer this sprite appears over (-1=sprite not shown, 0=appears over back-most layer, 1=appears over layer 1, 2=appears over layer 2)
    int16_t    layer;
    // The palette this sprite will use (palettes are 6 bytes, with each byte being the attribute for a 24x4 row of the sprite, top to bottom)
    int16_t     paletteIX;
    // Float position in X axis
    float       xF;
    // Float position in Y axis
    float       yF;
    // Float velocity in X axis (added to xF, which then updates x each frame, if not zero)
    float       xDir;
    // Float velocity in Y axis (added to yF, which then updates y each frame, if not zero)
    float       yDir;
} Sprite;

extern Sprite *spriteList;
extern int totalSprites;

void initSprites(int numSprites);
void deleteSprites(void);

static inline void setSpriteDir(int ix, float xDir, float yDir)
{
    Sprite *s=spriteList+ix;
    s->xDir=xDir;
    s->yDir=yDir;
}

static inline void setSpritePos(int ix, float x, float y)
{
    Sprite *s=spriteList+ix;
    s->x=x;
    s->y=y;
    s->xF=x;
    s->yF=y;
}

static inline void setSpriteLayer(int ix, int l){
    if(l>MAX_TILE_LAYERS){
        l=MAX_TILE_LAYERS;
    }
    spriteList[ix].layer=l;
}

static inline void setSpriteDef(int ix, int d)
{
    spriteList[ix].defIX=d;
}

static inline void setSpritePalette(int ix, int p)
{
    spriteList[ix].paletteIX=p;
}

static inline void setSpriteGroups(int ix, uint32_t gB, uint32_t cGB)
{
    Sprite *s=spriteList+ix;
    s->groupBits=gB;
    s->collideGroupBits=cGB;
}

void drawSprite(int ix);

void blitSpritesToRenderBuffer(int ix);
