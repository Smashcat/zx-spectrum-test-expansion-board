#include "Compositor.h"

void compositeScene(void){
    updateParticles();
    for(int n=MAX_TILE_LAYERS-1;n>-1;n--){
        initScratchBuffers(false);
        blitLayerToScratchBuffers(n);
        blitParticlesToScratchBuffers(n);
        blitScratchToRenderBuffer();
        blitSpritesToRenderBuffer(n);
    }

    blitRenderBuffer();
}