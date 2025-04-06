#pragma once

#include <stdint.h>

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