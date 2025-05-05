
#include "pico/multicore.h"
#include "engine/funcs.h"
#include "game.h"

#include "pico/stdlib.h"
#include "hardware/clocks.h"
#include "hardware/pll.h"
#include "hardware/vreg.h"


int main() {
    
    setupIO();
    setupPIO();
    sleep_ms(1200);
    multicore_reset_core1();
    multicore_launch_core1(handleZ80Read);
    gameLoop();
    return 0;
}        
