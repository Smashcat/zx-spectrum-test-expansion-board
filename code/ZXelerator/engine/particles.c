#include "particles.h"

Particle *particleList=NULL;
int totalParticles=0;
float gravity=0.0;

void initParticles(int newTotalParticles)
{
    if(totalParticles){
        deleteSprites();
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

void startParticles(int x, int y, int numParticles, float minAngle, float maxAngle, float minSpeed, float maxSpeed, int minAge, int maxAge)
{
    
}
