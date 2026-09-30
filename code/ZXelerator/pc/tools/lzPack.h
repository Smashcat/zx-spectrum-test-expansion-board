#pragma once

#include <stdint.h>

/// @brief The most lzPack can write for n bytes of input (when nothing repeats)
#define LZ_PACK_BOUND(n) ((n)+((n)/255)+16)

/// @brief Pack data for lzUnpack (engine/lzUnpack.h, which describes the format). Matches are chosen for the smallest
/// output (an optimal parse over hash chain matches), so packing is slower than unpacking - it's done once, by the
/// level converter
/// @param src Data to pack
/// @param n Its size in bytes
/// @param dst Output, at least LZ_PACK_BOUND(n) bytes
/// @return The packed size
int lzPack(const uint8_t *src, int n, uint8_t *dst);
