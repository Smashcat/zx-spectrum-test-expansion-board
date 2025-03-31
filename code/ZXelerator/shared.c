#include "shared.h"

uint8_t keyboardScan[8] __attribute__((aligned(4))) = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
volatile uint32_t readBank=0, writeBank=1;
volatile uint32_t frameDisplayed=0;
volatile int flipBank=0;
volatile int writeOK=0;
volatile int eroneousAddr=0;
uint8_t ram[3][2][0x2f00] __attribute__((aligned(0x20000)));
uint8_t scratchPixRam[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_CELLS*8] __attribute__((aligned(4)));
uint8_t scratchMaskRam[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_CELLS*8] __attribute__((aligned(4)));
