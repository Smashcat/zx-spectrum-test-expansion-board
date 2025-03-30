#include "game.h"

GameState gs=GS_idle;
GameVar gv;
volatile uint32_t frameRendered=0;
int dma_chan;
dma_channel_config dmaBlitCfg;
int vPos=0;
int vDir=1;
int vLPos=0;
int vLDir=1;
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

    const int numSprites=512;
    Sprite s[numSprites];
    for(int n=0;n<numSprites;n++){
        s[n].x=rand()%255;
        s[n].y=rand()%192;
        s[n].defIX=0;
        s[n].groupBits=1;
    };

    while(eroneousAddr==0){
        // Wait for core0 to wake us
        __wfe(); // Wait for event
        __dsb(); // Make sure memory is consistent
        // Render the frame here - generates the ASM
        // For now just keep copying the default ASM - title image
        
        if(frameRendered>50){
            safeBankBlit(writeBank,resetBank[0]);

            for(int n=0;n<32;n+=2){
                setAttrDirect((vPos*32)+n,0b01110101);
                setAttrDirect(((47-vPos)*32)+n+1,0b01011010);
            }
            for(int n=0;n<256;n++){
                setDispDirect((vLPos*32)+n,0b10101010);
                setDispDirect(((184-vLPos)*32)+n,0xf0);
            }

            vPos+=vDir;
            if(vPos==47){
                vDir=-1;
            }else if(vPos==0){
                vDir=1;
            }

            vLPos+=vLDir;
            if(vLPos==184){
                vLDir=-1;
            }else if(vLPos==0){
                vLDir=1;
            }
            int spritesToDraw=(frameRendered-50);
            if(spritesToDraw>numSprites){
                spritesToDraw=numSprites;
            }
            for(int n=0;n<spritesToDraw;n++){
                drawSprite(s[n]);
                if(--s[n].x==-32){
                    s[n].x=255;
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