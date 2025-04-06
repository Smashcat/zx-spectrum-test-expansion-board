#pragma once

#include <stdint.h>
#include <math.h>

typedef struct Particle {
    float   x;
    float   y;
    float   xDir;
    float   yDir;
    int     timeToLive;
    int     delay;
} Particle;

static inline void setGravity(float newGravity)
{
    gravity=newGravity;
}

void initParticles(int totalParticles);
void deleteParticles(void);
void startParticles(int x, int y, int numParticles, float minAngle, float maxAngle, float minSpeed, float maxSpeed, int minAge, int maxAge);