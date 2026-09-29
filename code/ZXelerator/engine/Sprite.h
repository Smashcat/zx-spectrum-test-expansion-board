#pragma once

#include "defs.h"
#include <stdint.h>
#include <stdbool.h>
#include <memory.h>
#include "shared.h"
#include "displayMemoryOffsets.h"
#include "spriteDefs.h"
#include "palette.h"
#include "fixedMath.h"

// ---------------------------------------------------------------------------
// Collisions - flags for setSpriteCollisions (combine with |)
// ---------------------------------------------------------------------------
#define MAX_COLLISION_HITS      16
#define COLLIDE_NONE            0x00
/// @brief Collide with the tile layer drawn just before the sprite - the layer it's drawn over (setSpriteLayer).
/// Layers are drawn back to front, with each layer's sprites and particles drawn straight after it
#define COLLIDE_LAYER           0x01
/// @brief Collide with other sprites that also have COLLIDE_SPRITES
#define COLLIDE_SPRITES         0x02

/// @brief A tile a sprite collided with - its position in the layer's tile map
typedef struct TileHit {
    uint8_t x;
    uint8_t y;
} TileHit;

/// @brief Sizes can be set since not all sprites need to be the maximum size, for example a bullet does not need to be 24x24, and would be wasteful in terms of flash space and processing
typedef enum SpriteSize {
    SIZE_8X4,
    SIZE_8X8,
    SIZE_8X12,
    SIZE_8X16,

    SIZE_16X8,
    SIZE_16X12,
    SIZE_16X16,
    SIZE_16X24,

    SIZE_24X24,
    SIZE_24X32,
    SIZE_24X40,
    SIZE_24X48,
    SIZE_24X64,

    SIZE_32X40
} SpriteSize;

/// @brief Used when performing fixed point math for faster scaling of sprites
typedef union U32u8 {
    uint32_t u32;
    uint8_t u8[4];
} U32u8;

/// @brief Structure containing data for a single Sprite object
typedef struct Sprite {
    // Integer position in X axis (centre of sprite)
    int16_t         x;
    // Integer position in Y axis (centre of sprite)
    int16_t         y;
    // Offset x position to the left edge
    int16_t         offX;
    // Offset t position to the top edge
    int16_t         offY;
    // The sprite definition base index currently pointed to by this sprite
    const uint8_t   *defPtr;
    // The sprite mask definition base index currently pointed to by this sprite
    const uint8_t   *maskPtr;
    // The sprite frame, relative to the base defIX
    int16_t         frame;
    // Tile layer this sprite appears over (-1=sprite not shown, 0=appears over back-most layer, 1=appears over layer 1, 2=appears over layer 2)
    int16_t         layer;
    // The palette this sprite will use (palettes are arrays of uint8_ts, with each byte being the attribute for a 4 pixel high row of the sprite, top to bottom)
    int16_t         paletteIX;
    // Float position in X axis
    float           xF;
    // Float position in Y axis
    float           yF;
    // Float velocity in X axis (added to xF, which then updates x each frame, if not zero)
    float           xDir;
    // Float velocity in Y axis (added to yF, which then updates y each frame, if not zero)
    float           yDir;
    // The dimensions of the sprite in pixels
    SpriteSize      size;
    // The width of sprite (set when specifying the size above, just to speed up rendering really - should NEVER be set directly unless you're happy to deal with the consequences!)
    int16_t         width;
    // The height of sprite (set when specifying the size above, just to speed up rendering really - should NEVER be set directly unless you're happy to deal with the consequences!)
    int16_t         height;
    // How many bytes are in the src data per row of the sprite (set when specifying the size above, just to speed up rendering really - should NEVER be set directly unless you're happy to deal with the consequences!)
    int16_t         bytesPerRow;
    // If above zero, this is the scaling multiplier for the sprite (so 2.0 would double the width of the sprite when it's rendered)
    float           scaleX;
    // If above zero, this is the scaling multiplier for the sprite (so 2.0 would double the height of the sprite when it's rendered)
    float           scaleY;
    // If not zero, sprite is scaled
    int16_t         isScaled;
    // The scaled width of sprite (only relevant if scaling has been set for the sprite since it was created, and the scaleX is >0)
    int16_t         scaledWidth;
    // Amount to add to src bit offset when copying bits to destination when rendering scaled sprite
    U32u8          scaledWidthAdder;

    // The scaled height of sprite (only relevant if scaling has been set for the sprite since it was created, and the scaleY is >0)
    int16_t         scaledHeight;
    // Amount to add to src y offset when copying bytes to destination when rendering scaled sprite
    U32u8          scaledHeightAdder;
    // Useful for staggering effects with sprites
    int             delay;
    // Rotation in radians, clockwise on screen (set with setSpriteRotation)
    float           angle;
    // If not zero, sprite is rotated (and possibly scaled), and drawn with the transformed renderer
    int16_t         isRotated;
    // Inverse transform for rotated sprites - sprite pixels per screen pixel, as 16.16 fixed point for drawing...
    int32_t         invDudx, invDudy, invDvdx, invDvdy;
    // ...and float for placing attributes
    float           fDudx, fDudy, fDvdx, fDvdy;

    // What this sprite collides with (COLLIDE_ flags), set with setSpriteCollisions
    uint8_t         collideWith;
    // Collisions found in the last frame drawn (pixel accurate - the sprite's pixels, not its mask, against the other
    // sprites' pixels and the tile graphics). Filled in by compositeScene, up to MAX_COLLISION_HITS of each
    uint8_t         spriteHitCount;
    uint8_t         tileHitCount;
    // Indexes of the sprites hit
    int16_t         spriteHits[MAX_COLLISION_HITS];
    // Tiles hit in the layer the sprite is drawn over (each tile listed once)
    TileHit         tileHits[MAX_COLLISION_HITS];
} Sprite;

