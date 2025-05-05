#include "game.h"

GameState gs=GS_idle;
GameVar gv;

void gameLoop(void)
{
    gpio_init(PIN_LED);
    gpio_set_dir(PIN_LED,GPIO_OUT);
    gpio_put(PIN_LED,false);
    gv.frameRendered=0;

    // Reset the ASM buffer, this contains the "title image" data by default
    safeBankBlit(writeBank,resetBank[0]);
    initLayers();
    
    //demoLoop();
    gameUpdateLoop();
}

void gameUpdateLoop(void){
    setState(GS_title);
    while(1){
        __wfe(); // Wait for event
        __dsb(); // Make sure memory is consistent

        if(gv.frameRendered>25){
            initScratchBuffers(true);
            int fy=(int)(sin((float)gv.frameRendered/10)*40)*4;
            int fx=(int)(sin((float)gv.frameRendered/13)*20)*8;
            setLayerPos(0,fx,fy);

            compositeScene();
            flipBank=1;
            __dsb();
        }
        ++gv.frameRendered;
    }
}

void setState(GameState newGS)
{
    switch(newGS){
        case GS_title:
        setLayerPos(0,0,0);
        setLayerType(0,LT_BITMAP);
        setLayerBitmap(0,bitmap0,attr0);
        break;
        default:
        break;
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
    uint16_t addr1=attrOffset[1][ix];
    ram[writeBank][0][addr]=v;
    ram[writeBank][1][addr1]=v;
}

void setDispDirect(int ix, uint8_t v){
    ram[writeBank][0][dispOffset[ix]]=v;
}

void safeBankBlit(int dstBankIX,const uint8_t *srcBank){
    memcpy(ram[dstBankIX][0],srcBank,0x2f00*2);
}