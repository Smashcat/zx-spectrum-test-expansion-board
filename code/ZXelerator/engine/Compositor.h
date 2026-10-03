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

/// @brief Draw the frame: every layer, back to front, each with its particles and sprites (or, while one's shown, the
/// screen snapshot - see showScreenSnapshot), then send it to the Spectrum - unless setFrameTarget asked for it to go
/// into a snapshot instead
/// @return True if the frame was sent to the Spectrum (the game loop then flips the display bank), false if it only went
/// into a snapshot (the Spectrum keeps showing the last frame sent)
bool compositeScene(void);

/// @brief Leave the front layers (0 to frontLayers-1, with their sprites and particles) out of snapshots (captureNextFrame
/// and setFrameTarget) - e.g. 1 to keep a HUD on layer 0 out, so it can be drawn live over a zoomed snapshot with
/// showScreenSnapshot(snap,1). The frame itself is still drawn whole. 0 (the default) captures everything
void setSnapshotFrontLayers(int frontLayers);

/// @brief Draw the next frame into snap instead of sending it to the Spectrum, which keeps showing the last frame it
/// was sent - e.g. to draw a new level's first frame unseen, then zoom out of it with showScreenSnapshot. Just that
/// frame: the one after is sent as normal
void setFrameTarget(FrameSnapshot *snap);

/// @brief Show a snapshot full screen instead of the game's layers: compositeScene draws just the snapshot (and any
/// front layers asked for), so frames are quick, and the layers, sprites and particles are left as they are - turn it
/// off with hideScreenSnapshot and they're drawn again as they were. Scale and rotate it with setScreenSnapshotView
/// (shown 1:1 to start with). The snapshot doesn't use one of the game's layers
/// @param snap The frame to show (e.g. from captureNextFrame or setFrameTarget) - must stay valid while it's shown
/// @param frontLayers How many of the front layers (0 to frontLayers-1, with their sprites and particles) to still draw
/// over it, e.g. 1 for a HUD or pause menu on layer 0 - 0 for none
void showScreenSnapshot(const FrameSnapshot *snap, int frontLayers);

/// @brief Where the screen snapshot is shown: the snapshot's pixel (focusX, focusY) is drawn at screen position
/// (screenX, screenY), the snapshot scaled (2.0 doubles its size) and rotated (radians, clockwise) around it - e.g. to
/// zoom into a door, keep the focus on the door and move its screen position to the middle as the scale grows
void setScreenSnapshotView(float focusX, float focusY, float screenX, float screenY, float scale, float angle);

/// @brief Stop showing the screen snapshot: the game's layers are drawn again
void hideScreenSnapshot(void);

/// @brief True while a screen snapshot is shown
bool isScreenSnapshotShown(void);

/// @brief Capture the frame being composited this frame into snap, once compositeScene has finished it. The snapshot is
/// ready to use from the next frame (the render buffer is cleared before the game code runs each frame, so frames can
/// only be captured as compositing finishes)
/// @param snap Where to store the frame - must stay valid until the next compositeScene (and while it's shown on a layer)
void captureNextFrame(FrameSnapshot *snap);

/// @brief Show a captured frame on a layer, as an opaque bitmap (hiding the layers behind it). It can then be
/// positioned and transformed like any bitmap layer (setLayerPos, setLayerTransform, setLayerLineTransforms)
void setLayerSnapshot(int layerIX, const FrameSnapshot *snap);