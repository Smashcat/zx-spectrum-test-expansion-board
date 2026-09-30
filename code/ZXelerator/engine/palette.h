#pragma once

#include <stdint.h>

/// @brief How many palettes there are (keep in step with palette.c)
#define PALETTE_COUNT 12

extern const uint8_t palette[PALETTE_COUNT][10];