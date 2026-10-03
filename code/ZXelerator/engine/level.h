#pragma once

#include <stdint.h>
#include <stdbool.h>
#include "defs.h"

// Levels are made in Tiled and converted by pc/tools/levelconv (see levels/README.md) into a LevelDef, packed in flash.
// loadLevel unpacks one into RAM; setLevelCamera then positions its layers and copies the tiles around the view into
// the engine's 64x64 tile layers as the camera moves, so levels can be much bigger than a tile layer. Level coordinates
// are the layers' own pixel coordinates (layer space), so layer space sprites and particles use level positions directly

/// @brief Tile flags, from the tile properties set in Tiled (see getLevelTileFlags). The engine doesn't act on them -
/// they're for the game's own collision and pickup code
#define LEVEL_TILE_SOLID        0x01    // "solid" - walls and floors
#define LEVEL_TILE_PLATFORM     0x02    // "platform" - solid from above only
#define LEVEL_TILE_HAZARD       0x04    // "hazard"
#define LEVEL_TILE_COLLECT      0x08    // "collect" - pickups
// Bits 4-7: the tile's type, 0-15 - its "tileType" (the TileType enum in the Tiled project: TILE_TYPE_... in
// levels/levelObjects.h), for the game to give meaning to, e.g. conveyors or springboards
#define LEVEL_TILE_TYPE_SHIFT   4
#define LEVEL_TILE_TYPE(flags)  ((flags)>>LEVEL_TILE_TYPE_SHIFT)
// (a tile's "flags" property, an int, is ORed in too)

/// @brief LevelLayer flags
#define LEVEL_WRAP_X            0x01    // The layer's tiles repeat across (e.g. parallax backgrounds)
#define LEVEL_WRAP_Y            0x02    // ...and down

/// @brief One frame of an animated tile
typedef struct LevelAnimFrame {
    /// @brief The tile graphic shown (a tile number in the same tile set)
    uint8_t def;
    /// @brief How long it's shown, in frames (25ths of a second)
    uint8_t ticks;
} LevelAnimFrame;

/// @brief An animated tile: everywhere it's used, its graphic cycles through the frames (the tile set is copied to RAM
/// and the tile's graphic and mask rewritten as the frame changes, so this costs nothing per tile on screen)
typedef struct LevelAnim {
    uint8_t def;
    uint8_t frameCount;
    const LevelAnimFrame *frames;
} LevelAnim;

/// @brief A tile set used by the level: the engine tile graphics, and the colours and flags set on its tiles in Tiled
typedef struct LevelTileSet {
    /// @brief Engine tile graphics - 256 tiles then their 256 masks (e.g. defaultTileDef)
    const uint8_t *tiles;
    /// @brief Attributes: for 8x8 tiles, the top and bottom half of each tile (512 bytes); for 16x16 tiles, the top and
    /// bottom half of each quarter of each tile (2048 bytes - tile*8 + quarter*2, quarters top left, top right, bottom
    /// left, bottom right)
    const uint8_t *attrs;
    /// @brief LEVEL_TILE_ flags of each tile (256 bytes)
    const uint8_t *flags;
    uint8_t animCount;
    const LevelAnim *anims;
    /// @brief 8 or 16 (0 is 8): 16x16 tile sets are 256 tiles of 32 bytes (2 bytes a row, left then right), then their
    /// 256 masks - 16KB
    uint8_t tileSize;
} LevelTileSet;

