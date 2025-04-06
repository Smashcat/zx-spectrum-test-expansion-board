#include "Sprite.h"

Sprite *spriteList=NULL;
int totalSprites=0;

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
    s->size=st;
    switch(st){
        case SIZE_8X4:
        s->width=1;
        s->height=4;
        break;
        case SIZE_8X8:
        s->width=1;
        s->height=8;
        break;
        case SIZE_8X12:
        s->width=1;
        s->height=12;
        break;
        case SIZE_8X16:
        s->width=1;
        s->height=16;
        break;

        case SIZE_16X8:
        s->width=2;
        s->height=8;
        break;
        case SIZE_16X12:
        s->width=2;
        s->height=12;
        break;
        case SIZE_16X16:
        s->width=2;
        s->height=16;
        break;
        case SIZE_16X24:
        s->width=2;
        s->height=24;
        break;
        
        case SIZE_24X24:
        s->width=3;
        s->height=24;
        break;
        case SIZE_24X32:
        s->width=3;
        s->height=32;
        break;
        case SIZE_24X48:
        s->width=3;
        s->height=48;
        break;
        case SIZE_24X64:
        s->width=3;
        s->height=64;
        break;
    }
}

void blitSpritesToRenderBuffer(int layerIX)
{
    bool initedBuffers=false;
    for(int n=totalSprites-1;n>-1;n--){
        Sprite *s=spriteList+n;
        // If sprite is not in this layer, it's not shown
        // Also if it's not within the visible screen, it's not shown
        if(
            (s->layer!=layerIX) || 
            (s->y>191) || 
            (s->y<-23) || 
            (s->x<-23) || 
            (s->x>255)
        ){
            continue;
        }

        if(!initedBuffers){
            initScratchBuffers(false);
            initedBuffers=true;
        }

        switch(s->width){
            case 1:
                blitSprite8ToRenderBuffer(s);
                break;
            case 2:
                blitSprite16ToRenderBuffer(s);
                break;
            case 3:
                blitSprite24ToRenderBuffer(s);
                break;
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
