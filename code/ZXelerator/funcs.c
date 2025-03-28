
#include "funcs.h"
#include "resetData.h"

PIO pio;
uint addr_data_sm;

void setupIO(void){
        // -------------------------------
    // set-up user, romcs & reset gpio
    // -------------------------------
    gpio_init(PIN_RESET);
    gpio_set_dir(PIN_RESET,GPIO_OUT);
    gpio_put(PIN_RESET,false);    // initially not in RESET, as we need to wait for at least one memory access so that the PIO will work correctly
    //
    gpio_init(PIN_USER);
    gpio_set_dir(PIN_USER,GPIO_OUT);
    gpio_put(PIN_USER,true); // button active when connected to ground
    gpio_set_irq_enabled_with_callback(PIN_USER,GPIO_IRQ_EDGE_FALL,true,&resetButton);  // when user button pressed, interrupt code and run resetButton routine
    //
    gpio_init(PIN_ROMCS);
    gpio_set_dir(PIN_ROMCS,GPIO_OUT);
    gpio_put(PIN_ROMCS,false);    // start with ROM off  
    //
    gpio_init(PIN_LED);
    gpio_set_dir(PIN_LED,GPIO_OUT);
    gpio_put(PIN_LED,false);

    // Initialise the ASM data banks
    copyBank(&ram[readBank],&resetBank);
    copyBank(&ram[writeBank],&resetBank);
}

void setupPIO(void){
    // Set-up PIO
    pio=pio0;                                                           // use pio 0
    addr_data_sm=pio_claim_unused_sm(pio,true);                         // grab a free state machine from PIO 0
    uint addr_data_offset=pio_add_program(pio,&picoif2_program);        // get instruction memory offset for the loaded program
    pio_sm_config addr_data_config=picoif2_program_get_default_config(addr_data_offset); // get the default state machine config

    // set-up IN pins
    for(uint i=PIN_A0;i<PIN_A0+14;i++) {
        pio_gpio_init(pio,i);                                           // initialise all 14 input pins 
    }    
    pio_sm_set_consecutive_pindirs(pio,addr_data_sm,PIN_A0,14,false);   // input
    sm_config_set_in_pins(&addr_data_config,PIN_A0);                    // set IN pin base
    sm_config_set_in_shift(&addr_data_config,false,true,14);            // shift left 14 pins (A13-A0) into ISR, autopush resultant 32bit address to DMA RXF

    // set-up /ROMRQ pin
    pio_gpio_init(pio,PIN_ROMRQ);                                       // ROMRQ (OR of A14,A15 and /MREQ lines) When this switches to LOW it triggers the address line input DMA transfer
    pio_sm_set_consecutive_pindirs(pio,addr_data_sm,PIN_ROMRQ,1,false); // input
    
    // set-up OUT pins
    for(uint i=PIN_D0;i<PIN_D0+8;i++) {                                 // set-up OUT data pins
        pio_gpio_init(pio,i);                                           // initialise all 8 output pins
    }
    sm_config_set_out_pins(&addr_data_config,PIN_D0,8);                 // set OUT pin base & number (bits)
    sm_config_set_out_shift(&addr_data_config,true,true,8);             // right shift 8 bits of OSR to pins (D0-D7) with autopull on
    pio_sm_set_consecutive_pindirs(pio,addr_data_sm,PIN_D0,8,true);     // set all output pins to output, D0-D7
    pio_sm_init(pio,addr_data_sm,addr_data_offset,&addr_data_config);   // reset state machine and configure it

    // start PIO state machine
    pio_sm_set_enabled(pio,addr_data_sm,true);                          // enable state machine       
}

void releaseReset(void){
    busy_wait_us_32(50000);      // wait 50ms before lifting RESET          
    gpio_put(PIN_RESET,true);    // release RESET    
}

