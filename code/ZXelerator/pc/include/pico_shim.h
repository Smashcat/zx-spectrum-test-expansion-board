#pragma once

// Minimal stand-ins for the parts of the Pico SDK used by the engine/game code,
// so it can be built for the PC emulator (see pc/pc_main.c)

#include <stdint.h>
#include <stdbool.h>

typedef unsigned int uint;

#define GPIO_IN     false
#define GPIO_OUT    true

#define __not_in_flash_func(func_name) func_name
#define __no_inline_not_in_flash_func(func_name) func_name

static inline void gpio_init(uint gpio) { (void)gpio; }
static inline void gpio_set_dir(uint gpio, bool out) { (void)gpio; (void)out; }
static inline void gpio_put(uint gpio, bool value) { (void)gpio; (void)value; }
static inline bool gpio_get(uint gpio) { (void)gpio; return true; }

void sleep_ms(uint32_t ms);
void busy_wait_ms(uint32_t ms);
void busy_wait_us_32(uint32_t us);
uint64_t time_us_64(void);

// On the RP2350, core1 sleeps in __wfe() until core0 signals the start of the next
// Spectrum frame. On the PC this is where the frame is displayed, input is read and
// we wait for the next 25fps tick
void pc_waitForFrame(void);

#define __wfe() pc_waitForFrame()
#define __sev() ((void)0)
#define __dsb() ((void)0)
#define __dmb() ((void)0)
#define __isb() ((void)0)
