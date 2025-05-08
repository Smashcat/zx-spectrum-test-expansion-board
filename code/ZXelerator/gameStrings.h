#pragma once

#include <stdint.h>
#include "engine/defs.h"
#include "engine/displayMemoryOffsets.h"
#include "engine/resetData.h"
#include "engine/myTypes.h"
#include "engine/shared.h"
#include "engine/tileDefs.h"
#include "engine/bitmapData.h"
#include "engine/palette.h"
#include "engine/Sprite.h"
#include "engine/TileLayer.h"
#include "engine/Compositor.h"
#include "engine/inputDevice.h"
#include "engine/funcs.h"
#include "gameFunc.h"

extern const int totalStoryEntries;
extern const StoryEntry storyEntry[5];

/// @brief Draw a sction of the story text to a layer, ready to scroll
/// @param layerIX The layer to draw to
/// @param storySectionIX The section of the story to draw
/// @param yPos The y position in the layer (x is automatic)
/// @return The last Y position drawn to
int drawStorySection(int layerIX, int storySectionIX, int yPos);
