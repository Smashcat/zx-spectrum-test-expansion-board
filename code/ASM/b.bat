@echo off
cd /d %~dp0

rem assemble Z80 code into a ROM
sjasmplus sp48.asm

rem also convert it to a C hex array, for use with the ZXcelerator firmware
php conv.php 

rem drop the rom into the klive emulator roms directory
del "C:\Users\ScottPorter\AppData\Local\Programs\klive-ide\resources\roms\sp48.rom"
cp sp48.rom C:\Users\ScottPorter\AppData\Local\Programs\klive-ide\resources\roms

rem Launch Klive to test!
"C:\Users\ScottPorter\AppData\Local\Programs\klive-ide\Klive IDE.exe"

