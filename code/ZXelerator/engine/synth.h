#pragma once

#include <stdint.h>
#include <stdbool.h>
#include "audio.h"

// Simple 3 voice square wave synth for the beeper, filling the ASM template's OUT lists (see audio.h).
//
// The voices are mixed by time-division: each OUT plays the next active voice in turn, so with the OUT rate of
// ~291.7kHz each of 3 voices is still sampled at ~97kHz. Each sample is calculated at the exact T-state its OUT
// runs, and each voice's phase keeps running between frames, so notes stay in tune across the gaps between lists.

#define SYNTH_VOICES    3

/// @brief Silence all voices and reset their phase
void synthInit(void);

/// @brief Set a voice's frequency
/// @param voice 0 to SYNTH_VOICES-1
/// @param hz Frequency in Hz, 0 for silence
void synthSetFrequency(int voice, float hz);

/// @brief Set a voice to a MIDI note number (60 = middle C, 69 = A 440Hz)
/// @param voice 0 to SYNTH_VOICES-1
/// @param note MIDI note number, 0 for silence
void synthSetNote(int voice, int note);

/// @brief Fill the OUT lists of the frame being generated (the write bank) - call once per frame
void synthRender(void);
