#include "game.h"
#include "displayMemoryOffsets.h"
#include "resetData.h"


GameState gs=GS_idle;
GameVar gv;
uint32_t frameRendered=0;

void gameLoop(void)
{
    setState(GS_idle);
    while(1){

        switch(gs){
            case GS_idle:
                copyBank(&ram[writeBank],&resetBank);
                for(int n=0;n<768*2;n++){
                    setAttrDirect(1,0b01110011+gv.ix);
                }
                if(++gv.ix>255){
                    gv.ix=0;
                }
                flipBank=1;
            break;
            case GS_title:
            break;
        }
        while(frameDrawn==frameRendered){
            tight_loop_contents();
        }
        frameRendered=frameDrawn;
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
