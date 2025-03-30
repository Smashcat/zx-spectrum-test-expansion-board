#pragma once

#include <stdint.h>
#include "shared.h"
#include "displayMemoryOffsets.h"
#include "spriteDefs.h"

typedef struct Sprite {
    int16_t     x;
    int16_t     y;
    int16_t     defIX;
    uint16_t    groupBits;
    uint16_t    collideGroupBits;
    uint16_t    layer;
    float       xF;
    float       yF;
    float       xDir;
    float       yDir;
} Sprite;

void drawSprite(Sprite s);