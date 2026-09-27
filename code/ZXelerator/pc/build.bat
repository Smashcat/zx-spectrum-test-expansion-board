@echo off
rem Builds the ZXelerator PC emulator using Visual Studio's C compiler and bundled CMake.
rem Usage: build.bat [run]

setlocal
set PC_DIR=%~dp0
set VSWHERE="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"

where cmake >nul 2>nul
if %errorlevel%==0 (
    set CMAKE=cmake
) else (
    for /f "usebackq tokens=*" %%i in (`%VSWHERE% -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set VS_PATH=%%i
)
if not defined CMAKE set CMAKE="%VS_PATH%\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"

if not exist "%PC_DIR%build\CMakeCache.txt" (
    %CMAKE% -S "%PC_DIR%." -B "%PC_DIR%build" -A x64 || exit /b 1
)
%CMAKE% --build "%PC_DIR%build" --config Release || exit /b 1

if /i "%1"=="run" "%PC_DIR%build\Release\ZXeleratorPC.exe"