/// @brief One tile layer of a level (and the foreground tiles drawn in front of its sprites, if it has any)
typedef struct LevelLayer {
    /// @brief Packed (lzUnpack) tiles: width*height tile numbers, padded to 4 bytes, then if there are foreground tiles,
    /// a bit per tile (rows of 32 bit words, bit n of a word for tile n across) and a tile number for each set bit
    const uint8_t *data;
    uint32_t dataSize;
    /// @brief Size of the stored area, in tiles (trimmed to the tiles used)
    uint16_t width;
    uint16_t height;
    /// @brief Where the stored area starts in the level, in tiles
    int16_t tileX;
    int16_t tileY;
    /// @brief Pixel offset of the layer (Tiled's layer offset)
    int16_t offsetX;
    int16_t offsetY;
    /// @brief Scroll speed relative to the camera (Tiled's parallax factor), 8.8 fixed point - 256 moves with the camera
    int16_t parallaxX;
    int16_t parallaxY;
    /// @brief Number of foreground tiles (0 if none)
    uint16_t fgCount;
    /// @brief Index of this layer's tile set, and its foreground tiles' tile set, in the level's tile sets
    uint8_t tileSet;
    uint8_t fgTileSet;
    /// @brief The engine layer it's shown on, and the one its foreground tiles are shown on (-1 if none) - a lower
    /// numbered layer, so it's drawn after this layer's sprites
    int8_t layer;
    int8_t fgLayer;
    /// @brief LEVEL_WRAP_ flags
    uint8_t flags;
    /// @brief The Tiled layer's name
    const char *name;
    /// @brief If not 0, the layer is one colour (its "ink", "paper", "bright" or "transparent" properties in Tiled):
    /// colour, for the whole layer (see setLayerColour) - its tiles' colours aren't used, and its foreground (in front)
    /// draws its pixels only
    uint8_t singleColour;
    uint8_t colour;
} LevelLayer;

/// @brief Sprite graphics used by the level's objects (from a sprite tile set in Tiled, or a level tile set - tile
/// objects placed with level tiles are sprites of those tiles)
typedef struct LevelSpriteSheet {
    /// @brief Graphics and mask (NULL for a level tile set's: those are its tiles in RAM, so animate)
    const uint8_t *def;
    const uint8_t *mask;
    /// @brief SpriteSize
    uint8_t size;
    /// @brief Palette the sprites are drawn with
    uint8_t palette;
    uint8_t frames;
    /// @brief 0, or 1 + the level tile set (index into LevelDef tileSets) whose tiles are the frames
    uint8_t tileSet;
} LevelSpriteSheet;

/// @brief LevelProp types
#define LEVEL_PROP_TYPE_INT     0       // int, bool (0/1) or colour
#define LEVEL_PROP_TYPE_FLOAT   1
#define LEVEL_PROP_TYPE_STRING  2
#define LEVEL_PROP_TYPE_OBJECT  3       // another object in the level: its index, or -1

/// @brief A custom property of an object (the classes and their properties are set up in the Tiled project, and
/// numbered in levels/levelObjects.h: LEVEL_PROP_...)
typedef struct LevelProp {
    uint8_t id;
    uint8_t type;
    union {
        int32_t i;
        float f;
        const char *s;
    } v;
} LevelProp;

/// @brief A point of a path (a polyline or polygon drawn in Tiled), in level pixels
typedef struct LevelPoint {
    int16_t x;
    int16_t y;
} LevelPoint;

/// @brief LevelObject flags
#define LEVEL_OBJ_FLIP_X        0x01    // The tile object is flipped across (e.g. for an enemy facing the other way)
#define LEVEL_OBJ_FLIP_Y        0x02
#define LEVEL_OBJ_WAIT          0x04    // "waitForCamera": dormant until the camera comes near (e.g. a wave of enemies)
#define LEVEL_OBJ_CLOSED        0x08    // Its path is a polygon (joins back to its start)
#define LEVEL_OBJ_PERSIST       0x10    // "persist": its state is remembered when the player leaves the level
#define LEVEL_OBJ_SWITCH        0x20    // It's a switch (it has a "mode"): on or off, see useLevelSwitch. With a sprite, it
                                        // shows its placed frame when off, and the last frame of its sheet when on (the
                                        // game can play the frames between, e.g. a door opening)

/// @brief Switch modes (the "mode" property, a SwitchMode in the Tiled project - in this order)
#define LEVEL_SWITCH_ONCE       0       // Turns on, and stays on
#define LEVEL_SWITCH_TOGGLE     1       // Turns on and off each time it's used
#define LEVEL_SWITCH_TIMED      2       // Turns on, and back off "time" frames after it was last used (e.g. pressure plates)

