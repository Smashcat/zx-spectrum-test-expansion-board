#pragma once

#include <stdbool.h>
#include <stdint.h>

// Records the emulator's display and beeper audio to an AVI file, one video frame per game frame - so the video is
// exactly 25fps whatever speed the emulator runs at (including fast forward and frame stepping).
// Video is uncompressed 24 bit RGB (pixel exact, and plays/edits almost anywhere), audio is 48kHz 16 bit mono PCM.
// Files are split into parts of about 1GB, as many AVI readers can't handle more.

/// @brief Start recording
/// @param path File to write (.avi). Further parts, if needed, get _part2, _part3 etc. added to the name
/// @param scale Pixel scale, 1 = the native 320x256 (screen and border)
/// @return False if the file couldn't be created
bool pcVideoStart(const char *path, int scale);

/// @brief Add one frame
/// @param screen The 256x192 display, as 0xAARRGGBB
/// @param border Border colour, as 0xAARRGGBB
/// @param samples This frame's audio samples
/// @param numSamples Number of audio samples
void pcVideoFrame(const uint32_t *screen, uint32_t border, const int16_t *samples, int numSamples);

/// @brief Finish the file (writes the index and header sizes). Safe to call when not recording
void pcVideoStop(void);

bool pcVideoRecording(void);
