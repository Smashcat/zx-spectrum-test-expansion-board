# Levels

Levels are made in [Tiled](https://www.mapeditor.org/). The level converter (`levelconv`) turns them into
packed C data in this folder (`level_<name>.c` / `.h`, and `levels.h`, which includes them all). Any `.c`
file here is built into both the firmware and the PC emulator.

At run time, `loadLevel` unpacks a level into RAM (`LEVEL_RAM_SIZE` in `engine/defs.h`, 128KB), and
`setLevelCamera` scrolls it. As the camera moves, the tiles coming into view are copied into the engine's
64x64 tile layers, so a level can be much bigger than a tile layer (up to 256x256 tiles fits easily). See
`engine/level.h` for the functions.

```
levels/
    tiled/                      Tiled project, maps and tile sets (the files you edit)
        ZXelerator.tiled-project
        demo.tmx                The demo level (press L on the title screen)
        demoTiles.tsj / .png    Its tile set (levelDemoTileDef in engine/tileDefs.c)
    level_demo.c / .h           Converted - don't edit these
    levels.h                    Includes every converted level
```

## Setting up Tiled

Open `levels/tiled/ZXelerator.tiled-project` in Tiled (File > Open Project). The project adds:

- **F5 - Convert level for ZXelerator**: saves the map, then converts it into this folder. The result
  (sizes, packing, RAM needed) or any errors show in Tiled's Console (View > Views and Toolbars > Console).
- **Shift+F5 - Convert all levels**
- **F6 - Redraw tile set image**: with a tile set open, saves it and redraws its image in the colours set on
  its tiles.
- The **ZXColour** property type, for tile colours, and **TileType**, for tile types.

The commands run `pc/build/Release/levelconv.exe`, so build the PC project first (`pc\build.bat`). If the
repository is somewhere other than `G:/repos/Speccy`, change the paths in Project > Project Properties >
Commands.

## Tile sets

Tile graphics come from the engine: 256 8x8 tiles and their masks, as a `const uint8_t name[4096]` array
declared in `engine/tileDefs.h` (the converter finds every such array when it's built). Tile 0 is always
empty.

**16x16 tiles:** a map's tile size (8x8 or 16x16, set when making the map in Tiled) is its levels' tile size.
A 16x16 level stores a byte per 16x16 tile, a quarter of the RAM of the same level in 8x8 tiles, and up to 256
different 16x16 tiles. Its tile sets are `const uint8_t name[16384]` arrays: 256 tiles of 32 bytes, each pixel row
2 bytes (left, then right, as 16 wide sprites), then 256 masks the same way. `levelconv tileset` makes 16x16 Tiled
tile sets from them. The engine's layers are still 8x8 cells: each 16x16 tile fills 2x2 cells, and the renderers
draw each cell's quarter of it (`setLayerTileSize`). Scrolling, rotation, Mode 7, foregrounds, animated tiles and
collisions all work the same, and 8x8 levels and layers (e.g. text) work alongside. A 16x16 tile spans 4 rows of
attributes (4 pixels each): `ink`, `paper`, `bright` and `transparent` set its top row, `...Row1` to `...Row3` its
others (each as the row above if not set, with `...Bottom` setting the bottom half). In a 16x16 level, tile
positions (`getLevelTile`, `setLevelTile` etc) are in 16x16 tiles, and `getLevelTileSize` gives the size. The
loaded tile set takes 16KB of the level RAM (4KB for 8x8). `demo16.tmx`, through the cave's second door, is a
16x16 level.

**Themes:** a tile set is its own file, shared by every map that uses it. Make one per theme (one engine tile
graphics array, and its `.tsj` with colours, flags and animations), and every level in that theme uses it; change
a tile once and they all change. The converter writes each tile set's colours, flags and animations once
(`levels/tileset_<name>.c`), shared by its levels in flash. Each layer uses one tile set (256 tiles), and a level
can use up to 4, e.g. its theme's for the main layers, and a shared one for backgrounds.

To make a Tiled tile set for one:

```bat
pc\build\Release\levelconv.exe tileset levels\tiled\myTiles.tsj myTileDef
```

This writes `myTiles.tsj` and `myTiles.png` (the tiles drawn in their colours). Set the colours and
behaviour of each tile as custom properties in Tiled's tile set editor (select several tiles to set them
all at once), then press F6 to redraw the image:

| Property | Type | |
|---|---|---|
| `ink`, `paper` | ZXColour | Colours of the top half of the tile (4 lines) |
| `bright` | bool | |
| `transparent` | bool | Leave the colours under the top half alone (only the pixels are drawn) |
| `inkBottom`, `paperBottom`, `brightBottom`, `transparentBottom` | | The bottom half - each defaults to the top half's |
| `solid` | bool | Walls and floors (`LEVEL_TILE_SOLID`) |
| `platform` | bool | Solid from above only (`LEVEL_TILE_PLATFORM`) |
| `hazard` | bool | `LEVEL_TILE_HAZARD` |
| `collect` | bool | Pickups (`LEVEL_TILE_COLLECT`) |
| `tileType` | TileType | The tile's type (bits 4-7 of its flags), for the game: see below |
| `flags` | int | ORed into the tile's flags |

`ink`, `paper` and `bright` on the tile set itself are the defaults for its tiles (white on black). The
engine doesn't act on the flags: they're for the game, through `getLevelTileFlags` and `isLevelPixelSolid`.

**Tile types:** the project's **TileType** enum (Project > Project Properties > Custom Types) names up to 16
kinds of tile: none, conveyorLeft, conveyorRight, superJump and grapplePoint so far. Add your own values to the
end, so the numbers of tiles already set don't change. Converting writes them to `levels/levelObjects.h`
(`TILE_TYPE_CONVEYOR_LEFT` etc), and a tile's type is `LEVEL_TILE_TYPE(getLevelTileFlags(...))`. It combines
with the other flags: a conveyor is `solid` too. `getLevelTileSetFlags(layer, tile)` gives a tile number's flags,
wherever it is (e.g. to check a tile before `setLevelTile` puts it in).

In `demo16.tmx`, the level test player is carried along by conveyors (34, animated, going right, and 38, the same
frames backwards, going left) and bounced up by the springboard (39, higher holding jump). The springboard shows the
next tile (40, squashed) for a moment, as that's a springboard too.

**Animated tiles** use Tiled's Tile Animation Editor: frames are other tiles of the same tile set (in its
first 256), and their durations are rounded to 25ths of a second. The tile's own colours are used for
every frame. Every copy of an animated tile animates together, at no cost per tile. The tile set is
copied to RAM, and the tile's graphic and mask are rewritten when its frame changes.

