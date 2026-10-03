#include "particles.h"
#include "pico.h"

ParticleSet particleSets[MAX_PARTICLE_SETS];

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

// Surface directions for bouncing - 16 directions around the circle (0 = pointing right, clockwise on screen)
#define DEFLECT_DIRECTIONS  16
static float deflectX[DEFLECT_DIRECTIONS];
static float deflectY[DEFLECT_DIRECTIONS];
static bool deflectBuilt=false;

// Bounces slower than this (pixels per frame, away from the surface) just stop moving into it, so particles settle
// and slide instead of jittering
#define MIN_BOUNCE_SPEED    0.4f

static void buildDeflectTable(void)
{
    if(deflectBuilt){
        return;
    }
    for(int n=0;n<DEFLECT_DIRECTIONS;n++){
        const float a=(float)n*(2.0f*(float)M_PI/(float)DEFLECT_DIRECTIONS);
        float c=cosf(a), s=sinf(a);
        // Exact zeros, so flat and vertical surfaces only change one direction
        if(fabsf(c)<0.0001f){
            c=0.0f;
        }
        if(fabsf(s)<0.0001f){
            s=0.0f;
        }
        deflectX[n]=c;
        deflectY[n]=s;
    }
    deflectBuilt=true;
}

int createParticleSet(int maxParticles, int layer)
{
    buildDeflectTable();
    for(int n=0;n<MAX_PARTICLE_SETS;n++){
        ParticleSet *set=particleSets+n;
        if(set->particles==NULL){
            set->particles=(Particle *)calloc((size_t)maxParticles,sizeof(Particle));
            if(set->particles==NULL){
                return -1;
            }
            set->total=maxParticles;
            set->alive=0;
            set->layer=(layer<0)?0:((layer>=MAX_TILE_LAYERS)?MAX_TILE_LAYERS-1:layer);
            set->gravity=0.0f;
            set->bounce=0.75f;
            set->stillLimit=25;
            set->space=PARTICLE_SPACE_SCREEN;
            set->flags=0;
            return n;
        }
    }
    return -1;
}

void deleteParticleSet(int setIX)
{
    if(setIX<0 || setIX>=MAX_PARTICLE_SETS){
        return;
    }
    ParticleSet *set=particleSets+setIX;
    free(set->particles);
    set->particles=NULL;
    set->total=0;
    set->alive=0;
}

void deleteParticleSets(void)
{
    for(int n=0;n<MAX_PARTICLE_SETS;n++){
        deleteParticleSet(n);
    }
}

void setParticleSetLayer(int setIX, int layer)
{
    particleSets[setIX].layer=(layer<0)?0:((layer>=MAX_TILE_LAYERS)?MAX_TILE_LAYERS-1:layer);
}

void setParticleSetGravity(int setIX, float gravity)
{
    particleSets[setIX].gravity=gravity;
}

void setParticleSetCollisions(int setIX, bool collideWithLayer)
{
    if(collideWithLayer){
        particleSets[setIX].flags|=PARTICLES_COLLIDE_LAYER;
    }else{
        particleSets[setIX].flags&=(uint8_t)~PARTICLES_COLLIDE_LAYER;
    }
}

void setParticleSetSpace(int setIX, ParticleSpace space)
{
    ParticleSet *set=particleSets+setIX;
    if(set->particles==NULL || set->space==space){
        set->space=space;
        return;
    }
    // Convert the particles alive - their block centre (x+2,y+2), and velocity
    for(int n=0;n<set->total;n++){
        Particle *p=set->particles+n;
        if(p->timeToLive<=0){
            continue;
        }
        float cx, cy, vx, vy;
        if(space==PARTICLE_SPACE_LAYER){
            screenToLayer(set->layer,p->x+2.0f,p->y+2.0f,&cx,&cy);
            screenToLayerVector(set->layer,p->xDir,p->yDir,&vx,&vy);
        }else{
            layerToScreen(set->layer,p->x+2.0f,p->y+2.0f,&cx,&cy);
            layerToScreenVector(set->layer,p->xDir,p->yDir,&vx,&vy);
        }
        p->x=cx-2.0f;
        p->y=cy-2.0f;
        p->xDir=vx;
        p->yDir=vy;
        p->lastX=INT16_MIN;
        p->lastY=INT16_MIN;
        p->stillFrames=0;
    }
    set->space=space;
}

void setParticleSetStillLimit(int setIX, int frames)
{
    particleSets[setIX].stillLimit=frames;
}

void setParticleSetBounce(int setIX, float bounce)
{
    particleSets[setIX].bounce=bounce;
}

