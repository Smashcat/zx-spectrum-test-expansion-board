	; List of index 8 and 16 dwords for each attr row, for faster loading into AF pair
attr8and16vals:
	dw 32382,28784,32382,32382,30840,32382,30840,32382,30840,32382,30840,32382,30840,32382,30840,32382,30840,32382,30840,32382,30840,30832,30776,30832,30776,30832,30840,30832,14384,30832,14384,30832,14384,30846,14392,14392,30840,14456,30840,30840,30840,30776,30776,30776,14392,14392,14456,30840

pop_push_even:	;offset 0x00c4
	ld (spBackupAddr),sp

	; Audio list init

	ld bc,0xfe
	ld de,0x0010
	; Start of audio list at offset 0x00ce, 503 entries of 2 bytes each
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	; End of audio list at offset 0x04bc

	; Block attribute blit start
	ld sp,attrStartAddr+768	; Set sp to end of attr memory - code offset 0x04bf

	ld hl,30840	; src offset 766, code offset 0x04c2
	push hl		; code offset 0x04c3
	ld hl,30840	; src offset 764, code offset 0x04c6
	push hl		; code offset 0x04c7
	ld hl,30840	; src offset 762, code offset 0x04ca
	push hl		; code offset 0x04cb
	ld hl,30840	; src offset 760, code offset 0x04ce
	push hl		; code offset 0x04cf
	ld hl,30840	; src offset 758, code offset 0x04d2
	push hl		; code offset 0x04d3
	ld hl,30840	; src offset 756, code offset 0x04d6
	push hl		; code offset 0x04d7
	ld hl,30776	; src offset 754, code offset 0x04da
	push hl		; code offset 0x04db
	ld hl,14456	; src offset 752, code offset 0x04de
	push hl		; code offset 0x04df
	ld hl,30776	; src offset 750, code offset 0x04e2
	push hl		; code offset 0x04e3
	ld hl,30840	; src offset 748, code offset 0x04e6
	push hl		; code offset 0x04e7
	ld hl,30840	; src offset 746, code offset 0x04ea
	push hl		; code offset 0x04eb
	ld hl,30840	; src offset 744, code offset 0x04ee
	push hl		; code offset 0x04ef
	ld hl,30840	; src offset 742, code offset 0x04f2
	push hl		; code offset 0x04f3
	ld hl,30840	; src offset 740, code offset 0x04f6
	push hl		; code offset 0x04f7
	ld hl,30840	; src offset 738, code offset 0x04fa
	push hl		; code offset 0x04fb
	ld hl,30840	; src offset 736, code offset 0x04fe
	push hl		; code offset 0x04ff
	ld hl,14392	; src offset 734, code offset 0x0502
	push hl		; code offset 0x0503
	ld hl,14392	; src offset 732, code offset 0x0506
	push hl		; code offset 0x0507
	ld hl,30776	; src offset 730, code offset 0x050a
	push hl		; code offset 0x050b
	ld hl,14392	; src offset 728, code offset 0x050e
	push hl		; code offset 0x050f
	ld hl,14392	; src offset 726, code offset 0x0512
	push hl		; code offset 0x0513
	ld hl,14392	; src offset 724, code offset 0x0516
	push hl		; code offset 0x0517
	ld hl,14392	; src offset 722, code offset 0x051a
	push hl		; code offset 0x051b
	ld hl,14392	; src offset 720, code offset 0x051e
	push hl		; code offset 0x051f
	ld hl,14392	; src offset 718, code offset 0x0522
	push hl		; code offset 0x0523
	ld hl,14392	; src offset 716, code offset 0x0526
	push hl		; code offset 0x0527
	ld hl,14392	; src offset 714, code offset 0x052a
	push hl		; code offset 0x052b
	ld hl,14392	; src offset 712, code offset 0x052e
	push hl		; code offset 0x052f
	ld hl,14392	; src offset 710, code offset 0x0532
	push hl		; code offset 0x0533
	ld hl,14392	; src offset 708, code offset 0x0536
	push hl		; code offset 0x0537
	ld hl,14392	; src offset 706, code offset 0x053a
	push hl		; code offset 0x053b
	ld hl,14392	; src offset 704, code offset 0x053e
	push hl		; code offset 0x053f
	ld hl,14392	; src offset 702, code offset 0x0542
	push hl		; code offset 0x0543
	ld hl,30840	; src offset 700, code offset 0x0546
	push hl		; code offset 0x0547
	ld hl,30840	; src offset 698, code offset 0x054a
	push hl		; code offset 0x054b
	ld hl,30840	; src offset 696, code offset 0x054e
	push hl		; code offset 0x054f
	ld hl,14456	; src offset 694, code offset 0x0552
	push hl		; code offset 0x0553
	ld hl,30840	; src offset 692, code offset 0x0556
	push hl		; code offset 0x0557
	ld hl,30776	; src offset 690, code offset 0x055a
	push hl		; code offset 0x055b
	ld hl,30776	; src offset 688, code offset 0x055e
	push hl		; code offset 0x055f
	ld hl,14456	; src offset 686, code offset 0x0562
	push hl		; code offset 0x0563
	ld hl,30840	; src offset 684, code offset 0x0566
	push hl		; code offset 0x0567
	ld hl,14456	; src offset 682, code offset 0x056a
	push hl		; code offset 0x056b
	ld hl,30776	; src offset 680, code offset 0x056e
	push hl		; code offset 0x056f
	ld hl,30840	; src offset 678, code offset 0x0572
	push hl		; code offset 0x0573
	ld hl,14456	; src offset 676, code offset 0x0576
	push hl		; code offset 0x0577
	ld hl,30776	; src offset 674, code offset 0x057a
	push hl		; code offset 0x057b
	ld hl,14392	; src offset 672, code offset 0x057e
	push hl		; code offset 0x057f
	ld hl,14392	; src offset 670, code offset 0x0582
	push hl		; code offset 0x0583
	ld hl,14456	; src offset 668, code offset 0x0586
	push hl		; code offset 0x0587
	ld hl,30840	; src offset 666, code offset 0x058a
	push hl		; code offset 0x058b
	ld hl,30840	; src offset 664, code offset 0x058e
	push hl		; code offset 0x058f
	ld hl,30840	; src offset 662, code offset 0x0592
	push hl		; code offset 0x0593
	ld hl,30840	; src offset 660, code offset 0x0596
	push hl		; code offset 0x0597
	ld hl,30776	; src offset 658, code offset 0x059a
	push hl		; code offset 0x059b
	ld hl,30840	; src offset 656, code offset 0x059e
	push hl		; code offset 0x059f
	ld hl,30840	; src offset 654, code offset 0x05a2
	push hl		; code offset 0x05a3
	ld hl,30840	; src offset 652, code offset 0x05a6
	push hl		; code offset 0x05a7
	ld hl,30840	; src offset 650, code offset 0x05aa
	push hl		; code offset 0x05ab
	ld hl,30776	; src offset 648, code offset 0x05ae
	push hl		; code offset 0x05af
	ld hl,30840	; src offset 646, code offset 0x05b2
	push hl		; code offset 0x05b3
	ld hl,14456	; src offset 644, code offset 0x05b6
	push hl		; code offset 0x05b7
	ld hl,30840	; src offset 642, code offset 0x05ba
	push hl		; code offset 0x05bb
	ld hl,14392	; src offset 640, code offset 0x05be
	push hl		; code offset 0x05bf
	ld hl,14392	; src offset 638, code offset 0x05c2
	push hl		; code offset 0x05c3
	ld hl,14456	; src offset 636, code offset 0x05c6
	push hl		; code offset 0x05c7
	ld hl,30840	; src offset 634, code offset 0x05ca
	push hl		; code offset 0x05cb
	ld hl,30840	; src offset 632, code offset 0x05ce
	push hl		; code offset 0x05cf
	ld hl,30840	; src offset 630, code offset 0x05d2
	push hl		; code offset 0x05d3
	ld hl,30840	; src offset 628, code offset 0x05d6
	push hl		; code offset 0x05d7
	ld hl,30776	; src offset 626, code offset 0x05da
	push hl		; code offset 0x05db
	ld hl,30840	; src offset 624, code offset 0x05de
	push hl		; code offset 0x05df
	ld hl,30840	; src offset 622, code offset 0x05e2
	push hl		; code offset 0x05e3
	ld hl,30840	; src offset 620, code offset 0x05e6
	push hl		; code offset 0x05e7
	ld hl,30840	; src offset 618, code offset 0x05ea
	push hl		; code offset 0x05eb
	ld hl,30840	; src offset 616, code offset 0x05ee
	push hl		; code offset 0x05ef
	ld hl,30840	; src offset 614, code offset 0x05f2
	push hl		; code offset 0x05f3
	ld hl,30840	; src offset 612, code offset 0x05f6
	push hl		; code offset 0x05f7
	ld hl,30840	; src offset 610, code offset 0x05fa
	push hl		; code offset 0x05fb
	ld hl,14392	; src offset 608, code offset 0x05fe
	push hl		; code offset 0x05ff
	ld hl,14392	; src offset 606, code offset 0x0602
	push hl		; code offset 0x0603
	ld hl,30840	; src offset 604, code offset 0x0606
	push hl		; code offset 0x0607
	ld hl,30840	; src offset 602, code offset 0x060a
	push hl		; code offset 0x060b
	ld hl,14392	; src offset 600, code offset 0x060e
	push hl		; code offset 0x060f
	ld hl,30840	; src offset 598, code offset 0x0612
	push hl		; code offset 0x0613
	ld hl,30840	; src offset 596, code offset 0x0616
	push hl		; code offset 0x0617
	ld hl,30840	; src offset 594, code offset 0x061a
	push hl		; code offset 0x061b
	ld hl,30840	; src offset 592, code offset 0x061e
	push hl		; code offset 0x061f
	ld hl,30840	; src offset 590, code offset 0x0622
	push hl		; code offset 0x0623
	ld hl,30840	; src offset 588, code offset 0x0626
	push hl		; code offset 0x0627
	ld hl,30776	; src offset 586, code offset 0x062a
	push hl		; code offset 0x062b
	ld hl,14456	; src offset 584, code offset 0x062e
	push hl		; code offset 0x062f
	ld hl,30840	; src offset 582, code offset 0x0632
	push hl		; code offset 0x0633
	ld hl,30840	; src offset 580, code offset 0x0636
	push hl		; code offset 0x0637
	ld hl,30776	; src offset 578, code offset 0x063a
	push hl		; code offset 0x063b
	ld hl,14392	; src offset 576, code offset 0x063e
	push hl		; code offset 0x063f
	ld hl,14392	; src offset 574, code offset 0x0642
	push hl		; code offset 0x0643
	ld hl,14392	; src offset 572, code offset 0x0646
	push hl		; code offset 0x0647
	ld hl,14392	; src offset 570, code offset 0x064a
	push hl		; code offset 0x064b
	ld hl,14392	; src offset 568, code offset 0x064e
	push hl		; code offset 0x064f
	ld hl,14392	; src offset 566, code offset 0x0652
	push hl		; code offset 0x0653
	ld hl,14392	; src offset 564, code offset 0x0656
	push hl		; code offset 0x0657
	ld hl,14392	; src offset 562, code offset 0x065a
	push hl		; code offset 0x065b
	ld hl,14392	; src offset 560, code offset 0x065e
	push hl		; code offset 0x065f
	ld hl,14392	; src offset 558, code offset 0x0662
	push hl		; code offset 0x0663
	ld hl,14392	; src offset 556, code offset 0x0666
	push hl		; code offset 0x0667
	ld hl,14392	; src offset 554, code offset 0x066a
	push hl		; code offset 0x066b
	ld hl,14392	; src offset 552, code offset 0x066e
	push hl		; code offset 0x066f
	ld hl,14392	; src offset 550, code offset 0x0672
	push hl		; code offset 0x0673
	ld hl,14392	; src offset 548, code offset 0x0676
	push hl		; code offset 0x0677
	ld hl,14392	; src offset 546, code offset 0x067a
	push hl		; code offset 0x067b
	ld hl,14392	; src offset 544, code offset 0x067e
	push hl		; code offset 0x067f
	ld hl,14392	; src offset 542, code offset 0x0682
	push hl		; code offset 0x0683
	ld hl,14392	; src offset 540, code offset 0x0686
	push hl		; code offset 0x0687
	ld hl,14392	; src offset 538, code offset 0x068a
	push hl		; code offset 0x068b
	ld hl,14456	; src offset 536, code offset 0x068e
	push hl		; code offset 0x068f
	ld hl,31312	; src offset 534, code offset 0x0692
	push hl		; code offset 0x0693
	ld hl,4154	; src offset 532, code offset 0x0696
	push hl		; code offset 0x0697
	ld hl,4152	; src offset 530, code offset 0x069a
	push hl		; code offset 0x069b
	ld hl,14352	; src offset 528, code offset 0x069e
	push hl		; code offset 0x069f
	ld hl,4152	; src offset 526, code offset 0x06a2
	push hl		; code offset 0x06a3
	ld hl,14352	; src offset 524, code offset 0x06a6
	push hl		; code offset 0x06a7
	ld hl,4216	; src offset 522, code offset 0x06aa
	push hl		; code offset 0x06ab
	ld hl,30842	; src offset 520, code offset 0x06ae
	push hl		; code offset 0x06af
	ld hl,30776	; src offset 518, code offset 0x06b2
	push hl		; code offset 0x06b3
	ld hl,14392	; src offset 516, code offset 0x06b6
	push hl		; code offset 0x06b7
	ld hl,14392	; src offset 514, code offset 0x06ba
	push hl		; code offset 0x06bb
	ld hl,14392	; src offset 512, code offset 0x06be
	push hl		; code offset 0x06bf
	ld hl,14392	; src offset 510, code offset 0x06c2
	push hl		; code offset 0x06c3
	ld hl,14392	; src offset 508, code offset 0x06c6
	push hl		; code offset 0x06c7
	ld hl,14392	; src offset 506, code offset 0x06ca
	push hl		; code offset 0x06cb
	ld hl,14456	; src offset 504, code offset 0x06ce
	push hl		; code offset 0x06cf
	ld hl,20560	; src offset 502, code offset 0x06d2
	push hl		; code offset 0x06d3
	ld hl,4154	; src offset 500, code offset 0x06d6
	push hl		; code offset 0x06d7
	ld hl,4152	; src offset 498, code offset 0x06da
	push hl		; code offset 0x06db
	ld hl,14352	; src offset 496, code offset 0x06de
	push hl		; code offset 0x06df
	ld hl,4152	; src offset 494, code offset 0x06e2
	push hl		; code offset 0x06e3
	ld hl,14352	; src offset 492, code offset 0x06e6
	push hl		; code offset 0x06e7
	ld hl,4216	; src offset 490, code offset 0x06ea
	push hl		; code offset 0x06eb
	ld hl,30800	; src offset 488, code offset 0x06ee
	push hl		; code offset 0x06ef
	ld hl,30776	; src offset 486, code offset 0x06f2
	push hl		; code offset 0x06f3
	ld hl,14392	; src offset 484, code offset 0x06f6
	push hl		; code offset 0x06f7
	ld hl,14392	; src offset 482, code offset 0x06fa
	push hl		; code offset 0x06fb
	ld hl,14392	; src offset 480, code offset 0x06fe
	push hl		; code offset 0x06ff
	ld hl,14392	; src offset 478, code offset 0x0702
	push hl		; code offset 0x0703
	ld hl,14392	; src offset 476, code offset 0x0706
	push hl		; code offset 0x0707
	ld hl,30840	; src offset 474, code offset 0x070a
	push hl		; code offset 0x070b
	ld hl,30800	; src offset 472, code offset 0x070e
	push hl		; code offset 0x070f
	ld hl,20560	; src offset 470, code offset 0x0712
	push hl		; code offset 0x0713
	ld hl,20538	; src offset 468, code offset 0x0716
	push hl		; code offset 0x0717
	ld hl,30776	; src offset 466, code offset 0x071a
	push hl		; code offset 0x071b
	ld hl,14352	; src offset 464, code offset 0x071e
	push hl		; code offset 0x071f
	ld hl,14392	; src offset 462, code offset 0x0722
	push hl		; code offset 0x0723
	ld hl,14352	; src offset 460, code offset 0x0726
	push hl		; code offset 0x0727
	ld hl,4152	; src offset 458, code offset 0x072a
	push hl		; code offset 0x072b
	ld hl,30800	; src offset 456, code offset 0x072e
	push hl		; code offset 0x072f
	ld hl,20600	; src offset 454, code offset 0x0732
	push hl		; code offset 0x0733
	ld hl,30840	; src offset 452, code offset 0x0736
	push hl		; code offset 0x0737
	ld hl,14392	; src offset 450, code offset 0x073a
	push hl		; code offset 0x073b
	ld hl,14392	; src offset 448, code offset 0x073e
	push hl		; code offset 0x073f
	ld hl,14392	; src offset 446, code offset 0x0742
	push hl		; code offset 0x0743
	ld hl,14392	; src offset 444, code offset 0x0746
	push hl		; code offset 0x0747
	ld hl,30800	; src offset 442, code offset 0x074a
	push hl		; code offset 0x074b
	ld hl,20560	; src offset 440, code offset 0x074e
	push hl		; code offset 0x074f
	ld hl,20536	; src offset 438, code offset 0x0752
	push hl		; code offset 0x0753
	ld hl,20538	; src offset 436, code offset 0x0756
	push hl		; code offset 0x0757
	ld hl,30776	; src offset 434, code offset 0x075a
	push hl		; code offset 0x075b
	ld hl,30840	; src offset 432, code offset 0x075e
	push hl		; code offset 0x075f
	ld hl,14456	; src offset 430, code offset 0x0762
	push hl		; code offset 0x0763
	ld hl,14352	; src offset 428, code offset 0x0766
	push hl		; code offset 0x0767
	ld hl,4152	; src offset 426, code offset 0x076a
	push hl		; code offset 0x076b
	ld hl,30800	; src offset 424, code offset 0x076e
	push hl		; code offset 0x076f
	ld hl,20560	; src offset 422, code offset 0x0772
	push hl		; code offset 0x0773
	ld hl,20600	; src offset 420, code offset 0x0776
	push hl		; code offset 0x0777
	ld hl,14392	; src offset 418, code offset 0x077a
	push hl		; code offset 0x077b
	ld hl,14392	; src offset 416, code offset 0x077e
	push hl		; code offset 0x077f
	ld hl,14392	; src offset 414, code offset 0x0782
	push hl		; code offset 0x0783
	ld hl,30776	; src offset 412, code offset 0x0786
	push hl		; code offset 0x0787
	ld hl,30842	; src offset 410, code offset 0x078a
	push hl		; code offset 0x078b
	ld hl,20602	; src offset 408, code offset 0x078e
	push hl		; code offset 0x078f
	ld hl,20536	; src offset 406, code offset 0x0792
	push hl		; code offset 0x0793
	ld hl,30736	; src offset 404, code offset 0x0796
	push hl		; code offset 0x0797
	ld hl,30840	; src offset 402, code offset 0x079a
	push hl		; code offset 0x079b
	ld hl,30776	; src offset 400, code offset 0x079e
	push hl		; code offset 0x079f
	ld hl,14392	; src offset 398, code offset 0x07a2
	push hl		; code offset 0x07a3
	ld hl,14352	; src offset 396, code offset 0x07a6
	push hl		; code offset 0x07a7
	ld hl,20536	; src offset 394, code offset 0x07aa
	push hl		; code offset 0x07ab
	ld hl,30800	; src offset 392, code offset 0x07ae
	push hl		; code offset 0x07af
	ld hl,31354	; src offset 390, code offset 0x07b2
	push hl		; code offset 0x07b3
	ld hl,20600	; src offset 388, code offset 0x07b6
	push hl		; code offset 0x07b7
	ld hl,14392	; src offset 386, code offset 0x07ba
	push hl		; code offset 0x07bb
	ld hl,14392	; src offset 384, code offset 0x07be
	push hl		; code offset 0x07bf
	ld hl,14392	; src offset 382, code offset 0x07c2
	push hl		; code offset 0x07c3
	ld hl,30776	; src offset 380, code offset 0x07c6
	push hl		; code offset 0x07c7
	ld hl,30842	; src offset 378, code offset 0x07ca
	push hl		; code offset 0x07cb
	ld hl,31354	; src offset 376, code offset 0x07ce
	push hl		; code offset 0x07cf
	ld hl,20536	; src offset 374, code offset 0x07d2
	push hl		; code offset 0x07d3
	ld hl,30840	; src offset 372, code offset 0x07d6
	push hl		; code offset 0x07d7
	ld hl,30840	; src offset 370, code offset 0x07da
	push hl		; code offset 0x07db
	ld hl,30776	; src offset 368, code offset 0x07de
	push hl		; code offset 0x07df
	ld hl,14392	; src offset 366, code offset 0x07e2
	push hl		; code offset 0x07e3
	ld hl,30840	; src offset 364, code offset 0x07e6
	push hl		; code offset 0x07e7
	ld hl,30776	; src offset 362, code offset 0x07ea
	push hl		; code offset 0x07eb
	ld hl,30800	; src offset 360, code offset 0x07ee
	push hl		; code offset 0x07ef
	ld hl,31354	; src offset 358, code offset 0x07f2
	push hl		; code offset 0x07f3
	ld hl,20600	; src offset 356, code offset 0x07f6
	push hl		; code offset 0x07f7
	ld hl,14392	; src offset 354, code offset 0x07fa
	push hl		; code offset 0x07fb
	ld hl,14392	; src offset 352, code offset 0x07fe
	push hl		; code offset 0x07ff
	ld hl,14392	; src offset 350, code offset 0x0802
	push hl		; code offset 0x0803
	ld hl,30840	; src offset 348, code offset 0x0806
	push hl		; code offset 0x0807
	ld hl,30842	; src offset 346, code offset 0x080a
	push hl		; code offset 0x080b
	ld hl,31354	; src offset 344, code offset 0x080e
	push hl		; code offset 0x080f
	ld hl,31352	; src offset 342, code offset 0x0812
	push hl		; code offset 0x0813
	ld hl,14456	; src offset 340, code offset 0x0816
	push hl		; code offset 0x0817
	ld hl,30840	; src offset 338, code offset 0x081a
	push hl		; code offset 0x081b
	ld hl,30840	; src offset 336, code offset 0x081e
	push hl		; code offset 0x081f
	ld hl,30840	; src offset 334, code offset 0x0822
	push hl		; code offset 0x0823
	ld hl,30840	; src offset 332, code offset 0x0826
	push hl		; code offset 0x0827
	ld hl,30840	; src offset 330, code offset 0x082a
	push hl		; code offset 0x082b
	ld hl,30800	; src offset 328, code offset 0x082e
	push hl		; code offset 0x082f
	ld hl,31354	; src offset 326, code offset 0x0832
	push hl		; code offset 0x0833
	ld hl,31312	; src offset 324, code offset 0x0836
	push hl		; code offset 0x0837
	ld hl,30840	; src offset 322, code offset 0x083a
	push hl		; code offset 0x083b
	ld hl,14392	; src offset 320, code offset 0x083e
	push hl		; code offset 0x083f
	ld hl,14392	; src offset 318, code offset 0x0842
	push hl		; code offset 0x0843
	ld hl,30840	; src offset 316, code offset 0x0846
	push hl		; code offset 0x0847
	ld hl,20602	; src offset 314, code offset 0x084a
	push hl		; code offset 0x084b
	ld hl,31354	; src offset 312, code offset 0x084e
	push hl		; code offset 0x084f
	ld hl,31312	; src offset 310, code offset 0x0852
	push hl		; code offset 0x0853
	ld hl,14392	; src offset 308, code offset 0x0856
	push hl		; code offset 0x0857
	ld hl,30840	; src offset 306, code offset 0x085a
	push hl		; code offset 0x085b
	ld hl,30840	; src offset 304, code offset 0x085e
	push hl		; code offset 0x085f
	ld hl,30840	; src offset 302, code offset 0x0862
	push hl		; code offset 0x0863
	ld hl,30840	; src offset 300, code offset 0x0866
	push hl		; code offset 0x0867
	ld hl,14456	; src offset 298, code offset 0x086a
	push hl		; code offset 0x086b
	ld hl,31354	; src offset 296, code offset 0x086e
	push hl		; code offset 0x086f
	ld hl,31354	; src offset 294, code offset 0x0872
	push hl		; code offset 0x0873
	ld hl,31312	; src offset 292, code offset 0x0876
	push hl		; code offset 0x0877
	ld hl,20600	; src offset 290, code offset 0x087a
	push hl		; code offset 0x087b
	ld hl,14392	; src offset 288, code offset 0x087e
	push hl		; code offset 0x087f
	ld hl,14392	; src offset 286, code offset 0x0882
	push hl		; code offset 0x0883
	ld hl,14416	; src offset 284, code offset 0x0886
	push hl		; code offset 0x0887
	ld hl,20602	; src offset 282, code offset 0x088a
	push hl		; code offset 0x088b
	ld hl,31354	; src offset 280, code offset 0x088e
	push hl		; code offset 0x088f
	ld hl,31354	; src offset 278, code offset 0x0892
	push hl		; code offset 0x0893
	ld hl,20536	; src offset 276, code offset 0x0896
	push hl		; code offset 0x0897
	ld hl,30840	; src offset 274, code offset 0x089a
	push hl		; code offset 0x089b
	ld hl,30840	; src offset 272, code offset 0x089e
	push hl		; code offset 0x089f
	ld hl,30840	; src offset 270, code offset 0x08a2
	push hl		; code offset 0x08a3
	ld hl,30776	; src offset 268, code offset 0x08a6
	push hl		; code offset 0x08a7
	ld hl,14416	; src offset 266, code offset 0x08aa
	push hl		; code offset 0x08ab
	ld hl,31354	; src offset 264, code offset 0x08ae
	push hl		; code offset 0x08af
	ld hl,31354	; src offset 262, code offset 0x08b2
	push hl		; code offset 0x08b3
	ld hl,31354	; src offset 260, code offset 0x08b6
	push hl		; code offset 0x08b7
	ld hl,20600	; src offset 258, code offset 0x08ba
	push hl		; code offset 0x08bb
	ld hl,14392	; src offset 256, code offset 0x08be
	push hl		; code offset 0x08bf
	ld hl,14456	; src offset 254, code offset 0x08c2
	push hl		; code offset 0x08c3
	ld hl,14416	; src offset 252, code offset 0x08c6
	push hl		; code offset 0x08c7
	ld hl,31354	; src offset 250, code offset 0x08ca
	push hl		; code offset 0x08cb
	ld hl,31354	; src offset 248, code offset 0x08ce
	push hl		; code offset 0x08cf
	ld hl,31354	; src offset 246, code offset 0x08d2
	push hl		; code offset 0x08d3
	ld hl,20600	; src offset 244, code offset 0x08d6
	push hl		; code offset 0x08d7
	ld hl,30840	; src offset 242, code offset 0x08da
	push hl		; code offset 0x08db
	ld hl,30840	; src offset 240, code offset 0x08de
	push hl		; code offset 0x08df
	ld hl,30840	; src offset 238, code offset 0x08e2
	push hl		; code offset 0x08e3
	ld hl,30840	; src offset 236, code offset 0x08e6
	push hl		; code offset 0x08e7
	ld hl,20602	; src offset 234, code offset 0x08ea
	push hl		; code offset 0x08eb
	ld hl,31354	; src offset 232, code offset 0x08ee
	push hl		; code offset 0x08ef
	ld hl,31354	; src offset 230, code offset 0x08f2
	push hl		; code offset 0x08f3
	ld hl,31354	; src offset 228, code offset 0x08f6
	push hl		; code offset 0x08f7
	ld hl,20600	; src offset 226, code offset 0x08fa
	push hl		; code offset 0x08fb
	ld hl,14392	; src offset 224, code offset 0x08fe
	push hl		; code offset 0x08ff
	ld hl,14456	; src offset 222, code offset 0x0902
	push hl		; code offset 0x0903
	ld hl,14416	; src offset 220, code offset 0x0906
	push hl		; code offset 0x0907
	ld hl,31354	; src offset 218, code offset 0x090a
	push hl		; code offset 0x090b
	ld hl,31354	; src offset 216, code offset 0x090e
	push hl		; code offset 0x090f
	ld hl,31354	; src offset 214, code offset 0x0912
	push hl		; code offset 0x0913
	ld hl,31352	; src offset 212, code offset 0x0916
	push hl		; code offset 0x0917
	ld hl,30840	; src offset 210, code offset 0x091a
	push hl		; code offset 0x091b
	ld hl,30840	; src offset 208, code offset 0x091e
	push hl		; code offset 0x091f
	ld hl,30840	; src offset 206, code offset 0x0922
	push hl		; code offset 0x0923
	ld hl,30840	; src offset 204, code offset 0x0926
	push hl		; code offset 0x0927
	ld hl,20602	; src offset 202, code offset 0x092a
	push hl		; code offset 0x092b
	ld hl,31354	; src offset 200, code offset 0x092e
	push hl		; code offset 0x092f
	ld hl,31354	; src offset 198, code offset 0x0932
	push hl		; code offset 0x0933
	ld hl,31312	; src offset 196, code offset 0x0936
	push hl		; code offset 0x0937
	ld hl,20536	; src offset 194, code offset 0x093a
	push hl		; code offset 0x093b
	ld hl,30776	; src offset 192, code offset 0x093e
	push hl		; code offset 0x093f
	ld hl,14456	; src offset 190, code offset 0x0942
	push hl		; code offset 0x0943
	ld hl,14392	; src offset 188, code offset 0x0946
	push hl		; code offset 0x0947
	ld hl,20602	; src offset 186, code offset 0x094a
	push hl		; code offset 0x094b
	ld hl,31354	; src offset 184, code offset 0x094e
	push hl		; code offset 0x094f
	ld hl,31354	; src offset 182, code offset 0x0952
	push hl		; code offset 0x0953
	ld hl,31354	; src offset 180, code offset 0x0956
	push hl		; code offset 0x0957
	ld hl,30840	; src offset 178, code offset 0x095a
	push hl		; code offset 0x095b
	ld hl,30840	; src offset 176, code offset 0x095e
	push hl		; code offset 0x095f
	ld hl,30840	; src offset 174, code offset 0x0962
	push hl		; code offset 0x0963
	ld hl,30800	; src offset 172, code offset 0x0966
	push hl		; code offset 0x0967
	ld hl,31354	; src offset 170, code offset 0x096a
	push hl		; code offset 0x096b
	ld hl,31354	; src offset 168, code offset 0x096e
	push hl		; code offset 0x096f
	ld hl,31354	; src offset 166, code offset 0x0972
	push hl		; code offset 0x0973
	ld hl,31312	; src offset 164, code offset 0x0976
	push hl		; code offset 0x0977
	ld hl,14392	; src offset 162, code offset 0x097a
	push hl		; code offset 0x097b
	ld hl,30776	; src offset 160, code offset 0x097e
	push hl		; code offset 0x097f
	ld hl,14456	; src offset 158, code offset 0x0982
	push hl		; code offset 0x0983
	ld hl,14392	; src offset 156, code offset 0x0986
	push hl		; code offset 0x0987
	ld hl,20602	; src offset 154, code offset 0x098a
	push hl		; code offset 0x098b
	ld hl,31354	; src offset 152, code offset 0x098e
	push hl		; code offset 0x098f
	ld hl,31354	; src offset 150, code offset 0x0992
	push hl		; code offset 0x0993
	ld hl,31354	; src offset 148, code offset 0x0996
	push hl		; code offset 0x0997
	ld hl,20600	; src offset 146, code offset 0x099a
	push hl		; code offset 0x099b
	ld hl,30840	; src offset 144, code offset 0x099e
	push hl		; code offset 0x099f
	ld hl,30840	; src offset 142, code offset 0x09a2
	push hl		; code offset 0x09a3
	ld hl,30800	; src offset 140, code offset 0x09a6
	push hl		; code offset 0x09a7
	ld hl,31354	; src offset 138, code offset 0x09aa
	push hl		; code offset 0x09ab
	ld hl,31354	; src offset 136, code offset 0x09ae
	push hl		; code offset 0x09af
	ld hl,31354	; src offset 134, code offset 0x09b2
	push hl		; code offset 0x09b3
	ld hl,20560	; src offset 132, code offset 0x09b6
	push hl		; code offset 0x09b7
	ld hl,14392	; src offset 130, code offset 0x09ba
	push hl		; code offset 0x09bb
	ld hl,30776	; src offset 128, code offset 0x09be
	push hl		; code offset 0x09bf
	ld hl,14392	; src offset 126, code offset 0x09c2
	push hl		; code offset 0x09c3
	ld hl,14392	; src offset 124, code offset 0x09c6
	push hl		; code offset 0x09c7
	ld hl,14416	; src offset 122, code offset 0x09ca
	push hl		; code offset 0x09cb
	ld hl,31354	; src offset 120, code offset 0x09ce
	push hl		; code offset 0x09cf
	ld hl,31354	; src offset 118, code offset 0x09d2
	push hl		; code offset 0x09d3
	ld hl,31354	; src offset 116, code offset 0x09d6
	push hl		; code offset 0x09d7
	ld hl,20600	; src offset 114, code offset 0x09da
	push hl		; code offset 0x09db
	ld hl,30840	; src offset 112, code offset 0x09de
	push hl		; code offset 0x09df
	ld hl,30840	; src offset 110, code offset 0x09e2
	push hl		; code offset 0x09e3
	ld hl,30800	; src offset 108, code offset 0x09e6
	push hl		; code offset 0x09e7
	ld hl,31354	; src offset 106, code offset 0x09ea
	push hl		; code offset 0x09eb
	ld hl,31354	; src offset 104, code offset 0x09ee
	push hl		; code offset 0x09ef
	ld hl,31354	; src offset 102, code offset 0x09f2
	push hl		; code offset 0x09f3
	ld hl,4152	; src offset 100, code offset 0x09f6
	push hl		; code offset 0x09f7
	ld hl,14392	; src offset 98, code offset 0x09fa
	push hl		; code offset 0x09fb
	ld hl,30776	; src offset 96, code offset 0x09fe
	push hl		; code offset 0x09ff
	ld hl,14392	; src offset 94, code offset 0x0a02
	push hl		; code offset 0x0a03
	ld hl,14392	; src offset 92, code offset 0x0a06
	push hl		; code offset 0x0a07
	ld hl,14416	; src offset 90, code offset 0x0a0a
	push hl		; code offset 0x0a0b
	ld hl,20602	; src offset 88, code offset 0x0a0e
	push hl		; code offset 0x0a0f
	ld hl,31354	; src offset 86, code offset 0x0a12
	push hl		; code offset 0x0a13
	ld hl,31354	; src offset 84, code offset 0x0a16
	push hl		; code offset 0x0a17
	ld hl,31312	; src offset 82, code offset 0x0a1a
	push hl		; code offset 0x0a1b
	ld hl,30840	; src offset 80, code offset 0x0a1e
	push hl		; code offset 0x0a1f
	ld hl,30840	; src offset 78, code offset 0x0a22
	push hl		; code offset 0x0a23
	ld hl,31354	; src offset 76, code offset 0x0a26
	push hl		; code offset 0x0a27
	ld hl,31354	; src offset 74, code offset 0x0a2a
	push hl		; code offset 0x0a2b
	ld hl,31354	; src offset 72, code offset 0x0a2e
	push hl		; code offset 0x0a2f
	ld hl,31312	; src offset 70, code offset 0x0a32
	push hl		; code offset 0x0a33
	ld hl,14392	; src offset 68, code offset 0x0a36
	push hl		; code offset 0x0a37
	ld hl,14392	; src offset 66, code offset 0x0a3a
	push hl		; code offset 0x0a3b
	ld hl,30776	; src offset 64, code offset 0x0a3e
	push hl		; code offset 0x0a3f
	ld hl,14392	; src offset 62, code offset 0x0a42
	push hl		; code offset 0x0a43
	ld hl,14392	; src offset 60, code offset 0x0a46
	push hl		; code offset 0x0a47
	ld hl,14392	; src offset 58, code offset 0x0a4a
	push hl		; code offset 0x0a4b
	ld hl,20560	; src offset 56, code offset 0x0a4e
	push hl		; code offset 0x0a4f
	ld hl,31354	; src offset 54, code offset 0x0a52
	push hl		; code offset 0x0a53
	ld hl,31354	; src offset 52, code offset 0x0a56
	push hl		; code offset 0x0a57
	ld hl,31354	; src offset 50, code offset 0x0a5a
	push hl		; code offset 0x0a5b
	ld hl,31354	; src offset 48, code offset 0x0a5e
	push hl		; code offset 0x0a5f
	ld hl,20602	; src offset 46, code offset 0x0a62
	push hl		; code offset 0x0a63
	ld hl,31354	; src offset 44, code offset 0x0a66
	push hl		; code offset 0x0a67
	ld hl,31354	; src offset 42, code offset 0x0a6a
	push hl		; code offset 0x0a6b
	ld hl,31354	; src offset 40, code offset 0x0a6e
	push hl		; code offset 0x0a6f
	ld hl,20560	; src offset 38, code offset 0x0a72
	push hl		; code offset 0x0a73
	ld hl,14392	; src offset 36, code offset 0x0a76
	push hl		; code offset 0x0a77
	ld hl,14392	; src offset 34, code offset 0x0a7a
	push hl		; code offset 0x0a7b
	ld hl,30776	; src offset 32, code offset 0x0a7e
	push hl		; code offset 0x0a7f
	ld hl,14392	; src offset 30, code offset 0x0a82
	push hl		; code offset 0x0a83
	ld hl,14392	; src offset 28, code offset 0x0a86
	push hl		; code offset 0x0a87
	ld hl,14392	; src offset 26, code offset 0x0a8a
	push hl		; code offset 0x0a8b
	ld hl,14416	; src offset 24, code offset 0x0a8e
	push hl		; code offset 0x0a8f
	ld hl,20602	; src offset 22, code offset 0x0a92
	push hl		; code offset 0x0a93
	ld hl,31354	; src offset 20, code offset 0x0a96
	push hl		; code offset 0x0a97
	ld hl,31354	; src offset 18, code offset 0x0a9a
	push hl		; code offset 0x0a9b
	ld hl,31354	; src offset 16, code offset 0x0a9e
	push hl		; code offset 0x0a9f
	ld hl,31354	; src offset 14, code offset 0x0aa2
	push hl		; code offset 0x0aa3
	ld hl,31354	; src offset 12, code offset 0x0aa6
	push hl		; code offset 0x0aa7
	ld hl,31354	; src offset 10, code offset 0x0aaa
	push hl		; code offset 0x0aab
	ld hl,20560	; src offset 8, code offset 0x0aae
	push hl		; code offset 0x0aaf
	ld hl,14392	; src offset 6, code offset 0x0ab2
	push hl		; code offset 0x0ab3
	ld hl,14392	; src offset 4, code offset 0x0ab6
	push hl		; code offset 0x0ab7
	ld hl,14392	; src offset 2, code offset 0x0aba
	push hl		; code offset 0x0abb
	ld hl,14392	; src offset 0, code offset 0x0abe
	push hl		; code offset 0x0abf

	; Block attribute blit end

	; delay to get start of scanline (10 T-states) at offset 0x0abf
	ld b,0
		; offset 0x0ac1, 8 T-states remaining
	nop   	; offset 0x0ac2, 4 T-states remaining
	nop   	; offset 0x0ac3, 0 T-states remaining


	; src_data blit 0
	ld sp,screenStartAddr+16	; offset 0x0ac6
	ld hl,65535	; offset 0x0ac9
	push hl	; offset 0x0aca
	ld hl,65535	; offset 0x0acd
	push hl	; offset 0x0ace
	ld hl,65535	; offset 0x0ad1
	push hl	; offset 0x0ad2
	ld hl,33023	; offset 0x0ad5
	push hl	; offset 0x0ad6
	ld hl,65535	; offset 0x0ad9
	push hl	; offset 0x0ada
	ld hl,65535	; offset 0x0add
	push hl	; offset 0x0ade
	ld hl,65535	; offset 0x0ae1
	push hl	; offset 0x0ae2
	ld hl,65535	; offset 0x0ae5
	push hl	; offset 0x0ae6

	; src_data blit 1
	ld sp,screenStartAddr+32	; offset 0x0ae9
	ld hl,65535	; offset 0x0aec
	push hl	; offset 0x0aed
	ld hl,65535	; offset 0x0af0
	push hl	; offset 0x0af1
	ld hl,65535	; offset 0x0af4
	push hl	; offset 0x0af5
	ld hl,65535	; offset 0x0af8
	push hl	; offset 0x0af9
	ld hl,32767	; offset 0x0afc
	push hl	; offset 0x0afd
	ld hl,65535	; offset 0x0b00
	push hl	; offset 0x0b01
	ld hl,65535	; offset 0x0b04
	push hl	; offset 0x0b05
	ld hl,65535	; offset 0x0b08
	push hl	; offset 0x0b09

	; src_data blit 2
	ld sp,screenStartAddr+272	; offset 0x0b0c
	ld hl,65535	; offset 0x0b0f
	push hl	; offset 0x0b10
	ld hl,65535	; offset 0x0b13
	push hl	; offset 0x0b14
	ld hl,65535	; offset 0x0b17
	push hl	; offset 0x0b18
	ld hl,255	; offset 0x0b1b
	push hl	; offset 0x0b1c
	ld hl,65535	; offset 0x0b1f
	push hl	; offset 0x0b20
	ld hl,65535	; offset 0x0b23
	push hl	; offset 0x0b24
	ld hl,65535	; offset 0x0b27
	push hl	; offset 0x0b28
	ld hl,65535	; offset 0x0b2b
	push hl	; offset 0x0b2c

	; attr draw 0
	ld sp,attr8and16vals+0
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,32382	; src 18
	ld de,32382	; src 20
	ld hl,28798	; src 22
	ld ix,14392	; src 4
	ld iy,14392	; src 6
	exx
	ld bc,32382	; src 10
	ld de,32382	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+0
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+0),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+0),hl	; dest 2
	ld hl,32382	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+0
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,14448	; src 24
	ld de,14392	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+0
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+0),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 0, offset 0x0b85
	; Clock offset: -864


	; src_data blit 3
	ld sp,screenStartAddr+288	; offset 0x0b88
	ld hl,65535	; offset 0x0b8b
	push hl	; offset 0x0b8c
	ld hl,65535	; offset 0x0b8f
	push hl	; offset 0x0b90
	ld hl,65535	; offset 0x0b93
	push hl	; offset 0x0b94
	ld hl,65535	; offset 0x0b97
	push hl	; offset 0x0b98
	ld hl,8191	; offset 0x0b9b
	push hl	; offset 0x0b9c
	ld hl,65535	; offset 0x0b9f
	push hl	; offset 0x0ba0
	ld hl,65535	; offset 0x0ba3
	push hl	; offset 0x0ba4
	ld hl,65535	; offset 0x0ba7
	push hl	; offset 0x0ba8

	; src_data blit 4
	ld sp,screenStartAddr+528	; offset 0x0bab
	ld hl,65535	; offset 0x0bae
	push hl	; offset 0x0baf
	ld hl,65535	; offset 0x0bb2
	push hl	; offset 0x0bb3
	ld hl,65535	; offset 0x0bb6
	push hl	; offset 0x0bb7
	ld hl,252	; offset 0x0bba
	push hl	; offset 0x0bbb
	ld hl,65535	; offset 0x0bbe
	push hl	; offset 0x0bbf
	ld hl,65535	; offset 0x0bc2
	push hl	; offset 0x0bc3
	ld hl,65535	; offset 0x0bc6
	push hl	; offset 0x0bc7
	ld hl,65535	; offset 0x0bca
	push hl	; offset 0x0bcb

	; src_data blit 5
	ld sp,screenStartAddr+544	; offset 0x0bce
	ld hl,65535	; offset 0x0bd1
	push hl	; offset 0x0bd2
	ld hl,65535	; offset 0x0bd5
	push hl	; offset 0x0bd6
	ld hl,65535	; offset 0x0bd9
	push hl	; offset 0x0bda
	ld hl,65535	; offset 0x0bdd
	push hl	; offset 0x0bde
	ld hl,4095	; offset 0x0be1
	push hl	; offset 0x0be2
	ld hl,65535	; offset 0x0be5
	push hl	; offset 0x0be6
	ld hl,65535	; offset 0x0be9
	push hl	; offset 0x0bea
	ld hl,65535	; offset 0x0bed
	push hl	; offset 0x0bee

	; src_data blit 6
	ld sp,screenStartAddr+784	; offset 0x0bf1
	ld hl,65535	; offset 0x0bf4
	push hl	; offset 0x0bf5
	ld hl,65535	; offset 0x0bf8
	push hl	; offset 0x0bf9
	ld hl,65535	; offset 0x0bfc
	push hl	; offset 0x0bfd
	ld hl,248	; offset 0x0c00
	push hl	; offset 0x0c01
	ld hl,65535	; offset 0x0c04
	push hl	; offset 0x0c05
	ld hl,65535	; offset 0x0c08
	push hl	; offset 0x0c09
	ld hl,65535	; offset 0x0c0c
	push hl	; offset 0x0c0d
	ld hl,65535	; offset 0x0c10
	push hl	; offset 0x0c11

	; src_data blit 7
	ld sp,screenStartAddr+800	; offset 0x0c14
	ld hl,65535	; offset 0x0c17
	push hl	; offset 0x0c18
	ld hl,65535	; offset 0x0c1b
	push hl	; offset 0x0c1c
	ld hl,65535	; offset 0x0c1f
	push hl	; offset 0x0c20
	ld hl,65535	; offset 0x0c23
	push hl	; offset 0x0c24
	ld hl,2047	; offset 0x0c27
	push hl	; offset 0x0c28
	ld hl,65535	; offset 0x0c2b
	push hl	; offset 0x0c2c
	ld hl,65535	; offset 0x0c2f
	push hl	; offset 0x0c30
	ld hl,65535	; offset 0x0c33
	push hl	; offset 0x0c34

	; src_data blit 8
	ld sp,screenStartAddr+1040	; offset 0x0c37
	ld hl,65535	; offset 0x0c3a
	push hl	; offset 0x0c3b
	ld hl,65535	; offset 0x0c3e
	push hl	; offset 0x0c3f
	ld hl,65535	; offset 0x0c42
	push hl	; offset 0x0c43
	ld hl,240	; offset 0x0c46
	push hl	; offset 0x0c47
	ld hl,65535	; offset 0x0c4a
	push hl	; offset 0x0c4b
	ld hl,65535	; offset 0x0c4e
	push hl	; offset 0x0c4f
	ld hl,65535	; offset 0x0c52
	push hl	; offset 0x0c53
	ld hl,65535	; offset 0x0c56
	push hl	; offset 0x0c57

	; attr draw 1
	ld sp,attr8and16vals+4
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,32382	; src 18
	ld de,32382	; src 20
	ld hl,32382	; src 22
	ld ix,14392	; src 4
	ld iy,28784	; src 6
	exx
	ld bc,32382	; src 10
	ld de,32382	; src 12
	ld hl,30776	; src 0

	ld sp,attrStartAddr+16+32
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+32),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+32),hl	; dest 2
	ld hl,28798	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+32
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,28784	; src 24
	ld de,14392	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+32
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+32),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 1, offset 0x0cb0
	; Clock offset: -864


	; src_data blit 9
	ld sp,screenStartAddr+1056	; offset 0x0cb3
	ld hl,65535	; offset 0x0cb6
	push hl	; offset 0x0cb7
	ld hl,65535	; offset 0x0cba
	push hl	; offset 0x0cbb
	ld hl,65535	; offset 0x0cbe
	push hl	; offset 0x0cbf
	ld hl,65535	; offset 0x0cc2
	push hl	; offset 0x0cc3
	ld hl,511	; offset 0x0cc6
	push hl	; offset 0x0cc7
	ld hl,65535	; offset 0x0cca
	push hl	; offset 0x0ccb
	ld hl,65535	; offset 0x0cce
	push hl	; offset 0x0ccf
	ld hl,65535	; offset 0x0cd2
	push hl	; offset 0x0cd3

	; src_data blit 10
	ld sp,screenStartAddr+1296	; offset 0x0cd6
	ld hl,65535	; offset 0x0cd9
	push hl	; offset 0x0cda
	ld hl,65535	; offset 0x0cdd
	push hl	; offset 0x0cde
	ld hl,65535	; offset 0x0ce1
	push hl	; offset 0x0ce2
	ld hl,192	; offset 0x0ce5
	push hl	; offset 0x0ce6
	ld hl,65535	; offset 0x0ce9
	push hl	; offset 0x0cea
	ld hl,65535	; offset 0x0ced
	push hl	; offset 0x0cee
	ld hl,65535	; offset 0x0cf1
	push hl	; offset 0x0cf2
	ld hl,65295	; offset 0x0cf5
	push hl	; offset 0x0cf6

	; src_data blit 11
	ld sp,screenStartAddr+1312	; offset 0x0cf9
	ld hl,63743	; offset 0x0cfc
	push hl	; offset 0x0cfd
	ld hl,65535	; offset 0x0d00
	push hl	; offset 0x0d01
	ld hl,65535	; offset 0x0d04
	push hl	; offset 0x0d05
	ld hl,65535	; offset 0x0d08
	push hl	; offset 0x0d09
	ld hl,255	; offset 0x0d0c
	push hl	; offset 0x0d0d
	ld hl,65535	; offset 0x0d10
	push hl	; offset 0x0d11
	ld hl,65535	; offset 0x0d14
	push hl	; offset 0x0d15
	ld hl,65535	; offset 0x0d18
	push hl	; offset 0x0d19

	; src_data blit 12
	ld sp,screenStartAddr+1552	; offset 0x0d1c
	ld hl,65535	; offset 0x0d1f
	push hl	; offset 0x0d20
	ld hl,65535	; offset 0x0d23
	push hl	; offset 0x0d24
	ld hl,65535	; offset 0x0d27
	push hl	; offset 0x0d28
	ld hl,128	; offset 0x0d2b
	push hl	; offset 0x0d2c
	ld hl,65535	; offset 0x0d2f
	push hl	; offset 0x0d30
	ld hl,65535	; offset 0x0d33
	push hl	; offset 0x0d34
	ld hl,65535	; offset 0x0d37
	push hl	; offset 0x0d38
	ld hl,65531	; offset 0x0d3b
	push hl	; offset 0x0d3c

	; src_data blit 13
	ld sp,screenStartAddr+1568	; offset 0x0d3f
	ld hl,63487	; offset 0x0d42
	push hl	; offset 0x0d43
	ld hl,65535	; offset 0x0d46
	push hl	; offset 0x0d47
	ld hl,65535	; offset 0x0d4a
	push hl	; offset 0x0d4b
	ld hl,65407	; offset 0x0d4e
	push hl	; offset 0x0d4f
	ld hl,255	; offset 0x0d52
	push hl	; offset 0x0d53
	ld hl,65535	; offset 0x0d56
	push hl	; offset 0x0d57
	ld hl,65535	; offset 0x0d5a
	push hl	; offset 0x0d5b
	ld hl,65535	; offset 0x0d5e
	push hl	; offset 0x0d5f

	; src_data blit 14
	ld sp,screenStartAddr+1808	; offset 0x0d62
	ld hl,65535	; offset 0x0d65
	push hl	; offset 0x0d66
	ld hl,65535	; offset 0x0d69
	push hl	; offset 0x0d6a
	ld hl,65535	; offset 0x0d6d
	push hl	; offset 0x0d6e
	ld hl,0	; offset 0x0d71
	push hl	; offset 0x0d72
	ld hl,65535	; offset 0x0d75
	push hl	; offset 0x0d76
	ld hl,65535	; offset 0x0d79
	push hl	; offset 0x0d7a
	ld hl,65535	; offset 0x0d7d
	push hl	; offset 0x0d7e
	ld hl,65349	; offset 0x0d81
	push hl	; offset 0x0d82

	; attr draw 2
	ld sp,attr8and16vals+8
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,32368	; src 18
	ld de,32382	; src 20
	ld hl,32382	; src 22
	ld ix,14392	; src 4
	ld iy,32368	; src 6
	exx
	ld bc,32382	; src 10
	ld de,32382	; src 12
	ld hl,30776	; src 0

	ld sp,attrStartAddr+16+64
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+64),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+64),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+64
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,28798	; src 24
	ld de,14448	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+64
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+64),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 2, offset 0x0ddb
	; Clock offset: -864


	; src_data blit 15
	ld sp,screenStartAddr+1824	; offset 0x0dde
	ld hl,60671	; offset 0x0de1
	push hl	; offset 0x0de2
	ld hl,65535	; offset 0x0de5
	push hl	; offset 0x0de6
	ld hl,65535	; offset 0x0de9
	push hl	; offset 0x0dea
	ld hl,65343	; offset 0x0ded
	push hl	; offset 0x0dee
	ld hl,255	; offset 0x0df1
	push hl	; offset 0x0df2
	ld hl,65535	; offset 0x0df5
	push hl	; offset 0x0df6
	ld hl,65535	; offset 0x0df9
	push hl	; offset 0x0dfa
	ld hl,65535	; offset 0x0dfd
	push hl	; offset 0x0dfe

	; src_data blit 16
	ld sp,screenStartAddr+48	; offset 0x0e01
	ld hl,255	; offset 0x0e04
	push hl	; offset 0x0e05
	ld hl,65535	; offset 0x0e08
	push hl	; offset 0x0e09
	ld hl,65535	; offset 0x0e0c
	push hl	; offset 0x0e0d
	ld hl,65535	; offset 0x0e10
	push hl	; offset 0x0e11
	ld hl,65279	; offset 0x0e14
	push hl	; offset 0x0e15
	ld hl,65535	; offset 0x0e18
	push hl	; offset 0x0e19
	ld hl,65535	; offset 0x0e1c
	push hl	; offset 0x0e1d
	ld hl,65373	; offset 0x0e20
	push hl	; offset 0x0e21

	; src_data blit 17
	ld sp,screenStartAddr+64	; offset 0x0e24
	ld hl,60671	; offset 0x0e27
	push hl	; offset 0x0e28
	ld hl,65535	; offset 0x0e2b
	push hl	; offset 0x0e2c
	ld hl,65535	; offset 0x0e2f
	push hl	; offset 0x0e30
	ld hl,65311	; offset 0x0e33
	push hl	; offset 0x0e34
	ld hl,65535	; offset 0x0e37
	push hl	; offset 0x0e38
	ld hl,65535	; offset 0x0e3b
	push hl	; offset 0x0e3c
	ld hl,65535	; offset 0x0e3f
	push hl	; offset 0x0e40
	ld hl,65535	; offset 0x0e43
	push hl	; offset 0x0e44

	; src_data blit 18
	ld sp,screenStartAddr+304	; offset 0x0e47
	ld hl,255	; offset 0x0e4a
	push hl	; offset 0x0e4b
	ld hl,65535	; offset 0x0e4e
	push hl	; offset 0x0e4f
	ld hl,65535	; offset 0x0e52
	push hl	; offset 0x0e53
	ld hl,65535	; offset 0x0e56
	push hl	; offset 0x0e57
	ld hl,64767	; offset 0x0e5a
	push hl	; offset 0x0e5b
	ld hl,65535	; offset 0x0e5e
	push hl	; offset 0x0e5f
	ld hl,65535	; offset 0x0e62
	push hl	; offset 0x0e63
	ld hl,65360	; offset 0x0e66
	push hl	; offset 0x0e67

	; src_data blit 19
	ld sp,screenStartAddr+320	; offset 0x0e6a
	ld hl,49407	; offset 0x0e6d
	push hl	; offset 0x0e6e
	ld hl,65535	; offset 0x0e71
	push hl	; offset 0x0e72
	ld hl,65535	; offset 0x0e75
	push hl	; offset 0x0e76
	ld hl,65295	; offset 0x0e79
	push hl	; offset 0x0e7a
	ld hl,65535	; offset 0x0e7d
	push hl	; offset 0x0e7e
	ld hl,65535	; offset 0x0e81
	push hl	; offset 0x0e82
	ld hl,65535	; offset 0x0e85
	push hl	; offset 0x0e86
	ld hl,65535	; offset 0x0e89
	push hl	; offset 0x0e8a

	; src_data blit 20
	ld sp,screenStartAddr+560	; offset 0x0e8d
	ld hl,255	; offset 0x0e90
	push hl	; offset 0x0e91
	ld hl,65535	; offset 0x0e94
	push hl	; offset 0x0e95
	ld hl,65535	; offset 0x0e98
	push hl	; offset 0x0e99
	ld hl,65535	; offset 0x0e9c
	push hl	; offset 0x0e9d
	ld hl,61695	; offset 0x0ea0
	push hl	; offset 0x0ea1
	ld hl,65535	; offset 0x0ea4
	push hl	; offset 0x0ea5
	ld hl,65535	; offset 0x0ea8
	push hl	; offset 0x0ea9
	ld hl,32600	; offset 0x0eac
	push hl	; offset 0x0ead

	; attr draw 3
	ld sp,attr8and16vals+12
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,28792	; src 18
	ld de,32382	; src 20
	ld hl,32382	; src 22
	ld ix,12344	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,32382	; src 10
	ld de,30832	; src 12
	ld hl,30776	; src 0

	ld sp,attrStartAddr+16+96
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+96),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+96),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+96
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,14448	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+96
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+96),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 3, offset 0x0f06
	; Clock offset: -864


	; src_data blit 21
	ld sp,screenStartAddr+576	; offset 0x0f09
	ld hl,36351	; offset 0x0f0c
	push hl	; offset 0x0f0d
	ld hl,65535	; offset 0x0f10
	push hl	; offset 0x0f11
	ld hl,65535	; offset 0x0f14
	push hl	; offset 0x0f15
	ld hl,65287	; offset 0x0f18
	push hl	; offset 0x0f19
	ld hl,65535	; offset 0x0f1c
	push hl	; offset 0x0f1d
	ld hl,65535	; offset 0x0f20
	push hl	; offset 0x0f21
	ld hl,65535	; offset 0x0f24
	push hl	; offset 0x0f25
	ld hl,65535	; offset 0x0f28
	push hl	; offset 0x0f29

	; src_data blit 22
	ld sp,screenStartAddr+816	; offset 0x0f2c
	ld hl,255	; offset 0x0f2f
	push hl	; offset 0x0f30
	ld hl,65535	; offset 0x0f33
	push hl	; offset 0x0f34
	ld hl,65535	; offset 0x0f37
	push hl	; offset 0x0f38
	ld hl,65535	; offset 0x0f3b
	push hl	; offset 0x0f3c
	ld hl,57599	; offset 0x0f3f
	push hl	; offset 0x0f40
	ld hl,65535	; offset 0x0f43
	push hl	; offset 0x0f44
	ld hl,65535	; offset 0x0f47
	push hl	; offset 0x0f48
	ld hl,16344	; offset 0x0f4b
	push hl	; offset 0x0f4c

	; src_data blit 23
	ld sp,screenStartAddr+832	; offset 0x0f4f
	ld hl,19967	; offset 0x0f52
	push hl	; offset 0x0f53
	ld hl,65535	; offset 0x0f56
	push hl	; offset 0x0f57
	ld hl,65535	; offset 0x0f5a
	push hl	; offset 0x0f5b
	ld hl,65281	; offset 0x0f5e
	push hl	; offset 0x0f5f
	ld hl,65535	; offset 0x0f62
	push hl	; offset 0x0f63
	ld hl,65535	; offset 0x0f66
	push hl	; offset 0x0f67
	ld hl,65535	; offset 0x0f6a
	push hl	; offset 0x0f6b
	ld hl,65311	; offset 0x0f6e
	push hl	; offset 0x0f6f

	; src_data blit 24
	ld sp,screenStartAddr+1072	; offset 0x0f72
	ld hl,511	; offset 0x0f75
	push hl	; offset 0x0f76
	ld hl,65535	; offset 0x0f79
	push hl	; offset 0x0f7a
	ld hl,65535	; offset 0x0f7d
	push hl	; offset 0x0f7e
	ld hl,65535	; offset 0x0f81
	push hl	; offset 0x0f82
	ld hl,49407	; offset 0x0f85
	push hl	; offset 0x0f86
	ld hl,65535	; offset 0x0f89
	push hl	; offset 0x0f8a
	ld hl,65535	; offset 0x0f8d
	push hl	; offset 0x0f8e
	ld hl,24537	; offset 0x0f91
	push hl	; offset 0x0f92

	; src_data blit 25
	ld sp,screenStartAddr+1088	; offset 0x0f95
	ld hl,19967	; offset 0x0f98
	push hl	; offset 0x0f99
	ld hl,65535	; offset 0x0f9c
	push hl	; offset 0x0f9d
	ld hl,65535	; offset 0x0fa0
	push hl	; offset 0x0fa1
	ld hl,65280	; offset 0x0fa4
	push hl	; offset 0x0fa5
	ld hl,65535	; offset 0x0fa8
	push hl	; offset 0x0fa9
	ld hl,65535	; offset 0x0fac
	push hl	; offset 0x0fad
	ld hl,65535	; offset 0x0fb0
	push hl	; offset 0x0fb1
	ld hl,65295	; offset 0x0fb4
	push hl	; offset 0x0fb5

	; src_data blit 26
	ld sp,screenStartAddr+1328	; offset 0x0fb8
	ld hl,511	; offset 0x0fbb
	push hl	; offset 0x0fbc
	ld hl,65535	; offset 0x0fbf
	push hl	; offset 0x0fc0
	ld hl,65535	; offset 0x0fc3
	push hl	; offset 0x0fc4
	ld hl,65535	; offset 0x0fc7
	push hl	; offset 0x0fc8
	ld hl,33023	; offset 0x0fcb
	push hl	; offset 0x0fcc
	ld hl,65535	; offset 0x0fcf
	push hl	; offset 0x0fd0
	ld hl,65535	; offset 0x0fd3
	push hl	; offset 0x0fd4
	ld hl,8152	; offset 0x0fd7
	push hl	; offset 0x0fd8

	; attr draw 4
	ld sp,attr8and16vals+16
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,28792	; src 18
	ld de,32382	; src 20
	ld hl,32382	; src 22
	ld ix,28784	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,32382	; src 10
	ld de,30832	; src 12
	ld hl,30776	; src 0

	ld sp,attrStartAddr+16+128
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+128),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+128),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+128
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,28798	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+128
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14456	; src 30
	ld (attrStartAddr+30+128),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 4, offset 0x1031
	; Clock offset: -864


	; src_data blit 27
	ld sp,screenStartAddr+1344	; offset 0x1034
	ld hl,3583	; offset 0x1037
	push hl	; offset 0x1038
	ld hl,65535	; offset 0x103b
	push hl	; offset 0x103c
	ld hl,65535	; offset 0x103f
	push hl	; offset 0x1040
	ld hl,32512	; offset 0x1043
	push hl	; offset 0x1044
	ld hl,65535	; offset 0x1047
	push hl	; offset 0x1048
	ld hl,65535	; offset 0x104b
	push hl	; offset 0x104c
	ld hl,65535	; offset 0x104f
	push hl	; offset 0x1050
	ld hl,65295	; offset 0x1053
	push hl	; offset 0x1054

	; src_data blit 28
	ld sp,screenStartAddr+1584	; offset 0x1057
	ld hl,511	; offset 0x105a
	push hl	; offset 0x105b
	ld hl,65535	; offset 0x105e
	push hl	; offset 0x105f
	ld hl,65535	; offset 0x1062
	push hl	; offset 0x1063
	ld hl,65535	; offset 0x1066
	push hl	; offset 0x1067
	ld hl,255	; offset 0x106a
	push hl	; offset 0x106b
	ld hl,65535	; offset 0x106e
	push hl	; offset 0x106f
	ld hl,65535	; offset 0x1072
	push hl	; offset 0x1073
	ld hl,8153	; offset 0x1076
	push hl	; offset 0x1077

	; src_data blit 29
	ld sp,screenStartAddr+1600	; offset 0x107a
	ld hl,19967	; offset 0x107d
	push hl	; offset 0x107e
	ld hl,65535	; offset 0x1081
	push hl	; offset 0x1082
	ld hl,65535	; offset 0x1085
	push hl	; offset 0x1086
	ld hl,32512	; offset 0x1089
	push hl	; offset 0x108a
	ld hl,65535	; offset 0x108d
	push hl	; offset 0x108e
	ld hl,65535	; offset 0x1091
	push hl	; offset 0x1092
	ld hl,65535	; offset 0x1095
	push hl	; offset 0x1096
	ld hl,65287	; offset 0x1099
	push hl	; offset 0x109a

	; src_data blit 30
	ld sp,screenStartAddr+1840	; offset 0x109d
	ld hl,15871	; offset 0x10a0
	push hl	; offset 0x10a1
	ld hl,65535	; offset 0x10a4
	push hl	; offset 0x10a5
	ld hl,65535	; offset 0x10a8
	push hl	; offset 0x10a9
	ld hl,65535	; offset 0x10ac
	push hl	; offset 0x10ad
	ld hl,254	; offset 0x10b0
	push hl	; offset 0x10b1
	ld hl,65535	; offset 0x10b4
	push hl	; offset 0x10b5
	ld hl,65535	; offset 0x10b8
	push hl	; offset 0x10b9
	ld hl,8153	; offset 0x10bc
	push hl	; offset 0x10bd

	; src_data blit 31
	ld sp,screenStartAddr+1856	; offset 0x10c0
	ld hl,19967	; offset 0x10c3
	push hl	; offset 0x10c4
	ld hl,65535	; offset 0x10c7
	push hl	; offset 0x10c8
	ld hl,65535	; offset 0x10cb
	push hl	; offset 0x10cc
	ld hl,16128	; offset 0x10cf
	push hl	; offset 0x10d0
	ld hl,65535	; offset 0x10d3
	push hl	; offset 0x10d4
	ld hl,65535	; offset 0x10d7
	push hl	; offset 0x10d8
	ld hl,65535	; offset 0x10db
	push hl	; offset 0x10dc
	ld hl,32524	; offset 0x10df
	push hl	; offset 0x10e0

	; src_data blit 32
	ld sp,screenStartAddr+80	; offset 0x10e3
	ld hl,36608	; offset 0x10e6
	push hl	; offset 0x10e7
	ld hl,65535	; offset 0x10ea
	push hl	; offset 0x10eb
	ld hl,65535	; offset 0x10ee
	push hl	; offset 0x10ef
	ld hl,65535	; offset 0x10f2
	push hl	; offset 0x10f3
	ld hl,65532	; offset 0x10f6
	push hl	; offset 0x10f7
	ld hl,65535	; offset 0x10fa
	push hl	; offset 0x10fb
	ld hl,65535	; offset 0x10fe
	push hl	; offset 0x10ff
	ld hl,8153	; offset 0x1102
	push hl	; offset 0x1103

	; attr draw 5
	ld sp,attr8and16vals+20
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,32382	; src 20
	ld hl,32382	; src 22
	ld ix,32368	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,32382	; src 10
	ld de,30832	; src 12
	ld hl,30776	; src 0

	ld sp,attrStartAddr+16+160
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+160),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+160),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+160
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,28798	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+160
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14456	; src 30
	ld (attrStartAddr+30+160),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 5, offset 0x115c
	; Clock offset: -864


	; src_data blit 33
	ld sp,screenStartAddr+96	; offset 0x115f
	ld hl,19967	; offset 0x1162
	push hl	; offset 0x1163
	ld hl,65535	; offset 0x1166
	push hl	; offset 0x1167
	ld hl,65535	; offset 0x116a
	push hl	; offset 0x116b
	ld hl,8191	; offset 0x116e
	push hl	; offset 0x116f
	ld hl,65535	; offset 0x1172
	push hl	; offset 0x1173
	ld hl,65535	; offset 0x1176
	push hl	; offset 0x1177
	ld hl,65280	; offset 0x117a
	push hl	; offset 0x117b
	ld hl,8254	; offset 0x117e
	push hl	; offset 0x117f

	; src_data blit 34
	ld sp,screenStartAddr+336	; offset 0x1182
	ld hl,32514	; offset 0x1185
	push hl	; offset 0x1186
	ld hl,65535	; offset 0x1189
	push hl	; offset 0x118a
	ld hl,65535	; offset 0x118d
	push hl	; offset 0x118e
	ld hl,65535	; offset 0x1191
	push hl	; offset 0x1192
	ld hl,65528	; offset 0x1195
	push hl	; offset 0x1196
	ld hl,65535	; offset 0x1199
	push hl	; offset 0x119a
	ld hl,65535	; offset 0x119d
	push hl	; offset 0x119e
	ld hl,8153	; offset 0x11a1
	push hl	; offset 0x11a2

	; src_data blit 35
	ld sp,screenStartAddr+352	; offset 0x11a5
	ld hl,19967	; offset 0x11a8
	push hl	; offset 0x11a9
	ld hl,65535	; offset 0x11ac
	push hl	; offset 0x11ad
	ld hl,65535	; offset 0x11b0
	push hl	; offset 0x11b1
	ld hl,4095	; offset 0x11b4
	push hl	; offset 0x11b5
	ld hl,65535	; offset 0x11b8
	push hl	; offset 0x11b9
	ld hl,65535	; offset 0x11bc
	push hl	; offset 0x11bd
	ld hl,65280	; offset 0x11c0
	push hl	; offset 0x11c1
	ld hl,51263	; offset 0x11c4
	push hl	; offset 0x11c5

	; src_data blit 36
	ld sp,screenStartAddr+592	; offset 0x11c8
	ld hl,62217	; offset 0x11cb
	push hl	; offset 0x11cc
	ld hl,65535	; offset 0x11cf
	push hl	; offset 0x11d0
	ld hl,65535	; offset 0x11d3
	push hl	; offset 0x11d4
	ld hl,65535	; offset 0x11d7
	push hl	; offset 0x11d8
	ld hl,65520	; offset 0x11db
	push hl	; offset 0x11dc
	ld hl,65535	; offset 0x11df
	push hl	; offset 0x11e0
	ld hl,65535	; offset 0x11e3
	push hl	; offset 0x11e4
	ld hl,8153	; offset 0x11e7
	push hl	; offset 0x11e8

	; src_data blit 37
	ld sp,screenStartAddr+608	; offset 0x11eb
	ld hl,19967	; offset 0x11ee
	push hl	; offset 0x11ef
	ld hl,65535	; offset 0x11f2
	push hl	; offset 0x11f3
	ld hl,65535	; offset 0x11f6
	push hl	; offset 0x11f7
	ld hl,2047	; offset 0x11fa
	push hl	; offset 0x11fb
	ld hl,65535	; offset 0x11fe
	push hl	; offset 0x11ff
	ld hl,65535	; offset 0x1202
	push hl	; offset 0x1203
	ld hl,65280	; offset 0x1206
	push hl	; offset 0x1207
	ld hl,61497	; offset 0x120a
	push hl	; offset 0x120b

	; src_data blit 38
	ld sp,screenStartAddr+848	; offset 0x120e
	ld hl,57111	; offset 0x1211
	push hl	; offset 0x1212
	ld hl,65535	; offset 0x1215
	push hl	; offset 0x1216
	ld hl,65535	; offset 0x1219
	push hl	; offset 0x121a
	ld hl,65535	; offset 0x121d
	push hl	; offset 0x121e
	ld hl,65504	; offset 0x1221
	push hl	; offset 0x1222
	ld hl,65535	; offset 0x1225
	push hl	; offset 0x1226
	ld hl,65535	; offset 0x1229
	push hl	; offset 0x122a
	ld hl,8153	; offset 0x122d
	push hl	; offset 0x122e

	; attr draw 6
	ld sp,attr8and16vals+24
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,32376	; src 20
	ld hl,32382	; src 22
	ld ix,32368	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,28798	; src 10
	ld de,30840	; src 12
	ld hl,30776	; src 0

	ld sp,attrStartAddr+16+192
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+192),hl	; dest 0
	ld hl,28728	; src 2
	ld (attrStartAddr+2+192),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+192
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,32382	; src 26
	ld hl,14448	; src 28
	ld sp,attrStartAddr+30+192
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14456	; src 30
	ld (attrStartAddr+30+192),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 6, offset 0x1287
	; Clock offset: -864


	; src_data blit 39
	ld sp,screenStartAddr+864	; offset 0x128a
	ld hl,19967	; offset 0x128d
	push hl	; offset 0x128e
	ld hl,65535	; offset 0x1291
	push hl	; offset 0x1292
	ld hl,65535	; offset 0x1295
	push hl	; offset 0x1296
	ld hl,1023	; offset 0x1299
	push hl	; offset 0x129a
	ld hl,65535	; offset 0x129d
	push hl	; offset 0x129e
	ld hl,65535	; offset 0x12a1
	push hl	; offset 0x12a2
	ld hl,65280	; offset 0x12a5
	push hl	; offset 0x12a6
	ld hl,64831	; offset 0x12a9
	push hl	; offset 0x12aa

	; src_data blit 40
	ld sp,screenStartAddr+1104	; offset 0x12ad
	ld hl,25390	; offset 0x12b0
	push hl	; offset 0x12b1
	ld hl,65535	; offset 0x12b4
	push hl	; offset 0x12b5
	ld hl,65535	; offset 0x12b8
	push hl	; offset 0x12b9
	ld hl,65535	; offset 0x12bc
	push hl	; offset 0x12bd
	ld hl,65472	; offset 0x12c0
	push hl	; offset 0x12c1
	ld hl,65535	; offset 0x12c4
	push hl	; offset 0x12c5
	ld hl,65535	; offset 0x12c8
	push hl	; offset 0x12c9
	ld hl,8153	; offset 0x12cc
	push hl	; offset 0x12cd

	; src_data blit 41
	ld sp,screenStartAddr+1120	; offset 0x12d0
	ld hl,19967	; offset 0x12d3
	push hl	; offset 0x12d4
	ld hl,65535	; offset 0x12d7
	push hl	; offset 0x12d8
	ld hl,65535	; offset 0x12db
	push hl	; offset 0x12dc
	ld hl,511	; offset 0x12df
	push hl	; offset 0x12e0
	ld hl,65535	; offset 0x12e3
	push hl	; offset 0x12e4
	ld hl,65535	; offset 0x12e7
	push hl	; offset 0x12e8
	ld hl,65408	; offset 0x12eb
	push hl	; offset 0x12ec
	ld hl,56888	; offset 0x12ef
	push hl	; offset 0x12f0

	; src_data blit 42
	ld sp,screenStartAddr+1360	; offset 0x12f3
	ld hl,8188	; offset 0x12f6
	push hl	; offset 0x12f7
	ld hl,65279	; offset 0x12fa
	push hl	; offset 0x12fb
	ld hl,65535	; offset 0x12fe
	push hl	; offset 0x12ff
	ld hl,65535	; offset 0x1302
	push hl	; offset 0x1303
	ld hl,65408	; offset 0x1306
	push hl	; offset 0x1307
	ld hl,65535	; offset 0x130a
	push hl	; offset 0x130b
	ld hl,65535	; offset 0x130e
	push hl	; offset 0x130f
	ld hl,8153	; offset 0x1312
	push hl	; offset 0x1313

	; src_data blit 43
	ld sp,screenStartAddr+1376	; offset 0x1316
	ld hl,19967	; offset 0x1319
	push hl	; offset 0x131a
	ld hl,65535	; offset 0x131d
	push hl	; offset 0x131e
	ld hl,65535	; offset 0x1321
	push hl	; offset 0x1322
	ld hl,255	; offset 0x1325
	push hl	; offset 0x1326
	ld hl,65535	; offset 0x1329
	push hl	; offset 0x132a
	ld hl,65535	; offset 0x132d
	push hl	; offset 0x132e
	ld hl,65440	; offset 0x1331
	push hl	; offset 0x1332
	ld hl,1855	; offset 0x1335
	push hl	; offset 0x1336

	; src_data blit 44
	ld sp,screenStartAddr+1616	; offset 0x1339
	ld hl,65392	; offset 0x133c
	push hl	; offset 0x133d
	ld hl,64767	; offset 0x1340
	push hl	; offset 0x1341
	ld hl,65535	; offset 0x1344
	push hl	; offset 0x1345
	ld hl,65535	; offset 0x1348
	push hl	; offset 0x1349
	ld hl,65408	; offset 0x134c
	push hl	; offset 0x134d
	ld hl,65535	; offset 0x1350
	push hl	; offset 0x1351
	ld hl,65535	; offset 0x1354
	push hl	; offset 0x1355
	ld hl,8025	; offset 0x1358
	push hl	; offset 0x1359

	; attr draw 7
	ld sp,attr8and16vals+28
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,28792	; src 20
	ld hl,32382	; src 22
	ld ix,32382	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,28798	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+224
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+224),hl	; dest 0
	ld hl,28792	; src 2
	ld (attrStartAddr+2+224),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+224
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,32382	; src 26
	ld hl,14448	; src 28
	ld sp,attrStartAddr+30+224
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14456	; src 30
	ld (attrStartAddr+30+224),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 7, offset 0x13b2
	; Clock offset: -864


	; src_data blit 45
	ld sp,screenStartAddr+1632	; offset 0x13b5
	ld hl,19967	; offset 0x13b8
	push hl	; offset 0x13b9
	ld hl,65535	; offset 0x13bc
	push hl	; offset 0x13bd
	ld hl,65407	; offset 0x13c0
	push hl	; offset 0x13c1
	ld hl,255	; offset 0x13c4
	push hl	; offset 0x13c5
	ld hl,65535	; offset 0x13c8
	push hl	; offset 0x13c9
	ld hl,65535	; offset 0x13cc
	push hl	; offset 0x13cd
	ld hl,65520	; offset 0x13d0
	push hl	; offset 0x13d1
	ld hl,58175	; offset 0x13d4
	push hl	; offset 0x13d5

	; src_data blit 46
	ld sp,screenStartAddr+1872	; offset 0x13d8
	ld hl,65507	; offset 0x13db
	push hl	; offset 0x13dc
	ld hl,63743	; offset 0x13df
	push hl	; offset 0x13e0
	ld hl,65535	; offset 0x13e3
	push hl	; offset 0x13e4
	ld hl,65535	; offset 0x13e7
	push hl	; offset 0x13e8
	ld hl,65280	; offset 0x13eb
	push hl	; offset 0x13ec
	ld hl,65535	; offset 0x13ef
	push hl	; offset 0x13f0
	ld hl,65535	; offset 0x13f3
	push hl	; offset 0x13f4
	ld hl,7961	; offset 0x13f7
	push hl	; offset 0x13f8

	; src_data blit 47
	ld sp,screenStartAddr+1888	; offset 0x13fb
	ld hl,19711	; offset 0x13fe
	push hl	; offset 0x13ff
	ld hl,65535	; offset 0x1402
	push hl	; offset 0x1403
	ld hl,65343	; offset 0x1406
	push hl	; offset 0x1407
	ld hl,255	; offset 0x140a
	push hl	; offset 0x140b
	ld hl,65535	; offset 0x140e
	push hl	; offset 0x140f
	ld hl,65535	; offset 0x1412
	push hl	; offset 0x1413
	ld hl,65528	; offset 0x1416
	push hl	; offset 0x1417
	ld hl,63551	; offset 0x141a
	push hl	; offset 0x141b

	; src_data blit 48
	ld sp,screenStartAddr+112	; offset 0x141e
	ld hl,4038	; offset 0x1421
	push hl	; offset 0x1422
	ld hl,3328	; offset 0x1425
	push hl	; offset 0x1426
	ld hl,65535	; offset 0x1429
	push hl	; offset 0x142a
	ld hl,65535	; offset 0x142d
	push hl	; offset 0x142e
	ld hl,65535	; offset 0x1431
	push hl	; offset 0x1432
	ld hl,65279	; offset 0x1435
	push hl	; offset 0x1436
	ld hl,65535	; offset 0x1439
	push hl	; offset 0x143a
	ld hl,7961	; offset 0x143d
	push hl	; offset 0x143e

	; src_data blit 49
	ld sp,screenStartAddr+128	; offset 0x1441
	ld hl,19967	; offset 0x1444
	push hl	; offset 0x1445
	ld hl,65535	; offset 0x1448
	push hl	; offset 0x1449
	ld hl,65343	; offset 0x144c
	push hl	; offset 0x144d
	ld hl,65535	; offset 0x1450
	push hl	; offset 0x1451
	ld hl,65535	; offset 0x1454
	push hl	; offset 0x1455
	ld hl,65535	; offset 0x1458
	push hl	; offset 0x1459
	ld hl,112	; offset 0x145c
	push hl	; offset 0x145d
	ld hl,3134	; offset 0x1460
	push hl	; offset 0x1461

	; src_data blit 50
	ld sp,screenStartAddr+368	; offset 0x1464
	ld hl,2008	; offset 0x1467
	push hl	; offset 0x1468
	ld hl,15104	; offset 0x146b
	push hl	; offset 0x146c
	ld hl,65535	; offset 0x146f
	push hl	; offset 0x1470
	ld hl,65535	; offset 0x1473
	push hl	; offset 0x1474
	ld hl,65535	; offset 0x1477
	push hl	; offset 0x1478
	ld hl,65279	; offset 0x147b
	push hl	; offset 0x147c
	ld hl,65535	; offset 0x147f
	push hl	; offset 0x1480
	ld hl,7961	; offset 0x1483
	push hl	; offset 0x1484

	; attr draw 8
	ld sp,attr8and16vals+32
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,28728	; src 20
	ld hl,32382	; src 22
	ld ix,32382	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,14448	; src 10
	ld de,30776	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+256
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+256),hl	; dest 0
	ld hl,28792	; src 2
	ld (attrStartAddr+2+256),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+256
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,28798	; src 26
	ld hl,14448	; src 28
	ld sp,attrStartAddr+30+256
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+256),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 8, offset 0x14dd
	; Clock offset: -864


	; src_data blit 51
	ld sp,screenStartAddr+384	; offset 0x14e0
	ld hl,19967	; offset 0x14e3
	push hl	; offset 0x14e4
	ld hl,65535	; offset 0x14e7
	push hl	; offset 0x14e8
	ld hl,65311	; offset 0x14eb
	push hl	; offset 0x14ec
	ld hl,65535	; offset 0x14ef
	push hl	; offset 0x14f0
	ld hl,65535	; offset 0x14f3
	push hl	; offset 0x14f4
	ld hl,65535	; offset 0x14f7
	push hl	; offset 0x14f8
	ld hl,56	; offset 0x14fb
	push hl	; offset 0x14fc
	ld hl,828	; offset 0x14ff
	push hl	; offset 0x1500

	; src_data blit 52
	ld sp,screenStartAddr+624	; offset 0x1503
	ld hl,51361	; offset 0x1506
	push hl	; offset 0x1507
	ld hl,65280	; offset 0x150a
	push hl	; offset 0x150b
	ld hl,65535	; offset 0x150e
	push hl	; offset 0x150f
	ld hl,65535	; offset 0x1512
	push hl	; offset 0x1513
	ld hl,65535	; offset 0x1516
	push hl	; offset 0x1517
	ld hl,64767	; offset 0x151a
	push hl	; offset 0x151b
	ld hl,65535	; offset 0x151e
	push hl	; offset 0x151f
	ld hl,8089	; offset 0x1522
	push hl	; offset 0x1523

	; src_data blit 53
	ld sp,screenStartAddr+640	; offset 0x1526
	ld hl,19711	; offset 0x1529
	push hl	; offset 0x152a
	ld hl,65535	; offset 0x152d
	push hl	; offset 0x152e
	ld hl,65295	; offset 0x1531
	push hl	; offset 0x1532
	ld hl,65535	; offset 0x1535
	push hl	; offset 0x1536
	ld hl,65535	; offset 0x1539
	push hl	; offset 0x153a
	ld hl,65535	; offset 0x153d
	push hl	; offset 0x153e
	ld hl,154	; offset 0x1541
	push hl	; offset 0x1542
	ld hl,24622	; offset 0x1545
	push hl	; offset 0x1546

	; src_data blit 54
	ld sp,screenStartAddr+880	; offset 0x1549
	ld hl,34695	; offset 0x154c
	push hl	; offset 0x154d
	ld hl,63233	; offset 0x1550
	push hl	; offset 0x1551
	ld hl,65535	; offset 0x1554
	push hl	; offset 0x1555
	ld hl,65535	; offset 0x1558
	push hl	; offset 0x1559
	ld hl,65535	; offset 0x155c
	push hl	; offset 0x155d
	ld hl,63743	; offset 0x1560
	push hl	; offset 0x1561
	ld hl,65535	; offset 0x1564
	push hl	; offset 0x1565
	ld hl,8009	; offset 0x1568
	push hl	; offset 0x1569

	; src_data blit 55
	ld sp,screenStartAddr+896	; offset 0x156c
	ld hl,18943	; offset 0x156f
	push hl	; offset 0x1570
	ld hl,65535	; offset 0x1573
	push hl	; offset 0x1574
	ld hl,65287	; offset 0x1577
	push hl	; offset 0x1578
	ld hl,65535	; offset 0x157b
	push hl	; offset 0x157c
	ld hl,65535	; offset 0x157f
	push hl	; offset 0x1580
	ld hl,65535	; offset 0x1583
	push hl	; offset 0x1584
	ld hl,49245	; offset 0x1587
	push hl	; offset 0x1588
	ld hl,14396	; offset 0x158b
	push hl	; offset 0x158c

	; src_data blit 56
	ld sp,screenStartAddr+1136	; offset 0x158f
	ld hl,65288	; offset 0x1592
	push hl	; offset 0x1593
	ld hl,12035	; offset 0x1596
	push hl	; offset 0x1597
	ld hl,65535	; offset 0x159a
	push hl	; offset 0x159b
	ld hl,65535	; offset 0x159e
	push hl	; offset 0x159f
	ld hl,65535	; offset 0x15a2
	push hl	; offset 0x15a3
	ld hl,61695	; offset 0x15a6
	push hl	; offset 0x15a7
	ld hl,65535	; offset 0x15aa
	push hl	; offset 0x15ab
	ld hl,8017	; offset 0x15ae
	push hl	; offset 0x15af

	; attr draw 9
	ld sp,attr8and16vals+36
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,14392	; src 20
	ld hl,32368	; src 22
	ld ix,32368	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,14456	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+288
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+288),hl	; dest 0
	ld hl,28792	; src 2
	ld (attrStartAddr+2+288),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+288
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,28798	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+288
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+288),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 9, offset 0x1608
	; Clock offset: -864


	; src_data blit 57
	ld sp,screenStartAddr+1152	; offset 0x160b
	ld hl,20991	; offset 0x160e
	push hl	; offset 0x160f
	ld hl,65535	; offset 0x1612
	push hl	; offset 0x1613
	ld hl,65287	; offset 0x1616
	push hl	; offset 0x1617
	ld hl,65535	; offset 0x161a
	push hl	; offset 0x161b
	ld hl,65535	; offset 0x161e
	push hl	; offset 0x161f
	ld hl,65535	; offset 0x1622
	push hl	; offset 0x1623
	ld hl,61470	; offset 0x1626
	push hl	; offset 0x1627
	ld hl,58495	; offset 0x162a
	push hl	; offset 0x162b

	; src_data blit 58
	ld sp,screenStartAddr+1392	; offset 0x162e
	ld hl,65319	; offset 0x1631
	push hl	; offset 0x1632
	ld hl,48647	; offset 0x1635
	push hl	; offset 0x1636
	ld hl,65535	; offset 0x1639
	push hl	; offset 0x163a
	ld hl,65535	; offset 0x163d
	push hl	; offset 0x163e
	ld hl,65535	; offset 0x1641
	push hl	; offset 0x1642
	ld hl,57599	; offset 0x1645
	push hl	; offset 0x1646
	ld hl,65535	; offset 0x1649
	push hl	; offset 0x164a
	ld hl,8016	; offset 0x164d
	push hl	; offset 0x164e

	; src_data blit 59
	ld sp,screenStartAddr+1408	; offset 0x1651
	ld hl,4607	; offset 0x1654
	push hl	; offset 0x1655
	ld hl,65535	; offset 0x1658
	push hl	; offset 0x1659
	ld hl,65283	; offset 0x165c
	push hl	; offset 0x165d
	ld hl,65535	; offset 0x1660
	push hl	; offset 0x1661
	ld hl,65535	; offset 0x1664
	push hl	; offset 0x1665
	ld hl,65535	; offset 0x1668
	push hl	; offset 0x1669
	ld hl,63502	; offset 0x166c
	push hl	; offset 0x166d
	ld hl,63599	; offset 0x1670
	push hl	; offset 0x1671

	; src_data blit 60
	ld sp,screenStartAddr+1648	; offset 0x1674
	ld hl,48959	; offset 0x1677
	push hl	; offset 0x1678
	ld hl,56327	; offset 0x167b
	push hl	; offset 0x167c
	ld hl,65535	; offset 0x167f
	push hl	; offset 0x1680
	ld hl,65535	; offset 0x1683
	push hl	; offset 0x1684
	ld hl,65535	; offset 0x1687
	push hl	; offset 0x1688
	ld hl,57599	; offset 0x168b
	push hl	; offset 0x168c
	ld hl,65535	; offset 0x168f
	push hl	; offset 0x1690
	ld hl,8000	; offset 0x1693
	push hl	; offset 0x1694

	; src_data blit 61
	ld sp,screenStartAddr+1664	; offset 0x1697
	ld hl,4607	; offset 0x169a
	push hl	; offset 0x169b
	ld hl,65535	; offset 0x169e
	push hl	; offset 0x169f
	ld hl,65281	; offset 0x16a2
	push hl	; offset 0x16a3
	ld hl,65535	; offset 0x16a6
	push hl	; offset 0x16a7
	ld hl,65535	; offset 0x16aa
	push hl	; offset 0x16ab
	ld hl,65535	; offset 0x16ae
	push hl	; offset 0x16af
	ld hl,63495	; offset 0x16b2
	push hl	; offset 0x16b3
	ld hl,16255	; offset 0x16b6
	push hl	; offset 0x16b7

	; src_data blit 62
	ld sp,screenStartAddr+1904	; offset 0x16ba
	ld hl,65529	; offset 0x16bd
	push hl	; offset 0x16be
	ld hl,56327	; offset 0x16c1
	push hl	; offset 0x16c2
	ld hl,65535	; offset 0x16c5
	push hl	; offset 0x16c6
	ld hl,65535	; offset 0x16c9
	push hl	; offset 0x16ca
	ld hl,65535	; offset 0x16cd
	push hl	; offset 0x16ce
	ld hl,49407	; offset 0x16d1
	push hl	; offset 0x16d2
	ld hl,65535	; offset 0x16d5
	push hl	; offset 0x16d6
	ld hl,8128	; offset 0x16d9
	push hl	; offset 0x16da

	; attr draw 10
	ld sp,attr8and16vals+40
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,14456	; src 20
	ld hl,32376	; src 22
	ld ix,32368	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+320
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+320),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+320),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+320
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,30846	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+320
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+320),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 10, offset 0x1733
	; Clock offset: -864


	; src_data blit 63
	ld sp,screenStartAddr+1920	; offset 0x1736
	ld hl,1535	; offset 0x1739
	push hl	; offset 0x173a
	ld hl,65535	; offset 0x173d
	push hl	; offset 0x173e
	ld hl,65281	; offset 0x1741
	push hl	; offset 0x1742
	ld hl,65535	; offset 0x1745
	push hl	; offset 0x1746
	ld hl,65535	; offset 0x1749
	push hl	; offset 0x174a
	ld hl,65535	; offset 0x174d
	push hl	; offset 0x174e
	ld hl,63687	; offset 0x1751
	push hl	; offset 0x1752
	ld hl,63359	; offset 0x1755
	push hl	; offset 0x1756

	; src_data blit 64
	ld sp,screenStartAddr+144	; offset 0x1759
	ld hl,65519	; offset 0x175c
	push hl	; offset 0x175d
	ld hl,63759	; offset 0x1760
	push hl	; offset 0x1761
	ld hl,65535	; offset 0x1764
	push hl	; offset 0x1765
	ld hl,65535	; offset 0x1768
	push hl	; offset 0x1769
	ld hl,65535	; offset 0x176c
	push hl	; offset 0x176d
	ld hl,33023	; offset 0x1770
	push hl	; offset 0x1771
	ld hl,65535	; offset 0x1774
	push hl	; offset 0x1775
	ld hl,8136	; offset 0x1778
	push hl	; offset 0x1779

	; src_data blit 65
	ld sp,screenStartAddr+160	; offset 0x177c
	ld hl,3580	; offset 0x177f
	push hl	; offset 0x1780
	ld hl,65535	; offset 0x1783
	push hl	; offset 0x1784
	ld hl,65535	; offset 0x1787
	push hl	; offset 0x1788
	ld hl,65535	; offset 0x178b
	push hl	; offset 0x178c
	ld hl,65535	; offset 0x178f
	push hl	; offset 0x1790
	ld hl,65535	; offset 0x1793
	push hl	; offset 0x1794
	ld hl,47351	; offset 0x1797
	push hl	; offset 0x1798
	ld hl,65151	; offset 0x179b
	push hl	; offset 0x179c

	; src_data blit 66
	ld sp,screenStartAddr+400	; offset 0x179f
	ld hl,65471	; offset 0x17a2
	push hl	; offset 0x17a3
	ld hl,46855	; offset 0x17a6
	push hl	; offset 0x17a7
	ld hl,65535	; offset 0x17aa
	push hl	; offset 0x17ab
	ld hl,65535	; offset 0x17ae
	push hl	; offset 0x17af
	ld hl,65535	; offset 0x17b2
	push hl	; offset 0x17b3
	ld hl,33023	; offset 0x17b6
	push hl	; offset 0x17b7
	ld hl,65535	; offset 0x17ba
	push hl	; offset 0x17bb
	ld hl,2009	; offset 0x17be
	push hl	; offset 0x17bf

	; src_data blit 67
	ld sp,screenStartAddr+416	; offset 0x17c2
	ld hl,28153	; offset 0x17c5
	push hl	; offset 0x17c6
	ld hl,65535	; offset 0x17c9
	push hl	; offset 0x17ca
	ld hl,32767	; offset 0x17cd
	push hl	; offset 0x17ce
	ld hl,65535	; offset 0x17d1
	push hl	; offset 0x17d2
	ld hl,65535	; offset 0x17d5
	push hl	; offset 0x17d6
	ld hl,65535	; offset 0x17d9
	push hl	; offset 0x17da
	ld hl,47291	; offset 0x17dd
	push hl	; offset 0x17de
	ld hl,65407	; offset 0x17e1
	push hl	; offset 0x17e2

	; src_data blit 68
	ld sp,screenStartAddr+656	; offset 0x17e5
	ld hl,16376	; offset 0x17e8
	push hl	; offset 0x17e9
	ld hl,44551	; offset 0x17ec
	push hl	; offset 0x17ed
	ld hl,65535	; offset 0x17f0
	push hl	; offset 0x17f1
	ld hl,65535	; offset 0x17f4
	push hl	; offset 0x17f5
	ld hl,65535	; offset 0x17f8
	push hl	; offset 0x17f9
	ld hl,255	; offset 0x17fc
	push hl	; offset 0x17fd
	ld hl,65535	; offset 0x1800
	push hl	; offset 0x1801
	ld hl,2009	; offset 0x1804
	push hl	; offset 0x1805

	; attr draw 11
	ld sp,attr8and16vals+44
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,28728	; src 22
	ld ix,28792	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,30776	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+352
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+352),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+352),hl	; dest 2
	ld hl,14392	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+352
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,32382	; src 24
	ld de,30846	; src 26
	ld hl,30776	; src 28
	ld sp,attrStartAddr+30+352
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+352),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 11, offset 0x185e
	; Clock offset: -864


	; src_data blit 69
	ld sp,screenStartAddr+672	; offset 0x1861
	ld hl,28155	; offset 0x1864
	push hl	; offset 0x1865
	ld hl,65535	; offset 0x1868
	push hl	; offset 0x1869
	ld hl,32767	; offset 0x186c
	push hl	; offset 0x186d
	ld hl,65535	; offset 0x1870
	push hl	; offset 0x1871
	ld hl,65535	; offset 0x1874
	push hl	; offset 0x1875
	ld hl,65535	; offset 0x1878
	push hl	; offset 0x1879
	ld hl,47325	; offset 0x187c
	push hl	; offset 0x187d
	ld hl,33663	; offset 0x1880
	push hl	; offset 0x1881

	; src_data blit 70
	ld sp,screenStartAddr+912	; offset 0x1884
	ld hl,8176	; offset 0x1887
	push hl	; offset 0x1888
	ld hl,56583	; offset 0x188b
	push hl	; offset 0x188c
	ld hl,65535	; offset 0x188f
	push hl	; offset 0x1890
	ld hl,65535	; offset 0x1893
	push hl	; offset 0x1894
	ld hl,65535	; offset 0x1897
	push hl	; offset 0x1898
	ld hl,255	; offset 0x189b
	push hl	; offset 0x189c
	ld hl,65535	; offset 0x189f
	push hl	; offset 0x18a0
	ld hl,2009	; offset 0x18a3
	push hl	; offset 0x18a4

	; src_data blit 71
	ld sp,screenStartAddr+928	; offset 0x18a7
	ld hl,28155	; offset 0x18aa
	push hl	; offset 0x18ab
	ld hl,65535	; offset 0x18ae
	push hl	; offset 0x18af
	ld hl,16383	; offset 0x18b2
	push hl	; offset 0x18b3
	ld hl,65535	; offset 0x18b6
	push hl	; offset 0x18b7
	ld hl,65535	; offset 0x18ba
	push hl	; offset 0x18bb
	ld hl,65535	; offset 0x18be
	push hl	; offset 0x18bf
	ld hl,63735	; offset 0x18c2
	push hl	; offset 0x18c3
	ld hl,383	; offset 0x18c6
	push hl	; offset 0x18c7

	; src_data blit 72
	ld sp,screenStartAddr+1168	; offset 0x18ca
	ld hl,4064	; offset 0x18cd
	push hl	; offset 0x18ce
	ld hl,47887	; offset 0x18d1
	push hl	; offset 0x18d2
	ld hl,65535	; offset 0x18d5
	push hl	; offset 0x18d6
	ld hl,65535	; offset 0x18d9
	push hl	; offset 0x18da
	ld hl,65535	; offset 0x18dd
	push hl	; offset 0x18de
	ld hl,254	; offset 0x18e1
	push hl	; offset 0x18e2
	ld hl,65535	; offset 0x18e5
	push hl	; offset 0x18e6
	ld hl,2009	; offset 0x18e9
	push hl	; offset 0x18ea

	; src_data blit 73
	ld sp,screenStartAddr+1184	; offset 0x18ed
	ld hl,28153	; offset 0x18f0
	push hl	; offset 0x18f1
	ld hl,65535	; offset 0x18f4
	push hl	; offset 0x18f5
	ld hl,8191	; offset 0x18f8
	push hl	; offset 0x18f9
	ld hl,65535	; offset 0x18fc
	push hl	; offset 0x18fd
	ld hl,65535	; offset 0x1900
	push hl	; offset 0x1901
	ld hl,65535	; offset 0x1904
	push hl	; offset 0x1905
	ld hl,47355	; offset 0x1908
	push hl	; offset 0x1909
	ld hl,126	; offset 0x190c
	push hl	; offset 0x190d

	; src_data blit 74
	ld sp,screenStartAddr+1424	; offset 0x1910
	ld hl,4064	; offset 0x1913
	push hl	; offset 0x1914
	ld hl,62735	; offset 0x1917
	push hl	; offset 0x1918
	ld hl,65535	; offset 0x191b
	push hl	; offset 0x191c
	ld hl,65535	; offset 0x191f
	push hl	; offset 0x1920
	ld hl,65535	; offset 0x1923
	push hl	; offset 0x1924
	ld hl,254	; offset 0x1927
	push hl	; offset 0x1928
	ld hl,65535	; offset 0x192b
	push hl	; offset 0x192c
	ld hl,10201	; offset 0x192f
	push hl	; offset 0x1930

	; attr draw 12
	ld sp,attr8and16vals+48
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,30768	; src 20
	ld hl,28728	; src 22
	ld ix,28792	; src 4
	ld iy,32382	; src 6
	exx
	ld bc,28728	; src 10
	ld de,14384	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+384
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+384),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+384),hl	; dest 2
	ld hl,14392	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+384
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,28798	; src 24
	ld de,30846	; src 26
	ld hl,30776	; src 28
	ld sp,attrStartAddr+30+384
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+384),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 12, offset 0x1989
	; Clock offset: -864


	; src_data blit 75
	ld sp,screenStartAddr+1440	; offset 0x198c
	ld hl,28155	; offset 0x198f
	push hl	; offset 0x1990
	ld hl,65535	; offset 0x1993
	push hl	; offset 0x1994
	ld hl,8191	; offset 0x1997
	push hl	; offset 0x1998
	ld hl,65535	; offset 0x199b
	push hl	; offset 0x199c
	ld hl,65535	; offset 0x199f
	push hl	; offset 0x19a0
	ld hl,65535	; offset 0x19a3
	push hl	; offset 0x19a4
	ld hl,48381	; offset 0x19a7
	push hl	; offset 0x19a8
	ld hl,126	; offset 0x19ab
	push hl	; offset 0x19ac

	; src_data blit 76
	ld sp,screenStartAddr+1680	; offset 0x19af
	ld hl,4064	; offset 0x19b2
	push hl	; offset 0x19b3
	ld hl,26383	; offset 0x19b6
	push hl	; offset 0x19b7
	ld hl,65535	; offset 0x19ba
	push hl	; offset 0x19bb
	ld hl,65535	; offset 0x19be
	push hl	; offset 0x19bf
	ld hl,65535	; offset 0x19c2
	push hl	; offset 0x19c3
	ld hl,252	; offset 0x19c6
	push hl	; offset 0x19c7
	ld hl,65535	; offset 0x19ca
	push hl	; offset 0x19cb
	ld hl,2009	; offset 0x19ce
	push hl	; offset 0x19cf

	; src_data blit 77
	ld sp,screenStartAddr+1696	; offset 0x19d2
	ld hl,28154	; offset 0x19d5
	push hl	; offset 0x19d6
	ld hl,65535	; offset 0x19d9
	push hl	; offset 0x19da
	ld hl,4095	; offset 0x19dd
	push hl	; offset 0x19de
	ld hl,65535	; offset 0x19e1
	push hl	; offset 0x19e2
	ld hl,65535	; offset 0x19e5
	push hl	; offset 0x19e6
	ld hl,65535	; offset 0x19e9
	push hl	; offset 0x19ea
	ld hl,56573	; offset 0x19ed
	push hl	; offset 0x19ee
	ld hl,126	; offset 0x19f1
	push hl	; offset 0x19f2

	; src_data blit 78
	ld sp,screenStartAddr+1936	; offset 0x19f5
	ld hl,4064	; offset 0x19f8
	push hl	; offset 0x19f9
	ld hl,60175	; offset 0x19fc
	push hl	; offset 0x19fd
	ld hl,65535	; offset 0x1a00
	push hl	; offset 0x1a01
	ld hl,65535	; offset 0x1a04
	push hl	; offset 0x1a05
	ld hl,65535	; offset 0x1a08
	push hl	; offset 0x1a09
	ld hl,252	; offset 0x1a0c
	push hl	; offset 0x1a0d
	ld hl,65535	; offset 0x1a10
	push hl	; offset 0x1a11
	ld hl,10201	; offset 0x1a14
	push hl	; offset 0x1a15

	; src_data blit 79
	ld sp,screenStartAddr+1952	; offset 0x1a18
	ld hl,28154	; offset 0x1a1b
	push hl	; offset 0x1a1c
	ld hl,65535	; offset 0x1a1f
	push hl	; offset 0x1a20
	ld hl,4095	; offset 0x1a23
	push hl	; offset 0x1a24
	ld hl,65535	; offset 0x1a27
	push hl	; offset 0x1a28
	ld hl,65535	; offset 0x1a2b
	push hl	; offset 0x1a2c
	ld hl,65535	; offset 0x1a2f
	push hl	; offset 0x1a30
	ld hl,61178	; offset 0x1a33
	push hl	; offset 0x1a34
	ld hl,126	; offset 0x1a37
	push hl	; offset 0x1a38

	; src_data blit 80
	ld sp,screenStartAddr+176	; offset 0x1a3b
	ld hl,8160	; offset 0x1a3e
	push hl	; offset 0x1a3f
	ld hl,60171	; offset 0x1a42
	push hl	; offset 0x1a43
	ld hl,65535	; offset 0x1a46
	push hl	; offset 0x1a47
	ld hl,65535	; offset 0x1a4a
	push hl	; offset 0x1a4b
	ld hl,65535	; offset 0x1a4e
	push hl	; offset 0x1a4f
	ld hl,65528	; offset 0x1a52
	push hl	; offset 0x1a53
	ld hl,65535	; offset 0x1a56
	push hl	; offset 0x1a57
	ld hl,10201	; offset 0x1a5a
	push hl	; offset 0x1a5b

	; attr draw 13
	ld sp,attr8and16vals+52
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30776	; src 18
	ld de,28734	; src 20
	ld hl,28728	; src 22
	ld ix,28792	; src 4
	ld iy,28784	; src 6
	exx
	ld bc,12344	; src 10
	ld de,14384	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+416
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+416),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+416),hl	; dest 2
	ld hl,14456	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+416
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,28784	; src 24
	ld de,30832	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+416
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+416),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 13, offset 0x1ab4
	; Clock offset: -864


	; src_data blit 81
	ld sp,screenStartAddr+192	; offset 0x1ab7
	ld hl,28154	; offset 0x1aba
	push hl	; offset 0x1abb
	ld hl,65535	; offset 0x1abe
	push hl	; offset 0x1abf
	ld hl,2047	; offset 0x1ac2
	push hl	; offset 0x1ac3
	ld hl,65535	; offset 0x1ac6
	push hl	; offset 0x1ac7
	ld hl,65535	; offset 0x1aca
	push hl	; offset 0x1acb
	ld hl,65535	; offset 0x1ace
	push hl	; offset 0x1acf
	ld hl,59903	; offset 0x1ad2
	push hl	; offset 0x1ad3
	ld hl,127	; offset 0x1ad6
	push hl	; offset 0x1ad7

	; src_data blit 82
	ld sp,screenStartAddr+432	; offset 0x1ada
	ld hl,16368	; offset 0x1add
	push hl	; offset 0x1ade
	ld hl,61965	; offset 0x1ae1
	push hl	; offset 0x1ae2
	ld hl,65535	; offset 0x1ae5
	push hl	; offset 0x1ae6
	ld hl,65535	; offset 0x1ae9
	push hl	; offset 0x1aea
	ld hl,65535	; offset 0x1aed
	push hl	; offset 0x1aee
	ld hl,65528	; offset 0x1af1
	push hl	; offset 0x1af2
	ld hl,65535	; offset 0x1af5
	push hl	; offset 0x1af6
	ld hl,10201	; offset 0x1af9
	push hl	; offset 0x1afa

	; src_data blit 83
	ld sp,screenStartAddr+448	; offset 0x1afd
	ld hl,28154	; offset 0x1b00
	push hl	; offset 0x1b01
	ld hl,65535	; offset 0x1b04
	push hl	; offset 0x1b05
	ld hl,2047	; offset 0x1b08
	push hl	; offset 0x1b09
	ld hl,65535	; offset 0x1b0c
	push hl	; offset 0x1b0d
	ld hl,65535	; offset 0x1b10
	push hl	; offset 0x1b11
	ld hl,65535	; offset 0x1b14
	push hl	; offset 0x1b15
	ld hl,63743	; offset 0x1b18
	push hl	; offset 0x1b19
	ld hl,33151	; offset 0x1b1c
	push hl	; offset 0x1b1d

	; src_data blit 84
	ld sp,screenStartAddr+688	; offset 0x1b20
	ld hl,32760	; offset 0x1b23
	push hl	; offset 0x1b24
	ld hl,30479	; offset 0x1b27
	push hl	; offset 0x1b28
	ld hl,65535	; offset 0x1b2b
	push hl	; offset 0x1b2c
	ld hl,65535	; offset 0x1b2f
	push hl	; offset 0x1b30
	ld hl,65535	; offset 0x1b33
	push hl	; offset 0x1b34
	ld hl,65520	; offset 0x1b37
	push hl	; offset 0x1b38
	ld hl,65535	; offset 0x1b3b
	push hl	; offset 0x1b3c
	ld hl,10201	; offset 0x1b3f
	push hl	; offset 0x1b40

	; src_data blit 85
	ld sp,screenStartAddr+704	; offset 0x1b43
	ld hl,28154	; offset 0x1b46
	push hl	; offset 0x1b47
	ld hl,65535	; offset 0x1b4a
	push hl	; offset 0x1b4b
	ld hl,1023	; offset 0x1b4e
	push hl	; offset 0x1b4f
	ld hl,65535	; offset 0x1b52
	push hl	; offset 0x1b53
	ld hl,65535	; offset 0x1b56
	push hl	; offset 0x1b57
	ld hl,65535	; offset 0x1b5a
	push hl	; offset 0x1b5b
	ld hl,53501	; offset 0x1b5e
	push hl	; offset 0x1b5f
	ld hl,58239	; offset 0x1b62
	push hl	; offset 0x1b63

	; src_data blit 86
	ld sp,screenStartAddr+944	; offset 0x1b66
	ld hl,65535	; offset 0x1b69
	push hl	; offset 0x1b6a
	ld hl,38685	; offset 0x1b6d
	push hl	; offset 0x1b6e
	ld hl,65535	; offset 0x1b71
	push hl	; offset 0x1b72
	ld hl,65535	; offset 0x1b75
	push hl	; offset 0x1b76
	ld hl,65535	; offset 0x1b79
	push hl	; offset 0x1b7a
	ld hl,65520	; offset 0x1b7d
	push hl	; offset 0x1b7e
	ld hl,65535	; offset 0x1b81
	push hl	; offset 0x1b82
	ld hl,10073	; offset 0x1b85
	push hl	; offset 0x1b86

	; attr draw 14
	ld sp,attr8and16vals+56
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30776	; src 18
	ld de,28734	; src 20
	ld hl,28784	; src 22
	ld ix,30840	; src 4
	ld iy,28792	; src 6
	exx
	ld bc,12344	; src 10
	ld de,14384	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+448
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+448),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+448),hl	; dest 2
	ld hl,14392	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+448
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,30832	; src 24
	ld de,30840	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+448
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+448),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 14, offset 0x1bdf
	; Clock offset: -864


	; src_data blit 87
	ld sp,screenStartAddr+960	; offset 0x1be2
	ld hl,28154	; offset 0x1be5
	push hl	; offset 0x1be6
	ld hl,65535	; offset 0x1be9
	push hl	; offset 0x1bea
	ld hl,1023	; offset 0x1bed
	push hl	; offset 0x1bee
	ld hl,65535	; offset 0x1bf1
	push hl	; offset 0x1bf2
	ld hl,65535	; offset 0x1bf5
	push hl	; offset 0x1bf6
	ld hl,65535	; offset 0x1bf9
	push hl	; offset 0x1bfa
	ld hl,14077	; offset 0x1bfd
	push hl	; offset 0x1bfe
	ld hl,65407	; offset 0x1c01
	push hl	; offset 0x1c02

	; src_data blit 88
	ld sp,screenStartAddr+1200	; offset 0x1c05
	ld hl,65535	; offset 0x1c08
	push hl	; offset 0x1c09
	ld hl,38685	; offset 0x1c0c
	push hl	; offset 0x1c0d
	ld hl,65535	; offset 0x1c10
	push hl	; offset 0x1c11
	ld hl,65535	; offset 0x1c14
	push hl	; offset 0x1c15
	ld hl,65535	; offset 0x1c18
	push hl	; offset 0x1c19
	ld hl,65504	; offset 0x1c1c
	push hl	; offset 0x1c1d
	ld hl,65535	; offset 0x1c20
	push hl	; offset 0x1c21
	ld hl,10009	; offset 0x1c24
	push hl	; offset 0x1c25

	; src_data blit 89
	ld sp,screenStartAddr+1216	; offset 0x1c28
	ld hl,28154	; offset 0x1c2b
	push hl	; offset 0x1c2c
	ld hl,65535	; offset 0x1c2f
	push hl	; offset 0x1c30
	ld hl,1023	; offset 0x1c33
	push hl	; offset 0x1c34
	ld hl,65535	; offset 0x1c37
	push hl	; offset 0x1c38
	ld hl,65535	; offset 0x1c3b
	push hl	; offset 0x1c3c
	ld hl,65535	; offset 0x1c3f
	push hl	; offset 0x1c40
	ld hl,14077	; offset 0x1c43
	push hl	; offset 0x1c44
	ld hl,65407	; offset 0x1c47
	push hl	; offset 0x1c48

	; src_data blit 90
	ld sp,screenStartAddr+1456	; offset 0x1c4b
	ld hl,65535	; offset 0x1c4e
	push hl	; offset 0x1c4f
	ld hl,36667	; offset 0x1c52
	push hl	; offset 0x1c53
	ld hl,65535	; offset 0x1c56
	push hl	; offset 0x1c57
	ld hl,65535	; offset 0x1c5a
	push hl	; offset 0x1c5b
	ld hl,65535	; offset 0x1c5e
	push hl	; offset 0x1c5f
	ld hl,65504	; offset 0x1c62
	push hl	; offset 0x1c63
	ld hl,65535	; offset 0x1c66
	push hl	; offset 0x1c67
	ld hl,10085	; offset 0x1c6a
	push hl	; offset 0x1c6b

	; src_data blit 91
	ld sp,screenStartAddr+1472	; offset 0x1c6e
	ld hl,25082	; offset 0x1c71
	push hl	; offset 0x1c72
	ld hl,65535	; offset 0x1c75
	push hl	; offset 0x1c76
	ld hl,511	; offset 0x1c79
	push hl	; offset 0x1c7a
	ld hl,65535	; offset 0x1c7d
	push hl	; offset 0x1c7e
	ld hl,65535	; offset 0x1c81
	push hl	; offset 0x1c82
	ld hl,65535	; offset 0x1c85
	push hl	; offset 0x1c86
	ld hl,47613	; offset 0x1c89
	push hl	; offset 0x1c8a
	ld hl,65407	; offset 0x1c8d
	push hl	; offset 0x1c8e

	; src_data blit 92
	ld sp,screenStartAddr+1712	; offset 0x1c91
	ld hl,65535	; offset 0x1c94
	push hl	; offset 0x1c95
	ld hl,3899	; offset 0x1c98
	push hl	; offset 0x1c99
	ld hl,65535	; offset 0x1c9c
	push hl	; offset 0x1c9d
	ld hl,65535	; offset 0x1ca0
	push hl	; offset 0x1ca1
	ld hl,65535	; offset 0x1ca4
	push hl	; offset 0x1ca5
	ld hl,65472	; offset 0x1ca8
	push hl	; offset 0x1ca9
	ld hl,65535	; offset 0x1cac
	push hl	; offset 0x1cad
	ld hl,42820	; offset 0x1cb0
	push hl	; offset 0x1cb1

	; attr draw 15
	ld sp,attr8and16vals+60
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,12344	; src 18
	ld de,12350	; src 20
	ld hl,28784	; src 22
	ld ix,14392	; src 4
	ld iy,30776	; src 6
	exx
	ld bc,12408	; src 10
	ld de,14384	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+480
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+480),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+480),hl	; dest 2
	ld hl,12344	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+480
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,14456	; src 24
	ld de,14392	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+480
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+480),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 15, offset 0x1d0a
	; Clock offset: -864


	; src_data blit 93
	ld sp,screenStartAddr+1728	; offset 0x1d0d
	ld hl,506	; offset 0x1d10
	push hl	; offset 0x1d11
	ld hl,65535	; offset 0x1d14
	push hl	; offset 0x1d15
	ld hl,511	; offset 0x1d18
	push hl	; offset 0x1d19
	ld hl,65535	; offset 0x1d1c
	push hl	; offset 0x1d1d
	ld hl,65535	; offset 0x1d20
	push hl	; offset 0x1d21
	ld hl,65535	; offset 0x1d24
	push hl	; offset 0x1d25
	ld hl,39165	; offset 0x1d28
	push hl	; offset 0x1d29
	ld hl,65407	; offset 0x1d2c
	push hl	; offset 0x1d2d

	; src_data blit 94
	ld sp,screenStartAddr+1968	; offset 0x1d30
	ld hl,32760	; offset 0x1d33
	push hl	; offset 0x1d34
	ld hl,12159	; offset 0x1d37
	push hl	; offset 0x1d38
	ld hl,65535	; offset 0x1d3b
	push hl	; offset 0x1d3c
	ld hl,65535	; offset 0x1d3f
	push hl	; offset 0x1d40
	ld hl,65535	; offset 0x1d43
	push hl	; offset 0x1d44
	ld hl,65472	; offset 0x1d47
	push hl	; offset 0x1d48
	ld hl,65535	; offset 0x1d4b
	push hl	; offset 0x1d4c
	ld hl,42754	; offset 0x1d4f
	push hl	; offset 0x1d50

	; src_data blit 95
	ld sp,screenStartAddr+1984	; offset 0x1d53
	ld hl,8442	; offset 0x1d56
	push hl	; offset 0x1d57
	ld hl,65535	; offset 0x1d5a
	push hl	; offset 0x1d5b
	ld hl,255	; offset 0x1d5e
	push hl	; offset 0x1d5f
	ld hl,65535	; offset 0x1d62
	push hl	; offset 0x1d63
	ld hl,65535	; offset 0x1d66
	push hl	; offset 0x1d67
	ld hl,65407	; offset 0x1d6a
	push hl	; offset 0x1d6b
	ld hl,40191	; offset 0x1d6e
	push hl	; offset 0x1d6f
	ld hl,50047	; offset 0x1d72
	push hl	; offset 0x1d73

	; src_data blit 96
	ld sp,screenStartAddr+208	; offset 0x1d76
	ld hl,16368	; offset 0x1d79
	push hl	; offset 0x1d7a
	ld hl,3859	; offset 0x1d7d
	push hl	; offset 0x1d7e
	ld hl,255	; offset 0x1d81
	push hl	; offset 0x1d82
	ld hl,65535	; offset 0x1d85
	push hl	; offset 0x1d86
	ld hl,65535	; offset 0x1d89
	push hl	; offset 0x1d8a
	ld hl,65408	; offset 0x1d8d
	push hl	; offset 0x1d8e
	ld hl,65535	; offset 0x1d91
	push hl	; offset 0x1d92
	ld hl,34624	; offset 0x1d95
	push hl	; offset 0x1d96

	; src_data blit 97
	ld sp,screenStartAddr+224	; offset 0x1d99
	ld hl,504	; offset 0x1d9c
	push hl	; offset 0x1d9d
	ld hl,65535	; offset 0x1da0
	push hl	; offset 0x1da1
	ld hl,65535	; offset 0x1da4
	push hl	; offset 0x1da5
	ld hl,65535	; offset 0x1da8
	push hl	; offset 0x1da9
	ld hl,65535	; offset 0x1dac
	push hl	; offset 0x1dad
	ld hl,65311	; offset 0x1db0
	push hl	; offset 0x1db1
	ld hl,6655	; offset 0x1db4
	push hl	; offset 0x1db5
	ld hl,33151	; offset 0x1db8
	push hl	; offset 0x1db9

	; src_data blit 98
	ld sp,screenStartAddr+464	; offset 0x1dbc
	ld hl,8160	; offset 0x1dbf
	push hl	; offset 0x1dc0
	ld hl,12191	; offset 0x1dc3
	push hl	; offset 0x1dc4
	ld hl,511	; offset 0x1dc7
	push hl	; offset 0x1dc8
	ld hl,65535	; offset 0x1dcb
	push hl	; offset 0x1dcc
	ld hl,65535	; offset 0x1dcf
	push hl	; offset 0x1dd0
	ld hl,65408	; offset 0x1dd3
	push hl	; offset 0x1dd4
	ld hl,65535	; offset 0x1dd7
	push hl	; offset 0x1dd8
	ld hl,2008	; offset 0x1ddb
	push hl	; offset 0x1ddc

	; attr draw 16
	ld sp,attr8and16vals+64
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,12344	; src 18
	ld de,12350	; src 20
	ld hl,32368	; src 22
	ld ix,14392	; src 4
	ld iy,30776	; src 6
	exx
	ld bc,12408	; src 10
	ld de,14384	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+512
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+512),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+512),hl	; dest 2
	ld hl,12344	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+512
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,14456	; src 24
	ld de,14392	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+512
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+512),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 16, offset 0x1e35
	; Clock offset: -864


	; src_data blit 99
	ld sp,screenStartAddr+480	; offset 0x1e38
	ld hl,1528	; offset 0x1e3b
	push hl	; offset 0x1e3c
	ld hl,65535	; offset 0x1e3f
	push hl	; offset 0x1e40
	ld hl,65535	; offset 0x1e43
	push hl	; offset 0x1e44
	ld hl,65535	; offset 0x1e47
	push hl	; offset 0x1e48
	ld hl,65535	; offset 0x1e4b
	push hl	; offset 0x1e4c
	ld hl,65295	; offset 0x1e4f
	push hl	; offset 0x1e50
	ld hl,8191	; offset 0x1e53
	push hl	; offset 0x1e54
	ld hl,127	; offset 0x1e57
	push hl	; offset 0x1e58

	; src_data blit 100
	ld sp,screenStartAddr+720	; offset 0x1e5b
	ld hl,8128	; offset 0x1e5e
	push hl	; offset 0x1e5f
	ld hl,12183	; offset 0x1e62
	push hl	; offset 0x1e63
	ld hl,1023	; offset 0x1e66
	push hl	; offset 0x1e67
	ld hl,65535	; offset 0x1e6a
	push hl	; offset 0x1e6b
	ld hl,65535	; offset 0x1e6e
	push hl	; offset 0x1e6f
	ld hl,65408	; offset 0x1e72
	push hl	; offset 0x1e73
	ld hl,65535	; offset 0x1e76
	push hl	; offset 0x1e77
	ld hl,2011	; offset 0x1e7a
	push hl	; offset 0x1e7b

	; src_data blit 101
	ld sp,screenStartAddr+736	; offset 0x1e7e
	ld hl,3576	; offset 0x1e81
	push hl	; offset 0x1e82
	ld hl,65407	; offset 0x1e85
	push hl	; offset 0x1e86
	ld hl,65535	; offset 0x1e89
	push hl	; offset 0x1e8a
	ld hl,65535	; offset 0x1e8d
	push hl	; offset 0x1e8e
	ld hl,65535	; offset 0x1e91
	push hl	; offset 0x1e92
	ld hl,65319	; offset 0x1e95
	push hl	; offset 0x1e96
	ld hl,8063	; offset 0x1e99
	push hl	; offset 0x1e9a
	ld hl,127	; offset 0x1e9d
	push hl	; offset 0x1e9e

	; src_data blit 102
	ld sp,screenStartAddr+976	; offset 0x1ea1
	ld hl,192	; offset 0x1ea4
	push hl	; offset 0x1ea5
	ld hl,12247	; offset 0x1ea8
	push hl	; offset 0x1ea9
	ld hl,2047	; offset 0x1eac
	push hl	; offset 0x1ead
	ld hl,65535	; offset 0x1eb0
	push hl	; offset 0x1eb1
	ld hl,65535	; offset 0x1eb4
	push hl	; offset 0x1eb5
	ld hl,65280	; offset 0x1eb8
	push hl	; offset 0x1eb9
	ld hl,65535	; offset 0x1ebc
	push hl	; offset 0x1ebd
	ld hl,18395	; offset 0x1ec0
	push hl	; offset 0x1ec1

	; src_data blit 103
	ld sp,screenStartAddr+992	; offset 0x1ec4
	ld hl,28152	; offset 0x1ec7
	push hl	; offset 0x1ec8
	ld hl,65407	; offset 0x1ecb
	push hl	; offset 0x1ecc
	ld hl,65535	; offset 0x1ecf
	push hl	; offset 0x1ed0
	ld hl,65535	; offset 0x1ed3
	push hl	; offset 0x1ed4
	ld hl,65535	; offset 0x1ed7
	push hl	; offset 0x1ed8
	ld hl,65319	; offset 0x1edb
	push hl	; offset 0x1edc
	ld hl,34175	; offset 0x1edf
	push hl	; offset 0x1ee0
	ld hl,224	; offset 0x1ee3
	push hl	; offset 0x1ee4

	; src_data blit 104
	ld sp,screenStartAddr+1232	; offset 0x1ee7
	ld hl,65475	; offset 0x1eea
	push hl	; offset 0x1eeb
	ld hl,12246	; offset 0x1eee
	push hl	; offset 0x1eef
	ld hl,2047	; offset 0x1ef2
	push hl	; offset 0x1ef3
	ld hl,65535	; offset 0x1ef6
	push hl	; offset 0x1ef7
	ld hl,65535	; offset 0x1efa
	push hl	; offset 0x1efb
	ld hl,65280	; offset 0x1efe
	push hl	; offset 0x1eff
	ld hl,65535	; offset 0x1f02
	push hl	; offset 0x1f03
	ld hl,26587	; offset 0x1f06
	push hl	; offset 0x1f07

	; attr draw 17
	ld sp,attr8and16vals+68
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,14392	; src 18
	ld de,14392	; src 20
	ld hl,14392	; src 22
	ld ix,14392	; src 4
	ld iy,14392	; src 6
	exx
	ld bc,14392	; src 10
	ld de,14392	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+544
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+544),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+544),hl	; dest 2
	ld hl,14392	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+544
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,14392	; src 24
	ld de,14392	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+544
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+544),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 17, offset 0x1f60
	; Clock offset: -864


	; src_data blit 105
	ld sp,screenStartAddr+1248	; offset 0x1f63
	ld hl,28153	; offset 0x1f66
	push hl	; offset 0x1f67
	ld hl,65407	; offset 0x1f6a
	push hl	; offset 0x1f6b
	ld hl,65535	; offset 0x1f6e
	push hl	; offset 0x1f6f
	ld hl,65535	; offset 0x1f72
	push hl	; offset 0x1f73
	ld hl,65535	; offset 0x1f76
	push hl	; offset 0x1f77
	ld hl,65387	; offset 0x1f7a
	push hl	; offset 0x1f7b
	ld hl,36223	; offset 0x1f7e
	push hl	; offset 0x1f7f
	ld hl,61695	; offset 0x1f82
	push hl	; offset 0x1f83

	; src_data blit 106
	ld sp,screenStartAddr+1488	; offset 0x1f86
	ld hl,65087	; offset 0x1f89
	push hl	; offset 0x1f8a
	ld hl,12246	; offset 0x1f8d
	push hl	; offset 0x1f8e
	ld hl,4095	; offset 0x1f91
	push hl	; offset 0x1f92
	ld hl,65535	; offset 0x1f95
	push hl	; offset 0x1f96
	ld hl,65535	; offset 0x1f99
	push hl	; offset 0x1f9a
	ld hl,65280	; offset 0x1f9d
	push hl	; offset 0x1f9e
	ld hl,65535	; offset 0x1fa1
	push hl	; offset 0x1fa2
	ld hl,26587	; offset 0x1fa5
	push hl	; offset 0x1fa6

	; src_data blit 107
	ld sp,screenStartAddr+1504	; offset 0x1fa9
	ld hl,60921	; offset 0x1fac
	push hl	; offset 0x1fad
	ld hl,65343	; offset 0x1fb0
	push hl	; offset 0x1fb1
	ld hl,65535	; offset 0x1fb4
	push hl	; offset 0x1fb5
	ld hl,65535	; offset 0x1fb8
	push hl	; offset 0x1fb9
	ld hl,65535	; offset 0x1fbc
	push hl	; offset 0x1fbd
	ld hl,65401	; offset 0x1fc0
	push hl	; offset 0x1fc1
	ld hl,36127	; offset 0x1fc4
	push hl	; offset 0x1fc5
	ld hl,65535	; offset 0x1fc8
	push hl	; offset 0x1fc9

	; src_data blit 108
	ld sp,screenStartAddr+1744	; offset 0x1fcc
	ld hl,32766	; offset 0x1fcf
	push hl	; offset 0x1fd0
	ld hl,12766	; offset 0x1fd3
	push hl	; offset 0x1fd4
	ld hl,8191	; offset 0x1fd7
	push hl	; offset 0x1fd8
	ld hl,65535	; offset 0x1fdb
	push hl	; offset 0x1fdc
	ld hl,65535	; offset 0x1fdf
	push hl	; offset 0x1fe0
	ld hl,65280	; offset 0x1fe3
	push hl	; offset 0x1fe4
	ld hl,65279	; offset 0x1fe7
	push hl	; offset 0x1fe8
	ld hl,26587	; offset 0x1feb
	push hl	; offset 0x1fec

	; src_data blit 109
	ld sp,screenStartAddr+1760	; offset 0x1fef
	ld hl,60913	; offset 0x1ff2
	push hl	; offset 0x1ff3
	ld hl,65343	; offset 0x1ff6
	push hl	; offset 0x1ff7
	ld hl,65535	; offset 0x1ffa
	push hl	; offset 0x1ffb
	ld hl,65535	; offset 0x1ffe
	push hl	; offset 0x1fff
	ld hl,65535	; offset 0x2002
	push hl	; offset 0x2003
	ld hl,65402	; offset 0x2006
	push hl	; offset 0x2007
	ld hl,40947	; offset 0x200a
	push hl	; offset 0x200b
	ld hl,53119	; offset 0x200e
	push hl	; offset 0x200f

	; src_data blit 110
	ld sp,screenStartAddr+2000	; offset 0x2012
	ld hl,65519	; offset 0x2015
	push hl	; offset 0x2016
	ld hl,20446	; offset 0x2019
	push hl	; offset 0x201a
	ld hl,3839	; offset 0x201d
	push hl	; offset 0x201e
	ld hl,65535	; offset 0x2021
	push hl	; offset 0x2022
	ld hl,65535	; offset 0x2025
	push hl	; offset 0x2026
	ld hl,65280	; offset 0x2029
	push hl	; offset 0x202a
	ld hl,65279	; offset 0x202d
	push hl	; offset 0x202e
	ld hl,25051	; offset 0x2031
	push hl	; offset 0x2032

	; attr draw 18
	ld sp,attr8and16vals+72
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30776	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+576
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+576),hl	; dest 0
	ld hl,30776	; src 2
	ld (attrStartAddr+2+576),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+576
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,14392	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+576
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+576),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 18, offset 0x208b
	; Clock offset: -864


	; src_data blit 111
	ld sp,screenStartAddr+2016	; offset 0x208e
	ld hl,60865	; offset 0x2091
	push hl	; offset 0x2092
	ld hl,65343	; offset 0x2095
	push hl	; offset 0x2096
	ld hl,65535	; offset 0x2099
	push hl	; offset 0x209a
	ld hl,65535	; offset 0x209d
	push hl	; offset 0x209e
	ld hl,65535	; offset 0x20a1
	push hl	; offset 0x20a2
	ld hl,32634	; offset 0x20a5
	push hl	; offset 0x20a6
	ld hl,36860	; offset 0x20a9
	push hl	; offset 0x20aa
	ld hl,64639	; offset 0x20ad
	push hl	; offset 0x20ae

	; src_data blit 112
	ld sp,screenStartAddr+240	; offset 0x20b1
	ld hl,16376	; offset 0x20b4
	push hl	; offset 0x20b5
	ld hl,16086	; offset 0x20b8
	push hl	; offset 0x20b9
	ld hl,3071	; offset 0x20bc
	push hl	; offset 0x20bd
	ld hl,65535	; offset 0x20c0
	push hl	; offset 0x20c1
	ld hl,65535	; offset 0x20c4
	push hl	; offset 0x20c5
	ld hl,65535	; offset 0x20c8
	push hl	; offset 0x20c9
	ld hl,65151	; offset 0x20cc
	push hl	; offset 0x20cd
	ld hl,25819	; offset 0x20d0
	push hl	; offset 0x20d1

	; src_data blit 113
	ld sp,screenStartAddr+256	; offset 0x20d4
	ld hl,60801	; offset 0x20d7
	push hl	; offset 0x20d8
	ld hl,65311	; offset 0x20db
	push hl	; offset 0x20dc
	ld hl,65535	; offset 0x20df
	push hl	; offset 0x20e0
	ld hl,65535	; offset 0x20e3
	push hl	; offset 0x20e4
	ld hl,65535	; offset 0x20e7
	push hl	; offset 0x20e8
	ld hl,32890	; offset 0x20eb
	push hl	; offset 0x20ec
	ld hl,48607	; offset 0x20ef
	push hl	; offset 0x20f0
	ld hl,33663	; offset 0x20f3
	push hl	; offset 0x20f4

	; src_data blit 114
	ld sp,screenStartAddr+496	; offset 0x20f7
	ld hl,8176	; offset 0x20fa
	push hl	; offset 0x20fb
	ld hl,65526	; offset 0x20fe
	push hl	; offset 0x20ff
	ld hl,16383	; offset 0x2102
	push hl	; offset 0x2103
	ld hl,65535	; offset 0x2106
	push hl	; offset 0x2107
	ld hl,65535	; offset 0x210a
	push hl	; offset 0x210b
	ld hl,65535	; offset 0x210e
	push hl	; offset 0x210f
	ld hl,65151	; offset 0x2112
	push hl	; offset 0x2113
	ld hl,25819	; offset 0x2116
	push hl	; offset 0x2117

	; src_data blit 115
	ld sp,screenStartAddr+512	; offset 0x211a
	ld hl,28065	; offset 0x211d
	push hl	; offset 0x211e
	ld hl,65311	; offset 0x2121
	push hl	; offset 0x2122
	ld hl,65535	; offset 0x2125
	push hl	; offset 0x2126
	ld hl,65535	; offset 0x2129
	push hl	; offset 0x212a
	ld hl,65535	; offset 0x212d
	push hl	; offset 0x212e
	ld hl,33023	; offset 0x2131
	push hl	; offset 0x2132
	ld hl,52735	; offset 0x2135
	push hl	; offset 0x2136
	ld hl,383	; offset 0x2139
	push hl	; offset 0x213a

	; src_data blit 116
	ld sp,screenStartAddr+752	; offset 0x213d
	ld hl,8160	; offset 0x2140
	push hl	; offset 0x2141
	ld hl,65525	; offset 0x2144
	push hl	; offset 0x2145
	ld hl,16383	; offset 0x2148
	push hl	; offset 0x2149
	ld hl,65535	; offset 0x214c
	push hl	; offset 0x214d
	ld hl,65535	; offset 0x2150
	push hl	; offset 0x2151
	ld hl,65535	; offset 0x2154
	push hl	; offset 0x2155
	ld hl,64639	; offset 0x2158
	push hl	; offset 0x2159
	ld hl,25819	; offset 0x215c
	push hl	; offset 0x215d

	; attr draw 19
	ld sp,attr8and16vals+76
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30776	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+608
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+608),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+608),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+608
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,14456	; src 28
	ld sp,attrStartAddr+30+608
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+608),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 19, offset 0x21b6
	; Clock offset: -864


	; src_data blit 117
	ld sp,screenStartAddr+768	; offset 0x21b9
	ld hl,28065	; offset 0x21bc
	push hl	; offset 0x21bd
	ld hl,65311	; offset 0x21c0
	push hl	; offset 0x21c1
	ld hl,65535	; offset 0x21c4
	push hl	; offset 0x21c5
	ld hl,65535	; offset 0x21c8
	push hl	; offset 0x21c9
	ld hl,65535	; offset 0x21cc
	push hl	; offset 0x21cd
	ld hl,49406	; offset 0x21d0
	push hl	; offset 0x21d1
	ld hl,62972	; offset 0x21d4
	push hl	; offset 0x21d5
	ld hl,127	; offset 0x21d8
	push hl	; offset 0x21d9

	; src_data blit 118
	ld sp,screenStartAddr+1008	; offset 0x21dc
	ld hl,4064	; offset 0x21df
	push hl	; offset 0x21e0
	ld hl,65531	; offset 0x21e3
	push hl	; offset 0x21e4
	ld hl,16383	; offset 0x21e7
	push hl	; offset 0x21e8
	ld hl,65535	; offset 0x21eb
	push hl	; offset 0x21ec
	ld hl,65535	; offset 0x21ef
	push hl	; offset 0x21f0
	ld hl,65535	; offset 0x21f3
	push hl	; offset 0x21f4
	ld hl,64639	; offset 0x21f7
	push hl	; offset 0x21f8
	ld hl,25819	; offset 0x21fb
	push hl	; offset 0x21fc

	; src_data blit 119
	ld sp,screenStartAddr+1024	; offset 0x21ff
	ld hl,60801	; offset 0x2202
	push hl	; offset 0x2203
	ld hl,65295	; offset 0x2206
	push hl	; offset 0x2207
	ld hl,65535	; offset 0x220a
	push hl	; offset 0x220b
	ld hl,65535	; offset 0x220e
	push hl	; offset 0x220f
	ld hl,65535	; offset 0x2212
	push hl	; offset 0x2213
	ld hl,57598	; offset 0x2216
	push hl	; offset 0x2217
	ld hl,48125	; offset 0x221a
	push hl	; offset 0x221b
	ld hl,126	; offset 0x221e
	push hl	; offset 0x221f

	; src_data blit 120
	ld sp,screenStartAddr+1264	; offset 0x2222
	ld hl,4064	; offset 0x2225
	push hl	; offset 0x2226
	ld hl,49143	; offset 0x2229
	push hl	; offset 0x222a
	ld hl,32767	; offset 0x222d
	push hl	; offset 0x222e
	ld hl,65535	; offset 0x2231
	push hl	; offset 0x2232
	ld hl,65535	; offset 0x2235
	push hl	; offset 0x2236
	ld hl,65535	; offset 0x2239
	push hl	; offset 0x223a
	ld hl,64639	; offset 0x223d
	push hl	; offset 0x223e
	ld hl,25819	; offset 0x2241
	push hl	; offset 0x2242

	; src_data blit 121
	ld sp,screenStartAddr+1280	; offset 0x2245
	ld hl,60801	; offset 0x2248
	push hl	; offset 0x2249
	ld hl,65295	; offset 0x224c
	push hl	; offset 0x224d
	ld hl,65535	; offset 0x2250
	push hl	; offset 0x2251
	ld hl,65535	; offset 0x2254
	push hl	; offset 0x2255
	ld hl,65535	; offset 0x2258
	push hl	; offset 0x2259
	ld hl,61694	; offset 0x225c
	push hl	; offset 0x225d
	ld hl,48637	; offset 0x2260
	push hl	; offset 0x2261
	ld hl,126	; offset 0x2264
	push hl	; offset 0x2265

	; src_data blit 122
	ld sp,screenStartAddr+1520	; offset 0x2268
	ld hl,4064	; offset 0x226b
	push hl	; offset 0x226c
	ld hl,49142	; offset 0x226f
	push hl	; offset 0x2270
	ld hl,49151	; offset 0x2273
	push hl	; offset 0x2274
	ld hl,65535	; offset 0x2277
	push hl	; offset 0x2278
	ld hl,65535	; offset 0x227b
	push hl	; offset 0x227c
	ld hl,65535	; offset 0x227f
	push hl	; offset 0x2280
	ld hl,64639	; offset 0x2283
	push hl	; offset 0x2284
	ld hl,25819	; offset 0x2287
	push hl	; offset 0x2288

	; attr draw 20
	ld sp,attr8and16vals+80
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30776	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,14456	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+640
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+640),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+640),hl	; dest 2
	ld hl,30840	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+640
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,14456	; src 28
	ld sp,attrStartAddr+30+640
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+640),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 20, offset 0x22e1
	; Clock offset: -864


	; src_data blit 123
	ld sp,screenStartAddr+1536	; offset 0x22e4
	ld hl,60801	; offset 0x22e7
	push hl	; offset 0x22e8
	ld hl,65295	; offset 0x22eb
	push hl	; offset 0x22ec
	ld hl,65535	; offset 0x22ef
	push hl	; offset 0x22f0
	ld hl,65535	; offset 0x22f3
	push hl	; offset 0x22f4
	ld hl,65535	; offset 0x22f7
	push hl	; offset 0x22f8
	ld hl,61695	; offset 0x22fb
	push hl	; offset 0x22fc
	ld hl,44541	; offset 0x22ff
	push hl	; offset 0x2300
	ld hl,126	; offset 0x2303
	push hl	; offset 0x2304

	; src_data blit 124
	ld sp,screenStartAddr+1776	; offset 0x2307
	ld hl,8160	; offset 0x230a
	push hl	; offset 0x230b
	ld hl,47103	; offset 0x230e
	push hl	; offset 0x230f
	ld hl,49151	; offset 0x2312
	push hl	; offset 0x2313
	ld hl,65535	; offset 0x2316
	push hl	; offset 0x2317
	ld hl,65535	; offset 0x231a
	push hl	; offset 0x231b
	ld hl,65535	; offset 0x231e
	push hl	; offset 0x231f
	ld hl,64639	; offset 0x2322
	push hl	; offset 0x2323
	ld hl,24795	; offset 0x2326
	push hl	; offset 0x2327

	; src_data blit 125
	ld sp,screenStartAddr+1792	; offset 0x232a
	ld hl,60833	; offset 0x232d
	push hl	; offset 0x232e
	ld hl,65295	; offset 0x2331
	push hl	; offset 0x2332
	ld hl,65535	; offset 0x2335
	push hl	; offset 0x2336
	ld hl,65535	; offset 0x2339
	push hl	; offset 0x233a
	ld hl,65535	; offset 0x233d
	push hl	; offset 0x233e
	ld hl,61695	; offset 0x2341
	push hl	; offset 0x2342
	ld hl,65533	; offset 0x2345
	push hl	; offset 0x2346
	ld hl,126	; offset 0x2349
	push hl	; offset 0x234a

	; src_data blit 126
	ld sp,screenStartAddr+2032	; offset 0x234d
	ld hl,8176	; offset 0x2350
	push hl	; offset 0x2351
	ld hl,63486	; offset 0x2354
	push hl	; offset 0x2355
	ld hl,65532	; offset 0x2358
	push hl	; offset 0x2359
	ld hl,65535	; offset 0x235c
	push hl	; offset 0x235d
	ld hl,65535	; offset 0x2360
	push hl	; offset 0x2361
	ld hl,65535	; offset 0x2364
	push hl	; offset 0x2365
	ld hl,64639	; offset 0x2368
	push hl	; offset 0x2369
	ld hl,24795	; offset 0x236c
	push hl	; offset 0x236d

	; src_data blit 127
	ld sp,screenStartAddr+2048	; offset 0x2370
	ld hl,60801	; offset 0x2373
	push hl	; offset 0x2374
	ld hl,65295	; offset 0x2377
	push hl	; offset 0x2378
	ld hl,65535	; offset 0x237b
	push hl	; offset 0x237c
	ld hl,65535	; offset 0x237f
	push hl	; offset 0x2380
	ld hl,65535	; offset 0x2383
	push hl	; offset 0x2384
	ld hl,63743	; offset 0x2387
	push hl	; offset 0x2388
	ld hl,61437	; offset 0x238b
	push hl	; offset 0x238c
	ld hl,383	; offset 0x238f
	push hl	; offset 0x2390

	; src_data blit 128
	ld sp,screenStartAddr+2064	; offset 0x2393
	ld hl,16376	; offset 0x2396
	push hl	; offset 0x2397
	ld hl,30718	; offset 0x239a
	push hl	; offset 0x239b
	ld hl,32512	; offset 0x239e
	push hl	; offset 0x239f
	ld hl,65535	; offset 0x23a2
	push hl	; offset 0x23a3
	ld hl,65535	; offset 0x23a6
	push hl	; offset 0x23a7
	ld hl,65535	; offset 0x23aa
	push hl	; offset 0x23ab
	ld hl,64639	; offset 0x23ae
	push hl	; offset 0x23af
	ld hl,25819	; offset 0x23b2
	push hl	; offset 0x23b3

	; attr draw 21
	ld sp,attr8and16vals+84
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30776	; src 18
	ld de,30840	; src 20
	ld hl,14456	; src 22
	ld ix,14456	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,14456	; src 10
	ld de,30840	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+672
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+672),hl	; dest 0
	ld hl,30776	; src 2
	ld (attrStartAddr+2+672),hl	; dest 2
	ld hl,14456	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+672
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+672
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+672),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 21, offset 0x240c
	; Clock offset: -864


	; src_data blit 129
	ld sp,screenStartAddr+2080	; offset 0x240f
	ld hl,60833	; offset 0x2412
	push hl	; offset 0x2413
	ld hl,65295	; offset 0x2416
	push hl	; offset 0x2417
	ld hl,255	; offset 0x241a
	push hl	; offset 0x241b
	ld hl,65535	; offset 0x241e
	push hl	; offset 0x241f
	ld hl,65535	; offset 0x2422
	push hl	; offset 0x2423
	ld hl,61695	; offset 0x2426
	push hl	; offset 0x2427
	ld hl,53247	; offset 0x242a
	push hl	; offset 0x242b
	ld hl,50047	; offset 0x242e
	push hl	; offset 0x242f

	; src_data blit 130
	ld sp,screenStartAddr+2320	; offset 0x2432
	ld hl,65535	; offset 0x2435
	push hl	; offset 0x2436
	ld hl,32766	; offset 0x2439
	push hl	; offset 0x243a
	ld hl,32513	; offset 0x243d
	push hl	; offset 0x243e
	ld hl,65535	; offset 0x2441
	push hl	; offset 0x2442
	ld hl,65535	; offset 0x2445
	push hl	; offset 0x2446
	ld hl,65535	; offset 0x2449
	push hl	; offset 0x244a
	ld hl,64639	; offset 0x244d
	push hl	; offset 0x244e
	ld hl,25819	; offset 0x2451
	push hl	; offset 0x2452

	; src_data blit 131
	ld sp,screenStartAddr+2336	; offset 0x2455
	ld hl,60801	; offset 0x2458
	push hl	; offset 0x2459
	ld hl,65295	; offset 0x245c
	push hl	; offset 0x245d
	ld hl,255	; offset 0x2460
	push hl	; offset 0x2461
	ld hl,65535	; offset 0x2464
	push hl	; offset 0x2465
	ld hl,65535	; offset 0x2468
	push hl	; offset 0x2469
	ld hl,61695	; offset 0x246c
	push hl	; offset 0x246d
	ld hl,53247	; offset 0x2470
	push hl	; offset 0x2471
	ld hl,65407	; offset 0x2474
	push hl	; offset 0x2475

	; src_data blit 132
	ld sp,screenStartAddr+2576	; offset 0x2478
	ld hl,65535	; offset 0x247b
	push hl	; offset 0x247c
	ld hl,16383	; offset 0x247f
	push hl	; offset 0x2480
	ld hl,65281	; offset 0x2483
	push hl	; offset 0x2484
	ld hl,65535	; offset 0x2487
	push hl	; offset 0x2488
	ld hl,65535	; offset 0x248b
	push hl	; offset 0x248c
	ld hl,65535	; offset 0x248f
	push hl	; offset 0x2490
	ld hl,64639	; offset 0x2493
	push hl	; offset 0x2494
	ld hl,25819	; offset 0x2497
	push hl	; offset 0x2498

	; src_data blit 133
	ld sp,screenStartAddr+2592	; offset 0x249b
	ld hl,60801	; offset 0x249e
	push hl	; offset 0x249f
	ld hl,65295	; offset 0x24a2
	push hl	; offset 0x24a3
	ld hl,255	; offset 0x24a6
	push hl	; offset 0x24a7
	ld hl,65535	; offset 0x24aa
	push hl	; offset 0x24ab
	ld hl,65535	; offset 0x24ae
	push hl	; offset 0x24af
	ld hl,63743	; offset 0x24b2
	push hl	; offset 0x24b3
	ld hl,40959	; offset 0x24b6
	push hl	; offset 0x24b7
	ld hl,65407	; offset 0x24ba
	push hl	; offset 0x24bb

	; src_data blit 134
	ld sp,screenStartAddr+2832	; offset 0x24be
	ld hl,65535	; offset 0x24c1
	push hl	; offset 0x24c2
	ld hl,40959	; offset 0x24c5
	push hl	; offset 0x24c6
	ld hl,65285	; offset 0x24c9
	push hl	; offset 0x24ca
	ld hl,65535	; offset 0x24cd
	push hl	; offset 0x24ce
	ld hl,65535	; offset 0x24d1
	push hl	; offset 0x24d2
	ld hl,65535	; offset 0x24d5
	push hl	; offset 0x24d6
	ld hl,64639	; offset 0x24d9
	push hl	; offset 0x24da
	ld hl,25819	; offset 0x24dd
	push hl	; offset 0x24de

	; attr draw 22
	ld sp,attr8and16vals+88
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,14392	; src 18
	ld de,14392	; src 20
	ld hl,14392	; src 22
	ld ix,14392	; src 4
	ld iy,14392	; src 6
	exx
	ld bc,14392	; src 10
	ld de,14392	; src 12
	ld hl,14392	; src 0

	ld sp,attrStartAddr+16+704
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+704),hl	; dest 0
	ld hl,14392	; src 2
	ld (attrStartAddr+2+704),hl	; dest 2
	ld hl,14392	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+704
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,14392	; src 24
	ld de,30776	; src 26
	ld hl,14392	; src 28
	ld sp,attrStartAddr+30+704
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,14392	; src 30
	ld (attrStartAddr+30+704),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 22, offset 0x2537
	; Clock offset: -864


	; src_data blit 135
	ld sp,screenStartAddr+2848	; offset 0x253a
	ld hl,60801	; offset 0x253d
	push hl	; offset 0x253e
	ld hl,65295	; offset 0x2541
	push hl	; offset 0x2542
	ld hl,255	; offset 0x2545
	push hl	; offset 0x2546
	ld hl,65535	; offset 0x2549
	push hl	; offset 0x254a
	ld hl,65535	; offset 0x254d
	push hl	; offset 0x254e
	ld hl,64767	; offset 0x2551
	push hl	; offset 0x2552
	ld hl,16379	; offset 0x2555
	push hl	; offset 0x2556
	ld hl,65407	; offset 0x2559
	push hl	; offset 0x255a

	; src_data blit 136
	ld sp,screenStartAddr+3088	; offset 0x255d
	ld hl,65535	; offset 0x2560
	push hl	; offset 0x2561
	ld hl,40957	; offset 0x2564
	push hl	; offset 0x2565
	ld hl,65287	; offset 0x2568
	push hl	; offset 0x2569
	ld hl,65535	; offset 0x256c
	push hl	; offset 0x256d
	ld hl,65535	; offset 0x2570
	push hl	; offset 0x2571
	ld hl,65535	; offset 0x2574
	push hl	; offset 0x2575
	ld hl,64639	; offset 0x2578
	push hl	; offset 0x2579
	ld hl,25819	; offset 0x257c
	push hl	; offset 0x257d

	; src_data blit 137
	ld sp,screenStartAddr+3104	; offset 0x2580
	ld hl,60801	; offset 0x2583
	push hl	; offset 0x2584
	ld hl,65295	; offset 0x2587
	push hl	; offset 0x2588
	ld hl,255	; offset 0x258b
	push hl	; offset 0x258c
	ld hl,65535	; offset 0x258f
	push hl	; offset 0x2590
	ld hl,65535	; offset 0x2593
	push hl	; offset 0x2594
	ld hl,64767	; offset 0x2597
	push hl	; offset 0x2598
	ld hl,14335	; offset 0x259b
	push hl	; offset 0x259c
	ld hl,65407	; offset 0x259f
	push hl	; offset 0x25a0

	; src_data blit 138
	ld sp,screenStartAddr+3344	; offset 0x25a3
	ld hl,65535	; offset 0x25a6
	push hl	; offset 0x25a7
	ld hl,53245	; offset 0x25aa
	push hl	; offset 0x25ab
	ld hl,65303	; offset 0x25ae
	push hl	; offset 0x25af
	ld hl,65535	; offset 0x25b2
	push hl	; offset 0x25b3
	ld hl,65535	; offset 0x25b6
	push hl	; offset 0x25b7
	ld hl,65535	; offset 0x25ba
	push hl	; offset 0x25bb
	ld hl,64639	; offset 0x25be
	push hl	; offset 0x25bf
	ld hl,24795	; offset 0x25c2
	push hl	; offset 0x25c3

	; src_data blit 139
	ld sp,screenStartAddr+3360	; offset 0x25c6
	ld hl,60833	; offset 0x25c9
	push hl	; offset 0x25ca
	ld hl,65295	; offset 0x25cd
	push hl	; offset 0x25ce
	ld hl,255	; offset 0x25d1
	push hl	; offset 0x25d2
	ld hl,65535	; offset 0x25d5
	push hl	; offset 0x25d6
	ld hl,65535	; offset 0x25d9
	push hl	; offset 0x25da
	ld hl,64767	; offset 0x25dd
	push hl	; offset 0x25de
	ld hl,30718	; offset 0x25e1
	push hl	; offset 0x25e2
	ld hl,65407	; offset 0x25e5
	push hl	; offset 0x25e6

	; src_data blit 140
	ld sp,screenStartAddr+3600	; offset 0x25e9
	ld hl,32760	; offset 0x25ec
	push hl	; offset 0x25ed
	ld hl,59391	; offset 0x25f0
	push hl	; offset 0x25f1
	ld hl,65295	; offset 0x25f4
	push hl	; offset 0x25f5
	ld hl,65535	; offset 0x25f8
	push hl	; offset 0x25f9
	ld hl,65535	; offset 0x25fc
	push hl	; offset 0x25fd
	ld hl,65535	; offset 0x2600
	push hl	; offset 0x2601
	ld hl,63615	; offset 0x2604
	push hl	; offset 0x2605
	ld hl,24795	; offset 0x2608
	push hl	; offset 0x2609

	; attr draw 23
	ld sp,attr8and16vals+92
	pop af	; src 8
	ex af,af'
	pop af	; src 16
	ld bc,30776	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+736
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+736),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+736),hl	; dest 2
	ld hl,30776	; src 14
	push hl	; dest 14
	push de	; dest 12
	push bc	; dest 10
	push af	; dest 8
	exx
	ex af,af'
	push iy	; dest 6
	push ix	; dest 4
	ld sp,attrStartAddr+24+736
	push hl	; dest 22
	push de	; dest 20
	push bc	; dest 18
	push af	; dest 16
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+736
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+736),hl;	 dest 30
	; Inter-frame delay
	ld b,8
