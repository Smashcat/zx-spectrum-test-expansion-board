@echo off
cd /d %~dp0

rem assemble Z80 code into a ROM
sjasmplus sp48.asm

rem drop the rom into the klive emulator roms directory
del "C:\Users\scott\AppData\Local\Programs\klive-ide\resources\roms\sp48.rom"
copy sp48.rom C:\Users\scott\AppData\Local\Programs\klive-ide\resources\roms

rem Launch Klive to test!
"C:\Users\scott\AppData\Local\Programs\klive-ide\Klive IDE.exe"

