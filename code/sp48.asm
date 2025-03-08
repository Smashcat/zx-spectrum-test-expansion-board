    DEVICE ZXSPECTRUM48

	define colorBlack		0
	define colorBlue		1
	define colorRed			2
	define colorMagenta		3
	define colorGreen		4
	define colorCyan		5
	define colorYellow		6
	define colorWhite		7

	define audioListLen		1200	; number of speaker transitions in the audio data
	define attrLen			0x0300	; lenngth of the attribute memory

    define spBackupAddr 	0x8002	; required as we abuse the stack constantly :)
    define tunePositionAddr 0x8004	; will not be used in the actual cart, as tone command lists will be updated each frame
	define keyScanData		0x8006	; 8 bytes use to hold half-row keyboard scan data
    define stackTopAddr 	0x80FE	; 242 bytes of stack space available before hitting contested memory
	define audioListAddr	0x8100	; first audio list, this will be in cart address space eventually
	define audioList2Addr	0x8100+(audioListLen*2)+11	; second audio list, will also be in cart address space

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
	ld c,0xe9				; frequency
	call initAudioList

	ld hl,audioList2Addr
	ld c,0xa3
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
	ld (hl),0x10
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

	; sync with display update
    halt

	; Play the audio data for frame (border is black during this)
	;call audioListAddr

	; chase the raster beam!
    ld a,colorBlue
    out (0xFE), a
	call pop_push_even

	; approx 68 visible pixel rows plus bottom border free at this point, before second audio "channel" begins

	; Play second audio tone data for frame (border is black during this)
    ;call audioList2Addr

	ld a,colorWhite
	out (0xFE), a
	call scanKeyboard

	; all done, border green so we can see how many cycles we have left spare
	ld a,colorRed
	out (0xFE), a
	ei

    jp main_loop



scanKeyboard:

	ret

; We draw behind the raster beam form the highest 20 byte rows to the lowest (not trivial).
; Audio is played until raster has drawn its first line of pixels so we don't change anything ahead.
; This allows perfectly stable 25fps, even with full screen scrolling, or any other full screen updates!
pop_push_even:

    ld (spBackupAddr),sp

	; 0
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+16
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 1
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+32
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 2
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+48
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 3
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+64
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 4
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+80
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 5
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+96
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 6
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+112
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 7
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+128
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 8
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+144
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 9
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+160
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 10
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+176
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 11
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+192
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 12
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+208
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 13
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+224
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 14
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+240
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 15
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+256
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 16
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+272
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 17
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+288
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 18
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+304
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 19
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+320
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 20
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+336
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 21
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+352
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 22
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+368
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 23
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+384
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 24
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+400
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 25
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+416
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 26
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+432
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 27
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+448
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 28
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+464
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 29
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+480
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 30
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+496
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 31
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+512
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 32
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+528
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 33
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+544
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 34
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+560
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 35
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+576
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 36
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+592
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 37
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+608
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 38
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+624
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 39
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+640
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 40
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+656
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 41
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+672
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 42
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+688
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 43
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+704
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 44
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+720
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 45
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+736
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 46
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+752
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 47
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+768
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; delay to get start of second scanline
	ld b,95
