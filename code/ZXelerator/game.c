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
            switch(gs){
                case GS_title:
                    gameTitle();
                break;
                default:
                break;
            }
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
        setLayerPos(1,0,400);
        setLayerType(1,LT_BITMAP);
        setLayerBitmap(1,bitmap0,attr0);

        setLayerPos(0,0,0);
        setTileDefSet(0,tiles1Def);
        // Title letter positions: 0,32,64,88, 112,128,152,168,196,224
        initSprites(10);
        for(int n=0;n<10;n++){
            setSpritePos(n,300,300);
            setSpriteSize(n,SIZE_32X40);
            setSpriteDef(n,titleLettersDef,titleLettersMaskDef);
            setSpritePalette(n,2);
            setSpriteLayer(n,0);
            spriteList[n].frame=n;
            setSpriteScale(n,0.1,1);
            spriteList[n].delay=(n*2);
        }
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