#include "game.h"

GameState gs=GS_idle;
GameVar gv;
volatile uint32_t frameRendered=0;
int dma_chan;
dma_channel_config dmaBlitCfg;

const uint8_t bowser[64]={
    128,129,130,131,132,133,134,135,
    144,145,146,147,148,149,150,151,
    160,161,162,163,164,165,166,167,
    176,177,178,179,180,181,182,183,
    192,193,194,195,196,197,198,199,
    208,209,210,211,212,213,214,215,
    224,225,226,227,228,229,230,231,
    240,241,242,243,244,245,246,247
};

const uint8_t bowserCol[128]={
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
};

const uint8_t scoreBorder[28]={
    1,2,2,2,2,2,3,
    4,'S','C','O','R','E',20,
    4,'0','0','0','0','0',20,
    17,18,18,18,18,18,19
};

const uint8_t scoreColor[56]={
    0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,
    0x4f,0x4f, 0x71,0x61,0x71,0x61,0x71,0x61,0x71,0x61,0x71,0x61, 0x4f,0x4f,
    0x4f,0x4f, 0x79,0x79,0x79,0x79,0x79,0x79,0x79,0x79,0x79,0x79, 0x4f,0x4f, 
    0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,
};

void gameLoop(void)
{
    gpio_init(PIN_LED);
    gpio_set_dir(PIN_LED,GPIO_OUT);
    gpio_put(PIN_LED,false);
    bool tf=false;

    dma_chan = dma_claim_unused_channel(true);
    dmaBlitCfg = dma_channel_get_default_config(dma_chan);
    channel_config_set_transfer_data_size(&dmaBlitCfg, DMA_SIZE_32);
    channel_config_set_read_increment(&dmaBlitCfg, true);
    channel_config_set_write_increment(&dmaBlitCfg, true);

    const int numSprites=100;
    initSprites(numSprites);
    for(int n=0;n<numSprites;n++){
        setSpritePos(n,(n==0?10:rand()%255),(n==0?168:32+(rand()%150)));
        setSpriteDef(n,0);
        setSpritePalette(n,(n==0?1:2));
        setSpriteGroups(n,0,1);
        setSpriteLayer(n,1);
    };

    // Reset the ASM buffer, this contains the "title image" data by default
    safeBankBlit(writeBank,resetBank[0]);

    initLayers();

    const int hudLayer=0;
    const int frameCounterLayer=1;
    const int frontBowserLayer=2;
    const int backBowserLayer=3;

    setTileDefSet(frameCounterLayer,tiles1Def);
    setTileDefSet(frontBowserLayer,tiles1Def);
    setTileDefSet(hudLayer,tiles1Def);
    setTileDefSet(backBowserLayer,tiles1Def);

    for(int xPos=0;xPos<32;xPos+=8){
        for(int yPos=0;yPos<32;yPos+=8){
            for(int n=0;n<8;n++){
                blitRawToLayer(frontBowserLayer,bowser+(n*8),bowserCol+(n*16),xPos,yPos+n,8);
                blitRawToLayer(backBowserLayer,bowser+(n*8),bowserCol+(n*16),xPos,yPos+n,8);
            }
        }
    }

    for(int n=0;n<4;n++){
        blitRawToLayer(hudLayer,scoreBorder+(n*7),scoreColor+(n*14),0,n,7);
        blitRawToLayer(hudLayer,scoreBorder+(n*7),scoreColor+(n*14),25,n,7);
    }

    drawTxtToLayer(hudLayer,"xShift: 00",0b01000110,0b00000101,22,5);
    drawTxtToLayer(hudLayer,"xStart: 00",0b01000110,0b00000101,22,6);
    drawTxtToLayer(hudLayer,"Keyboard:",0b01000110,0b00000101,0,5);

    setLayerPos(frameCounterLayer,0,0);
    setLayerPos(frontBowserLayer,0,0);
    setLayerPos(hudLayer,0,0);

    int lYPos=0;
    int lYDir=1;
    int l1YPos=0;
    int l2YPos=0;
    float spinOffX=0;
    float spinOffY=0;
    while(eroneousAddr==0){
        // Wait for core0 to wake us
        __wfe(); // Wait for event
        __dsb(); // Make sure memory is consistent
        // Render the frame here - generates the ASM
        // For now just keep copying the default ASM - title image
        
        if(frameRendered>50){
            initScratchBuffers(true);

            for(int n=0;n<24;n++){
                drawIntNumToLayer(frameCounterLayer,frameRendered,0x57,0x0f,n,n,8);
            }
        
            setLayerPos(frameCounterLayer,lYPos,4);
            lYPos+=lYDir;
            if(lYPos==16){
                lYDir=-1;
            }else if(lYPos==-16){
                lYDir=1;
            }

            setLayerPos(frontBowserLayer,sin(((float)frameRendered)/10.0)*50,l1YPos);
            l1YPos-=4;
            if(l1YPos==-64){
                l1YPos=0;
            }

            setLayerPos(backBowserLayer,sin(((float)frameRendered)/17.0)*25,l2YPos);
            l2YPos+=2;
            if(l2YPos==2){
                l2YPos=-62;
            }

            for(int n=0;n<8;n++){
                drawIntNumToLayer(hudLayer,keyboardScan[n],0x57,0x0f,0,n+7,3);
            }

            int spritesToDraw=(frameRendered-100);
            if(spritesToDraw>numSprites){
                spritesToDraw=numSprites;
            }
            for(int n=1;n<spritesToDraw;n++){
                setSpriteGroups(n,1,1);
                if(n<64){
                    setSpritePos(n,118+(sin((spinOffX+(n*0.15)))*100.0),84+(cos((spinOffY+(n*0.15)))*60.0));
                }else{
                    setSpritePos(n,118-(sin((spinOffX+(n*0.15)))*100.0),84+(cos((spinOffY+(n*0.15)))*60.0));
                }
            }
            spinOffX+=0.04;
            spinOffY+=0.15;

            setSpriteGroups(0,1,1);
            if((keyboardScan[6]&0x01)){
                setSpritePos(0,spriteList[0].x-2,spriteList[0].y);
                setSpriteDef(0,0);
                if(--spriteList[0].frame<0){
                    spriteList[0].frame=7;
                }
            }
            if((keyboardScan[6]&0x04)){
                setSpritePos(0,spriteList[0].x+2,spriteList[0].y);
                setSpriteDef(0,8);
                if(++spriteList[0].frame==8){
                    spriteList[0].frame=0;
                }
            }
            if((keyboardScan[5]&0x02)){
                setSpritePos(0,spriteList[0].x,spriteList[0].y-4);
            }
            if((keyboardScan[6]&0x02)){
                setSpritePos(0,spriteList[0].x,spriteList[0].y+4);
            }
            drawIntNumToLayer(hudLayer,spriteList[0].x&0x07,0b01000110,0b00000101,30,5,2);
            drawIntNumToLayer(hudLayer,spriteList[0].x>>3,0b01000110,0b00000101,30,6,2);
            compositeScene();

            tf=(tf?false:true);
            gpio_put(PIN_LED,tf);
            flipBank=1;
            __dsb();
        }
        ++frameRendered;
    }
}


void setState(GameState newGS)
{
    switch(newGS){

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