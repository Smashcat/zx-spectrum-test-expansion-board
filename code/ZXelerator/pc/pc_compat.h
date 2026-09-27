#pragma once

// Force-included into every source file when building the PC emulator

// M_PI etc. from math.h
#define _USE_MATH_DEFINES

// Allow standard C functions such as sprintf without MSVC deprecation warnings
#define _CRT_SECURE_NO_WARNINGS

#if defined(_MSC_VER) && !defined(__clang__)
// MSVC has no GCC attributes - only used for alignment hints, which x86 doesn't need
#define __attribute__(x)
#endif