/// @brief An object placed in the level in Tiled: a sprite (tile object), point, area or path
typedef struct LevelObject {
    /// @brief Its class, LEVEL_CLASS_... from levels/levelObjects.h (LEVEL_CLASS_NONE if it has none)
    uint8_t cls;
    /// @brief Its sprite graphics (an index into the level's sprite sheets), or -1 if it isn't a sprite
    int8_t sheet;
    uint8_t frame;
    /// @brief LEVEL_OBJ_ flags
    uint8_t flags;
    /// @brief The engine layer its sprite goes on (its object layer's "layer" property), or -1 if not set
    int8_t layer;
    uint8_t propCount;
    uint8_t pointCount;
    /// @brief Its centre (a point's position, a path's first point), in level pixels
    int16_t x;
    int16_t y;
    /// @brief Size of a sprite or area (0 for points and paths)
    int16_t width;
    int16_t height;
    const LevelProp *props;
    const LevelPoint *points;
    /// @brief Its name in Tiled (entrances are found by name - see enterLevel)
    const char *name;
    /// @brief Its place in the level's remembered state (LEVEL_OBJ_PERSIST objects), or -1
    int16_t slot;
    /// @brief Switches: the "value" given to the switch handler, the mode (LEVEL_SWITCH_), the time a timed switch stays
    /// on, and whether it starts on ("startOn")
    int16_t value;
    int16_t time;
    uint8_t mode;
    uint8_t startOn;
} LevelObject;

/// @brief A level, as written by the level converter
typedef struct LevelDef {
    const char *name;
    /// @brief Size in tiles
    uint16_t width;
    uint16_t height;
    /// @brief RAM loadLevel needs (at most LEVEL_RAM_SIZE)
    uint32_t ramSize;
    uint8_t tileSetCount;
    uint8_t layerCount;
    uint8_t sheetCount;
    uint16_t objectCount;
    /// @brief The tile sets it uses (shared with other levels using them - levels/tileset_*.c)
    const LevelTileSet *const *tileSets;
    const LevelLayer *layers;
    const LevelSpriteSheet *sheets;
    const LevelObject *objects;
    /// @brief Its number in levelList (LEVEL_ID_... in levels/levels.h), and how many bytes of remembered state it has
    /// (one per LEVEL_OBJ_PERSIST object)
    uint16_t id;
    uint16_t stateBytes;
    /// @brief The size of its tiles, 8 or 16 (0 is 8) - its layers' sizes, tile positions and tile lookups are in these
    /// tiles. Each 16x16 tile fills 2x2 cells of the engine's 8x8 cell layers (see setLayerTileSize)
    uint8_t tileSize;
    /// @brief The level's own properties (the map's, in Tiled: e.g. the Level class's levelName and levelDescription)
    const LevelProp *props;
    uint8_t propCount;
    /// @brief Its type - its "levelType" property (the LevelType enum in the Tiled project: LEVEL_TYPE_... in
    /// levels/levelObjects.h), 0 if not set. For the game, e.g. to tell platform stages from flying ones
    uint8_t type;
} LevelDef;

/// @brief Every level converted, by LEVEL_ID_... (from levels/levelList.c, written by the level converter). Levels that
/// haven't been converted yet are NULL
extern const LevelDef *const levelList[];
extern const int levelCount;

/// @brief The live state of a level object. Every object has one from loadLevel, and it's the game's to update each
/// frame (all of them, on screen or not - enemies keep patrolling off screen, as tile lookups on the level work
/// anywhere). The engine only decides which have a sprite: those near the camera (see setLevelActorMargins), placed
/// and shown each frame by updateLevel at the actor's position and frame
typedef struct LevelActor {
    /// @brief Position (centre) in level pixels - starts at the object's position
    float x;
    float y;
    /// @brief For the game: velocity, angle (e.g. a turret's aim), a timer, a state, hit points (all 0 at the start)
    float vx;
    float vy;
    float angle;
    int16_t timer;
    int16_t hp;
    uint8_t state;
    /// @brief Facing: -1 if the tile object was flipped across, 1 otherwise
    int8_t dir;
    /// @brief Frame of its sprite graphics shown (starts at the tile object's)
    uint8_t frame;
    /// @brief LEVEL_ACTOR_ flags
    uint8_t flags;
    /// @brief Its sprite while it's near the camera, or -1
    int16_t sprite;
    /// @brief INTERNAL - frames left before a timed switch turns off
    int16_t switchTimer;
} LevelActor;

