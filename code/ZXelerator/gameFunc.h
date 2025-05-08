#pragma once 

#include <stdint.h>
#include <stdbool.h>
#include <math.h>

#include "hardware/sync.h"
#include "hardware/dma.h"

#include "engine/defs.h"
#include "engine/displayMemoryOffsets.h"
#include "engine/resetData.h"
#include "engine/myTypes.h"
#include "engine/shared.h"
#include "engine/tileDefs.h"
#include "engine/palette.h"
#include "engine/Sprite.h"
#include "engine/TileLayer.h"
#include "engine/Compositor.h"
#include "engine/inputDevice.h"
#include "engine/funcs.h"

#include "gameStrings.h"
#include "game.h"

/// @brief Just a piece of test code to check rendering is working.
/// @param  
void demoLoop(void);
void gameTitle(void);

/// @brief Draw large font characters (8x16) to tilemap
/// @param layerIX The layer index to draw to
/// @param s The string (note only alphanumeric chars available and limited punctuation)
/// @param colors 
/// @param x 
/// @param y 
void drawBigTxtToLayer(int layerIX, const char *s, const uint8_t *colors, int x, int y);