extern Sprite *spriteList;
extern int totalSprites;

/// @brief INTERNAL - recalculates the transform and bounding box of a rotated sprite after its size, scale or angle change
void updateSpriteTransform(Sprite *s);

/// @brief INTERNAL - for a rotated sprite, the sprite position (16.16) sampled at the centre of screen pixel (x0,y0).
/// Shared by the renderer and collision tests, so both sample exactly the same pixels
void spriteTransformOrigin(const Sprite *s, int x0, int y0, int32_t *u, int32_t *v);

/// @brief Set what a sprite collides with. Results are in the sprite's spriteHits/tileHits after each compositeScene
/// @param ix Sprite index
/// @param flags COLLIDE_ flags, e.g. COLLIDE_SPRITES|COLLIDE_LAYER (COLLIDE_NONE to stop)
static inline void setSpriteCollisions(int ix, uint8_t flags)
{
    Sprite *s=spriteList+ix;
    s->collideWith=flags;
    s->spriteHitCount=0;
    s->tileHitCount=0;
}

static inline void setSpriteScale(int ix, float xScale, float yScale)
{
    Sprite *s=spriteList+ix;
    s->isScaled=( (xScale>0) && (yScale>0) && ((xScale>1.001 || xScale<0.999) || (yScale>1.001 || yScale<0.999)) )?1:0;
    if (s->isScaled && (xScale < 0.125)) {
        xScale = 0.125;
    }
    if (s->isScaled && (yScale < 0.125)) {
        yScale = 0.125;
    }
    s->scaleX=xScale;
    s->scaleY=yScale;
    if(s->isScaled){
        s->scaledWidth=(int16_t)(((float)s->width)*xScale);
        s->scaledWidthAdder.u32 = (uint32_t)((1.0f / xScale)*0x10000);
        s->scaledHeight=(int16_t)(((float)s->height)*yScale);
        s->scaledHeightAdder.u32 = (uint32_t)((1.0f / yScale)*0x10000);
    }else{
        s->scaledWidth=s->width;
        s->scaledHeight=s->height;
    }
    s->offX=s->x-(s->scaledWidth/2);
    s->offY=s->y-(s->scaledHeight/2);
    if(s->isRotated){
        updateSpriteTransform(s);
    }
}

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
    s->offX=s->x-(s->scaledWidth/2);
    s->offY=s->y-(s->scaledHeight/2);

}

static inline void setSpriteLayer(int ix, int l){
    if(l>MAX_TILE_LAYERS){
        l=MAX_TILE_LAYERS;
    }
    spriteList[ix].layer=l;
}

static inline void setSpriteDef(int ix, const uint8_t *spriteDefArray, const uint8_t *spriteMaskArray)
{
    spriteList[ix].defPtr=spriteDefArray;
    spriteList[ix].maskPtr=spriteMaskArray;
}

static inline void setSpritePalette(int ix, int p)
{
    spriteList[ix].paletteIX=p;
}

/// @brief Rotate a sprite around its centre. Works together with setSpriteScale. An angle of zero uses the
/// faster unrotated renderers. Attributes are only set on the 8x4 cells the rotated sprite covers, using the
/// palette row for the part of the sprite at the centre of each cell
/// @param ix Sprite index
/// @param angle Rotation in radians, clockwise on screen
void setSpriteRotation(int ix, float angle);

void initSprites(int numSprites);
void deleteSprites(void);
void setSpriteSize(int ix, SpriteSize st);
void blitSpritesToRenderBuffer(int ix);

/// @brief INTERNAL - blits a 8 bit wide sprite to the render buffer
/// @param s Sprite pointer
void blitSprite8ToRenderBuffer(Sprite *s);

/// @brief INTERNAL - blits a 16 bit wide sprite to the render buffer
/// @param s Sprite pointer
void blitSprite16ToRenderBuffer(Sprite *s);

/// @brief INTERNAL - blits a 24 bit wide sprite to the render buffer - NOTE, the 24 bit wide sprites are padded so every row is 4 bytes, the last byte is always zero (or 0xff on mask byte) to align for faster reading
/// @param s Sprite pointer
void blitSprite24ToRenderBuffer(Sprite *s);

/// @brief INTERNAL - blits a scaled sprite to the render buffer
/// @param s Sprite pointer
void blitSpriteScaledToRenderBuffer(Sprite *s);

/// @brief INTERNAL - blits a rotated (and possibly scaled) sprite to the render buffer
/// @param s Sprite pointer
void blitSpriteTransformedToRenderBuffer(Sprite *s);
