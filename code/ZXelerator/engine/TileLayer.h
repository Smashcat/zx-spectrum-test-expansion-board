#pragma once

#include "defs.h"
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include "pico/stdlib.h"
#include "pico.h"
#include "shared.h"
#include "displayMemoryOffsets.h"

/// @brief The layer's type, LT_TILE is a tilemap, LT_BITMAP holds a bitmap image
typedef enum LayerType {
    LT_TILE,
    LT_BITMAP
} LayerType;

typedef struct TileLayer {
    // X position, relative to screen in pixels (if over 254, or under -511 layer not drawn)
    int16_t x;
    // Y position, relative to screen in pixels (if over 191, or under -383 layer not drawn)
    int16_t y;
    // Tile definitions in cells within this layer
    uint8_t tileMap[(TILE_LAYER_WIDTH*TILE_LAYER_HEIGHT)];
    // Attribute definitions in cells within this layer (bi-color, so 8x4 pixel blocks). If "flash bit" (7) set, then will not update current attr under the tile on this layer"
    uint8_t attrMap[(TILE_LAYER_WIDTH*TILE_LAYER_ATTR_HEIGHT)];
    // Pointer to the tile definitions to use for this layer (mask defs are always tileDefPtr+(8*256))
    const uint8_t *tileDefPtr;
    // This layer's type
    LayerType layerType;

    const uint8_t *bitmapDefPtr;
    const uint8_t *attrDefPtr;
    int bitmapCharWidth;
    int bitmapHeight;

} TileLayer;

/// @brief Initialise all tile layers, setting them off of screen, clearing tiles to zero, with attributes set to white ink on black background
void initLayers(void);

/// @brief Change the layer's type
/// @param layerIX The layer to update
/// @param lt The layer type
void setLayerType(int layerIX, LayerType lt);

/// @brief Sets up the bitmap data for a layer set to LT_BITMAP
/// @param layerIX The layer to update
/// @param bitmapData The array of bitmap pixel data
/// @param attrData The array of attribute data (it's 1/4 the size of the bitmap data, as colour resolution is 8x4 and pixel resolution is 8x1)
/// @param width The width of the bitmap in bytes
/// @param height The height of the bitmap in pixels
void setBitmap(int layerIX, const uint8_t *bitmapData, const uint8_t *attrData, int width, int height);

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
/// @param y y tile position within layer to start drawing string
void drawTxtToLayer(int layerIX, const char *s, uint8_t colorTop, uint8_t colorBottom, int x, int y);

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
void blitBitmapLayerToScratchBuffers(layerIX);