int particlesAlive(int setIX)
{
    return (setIX<0 || setIX>=MAX_PARTICLE_SETS)?0:particleSets[setIX].alive;
}

// The direction gravity pulls in the set being updated, in the set's coordinates (for layer space sets, down the screen
// turned into layer coordinates)
static float gravityX, gravityY;

/// @brief n pixels of the set's layer, starting at x,y in the set's space (screen or layer coordinates), in the top n bits.
/// Only the pixels needed are read
static inline uint32_t setPixels(const ParticleSet *set, int x, int y, int n)
{
    return (set->space==PARTICLE_SPACE_LAYER)?getLayerMapPixels(set->layer,x,y,n):getLayerPixelsN(set->layer,x,y,n);
}

/// @brief True if the particle's 2x2 block, at whole pixel position px,py, touches any tile pixels of the layer
static inline bool blockHitsLayer(const ParticleSet *set, int px, int py)
{
    return (setPixels(set,px+1,py+1,2)|setPixels(set,px+1,py+2,2))!=0;
}

/// @brief The direction pointing away from the solid tile pixels around a particle block at hx,hy (e.g. straight up
/// for a flat floor), rounded to one of 16 directions
/// @return False if there's no clear direction (no solid pixels, or solid all round)
static bool surfaceDirection(const ParticleSet *set, int hx, int hy, int *dir)
{
    // Solid pixels in the 6x6 area centred on the block (hx+1..hx+2, hy+1..hy+2), as offsets from its centre (x2)
    int sumX=0, sumY=0;
    for(int r=0;r<6;r++){
        const uint32_t bits=setPixels(set,hx-1,hy-1+r,6)>>26;
        for(int c=0;c<6;c++){
            if(bits&(0x20u>>c)){
                sumX+=(2*c)-5;
                sumY+=(2*r)-5;
            }
        }
    }
    if(sumX==0 && sumY==0){
        return false;
    }
    *dir=((int)lroundf(atan2f((float)-sumY,(float)-sumX)/(2.0f*(float)M_PI/(float)DEFLECT_DIRECTIONS)))&(DEFLECT_DIRECTIONS-1);
    return true;
}

/// @brief Bounce a particle that hit the layer with its block at hx,hy. The surface direction comes from the solid tile
/// pixels around the block (see surfaceDirection), and the velocity is reflected off it
/// @return True if it bounced, false if it was too slow to bounce, and now slides along the surface instead
static bool bounceParticle(const ParticleSet *set, Particle *p, int hx, int hy)
{
    const float vx=p->xDir;
    const float vy=p->yDir;
    int dir;
    if(!surfaceDirection(set,hx,hy,&dir)){
        // No clear surface (e.g. surrounded) - send it back the way it came
        dir=((int)lroundf(atan2f(-vy,-vx)/(2.0f*(float)M_PI/(float)DEFLECT_DIRECTIONS)))&(DEFLECT_DIRECTIONS-1);
    }
    float nx=deflectX[dir];
    float ny=deflectY[dir];

    float into=(vx*nx)+(vy*ny);
    if(into>=0.0f){
        // It hit something, but isn't moving into the surface found - e.g. falling onto a point or edge, where the solid
        // pixels are mostly to one side. Use a direction between that surface and straight back the way it came, so it
        // tips off the side it isn't supported on (rather than bouncing straight back, and landing in the same place)
        const float speed=sqrtf((vx*vx)+(vy*vy));
        const float bx=nx-(vx/speed);
        const float by=ny-(vy/speed);
        dir=((int)lroundf(atan2f(by,bx)/(2.0f*(float)M_PI/(float)DEFLECT_DIRECTIONS)))&(DEFLECT_DIRECTIONS-1);
        nx=deflectX[dir];
        ny=deflectY[dir];
        into=(vx*nx)+(vy*ny);
    }

    // Reflect the speed into the surface (losing some), or if that's slow, just stop moving into it. The threshold
    // grows with gravity, as a resting particle falls back onto the surface a little faster each frame
    const float minBounce=fmaxf(MIN_BOUNCE_SPEED,3.0f*fabsf(set->gravity));
    const float keep=((-into)*set->bounce>=minBounce)?(1.0f+set->bounce):1.0f;
    p->xDir=vx-(keep*into*nx);
    p->yDir=vy-(keep*into*ny);
    return keep>1.0f;
}