/// @brief LevelActor flags
#define LEVEL_ACTOR_ALIVE       0x01    // Updated, and shown near the camera - cleared by killLevelActor
#define LEVEL_ACTOR_DORMANT     0x02    // Waiting for the camera (LEVEL_OBJ_WAIT) - not to be updated yet
#define LEVEL_ACTOR_WOKE        0x04    // Woke this frame (the camera reached it)
#define LEVEL_ACTOR_ON          0x08    // A switch that's on

/// @brief Why the switch handler was called
#define LEVEL_SWITCH_USED       0       // useLevelSwitch (e.g. the player pulled it)
#define LEVEL_SWITCH_SET        1       // setLevelSwitch (the game changed it)
#define LEVEL_SWITCH_EXPIRED    2       // A timed switch turned itself off
#define LEVEL_SWITCH_REPLAY     3       // Entering the level: it was left on (or starts on) - put its effect in place
                                        // straight away (e.g. the door is open), rather than animating it

/// @brief The game's switch handler - one for every switch in every level: the switch's value, whether it's now on,
/// the switch object, and why it's being called (LEVEL_SWITCH_)
typedef void (*LevelSwitchFn)(int value, bool on, int objectIX, uint8_t why);

/// @brief The game's level setup, called by enterLevel once the level's loaded, before its switches are replayed and
/// the player's placed - set up sprite sets, class sprites and the game's own per level state here
typedef void (*LevelSetupFn)(const LevelDef *lv);

/// @brief Called when an actor gets a sprite (it's come near the camera): the sprite is already set up from its sprite
/// sheet, in layer space on its layer, at the actor's position - add it to a set, set its collisions etc here
typedef void (*LevelShowFn)(int objectIX, int spriteIX);

/// @brief Called before an actor's sprite is taken away (it's gone far from the camera, or been killed)
typedef void (*LevelHideFn)(int objectIX, int spriteIX);

/// @brief Unpack a level into RAM, and set up the engine layers it uses (tile sets, foreground layers following their
/// layers). Call setLevelCamera next to position and fill them. Other layers are left alone, e.g. for a HUD
/// @return False if the level doesn't fit in LEVEL_RAM_SIZE, or its data is corrupt
bool loadLevel(const LevelDef *lv);

/// @brief Move the camera: x,y is the level pixel at the top left of the screen (for layers that move with the camera -
/// parallax layers move proportionally). Positions every layer of the level and copies in the tiles coming into view.
/// Call each frame, after changing any level layer's rotation or scale, as the tiles copied are those around the centre
/// of the screen, however the layer is rotated (64x64 tiles: enough for any rotation, at a scale of 0.65 or more).
/// Tile lookups on the engine layers (e.g. getSpriteTileAtI) are right within 16 tiles or so of the screen - further
/// out, use getLevelTile
void setLevelCamera(int x, int y);

/// @brief Shake the level (e.g. with the weight of a landing, or an impact): over 8 frames it jolts up to size pixels in
/// a direction (0,1 down, 1,0 right...), bounces back past where it was, and settles. It's done by moving the camera
/// (setLevelCamera adds it), so each layer moves by its own parallax - a half speed background half as far - with the
/// sprites and particles in the level. Layers that aren't the level's (e.g. a HUD) stay still. A new shake replaces one
/// going on; loading a level stops it
void shakeLevel(float size, float dirX, float dirY);

/// @brief The shake this frame: how far (pixels) the level's camera-speed layers are moved by it (0,0 when still)
void getLevelShake(int *x, int *y);

/// @brief An offset added to the camera every frame (0,0 unless set) - for effects of the game's own, e.g. its own
/// shakes or a nudge. Positive moves the view right/down (the level left/up)
void setLevelCameraOffset(int x, int y);

/// @brief Animate the level's tiles, wake actors the camera has reached, give sprites to actors near the camera (and
/// take them from those far from it), and place every actor's sprite at its position and frame. Call once a frame,
/// after updating the actors and setting the camera
void updateLevel(void);

