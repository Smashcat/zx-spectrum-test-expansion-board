#pragma once

#define IF2_BOARD            1

#define PROG_NAME   "ZXelerator"
#define VERSION_NUM "v0.1"

#define TOTAL_RAMBANKS          2
#define MAX_TILE_LAYERS         5
#define MAX_PARTICLES           1000
#define MAX_SPRITES             500
#define MAX_FALL_SPEED          6.0
// RAM for the level being played (engine/level.c): its tile sets (4KB each) and unpacked tile layers, e.g. a 256x256 tile
// layer is 64KB. The level converter reports what each level needs
#define LEVEL_RAM_SIZE          (128*1024)
// What's remembered about every level (a byte per persistent object - switches, keys etc), for the whole game
#define LEVEL_STATE_SIZE        2048

// ---------------------------------------------------------------------------
// gpio pins
// ---------------------------------------------------------------------------
#define PIN_A0      0   // GPIO 0-13 for A0-A13
#define PIN_D0      14  // GPIO 14-21 for D0-D7
#ifdef IF2_BOARD
#define PIN_LED     22
#else
#define PIN_LED     25  // Default LED pin for Pico (not W) - was (25 on breadboard) (22 on PCB)
#endif
//                  3         2         1   
//                 10987654321098765432109876543210
#define MASK_LED 0b00000010000000000000000000000000

//
#ifdef IF2_BOARD
#define PIN_RESET   29
#else
#define PIN_RESET   28  // GPIO to control RESET of Spectrum - 28 on breadboard (29 on PCB)
#endif

#define PIN_USER    22  // User input GPIO (v1.1 PCB this is 22) - no longer used
#define PIN_ROMRQ   26  // ROM Request
#define PIN_ROMCS   27  // ROMCS
//
#define poMask   0b0011111111010000
#define poMaskn  0b0011111111000000
#define lkMask   0b0011111111100000
#define bkMask   0b0000000000001111

#define SCREEN_WIDTH_CELLS      32
#define SCREEN_HEIGHT_CELLS     24
#define SCREEN_WIDTH_PIXELS     (SCREEN_WIDTH_CELLS*8)
#define SCREEN_HEIGHT_LINES     (SCREEN_HEIGHT_CELLS*8)
#define ATTR_HEIGHT_PIXELS      4
#define ATTR_HEIGHT_CELLS       (SCREEN_HEIGHT_LINES/ATTR_HEIGHT_PIXELS)

#define TILE_LAYER_WIDTH        64
#define TILE_LAYER_HEIGHT       64
#define TILE_LAYER_ATTR_HEIGHT  (TILE_LAYER_HEIGHT*2)