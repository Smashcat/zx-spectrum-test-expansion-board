#include "Sprite.h"

void drawSprite(Sprite s)
{
    // If sprite has no group bits, it's not active
    if(s.groupBits==0){
        return;
    }
    
    const int xS=s.x>>3;   // Character cell to start in is the xPos/8
    const uint8_t frame=(s.x&0x07);    // 4 frames of animation for odd, and 4 for even positions
    const uint8_t *sDef=spriteDef+((s.defIX+frame)*96);    // Point to start of sprite foreground data
    const uint8_t *mDef=maskDef+((s.defIX+frame)*96);    // Point to start of sprite foreground data

    for(int y=s.y;y<s.y+24;y++){
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
