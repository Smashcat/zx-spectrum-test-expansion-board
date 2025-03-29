
#include "pico/multicore.h"
#include "funcs.h"
#include "game.h"

void main() {
    setupIO();
    setupPIO();
    sleep_ms(1200);
    multicore_reset_core1();
    multicore_launch_core1(handleZ80Read);
    gameLoop();
    
}        