/// @brief A moving layer (e.g. scrolling or rotating) can sweep into a particle - push it back out, along the surface
/// direction, and stop it moving into the surface (so the surface carries it)
/// @return False if it's buried too deep to push out (e.g. it was started inside something)
static bool pushOutParticle(const ParticleSet *set, Particle *p, int sx, int sy)
{
    int dir;
    if(!surfaceDirection(set,sx,sy,&dir)){
        // No clear surface - push it up (against gravity)
        dir=(gravityX==0.0f && gravityY==0.0f)?(DEFLECT_DIRECTIONS*3/4):
            (((int)lroundf(atan2f(-gravityY,-gravityX)/(2.0f*(float)M_PI/(float)DEFLECT_DIRECTIONS)))&(DEFLECT_DIRECTIONS-1));
    }
    const float nx=deflectX[dir];
    const float ny=deflectY[dir];
    for(int d=1;d<=4;d++){
        const int px=sx+(int)lroundf(nx*(float)d);
        const int py=sy+(int)lroundf(ny*(float)d);
        if(!blockHitsLayer(set,px,py)){
            p->x=(float)px+0.5f;
            p->y=(float)py+0.5f;
            const float into=(p->xDir*nx)+(p->yDir*ny);
            if(into<0.0f){
                p->xDir-=into*nx;
                p->yDir-=into*ny;
            }
            return true;
        }
    }
    return false;
}

/// @brief Move a particle by its velocity. If it collides with the layer, it's traced a pixel at a time, to find the
/// first tile pixels it hits along its path - it stops just before them and bounces
static void __no_inline_not_in_flash_func(moveParticle)(const ParticleSet *set, Particle *p)
{
    const float dx=p->xDir;
    const float dy=p->yDir;
    if((set->flags&PARTICLES_COLLIDE_LAYER)==0){
        p->x+=dx;
        p->y+=dy;
        return;
    }

    const int sx=(int)p->x;
    const int sy=(int)p->y;
    const int ex=(int)(p->x+dx);
    const int ey=(int)(p->y+dy);
    // Nothing solid anywhere along the way (the usual case). In layer space this works however the layer is rotated
    const int ax0=((sx<ex)?sx:ex)+1, ay0=((sy<ey)?sy:ey)+1, ax1=((sx>ex)?sx:ex)+2, ay1=((sy>ey)?sy:ey)+2;
    if((set->space==PARTICLE_SPACE_LAYER)?isLayerMapAreaEmpty(set->layer,ax0,ay0,ax1,ay1):
        isLayerAreaEmpty(set->layer,ax0,ay0,ax1,ay1)){
        p->x+=dx;
        p->y+=dy;
        return;
    }
    // Already inside something - the layer has moved into it, so push it back out. If it's in too deep (e.g. it was
    // started inside something), let it move freely until it's out
    if(blockHitsLayer(set,sx,sy) && !pushOutParticle(set,p,sx,sy)){
        p->x+=dx;
        p->y+=dy;
        return;
    }

    // Step a pixel (or less) at a time. After a bounce or slide, the rest of the frame's movement carries on with the
    // new velocity, so particles keep moving along surfaces (up to 3 collisions a frame)
    float remaining=1.0f;
    for(int pass=0;pass<3;pass++){
        const float mx=p->xDir*remaining;
        const float my=p->yDir*remaining;
        const float dist=fmaxf(fabsf(mx),fabsf(my));
        if(dist<0.0001f){
            return;
        }
        const int steps=(dist<1.0f)?1:(int)ceilf(dist);
        const float stepX=mx/(float)steps;
        const float stepY=my/(float)steps;
        bool collided=false;
        bool bounced=false;
        for(int i=0;i<steps;i++){
            const int cx=(int)p->x;
            const int cy=(int)p->y;
            const float nx=p->x+stepX;
            const float ny=p->y+stepY;
            const int ix=(int)nx;
            const int iy=(int)ny;
            if((ix==cx && iy==cy) || !blockHitsLayer(set,ix,iy)){
                p->x=nx;
                p->y=ny;
                continue;
            }
            // Hit the surface - bounce (or slide) off it
            bounced=bounceParticle(set,p,ix,iy);
            if(ix!=cx && iy!=cy && !blockHitsLayer(set,ix,cy)){
                // A blocked diagonal step, but moving on just one axis is free - take that, so particles slip along
                // slopes and around corners a pixel at a time
                p->x=nx;
                remaining*=(float)(steps-i-1)/(float)steps;
            }else if(ix!=cx && iy!=cy && !blockHitsLayer(set,cx,iy)){
                p->y=ny;
                remaining*=(float)(steps-i-1)/(float)steps;
            }else{
                // Stay in the last free pixel, at its centre, so sliding along a diagonal steps both axes together
                // (rather than one first, into the surface)
                p->x=(float)cx+0.5f;
                p->y=(float)cy+0.5f;
                remaining*=(float)(steps-i)/(float)steps;
            }
            collided=true;
            break;
        }
        // A real bounce ends this frame's movement (carrying on would add height, so bounces would never die down).
        // Slides carry on with the rest of the movement, so particles keep moving along surfaces
        if(!collided || bounced){
            return;
        }
    }
}