/// @brief The loaded level, or NULL
const LevelDef *getLevel(void);

/// @brief Level size in pixels
int getLevelWidth(void);
int getLevelHeight(void);

/// @brief The size of the level's tiles: 8 or 16. Tile positions (getLevelTile etc) are in these
int getLevelTileSize(void);

/// @brief The tile at a tile position in the level, from the level in RAM (so anywhere in the level, on screen or not)
/// @param layerIX The engine layer the level layer is shown on
/// @return The tile number (0 for none), or -1 if layerIX isn't a level layer
int getLevelTile(int layerIX, int tileX, int tileY);

/// @brief The foreground tile at a tile position (drawn in front of the layer's sprites)
/// @param layerIX The engine layer of the level layer the foreground belongs to (not the foreground's own layer)
/// @return The tile number, 0 if there's none there, or -1 if layerIX isn't a level layer
int getLevelForegroundTile(int layerIX, int tileX, int tileY);

/// @brief The LEVEL_TILE_ flags of the tile at a tile position (0 if none)
uint8_t getLevelTileFlags(int layerIX, int tileX, int tileY);

/// @brief The LEVEL_TILE_ flags of a tile number in a layer's tile set, wherever it is (0 if the layer isn't a level
/// layer) - e.g. to check a tile before setLevelTile puts it in
uint8_t getLevelTileSetFlags(int layerIX, uint8_t tile);

/// @brief True if the tile at a level pixel has a pixel set there (in its graphic as drawn now, animated tiles included),
/// whatever its flags
bool isLevelPixelSet(int layerIX, int x, int y);

/// @brief True if the tile at a level pixel has the LEVEL_TILE_SOLID flag and a pixel set there (pixel accurate, so
/// slopes work)
bool isLevelPixelSolid(int layerIX, int x, int y);

/// @brief Change a tile in the level (e.g. a pickup collected, a wall broken) - on screen too, if it's in view
void setLevelTile(int layerIX, int tileX, int tileY, uint8_t tile);

// ---------------------------------------------------------------------------
// Objects and actors
// ---------------------------------------------------------------------------

/// @brief How many objects the level has
int getLevelObjectCount(void);

/// @brief An object as placed in Tiled
const LevelObject *getLevelObject(int objectIX);

/// @brief An object's live state (see LevelActor)
LevelActor *getLevelActor(int objectIX);

/// @brief True if an actor is alive and not waiting for the camera - the ones for the game to update
bool isLevelActorActive(int objectIX);

/// @brief The first object of a class (e.g. the player start), or -1 if there's none
int findLevelObject(int cls);

/// @brief An object's property (see LevelProp), or def if it doesn't have it. Ints and floats convert either way;
/// object properties give the other object's index
int32_t getLevelObjectInt(int objectIX, int prop, int32_t def);
float getLevelObjectFloat(int objectIX, int prop, float def);
const char *getLevelObjectString(int objectIX, int prop, const char *def);

/// @brief The level object a sprite is showing (for a sprite hit in a collision, say), or -1
int getSpriteLevelObject(int spriteIX);

/// @brief Kill an actor: its sprite goes, and it isn't updated or shown again (until the level is loaded again)
void killLevelActor(int objectIX);

/// @brief Set up what happens as actors get and lose sprites (either can be NULL). Call after loadLevel
void setLevelActorCallbacks(LevelShowFn show, LevelHideFn hide);

/// @brief How near the camera actors need to be, in pixels beyond the edges of the screen: to get a sprite (default
/// 32), to lose it (default 96 - further, so sprites don't flicker on and off at the edge), and for waiting actors to
/// wake (default 0: as they reach the edge of the screen)
void setLevelActorMargins(int show, int hide, int wake);

/// @brief Every sprite class's sprites join a set as they're shown, with collision flags (see sprite sets) - so a hit
/// sprite's set says what it is. Call after loadLevel
/// @param setIX The set, or SPRITE_SET_NONE
void setLevelClassSprites(int cls, int setIX, uint8_t collisions);

