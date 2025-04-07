#include "particles.h"

Particle *particleList=NULL;
int totalParticles=0;
float gravity=0.0;
int particlesAlive=0;

/// @brief Only need one line for the particle pixels, as it's the same pattern repeated (2 px high, and 2 px wide)
const uint16_t particlePixel[8]={
    0b0110000000000000,
    0b0011000000000000,
    0b0001100000000000,
    0b0000110000000000,
    0b0000011000000000,
    0b0000001100000000,
    0b0000000110000000,
    0b0000000011000000
};

/// @brief Top and bottom mask pixel lines (only 2 pixels wide, so particle appears more rounded)
const uint16_t particleTBMask[8]={
    0b1001111111111111,
    0b1100111111111111,
    0b1110011111111111,
    0b1111001111111111,
    0b1111100111111111,
    0b1111110011111111,
    0b1111111001111111,
    0b1111111100111111
};

/// @brief Middle two mask pixel lines
const uint16_t particleMask[8]={
    0b0000111111111111,
    0b1000011111111111,
    0b1100001111111111,
    0b1110000111111111,
    0b1111000011111111,
    0b1111100001111111,
    0b1111110000111111,
    0b1111111000011111
};

void updateParticles(void)
{
    particlesAlive=0;
    for(int n=0;n<totalParticles;n++){
        Particle *p=particleList+n;
        if(p->timeToLive>0){
            ++particlesAlive;
            if(p->delay>0){
                --p->delay;
            }else{
                --p->timeToLive;
                p->x+=p->xDir;
                p->y+=p->yDir;
                p->yDir+=gravity;
                if(p->yDir>MAX_FALL_SPEED){
                    p->yDir=MAX_FALL_SPEED;
                }
            }
        }
    }
}

void setGravity(float newGravity)
{
    gravity=newGravity;
}

void initParticles(int newTotalParticles)
{
    if(totalParticles){
        deleteParticles();
    }
    totalParticles=newTotalParticles;
    particleList=(Particle *)malloc(totalParticles*sizeof(Particle));
    for(int n=0;n<totalParticles;n++){
        Particle *p=particleList+n;
        p->x=0;
        p->y=0;
        p->xDir=0;
        p->yDir=0;
        p->timeToLive=0;
        p->delay=0;
    }
}

void deleteParticles(void)
{
    totalParticles=0;
    if(particleList==NULL){
        return;
    }
    free(particleList);
    particleList=NULL;
}

float randF(float min, float max){
    if(max<min){
        float tmp=min;
        min=max;
        max=tmp;
    }
    return min+((float)rand()/(float)(RAND_MAX)) * (max-min);
}

void startParticles(int layer, int x, int y, int numParticles, float minAngle, float maxAngle, float minSpeed, float maxSpeed, int minAge, int maxAge)
{
    if(layer>=MAX_TILE_LAYERS){
        layer=MAX_TILE_LAYERS-1;
    }
    if(minAge>=maxAge){
        maxAge=minAge+1;
    }
    if(numParticles>totalParticles){
        numParticles=totalParticles;
    }
    int pIX=-1;
    int cDelay=0;
    for(int n=0;n<numParticles;n++){
        for(int i=pIX+1;i<totalParticles;i++){
            if(particleList[i].timeToLive==0){
                pIX=i;
                Particle *p=particleList+i;
                p->layer=layer;
                p->x=x;
                p->y=y;
                p->delay=cDelay;
                if(n==numParticles/2){
                    cDelay+=3;
                }
                p->timeToLive=minAge+(rand()%(maxAge-minAge));
                float angle=randF(minAngle,maxAngle);
                float speed=randF(minSpeed+cDelay,maxSpeed+cDelay);
                p->xDir=sin(angle)*speed;
                p->yDir=-cos(angle)*speed;
                break;
            }
        }
    }
}

void blitParticlesToScratchBuffers(int layer)
{
    for(int n=0;n<totalParticles;n++){
        Particle *p=particleList+n;
        if((p->timeToLive>0) && (p->layer==layer)){
            if(
                p->y>=SCREEN_HEIGHT_LINES || 
                p->y<=-4 ||
                p->x>=SCREEN_WIDTH_PIXELS ||
                p->x<=-4
            ){
                p->timeToLive=0;
                continue;
            }
            const int y=p->y;
            int yOff=(y*SCREEN_WIDTH_CELLS);
            const int xCell=((int)p->x)>>3;
            const int shiftRight=((int)p->x)&0x07;
            uint8_t *spr=scratchPixRam+yOff+xCell;
            uint8_t *smr=scratchMaskRam+yOff+xCell;
            const uint16_t tbMaskPix=particleTBMask[shiftRight];
            const uint8_t tbMaskPixLeft=(tbMaskPix>>8);
            const uint8_t tbMaskPixRight=(tbMaskPix&0xff);

            const uint16_t midMaskPix=particleMask[shiftRight];
            const uint8_t midMaskPixLeft=(midMaskPix>>8);
            const uint8_t midMaskPixRight=(midMaskPix&0xff);

            const uint16_t pix=particlePixel[shiftRight];
            const uint8_t pixLeft=(pix>>8);
            const uint8_t pixRight=(pix&0xff);
            
            if(y>-1){
                if(xCell>-1){*smr&=tbMaskPixLeft;}
                if(xCell<SCREEN_WIDTH_CELLS){*(smr+1)&=tbMaskPixRight;}
            }

            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            if((y>-2) && (y<SCREEN_HEIGHT_LINES-1)){
                if(xCell>-1){
                    *smr&=midMaskPixLeft;
                    *spr|=pixLeft;
                }
                if(xCell<SCREEN_WIDTH_CELLS){
                    *(smr+1)&=midMaskPixRight;
                    *(spr+1)|=pixRight;
                }
            }

            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            if((y>-3) && (y<SCREEN_HEIGHT_LINES-2)){
                if(xCell>-1){
                    *smr&=midMaskPixLeft;
                    *spr|=pixLeft;
                }
                if(xCell<SCREEN_WIDTH_CELLS){
                    *(smr+1)&=midMaskPixRight;
                    *(spr+1)|=pixRight;
                }
            }

            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            if(y<SCREEN_HEIGHT_LINES-3){
                if(xCell>-1){*smr&=tbMaskPixLeft;}
                if(xCell<SCREEN_WIDTH_CELLS){*(smr+1)&=tbMaskPixRight;}
            }

        }
    }
}
