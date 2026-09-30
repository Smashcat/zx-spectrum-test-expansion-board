#pragma once

#include <stdint.h>

/// @brief Unpack data packed by the level converter (pc/tools/lzPack.c). The format is LZ77, byte aligned (like LZ4):
/// a run of sequences, each a token byte - literal count in the high nibble, match length-4 in the low nibble (15 in
/// either means more bytes follow, each added until one is under 255) - then the literals, then (unless the output is
/// complete) a 16 bit little endian offset back into the output (1-65535) and any extra match length bytes. Matches
/// can overlap the bytes they copy, so runs of a byte (or a pattern) cost a few bytes
/// @param src Packed data
/// @param srcSize Packed size in bytes
/// @param dst Where to unpack to
/// @param dstSize The unpacked size (the packed data doesn't store it)
/// @return dstSize if the data unpacked correctly, or -1 if it's corrupt (runs off either end, or refers back before
/// the start)
int lzUnpack(const uint8_t *src, int srcSize, uint8_t *dst, int dstSize);
