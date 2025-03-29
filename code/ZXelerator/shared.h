#pragma once 

#include <stdint.h>
#include "defs.h"
#include "myTypes.h"

extern uint8_t ram[3][2][0x2f00] __attribute__((aligned(4)));
extern volatile uint32_t readBank, writeBank;
extern volatile uint32_t frameDisplayed;
extern volatile int flipBank;
extern volatile int writeOK;
extern uint8_t keyboardScan[8] __attribute__((aligned(4)));
extern volatile int eroneousAddr;
//extern uint8_t vRam[32768] __attribute__((aligned(4)));