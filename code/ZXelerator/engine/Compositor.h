#pragma once 

#include <stdint.h>
#include <stdbool.h>

#include "hardware/sync.h"
#include "hardware/dma.h"

#include "defs.h"
#include "displayMemoryOffsets.h"
#include "resetData.h"
#include "myTypes.h"
#include "shared.h"
#include "tileDefs.h"
#include "bitmapData.h"
#include "Sprite.h"
#include "TileLayer.h"
#include "particles.h"
#include "collision.h"

/// @brief A finished frame (pixels and bi-colour attributes), stored in the same form as a bitmap layer, so it can be
/// shown on a layer and scrolled, scaled, rotated or line transformed like any other bitmap - e.g. to transition a
/// whole screen (layers, sprites and all) away. About 7.5KB, so declare as static/global rather than on the stack
typedef struct FrameSnapshot {
    /// @brief Bitmap layer header (width in bytes, height in 8 line rows, attr width, unused), then the pixels
    uint8_t bitmap[4+(SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES)];
    /// @brief One attribute per 8x4 cell
    uint8_t attrs[SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS];
} FrameSnapshot;

void compositeScene(void);

/// @brief Capture the frame being composited this frame into snap, once compositeScene has finished it. The snapshot is
/// ready to use from the next frame (the render buffer is cleared before the game code runs each frame, so frames can
/// only be captured as compositing finishes)
/// @param snap Where to store the frame - must stay valid until the next compositeScene (and while it's shown on a layer)
void captureNextFrame(FrameSnapshot *snap);

/// @brief Show a captured frame on a layer, as an opaque bitmap (hiding the layers behind it). It can then be
/// positioned and transformed like any bitmap layer (setLayerPos, setLayerTransform, setLayerLineTransforms)
void setLayerSnapshot(int layerIX, const FrameSnapshot *snap);