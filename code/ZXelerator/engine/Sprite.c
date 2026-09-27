#include "Sprite.h"
#include <math.h>
#include "pico.h"

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
        s->offX=500;
        s->offY=0;
        s->defPtr=NULL;
        s->frame=0;
        s->isScaled=0;
        s->scaleX=1.0f;
        s->scaleY=1.0f;
        s->angle=0.0f;
        s->isRotated=0;
        s->delay=0;
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

        case SIZE_32X40:
        s->width=32;
        s->height=40;
        break;
    }
    s->size=st;
    s->scaledWidth=s->width;
    s->scaledHeight=s->height;
    s->offX=s->x-(s->scaledWidth/2);
    s->offY=s->y-(s->scaledHeight/2);
    s->isScaled=0;
    s->bytesPerRow = (s->width==24?4:(s->width >> 3));  // 24bit wide sprites actually span 4 bytes for faster 32-bit aligned reads
    if(s->isRotated){
        updateSpriteTransform(s);
    }
}

void setSpriteRotation(int ix, float angle)
{
    Sprite *s=spriteList+ix;
    const float twoPi=2.0f*(float)M_PI;
    angle=fmodf(angle,twoPi);
    if(angle>(float)M_PI){
        angle-=twoPi;
    }else if(angle<-(float)M_PI){
        angle+=twoPi;
    }
    s->angle=angle;
    s->isRotated=(fabsf(angle)>0.0001f)?1:0;
    if(s->isRotated){
        updateSpriteTransform(s);
    }else{
        // Back to the unrotated renderers - restore the unrotated scaled size and position
        setSpriteScale(ix,s->isScaled?s->scaleX:0.0f,s->isScaled?s->scaleY:0.0f);
    }
}

void updateSpriteTransform(Sprite *s)
{
    const float sx=s->isScaled?s->scaleX:1.0f;
    const float sy=s->isScaled?s->scaleY:1.0f;
    const float c=cosf(s->angle);
    const float sn=sinf(s->angle);

    // Inverse of rotate then scale, so each screen pixel can be mapped back to a sprite pixel
    s->fDudx=c/sx;
    s->fDudy=sn/sx;
    s->fDvdx=-sn/sy;
    s->fDvdy=c/sy;
    s->invDudx=FIXED16(s->fDudx);
    s->invDudy=FIXED16(s->fDudy);
    s->invDvdx=FIXED16(s->fDvdx);
    s->invDvdy=FIXED16(s->fDvdy);

    // Bounding box of the rotated sprite (plus a pixel of margin), used for clipping and culling
    const float hw=(float)s->width*sx*0.5f;
    const float hh=(float)s->height*sy*0.5f;
    const int ex=(int)ceilf((fabsf(c)*hw)+(fabsf(sn)*hh))+1;
    const int ey=(int)ceilf((fabsf(sn)*hw)+(fabsf(c)*hh))+1;
    s->scaledWidth=ex*2;
    s->scaledHeight=ey*2;
    s->offX=s->x-ex;
    s->offY=s->y-ey;
}

void blitSpritesToRenderBuffer(int layerIX)
{
    for(int n=totalSprites-1;n>-1;n--){
        Sprite *s=spriteList+n;
        // If sprite is not in this layer, it's not shown
        // Also if it's not within the visible screen, it's not shown
        if(
            (s->layer!=layerIX) || 
            (s->offY>=SCREEN_HEIGHT_LINES) || 
            (s->offY<=-(s->scaledHeight)) || 
            (s->offX<=-(s->scaledWidth)) || 
            (s->offX>=SCREEN_WIDTH_PIXELS)
        ){
            continue;
        }

        if(s->isRotated){
            blitSpriteTransformedToRenderBuffer(s);
        }else if(s->isScaled){
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
                case 32:
                    blitSprite24ToRenderBuffer(s);
                    break;
            }
        }
    }
}

