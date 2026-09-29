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
#include "engine/audio.h"
#include "engine/synth.h"
#include "engine/funcs.h"

#include "gameStrings.h"
#include "game.h"

/// @brief Just a piece of test code to check rendering is working.
/// @param  
void demoLoop(void);
void gameTitle(void);

/// @brief Set up the Mode 7 test scene (press M on the title screen): a perspective floor, wrapping sky and
/// rotating/scaling sprites
void setupMode7Test(void);

/// @brief Per-frame update of the Mode 7 test scene. O/P turn, Q/A speed, W/S camera height, SPACE returns to the title
void mode7Test(void);

/// @brief Set up the audio test (press T on the title screen), which plays a single note, a chord, a low note,
/// then a short 3 part tune on the beeper, looping. SPACE returns to the title
void setupAudioTest(void);

/// @brief Per-frame update of the audio test
void audioTest(void);

/// @brief Set up the collision test (press C on the title screen): a tile layer with floors, walls, slopes and bumps, a
/// fountain of particles bouncing off it, bouncing bubbles, and a player sprite (QAOP) that shows what it hits
void setupCollisionTest(void);

/// @brief Per-frame update of the collision test. SPACE returns to the title
void collisionTest(void);

/// @brief Draw large font characters (8x16) to tilemap
/// @param layerIX The layer index to draw to
/// @param s The string (note only alphanumeric chars available and limited punctuation)
/// @param colors 
/// @param x 
/// @param y 
void drawBigTxtToLayer(int layerIX, const char *s, const uint8_t *colors, int x, int y);
