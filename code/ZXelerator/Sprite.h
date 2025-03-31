#pragma once

#include <stdint.h>
#include "shared.h"
#include "displayMemoryOffsets.h"
#include "spriteDefs.h"

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
    // Tile layer this sprite appears over (-1=sprite not shown, 0=appears over back-most layer, 1=appears over layer 1, 2=appears over layer 2)
    int16_t    layer;
    // Float position in X axis
    float       xF;
    // Float position in Y axis
    float       yF;
    // Float velocity in X axis (added to xF, which then updates x each frame, if not zero)
    float       xDir;
    // Float velocity in Y axis (added to yF, which then updates y each frame, if not zero)
    float       yDir;
} Sprite;

void drawSprite(Sprite s);