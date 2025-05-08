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
        {
            // Layer 0 used for debugging
            setLayerPos(0,0,24*8);
            setTileDefSet(0,defaultTileDef);
            drawTxtToLayer(0,"PRESS KEY TO PLAY!",0b01000110,0b1000010,7,0);

            // Layer 1 used for main title screen overlay bitmap
            setLayerPos(1,0,400);
            setLayerType(1,LT_BITMAP);
            setLayerBitmap(1,titleScreenBitmap,titleScreenAttr);

            // Layer 2 used for scrolling text
            setLayerPos(2,0,0);
            setTileDefSet(2,defaultTileDef);
            clearLayerLines(2,0,TILE_LAYER_HEIGHT);
            gv.storyTextCurrentLineIX=24;
            gv.storyTextNextSectionAtLineIX=24;
            gv.storyTextSectionIX=0;
            gv.storyTextCurrentSubLineIX=0;
            gv.storyScrollCDStartLine=0;
            gv.storyScrollCD=0;
        

            // Layer 3 used for side big daddy graphic
            setLayerPos(3,152+104,0);
            setTileDefSet(3,sideDaddyTileDef);

            // Layer 4 used for scrolling background image when showing instructions/story
            setLayerPos(4,400,0);
            setLayerType(4,LT_BITMAP);
            setLayerBitmap(4,gameBackground0Bitmap,NULL);

            int tDef=1;
            for(int y=0;y<15;y++){
                for(int x=0;x<14;x++){
                    setLayerTile(3, tDef++, 0b01000111, 0b01000111, x, y);
                }
                tDef+=2;
            }

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
        }
        break;
        default:
        break;
    }
    gs=newGS;
    resetStateVars();
}

void resetStateVars(){
    gv.iu=0;
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