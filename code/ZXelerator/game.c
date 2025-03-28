#include "game.h"
#include "displayMemoryOffsets.h"
#include "resetData.h"


GameState gs=GS_idle;
GameVar gv;
volatile uint32_t frameRendered=0;

void gameLoop(void)
{
    gpio_init(PIN_LED);
    gpio_set_dir(PIN_LED,GPIO_OUT);
    gpio_put(PIN_LED,false);
    bool tf=false;
    while(eroneousAddr==0){
        // Render the frame here - generates the ASM
        // For now just keep copying the default ASM - title image
        //copyBank(&ram[writeBank],&resetBank);
        testBlit();
        //setAttrDirect(frameRendered&0x1f,0b11110001);
        __wfe(); // Wait for event
        __dsb(); // Make sure memory is consistent
        tf=(tf?false:true);
        gpio_put(PIN_LED,tf);
        flipBank=1;
        ++frameRendered;
    }
}


void setState(GameState newGS)
{
    switch(newGS){
    }
    gs=newGS;
    resetStateVars();
}

void resetStateVars(){
    gv.iv=0;
    gv.iw=0;
    gv.ix=0;
    gv.iy=0;
    gv.iz=0;
}

void setAttrDirect(int ix, uint8_t v)
{
    uint16_t addr=attrOffset[0][ix];
    uint16_t addr2=attrOffset[1][ix];
    ram[writeBank].memory8[0][addr]=v;
    ram[writeBank].memory8[1][addr2]=v;
}
