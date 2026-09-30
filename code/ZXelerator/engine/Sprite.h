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
/// @brief Check for collisions with other sprites - those with COLLIDE_SPRITES or COLLIDE_TARGET - and record the hits in
/// this sprite's spriteHits (e.g. the player, or bullets)
#define COLLIDE_SPRITES         0x02
/// @brief Can be hit by sprites with COLLIDE_SPRITES, but doesn't check for collisions itself (no spriteHits are
/// recorded for it, and targets are never tested against each other) - e.g. enemies or pickups, when the player and
/// bullets do the checking. Sprites with no collision flags aren't in any collision tests
#define COLLIDE_TARGET          0x04

/// @brief Where a sprite's position (xF, yF) is (setSpriteSpace)
typedef enum SpriteSpace {
    /// @brief Screen pixel coordinates (the default) - e.g. the HUD, or things that don't belong to a layer's world
    SPRITE_SPACE_SCREEN,
    /// @brief A layer's own pixel coordinates - the sprite belongs to the layer's world, so it moves with the layer as it
    /// scrolls, rotates and scales (and by default rotates and scales with it too - see setSpriteRotateWithLayer).
    /// Scrolled, rotated and scaled layers only (not line transformed)
    SPRITE_SPACE_LAYER
} SpriteSpace;

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

    SIZE_32X40,
    SIZE_32X8,
    SIZE_16X32
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

    // Screen or layer space (setSpriteSpace). In layer space, xF/yF are the sprite's position (centre) in the layer's
    // coordinates, and x/y its position on screen, worked out each frame
    uint8_t         space;
    // The layer whose coordinates a layer space sprite uses (-1 = the layer it's drawn over)
    int8_t          parentLayer;
    // Layer space: if not zero (the default), the sprite also rotates and scales with the layer - otherwise it keeps its
    // own rotation and scale relative to the screen
    uint8_t         rotateWithLayer;
    // Cosine and sine of the sprite's own angle, kept so a layer space sprite's transform can be combined with its
    // layer's each frame without any trig
    float           rotCos, rotSin;

    // The sprite set it's in (SPRITE_SET_NONE if none) - see addSpriteToSet - and the next and previous sprites in that
    // set (-1 at the ends)
    int8_t          set;
    int16_t         setNext;
    int16_t         setPrev;

    // Given out by allocateSprite (and not yet freed)
    uint8_t         inUse;
    // Solid: found by getSolidSpriteAt, so it blocks movement like a wall (e.g. closed doors, piston heads). Set by its
    // sprite set (setSpriteSetSolid), or setSpriteSolid
    uint8_t         solid;
    // The level object this sprite was spawned for (see engine/level.h), or -1
    int16_t         levelObject;
} Sprite;

extern Sprite *spriteList;
extern int totalSprites;

/// @brief Take an unused sprite (one not given out by allocateSprite, or freed since), reset to its initial state: off
/// screen, screen space, no rotation, scaling, collisions or set. For sprites that come and go, e.g. enemies spawned
/// as the level scrolls. Sprites used by index without allocateSprite aren't tracked, so allocate those first (or all
/// sprites this way) to keep them apart
/// @return The sprite's index, or -1 if every sprite is in use
int allocateSprite(void);

/// @brief Give a sprite back: it's hidden, taken out of its set and collision tests, and can be allocated again
void freeSprite(int ix);

// ---------------------------------------------------------------------------
// Sprite sets - groups of sprites, e.g. platforms, enemies, doors, pickups. A sprite is in one set at most, and knows
// which, so finding out what the player has hit is a single check (isSpriteInSet), and a set's sprites can be looped
// through (firstSpriteInSet/nextSpriteInSet) without searching every sprite
// ---------------------------------------------------------------------------

#define MAX_SPRITE_SETS         16
#define SPRITE_SET_NONE         (-1)

typedef struct SpriteSet {
    bool used;
    // Sprites in it are solid (see setSpriteSetSolid)
    bool solid;
    // First and last sprites in the set (-1 if empty), and how many there are
    int16_t first;
    int16_t last;
    int16_t count;
} SpriteSet;

extern SpriteSet spriteSets[MAX_SPRITE_SETS];

/// @brief Create an empty sprite set
/// @return The set's index, or SPRITE_SET_NONE if there are already MAX_SPRITE_SETS sets
int createSpriteSet(void);

/// @brief Delete a sprite set - its sprites are left out of any set (the sprites themselves aren't changed)
void deleteSpriteSet(int setIX);

/// @brief Delete every sprite set (initSprites and deleteSprites do this too)
void deleteSpriteSets(void);

/// @brief Put a sprite in a set (taking it out of any set it was in), at the end of the set
/// @param setIX The set, or SPRITE_SET_NONE to take it out of its set
void addSpriteToSet(int ix, int setIX);

/// @brief Take a sprite out of its set
void removeSpriteFromSet(int ix);

/// @brief Set what every sprite in a set collides with (see setSpriteCollisions) - e.g. COLLIDE_TARGET for enemies
void setSpriteSetCollisions(int setIX, uint8_t flags);

/// @brief Make a set's sprites solid (or not) - those in it now, and those added later. Solid sprites block movement
/// like walls: the game checks for them with getSolidSpriteAt, alongside the level's solid tiles
void setSpriteSetSolid(int setIX, bool solid);

/// @brief Make one sprite solid or not, e.g. a door once it's open (a sprite in a solid set is solid when added)
void setSpriteSolid(int ix, bool solid);

