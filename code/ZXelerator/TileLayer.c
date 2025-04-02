#include "TileLayer.h"

TileLayer tileLayer[MAX_TILE_LAYERS];

void initLayers(void){
    for(int n=0;n<MAX_TILE_LAYERS;n++){
        tileLayer[n].x=500;
        tileLayer[n].y=0;
        tileLayer[n].tileDefPtr=NULL;
        for(int i=0;i<(TILE_LAYER_WIDTH*TILE_LAYER_HEIGHT);i++){
            tileLayer[n].tileMap[i]=0;
        }
        for(int i=0;i<(TILE_LAYER_WIDTH*TILE_LAYER_ATTR_HEIGHT);i++){
            tileLayer[n].attrMap[i]=7+(1<<7);   // High bit set = do not update attr when drawing the pixels under this attr block
        }
    }
}

void blitRawToLayer(int layerIX, const uint8_t *tileDefs, const uint8_t *attrDefs, int x, int y, int len)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x;
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    while(len--){
        *tP++=*tileDefs++;
        *aP=*attrDefs++;
        *(aP+TILE_LAYER_WIDTH)=*attrDefs++;
        ++aP;
    }
}

void drawTxtToLayer(int layerIX, const uint8_t *s, uint8_t colorTop, uint8_t colorBottom, int x, int y)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x;
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    while(*s){
        *tP=*s++;
        *aP=colorTop;
        *(aP+TILE_LAYER_WIDTH)=colorBottom;
        ++tP;
        ++aP;
    }
}

void drawIntNumToLayer(int layerIX, int32_t num, uint8_t colorTop, uint8_t colorBottom, int x, int y, int maxDigits)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x+(maxDigits-1);
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x+(maxDigits-1);
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    while(maxDigits){
        *tP=(num%10)+'0';
        num/=10;
        *aP=colorTop;
        *(aP+TILE_LAYER_WIDTH)=colorBottom;
        --tP;
        --aP;
        --maxDigits;
    }
}

void setLayerPos(int layerIX, int x, int y)
{
    tileLayer[layerIX].x=x;
    tileLayer[layerIX].y=y;
}

void setTileDefSet(int layerIX, const uint8_t *setRef)
{
    tileLayer[layerIX].tileDefPtr=setRef;
}

//__not_in_flash_func(
//    void blitLayerToRenderBuffer(int layerIX)
//)
void blitLayerToRenderBuffer(int layerIX)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->tileDefPtr==NULL){
        return;
    }

    // If layer is off screen, don't draw it
    if(
        (tL->x<=-TILE_LAYER_WIDTH*8*2) ||
        (tL->x>=SCREEN_WIDTH_CELLS*8) ||
        (tL->y<=-TILE_LAYER_HEIGHT*8*2) ||
        (tL->y>=SCREEN_HEIGHT_CELLS*8) 
    ){
        return;
    }

    // Find correct offset into tiles in Y axis. We wrap to stay within 0-63 in both axis
    int srcStartY=0;
    int srcRowOffY=(8-(tL->y&0x07))&0x07;
    if(tL->y<0){
        srcStartY=((-(tL->y/8) % 64) + 64) % 64;
    }else{
        srcStartY=((-((tL->y+7)/8) % 64) + 64) % 64;
    }

    int srcStartX=0;
    const int leftShift=(8-(tL->x&0x07))&0x07;
    if(tL->x<0){
        srcStartX=((-(tL->x/8) % 64) + 64) % 64;
    }else{
        srcStartX=((-((tL->x+7)/8) % 64) + 64) % 64;
    }

    if(layerIX==0){
        drawIntNumToLayer(2,leftShift,0x4f,0x5f,30,5,2);
        drawIntNumToLayer(2,srcStartX,0x4f,0x5f,30,6,2);
    }

    // Get scratch buffers ready
    initScratchBuffers(false);

    uint8_t *spr=scratchPixRam;
    uint8_t *smr=scratchMaskRam;
    const uint8_t *tileData=tL->tileMap;
    int srcRow=srcStartY;

    // We now go through the 192 rows of the destination array, wrapping the X and Y src positions as needed
    for(int destRow=0;destRow<(SCREEN_HEIGHT_CELLS*8);destRow++){
        // Go through 32 cols for each pixel row, picking up the correct char defs for the 8x8 cell, and scan-line offset
        const uint8_t *tDef=tL->tileDefPtr+srcRowOffY; // Current line offset added, for quicker lookup
        int yOff=srcRow*TILE_LAYER_WIDTH;
        int srcCol=srcStartX;
        for(int destCol=0;destCol<SCREEN_WIDTH_CELLS;destCol++){
            int tileDef=*(tileData+yOff+srcCol);
            *spr++=*(tDef+(tileDef*8));
            *smr++=*(tDef+(tileDef*8)+(256*8));
            if(++srcCol==TILE_LAYER_WIDTH){
                srcCol=0;
            }
        }

        // Now shift pixels left if necessary

        if(leftShift){
            int tileDef=*(tileData+yOff+srcCol);
            uint8_t carry=*(tDef+(tileDef*8));
            uint8_t carryM=*(tDef+(tileDef*8)+(256*8));
            const int ramOff=(destRow*SCREEN_WIDTH_CELLS)+31;
            uint8_t *rotP=scratchPixRam+ramOff;
            uint8_t *rotM=scratchMaskRam+ramOff;
            for (int x=31;x>=0;x--){  // Process right-to-left
                uint8_t current=*rotP;
                uint8_t rotated=(current<<leftShift) | (carry>>(8-leftShift));
                *rotP=rotated;
                carry=current;
                --rotP;

                current=*rotM;
                rotated=(current<<leftShift) | (carryM>>(8-leftShift));
                *rotM=rotated;
                carryM=current;
                --rotM;
            }
        }

        if(++srcRowOffY==8){
            srcRowOffY=0;
            if(++srcRow==TILE_LAYER_HEIGHT){
                srcRow=0;
            }
        }
    }


    // Now draw attributes directly to the render buffer. Any attribute 
    // color with flashing bit set means (don't update this cell)
    srcRow=((srcStartY*8)+srcRowOffY)/4;
    const uint8_t *am=tL->attrMap;
    if(leftShift>3){
        if(++srcStartX==TILE_LAYER_WIDTH){
            srcStartX=0;
        }
        
    }
    uint8_t *destAttrBuffer=renderAttrBuffer;
    for(int destRow=0;destRow<(SCREEN_HEIGHT_CELLS*2);destRow++){
        // Go through 32 cols for each pixel row, picking up the correct char defs for the 8x8 cell, and scan-line offset
        int srcCol=srcStartX;
        int yOff=srcRow*(TILE_LAYER_WIDTH);
        for(int destCol=0;destCol<SCREEN_WIDTH_CELLS;destCol++){
            uint8_t col=*(am+yOff+srcCol);
            if((col&0x80)==0){
                *destAttrBuffer=col;
            }
            ++destAttrBuffer;
            if(++srcCol==TILE_LAYER_WIDTH){
                srcCol=0;
            }
        }
        if(++srcRow==TILE_LAYER_ATTR_HEIGHT){
            srcRow=0;
        }
    }

    blitScratchToRenderBuffer();
}
