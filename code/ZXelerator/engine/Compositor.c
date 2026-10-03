#include "Compositor.h"
#include <string.h>
#include <math.h>

static FrameSnapshot *pendingCapture=NULL;
// The next frame goes into this snapshot instead of to the Spectrum
static FrameSnapshot *frameTarget=NULL;
// The snapshot shown full screen instead of the layers (NULL for none), and how many front layers are drawn over it
static const FrameSnapshot *screenSnapshot=NULL;
static int screenFrontLayers=0;
// Front layers left out of snapshots
static int snapshotFrontLayers=0;

void setSnapshotFrontLayers(int frontLayers)
{
    snapshotFrontLayers=(frontLayers<0)?0:((frontLayers>MAX_TILE_LAYERS)?MAX_TILE_LAYERS:frontLayers);
}

void captureNextFrame(FrameSnapshot *snap)
{
    pendingCapture=snap;
}

void setFrameTarget(FrameSnapshot *snap)
{
    frameTarget=snap;
}

void showScreenSnapshot(const FrameSnapshot *snap, int frontLayers)
{
    screenSnapshot=snap;
    screenFrontLayers=(frontLayers<0)?0:((frontLayers>MAX_TILE_LAYERS)?MAX_TILE_LAYERS:frontLayers);
    setLayerSnapshot(SCREEN_SNAPSHOT_LAYER,snap);
    setScreenSnapshotView(SCREEN_WIDTH_PIXELS/2,SCREEN_HEIGHT_LINES/2,SCREEN_WIDTH_PIXELS/2,SCREEN_HEIGHT_LINES/2,1.0f,0.0f);
}

void setScreenSnapshotView(float focusX, float focusY, float screenX, float screenY, float scale, float angle)
{
    // Unscaled, the snapshot's top left is at the layer position, so its focus pixel is at (screenX,screenY) - which is
    // then the pivot it's scaled and rotated around, so it stays there
    setLayerPos(SCREEN_SNAPSHOT_LAYER,(int)floorf(screenX-focusX+0.5f),(int)floorf(screenY-focusY+0.5f));
    setLayerPivot(SCREEN_SNAPSHOT_LAYER,screenX,screenY);
    if(scale==1.0f && angle==0.0f){
        clearLayerTransform(SCREEN_SNAPSHOT_LAYER);
    }else{
        setLayerTransform(SCREEN_SNAPSHOT_LAYER,angle,scale,scale);
    }
}

void hideScreenSnapshot(void)
{
    screenSnapshot=NULL;
}

bool isScreenSnapshotShown(void)
{
    return screenSnapshot!=NULL;
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

// The snapshots asked for this frame (captureNextFrame, setFrameTarget), of the render buffer as it is now
static void takeSnapshots(void)
{
    if(pendingCapture){
        captureFrame(pendingCapture);
        pendingCapture=NULL;
    }
    if(frameTarget){
        captureFrame(frameTarget);
        frameTarget=NULL;
    }
}

bool compositeScene(void){
    // Layers locked to another layer (e.g. a level's foreground) take its position and transform as it is this frame
    syncFollowingLayers();
    // Layer space sprites follow their layer's position, rotation and scale as it is this frame
    placeLayerSprites();
    updateParticles();
    // Back to front - or, with a screen snapshot shown, just it and the front layers asked for over it
    int first=MAX_TILE_LAYERS-1;
    if(screenSnapshot){
        initScratchBuffers(false);
        blitLayerToScratchBuffers(SCREEN_SNAPSHOT_LAYER);
        blitScratchToRenderBuffer();
        first=screenFrontLayers-1;
    }
    // Snapshots are taken before the front layers left out of them are drawn (or once the frame's finished)
    const bool unseen=(frameTarget!=NULL);
    bool captured=false;
    for(int n=first;n>-1;n--){
        if(!captured && n<snapshotFrontLayers){
            takeSnapshots();
            captured=true;
        }
        initScratchBuffers(false);
        blitLayerToScratchBuffers(n);
        blitParticlesToScratchBuffers(n);
        blitLayerPointsToScratchBuffers(n);
        blitScratchToRenderBuffer();
        blitSpritesToRenderBuffer(n);
    }
    if(!captured){
        takeSnapshots();
    }

    // Sprite collisions, now the frame is drawn - the game sees them in its next update
    detectCollisions();

    // (layer points are drawn for one frame - the game adds them each frame)
    clearLayerPoints();

    // Into a snapshot, unseen - the Spectrum keeps showing the last frame sent
    if(unseen){
        return false;
    }
    blitRenderBuffer();
    return true;
}