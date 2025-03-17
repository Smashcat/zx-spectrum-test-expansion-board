    DEVICE ZXSPECTRUM48

	define colorBlack		0
	define colorBlue		1
	define colorRed			2
	define colorMagenta		3
	define colorGreen		4
	define colorCyan		5
	define colorYellow		6
	define colorWhite		7

	define attrLen			0x0300	; length of the attribute memory

    define spBackupAddr 	0xE002	; required as we abuse the stack constantly :)
    define stackTopAddr 	0xE0FE	; 242 bytes of stack space available before hitting contested memory

    define attrStartAddr 	0x5800	; Attribute memory start
    define screenStartAddr 	0x4000	; screen bitmap memory start


    org 0x0000
	
rom_start:

    jp cold_start

    ; Place the IM1 vector (exactly at 0x0038)
    ;defs 0x0038 - $, 0x00   ; pad from 0x0003 to 0x0037
    org 0x00038
	reti

cold_start:

    di
    ld sp, stackTopAddr
    im 1

    ; border black
    xor a
    out (0xFE), a

	; screen black
    LD HL, attrStartAddr	; Start of attribute area
    LD DE, attrStartAddr+1
    LD BC, attrLen-1
    LD (HL), 0x00
    ldir

    ei

main_loop:

	; Tell ROM we are waiting for frame refresh - it can then swap in the buffer holding the command list to render the first half of the screen
	ld a,(0x3ffe);

	; sync with display update
    halt

	; chase the raster beam!
    ld a,colorGreen
    out (0xFE), a

	call pop_push_even

	; all done, border red so we can see how many cycles we have left spare
	ld a,colorRed
	out (0xFE), a

	ei

    jp main_loop


; We draw behind the raster beam from the highest 20 byte rows to the lowest (not trivial).
; Audio is played until raster has drawn its first line of pixels so we don't change anything ahead.
; This allows perfectly stable 25fps, even with full screen scrolling, or any other full screen updates!

	include "blitCode.asm"
	