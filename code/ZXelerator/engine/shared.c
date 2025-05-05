#include "shared.h"

uint8_t keyboardScan[8] __attribute__((aligned(4))) = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
volatile uint32_t readBank=0, writeBank=1;
volatile uint32_t frameDisplayed=0;
volatile int flipBank=0;
volatile int writeOK=0;
volatile int eroneousAddr=0;
uint8_t ram[TOTAL_RAMBANKS][2][0x2f00] __attribute__((aligned(0x20000)));

// Used to render pixel data from layers/sprites before copying to bufferRam
uint8_t scratchPixRam[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES] __attribute__((aligned(4)));

// Used to render mask data from layers/sprites before copying to bufferRam
uint8_t scratchMaskRam[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES] __attribute__((aligned(4)));

// Main back-buffer, used to build up frame image before generating ASM for next frame
uint8_t renderBuffer[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES] __attribute__((aligned(4)));

// Main attribute buffer, used to update colors on screen - note that flashing bit (7) will never be used, as it's used internally to mean "do not update existing color" when addinng layers
uint8_t renderAttrBuffer[SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS] __attribute__((aligned(4)));
uint8_t oldRenderAttrBuffer[SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS] __attribute__((aligned(4)));

void initScratchBuffers(bool includeRenderBuffer)
{
    // Initialise the scratch buffers
    const int numBlits=(SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES)/4;
    uint32_t *pP=(uint32_t *)scratchPixRam;
    uint32_t *mP=(uint32_t *)scratchMaskRam;
    for(int n=0;n<numBlits;n++){
        *pP++=0;
        *mP++=0xffffffff;
    }
    if(!includeRenderBuffer){
        return;
    }

    pP=(uint32_t *)renderBuffer;
    for(int n=0;n<numBlits;n++){
        *pP++=0;
    }

    pP=(uint32_t *)renderAttrBuffer;
    for(int n=0;n<(SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS)/4;n++){
        *pP++=0x07070707;   // dim white on black background for testing - will be black on black
    }
}

void blitScratchToRenderBuffer(void)
{
    const int numBlits=(SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES)/4;
    const uint32_t *pP=(uint32_t *)scratchPixRam;
    const uint32_t *mP=(uint32_t *)scratchMaskRam;
    uint32_t *rP=(uint32_t *)renderBuffer;
    for(int n=0;n<numBlits;n++){
        *rP&=*mP;
        *rP|=*pP;
        ++rP;
        ++mP;
        ++pP;
    }   
}

void blitRenderBuffer(void)
{

    const int numBlits=(SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES);
    const uint8_t *rP=(uint8_t *)renderBuffer;
    uint16_t *doP=(uint16_t *)dispOffset;
    for(int n=0;n<numBlits;n++){
        ram[writeBank][0][*doP]=*rP;
        ++doP;
        ++rP;
    }

    const uint8_t *raP=(uint8_t *)renderAttrBuffer;
    uint8_t *oRaP=(uint8_t *)oldRenderAttrBuffer;
    for(int n=0;n<(SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS);n++){
        uint16_t addr=attrOffset[0][n];
        uint16_t addr1=attrOffset[1][n];
        ram[writeBank][0][addr]=*oRaP;
        ram[writeBank][1][addr1]=*raP;
        *oRaP=*raP;
        ++raP;
        ++oRaP;
    }

}
