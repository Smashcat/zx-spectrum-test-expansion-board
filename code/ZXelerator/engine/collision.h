#pragma once

#include <stdint.h>
#include <stdbool.h>
#include "defs.h"
#include "Sprite.h"
#include "TileLayer.h"

// Pixel accurate collision detection for sprites (see setSpriteCollisions in Sprite.h). Sprites are tested with their
// pixels as drawn - scaled and rotated sprites included - against other sprites' pixels, and the tile pixels of the
// tile layer drawn just before them (the layer they're drawn over). Masks aren't used, so only set pixels collide.
// Only what's on screen is tested.

/// @brief Most sprites with collision flags that are tested each frame (any more are skipped)
#define MAX_COLLIDING_SPRITES   128

/// @brief Sprite pairs considered in the last detectCollisions (their areas checked, and pixels if they overlap) - handy
/// for seeing the effect of the collision flags on performance
extern uint32_t collisionPairsTested;

/// @brief Find the collisions of every sprite that has collision flags, filling in their spriteHits and tileHits.
/// Called by compositeScene once the frame is drawn, so the results match what's on screen
void detectCollisions(void);

/// @brief A sprite's pixels (not its mask) as drawn at screen pixels x to x+31 on screen line y
/// @return 32 pixels, screen pixel x in bit 31. Zero where the sprite isn't drawn
uint32_t getSpritePixels32(const Sprite *s, int x, int y);
