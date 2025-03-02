    DEVICE ZXSPECTRUM48

    define pushPopAddr 0x8200
    define stackTopAddr 0x8100
    define spBackupAddr 0x8002

    define attrStartAddr 0x5800
    define screenStartAddr 0x4000


    org 0x0000
    jp cold_start

; Place the IM1 vector (exactly at 0x0038)
    ;defs 0x0038 - $, 0x00   ; pad from 0x0003 to 0x0037
    org 0x00038
    jp isr_handler           ; At 0x0038 - works in IM 1

cold_start:
    di
    ld sp, stackTopAddr
    im 1
    ; border black
    ld a,0
    out (0xFE), a

    LD HL, 0x5800            ; Start of attribute area
    LD DE, 0x5801
    LD BC, 0x02FF
    LD (HL), 7
    ldir


    ei
    jp main_loop

; Simple IM 1 interrupt handler
isr_handler:
    ei
    reti

main_loop:
    halt                   ; This should be woken up by the interrupt
    ld a,0
    out (0xFE), a
    ld b,255
wait_beam:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    djnz wait_beam
    ld a,2
    out (0xFE), a
    call pop_push
    ld a,7
    out (0xFE), a
    jp main_loop

pop_push:
    ld (spBackupAddr),sp

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
    pop ix
    pop iy
    ld sp,screenStartAddr+20
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+40
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+60
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+80
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+100
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+120
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+140
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+160
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+180
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+200
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+220
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+240
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+260
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+280
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+300
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+320
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+340
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+360
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+380
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+400
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+420
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+440
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+460
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+480
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+500
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+520
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+540
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+560
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+580
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+600
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+620
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+640
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+660
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+680
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+700
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+720
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+740
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+760
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+780
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+800
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+820
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+840
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+860
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+880
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+900
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+920
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+940
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+960
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+980
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1000
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1020
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1040
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1060
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1080
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1100
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1120
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1140
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1160
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1180
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1200
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1220
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1240
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1260
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1280
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1300
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1320
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1340
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1360
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1380
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1400
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1420
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1440
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1460
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1480
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1500
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1520
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1540
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1560
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1580
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1600
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1620
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1640
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1660
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1680
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1700
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1720
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1740
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1760
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1780
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1800
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1820
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1840
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1860
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1880
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1900
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1920
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1940
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1960
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+1980
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2000
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2020
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2040
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2060
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2080
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2100
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2120
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2140
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2160
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2180
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2200
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2220
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2240
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2260
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2280
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2300
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2320
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2340
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2360
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2380
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2400
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2420
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2440
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2460
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2480
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2500
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2520
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2540
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2560
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2580
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2600
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2620
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2640
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2660
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2680
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2700
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2720
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2740
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2760
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2780
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2800
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2820
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2840
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2860
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2880
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2900
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2920
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2940
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2960
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+2980
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3000
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3020
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3040
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3060
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3080
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3100
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3120
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3140
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3160
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3180
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3200
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3220
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3240
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,screenStartAddr+3260
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl
















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
    pop ix
    pop iy
    ld sp,attrStartAddr+20
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+40
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+60
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+80
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+100
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+120
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+140
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+160
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+180
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+200
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+220
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+240
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+260
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+280
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+300
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+320
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+340
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+360
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+380
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+400
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+420
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+440
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+460
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl

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
    pop ix
    pop iy
    ld sp,attrStartAddr+480
    push af
    push bc
    push de
    push hl
    push ix
    push iy
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl






    ld sp,(spBackupAddr)

    ret


src_data:
    db  0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff,0b10101010,0xff

pop_push_code_pre:
    db  0xed,0x73,0x02,0x80  ; ld ($8002),sp

pop_push_body:
    db  0x31,0x8e,0x00       ; ld sp,$008e
    db  0xf1                 ; pop af
    db  0xc1                 ; pop bc
    db  0xd1                 ; pop de
    db  0xe1                 ; pop hl
    db  0xd9                 ; exx
    db  0xd9                 ; ex af,af'
    db  0xf1                 ; pop af
    db  0xc1                 ; pop bc
    db  0xd1                 ; pop de
    db  0xe1                 ; pop hl
    db  0xdd,0xe1            ; pop ix
    db  0xdd,0xe1            ; pop iy
    db  0x31,0x14,0x40       ; ld sp,$4014
    db  0xf5                 ; push af
    db  0xc5                 ; push bc
    db  0xd5                 ; push de
    db  0xe5                 ; push hl
    db  0xdd,0xe5            ; push ix
    db  0xdd,0xe5            ; push iy
    db  0xd9                 ; ex af,af'
    db  0xd9                 ; exx
    db  0xf5                 ; push af
    db  0xc5                 ; push bc
    db  0xd5                 ; push de
    db  0xe5                 ; push hl

pop_push_post:
    db  0xed,0x7b,0x02,0x80  ; ld sp,($8002)
    db  0xc9                 ; ret


    SAVEBIN "sp48.rom",0,$