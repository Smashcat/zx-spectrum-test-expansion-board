#include "TileLayer.h"

TileLayer tileLayer[MAX_TILE_LAYERS];
static uint8_t pixLineBuffer[260] __attribute__((aligned(4)));

void initLayers(void){
    for(int n=0;n<MAX_TILE_LAYERS;n++){
        TileLayer *t=tileLayer+n;
        t->x=500;
        t->y=0;
        t->tileDefPtr=NULL;
        t->bitmapDefPtr=NULL;
        t->attrDefPtr=NULL;
        t->layerType=LT_TILE;
        for(int i=0;i<(TILE_LAYER_WIDTH*TILE_LAYER_HEIGHT);i++){
            t->tileMap[i]=0;
        }
        for(int i=0;i<(TILE_LAYER_WIDTH*TILE_LAYER_ATTR_HEIGHT);i++){
            t->attrMap[i]=7+(1<<7);   // High bit set = do not update attr when drawing the pixels under this attr block
        }
    }
}

void setLayerType(int layerIX, LayerType lt)
{
    tileLayer[layerIX].layerType=lt;
}

void setLayerBitmap(int layerIX, const uint8_t *bitmapData, const uint8_t *attrData)
{
    TileLayer *t=tileLayer+layerIX;
    t->bitmapDefPtr=bitmapData+4;
    t->attrDefPtr=attrData;
    t->bitmapCharWidth=bitmapData[0];
    t->bitmapHeight=bitmapData[1];
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

void drawTxtToLayer(int layerIX, const char *s, uint8_t colorTop, uint8_t colorBottom, int x, int y)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x;
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    while(*s){
        *tP=*s;
        if(*s && *s!=32){
            *aP=colorTop;
            *(aP+TILE_LAYER_WIDTH)=colorBottom;
        }else{
            *aP=0x80;
            *(aP+TILE_LAYER_WIDTH)=0x80;
        }
        ++tP;
        ++aP;
        ++s;
    }
}

void drawIntNumToLayer(int layerIX, int32_t num, uint8_t colorTop, uint8_t colorBottom, int x, int y, int maxDigits)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x+(maxDigits-1);
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x+(maxDigits-1);
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    if(num<0){
        *(tP-(maxDigits-1))='-';
        --maxDigits;
        num=-num;
    }
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
void blitLayerToScratchBuffers(int layerIX)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->layerType!=LT_TILE){
        blitBitmapLayerToScratchBuffers(layerIX);
    }

    if(tL->tileDefPtr==NULL){
        return;
    }

    // If layer is off screen, don't draw it
    if(
        (tL->x<=-TILE_LAYER_WIDTH*8*2) ||
        (tL->x>=SCREEN_WIDTH_PIXELS) ||
        (tL->y<=-TILE_LAYER_HEIGHT*8*2) ||
        (tL->y>=SCREEN_HEIGHT_LINES) 
    ){
        return;
    }

    // Find correct offset into tiles in Y axis. We wrap to stay within 0-63 in both axis
    int srcStartY=0;
    int srcRowOffY=(8-(tL->y&0x07))&0x07;
    if(tL->y<0){
        srcStartY=((-(tL->y/8) % TILE_LAYER_HEIGHT) + TILE_LAYER_HEIGHT) % TILE_LAYER_HEIGHT;
    }else{
        srcStartY=((-((tL->y+7)/8) % TILE_LAYER_HEIGHT) + TILE_LAYER_HEIGHT) % TILE_LAYER_HEIGHT;
    }

    int srcStartX=0;
    const int leftShift=(8-(tL->x&0x07))&0x07;
    if(tL->x<0){
        srcStartX=((-(tL->x/8) % TILE_LAYER_WIDTH) + TILE_LAYER_WIDTH) % TILE_LAYER_WIDTH;
    }else{
        srcStartX=((-((tL->x+7)/8) % TILE_LAYER_WIDTH) + TILE_LAYER_WIDTH) % TILE_LAYER_WIDTH;
    }

    uint8_t *spr=scratchPixRam;
    uint8_t *smr=scratchMaskRam;
    const uint8_t *tileData=tL->tileMap;
    int srcRow=srcStartY;

    // We now go through the 192 rows of the destination array, wrapping the X and Y src positions as needed
    for(int destRow=0;destRow<SCREEN_HEIGHT_LINES;destRow++){

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

}

