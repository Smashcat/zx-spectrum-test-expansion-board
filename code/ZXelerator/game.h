#pragma once 

#include <stdint.h>
#include <stdbool.h>
#include <math.h>

#include "hardware/sync.h"
#include "hardware/dma.h"

#include "defs.h"
#include "displayMemoryOffsets.h"
#include "resetData.h"
#include "myTypes.h"
#include "shared.h"
#include "tileDefs.h"
#include "Sprite.h"
#include "TileLayer.h"
#include "Compositor.h"
#include "funcs.h"


void gameLoop(void);
void setState(GameState newGS);
void resetStateVars();

/// @brief Set a single attribute block to a new color
/// @param ix The index of the block in the attribute table (note, 32x48 colour resolution)
/// @param v The new colour (FBIIIPPP)
void setAttrDirect(int ix, uint8_t v);

void setDispDirect(int ix, uint8_t v);

void safeBankBlit(int dstBankIX, const uint8_t *srcBank);
