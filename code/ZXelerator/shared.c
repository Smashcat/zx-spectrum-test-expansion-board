#include "shared.h"

MemoryBank ram[2] __attribute__((aligned(4)));
volatile uint32_t readBank=0, writeBank=1;
volatile uint32_t frameDisplayed=0;
volatile int flipBank=0;
volatile int writeOK=0;
uint8_t keyboardScan[8]={0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
volatile int eroneousAddr=0;
volatile uint8_t vRam[32768];