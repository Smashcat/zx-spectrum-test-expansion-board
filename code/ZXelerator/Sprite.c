#include "Sprite.h"

Sprite *spriteList=NULL;
int totalSprites=0;

void initSprites(int numSprites)
{
    spriteList=(Sprite *)malloc(numSprites*sizeof(Sprite));
    totalSprites=numSprites;
    for(int n=0;n<numSprites;n++){
        Sprite *s=spriteList+n;
        s->groupBits=0;
        s->collideGroupBits=0;
        s->x=500;
        s->y=0;
        s->defIX=-1;
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


void drawSprite(int ix)
{
    Sprite *s=spriteList+ix;
    // If sprite has no group bits, it's not active
    if(s->groupBits==0){
        return;
    }
    
    const int xS=s->x>>3;   // Character cell to start in is the xPos/8
    const uint8_t frame=(s->x&0x07);    // 4 frames of animation for odd, and 4 for even positions
    const uint8_t *sDef=spriteDef+((s->defIX+frame)*96);    // Point to start of sprite foreground data
    const uint8_t *mDef=maskDef+((s->defIX+frame)*96);    // Point to start of sprite foreground data

    for(int y=s->y;y<s->y+24;y++){
        if(y>-1 && y<192){
            int yRow=(y*32);
            for(int x=xS;x<xS+4;x++){
                if((x>-1) && (x<32) && (*sDef!=0)){
                    int ix=yRow+x;
                    uint8_t sByte=ram[writeBank][0][dispOffset[ix]];
                    sByte&=*mDef++;
                    sByte|=*sDef++;
                    ram[writeBank][0][dispOffset[ix]]=sByte;
                }else{
                    ++mDef;
                    ++sDef;
                }
            }
        }else{
            sDef+=4;
            mDef+=4;
        }
    }
}

void blitSpritesToRenderBuffer(int layerIX)
{
    bool initedBuffers=false;
    for(int n=totalSprites-1;n>-1;n--){
        Sprite *s=spriteList+n;
        // If sprite has no group bits, it's not active, if it's not in this layer, it's not shown
        // Also if it's not on screen, it's not shown
        if( (s->groupBits==0) || 
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

        const int xS=s->x>>3;                                   // Character cell to start in is the xPos/8
        const int shiftRight=s->x&0x07;
        const uint32_t *sDef=(uint32_t *)spriteDef+((s->defIX+s->frame)*24);    // Point to start of sprite foreground data
        const uint32_t *mDef=(uint32_t *)maskDef+((s->defIX+s->frame)*24);      // Point to start of sprite foreground data
        uint8_t *rP=(uint8_t *)renderBuffer+(s->y*SCREEN_WIDTH_CELLS);

        for(int y=s->y;y<s->y+24;y++){
            if(y>-1 && y<192){
                // Need to reverse the order of the bytes in the word so we can do a single shift operation
                uint32_t src32= ((*sDef<<24)+((*sDef&0x0000ff00)<<8)+((*sDef&0x00ff0000)>>8)+(*sDef>>24))>>shiftRight;
                uint32_t mask32=(((*mDef<<24)+((*mDef&0x0000ff00)<<8)+((*mDef&0x00ff0000)>>8)+(*mDef>>24))>>shiftRight)|(0xffffffff<<(32-shiftRight));
                if(xS>-1){
                    *(rP+xS)&=(uint8_t)(mask32>>24);
                    *(rP+xS)|=(uint8_t)(src32>>24);
                }
                if(xS>-2 && xS<31){
                    *(rP+xS+1)&=(uint8_t)(mask32>>16);
                    *(rP+xS+1)|=(uint8_t)(src32>>16);
                }
                if(xS>-3 && xS<30){
                    *(rP+xS+2)&=(uint8_t)(mask32>>8);
                    *(rP+xS+2)|=(uint8_t)(src32>>8);
                }
                if(xS>-4 && xS<29){
                    *(rP+xS+3)&=(uint8_t)(mask32);
                    *(rP+xS+3)|=(uint8_t)(src32);
                }

            }
            rP+=SCREEN_WIDTH_CELLS;
            ++sDef;
            ++mDef;
        }

        const int startY=(s->y>>2);
        uint8_t *aP=renderAttrBuffer+(startY*SCREEN_WIDTH_CELLS);
        const uint8_t *apSrc=palette[s->paletteIX];
        for(int y=startY;y<startY+6;y++){
            const uint8_t apS=*apSrc;
            if(y>-1 && y<ATTR_HEIGHT_CELLS && ((apS&0x80)==0)){
                if(xS>-1){
                    *(aP+xS)=apS;
                }
                if(xS>-2 && xS<31){
                    *(aP+xS+1)=apS;
                }
                if(xS>-3 && xS<30){
                    *(aP+xS+2)=apS;
                }
                if(xS>-4 && xS<29  && (shiftRight>3)){
                    *(aP+xS+3)=apS;
                }
            }
            ++apSrc;
            aP+=SCREEN_WIDTH_CELLS;
        }
    }
}
