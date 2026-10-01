# ZXelerator PC emulator build
#
# Builds the game/engine code for the PC with an SDL2 window in place of the Z80/Spectrum.
# SDL2 is downloaded automatically unless SDL2_DIR is set to an existing install.
#
#   cmake -S pc -B pc/build
#   cmake --build pc/build --config Release
#
# (or just run pc/build.bat on Windows)

cmake_minimum_required(VERSION 3.16)

project(ZXeleratorPC C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(ZX_ROOT ${CMAKE_CURRENT_LIST_DIR}/..)

# --- SDL2 ------------------------------------------------------------------
set(SDL2_VERSION 2.32.10)
if(NOT SDL2_DIR)
    include(FetchContent)
    if(MSVC)
        FetchContent_Declare(
            SDL2Prebuilt
            URL https://github.com/libsdl-org/SDL/releases/download/release-${SDL2_VERSION}/SDL2-devel-${SDL2_VERSION}-VC.zip
            DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        )
    else()
        FetchContent_Declare(
            SDL2Prebuilt
            URL https://github.com/libsdl-org/SDL/releases/download/release-${SDL2_VERSION}/SDL2-devel-${SDL2_VERSION}-mingw.zip
            DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        )
    endif()
    FetchContent_MakeAvailable(SDL2Prebuilt)
    set(SDL2_DIR ${sdl2prebuilt_SOURCE_DIR}/cmake)
endif()
find_package(SDL2 REQUIRED CONFIG)

# Levels converted from Tiled (levels/*.c - see levels/README.md)
file(GLOB LEVEL_SOURCES CONFIGURE_DEPENDS ${ZX_ROOT}/levels/*.c)

# --- Emulator ----------------------------------------------------------------
# All of the game and engine code, except the RP2350-only parts (ZXelerator.c main and
# engine/funcs.c which drive the PIO/Z80 interface) - pc_main.c replaces those
add_executable(
    ZXeleratorPC
    pc_main.c
    pc_audio.c
    pc_video.c
    ${ZX_ROOT}/engine/resetData.c
    ${ZX_ROOT}/engine/shared.c
    ${ZX_ROOT}/engine/spriteDefs.c
    ${ZX_ROOT}/engine/displayMemoryOffsets.c
    ${ZX_ROOT}/engine/Sprite.c
    ${ZX_ROOT}/engine/tileDefs.c
    ${ZX_ROOT}/engine/bitmapData.c
    ${ZX_ROOT}/engine/TileLayer.c
    ${ZX_ROOT}/engine/Compositor.c
    ${ZX_ROOT}/engine/palette.c
    ${ZX_ROOT}/engine/inputDevice.c
    ${ZX_ROOT}/engine/particles.c
    ${ZX_ROOT}/engine/audio.c
    ${ZX_ROOT}/engine/synth.c
    ${ZX_ROOT}/engine/collision.c
    ${ZX_ROOT}/engine/level.c
    ${ZX_ROOT}/engine/lzUnpack.c
    ${LEVEL_SOURCES}
    ${ZX_ROOT}/gameFunc.c
    ${ZX_ROOT}/gameStrings.c
    ${ZX_ROOT}/game.c
)

# Stub Pico SDK headers come first so they are used in place of the real SDK
target_include_directories(
    ZXeleratorPC PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/include
    ${ZX_ROOT}
    ${ZX_ROOT}/engine
    ${ZX_ROOT}/levels
)

if(MSVC)
    # /FI force-includes the compatibility header, /J makes char unsigned as on ARM
    target_compile_options(ZXeleratorPC PRIVATE /FI${CMAKE_CURRENT_LIST_DIR}/pc_compat.h /J /W3 /utf-8 /wd4244 /wd4305 /wd4267)
else()
    target_compile_options(ZXeleratorPC PRIVATE -include ${CMAKE_CURRENT_LIST_DIR}/pc_compat.h -funsigned-char -Wall -Wextra)
    target_link_libraries(ZXeleratorPC PRIVATE m)
endif()

if(TARGET SDL2::SDL2main)
    target_link_libraries(ZXeleratorPC PRIVATE SDL2::SDL2main)
endif()
target_link_libraries(ZXeleratorPC PRIVATE SDL2::SDL2)

# Put SDL2.dll next to the executable
if(WIN32)
    add_custom_command(
        TARGET ZXeleratorPC POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:SDL2::SDL2> $<TARGET_FILE_DIR:ZXeleratorPC>
    )
endif()

# --- Engine tests (no SDL) ---------------------------------------------------
# Checks the rotation/scaling renderers against the fast renderers, and renders example scenes to BMPs:
#   pc/build/Release/ZXeleratorTests.exe [output folder]
add_executable(
    ZXeleratorTests
    tests/transform_tests.c
    ${ZX_ROOT}/engine/resetData.c
    ${ZX_ROOT}/engine/shared.c
    ${ZX_ROOT}/engine/spriteDefs.c
    ${ZX_ROOT}/engine/displayMemoryOffsets.c
    ${ZX_ROOT}/engine/Sprite.c
    ${ZX_ROOT}/engine/tileDefs.c
    ${ZX_ROOT}/engine/bitmapData.c
    ${ZX_ROOT}/engine/TileLayer.c
    ${ZX_ROOT}/engine/Compositor.c
    ${ZX_ROOT}/engine/palette.c
    ${ZX_ROOT}/engine/particles.c
    ${ZX_ROOT}/engine/collision.c
    ${ZX_ROOT}/engine/level.c
    ${ZX_ROOT}/engine/lzUnpack.c
    ${LEVEL_SOURCES}
    tools/lzPack.c
)
target_include_directories(ZXeleratorTests PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include ${ZX_ROOT} ${ZX_ROOT}/engine ${ZX_ROOT}/levels ${CMAKE_CURRENT_LIST_DIR}/tools)
# The tests are built with AddressSanitizer, so any read or write outside a buffer (which the pixel
# comparisons can't see) fails the run
if(MSVC)
    target_compile_options(ZXeleratorTests PRIVATE /FI${CMAKE_CURRENT_LIST_DIR}/pc_compat.h /J /W3 /utf-8 /wd4244 /wd4305 /wd4267 /fsanitize=address /Zi)
    target_link_options(ZXeleratorTests PRIVATE /INCREMENTAL:NO /DEBUG)
    # The sanitizer runtime DLL lives next to the compiler - copy it next to the test executable
    get_filename_component(MSVC_BIN_DIR ${CMAKE_C_COMPILER} DIRECTORY)
    add_custom_command(
        TARGET ZXeleratorTests POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${MSVC_BIN_DIR}/clang_rt.asan_dynamic-x86_64.dll $<TARGET_FILE_DIR:ZXeleratorTests>
    )
else()
    target_compile_options(ZXeleratorTests PRIVATE -include ${CMAKE_CURRENT_LIST_DIR}/pc_compat.h -funsigned-char -Wall -Wextra -fsanitize=address)
    target_link_options(ZXeleratorTests PRIVATE -fsanitize=address)
    target_link_libraries(ZXeleratorTests PRIVATE m)
endif()

# --- Level converter -----------------------------------------------------------
# Converts Tiled maps into levels (levels/*.c), and makes Tiled tile sets from the engine's tile graphics - see
# levels/README.md:
#   pc/build/Release/levelconv.exe level levels/tiled/demo.tmx levels
include(FetchContent)
FetchContent_Declare(
    cJSON
    URL https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.18.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    SOURCE_SUBDIR sources-only
)
FetchContent_Declare(
    miniz
    URL https://github.com/richgel999/miniz/releases/download/3.0.2/miniz-3.0.2.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    SOURCE_SUBDIR sources-only
)
# Just the sources are used (SOURCE_SUBDIR points at a folder that doesn't exist, so their own CMake projects aren't added)
FetchContent_MakeAvailable(cJSON miniz)

# The engine's tile sets by name (every 4096 byte array in engine/tileDefs.h), so the converter can draw them for Tiled
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${ZX_ROOT}/engine/tileDefs.h)
file(STRINGS ${ZX_ROOT}/engine/tileDefs.h TILESET_LINES REGEX "extern const uint8_t [A-Za-z0-9_]+\\[(4096|16384)\\];")
set(TILESET_REGISTRY "// Generated by pc/CMakeLists.txt from engine/tileDefs.h\n#include <stddef.h>\n#include \"tileDefs.h\"\n#include \"tileSetRegistry.h\"\n\nconst TileSetEntry tileSetRegistry[]={\n")
foreach(line ${TILESET_LINES})
    string(REGEX REPLACE ".*extern const uint8_t ([A-Za-z0-9_]+)\\[([0-9]+)\\];.*" "\\1" tileSetName "${line}")
    string(REGEX REPLACE ".*extern const uint8_t ([A-Za-z0-9_]+)\\[([0-9]+)\\];.*" "\\2" tileSetSize "${line}")
    string(APPEND TILESET_REGISTRY "    {\"${tileSetName}\",${tileSetName},${tileSetSize}},\n")
endforeach()
string(APPEND TILESET_REGISTRY "    {NULL,NULL,0}\n};\n")
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/tileSetRegistry.c CONTENT "${TILESET_REGISTRY}")

# ...and its sprite graphics (every array in engine/spriteDefs.h - spriteDefs.c is included, so their sizes are known)
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${ZX_ROOT}/engine/spriteDefs.h)
file(STRINGS ${ZX_ROOT}/engine/spriteDefs.h SPRITEDEF_LINES REGEX "extern const uint8_t [A-Za-z0-9_]+\\[\\];")
set(SPRITEDEF_REGISTRY "// Generated by pc/CMakeLists.txt from engine/spriteDefs.h\n#include <stddef.h>\n#include \"spriteDefs.c\"\n#include \"tileSetRegistry.h\"\n\nconst SpriteDefEntry spriteDefRegistry[]={\n")
foreach(line ${SPRITEDEF_LINES})
    string(REGEX REPLACE ".*extern const uint8_t ([A-Za-z0-9_]+)\\[\\];.*" "\\1" spriteDefName "${line}")
    string(APPEND SPRITEDEF_REGISTRY "    {\"${spriteDefName}\",${spriteDefName},(int)sizeof(${spriteDefName})},\n")
endforeach()
string(APPEND SPRITEDEF_REGISTRY "    {NULL,NULL,0}\n};\n")
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/spriteDefRegistry.c CONTENT "${SPRITEDEF_REGISTRY}")

add_executable(
    levelconv
    tools/levelconv.c
    tools/lzPack.c
    ${CMAKE_CURRENT_BINARY_DIR}/tileSetRegistry.c
    ${CMAKE_CURRENT_BINARY_DIR}/spriteDefRegistry.c
    ${ZX_ROOT}/engine/palette.c
    ${ZX_ROOT}/engine/lzUnpack.c
    ${ZX_ROOT}/engine/tileDefs.c
    ${cjson_SOURCE_DIR}/cJSON.c
    ${miniz_SOURCE_DIR}/miniz.c
)
target_include_directories(levelconv PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include ${CMAKE_CURRENT_LIST_DIR}/tools ${ZX_ROOT}/engine
    ${cjson_SOURCE_DIR} ${miniz_SOURCE_DIR})
if(MSVC)
    target_compile_options(levelconv PRIVATE /FI${CMAKE_CURRENT_LIST_DIR}/pc_compat.h /J /W3 /utf-8 /wd4244 /wd4305 /wd4267 /wd4996)
else()
    target_compile_options(levelconv PRIVATE -include ${CMAKE_CURRENT_LIST_DIR}/pc_compat.h -funsigned-char)
endif()