/// @brief The first solid sprite overlapping a box in a layer's coordinates (inclusive) - its drawn size, unrotated,
/// around its position. Only layer space sprites belonging to that layer, in solid sets, are looked at (so it's quick)
/// @return The sprite, or -1
int getSolidSpriteAt(int layerIX, int x0, int y0, int x1, int y1);

/// @brief The first sprite that a sprite hit in the last frame drawn (see spriteHits) that's in a set - e.g. "has the
/// player hit an enemy?"
/// @return The sprite hit, or -1 if it hit none in the set
int getSpriteHitInSet(int ix, int setIX);

/// @brief The set a sprite is in, or SPRITE_SET_NONE
static inline int getSpriteSet(int ix)
{
    return spriteList[ix].set;
}

/// @brief True if a sprite is in a set - e.g. isSpriteInSet(player->spriteHits[n], platforms)
static inline bool isSpriteInSet(int ix, int setIX)
{
    return setIX>=0 && spriteList[ix].set==setIX;
}

/// @brief How many sprites are in a set
static inline int getSpriteSetCount(int setIX)
{
    return (setIX>=0 && setIX<MAX_SPRITE_SETS)?spriteSets[setIX].count:0;
}

/// @brief The sprites in a set, in the order they were added:
/// for(int ix=firstSpriteInSet(enemies);ix>=0;ix=nextSpriteInSet(ix)){ ... }
/// (to take sprites out of the set in the loop, get the next one before taking this one out)
/// @return A sprite index, or -1 if the set is empty
static inline int firstSpriteInSet(int setIX)
{
    return (setIX>=0 && setIX<MAX_SPRITE_SETS && spriteSets[setIX].used)?spriteSets[setIX].first:-1;
}

/// @brief The next sprite in the same set, or -1 after the last
static inline int nextSpriteInSet(int ix)
{
    return spriteList[ix].setNext;
}

/// @brief INTERNAL - recalculates the transform and bounding box of a rotated sprite after its size, scale or angle change
void updateSpriteTransform(Sprite *s);

/// @brief INTERNAL - works out a layer space sprite's screen position and transform, from its layer position and its
/// layer's current position, rotation and scale
void placeSprite(Sprite *s);

/// @brief INTERNAL - places every layer space sprite (called by compositeScene, before drawing)
void placeLayerSprites(void);

/// @brief Choose whether a sprite's position is in screen or layer coordinates (see SpriteSpace). Its current position is
/// converted, so it stays where it is on screen
/// @param ix Sprite index
/// @param space SPRITE_SPACE_SCREEN or SPRITE_SPACE_LAYER
/// @param parentLayer The layer whose coordinates are used, or -1 for the layer the sprite is drawn over
void setSpriteSpace(int ix, SpriteSpace space, int parentLayer);

/// @brief Layer space sprites: true (the default) to rotate and scale with the layer, e.g. scenery or crates on a tilting
/// platform - false to keep the sprite's own rotation and scale relative to the screen, e.g. a character that stays
/// upright (its position still follows the layer)
void setSpriteRotateWithLayer(int ix, bool rotate);

/// @brief A point near a sprite, in the sprite's space - e.g. where to start particles from its gun
/// @param dx,dy Offset from the sprite's centre, in its own pixels - scaled and rotated as the sprite is drawn
/// @param x,y Set to the point: in its layer's coordinates for a layer space sprite, on screen for a screen space one
/// @return The layer: the one it belongs to (layer space) or is drawn over (screen space)
int getSpritePoint(int ix, float dx, float dy, float *x, float *y);

/// @brief The tile at a point near a sprite, in the layer the sprite belongs to (layer space) or is drawn over (screen
/// space) - e.g. (0, height/2) is just under its feet, (-width/2-1, 0) just to its left
/// @param dx,dy Offset from the sprite's centre, in its own pixels - scaled and rotated as the sprite is drawn, so the
/// point turns with it
/// @param tileX,tileY If not NULL, set to the tile's position in the tile map
/// @return The tile number, or -1 if there's none (for screen space sprites, if the point is off screen). For layer
/// space sprites this is a direct tile map lookup (fast, however the layer is rotated, and works off screen too)
int getSpriteTileAt(int ix, float dx, float dy, int *tileX, int *tileY);

/// @brief True if the tile graphics have a pixel set at a point near a sprite (see getSpriteTileAt) - a pixel accurate
/// check for floors and walls, including slopes
bool isSpritePointSolid(int ix, float dx, float dy);

/// @brief getSpriteTileAt for a whole pixel offset - the fast route for gameplay checks (feet, walls). When the sprite
/// isn't rotated or scaled itself (and, in layer space, turns with its layer or the layer isn't transformed), there's no
/// float maths beyond one floor of its position: just an add and the tile lookup. Otherwise it's getSpriteTileAt
int getSpriteTileAtI(int ix, int dx, int dy, int *tileX, int *tileY);

/// @brief isSpritePointSolid for a whole pixel offset - fast in the same cases as getSpriteTileAtI
bool isSpritePointSolidI(int ix, int dx, int dy);

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
    if(s->space==SPRITE_SPACE_LAYER){
        placeSprite(s);
    }
}

static inline void setSpriteDir(int ix, float xDir, float yDir)
{
    Sprite *s=spriteList+ix;
    s->xDir=xDir;
    s->yDir=yDir;
}

/// @brief Set a sprite's position (its centre) - in screen coordinates, or for a layer space sprite, the layer's
static inline void setSpritePos(int ix, float x, float y)
{
    Sprite *s=spriteList+ix;
    s->xF=x;
    s->yF=y;
    if(s->space==SPRITE_SPACE_LAYER){
        placeSprite(s);
        return;
    }
    s->x=x;
    s->y=y;
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
