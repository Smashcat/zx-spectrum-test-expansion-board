#pragma once 

#include <stdint.h>
#include "defs.h"
#include "myTypes.h"

extern MemoryBank ram[2];
extern volatile uint32_t readBank, writeBank;
extern volatile uint32_t frameDisplayed;
extern volatile int flipBank;
extern volatile int writeOK;
extern uint8_t keyboardScan[8];
extern volatile int eroneousAddr;
extern volatile uint8_t vRam[32768];