void updateParticles(void)
{
    for(int s=0;s<MAX_PARTICLE_SETS;s++){
        ParticleSet *set=particleSets+s;
        if(set->particles==NULL){
            continue;
        }
        set->alive=0;

        // Gravity pulls down the screen - for layer space sets, turn that into the layer's coordinates (also scaling the
        // fastest fall speed, in layer pixels)
        float maxFall=MAX_FALL_SPEED;
        if(set->space==PARTICLE_SPACE_LAYER){
            float dx, dy;
            screenToLayerVector(set->layer,0.0f,1.0f,&dx,&dy);
            const float len=sqrtf((dx*dx)+(dy*dy));
            gravityX=dx*set->gravity;
            gravityY=dy*set->gravity;
            maxFall*=len;
        }else{
            gravityX=0.0f;
            gravityY=set->gravity;
        }
        const float gravityLen=sqrtf((gravityX*gravityX)+(gravityY*gravityY));
        const float downX=(gravityLen>0.0f)?gravityX/gravityLen:0.0f;
        const float downY=(gravityLen>0.0f)?gravityY/gravityLen:1.0f;

        for(int n=0;n<set->total;n++){
            Particle *p=set->particles+n;
            if(p->timeToLive>0){
                ++set->alive;
                if(p->delay>0){
                    --p->delay;
                }else{
                    --p->timeToLive;
                    moveParticle(set,p);
                    p->xDir+=gravityX;
                    p->yDir+=gravityY;
                    // Limit the speed of falling (in the direction of gravity)
                    const float falling=(p->xDir*downX)+(p->yDir*downY);
                    if(falling>maxFall){
                        p->xDir-=(falling-maxFall)*downX;
                        p->yDir-=(falling-maxFall)*downY;
                    }
                    // Remove particles that have stopped on the same pixel for too long
                    const int16_t px=(int16_t)p->x;
                    const int16_t py=(int16_t)p->y;
                    if(px==p->lastX && py==p->lastY){
                        if(set->stillLimit>0 && ++p->stillFrames>=set->stillLimit){
                            p->timeToLive=0;
                        }
                    }else{
                        p->lastX=px;
                        p->lastY=py;
                        p->stillFrames=0;
                    }
                }
            }
        }
    }
}

float randF(float min, float max){
    if(max<min){
        float tmp=min;
        min=max;
        max=tmp;
    }
    return min+((float)rand()/(float)(RAND_MAX)) * (max-min);
}

void startParticles(int setIX, int x, int y, int numParticles, float minAngle, float maxAngle, float minSpeed,
    float maxSpeed, int minAge, int maxAge)
{
    if(setIX<0 || setIX>=MAX_PARTICLE_SETS || particleSets[setIX].particles==NULL){
        return;
    }
    ParticleSet *set=particleSets+setIX;
    if(minAge>=maxAge){
        maxAge=minAge+1;
    }
    if(numParticles>set->total){
        numParticles=set->total;
    }
    int pIX=-1;
    int cDelay=0;
    for(int n=0;n<numParticles;n++){
        for(int i=pIX+1;i<set->total;i++){
            if(set->particles[i].timeToLive==0){
                pIX=i;
                Particle *p=set->particles+i;
                p->x=x;
                p->y=y;
                p->delay=cDelay;
                p->lastX=INT16_MIN;
                p->lastY=INT16_MIN;
                p->stillFrames=0;
                if(n==numParticles/2){
                    cDelay+=3;
                }
                p->timeToLive=minAge+(rand()%(maxAge-minAge));
                float angle=randF(minAngle,maxAngle);
                float speed=randF(minSpeed+cDelay,maxSpeed+cDelay);
                p->xDir=sinf(angle)*speed;
                p->yDir=-cosf(angle)*speed;
                break;
            }
        }
    }
}

bool emitParticle(int setIX, float x, float y, float xDir, float yDir, int timeToLive)
{
    if(setIX<0 || setIX>=MAX_PARTICLE_SETS || particleSets[setIX].particles==NULL || timeToLive<=0){
        return false;
    }
    ParticleSet *set=particleSets+setIX;
    for(int n=0;n<set->total;n++){
        Particle *p=set->particles+n;
        if(p->timeToLive==0){
            p->x=x;
            p->y=y;
            p->xDir=xDir;
            p->yDir=yDir;
            p->delay=0;
            p->timeToLive=timeToLive;
            p->lastX=INT16_MIN;
            p->lastY=INT16_MIN;
            p->stillFrames=0;
            return true;
        }
    }
    return false;
}

