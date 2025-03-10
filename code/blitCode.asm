pop_push_even:
	ld (spBackupAddr),sp

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay0:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay0
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay1:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay1
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay2:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay2
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay3:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay3
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay4:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay4
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay5:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay5
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay6:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay6
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay7:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay7
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay8:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay8
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay9:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay9
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay10:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay10
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay11:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay11
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (5000 T-states)
	ld b,172
ppe_scan_delay12:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay12
		; 10 T-states remaining
	nop   	; 6 T-states remaining
	nop   	; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (2000 T-states)
	ld b,69
ppe_scan_delay13:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay13
		; 2 T-states remaining
	nop   	; -2 T-states remaining

	;Beam chasing starts NOW!

	; delay to get start of scanline (672 T-states)
	ld b,23
ppe_scan_delay14:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay14
		; 8 T-states remaining
	nop   	; 4 T-states remaining
	nop   	; 0 T-states remaining

	;Beam chasing starts NOW!

	; src_attr_data blit 0
	ld bc,3598	; offset 0
	ld de,3598	; offset 3
	ld hl,3598	; offset 6
	exx    	; offset 9
	ld bc,3598	; offset 10
	ld de,3598	; offset 13
	ld hl,3598	; offset 16
	ld sp,attrStartAddr+12	; offset 19
	push hl	; offset 22
	push de	; offset 23
	push bc	; offset 24
	exx    	; offset 25
	push hl	; offset 26
	push de	; offset 27
	push bc	; offset 28

	; src_attr_data blit 1
	ld bc,3598	; offset 29
	ld de,3598	; offset 32
	ld hl,3598	; offset 35
	exx    	; offset 38
	ld bc,3598	; offset 39
	ld de,3598	; offset 42
	ld hl,3598	; offset 45
	ld sp,attrStartAddr+24	; offset 48
	push hl	; offset 51
	push de	; offset 52
	push bc	; offset 53
	exx    	; offset 54
	push hl	; offset 55
	push de	; offset 56
	push bc	; offset 57

	; src_attr_data blit 2
	ld bc,3598	; offset 58
	ld de,3598	; offset 61
	ld hl,3598	; offset 64
	exx    	; offset 67
	ld bc,3598	; offset 68
	ld de,3598	; offset 71
	ld hl,3598	; offset 74
	ld sp,attrStartAddr+36	; offset 77
	push hl	; offset 80
	push de	; offset 81
	push bc	; offset 82
	exx    	; offset 83
	push hl	; offset 84
	push de	; offset 85
	push bc	; offset 86

	; src_attr_data blit 3
	ld bc,3598	; offset 87
	ld de,3598	; offset 90
	ld hl,3598	; offset 93
	exx    	; offset 96
	ld bc,3598	; offset 97
	ld de,3598	; offset 100
	ld hl,3598	; offset 103
	ld sp,attrStartAddr+48	; offset 106
	push hl	; offset 109
	push de	; offset 110
	push bc	; offset 111
	exx    	; offset 112
	push hl	; offset 113
	push de	; offset 114
	push bc	; offset 115

	; src_attr_data blit 4
	ld bc,3598	; offset 116
	ld de,3598	; offset 119
	ld hl,3598	; offset 122
	exx    	; offset 125
	ld bc,3598	; offset 126
	ld de,3598	; offset 129
	ld hl,3598	; offset 132
	ld sp,attrStartAddr+60	; offset 135
	push hl	; offset 138
	push de	; offset 139
	push bc	; offset 140
	exx    	; offset 141
	push hl	; offset 142
	push de	; offset 143
	push bc	; offset 144

	; src_attr_data blit 5
	ld bc,3598	; offset 145
	ld de,3598	; offset 148
	ld hl,3598	; offset 151
	exx    	; offset 154
	ld bc,3598	; offset 155
	ld de,3598	; offset 158
	ld hl,3598	; offset 161
	ld sp,attrStartAddr+72	; offset 164
	push hl	; offset 167
	push de	; offset 168
	push bc	; offset 169
	exx    	; offset 170
	push hl	; offset 171
	push de	; offset 172
	push bc	; offset 173

	; src_attr_data blit 6
	ld bc,3598	; offset 174
	ld de,3598	; offset 177
	ld hl,3598	; offset 180
	exx    	; offset 183
	ld bc,3598	; offset 184
	ld de,3598	; offset 187
	ld hl,3598	; offset 190
	ld sp,attrStartAddr+84	; offset 193
	push hl	; offset 196
	push de	; offset 197
	push bc	; offset 198
	exx    	; offset 199
	push hl	; offset 200
	push de	; offset 201
	push bc	; offset 202

	; src_attr_data blit 7
	ld bc,3598	; offset 203
	ld de,3598	; offset 206
	ld hl,3598	; offset 209
	exx    	; offset 212
	ld bc,3598	; offset 213
	ld de,3598	; offset 216
	ld hl,3598	; offset 219
	ld sp,attrStartAddr+96	; offset 222
	push hl	; offset 225
	push de	; offset 226
	push bc	; offset 227
	exx    	; offset 228
	push hl	; offset 229
	push de	; offset 230
	push bc	; offset 231

	; src_attr_data blit 8
	ld bc,3598	; offset 232
	ld de,3598	; offset 235
	ld hl,3598	; offset 238
	exx    	; offset 241
	ld bc,3598	; offset 242
	ld de,3598	; offset 245
	ld hl,3598	; offset 248
	ld sp,attrStartAddr+108	; offset 251
	push hl	; offset 254
	push de	; offset 255
	push bc	; offset 256
	exx    	; offset 257
	push hl	; offset 258
	push de	; offset 259
	push bc	; offset 260

	; src_attr_data blit 9
	ld bc,3598	; offset 261
	ld de,3598	; offset 264
	ld hl,3598	; offset 267
	exx    	; offset 270
	ld bc,3598	; offset 271
	ld de,3598	; offset 274
	ld hl,3598	; offset 277
	ld sp,attrStartAddr+120	; offset 280
	push hl	; offset 283
	push de	; offset 284
	push bc	; offset 285
	exx    	; offset 286
	push hl	; offset 287
	push de	; offset 288
	push bc	; offset 289

	; src_attr_data blit 10
	ld bc,3598	; offset 290
	ld de,3598	; offset 293
	ld hl,3598	; offset 296
	exx    	; offset 299
	ld bc,3598	; offset 300
	ld de,3598	; offset 303
	ld hl,3598	; offset 306
	ld sp,attrStartAddr+132	; offset 309
	push hl	; offset 312
	push de	; offset 313
	push bc	; offset 314
	exx    	; offset 315
	push hl	; offset 316
	push de	; offset 317
	push bc	; offset 318

	; src_attr_data blit 11
	ld bc,3598	; offset 319
	ld de,3598	; offset 322
	ld hl,3598	; offset 325
	exx    	; offset 328
	ld bc,3598	; offset 329
	ld de,3598	; offset 332
	ld hl,3598	; offset 335
	ld sp,attrStartAddr+144	; offset 338
	push hl	; offset 341
	push de	; offset 342
	push bc	; offset 343
	exx    	; offset 344
	push hl	; offset 345
	push de	; offset 346
	push bc	; offset 347

	; src_attr_data blit 12
	ld bc,3598	; offset 348
	ld de,3598	; offset 351
	ld hl,3598	; offset 354
	exx    	; offset 357
	ld bc,3598	; offset 358
	ld de,3598	; offset 361
	ld hl,3598	; offset 364
	ld sp,attrStartAddr+156	; offset 367
	push hl	; offset 370
	push de	; offset 371
	push bc	; offset 372
	exx    	; offset 373
	push hl	; offset 374
	push de	; offset 375
	push bc	; offset 376

	; src_attr_data blit 13
	ld bc,3598	; offset 377
	ld de,3598	; offset 380
	ld hl,3598	; offset 383
	exx    	; offset 386
	ld bc,3598	; offset 387
	ld de,3598	; offset 390
	ld hl,3598	; offset 393
	ld sp,attrStartAddr+168	; offset 396
	push hl	; offset 399
	push de	; offset 400
	push bc	; offset 401
	exx    	; offset 402
	push hl	; offset 403
	push de	; offset 404
	push bc	; offset 405

	; src_attr_data blit 14
	ld bc,3598	; offset 406
	ld de,3598	; offset 409
	ld hl,3598	; offset 412
	exx    	; offset 415
	ld bc,3598	; offset 416
	ld de,3598	; offset 419
	ld hl,3598	; offset 422
	ld sp,attrStartAddr+180	; offset 425
	push hl	; offset 428
	push de	; offset 429
	push bc	; offset 430
	exx    	; offset 431
	push hl	; offset 432
	push de	; offset 433
	push bc	; offset 434

	; src_attr_data blit 15
	ld bc,3598	; offset 435
	ld de,3598	; offset 438
	ld hl,3598	; offset 441
	exx    	; offset 444
	ld bc,3598	; offset 445
	ld de,3598	; offset 448
	ld hl,3598	; offset 451
	ld sp,attrStartAddr+192	; offset 454
	push hl	; offset 457
	push de	; offset 458
	push bc	; offset 459
	exx    	; offset 460
	push hl	; offset 461
	push de	; offset 462
	push bc	; offset 463

	; src_attr_data blit 16
	ld bc,3598	; offset 464
	ld de,3598	; offset 467
	ld hl,3598	; offset 470
	exx    	; offset 473
	ld bc,3598	; offset 474
	ld de,3598	; offset 477
	ld hl,3598	; offset 480
	ld sp,attrStartAddr+204	; offset 483
	push hl	; offset 486
	push de	; offset 487
	push bc	; offset 488
	exx    	; offset 489
	push hl	; offset 490
	push de	; offset 491
	push bc	; offset 492

	; src_attr_data blit 17
	ld bc,3598	; offset 493
	ld de,3598	; offset 496
	ld hl,3598	; offset 499
	exx    	; offset 502
	ld bc,3598	; offset 503
	ld de,3598	; offset 506
	ld hl,3598	; offset 509
	ld sp,attrStartAddr+216	; offset 512
	push hl	; offset 515
	push de	; offset 516
	push bc	; offset 517
	exx    	; offset 518
	push hl	; offset 519
	push de	; offset 520
	push bc	; offset 521

	; src_attr_data blit 18
	ld bc,3598	; offset 522
	ld de,3598	; offset 525
	ld hl,3598	; offset 528
	exx    	; offset 531
	ld bc,3598	; offset 532
	ld de,3598	; offset 535
	ld hl,3598	; offset 538
	ld sp,attrStartAddr+228	; offset 541
	push hl	; offset 544
	push de	; offset 545
	push bc	; offset 546
	exx    	; offset 547
	push hl	; offset 548
	push de	; offset 549
	push bc	; offset 550

	; src_attr_data blit 19
	ld bc,3598	; offset 551
	ld de,3598	; offset 554
	ld hl,3598	; offset 557
	exx    	; offset 560
	ld bc,3598	; offset 561
	ld de,3598	; offset 564
	ld hl,3598	; offset 567
	ld sp,attrStartAddr+240	; offset 570
	push hl	; offset 573
	push de	; offset 574
	push bc	; offset 575
	exx    	; offset 576
	push hl	; offset 577
	push de	; offset 578
	push bc	; offset 579

	; src_attr_data blit 20
	ld bc,3598	; offset 580
	ld de,3598	; offset 583
	ld hl,3598	; offset 586
	exx    	; offset 589
	ld bc,3598	; offset 590
	ld de,3598	; offset 593
	ld hl,3598	; offset 596
	ld sp,attrStartAddr+252	; offset 599
	push hl	; offset 602
	push de	; offset 603
	push bc	; offset 604
	exx    	; offset 605
	push hl	; offset 606
	push de	; offset 607
	push bc	; offset 608

	; src_attr_data blit 21
	ld bc,3598	; offset 609
	ld de,3598	; offset 612
	ld hl,3598	; offset 615
	exx    	; offset 618
	ld bc,3598	; offset 619
	ld de,3598	; offset 622
	ld hl,3598	; offset 625
	ld sp,attrStartAddr+264	; offset 628
	push hl	; offset 631
	push de	; offset 632
	push bc	; offset 633
	exx    	; offset 634
	push hl	; offset 635
	push de	; offset 636
	push bc	; offset 637

	; src_attr_data blit 22
	ld bc,3598	; offset 638
	ld de,3598	; offset 641
	ld hl,3598	; offset 644
	exx    	; offset 647
	ld bc,3598	; offset 648
	ld de,3598	; offset 651
	ld hl,3598	; offset 654
	ld sp,attrStartAddr+276	; offset 657
	push hl	; offset 660
	push de	; offset 661
	push bc	; offset 662
	exx    	; offset 663
	push hl	; offset 664
	push de	; offset 665
	push bc	; offset 666

	; src_attr_data blit 23
	ld bc,3598	; offset 667
	ld de,3598	; offset 670
	ld hl,3598	; offset 673
	exx    	; offset 676
	ld bc,3598	; offset 677
	ld de,3598	; offset 680
	ld hl,3598	; offset 683
	ld sp,attrStartAddr+288	; offset 686
	push hl	; offset 689
	push de	; offset 690
	push bc	; offset 691
	exx    	; offset 692
	push hl	; offset 693
	push de	; offset 694
	push bc	; offset 695

	; src_attr_data blit 24
	ld bc,3598	; offset 696
	ld de,3598	; offset 699
	ld hl,3598	; offset 702
	exx    	; offset 705
	ld bc,3598	; offset 706
	ld de,3598	; offset 709
	ld hl,3598	; offset 712
	ld sp,attrStartAddr+300	; offset 715
	push hl	; offset 718
	push de	; offset 719
	push bc	; offset 720
	exx    	; offset 721
	push hl	; offset 722
	push de	; offset 723
	push bc	; offset 724

	; src_attr_data blit 25
	ld bc,3598	; offset 725
	ld de,3598	; offset 728
	ld hl,3598	; offset 731
	exx    	; offset 734
	ld bc,3598	; offset 735
	ld de,3598	; offset 738
	ld hl,3598	; offset 741
	ld sp,attrStartAddr+312	; offset 744
	push hl	; offset 747
	push de	; offset 748
	push bc	; offset 749
	exx    	; offset 750
	push hl	; offset 751
	push de	; offset 752
	push bc	; offset 753

	; src_attr_data blit 26
	ld bc,3598	; offset 754
	ld de,3598	; offset 757
	ld hl,3598	; offset 760
	exx    	; offset 763
	ld bc,3598	; offset 764
	ld de,3598	; offset 767
	ld hl,3598	; offset 770
	ld sp,attrStartAddr+324	; offset 773
	push hl	; offset 776
	push de	; offset 777
	push bc	; offset 778
	exx    	; offset 779
	push hl	; offset 780
	push de	; offset 781
	push bc	; offset 782

	; src_attr_data blit 27
	ld bc,3598	; offset 783
	ld de,3598	; offset 786
	ld hl,3598	; offset 789
	exx    	; offset 792
	ld bc,3598	; offset 793
	ld de,3598	; offset 796
	ld hl,3598	; offset 799
	ld sp,attrStartAddr+336	; offset 802
	push hl	; offset 805
	push de	; offset 806
	push bc	; offset 807
	exx    	; offset 808
	push hl	; offset 809
	push de	; offset 810
	push bc	; offset 811

	; src_attr_data blit 28
	ld bc,3598	; offset 812
	ld de,3598	; offset 815
	ld hl,3598	; offset 818
	exx    	; offset 821
	ld bc,3598	; offset 822
	ld de,3598	; offset 825
	ld hl,3598	; offset 828
	ld sp,attrStartAddr+348	; offset 831
	push hl	; offset 834
	push de	; offset 835
	push bc	; offset 836
	exx    	; offset 837
	push hl	; offset 838
	push de	; offset 839
	push bc	; offset 840

	; src_attr_data blit 29
	ld bc,3598	; offset 841
	ld de,3598	; offset 844
	ld hl,3598	; offset 847
	exx    	; offset 850
	ld bc,3598	; offset 851
	ld de,3598	; offset 854
	ld hl,3598	; offset 857
	ld sp,attrStartAddr+360	; offset 860
	push hl	; offset 863
	push de	; offset 864
	push bc	; offset 865
	exx    	; offset 866
	push hl	; offset 867
	push de	; offset 868
	push bc	; offset 869

	; src_attr_data blit 30
	ld bc,3598	; offset 870
	ld de,3598	; offset 873
	ld hl,3598	; offset 876
	exx    	; offset 879
	ld bc,3598	; offset 880
	ld de,3598	; offset 883
	ld hl,3598	; offset 886
	ld sp,attrStartAddr+372	; offset 889
	push hl	; offset 892
	push de	; offset 893
	push bc	; offset 894
	exx    	; offset 895
	push hl	; offset 896
	push de	; offset 897
	push bc	; offset 898

	; src_attr_data blit 31
	ld bc,3598	; offset 899
	ld de,3598	; offset 902
	ld hl,3598	; offset 905
	exx    	; offset 908
	ld bc,3598	; offset 909
	ld de,3598	; offset 912
	ld hl,3598	; offset 915
	ld sp,attrStartAddr+384	; offset 918
	push hl	; offset 921
	push de	; offset 922
	push bc	; offset 923
	exx    	; offset 924
	push hl	; offset 925
	push de	; offset 926
	push bc	; offset 927

	; src_attr_data blit 32
	ld bc,3598	; offset 928
	ld de,3598	; offset 931
	ld hl,3598	; offset 934
	exx    	; offset 937
	ld bc,3598	; offset 938
	ld de,3598	; offset 941
	ld hl,3598	; offset 944
	ld sp,attrStartAddr+396	; offset 947
	push hl	; offset 950
	push de	; offset 951
	push bc	; offset 952
	exx    	; offset 953
	push hl	; offset 954
	push de	; offset 955
	push bc	; offset 956

	; src_attr_data blit 33
	ld bc,3598	; offset 957
	ld de,3598	; offset 960
	ld hl,3598	; offset 963
	exx    	; offset 966
	ld bc,3598	; offset 967
	ld de,3598	; offset 970
	ld hl,3598	; offset 973
	ld sp,attrStartAddr+408	; offset 976
	push hl	; offset 979
	push de	; offset 980
	push bc	; offset 981
	exx    	; offset 982
	push hl	; offset 983
	push de	; offset 984
	push bc	; offset 985

	; src_attr_data blit 34
	ld bc,3598	; offset 986
	ld de,3598	; offset 989
	ld hl,3598	; offset 992
	exx    	; offset 995
	ld bc,3598	; offset 996
	ld de,3598	; offset 999
	ld hl,3598	; offset 1002
	ld sp,attrStartAddr+420	; offset 1005
	push hl	; offset 1008
	push de	; offset 1009
	push bc	; offset 1010
	exx    	; offset 1011
	push hl	; offset 1012
	push de	; offset 1013
	push bc	; offset 1014

	; src_attr_data blit 35
	ld bc,3598	; offset 1015
	ld de,3598	; offset 1018
	ld hl,3598	; offset 1021
	exx    	; offset 1024
	ld bc,3598	; offset 1025
	ld de,3598	; offset 1028
	ld hl,3598	; offset 1031
	ld sp,attrStartAddr+432	; offset 1034
	push hl	; offset 1037
	push de	; offset 1038
	push bc	; offset 1039
	exx    	; offset 1040
	push hl	; offset 1041
	push de	; offset 1042
	push bc	; offset 1043

	; src_attr_data blit 36
	ld bc,3598	; offset 1044
	ld de,3598	; offset 1047
	ld hl,3598	; offset 1050
	exx    	; offset 1053
	ld bc,3598	; offset 1054
	ld de,3598	; offset 1057
	ld hl,3598	; offset 1060
	ld sp,attrStartAddr+444	; offset 1063
	push hl	; offset 1066
	push de	; offset 1067
	push bc	; offset 1068
	exx    	; offset 1069
	push hl	; offset 1070
	push de	; offset 1071
	push bc	; offset 1072

	; src_attr_data blit 37
	ld bc,3598	; offset 1073
	ld de,3598	; offset 1076
	ld hl,3598	; offset 1079
	exx    	; offset 1082
	ld bc,3598	; offset 1083
	ld de,3598	; offset 1086
	ld hl,3598	; offset 1089
	ld sp,attrStartAddr+456	; offset 1092
	push hl	; offset 1095
	push de	; offset 1096
	push bc	; offset 1097
	exx    	; offset 1098
	push hl	; offset 1099
	push de	; offset 1100
	push bc	; offset 1101

	; src_attr_data blit 38
	ld bc,3598	; offset 1102
	ld de,3598	; offset 1105
	ld hl,3598	; offset 1108
	exx    	; offset 1111
	ld bc,3598	; offset 1112
	ld de,3598	; offset 1115
	ld hl,3598	; offset 1118
	ld sp,attrStartAddr+468	; offset 1121
	push hl	; offset 1124
	push de	; offset 1125
	push bc	; offset 1126
	exx    	; offset 1127
	push hl	; offset 1128
	push de	; offset 1129
	push bc	; offset 1130

	; src_attr_data blit 39
	ld bc,3598	; offset 1131
	ld de,3598	; offset 1134
	ld hl,3598	; offset 1137
	exx    	; offset 1140
	ld bc,3598	; offset 1141
	ld de,3598	; offset 1144
	ld hl,3598	; offset 1147
	ld sp,attrStartAddr+480	; offset 1150
	push hl	; offset 1153
	push de	; offset 1154
	push bc	; offset 1155
	exx    	; offset 1156
	push hl	; offset 1157
	push de	; offset 1158
	push bc	; offset 1159

	; src_attr_data blit 40
	ld bc,3598	; offset 1160
	ld de,3598	; offset 1163
	ld hl,3598	; offset 1166
	exx    	; offset 1169
	ld bc,3598	; offset 1170
	ld de,3598	; offset 1173
	ld hl,3598	; offset 1176
	ld sp,attrStartAddr+492	; offset 1179
	push hl	; offset 1182
	push de	; offset 1183
	push bc	; offset 1184
	exx    	; offset 1185
	push hl	; offset 1186
	push de	; offset 1187
	push bc	; offset 1188

	; src_attr_data blit 41
	ld bc,3598	; offset 1189
	ld de,3598	; offset 1192
	ld hl,3598	; offset 1195
	exx    	; offset 1198
	ld bc,3598	; offset 1199
	ld de,3598	; offset 1202
	ld hl,3598	; offset 1205
	ld sp,attrStartAddr+504	; offset 1208
	push hl	; offset 1211
	push de	; offset 1212
	push bc	; offset 1213
	exx    	; offset 1214
	push hl	; offset 1215
	push de	; offset 1216
	push bc	; offset 1217

	; src_attr_data blit 42
	ld bc,3598	; offset 1218
	ld de,3598	; offset 1221
	ld hl,3598	; offset 1224
	exx    	; offset 1227
	ld bc,3598	; offset 1228
	ld de,3598	; offset 1231
	ld hl,3598	; offset 1234
	ld sp,attrStartAddr+516	; offset 1237
	push hl	; offset 1240
	push de	; offset 1241
	push bc	; offset 1242
	exx    	; offset 1243
	push hl	; offset 1244
	push de	; offset 1245
	push bc	; offset 1246

	; src_attr_data blit 43
	ld bc,3598	; offset 1247
	ld de,3598	; offset 1250
	ld hl,3598	; offset 1253
	exx    	; offset 1256
	ld bc,3598	; offset 1257
	ld de,3598	; offset 1260
	ld hl,3598	; offset 1263
	ld sp,attrStartAddr+528	; offset 1266
	push hl	; offset 1269
	push de	; offset 1270
	push bc	; offset 1271
	exx    	; offset 1272
	push hl	; offset 1273
	push de	; offset 1274
	push bc	; offset 1275

	; src_attr_data blit 44
	ld bc,3598	; offset 1276
	ld de,3598	; offset 1279
	ld hl,3598	; offset 1282
	exx    	; offset 1285
	ld bc,3598	; offset 1286
	ld de,3598	; offset 1289
	ld hl,3598	; offset 1292
	ld sp,attrStartAddr+540	; offset 1295
	push hl	; offset 1298
	push de	; offset 1299
	push bc	; offset 1300
	exx    	; offset 1301
	push hl	; offset 1302
	push de	; offset 1303
	push bc	; offset 1304

	; src_attr_data blit 45
	ld bc,3598	; offset 1305
	ld de,3598	; offset 1308
	ld hl,3598	; offset 1311
	exx    	; offset 1314
	ld bc,3598	; offset 1315
	ld de,3598	; offset 1318
	ld hl,3598	; offset 1321
	ld sp,attrStartAddr+552	; offset 1324
	push hl	; offset 1327
	push de	; offset 1328
	push bc	; offset 1329
	exx    	; offset 1330
	push hl	; offset 1331
	push de	; offset 1332
	push bc	; offset 1333

	; src_attr_data blit 46
	ld bc,3598	; offset 1334
	ld de,3598	; offset 1337
	ld hl,3598	; offset 1340
	exx    	; offset 1343
	ld bc,3598	; offset 1344
	ld de,3598	; offset 1347
	ld hl,3598	; offset 1350
	ld sp,attrStartAddr+564	; offset 1353
	push hl	; offset 1356
	push de	; offset 1357
	push bc	; offset 1358
	exx    	; offset 1359
	push hl	; offset 1360
	push de	; offset 1361
	push bc	; offset 1362

	; src_attr_data blit 47
	ld bc,3598	; offset 1363
	ld de,3598	; offset 1366
	ld hl,3598	; offset 1369
	exx    	; offset 1372
	ld bc,3598	; offset 1373
	ld de,3598	; offset 1376
	ld hl,3598	; offset 1379
	ld sp,attrStartAddr+576	; offset 1382
	push hl	; offset 1385
	push de	; offset 1386
	push bc	; offset 1387
	exx    	; offset 1388
	push hl	; offset 1389
	push de	; offset 1390
	push bc	; offset 1391

	; src_attr_data blit 48
	ld bc,3598	; offset 1392
	ld de,3598	; offset 1395
	ld hl,3598	; offset 1398
	exx    	; offset 1401
	ld bc,3598	; offset 1402
	ld de,3598	; offset 1405
	ld hl,3598	; offset 1408
	ld sp,attrStartAddr+588	; offset 1411
	push hl	; offset 1414
	push de	; offset 1415
	push bc	; offset 1416
	exx    	; offset 1417
	push hl	; offset 1418
	push de	; offset 1419
	push bc	; offset 1420

	; src_attr_data blit 49
	ld bc,3598	; offset 1421
	ld de,3598	; offset 1424
	ld hl,3598	; offset 1427
	exx    	; offset 1430
	ld bc,3598	; offset 1431
	ld de,3598	; offset 1434
	ld hl,3598	; offset 1437
	ld sp,attrStartAddr+600	; offset 1440
	push hl	; offset 1443
	push de	; offset 1444
	push bc	; offset 1445
	exx    	; offset 1446
	push hl	; offset 1447
	push de	; offset 1448
	push bc	; offset 1449

	; src_attr_data blit 50
	ld bc,3598	; offset 1450
	ld de,3598	; offset 1453
	ld hl,3598	; offset 1456
	exx    	; offset 1459
	ld bc,3598	; offset 1460
	ld de,3598	; offset 1463
	ld hl,3598	; offset 1466
	ld sp,attrStartAddr+612	; offset 1469
	push hl	; offset 1472
	push de	; offset 1473
	push bc	; offset 1474
	exx    	; offset 1475
	push hl	; offset 1476
	push de	; offset 1477
	push bc	; offset 1478

	; src_attr_data blit 51
	ld bc,3598	; offset 1479
	ld de,3598	; offset 1482
	ld hl,3598	; offset 1485
	exx    	; offset 1488
	ld bc,3598	; offset 1489
	ld de,3598	; offset 1492
	ld hl,3598	; offset 1495
	ld sp,attrStartAddr+624	; offset 1498
	push hl	; offset 1501
	push de	; offset 1502
	push bc	; offset 1503
	exx    	; offset 1504
	push hl	; offset 1505
	push de	; offset 1506
	push bc	; offset 1507

	; src_attr_data blit 52
	ld bc,3598	; offset 1508
	ld de,3598	; offset 1511
	ld hl,3598	; offset 1514
	exx    	; offset 1517
	ld bc,3598	; offset 1518
	ld de,3598	; offset 1521
	ld hl,3598	; offset 1524
	ld sp,attrStartAddr+636	; offset 1527
	push hl	; offset 1530
	push de	; offset 1531
	push bc	; offset 1532
	exx    	; offset 1533
	push hl	; offset 1534
	push de	; offset 1535
	push bc	; offset 1536

	; src_attr_data blit 53
	ld bc,3598	; offset 1537
	ld de,3598	; offset 1540
	ld hl,3598	; offset 1543
	exx    	; offset 1546
	ld bc,3598	; offset 1547
	ld de,3598	; offset 1550
	ld hl,3598	; offset 1553
	ld sp,attrStartAddr+648	; offset 1556
	push hl	; offset 1559
	push de	; offset 1560
	push bc	; offset 1561
	exx    	; offset 1562
	push hl	; offset 1563
	push de	; offset 1564
	push bc	; offset 1565

	; src_attr_data blit 54
	ld bc,3598	; offset 1566
	ld de,3598	; offset 1569
	ld hl,3598	; offset 1572
	exx    	; offset 1575
	ld bc,3598	; offset 1576
	ld de,3598	; offset 1579
	ld hl,3598	; offset 1582
	ld sp,attrStartAddr+660	; offset 1585
	push hl	; offset 1588
	push de	; offset 1589
	push bc	; offset 1590
	exx    	; offset 1591
	push hl	; offset 1592
	push de	; offset 1593
	push bc	; offset 1594

	; src_attr_data blit 55
	ld bc,3598	; offset 1595
	ld de,3598	; offset 1598
	ld hl,3598	; offset 1601
	exx    	; offset 1604
	ld bc,3598	; offset 1605
	ld de,3598	; offset 1608
	ld hl,3598	; offset 1611
	ld sp,attrStartAddr+672	; offset 1614
	push hl	; offset 1617
	push de	; offset 1618
	push bc	; offset 1619
	exx    	; offset 1620
	push hl	; offset 1621
	push de	; offset 1622
	push bc	; offset 1623

	; src_attr_data blit 56
	ld bc,3598	; offset 1624
	ld de,3598	; offset 1627
	ld hl,3598	; offset 1630
	exx    	; offset 1633
	ld bc,3598	; offset 1634
	ld de,3598	; offset 1637
	ld hl,3598	; offset 1640
	ld sp,attrStartAddr+684	; offset 1643
	push hl	; offset 1646
	push de	; offset 1647
	push bc	; offset 1648
	exx    	; offset 1649
	push hl	; offset 1650
	push de	; offset 1651
	push bc	; offset 1652

	; src_attr_data blit 57
	ld bc,3598	; offset 1653
	ld de,3598	; offset 1656
	ld hl,3598	; offset 1659
	exx    	; offset 1662
	ld bc,3598	; offset 1663
	ld de,3598	; offset 1666
	ld hl,3598	; offset 1669
	ld sp,attrStartAddr+696	; offset 1672
	push hl	; offset 1675
	push de	; offset 1676
	push bc	; offset 1677
	exx    	; offset 1678
	push hl	; offset 1679
	push de	; offset 1680
	push bc	; offset 1681

	; src_attr_data blit 58
	ld bc,3598	; offset 1682
	ld de,3598	; offset 1685
	ld hl,3598	; offset 1688
	exx    	; offset 1691
	ld bc,3598	; offset 1692
	ld de,3598	; offset 1695
	ld hl,3598	; offset 1698
	ld sp,attrStartAddr+708	; offset 1701
	push hl	; offset 1704
	push de	; offset 1705
	push bc	; offset 1706
	exx    	; offset 1707
	push hl	; offset 1708
	push de	; offset 1709
	push bc	; offset 1710

	; src_attr_data blit 59
	ld bc,3598	; offset 1711
	ld de,3598	; offset 1714
	ld hl,3598	; offset 1717
	exx    	; offset 1720
	ld bc,3598	; offset 1721
	ld de,3598	; offset 1724
	ld hl,3598	; offset 1727
	ld sp,attrStartAddr+720	; offset 1730
	push hl	; offset 1733
	push de	; offset 1734
	push bc	; offset 1735
	exx    	; offset 1736
	push hl	; offset 1737
	push de	; offset 1738
	push bc	; offset 1739

	; src_attr_data blit 60
	ld bc,3598	; offset 1740
	ld de,3598	; offset 1743
	ld hl,3598	; offset 1746
	exx    	; offset 1749
	ld bc,3598	; offset 1750
	ld de,3598	; offset 1753
	ld hl,3598	; offset 1756
	ld sp,attrStartAddr+732	; offset 1759
	push hl	; offset 1762
	push de	; offset 1763
	push bc	; offset 1764
	exx    	; offset 1765
	push hl	; offset 1766
	push de	; offset 1767
	push bc	; offset 1768

	; src_attr_data blit 61
	ld bc,3598	; offset 1769
	ld de,3598	; offset 1772
	ld hl,3598	; offset 1775
	exx    	; offset 1778
	ld bc,3598	; offset 1779
	ld de,3598	; offset 1782
	ld hl,3598	; offset 1785
	ld sp,attrStartAddr+744	; offset 1788
	push hl	; offset 1791
	push de	; offset 1792
	push bc	; offset 1793
	exx    	; offset 1794
	push hl	; offset 1795
	push de	; offset 1796
	push bc	; offset 1797

	; src_attr_data blit 62
	ld bc,3598	; offset 1798
	ld de,3598	; offset 1801
	ld hl,3598	; offset 1804
	exx    	; offset 1807
	ld bc,3598	; offset 1808
	ld de,3598	; offset 1811
	ld hl,3598	; offset 1814
	ld sp,attrStartAddr+756	; offset 1817
	push hl	; offset 1820
	push de	; offset 1821
	push bc	; offset 1822
	exx    	; offset 1823
	push hl	; offset 1824
	push de	; offset 1825
	push bc	; offset 1826

	; src_attr_data blit 63
	ld bc,3598	; offset 1827
	ld de,3598	; offset 1830
	ld hl,3598	; offset 1833
	exx    	; offset 1836
	ld bc,3598	; offset 1837
	ld de,3598	; offset 1840
	ld hl,3598	; offset 1843
	ld sp,attrStartAddr+768	; offset 1846
	push hl	; offset 1849
	push de	; offset 1850
	push bc	; offset 1851
	exx    	; offset 1852
	push hl	; offset 1853
	push de	; offset 1854
	push bc	; offset 1855

	; src_data blit 241
	ld bc,52428	; offset 1856
	ld de,52428	; offset 1859
	ld hl,52428	; offset 1862
	exx    	; offset 1865
	ld bc,52428	; offset 1866
	ld de,52428	; offset 1869
	ld hl,52428	; offset 1872
	ld sp,screenStartAddr+2184	; offset 1875
	push hl	; offset 1878
	push de	; offset 1879
	push bc	; offset 1880
	exx    	; offset 1881
	push hl	; offset 1882
	push de	; offset 1883
	push bc	; offset 1884
	; Clock offset: -7488

	; src_data blit 242
	ld bc,52428	; offset 1885
	ld de,52428	; offset 1888
	ld hl,52428	; offset 1891
	exx    	; offset 1894
	ld bc,52428	; offset 1895
	ld de,52428	; offset 1898
	ld hl,52428	; offset 1901
	ld sp,screenStartAddr+2412	; offset 1904
	push hl	; offset 1907
	push de	; offset 1908
	push bc	; offset 1909
	exx    	; offset 1910
	push hl	; offset 1911
	push de	; offset 1912
	push bc	; offset 1913
	; Clock offset: -7344

	; src_data blit 243
	ld bc,52428	; offset 1914
	ld de,52428	; offset 1917
	ld hl,52428	; offset 1920
	exx    	; offset 1923
	ld bc,52428	; offset 1924
	ld de,52428	; offset 1927
	ld hl,52428	; offset 1930
	ld sp,screenStartAddr+2424	; offset 1933
	push hl	; offset 1936
	push de	; offset 1937
	push bc	; offset 1938
	exx    	; offset 1939
	push hl	; offset 1940
	push de	; offset 1941
	push bc	; offset 1942
	; Clock offset: -7200

	; src_data blit 244
	ld bc,52428	; offset 1943
	ld de,52428	; offset 1946
	ld hl,52428	; offset 1949
	exx    	; offset 1952
	ld bc,52428	; offset 1953
	ld de,52428	; offset 1956
	ld hl,52428	; offset 1959
	ld sp,screenStartAddr+2436	; offset 1962
	push hl	; offset 1965
	push de	; offset 1966
	push bc	; offset 1967
	exx    	; offset 1968
	push hl	; offset 1969
	push de	; offset 1970
	push bc	; offset 1971
	; Clock offset: -7056

	; src_data blit 245
	ld bc,52428	; offset 1972
	ld de,52428	; offset 1975
	ld hl,52428	; offset 1978
	exx    	; offset 1981
	ld bc,52428	; offset 1982
	ld de,52428	; offset 1985
	ld hl,52428	; offset 1988
	ld sp,screenStartAddr+2676	; offset 1991
	push hl	; offset 1994
	push de	; offset 1995
	push bc	; offset 1996
	exx    	; offset 1997
	push hl	; offset 1998
	push de	; offset 1999
	push bc	; offset 2000
	; Clock offset: -6912

	; src_data blit 246
	ld bc,52428	; offset 2001
	ld de,52428	; offset 2004
	ld hl,52428	; offset 2007
	exx    	; offset 2010
	ld bc,52428	; offset 2011
	ld de,52428	; offset 2014
	ld hl,52428	; offset 2017
	ld sp,screenStartAddr+2688	; offset 2020
	push hl	; offset 2023
	push de	; offset 2024
	push bc	; offset 2025
	exx    	; offset 2026
	push hl	; offset 2027
	push de	; offset 2028
	push bc	; offset 2029
	; Clock offset: -6768

	; src_data blit 247
	ld bc,52428	; offset 2030
	ld de,52428	; offset 2033
	ld hl,52428	; offset 2036
	exx    	; offset 2039
	ld bc,52428	; offset 2040
	ld de,52428	; offset 2043
	ld hl,52428	; offset 2046
	ld sp,screenStartAddr+2928	; offset 2049
	push hl	; offset 2052
	push de	; offset 2053
	push bc	; offset 2054
	exx    	; offset 2055
	push hl	; offset 2056
	push de	; offset 2057
	push bc	; offset 2058
	; Clock offset: -6624

	; src_data blit 248
	ld bc,52428	; offset 2059
	ld de,52428	; offset 2062
	ld hl,52428	; offset 2065
	exx    	; offset 2068
	ld bc,52428	; offset 2069
	ld de,52428	; offset 2072
	ld hl,52428	; offset 2075
	ld sp,screenStartAddr+2940	; offset 2078
	push hl	; offset 2081
	push de	; offset 2082
	push bc	; offset 2083
	exx    	; offset 2084
	push hl	; offset 2085
	push de	; offset 2086
	push bc	; offset 2087
	; Clock offset: -6480

	; src_data blit 249
	ld bc,52428	; offset 2088
	ld de,52428	; offset 2091
	ld hl,52428	; offset 2094
	exx    	; offset 2097
	ld bc,52428	; offset 2098
	ld de,52428	; offset 2101
	ld hl,52428	; offset 2104
	ld sp,screenStartAddr+2952	; offset 2107
	push hl	; offset 2110
	push de	; offset 2111
	push bc	; offset 2112
	exx    	; offset 2113
	push hl	; offset 2114
	push de	; offset 2115
	push bc	; offset 2116
	; Clock offset: -6336

	; src_data blit 250
	ld bc,52428	; offset 2117
	ld de,52428	; offset 2120
	ld hl,52428	; offset 2123
	exx    	; offset 2126
	ld bc,52428	; offset 2127
	ld de,52428	; offset 2130
	ld hl,52428	; offset 2133
	ld sp,screenStartAddr+3180	; offset 2136
	push hl	; offset 2139
	push de	; offset 2140
	push bc	; offset 2141
	exx    	; offset 2142
	push hl	; offset 2143
	push de	; offset 2144
	push bc	; offset 2145
	; Clock offset: -6192

	; src_data blit 251
	ld bc,52428	; offset 2146
	ld de,52428	; offset 2149
	ld hl,52428	; offset 2152
	exx    	; offset 2155
	ld bc,52428	; offset 2156
	ld de,52428	; offset 2159
	ld hl,52428	; offset 2162
	ld sp,screenStartAddr+3192	; offset 2165
	push hl	; offset 2168
	push de	; offset 2169
	push bc	; offset 2170
	exx    	; offset 2171
	push hl	; offset 2172
	push de	; offset 2173
	push bc	; offset 2174
	; Clock offset: -6048

	; src_data blit 252
	ld bc,52428	; offset 2175
	ld de,52428	; offset 2178
	ld hl,52428	; offset 2181
	exx    	; offset 2184
	ld bc,52428	; offset 2185
	ld de,52428	; offset 2188
	ld hl,52428	; offset 2191
	ld sp,screenStartAddr+3204	; offset 2194
	push hl	; offset 2197
	push de	; offset 2198
	push bc	; offset 2199
	exx    	; offset 2200
	push hl	; offset 2201
	push de	; offset 2202
	push bc	; offset 2203
	; Clock offset: -5904

	; src_data blit 253
	ld bc,52428	; offset 2204
	ld de,52428	; offset 2207
	ld hl,52428	; offset 2210
	exx    	; offset 2213
	ld bc,52428	; offset 2214
	ld de,52428	; offset 2217
	ld hl,52428	; offset 2220
	ld sp,screenStartAddr+3444	; offset 2223
	push hl	; offset 2226
	push de	; offset 2227
	push bc	; offset 2228
	exx    	; offset 2229
	push hl	; offset 2230
	push de	; offset 2231
	push bc	; offset 2232
	; Clock offset: -5760

	; src_data blit 254
	ld bc,52428	; offset 2233
	ld de,52428	; offset 2236
	ld hl,52428	; offset 2239
	exx    	; offset 2242
	ld bc,52428	; offset 2243
	ld de,52428	; offset 2246
	ld hl,52428	; offset 2249
	ld sp,screenStartAddr+3456	; offset 2252
	push hl	; offset 2255
	push de	; offset 2256
	push bc	; offset 2257
	exx    	; offset 2258
	push hl	; offset 2259
	push de	; offset 2260
	push bc	; offset 2261
	; Clock offset: -5616

	; src_data blit 255
	ld bc,52428	; offset 2262
	ld de,52428	; offset 2265
	ld hl,52428	; offset 2268
	exx    	; offset 2271
	ld bc,52428	; offset 2272
	ld de,52428	; offset 2275
	ld hl,52428	; offset 2278
	ld sp,screenStartAddr+3696	; offset 2281
	push hl	; offset 2284
	push de	; offset 2285
	push bc	; offset 2286
	exx    	; offset 2287
	push hl	; offset 2288
	push de	; offset 2289
	push bc	; offset 2290
	; Clock offset: -5472

	; src_data blit 256
	ld bc,52428	; offset 2291
	ld de,52428	; offset 2294
	ld hl,52428	; offset 2297
	exx    	; offset 2300
	ld bc,52428	; offset 2301
	ld de,52428	; offset 2304
	ld hl,52428	; offset 2307
	ld sp,screenStartAddr+3708	; offset 2310
	push hl	; offset 2313
	push de	; offset 2314
	push bc	; offset 2315
	exx    	; offset 2316
	push hl	; offset 2317
	push de	; offset 2318
	push bc	; offset 2319
	; Clock offset: -5328

	; src_data blit 257
	ld bc,52428	; offset 2320
	ld de,52428	; offset 2323
	ld hl,52428	; offset 2326
	exx    	; offset 2329
	ld bc,52428	; offset 2330
	ld de,52428	; offset 2333
	ld hl,52428	; offset 2336
	ld sp,screenStartAddr+3720	; offset 2339
	push hl	; offset 2342
	push de	; offset 2343
	push bc	; offset 2344
	exx    	; offset 2345
	push hl	; offset 2346
	push de	; offset 2347
	push bc	; offset 2348
	; Clock offset: -5184

	; src_data blit 258
	ld bc,52428	; offset 2349
	ld de,52428	; offset 2352
	ld hl,52428	; offset 2355
	exx    	; offset 2358
	ld bc,52428	; offset 2359
	ld de,52428	; offset 2362
	ld hl,52428	; offset 2365
	ld sp,screenStartAddr+3948	; offset 2368
	push hl	; offset 2371
	push de	; offset 2372
	push bc	; offset 2373
	exx    	; offset 2374
	push hl	; offset 2375
	push de	; offset 2376
	push bc	; offset 2377
	; Clock offset: -5040

	; src_data blit 259
	ld bc,52428	; offset 2378
	ld de,52428	; offset 2381
	ld hl,52428	; offset 2384
	exx    	; offset 2387
	ld bc,52428	; offset 2388
	ld de,52428	; offset 2391
	ld hl,52428	; offset 2394
	ld sp,screenStartAddr+3960	; offset 2397
	push hl	; offset 2400
	push de	; offset 2401
	push bc	; offset 2402
	exx    	; offset 2403
	push hl	; offset 2404
	push de	; offset 2405
	push bc	; offset 2406
	; Clock offset: -4896

	; src_data blit 260
	ld bc,52428	; offset 2407
	ld de,52428	; offset 2410
	ld hl,52428	; offset 2413
	exx    	; offset 2416
	ld bc,52428	; offset 2417
	ld de,52428	; offset 2420
	ld hl,52428	; offset 2423
	ld sp,screenStartAddr+3972	; offset 2426
	push hl	; offset 2429
	push de	; offset 2430
	push bc	; offset 2431
	exx    	; offset 2432
	push hl	; offset 2433
	push de	; offset 2434
	push bc	; offset 2435
	; Clock offset: -4752

	; src_data blit 261
	ld bc,52428	; offset 2436
	ld de,52428	; offset 2439
	ld hl,52428	; offset 2442
	exx    	; offset 2445
	ld bc,52428	; offset 2446
	ld de,52428	; offset 2449
	ld hl,52428	; offset 2452
	ld sp,screenStartAddr+2196	; offset 2455
	push hl	; offset 2458
	push de	; offset 2459
	push bc	; offset 2460
	exx    	; offset 2461
	push hl	; offset 2462
	push de	; offset 2463
	push bc	; offset 2464
	; Clock offset: -4608

	; src_data blit 262
	ld bc,52428	; offset 2465
	ld de,52428	; offset 2468
	ld hl,52428	; offset 2471
	exx    	; offset 2474
	ld bc,52428	; offset 2475
	ld de,52428	; offset 2478
	ld hl,52428	; offset 2481
	ld sp,screenStartAddr+2208	; offset 2484
	push hl	; offset 2487
	push de	; offset 2488
	push bc	; offset 2489
	exx    	; offset 2490
	push hl	; offset 2491
	push de	; offset 2492
	push bc	; offset 2493
	; Clock offset: -4464

	; src_data blit 263
	ld bc,52428	; offset 2494
	ld de,52428	; offset 2497
	ld hl,52428	; offset 2500
	exx    	; offset 2503
	ld bc,52428	; offset 2504
	ld de,52428	; offset 2507
	ld hl,52428	; offset 2510
	ld sp,screenStartAddr+2448	; offset 2513
	push hl	; offset 2516
	push de	; offset 2517
	push bc	; offset 2518
	exx    	; offset 2519
	push hl	; offset 2520
	push de	; offset 2521
	push bc	; offset 2522
	; Clock offset: -4320

	; src_data blit 264
	ld bc,52428	; offset 2523
	ld de,52428	; offset 2526
	ld hl,52428	; offset 2529
	exx    	; offset 2532
	ld bc,52428	; offset 2533
	ld de,52428	; offset 2536
	ld hl,52428	; offset 2539
	ld sp,screenStartAddr+2460	; offset 2542
	push hl	; offset 2545
	push de	; offset 2546
	push bc	; offset 2547
	exx    	; offset 2548
	push hl	; offset 2549
	push de	; offset 2550
	push bc	; offset 2551
	; Clock offset: -4176

	; src_data blit 265
	ld bc,52428	; offset 2552
	ld de,52428	; offset 2555
	ld hl,52428	; offset 2558
	exx    	; offset 2561
	ld bc,52428	; offset 2562
	ld de,52428	; offset 2565
	ld hl,52428	; offset 2568
	ld sp,screenStartAddr+2472	; offset 2571
	push hl	; offset 2574
	push de	; offset 2575
	push bc	; offset 2576
	exx    	; offset 2577
	push hl	; offset 2578
	push de	; offset 2579
	push bc	; offset 2580
	; Clock offset: -4032

	; src_data blit 266
	ld bc,52428	; offset 2581
	ld de,52428	; offset 2584
	ld hl,52428	; offset 2587
	exx    	; offset 2590
	ld bc,52428	; offset 2591
	ld de,52428	; offset 2594
	ld hl,52428	; offset 2597
	ld sp,screenStartAddr+2700	; offset 2600
	push hl	; offset 2603
	push de	; offset 2604
	push bc	; offset 2605
	exx    	; offset 2606
	push hl	; offset 2607
	push de	; offset 2608
	push bc	; offset 2609
	; Clock offset: -3888

	; src_data blit 267
	ld bc,52428	; offset 2610
	ld de,52428	; offset 2613
	ld hl,52428	; offset 2616
	exx    	; offset 2619
	ld bc,52428	; offset 2620
	ld de,52428	; offset 2623
	ld hl,52428	; offset 2626
	ld sp,screenStartAddr+2712	; offset 2629
	push hl	; offset 2632
	push de	; offset 2633
	push bc	; offset 2634
	exx    	; offset 2635
	push hl	; offset 2636
	push de	; offset 2637
	push bc	; offset 2638
	; Clock offset: -3744

	; src_data blit 268
	ld bc,52428	; offset 2639
	ld de,52428	; offset 2642
	ld hl,52428	; offset 2645
	exx    	; offset 2648
	ld bc,52428	; offset 2649
	ld de,52428	; offset 2652
	ld hl,52428	; offset 2655
	ld sp,screenStartAddr+2724	; offset 2658
	push hl	; offset 2661
	push de	; offset 2662
	push bc	; offset 2663
	exx    	; offset 2664
	push hl	; offset 2665
	push de	; offset 2666
	push bc	; offset 2667
	; Clock offset: -3600

	; src_data blit 269
	ld bc,52428	; offset 2668
	ld de,52428	; offset 2671
	ld hl,52428	; offset 2674
	exx    	; offset 2677
	ld bc,52428	; offset 2678
	ld de,52428	; offset 2681
	ld hl,52428	; offset 2684
	ld sp,screenStartAddr+2964	; offset 2687
	push hl	; offset 2690
	push de	; offset 2691
	push bc	; offset 2692
	exx    	; offset 2693
	push hl	; offset 2694
	push de	; offset 2695
	push bc	; offset 2696
	; Clock offset: -3456

	; src_data blit 270
	ld bc,52428	; offset 2697
	ld de,52428	; offset 2700
	ld hl,52428	; offset 2703
	exx    	; offset 2706
	ld bc,52428	; offset 2707
	ld de,52428	; offset 2710
	ld hl,52428	; offset 2713
	ld sp,screenStartAddr+2976	; offset 2716
	push hl	; offset 2719
	push de	; offset 2720
	push bc	; offset 2721
	exx    	; offset 2722
	push hl	; offset 2723
	push de	; offset 2724
	push bc	; offset 2725
	; Clock offset: -3312

	; src_data blit 271
	ld bc,52428	; offset 2726
	ld de,52428	; offset 2729
	ld hl,52428	; offset 2732
	exx    	; offset 2735
	ld bc,52428	; offset 2736
	ld de,52428	; offset 2739
	ld hl,52428	; offset 2742
	ld sp,screenStartAddr+3216	; offset 2745
	push hl	; offset 2748
	push de	; offset 2749
	push bc	; offset 2750
	exx    	; offset 2751
	push hl	; offset 2752
	push de	; offset 2753
	push bc	; offset 2754
	; Clock offset: -3168

	; src_data blit 272
	ld bc,52428	; offset 2755
	ld de,52428	; offset 2758
	ld hl,52428	; offset 2761
	exx    	; offset 2764
	ld bc,52428	; offset 2765
	ld de,52428	; offset 2768
	ld hl,52428	; offset 2771
	ld sp,screenStartAddr+3228	; offset 2774
	push hl	; offset 2777
	push de	; offset 2778
	push bc	; offset 2779
	exx    	; offset 2780
	push hl	; offset 2781
	push de	; offset 2782
	push bc	; offset 2783
	; Clock offset: -3024

	; src_data blit 273
	ld bc,52428	; offset 2784
	ld de,52428	; offset 2787
	ld hl,52428	; offset 2790
	exx    	; offset 2793
	ld bc,52428	; offset 2794
	ld de,52428	; offset 2797
	ld hl,52428	; offset 2800
	ld sp,screenStartAddr+3240	; offset 2803
	push hl	; offset 2806
	push de	; offset 2807
	push bc	; offset 2808
	exx    	; offset 2809
	push hl	; offset 2810
	push de	; offset 2811
	push bc	; offset 2812
	; Clock offset: -2880

	; src_data blit 274
	ld bc,52428	; offset 2813
	ld de,52428	; offset 2816
	ld hl,52428	; offset 2819
	exx    	; offset 2822
	ld bc,52428	; offset 2823
	ld de,52428	; offset 2826
	ld hl,52428	; offset 2829
	ld sp,screenStartAddr+3468	; offset 2832
	push hl	; offset 2835
	push de	; offset 2836
	push bc	; offset 2837
	exx    	; offset 2838
	push hl	; offset 2839
	push de	; offset 2840
	push bc	; offset 2841
	; Clock offset: -2736

	; src_data blit 275
	ld bc,52428	; offset 2842
	ld de,52428	; offset 2845
	ld hl,52428	; offset 2848
	exx    	; offset 2851
	ld bc,52428	; offset 2852
	ld de,52428	; offset 2855
	ld hl,52428	; offset 2858
	ld sp,screenStartAddr+3480	; offset 2861
	push hl	; offset 2864
	push de	; offset 2865
	push bc	; offset 2866
	exx    	; offset 2867
	push hl	; offset 2868
	push de	; offset 2869
	push bc	; offset 2870
	; Clock offset: -2592

	; src_data blit 276
	ld bc,52428	; offset 2871
	ld de,52428	; offset 2874
	ld hl,52428	; offset 2877
	exx    	; offset 2880
	ld bc,52428	; offset 2881
	ld de,52428	; offset 2884
	ld hl,52428	; offset 2887
	ld sp,screenStartAddr+3492	; offset 2890
	push hl	; offset 2893
	push de	; offset 2894
	push bc	; offset 2895
	exx    	; offset 2896
	push hl	; offset 2897
	push de	; offset 2898
	push bc	; offset 2899
	; Clock offset: -2448

	; src_data blit 277
	ld bc,52428	; offset 2900
	ld de,52428	; offset 2903
	ld hl,52428	; offset 2906
	exx    	; offset 2909
	ld bc,52428	; offset 2910
	ld de,52428	; offset 2913
	ld hl,52428	; offset 2916
	ld sp,screenStartAddr+3732	; offset 2919
	push hl	; offset 2922
	push de	; offset 2923
	push bc	; offset 2924
	exx    	; offset 2925
	push hl	; offset 2926
	push de	; offset 2927
	push bc	; offset 2928
	; Clock offset: -2304

	; src_data blit 278
	ld bc,52428	; offset 2929
	ld de,52428	; offset 2932
	ld hl,52428	; offset 2935
	exx    	; offset 2938
	ld bc,52428	; offset 2939
	ld de,52428	; offset 2942
	ld hl,52428	; offset 2945
	ld sp,screenStartAddr+3744	; offset 2948
	push hl	; offset 2951
	push de	; offset 2952
	push bc	; offset 2953
	exx    	; offset 2954
	push hl	; offset 2955
	push de	; offset 2956
	push bc	; offset 2957
	; Clock offset: -2160

	; src_data blit 279
	ld bc,52428	; offset 2958
	ld de,52428	; offset 2961
	ld hl,52428	; offset 2964
	exx    	; offset 2967
	ld bc,52428	; offset 2968
	ld de,52428	; offset 2971
	ld hl,52428	; offset 2974
	ld sp,screenStartAddr+3984	; offset 2977
	push hl	; offset 2980
	push de	; offset 2981
	push bc	; offset 2982
	exx    	; offset 2983
	push hl	; offset 2984
	push de	; offset 2985
	push bc	; offset 2986
	; Clock offset: -2016

	; src_data blit 280
	ld bc,52428	; offset 2987
	ld de,52428	; offset 2990
	ld hl,52428	; offset 2993
	exx    	; offset 2996
	ld bc,52428	; offset 2997
	ld de,52428	; offset 3000
	ld hl,52428	; offset 3003
	ld sp,screenStartAddr+3996	; offset 3006
	push hl	; offset 3009
	push de	; offset 3010
	push bc	; offset 3011
	exx    	; offset 3012
	push hl	; offset 3013
	push de	; offset 3014
	push bc	; offset 3015
	; Clock offset: -1872

	; src_data blit 281
	ld bc,52428	; offset 3016
	ld de,52428	; offset 3019
	ld hl,52428	; offset 3022
	exx    	; offset 3025
	ld bc,52428	; offset 3026
	ld de,52428	; offset 3029
	ld hl,52428	; offset 3032
	ld sp,screenStartAddr+4008	; offset 3035
	push hl	; offset 3038
	push de	; offset 3039
	push bc	; offset 3040
	exx    	; offset 3041
	push hl	; offset 3042
	push de	; offset 3043
	push bc	; offset 3044
	; Clock offset: -1728

	; src_data blit 282
	ld bc,52428	; offset 3045
	ld de,52428	; offset 3048
	ld hl,52428	; offset 3051
	exx    	; offset 3054
	ld bc,52428	; offset 3055
	ld de,52428	; offset 3058
	ld hl,52428	; offset 3061
	ld sp,screenStartAddr+2220	; offset 3064
	push hl	; offset 3067
	push de	; offset 3068
	push bc	; offset 3069
	exx    	; offset 3070
	push hl	; offset 3071
	push de	; offset 3072
	push bc	; offset 3073
	; Clock offset: -1584

	; src_data blit 283
	ld bc,52428	; offset 3074
	ld de,52428	; offset 3077
	ld hl,52428	; offset 3080
	exx    	; offset 3083
	ld bc,52428	; offset 3084
	ld de,52428	; offset 3087
	ld hl,52428	; offset 3090
	ld sp,screenStartAddr+2232	; offset 3093
	push hl	; offset 3096
	push de	; offset 3097
	push bc	; offset 3098
	exx    	; offset 3099
	push hl	; offset 3100
	push de	; offset 3101
	push bc	; offset 3102
	; Clock offset: -1440

	; src_data blit 284
	ld bc,52428	; offset 3103
	ld de,52428	; offset 3106
	ld hl,52428	; offset 3109
	exx    	; offset 3112
	ld bc,52428	; offset 3113
	ld de,52428	; offset 3116
	ld hl,52428	; offset 3119
	ld sp,screenStartAddr+2244	; offset 3122
	push hl	; offset 3125
	push de	; offset 3126
	push bc	; offset 3127
	exx    	; offset 3128
	push hl	; offset 3129
	push de	; offset 3130
	push bc	; offset 3131
	; Clock offset: -1296

	; src_data blit 285
	ld bc,52428	; offset 3132
	ld de,52428	; offset 3135
	ld hl,52428	; offset 3138
	exx    	; offset 3141
	ld bc,52428	; offset 3142
	ld de,52428	; offset 3145
	ld hl,52428	; offset 3148
	ld sp,screenStartAddr+2484	; offset 3151
	push hl	; offset 3154
	push de	; offset 3155
	push bc	; offset 3156
	exx    	; offset 3157
	push hl	; offset 3158
	push de	; offset 3159
	push bc	; offset 3160
	; Clock offset: -1152

	; src_data blit 286
	ld bc,52428	; offset 3161
	ld de,52428	; offset 3164
	ld hl,52428	; offset 3167
	exx    	; offset 3170
	ld bc,52428	; offset 3171
	ld de,52428	; offset 3174
	ld hl,52428	; offset 3177
	ld sp,screenStartAddr+2496	; offset 3180
	push hl	; offset 3183
	push de	; offset 3184
	push bc	; offset 3185
	exx    	; offset 3186
	push hl	; offset 3187
	push de	; offset 3188
	push bc	; offset 3189
	; Clock offset: -1008

	; src_data blit 287
	ld bc,52428	; offset 3190
	ld de,52428	; offset 3193
	ld hl,52428	; offset 3196
	exx    	; offset 3199
	ld bc,52428	; offset 3200
	ld de,52428	; offset 3203
	ld hl,52428	; offset 3206
	ld sp,screenStartAddr+2736	; offset 3209
	push hl	; offset 3212
	push de	; offset 3213
	push bc	; offset 3214
	exx    	; offset 3215
	push hl	; offset 3216
	push de	; offset 3217
	push bc	; offset 3218
	; Clock offset: -864

	; src_data blit 288
	ld bc,52428	; offset 3219
	ld de,52428	; offset 3222
	ld hl,52428	; offset 3225
	exx    	; offset 3228
	ld bc,52428	; offset 3229
	ld de,52428	; offset 3232
	ld hl,52428	; offset 3235
	ld sp,screenStartAddr+2748	; offset 3238
	push hl	; offset 3241
	push de	; offset 3242
	push bc	; offset 3243
	exx    	; offset 3244
	push hl	; offset 3245
	push de	; offset 3246
	push bc	; offset 3247
	; Clock offset: -720

	; src_data blit 289
	ld bc,52428	; offset 3248
	ld de,52428	; offset 3251
	ld hl,52428	; offset 3254
	exx    	; offset 3257
	ld bc,52428	; offset 3258
	ld de,52428	; offset 3261
	ld hl,52428	; offset 3264
	ld sp,screenStartAddr+2760	; offset 3267
	push hl	; offset 3270
	push de	; offset 3271
	push bc	; offset 3272
	exx    	; offset 3273
	push hl	; offset 3274
	push de	; offset 3275
	push bc	; offset 3276
	; Clock offset: -576

	; src_data blit 290
	ld bc,52428	; offset 3277
	ld de,52428	; offset 3280
	ld hl,52428	; offset 3283
	exx    	; offset 3286
	ld bc,52428	; offset 3287
	ld de,52428	; offset 3290
	ld hl,52428	; offset 3293
	ld sp,screenStartAddr+2988	; offset 3296
	push hl	; offset 3299
	push de	; offset 3300
	push bc	; offset 3301
	exx    	; offset 3302
	push hl	; offset 3303
	push de	; offset 3304
	push bc	; offset 3305
	; Clock offset: -432

	; src_data blit 291
	ld bc,52428	; offset 3306
	ld de,52428	; offset 3309
	ld hl,52428	; offset 3312
	exx    	; offset 3315
	ld bc,52428	; offset 3316
	ld de,52428	; offset 3319
	ld hl,52428	; offset 3322
	ld sp,screenStartAddr+3000	; offset 3325
	push hl	; offset 3328
	push de	; offset 3329
	push bc	; offset 3330
	exx    	; offset 3331
	push hl	; offset 3332
	push de	; offset 3333
	push bc	; offset 3334
	; Clock offset: -288

	; src_data blit 292
	ld bc,52428	; offset 3335
	ld de,52428	; offset 3338
	ld hl,52428	; offset 3341
	exx    	; offset 3344
	ld bc,52428	; offset 3345
	ld de,52428	; offset 3348
	ld hl,52428	; offset 3351
	ld sp,screenStartAddr+3012	; offset 3354
	push hl	; offset 3357
	push de	; offset 3358
	push bc	; offset 3359
	exx    	; offset 3360
	push hl	; offset 3361
	push de	; offset 3362
	push bc	; offset 3363
	; Clock offset: -144

	; src_data blit 293
	ld bc,52428	; offset 3364
	ld de,52428	; offset 3367
	ld hl,52428	; offset 3370
	exx    	; offset 3373
	ld bc,52428	; offset 3374
	ld de,52428	; offset 3377
	ld hl,52428	; offset 3380
	ld sp,screenStartAddr+3252	; offset 3383
	push hl	; offset 3386
	push de	; offset 3387
	push bc	; offset 3388
	exx    	; offset 3389
	push hl	; offset 3390
	push de	; offset 3391
	push bc	; offset 3392
	; Clock offset: 0

	; attr draw 0
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+0
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+0),hl
	ld hl,10280
	ld (attrStartAddr+2+0),hl
	ld hl,10280
	push hl
	push de
	push bc
	push af
	exx
	ex af,af'
	push iy
	push ix
	ld sp,attrStartAddr+24+0
	push hl
	push de
	push bc
	push af
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+0
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+0),hl
	; src_data filler blit 0
	ld bc,52428	; offset 3848
	ld de,52428	; offset 3851
	exx    	; offset 3854
	ld bc,52428	; offset 3855
	ld de,52428	; offset 3858
	ld sp,screenStartAddr+5780	; offset 3861
	push de	; offset 3864
	push bc	; offset 3865
	exx    	; offset 3866
	push de	; offset 3867
	push bc	; offset 3868
	nop
	; end attr draw 0
	; Clock offset: -1008

	; src_data blit 294
	ld bc,52428	; offset 3870
	ld de,52428	; offset 3873
	ld hl,52428	; offset 3876
	exx    	; offset 3879
	ld bc,52428	; offset 3880
	ld de,52428	; offset 3883
	ld hl,52428	; offset 3886
	ld sp,screenStartAddr+3264	; offset 3889
	push hl	; offset 3892
	push de	; offset 3893
	push bc	; offset 3894
	exx    	; offset 3895
	push hl	; offset 3896
	push de	; offset 3897
	push bc	; offset 3898
	; Clock offset: -864

	; src_data blit 295
	ld bc,52428	; offset 3899
	ld de,52428	; offset 3902
	ld hl,52428	; offset 3905
	exx    	; offset 3908
	ld bc,52428	; offset 3909
	ld de,52428	; offset 3912
	ld hl,52428	; offset 3915
	ld sp,screenStartAddr+3504	; offset 3918
	push hl	; offset 3921
	push de	; offset 3922
	push bc	; offset 3923
	exx    	; offset 3924
	push hl	; offset 3925
	push de	; offset 3926
	push bc	; offset 3927
	; Clock offset: -720

	; src_data blit 296
	ld bc,52428	; offset 3928
	ld de,52428	; offset 3931
	ld hl,52428	; offset 3934
	exx    	; offset 3937
	ld bc,52428	; offset 3938
	ld de,52428	; offset 3941
	ld hl,52428	; offset 3944
	ld sp,screenStartAddr+3516	; offset 3947
	push hl	; offset 3950
	push de	; offset 3951
	push bc	; offset 3952
	exx    	; offset 3953
	push hl	; offset 3954
	push de	; offset 3955
	push bc	; offset 3956
	; Clock offset: -576

	; src_data blit 297
	ld bc,52428	; offset 3957
	ld de,52428	; offset 3960
	ld hl,52428	; offset 3963
	exx    	; offset 3966
	ld bc,52428	; offset 3967
	ld de,52428	; offset 3970
	ld hl,52428	; offset 3973
	ld sp,screenStartAddr+3528	; offset 3976
	push hl	; offset 3979
	push de	; offset 3980
	push bc	; offset 3981
	exx    	; offset 3982
	push hl	; offset 3983
	push de	; offset 3984
	push bc	; offset 3985
	; Clock offset: -432

	; src_data blit 298
	ld bc,52428	; offset 3986
	ld de,52428	; offset 3989
	ld hl,52428	; offset 3992
	exx    	; offset 3995
	ld bc,52428	; offset 3996
	ld de,52428	; offset 3999
	ld hl,52428	; offset 4002
	ld sp,screenStartAddr+3756	; offset 4005
	push hl	; offset 4008
	push de	; offset 4009
	push bc	; offset 4010
	exx    	; offset 4011
	push hl	; offset 4012
	push de	; offset 4013
	push bc	; offset 4014
	; Clock offset: -288

	; src_data blit 299
	ld bc,52428	; offset 4015
	ld de,52428	; offset 4018
	ld hl,52428	; offset 4021
	exx    	; offset 4024
	ld bc,52428	; offset 4025
	ld de,52428	; offset 4028
	ld hl,52428	; offset 4031
	ld sp,screenStartAddr+3768	; offset 4034
	push hl	; offset 4037
	push de	; offset 4038
	push bc	; offset 4039
	exx    	; offset 4040
	push hl	; offset 4041
	push de	; offset 4042
	push bc	; offset 4043
	; Clock offset: -144

	; src_data blit 300
	ld bc,52428	; offset 4044
	ld de,52428	; offset 4047
	ld hl,52428	; offset 4050
	exx    	; offset 4053
	ld bc,52428	; offset 4054
	ld de,52428	; offset 4057
	ld hl,52428	; offset 4060
	ld sp,screenStartAddr+3780	; offset 4063
	push hl	; offset 4066
	push de	; offset 4067
	push bc	; offset 4068
	exx    	; offset 4069
	push hl	; offset 4070
	push de	; offset 4071
	push bc	; offset 4072
	; Clock offset: 0

	; attr draw 1
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+32
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+32),hl
	ld hl,10280
	ld (attrStartAddr+2+32),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+32
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+32),hl
	; src_data filler blit 32
	ld bc,52428	; offset 4528
	ld de,52428	; offset 4531
	exx    	; offset 4534
	ld bc,52428	; offset 4535
	ld de,52428	; offset 4538
	ld sp,screenStartAddr+5788	; offset 4541
	push de	; offset 4544
	push bc	; offset 4545
	exx    	; offset 4546
	push de	; offset 4547
	push bc	; offset 4548
	nop
	; end attr draw 1
	; Clock offset: -1008

	; src_data blit 301
	ld bc,52428	; offset 4550
	ld de,52428	; offset 4553
	ld hl,52428	; offset 4556
	exx    	; offset 4559
	ld bc,52428	; offset 4560
	ld de,52428	; offset 4563
	ld hl,52428	; offset 4566
	ld sp,screenStartAddr+4020	; offset 4569
	push hl	; offset 4572
	push de	; offset 4573
	push bc	; offset 4574
	exx    	; offset 4575
	push hl	; offset 4576
	push de	; offset 4577
	push bc	; offset 4578
	; Clock offset: -864

	; src_data blit 302
	ld bc,52428	; offset 4579
	ld de,52428	; offset 4582
	ld hl,52428	; offset 4585
	exx    	; offset 4588
	ld bc,52428	; offset 4589
	ld de,52428	; offset 4592
	ld hl,52428	; offset 4595
	ld sp,screenStartAddr+4032	; offset 4598
	push hl	; offset 4601
	push de	; offset 4602
	push bc	; offset 4603
	exx    	; offset 4604
	push hl	; offset 4605
	push de	; offset 4606
	push bc	; offset 4607
	; Clock offset: -720

	; src_data blit 303
	ld bc,52428	; offset 4608
	ld de,52428	; offset 4611
	ld hl,52428	; offset 4614
	exx    	; offset 4617
	ld bc,52428	; offset 4618
	ld de,52428	; offset 4621
	ld hl,52428	; offset 4624
	ld sp,screenStartAddr+2256	; offset 4627
	push hl	; offset 4630
	push de	; offset 4631
	push bc	; offset 4632
	exx    	; offset 4633
	push hl	; offset 4634
	push de	; offset 4635
	push bc	; offset 4636
	; Clock offset: -576

	; src_data blit 304
	ld bc,52428	; offset 4637
	ld de,52428	; offset 4640
	ld hl,52428	; offset 4643
	exx    	; offset 4646
	ld bc,52428	; offset 4647
	ld de,52428	; offset 4650
	ld hl,52428	; offset 4653
	ld sp,screenStartAddr+2268	; offset 4656
	push hl	; offset 4659
	push de	; offset 4660
	push bc	; offset 4661
	exx    	; offset 4662
	push hl	; offset 4663
	push de	; offset 4664
	push bc	; offset 4665
	; Clock offset: -432

	; src_data blit 305
	ld bc,52428	; offset 4666
	ld de,52428	; offset 4669
	ld hl,52428	; offset 4672
	exx    	; offset 4675
	ld bc,52428	; offset 4676
	ld de,52428	; offset 4679
	ld hl,52428	; offset 4682
	ld sp,screenStartAddr+2280	; offset 4685
	push hl	; offset 4688
	push de	; offset 4689
	push bc	; offset 4690
	exx    	; offset 4691
	push hl	; offset 4692
	push de	; offset 4693
	push bc	; offset 4694
	; Clock offset: -288

	; src_data blit 306
	ld bc,52428	; offset 4695
	ld de,52428	; offset 4698
	ld hl,52428	; offset 4701
	exx    	; offset 4704
	ld bc,52428	; offset 4705
	ld de,52428	; offset 4708
	ld hl,52428	; offset 4711
	ld sp,screenStartAddr+2508	; offset 4714
	push hl	; offset 4717
	push de	; offset 4718
	push bc	; offset 4719
	exx    	; offset 4720
	push hl	; offset 4721
	push de	; offset 4722
	push bc	; offset 4723
	; Clock offset: -144

	; src_data blit 307
	ld bc,52428	; offset 4724
	ld de,52428	; offset 4727
	ld hl,52428	; offset 4730
	exx    	; offset 4733
	ld bc,52428	; offset 4734
	ld de,52428	; offset 4737
	ld hl,52428	; offset 4740
	ld sp,screenStartAddr+2520	; offset 4743
	push hl	; offset 4746
	push de	; offset 4747
	push bc	; offset 4748
	exx    	; offset 4749
	push hl	; offset 4750
	push de	; offset 4751
	push bc	; offset 4752
	; Clock offset: 0

	; attr draw 2
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+64
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+64),hl
	ld hl,10280
	ld (attrStartAddr+2+64),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+64
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+64),hl
	; src_data filler blit 64
	ld bc,52428	; offset 5208
	ld de,52428	; offset 5211
	exx    	; offset 5214
	ld bc,52428	; offset 5215
	ld de,52428	; offset 5218
	ld sp,screenStartAddr+5796	; offset 5221
	push de	; offset 5224
	push bc	; offset 5225
	exx    	; offset 5226
	push de	; offset 5227
	push bc	; offset 5228
	nop
	; end attr draw 2
	; Clock offset: -1008

	; src_data blit 308
	ld bc,52428	; offset 5230
	ld de,52428	; offset 5233
	ld hl,52428	; offset 5236
	exx    	; offset 5239
	ld bc,52428	; offset 5240
	ld de,52428	; offset 5243
	ld hl,52428	; offset 5246
	ld sp,screenStartAddr+2532	; offset 5249
	push hl	; offset 5252
	push de	; offset 5253
	push bc	; offset 5254
	exx    	; offset 5255
	push hl	; offset 5256
	push de	; offset 5257
	push bc	; offset 5258
	; Clock offset: -864

	; src_data blit 309
	ld bc,52428	; offset 5259
	ld de,52428	; offset 5262
	ld hl,52428	; offset 5265
	exx    	; offset 5268
	ld bc,52428	; offset 5269
	ld de,52428	; offset 5272
	ld hl,52428	; offset 5275
	ld sp,screenStartAddr+2772	; offset 5278
	push hl	; offset 5281
	push de	; offset 5282
	push bc	; offset 5283
	exx    	; offset 5284
	push hl	; offset 5285
	push de	; offset 5286
	push bc	; offset 5287
	; Clock offset: -720

	; src_data blit 310
	ld bc,52428	; offset 5288
	ld de,52428	; offset 5291
	ld hl,52428	; offset 5294
	exx    	; offset 5297
	ld bc,52428	; offset 5298
	ld de,52428	; offset 5301
	ld hl,52428	; offset 5304
	ld sp,screenStartAddr+2784	; offset 5307
	push hl	; offset 5310
	push de	; offset 5311
	push bc	; offset 5312
	exx    	; offset 5313
	push hl	; offset 5314
	push de	; offset 5315
	push bc	; offset 5316
	; Clock offset: -576

	; src_data blit 311
	ld bc,52428	; offset 5317
	ld de,52428	; offset 5320
	ld hl,52428	; offset 5323
	exx    	; offset 5326
	ld bc,52428	; offset 5327
	ld de,52428	; offset 5330
	ld hl,52428	; offset 5333
	ld sp,screenStartAddr+3024	; offset 5336
	push hl	; offset 5339
	push de	; offset 5340
	push bc	; offset 5341
	exx    	; offset 5342
	push hl	; offset 5343
	push de	; offset 5344
	push bc	; offset 5345
	; Clock offset: -432

	; src_data blit 312
	ld bc,52428	; offset 5346
	ld de,52428	; offset 5349
	ld hl,52428	; offset 5352
	exx    	; offset 5355
	ld bc,52428	; offset 5356
	ld de,52428	; offset 5359
	ld hl,52428	; offset 5362
	ld sp,screenStartAddr+3036	; offset 5365
	push hl	; offset 5368
	push de	; offset 5369
	push bc	; offset 5370
	exx    	; offset 5371
	push hl	; offset 5372
	push de	; offset 5373
	push bc	; offset 5374
	; Clock offset: -288

	; src_data blit 313
	ld bc,52428	; offset 5375
	ld de,52428	; offset 5378
	ld hl,52428	; offset 5381
	exx    	; offset 5384
	ld bc,52428	; offset 5385
	ld de,52428	; offset 5388
	ld hl,52428	; offset 5391
	ld sp,screenStartAddr+3048	; offset 5394
	push hl	; offset 5397
	push de	; offset 5398
	push bc	; offset 5399
	exx    	; offset 5400
	push hl	; offset 5401
	push de	; offset 5402
	push bc	; offset 5403
	; Clock offset: -144

	; src_data blit 314
	ld bc,52428	; offset 5404
	ld de,52428	; offset 5407
	ld hl,52428	; offset 5410
	exx    	; offset 5413
	ld bc,52428	; offset 5414
	ld de,52428	; offset 5417
	ld hl,52428	; offset 5420
	ld sp,screenStartAddr+3276	; offset 5423
	push hl	; offset 5426
	push de	; offset 5427
	push bc	; offset 5428
	exx    	; offset 5429
	push hl	; offset 5430
	push de	; offset 5431
	push bc	; offset 5432
	; Clock offset: 0

	; attr draw 3
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+96
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+96),hl
	ld hl,10280
	ld (attrStartAddr+2+96),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+96
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+96),hl
	; src_data filler blit 96
	ld bc,52428	; offset 5888
	ld de,52428	; offset 5891
	exx    	; offset 5894
	ld bc,52428	; offset 5895
	ld de,52428	; offset 5898
	ld sp,screenStartAddr+5804	; offset 5901
	push de	; offset 5904
	push bc	; offset 5905
	exx    	; offset 5906
	push de	; offset 5907
	push bc	; offset 5908
	nop
	; end attr draw 3
	; Clock offset: -1008

	; src_data blit 315
	ld bc,52428	; offset 5910
	ld de,52428	; offset 5913
	ld hl,52428	; offset 5916
	exx    	; offset 5919
	ld bc,52428	; offset 5920
	ld de,52428	; offset 5923
	ld hl,52428	; offset 5926
	ld sp,screenStartAddr+3288	; offset 5929
	push hl	; offset 5932
	push de	; offset 5933
	push bc	; offset 5934
	exx    	; offset 5935
	push hl	; offset 5936
	push de	; offset 5937
	push bc	; offset 5938
	; Clock offset: -864

	; src_data blit 316
	ld bc,52428	; offset 5939
	ld de,52428	; offset 5942
	ld hl,52428	; offset 5945
	exx    	; offset 5948
	ld bc,52428	; offset 5949
	ld de,52428	; offset 5952
	ld hl,52428	; offset 5955
	ld sp,screenStartAddr+3300	; offset 5958
	push hl	; offset 5961
	push de	; offset 5962
	push bc	; offset 5963
	exx    	; offset 5964
	push hl	; offset 5965
	push de	; offset 5966
	push bc	; offset 5967
	; Clock offset: -720

	; src_data blit 317
	ld bc,52428	; offset 5968
	ld de,52428	; offset 5971
	ld hl,52428	; offset 5974
	exx    	; offset 5977
	ld bc,52428	; offset 5978
	ld de,52428	; offset 5981
	ld hl,52428	; offset 5984
	ld sp,screenStartAddr+3540	; offset 5987
	push hl	; offset 5990
	push de	; offset 5991
	push bc	; offset 5992
	exx    	; offset 5993
	push hl	; offset 5994
	push de	; offset 5995
	push bc	; offset 5996
	; Clock offset: -576

	; src_data blit 318
	ld bc,52428	; offset 5997
	ld de,52428	; offset 6000
	ld hl,52428	; offset 6003
	exx    	; offset 6006
	ld bc,52428	; offset 6007
	ld de,52428	; offset 6010
	ld hl,52428	; offset 6013
	ld sp,screenStartAddr+3552	; offset 6016
	push hl	; offset 6019
	push de	; offset 6020
	push bc	; offset 6021
	exx    	; offset 6022
	push hl	; offset 6023
	push de	; offset 6024
	push bc	; offset 6025
	; Clock offset: -432

	; src_data blit 319
	ld bc,52428	; offset 6026
	ld de,52428	; offset 6029
	ld hl,52428	; offset 6032
	exx    	; offset 6035
	ld bc,52428	; offset 6036
	ld de,52428	; offset 6039
	ld hl,52428	; offset 6042
	ld sp,screenStartAddr+3792	; offset 6045
	push hl	; offset 6048
	push de	; offset 6049
	push bc	; offset 6050
	exx    	; offset 6051
	push hl	; offset 6052
	push de	; offset 6053
	push bc	; offset 6054
	; Clock offset: -288

	; src_data blit 320
	ld bc,52428	; offset 6055
	ld de,52428	; offset 6058
	ld hl,52428	; offset 6061
	exx    	; offset 6064
	ld bc,52428	; offset 6065
	ld de,52428	; offset 6068
	ld hl,52428	; offset 6071
	ld sp,screenStartAddr+3804	; offset 6074
	push hl	; offset 6077
	push de	; offset 6078
	push bc	; offset 6079
	exx    	; offset 6080
	push hl	; offset 6081
	push de	; offset 6082
	push bc	; offset 6083
	; Clock offset: -144

	; src_data blit 321
	ld bc,52428	; offset 6084
	ld de,52428	; offset 6087
	ld hl,52428	; offset 6090
	exx    	; offset 6093
	ld bc,52428	; offset 6094
	ld de,52428	; offset 6097
	ld hl,52428	; offset 6100
	ld sp,screenStartAddr+3816	; offset 6103
	push hl	; offset 6106
	push de	; offset 6107
	push bc	; offset 6108
	exx    	; offset 6109
	push hl	; offset 6110
	push de	; offset 6111
	push bc	; offset 6112
	; Clock offset: 0

	; attr draw 4
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+128
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+128),hl
	ld hl,10280
	ld (attrStartAddr+2+128),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+128
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+128),hl
	; src_data filler blit 128
	ld bc,52428	; offset 6568
	ld de,52428	; offset 6571
	exx    	; offset 6574
	ld bc,52428	; offset 6575
	ld de,52428	; offset 6578
	ld sp,screenStartAddr+5812	; offset 6581
	push de	; offset 6584
	push bc	; offset 6585
	exx    	; offset 6586
	push de	; offset 6587
	push bc	; offset 6588
	nop
	; end attr draw 4
	; Clock offset: -1008

	; src_data blit 322
	ld bc,52428	; offset 6590
	ld de,52428	; offset 6593
	ld hl,52428	; offset 6596
	exx    	; offset 6599
	ld bc,52428	; offset 6600
	ld de,52428	; offset 6603
	ld hl,52428	; offset 6606
	ld sp,screenStartAddr+4044	; offset 6609
	push hl	; offset 6612
	push de	; offset 6613
	push bc	; offset 6614
	exx    	; offset 6615
	push hl	; offset 6616
	push de	; offset 6617
	push bc	; offset 6618
	; Clock offset: -864

	; src_data blit 323
	ld bc,52428	; offset 6619
	ld de,52428	; offset 6622
	ld hl,52428	; offset 6625
	exx    	; offset 6628
	ld bc,52428	; offset 6629
	ld de,52428	; offset 6632
	ld hl,52428	; offset 6635
	ld sp,screenStartAddr+4056	; offset 6638
	push hl	; offset 6641
	push de	; offset 6642
	push bc	; offset 6643
	exx    	; offset 6644
	push hl	; offset 6645
	push de	; offset 6646
	push bc	; offset 6647
	; Clock offset: -720

	; src_data blit 324
	ld bc,52428	; offset 6648
	ld de,52428	; offset 6651
	ld hl,52428	; offset 6654
	exx    	; offset 6657
	ld bc,52428	; offset 6658
	ld de,52428	; offset 6661
	ld hl,52428	; offset 6664
	ld sp,screenStartAddr+4068	; offset 6667
	push hl	; offset 6670
	push de	; offset 6671
	push bc	; offset 6672
	exx    	; offset 6673
	push hl	; offset 6674
	push de	; offset 6675
	push bc	; offset 6676
	; Clock offset: -576

	; src_data blit 325
	ld bc,52428	; offset 6677
	ld de,52428	; offset 6680
	ld hl,52428	; offset 6683
	exx    	; offset 6686
	ld bc,52428	; offset 6687
	ld de,52428	; offset 6690
	ld hl,52428	; offset 6693
	ld sp,screenStartAddr+2292	; offset 6696
	push hl	; offset 6699
	push de	; offset 6700
	push bc	; offset 6701
	exx    	; offset 6702
	push hl	; offset 6703
	push de	; offset 6704
	push bc	; offset 6705
	; Clock offset: -432

	; src_data blit 326
	ld bc,52428	; offset 6706
	ld de,52428	; offset 6709
	ld hl,52428	; offset 6712
	exx    	; offset 6715
	ld bc,52428	; offset 6716
	ld de,52428	; offset 6719
	ld hl,52428	; offset 6722
	ld sp,screenStartAddr+2304	; offset 6725
	push hl	; offset 6728
	push de	; offset 6729
	push bc	; offset 6730
	exx    	; offset 6731
	push hl	; offset 6732
	push de	; offset 6733
	push bc	; offset 6734
	; Clock offset: -288

	; src_data blit 327
	ld bc,52428	; offset 6735
	ld de,52428	; offset 6738
	ld hl,52428	; offset 6741
	exx    	; offset 6744
	ld bc,52428	; offset 6745
	ld de,52428	; offset 6748
	ld hl,52428	; offset 6751
	ld sp,screenStartAddr+2544	; offset 6754
	push hl	; offset 6757
	push de	; offset 6758
	push bc	; offset 6759
	exx    	; offset 6760
	push hl	; offset 6761
	push de	; offset 6762
	push bc	; offset 6763
	; Clock offset: -144

	; src_data blit 328
	ld bc,52428	; offset 6764
	ld de,52428	; offset 6767
	ld hl,52428	; offset 6770
	exx    	; offset 6773
	ld bc,52428	; offset 6774
	ld de,52428	; offset 6777
	ld hl,52428	; offset 6780
	ld sp,screenStartAddr+2556	; offset 6783
	push hl	; offset 6786
	push de	; offset 6787
	push bc	; offset 6788
	exx    	; offset 6789
	push hl	; offset 6790
	push de	; offset 6791
	push bc	; offset 6792
	; Clock offset: 0

	; attr draw 5
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+160
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+160),hl
	ld hl,10280
	ld (attrStartAddr+2+160),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+160
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+160),hl
	; src_data filler blit 160
	ld bc,52428	; offset 7248
	ld de,52428	; offset 7251
	exx    	; offset 7254
	ld bc,52428	; offset 7255
	ld de,52428	; offset 7258
	ld sp,screenStartAddr+5820	; offset 7261
	push de	; offset 7264
	push bc	; offset 7265
	exx    	; offset 7266
	push de	; offset 7267
	push bc	; offset 7268
	nop
	; end attr draw 5
	; Clock offset: -1008

	; src_data blit 329
	ld bc,52428	; offset 7270
	ld de,52428	; offset 7273
	ld hl,52428	; offset 7276
	exx    	; offset 7279
	ld bc,52428	; offset 7280
	ld de,52428	; offset 7283
	ld hl,52428	; offset 7286
	ld sp,screenStartAddr+2796	; offset 7289
	push hl	; offset 7292
	push de	; offset 7293
	push bc	; offset 7294
	exx    	; offset 7295
	push hl	; offset 7296
	push de	; offset 7297
	push bc	; offset 7298
	; Clock offset: -864

	; src_data blit 330
	ld bc,52428	; offset 7299
	ld de,52428	; offset 7302
	ld hl,52428	; offset 7305
	exx    	; offset 7308
	ld bc,52428	; offset 7309
	ld de,52428	; offset 7312
	ld hl,52428	; offset 7315
	ld sp,screenStartAddr+2808	; offset 7318
	push hl	; offset 7321
	push de	; offset 7322
	push bc	; offset 7323
	exx    	; offset 7324
	push hl	; offset 7325
	push de	; offset 7326
	push bc	; offset 7327
	; Clock offset: -720

	; src_data blit 331
	ld bc,52428	; offset 7328
	ld de,52428	; offset 7331
	ld hl,52428	; offset 7334
	exx    	; offset 7337
	ld bc,52428	; offset 7338
	ld de,52428	; offset 7341
	ld hl,52428	; offset 7344
	ld sp,screenStartAddr+3060	; offset 7347
	push hl	; offset 7350
	push de	; offset 7351
	push bc	; offset 7352
	exx    	; offset 7353
	push hl	; offset 7354
	push de	; offset 7355
	push bc	; offset 7356
	; Clock offset: -576

	; src_data blit 332
	ld bc,52428	; offset 7357
	ld de,52428	; offset 7360
	ld hl,52428	; offset 7363
	exx    	; offset 7366
	ld bc,52428	; offset 7367
	ld de,52428	; offset 7370
	ld hl,52428	; offset 7373
	ld sp,screenStartAddr+3072	; offset 7376
	push hl	; offset 7379
	push de	; offset 7380
	push bc	; offset 7381
	exx    	; offset 7382
	push hl	; offset 7383
	push de	; offset 7384
	push bc	; offset 7385
	; Clock offset: -432

	; src_data blit 333
	ld bc,52428	; offset 7386
	ld de,52428	; offset 7389
	ld hl,52428	; offset 7392
	exx    	; offset 7395
	ld bc,52428	; offset 7396
	ld de,52428	; offset 7399
	ld hl,52428	; offset 7402
	ld sp,screenStartAddr+3312	; offset 7405
	push hl	; offset 7408
	push de	; offset 7409
	push bc	; offset 7410
	exx    	; offset 7411
	push hl	; offset 7412
	push de	; offset 7413
	push bc	; offset 7414
	; Clock offset: -288

	; src_data blit 334
	ld bc,52428	; offset 7415
	ld de,52428	; offset 7418
	ld hl,52428	; offset 7421
	exx    	; offset 7424
	ld bc,52428	; offset 7425
	ld de,52428	; offset 7428
	ld hl,52428	; offset 7431
	ld sp,screenStartAddr+3324	; offset 7434
	push hl	; offset 7437
	push de	; offset 7438
	push bc	; offset 7439
	exx    	; offset 7440
	push hl	; offset 7441
	push de	; offset 7442
	push bc	; offset 7443
	; Clock offset: -144

	; src_data blit 335
	ld bc,52428	; offset 7444
	ld de,52428	; offset 7447
	ld hl,52428	; offset 7450
	exx    	; offset 7453
	ld bc,52428	; offset 7454
	ld de,52428	; offset 7457
	ld hl,52428	; offset 7460
	ld sp,screenStartAddr+3564	; offset 7463
	push hl	; offset 7466
	push de	; offset 7467
	push bc	; offset 7468
	exx    	; offset 7469
	push hl	; offset 7470
	push de	; offset 7471
	push bc	; offset 7472
	; Clock offset: 0

	; attr draw 6
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+192
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+192),hl
	ld hl,10280
	ld (attrStartAddr+2+192),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+192
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+192),hl
	; src_data filler blit 192
	ld bc,52428	; offset 7928
	ld de,52428	; offset 7931
	exx    	; offset 7934
	ld bc,52428	; offset 7935
	ld de,52428	; offset 7938
	ld sp,screenStartAddr+5828	; offset 7941
	push de	; offset 7944
	push bc	; offset 7945
	exx    	; offset 7946
	push de	; offset 7947
	push bc	; offset 7948
	nop
	; end attr draw 6
	; Clock offset: -1008

	; src_data blit 336
	ld bc,52428	; offset 7950
	ld de,52428	; offset 7953
	ld hl,52428	; offset 7956
	exx    	; offset 7959
	ld bc,52428	; offset 7960
	ld de,52428	; offset 7963
	ld hl,52428	; offset 7966
	ld sp,screenStartAddr+3576	; offset 7969
	push hl	; offset 7972
	push de	; offset 7973
	push bc	; offset 7974
	exx    	; offset 7975
	push hl	; offset 7976
	push de	; offset 7977
	push bc	; offset 7978
	; Clock offset: -864

	; src_data blit 337
	ld bc,52428	; offset 7979
	ld de,52428	; offset 7982
	ld hl,52428	; offset 7985
	exx    	; offset 7988
	ld bc,52428	; offset 7989
	ld de,52428	; offset 7992
	ld hl,52428	; offset 7995
	ld sp,screenStartAddr+3828	; offset 7998
	push hl	; offset 8001
	push de	; offset 8002
	push bc	; offset 8003
	exx    	; offset 8004
	push hl	; offset 8005
	push de	; offset 8006
	push bc	; offset 8007
	; Clock offset: -720

	; src_data blit 338
	ld bc,52428	; offset 8008
	ld de,52428	; offset 8011
	ld hl,52428	; offset 8014
	exx    	; offset 8017
	ld bc,52428	; offset 8018
	ld de,52428	; offset 8021
	ld hl,52428	; offset 8024
	ld sp,screenStartAddr+3840	; offset 8027
	push hl	; offset 8030
	push de	; offset 8031
	push bc	; offset 8032
	exx    	; offset 8033
	push hl	; offset 8034
	push de	; offset 8035
	push bc	; offset 8036
	; Clock offset: -576

	; src_data blit 339
	ld bc,52428	; offset 8037
	ld de,52428	; offset 8040
	ld hl,52428	; offset 8043
	exx    	; offset 8046
	ld bc,52428	; offset 8047
	ld de,52428	; offset 8050
	ld hl,52428	; offset 8053
	ld sp,screenStartAddr+4080	; offset 8056
	push hl	; offset 8059
	push de	; offset 8060
	push bc	; offset 8061
	exx    	; offset 8062
	push hl	; offset 8063
	push de	; offset 8064
	push bc	; offset 8065
	; Clock offset: -432

	; src_data blit 340
	ld bc,52428	; offset 8066
	ld de,52428	; offset 8069
	ld hl,52428	; offset 8072
	exx    	; offset 8075
	ld bc,52428	; offset 8076
	ld de,52428	; offset 8079
	ld hl,52428	; offset 8082
	ld sp,screenStartAddr+4092	; offset 8085
	push hl	; offset 8088
	push de	; offset 8089
	push bc	; offset 8090
	exx    	; offset 8091
	push hl	; offset 8092
	push de	; offset 8093
	push bc	; offset 8094
	; Clock offset: -288

	; src_data blit 341
	ld bc,52428	; offset 8095
	ld de,52428	; offset 8098
	ld hl,52428	; offset 8101
	exx    	; offset 8104
	ld bc,52428	; offset 8105
	ld de,52428	; offset 8108
	ld hl,52428	; offset 8111
	ld sp,screenStartAddr+4104	; offset 8114
	push hl	; offset 8117
	push de	; offset 8118
	push bc	; offset 8119
	exx    	; offset 8120
	push hl	; offset 8121
	push de	; offset 8122
	push bc	; offset 8123
	; Clock offset: -144

	; src_data blit 342
	ld bc,52428	; offset 8124
	ld de,52428	; offset 8127
	ld hl,52428	; offset 8130
	exx    	; offset 8133
	ld bc,52428	; offset 8134
	ld de,52428	; offset 8137
	ld hl,52428	; offset 8140
	ld sp,screenStartAddr+4116	; offset 8143
	push hl	; offset 8146
	push de	; offset 8147
	push bc	; offset 8148
	exx    	; offset 8149
	push hl	; offset 8150
	push de	; offset 8151
	push bc	; offset 8152
	; Clock offset: 0

	; attr draw 7
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+224
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+224),hl
	ld hl,10280
	ld (attrStartAddr+2+224),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+224
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+224),hl
	; src_data filler blit 224
	ld bc,52428	; offset 8608
	ld de,52428	; offset 8611
	exx    	; offset 8614
	ld bc,52428	; offset 8615
	ld de,52428	; offset 8618
	ld sp,screenStartAddr+5836	; offset 8621
	push de	; offset 8624
	push bc	; offset 8625
	exx    	; offset 8626
	push de	; offset 8627
	push bc	; offset 8628
	nop
	; end attr draw 7
	; Clock offset: -1008

	; src_data blit 343
	ld bc,52428	; offset 8630
	ld de,52428	; offset 8633
	ld hl,52428	; offset 8636
	exx    	; offset 8639
	ld bc,52428	; offset 8640
	ld de,52428	; offset 8643
	ld hl,52428	; offset 8646
	ld sp,screenStartAddr+4128	; offset 8649
	push hl	; offset 8652
	push de	; offset 8653
	push bc	; offset 8654
	exx    	; offset 8655
	push hl	; offset 8656
	push de	; offset 8657
	push bc	; offset 8658
	; Clock offset: -864

	; src_data blit 344
	ld bc,52428	; offset 8659
	ld de,52428	; offset 8662
	ld hl,52428	; offset 8665
	exx    	; offset 8668
	ld bc,52428	; offset 8669
	ld de,52428	; offset 8672
	ld hl,52428	; offset 8675
	ld sp,screenStartAddr+4356	; offset 8678
	push hl	; offset 8681
	push de	; offset 8682
	push bc	; offset 8683
	exx    	; offset 8684
	push hl	; offset 8685
	push de	; offset 8686
	push bc	; offset 8687
	; Clock offset: -720

	; src_data blit 345
	ld bc,52428	; offset 8688
	ld de,52428	; offset 8691
	ld hl,52428	; offset 8694
	exx    	; offset 8697
	ld bc,52428	; offset 8698
	ld de,52428	; offset 8701
	ld hl,52428	; offset 8704
	ld sp,screenStartAddr+4368	; offset 8707
	push hl	; offset 8710
	push de	; offset 8711
	push bc	; offset 8712
	exx    	; offset 8713
	push hl	; offset 8714
	push de	; offset 8715
	push bc	; offset 8716
	; Clock offset: -576

	; src_data blit 346
	ld bc,52428	; offset 8717
	ld de,52428	; offset 8720
	ld hl,52428	; offset 8723
	exx    	; offset 8726
	ld bc,52428	; offset 8727
	ld de,52428	; offset 8730
	ld hl,52428	; offset 8733
	ld sp,screenStartAddr+4380	; offset 8736
	push hl	; offset 8739
	push de	; offset 8740
	push bc	; offset 8741
	exx    	; offset 8742
	push hl	; offset 8743
	push de	; offset 8744
	push bc	; offset 8745
	; Clock offset: -432

	; src_data blit 347
	ld bc,52428	; offset 8746
	ld de,52428	; offset 8749
	ld hl,52428	; offset 8752
	exx    	; offset 8755
	ld bc,52428	; offset 8756
	ld de,52428	; offset 8759
	ld hl,52428	; offset 8762
	ld sp,screenStartAddr+4392	; offset 8765
	push hl	; offset 8768
	push de	; offset 8769
	push bc	; offset 8770
	exx    	; offset 8771
	push hl	; offset 8772
	push de	; offset 8773
	push bc	; offset 8774
	; Clock offset: -288

	; src_data blit 348
	ld bc,52428	; offset 8775
	ld de,52428	; offset 8778
	ld hl,52428	; offset 8781
	exx    	; offset 8784
	ld bc,52428	; offset 8785
	ld de,52428	; offset 8788
	ld hl,52428	; offset 8791
	ld sp,screenStartAddr+4620	; offset 8794
	push hl	; offset 8797
	push de	; offset 8798
	push bc	; offset 8799
	exx    	; offset 8800
	push hl	; offset 8801
	push de	; offset 8802
	push bc	; offset 8803
	; Clock offset: -144

	; src_data blit 349
	ld bc,52428	; offset 8804
	ld de,52428	; offset 8807
	ld hl,52428	; offset 8810
	exx    	; offset 8813
	ld bc,52428	; offset 8814
	ld de,52428	; offset 8817
	ld hl,52428	; offset 8820
	ld sp,screenStartAddr+4632	; offset 8823
	push hl	; offset 8826
	push de	; offset 8827
	push bc	; offset 8828
	exx    	; offset 8829
	push hl	; offset 8830
	push de	; offset 8831
	push bc	; offset 8832
	; Clock offset: 0

	; attr draw 8
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+256
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+256),hl
	ld hl,10280
	ld (attrStartAddr+2+256),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+256
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+256),hl
	; src_data filler blit 256
	ld bc,52428	; offset 9288
	ld de,52428	; offset 9291
	exx    	; offset 9294
	ld bc,52428	; offset 9295
	ld de,52428	; offset 9298
	ld sp,screenStartAddr+5844	; offset 9301
	push de	; offset 9304
	push bc	; offset 9305
	exx    	; offset 9306
	push de	; offset 9307
	push bc	; offset 9308
	nop
	; end attr draw 8
	; Clock offset: -1008

	; src_data blit 350
	ld bc,52428	; offset 9310
	ld de,52428	; offset 9313
	ld hl,52428	; offset 9316
	exx    	; offset 9319
	ld bc,52428	; offset 9320
	ld de,52428	; offset 9323
	ld hl,52428	; offset 9326
	ld sp,screenStartAddr+4644	; offset 9329
	push hl	; offset 9332
	push de	; offset 9333
	push bc	; offset 9334
	exx    	; offset 9335
	push hl	; offset 9336
	push de	; offset 9337
	push bc	; offset 9338
	; Clock offset: -864

	; src_data blit 351
	ld bc,52428	; offset 9339
	ld de,52428	; offset 9342
	ld hl,52428	; offset 9345
	exx    	; offset 9348
	ld bc,52428	; offset 9349
	ld de,52428	; offset 9352
	ld hl,52428	; offset 9355
	ld sp,screenStartAddr+4872	; offset 9358
	push hl	; offset 9361
	push de	; offset 9362
	push bc	; offset 9363
	exx    	; offset 9364
	push hl	; offset 9365
	push de	; offset 9366
	push bc	; offset 9367
	; Clock offset: -720

	; src_data blit 352
	ld bc,52428	; offset 9368
	ld de,52428	; offset 9371
	ld hl,52428	; offset 9374
	exx    	; offset 9377
	ld bc,52428	; offset 9378
	ld de,52428	; offset 9381
	ld hl,52428	; offset 9384
	ld sp,screenStartAddr+4884	; offset 9387
	push hl	; offset 9390
	push de	; offset 9391
	push bc	; offset 9392
	exx    	; offset 9393
	push hl	; offset 9394
	push de	; offset 9395
	push bc	; offset 9396
	; Clock offset: -576

	; src_data blit 353
	ld bc,52428	; offset 9397
	ld de,52428	; offset 9400
	ld hl,52428	; offset 9403
	exx    	; offset 9406
	ld bc,52428	; offset 9407
	ld de,52428	; offset 9410
	ld hl,52428	; offset 9413
	ld sp,screenStartAddr+4896	; offset 9416
	push hl	; offset 9419
	push de	; offset 9420
	push bc	; offset 9421
	exx    	; offset 9422
	push hl	; offset 9423
	push de	; offset 9424
	push bc	; offset 9425
	; Clock offset: -432

	; src_data blit 354
	ld bc,52428	; offset 9426
	ld de,52428	; offset 9429
	ld hl,52428	; offset 9432
	exx    	; offset 9435
	ld bc,52428	; offset 9436
	ld de,52428	; offset 9439
	ld hl,52428	; offset 9442
	ld sp,screenStartAddr+5124	; offset 9445
	push hl	; offset 9448
	push de	; offset 9449
	push bc	; offset 9450
	exx    	; offset 9451
	push hl	; offset 9452
	push de	; offset 9453
	push bc	; offset 9454
	; Clock offset: -288

	; src_data blit 355
	ld bc,52428	; offset 9455
	ld de,52428	; offset 9458
	ld hl,52428	; offset 9461
	exx    	; offset 9464
	ld bc,52428	; offset 9465
	ld de,52428	; offset 9468
	ld hl,52428	; offset 9471
	ld sp,screenStartAddr+5136	; offset 9474
	push hl	; offset 9477
	push de	; offset 9478
	push bc	; offset 9479
	exx    	; offset 9480
	push hl	; offset 9481
	push de	; offset 9482
	push bc	; offset 9483
	; Clock offset: -144

	; src_data blit 356
	ld bc,52428	; offset 9484
	ld de,52428	; offset 9487
	ld hl,52428	; offset 9490
	exx    	; offset 9493
	ld bc,52428	; offset 9494
	ld de,52428	; offset 9497
	ld hl,52428	; offset 9500
	ld sp,screenStartAddr+5148	; offset 9503
	push hl	; offset 9506
	push de	; offset 9507
	push bc	; offset 9508
	exx    	; offset 9509
	push hl	; offset 9510
	push de	; offset 9511
	push bc	; offset 9512
	; Clock offset: 0

	; attr draw 9
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+288
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+288),hl
	ld hl,10280
	ld (attrStartAddr+2+288),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+288
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+288),hl
	; src_data filler blit 288
	ld bc,52428	; offset 9968
	ld de,52428	; offset 9971
	exx    	; offset 9974
	ld bc,52428	; offset 9975
	ld de,52428	; offset 9978
	ld sp,screenStartAddr+5852	; offset 9981
	push de	; offset 9984
	push bc	; offset 9985
	exx    	; offset 9986
	push de	; offset 9987
	push bc	; offset 9988
	nop
	; end attr draw 9
	; Clock offset: -1008

	; src_data blit 357
	ld bc,52428	; offset 9990
	ld de,52428	; offset 9993
	ld hl,52428	; offset 9996
	exx    	; offset 9999
	ld bc,52428	; offset 10000
	ld de,52428	; offset 10003
	ld hl,52428	; offset 10006
	ld sp,screenStartAddr+5160	; offset 10009
	push hl	; offset 10012
	push de	; offset 10013
	push bc	; offset 10014
	exx    	; offset 10015
	push hl	; offset 10016
	push de	; offset 10017
	push bc	; offset 10018
	; Clock offset: -864

	; src_data blit 358
	ld bc,52428	; offset 10019
	ld de,52428	; offset 10022
	ld hl,52428	; offset 10025
	exx    	; offset 10028
	ld bc,52428	; offset 10029
	ld de,52428	; offset 10032
	ld hl,52428	; offset 10035
	ld sp,screenStartAddr+5388	; offset 10038
	push hl	; offset 10041
	push de	; offset 10042
	push bc	; offset 10043
	exx    	; offset 10044
	push hl	; offset 10045
	push de	; offset 10046
	push bc	; offset 10047
	; Clock offset: -720

	; src_data blit 359
	ld bc,52428	; offset 10048
	ld de,52428	; offset 10051
	ld hl,52428	; offset 10054
	exx    	; offset 10057
	ld bc,52428	; offset 10058
	ld de,52428	; offset 10061
	ld hl,52428	; offset 10064
	ld sp,screenStartAddr+5400	; offset 10067
	push hl	; offset 10070
	push de	; offset 10071
	push bc	; offset 10072
	exx    	; offset 10073
	push hl	; offset 10074
	push de	; offset 10075
	push bc	; offset 10076
	; Clock offset: -576

	; src_data blit 360
	ld bc,52428	; offset 10077
	ld de,52428	; offset 10080
	ld hl,52428	; offset 10083
	exx    	; offset 10086
	ld bc,52428	; offset 10087
	ld de,52428	; offset 10090
	ld hl,52428	; offset 10093
	ld sp,screenStartAddr+5412	; offset 10096
	push hl	; offset 10099
	push de	; offset 10100
	push bc	; offset 10101
	exx    	; offset 10102
	push hl	; offset 10103
	push de	; offset 10104
	push bc	; offset 10105
	; Clock offset: -432

	; src_data blit 361
	ld bc,52428	; offset 10106
	ld de,52428	; offset 10109
	ld hl,52428	; offset 10112
	exx    	; offset 10115
	ld bc,52428	; offset 10116
	ld de,52428	; offset 10119
	ld hl,52428	; offset 10122
	ld sp,screenStartAddr+5640	; offset 10125
	push hl	; offset 10128
	push de	; offset 10129
	push bc	; offset 10130
	exx    	; offset 10131
	push hl	; offset 10132
	push de	; offset 10133
	push bc	; offset 10134
	; Clock offset: -288

	; src_data blit 362
	ld bc,52428	; offset 10135
	ld de,52428	; offset 10138
	ld hl,52428	; offset 10141
	exx    	; offset 10144
	ld bc,52428	; offset 10145
	ld de,52428	; offset 10148
	ld hl,52428	; offset 10151
	ld sp,screenStartAddr+5652	; offset 10154
	push hl	; offset 10157
	push de	; offset 10158
	push bc	; offset 10159
	exx    	; offset 10160
	push hl	; offset 10161
	push de	; offset 10162
	push bc	; offset 10163
	; Clock offset: -144

	; src_data blit 363
	ld bc,52428	; offset 10164
	ld de,52428	; offset 10167
	ld hl,52428	; offset 10170
	exx    	; offset 10173
	ld bc,52428	; offset 10174
	ld de,52428	; offset 10177
	ld hl,52428	; offset 10180
	ld sp,screenStartAddr+5664	; offset 10183
	push hl	; offset 10186
	push de	; offset 10187
	push bc	; offset 10188
	exx    	; offset 10189
	push hl	; offset 10190
	push de	; offset 10191
	push bc	; offset 10192
	; Clock offset: 0

	; attr draw 10
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+320
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+320),hl
	ld hl,10280
	ld (attrStartAddr+2+320),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+320
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+320),hl
	; src_data filler blit 320
	ld bc,52428	; offset 10648
	ld de,52428	; offset 10651
	exx    	; offset 10654
	ld bc,52428	; offset 10655
	ld de,52428	; offset 10658
	ld sp,screenStartAddr+5860	; offset 10661
	push de	; offset 10664
	push bc	; offset 10665
	exx    	; offset 10666
	push de	; offset 10667
	push bc	; offset 10668
	nop
	; end attr draw 10
	; Clock offset: -1008

	; src_data blit 364
	ld bc,52428	; offset 10670
	ld de,52428	; offset 10673
	ld hl,52428	; offset 10676
	exx    	; offset 10679
	ld bc,52428	; offset 10680
	ld de,52428	; offset 10683
	ld hl,52428	; offset 10686
	ld sp,screenStartAddr+4140	; offset 10689
	push hl	; offset 10692
	push de	; offset 10693
	push bc	; offset 10694
	exx    	; offset 10695
	push hl	; offset 10696
	push de	; offset 10697
	push bc	; offset 10698
	; Clock offset: -864

	; src_data blit 365
	ld bc,52428	; offset 10699
	ld de,52428	; offset 10702
	ld hl,52428	; offset 10705
	exx    	; offset 10708
	ld bc,52428	; offset 10709
	ld de,52428	; offset 10712
	ld hl,52428	; offset 10715
	ld sp,screenStartAddr+4152	; offset 10718
	push hl	; offset 10721
	push de	; offset 10722
	push bc	; offset 10723
	exx    	; offset 10724
	push hl	; offset 10725
	push de	; offset 10726
	push bc	; offset 10727
	; Clock offset: -720

	; src_data blit 366
	ld bc,52428	; offset 10728
	ld de,52428	; offset 10731
	ld hl,52428	; offset 10734
	exx    	; offset 10737
	ld bc,52428	; offset 10738
	ld de,52428	; offset 10741
	ld hl,52428	; offset 10744
	ld sp,screenStartAddr+4164	; offset 10747
	push hl	; offset 10750
	push de	; offset 10751
	push bc	; offset 10752
	exx    	; offset 10753
	push hl	; offset 10754
	push de	; offset 10755
	push bc	; offset 10756
	; Clock offset: -576

	; src_data blit 367
	ld bc,52428	; offset 10757
	ld de,52428	; offset 10760
	ld hl,52428	; offset 10763
	exx    	; offset 10766
	ld bc,52428	; offset 10767
	ld de,52428	; offset 10770
	ld hl,52428	; offset 10773
	ld sp,screenStartAddr+4404	; offset 10776
	push hl	; offset 10779
	push de	; offset 10780
	push bc	; offset 10781
	exx    	; offset 10782
	push hl	; offset 10783
	push de	; offset 10784
	push bc	; offset 10785
	; Clock offset: -432

	; src_data blit 368
	ld bc,52428	; offset 10786
	ld de,52428	; offset 10789
	ld hl,52428	; offset 10792
	exx    	; offset 10795
	ld bc,52428	; offset 10796
	ld de,52428	; offset 10799
	ld hl,52428	; offset 10802
	ld sp,screenStartAddr+4416	; offset 10805
	push hl	; offset 10808
	push de	; offset 10809
	push bc	; offset 10810
	exx    	; offset 10811
	push hl	; offset 10812
	push de	; offset 10813
	push bc	; offset 10814
	; Clock offset: -288

	; src_data blit 369
	ld bc,52428	; offset 10815
	ld de,52428	; offset 10818
	ld hl,52428	; offset 10821
	exx    	; offset 10824
	ld bc,52428	; offset 10825
	ld de,52428	; offset 10828
	ld hl,52428	; offset 10831
	ld sp,screenStartAddr+4656	; offset 10834
	push hl	; offset 10837
	push de	; offset 10838
	push bc	; offset 10839
	exx    	; offset 10840
	push hl	; offset 10841
	push de	; offset 10842
	push bc	; offset 10843
	; Clock offset: -144

	; src_data blit 370
	ld bc,52428	; offset 10844
	ld de,52428	; offset 10847
	ld hl,52428	; offset 10850
	exx    	; offset 10853
	ld bc,52428	; offset 10854
	ld de,52428	; offset 10857
	ld hl,52428	; offset 10860
	ld sp,screenStartAddr+4668	; offset 10863
	push hl	; offset 10866
	push de	; offset 10867
	push bc	; offset 10868
	exx    	; offset 10869
	push hl	; offset 10870
	push de	; offset 10871
	push bc	; offset 10872
	; Clock offset: 0

	; attr draw 11
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+352
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+352),hl
	ld hl,10280
	ld (attrStartAddr+2+352),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+352
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+352),hl
	; src_data filler blit 352
	ld bc,52428	; offset 11328
	ld de,52428	; offset 11331
	exx    	; offset 11334
	ld bc,52428	; offset 11335
	ld de,52428	; offset 11338
	ld sp,screenStartAddr+5868	; offset 11341
	push de	; offset 11344
	push bc	; offset 11345
	exx    	; offset 11346
	push de	; offset 11347
	push bc	; offset 11348
	nop
	; end attr draw 11
	; Clock offset: -1008

	; src_data blit 371
	ld bc,52428	; offset 11350
	ld de,52428	; offset 11353
	ld hl,52428	; offset 11356
	exx    	; offset 11359
	ld bc,52428	; offset 11360
	ld de,52428	; offset 11363
	ld hl,52428	; offset 11366
	ld sp,screenStartAddr+4680	; offset 11369
	push hl	; offset 11372
	push de	; offset 11373
	push bc	; offset 11374
	exx    	; offset 11375
	push hl	; offset 11376
	push de	; offset 11377
	push bc	; offset 11378
	; Clock offset: -864

	; src_data blit 372
	ld bc,52428	; offset 11379
	ld de,52428	; offset 11382
	ld hl,52428	; offset 11385
	exx    	; offset 11388
	ld bc,52428	; offset 11389
	ld de,52428	; offset 11392
	ld hl,52428	; offset 11395
	ld sp,screenStartAddr+4908	; offset 11398
	push hl	; offset 11401
	push de	; offset 11402
	push bc	; offset 11403
	exx    	; offset 11404
	push hl	; offset 11405
	push de	; offset 11406
	push bc	; offset 11407
	; Clock offset: -720

	; src_data blit 373
	ld bc,52428	; offset 11408
	ld de,52428	; offset 11411
	ld hl,52428	; offset 11414
	exx    	; offset 11417
	ld bc,52428	; offset 11418
	ld de,52428	; offset 11421
	ld hl,52428	; offset 11424
	ld sp,screenStartAddr+4920	; offset 11427
	push hl	; offset 11430
	push de	; offset 11431
	push bc	; offset 11432
	exx    	; offset 11433
	push hl	; offset 11434
	push de	; offset 11435
	push bc	; offset 11436
	; Clock offset: -576

	; src_data blit 374
	ld bc,52428	; offset 11437
	ld de,52428	; offset 11440
	ld hl,52428	; offset 11443
	exx    	; offset 11446
	ld bc,52428	; offset 11447
	ld de,52428	; offset 11450
	ld hl,52428	; offset 11453
	ld sp,screenStartAddr+4932	; offset 11456
	push hl	; offset 11459
	push de	; offset 11460
	push bc	; offset 11461
	exx    	; offset 11462
	push hl	; offset 11463
	push de	; offset 11464
	push bc	; offset 11465
	; Clock offset: -432

	; src_data blit 375
	ld bc,52428	; offset 11466
	ld de,52428	; offset 11469
	ld hl,52428	; offset 11472
	exx    	; offset 11475
	ld bc,52428	; offset 11476
	ld de,52428	; offset 11479
	ld hl,52428	; offset 11482
	ld sp,screenStartAddr+5172	; offset 11485
	push hl	; offset 11488
	push de	; offset 11489
	push bc	; offset 11490
	exx    	; offset 11491
	push hl	; offset 11492
	push de	; offset 11493
	push bc	; offset 11494
	; Clock offset: -288

	; src_data blit 376
	ld bc,52428	; offset 11495
	ld de,52428	; offset 11498
	ld hl,52428	; offset 11501
	exx    	; offset 11504
	ld bc,52428	; offset 11505
	ld de,52428	; offset 11508
	ld hl,52428	; offset 11511
	ld sp,screenStartAddr+5184	; offset 11514
	push hl	; offset 11517
	push de	; offset 11518
	push bc	; offset 11519
	exx    	; offset 11520
	push hl	; offset 11521
	push de	; offset 11522
	push bc	; offset 11523
	; Clock offset: -144

	; src_data blit 377
	ld bc,52428	; offset 11524
	ld de,52428	; offset 11527
	ld hl,52428	; offset 11530
	exx    	; offset 11533
	ld bc,52428	; offset 11534
	ld de,52428	; offset 11537
	ld hl,52428	; offset 11540
	ld sp,screenStartAddr+5424	; offset 11543
	push hl	; offset 11546
	push de	; offset 11547
	push bc	; offset 11548
	exx    	; offset 11549
	push hl	; offset 11550
	push de	; offset 11551
	push bc	; offset 11552
	; Clock offset: 0

	; attr draw 12
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+384
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+384),hl
	ld hl,10280
	ld (attrStartAddr+2+384),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+384
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+384),hl
	; src_data filler blit 384
	ld bc,52428	; offset 12008
	ld de,52428	; offset 12011
	exx    	; offset 12014
	ld bc,52428	; offset 12015
	ld de,52428	; offset 12018
	ld sp,screenStartAddr+5876	; offset 12021
	push de	; offset 12024
	push bc	; offset 12025
	exx    	; offset 12026
	push de	; offset 12027
	push bc	; offset 12028
	nop
	; end attr draw 12
	; Clock offset: -1008

	; src_data blit 378
	ld bc,52428	; offset 12030
	ld de,52428	; offset 12033
	ld hl,52428	; offset 12036
	exx    	; offset 12039
	ld bc,52428	; offset 12040
	ld de,52428	; offset 12043
	ld hl,52428	; offset 12046
	ld sp,screenStartAddr+5436	; offset 12049
	push hl	; offset 12052
	push de	; offset 12053
	push bc	; offset 12054
	exx    	; offset 12055
	push hl	; offset 12056
	push de	; offset 12057
	push bc	; offset 12058
	; Clock offset: -864

	; src_data blit 379
	ld bc,52428	; offset 12059
	ld de,52428	; offset 12062
	ld hl,52428	; offset 12065
	exx    	; offset 12068
	ld bc,52428	; offset 12069
	ld de,52428	; offset 12072
	ld hl,52428	; offset 12075
	ld sp,screenStartAddr+5448	; offset 12078
	push hl	; offset 12081
	push de	; offset 12082
	push bc	; offset 12083
	exx    	; offset 12084
	push hl	; offset 12085
	push de	; offset 12086
	push bc	; offset 12087
	; Clock offset: -720

	; src_data blit 380
	ld bc,52428	; offset 12088
	ld de,52428	; offset 12091
	ld hl,52428	; offset 12094
	exx    	; offset 12097
	ld bc,52428	; offset 12098
	ld de,52428	; offset 12101
	ld hl,52428	; offset 12104
	ld sp,screenStartAddr+5676	; offset 12107
	push hl	; offset 12110
	push de	; offset 12111
	push bc	; offset 12112
	exx    	; offset 12113
	push hl	; offset 12114
	push de	; offset 12115
	push bc	; offset 12116
	; Clock offset: -576

	; src_data blit 381
	ld bc,52428	; offset 12117
	ld de,52428	; offset 12120
	ld hl,52428	; offset 12123
	exx    	; offset 12126
	ld bc,52428	; offset 12127
	ld de,52428	; offset 12130
	ld hl,52428	; offset 12133
	ld sp,screenStartAddr+5688	; offset 12136
	push hl	; offset 12139
	push de	; offset 12140
	push bc	; offset 12141
	exx    	; offset 12142
	push hl	; offset 12143
	push de	; offset 12144
	push bc	; offset 12145
	; Clock offset: -432

	; src_data blit 382
	ld bc,52428	; offset 12146
	ld de,52428	; offset 12149
	ld hl,52428	; offset 12152
	exx    	; offset 12155
	ld bc,52428	; offset 12156
	ld de,52428	; offset 12159
	ld hl,52428	; offset 12162
	ld sp,screenStartAddr+5700	; offset 12165
	push hl	; offset 12168
	push de	; offset 12169
	push bc	; offset 12170
	exx    	; offset 12171
	push hl	; offset 12172
	push de	; offset 12173
	push bc	; offset 12174
	; Clock offset: -288

	; src_data blit 383
	ld bc,52428	; offset 12175
	ld de,52428	; offset 12178
	ld hl,52428	; offset 12181
	exx    	; offset 12184
	ld bc,52428	; offset 12185
	ld de,52428	; offset 12188
	ld hl,52428	; offset 12191
	ld sp,screenStartAddr+4176	; offset 12194
	push hl	; offset 12197
	push de	; offset 12198
	push bc	; offset 12199
	exx    	; offset 12200
	push hl	; offset 12201
	push de	; offset 12202
	push bc	; offset 12203
	; Clock offset: -144

	; src_data blit 384
	ld bc,52428	; offset 12204
	ld de,52428	; offset 12207
	ld hl,52428	; offset 12210
	exx    	; offset 12213
	ld bc,52428	; offset 12214
	ld de,52428	; offset 12217
	ld hl,52428	; offset 12220
	ld sp,screenStartAddr+4188	; offset 12223
	push hl	; offset 12226
	push de	; offset 12227
	push bc	; offset 12228
	exx    	; offset 12229
	push hl	; offset 12230
	push de	; offset 12231
	push bc	; offset 12232
	; Clock offset: 0

	; attr draw 13
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+416
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+416),hl
	ld hl,10280
	ld (attrStartAddr+2+416),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+416
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+416),hl
	; src_data filler blit 416
	ld bc,52428	; offset 12688
	ld de,52428	; offset 12691
	exx    	; offset 12694
	ld bc,52428	; offset 12695
	ld de,52428	; offset 12698
	ld sp,screenStartAddr+5884	; offset 12701
	push de	; offset 12704
	push bc	; offset 12705
	exx    	; offset 12706
	push de	; offset 12707
	push bc	; offset 12708
	nop
	; end attr draw 13
	; Clock offset: -1008

	; src_data blit 385
	ld bc,52428	; offset 12710
	ld de,52428	; offset 12713
	ld hl,52428	; offset 12716
	exx    	; offset 12719
	ld bc,52428	; offset 12720
	ld de,52428	; offset 12723
	ld hl,52428	; offset 12726
	ld sp,screenStartAddr+4200	; offset 12729
	push hl	; offset 12732
	push de	; offset 12733
	push bc	; offset 12734
	exx    	; offset 12735
	push hl	; offset 12736
	push de	; offset 12737
	push bc	; offset 12738
	; Clock offset: -864

	; src_data blit 386
	ld bc,52428	; offset 12739
	ld de,52428	; offset 12742
	ld hl,52428	; offset 12745
	exx    	; offset 12748
	ld bc,52428	; offset 12749
	ld de,52428	; offset 12752
	ld hl,52428	; offset 12755
	ld sp,screenStartAddr+4428	; offset 12758
	push hl	; offset 12761
	push de	; offset 12762
	push bc	; offset 12763
	exx    	; offset 12764
	push hl	; offset 12765
	push de	; offset 12766
	push bc	; offset 12767
	; Clock offset: -720

	; src_data blit 387
	ld bc,52428	; offset 12768
	ld de,52428	; offset 12771
	ld hl,52428	; offset 12774
	exx    	; offset 12777
	ld bc,52428	; offset 12778
	ld de,52428	; offset 12781
	ld hl,52428	; offset 12784
	ld sp,screenStartAddr+4440	; offset 12787
	push hl	; offset 12790
	push de	; offset 12791
	push bc	; offset 12792
	exx    	; offset 12793
	push hl	; offset 12794
	push de	; offset 12795
	push bc	; offset 12796
	; Clock offset: -576

	; src_data blit 388
	ld bc,52428	; offset 12797
	ld de,52428	; offset 12800
	ld hl,52428	; offset 12803
	exx    	; offset 12806
	ld bc,52428	; offset 12807
	ld de,52428	; offset 12810
	ld hl,52428	; offset 12813
	ld sp,screenStartAddr+4452	; offset 12816
	push hl	; offset 12819
	push de	; offset 12820
	push bc	; offset 12821
	exx    	; offset 12822
	push hl	; offset 12823
	push de	; offset 12824
	push bc	; offset 12825
	; Clock offset: -432

	; src_data blit 389
	ld bc,52428	; offset 12826
	ld de,52428	; offset 12829
	ld hl,52428	; offset 12832
	exx    	; offset 12835
	ld bc,52428	; offset 12836
	ld de,52428	; offset 12839
	ld hl,52428	; offset 12842
	ld sp,screenStartAddr+4692	; offset 12845
	push hl	; offset 12848
	push de	; offset 12849
	push bc	; offset 12850
	exx    	; offset 12851
	push hl	; offset 12852
	push de	; offset 12853
	push bc	; offset 12854
	; Clock offset: -288

	; src_data blit 390
	ld bc,52428	; offset 12855
	ld de,52428	; offset 12858
	ld hl,52428	; offset 12861
	exx    	; offset 12864
	ld bc,52428	; offset 12865
	ld de,52428	; offset 12868
	ld hl,52428	; offset 12871
	ld sp,screenStartAddr+4704	; offset 12874
	push hl	; offset 12877
	push de	; offset 12878
	push bc	; offset 12879
	exx    	; offset 12880
	push hl	; offset 12881
	push de	; offset 12882
	push bc	; offset 12883
	; Clock offset: -144

	; src_data blit 391
	ld bc,52428	; offset 12884
	ld de,52428	; offset 12887
	ld hl,52428	; offset 12890
	exx    	; offset 12893
	ld bc,52428	; offset 12894
	ld de,52428	; offset 12897
	ld hl,52428	; offset 12900
	ld sp,screenStartAddr+4944	; offset 12903
	push hl	; offset 12906
	push de	; offset 12907
	push bc	; offset 12908
	exx    	; offset 12909
	push hl	; offset 12910
	push de	; offset 12911
	push bc	; offset 12912
	; Clock offset: 0

	; attr draw 14
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+448
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+448),hl
	ld hl,10280
	ld (attrStartAddr+2+448),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+448
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+448),hl
	; src_data filler blit 448
	ld bc,52428	; offset 13368
	ld de,52428	; offset 13371
	exx    	; offset 13374
	ld bc,52428	; offset 13375
	ld de,52428	; offset 13378
	ld sp,screenStartAddr+5892	; offset 13381
	push de	; offset 13384
	push bc	; offset 13385
	exx    	; offset 13386
	push de	; offset 13387
	push bc	; offset 13388
	nop
	; end attr draw 14
	; Clock offset: -1008

	; src_data blit 392
	ld bc,52428	; offset 13390
	ld de,52428	; offset 13393
	ld hl,52428	; offset 13396
	exx    	; offset 13399
	ld bc,52428	; offset 13400
	ld de,52428	; offset 13403
	ld hl,52428	; offset 13406
	ld sp,screenStartAddr+4956	; offset 13409
	push hl	; offset 13412
	push de	; offset 13413
	push bc	; offset 13414
	exx    	; offset 13415
	push hl	; offset 13416
	push de	; offset 13417
	push bc	; offset 13418
	; Clock offset: -864

	; src_data blit 393
	ld bc,52428	; offset 13419
	ld de,52428	; offset 13422
	ld hl,52428	; offset 13425
	exx    	; offset 13428
	ld bc,52428	; offset 13429
	ld de,52428	; offset 13432
	ld hl,52428	; offset 13435
	ld sp,screenStartAddr+4968	; offset 13438
	push hl	; offset 13441
	push de	; offset 13442
	push bc	; offset 13443
	exx    	; offset 13444
	push hl	; offset 13445
	push de	; offset 13446
	push bc	; offset 13447
	; Clock offset: -720

	; src_data blit 394
	ld bc,52428	; offset 13448
	ld de,52428	; offset 13451
	ld hl,52428	; offset 13454
	exx    	; offset 13457
	ld bc,52428	; offset 13458
	ld de,52428	; offset 13461
	ld hl,52428	; offset 13464
	ld sp,screenStartAddr+5196	; offset 13467
	push hl	; offset 13470
	push de	; offset 13471
	push bc	; offset 13472
	exx    	; offset 13473
	push hl	; offset 13474
	push de	; offset 13475
	push bc	; offset 13476
	; Clock offset: -576

	; src_data blit 395
	ld bc,52428	; offset 13477
	ld de,52428	; offset 13480
	ld hl,52428	; offset 13483
	exx    	; offset 13486
	ld bc,52428	; offset 13487
	ld de,52428	; offset 13490
	ld hl,52428	; offset 13493
	ld sp,screenStartAddr+5208	; offset 13496
	push hl	; offset 13499
	push de	; offset 13500
	push bc	; offset 13501
	exx    	; offset 13502
	push hl	; offset 13503
	push de	; offset 13504
	push bc	; offset 13505
	; Clock offset: -432

	; src_data blit 396
	ld bc,52428	; offset 13506
	ld de,52428	; offset 13509
	ld hl,52428	; offset 13512
	exx    	; offset 13515
	ld bc,52428	; offset 13516
	ld de,52428	; offset 13519
	ld hl,52428	; offset 13522
	ld sp,screenStartAddr+5220	; offset 13525
	push hl	; offset 13528
	push de	; offset 13529
	push bc	; offset 13530
	exx    	; offset 13531
	push hl	; offset 13532
	push de	; offset 13533
	push bc	; offset 13534
	; Clock offset: -288

	; src_data blit 397
	ld bc,52428	; offset 13535
	ld de,52428	; offset 13538
	ld hl,52428	; offset 13541
	exx    	; offset 13544
	ld bc,52428	; offset 13545
	ld de,52428	; offset 13548
	ld hl,52428	; offset 13551
	ld sp,screenStartAddr+5460	; offset 13554
	push hl	; offset 13557
	push de	; offset 13558
	push bc	; offset 13559
	exx    	; offset 13560
	push hl	; offset 13561
	push de	; offset 13562
	push bc	; offset 13563
	; Clock offset: -144

	; src_data blit 398
	ld bc,52428	; offset 13564
	ld de,52428	; offset 13567
	ld hl,52428	; offset 13570
	exx    	; offset 13573
	ld bc,52428	; offset 13574
	ld de,52428	; offset 13577
	ld hl,52428	; offset 13580
	ld sp,screenStartAddr+5472	; offset 13583
	push hl	; offset 13586
	push de	; offset 13587
	push bc	; offset 13588
	exx    	; offset 13589
	push hl	; offset 13590
	push de	; offset 13591
	push bc	; offset 13592
	; Clock offset: 0

	; attr draw 15
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+480
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+480),hl
	ld hl,10280
	ld (attrStartAddr+2+480),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+480
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+480),hl
	; src_data filler blit 480
	ld bc,52428	; offset 14048
	ld de,52428	; offset 14051
	exx    	; offset 14054
	ld bc,52428	; offset 14055
	ld de,52428	; offset 14058
	ld sp,screenStartAddr+5900	; offset 14061
	push de	; offset 14064
	push bc	; offset 14065
	exx    	; offset 14066
	push de	; offset 14067
	push bc	; offset 14068
	nop
	; end attr draw 15
	; Clock offset: -1008

	; src_data blit 399
	ld bc,52428	; offset 14070
	ld de,52428	; offset 14073
	ld hl,52428	; offset 14076
	exx    	; offset 14079
	ld bc,52428	; offset 14080
	ld de,52428	; offset 14083
	ld hl,52428	; offset 14086
	ld sp,screenStartAddr+5712	; offset 14089
	push hl	; offset 14092
	push de	; offset 14093
	push bc	; offset 14094
	exx    	; offset 14095
	push hl	; offset 14096
	push de	; offset 14097
	push bc	; offset 14098
	; Clock offset: -864

	; src_data blit 400
	ld bc,52428	; offset 14099
	ld de,52428	; offset 14102
	ld hl,52428	; offset 14105
	exx    	; offset 14108
	ld bc,52428	; offset 14109
	ld de,52428	; offset 14112
	ld hl,52428	; offset 14115
	ld sp,screenStartAddr+5724	; offset 14118
	push hl	; offset 14121
	push de	; offset 14122
	push bc	; offset 14123
	exx    	; offset 14124
	push hl	; offset 14125
	push de	; offset 14126
	push bc	; offset 14127
	; Clock offset: -720

	; src_data blit 401
	ld bc,52428	; offset 14128
	ld de,52428	; offset 14131
	ld hl,52428	; offset 14134
	exx    	; offset 14137
	ld bc,52428	; offset 14138
	ld de,52428	; offset 14141
	ld hl,52428	; offset 14144
	ld sp,screenStartAddr+5736	; offset 14147
	push hl	; offset 14150
	push de	; offset 14151
	push bc	; offset 14152
	exx    	; offset 14153
	push hl	; offset 14154
	push de	; offset 14155
	push bc	; offset 14156
	; Clock offset: -576

	; src_data blit 402
	ld bc,52428	; offset 14157
	ld de,52428	; offset 14160
	ld hl,52428	; offset 14163
	exx    	; offset 14166
	ld bc,52428	; offset 14167
	ld de,52428	; offset 14170
	ld hl,52428	; offset 14173
	ld sp,screenStartAddr+4212	; offset 14176
	push hl	; offset 14179
	push de	; offset 14180
	push bc	; offset 14181
	exx    	; offset 14182
	push hl	; offset 14183
	push de	; offset 14184
	push bc	; offset 14185
	; Clock offset: -432

	; src_data blit 403
	ld bc,52428	; offset 14186
	ld de,52428	; offset 14189
	ld hl,52428	; offset 14192
	exx    	; offset 14195
	ld bc,52428	; offset 14196
	ld de,52428	; offset 14199
	ld hl,52428	; offset 14202
	ld sp,screenStartAddr+4224	; offset 14205
	push hl	; offset 14208
	push de	; offset 14209
	push bc	; offset 14210
	exx    	; offset 14211
	push hl	; offset 14212
	push de	; offset 14213
	push bc	; offset 14214
	; Clock offset: -288

	; src_data blit 404
	ld bc,52428	; offset 14215
	ld de,52428	; offset 14218
	ld hl,52428	; offset 14221
	exx    	; offset 14224
	ld bc,52428	; offset 14225
	ld de,52428	; offset 14228
	ld hl,52428	; offset 14231
	ld sp,screenStartAddr+4464	; offset 14234
	push hl	; offset 14237
	push de	; offset 14238
	push bc	; offset 14239
	exx    	; offset 14240
	push hl	; offset 14241
	push de	; offset 14242
	push bc	; offset 14243
	; Clock offset: -144

	; src_data blit 405
	ld bc,52428	; offset 14244
	ld de,52428	; offset 14247
	ld hl,52428	; offset 14250
	exx    	; offset 14253
	ld bc,52428	; offset 14254
	ld de,52428	; offset 14257
	ld hl,52428	; offset 14260
	ld sp,screenStartAddr+4476	; offset 14263
	push hl	; offset 14266
	push de	; offset 14267
	push bc	; offset 14268
	exx    	; offset 14269
	push hl	; offset 14270
	push de	; offset 14271
	push bc	; offset 14272
	; Clock offset: 0

	; attr draw 16
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+512
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+512),hl
	ld hl,10280
	ld (attrStartAddr+2+512),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+512
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+512),hl
	; src_data filler blit 512
	ld bc,52428	; offset 14728
	ld de,52428	; offset 14731
	exx    	; offset 14734
	ld bc,52428	; offset 14735
	ld de,52428	; offset 14738
	ld sp,screenStartAddr+5908	; offset 14741
	push de	; offset 14744
	push bc	; offset 14745
	exx    	; offset 14746
	push de	; offset 14747
	push bc	; offset 14748
	nop
	; end attr draw 16
	; Clock offset: -1008

	; src_data blit 406
	ld bc,52428	; offset 14750
	ld de,52428	; offset 14753
	ld hl,52428	; offset 14756
	exx    	; offset 14759
	ld bc,52428	; offset 14760
	ld de,52428	; offset 14763
	ld hl,52428	; offset 14766
	ld sp,screenStartAddr+4488	; offset 14769
	push hl	; offset 14772
	push de	; offset 14773
	push bc	; offset 14774
	exx    	; offset 14775
	push hl	; offset 14776
	push de	; offset 14777
	push bc	; offset 14778
	; Clock offset: -864

	; src_data blit 407
	ld bc,52428	; offset 14779
	ld de,52428	; offset 14782
	ld hl,52428	; offset 14785
	exx    	; offset 14788
	ld bc,52428	; offset 14789
	ld de,52428	; offset 14792
	ld hl,52428	; offset 14795
	ld sp,screenStartAddr+4716	; offset 14798
	push hl	; offset 14801
	push de	; offset 14802
	push bc	; offset 14803
	exx    	; offset 14804
	push hl	; offset 14805
	push de	; offset 14806
	push bc	; offset 14807
	; Clock offset: -720

	; src_data blit 408
	ld bc,52428	; offset 14808
	ld de,52428	; offset 14811
	ld hl,52428	; offset 14814
	exx    	; offset 14817
	ld bc,52428	; offset 14818
	ld de,52428	; offset 14821
	ld hl,52428	; offset 14824
	ld sp,screenStartAddr+4728	; offset 14827
	push hl	; offset 14830
	push de	; offset 14831
	push bc	; offset 14832
	exx    	; offset 14833
	push hl	; offset 14834
	push de	; offset 14835
	push bc	; offset 14836
	; Clock offset: -576

	; src_data blit 409
	ld bc,52428	; offset 14837
	ld de,52428	; offset 14840
	ld hl,52428	; offset 14843
	exx    	; offset 14846
	ld bc,52428	; offset 14847
	ld de,52428	; offset 14850
	ld hl,52428	; offset 14853
	ld sp,screenStartAddr+4740	; offset 14856
	push hl	; offset 14859
	push de	; offset 14860
	push bc	; offset 14861
	exx    	; offset 14862
	push hl	; offset 14863
	push de	; offset 14864
	push bc	; offset 14865
	; Clock offset: -432

	; src_data blit 410
	ld bc,52428	; offset 14866
	ld de,52428	; offset 14869
	ld hl,52428	; offset 14872
	exx    	; offset 14875
	ld bc,52428	; offset 14876
	ld de,52428	; offset 14879
	ld hl,52428	; offset 14882
	ld sp,screenStartAddr+4980	; offset 14885
	push hl	; offset 14888
	push de	; offset 14889
	push bc	; offset 14890
	exx    	; offset 14891
	push hl	; offset 14892
	push de	; offset 14893
	push bc	; offset 14894
	; Clock offset: -288

	; src_data blit 411
	ld bc,52428	; offset 14895
	ld de,52428	; offset 14898
	ld hl,52428	; offset 14901
	exx    	; offset 14904
	ld bc,52428	; offset 14905
	ld de,52428	; offset 14908
	ld hl,52428	; offset 14911
	ld sp,screenStartAddr+4992	; offset 14914
	push hl	; offset 14917
	push de	; offset 14918
	push bc	; offset 14919
	exx    	; offset 14920
	push hl	; offset 14921
	push de	; offset 14922
	push bc	; offset 14923
	; Clock offset: -144

	; src_data blit 412
	ld bc,52428	; offset 14924
	ld de,52428	; offset 14927
	ld hl,52428	; offset 14930
	exx    	; offset 14933
	ld bc,52428	; offset 14934
	ld de,52428	; offset 14937
	ld hl,52428	; offset 14940
	ld sp,screenStartAddr+5232	; offset 14943
	push hl	; offset 14946
	push de	; offset 14947
	push bc	; offset 14948
	exx    	; offset 14949
	push hl	; offset 14950
	push de	; offset 14951
	push bc	; offset 14952
	; Clock offset: 0

	; attr draw 17
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+544
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+544),hl
	ld hl,10280
	ld (attrStartAddr+2+544),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+544
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+544),hl
	; src_data filler blit 544
	ld bc,52428	; offset 15408
	ld de,52428	; offset 15411
	exx    	; offset 15414
	ld bc,52428	; offset 15415
	ld de,52428	; offset 15418
	ld sp,screenStartAddr+5916	; offset 15421
	push de	; offset 15424
	push bc	; offset 15425
	exx    	; offset 15426
	push de	; offset 15427
	push bc	; offset 15428
	nop
	; end attr draw 17
	; Clock offset: -1008

	; src_data blit 413
	ld bc,52428	; offset 15430
	ld de,52428	; offset 15433
	ld hl,52428	; offset 15436
	exx    	; offset 15439
	ld bc,52428	; offset 15440
	ld de,52428	; offset 15443
	ld hl,52428	; offset 15446
	ld sp,screenStartAddr+5244	; offset 15449
	push hl	; offset 15452
	push de	; offset 15453
	push bc	; offset 15454
	exx    	; offset 15455
	push hl	; offset 15456
	push de	; offset 15457
	push bc	; offset 15458
	; Clock offset: -864

	; src_data blit 414
	ld bc,52428	; offset 15459
	ld de,52428	; offset 15462
	ld hl,52428	; offset 15465
	exx    	; offset 15468
	ld bc,52428	; offset 15469
	ld de,52428	; offset 15472
	ld hl,52428	; offset 15475
	ld sp,screenStartAddr+5256	; offset 15478
	push hl	; offset 15481
	push de	; offset 15482
	push bc	; offset 15483
	exx    	; offset 15484
	push hl	; offset 15485
	push de	; offset 15486
	push bc	; offset 15487
	; Clock offset: -720

	; src_data blit 415
	ld bc,52428	; offset 15488
	ld de,52428	; offset 15491
	ld hl,52428	; offset 15494
	exx    	; offset 15497
	ld bc,52428	; offset 15498
	ld de,52428	; offset 15501
	ld hl,52428	; offset 15504
	ld sp,screenStartAddr+5484	; offset 15507
	push hl	; offset 15510
	push de	; offset 15511
	push bc	; offset 15512
	exx    	; offset 15513
	push hl	; offset 15514
	push de	; offset 15515
	push bc	; offset 15516
	; Clock offset: -576

	; src_data blit 416
	ld bc,52428	; offset 15517
	ld de,52428	; offset 15520
	ld hl,52428	; offset 15523
	exx    	; offset 15526
	ld bc,52428	; offset 15527
	ld de,52428	; offset 15530
	ld hl,52428	; offset 15533
	ld sp,screenStartAddr+5496	; offset 15536
	push hl	; offset 15539
	push de	; offset 15540
	push bc	; offset 15541
	exx    	; offset 15542
	push hl	; offset 15543
	push de	; offset 15544
	push bc	; offset 15545
	; Clock offset: -432

	; src_data blit 417
	ld bc,52428	; offset 15546
	ld de,52428	; offset 15549
	ld hl,52428	; offset 15552
	exx    	; offset 15555
	ld bc,52428	; offset 15556
	ld de,52428	; offset 15559
	ld hl,52428	; offset 15562
	ld sp,screenStartAddr+5508	; offset 15565
	push hl	; offset 15568
	push de	; offset 15569
	push bc	; offset 15570
	exx    	; offset 15571
	push hl	; offset 15572
	push de	; offset 15573
	push bc	; offset 15574
	; Clock offset: -288

	; src_data blit 418
	ld bc,52428	; offset 15575
	ld de,52428	; offset 15578
	ld hl,52428	; offset 15581
	exx    	; offset 15584
	ld bc,52428	; offset 15585
	ld de,52428	; offset 15588
	ld hl,52428	; offset 15591
	ld sp,screenStartAddr+5748	; offset 15594
	push hl	; offset 15597
	push de	; offset 15598
	push bc	; offset 15599
	exx    	; offset 15600
	push hl	; offset 15601
	push de	; offset 15602
	push bc	; offset 15603
	; Clock offset: -144

	; src_data blit 419
	ld bc,52428	; offset 15604
	ld de,52428	; offset 15607
	ld hl,52428	; offset 15610
	exx    	; offset 15613
	ld bc,52428	; offset 15614
	ld de,52428	; offset 15617
	ld hl,52428	; offset 15620
	ld sp,screenStartAddr+5760	; offset 15623
	push hl	; offset 15626
	push de	; offset 15627
	push bc	; offset 15628
	exx    	; offset 15629
	push hl	; offset 15630
	push de	; offset 15631
	push bc	; offset 15632
	; Clock offset: 0

	; attr draw 18
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+576
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+576),hl
	ld hl,10280
	ld (attrStartAddr+2+576),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+576
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+576),hl
	; src_data filler blit 576
	ld bc,52428	; offset 16088
	ld de,52428	; offset 16091
	exx    	; offset 16094
	ld bc,52428	; offset 16095
	ld de,52428	; offset 16098
	ld sp,screenStartAddr+5924	; offset 16101
	push de	; offset 16104
	push bc	; offset 16105
	exx    	; offset 16106
	push de	; offset 16107
	push bc	; offset 16108
	nop
	; end attr draw 18
	; Clock offset: -1008

	; src_data blit 420
	ld bc,52428	; offset 16110
	ld de,52428	; offset 16113
	ld hl,52428	; offset 16116
	exx    	; offset 16119
	ld bc,52428	; offset 16120
	ld de,52428	; offset 16123
	ld hl,52428	; offset 16126
	ld sp,screenStartAddr+4236	; offset 16129
	push hl	; offset 16132
	push de	; offset 16133
	push bc	; offset 16134
	exx    	; offset 16135
	push hl	; offset 16136
	push de	; offset 16137
	push bc	; offset 16138
	; Clock offset: -864

	; src_data blit 421
	ld bc,52428	; offset 16139
	ld de,52428	; offset 16142
	ld hl,52428	; offset 16145
	exx    	; offset 16148
	ld bc,52428	; offset 16149
	ld de,52428	; offset 16152
	ld hl,52428	; offset 16155
	ld sp,screenStartAddr+4248	; offset 16158
	push hl	; offset 16161
	push de	; offset 16162
	push bc	; offset 16163
	exx    	; offset 16164
	push hl	; offset 16165
	push de	; offset 16166
	push bc	; offset 16167
	; Clock offset: -720

	; src_data blit 422
	ld bc,52428	; offset 16168
	ld de,52428	; offset 16171
	ld hl,52428	; offset 16174
	exx    	; offset 16177
	ld bc,52428	; offset 16178
	ld de,52428	; offset 16181
	ld hl,52428	; offset 16184
	ld sp,screenStartAddr+4260	; offset 16187
	push hl	; offset 16190
	push de	; offset 16191
	push bc	; offset 16192
	exx    	; offset 16193
	push hl	; offset 16194
	push de	; offset 16195
	push bc	; offset 16196
	; Clock offset: -576

	; src_data blit 423
	ld bc,52428	; offset 16197
	ld de,52428	; offset 16200
	ld hl,52428	; offset 16203
	exx    	; offset 16206
	ld bc,52428	; offset 16207
	ld de,52428	; offset 16210
	ld hl,52428	; offset 16213
	ld sp,screenStartAddr+4500	; offset 16216
	push hl	; offset 16219
	push de	; offset 16220
	push bc	; offset 16221
	exx    	; offset 16222
	push hl	; offset 16223
	push de	; offset 16224
	push bc	; offset 16225
	; Clock offset: -432

	; src_data blit 424
	ld bc,52428	; offset 16226
	ld de,52428	; offset 16229
	ld hl,52428	; offset 16232
	exx    	; offset 16235
	ld bc,52428	; offset 16236
	ld de,52428	; offset 16239
	ld hl,52428	; offset 16242
	ld sp,screenStartAddr+4512	; offset 16245
	push hl	; offset 16248
	push de	; offset 16249
	push bc	; offset 16250
	exx    	; offset 16251
	push hl	; offset 16252
	push de	; offset 16253
	push bc	; offset 16254
	; Clock offset: -288

	; src_data blit 425
	ld bc,52428	; offset 16255
	ld de,52428	; offset 16258
	ld hl,52428	; offset 16261
	exx    	; offset 16264
	ld bc,52428	; offset 16265
	ld de,52428	; offset 16268
	ld hl,52428	; offset 16271
	ld sp,screenStartAddr+4752	; offset 16274
	push hl	; offset 16277
	push de	; offset 16278
	push bc	; offset 16279
	exx    	; offset 16280
	push hl	; offset 16281
	push de	; offset 16282
	push bc	; offset 16283
	; Clock offset: -144

	; src_data blit 426
	ld bc,52428	; offset 16284
	ld de,52428	; offset 16287
	ld hl,52428	; offset 16290
	exx    	; offset 16293
	ld bc,52428	; offset 16294
	ld de,52428	; offset 16297
	ld hl,52428	; offset 16300
	ld sp,screenStartAddr+4764	; offset 16303
	push hl	; offset 16306
	push de	; offset 16307
	push bc	; offset 16308
	exx    	; offset 16309
	push hl	; offset 16310
	push de	; offset 16311
	push bc	; offset 16312
	; Clock offset: 0

	; attr draw 19
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+608
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+608),hl
	ld hl,10280
	ld (attrStartAddr+2+608),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+608
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+608),hl
	; src_data filler blit 608
	ld bc,52428	; offset 16768
	ld de,52428	; offset 16771
	exx    	; offset 16774
	ld bc,52428	; offset 16775
	ld de,52428	; offset 16778
	ld sp,screenStartAddr+5932	; offset 16781
	push de	; offset 16784
	push bc	; offset 16785
	exx    	; offset 16786
	push de	; offset 16787
	push bc	; offset 16788
	nop
	; end attr draw 19
	; Clock offset: -1008

	; src_data blit 427
	ld bc,52428	; offset 16790
	ld de,52428	; offset 16793
	ld hl,52428	; offset 16796
	exx    	; offset 16799
	ld bc,52428	; offset 16800
	ld de,52428	; offset 16803
	ld hl,52428	; offset 16806
	ld sp,screenStartAddr+4776	; offset 16809
	push hl	; offset 16812
	push de	; offset 16813
	push bc	; offset 16814
	exx    	; offset 16815
	push hl	; offset 16816
	push de	; offset 16817
	push bc	; offset 16818
	; Clock offset: -864

	; src_data blit 428
	ld bc,52428	; offset 16819
	ld de,52428	; offset 16822
	ld hl,52428	; offset 16825
	exx    	; offset 16828
	ld bc,52428	; offset 16829
	ld de,52428	; offset 16832
	ld hl,52428	; offset 16835
	ld sp,screenStartAddr+5004	; offset 16838
	push hl	; offset 16841
	push de	; offset 16842
	push bc	; offset 16843
	exx    	; offset 16844
	push hl	; offset 16845
	push de	; offset 16846
	push bc	; offset 16847
	; Clock offset: -720

	; src_data blit 429
	ld bc,52428	; offset 16848
	ld de,52428	; offset 16851
	ld hl,52428	; offset 16854
	exx    	; offset 16857
	ld bc,52428	; offset 16858
	ld de,52428	; offset 16861
	ld hl,52428	; offset 16864
	ld sp,screenStartAddr+5016	; offset 16867
	push hl	; offset 16870
	push de	; offset 16871
	push bc	; offset 16872
	exx    	; offset 16873
	push hl	; offset 16874
	push de	; offset 16875
	push bc	; offset 16876
	; Clock offset: -576

	; src_data blit 430
	ld bc,52428	; offset 16877
	ld de,52428	; offset 16880
	ld hl,52428	; offset 16883
	exx    	; offset 16886
	ld bc,52428	; offset 16887
	ld de,52428	; offset 16890
	ld hl,52428	; offset 16893
	ld sp,screenStartAddr+5028	; offset 16896
	push hl	; offset 16899
	push de	; offset 16900
	push bc	; offset 16901
	exx    	; offset 16902
	push hl	; offset 16903
	push de	; offset 16904
	push bc	; offset 16905
	; Clock offset: -432

	; src_data blit 431
	ld bc,52428	; offset 16906
	ld de,52428	; offset 16909
	ld hl,52428	; offset 16912
	exx    	; offset 16915
	ld bc,52428	; offset 16916
	ld de,52428	; offset 16919
	ld hl,52428	; offset 16922
	ld sp,screenStartAddr+5268	; offset 16925
	push hl	; offset 16928
	push de	; offset 16929
	push bc	; offset 16930
	exx    	; offset 16931
	push hl	; offset 16932
	push de	; offset 16933
	push bc	; offset 16934
	; Clock offset: -288

	; src_data blit 432
	ld bc,52428	; offset 16935
	ld de,52428	; offset 16938
	ld hl,52428	; offset 16941
	exx    	; offset 16944
	ld bc,52428	; offset 16945
	ld de,52428	; offset 16948
	ld hl,52428	; offset 16951
	ld sp,screenStartAddr+5280	; offset 16954
	push hl	; offset 16957
	push de	; offset 16958
	push bc	; offset 16959
	exx    	; offset 16960
	push hl	; offset 16961
	push de	; offset 16962
	push bc	; offset 16963
	; Clock offset: -144

	; src_data blit 433
	ld bc,52428	; offset 16964
	ld de,52428	; offset 16967
	ld hl,52428	; offset 16970
	exx    	; offset 16973
	ld bc,52428	; offset 16974
	ld de,52428	; offset 16977
	ld hl,52428	; offset 16980
	ld sp,screenStartAddr+5520	; offset 16983
	push hl	; offset 16986
	push de	; offset 16987
	push bc	; offset 16988
	exx    	; offset 16989
	push hl	; offset 16990
	push de	; offset 16991
	push bc	; offset 16992
	; Clock offset: 0

	; attr draw 20
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+640
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+640),hl
	ld hl,10280
	ld (attrStartAddr+2+640),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+640
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+640),hl
	; src_data filler blit 640
	ld bc,52428	; offset 17448
	ld de,52428	; offset 17451
	exx    	; offset 17454
	ld bc,52428	; offset 17455
	ld de,52428	; offset 17458
	ld sp,screenStartAddr+5940	; offset 17461
	push de	; offset 17464
	push bc	; offset 17465
	exx    	; offset 17466
	push de	; offset 17467
	push bc	; offset 17468
	nop
	; end attr draw 20
	; Clock offset: -1008

	; src_data blit 434
	ld bc,52428	; offset 17470
	ld de,52428	; offset 17473
	ld hl,52428	; offset 17476
	exx    	; offset 17479
	ld bc,52428	; offset 17480
	ld de,52428	; offset 17483
	ld hl,52428	; offset 17486
	ld sp,screenStartAddr+5532	; offset 17489
	push hl	; offset 17492
	push de	; offset 17493
	push bc	; offset 17494
	exx    	; offset 17495
	push hl	; offset 17496
	push de	; offset 17497
	push bc	; offset 17498
	; Clock offset: -864

	; src_data blit 435
	ld bc,52428	; offset 17499
	ld de,52428	; offset 17502
	ld hl,52428	; offset 17505
	exx    	; offset 17508
	ld bc,52428	; offset 17509
	ld de,52428	; offset 17512
	ld hl,52428	; offset 17515
	ld sp,screenStartAddr+5544	; offset 17518
	push hl	; offset 17521
	push de	; offset 17522
	push bc	; offset 17523
	exx    	; offset 17524
	push hl	; offset 17525
	push de	; offset 17526
	push bc	; offset 17527
	; Clock offset: -720

	; src_data blit 436
	ld bc,52428	; offset 17528
	ld de,52428	; offset 17531
	ld hl,52428	; offset 17534
	exx    	; offset 17537
	ld bc,52428	; offset 17538
	ld de,52428	; offset 17541
	ld hl,52428	; offset 17544
	ld sp,screenStartAddr+5772	; offset 17547
	push hl	; offset 17550
	push de	; offset 17551
	push bc	; offset 17552
	exx    	; offset 17553
	push hl	; offset 17554
	push de	; offset 17555
	push bc	; offset 17556
	; Clock offset: -576

	; src_data blit 437
	ld bc,52428	; offset 17557
	ld de,52428	; offset 17560
	ld hl,52428	; offset 17563
	exx    	; offset 17566
	ld bc,52428	; offset 17567
	ld de,52428	; offset 17570
	ld hl,52428	; offset 17573
	ld sp,screenStartAddr+5784	; offset 17576
	push hl	; offset 17579
	push de	; offset 17580
	push bc	; offset 17581
	exx    	; offset 17582
	push hl	; offset 17583
	push de	; offset 17584
	push bc	; offset 17585
	; Clock offset: -432

	; src_data blit 438
	ld bc,52428	; offset 17586
	ld de,52428	; offset 17589
	ld hl,52428	; offset 17592
	exx    	; offset 17595
	ld bc,52428	; offset 17596
	ld de,52428	; offset 17599
	ld hl,52428	; offset 17602
	ld sp,screenStartAddr+4272	; offset 17605
	push hl	; offset 17608
	push de	; offset 17609
	push bc	; offset 17610
	exx    	; offset 17611
	push hl	; offset 17612
	push de	; offset 17613
	push bc	; offset 17614
	; Clock offset: -288

	; src_data blit 439
	ld bc,52428	; offset 17615
	ld de,52428	; offset 17618
	ld hl,52428	; offset 17621
	exx    	; offset 17624
	ld bc,52428	; offset 17625
	ld de,52428	; offset 17628
	ld hl,52428	; offset 17631
	ld sp,screenStartAddr+4284	; offset 17634
	push hl	; offset 17637
	push de	; offset 17638
	push bc	; offset 17639
	exx    	; offset 17640
	push hl	; offset 17641
	push de	; offset 17642
	push bc	; offset 17643
	; Clock offset: -144

	; src_data blit 440
	ld bc,52428	; offset 17644
	ld de,52428	; offset 17647
	ld hl,52428	; offset 17650
	exx    	; offset 17653
	ld bc,52428	; offset 17654
	ld de,52428	; offset 17657
	ld hl,52428	; offset 17660
	ld sp,screenStartAddr+4296	; offset 17663
	push hl	; offset 17666
	push de	; offset 17667
	push bc	; offset 17668
	exx    	; offset 17669
	push hl	; offset 17670
	push de	; offset 17671
	push bc	; offset 17672
	; Clock offset: 0

	; attr draw 21
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+672
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+672),hl
	ld hl,10280
	ld (attrStartAddr+2+672),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+672
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+672),hl
	; src_data filler blit 672
	ld bc,52428	; offset 18128
	ld de,52428	; offset 18131
	exx    	; offset 18134
	ld bc,52428	; offset 18135
	ld de,52428	; offset 18138
	ld sp,screenStartAddr+5948	; offset 18141
	push de	; offset 18144
	push bc	; offset 18145
	exx    	; offset 18146
	push de	; offset 18147
	push bc	; offset 18148
	nop
	; end attr draw 21
	; Clock offset: -1008

	; src_data blit 441
	ld bc,52428	; offset 18150
	ld de,52428	; offset 18153
	ld hl,52428	; offset 18156
	exx    	; offset 18159
	ld bc,52428	; offset 18160
	ld de,52428	; offset 18163
	ld hl,52428	; offset 18166
	ld sp,screenStartAddr+4524	; offset 18169
	push hl	; offset 18172
	push de	; offset 18173
	push bc	; offset 18174
	exx    	; offset 18175
	push hl	; offset 18176
	push de	; offset 18177
	push bc	; offset 18178
	; Clock offset: -864

	; src_data blit 442
	ld bc,52428	; offset 18179
	ld de,52428	; offset 18182
	ld hl,52428	; offset 18185
	exx    	; offset 18188
	ld bc,52428	; offset 18189
	ld de,52428	; offset 18192
	ld hl,52428	; offset 18195
	ld sp,screenStartAddr+4536	; offset 18198
	push hl	; offset 18201
	push de	; offset 18202
	push bc	; offset 18203
	exx    	; offset 18204
	push hl	; offset 18205
	push de	; offset 18206
	push bc	; offset 18207
	; Clock offset: -720

	; src_data blit 443
	ld bc,52428	; offset 18208
	ld de,52428	; offset 18211
	ld hl,52428	; offset 18214
	exx    	; offset 18217
	ld bc,52428	; offset 18218
	ld de,52428	; offset 18221
	ld hl,52428	; offset 18224
	ld sp,screenStartAddr+4548	; offset 18227
	push hl	; offset 18230
	push de	; offset 18231
	push bc	; offset 18232
	exx    	; offset 18233
	push hl	; offset 18234
	push de	; offset 18235
	push bc	; offset 18236
	; Clock offset: -576

	; src_data blit 444
	ld bc,52428	; offset 18237
	ld de,52428	; offset 18240
	ld hl,52428	; offset 18243
	exx    	; offset 18246
	ld bc,52428	; offset 18247
	ld de,52428	; offset 18250
	ld hl,52428	; offset 18253
	ld sp,screenStartAddr+4788	; offset 18256
	push hl	; offset 18259
	push de	; offset 18260
	push bc	; offset 18261
	exx    	; offset 18262
	push hl	; offset 18263
	push de	; offset 18264
	push bc	; offset 18265
	; Clock offset: -432

	; src_data blit 445
	ld bc,52428	; offset 18266
	ld de,52428	; offset 18269
	ld hl,52428	; offset 18272
	exx    	; offset 18275
	ld bc,52428	; offset 18276
	ld de,52428	; offset 18279
	ld hl,52428	; offset 18282
	ld sp,screenStartAddr+4800	; offset 18285
	push hl	; offset 18288
	push de	; offset 18289
	push bc	; offset 18290
	exx    	; offset 18291
	push hl	; offset 18292
	push de	; offset 18293
	push bc	; offset 18294
	; Clock offset: -288

	; src_data blit 446
	ld bc,52428	; offset 18295
	ld de,52428	; offset 18298
	ld hl,52428	; offset 18301
	exx    	; offset 18304
	ld bc,52428	; offset 18305
	ld de,52428	; offset 18308
	ld hl,52428	; offset 18311
	ld sp,screenStartAddr+5040	; offset 18314
	push hl	; offset 18317
	push de	; offset 18318
	push bc	; offset 18319
	exx    	; offset 18320
	push hl	; offset 18321
	push de	; offset 18322
	push bc	; offset 18323
	; Clock offset: -144

	; src_data blit 447
	ld bc,52428	; offset 18324
	ld de,52428	; offset 18327
	ld hl,52428	; offset 18330
	exx    	; offset 18333
	ld bc,52428	; offset 18334
	ld de,52428	; offset 18337
	ld hl,52428	; offset 18340
	ld sp,screenStartAddr+5052	; offset 18343
	push hl	; offset 18346
	push de	; offset 18347
	push bc	; offset 18348
	exx    	; offset 18349
	push hl	; offset 18350
	push de	; offset 18351
	push bc	; offset 18352
	; Clock offset: 0

	; attr draw 22
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+704
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+704),hl
	ld hl,10280
	ld (attrStartAddr+2+704),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+704
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+704),hl
	; src_data filler blit 704
	ld bc,52428	; offset 18808
	ld de,52428	; offset 18811
	exx    	; offset 18814
	ld bc,52428	; offset 18815
	ld de,52428	; offset 18818
	ld sp,screenStartAddr+5956	; offset 18821
	push de	; offset 18824
	push bc	; offset 18825
	exx    	; offset 18826
	push de	; offset 18827
	push bc	; offset 18828
	nop
	; end attr draw 22
	; Clock offset: -1008

	; src_data blit 448
	ld bc,52428	; offset 18830
	ld de,52428	; offset 18833
	ld hl,52428	; offset 18836
	exx    	; offset 18839
	ld bc,52428	; offset 18840
	ld de,52428	; offset 18843
	ld hl,52428	; offset 18846
	ld sp,screenStartAddr+5064	; offset 18849
	push hl	; offset 18852
	push de	; offset 18853
	push bc	; offset 18854
	exx    	; offset 18855
	push hl	; offset 18856
	push de	; offset 18857
	push bc	; offset 18858
	; Clock offset: -864

	; src_data blit 449
	ld bc,52428	; offset 18859
	ld de,52428	; offset 18862
	ld hl,52428	; offset 18865
	exx    	; offset 18868
	ld bc,52428	; offset 18869
	ld de,52428	; offset 18872
	ld hl,52428	; offset 18875
	ld sp,screenStartAddr+5292	; offset 18878
	push hl	; offset 18881
	push de	; offset 18882
	push bc	; offset 18883
	exx    	; offset 18884
	push hl	; offset 18885
	push de	; offset 18886
	push bc	; offset 18887
	; Clock offset: -720

	; src_data blit 450
	ld bc,52428	; offset 18888
	ld de,52428	; offset 18891
	ld hl,52428	; offset 18894
	exx    	; offset 18897
	ld bc,52428	; offset 18898
	ld de,52428	; offset 18901
	ld hl,52428	; offset 18904
	ld sp,screenStartAddr+5304	; offset 18907
	push hl	; offset 18910
	push de	; offset 18911
	push bc	; offset 18912
	exx    	; offset 18913
	push hl	; offset 18914
	push de	; offset 18915
	push bc	; offset 18916
	; Clock offset: -576

	; src_data blit 451
	ld bc,52428	; offset 18917
	ld de,52428	; offset 18920
	ld hl,52428	; offset 18923
	exx    	; offset 18926
	ld bc,52428	; offset 18927
	ld de,52428	; offset 18930
	ld hl,52428	; offset 18933
	ld sp,screenStartAddr+5316	; offset 18936
	push hl	; offset 18939
	push de	; offset 18940
	push bc	; offset 18941
	exx    	; offset 18942
	push hl	; offset 18943
	push de	; offset 18944
	push bc	; offset 18945
	; Clock offset: -432

	; src_data blit 452
	ld bc,52428	; offset 18946
	ld de,52428	; offset 18949
	ld hl,52428	; offset 18952
	exx    	; offset 18955
	ld bc,52428	; offset 18956
	ld de,52428	; offset 18959
	ld hl,52428	; offset 18962
	ld sp,screenStartAddr+5556	; offset 18965
	push hl	; offset 18968
	push de	; offset 18969
	push bc	; offset 18970
	exx    	; offset 18971
	push hl	; offset 18972
	push de	; offset 18973
	push bc	; offset 18974
	; Clock offset: -288

	; src_data blit 453
	ld bc,52428	; offset 18975
	ld de,52428	; offset 18978
	ld hl,52428	; offset 18981
	exx    	; offset 18984
	ld bc,52428	; offset 18985
	ld de,52428	; offset 18988
	ld hl,52428	; offset 18991
	ld sp,screenStartAddr+5568	; offset 18994
	push hl	; offset 18997
	push de	; offset 18998
	push bc	; offset 18999
	exx    	; offset 19000
	push hl	; offset 19001
	push de	; offset 19002
	push bc	; offset 19003
	; Clock offset: -144

	; src_data blit 454
	ld bc,52428	; offset 19004
	ld de,52428	; offset 19007
	ld hl,52428	; offset 19010
	exx    	; offset 19013
	ld bc,52428	; offset 19014
	ld de,52428	; offset 19017
	ld hl,52428	; offset 19020
	ld sp,screenStartAddr+4308	; offset 19023
	push hl	; offset 19026
	push de	; offset 19027
	push bc	; offset 19028
	exx    	; offset 19029
	push hl	; offset 19030
	push de	; offset 19031
	push bc	; offset 19032
	; Clock offset: 0

	; attr draw 23
	ld sp,0x8020
	ld bc,10280
	push bc
	ld bc,10280
	push bc
	pop af
	ex af,af'
	pop af
	ld sp,attrStartAddr+16+736
	ld de,10280
	ld hl,10280
	ld ix,10280
	ld iy,10280
	exx
	ld bc,10280
	ld de,10280
	ld hl,10280

	; start chasing raster here

	ld (attrStartAddr+736),hl
	ld hl,10280
	ld (attrStartAddr+2+736),hl
	ld hl,10280
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
	ld bc,10280
	ld de,10280
	ld hl,10280
	ld sp,attrStartAddr+30+736
	push hl
	push de
	push bc
	ld hl,10280
	ld (attrStartAddr+30+736),hl
	; end attr draw 23
	; src_data blit 455
	ld bc,52428	; offset 19488
	ld de,52428	; offset 19491
	ld hl,52428	; offset 19494
	exx    	; offset 19497
	ld bc,52428	; offset 19498
	ld de,52428	; offset 19501
	ld hl,52428	; offset 19504
	ld sp,screenStartAddr+4320	; offset 19507
	push hl	; offset 19510
	push de	; offset 19511
	push bc	; offset 19512
	exx    	; offset 19513
	push hl	; offset 19514
	push de	; offset 19515
	push bc	; offset 19516

	; src_data blit 456
	ld bc,52428	; offset 19517
	ld de,52428	; offset 19520
	ld hl,52428	; offset 19523
	exx    	; offset 19526
	ld bc,52428	; offset 19527
	ld de,52428	; offset 19530
	ld hl,52428	; offset 19533
	ld sp,screenStartAddr+4560	; offset 19536
	push hl	; offset 19539
	push de	; offset 19540
	push bc	; offset 19541
	exx    	; offset 19542
	push hl	; offset 19543
	push de	; offset 19544
	push bc	; offset 19545

	; src_data blit 457
	ld bc,52428	; offset 19546
	ld de,52428	; offset 19549
	ld hl,52428	; offset 19552
	exx    	; offset 19555
	ld bc,52428	; offset 19556
	ld de,52428	; offset 19559
	ld hl,52428	; offset 19562
	ld sp,screenStartAddr+4572	; offset 19565
	push hl	; offset 19568
	push de	; offset 19569
	push bc	; offset 19570
	exx    	; offset 19571
	push hl	; offset 19572
	push de	; offset 19573
	push bc	; offset 19574

	; src_data blit 458
	ld bc,52428	; offset 19575
	ld de,52428	; offset 19578
	ld hl,52428	; offset 19581
	exx    	; offset 19584
	ld bc,52428	; offset 19585
	ld de,52428	; offset 19588
	ld hl,52428	; offset 19591
	ld sp,screenStartAddr+4584	; offset 19594
	push hl	; offset 19597
	push de	; offset 19598
	push bc	; offset 19599
	exx    	; offset 19600
	push hl	; offset 19601
	push de	; offset 19602
	push bc	; offset 19603

	; src_data blit 459
	ld bc,52428	; offset 19604
	ld de,52428	; offset 19607
	ld hl,52428	; offset 19610
	exx    	; offset 19613
	ld bc,52428	; offset 19614
	ld de,52428	; offset 19617
	ld hl,52428	; offset 19620
	ld sp,screenStartAddr+4812	; offset 19623
	push hl	; offset 19626
	push de	; offset 19627
	push bc	; offset 19628
	exx    	; offset 19629
	push hl	; offset 19630
	push de	; offset 19631
	push bc	; offset 19632

	; src_data blit 460
	ld bc,52428	; offset 19633
	ld de,52428	; offset 19636
	ld hl,52428	; offset 19639
	exx    	; offset 19642
	ld bc,52428	; offset 19643
	ld de,52428	; offset 19646
	ld hl,52428	; offset 19649
	ld sp,screenStartAddr+4824	; offset 19652
	push hl	; offset 19655
	push de	; offset 19656
	push bc	; offset 19657
	exx    	; offset 19658
	push hl	; offset 19659
	push de	; offset 19660
	push bc	; offset 19661

	; src_data blit 461
	ld bc,52428	; offset 19662
	ld de,52428	; offset 19665
	ld hl,52428	; offset 19668
	exx    	; offset 19671
	ld bc,52428	; offset 19672
	ld de,52428	; offset 19675
	ld hl,52428	; offset 19678
	ld sp,screenStartAddr+4836	; offset 19681
	push hl	; offset 19684
	push de	; offset 19685
	push bc	; offset 19686
	exx    	; offset 19687
	push hl	; offset 19688
	push de	; offset 19689
	push bc	; offset 19690

	; src_data blit 462
	ld bc,52428	; offset 19691
	ld de,52428	; offset 19694
	ld hl,52428	; offset 19697
	exx    	; offset 19700
	ld bc,52428	; offset 19701
	ld de,52428	; offset 19704
	ld hl,52428	; offset 19707
	ld sp,screenStartAddr+5076	; offset 19710
	push hl	; offset 19713
	push de	; offset 19714
	push bc	; offset 19715
	exx    	; offset 19716
	push hl	; offset 19717
	push de	; offset 19718
	push bc	; offset 19719

	; src_data blit 463
	ld bc,52428	; offset 19720
	ld de,52428	; offset 19723
	ld hl,52428	; offset 19726
	exx    	; offset 19729
	ld bc,52428	; offset 19730
	ld de,52428	; offset 19733
	ld hl,52428	; offset 19736
	ld sp,screenStartAddr+5088	; offset 19739
	push hl	; offset 19742
	push de	; offset 19743
	push bc	; offset 19744
	exx    	; offset 19745
	push hl	; offset 19746
	push de	; offset 19747
	push bc	; offset 19748

	; src_data blit 464
	ld bc,52428	; offset 19749
	ld de,52428	; offset 19752
	ld hl,52428	; offset 19755
	exx    	; offset 19758
	ld bc,52428	; offset 19759
	ld de,52428	; offset 19762
	ld hl,52428	; offset 19765
	ld sp,screenStartAddr+5328	; offset 19768
	push hl	; offset 19771
	push de	; offset 19772
	push bc	; offset 19773
	exx    	; offset 19774
	push hl	; offset 19775
	push de	; offset 19776
	push bc	; offset 19777

	; src_data blit 465
	ld bc,52428	; offset 19778
	ld de,52428	; offset 19781
	ld hl,52428	; offset 19784
	exx    	; offset 19787
	ld bc,52428	; offset 19788
	ld de,52428	; offset 19791
	ld hl,52428	; offset 19794
	ld sp,screenStartAddr+5340	; offset 19797
	push hl	; offset 19800
	push de	; offset 19801
	push bc	; offset 19802
	exx    	; offset 19803
	push hl	; offset 19804
	push de	; offset 19805
	push bc	; offset 19806

	; src_data blit 466
	ld bc,52428	; offset 19807
	ld de,52428	; offset 19810
	ld hl,52428	; offset 19813
	exx    	; offset 19816
	ld bc,52428	; offset 19817
	ld de,52428	; offset 19820
	ld hl,52428	; offset 19823
	ld sp,screenStartAddr+5352	; offset 19826
	push hl	; offset 19829
	push de	; offset 19830
	push bc	; offset 19831
	exx    	; offset 19832
	push hl	; offset 19833
	push de	; offset 19834
	push bc	; offset 19835

	; src_data blit 467
	ld bc,52428	; offset 19836
	ld de,52428	; offset 19839
	ld hl,52428	; offset 19842
	exx    	; offset 19845
	ld bc,52428	; offset 19846
	ld de,52428	; offset 19849
	ld hl,52428	; offset 19852
	ld sp,screenStartAddr+5580	; offset 19855
	push hl	; offset 19858
	push de	; offset 19859
	push bc	; offset 19860
	exx    	; offset 19861
	push hl	; offset 19862
	push de	; offset 19863
	push bc	; offset 19864

	; src_data blit 468
	ld bc,52428	; offset 19865
	ld de,52428	; offset 19868
	ld hl,52428	; offset 19871
	exx    	; offset 19874
	ld bc,52428	; offset 19875
	ld de,52428	; offset 19878
	ld hl,52428	; offset 19881
	ld sp,screenStartAddr+5592	; offset 19884
	push hl	; offset 19887
	push de	; offset 19888
	push bc	; offset 19889
	exx    	; offset 19890
	push hl	; offset 19891
	push de	; offset 19892
	push bc	; offset 19893

	; src_data blit 469
	ld bc,52428	; offset 19894
	ld de,52428	; offset 19897
	ld hl,52428	; offset 19900
	exx    	; offset 19903
	ld bc,52428	; offset 19904
	ld de,52428	; offset 19907
	ld hl,52428	; offset 19910
	ld sp,screenStartAddr+5604	; offset 19913
	push hl	; offset 19916
	push de	; offset 19917
	push bc	; offset 19918
	exx    	; offset 19919
	push hl	; offset 19920
	push de	; offset 19921
	push bc	; offset 19922

	; src_data blit 470
	ld bc,52428	; offset 19923
	ld de,52428	; offset 19926
	ld hl,52428	; offset 19929
	exx    	; offset 19932
	ld bc,52428	; offset 19933
	ld de,52428	; offset 19936
	ld hl,52428	; offset 19939
	ld sp,screenStartAddr+4332	; offset 19942
	push hl	; offset 19945
	push de	; offset 19946
	push bc	; offset 19947
	exx    	; offset 19948
	push hl	; offset 19949
	push de	; offset 19950
	push bc	; offset 19951

	; src_data blit 471
	ld bc,52428	; offset 19952
	ld de,52428	; offset 19955
	ld hl,52428	; offset 19958
	exx    	; offset 19961
	ld bc,52428	; offset 19962
	ld de,52428	; offset 19965
	ld hl,52428	; offset 19968
	ld sp,screenStartAddr+4344	; offset 19971
	push hl	; offset 19974
	push de	; offset 19975
	push bc	; offset 19976
	exx    	; offset 19977
	push hl	; offset 19978
	push de	; offset 19979
	push bc	; offset 19980

	; src_data blit 472
	ld bc,52428	; offset 19981
	ld de,52428	; offset 19984
	ld hl,52428	; offset 19987
	exx    	; offset 19990
	ld bc,52428	; offset 19991
	ld de,52428	; offset 19994
	ld hl,52428	; offset 19997
	ld sp,screenStartAddr+4596	; offset 20000
	push hl	; offset 20003
	push de	; offset 20004
	push bc	; offset 20005
	exx    	; offset 20006
	push hl	; offset 20007
	push de	; offset 20008
	push bc	; offset 20009

	; src_data blit 473
	ld bc,52428	; offset 20010
	ld de,52428	; offset 20013
	ld hl,52428	; offset 20016
	exx    	; offset 20019
	ld bc,52428	; offset 20020
	ld de,52428	; offset 20023
	ld hl,52428	; offset 20026
	ld sp,screenStartAddr+4608	; offset 20029
	push hl	; offset 20032
	push de	; offset 20033
	push bc	; offset 20034
	exx    	; offset 20035
	push hl	; offset 20036
	push de	; offset 20037
	push bc	; offset 20038

	; src_data blit 474
	ld bc,52428	; offset 20039
	ld de,52428	; offset 20042
	ld hl,52428	; offset 20045
	exx    	; offset 20048
	ld bc,52428	; offset 20049
	ld de,52428	; offset 20052
	ld hl,52428	; offset 20055
	ld sp,screenStartAddr+4848	; offset 20058
	push hl	; offset 20061
	push de	; offset 20062
	push bc	; offset 20063
	exx    	; offset 20064
	push hl	; offset 20065
	push de	; offset 20066
	push bc	; offset 20067

	; src_data blit 475
	ld bc,52428	; offset 20068
	ld de,52428	; offset 20071
	ld hl,52428	; offset 20074
	exx    	; offset 20077
	ld bc,52428	; offset 20078
	ld de,52428	; offset 20081
	ld hl,52428	; offset 20084
	ld sp,screenStartAddr+4860	; offset 20087
	push hl	; offset 20090
	push de	; offset 20091
	push bc	; offset 20092
	exx    	; offset 20093
	push hl	; offset 20094
	push de	; offset 20095
	push bc	; offset 20096

	; src_data blit 476
	ld bc,52428	; offset 20097
	ld de,52428	; offset 20100
	ld hl,52428	; offset 20103
	exx    	; offset 20106
	ld bc,52428	; offset 20107
	ld de,52428	; offset 20110
	ld hl,52428	; offset 20113
	ld sp,screenStartAddr+5100	; offset 20116
	push hl	; offset 20119
	push de	; offset 20120
	push bc	; offset 20121
	exx    	; offset 20122
	push hl	; offset 20123
	push de	; offset 20124
	push bc	; offset 20125

	; src_data blit 477
	ld bc,52428	; offset 20126
	ld de,52428	; offset 20129
	ld hl,52428	; offset 20132
	exx    	; offset 20135
	ld bc,52428	; offset 20136
	ld de,52428	; offset 20139
	ld hl,52428	; offset 20142
	ld sp,screenStartAddr+5112	; offset 20145
	push hl	; offset 20148
	push de	; offset 20149
	push bc	; offset 20150
	exx    	; offset 20151
	push hl	; offset 20152
	push de	; offset 20153
	push bc	; offset 20154

	; src_data blit 478
	ld bc,52428	; offset 20155
	ld de,52428	; offset 20158
	ld hl,52428	; offset 20161
	exx    	; offset 20164
	ld bc,52428	; offset 20165
	ld de,52428	; offset 20168
	ld hl,52428	; offset 20171
	ld sp,screenStartAddr+5364	; offset 20174
	push hl	; offset 20177
	push de	; offset 20178
	push bc	; offset 20179
	exx    	; offset 20180
	push hl	; offset 20181
	push de	; offset 20182
	push bc	; offset 20183

	; src_data blit 479
	ld bc,52428	; offset 20184
	ld de,52428	; offset 20187
	ld hl,52428	; offset 20190
	exx    	; offset 20193
	ld bc,52428	; offset 20194
	ld de,52428	; offset 20197
	ld hl,52428	; offset 20200
	ld sp,screenStartAddr+5376	; offset 20203
	push hl	; offset 20206
	push de	; offset 20207
	push bc	; offset 20208
	exx    	; offset 20209
	push hl	; offset 20210
	push de	; offset 20211
	push bc	; offset 20212

	; src_data blit 480
	ld bc,52428	; offset 20213
	ld de,52428	; offset 20216
	ld hl,52428	; offset 20219
	exx    	; offset 20222
	ld bc,52428	; offset 20223
	ld de,52428	; offset 20226
	ld hl,52428	; offset 20229
	ld sp,screenStartAddr+5616	; offset 20232
	push hl	; offset 20235
	push de	; offset 20236
	push bc	; offset 20237
	exx    	; offset 20238
	push hl	; offset 20239
	push de	; offset 20240
	push bc	; offset 20241

	; src_data blit 481
	ld bc,52428	; offset 20242
	ld de,52428	; offset 20245
	ld hl,52428	; offset 20248
	exx    	; offset 20251
	ld bc,52428	; offset 20252
	ld de,52428	; offset 20255
	ld hl,52428	; offset 20258
	ld sp,screenStartAddr+5628	; offset 20261
	push hl	; offset 20264
	push de	; offset 20265
	push bc	; offset 20266
	exx    	; offset 20267
	push hl	; offset 20268
	push de	; offset 20269
	push bc	; offset 20270

	ld sp,(spBackupAddr)
	ret

	SAVEBIN "sp48.rom",0,$
