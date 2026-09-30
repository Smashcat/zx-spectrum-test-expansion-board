#include "lzPack.h"

#include <stdlib.h>
#include <string.h>

#define MIN_MATCH       4
#define MAX_OFFSET      65535
#define HASH_BITS       16
#define CHAIN_DEPTH     256
#define MAX_CANDIDATES  4
// Past this length, the next position's match is taken as this one less a byte (instead of searching again), so long
// runs pack in linear time
#define LONG_MATCH      64
// Every length up to this is tried for each candidate match (and each candidate's full length)
#define TRY_LENGTHS     48

typedef struct Candidate {
    int offset;
    int len;
} Candidate;

static uint32_t hash4(const uint8_t *p)
{
    const uint32_t v=(uint32_t)p[0]|((uint32_t)p[1]<<8)|((uint32_t)p[2]<<16)|((uint32_t)p[3]<<24);
    return (v*2654435761u)>>(32-HASH_BITS);
}

// Bytes a match of this length costs: token, offset, and any extra length bytes
static int matchCost(int len)
{
    const int extra=len-MIN_MATCH;
    return 3+((extra>=15)?1+((extra-15)/255):0);
}

static int writeLength(uint8_t *dst, int len)
{
    // The nibble held 15 - the rest follows in bytes, each added until one is under 255
    int n=0;
    len-=15;
    while(len>=255){
        dst[n++]=255;
        len-=255;
    }
    dst[n++]=(uint8_t)len;
    return n;
}

int lzPack(const uint8_t *src, int n, uint8_t *dst)
{
    if(n<=0){
        return 0;
    }
    Candidate *cands=calloc((size_t)n*MAX_CANDIDATES,sizeof(Candidate));
    int *head=malloc(sizeof(int)<<HASH_BITS);
    int *prev=malloc(sizeof(int)*(size_t)n);
    int *cost=malloc(sizeof(int)*((size_t)n+1));
    int *choiceLen=malloc(sizeof(int)*((size_t)n+1));
    int *choiceOff=malloc(sizeof(int)*((size_t)n+1));
    for(int h=0;h<(1<<HASH_BITS);h++){
        head[h]=-1;
    }

    // Matches at each position (the longest few at different offsets)
    for(int i=0;i+MIN_MATCH<=n;i++){
        const uint32_t h=hash4(src+i);
        Candidate *c=cands+((size_t)i*MAX_CANDIDATES);
        const Candidate *pc=(i>0)?c-MAX_CANDIDATES:NULL;
        if(pc && pc[0].len>LONG_MATCH){
            // Inside a long match - it carries on from here, a byte shorter
            c[0].offset=pc[0].offset;
            c[0].len=pc[0].len-1;
        }else{
            int found=0;
            int depth=0;
            for(int j=head[h];j>=0 && (i-j)<=MAX_OFFSET && depth<CHAIN_DEPTH;j=prev[j],depth++){
                int len=0;
                const int maxLen=n-i;
                while(len<maxLen && src[j+len]==src[i+len]){
                    ++len;
                }
                if(len<MIN_MATCH){
                    continue;
                }
                // Keep the longest few (nearer offsets are found first, so ties keep the nearest)
                if(found<MAX_CANDIDATES){
                    c[found].offset=i-j;
                    c[found].len=len;
                    ++found;
                }else{
                    int worst=0;
                    for(int k=1;k<MAX_CANDIDATES;k++){
                        if(c[k].len<c[worst].len){
                            worst=k;
                        }
                    }
                    if(len>c[worst].len){
                        c[worst].offset=i-j;
                        c[worst].len=len;
                    }
                }
                if(len==maxLen){
                    break;
                }
            }
        }
        prev[i]=head[h];
        head[h]=i;
    }

    // Cheapest way to pack from each position to the end (literals cost a byte each - their share of tokens and extra
    // length bytes is small enough to leave out)
    cost[n]=0;
    for(int i=n-1;i>=0;i--){
        cost[i]=cost[i+1]+1;
        choiceLen[i]=0;
        choiceOff[i]=0;
        if(i+MIN_MATCH>n){
            continue;
        }
        const Candidate *c=cands+((size_t)i*MAX_CANDIDATES);
        for(int k=0;k<MAX_CANDIDATES;k++){
            const int len=c[k].len;
            if(len<MIN_MATCH){
                continue;
            }
            const int tryTo=(len<TRY_LENGTHS)?len:TRY_LENGTHS;
            for(int l=MIN_MATCH;l<=tryTo+1;l++){
                const int L=(l>tryTo)?len:l;
                const int total=matchCost(L)+cost[i+L];
                if(total<cost[i]){
                    cost[i]=total;
                    choiceLen[i]=L;
                    choiceOff[i]=c[k].offset;
                }
            }
        }
    }

    // Write the sequences
    int out=0;
    int i=0;
    while(i<n){
        const int litStart=i;
        while(i<n && choiceLen[i]==0){
            ++i;
        }
        const int litLen=i-litStart;
        const int matchLen=(i<n)?choiceLen[i]:0;
        uint8_t *token=dst+out++;
        *token=(uint8_t)(((litLen<15)?litLen:15)<<4);
        if(litLen>=15){
            out+=writeLength(dst+out,litLen);
        }
        memcpy(dst+out,src+litStart,(size_t)litLen);
        out+=litLen;
        if(i>=n){
            break;
        }
        const int offset=choiceOff[i];
        dst[out++]=(uint8_t)(offset&0xff);
        dst[out++]=(uint8_t)(offset>>8);
        const int extra=matchLen-MIN_MATCH;
        *token|=(uint8_t)((extra<15)?extra:15);
        if(extra>=15){
            out+=writeLength(dst+out,extra);
        }
        i+=matchLen;
    }

    free(cands);
    free(head);
    free(prev);
    free(cost);
    free(choiceLen);
    free(choiceOff);
    return out;
}