void blitParticlesToScratchBuffers(int layer)
{
    for(int s=0;s<MAX_PARTICLE_SETS;s++){
        ParticleSet *set=particleSets+s;
        if(set->particles==NULL || set->layer!=layer){
            continue;
        }
        for(int n=0;n<set->total;n++){
            Particle *p=set->particles+n;
            if(p->timeToLive<=0){
                continue;
            }
            // Where it is on screen - layer space particles are converted, drawing the 2x2 block around its centre
            float screenX=p->x, screenY=p->y;
            if(set->space==PARTICLE_SPACE_LAYER){
                layerToScreen(set->layer,p->x+2.0f,p->y+2.0f,&screenX,&screenY);
                screenX-=2.0f;
                screenY-=2.0f;
            }
            if(
                screenY>=SCREEN_HEIGHT_LINES ||
                screenY<=-4 ||
                screenX>=SCREEN_WIDTH_PIXELS ||
                screenX<=-4
            ){
                // Off screen - screen space particles have gone for good, layer space ones are still in the layer's
                // world, so are just not drawn
                if(set->space==PARTICLE_SPACE_SCREEN){
                    p->timeToLive=0;
                }
                continue;
            }
            const int y=(int)screenY;
            int yOff=(y*SCREEN_WIDTH_CELLS);
            const int xCell=((int)screenX)>>3;
            const int shiftRight=((int)screenX)&0x07;
            // The particle covers two bytes - only draw the ones on screen (the right one is off screen when the
            // particle is in the last character column, and writing it would spill into the next line)
            const bool leftOn=(xCell>-1);
            const bool rightOn=(xCell+1<SCREEN_WIDTH_CELLS);
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
                if(leftOn){*smr&=tbMaskPixLeft;}
                if(rightOn){*(smr+1)&=tbMaskPixRight;}
            }

            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            if((y>-2) && (y<SCREEN_HEIGHT_LINES-1)){
                if(leftOn){
                    *smr&=midMaskPixLeft;
                    *spr|=pixLeft;
                }
                if(rightOn){
                    *(smr+1)&=midMaskPixRight;
                    *(spr+1)|=pixRight;
                }
            }

            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            if((y>-3) && (y<SCREEN_HEIGHT_LINES-2)){
                if(leftOn){
                    *smr&=midMaskPixLeft;
                    *spr|=pixLeft;
                }
                if(rightOn){
                    *(smr+1)&=midMaskPixRight;
                    *(spr+1)|=pixRight;
                }
            }

            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            if(y<SCREEN_HEIGHT_LINES-3){
                if(leftOn){*smr&=tbMaskPixLeft;}
                if(rightOn){*(smr+1)&=tbMaskPixRight;}
            }
        }
    }
}

// ---------------------------------------------------------------------------
// Layer points
// ---------------------------------------------------------------------------

typedef struct LayerPoint {
    int16_t x, y;           // (the layer pixel it's in)
    int8_t layer;
} LayerPoint;

static LayerPoint layerPoints[MAX_LAYER_POINTS];
static int layerPointCount=0;

void clearLayerPoints(void)
{
    layerPointCount=0;
}

bool addLayerPoint(int layer, float x, float y)
{
    if(layerPointCount>=MAX_LAYER_POINTS || layer<0 || layer>=MAX_TILE_LAYERS){
        return false;
    }
    LayerPoint *p=layerPoints+layerPointCount++;
    p->x=(int16_t)floorf(x);
    p->y=(int16_t)floorf(y);
    p->layer=(int8_t)layer;
    return true;
}

void blitLayerPointsToScratchBuffers(int layer)
{
    for(int n=0;n<layerPointCount;n++){
        const LayerPoint *p=layerPoints+n;
        if(p->layer!=layer){
            continue;
        }
        // The pixel the point's in on screen (layerToScreen gives the pixel's centre's position for its top left corner)
        float sx, sy;
        layerToScreen(layer,(float)p->x+0.5f,(float)p->y+0.5f,&sx,&sy);
        const int x=(int)floorf(sx), y=(int)floorf(sy);
        if(x<0 || x>=SCREEN_WIDTH_PIXELS || y<0 || y>=SCREEN_HEIGHT_LINES){
            continue;
        }
        const int i=(y*SCREEN_WIDTH_CELLS)+(x>>3);
        const uint8_t bit=(uint8_t)(0x80>>(x&7));
        scratchPixRam[i]|=bit;
        scratchMaskRam[i]&=(uint8_t)~bit;
    }
}