/* Remember, DEBUG settings are on!!!! */
void handleZ80Read(void){
    uint32_t bank1SwapCnt=0;
    uint32_t keyScanCnt=0;
    uint32_t currentSubBank=0;
    uint32_t totalFlips=0;
    const uint8_t *readPtr=ram[readBank].memory8[currentSubBank];
    
    // We are not holding the spectrum in RESET at this point, and the ROM is disabled, so populate at least one byte so the output buffer will work correctly!
    // In the Interface 2 cart, we will not be able to control RESET, so we wait for address 0x38 (ULA interrupt), switch in the ROM, and return NOPs then JP 0
    //for(uint8_t n=0;n<3;n++){
    //    pio_sm_get_blocking(pio,addr_data_sm);
    //    pio_sm_put_blocking(pio,addr_data_sm,n);                         // Output a NOP - won't actually be used as we RESET the Z80 just after this
    //}
    enableROMOutput();
    gpio_put(PIN_RESET,true);   // lift reset
    while(true){
        writeOK=0;
        uint32_t address=pio_sm_get_blocking(pio,addr_data_sm);
        pio_sm_put_blocking(pio,addr_data_sm,*(readPtr+address)); // if ROMCS off then direction of Data chip is input so they do not interfere
        writeOK=1;
        if((address==0x3fff) && (keyScanCnt==0)) {       // Z80 is about to send 8 scan codes from keys
            keyScanCnt=8;

        // When sending keyboard scan codes, the high byte of the address will be 0x3f, and the low byte will be the data
        }else if(keyScanCnt>0){
            
            if((address>>8)==0x3f){
                --keyScanCnt;
                keyboardScan[keyScanCnt]=(uint8_t)(address&0xff);
            }

        // Z80 is about to read the first bank, for the top half of the screen (chasing the beam) - this is just before the halt instruction, so there is plenty of time to flip buffers
        }else if(address==0x3ffe){  

            currentSubBank=0;
            if(flipBank){
                if(readBank==0){
                    readBank=1;
                    writeBank=0;
                }else{
                    readBank=0;
                    writeBank=1;
                }
                ++totalFlips;
            }
            readPtr=ram[readBank].memory8[currentSubBank];
            ++frameDisplayed;
            flipBank=0;
            __dsb();   // Ensure write completes before waking other core
            __sev();   // Send event to wake core1 out of __wfe()

        // Z80 is about to read the second bank, for the bottom half of the screen (racing the beam)
        }else if(address==0x3ffd){  
            bank1SwapCnt=3; // We allow 3 more memory reads before swapping the bank, so the Z80 can read in the jump instruction following the request to swap banks
        }else if(bank1SwapCnt>0){
            if(--bank1SwapCnt==0){
                currentSubBank=1;
                readPtr=ram[readBank].memory8[currentSubBank];
            }
        }else if(address>0xffff){
            break;
        }

    }
    eroneousAddr=1;
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

void enableROMOutput(void){
//    gpio_put(PIN_RESET,true);   // release reset    
//    busy_wait_ms(2800);    // wait 1000ms before lifting RESET           
    gpio_put(PIN_RESET,false);   // set reset    
    gpio_put(PIN_ROMCS,true);   // turn on ROMCS  
    busy_wait_ms(800);    // wait 1000ms before lifting RESET           
}

void copyBank(MemoryBank *dest, const MemoryBank *src){
    /*
    for(int n=0;n<2;n++){
        for(int i=0;i<16384;i++){
            dest->memory8[n][i]=src->memory8[n][i];
        }
    }
    */
    memcpy(dest->memory32, src->memory32, sizeof(src->memory32));
}

/// @brief Copy a block to the write buffer in a safe way by waiting till an address read from Z80, then copying 2048 bytes, until all 32k copied to ensure there is no conflict
/// @param dest 
/// @param src 
/// @param seg 
void copyBankSafe(MemoryBank *dest, const MemoryBank *src){

    while(!writeOK){
        tight_loop_contents();
    }

    const int totalSegs=512;
    const int segSize=4096/totalSegs;
    int segStart=0;
    for(int n=0;n<totalSegs;n++){
        while(!writeOK){
            tight_loop_contents();
        }
        for(int i=segStart;i<segStart+segSize;i++){
            dest->memory32[i]=src->memory32[i];
        }
        segStart+=segSize;
        while(writeOK){
            tight_loop_contents();
        }
    }
  
}

void testBlit(void){
    for(int n=0;n<32768;n++){
        vRam[n]=0;
    }
}