#include "shared.h"

MemoryBank ram[2];
uint32_t readBank=0, writeBank=1;
volatile uint32_t frameDrawn=0;
volatile int flipBank=0;
volatile int frameComplete=0;
volatile int core0_needs_access=0;
