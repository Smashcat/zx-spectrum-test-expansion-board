#pragma once

#include "defs.h"
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <memory.h>
#include "pico/stdlib.h"
#include "pico.h"
#include <math.h>
#include "shared.h"
#include "displayMemoryOffsets.h"
#include "fixedMath.h"

/// @brief The layer's type, LT_TILE is a tilemap, LT_BITMAP holds a bitmap image. LT_BITMAP_WRAP allows the bitmap to repeat when exceeding its dimensions while scrolling (tilemaps always wrap)
typedef enum LayerType {
    LT_TILE,
    LT_BITMAP,
    LT_BITMAP_WRAP
} LayerType;

/// @brief How one screen line of a transformed layer samples the layer (like a SNES Mode 7 HDMA table entry).
/// Positions are in layer pixels, 16.16 fixed point (see FIXED16). Screen pixel x on this line samples the
/// layer at (u+(x*dudx), v+(x*dvdx)), so u,v should be the layer position at the centre of screen pixel 0
typedef struct LayerLineTransform {
    int32_t u;
    int32_t v;
    int32_t dudx;
    int32_t dvdx;
    /// @brief Zero to leave this line of the layer blank (transparent), e.g. above the horizon
    int32_t enabled;
} LayerLineTransform;

typedef struct TileLayer {
    /// @brief X position, relative to screen in pixels (if over 254, or under -511 layer not drawn)
    int16_t x;
    /// @brief Y position, relative to screen in pixels (if over 191, or under -383 layer not drawn)
    int16_t y;
    /// @brief Tile definitions in cells within this layer
    uint8_t tileMap[(TILE_LAYER_WIDTH*TILE_LAYER_HEIGHT)];
    /// @brief Attribute definitions in cells within this layer (bi-color, so 8x4 pixel blocks). If "flash bit" (7) set, then will not update current attr under the tile on this layer"
    uint8_t attrMap[(TILE_LAYER_WIDTH*TILE_LAYER_ATTR_HEIGHT)];
    /// @brief Pointer to the tile definitions to use for this layer (mask defs are always tileDefPtr+(8*256))
    const uint8_t *tileDefPtr;
    /// @brief Pointer to the bitmap to use for the layer (if layerType is set to LT_BITMAP)
    const uint8_t *bitmapDefPtr;
    /// @brief Pointer to the attribute data to use for the layer (if layerType is set to LT_BITMAP)
    const uint8_t *attrDefPtr;
    /// @brief Width of the bitmap in bytes
    int bitmapCharWidth;
    /// @brief Height of the bitmap in pixels
    int bitmapHeight;
    /// @brief This layer's type (tilemap or bitmap)
    LayerType layerType;
    /// @brief If no attribute map supplied when switching layer to a bitmap type, then this is used to set the global background when drawing the bitmap
    uint8_t globalAttr;
    /// @brief True if rotated or scaled with setLayerTransform (the fast scrolling-only renderer is used otherwise)
    bool transformed;
    /// @brief Rotation in radians (clockwise on screen)
    float angle;
    float scaleX;
    float scaleY;
    /// @brief Screen position the layer rotates/scales around
    float pivotX;
    float pivotY;
    /// @brief Inverse transform (layer pixels per screen pixel), set from angle and scale
    float dudx, dudy, dvdx, dvdy;
    /// @brief If set, one entry per screen line, overriding the rotation/scale and position (for Mode 7 style effects)
    const LayerLineTransform *lineTransforms;
} TileLayer;

/// @brief Initialise all tile layers, setting them off of screen, clearing tiles to zero, with attributes set to white ink on black background
void initLayers(void);

/// @brief Resets rows of tiles in layer to index 0, with transparent attributes
/// @param layerIX The tile layer to update
/// @param fromY The first row to clear
/// @param numRows The number of rows to clear
void clearLayerLines(int layerIX, int fromY, int numRows);

/// @brief Change the layer's type
/// @param layerIX The layer to update
/// @param lt The layer type
void setLayerType(int layerIX, LayerType lt);

/// @brief Sets up the bitmap data for a layer set to LT_BITMAP
/// @param layerIX The layer to update
/// @param bitmapData The array of bitmap pixel data
/// @param attrData The array of attribute data (it's 1/4 the size of the bitmap data, as colour resolution is 8x4 and pixel resolution is 8x1)
void setLayerBitmap(int layerIX, const uint8_t *bitmapData, const uint8_t *attrData);

/// @brief Directly blit data to the layer - handy for quickly setting up level data etc
/// @param layerIX The layer to update
/// @param tileDefs An array of tile defs to draw
/// @param attrDefs An array of attr defs to draw (every 32 rows, switches between top and bottom attributes, so this will always be double the length of the tileDefs array)
/// @param x X tile position within layer to start copying data
/// @param y Y tile position within layer to start copying data
/// @param len Total length of tileDef data to draw. This is the number of tiles that will be updated. Note that double this number of attribute rows will be updated 
void blitRawToLayer(int layerIX, const uint8_t *tileDefs, const uint8_t *attrDefs, int x, int y, int len);

