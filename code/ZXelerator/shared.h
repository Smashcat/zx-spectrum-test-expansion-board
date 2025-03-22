#pragma once 
#include <stdint.h>
#include "defs.h"
#include "myTypes.h"

extern MemoryBank ram[2];
extern uint32_t readBank, writeBank;
extern volatile uint32_t frameDrawn;
extern volatile int flipBank;
extern volatile int frameComplete;
extern volatile int core0_needs_access;