### Importing your own graphics (PNG)

Tiles and sprites can be drawn in any paint program and imported from a PNG. Your image is the tile set's image
in Tiled, so you see exactly what you drew. It stays the source of the graphics: converting a level reads it again
each time, so edit the image, press F5, and the level and the game's graphics are up to date - no rebuilding the
converter, and nothing to copy into the engine. Put the image in `levels/tiled`, then:

```bat
pc\build\Release\levelconv.exe import levels\tiled\caveTiles.png caveTiles 16
pc\build\Release\levelconv.exe importsprites levels\tiled\bat.png batSprite 16x16 7
```

- `import <image> <name> [8|16]`: tiles of 8x8 (the default) or 16x16, left to right then down, up to 256. The
  first (top left) is tile 0, which is always empty - leave it clear.
- `importsprites <image> <name> <width>x<height> [palette]`: sprite frames of one of the engine's sprite sizes,
  left to right then down. The palette is the sprites' colours in the game (`engine/palette.c`).

Each makes a Tiled tile set next to the image (`caveTiles.tsj`), and the engine graphics as
`levels/gfx_<name>.c` and `.h` (the array `<name>`, and for sprites `<name>Mask`), which the game and PC builds
compile with the levels. Importing again (e.g. after changing the image's size) keeps everything set in Tiled:
tiles' flags, types, colours and animations.

How the image's pixels become the engine's:

| In the image | In the engine |
|---|---|
| Transparent (alpha under half) | Not drawn: what's behind shows (mask clear) |
| The paper colour (black, unless the tile set's `imagePaper` property says otherwise) | Paper: drawn, a clear pixel |
| Any other colour | Ink: a set pixel - and what collisions see |

So draw with black (or your `imagePaper` colour) as the background, and the shapes in colours. Colours are matched
to the nearest Spectrum colour. Each tile's colours come from the image: each 8x4 attribute cell gets the
paper colour and its most common ink colour, bright if that ink is bright. A cell with more than one ink colour
can't be shown on the Spectrum; the converter warns about how many there are, and uses the most common. A cell
that's all transparent leaves the colours under it alone. To choose a tile's colours yourself, give it any of the
usual colour properties in Tiled (`ink`, `paper`, `bright`, `transparent`, ...) and those are used instead.
Sprites use their palette, not the image's colours.

Any PNG works (palette, greyscale, RGB or RGBA, any bit depth), except interlaced ones. F6 (redraw the tile set
image) leaves an imported image alone.

## Maps

- Orthogonal, 8x8 tiles, not infinite. Any tile layer format (CSV or Base64) works.
- Tiles can't be flipped or rotated, since the engine can't draw them that way.
- Each layer can only use tiles from one tile set.

Tile layers are included by giving them custom properties (layers without a `layer` property are left out,
e.g. for notes):

| Property | Type | |
|---|---|---|
| `layer` | int | The engine layer (0-4) it's shown on. Lower numbers are drawn in front |
| `foregroundOf` | string | This layer's tiles are drawn in front of another layer's sprites (see below) |
| `wrapX`, `wrapY` | bool | The layer repeats across/down (e.g. parallax backgrounds) |
| `ink`, `paper`, `bright` | ZXColour/bool | One colour for the whole layer instead of its tiles' colours (see below) |
| `transparent` | bool | The layer has no colour of its own: its pixels show in the colour of the layers behind |

Tiled's **parallax factor** (layer properties) sets how fast a layer scrolls with the camera, and the
layer **offset** moves it. Groups work too, and their parallax and offsets combine.

Each layer is trimmed to the area its tiles cover. A repeating layer repeats that area, so draw one
repeat of the background (e.g. 64 tiles across) at the left of the map.

### Level type, name and other level properties

Give a map the **Level** class (Map > Map Properties > Class) for its level's own properties:

| Property | Type | |
|---|---|---|
| `levelType` | LevelType | platform (the default) or shooter - add your own kinds of stage to the enum |
| `levelName` | string | e.g. for a title as the level starts |
| `levelDescription` | string | |

Add more members to the class (Project > Custom Types) and every level gets them, or add a property to just one
map. Each becomes a `LEVEL_PROP_...` like object properties. The game reads them with `getLevelType()` (`LEVEL_TYPE_SHOOTER`
etc. in `levelObjects.h`) and `getLevelPropInt`, `getLevelPropFloat` and `getLevelPropString`. Any level's can be read
without loading it, e.g. for a level select screen: `levelList[id]->type`, `getLevelDefInt(levelList[id], prop, def)`
and `getLevelDefString`.

The level test shows the name and then the description as a level starts. On foot in platform levels, it flies
in shooter levels: O/P/Q/A fly in any direction, with no gravity, and exits are taken by flying into them.
`flight.tmx`, through the door at the right end of demo16, is a shooter level: a cave tunnel to fly through, in one
colour.

**Flying enemies:** place **Flyer** objects (e.g. with the saucer sprite sheet). Each sets off towards the player
when the camera reaches it (`waitForCamera`, on by default), so waves come at the player from whichever side
they're flying from, and it's gone once it has flown well past them. Its `pattern` (the FlyPattern enum) is one of:

| Pattern | |
|---|---|
| straight | Straight across at `speed` |
| sine | Across, weaving up and down `amplitude` pixels around where it was placed, once every `period` frames |
| swoop | Straight in, then within 3 x `amplitude` across of the player, curving up or down through them |
| path | Along its `path` object: a polygon loops; at the end of a polyline it carries on the way it was going |
| homing | Turning towards the player a little at a time |
| launch | Waiting on the roof or floor until the player is within `range`, then launching at them and chasing them |

`hp` is how many hits it takes. A flyer with a `fireRate` (frames between shots, 0 for none) shoots at the player
while they're about on screen, at `shotSpeed`. Launchers (the mine sheet) don't shoot.

**Turrets:** a turret's base is part of the level, a dome tile in the floor or roof (demoTiles 38-39 on the floor,
40-41 on the roof, both solid). Its gun is a **Turret** object (the turretGun sheet) placed at the middle of the
dome's flat side, with `ceiling` set for one on the roof. The gun is a sprite rotated to follow the player, turning
`turnSpeed` radians a frame and only as far as 80 degrees either side of straight out. It fires along the gun,
from its end, when it's pointing at the player and they're within `range`: every `fireRate` frames, at `shotSpeed`.
It takes `hp` hits to destroy, which leaves the dome.

In the level test, M fires bullets (sprites) the way the player faces. A bullet that hits a wall sparks back off it.
One that destroys an enemy blows it apart in particles: a big burst carried on the way the shot was going, and
smaller ones up, down and back the other way. Enemy shots (sprites) fly straight, puff out on walls, and cost the
player a life.

### Foreground tiles

Sprites are drawn after the layer they're on, so to have a tile drawn in front of a sprite (a pillar the
player walks behind, grass over their feet), paint it on a layer with `foregroundOf` set to the name of the
sprite's layer, and `layer` set to a lower numbered engine layer. For example, in the demo level:

