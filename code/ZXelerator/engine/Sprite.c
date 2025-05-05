#include "Sprite.h"

Sprite *spriteList=NULL;
int totalSprites=0;
static uint8_t pixLineBuffer[256] __attribute__((aligned(4)));
static uint8_t maskLineBuffer[256] __attribute__((aligned(4)));

void initSprites(int numSprites)
{
    if(totalSprites){
        deleteSprites();
    }
    spriteList=(Sprite *)malloc(numSprites*sizeof(Sprite));
    totalSprites=numSprites;
    for(int n=0;n<numSprites;n++){
        Sprite *s=spriteList+n;
        s->x=500;
        s->y=0;
        s->defPtr=NULL;
        s->frame=0;
        s->isScaled=0;
    }
}

void deleteSprites(void)
{
    totalSprites=0;
    if(spriteList==NULL){
        return;
    }
    free(spriteList);
    spriteList=NULL;
}

void setSpriteSize(int ix, SpriteSize st){
    Sprite *s=spriteList+ix;
    switch(st){
        case SIZE_8X4:
        s->width=8;
        s->height=4;
        break;
        case SIZE_8X8:
        s->width=8;
        s->height=8;
        break;
        case SIZE_8X12:
        s->width=8;
        s->height=12;
        break;
        case SIZE_8X16:
        s->width=8;
        s->height=16;
        break;

        case SIZE_16X8:
        s->width=16;
        s->height=8;
        break;
        case SIZE_16X12:
        s->width=16;
        s->height=12;
        break;
        case SIZE_16X16:
        s->width=16;
        s->height=16;
        break;
        case SIZE_16X24:
        s->width=16;
        s->height=24;
        break;
        
        case SIZE_24X24:
        s->width=24;
        s->height=24;
        break;
        case SIZE_24X32:
        s->width=24;
        s->height=32;
        break;
        case SIZE_24X40:
        s->width=24;
        s->height=40;
        break;
        case SIZE_24X48:
        s->width=24;
        s->height=48;
        break;
        case SIZE_24X64:
        s->width=24;
        s->height=64;
        break;
    }
    s->size=st;
    s->scaledWidth=s->width;
    s->scaledHeight=s->height;
    s->isScaled=0;
    s->bytesPerRow = (s->width==24?4:(s->width >> 3));  // 24bit wide sprites actually span 4 bytes for faster 32-bit aligned reads
}

void blitSpritesToRenderBuffer(int layerIX)
{
    for(int n=totalSprites-1;n>-1;n--){
        Sprite *s=spriteList+n;
        // If sprite is not in this layer, it's not shown
        // Also if it's not within the visible screen, it's not shown
        if(
            (s->layer!=layerIX) || 
            (s->y>=SCREEN_HEIGHT_LINES) || 
            (s->y<=-(s->scaledHeight)) || 
            (s->x<=-(s->scaledWidth)) || 
            (s->x>=SCREEN_WIDTH_PIXELS)
        ){
            continue;
        }

        if(s->isScaled){
            blitSpriteScaledToRenderBuffer(s);
        }else{
            switch(s->width){
                case 8:
                    blitSprite8ToRenderBuffer(s);
                    break;
                case 16:
                    blitSprite16ToRenderBuffer(s);
                    break;
                case 24:
                    blitSprite24ToRenderBuffer(s);
                    break;
            }
        }
    }
}

void blitSprite8ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->x>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->x&0x07;
    const uint8_t *sDef=(uint8_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint8_t *mDef=(uint8_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->y*SCREEN_WIDTH_CELLS);

    for(int y=s->y;y<s->y+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint16_t src16=  (*sDef<<8)>>shiftRight;
            uint16_t mask16=(((*mDef<<8)+0xff)>>shiftRight)|(0xffff<<(16-shiftRight));
            if(xS>-1){
                *(rP+xS)&=(uint8_t)(mask16>>8);
                *(rP+xS)|=(uint8_t)(src16>>8);
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(rP+xS+1)&=(uint8_t)(mask16);
                *(rP+xS+1)|=(uint8_t)(src16);
            }
        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->y/ATTR_HEIGHT_PIXELS);
    uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
    const uint8_t *apSrc=palette[s->paletteIX];
    for(int y=startY;y<startY+(spriteHeight/ATTR_HEIGHT_PIXELS);y++){
        const uint8_t apS=*apSrc;
        if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
            if(xS>-1){
                *(aP+xS)=apS;
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)  && (shiftRight>0)){
                *(aP+xS+1)=apS;
            }
        }
        ++apSrc;
        aP+=SCREEN_WIDTH_CELLS;
    }
}

