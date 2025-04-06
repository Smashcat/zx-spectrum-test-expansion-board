#include "Compositor.h"

void compositeScene(void){

    for(int n=MAX_TILE_LAYERS-1;n>-1;n--){
        blitLayerToScratchBuffers(n);
        blitScratchToRenderBuffer();
        blitSpritesToRenderBuffer(n);
    }

    blitRenderBuffer();
}