#pragma once

#define PROG_NAME   "ZXelerator"
#define VERSION_NUM "v0.1"

// ---------------------------------------------------------------------------
// gpio pins
// ---------------------------------------------------------------------------
#define PIN_A0      0   // GPIO 0-13 for A0-A13
#define PIN_D0      14  // GPIO 14-21 for D0-D7
#define PIN_LED     25  // Default LED pin for Pico (not W)
//                  3         2         1   
//                 10987654321098765432109876543210
#define MASK_LED 0b00000010000000000000000000000000

//
#define PIN_RESET   28  // GPIO to control RESET of Spectrum 
#define PIN_USER    22  // User input GPIO (v1.1 PCB this is 22)
#define PIN_ROMRQ   26  // ROM Request
#define PIN_ROMCS   27  // ROMCS
//
#define poMask   0b0011111111010000
#define poMaskn  0b0011111111000000
#define lkMask   0b0011111111100000
#define bkMask   0b0000000000001111

#define SCREEN_WIDTH_CELLS      32
#define SCREEN_HEIGHT_CELLS     24

#define MAX_TILE_LAYERS         4
#define TILE_LAYER_WIDTH        64
#define TILE_LAYER_HEIGHT       64
#define TILE_LAYER_ATTR_HEIGHT  128