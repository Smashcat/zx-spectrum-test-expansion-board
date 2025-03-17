// Versions
// v0.1 initial release taken form PicoIF2ROM but with interrupt drive user button
// v0.2 changes to improve ZXC compatibility, added zxcOn true/false
// v0.3 Z80/SNA snapshot support, zxcOn->compatMode
// v0.4 fixed issue with not loading correctly on earlier Spectrums, needed i register setting at 0x80
// v0.5 big ZX Spectrum machine code refactoring, LED matches ROMCS on/off, attempt to fix crash on reset
// v0.6 simplified ROM includes, added header to each ROM to replace romName & compatMode 
//
#define PROG_NAME   "ZXelerator"
#define VERSION_NUM "v0.1"
// ---------------------------------------------------------------------------
// includes
// ---------------------------------------------------------------------------
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "pico/stdlib.h"
#include "hardware/pio.h"
#include "ZXelerator.pio.h"
//#include "picoif2lite.h"   // header
//#include "picoif2lite_jh.h"   // header
#include "ZXelerator.h"   // header (lite version for GitHub)
// ---------------------------------------------------------------------------
// gpio pins
// ---------------------------------------------------------------------------
#define PIN_A0      0   // GPIO 0-13 for A0-A13
#define PIN_D0      14  // GPIO 14-21 for D0-D7
#define PIN_LED     25  // Default LED pin for Pico (not W)
//                  3         2         1   
//                 10987654321098765432109876543210
#define MASK_LED 0b00000010000000000000000000000000

//
#define PIN_RESET   28  // GPIO to control RESET of Spectrum 
#define PIN_USER    22  // User input GPIO (v1.1 PCB this is 22)
#define PIN_ROMRQ   26  // ROM Request
#define PIN_ROMCS   27  // ROMCS
//
#define poMask   0b0011111111010000
#define poMaskn  0b0011111111000000
#define lkMask   0b0011111111100000
#define bkMask   0b0000000000001111

PIO pio;
uint addr_data_sm;
uint32_t bank1SwapCnt=0;
uint32_t currentBank=0;

//
//void dtoBuffer(uint8_t *to,const uint8_t *from);
//uint16_t simplelz(uint8_t* fload,uint8_t* store,uint16_t filesize);
void resetButton(uint gpio,uint32_t events);
//
void main() {
    // -------------------------------
    // set-up user, romcs & reset gpio
    // -------------------------------
    gpio_init(PIN_RESET);
    gpio_set_dir(PIN_RESET,GPIO_OUT);
    gpio_put(PIN_RESET,false);    // hold in RESET state till ready
    //
    gpio_init(PIN_USER);
    gpio_set_dir(PIN_USER,GPIO_IN);
    gpio_pull_up(PIN_USER); // button active when connected to ground
    gpio_set_irq_enabled_with_callback(PIN_USER,GPIO_IRQ_EDGE_FALL,true,&resetButton);  // when user button pressed, interrupt code annd run resetButton routine
    //
    gpio_init(PIN_ROMCS);
    gpio_set_dir(PIN_ROMCS,GPIO_OUT);
    gpio_put(PIN_ROMCS,false);    // start with ROM off  
    //
    gpio_init(PIN_LED);
    gpio_set_dir(PIN_LED,GPIO_OUT);
    gpio_put(PIN_LED,false);
    // ----------
    // Set-up PIO
    // ----------
    pio=pio0; // use pio 0
    addr_data_sm=pio_claim_unused_sm(pio,true); // grab an free state machine from PIO 0
    uint addr_data_offset=pio_add_program(pio,&picoif2_program); // get instruction memory offset for the loaded program
    pio_sm_config addr_data_config=picoif2_program_get_default_config(addr_data_offset); // get the default state machine config
    // set-up IN pins
    for(uint i=PIN_A0;i<PIN_A0+14;i++) {
        pio_gpio_init(pio,i); // initialise all 14 input pins 
    }    
    pio_sm_set_consecutive_pindirs(pio,addr_data_sm,PIN_A0,14,false); // input
    sm_config_set_in_pins(&addr_data_config,PIN_A0); // set IN pin base
    sm_config_set_in_shift(&addr_data_config,false,true,14); // shift left 14 pins (A13-A0) into ISR, autopush resultant 32bit address to DMA RXF
    pio_gpio_init(pio,PIN_ROMRQ);
    pio_sm_set_consecutive_pindirs(pio,addr_data_sm,PIN_ROMRQ,1,false); // input
    // set-up OUT data pins
    for(uint i=PIN_D0;i<PIN_D0+8;i++) {
        pio_gpio_init(pio,i); // initialise all 8 output pins
    }
    sm_config_set_out_pins(&addr_data_config,PIN_D0,8); // set OUT pin base & number (bits)
    sm_config_set_out_shift(&addr_data_config,true,true,8); // right shift 8 bits of OSR to pins (D0-D7) with autopull on
    pio_sm_set_consecutive_pindirs(pio,addr_data_sm,PIN_D0,8,true); // set all output pins to output, D0-D7
    pio_sm_init(pio,addr_data_sm,addr_data_offset,&addr_data_config); // reset state machine and configure it
    // start PIO state machine
    pio_sm_set_enabled(pio,addr_data_sm,true); // enable state machine   
    busy_wait_us_32(50000);       // wait 50ms before lifting RESET          
    gpio_put(PIN_RESET,true);    // release RESET    
    // loop forever
    uint32_t address;
    uint32_t c;
    while(true) {
        address=pio_sm_get_blocking(pio,addr_data_sm);
//        pio_sm_put_blocking(pio,addr_data_sm,bank1[address+adder]); // if ROMCS off then direction of Data chip is input so they do not interfere
        pio_sm_put_blocking(pio,addr_data_sm,bank[currentBank][address]); // if ROMCS off then direction of Data chip is input so they do not interfere
        // z80 routine
        if(address==0x3fff) {       // Z80 is about to send scan codes from keys

        }else if(address==0x3ffe){  // Z80 is about to read the first bank, for the bottom half of the screen
            currentBank=0;
            gpio_put(PIN_LED,true);
        }else if(address==0x3ffd){  // Z80 is about to read the second bank, for the bottom half of the screen
            bank1SwapCnt=4; // We allow 3 more memory reads before swapping the bank, so the Z80 can read in the jump instruction following the request to swap banks
        }
        if(bank1SwapCnt>0){
            if(--bank1SwapCnt==0){
                currentBank=1;
                gpio_put(PIN_LED,false);
            }
        }
    }
}        
//
// ---------------------------------------------------------------------------
// resetButton - interrupt driven routine when user button pressed
// input:
//   gpio - which gpio called this routine
//   events - the compressed storage
// ---------------------------------------------------------------------------
void resetButton(uint gpio,uint32_t events) {
    uint32_t address;         
    busy_wait_us_32(100000);    // litle wait to help with button bounce
    gpio_put(PIN_RESET,false); // put Spectrum in RESET state                      
    // wait for button release and check held for 1second to switch ROM otherwise just reset
    uint64_t lastPing=time_us_64();        
    do {
        busy_wait_us_32(100000); // wait 100ms between each read, minimum 200ms wait on each press
    } while((gpio_get(PIN_USER)==false)&&(time_us_64()<lastPing+1000000));
    // button pressed for >=1second?
    if(time_us_64()>=lastPing+1000000) {                                              
        gpio_put(PIN_ROMCS,true);     // turn on ROMCS  
        gpio_put(PIN_LED,true);          
    }
    busy_wait_us_32(100000);    // wait 100ms before lifting RESET       
    gpio_put(PIN_RESET,true);   // lift reset    
}
