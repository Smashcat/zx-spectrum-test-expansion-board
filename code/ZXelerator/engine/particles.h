#pragma once

#define _USE_MATH_DEFINES
#include "defs.h"
#include <stdint.h>
#include <math.h>
#include "shared.h"
#include "TileLayer.h"

typedef struct Particle {
    float   x;
    float   y;
    float   xDir;
    float   yDir;
    int     timeToLive;
    int     delay;
    int     layer;
} Particle;

extern int particlesAlive;

void updateParticles(void);
void setGravity(float newGravity);
void initParticles(int totalParticles);
void deleteParticles(void);
void startParticles(int layer, int x, int y, int numParticles, float minAngle, float maxAngle, float minSpeed, float maxSpeed, int minAge, int maxAge);
void blitParticlesToScratchBuffers(int layer);