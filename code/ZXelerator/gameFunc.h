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

#include "game.h"

/// @brief Just a piece of test code to check rendering is working.
/// @param  
void demoLoop(void);
void gameTitle(void);