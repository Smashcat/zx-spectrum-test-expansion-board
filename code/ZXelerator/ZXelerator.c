
#include "pico/multicore.h"
#include "funcs.h"
#include "game.h"

void main() {
    setupIO();
    multicore_reset_core1();
    multicore_launch_core1(gameLoop);
    handleZ80Read();
}        
