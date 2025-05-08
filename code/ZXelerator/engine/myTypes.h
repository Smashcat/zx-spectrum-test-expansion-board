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
    uint32_t frameRendered;
    int32_t iu;
    int32_t iv;
    int32_t iw;
    int32_t ix;
    int32_t iy;
    int32_t iz;
    int storyTextSectionIX;
    int storyTextNextSectionAtLineIX;
    int storyTextCurrentLineIX;
    int storyTextCurrentSubLineIX;
    int storyScrollCDStartLine;
    int storyScrollCD;

} GameVar;

typedef struct StoryEntry{
    const char title[16];
    const char body[512];
} StoryEntry;