/// @brief The first object with a name (as set in Tiled), or -1
int findLevelObjectByName(const char *name);

// ---------------------------------------------------------------------------
// Moving between levels, switches, and what's remembered
// ---------------------------------------------------------------------------

/// @brief Set the game's level setup and switch handler (they stay set, for every level)
void setLevelHandlers(LevelSetupFn setup, LevelSwitchFn onSwitch);

/// @brief Enter a level: load it (with its remembered state - collected keys and killed bosses stay gone, switches as
/// they were left), call the game's level setup, replay its switches that are on (the switch handler is called for
/// each, with LEVEL_SWITCH_REPLAY, so doors are open etc before anything's drawn), and find the entrance. The level
/// being left needs nothing doing - its state is remembered as it changes
/// @param levelID LEVEL_ID_... (e.g. from an exit's "toLevel" property)
/// @param entrance The name of the entrance object to arrive at (e.g. an exit's "toEntrance"), or NULL for "start"
/// @return The entrance object (put the player at its actor's position, facing its dir), -1 if it wasn't found, or -2
/// if the level couldn't be loaded
int enterLevel(int levelID, const char *entrance);

/// @brief The loaded level's LEVEL_ID_..., or -1
int getLevelID(void);

/// @brief The loaded level's type: its "levelType" (LEVEL_TYPE_... in levels/levelObjects.h), 0 if none is loaded
int getLevelType(void);

/// @brief The loaded level's own properties (its map's properties in Tiled, by LEVEL_PROP_... - e.g. LEVEL_PROP_LEVEL_NAME),
/// or def if it doesn't have it. Any level in levelList can be read without loading it: getLevelDefString etc
int32_t getLevelPropInt(int prop, int32_t def);
float getLevelPropFloat(int prop, float def);
const char *getLevelPropString(int prop, const char *def);
int32_t getLevelDefInt(const LevelDef *lv, int prop, int32_t def);
const char *getLevelDefString(const LevelDef *lv, int prop, const char *def);

/// @brief Use a switch, as its mode says (turn on, toggle, or turn on for its time). The handler's called if it
/// changes (a timed switch used again while on just restarts its time)
/// @return True if it changed
bool useLevelSwitch(int objectIX);

/// @brief Turn a switch on or off from the game (the handler's called with LEVEL_SWITCH_SET if it changes)
void setLevelSwitch(int objectIX, bool on);

/// @brief True if a switch is on
bool getLevelSwitch(int objectIX);

/// @brief The first switch with a value, or -1
int findLevelSwitch(int value);

/// @brief 5 bits of the game's own remembered state for a persistent object (e.g. how many times it's been used) - 0
/// for objects that don't persist
uint8_t getLevelObjectMemory(int objectIX);
void setLevelObjectMemory(int objectIX, uint8_t value);

/// @brief Replay the level's switches that are on (the switch handler's called for each with LEVEL_SWITCH_REPLAY) -
/// enterLevel does this. For games that load levels with loadLevel directly
void replayLevelSwitches(void);

/// @brief Everything remembered about every level, e.g. to write to a saved game and put back when it's loaded (it's
/// LEVEL_STATE_SIZE bytes, engine/defs.h - each level's part is the size of its persistent objects)
uint8_t *getLevelStateStore(void);

/// @brief Forget everything remembered about every level (e.g. a new game)
void clearLevelStateStore(void);

/// @brief Turn a switch on or off in a level's remembered state, whether or not it's the level loaded - e.g. a switch
/// in one level opening a door in another. The switch handler isn't called (the change is replayed when the level's
/// entered)
/// @param slot The switch's slot (LEVEL_SLOT_<LEVEL>_<NAME> in levels/levelObjects.h, for named persistent objects)
void setLevelSwitchState(int levelID, int slot, bool on);
bool getLevelSwitchState(int levelID, int slot);

/// @brief Length of a path object (polyline or polygon) in pixels
float getLevelPathLength(int objectIX);

/// @brief The point a distance along a path object (clamped to its ends; a polygon's distance wraps around)
/// @return False if the object isn't a path
bool getLevelPathPoint(int objectIX, float distance, float *x, float *y);
