#pragma once

#include <stdbool.h>

/// @brief Open the audio device, and optionally start recording to a WAV file
void pcAudioInit(bool startMuted, const char *wavPath);

void pcAudioShutdown(void);

/// @return True if now muted
bool pcAudioToggleMute(void);

/// @brief Generate and queue the audio for one frame from the beeper OUT lists in the given ASM bank
void pcAudioFrame(int bankIX);