| Tiled layer | `layer` | |
|---|---|---|
| Sky | 4 | parallax 0.25, `wrapX` |
| Hills | 3 | parallax 0.5, `wrapX` |
| Level | 2 | The layer the player is on |
| Foreground | 1 | `foregroundOf` = Level |
| (the game's HUD) | 0 | |

Foreground tiles aren't stored as a second copy of the layer. They're a bit per tile, plus the list of
foreground tiles, so a sparse foreground costs little RAM. A tile can be on both the layer and its
foreground (a wall behind a pillar), and the layer's tile is the one used for collisions.
`setLayerFollow` keeps the foreground layer lined up with its layer, however it's scrolled, rotated or
scaled.

### Single colour layers

Fast scrolling or parallax layers with per-tile colours clash badly, so a layer can be one colour instead.
Give it any of `ink`, `paper` (ZXColour, default white on black) or `bright` and the whole layer is drawn in
that colour. Its tiles' colours are ignored and no colour is copied while it scrolls, so it's quicker too.
Give layers in front of it `transparent` and they add only their pixels, keeping that colour. Anything that
does set colour on a layer further forward, such as a HUD on layer 0, is drawn over the top in its own colours.

In `demo16.tmx`, Sky is bright white on blue, and Level (with its foreground) is `transparent`:

| Tiled layer | `layer` | |
|---|---|---|
| Sky | 4 | `ink` white, `paper` blue, `bright` |
| Level | 2 | `transparent` |
| Foreground | 1 | (a foreground of a single colour layer is always pixels only) |
| (the game's HUD) | 0 | its own colours |

Sprites keep their own palettes. Games can set this on any layer too:

```c
setLayerColour(4,0x4F);                 // one colour: bright white ink on blue paper (as an attribute byte)
setLayerColour(2,LAYER_COLOUR_NONE);    // pixels only, keep the colour from behind
setLayerColour(2,LAYER_COLOUR_CELLS);   // back to each cell's own colour (the default)
```

When a single colour layer is rotated or scaled with line tables (Mode 7, etc.), only the attribute rows
of its enabled lines are coloured, so the colour stops at a horizon.

## Using a level

```c
#include "levels.h"

loadLevel(&level_demo);                 // false if it doesn't fit in LEVEL_RAM_SIZE
// each frame:
setLevelCamera(camX,camY);              // the level pixel at the top left of the screen
updateLevel();                          // animated tiles
```

Level coordinates are the layers' own pixel coordinates, so a layer space sprite's position (see
`setSpriteSpace`) is its position in the level. The player in the level test (`gameFunc.c`, press L on
the title screen) is one. It moves in level pixels and checks for floors, walls and platforms with
`isLevelPixelSolid`, `isLevelPixelSet` and `getLevelTileFlags`. These read the level in RAM, so they work
anywhere in the level, whether it's on screen or rotated. `setLevelTile` changes a tile (e.g. a coin
collected), on screen too.

`setLevelCamera` keeps the 64x64 tiles around the middle of the screen in each engine layer. That's
enough for any rotation at a scale of 0.65 or more. It should be called after changing a level layer's
rotation or scale in the frame. The engine layer lookups (e.g. `getSpriteTileAtI`) are right within about
16 tiles of the screen.

## Objects: sprites, generators, paths

Object layers hold everything that isn't tiles: where sprites start, generators, trigger areas, paths.

**Sprite sheets** show engine sprite graphics in Tiled, one tile per frame, so objects look like the real
sprites:

```bat
pc\build\Release\levelconv.exe sprites levels\tiled\enemy.tsj sprite24x24Def mask24x24Def 24x24 7
```

The arguments are the graphics and mask arrays from `engine/spriteDefs.h`, the sprite size, and the palette
(`engine/palette.c`). F6 redraws a sprite sheet too, e.g. after changing its palette. Place sprites with
Tiled's Insert Tile tool. Flipping one across sets `LEVEL_OBJ_FLIP_X`, e.g. to face the other way.

**Level tiles as objects:** tiles from a level tile set can be placed with Insert Tile too. They become sprites of
that tile, 8x8 or 16x16 by the tile set, drawn from the level's RAM copy of the tile set. They cost no extra
graphics, and animated tiles animate on them too. Use them for moving pieces of the scenery, e.g. a brick that's a
Platform, or a torch. The tile's own properties (colours, `solid`) aren't the object's. A sprite has a palette rather
than tile colours: the tile set's `spritePalette` property (int, default 0, no colour of its own) sets it. A tile
object's tile set doesn't have to be used by any layer, and it can be a different tile size to the map. A switch
made from a level tile shows the next tile along when it's on. In `demo16.tmx`, the brick lift over the pool and
the torch on the hill are level tiles.

In code, `setSpriteTile(sprite, layer, tile)` does the same for any sprite: it shows the layer's tile set's tile, at
the layer's tile size.

**Classes** are set up in the project (Project > Project Properties > Custom Types): e.g. Enemy, Platform,
Generator, PlayerStart. Each class's members are the properties its objects get, with defaults you can
change per object. Converting writes `levels/levelObjects.h`, which numbers the classes (`LEVEL_CLASS_ENEMY`)
and properties (`LEVEL_PROP_SPEED`) for the game code. Property types:

| Tiled type | In the game |
|---|---|
| int, bool, color | `getLevelObjectInt` |
| float | `getLevelObjectFloat` |
| string, file | `getLevelObjectString` |
| object (a link to another object, e.g. a platform's path) | `getLevelObjectInt` gives the other object's index |

A `waitForCamera` property (bool) keeps an object dormant until the camera reaches it, e.g. for a wave of
enemies in a shoot-em-up stage whose pattern starts when it comes into view. An object layer's `layer`
property sets which engine layer its sprites go on. Otherwise it's the front-most layer that moves with the
camera. Points, rectangles and polylines/polygons work too. A path's points are in level pixels, and
`getLevelPathPoint` gives the point a distance along it.

### Actors

Every object gets an **actor** when the level loads: its live state (position, velocity, angle, timer, state,
hit points, facing, frame). The game updates the actors every frame, wherever they are, so enemies keep
patrolling off screen. The level's tile lookups (`isLevelPixelSolid` etc) work anywhere in the level. Actors
only react to the player when the game's code decides they're close enough.

The engine only decides which actors have a **sprite**. `updateLevel` gives one to each actor that comes
within 32 pixels of the view and takes it back once the actor is 96 pixels away (`setLevelActorMargins`),
so the number of sprites stays small however many objects a level has. Each sprite is set up from its
object's sprite sheet and frame, in layer space, and placed at the actor's position and frame every frame.
`setLevelClassSprites` puts a class's sprites in a sprite set with collision flags. Then, when the player
hits a sprite, `isSpriteInSet` says what it is and `getSpriteLevelObject` says which object.
`setLevelActorCallbacks` lets the game adjust sprites as they're given and taken. `killLevelActor` removes
an actor for good (e.g. a stomped enemy).

```c
setLevelClassSprites(LEVEL_CLASS_ENEMY,enemies,COLLIDE_TARGET);
// each frame:
for(int ix=0;ix<getLevelObjectCount();ix++){
    if(!isLevelActorActive(ix)){
        continue;
    }
    LevelActor *a=getLevelActor(ix);
    switch(getLevelObject(ix)->cls){
        case LEVEL_CLASS_ENEMY: /* move a->x, a->y, set a->frame */ break;
        ...
    }
}
setLevelCamera(camX,camY);
updateLevel();      // sprites near the camera, placed where the actors are
```

Sprites that aren't level objects (bullets, bubbles from a generator) come from `allocateSprite` and go
back with `freeSprite`, sharing the sprites with the actors. `initSprites` sets how many there are.

The level test (`gameFunc.c`) has examples of each: enemies that patrol, turning at walls and ledges, and
chase when the player is in front of them and in range; a lift that follows a path and carries the player;
a generator that makes bubbles while the player's nearby; and pistons.

**Pistons** (class Piston) push their head along a path (from its first point, pulled in, to its last,
pushed out), up, down, left or right. The properties are:
- `speedOut` and `speedIn`: how fast the head pushes out and pulls back.
- `waitOut` and `waitIn`: the pauses in frames at each end.
- `phase`: frames to wait at the start, so a row of pistons can fire one after another.
- `shaftTile`: the first of the two shaft tiles.

The head is the only sprite. The shaft behind it is written into the level as tiles, two tiles thick (`shaftTile`
and `shaftTile+1`, e.g. 34/35 up and down, 36/37 across in the demo tile set), only changing as the head
crosses a tile. Mark the shaft tiles `solid` and the shaft is solid with no extra code. Place the head so its
back edge is on a tile edge, keep its path clear in the map (the tiles are cleared as it pulls back), and make
the head at least 8 pixels long in the direction it moves, to cover the partly filled tile behind it. In
the demo, the head's front crushes the player while it's pushing out. Its sides and back are solid, and a
head that lands on the player without crushing them pushes them out to the side.

## Switches, keys, doors and more levels

### Switches

Any object with a `mode` property is a **switch**: on or off. The properties the engine uses:

| Property | Type | |
|---|---|---|
| `mode` | SwitchMode | `once` (turns on, stays on), `toggle`, or `timed` (turns off `time` frames after it was last used) |
| `value` | SwitchId | Passed to the switch handler. Switches can share a value (two levers for one gate), and a key opens doors with its value |
| `time` | int | For timed switches (e.g. pressure plates) |
| `startOn` | bool | |
| `persist` | bool | Remember its state when the player leaves the level (see below) |

The Switch, Door and Key classes in the project have these as members, with defaults. SwitchId is an enum in the
project (Project > Project Properties > Custom Types): add a value for each thing switches control (e.g.
`gateA`), and it becomes `SWITCH_ID_GATE_A` in `levels/levelObjects.h`. A switch with a sprite shows the frame
it was placed with when it's off, and the last frame of its sprite sheet when it's on. Any frames in between are
for the game to play as it changes, e.g. a door opening.

**The game has one switch handler for every switch in every level:**

```c
void onSwitch(int value, bool on, int objectIX, uint8_t why)
{
    switch(value){
        case SWITCH_ID_PISTONS:  pistonsStopped=on;  break;
        case SWITCH_ID_LIFT_CALL: liftCalled=on;     break;
    }
}
```

`why` is `LEVEL_SWITCH_USED` (`useLevelSwitch`, e.g. the player pulled it), `LEVEL_SWITCH_SET` (`setLevelSwitch`,
the game changed it), `LEVEL_SWITCH_EXPIRED` (a timed switch turned itself off) or `LEVEL_SWITCH_REPLAY`
(entering a level, see below). The handler is written to set up a state ("the pistons are stopped", "the door is
open"), not to start something happening, so that replaying it puts everything back as it was.

### Remembered state, and replay

Objects with `persist` set (in the class, or on the object) are remembered when the player leaves the level: a
byte each, holding whether a switch is on, whether the object's gone (`killLevelActor`: collected keys, killed
bosses), and 5 bits for the game (`getLevelObjectMemory`/`setLevelObjectMemory`). The engine keeps this for every
level (`LEVEL_STATE_SIZE` in `engine/defs.h`), so nothing needs saving by the game. `getLevelStateStore` gives it
all, to write into a saved game and put back, and `clearLevelStateStore` starts a new game.

**Entering a level** (`enterLevel`):
1. It loads the level, with gone objects left out and switches as they were left.
2. It calls the game's level setup (`setLevelHandlers`).
3. It replays every switch that's on through the switch handler (`LEVEL_SWITCH_REPLAY`), so doors are open and
   pistons stopped before anything's drawn.
4. It returns the entrance to put the player at.

`setLevelSwitchState` changes a switch in a level that isn't loaded (a lever in one level opening a door in
another). Named persistent objects get constants for this in each level's header, e.g.
`LEVEL_SLOT_DEMO_PISTON_LEVER`.

### Levels, entrances and exits

Every map in `levels/tiled` is a level, numbered in name order: `LEVEL_ID_CAVE`, `LEVEL_ID_DEMO` in `levels/levels.h`.
`levelList` holds them all. A level's number changes if a map is added before it alphabetically. Saved games
depend on these numbers and on each level's number of persistent objects, so settle the level names before the
game ships.

- **Entrances** (class Entrance, usually a point) are found by their object name. A level can have any number
  (one per door into it). `enterLevel(id, NULL)` uses the one named `start`.
- **Exits** (class Exit, usually an area) have:
  - `toLevel`: a file property. Pick the other level's `.tmx` in Tiled, and it becomes that level's number.
  - `toEntrance`: the name of the entrance to arrive at.

  The level test uses an exit when the player presses A over it:
  `enterLevel(getLevelObjectInt(exit,LEVEL_PROP_TO_LEVEL,-1), getLevelObjectString(exit,LEVEL_PROP_TO_ENTRANCE,"start"))`.
  An entrance's facing is its flip in Tiled.

### Doors, and solid sprites

Doors are sprites (the demo's are 16x32, 4 frames), so they can animate, and they need no tiles in the tile set.
In the demo:
- **Gate doors** (class Door, a switch) block the way until opened by their key or a switch. The first time,
  they play their opening frames; when a level's entered with them open, they're simply open.
- **Doors to other levels** (class Exit, with a sprite) open into the screen, so they never block the player
  walking past. Using one plays its opening frames, and then the player goes through.

A sprite blocks movement when it's **solid**: `setSpriteSetSolid` makes a sprite set's sprites solid (those in
it now, and those added later), `setSpriteSolid` changes one (a door once it's open), and `getSolidSpriteAt`
finds a solid sprite in a box in a layer's coordinates. The level test checks for solid sprites wherever it checks
for solid tiles, so closed gate doors and piston heads stop the player and enemies like walls.

**The demo:**
- The lever before the pistons (A to pull) stops them, and they stay stopped if you leave and come back.
- The plate by the lift, when you stand on it, calls the lift down.
- The door by the start (A) leads to the cave, where there's a key. Take it back to the gate door at the far end
  of the demo level, and the door slides open as you reach it. It stays open, and the key stays taken.

## RAM

A level needs its tile sets (4KB each) plus, for each layer, a byte per tile of its trimmed area, and for
a layer with a foreground, a bit per tile, a byte per foreground tile and 2 bytes per row. Each object's
actor takes 32 bytes (the objects themselves stay in flash). The converter
reports the total and refuses a level that won't fit. The demo level (192x40) needs 16KB. A 256x256
level with a foreground, parallax sky and hills needs around 80KB.
