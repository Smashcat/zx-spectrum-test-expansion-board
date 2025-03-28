#pragma once

#include <stdint.h>

typedef union MemoryBank {

    // For changing individual screen elements
    uint8_t  memory8[2][16384] __attribute__((aligned(4)));

    // For block blitting into other banks
    uint32_t memory32[(16384*2)/4] __attribute__((aligned(4)));

} MemoryBank;

typedef enum GameState {
    GS_idle,
    GS_title,
    GS_demo,
    GS_levelStart,
    GS_playing,
    GS_lostLife,
    GS_gameOver
} GameState;

typedef struct GameVar {
    int32_t iv;
    int32_t iw;
    int32_t ix;
    int32_t iy;
    int32_t iz;
} GameVar;