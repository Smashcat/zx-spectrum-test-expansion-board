# ZXelerator PC emulator

Runs the game and engine code on a Windows PC, with an SDL2 window standing in for the Spectrum.
The screen is decoded from the same ASM banks the Z80 would run, the PC keyboard feeds
`keyboardScan[]`, and the beeper OUT lists are played as audio.

## Two independent builds

The RP2350 firmware and the PC emulator build from the same game and engine sources, but they are
separate CMake projects with separate build folders. Nothing needs switching: you can build either
one at any time.

| | RP2350 firmware | PC emulator |
|---|---|---|
| CMake project | `CMakeLists.txt` | `pc/CMakeLists.txt` |
| Build folder | `build/` | `pc/build/` |
| Compiler | Arm GCC (Pico SDK 2.1.1) | MSVC (Visual Studio 2026) |
| Output | `build/ZXelerator.elf` / `.uf2` | `pc/build/Release/ZXeleratorPC.exe` |
| Entry point | `ZXelerator.c` + `engine/funcs.c` (PIO / Z80 servicing on core 0) | `pc/pc_main.c` (replaces both) |

### Building the RP2350 firmware

Open `code/ZXelerator` in VS Code with the Raspberry Pi Pico extension installed, then:

- **Compile Project** task (or the extension's Compile button): builds into `build/`
- **Flash** task: programs the device over SWD using openocd

This needs the Pico SDK toolchain in `%USERPROFILE%\.pico-sdk`, which the extension installs.

### Building the PC emulator

Needs Visual Studio 2026 (Community is fine) with the **Desktop development with C++** workload.
CMake is not needed separately: `build.bat` finds the copy bundled with Visual Studio. SDL2
is downloaded automatically on the first build.

```bat
code\ZXelerator\pc\build.bat          :: build only
code\ZXelerator\pc\build.bat run      :: build, then run
```

Or run `pc\build\Release\ZXeleratorPC.exe` directly after building.

If you add a new `.c` file to the project, add it to **both** `CMakeLists.txt` and
`pc/CMakeLists.txt`. Files that use Pico hardware (PIO, DMA, multicore, GPIO) should stay out of
the PC build, as `engine/funcs.c` does.

### Engine tests

`build.bat` also builds `pc\build\Release\ZXeleratorTests.exe`, which doesn't need SDL:

```bat
pc\build\Release\ZXeleratorTests.exe [folder for BMPs]
```

It checks that the rotation/scaling renderers give exactly the same pixels as the fast renderers when
nothing is rotated (tile layers, bitmap layers and every sprite width, at thousands of positions). It
also renders example scenes (rotated layers and sprites, Mode 7 floor) to BMP files. It exits with
code 1 if any comparison fails.

### Level converter

`build.bat` also builds `pc\build\Release\levelconv.exe`, which converts levels made in Tiled into
`levels/*.c` - see [levels/README.md](../levels/README.md). Converted levels are ordinary source files,
built into both the firmware and the emulator (any `.c` file in `levels/` is picked up automatically).

## Controls

| Key | Action |
|---|---|
| Letters, digits, Enter, Space | Spectrum keys |
| Shift / Ctrl | CAPS SHIFT / SYMBOL SHIFT |
| Cursor keys, Backspace | CAPS SHIFT + 5/6/7/8, CAPS SHIFT + 0 |
| F2 | Toggle display source: ASM bank (what the Z80 draws) / render buffer |
| F3 | Mute / unmute audio |
| F5 / F6 | Pause / step one frame while paused |
| Tab (hold) | Fast forward |
| F9 | Start / stop recording video (`recording_YYYYMMDD_HHMMSS.avi`) |
| F12 | Save screenshot (`screenshot_NNNNN.bmp`) |
| Esc | Quit |

The window title shows the frame rate and the PC time spent on game logic + compositing per frame.
This is only useful for comparing one scene with another, not as an RP2350 timing.

## Command line options

| Option | Effect |
|---|---|
| `--shot FRAME file.bmp` | Save a screenshot at that frame; exits after the last one (can be repeated) |
| `--hold FROM TO KEY` | Hold a PC key (SDL name, e.g. `M`, `Space`, `Left`) from frame FROM to TO, for scripted tests (can be repeated) |
| `--wav file.wav` | Record the beeper audio |
| `--record file.avi` | Record video with audio from the start (see below) |
| `--record-scale N` | Pixel scale for recordings: 1 = 320x256 (default), 2 = 640x512, etc. |

## Recording video

F9 or `--record` writes an AVI with one video frame per game frame, so it is exactly 25fps and
perfectly smooth - unlike a desktop screen recorder at 30/60fps. The recording follows the game's
frames, not real time, so it works the same with `--fast`, while fast forwarding, or when stepping
frames with F6 (paused time isn't recorded).

- Video is uncompressed 24-bit RGB: pixel exact, and plays in VLC, Windows Media Player and video
  editors. It's about 6MB per second at scale 1, and 24MB per second at scale 2.
- Audio is the beeper at 48kHz, in sync with the picture. It's recorded even when muted with F3.
- Files are split at about 1GB (`name.avi`, `name_part2.avi`, ...), as many AVI readers can't
  handle larger files.

For example, to record the intro at 2x for 40 seconds, without waiting for it to play:

```bat
ZXeleratorPC.exe --fast --mute --record intro.avi --record-scale 2 --shot 1000 last.bmp
```
| `--mute` | Start muted |
| `--fast` | Run without the 25fps frame limit |

Example automated check:

```bat
ZXeleratorPC.exe --fast --mute --shot 60 title.bmp --shot 500 story.bmp
```

## How it maps onto the hardware

- **Pico SDK headers:** `pc/include/` contains stub versions of the Pico SDK headers the game code
  includes. `pc/pc_compat.h` is force-included into every file to cover GCC-only syntax such as
  `__attribute__`.
- **Frame timing:** on the RP2350, the game core sleeps in `__wfe()` until core 0 signals a new
  Z80 frame. On the PC, `__wfe()` is where the emulator swaps banks (when `flipBank` is set), draws
  the screen, plays the frame's audio, reads the keyboard and waits for the next 25fps tick.
- **`char` signedness:** `char` is compiled as unsigned (`/J`), matching ARM, so code behaves the
  same on both targets.
- **Audio:** comes from the OUT lists written by `setAudioBit()` (see `engine/audio.h`). If the ASM
  template changes, update the list offsets in `engine/audio.h`, which both targets use.

What the emulator does **not** check: RP2350 performance (frame budget, flash XIP cache misses), and
the Z80 side of the template (T-state timing, beam chasing/racing). The ASM is decoded, not executed.
