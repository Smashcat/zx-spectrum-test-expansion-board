#pragma once

#include <stdint.h>

typedef enum GameState {
    GS_idle,
    GS_title,
    GS_demo,
    GS_levelStart,
    GS_playing,
    GS_lostLife,
    GS_gameOver,
    GS_mode7Test,
    GS_audioTest,
    GS_collisionTest
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
    // Microseconds the last frame took, from the start of the game code to the end of compositing (the frame is 40ms)
    uint32_t frameTimeUs;

} GameVar;

typedef struct StoryEntry{
    const char title[16];
    const char body[512];
} StoryEntry;