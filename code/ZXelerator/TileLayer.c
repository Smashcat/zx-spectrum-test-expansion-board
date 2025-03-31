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
            tileLayer[n].attrMap[i]=7;
        }
    }
}

void blitRawToLayer(int layerIX, const uint8_t *tileDefs, const uint8_t *attrDefs, int x, int y, int len)
{
    const int offset=(y*TILE_LAYER_WIDTH)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+offset;
    uint8_t *aP=tileLayer[layerIX].attrMap+(offset*2);
    while(len--){
        *tP++=*tileDefs++;
        *aP++=*attrDefs++;
        *aP++=*attrDefs++;
    }
}

void drawTxtToLayer(int layerIX, const uint8_t *s, uint8_t colorTop, uint8_t colorBottom, int x, int y)
{
    const int offset=(y*TILE_LAYER_WIDTH)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+offset;
    uint8_t *aP=tileLayer[layerIX].attrMap+(offset*2);
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
    const int offset=(y*TILE_LAYER_WIDTH)+x+(maxDigits-1);
    uint8_t *tP=tileLayer[layerIX].tileMap+offset;
    uint8_t *aP=tileLayer[layerIX].attrMap+(offset*2);
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

void blitLayerToScreen(int layerIX)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->tileDefPtr==NULL){
        return;
    }
    // If layer is off screen, don't draw it
    if(
        (tL->x<=-TILE_LAYER_WIDTH*8*2) ||
        (tL->x>=SCREEN_WIDTH_CELLS*8) ||
        (tL->y<TILE_LAYER_HEIGHT*8*2) ||
        (tL->y>=SCREEN_HEIGHT_CELLS*8) 
    ){
        return;
    }

    // Find correct offset into tiles in Y axis. We wrap to stay within 0-63 in both axis
    int srcRowY=0;
    int srcRowOffY=(8-(tL->y&0x07))&0x07;
    if(tL->y<0){
        srcRowY=((-(tL->y/8) % 64) + 64) % 64;
    }else{
        srcRowY=((-((tL->y+7)/8) % 64) + 64) % 64;
    }

    int srcStartX=0;
    const int leftShift=(8-(tL->x&0x07))&0x07;
    if(tL->x<0){
        srcStartX=((-(tL->x/8) % 64) + 64) % 64;
    }else{
        srcStartX=((-((tL->x+7)/8) % 64) + 64) % 64;
    }

    // We now go through the 192 rows of the destination array, wrapping the X and Y src positions as needed
    for(int destRow=0;destRow<(SCREEN_HEIGHT_CELLS*8);destRow++){

    }
}