/// @brief Draw a string of text to the layer
/// @param layerIX The layer to update
/// @param s Zero delimited ASCII string
/// @param colorTop The attribute to use under top half of string
/// @param colorBottom The attribute to use under bottom half of string
/// @param x X tile position within layer to start drawing string
/// @param y Y tile position within layer to start drawing string
void drawTxtToLayer(int layerIX, const char *s, uint8_t colorTop, uint8_t colorBottom, int x, int y);

/// @brief Set a single tile in a layer
/// @param layerIX The layer to update
/// @param tileDefIX The tile definition to use
/// @param colorTop The attr to use for the top half of tile
/// @param colorBottom The attr to use for the bottom half of tile
/// @param x X tile position within layer
/// @param y Y tile position within layer
void setLayerTile(int layerIX, uint8_t tileDefIX, uint8_t colorTop, uint8_t colorBottom, int x, int y);

/// @brief Draw a number to the layer
/// @param layerIX The layer to update
/// @param num The number to draw, this is a 32bit int
/// @param colorTop The attribute to use under top half of string
/// @param colorBottom The attribute to use under bottom half of string
/// @param x X tile position within layer to start drawing string
/// @param y y tile position within layer to start drawing string
/// @param maxDigits Maximum number of digits to show for the number - this is left padded with zeroes (useful for scores :) )
void drawIntNumToLayer(int layerIX, int32_t num, uint8_t colorTop, uint8_t colorBottom, int x, int y, int maxDigits);

/// @brief Set the position of the layer relative to the screen
/// @param layerIX The layer to update
/// @param x X position, relative to screen in pixels (if over 254, or under -511 layer not drawn)
/// @param y Y position, relative to screen in pixels (if over 191, or under -383 layer not drawn)
void setLayerPos(int layerIX,int x, int y);

/// @brief Set the tile-set to be used by the layer
/// @param setRef pointer to the array of tile data
void setTileDefSet(int layerIX, const uint8_t *setRef);

/// @brief Draws the layer to the scratch buffers, ready to move to the render buffer
/// @param layerIX The layer to draw
void blitLayerToScratchBuffers(int layerIX);

/// @brief Draws the bitmap layer to the scratch buffers, ready to move to the render buffer. Bitmaps wrap in both axis
/// @param layerIX The layer to draw
void blitBitmapLayerToScratchBuffers(int layerIX);

/// @brief Rotate and/or scale a layer around its pivot point (the screen centre unless changed with setLayerPivot).
/// The layer position set with setLayerPos still scrolls the layer. Tile layers and LT_BITMAP_WRAP layers repeat
/// forever, LT_BITMAP layers are transparent outside the bitmap. With no rotation and a scale of 1, the fast
/// scrolling renderer is used
/// @param layerIX The layer to update
/// @param angle Rotation in radians, clockwise on screen
/// @param scaleX Horizontal scale (2.0 doubles the size on screen)
/// @param scaleY Vertical scale
void setLayerTransform(int layerIX, float angle, float scaleX, float scaleY);

/// @brief Set the screen position a layer rotates and scales around (defaults to the screen centre)
void setLayerPivot(int layerIX, float x, float y);

/// @brief Remove any rotation, scaling and line transforms from the layer
void clearLayerTransform(int layerIX);

/// @brief Use a table of per-line transforms for the layer, for Mode 7 style effects (perspective floors, wobbles etc).
/// While set, the layer position and setLayerTransform are ignored
/// @param layerIX The layer to update
/// @param lines SCREEN_HEIGHT_LINES (192) entries, which must stay valid while in use (not copied). NULL to stop using a table
void setLayerLineTransforms(int layerIX, const LayerLineTransform *lines);

/// @brief Fill a line transform table with a Mode 7 style perspective floor, viewed from a camera above the layer
/// @param lines Table of SCREEN_HEIGHT_LINES entries to fill
/// @param camX Camera X position on the layer, in layer pixels
/// @param camY Camera Y position on the layer, in layer pixels
/// @param angle Camera heading in radians - 0 looks towards the top of the layer (negative Y), increasing clockwise
/// @param camHeight Camera height above the layer, in pixels
/// @param horizonY Screen line of the horizon - lines above it are left blank, so layers behind show through
/// @param focalLength Distance from the camera to the projection plane, in pixels (around 128 gives a 90 degree field of view)
void buildLayerPerspective(LayerLineTransform *lines, float camX, float camY, float angle, float camHeight, float horizonY, float focalLength);

extern TileLayer tileLayer[MAX_TILE_LAYERS];
