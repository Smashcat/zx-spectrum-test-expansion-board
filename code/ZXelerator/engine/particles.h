#pragma once

#define _USE_MATH_DEFINES
#include "defs.h"
#include <stdint.h>
#include <stdbool.h>
#include <math.h>
#include "shared.h"
#include "TileLayer.h"

// Particles belong to particle sets. Each set is drawn straight after its layer (like sprites), has its own gravity,
// and can collide with that layer - the tile layer drawn just before the particles. Colliding particles bounce off the
// tiles, deflected by the shape of the tile pixels they hit (coarsely - one of 16 directions).

#define MAX_PARTICLE_SETS       8

/// @brief Particle set flag: particles collide with (and bounce off) the tile layer they're drawn over
#define PARTICLES_COLLIDE_LAYER 0x01

/// @brief Where a particle set's particles live (setParticleSetSpace)
typedef enum ParticleSpace {
    /// @brief Screen pixel coordinates (the default) - for effects on screen, e.g. sparks and explosions
    PARTICLE_SPACE_SCREEN,
    /// @brief The layer's own pixel coordinates - particles belong to the layer's world, so they scroll, rotate and
    /// scale with it. Collisions are simple tile map lookups, so this is also the fastest when the layer is rotated.
    /// Gravity still pulls down the screen. Particles off screen aren't removed (just not drawn). Scrolled, rotated and
    /// scaled layers only (not line transformed)
    PARTICLE_SPACE_LAYER
} ParticleSpace;

typedef struct Particle {
    // Position - the particle is drawn as a 2x2 block at pixels (x+1,y+1) to (x+2,y+2)
    float   x;
    float   y;
    // Velocity, in pixels per frame
    float   xDir;
    float   yDir;
    // Frames left to live (0 = not in use)
    int     timeToLive;
    // Frames before it starts moving
    int     delay;
    // The pixel it was on last frame, and how many frames it's stayed there (for the set's still limit)
    int16_t lastX;
    int16_t lastY;
    int     stillFrames;
} Particle;

typedef struct ParticleSet {
    Particle *particles;
    int     total;
    // Particles alive after the last update
    int     alive;
    // Drawn straight after this layer, and collides with it
    int     layer;
    // Added to yDir every frame
    float   gravity;
    // Fraction of the speed into a surface kept when bouncing off it (0 = stop dead, 1 = no loss)
    float   bounce;
    // Particles that stay on the same pixel for this many frames are removed (0 = never)
    int     stillLimit;
    // Screen or layer coordinates (setParticleSetSpace)
    ParticleSpace space;
    // PARTICLES_ flags
    uint8_t flags;
} ParticleSet;

extern ParticleSet particleSets[MAX_PARTICLE_SETS];

/// @brief Create a particle set
/// @param maxParticles Most particles the set can have alive at once
/// @param layer The layer the particles are drawn over (and collide with)
/// @return The set's index, or -1 if there are already MAX_PARTICLE_SETS sets
int createParticleSet(int maxParticles, int layer);

void deleteParticleSet(int setIX);

/// @brief Delete every particle set (e.g. when changing screens)
void deleteParticleSets(void);

void setParticleSetLayer(int setIX, int layer);
void setParticleSetGravity(int setIX, float gravity);

/// @brief Make the set's particles collide with and bounce off the tile layer they're drawn over
void setParticleSetCollisions(int setIX, bool collideWithLayer);

/// @brief How bouncy collisions are: the fraction of the speed into a surface kept (default 0.75)
void setParticleSetBounce(int setIX, float bounce);

/// @brief Remove particles that stay on the same pixel for this many frames - e.g. once they've settled on the ground
/// (default 25, one second). 0 keeps them until their time to live runs out
void setParticleSetStillLimit(int setIX, int frames);

/// @brief Choose whether a set's particles live in screen or layer coordinates (see ParticleSpace). Particles already
/// alive are converted, using the layer's current position, rotation and scale
void setParticleSetSpace(int setIX, ParticleSpace space);

/// @brief Start particles from a point, at random angles, speeds and lifetimes within the ranges given. Positions and
/// angles are in the set's space (screen or layer coordinates)
/// @param minAngle Angles in radians, 0 = up, increasing clockwise
void startParticles(int setIX, int x, int y, int numParticles, float minAngle, float maxAngle, float minSpeed,
    float maxSpeed, int minAge, int maxAge);

/// @brief Start a single particle (e.g. for fountains, sparks or trails). Position and velocity are in the set's space -
/// for a layer space set, screenToLayer and screenToLayerVector convert from screen coordinates
/// @param xDir Velocity in pixels per frame
/// @param timeToLive Frames it lives for
/// @return False if the set has no free particles
bool emitParticle(int setIX, float x, float y, float xDir, float yDir, int timeToLive);

/// @brief Number of particles alive in a set (after the last update)
int particlesAlive(int setIX);

/// @brief Move every particle set (called by compositeScene)
void updateParticles(void);

/// @brief Draw the particle sets that are drawn over a layer (called by compositeScene)
void blitParticlesToScratchBuffers(int layer);
