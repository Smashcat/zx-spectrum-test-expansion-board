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

    const int numSprites=200;
    Sprite s[numSprites];
    for(int n=0;n<numSprites;n++){
        s[n].x=(n==0?10:rand()%255);
        s[n].y=(n==0?168:32+(rand()%150));
        s[n].defIX=0;
        s[n].groupBits=1;
    };

    safeBankBlit(writeBank,resetBank[0]);

    initLayers();
    setTileDefSet(0,tiles1Def);
    setTileDefSet(1,tiles1Def);
    setTileDefSet(2,tiles1Def);

    drawTxtToLayer(0,"Test  text",0b01000110,0b00000101,11,22);

    for(int xPos=0;xPos<32;xPos+=8){
        for(int yPos=0;yPos<32;yPos+=8){
            for(int n=0;n<8;n++){
                blitRawToLayer(1,bowser+(n*8),bowserCol+(n*16),xPos,yPos+n,8);
            }
        }
    }

    for(int n=0;n<4;n++){
        blitRawToLayer(2,scoreBorder+(n*7),scoreColor+(n*14),0,n,7);
        blitRawToLayer(2,scoreBorder+(n*7),scoreColor+(n*14),25,n,7);
    }

    setLayerPos(0,0,0);
    setLayerPos(1,0,0);
    setLayerPos(2,0,0);

    int lYPos=0;
    int lYDir=1;
    int l1YPos=0;
    while(eroneousAddr==0){
        // Wait for core0 to wake us
        __wfe(); // Wait for event
        __dsb(); // Make sure memory is consistent
        // Render the frame here - generates the ASM
        // For now just keep copying the default ASM - title image
        
        if(frameRendered>50){
            initScratchBuffers(true);


            for(int n=0;n<24;n++){
                drawIntNumToLayer(0,frameRendered,0b01010111,0b00001111,n,n,8);
            }
            setLayerPos(0,8,lYPos);
            lYPos+=lYDir;
            if(lYPos==16){
                lYDir=-1;
            }else if(lYPos==-16){
                lYDir=1;
            }

            setLayerPos(1,0,l1YPos);
            l1YPos-=2;
            if(l1YPos==-64){
                l1YPos=0;
            }
            blitLayerToRenderBuffer(1);
            blitLayerToRenderBuffer(0);
            blitLayerToRenderBuffer(2);
            blitRenderBuffer();

            int spritesToDraw=(frameRendered-100);
            if(spritesToDraw>numSprites){
                spritesToDraw=numSprites;
            }
            for(int n=0;n<spritesToDraw;n++){
                drawSprite(s[n]);
                if((frameRendered%1)==0){
                    if(--s[n].x==-32){
                        s[n].x=255;
                    }
                }
            }
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