ppe_scan_delay:
	nop 
	nop
	nop
	nop 
	nop 
	nop 
	nop
	nop
	djnz ppe_scan_delay
	nop
	nop
	nop
	nop




	; scanline is just entering the first pixel row here



	; 0 - 242 clocks for 20 bytes moved - 348 repititions for all screen/attr RAM = 84216 T-cycles (plus some more for contention)
	;     184 If we don't use IX/IY - 435 repetitions for all screen/attr RAM = 80040 T-cycles (plus some more for contention)
	;	  This renders over 2 frames, completing screen bitmap+attribute memory blits approx 82 rows of pixels ahead of ULA on the second screen.
	;	  There are 130 rows remaining if no attributes rendered. That gives 130*224 T-cycles in the pixel area
	; 0
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+16
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+32
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+272
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; attr draw 0
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30),hl
	; end attr draw 0

	; 3
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+288
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 4
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+528
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 5
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+544
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 6
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+784
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 7
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+800
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 8-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1040
	push hl
	push de
	push bc
	push af

	; attr draw 1
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+32
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+32),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+32),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+32
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+32
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+32),hl
	; end attr draw 1

	; 8-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1032
	push hl
	push de
	push bc
	push af

	; 9
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1056
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 10
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1296
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 11
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1312
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 12
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1552
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 13
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1568
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 14-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+1808
	push de
	push bc
	push af

	; attr draw 2
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+64
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+64),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+64),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+64
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+64
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+64),hl
	; end attr draw 2

	; 14-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+1802
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 15
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1824
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 16
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+48
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 17
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+64
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 18
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+304
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 19
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+320
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop
	
	; attr draw 3
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+96
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+96),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+96),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+96
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+96
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+96),hl
	; end attr draw 3



	; 20
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+560
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 21
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+576
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 22
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+816
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 23
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+832
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 24
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1072
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 25-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1088
	push hl
	push de
	push bc
	push af

	; attr draw 4
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+128
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+128),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+128),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+128
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+128
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+128),hl
	; end attr draw 4


	; 25-2 (8 bytes)
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1080
	push hl
	push de
	push bc
	push af

	; 26
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1328
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 27
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1344
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 28
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1584
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 29
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1600
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 30
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1840
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 31-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+1856
	push de
	push bc
	push af

	; attr draw 5
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+160
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+160),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+160),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+160
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+160
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+160),hl
	; end attr draw 5

	; 31-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop bc
	ld sp,screenStartAddr+1850
	push bc
	exx
	push hl
	push de
	push bc
	push af

	; 32
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+80
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 33
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+96
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 34
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+336
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 35
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+352
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 36
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+592
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop

	; attr draw 6
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+192
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+192),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+192),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+192
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+192
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+192),hl
	; end attr draw 6


	; 37
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+608
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 38
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+848
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 39
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+864
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 40
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1104
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 41
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1120
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 42-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1360
	push hl
	push de
	push bc
	push af


	; attr draw 7
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+224
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+224),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+224),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+224
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+224
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+224),hl
	; end attr draw 7

	; 42-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1352
	push hl
	push de
	push bc
	push af

	; 43
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1376
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 44
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1616
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 45
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1632
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 46
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1872
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 47
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1888
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 48-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+112
	push de
	push bc
	push af


	; attr draw 8
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+256
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+256),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+256),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+256
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+256
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+256),hl
	; end attr draw 8


	; 48-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+106
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 49
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+128
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 50
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+368
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 51
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+384
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 52
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+624
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 53
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+640
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop


	; attr draw 9
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+288
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+288),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+288),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+288
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+288
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+288),hl
	; end attr draw 9

	; 54
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+880
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 55
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+896
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 56
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1136
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 57
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1152
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 58
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1392
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 59-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1408
	push hl
	push de
	push bc
	push af


	; attr draw 10
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+320
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+320),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+320),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+320
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+320
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+320),hl
	; end attr draw 10

	; 59-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1400
	push hl
	push de
	push bc
	push af

	; 60
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1648
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 61
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1664
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 62
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1904
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 63
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1920
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 64
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+144
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 65-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+160
	push de
	push bc
	push af

	; attr draw 11
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+352
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+352),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+352),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+352
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+352
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+352),hl
	; end attr draw 11

	; 65-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+154
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 66
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+400
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 67
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+416
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 68
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+656
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 69
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+672
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 70
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+912
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop


	; attr draw 12
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+384
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+384),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+384),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+384
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+384
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+384),hl
	; end attr draw 12


	; 71
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+928
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 72
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1168
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 73
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1184
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 74
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1424
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 75
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1440
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 76-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1680
	push hl
	push de
	push bc
	push af


	; attr draw 13
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+416
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+416),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+416),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+416
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+416
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+416),hl
	; end attr draw 13

	; 76-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1672
	push hl
	push de
	push bc
	push af

	; 77
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1696
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 78
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1936
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 79
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1952
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 80
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+176
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 81
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+192
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 82-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+432
	push de
	push bc
	push af

	; attr draw 14
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+448
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+448),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+448),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+448
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+448
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+448),hl
	; end attr draw 14

	; 82-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+426
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 83
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+448
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 84
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+688
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 85
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+704
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 86
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+944
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 87
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+960
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop

	; attr draw 15
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+480
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+480),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+480),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+480
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+480
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+480),hl
	; end attr draw 15


	; 88
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1200
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 89
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1216
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 90
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1456
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 91
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1472
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 92
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1712
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 93-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1728
	push hl
	push de
	push bc
	push af

	; attr draw 16
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+512
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+512),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+512),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+512
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+512
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+512),hl
	; end attr draw 16

	; 93-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1720
	push hl
	push de
	push bc
	push af

	; 94
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1968
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 95
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1984
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 96
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+208
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 97
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+224
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 98
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+464
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 99-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+480
	push de
	push bc
	push af


	; attr draw 17
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+544
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+544),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+544),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+544
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+544
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+544),hl
	; end attr draw 17

	; 99-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+474
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 100
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+720
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 101
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+736
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 102
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+976
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 103
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+992
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 104
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1232
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop

	; attr draw 18
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+576
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+576),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+576),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+576
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+576
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+576),hl
	; end attr draw 18


	; 105
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1248
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 106
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1488
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 107
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1504
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 108
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1744
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 109
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1760
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 110-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2000
	push hl
	push de
	push bc
	push af

	; attr draw 19
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+608
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+608),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+608),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+608
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+608
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+608),hl
	; end attr draw 19

	; 110-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1992
	push hl
	push de
	push bc
	push af

	; 111
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2016
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 112
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+240
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 113
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+256
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 114
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+496
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 115
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+512
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 116-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+752
	push de
	push bc
	push af

	; attr draw 20
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+640
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+640),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+640),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+640
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+640
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+640),hl
	; end attr draw 20

	; 116-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+746
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 117
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+768
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 118
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1008
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 119
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1024
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 120
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1264
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 121
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1280
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	nop
	nop

	; attr draw 21
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+672
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+672),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+672),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+672
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+672
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+672),hl
	; end attr draw 21

	; 122
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1520
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 123
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1536
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 124
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1776
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 125
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+1792
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 126
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2032
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 127-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2048
	push hl
	push de
	push bc
	push af

	; attr draw 22
	ld sp,0x8020
	ld bc,0b0000101000001010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+704
	ld de,0b0000101000001010
	ld hl,0b0000101000001010
	ld ix,0b0000101000001010
	ld iy,0b0000101000001010
	exx
	ld bc,0b0000101000001010
	ld de,0b0000101000001010
	ld hl,0b0000101000001010
	
	; start chasing raster here
	ld (attrStartAddr+704),hl
	ld hl,0b0000101000001010
	ld (attrStartAddr+2+704),hl
	ld hl,0b0000101000001010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+704
	push hl
	push de
	push bc
	push af

	ld bc,0b0000101000001010
	ld de,0b0000101000001010
	ld hl,0b0000101000001010
	ld sp,attrStartAddr+30+704
	push hl
	push de
	push bc
	ld hl,0b0000101000001010
	ld (attrStartAddr+30+704),hl
	; end attr draw 22

	; 127-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2040
	push hl
	push de
	push bc
	push af

	; 128
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2064
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 129
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2080
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 130
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2320
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 131
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2336
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 132
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2576
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 133-1
	ld sp,src_data
	pop af
	pop bc
	pop de
	ld sp,screenStartAddr+2592
	push de
	push bc
	push af

	; attr draw 23
	ld sp,0x8020
	ld bc,0b0010101000101010
	push bc	; doesn't matter that we're writing to the stack here, as it'll be overwritten
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+736
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld ix,0b0010101000101010
	ld iy,0b0010101000101010
	exx
	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	
	; start chasing raster here
	ld (attrStartAddr+736),hl
	ld hl,0b0010101000101010
	ld (attrStartAddr+2+736),hl
	ld hl,0b0010101000101010
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+736
	push hl
	push de
	push bc
	push af

	ld bc,0b0010101000101010
	ld de,0b0010101000101010
	ld hl,0b0010101000101010
	ld sp,attrStartAddr+30+736
	push hl
	push de
	push bc
	ld hl,0b0010101000101010
	ld (attrStartAddr+30+736),hl
	; end attr draw 23

	; 133-2
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	pop hl
	ld sp,screenStartAddr+2586
	push hl
	exx
	push hl
	push de
	push bc
	push af

	; 134
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2832
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 135
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2848
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 136
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3088
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 137
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3104
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 138
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3344
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 139
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3360
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 140
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3600
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 141
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3616
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 142
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3856
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 143
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3872
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 144
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2096
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 145
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2112
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 146
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2352
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 147
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2368
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 148
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2608
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 149
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2624
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 150
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2864
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 151
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2880
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 152
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3120
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 153
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3136
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 154
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3376
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 155
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3392
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 156
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3632
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 157
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3648
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 158
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3888
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 159
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3904
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 160
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2128
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 161
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2144
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 162
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2384
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 163
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2400
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 164
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2640
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 165
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2656
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 166
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2896
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 167
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2912
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 168
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3152
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 169
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3168
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 170
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3408
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 171
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3424
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 172
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3664
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 173
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3680
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 174
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3920
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 175
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3936
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 176
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2160
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 177
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2176
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 178
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2416
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 179
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2432
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 180
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2672
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 181
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2688
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 182
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2928
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 183
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2944
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 184
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3184
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 185
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3200
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 186
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3440
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 187
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3456
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

    ld sp,(spBackupAddr)
    ret

	; 188
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3696
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 189
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3712
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 190
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3952
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 191
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3968
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 192
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2192
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 193
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2208
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 194
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2448
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 195
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2464
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 196
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2704
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 197
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2720
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 198
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2960
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 199
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2976
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af