void blitSprite16ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->x>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->x&0x07;
    const uint16_t *sDef=(uint16_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint16_t *mDef=(uint16_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->y*SCREEN_WIDTH_CELLS);

    for(int y=s->y;y<s->y+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint32_t src32= *sDef;
            uint32_t mask32=*mDef;
            src32=  ((src32<<24)  |((src32&0xff00)<<8))>>shiftRight;
            mask32= (((mask32<<24)|((mask32&0xff00)<<8)|0xffff)>>shiftRight)|(0xffffffff<<(32-shiftRight));
            if(xS>-1){
                *(rP+xS)&=(uint8_t)(mask32>>24);
                *(rP+xS)|=(uint8_t)(src32>>24);
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(rP+xS+1)&=(uint8_t)(mask32>>16);
                *(rP+xS+1)|=(uint8_t)(src32>>16);
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)){
                *(rP+xS+2)&=(uint8_t)(mask32>>8);
                *(rP+xS+2)|=(uint8_t)(src32>>8);
            }
        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->y/ATTR_HEIGHT_PIXELS);
    uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
    const uint8_t *apSrc=palette[s->paletteIX];
    for(int y=startY;y<startY+(spriteHeight/ATTR_HEIGHT_PIXELS);y++){
        const uint8_t apS=*apSrc;
        if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
            if(xS>-1){
                *(aP+xS)=apS;
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(aP+xS+1)=apS;
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)  && (shiftRight>0)){
                *(aP+xS+2)=apS;
            }
        }
        ++apSrc;
        aP+=SCREEN_WIDTH_CELLS;
    }
}

void blitSprite24ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->x>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->x&0x07;
    const uint32_t *sDef=(uint32_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint32_t *mDef=(uint32_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->y*SCREEN_WIDTH_CELLS);

    for(int y=s->y;y<s->y+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint32_t src32= ((*sDef<<24)+((*sDef&0x0000ff00)<<8)+((*sDef&0x00ff0000)>>8)+(*sDef>>24))>>shiftRight;
            uint32_t mask32=(((*mDef<<24)+((*mDef&0x0000ff00)<<8)+((*mDef&0x00ff0000)>>8)+(*mDef>>24))>>shiftRight)|(0xffffffff<<(32-shiftRight));
            if(xS>-1){
                *(rP+xS)&=(uint8_t)(mask32>>24);
                *(rP+xS)|=(uint8_t)(src32>>24);
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(rP+xS+1)&=(uint8_t)(mask32>>16);
                *(rP+xS+1)|=(uint8_t)(src32>>16);
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)){
                *(rP+xS+2)&=(uint8_t)(mask32>>8);
                *(rP+xS+2)|=(uint8_t)(src32>>8);
            }
            if(xS>-4 && xS<(SCREEN_WIDTH_CELLS-3)){
                *(rP+xS+3)&=(uint8_t)(mask32);
                *(rP+xS+3)|=(uint8_t)(src32);
            }

        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->y/ATTR_HEIGHT_PIXELS);
    uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
    const uint8_t *apSrc=palette[s->paletteIX];
    for(int y=startY;y<startY+(spriteHeight/ATTR_HEIGHT_PIXELS);y++){
        const uint8_t apS=*apSrc;
        if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
            if(xS>-1){
                *(aP+xS)=apS;
            }
            if(xS>-2 && xS<(SCREEN_WIDTH_CELLS-1)){
                *(aP+xS+1)=apS;
            }
            if(xS>-3 && xS<(SCREEN_WIDTH_CELLS-2)){
                *(aP+xS+2)=apS;
            }
            if(xS>-4 && xS<(SCREEN_WIDTH_CELLS-3)  && (shiftRight>0)){
                *(aP+xS+3)=apS;
            }
        }
        ++apSrc;
        aP+=SCREEN_WIDTH_CELLS;
    }
}

