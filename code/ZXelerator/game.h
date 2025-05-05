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
#include "engine/bitmapData.h"
#include "engine/palette.h"
#include "engine/Sprite.h"
#include "engine/TileLayer.h"
#include "engine/Compositor.h"
#include "engine/inputDevice.h"
#include "engine/funcs.h"
#include "gameFunc.h"

extern GameVar gv;

/// @brief Perform initialisation and start the main game code loop (or test code loop)
void gameLoop(void);

/// @brief Runs continuously at 25fps - should never exit.
/// @param  
void gameUpdateLoop(void);

void setState(GameState newGS);
void resetStateVars();

/// @brief Set a single attribute block to a new color
/// @param ix The index of the block in the attribute table (note, 32x48 colour resolution)
/// @param v The new colour (FBIIIPPP)
void setAttrDirect(int ix, uint8_t v);

void setDispDirect(int ix, uint8_t v);

void safeBankBlit(int dstBankIX, const uint8_t *srcBank);