ifDelay:
	djnz ifDelay

	nop
	nop

	; end attr draw 23, offset 0x2665
	; Clock offset: -864


	; src_data blit 141
	ld sp,screenStartAddr+3616	; offset 0x2668
	ld hl,60801	; offset 0x266b
	push hl	; offset 0x266c
	ld hl,65391	; offset 0x266f
	push hl	; offset 0x2670
	ld hl,255	; offset 0x2673
	push hl	; offset 0x2674
	ld hl,65535	; offset 0x2677
	push hl	; offset 0x2678
	ld hl,65535	; offset 0x267b
	push hl	; offset 0x267c
	ld hl,64767	; offset 0x267f
	push hl	; offset 0x2680
	ld hl,63484	; offset 0x2683
	push hl	; offset 0x2684
	ld hl,50047	; offset 0x2687
	push hl	; offset 0x2688

	; src_data blit 142
	ld sp,screenStartAddr+3856	; offset 0x268b
	ld hl,8176	; offset 0x268e
	push hl	; offset 0x268f
	ld hl,62463	; offset 0x2692
	push hl	; offset 0x2693
	ld hl,65295	; offset 0x2696
	push hl	; offset 0x2697
	ld hl,65535	; offset 0x269a
	push hl	; offset 0x269b
	ld hl,65535	; offset 0x269e
	push hl	; offset 0x269f
	ld hl,65535	; offset 0x26a2
	push hl	; offset 0x26a3
	ld hl,63615	; offset 0x26a6
	push hl	; offset 0x26a7
	ld hl,25819	; offset 0x26aa
	push hl	; offset 0x26ab

	; src_data blit 143
	ld sp,screenStartAddr+3872	; offset 0x26ae
	ld hl,60809	; offset 0x26b1
	push hl	; offset 0x26b2
	ld hl,65391	; offset 0x26b5
	push hl	; offset 0x26b6
	ld hl,1023	; offset 0x26b9
	push hl	; offset 0x26ba
	ld hl,65535	; offset 0x26bd
	push hl	; offset 0x26be
	ld hl,65535	; offset 0x26c1
	push hl	; offset 0x26c2
	ld hl,65279	; offset 0x26c5
	push hl	; offset 0x26c6
	ld hl,65529	; offset 0x26c9
	push hl	; offset 0x26ca
	ld hl,383	; offset 0x26cd
	push hl	; offset 0x26ce

	; src_data blit 144
	ld sp,screenStartAddr+2096	; offset 0x26d1
	ld hl,8160	; offset 0x26d4
	push hl	; offset 0x26d5
	ld hl,63999	; offset 0x26d8
	push hl	; offset 0x26d9
	ld hl,65291	; offset 0x26dc
	push hl	; offset 0x26dd
	ld hl,65535	; offset 0x26e0
	push hl	; offset 0x26e1
	ld hl,65535	; offset 0x26e4
	push hl	; offset 0x26e5
	ld hl,65280	; offset 0x26e8
	push hl	; offset 0x26e9
	ld hl,63615	; offset 0x26ec
	push hl	; offset 0x26ed
	ld hl,25819	; offset 0x26f0
	push hl	; offset 0x26f1

	; src_data blit 145
	ld sp,screenStartAddr+2112	; offset 0x26f4
	ld hl,60801	; offset 0x26f7
	push hl	; offset 0x26f8
	ld hl,65391	; offset 0x26fb
	push hl	; offset 0x26fc
	ld hl,1023	; offset 0x26ff
	push hl	; offset 0x2700
	ld hl,65535	; offset 0x2703
	push hl	; offset 0x2704
	ld hl,65408	; offset 0x2707
	push hl	; offset 0x2708
	ld hl,63231	; offset 0x270b
	push hl	; offset 0x270c
	ld hl,65523	; offset 0x270f
	push hl	; offset 0x2710
	ld hl,126	; offset 0x2713
	push hl	; offset 0x2714

	; src_data blit 146
	ld sp,screenStartAddr+2352	; offset 0x2717
	ld hl,4064	; offset 0x271a
	push hl	; offset 0x271b
	ld hl,60670	; offset 0x271e
	push hl	; offset 0x271f
	ld hl,65339	; offset 0x2722
	push hl	; offset 0x2723
	ld hl,65535	; offset 0x2726
	push hl	; offset 0x2727
	ld hl,65535	; offset 0x272a
	push hl	; offset 0x272b
	ld hl,65280	; offset 0x272e
	push hl	; offset 0x272f
	ld hl,63615	; offset 0x2732
	push hl	; offset 0x2733
	ld hl,24795	; offset 0x2736
	push hl	; offset 0x2737

	; src_data blit 147
	ld sp,screenStartAddr+2368	; offset 0x273a
	ld hl,60801	; offset 0x273d
	push hl	; offset 0x273e
	ld hl,65391	; offset 0x2741
	push hl	; offset 0x2742
	ld hl,1023	; offset 0x2745
	push hl	; offset 0x2746
	ld hl,65535	; offset 0x2749
	push hl	; offset 0x274a
	ld hl,65472	; offset 0x274d
	push hl	; offset 0x274e
	ld hl,65279	; offset 0x2751
	push hl	; offset 0x2752
	ld hl,61411	; offset 0x2755
	push hl	; offset 0x2756
	ld hl,126	; offset 0x2759
	push hl	; offset 0x275a
	; delay to get start of scanline (-144 T-states) at offset 0x275a


	; src_data blit 148
	ld sp,screenStartAddr+2608	; offset 0x275d
	ld hl,3936	; offset 0x2760
	push hl	; offset 0x2761
	ld hl,65278	; offset 0x2764
	push hl	; offset 0x2765
	ld hl,65323	; offset 0x2768
	push hl	; offset 0x2769
	ld hl,65279	; offset 0x276c
	push hl	; offset 0x276d
	ld hl,65535	; offset 0x2770
	push hl	; offset 0x2771
	ld hl,65280	; offset 0x2774
	push hl	; offset 0x2775
	ld hl,63615	; offset 0x2778
	push hl	; offset 0x2779
	ld hl,24795	; offset 0x277c
	push hl	; offset 0x277d
	; delay to get start of scanline (-144 T-states) at offset 0x277d


	; src_data blit 149
	ld sp,screenStartAddr+2624	; offset 0x2780
	ld hl,60801	; offset 0x2783
	push hl	; offset 0x2784
	ld hl,65391	; offset 0x2787
	push hl	; offset 0x2788
	ld hl,1023	; offset 0x278b
	push hl	; offset 0x278c
	ld hl,65535	; offset 0x278f
	push hl	; offset 0x2790
	ld hl,65472	; offset 0x2793
	push hl	; offset 0x2794
	ld hl,65279	; offset 0x2797
	push hl	; offset 0x2798
	ld hl,61391	; offset 0x279b
	push hl	; offset 0x279c
	ld hl,126	; offset 0x279f
	push hl	; offset 0x27a0
	; delay to get start of scanline (-144 T-states) at offset 0x27a0


	; src_data blit 150
	ld sp,screenStartAddr+2864	; offset 0x27a3
	ld hl,3872	; offset 0x27a6
	push hl	; offset 0x27a7
	ld hl,63487	; offset 0x27aa
	push hl	; offset 0x27ab
	ld hl,65467	; offset 0x27ae
	push hl	; offset 0x27af
	ld hl,65279	; offset 0x27b2
	push hl	; offset 0x27b3
	ld hl,65535	; offset 0x27b6
	push hl	; offset 0x27b7
	ld hl,65280	; offset 0x27ba
	push hl	; offset 0x27bb
	ld hl,63615	; offset 0x27be
	push hl	; offset 0x27bf
	ld hl,25819	; offset 0x27c2
	push hl	; offset 0x27c3
	; delay to get start of scanline (-144 T-states) at offset 0x27c3


	; src_data blit 151
	ld sp,screenStartAddr+2880	; offset 0x27c6
	ld hl,60809	; offset 0x27c9
	push hl	; offset 0x27ca
	ld hl,65387	; offset 0x27cd
	push hl	; offset 0x27ce
	ld hl,1023	; offset 0x27d1
	push hl	; offset 0x27d2
	ld hl,65535	; offset 0x27d5
	push hl	; offset 0x27d6
	ld hl,65504	; offset 0x27d9
	push hl	; offset 0x27da
	ld hl,65535	; offset 0x27dd
	push hl	; offset 0x27de
	ld hl,65437	; offset 0x27e1
	push hl	; offset 0x27e2
	ld hl,126	; offset 0x27e5
	push hl	; offset 0x27e6
	; delay to get start of scanline (-144 T-states) at offset 0x27e6


	; src_data blit 152
	ld sp,screenStartAddr+3120	; offset 0x27e9
	ld hl,3984	; offset 0x27ec
	push hl	; offset 0x27ed
	ld hl,30719	; offset 0x27f0
	push hl	; offset 0x27f1
	ld hl,65407	; offset 0x27f4
	push hl	; offset 0x27f5
	ld hl,65279	; offset 0x27f8
	push hl	; offset 0x27f9
	ld hl,65535	; offset 0x27fc
	push hl	; offset 0x27fd
	ld hl,65280	; offset 0x2800
	push hl	; offset 0x2801
	ld hl,63615	; offset 0x2804
	push hl	; offset 0x2805
	ld hl,25819	; offset 0x2808
	push hl	; offset 0x2809
	; delay to get start of scanline (-144 T-states) at offset 0x2809


	; src_data blit 153
	ld sp,screenStartAddr+3136	; offset 0x280c
	ld hl,60809	; offset 0x280f
	push hl	; offset 0x2810
	ld hl,65287	; offset 0x2813
	push hl	; offset 0x2814
	ld hl,1023	; offset 0x2817
	push hl	; offset 0x2818
	ld hl,65535	; offset 0x281b
	push hl	; offset 0x281c
	ld hl,65520	; offset 0x281f
	push hl	; offset 0x2820
	ld hl,65535	; offset 0x2823
	push hl	; offset 0x2824
	ld hl,65341	; offset 0x2827
	push hl	; offset 0x2828
	ld hl,382	; offset 0x282b
	push hl	; offset 0x282c
	; delay to get start of scanline (-144 T-states) at offset 0x282c


	; src_data blit 154
	ld sp,screenStartAddr+3376	; offset 0x282f
	ld hl,8128	; offset 0x2832
	push hl	; offset 0x2833
	ld hl,32767	; offset 0x2836
	push hl	; offset 0x2837
	ld hl,65407	; offset 0x283a
	push hl	; offset 0x283b
	ld hl,64767	; offset 0x283e
	push hl	; offset 0x283f
	ld hl,65535	; offset 0x2842
	push hl	; offset 0x2843
	ld hl,65472	; offset 0x2846
	push hl	; offset 0x2847
	ld hl,59263	; offset 0x284a
	push hl	; offset 0x284b
	ld hl,24795	; offset 0x284e
	push hl	; offset 0x284f
	; delay to get start of scanline (-144 T-states) at offset 0x284f


	; src_data blit 155
	ld sp,screenStartAddr+3392	; offset 0x2852
	ld hl,60801	; offset 0x2855
	push hl	; offset 0x2856
	ld hl,49145	; offset 0x2859
	push hl	; offset 0x285a
	ld hl,1023	; offset 0x285d
	push hl	; offset 0x285e
	ld hl,65535	; offset 0x2861
	push hl	; offset 0x2862
	ld hl,65520	; offset 0x2865
	push hl	; offset 0x2866
	ld hl,65535	; offset 0x2869
	push hl	; offset 0x286a
	ld hl,57215	; offset 0x286d
	push hl	; offset 0x286e
	ld hl,1151	; offset 0x2871
	push hl	; offset 0x2872
	; delay to get start of scanline (-144 T-states) at offset 0x2872


	; src_data blit 156
	ld sp,screenStartAddr+3632	; offset 0x2875
	ld hl,16370	; offset 0x2878
	push hl	; offset 0x2879
	ld hl,64511	; offset 0x287c
	push hl	; offset 0x287d
	ld hl,65407	; offset 0x2880
	push hl	; offset 0x2881
	ld hl,63743	; offset 0x2884
	push hl	; offset 0x2885
	ld hl,65535	; offset 0x2888
	push hl	; offset 0x2889
	ld hl,65504	; offset 0x288c
	push hl	; offset 0x288d
	ld hl,61311	; offset 0x2890
	push hl	; offset 0x2891
	ld hl,26843	; offset 0x2894
	push hl	; offset 0x2895
	; delay to get start of scanline (-144 T-states) at offset 0x2895


	; src_data blit 157
	ld sp,screenStartAddr+3648	; offset 0x2898
	ld hl,60805	; offset 0x289b
	push hl	; offset 0x289c
	ld hl,65529	; offset 0x289f
	push hl	; offset 0x28a0
	ld hl,8191	; offset 0x28a3
	push hl	; offset 0x28a4
	ld hl,65535	; offset 0x28a7
	push hl	; offset 0x28a8
	ld hl,65508	; offset 0x28ab
	push hl	; offset 0x28ac
	ld hl,65535	; offset 0x28af
	push hl	; offset 0x28b0
	ld hl,53243	; offset 0x28b3
	push hl	; offset 0x28b4
	ld hl,35199	; offset 0x28b7
	push hl	; offset 0x28b8
	; delay to get start of scanline (-144 T-states) at offset 0x28b8


	; src_data blit 158
	ld sp,screenStartAddr+3888	; offset 0x28bb
	ld hl,65528	; offset 0x28be
	push hl	; offset 0x28bf
	ld hl,65535	; offset 0x28c2
	push hl	; offset 0x28c3
	ld hl,65407	; offset 0x28c6
	push hl	; offset 0x28c7
	ld hl,49407	; offset 0x28ca
	push hl	; offset 0x28cb
	ld hl,65535	; offset 0x28ce
	push hl	; offset 0x28cf
	ld hl,65504	; offset 0x28d2
	push hl	; offset 0x28d3
	ld hl,61247	; offset 0x28d6
	push hl	; offset 0x28d7
	ld hl,26843	; offset 0x28da
	push hl	; offset 0x28db
	; delay to get start of scanline (-144 T-states) at offset 0x28db


	; src_data blit 159
	ld sp,screenStartAddr+3904	; offset 0x28de
	ld hl,60821	; offset 0x28e1
	push hl	; offset 0x28e2
	ld hl,65529	; offset 0x28e5
	push hl	; offset 0x28e6
	ld hl,8191	; offset 0x28e9
	push hl	; offset 0x28ea
	ld hl,65535	; offset 0x28ed
	push hl	; offset 0x28ee
	ld hl,65532	; offset 0x28f1
	push hl	; offset 0x28f2
	ld hl,65535	; offset 0x28f5
	push hl	; offset 0x28f6
	ld hl,61439	; offset 0x28f9
	push hl	; offset 0x28fa
	ld hl,58239	; offset 0x28fd
	push hl	; offset 0x28fe
	; delay to get start of scanline (-144 T-states) at offset 0x28fe


	; src_data blit 160
	ld sp,screenStartAddr+2128	; offset 0x2901
	ld hl,16383	; offset 0x2904
	push hl	; offset 0x2905
	ld hl,48630	; offset 0x2908
	push hl	; offset 0x2909
	ld hl,65535	; offset 0x290c
	push hl	; offset 0x290d
	ld hl,0	; offset 0x2910
	push hl	; offset 0x2911
	ld hl,65535	; offset 0x2914
	push hl	; offset 0x2915
	ld hl,65504	; offset 0x2918
	push hl	; offset 0x2919
	ld hl,61215	; offset 0x291c
	push hl	; offset 0x291d
	ld hl,25051	; offset 0x2920
	push hl	; offset 0x2921
	; delay to get start of scanline (-144 T-states) at offset 0x2921


	; src_data blit 161
	ld sp,screenStartAddr+2144	; offset 0x2924
	ld hl,60801	; offset 0x2927
	push hl	; offset 0x2928
	ld hl,52825	; offset 0x292b
	push hl	; offset 0x292c
	ld hl,58367	; offset 0x292f
	push hl	; offset 0x2930
	ld hl,65535	; offset 0x2933
	push hl	; offset 0x2934
	ld hl,65518	; offset 0x2937
	push hl	; offset 0x2938
	ld hl,65535	; offset 0x293b
	push hl	; offset 0x293c
	ld hl,48631	; offset 0x293f
	push hl	; offset 0x2940
	ld hl,3967	; offset 0x2943
	push hl	; offset 0x2944
	; delay to get start of scanline (-144 T-states) at offset 0x2944


	; src_data blit 162
	ld sp,screenStartAddr+2384	; offset 0x2947
	ld hl,50175	; offset 0x294a
	push hl	; offset 0x294b
	ld hl,49127	; offset 0x294e
	push hl	; offset 0x294f
	ld hl,65281	; offset 0x2952
	push hl	; offset 0x2953
	ld hl,7168	; offset 0x2956
	push hl	; offset 0x2957
	ld hl,65535	; offset 0x295a
	push hl	; offset 0x295b
	ld hl,65504	; offset 0x295e
	push hl	; offset 0x295f
	ld hl,61215	; offset 0x2962
	push hl	; offset 0x2963
	ld hl,25051	; offset 0x2966
	push hl	; offset 0x2967
	; delay to get start of scanline (-144 T-states) at offset 0x2967


	; src_data blit 163
	ld sp,screenStartAddr+2400	; offset 0x296a
	ld hl,60673	; offset 0x296d
	push hl	; offset 0x296e
	ld hl,56921	; offset 0x2971
	push hl	; offset 0x2972
	ld hl,58367	; offset 0x2975
	push hl	; offset 0x2976
	ld hl,65535	; offset 0x2979
	push hl	; offset 0x297a
	ld hl,65530	; offset 0x297d
	push hl	; offset 0x297e
	ld hl,65535	; offset 0x2981
	push hl	; offset 0x2982
	ld hl,48639	; offset 0x2985
	push hl	; offset 0x2986
	ld hl,32624	; offset 0x2989
	push hl	; offset 0x298a
	; delay to get start of scanline (-144 T-states) at offset 0x298a


	; src_data blit 164
	ld sp,screenStartAddr+2640	; offset 0x298d
	ld hl,65535	; offset 0x2990
	push hl	; offset 0x2991
	ld hl,65255	; offset 0x2994
	push hl	; offset 0x2995
	ld hl,16135	; offset 0x2998
	push hl	; offset 0x2999
	ld hl,24576	; offset 0x299c
	push hl	; offset 0x299d
	ld hl,65535	; offset 0x29a0
	push hl	; offset 0x29a1
	ld hl,65504	; offset 0x29a4
	push hl	; offset 0x29a5
	ld hl,60959	; offset 0x29a8
	push hl	; offset 0x29a9
	ld hl,27867	; offset 0x29ac
	push hl	; offset 0x29ad
	; delay to get start of scanline (-144 T-states) at offset 0x29ad


	; src_data blit 165
	ld sp,screenStartAddr+2656	; offset 0x29b0
	ld hl,60685	; offset 0x29b3
	push hl	; offset 0x29b4
	ld hl,62585	; offset 0x29b7
	push hl	; offset 0x29b8
	ld hl,58367	; offset 0x29bb
	push hl	; offset 0x29bc
	ld hl,65535	; offset 0x29bf
	push hl	; offset 0x29c0
	ld hl,65532	; offset 0x29c3
	push hl	; offset 0x29c4
	ld hl,65535	; offset 0x29c7
	push hl	; offset 0x29c8
	ld hl,64751	; offset 0x29cb
	push hl	; offset 0x29cc
	ld hl,65407	; offset 0x29cf
	push hl	; offset 0x29d0
	; delay to get start of scanline (-144 T-states) at offset 0x29d0


	; src_data blit 166
	ld sp,screenStartAddr+2896	; offset 0x29d3
	ld hl,65407	; offset 0x29d6
	push hl	; offset 0x29d7
	ld hl,57287	; offset 0x29da
	push hl	; offset 0x29db
	ld hl,61439	; offset 0x29de
	push hl	; offset 0x29df
	ld hl,65281	; offset 0x29e2
	push hl	; offset 0x29e3
	ld hl,65535	; offset 0x29e6
	push hl	; offset 0x29e7
	ld hl,65504	; offset 0x29ea
	push hl	; offset 0x29eb
	ld hl,60959	; offset 0x29ee
	push hl	; offset 0x29ef
	ld hl,28123	; offset 0x29f2
	push hl	; offset 0x29f3
	; delay to get start of scanline (-144 T-states) at offset 0x29f3


	; src_data blit 167
	ld sp,screenStartAddr+2912	; offset 0x29f6
	ld hl,60717	; offset 0x29f9
	push hl	; offset 0x29fa
	ld hl,64601	; offset 0x29fd
	push hl	; offset 0x29fe
	ld hl,57855	; offset 0x2a01
	push hl	; offset 0x2a02
	ld hl,65535	; offset 0x2a05
	push hl	; offset 0x2a06
	ld hl,32540	; offset 0x2a09
	push hl	; offset 0x2a0a
	ld hl,65151	; offset 0x2a0d
	push hl	; offset 0x2a0e
	ld hl,31967	; offset 0x2a11
	push hl	; offset 0x2a12
	ld hl,65407	; offset 0x2a15
	push hl	; offset 0x2a16
	; delay to get start of scanline (-144 T-states) at offset 0x2a16


	; src_data blit 168
	ld sp,screenStartAddr+3152	; offset 0x2a19
	ld hl,65471	; offset 0x2a1c
	push hl	; offset 0x2a1d
	ld hl,24448	; offset 0x2a20
	push hl	; offset 0x2a21
	ld hl,63487	; offset 0x2a24
	push hl	; offset 0x2a25
	ld hl,16129	; offset 0x2a28
	push hl	; offset 0x2a29
	ld hl,65535	; offset 0x2a2c
	push hl	; offset 0x2a2d
	ld hl,65504	; offset 0x2a30
	push hl	; offset 0x2a31
	ld hl,61215	; offset 0x2a34
	push hl	; offset 0x2a35
	ld hl,28123	; offset 0x2a38
	push hl	; offset 0x2a39
	; delay to get start of scanline (-144 T-states) at offset 0x2a39


	; src_data blit 169
	ld sp,screenStartAddr+3168	; offset 0x2a3c
	ld hl,60845	; offset 0x2a3f
	push hl	; offset 0x2a40
	ld hl,31993	; offset 0x2a43
	push hl	; offset 0x2a44
	ld hl,57855	; offset 0x2a47
	push hl	; offset 0x2a48
	ld hl,65535	; offset 0x2a4b
	push hl	; offset 0x2a4c
	ld hl,8190	; offset 0x2a4f
	push hl	; offset 0x2a50
	ld hl,62271	; offset 0x2a53
	push hl	; offset 0x2a54
	ld hl,50367	; offset 0x2a57
	push hl	; offset 0x2a58
	ld hl,65407	; offset 0x2a5b
	push hl	; offset 0x2a5c
	; delay to get start of scanline (-144 T-states) at offset 0x2a5c


	; src_data blit 170
	ld sp,screenStartAddr+3408	; offset 0x2a5f
	ld hl,65503	; offset 0x2a62
	push hl	; offset 0x2a63
	ld hl,65287	; offset 0x2a66
	push hl	; offset 0x2a67
	ld hl,65535	; offset 0x2a6a
	push hl	; offset 0x2a6b
	ld hl,65281	; offset 0x2a6e
	push hl	; offset 0x2a6f
	ld hl,65535	; offset 0x2a72
	push hl	; offset 0x2a73
	ld hl,65520	; offset 0x2a76
	push hl	; offset 0x2a77
	ld hl,61279	; offset 0x2a7a
	push hl	; offset 0x2a7b
	ld hl,28123	; offset 0x2a7e
	push hl	; offset 0x2a7f
	; delay to get start of scanline (-144 T-states) at offset 0x2a7f


	; src_data blit 171
	ld sp,screenStartAddr+3424	; offset 0x2a82
	ld hl,60845	; offset 0x2a85
	push hl	; offset 0x2a86
	ld hl,64761	; offset 0x2a89
	push hl	; offset 0x2a8a
	ld hl,50175	; offset 0x2a8d
	push hl	; offset 0x2a8e
	ld hl,65535	; offset 0x2a91
	push hl	; offset 0x2a92
	ld hl,4082	; offset 0x2a95
	push hl	; offset 0x2a96
	ld hl,65343	; offset 0x2a99
	push hl	; offset 0x2a9a
	ld hl,64878	; offset 0x2a9d
	push hl	; offset 0x2a9e
	ld hl,65407	; offset 0x2aa1
	push hl	; offset 0x2aa2
	; delay to get start of scanline (-144 T-states) at offset 0x2aa2


	; src_data blit 172
	ld sp,screenStartAddr+3664	; offset 0x2aa5
	ld hl,65519	; offset 0x2aa8
	push hl	; offset 0x2aa9
	ld hl,12032	; offset 0x2aac
	push hl	; offset 0x2aad
	ld hl,65535	; offset 0x2ab0
	push hl	; offset 0x2ab1
	ld hl,32515	; offset 0x2ab4
	push hl	; offset 0x2ab5
	ld hl,65535	; offset 0x2ab8
	push hl	; offset 0x2ab9
	ld hl,65528	; offset 0x2abc
	push hl	; offset 0x2abd
	ld hl,61279	; offset 0x2ac0
	push hl	; offset 0x2ac1
	ld hl,28123	; offset 0x2ac4
	push hl	; offset 0x2ac5
	; delay to get start of scanline (-144 T-states) at offset 0x2ac5


	; src_data blit 173
	ld sp,screenStartAddr+3680	; offset 0x2ac8
	ld hl,60845	; offset 0x2acb
	push hl	; offset 0x2acc
	ld hl,31993	; offset 0x2acf
	push hl	; offset 0x2ad0
	ld hl,51199	; offset 0x2ad3
	push hl	; offset 0x2ad4
	ld hl,65535	; offset 0x2ad7
	push hl	; offset 0x2ad8
	ld hl,4032	; offset 0x2adb
	push hl	; offset 0x2adc
	ld hl,65471	; offset 0x2adf
	push hl	; offset 0x2ae0
	ld hl,49374	; offset 0x2ae3
	push hl	; offset 0x2ae4
	ld hl,65151	; offset 0x2ae7
	push hl	; offset 0x2ae8
	; delay to get start of scanline (-144 T-states) at offset 0x2ae8


	; src_data blit 174
	ld sp,screenStartAddr+3920	; offset 0x2aeb
	ld hl,65463	; offset 0x2aee
	push hl	; offset 0x2aef
	ld hl,32677	; offset 0x2af2
	push hl	; offset 0x2af3
	ld hl,65535	; offset 0x2af6
	push hl	; offset 0x2af7
	ld hl,65283	; offset 0x2afa
	push hl	; offset 0x2afb
	ld hl,65535	; offset 0x2afe
	push hl	; offset 0x2aff
	ld hl,65534	; offset 0x2b02
	push hl	; offset 0x2b03
	ld hl,61279	; offset 0x2b06
	push hl	; offset 0x2b07
	ld hl,28123	; offset 0x2b0a
	push hl	; offset 0x2b0b
	; delay to get start of scanline (-144 T-states) at offset 0x2b0b


	; src_data blit 175
	ld sp,screenStartAddr+3936	; offset 0x2b0e
	ld hl,60845	; offset 0x2b11
	push hl	; offset 0x2b12
	ld hl,64761	; offset 0x2b15
	push hl	; offset 0x2b16
	ld hl,55295	; offset 0x2b19
	push hl	; offset 0x2b1a
	ld hl,65535	; offset 0x2b1d
	push hl	; offset 0x2b1e
	ld hl,3967	; offset 0x2b21
	push hl	; offset 0x2b22
	ld hl,65045	; offset 0x2b25
	push hl	; offset 0x2b26
	ld hl,55037	; offset 0x2b29
	push hl	; offset 0x2b2a
	ld hl,64895	; offset 0x2b2d
	push hl	; offset 0x2b2e
	; delay to get start of scanline (-144 T-states) at offset 0x2b2e


	; src_data blit 176
	ld sp,screenStartAddr+2160	; offset 0x2b31
	ld hl,65529	; offset 0x2b34
	push hl	; offset 0x2b35
	ld hl,30637	; offset 0x2b38
	push hl	; offset 0x2b39
	ld hl,65535	; offset 0x2b3c
	push hl	; offset 0x2b3d
	ld hl,65283	; offset 0x2b40
	push hl	; offset 0x2b41
	ld hl,65535	; offset 0x2b44
	push hl	; offset 0x2b45
	ld hl,222	; offset 0x2b48
	push hl	; offset 0x2b49
	ld hl,44895	; offset 0x2b4c
	push hl	; offset 0x2b4d
	ld hl,28123	; offset 0x2b50
	push hl	; offset 0x2b51
	; delay to get start of scanline (-144 T-states) at offset 0x2b51


	; src_data blit 177
	ld sp,screenStartAddr+2176	; offset 0x2b54
	ld hl,60845	; offset 0x2b57
	push hl	; offset 0x2b58
	ld hl,64729	; offset 0x2b5b
	push hl	; offset 0x2b5c
	ld hl,6143	; offset 0x2b5f
	push hl	; offset 0x2b60
	ld hl,65535	; offset 0x2b63
	push hl	; offset 0x2b64
	ld hl,61695	; offset 0x2b67
	push hl	; offset 0x2b68
	ld hl,64271	; offset 0x2b6b
	push hl	; offset 0x2b6c
	ld hl,55037	; offset 0x2b6f
	push hl	; offset 0x2b70
	ld hl,63359	; offset 0x2b73
	push hl	; offset 0x2b74
	; delay to get start of scanline (-144 T-states) at offset 0x2b74


	; src_data blit 178
	ld sp,screenStartAddr+2416	; offset 0x2b77
	ld hl,32766	; offset 0x2b7a
	push hl	; offset 0x2b7b
	ld hl,31726	; offset 0x2b7e
	push hl	; offset 0x2b7f
	ld hl,65535	; offset 0x2b82
	push hl	; offset 0x2b83
	ld hl,65283	; offset 0x2b86
	push hl	; offset 0x2b87
	ld hl,65535	; offset 0x2b8a
	push hl	; offset 0x2b8b
	ld hl,222	; offset 0x2b8e
	push hl	; offset 0x2b8f
	ld hl,61279	; offset 0x2b92
	push hl	; offset 0x2b93
	ld hl,28123	; offset 0x2b96
	push hl	; offset 0x2b97
	; delay to get start of scanline (-144 T-states) at offset 0x2b97


	; src_data blit 179
	ld sp,screenStartAddr+2432	; offset 0x2b9a
	ld hl,60845	; offset 0x2b9d
	push hl	; offset 0x2b9e
	ld hl,64633	; offset 0x2ba1
	push hl	; offset 0x2ba2
	ld hl,6143	; offset 0x2ba5
	push hl	; offset 0x2ba6
	ld hl,65535	; offset 0x2ba9
	push hl	; offset 0x2baa
	ld hl,61695	; offset 0x2bad
	push hl	; offset 0x2bae
	ld hl,61191	; offset 0x2bb1
	push hl	; offset 0x2bb2
	ld hl,51195	; offset 0x2bb5
	push hl	; offset 0x2bb6
	ld hl,57215	; offset 0x2bb9
	push hl	; offset 0x2bba
	; delay to get start of scanline (-144 T-states) at offset 0x2bba


	; src_data blit 180
	ld sp,screenStartAddr+2672	; offset 0x2bbd
	ld hl,53247	; offset 0x2bc0
	push hl	; offset 0x2bc1
	ld hl,27631	; offset 0x2bc4
	push hl	; offset 0x2bc5
	ld hl,65407	; offset 0x2bc8
	push hl	; offset 0x2bc9
	ld hl,63491	; offset 0x2bcc
	push hl	; offset 0x2bcd
	ld hl,65535	; offset 0x2bd0
	push hl	; offset 0x2bd1
	ld hl,95	; offset 0x2bd4
	push hl	; offset 0x2bd5
	ld hl,61271	; offset 0x2bd8
	push hl	; offset 0x2bd9
	ld hl,28123	; offset 0x2bdc
	push hl	; offset 0x2bdd
	; delay to get start of scanline (-144 T-states) at offset 0x2bdd


	; src_data blit 181
	ld sp,screenStartAddr+2688	; offset 0x2be0
	ld hl,60845	; offset 0x2be3
	push hl	; offset 0x2be4
	ld hl,64633	; offset 0x2be7
	push hl	; offset 0x2be8
	ld hl,6143	; offset 0x2beb
	push hl	; offset 0x2bec
	ld hl,65535	; offset 0x2bef
	push hl	; offset 0x2bf0
	ld hl,61695	; offset 0x2bf3
	push hl	; offset 0x2bf4
	ld hl,48927	; offset 0x2bf7
	push hl	; offset 0x2bf8
	ld hl,55294	; offset 0x2bfb
	push hl	; offset 0x2bfc
	ld hl,32636	; offset 0x2bff
	push hl	; offset 0x2c00
	; delay to get start of scanline (-144 T-states) at offset 0x2c00


	; src_data blit 182
	ld sp,screenStartAddr+2928	; offset 0x2c03
	ld hl,65279	; offset 0x2c06
	push hl	; offset 0x2c07
	ld hl,30191	; offset 0x2c0a
	push hl	; offset 0x2c0b
	ld hl,65535	; offset 0x2c0e
	push hl	; offset 0x2c0f
	ld hl,52995	; offset 0x2c12
	push hl	; offset 0x2c13
	ld hl,65535	; offset 0x2c16
	push hl	; offset 0x2c17
	ld hl,32863	; offset 0x2c1a
	push hl	; offset 0x2c1b
	ld hl,61279	; offset 0x2c1e
	push hl	; offset 0x2c1f
	ld hl,28123	; offset 0x2c22
	push hl	; offset 0x2c23
	; delay to get start of scanline (-144 T-states) at offset 0x2c23


	; src_data blit 183
	ld sp,screenStartAddr+2944	; offset 0x2c26
	ld hl,60845	; offset 0x2c29
	push hl	; offset 0x2c2a
	ld hl,62585	; offset 0x2c2d
	push hl	; offset 0x2c2e
	ld hl,38911	; offset 0x2c31
	push hl	; offset 0x2c32
	ld hl,65535	; offset 0x2c35
	push hl	; offset 0x2c36
	ld hl,61695	; offset 0x2c39
	push hl	; offset 0x2c3a
	ld hl,65327	; offset 0x2c3d
	push hl	; offset 0x2c3e
	ld hl,63221	; offset 0x2c41
	push hl	; offset 0x2c42
	ld hl,65407	; offset 0x2c45
	push hl	; offset 0x2c46
	; delay to get start of scanline (-144 T-states) at offset 0x2c46


	; src_data blit 184
	ld sp,screenStartAddr+3184	; offset 0x2c49
	ld hl,65535	; offset 0x2c4c
	push hl	; offset 0x2c4d
	ld hl,64447	; offset 0x2c50
	push hl	; offset 0x2c51
	ld hl,65535	; offset 0x2c54
	push hl	; offset 0x2c55
	ld hl,32515	; offset 0x2c58
	push hl	; offset 0x2c59
	ld hl,65535	; offset 0x2c5c
	push hl	; offset 0x2c5d
	ld hl,32863	; offset 0x2c60
	push hl	; offset 0x2c61
	ld hl,61279	; offset 0x2c64
	push hl	; offset 0x2c65
	ld hl,28123	; offset 0x2c68
	push hl	; offset 0x2c69
	; delay to get start of scanline (-144 T-states) at offset 0x2c69


	; src_data blit 185
	ld sp,screenStartAddr+3200	; offset 0x2c6c
	ld hl,60845	; offset 0x2c6f
	push hl	; offset 0x2c70
	ld hl,62553	; offset 0x2c73
	push hl	; offset 0x2c74
	ld hl,38911	; offset 0x2c77
	push hl	; offset 0x2c78
	ld hl,65535	; offset 0x2c7b
	push hl	; offset 0x2c7c
	ld hl,61668	; offset 0x2c7f
	push hl	; offset 0x2c80
	ld hl,65319	; offset 0x2c83
	push hl	; offset 0x2c84
	ld hl,63487	; offset 0x2c87
	push hl	; offset 0x2c88
	ld hl,65407	; offset 0x2c8b
	push hl	; offset 0x2c8c
	; delay to get start of scanline (-144 T-states) at offset 0x2c8c


	; src_data blit 186
	ld sp,screenStartAddr+3440	; offset 0x2c8f
	ld hl,65535	; offset 0x2c92
	push hl	; offset 0x2c93
	ld hl,64431	; offset 0x2c96
	push hl	; offset 0x2c97
	ld hl,61439	; offset 0x2c9a
	push hl	; offset 0x2c9b
	ld hl,65283	; offset 0x2c9e
	push hl	; offset 0x2c9f
	ld hl,65535	; offset 0x2ca2
	push hl	; offset 0x2ca3
	ld hl,49375	; offset 0x2ca6
	push hl	; offset 0x2ca7
	ld hl,61007	; offset 0x2caa
	push hl	; offset 0x2cab
	ld hl,28123	; offset 0x2cae
	push hl	; offset 0x2caf
	; delay to get start of scanline (-144 T-states) at offset 0x2caf


	; src_data blit 187
	ld sp,screenStartAddr+3456	; offset 0x2cb2
	ld hl,60845	; offset 0x2cb5
	push hl	; offset 0x2cb6
	ld hl,64633	; offset 0x2cb9
	push hl	; offset 0x2cba
	ld hl,38399	; offset 0x2cbd
	push hl	; offset 0x2cbe
	ld hl,65535	; offset 0x2cc1
	push hl	; offset 0x2cc2
	ld hl,61695	; offset 0x2cc5
	push hl	; offset 0x2cc6
	ld hl,65295	; offset 0x2cc9
	push hl	; offset 0x2cca
	ld hl,65531	; offset 0x2ccd
	push hl	; offset 0x2cce
	ld hl,65407	; offset 0x2cd1
	push hl	; offset 0x2cd2
	; delay to get start of scanline (-144 T-states) at offset 0x2cd2


	; src_data blit 188
	ld sp,screenStartAddr+3696	; offset 0x2cd5
	ld hl,65535	; offset 0x2cd8
	push hl	; offset 0x2cd9
	ld hl,65327	; offset 0x2cdc
	push hl	; offset 0x2cdd
	ld hl,63359	; offset 0x2ce0
	push hl	; offset 0x2ce1
	ld hl,32769	; offset 0x2ce4
	push hl	; offset 0x2ce5
	ld hl,65535	; offset 0x2ce8
	push hl	; offset 0x2ce9
	ld hl,49247	; offset 0x2cec
	push hl	; offset 0x2ced
	ld hl,28502	; offset 0x2cf0
	push hl	; offset 0x2cf1
	ld hl,28123	; offset 0x2cf4
	push hl	; offset 0x2cf5
	; delay to get start of scanline (-144 T-states) at offset 0x2cf5


	; src_data blit 189
	ld sp,screenStartAddr+3712	; offset 0x2cf8
	ld hl,60845	; offset 0x2cfb
	push hl	; offset 0x2cfc
	ld hl,64601	; offset 0x2cff
	push hl	; offset 0x2d00
	ld hl,38399	; offset 0x2d03
	push hl	; offset 0x2d04
	ld hl,65535	; offset 0x2d07
	push hl	; offset 0x2d08
	ld hl,61695	; offset 0x2d0b
	push hl	; offset 0x2d0c
	ld hl,65303	; offset 0x2d0f
	push hl	; offset 0x2d10
	ld hl,63231	; offset 0x2d13
	push hl	; offset 0x2d14
	ld hl,65407	; offset 0x2d17
	push hl	; offset 0x2d18
	; delay to get start of scanline (-144 T-states) at offset 0x2d18


	; src_data blit 190
	ld sp,screenStartAddr+3952	; offset 0x2d1b
	ld hl,65407	; offset 0x2d1e
	push hl	; offset 0x2d1f
	ld hl,65327	; offset 0x2d22
	push hl	; offset 0x2d23
	ld hl,47871	; offset 0x2d26
	push hl	; offset 0x2d27
	ld hl,16129	; offset 0x2d2a
	push hl	; offset 0x2d2b
	ld hl,65535	; offset 0x2d2e
	push hl	; offset 0x2d2f
	ld hl,49247	; offset 0x2d32
	push hl	; offset 0x2d33
	ld hl,42845	; offset 0x2d36
	push hl	; offset 0x2d37
	ld hl,28123	; offset 0x2d3a
	push hl	; offset 0x2d3b
	; delay to get start of scanline (-144 T-states) at offset 0x2d3b


	; src_data blit 191
	ld sp,screenStartAddr+3968	; offset 0x2d3e
	ld hl,60845	; offset 0x2d41
	push hl	; offset 0x2d42
	ld hl,31833	; offset 0x2d45
	push hl	; offset 0x2d46
	ld hl,38399	; offset 0x2d49
	push hl	; offset 0x2d4a
	ld hl,65535	; offset 0x2d4d
	push hl	; offset 0x2d4e
	ld hl,61695	; offset 0x2d51
	push hl	; offset 0x2d52
	ld hl,65309	; offset 0x2d55
	push hl	; offset 0x2d56
	ld hl,65471	; offset 0x2d59
	push hl	; offset 0x2d5a
	ld hl,65535	; offset 0x2d5d
	push hl	; offset 0x2d5e
	; delay to get start of scanline (-144 T-states) at offset 0x2d5e


	; src_data blit 192
	ld sp,screenStartAddr+2192	; offset 0x2d61
	ld hl,65503	; offset 0x2d64
	push hl	; offset 0x2d65
	ld hl,61247	; offset 0x2d68
	push hl	; offset 0x2d69
	ld hl,59135	; offset 0x2d6c
	push hl	; offset 0x2d6d
	ld hl,65287	; offset 0x2d70
	push hl	; offset 0x2d71
	ld hl,65535	; offset 0x2d74
	push hl	; offset 0x2d75
	ld hl,49375	; offset 0x2d78
	push hl	; offset 0x2d79
	ld hl,42955	; offset 0x2d7c
	push hl	; offset 0x2d7d
	ld hl,28123	; offset 0x2d80
	push hl	; offset 0x2d81
	; delay to get start of scanline (-144 T-states) at offset 0x2d81


	; src_data blit 193
	ld sp,screenStartAddr+2208	; offset 0x2d84
	ld hl,60845	; offset 0x2d87
	push hl	; offset 0x2d88
	ld hl,60537	; offset 0x2d8b
	push hl	; offset 0x2d8c
	ld hl,38399	; offset 0x2d8f
	push hl	; offset 0x2d90
	ld hl,255	; offset 0x2d93
	push hl	; offset 0x2d94
	ld hl,61695	; offset 0x2d97
	push hl	; offset 0x2d98
	ld hl,32671	; offset 0x2d9b
	push hl	; offset 0x2d9c
	ld hl,65407	; offset 0x2d9f
	push hl	; offset 0x2da0
	ld hl,65279	; offset 0x2da3
	push hl	; offset 0x2da4
	; delay to get start of scanline (-144 T-states) at offset 0x2da4


	; src_data blit 194
	ld sp,screenStartAddr+2448	; offset 0x2da7
	ld hl,65527	; offset 0x2daa
	push hl	; offset 0x2dab
	ld hl,63263	; offset 0x2dae
	push hl	; offset 0x2daf
	ld hl,61695	; offset 0x2db2
	push hl	; offset 0x2db3
	ld hl,3847	; offset 0x2db6
	push hl	; offset 0x2db7
	ld hl,65535	; offset 0x2dba
	push hl	; offset 0x2dbb
	ld hl,49407	; offset 0x2dbe
	push hl	; offset 0x2dbf
	ld hl,453	; offset 0x2dc2
	push hl	; offset 0x2dc3
	ld hl,28123	; offset 0x2dc6
	push hl	; offset 0x2dc7
	; delay to get start of scanline (-144 T-states) at offset 0x2dc7


	; src_data blit 195
	ld sp,screenStartAddr+2464	; offset 0x2dca
	ld hl,60845	; offset 0x2dcd
	push hl	; offset 0x2dce
	ld hl,21752	; offset 0x2dd1
	push hl	; offset 0x2dd2
	ld hl,38911	; offset 0x2dd5
	push hl	; offset 0x2dd6
	ld hl,255	; offset 0x2dd9
	push hl	; offset 0x2dda
	ld hl,61695	; offset 0x2ddd
	push hl	; offset 0x2dde
	ld hl,65295	; offset 0x2de1
	push hl	; offset 0x2de2
	ld hl,65533	; offset 0x2de5
	push hl	; offset 0x2de6
	ld hl,64895	; offset 0x2de9
	push hl	; offset 0x2dea
	; delay to get start of scanline (-144 T-states) at offset 0x2dea


	; src_data blit 196
	ld sp,screenStartAddr+2704	; offset 0x2ded
	ld hl,65468	; offset 0x2df0
	push hl	; offset 0x2df1
	ld hl,65295	; offset 0x2df4
	push hl	; offset 0x2df5
	ld hl,65279	; offset 0x2df8
	push hl	; offset 0x2df9
	ld hl,65295	; offset 0x2dfc
	push hl	; offset 0x2dfd
	ld hl,65535	; offset 0x2e00
	push hl	; offset 0x2e01
	ld hl,49215	; offset 0x2e04
	push hl	; offset 0x2e05
	ld hl,63709	; offset 0x2e08
	push hl	; offset 0x2e09
	ld hl,28123	; offset 0x2e0c
	push hl	; offset 0x2e0d
	; delay to get start of scanline (-144 T-states) at offset 0x2e0d


	; src_data blit 197
	ld sp,screenStartAddr+2720	; offset 0x2e10
	ld hl,60845	; offset 0x2e13
	push hl	; offset 0x2e14
	ld hl,1087	; offset 0x2e17
	push hl	; offset 0x2e18
	ld hl,38655	; offset 0x2e1b
	push hl	; offset 0x2e1c
	ld hl,255	; offset 0x2e1f
	push hl	; offset 0x2e20
	ld hl,61695	; offset 0x2e23
	push hl	; offset 0x2e24
	ld hl,57095	; offset 0x2e27
	push hl	; offset 0x2e28
	ld hl,65215	; offset 0x2e2b
	push hl	; offset 0x2e2c
	ld hl,53119	; offset 0x2e2f
	push hl	; offset 0x2e30
	; delay to get start of scanline (-144 T-states) at offset 0x2e30


	; src_data blit 198
	ld sp,screenStartAddr+2960	; offset 0x2e33
	ld hl,53215	; offset 0x2e36
	push hl	; offset 0x2e37
	ld hl,65311	; offset 0x2e3a
	push hl	; offset 0x2e3b
	ld hl,65279	; offset 0x2e3e
	push hl	; offset 0x2e3f
	ld hl,65287	; offset 0x2e42
	push hl	; offset 0x2e43
	ld hl,65535	; offset 0x2e46
	push hl	; offset 0x2e47
	ld hl,49279	; offset 0x2e4a
	push hl	; offset 0x2e4b
	ld hl,65499	; offset 0x2e4e
	push hl	; offset 0x2e4f
	ld hl,28123	; offset 0x2e52
	push hl	; offset 0x2e53
	; delay to get start of scanline (-144 T-states) at offset 0x2e53


	; src_data blit 199
	ld sp,screenStartAddr+2976	; offset 0x2e56
	ld hl,60845	; offset 0x2e59
	push hl	; offset 0x2e5a
	ld hl,13503	; offset 0x2e5d
	push hl	; offset 0x2e5e
	ld hl,38399	; offset 0x2e61
	push hl	; offset 0x2e62
	ld hl,255	; offset 0x2e65
	push hl	; offset 0x2e66
	ld hl,61695	; offset 0x2e69
	push hl	; offset 0x2e6a
	ld hl,32515	; offset 0x2e6d
	push hl	; offset 0x2e6e
	ld hl,63487	; offset 0x2e71
	push hl	; offset 0x2e72
	ld hl,65276	; offset 0x2e75
	push hl	; offset 0x2e76
	; delay to get start of scanline (-144 T-states) at offset 0x2e76


	; src_data blit 200
	ld sp,screenStartAddr+3216	; offset 0x2e79
	ld hl,65395	; offset 0x2e7c
	push hl	; offset 0x2e7d
	ld hl,65309	; offset 0x2e80
	push hl	; offset 0x2e81
	ld hl,65535	; offset 0x2e84
	push hl	; offset 0x2e85
	ld hl,53007	; offset 0x2e88
	push hl	; offset 0x2e89
	ld hl,65535	; offset 0x2e8c
	push hl	; offset 0x2e8d
	ld hl,49279	; offset 0x2e90
	push hl	; offset 0x2e91
	ld hl,62431	; offset 0x2e94
	push hl	; offset 0x2e95
	ld hl,28123	; offset 0x2e98
	push hl	; offset 0x2e99
	; delay to get start of scanline (-144 T-states) at offset 0x2e99


	; src_data blit 201
	ld sp,screenStartAddr+3232	; offset 0x2e9c
	ld hl,60845	; offset 0x2e9f
	push hl	; offset 0x2ea0
	ld hl,21675	; offset 0x2ea3
	push hl	; offset 0x2ea4
	ld hl,38399	; offset 0x2ea7
	push hl	; offset 0x2ea8
	ld hl,255	; offset 0x2eab
	push hl	; offset 0x2eac
	ld hl,61695	; offset 0x2eaf
	push hl	; offset 0x2eb0
	ld hl,65283	; offset 0x2eb3
	push hl	; offset 0x2eb4
	ld hl,62463	; offset 0x2eb7
	push hl	; offset 0x2eb8
	ld hl,64511	; offset 0x2ebb
	push hl	; offset 0x2ebc
	; delay to get start of scanline (-144 T-states) at offset 0x2ebc


	; src_data blit 202
	ld sp,screenStartAddr+3472	; offset 0x2ebf
	ld hl,65470	; offset 0x2ec2
	push hl	; offset 0x2ec3
	ld hl,65295	; offset 0x2ec6
	push hl	; offset 0x2ec7
	ld hl,65279	; offset 0x2eca
	push hl	; offset 0x2ecb
	ld hl,32519	; offset 0x2ece
	push hl	; offset 0x2ecf
	ld hl,65535	; offset 0x2ed2
	push hl	; offset 0x2ed3
	ld hl,49263	; offset 0x2ed6
	push hl	; offset 0x2ed7
	ld hl,65503	; offset 0x2eda
	push hl	; offset 0x2edb
	ld hl,28123	; offset 0x2ede
	push hl	; offset 0x2edf
	; delay to get start of scanline (-144 T-states) at offset 0x2edf

	; Jump to second half of frame render (normally jumps back to pop_push_even, and MCU swaps 	; buffer pointer so new command list exists in same memory space)
	ld a,(0x3ffd)	; This informs ROM we need the bank for the second half of the screen (racing the beam)
	jp fake_jmp
fake_jmp:

	; Restore the stack pointer
	ld sp,(spBackupAddr)	; offset 0x2ee5
	ret

	SAVEBIN "sp48.rom",0,$