void blitSpriteScaledToRenderBuffer(Sprite *s)
{
    const int lineBufferLen = 256;
    const int sHeight=s->scaledHeight;
    const int sWidth=s->scaledWidth;
    const int sY=s->y;
    const int bpr=s->bytesPerRow;
    const int xS=s->x>>3;                                                  // Character cell to start in is the xPos/8
    const int dstStartBitPos=7-(s->x&0x07);
    const uint8_t *sDefBase=(uint8_t *)s->defPtr+(s->frame*s->height*s->bytesPerRow);       // Point to start of sprite foreground data
    const uint8_t *mDefBase=(uint8_t *)s->maskPtr+(s->frame*s->height*s->bytesPerRow);      // Point to start of sprite mask data
    const uint8_t *apSrc=palette[s->paletteIX];
    const int endLine=(sY+sHeight>SCREEN_HEIGHT_LINES?SCREEN_HEIGHT_LINES:sY+sHeight);
    const int sWidthChars=(sWidth>>3)+1;

    U32u8 xAdd,yAdd;
    yAdd.u32 = 0;
    uint8_t lByte = 255;
    uint8_t *rP=(uint8_t *)renderBuffer+(sY*SCREEN_WIDTH_CELLS);
    uint8_t *aP=renderAttrBuffer+((sY/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS);
    int attrCountDown=1;

    memset(pixLineBuffer,0,lineBufferLen);
    memset(maskLineBuffer,0xff,lineBufferLen);
    for(int y=s->y;y<endLine;y++){
        if(y>-1){
            if(lByte!=yAdd.u8[2]){
                lByte = yAdd.u8[2];
                int dstBitPos=dstStartBitPos;
                xAdd.u32=0;
                const uint8_t *src=sDefBase+((int)yAdd.u8[2] * bpr);
                const uint8_t *mSrc=mDefBase+((int)yAdd.u8[2] * bpr);
                int srcBitPos=7;
                int plbIX=0;
                pixLineBuffer[plbIX]=0;
                maskLineBuffer[plbIX]=0xff;
                for (int x = 0; x < sWidth; x++) {
                    if(*src&(1<<srcBitPos)){
                        pixLineBuffer[plbIX]|=(1<<dstBitPos);
                    }
                    if((*mSrc&(1<<srcBitPos))==0){
                        maskLineBuffer[plbIX]&=~(1<<dstBitPos);
                    }
                    if(--dstBitPos<0){
                        ++plbIX;
                        pixLineBuffer[plbIX]=0;
                        maskLineBuffer[plbIX]=0xff;
                        dstBitPos+=8;
                    }
                    xAdd.u32 += s->scaledWidthAdder.u32;
                    if (xAdd.u8[2] > 0) {
                        srcBitPos -= xAdd.u8[2];
                        xAdd.u8[2] = 0;
                        if (srcBitPos < 0) {
                            srcBitPos += 8;
                            ++src;
                            ++mSrc;
                        }
                    }
                }
            }

            yAdd.u32 += s->scaledHeightAdder.u32;
            for(int lIX=0;lIX<sWidthChars;lIX++){
                int dstChar=lIX+xS;
                if(dstChar>-1 && dstChar<SCREEN_WIDTH_CELLS){
                    *(rP+dstChar)&=maskLineBuffer[lIX];
                    *(rP+dstChar)|=pixLineBuffer[lIX];
                }
            }

            // Add attributes if flash bit not set - only once every 4 rows of pixels - always draw on last line to ensure we cover the bottom row of the sprite
            if(--attrCountDown==0){
                uint8_t c=*(apSrc+(yAdd.u8[2]>>2));
                if( (c&0x80)==0 ){
                    for(int lIX=0;lIX<sWidthChars;lIX++){
                        int dstChar=lIX+xS;
                        if(dstChar>-1 && dstChar<SCREEN_WIDTH_CELLS){
                            *(aP+dstChar)=c;
                        }
                    }
                }
                aP+=SCREEN_WIDTH_CELLS;
                if(endLine-y>3){
                    attrCountDown=4;                    
                }else{
                    attrCountDown=endLine-y;
                }
            }
            rP+=SCREEN_WIDTH_CELLS;

        }
    }
}
