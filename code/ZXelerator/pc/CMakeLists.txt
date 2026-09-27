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

# --- Emulator ----------------------------------------------------------------
# All of the game and engine code, except the RP2350-only parts (ZXelerator.c main and
# engine/funcs.c which drive the PIO/Z80 interface) - pc_main.c replaces those
add_executable(
    ZXeleratorPC
    pc_main.c
    pc_audio.c
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
)
target_include_directories(ZXeleratorTests PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include ${ZX_ROOT} ${ZX_ROOT}/engine)
if(MSVC)
    target_compile_options(ZXeleratorTests PRIVATE /FI${CMAKE_CURRENT_LIST_DIR}/pc_compat.h /J /W3 /utf-8 /wd4244 /wd4305 /wd4267)
else()
    target_compile_options(ZXeleratorTests PRIVATE -include ${CMAKE_CURRENT_LIST_DIR}/pc_compat.h -funsigned-char -Wall -Wextra)
    target_link_libraries(ZXeleratorTests PRIVATE m)
endif()
