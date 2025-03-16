    DEVICE ZXSPECTRUM48

	define colorBlack		0
	define colorBlue		1
	define colorRed			2
	define colorMagenta		3
	define colorGreen		4
	define colorCyan		5
	define colorYellow		6
	define colorWhite		7

	define audioListLen		508	; number of speaker transitions in the audio data
	define attrLen			0x0300	; length of the attribute memory

    define spBackupAddr 	0xE002	; required as we abuse the stack constantly :)
    define tunePositionAddr 0xE004	; will not be used in the actual cart, as tone command lists will be updated each frame
	define keyScanData		0xE006	; 8 bytes use to hold half-row keyboard scan data
    define stackTopAddr 	0xE0FE	; 242 bytes of stack space available before hitting contested memory
	define audioListAddr	0xE100	; first audio list, this will be in cart address space eventually
	define audioListAddr2	audioListAddr+(audioListLen*2)+20	; second audio list, this will be in cart address space eventually

    define attrStartAddr 	0x5800	; Attribute memory start
    define screenStartAddr 	0x4000	; screen bitmap memory start


    org 0x0000
    jp cold_start

    ; Place the IM1 vector (exactly at 0x0038)
    ;defs 0x0038 - $, 0x00   ; pad from 0x0003 to 0x0037
    org 0x00038
	reti

cold_start:
    di
    ld sp, stackTopAddr
    im 1

    ; reset the tune position (updates every frame)
    ld hl,tune
    ld (tunePositionAddr),HL

    ; border black
    xor a
    out (0xFE), a

    LD HL, attrStartAddr	; Start of attribute area
    LD DE, attrStartAddr+1
    LD BC, attrLen-1
    LD (HL), 0x17
    ldir

	ld hl,audioListAddr		; audio command list address
	ld c,0x00				; frequency
	call initAudioList

	ld hl,audioListAddr2		; audio command list address
	ld c,0x00					; frequency
	call initAudioList

    ei
    jp main_loop

; create the instruction skeleton for the tone player on/off list
; IN -> c holds interval between polarity changes - so lower = higher frequency
; IN -> hl holds the address of the audio command list to generate
; A,F,B,C,D,E,H,L all used not restored
initAudioList:

	; ld bc,0xfe
	ld (hl),0x01
	inc hl
	ld (hl),0xfe
	inc hl
	ld (hl),0x00
	inc hl

	; ld de,0x0010
	ld (hl),0x11
	inc hl
	ld a,c 
	cp 0
	jp z,ial_no_audio
	ld (hl),0x10
	jr ial_cont1
ial_no_audio:
	ld (hl),0x00
ial_cont1:
	inc hl
	ld (hl),0x00
	inc hl

	ld de,audioListLen
	ld b,c

	; out(c),d
	ld a,0b01010001	;	enable beeper/earphone bits

ial_audio_list_create_loop:
	ld (hl),0xed	; 		12		out(c),d or out(c),e
	inc hl			; 		
	ld (hl),a		; 		
	inc hl			;

	dec b
	jp nz,ial_no_swap
	ld b,c
	xor 0b00001000	;	flip bit 4 to swap between out(c),d and out(c),e

ial_no_swap:
	dec de			;		6
	bit 7,d			;		8
	jp z,ial_audio_list_create_loop ; 10

	; finally out (c),d because d is zero, to turn off beeper
	ld (hl),0xed	; 		12		out(c),d
	inc hl			; 		
	ld (hl),0b01010001		; 		
	inc hl			;
	ld (hl),0xc9	;		10	ret

	ret

main_loop:

	; Tell ROM we are waiting for frame refresh - it can then get the first bank ready for rendering
	ld a,(0x4ffe);

	; sync with display update
    halt

	; Play the audio data for frame (border is black during this)
	call audioListAddr

	; chase the raster beam!
    ld a,colorGreen
    out (0xFE), a

	call pop_push_even

	; Play the audio data for frame (border is black during this)
	call audioListAddr2

	; all done, border green so we can see how many cycles we have left spare
	ld a,colorRed
	out (0xFE), a

	ei

    jp main_loop



scanKeyboard:

	ret

; We draw behind the raster beam from the highest 20 byte rows to the lowest (not trivial).
; Audio is played until raster has drawn its first line of pixels so we don't change anything ahead.
; This allows perfectly stable 25fps, even with full screen scrolling, or any other full screen updates!

; List of index 8 and 16 dwords for each attr row, for faster loading into AF pair
attr8and16vals:
	dw  0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000
	dw  0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000
	dw  0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000
	dw  0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000
	dw  0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000,0b0010100000101000
	dw  0b0010100000101000,0b0010100000101000
tune:
    db  0x80/4,0x72/4,0x66/4,0x60/4,0x56/4,0x66/4,0x56/4,0x56/4
    db  0x51/4,0x60/4,0x51/4,0x51/4,0x56/4,0x66/4,0x56/4,0x56/4
    db  0x80/4,0x72/4,0x66/4,0x60/4,0x56/4,0x66/4,0x56/4,0x56/4
    db  0x51/4,0x60/4,0x51/4,0x51/4,0x56/4,0x56/4,0x56/4,0x56/4

    db  0x80,0x72,0x66,0x60,0x56,0x66,0x56,0x56
    db  0x51,0x60,0x51,0x51,0x56,0x66,0x56,0x56
    db  0x80,0x72,0x66,0x60,0x56,0x66,0x56,0x40
    db  0x56,0x66,0x80,0x66,0x56,0x56,0x56,0x56,0

	include "blitCode.asm"
	