void blitSprite8ToRenderBuffer(Sprite *s)
{
    const int spriteHeight=s->height;
    const int xS=s->offX>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->offX&0x07;
    const uint8_t *sDef=(uint8_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint8_t *mDef=(uint8_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->offY*SCREEN_WIDTH_CELLS);

    for(int y=s->offY;y<s->offY+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint16_t src16=  (*sDef<<8)>>shiftRight;
            uint16_t mask16=(((*mDef<<8)+0xff)>>shiftRight)|(0xffffu<<(16-shiftRight));
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

    const int startY=(s->offY/ATTR_HEIGHT_PIXELS);
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
    const int xS=s->offX>>3;                                           // Character cell to start in is the xPos/8
    const int shiftRight=s->offX&0x07;
    const uint16_t *sDef=(uint16_t *)s->defPtr+(s->frame*spriteHeight);       // Point to start of sprite foreground data
    const uint16_t *mDef=(uint16_t *)s->maskPtr+(s->frame*spriteHeight);      // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->offY*SCREEN_WIDTH_CELLS);

    for(int y=s->offY;y<s->offY+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint32_t src32= *sDef;
            uint32_t mask32=*mDef;
            src32=  ((src32<<24)  |((src32&0xff00)<<8))>>shiftRight;
            mask32= (((mask32<<24)|((mask32&0xff00)<<8)|0xffff)>>shiftRight)|(shiftRight?(0xffffffffu<<(32-shiftRight)):0);
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

    const int startY=(s->offY/ATTR_HEIGHT_PIXELS);
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
    const int xS=s->offX>>3;                                                    // Character cell to start in is the xPos/8
    const int shiftRight=s->offX&0x07;
    const bool is32=(s->width==32);
    const uint32_t *sDef=(uint32_t *)s->defPtr+(s->frame*spriteHeight);         // Point to start of sprite foreground data
    const uint32_t *mDef=(uint32_t *)s->maskPtr+(s->frame*spriteHeight);        // Point to start of sprite mask data
    uint8_t *rP=(uint8_t *)renderBuffer+(s->offY*SCREEN_WIDTH_CELLS);

    for(int y=s->offY;y<s->offY+spriteHeight;y++){
        if(y>-1 && y<SCREEN_HEIGHT_LINES){
            // Need to reverse the order of the bytes in the word so we can do a single shift operation
            uint32_t src32= ((*sDef<<24)+((*sDef&0x0000ff00)<<8)+((*sDef&0x00ff0000)>>8)+(*sDef>>24))>>shiftRight;
            uint32_t mask32=(((*mDef<<24)+((*mDef&0x0000ff00)<<8)+((*mDef&0x00ff0000)>>8)+(*mDef>>24))>>shiftRight)|(shiftRight?(0xffffffffu<<(32-shiftRight)):0);
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
            // 32 pixel wide sprites spill into a 5th byte when not character aligned - these are the bits shifted
            // out of the right of the 32 bit word above (the last source byte is the top byte of the word)
            if(is32 && shiftRight && xS>-5 && xS<(SCREEN_WIDTH_CELLS-4)){
                *(rP+xS+4)&=(uint8_t)(((*mDef>>24)<<(8-shiftRight))|(0xffu>>shiftRight));
                *(rP+xS+4)|=(uint8_t)((*sDef>>24)<<(8-shiftRight));
            }

        }
        rP+=SCREEN_WIDTH_CELLS;
        ++sDef;
        ++mDef;
    }

    const int startY=(s->offY/ATTR_HEIGHT_PIXELS);
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
            if(xS>-4 && xS<(SCREEN_WIDTH_CELLS-3)  && ((shiftRight>0) || is32)){
                *(aP+xS+3)=apS;
            }
            if(xS>-5 && xS<(SCREEN_WIDTH_CELLS-4) && is32 && (shiftRight>0)){
                *(aP+xS+4)=apS;
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
    const int sY=s->offY;
    const int bpr=s->bytesPerRow;
    const int xS=s->offX>>3;                                                  // Character cell to start in is the xPos/8
    const int dstStartBitPos=7-(s->offX&0x07);
    const uint8_t *sDefBase=(uint8_t *)s->defPtr+(s->frame*s->height*s->bytesPerRow);       // Point to start of sprite foreground data
    const uint8_t *mDefBase=(uint8_t *)s->maskPtr+(s->frame*s->height*s->bytesPerRow);      // Point to start of sprite mask data
    const uint8_t *apSrc=palette[s->paletteIX];
    const int endLine=(sY+sHeight>SCREEN_HEIGHT_LINES?SCREEN_HEIGHT_LINES:sY+sHeight);
    const int sWidthChars=(sWidth>>3)+1;

    U32u8 xAdd,yAdd;
    yAdd.u32 = 0;
    uint8_t lByte = 255;

    // If the sprite starts above the screen, skip the source rows that are off screen, so drawing starts at the top
    // line of the buffers (and not before them)
    int firstLine=sY;
    if(firstLine<0){
        yAdd.u32=(uint32_t)(-firstLine)*s->scaledHeightAdder.u32;
        firstLine=0;
    }
    uint8_t *rP=(uint8_t *)renderBuffer+(firstLine*SCREEN_WIDTH_CELLS);
    uint8_t *aP=renderAttrBuffer+((firstLine/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS);
    int attrCountDown=1;

    memset(pixLineBuffer,0,lineBufferLen);
    memset(maskLineBuffer,0xff,lineBufferLen);
    for(int y=firstLine;y<endLine;y++){
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


void __no_inline_not_in_flash_func(blitSpriteTransformedToRenderBuffer)(Sprite *s)
{
    const int w=s->width;
    const int h=s->height;
    const int bpr=s->bytesPerRow;
    const uint8_t *sDef=s->defPtr+(s->frame*h*bpr);      // Point to start of sprite foreground data
    const uint8_t *mDef=s->maskPtr+(s->frame*h*bpr);     // Point to start of sprite mask data
    const uint8_t *apSrc=palette[s->paletteIX];
    const int maxPaletteIX=(int)sizeof(palette[0])-1;
    const int32_t limU=w<<16;
    const int32_t limV=h<<16;
    const int32_t du=s->invDudx;
    const int32_t dv=s->invDvdx;

    // Bounding box, clipped to the screen
    int x0=s->offX;
    int x1=s->offX+s->scaledWidth;
    int y0=s->offY;
    int y1=s->offY+s->scaledHeight;
    if(x0<0){
        x0=0;
    }
    if(x1>SCREEN_WIDTH_PIXELS){
        x1=SCREEN_WIDTH_PIXELS;
    }
    if(y0<0){
        y0=0;
    }
    if(y1>SCREEN_HEIGHT_LINES){
        y1=SCREEN_HEIGHT_LINES;
    }
    if(x0>=x1 || y0>=y1){
        return;
    }

    // Sprite position sampled at the centre of screen pixel (x0,y0), stepped along each line and down each row
    const float centreU=(float)w*0.5f;
    const float centreV=(float)h*0.5f;
    const float relX=((float)x0+0.5f)-(float)s->x;
    const float relY=((float)y0+0.5f)-(float)s->y;
    int32_t rowU=FIXED16(centreU+(s->fDudx*relX)+(s->fDudy*relY));
    int32_t rowV=FIXED16(centreV+(s->fDvdx*relX)+(s->fDvdy*relY));

    uint8_t *rP=(uint8_t *)renderBuffer+(y0*SCREEN_WIDTH_CELLS);
    uint32_t cellsUsed=0;   // One bit per character column the sprite drew solid pixels in, for the current attribute row

    for(int y=y0;y<y1;y++){
        // Only visit the pixels on this line that land inside the sprite
        int start=0, end=x1-x0;
        clipSpan(rowU,du,limU,&start,&end);
        clipSpan(rowV,dv,limV,&start,&end);
        if(start<end){
            int32_t u=rowU+(start*du);
            int32_t v=rowV+(start*dv);
            int x=x0+start;
            const int xEnd=x0+end;
            while(x<xEnd){
                // Build up to 8 pixels for this character cell, then combine with the render buffer using the mask
                const int cell=x>>3;
                const int cellEnd=((cell+1)*8<xEnd)?(cell+1)*8:xEnd;
                uint32_t pix=0;
                uint32_t keep=0xff;
                for(;x<cellEnd;x++){
                    const int32_t ui=u>>16;
                    const int off=((v>>16)*bpr)+(ui>>3);
                    const int sh=ui&7;
                    const uint32_t bit=0x80>>(x&7);
                    if((sDef[off]<<sh)&0x80){
                        pix|=bit;
                    }
                    if(((mDef[off]<<sh)&0x80)==0){
                        keep&=~bit;
                    }
                    u+=du;
                    v+=dv;
                }
                rP[cell]=(uint8_t)((rP[cell]&keep)|pix);
                if(keep!=0xff){
                    cellsUsed|=1u<<cell;
                }
            }
        }
        rowU+=s->invDudy;
        rowV+=s->invDvdy;
        rP+=SCREEN_WIDTH_CELLS;

        // At the end of each 8x4 attribute row, colour the cells the sprite covered, using the palette entry for
        // the sprite row found at the centre of each cell (flash bit set means leave the cell alone)
        if((((y&(ATTR_HEIGHT_PIXELS-1))==(ATTR_HEIGHT_PIXELS-1)) || (y==y1-1)) && cellsUsed){
            const int cy=y/ATTR_HEIGHT_PIXELS;
            uint8_t *aP=renderAttrBuffer+(cy*SCREEN_WIDTH_CELLS);
            const float relCY=((float)((cy*ATTR_HEIGHT_PIXELS)+(ATTR_HEIGHT_PIXELS/2))+0.5f)-(float)s->y;
            for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                if((cellsUsed&(1u<<cx))==0){
                    continue;
                }
                const float relCX=((float)((cx*8)+4)+0.5f)-(float)s->x;
                int srcRow=(int)floorf(centreV+(s->fDvdx*relCX)+(s->fDvdy*relCY));
                if(srcRow<0){
                    srcRow=0;
                }else if(srcRow>=h){
                    srcRow=h-1;
                }
                int pIX=srcRow/ATTR_HEIGHT_PIXELS;
                if(pIX>maxPaletteIX){
                    pIX=maxPaletteIX;
                }
                const uint8_t c=apSrc[pIX];
                if((c&0x80)==0){
                    aP[cx]=c;
                }
            }
            cellsUsed=0;
        }
    }
}