;======================================================================================================= second half + attributes ============================================================================================



	; 0
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+16
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 1
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+32
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 2
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+48
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 3
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+64
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 4
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+80
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 5
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+96
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 6
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+112
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 7
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+128
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 8
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+144
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 9
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+160
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 10
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+176
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 11
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+192
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 12
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+208
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 13
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+224
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 14
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+240
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 15
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+256
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 16
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+272
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 17
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+288
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 18
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+304
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 19
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+320
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 20
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+336
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 21
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+352
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 22
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+368
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 23
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+384
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 24
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+400
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 25
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+416
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 26
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+432
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 27
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+448
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 28
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+464
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 29
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+480
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 30
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+496
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 31
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+512
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 32
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+528
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 33
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+544
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 34
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+560
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 35
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+576
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 36
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+592
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 37
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+608
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 38
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+624
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 39
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+640
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 40
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+656
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 41
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+672
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 42
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+688
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 43
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+704
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 44
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+720
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 45
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+736
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 46
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+752
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 47
	ld sp,src_attr_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,attrStartAddr+768
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 200
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3216
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 201
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3232
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 202
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3472
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 203
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3488
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 204
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3728
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 205
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3744
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 206
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3984
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 207
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4000
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 208
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2224
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 209
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2240
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 210
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2480
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 211
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2496
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 212
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2736
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 213
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2752
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 214
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2992
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 215
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3008
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 216
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3248
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 217
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3264
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 218
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3504
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 219
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3520
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 220
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3760
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 221
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3776
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 222
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4016
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 223
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4032
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 224
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2256
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 225
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2272
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 226
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2512
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 227
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2528
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 228
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2768
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 229
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2784
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 230
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3024
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 231
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3040
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 232
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3280
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 233
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3296
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 234
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3536
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 235
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3552
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 236
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3792
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 237
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3808
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 238
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4048
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 239
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4064
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 240
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2288
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 241
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2304
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 242
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2544
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 243
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2560
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 244
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2800
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 245
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+2816
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 246
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3056
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 247
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3072
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 248
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3312
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 249
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3328
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 250
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3568
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 251
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3584
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 252
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3824
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 253
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+3840
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 254
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4080
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 255
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4096
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 256
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4112
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 257
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4128
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 258
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4368
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 259
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4384
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 260
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4624
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 261
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4640
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 262
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4880
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 263
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4896
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 264
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5136
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 265
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5152
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 266
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5392
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 267
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5408
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 268
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5648
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 269
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5664
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 270
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5904
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 271
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5920
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 272
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4144
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 273
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4160
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 274
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4400
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 275
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4416
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 276
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4656
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 277
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4672
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 278
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4912
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 279
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4928
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 280
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5168
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 281
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5184
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 282
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5424
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 283
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5440
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 284
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5680
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 285
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5696
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 286
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5936
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 287
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5952
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 288
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4176
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 289
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4192
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 290
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4432
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 291
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4448
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 292
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4688
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 293
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4704
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 294
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4944
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 295
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4960
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 296
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5200
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 297
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5216
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 298
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5456
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 299
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5472
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 300
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5712
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 301
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5728
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 302
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5968
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 303
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5984
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 304
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4208
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 305
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4224
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 306
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4464
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 307
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4480
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 308
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4720
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 309
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4736
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 310
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4976
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 311
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4992
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 312
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5232
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 313
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5248
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 314
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5488
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 315
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5504
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 316
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5744
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 317
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5760
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 318
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6000
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 319
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6016
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 320
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4240
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 321
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4256
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 322
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4496
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 323
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4512
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 324
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4752
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 325
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4768
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 326
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5008
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 327
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5024
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 328
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5264
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 329
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5280
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 330
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5520
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 331
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5536
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 332
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5776
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 333
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5792
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 334
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6032
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 335
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6048
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 336
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4272
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 337
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4288
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 338
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4528
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 339
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4544
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 340
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4784
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 341
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4800
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 342
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5040
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 343
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5056
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 344
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5296
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 345
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5312
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 346
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5552
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 347
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5568
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 348
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5808
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 349
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5824
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 350
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6064
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 351
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6080
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 352
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4304
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 353
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4320
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 354
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4560
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 355
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4576
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 356
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4816
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 357
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4832
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 358
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5072
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 359
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5088
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 360
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5328
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 361
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5344
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 362
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5584
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 363
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5600
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 364
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5840
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 365
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5856
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 366
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6096
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 367
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6112
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 368
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4336
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 369
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4352
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 370
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4592
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 371
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4608
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 372
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4848
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 373
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+4864
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 374
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5104
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 375
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5120
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 376
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5360
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 377
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5376
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 378
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5616
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 379
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5632
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 380
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5872
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 381
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+5888
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 382
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6128
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af

	; 383
	ld sp,src_data
	pop af
	pop bc
	pop de
	pop hl
	exx
	ex af,af'
	pop af
	pop bc
	pop de
	pop hl
	ld sp,screenStartAddr+6144
	push hl
	push de
	push bc
	push af
	ex af,af'
	exx
	push hl
	push de
	push bc
	push af








    ld sp,(spBackupAddr)
    ret


