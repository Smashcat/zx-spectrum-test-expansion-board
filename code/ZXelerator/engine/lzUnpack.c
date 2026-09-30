#include "lzUnpack.h"

// Extra length bytes after a nibble of 15: each is added, until one is under 255
static inline int readLength(const uint8_t **sp, const uint8_t *srcEnd, int len)
{
    if(len==15){
        uint8_t b;
        do{
            if(*sp>=srcEnd){
                return -1;
            }
            b=*(*sp)++;
            len+=b;
        }while(b==255);
    }
    return len;
}

int lzUnpack(const uint8_t *src, int srcSize, uint8_t *dst, int dstSize)
{
    const uint8_t *sp=src;
    const uint8_t *srcEnd=src+srcSize;
    uint8_t *dp=dst;
    uint8_t *dstEnd=dst+dstSize;

    while(dp<dstEnd){
        if(sp>=srcEnd){
            return -1;
        }
        const uint8_t token=*sp++;

        // Literals
        const int litLen=readLength(&sp,srcEnd,token>>4);
        if(litLen<0 || litLen>(int)(srcEnd-sp) || litLen>(int)(dstEnd-dp)){
            return -1;
        }
        for(int n=0;n<litLen;n++){
            *dp++=*sp++;
        }
        if(dp>=dstEnd){
            break;
        }

        // Match - a copy of earlier output, which may overlap what it's copying
        if(srcEnd-sp<2){
            return -1;
        }
        const int offset=sp[0]|(sp[1]<<8);
        sp+=2;
        const int matchLen=readLength(&sp,srcEnd,token&15);
        if(matchLen<0 || offset==0 || offset>(int)(dp-dst) || matchLen+4>(int)(dstEnd-dp)){
            return -1;
        }
        const uint8_t *mp=dp-offset;
        for(int n=0;n<matchLen+4;n++){
            *dp++=*mp++;
        }
    }
    return (dp==dstEnd)?dstSize:-1;
}