void blitBitmapLayerToScratchBuffers(int layerIX)
{
    const int lineBufferLen=260;
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->attrDefPtr==NULL || tL->bitmapDefPtr==NULL){
        return; // Nothing to draw...
    }

    // If layer is off screen, don't draw it
    if(
        (tL->x<=-(tL->bitmapCharWidth*8)) ||
        (tL->x>=SCREEN_WIDTH_PIXELS) ||
        (tL->y<=-(tL->bitmapHeight)) ||
        (tL->y>=SCREEN_HEIGHT_LINES) 
    ){
        return;
    }
    
    int srcY=0;
    int srcX=0;
    int dstWidth=tL->bitmapCharWidth;
    int dstHeight=tL->bitmapHeight;
    int dstXChar=(tL->x/8);
    int rightShift=(tL->x&0x07)&0x07;
    int dstY=tL->y;

    if(dstY<0){
        srcY=-dstY;
        dstY=0;
        dstHeight-=srcY;
    }

    int add1=0;
    if(tL->x<0){
        srcX=-dstXChar;
        dstXChar=0;
        dstWidth-=srcX;
        if(rightShift){
            ++srcX;
            --dstWidth;
            add1=1;
        }
    }

    if((dstXChar+dstWidth)>SCREEN_WIDTH_CELLS){
        dstWidth=(SCREEN_WIDTH_CELLS-dstXChar);
    }

    if((dstY+dstHeight)>SCREEN_HEIGHT_LINES){
        dstHeight=(SCREEN_HEIGHT_LINES-dstY);
    }

    memset(pixLineBuffer,0,lineBufferLen);
    const uint8_t *srcP=tL->bitmapDefPtr+(tL->bitmapCharWidth*srcY)+srcX;
    const uint8_t *srcAP=tL->attrDefPtr+(tL->bitmapCharWidth*(srcY/ATTR_HEIGHT_PIXELS))+srcX;

    uint8_t *spr=scratchPixRam+(dstY*SCREEN_WIDTH_CELLS)+dstXChar;
    uint8_t *rb=renderAttrBuffer+((dstY/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS)+dstXChar;
    int aLCnt=1;
    for(int y=0;y<dstHeight;y++){
        uint8_t carry=0;
        if((rightShift>0) && (srcX>0)){
            carry=*(srcP-1);
            carry<<=(8-rightShift);
        }
        if(rightShift){
            for(int x=0;x<dstWidth;x++){
                uint8_t b=*(srcP+x);
                uint8_t newCarry=b<<(8-rightShift);
                b=(b>>rightShift)|carry;
                carry=newCarry;
                *(spr+x)=b;
            }
            if(add1){
                *(spr+dstWidth)=carry;
            }
        }else{
            for(int x=0;x<dstWidth;x++){
                *(spr+x)=*(srcP+x);
            }
        }
        srcP+=tL->bitmapCharWidth;
        spr+=SCREEN_WIDTH_CELLS;

        if(--aLCnt==0){
            aLCnt=dstHeight-y;
            if(aLCnt>4){
                aLCnt=4;
            }
            const int attrWidth=(add1?dstWidth+1:dstWidth);
            for(int x=0;x<attrWidth;x++){
                uint8_t col=*(srcAP+x);
                if((col&0x80)==0){
                    *(rb+x)=col;
                }
            }
            srcAP+=tL->bitmapCharWidth;
            rb+=SCREEN_WIDTH_CELLS;
        }
    }


}