src_data:
    db  0b11111111,0b00001111,0b00110011,0b01010101,0b11111111,0b00001111,0b00110011,0b01010101,0b11111111,0b00001111,0b00110011,0b01010101,0b11111111,0b00001111,0b00110011,0b01010101,0b11111111,0b00001111,0b00110011,0b01010101

src_attr_data:
    db  0b00110001,0b00110001,0b00110001,0b00110001,0b00110001,0b00110001,0b00110001,0b00110001
	db	0b00110001,0b00110001,0b00110001,0b00110001,0b00110001,0b00110001,0b00110001,0b00110001
	db	0b00110001,0b00110001,0b00110001,0b00110001

src_attr_data2:
    db  0b00000111,0b00000111,0b00000111,0b00000111,0b00000111,0b00000111,0b00000111,0b00000111,0b00000111,0b00000111
    db  0b00111000,0b00111000,0b00111000,0b00111000,0b00111000,0b00111000,0b00111000,0b00111000
    db  0b00111000,0b00111000,0b00111000,0b00111000,0b00111000,0b00111000,0b00111000,0b00111000
    db  0b00100011,0b00100011,0b00100011,0b00100011,0b00100011,0b00100011,0b00100011,0b00100011

tune:
    db  0x80/4,0x72/4,0x66/4,0x60/4,0x56/4,0x66/4,0x56/4,0x56/4
    db  0x51/4,0x60/4,0x51/4,0x51/4,0x56/4,0x66/4,0x56/4,0x56/4
    db  0x80/4,0x72/4,0x66/4,0x60/4,0x56/4,0x66/4,0x56/4,0x56/4
    db  0x51/4,0x60/4,0x51/4,0x51/4,0x56/4,0x56/4,0x56/4,0x56/4

    db  0x80,0x72,0x66,0x60,0x56,0x66,0x56,0x56
    db  0x51,0x60,0x51,0x51,0x56,0x66,0x56,0x56
    db  0x80,0x72,0x66,0x60,0x56,0x66,0x56,0x40
    db  0x56,0x66,0x80,0x66,0x56,0x56,0x56,0x56,0


    SAVEBIN "sp48.rom",0,$