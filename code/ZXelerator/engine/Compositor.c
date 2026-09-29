#include "Compositor.h"
#include <string.h>

static FrameSnapshot *pendingCapture=NULL;

void captureNextFrame(FrameSnapshot *snap)
{
    pendingCapture=snap;
}

void setLayerSnapshot(int layerIX, const FrameSnapshot *snap)
{
    setLayerType(layerIX,LT_BITMAP);
    setLayerBitmap(layerIX,snap->bitmap,snap->attrs);
    setLayerOpaque(layerIX,true);
}

static void captureFrame(FrameSnapshot *snap)
{
    snap->bitmap[0]=SCREEN_WIDTH_CELLS;
    snap->bitmap[1]=SCREEN_HEIGHT_CELLS;
    snap->bitmap[2]=SCREEN_WIDTH_CELLS;     // Non-zero - per cell attributes
    snap->bitmap[3]=0;
    memcpy(snap->bitmap+4,renderBuffer,SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES);
    memcpy(snap->attrs,renderAttrBuffer,SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS);
}

void compositeScene(void){
    updateParticles();
    for(int n=MAX_TILE_LAYERS-1;n>-1;n--){
        initScratchBuffers(false);
        blitLayerToScratchBuffers(n);
        blitParticlesToScratchBuffers(n);
        blitScratchToRenderBuffer();
        blitSpritesToRenderBuffer(n);
    }

    // Sprite collisions, now the frame is drawn - the game sees them in its next update
    detectCollisions();

    if(pendingCapture){
        captureFrame(pendingCapture);
        pendingCapture=NULL;
    }

    blitRenderBuffer();
}