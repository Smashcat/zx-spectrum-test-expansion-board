	; List of index 8 and 16 dwords for each attr row, for faster loading into AF pair at offset 0x0064
attr8and16vals:
	dw 30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840,30840

pop_push_even:	;offset 0x00c4
	; Block attribute blit start
	ld sp,attrStartAddr+768	; Set sp to end of attr memory - code offset 0x00c7

	ld hl,30840	; src offset 766, code offset 0x00ca
	push hl		; code offset 0x00cb
	ld hl,30840	; src offset 764, code offset 0x00ce
	push hl		; code offset 0x00cf
	ld hl,30840	; src offset 762, code offset 0x00d2
	push hl		; code offset 0x00d3
	ld hl,30840	; src offset 760, code offset 0x00d6
	push hl		; code offset 0x00d7
	ld hl,30840	; src offset 758, code offset 0x00da
	push hl		; code offset 0x00db
	ld hl,30840	; src offset 756, code offset 0x00de
	push hl		; code offset 0x00df
	ld hl,30840	; src offset 754, code offset 0x00e2
	push hl		; code offset 0x00e3
	ld hl,30840	; src offset 752, code offset 0x00e6
	push hl		; code offset 0x00e7
	ld hl,30840	; src offset 750, code offset 0x00ea
	push hl		; code offset 0x00eb
	ld hl,30840	; src offset 748, code offset 0x00ee
	push hl		; code offset 0x00ef
	ld hl,30840	; src offset 746, code offset 0x00f2
	push hl		; code offset 0x00f3
	ld hl,30840	; src offset 744, code offset 0x00f6
	push hl		; code offset 0x00f7
	ld hl,30840	; src offset 742, code offset 0x00fa
	push hl		; code offset 0x00fb
	ld hl,30840	; src offset 740, code offset 0x00fe
	push hl		; code offset 0x00ff
	ld hl,30840	; src offset 738, code offset 0x0102
	push hl		; code offset 0x0103
	ld hl,30840	; src offset 736, code offset 0x0106
	push hl		; code offset 0x0107
	ld hl,30840	; src offset 734, code offset 0x010a
	push hl		; code offset 0x010b
	ld hl,30840	; src offset 732, code offset 0x010e
	push hl		; code offset 0x010f
	ld hl,30840	; src offset 730, code offset 0x0112
	push hl		; code offset 0x0113
	ld hl,30840	; src offset 728, code offset 0x0116
	push hl		; code offset 0x0117
	ld hl,30840	; src offset 726, code offset 0x011a
	push hl		; code offset 0x011b
	ld hl,30840	; src offset 724, code offset 0x011e
	push hl		; code offset 0x011f
	ld hl,30840	; src offset 722, code offset 0x0122
	push hl		; code offset 0x0123
	ld hl,30840	; src offset 720, code offset 0x0126
	push hl		; code offset 0x0127
	ld hl,30840	; src offset 718, code offset 0x012a
	push hl		; code offset 0x012b
	ld hl,30840	; src offset 716, code offset 0x012e
	push hl		; code offset 0x012f
	ld hl,30840	; src offset 714, code offset 0x0132
	push hl		; code offset 0x0133
	ld hl,30840	; src offset 712, code offset 0x0136
	push hl		; code offset 0x0137
	ld hl,30840	; src offset 710, code offset 0x013a
	push hl		; code offset 0x013b
	ld hl,30840	; src offset 708, code offset 0x013e
	push hl		; code offset 0x013f
	ld hl,30840	; src offset 706, code offset 0x0142
	push hl		; code offset 0x0143
	ld hl,30840	; src offset 704, code offset 0x0146
	push hl		; code offset 0x0147
	ld hl,30840	; src offset 702, code offset 0x014a
	push hl		; code offset 0x014b
	ld hl,30840	; src offset 700, code offset 0x014e
	push hl		; code offset 0x014f
	ld hl,30840	; src offset 698, code offset 0x0152
	push hl		; code offset 0x0153
	ld hl,30840	; src offset 696, code offset 0x0156
	push hl		; code offset 0x0157
	ld hl,30840	; src offset 694, code offset 0x015a
	push hl		; code offset 0x015b
	ld hl,30840	; src offset 692, code offset 0x015e
	push hl		; code offset 0x015f
	ld hl,30840	; src offset 690, code offset 0x0162
	push hl		; code offset 0x0163
	ld hl,30840	; src offset 688, code offset 0x0166
	push hl		; code offset 0x0167
	ld hl,30840	; src offset 686, code offset 0x016a
	push hl		; code offset 0x016b
	ld hl,30840	; src offset 684, code offset 0x016e
	push hl		; code offset 0x016f
	ld hl,30840	; src offset 682, code offset 0x0172
	push hl		; code offset 0x0173
	ld hl,30840	; src offset 680, code offset 0x0176
	push hl		; code offset 0x0177
	ld hl,30840	; src offset 678, code offset 0x017a
	push hl		; code offset 0x017b
	ld hl,30840	; src offset 676, code offset 0x017e
	push hl		; code offset 0x017f
	ld hl,30840	; src offset 674, code offset 0x0182
	push hl		; code offset 0x0183
	ld hl,30840	; src offset 672, code offset 0x0186
	push hl		; code offset 0x0187
	ld hl,30840	; src offset 670, code offset 0x018a
	push hl		; code offset 0x018b
	ld hl,30840	; src offset 668, code offset 0x018e
	push hl		; code offset 0x018f
	ld hl,30840	; src offset 666, code offset 0x0192
	push hl		; code offset 0x0193
	ld hl,30840	; src offset 664, code offset 0x0196
	push hl		; code offset 0x0197
	ld hl,30840	; src offset 662, code offset 0x019a
	push hl		; code offset 0x019b
	ld hl,30840	; src offset 660, code offset 0x019e
	push hl		; code offset 0x019f
	ld hl,30840	; src offset 658, code offset 0x01a2
	push hl		; code offset 0x01a3
	ld hl,30840	; src offset 656, code offset 0x01a6
	push hl		; code offset 0x01a7
	ld hl,30840	; src offset 654, code offset 0x01aa
	push hl		; code offset 0x01ab
	ld hl,30840	; src offset 652, code offset 0x01ae
	push hl		; code offset 0x01af
	ld hl,30840	; src offset 650, code offset 0x01b2
	push hl		; code offset 0x01b3
	ld hl,30840	; src offset 648, code offset 0x01b6
	push hl		; code offset 0x01b7
	ld hl,30840	; src offset 646, code offset 0x01ba
	push hl		; code offset 0x01bb
	ld hl,30840	; src offset 644, code offset 0x01be
	push hl		; code offset 0x01bf
	ld hl,30840	; src offset 642, code offset 0x01c2
	push hl		; code offset 0x01c3
	ld hl,30840	; src offset 640, code offset 0x01c6
	push hl		; code offset 0x01c7
	ld hl,30840	; src offset 638, code offset 0x01ca
	push hl		; code offset 0x01cb
	ld hl,30840	; src offset 636, code offset 0x01ce
	push hl		; code offset 0x01cf
	ld hl,30840	; src offset 634, code offset 0x01d2
	push hl		; code offset 0x01d3
	ld hl,30840	; src offset 632, code offset 0x01d6
	push hl		; code offset 0x01d7
	ld hl,30840	; src offset 630, code offset 0x01da
	push hl		; code offset 0x01db
	ld hl,30840	; src offset 628, code offset 0x01de
	push hl		; code offset 0x01df
	ld hl,30840	; src offset 626, code offset 0x01e2
	push hl		; code offset 0x01e3
	ld hl,30840	; src offset 624, code offset 0x01e6
	push hl		; code offset 0x01e7
	ld hl,30840	; src offset 622, code offset 0x01ea
	push hl		; code offset 0x01eb
	ld hl,30840	; src offset 620, code offset 0x01ee
	push hl		; code offset 0x01ef
	ld hl,30840	; src offset 618, code offset 0x01f2
	push hl		; code offset 0x01f3
	ld hl,30840	; src offset 616, code offset 0x01f6
	push hl		; code offset 0x01f7
	ld hl,30840	; src offset 614, code offset 0x01fa
	push hl		; code offset 0x01fb
	ld hl,30840	; src offset 612, code offset 0x01fe
	push hl		; code offset 0x01ff
	ld hl,30840	; src offset 610, code offset 0x0202
	push hl		; code offset 0x0203
	ld hl,30840	; src offset 608, code offset 0x0206
	push hl		; code offset 0x0207
	ld hl,30840	; src offset 606, code offset 0x020a
	push hl		; code offset 0x020b
	ld hl,30840	; src offset 604, code offset 0x020e
	push hl		; code offset 0x020f
	ld hl,30840	; src offset 602, code offset 0x0212
	push hl		; code offset 0x0213
	ld hl,30840	; src offset 600, code offset 0x0216
	push hl		; code offset 0x0217
	ld hl,30840	; src offset 598, code offset 0x021a
	push hl		; code offset 0x021b
	ld hl,30840	; src offset 596, code offset 0x021e
	push hl		; code offset 0x021f
	ld hl,30840	; src offset 594, code offset 0x0222
	push hl		; code offset 0x0223
	ld hl,30840	; src offset 592, code offset 0x0226
	push hl		; code offset 0x0227
	ld hl,30840	; src offset 590, code offset 0x022a
	push hl		; code offset 0x022b
	ld hl,30840	; src offset 588, code offset 0x022e
	push hl		; code offset 0x022f
	ld hl,30840	; src offset 586, code offset 0x0232
	push hl		; code offset 0x0233
	ld hl,30840	; src offset 584, code offset 0x0236
	push hl		; code offset 0x0237
	ld hl,30840	; src offset 582, code offset 0x023a
	push hl		; code offset 0x023b
	ld hl,30840	; src offset 580, code offset 0x023e
	push hl		; code offset 0x023f
	ld hl,30840	; src offset 578, code offset 0x0242
	push hl		; code offset 0x0243
	ld hl,30840	; src offset 576, code offset 0x0246
	push hl		; code offset 0x0247
	ld hl,30840	; src offset 574, code offset 0x024a
	push hl		; code offset 0x024b
	ld hl,30840	; src offset 572, code offset 0x024e
	push hl		; code offset 0x024f
	ld hl,30840	; src offset 570, code offset 0x0252
	push hl		; code offset 0x0253
	ld hl,30840	; src offset 568, code offset 0x0256
	push hl		; code offset 0x0257
	ld hl,30840	; src offset 566, code offset 0x025a
	push hl		; code offset 0x025b
	ld hl,30840	; src offset 564, code offset 0x025e
	push hl		; code offset 0x025f
	ld hl,30840	; src offset 562, code offset 0x0262
	push hl		; code offset 0x0263
	ld hl,30840	; src offset 560, code offset 0x0266
	push hl		; code offset 0x0267
	ld hl,30840	; src offset 558, code offset 0x026a
	push hl		; code offset 0x026b
	ld hl,30840	; src offset 556, code offset 0x026e
	push hl		; code offset 0x026f
	ld hl,30840	; src offset 554, code offset 0x0272
	push hl		; code offset 0x0273
	ld hl,30840	; src offset 552, code offset 0x0276
	push hl		; code offset 0x0277
	ld hl,30840	; src offset 550, code offset 0x027a
	push hl		; code offset 0x027b
	ld hl,30840	; src offset 548, code offset 0x027e
	push hl		; code offset 0x027f
	ld hl,30840	; src offset 546, code offset 0x0282
	push hl		; code offset 0x0283
	ld hl,30840	; src offset 544, code offset 0x0286
	push hl		; code offset 0x0287
	ld hl,30840	; src offset 542, code offset 0x028a
	push hl		; code offset 0x028b
	ld hl,30840	; src offset 540, code offset 0x028e
	push hl		; code offset 0x028f
	ld hl,30840	; src offset 538, code offset 0x0292
	push hl		; code offset 0x0293
	ld hl,30840	; src offset 536, code offset 0x0296
	push hl		; code offset 0x0297
	ld hl,30840	; src offset 534, code offset 0x029a
	push hl		; code offset 0x029b
	ld hl,30840	; src offset 532, code offset 0x029e
	push hl		; code offset 0x029f
	ld hl,30840	; src offset 530, code offset 0x02a2
	push hl		; code offset 0x02a3
	ld hl,30840	; src offset 528, code offset 0x02a6
	push hl		; code offset 0x02a7
	ld hl,30840	; src offset 526, code offset 0x02aa
	push hl		; code offset 0x02ab
	ld hl,30840	; src offset 524, code offset 0x02ae
	push hl		; code offset 0x02af
	ld hl,30840	; src offset 522, code offset 0x02b2
	push hl		; code offset 0x02b3
	ld hl,30840	; src offset 520, code offset 0x02b6
	push hl		; code offset 0x02b7
	ld hl,30840	; src offset 518, code offset 0x02ba
	push hl		; code offset 0x02bb
	ld hl,30840	; src offset 516, code offset 0x02be
	push hl		; code offset 0x02bf
	ld hl,30840	; src offset 514, code offset 0x02c2
	push hl		; code offset 0x02c3
	ld hl,30840	; src offset 512, code offset 0x02c6
	push hl		; code offset 0x02c7
	ld hl,30840	; src offset 510, code offset 0x02ca
	push hl		; code offset 0x02cb
	ld hl,30840	; src offset 508, code offset 0x02ce
	push hl		; code offset 0x02cf
	ld hl,30840	; src offset 506, code offset 0x02d2
	push hl		; code offset 0x02d3
	ld hl,30840	; src offset 504, code offset 0x02d6
	push hl		; code offset 0x02d7
	ld hl,30840	; src offset 502, code offset 0x02da
	push hl		; code offset 0x02db
	ld hl,30840	; src offset 500, code offset 0x02de
	push hl		; code offset 0x02df
	ld hl,30840	; src offset 498, code offset 0x02e2
	push hl		; code offset 0x02e3
	ld hl,30840	; src offset 496, code offset 0x02e6
	push hl		; code offset 0x02e7
	ld hl,30840	; src offset 494, code offset 0x02ea
	push hl		; code offset 0x02eb
	ld hl,30840	; src offset 492, code offset 0x02ee
	push hl		; code offset 0x02ef
	ld hl,30840	; src offset 490, code offset 0x02f2
	push hl		; code offset 0x02f3
	ld hl,30840	; src offset 488, code offset 0x02f6
	push hl		; code offset 0x02f7
	ld hl,30840	; src offset 486, code offset 0x02fa
	push hl		; code offset 0x02fb
	ld hl,30840	; src offset 484, code offset 0x02fe
	push hl		; code offset 0x02ff
	ld hl,30840	; src offset 482, code offset 0x0302
	push hl		; code offset 0x0303
	ld hl,30840	; src offset 480, code offset 0x0306
	push hl		; code offset 0x0307
	ld hl,30840	; src offset 478, code offset 0x030a
	push hl		; code offset 0x030b
	ld hl,30840	; src offset 476, code offset 0x030e
	push hl		; code offset 0x030f
	ld hl,30840	; src offset 474, code offset 0x0312
	push hl		; code offset 0x0313
	ld hl,30840	; src offset 472, code offset 0x0316
	push hl		; code offset 0x0317
	ld hl,30840	; src offset 470, code offset 0x031a
	push hl		; code offset 0x031b
	ld hl,30840	; src offset 468, code offset 0x031e
	push hl		; code offset 0x031f
	ld hl,30840	; src offset 466, code offset 0x0322
	push hl		; code offset 0x0323
	ld hl,30840	; src offset 464, code offset 0x0326
	push hl		; code offset 0x0327
	ld hl,30840	; src offset 462, code offset 0x032a
	push hl		; code offset 0x032b
	ld hl,30840	; src offset 460, code offset 0x032e
	push hl		; code offset 0x032f
	ld hl,30840	; src offset 458, code offset 0x0332
	push hl		; code offset 0x0333
	ld hl,30840	; src offset 456, code offset 0x0336
	push hl		; code offset 0x0337
	ld hl,30840	; src offset 454, code offset 0x033a
	push hl		; code offset 0x033b
	ld hl,30840	; src offset 452, code offset 0x033e
	push hl		; code offset 0x033f
	ld hl,30840	; src offset 450, code offset 0x0342
	push hl		; code offset 0x0343
	ld hl,30840	; src offset 448, code offset 0x0346
	push hl		; code offset 0x0347
	ld hl,30840	; src offset 446, code offset 0x034a
	push hl		; code offset 0x034b
	ld hl,30840	; src offset 444, code offset 0x034e
	push hl		; code offset 0x034f
	ld hl,30840	; src offset 442, code offset 0x0352
	push hl		; code offset 0x0353
	ld hl,30840	; src offset 440, code offset 0x0356
	push hl		; code offset 0x0357
	ld hl,30840	; src offset 438, code offset 0x035a
	push hl		; code offset 0x035b
	ld hl,30840	; src offset 436, code offset 0x035e
	push hl		; code offset 0x035f
	ld hl,30840	; src offset 434, code offset 0x0362
	push hl		; code offset 0x0363
	ld hl,30840	; src offset 432, code offset 0x0366
	push hl		; code offset 0x0367
	ld hl,30840	; src offset 430, code offset 0x036a
	push hl		; code offset 0x036b
	ld hl,30840	; src offset 428, code offset 0x036e
	push hl		; code offset 0x036f
	ld hl,30840	; src offset 426, code offset 0x0372
	push hl		; code offset 0x0373
	ld hl,30840	; src offset 424, code offset 0x0376
	push hl		; code offset 0x0377
	ld hl,30840	; src offset 422, code offset 0x037a
	push hl		; code offset 0x037b
	ld hl,30840	; src offset 420, code offset 0x037e
	push hl		; code offset 0x037f
	ld hl,30840	; src offset 418, code offset 0x0382
	push hl		; code offset 0x0383
	ld hl,30840	; src offset 416, code offset 0x0386
	push hl		; code offset 0x0387
	ld hl,30840	; src offset 414, code offset 0x038a
	push hl		; code offset 0x038b
	ld hl,30840	; src offset 412, code offset 0x038e
	push hl		; code offset 0x038f
	ld hl,30840	; src offset 410, code offset 0x0392
	push hl		; code offset 0x0393
	ld hl,30840	; src offset 408, code offset 0x0396
	push hl		; code offset 0x0397
	ld hl,30840	; src offset 406, code offset 0x039a
	push hl		; code offset 0x039b
	ld hl,30840	; src offset 404, code offset 0x039e
	push hl		; code offset 0x039f
	ld hl,30840	; src offset 402, code offset 0x03a2
	push hl		; code offset 0x03a3
	ld hl,30840	; src offset 400, code offset 0x03a6
	push hl		; code offset 0x03a7
	ld hl,30840	; src offset 398, code offset 0x03aa
	push hl		; code offset 0x03ab
	ld hl,30840	; src offset 396, code offset 0x03ae
	push hl		; code offset 0x03af
	ld hl,30840	; src offset 394, code offset 0x03b2
	push hl		; code offset 0x03b3
	ld hl,30840	; src offset 392, code offset 0x03b6
	push hl		; code offset 0x03b7
	ld hl,30840	; src offset 390, code offset 0x03ba
	push hl		; code offset 0x03bb
	ld hl,30840	; src offset 388, code offset 0x03be
	push hl		; code offset 0x03bf
	ld hl,30840	; src offset 386, code offset 0x03c2
	push hl		; code offset 0x03c3
	ld hl,30840	; src offset 384, code offset 0x03c6
	push hl		; code offset 0x03c7
	ld hl,30840	; src offset 382, code offset 0x03ca
	push hl		; code offset 0x03cb
	ld hl,30840	; src offset 380, code offset 0x03ce
	push hl		; code offset 0x03cf
	ld hl,30840	; src offset 378, code offset 0x03d2
	push hl		; code offset 0x03d3
	ld hl,30840	; src offset 376, code offset 0x03d6
	push hl		; code offset 0x03d7
	ld hl,30840	; src offset 374, code offset 0x03da
	push hl		; code offset 0x03db
	ld hl,30840	; src offset 372, code offset 0x03de
	push hl		; code offset 0x03df
	ld hl,30840	; src offset 370, code offset 0x03e2
	push hl		; code offset 0x03e3
	ld hl,30840	; src offset 368, code offset 0x03e6
	push hl		; code offset 0x03e7
	ld hl,30840	; src offset 366, code offset 0x03ea
	push hl		; code offset 0x03eb
	ld hl,30840	; src offset 364, code offset 0x03ee
	push hl		; code offset 0x03ef
	ld hl,30840	; src offset 362, code offset 0x03f2
	push hl		; code offset 0x03f3
	ld hl,30840	; src offset 360, code offset 0x03f6
	push hl		; code offset 0x03f7
	ld hl,30840	; src offset 358, code offset 0x03fa
	push hl		; code offset 0x03fb
	ld hl,30840	; src offset 356, code offset 0x03fe
	push hl		; code offset 0x03ff
	ld hl,30840	; src offset 354, code offset 0x0402
	push hl		; code offset 0x0403
	ld hl,30840	; src offset 352, code offset 0x0406
	push hl		; code offset 0x0407
	ld hl,30840	; src offset 350, code offset 0x040a
	push hl		; code offset 0x040b
	ld hl,30840	; src offset 348, code offset 0x040e
	push hl		; code offset 0x040f
	ld hl,30840	; src offset 346, code offset 0x0412
	push hl		; code offset 0x0413
	ld hl,30840	; src offset 344, code offset 0x0416
	push hl		; code offset 0x0417
	ld hl,30840	; src offset 342, code offset 0x041a
	push hl		; code offset 0x041b
	ld hl,30840	; src offset 340, code offset 0x041e
	push hl		; code offset 0x041f
	ld hl,30840	; src offset 338, code offset 0x0422
	push hl		; code offset 0x0423
	ld hl,30840	; src offset 336, code offset 0x0426
	push hl		; code offset 0x0427
	ld hl,30840	; src offset 334, code offset 0x042a
	push hl		; code offset 0x042b
	ld hl,30840	; src offset 332, code offset 0x042e
	push hl		; code offset 0x042f
	ld hl,30840	; src offset 330, code offset 0x0432
	push hl		; code offset 0x0433
	ld hl,30840	; src offset 328, code offset 0x0436
	push hl		; code offset 0x0437
	ld hl,30840	; src offset 326, code offset 0x043a
	push hl		; code offset 0x043b
	ld hl,30840	; src offset 324, code offset 0x043e
	push hl		; code offset 0x043f
	ld hl,30840	; src offset 322, code offset 0x0442
	push hl		; code offset 0x0443
	ld hl,30840	; src offset 320, code offset 0x0446
	push hl		; code offset 0x0447
	ld hl,30840	; src offset 318, code offset 0x044a
	push hl		; code offset 0x044b
	ld hl,30840	; src offset 316, code offset 0x044e
	push hl		; code offset 0x044f
	ld hl,30840	; src offset 314, code offset 0x0452
	push hl		; code offset 0x0453
	ld hl,30840	; src offset 312, code offset 0x0456
	push hl		; code offset 0x0457
	ld hl,30840	; src offset 310, code offset 0x045a
	push hl		; code offset 0x045b
	ld hl,30840	; src offset 308, code offset 0x045e
	push hl		; code offset 0x045f
	ld hl,30840	; src offset 306, code offset 0x0462
	push hl		; code offset 0x0463
	ld hl,30840	; src offset 304, code offset 0x0466
	push hl		; code offset 0x0467
	ld hl,30840	; src offset 302, code offset 0x046a
	push hl		; code offset 0x046b
	ld hl,30840	; src offset 300, code offset 0x046e
	push hl		; code offset 0x046f
	ld hl,30840	; src offset 298, code offset 0x0472
	push hl		; code offset 0x0473
	ld hl,30840	; src offset 296, code offset 0x0476
	push hl		; code offset 0x0477
	ld hl,30840	; src offset 294, code offset 0x047a
	push hl		; code offset 0x047b
	ld hl,30840	; src offset 292, code offset 0x047e
	push hl		; code offset 0x047f
	ld hl,30840	; src offset 290, code offset 0x0482
	push hl		; code offset 0x0483
	ld hl,30840	; src offset 288, code offset 0x0486
	push hl		; code offset 0x0487
	ld hl,30840	; src offset 286, code offset 0x048a
	push hl		; code offset 0x048b
	ld hl,30840	; src offset 284, code offset 0x048e
	push hl		; code offset 0x048f
	ld hl,30840	; src offset 282, code offset 0x0492
	push hl		; code offset 0x0493
	ld hl,30840	; src offset 280, code offset 0x0496
	push hl		; code offset 0x0497
	ld hl,30840	; src offset 278, code offset 0x049a
	push hl		; code offset 0x049b
	ld hl,30840	; src offset 276, code offset 0x049e
	push hl		; code offset 0x049f
	ld hl,30840	; src offset 274, code offset 0x04a2
	push hl		; code offset 0x04a3
	ld hl,30840	; src offset 272, code offset 0x04a6
	push hl		; code offset 0x04a7
	ld hl,30840	; src offset 270, code offset 0x04aa
	push hl		; code offset 0x04ab
	ld hl,30840	; src offset 268, code offset 0x04ae
	push hl		; code offset 0x04af
	ld hl,30840	; src offset 266, code offset 0x04b2
	push hl		; code offset 0x04b3
	ld hl,30840	; src offset 264, code offset 0x04b6
	push hl		; code offset 0x04b7
	ld hl,30840	; src offset 262, code offset 0x04ba
	push hl		; code offset 0x04bb
	ld hl,30840	; src offset 260, code offset 0x04be
	push hl		; code offset 0x04bf
	ld hl,30840	; src offset 258, code offset 0x04c2
	push hl		; code offset 0x04c3
	ld hl,30840	; src offset 256, code offset 0x04c6
	push hl		; code offset 0x04c7
	ld hl,30840	; src offset 254, code offset 0x04ca
	push hl		; code offset 0x04cb
	ld hl,30840	; src offset 252, code offset 0x04ce
	push hl		; code offset 0x04cf
	ld hl,30840	; src offset 250, code offset 0x04d2
	push hl		; code offset 0x04d3
	ld hl,30840	; src offset 248, code offset 0x04d6
	push hl		; code offset 0x04d7
	ld hl,30840	; src offset 246, code offset 0x04da
	push hl		; code offset 0x04db
	ld hl,30840	; src offset 244, code offset 0x04de
	push hl		; code offset 0x04df
	ld hl,30840	; src offset 242, code offset 0x04e2
	push hl		; code offset 0x04e3
	ld hl,30840	; src offset 240, code offset 0x04e6
	push hl		; code offset 0x04e7
	ld hl,30840	; src offset 238, code offset 0x04ea
	push hl		; code offset 0x04eb
	ld hl,30840	; src offset 236, code offset 0x04ee
	push hl		; code offset 0x04ef
	ld hl,30840	; src offset 234, code offset 0x04f2
	push hl		; code offset 0x04f3
	ld hl,30840	; src offset 232, code offset 0x04f6
	push hl		; code offset 0x04f7
	ld hl,30840	; src offset 230, code offset 0x04fa
	push hl		; code offset 0x04fb
	ld hl,30840	; src offset 228, code offset 0x04fe
	push hl		; code offset 0x04ff
	ld hl,30840	; src offset 226, code offset 0x0502
	push hl		; code offset 0x0503
	ld hl,30840	; src offset 224, code offset 0x0506
	push hl		; code offset 0x0507
	ld hl,18504	; src offset 222, code offset 0x050a
	push hl		; code offset 0x050b
	ld hl,30840	; src offset 220, code offset 0x050e
	push hl		; code offset 0x050f
	ld hl,30840	; src offset 218, code offset 0x0512
	push hl		; code offset 0x0513
	ld hl,30840	; src offset 216, code offset 0x0516
	push hl		; code offset 0x0517
	ld hl,30840	; src offset 214, code offset 0x051a
	push hl		; code offset 0x051b
	ld hl,30840	; src offset 212, code offset 0x051e
	push hl		; code offset 0x051f
	ld hl,30840	; src offset 210, code offset 0x0522
	push hl		; code offset 0x0523
	ld hl,30840	; src offset 208, code offset 0x0526
	push hl		; code offset 0x0527
	ld hl,30840	; src offset 206, code offset 0x052a
	push hl		; code offset 0x052b
	ld hl,30840	; src offset 204, code offset 0x052e
	push hl		; code offset 0x052f
	ld hl,30840	; src offset 202, code offset 0x0532
	push hl		; code offset 0x0533
	ld hl,30840	; src offset 200, code offset 0x0536
	push hl		; code offset 0x0537
	ld hl,30840	; src offset 198, code offset 0x053a
	push hl		; code offset 0x053b
	ld hl,30840	; src offset 196, code offset 0x053e
	push hl		; code offset 0x053f
	ld hl,30840	; src offset 194, code offset 0x0542
	push hl		; code offset 0x0543
	ld hl,30840	; src offset 192, code offset 0x0546
	push hl		; code offset 0x0547
	ld hl,25169	; src offset 190, code offset 0x054a
	push hl		; code offset 0x054b
	ld hl,18552	; src offset 188, code offset 0x054e
	push hl		; code offset 0x054f
	ld hl,30840	; src offset 186, code offset 0x0552
	push hl		; code offset 0x0553
	ld hl,30840	; src offset 184, code offset 0x0556
	push hl		; code offset 0x0557
	ld hl,30840	; src offset 182, code offset 0x055a
	push hl		; code offset 0x055b
	ld hl,30840	; src offset 180, code offset 0x055e
	push hl		; code offset 0x055f
	ld hl,30840	; src offset 178, code offset 0x0562
	push hl		; code offset 0x0563
	ld hl,30840	; src offset 176, code offset 0x0566
	push hl		; code offset 0x0567
	ld hl,30840	; src offset 174, code offset 0x056a
	push hl		; code offset 0x056b
	ld hl,30840	; src offset 172, code offset 0x056e
	push hl		; code offset 0x056f
	ld hl,30840	; src offset 170, code offset 0x0572
	push hl		; code offset 0x0573
	ld hl,30840	; src offset 168, code offset 0x0576
	push hl		; code offset 0x0577
	ld hl,30840	; src offset 166, code offset 0x057a
	push hl		; code offset 0x057b
	ld hl,30840	; src offset 164, code offset 0x057e
	push hl		; code offset 0x057f
	ld hl,30840	; src offset 162, code offset 0x0582
	push hl		; code offset 0x0583
	ld hl,30840	; src offset 160, code offset 0x0586
	push hl		; code offset 0x0587
	ld hl,30060	; src offset 158, code offset 0x058a
	push hl		; code offset 0x058b
	ld hl,25169	; src offset 156, code offset 0x058e
	push hl		; code offset 0x058f
	ld hl,18552	; src offset 154, code offset 0x0592
	push hl		; code offset 0x0593
	ld hl,30840	; src offset 152, code offset 0x0596
	push hl		; code offset 0x0597
	ld hl,30840	; src offset 150, code offset 0x059a
	push hl		; code offset 0x059b
	ld hl,30840	; src offset 148, code offset 0x059e
	push hl		; code offset 0x059f
	ld hl,30840	; src offset 146, code offset 0x05a2
	push hl		; code offset 0x05a3
	ld hl,30840	; src offset 144, code offset 0x05a6
	push hl		; code offset 0x05a7
	ld hl,30840	; src offset 142, code offset 0x05aa
	push hl		; code offset 0x05ab
	ld hl,30840	; src offset 140, code offset 0x05ae
	push hl		; code offset 0x05af
	ld hl,30840	; src offset 138, code offset 0x05b2
	push hl		; code offset 0x05b3
	ld hl,30840	; src offset 136, code offset 0x05b6
	push hl		; code offset 0x05b7
	ld hl,30840	; src offset 134, code offset 0x05ba
	push hl		; code offset 0x05bb
	ld hl,30840	; src offset 132, code offset 0x05be
	push hl		; code offset 0x05bf
	ld hl,30840	; src offset 130, code offset 0x05c2
	push hl		; code offset 0x05c3
	ld hl,30840	; src offset 128, code offset 0x05c6
	push hl		; code offset 0x05c7
	ld hl,30590	; src offset 126, code offset 0x05ca
	push hl		; code offset 0x05cb
	ld hl,30060	; src offset 124, code offset 0x05ce
	push hl		; code offset 0x05cf
	ld hl,25169	; src offset 122, code offset 0x05d2
	push hl		; code offset 0x05d3
	ld hl,18552	; src offset 120, code offset 0x05d6
	push hl		; code offset 0x05d7
	ld hl,30840	; src offset 118, code offset 0x05da
	push hl		; code offset 0x05db
	ld hl,30840	; src offset 116, code offset 0x05de
	push hl		; code offset 0x05df
	ld hl,30840	; src offset 114, code offset 0x05e2
	push hl		; code offset 0x05e3
	ld hl,30840	; src offset 112, code offset 0x05e6
	push hl		; code offset 0x05e7
	ld hl,30840	; src offset 110, code offset 0x05ea
	push hl		; code offset 0x05eb
	ld hl,30840	; src offset 108, code offset 0x05ee
	push hl		; code offset 0x05ef
	ld hl,30840	; src offset 106, code offset 0x05f2
	push hl		; code offset 0x05f3
	ld hl,30840	; src offset 104, code offset 0x05f6
	push hl		; code offset 0x05f7
	ld hl,30840	; src offset 102, code offset 0x05fa
	push hl		; code offset 0x05fb
	ld hl,30840	; src offset 100, code offset 0x05fe
	push hl		; code offset 0x05ff
	ld hl,30840	; src offset 98, code offset 0x0602
	push hl		; code offset 0x0603
	ld hl,30840	; src offset 96, code offset 0x0606
	push hl		; code offset 0x0607
	ld hl,25966	; src offset 94, code offset 0x060a
	push hl		; code offset 0x060b
	ld hl,30590	; src offset 92, code offset 0x060e
	push hl		; code offset 0x060f
	ld hl,30060	; src offset 90, code offset 0x0612
	push hl		; code offset 0x0613
	ld hl,25169	; src offset 88, code offset 0x0616
	push hl		; code offset 0x0617
	ld hl,18552	; src offset 86, code offset 0x061a
	push hl		; code offset 0x061b
	ld hl,30840	; src offset 84, code offset 0x061e
	push hl		; code offset 0x061f
	ld hl,30840	; src offset 82, code offset 0x0622
	push hl		; code offset 0x0623
	ld hl,30840	; src offset 80, code offset 0x0626
	push hl		; code offset 0x0627
	ld hl,30840	; src offset 78, code offset 0x062a
	push hl		; code offset 0x062b
	ld hl,30840	; src offset 76, code offset 0x062e
	push hl		; code offset 0x062f
	ld hl,30840	; src offset 74, code offset 0x0632
	push hl		; code offset 0x0633
	ld hl,30840	; src offset 72, code offset 0x0636
	push hl		; code offset 0x0637
	ld hl,30840	; src offset 70, code offset 0x063a
	push hl		; code offset 0x063b
	ld hl,30840	; src offset 68, code offset 0x063e
	push hl		; code offset 0x063f
	ld hl,30840	; src offset 66, code offset 0x0642
	push hl		; code offset 0x0643
	ld hl,30840	; src offset 64, code offset 0x0646
	push hl		; code offset 0x0647
	ld hl,19028	; src offset 62, code offset 0x064a
	push hl		; code offset 0x064b
	ld hl,25966	; src offset 60, code offset 0x064e
	push hl		; code offset 0x064f
	ld hl,30590	; src offset 58, code offset 0x0652
	push hl		; code offset 0x0653
	ld hl,30060	; src offset 56, code offset 0x0656
	push hl		; code offset 0x0657
	ld hl,25168	; src offset 54, code offset 0x065a
	push hl		; code offset 0x065b
	ld hl,18552	; src offset 52, code offset 0x065e
	push hl		; code offset 0x065f
	ld hl,30840	; src offset 50, code offset 0x0662
	push hl		; code offset 0x0663
	ld hl,30840	; src offset 48, code offset 0x0666
	push hl		; code offset 0x0667
	ld hl,30840	; src offset 46, code offset 0x066a
	push hl		; code offset 0x066b
	ld hl,30840	; src offset 44, code offset 0x066e
	push hl		; code offset 0x066f
	ld hl,30840	; src offset 42, code offset 0x0672
	push hl		; code offset 0x0673
	ld hl,30840	; src offset 40, code offset 0x0676
	push hl		; code offset 0x0677
	ld hl,30840	; src offset 38, code offset 0x067a
	push hl		; code offset 0x067b
	ld hl,30840	; src offset 36, code offset 0x067e
	push hl		; code offset 0x067f
	ld hl,30840	; src offset 34, code offset 0x0682
	push hl		; code offset 0x0683
	ld hl,30840	; src offset 32, code offset 0x0686
	push hl		; code offset 0x0687
	ld hl,16449	; src offset 30, code offset 0x068a
	push hl		; code offset 0x068b
	ld hl,19028	; src offset 28, code offset 0x068e
	push hl		; code offset 0x068f
	ld hl,25966	; src offset 26, code offset 0x0692
	push hl		; code offset 0x0693
	ld hl,30590	; src offset 24, code offset 0x0696
	push hl		; code offset 0x0697
	ld hl,30060	; src offset 22, code offset 0x069a
	push hl		; code offset 0x069b
	ld hl,25169	; src offset 20, code offset 0x069e
	push hl		; code offset 0x069f
	ld hl,18552	; src offset 18, code offset 0x06a2
	push hl		; code offset 0x06a3
	ld hl,30840	; src offset 16, code offset 0x06a6
	push hl		; code offset 0x06a7
	ld hl,30840	; src offset 14, code offset 0x06aa
	push hl		; code offset 0x06ab
	ld hl,30840	; src offset 12, code offset 0x06ae
	push hl		; code offset 0x06af
	ld hl,30840	; src offset 10, code offset 0x06b2
	push hl		; code offset 0x06b3
	ld hl,30840	; src offset 8, code offset 0x06b6
	push hl		; code offset 0x06b7
	ld hl,30840	; src offset 6, code offset 0x06ba
	push hl		; code offset 0x06bb
	ld hl,30840	; src offset 4, code offset 0x06be
	push hl		; code offset 0x06bf
	ld hl,30840	; src offset 2, code offset 0x06c2
	push hl		; code offset 0x06c3
	ld hl,30840	; src offset 0, code offset 0x06c6
	push hl		; code offset 0x06c7

	; Block attribute blit end


	; src_data blit 203
	ld sp,screenStartAddr+3488	; offset 0x06ca
	ld hl,65535	; byte addr 0x0da0, code offset 0x06cd
	push hl	; offset 0x06ce
	ld hl,65535	; byte addr 0x0d9e, code offset 0x06d1
	push hl	; offset 0x06d2
	ld hl,7936	; byte addr 0x0d9c, code offset 0x06d5
	push hl	; offset 0x06d6
	ld hl,32771	; byte addr 0x0d9a, code offset 0x06d9
	push hl	; offset 0x06da
	ld hl,240	; byte addr 0x0d98, code offset 0x06dd
	push hl	; offset 0x06de
	ld hl,65283	; byte addr 0x0d96, code offset 0x06e1
	push hl	; offset 0x06e2
	ld hl,0	; byte addr 0x0d94, code offset 0x06e5
	push hl	; offset 0x06e6
	ld hl,61443	; byte addr 0x0d92, code offset 0x06e9
	push hl	; offset 0x06ea

	; src_data blit 204
	ld sp,screenStartAddr+3728	; offset 0x06ed
	ld hl,0	; byte addr 0x0e90, code offset 0x06f0
	push hl	; offset 0x06f1
	ld hl,0	; byte addr 0x0e8e, code offset 0x06f4
	push hl	; offset 0x06f5
	ld hl,0	; byte addr 0x0e8c, code offset 0x06f8
	push hl	; offset 0x06f9
	ld hl,0	; byte addr 0x0e8a, code offset 0x06fc
	push hl	; offset 0x06fd
	ld hl,64519	; byte addr 0x0e88, code offset 0x0700
	push hl	; offset 0x0701
	ld hl,0	; byte addr 0x0e86, code offset 0x0704
	push hl	; offset 0x0705
	ld hl,61695	; byte addr 0x0e84, code offset 0x0708
	push hl	; offset 0x0709
	ld hl,65535	; byte addr 0x0e82, code offset 0x070c
	push hl	; offset 0x070d

	; src_data blit 205
	ld sp,screenStartAddr+3744	; offset 0x0710
	ld hl,65535	; byte addr 0x0ea0, code offset 0x0713
	push hl	; offset 0x0714
	ld hl,65535	; byte addr 0x0e9e, code offset 0x0717
	push hl	; offset 0x0718
	ld hl,1792	; byte addr 0x0e9c, code offset 0x071b
	push hl	; offset 0x071c
	ld hl,0	; byte addr 0x0e9a, code offset 0x071f
	push hl	; offset 0x0720
	ld hl,224	; byte addr 0x0e98, code offset 0x0723
	push hl	; offset 0x0724
	ld hl,65281	; byte addr 0x0e96, code offset 0x0727
	push hl	; offset 0x0728
	ld hl,0	; byte addr 0x0e94, code offset 0x072b
	push hl	; offset 0x072c
	ld hl,49155	; byte addr 0x0e92, code offset 0x072f
	push hl	; offset 0x0730

	; src_data blit 206
	ld sp,screenStartAddr+3984	; offset 0x0733
	ld hl,0	; byte addr 0x0f90, code offset 0x0736
	push hl	; offset 0x0737
	ld hl,0	; byte addr 0x0f8e, code offset 0x073a
	push hl	; offset 0x073b
	ld hl,0	; byte addr 0x0f8c, code offset 0x073e
	push hl	; offset 0x073f
	ld hl,0	; byte addr 0x0f8a, code offset 0x0742
	push hl	; offset 0x0743
	ld hl,64519	; byte addr 0x0f88, code offset 0x0746
	push hl	; offset 0x0747
	ld hl,0	; byte addr 0x0f86, code offset 0x074a
	push hl	; offset 0x074b
	ld hl,63743	; byte addr 0x0f84, code offset 0x074e
	push hl	; offset 0x074f
	ld hl,65535	; byte addr 0x0f82, code offset 0x0752
	push hl	; offset 0x0753

	; src_data blit 207
	ld sp,screenStartAddr+4000	; offset 0x0756
	ld hl,65535	; byte addr 0x0fa0, code offset 0x0759
	push hl	; offset 0x075a
	ld hl,65535	; byte addr 0x0f9e, code offset 0x075d
	push hl	; offset 0x075e
	ld hl,768	; byte addr 0x0f9c, code offset 0x0761
	push hl	; offset 0x0762
	ld hl,0	; byte addr 0x0f9a, code offset 0x0765
	push hl	; offset 0x0766
	ld hl,0	; byte addr 0x0f98, code offset 0x0769
	push hl	; offset 0x076a
	ld hl,32512	; byte addr 0x0f96, code offset 0x076d
	push hl	; offset 0x076e
	ld hl,0	; byte addr 0x0f94, code offset 0x0771
	push hl	; offset 0x0772
	ld hl,32783	; byte addr 0x0f92, code offset 0x0775
	push hl	; offset 0x0776

	; src_data blit 208
	ld sp,screenStartAddr+2224	; offset 0x0779
	ld hl,0	; byte addr 0x08b0, code offset 0x077c
	push hl	; offset 0x077d
	ld hl,0	; byte addr 0x08ae, code offset 0x0780
	push hl	; offset 0x0781
	ld hl,0	; byte addr 0x08ac, code offset 0x0784
	push hl	; offset 0x0785
	ld hl,0	; byte addr 0x08aa, code offset 0x0788
	push hl	; offset 0x0789
	ld hl,63491	; byte addr 0x08a8, code offset 0x078c
	push hl	; offset 0x078d
	ld hl,0	; byte addr 0x08a6, code offset 0x0790
	push hl	; offset 0x0791
	ld hl,64767	; byte addr 0x08a4, code offset 0x0794
	push hl	; offset 0x0795
	ld hl,65535	; byte addr 0x08a2, code offset 0x0798
	push hl	; offset 0x0799

	; src_data blit 209
	ld sp,screenStartAddr+2240	; offset 0x079c
	ld hl,65535	; byte addr 0x08c0, code offset 0x079f
	push hl	; offset 0x07a0
	ld hl,65535	; byte addr 0x08be, code offset 0x07a3
	push hl	; offset 0x07a4
	ld hl,7936	; byte addr 0x08bc, code offset 0x07a7
	push hl	; offset 0x07a8
	ld hl,0	; byte addr 0x08ba, code offset 0x07ab
	push hl	; offset 0x07ac
	ld hl,0	; byte addr 0x08b8, code offset 0x07af
	push hl	; offset 0x07b0
	ld hl,0	; byte addr 0x08b6, code offset 0x07b3
	push hl	; offset 0x07b4
	ld hl,0	; byte addr 0x08b4, code offset 0x07b7
	push hl	; offset 0x07b8
	ld hl,63	; byte addr 0x08b2, code offset 0x07bb
	push hl	; offset 0x07bc

	; src_data blit 210
	ld sp,screenStartAddr+2480	; offset 0x07bf
	ld hl,0	; byte addr 0x09b0, code offset 0x07c2
	push hl	; offset 0x07c3
	ld hl,0	; byte addr 0x09ae, code offset 0x07c6
	push hl	; offset 0x07c7
	ld hl,0	; byte addr 0x09ac, code offset 0x07ca
	push hl	; offset 0x07cb
	ld hl,0	; byte addr 0x09aa, code offset 0x07ce
	push hl	; offset 0x07cf
	ld hl,63489	; byte addr 0x09a8, code offset 0x07d2
	push hl	; offset 0x07d3
	ld hl,0	; byte addr 0x09a6, code offset 0x07d6
	push hl	; offset 0x07d7
	ld hl,65279	; byte addr 0x09a4, code offset 0x07da
	push hl	; offset 0x07db
	ld hl,65535	; byte addr 0x09a2, code offset 0x07de
	push hl	; offset 0x07df

	; src_data blit 211
	ld sp,screenStartAddr+2496	; offset 0x07e2
	ld hl,65535	; byte addr 0x09c0, code offset 0x07e5
	push hl	; offset 0x07e6
	ld hl,65535	; byte addr 0x09be, code offset 0x07e9
	push hl	; offset 0x07ea
	ld hl,65281	; byte addr 0x09bc, code offset 0x07ed
	push hl	; offset 0x07ee
	ld hl,0	; byte addr 0x09ba, code offset 0x07f1
	push hl	; offset 0x07f2
	ld hl,0	; byte addr 0x09b8, code offset 0x07f5
	push hl	; offset 0x07f6
	ld hl,0	; byte addr 0x09b6, code offset 0x07f9
	push hl	; offset 0x07fa
	ld hl,0	; byte addr 0x09b4, code offset 0x07fd
	push hl	; offset 0x07fe
	ld hl,124	; byte addr 0x09b2, code offset 0x0801
	push hl	; offset 0x0802

	; src_data blit 212
	ld sp,screenStartAddr+2736	; offset 0x0805
	ld hl,256	; byte addr 0x0ab0, code offset 0x0808
	push hl	; offset 0x0809
	ld hl,0	; byte addr 0x0aae, code offset 0x080c
	push hl	; offset 0x080d
	ld hl,0	; byte addr 0x0aac, code offset 0x0810
	push hl	; offset 0x0811
	ld hl,0	; byte addr 0x0aaa, code offset 0x0814
	push hl	; offset 0x0815
	ld hl,63488	; byte addr 0x0aa8, code offset 0x0818
	push hl	; offset 0x0819
	ld hl,128	; byte addr 0x0aa6, code offset 0x081c
	push hl	; offset 0x081d
	ld hl,65535	; byte addr 0x0aa4, code offset 0x0820
	push hl	; offset 0x0821
	ld hl,65535	; byte addr 0x0aa2, code offset 0x0824
	push hl	; offset 0x0825

	; src_data blit 213
	ld sp,screenStartAddr+2752	; offset 0x0828
	ld hl,65535	; byte addr 0x0ac0, code offset 0x082b
	push hl	; offset 0x082c
	ld hl,65535	; byte addr 0x0abe, code offset 0x082f
	push hl	; offset 0x0830
	ld hl,65295	; byte addr 0x0abc, code offset 0x0833
	push hl	; offset 0x0834
	ld hl,0	; byte addr 0x0aba, code offset 0x0837
	push hl	; offset 0x0838
	ld hl,0	; byte addr 0x0ab8, code offset 0x083b
	push hl	; offset 0x083c
	ld hl,0	; byte addr 0x0ab6, code offset 0x083f
	push hl	; offset 0x0840
	ld hl,0	; byte addr 0x0ab4, code offset 0x0843
	push hl	; offset 0x0844
	ld hl,248	; byte addr 0x0ab2, code offset 0x0847
	push hl	; offset 0x0848

	; src_data blit 214
	ld sp,screenStartAddr+2992	; offset 0x084b
	ld hl,1792	; byte addr 0x0bb0, code offset 0x084e
	push hl	; offset 0x084f
	ld hl,0	; byte addr 0x0bae, code offset 0x0852
	push hl	; offset 0x0853
	ld hl,0	; byte addr 0x0bac, code offset 0x0856
	push hl	; offset 0x0857
	ld hl,0	; byte addr 0x0baa, code offset 0x085a
	push hl	; offset 0x085b
	ld hl,28672	; byte addr 0x0ba8, code offset 0x085e
	push hl	; offset 0x085f
	ld hl,192	; byte addr 0x0ba6, code offset 0x0862
	push hl	; offset 0x0863
	ld hl,65535	; byte addr 0x0ba4, code offset 0x0866
	push hl	; offset 0x0867
	ld hl,65535	; byte addr 0x0ba2, code offset 0x086a
	push hl	; offset 0x086b

	; src_data blit 215
	ld sp,screenStartAddr+3008	; offset 0x086e
	ld hl,65535	; byte addr 0x0bc0, code offset 0x0871
	push hl	; offset 0x0872
	ld hl,65535	; byte addr 0x0bbe, code offset 0x0875
	push hl	; offset 0x0876
	ld hl,65311	; byte addr 0x0bbc, code offset 0x0879
	push hl	; offset 0x087a
	ld hl,0	; byte addr 0x0bba, code offset 0x087d
	push hl	; offset 0x087e
	ld hl,0	; byte addr 0x0bb8, code offset 0x0881
	push hl	; offset 0x0882
	ld hl,0	; byte addr 0x0bb6, code offset 0x0885
	push hl	; offset 0x0886
	ld hl,0	; byte addr 0x0bb4, code offset 0x0889
	push hl	; offset 0x088a
	ld hl,224	; byte addr 0x0bb2, code offset 0x088d
	push hl	; offset 0x088e

	; src_data blit 216
	ld sp,screenStartAddr+3248	; offset 0x0891
	ld hl,3840	; byte addr 0x0cb0, code offset 0x0894
	push hl	; offset 0x0895
	ld hl,0	; byte addr 0x0cae, code offset 0x0898
	push hl	; offset 0x0899
	ld hl,0	; byte addr 0x0cac, code offset 0x089c
	push hl	; offset 0x089d
	ld hl,0	; byte addr 0x0caa, code offset 0x08a0
	push hl	; offset 0x08a1
	ld hl,28672	; byte addr 0x0ca8, code offset 0x08a4
	push hl	; offset 0x08a5
	ld hl,224	; byte addr 0x0ca6, code offset 0x08a8
	push hl	; offset 0x08a9
	ld hl,65535	; byte addr 0x0ca4, code offset 0x08ac
	push hl	; offset 0x08ad
	ld hl,65535	; byte addr 0x0ca2, code offset 0x08b0
	push hl	; offset 0x08b1

	; src_data blit 217
	ld sp,screenStartAddr+3264	; offset 0x08b4
	ld hl,65535	; byte addr 0x0cc0, code offset 0x08b7
	push hl	; offset 0x08b8
	ld hl,65535	; byte addr 0x0cbe, code offset 0x08bb
	push hl	; offset 0x08bc
	ld hl,65295	; byte addr 0x0cbc, code offset 0x08bf
	push hl	; offset 0x08c0
	ld hl,0	; byte addr 0x0cba, code offset 0x08c3
	push hl	; offset 0x08c4
	ld hl,0	; byte addr 0x0cb8, code offset 0x08c7
	push hl	; offset 0x08c8
	ld hl,0	; byte addr 0x0cb6, code offset 0x08cb
	push hl	; offset 0x08cc
	ld hl,0	; byte addr 0x0cb4, code offset 0x08cf
	push hl	; offset 0x08d0
	ld hl,192	; byte addr 0x0cb2, code offset 0x08d3
	push hl	; offset 0x08d4

	; src_data blit 218
	ld sp,screenStartAddr+3504	; offset 0x08d7
	ld hl,7936	; byte addr 0x0db0, code offset 0x08da
	push hl	; offset 0x08db
	ld hl,0	; byte addr 0x0dae, code offset 0x08de
	push hl	; offset 0x08df
	ld hl,0	; byte addr 0x0dac, code offset 0x08e2
	push hl	; offset 0x08e3
	ld hl,0	; byte addr 0x0daa, code offset 0x08e6
	push hl	; offset 0x08e7
	ld hl,0	; byte addr 0x0da8, code offset 0x08ea
	push hl	; offset 0x08eb
	ld hl,240	; byte addr 0x0da6, code offset 0x08ee
	push hl	; offset 0x08ef
	ld hl,65535	; byte addr 0x0da4, code offset 0x08f2
	push hl	; offset 0x08f3
	ld hl,65535	; byte addr 0x0da2, code offset 0x08f6
	push hl	; offset 0x08f7

	; src_data blit 219
	ld sp,screenStartAddr+3520	; offset 0x08fa
	ld hl,65535	; byte addr 0x0dc0, code offset 0x08fd
	push hl	; offset 0x08fe
	ld hl,65535	; byte addr 0x0dbe, code offset 0x0901
	push hl	; offset 0x0902
	ld hl,65287	; byte addr 0x0dbc, code offset 0x0905
	push hl	; offset 0x0906
	ld hl,0	; byte addr 0x0dba, code offset 0x0909
	push hl	; offset 0x090a
	ld hl,0	; byte addr 0x0db8, code offset 0x090d
	push hl	; offset 0x090e
	ld hl,0	; byte addr 0x0db6, code offset 0x0911
	push hl	; offset 0x0912
	ld hl,0	; byte addr 0x0db4, code offset 0x0915
	push hl	; offset 0x0916
	ld hl,248	; byte addr 0x0db2, code offset 0x0919
	push hl	; offset 0x091a

	; src_data blit 220
	ld sp,screenStartAddr+3760	; offset 0x091d
	ld hl,256	; byte addr 0x0eb0, code offset 0x0920
	push hl	; offset 0x0921
	ld hl,0	; byte addr 0x0eae, code offset 0x0924
	push hl	; offset 0x0925
	ld hl,0	; byte addr 0x0eac, code offset 0x0928
	push hl	; offset 0x0929
	ld hl,0	; byte addr 0x0eaa, code offset 0x092c
	push hl	; offset 0x092d
	ld hl,0	; byte addr 0x0ea8, code offset 0x0930
	push hl	; offset 0x0931
	ld hl,248	; byte addr 0x0ea6, code offset 0x0934
	push hl	; offset 0x0935
	ld hl,65535	; byte addr 0x0ea4, code offset 0x0938
	push hl	; offset 0x0939
	ld hl,65535	; byte addr 0x0ea2, code offset 0x093c
	push hl	; offset 0x093d

	; src_data blit 221
	ld sp,screenStartAddr+3776	; offset 0x0940
	ld hl,65535	; byte addr 0x0ec0, code offset 0x0943
	push hl	; offset 0x0944
	ld hl,65535	; byte addr 0x0ebe, code offset 0x0947
	push hl	; offset 0x0948
	ld hl,65287	; byte addr 0x0ebc, code offset 0x094b
	push hl	; offset 0x094c
	ld hl,192	; byte addr 0x0eba, code offset 0x094f
	push hl	; offset 0x0950
	ld hl,16128	; byte addr 0x0eb8, code offset 0x0953
	push hl	; offset 0x0954
	ld hl,0	; byte addr 0x0eb6, code offset 0x0957
	push hl	; offset 0x0958
	ld hl,0	; byte addr 0x0eb4, code offset 0x095b
	push hl	; offset 0x095c
	ld hl,254	; byte addr 0x0eb2, code offset 0x095f
	push hl	; offset 0x0960

	; src_data blit 222
	ld sp,screenStartAddr+4016	; offset 0x0963
	ld hl,0	; byte addr 0x0fb0, code offset 0x0966
	push hl	; offset 0x0967
	ld hl,0	; byte addr 0x0fae, code offset 0x096a
	push hl	; offset 0x096b
	ld hl,0	; byte addr 0x0fac, code offset 0x096e
	push hl	; offset 0x096f
	ld hl,0	; byte addr 0x0faa, code offset 0x0972
	push hl	; offset 0x0973
	ld hl,0	; byte addr 0x0fa8, code offset 0x0976
	push hl	; offset 0x0977
	ld hl,254	; byte addr 0x0fa6, code offset 0x097a
	push hl	; offset 0x097b
	ld hl,65535	; byte addr 0x0fa4, code offset 0x097e
	push hl	; offset 0x097f
	ld hl,65535	; byte addr 0x0fa2, code offset 0x0982
	push hl	; offset 0x0983

	; src_data blit 223
	ld sp,screenStartAddr+4032	; offset 0x0986
	ld hl,65535	; byte addr 0x0fc0, code offset 0x0989
	push hl	; offset 0x098a
	ld hl,65535	; byte addr 0x0fbe, code offset 0x098d
	push hl	; offset 0x098e
	ld hl,65283	; byte addr 0x0fbc, code offset 0x0991
	push hl	; offset 0x0992
	ld hl,192	; byte addr 0x0fba, code offset 0x0995
	push hl	; offset 0x0996
	ld hl,16128	; byte addr 0x0fb8, code offset 0x0999
	push hl	; offset 0x099a
	ld hl,0	; byte addr 0x0fb6, code offset 0x099d
	push hl	; offset 0x099e
	ld hl,0	; byte addr 0x0fb4, code offset 0x09a1
	push hl	; offset 0x09a2
	ld hl,61455	; byte addr 0x0fb2, code offset 0x09a5
	push hl	; offset 0x09a6

	; src_data blit 224
	ld sp,screenStartAddr+2256	; offset 0x09a9
	ld hl,0	; byte addr 0x08d0, code offset 0x09ac
	push hl	; offset 0x09ad
	ld hl,32768	; byte addr 0x08ce, code offset 0x09b0
	push hl	; offset 0x09b1
	ld hl,0	; byte addr 0x08cc, code offset 0x09b4
	push hl	; offset 0x09b5
	ld hl,0	; byte addr 0x08ca, code offset 0x09b8
	push hl	; offset 0x09b9
	ld hl,0	; byte addr 0x08c8, code offset 0x09bc
	push hl	; offset 0x09bd
	ld hl,255	; byte addr 0x08c6, code offset 0x09c0
	push hl	; offset 0x09c1
	ld hl,65535	; byte addr 0x08c4, code offset 0x09c4
	push hl	; offset 0x09c5
	ld hl,65535	; byte addr 0x08c2, code offset 0x09c8
	push hl	; offset 0x09c9

	; src_data blit 225
	ld sp,screenStartAddr+2272	; offset 0x09cc
	ld hl,65535	; byte addr 0x08e0, code offset 0x09cf
	push hl	; offset 0x09d0
	ld hl,65535	; byte addr 0x08de, code offset 0x09d3
	push hl	; offset 0x09d4
	ld hl,65281	; byte addr 0x08dc, code offset 0x09d7
	push hl	; offset 0x09d8
	ld hl,128	; byte addr 0x08da, code offset 0x09db
	push hl	; offset 0x09dc
	ld hl,7936	; byte addr 0x08d8, code offset 0x09df
	push hl	; offset 0x09e0
	ld hl,0	; byte addr 0x08d6, code offset 0x09e3
	push hl	; offset 0x09e4
	ld hl,0	; byte addr 0x08d4, code offset 0x09e7
	push hl	; offset 0x09e8
	ld hl,65024	; byte addr 0x08d2, code offset 0x09eb
	push hl	; offset 0x09ec

	; src_data blit 226
	ld sp,screenStartAddr+2512	; offset 0x09ef
	ld hl,0	; byte addr 0x09d0, code offset 0x09f2
	push hl	; offset 0x09f3
	ld hl,32768	; byte addr 0x09ce, code offset 0x09f6
	push hl	; offset 0x09f7
	ld hl,0	; byte addr 0x09cc, code offset 0x09fa
	push hl	; offset 0x09fb
	ld hl,0	; byte addr 0x09ca, code offset 0x09fe
	push hl	; offset 0x09ff
	ld hl,0	; byte addr 0x09c8, code offset 0x0a02
	push hl	; offset 0x0a03
	ld hl,33023	; byte addr 0x09c6, code offset 0x0a06
	push hl	; offset 0x0a07
	ld hl,65535	; byte addr 0x09c4, code offset 0x0a0a
	push hl	; offset 0x0a0b
	ld hl,65535	; byte addr 0x09c2, code offset 0x0a0e
	push hl	; offset 0x0a0f

	; src_data blit 227
	ld sp,screenStartAddr+2528	; offset 0x0a12
	ld hl,65535	; byte addr 0x09e0, code offset 0x0a15
	push hl	; offset 0x0a16
	ld hl,65535	; byte addr 0x09de, code offset 0x0a19
	push hl	; offset 0x0a1a
	ld hl,65281	; byte addr 0x09dc, code offset 0x0a1d
	push hl	; offset 0x0a1e
	ld hl,128	; byte addr 0x09da, code offset 0x0a21
	push hl	; offset 0x0a22
	ld hl,3840	; byte addr 0x09d8, code offset 0x0a25
	push hl	; offset 0x0a26
	ld hl,0	; byte addr 0x09d6, code offset 0x0a29
	push hl	; offset 0x0a2a
	ld hl,192	; byte addr 0x09d4, code offset 0x0a2d
	push hl	; offset 0x0a2e
	ld hl,1792	; byte addr 0x09d2, code offset 0x0a31
	push hl	; offset 0x0a32

	; src_data blit 228
	ld sp,screenStartAddr+2768	; offset 0x0a35
	ld hl,0	; byte addr 0x0ad0, code offset 0x0a38
	push hl	; offset 0x0a39
	ld hl,32768	; byte addr 0x0ace, code offset 0x0a3c
	push hl	; offset 0x0a3d
	ld hl,0	; byte addr 0x0acc, code offset 0x0a40
	push hl	; offset 0x0a41
	ld hl,0	; byte addr 0x0aca, code offset 0x0a44
	push hl	; offset 0x0a45
	ld hl,0	; byte addr 0x0ac8, code offset 0x0a48
	push hl	; offset 0x0a49
	ld hl,57599	; byte addr 0x0ac6, code offset 0x0a4c
	push hl	; offset 0x0a4d
	ld hl,65535	; byte addr 0x0ac4, code offset 0x0a50
	push hl	; offset 0x0a51
	ld hl,65535	; byte addr 0x0ac2, code offset 0x0a54
	push hl	; offset 0x0a55

	; src_data blit 229
	ld sp,screenStartAddr+2784	; offset 0x0a58
	ld hl,65535	; byte addr 0x0ae0, code offset 0x0a5b
	push hl	; offset 0x0a5c
	ld hl,65535	; byte addr 0x0ade, code offset 0x0a5f
	push hl	; offset 0x0a60
	ld hl,65280	; byte addr 0x0adc, code offset 0x0a63
	push hl	; offset 0x0a64
	ld hl,0	; byte addr 0x0ada, code offset 0x0a67
	push hl	; offset 0x0a68
	ld hl,3840	; byte addr 0x0ad8, code offset 0x0a6b
	push hl	; offset 0x0a6c
	ld hl,0	; byte addr 0x0ad6, code offset 0x0a6f
	push hl	; offset 0x0a70
	ld hl,0	; byte addr 0x0ad4, code offset 0x0a73
	push hl	; offset 0x0a74
	ld hl,0	; byte addr 0x0ad2, code offset 0x0a77
	push hl	; offset 0x0a78

	; src_data blit 230
	ld sp,screenStartAddr+3024	; offset 0x0a7b
	ld hl,0	; byte addr 0x0bd0, code offset 0x0a7e
	push hl	; offset 0x0a7f
	ld hl,32768	; byte addr 0x0bce, code offset 0x0a82
	push hl	; offset 0x0a83
	ld hl,0	; byte addr 0x0bcc, code offset 0x0a86
	push hl	; offset 0x0a87
	ld hl,0	; byte addr 0x0bca, code offset 0x0a8a
	push hl	; offset 0x0a8b
	ld hl,0	; byte addr 0x0bc8, code offset 0x0a8e
	push hl	; offset 0x0a8f
	ld hl,61695	; byte addr 0x0bc6, code offset 0x0a92
	push hl	; offset 0x0a93
	ld hl,65535	; byte addr 0x0bc4, code offset 0x0a96
	push hl	; offset 0x0a97
	ld hl,65535	; byte addr 0x0bc2, code offset 0x0a9a
	push hl	; offset 0x0a9b

	; src_data blit 231
	ld sp,screenStartAddr+3040	; offset 0x0a9e
	ld hl,65535	; byte addr 0x0be0, code offset 0x0aa1
	push hl	; offset 0x0aa2
	ld hl,65535	; byte addr 0x0bde, code offset 0x0aa5
	push hl	; offset 0x0aa6
	ld hl,65407	; byte addr 0x0bdc, code offset 0x0aa9
	push hl	; offset 0x0aaa
	ld hl,0	; byte addr 0x0bda, code offset 0x0aad
	push hl	; offset 0x0aae
	ld hl,1536	; byte addr 0x0bd8, code offset 0x0ab1
	push hl	; offset 0x0ab2
	ld hl,0	; byte addr 0x0bd6, code offset 0x0ab5
	push hl	; offset 0x0ab6
	ld hl,0	; byte addr 0x0bd4, code offset 0x0ab9
	push hl	; offset 0x0aba
	ld hl,0	; byte addr 0x0bd2, code offset 0x0abd
	push hl	; offset 0x0abe

	; src_data blit 232
	ld sp,screenStartAddr+3280	; offset 0x0ac1
	ld hl,0	; byte addr 0x0cd0, code offset 0x0ac4
	push hl	; offset 0x0ac5
	ld hl,32769	; byte addr 0x0cce, code offset 0x0ac8
	push hl	; offset 0x0ac9
	ld hl,0	; byte addr 0x0ccc, code offset 0x0acc
	push hl	; offset 0x0acd
	ld hl,0	; byte addr 0x0cca, code offset 0x0ad0
	push hl	; offset 0x0ad1
	ld hl,0	; byte addr 0x0cc8, code offset 0x0ad4
	push hl	; offset 0x0ad5
	ld hl,64767	; byte addr 0x0cc6, code offset 0x0ad8
	push hl	; offset 0x0ad9
	ld hl,65535	; byte addr 0x0cc4, code offset 0x0adc
	push hl	; offset 0x0add
	ld hl,65535	; byte addr 0x0cc2, code offset 0x0ae0
	push hl	; offset 0x0ae1

	; src_data blit 233
	ld sp,screenStartAddr+3296	; offset 0x0ae4
	ld hl,65535	; byte addr 0x0ce0, code offset 0x0ae7
	push hl	; offset 0x0ae8
	ld hl,65535	; byte addr 0x0cde, code offset 0x0aeb
	push hl	; offset 0x0aec
	ld hl,65535	; byte addr 0x0cdc, code offset 0x0aef
	push hl	; offset 0x0af0
	ld hl,7936	; byte addr 0x0cda, code offset 0x0af3
	push hl	; offset 0x0af4
	ld hl,0	; byte addr 0x0cd8, code offset 0x0af7
	push hl	; offset 0x0af8
	ld hl,0	; byte addr 0x0cd6, code offset 0x0afb
	push hl	; offset 0x0afc
	ld hl,0	; byte addr 0x0cd4, code offset 0x0aff
	push hl	; offset 0x0b00
	ld hl,0	; byte addr 0x0cd2, code offset 0x0b03
	push hl	; offset 0x0b04

	; src_data blit 234
	ld sp,screenStartAddr+3536	; offset 0x0b07
	ld hl,0	; byte addr 0x0dd0, code offset 0x0b0a
	push hl	; offset 0x0b0b
	ld hl,32769	; byte addr 0x0dce, code offset 0x0b0e
	push hl	; offset 0x0b0f
	ld hl,0	; byte addr 0x0dcc, code offset 0x0b12
	push hl	; offset 0x0b13
	ld hl,0	; byte addr 0x0dca, code offset 0x0b16
	push hl	; offset 0x0b17
	ld hl,0	; byte addr 0x0dc8, code offset 0x0b1a
	push hl	; offset 0x0b1b
	ld hl,57599	; byte addr 0x0dc6, code offset 0x0b1e
	push hl	; offset 0x0b1f
	ld hl,65535	; byte addr 0x0dc4, code offset 0x0b22
	push hl	; offset 0x0b23
	ld hl,65535	; byte addr 0x0dc2, code offset 0x0b26
	push hl	; offset 0x0b27

	; src_data blit 235
	ld sp,screenStartAddr+3552	; offset 0x0b2a
	ld hl,65535	; byte addr 0x0de0, code offset 0x0b2d
	push hl	; offset 0x0b2e
	ld hl,65535	; byte addr 0x0dde, code offset 0x0b31
	push hl	; offset 0x0b32
	ld hl,65535	; byte addr 0x0ddc, code offset 0x0b35
	push hl	; offset 0x0b36
	ld hl,16128	; byte addr 0x0dda, code offset 0x0b39
	push hl	; offset 0x0b3a
	ld hl,0	; byte addr 0x0dd8, code offset 0x0b3d
	push hl	; offset 0x0b3e
	ld hl,0	; byte addr 0x0dd6, code offset 0x0b41
	push hl	; offset 0x0b42
	ld hl,0	; byte addr 0x0dd4, code offset 0x0b45
	push hl	; offset 0x0b46
	ld hl,0	; byte addr 0x0dd2, code offset 0x0b49
	push hl	; offset 0x0b4a

	; src_data blit 236
	ld sp,screenStartAddr+3792	; offset 0x0b4d
	ld hl,0	; byte addr 0x0ed0, code offset 0x0b50
	push hl	; offset 0x0b51
	ld hl,32769	; byte addr 0x0ece, code offset 0x0b54
	push hl	; offset 0x0b55
	ld hl,0	; byte addr 0x0ecc, code offset 0x0b58
	push hl	; offset 0x0b59
	ld hl,0	; byte addr 0x0eca, code offset 0x0b5c
	push hl	; offset 0x0b5d
	ld hl,0	; byte addr 0x0ec8, code offset 0x0b60
	push hl	; offset 0x0b61
	ld hl,224	; byte addr 0x0ec6, code offset 0x0b64
	push hl	; offset 0x0b65
	ld hl,65535	; byte addr 0x0ec4, code offset 0x0b68
	push hl	; offset 0x0b69
	ld hl,65535	; byte addr 0x0ec2, code offset 0x0b6c
	push hl	; offset 0x0b6d

	; src_data blit 237
	ld sp,screenStartAddr+3808	; offset 0x0b70
	ld hl,65535	; byte addr 0x0ee0, code offset 0x0b73
	push hl	; offset 0x0b74
	ld hl,65535	; byte addr 0x0ede, code offset 0x0b77
	push hl	; offset 0x0b78
	ld hl,65535	; byte addr 0x0edc, code offset 0x0b7b
	push hl	; offset 0x0b7c
	ld hl,65280	; byte addr 0x0eda, code offset 0x0b7f
	push hl	; offset 0x0b80
	ld hl,0	; byte addr 0x0ed8, code offset 0x0b83
	push hl	; offset 0x0b84
	ld hl,0	; byte addr 0x0ed6, code offset 0x0b87
	push hl	; offset 0x0b88
	ld hl,0	; byte addr 0x0ed4, code offset 0x0b8b
	push hl	; offset 0x0b8c
	ld hl,0	; byte addr 0x0ed2, code offset 0x0b8f
	push hl	; offset 0x0b90

	; src_data blit 238
	ld sp,screenStartAddr+4048	; offset 0x0b93
	ld hl,0	; byte addr 0x0fd0, code offset 0x0b96
	push hl	; offset 0x0b97
	ld hl,32769	; byte addr 0x0fce, code offset 0x0b9a
	push hl	; offset 0x0b9b
	ld hl,0	; byte addr 0x0fcc, code offset 0x0b9e
	push hl	; offset 0x0b9f
	ld hl,0	; byte addr 0x0fca, code offset 0x0ba2
	push hl	; offset 0x0ba3
	ld hl,0	; byte addr 0x0fc8, code offset 0x0ba6
	push hl	; offset 0x0ba7
	ld hl,224	; byte addr 0x0fc6, code offset 0x0baa
	push hl	; offset 0x0bab
	ld hl,65535	; byte addr 0x0fc4, code offset 0x0bae
	push hl	; offset 0x0baf
	ld hl,65535	; byte addr 0x0fc2, code offset 0x0bb2
	push hl	; offset 0x0bb3

	; src_data blit 239
	ld sp,screenStartAddr+4064	; offset 0x0bb6
	ld hl,65535	; byte addr 0x0fe0, code offset 0x0bb9
	push hl	; offset 0x0bba
	ld hl,65535	; byte addr 0x0fde, code offset 0x0bbd
	push hl	; offset 0x0bbe
	ld hl,65535	; byte addr 0x0fdc, code offset 0x0bc1
	push hl	; offset 0x0bc2
	ld hl,65283	; byte addr 0x0fda, code offset 0x0bc5
	push hl	; offset 0x0bc6
	ld hl,0	; byte addr 0x0fd8, code offset 0x0bc9
	push hl	; offset 0x0bca
	ld hl,0	; byte addr 0x0fd6, code offset 0x0bcd
	push hl	; offset 0x0bce
	ld hl,0	; byte addr 0x0fd4, code offset 0x0bd1
	push hl	; offset 0x0bd2
	ld hl,0	; byte addr 0x0fd2, code offset 0x0bd5
	push hl	; offset 0x0bd6

	; src_data blit 240
	ld sp,screenStartAddr+2288	; offset 0x0bd9
	ld hl,0	; byte addr 0x08f0, code offset 0x0bdc
	push hl	; offset 0x0bdd
	ld hl,32769	; byte addr 0x08ee, code offset 0x0be0
	push hl	; offset 0x0be1
	ld hl,0	; byte addr 0x08ec, code offset 0x0be4
	push hl	; offset 0x0be5
	ld hl,0	; byte addr 0x08ea, code offset 0x0be8
	push hl	; offset 0x0be9
	ld hl,0	; byte addr 0x08e8, code offset 0x0bec
	push hl	; offset 0x0bed
	ld hl,248	; byte addr 0x08e6, code offset 0x0bf0
	push hl	; offset 0x0bf1
	ld hl,65535	; byte addr 0x08e4, code offset 0x0bf4
	push hl	; offset 0x0bf5
	ld hl,65535	; byte addr 0x08e2, code offset 0x0bf8
	push hl	; offset 0x0bf9

	; src_data blit 241
	ld sp,screenStartAddr+2304	; offset 0x0bfc
	ld hl,65535	; byte addr 0x0900, code offset 0x0bff
	push hl	; offset 0x0c00
	ld hl,65535	; byte addr 0x08fe, code offset 0x0c03
	push hl	; offset 0x0c04
	ld hl,65535	; byte addr 0x08fc, code offset 0x0c07
	push hl	; offset 0x0c08
	ld hl,65287	; byte addr 0x08fa, code offset 0x0c0b
	push hl	; offset 0x0c0c
	ld hl,0	; byte addr 0x08f8, code offset 0x0c0f
	push hl	; offset 0x0c10
	ld hl,0	; byte addr 0x08f6, code offset 0x0c13
	push hl	; offset 0x0c14
	ld hl,0	; byte addr 0x08f4, code offset 0x0c17
	push hl	; offset 0x0c18
	ld hl,0	; byte addr 0x08f2, code offset 0x0c1b
	push hl	; offset 0x0c1c

	; src_data blit 242
	ld sp,screenStartAddr+2544	; offset 0x0c1f
	ld hl,0	; byte addr 0x09f0, code offset 0x0c22
	push hl	; offset 0x0c23
	ld hl,32769	; byte addr 0x09ee, code offset 0x0c26
	push hl	; offset 0x0c27
	ld hl,0	; byte addr 0x09ec, code offset 0x0c2a
	push hl	; offset 0x0c2b
	ld hl,0	; byte addr 0x09ea, code offset 0x0c2e
	push hl	; offset 0x0c2f
	ld hl,0	; byte addr 0x09e8, code offset 0x0c32
	push hl	; offset 0x0c33
	ld hl,254	; byte addr 0x09e6, code offset 0x0c36
	push hl	; offset 0x0c37
	ld hl,65535	; byte addr 0x09e4, code offset 0x0c3a
	push hl	; offset 0x0c3b
	ld hl,65535	; byte addr 0x09e2, code offset 0x0c3e
	push hl	; offset 0x0c3f

	; src_data blit 243
	ld sp,screenStartAddr+2560	; offset 0x0c42
	ld hl,65535	; byte addr 0x0a00, code offset 0x0c45
	push hl	; offset 0x0c46
	ld hl,65535	; byte addr 0x09fe, code offset 0x0c49
	push hl	; offset 0x0c4a
	ld hl,65535	; byte addr 0x09fc, code offset 0x0c4d
	push hl	; offset 0x0c4e
	ld hl,65311	; byte addr 0x09fa, code offset 0x0c51
	push hl	; offset 0x0c52
	ld hl,0	; byte addr 0x09f8, code offset 0x0c55
	push hl	; offset 0x0c56
	ld hl,0	; byte addr 0x09f6, code offset 0x0c59
	push hl	; offset 0x0c5a
	ld hl,0	; byte addr 0x09f4, code offset 0x0c5d
	push hl	; offset 0x0c5e
	ld hl,0	; byte addr 0x09f2, code offset 0x0c61
	push hl	; offset 0x0c62

	; src_data blit 244
	ld sp,screenStartAddr+2800	; offset 0x0c65
	ld hl,0	; byte addr 0x0af0, code offset 0x0c68
	push hl	; offset 0x0c69
	ld hl,32771	; byte addr 0x0aee, code offset 0x0c6c
	push hl	; offset 0x0c6d
	ld hl,0	; byte addr 0x0aec, code offset 0x0c70
	push hl	; offset 0x0c71
	ld hl,0	; byte addr 0x0aea, code offset 0x0c74
	push hl	; offset 0x0c75
	ld hl,0	; byte addr 0x0ae8, code offset 0x0c78
	push hl	; offset 0x0c79
	ld hl,49407	; byte addr 0x0ae6, code offset 0x0c7c
	push hl	; offset 0x0c7d
	ld hl,65535	; byte addr 0x0ae4, code offset 0x0c80
	push hl	; offset 0x0c81
	ld hl,65535	; byte addr 0x0ae2, code offset 0x0c84
	push hl	; offset 0x0c85

	; src_data blit 245
	ld sp,screenStartAddr+2816	; offset 0x0c88
	ld hl,65535	; byte addr 0x0b00, code offset 0x0c8b
	push hl	; offset 0x0c8c
	ld hl,65535	; byte addr 0x0afe, code offset 0x0c8f
	push hl	; offset 0x0c90
	ld hl,65535	; byte addr 0x0afc, code offset 0x0c93
	push hl	; offset 0x0c94
	ld hl,65407	; byte addr 0x0afa, code offset 0x0c97
	push hl	; offset 0x0c98
	ld hl,0	; byte addr 0x0af8, code offset 0x0c9b
	push hl	; offset 0x0c9c
	ld hl,0	; byte addr 0x0af6, code offset 0x0c9f
	push hl	; offset 0x0ca0
	ld hl,0	; byte addr 0x0af4, code offset 0x0ca3
	push hl	; offset 0x0ca4
	ld hl,0	; byte addr 0x0af2, code offset 0x0ca7
	push hl	; offset 0x0ca8

	; src_data blit 246
	ld sp,screenStartAddr+3056	; offset 0x0cab
	ld hl,0	; byte addr 0x0bf0, code offset 0x0cae
	push hl	; offset 0x0caf
	ld hl,32771	; byte addr 0x0bee, code offset 0x0cb2
	push hl	; offset 0x0cb3
	ld hl,0	; byte addr 0x0bec, code offset 0x0cb6
	push hl	; offset 0x0cb7
	ld hl,0	; byte addr 0x0bea, code offset 0x0cba
	push hl	; offset 0x0cbb
	ld hl,0	; byte addr 0x0be8, code offset 0x0cbe
	push hl	; offset 0x0cbf
	ld hl,61695	; byte addr 0x0be6, code offset 0x0cc2
	push hl	; offset 0x0cc3
	ld hl,65535	; byte addr 0x0be4, code offset 0x0cc6
	push hl	; offset 0x0cc7
	ld hl,65535	; byte addr 0x0be2, code offset 0x0cca
	push hl	; offset 0x0ccb

	; src_data blit 247
	ld sp,screenStartAddr+3072	; offset 0x0cce
	ld hl,65535	; byte addr 0x0c00, code offset 0x0cd1
	push hl	; offset 0x0cd2
	ld hl,65535	; byte addr 0x0bfe, code offset 0x0cd5
	push hl	; offset 0x0cd6
	ld hl,65535	; byte addr 0x0bfc, code offset 0x0cd9
	push hl	; offset 0x0cda
	ld hl,65535	; byte addr 0x0bfa, code offset 0x0cdd
	push hl	; offset 0x0cde
	ld hl,256	; byte addr 0x0bf8, code offset 0x0ce1
	push hl	; offset 0x0ce2
	ld hl,0	; byte addr 0x0bf6, code offset 0x0ce5
	push hl	; offset 0x0ce6
	ld hl,0	; byte addr 0x0bf4, code offset 0x0ce9
	push hl	; offset 0x0cea
	ld hl,0	; byte addr 0x0bf2, code offset 0x0ced
	push hl	; offset 0x0cee

	; src_data blit 248
	ld sp,screenStartAddr+3312	; offset 0x0cf1
	ld hl,0	; byte addr 0x0cf0, code offset 0x0cf4
	push hl	; offset 0x0cf5
	ld hl,32771	; byte addr 0x0cee, code offset 0x0cf8
	push hl	; offset 0x0cf9
	ld hl,0	; byte addr 0x0cec, code offset 0x0cfc
	push hl	; offset 0x0cfd
	ld hl,0	; byte addr 0x0cea, code offset 0x0d00
	push hl	; offset 0x0d01
	ld hl,0	; byte addr 0x0ce8, code offset 0x0d04
	push hl	; offset 0x0d05
	ld hl,65279	; byte addr 0x0ce6, code offset 0x0d08
	push hl	; offset 0x0d09
	ld hl,65535	; byte addr 0x0ce4, code offset 0x0d0c
	push hl	; offset 0x0d0d
	ld hl,65535	; byte addr 0x0ce2, code offset 0x0d10
	push hl	; offset 0x0d11

	; src_data blit 249
	ld sp,screenStartAddr+3328	; offset 0x0d14
	ld hl,65535	; byte addr 0x0d00, code offset 0x0d17
	push hl	; offset 0x0d18
	ld hl,65535	; byte addr 0x0cfe, code offset 0x0d1b
	push hl	; offset 0x0d1c
	ld hl,65535	; byte addr 0x0cfc, code offset 0x0d1f
	push hl	; offset 0x0d20
	ld hl,65535	; byte addr 0x0cfa, code offset 0x0d23
	push hl	; offset 0x0d24
	ld hl,1792	; byte addr 0x0cf8, code offset 0x0d27
	push hl	; offset 0x0d28
	ld hl,0	; byte addr 0x0cf6, code offset 0x0d2b
	push hl	; offset 0x0d2c
	ld hl,0	; byte addr 0x0cf4, code offset 0x0d2f
	push hl	; offset 0x0d30
	ld hl,0	; byte addr 0x0cf2, code offset 0x0d33
	push hl	; offset 0x0d34

	; src_data blit 250
	ld sp,screenStartAddr+3568	; offset 0x0d37
	ld hl,0	; byte addr 0x0df0, code offset 0x0d3a
	push hl	; offset 0x0d3b
	ld hl,32775	; byte addr 0x0dee, code offset 0x0d3e
	push hl	; offset 0x0d3f
	ld hl,0	; byte addr 0x0dec, code offset 0x0d42
	push hl	; offset 0x0d43
	ld hl,0	; byte addr 0x0dea, code offset 0x0d46
	push hl	; offset 0x0d47
	ld hl,224	; byte addr 0x0de8, code offset 0x0d4a
	push hl	; offset 0x0d4b
	ld hl,65535	; byte addr 0x0de6, code offset 0x0d4e
	push hl	; offset 0x0d4f
	ld hl,65535	; byte addr 0x0de4, code offset 0x0d52
	push hl	; offset 0x0d53
	ld hl,65535	; byte addr 0x0de2, code offset 0x0d56
	push hl	; offset 0x0d57

	; src_data blit 251
	ld sp,screenStartAddr+3584	; offset 0x0d5a
	ld hl,65535	; byte addr 0x0e00, code offset 0x0d5d
	push hl	; offset 0x0d5e
	ld hl,65535	; byte addr 0x0dfe, code offset 0x0d61
	push hl	; offset 0x0d62
	ld hl,65535	; byte addr 0x0dfc, code offset 0x0d65
	push hl	; offset 0x0d66
	ld hl,65535	; byte addr 0x0dfa, code offset 0x0d69
	push hl	; offset 0x0d6a
	ld hl,16128	; byte addr 0x0df8, code offset 0x0d6d
	push hl	; offset 0x0d6e
	ld hl,0	; byte addr 0x0df6, code offset 0x0d71
	push hl	; offset 0x0d72
	ld hl,0	; byte addr 0x0df4, code offset 0x0d75
	push hl	; offset 0x0d76
	ld hl,0	; byte addr 0x0df2, code offset 0x0d79
	push hl	; offset 0x0d7a

	; attr draw 0, code offset 0x0d7a
	ld sp,attr8and16vals+0
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,18552	; src 18
	ld de,20552	; src 20
	ld hl,27746	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+0
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+0),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+0),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,32373	; src 24
	ld de,28279	; src 26
	ld hl,21605	; src 28
	ld sp,attrStartAddr+30+0
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,16714	; src 30
	ld (attrStartAddr+30+0),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 0, offset 0x0dd3
	; Clock offset: -864


	; src_data blit 252
	ld sp,screenStartAddr+3824	; offset 0x0dd6
	ld hl,0	; byte addr 0x0ef0, code offset 0x0dd9
	push hl	; offset 0x0dda
	ld hl,32775	; byte addr 0x0eee, code offset 0x0ddd
	push hl	; offset 0x0dde
	ld hl,0	; byte addr 0x0eec, code offset 0x0de1
	push hl	; offset 0x0de2
	ld hl,0	; byte addr 0x0eea, code offset 0x0de5
	push hl	; offset 0x0de6
	ld hl,248	; byte addr 0x0ee8, code offset 0x0de9
	push hl	; offset 0x0dea
	ld hl,65535	; byte addr 0x0ee6, code offset 0x0ded
	push hl	; offset 0x0dee
	ld hl,65535	; byte addr 0x0ee4, code offset 0x0df1
	push hl	; offset 0x0df2
	ld hl,65535	; byte addr 0x0ee2, code offset 0x0df5
	push hl	; offset 0x0df6

	; src_data blit 253
	ld sp,screenStartAddr+3840	; offset 0x0df9
	ld hl,65535	; byte addr 0x0f00, code offset 0x0dfc
	push hl	; offset 0x0dfd
	ld hl,65535	; byte addr 0x0efe, code offset 0x0e00
	push hl	; offset 0x0e01
	ld hl,65535	; byte addr 0x0efc, code offset 0x0e04
	push hl	; offset 0x0e05
	ld hl,65535	; byte addr 0x0efa, code offset 0x0e08
	push hl	; offset 0x0e09
	ld hl,65535	; byte addr 0x0ef8, code offset 0x0e0c
	push hl	; offset 0x0e0d
	ld hl,1792	; byte addr 0x0ef6, code offset 0x0e10
	push hl	; offset 0x0e11
	ld hl,0	; byte addr 0x0ef4, code offset 0x0e14
	push hl	; offset 0x0e15
	ld hl,0	; byte addr 0x0ef2, code offset 0x0e18
	push hl	; offset 0x0e19

	; src_data blit 254
	ld sp,screenStartAddr+4080	; offset 0x0e1c
	ld hl,0	; byte addr 0x0ff0, code offset 0x0e1f
	push hl	; offset 0x0e20
	ld hl,7	; byte addr 0x0fee, code offset 0x0e23
	push hl	; offset 0x0e24
	ld hl,0	; byte addr 0x0fec, code offset 0x0e27
	push hl	; offset 0x0e28
	ld hl,0	; byte addr 0x0fea, code offset 0x0e2b
	push hl	; offset 0x0e2c
	ld hl,33023	; byte addr 0x0fe8, code offset 0x0e2f
	push hl	; offset 0x0e30
	ld hl,65535	; byte addr 0x0fe6, code offset 0x0e33
	push hl	; offset 0x0e34
	ld hl,65535	; byte addr 0x0fe4, code offset 0x0e37
	push hl	; offset 0x0e38
	ld hl,65535	; byte addr 0x0fe2, code offset 0x0e3b
	push hl	; offset 0x0e3c

	; src_data blit 255
	ld sp,screenStartAddr+4096	; offset 0x0e3f
	ld hl,65535	; byte addr 0x1000, code offset 0x0e42
	push hl	; offset 0x0e43
	ld hl,65535	; byte addr 0x0ffe, code offset 0x0e46
	push hl	; offset 0x0e47
	ld hl,65535	; byte addr 0x0ffc, code offset 0x0e4a
	push hl	; offset 0x0e4b
	ld hl,65535	; byte addr 0x0ffa, code offset 0x0e4e
	push hl	; offset 0x0e4f
	ld hl,65535	; byte addr 0x0ff8, code offset 0x0e52
	push hl	; offset 0x0e53
	ld hl,1792	; byte addr 0x0ff6, code offset 0x0e56
	push hl	; offset 0x0e57
	ld hl,0	; byte addr 0x0ff4, code offset 0x0e5a
	push hl	; offset 0x0e5b
	ld hl,0	; byte addr 0x0ff2, code offset 0x0e5e
	push hl	; offset 0x0e5f

	; src_data blit 256
	ld sp,screenStartAddr+4112	; offset 0x0e62
	ld hl,0	; byte addr 0x1010, code offset 0x0e65
	push hl	; offset 0x0e66
	ld hl,7	; byte addr 0x100e, code offset 0x0e69
	push hl	; offset 0x0e6a
	ld hl,0	; byte addr 0x100c, code offset 0x0e6d
	push hl	; offset 0x0e6e
	ld hl,0	; byte addr 0x100a, code offset 0x0e71
	push hl	; offset 0x0e72
	ld hl,57599	; byte addr 0x1008, code offset 0x0e75
	push hl	; offset 0x0e76
	ld hl,65535	; byte addr 0x1006, code offset 0x0e79
	push hl	; offset 0x0e7a
	ld hl,65535	; byte addr 0x1004, code offset 0x0e7d
	push hl	; offset 0x0e7e
	ld hl,65535	; byte addr 0x1002, code offset 0x0e81
	push hl	; offset 0x0e82

	; src_data blit 257
	ld sp,screenStartAddr+4128	; offset 0x0e85
	ld hl,65535	; byte addr 0x1020, code offset 0x0e88
	push hl	; offset 0x0e89
	ld hl,65535	; byte addr 0x101e, code offset 0x0e8c
	push hl	; offset 0x0e8d
	ld hl,65535	; byte addr 0x101c, code offset 0x0e90
	push hl	; offset 0x0e91
	ld hl,65535	; byte addr 0x101a, code offset 0x0e94
	push hl	; offset 0x0e95
	ld hl,65535	; byte addr 0x1018, code offset 0x0e98
	push hl	; offset 0x0e99
	ld hl,1792	; byte addr 0x1016, code offset 0x0e9c
	push hl	; offset 0x0e9d
	ld hl,0	; byte addr 0x1014, code offset 0x0ea0
	push hl	; offset 0x0ea1
	ld hl,0	; byte addr 0x1012, code offset 0x0ea4
	push hl	; offset 0x0ea5

	; attr draw 1, code offset 0x0ea5
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,18552	; src 20
	ld hl,20808	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+32
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+32),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+32),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,27746	; src 24
	ld de,32373	; src 26
	ld hl,28279	; src 28
	ld sp,attrStartAddr+30+32
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,21605	; src 30
	ld (attrStartAddr+30+32),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 1, offset 0x0efe
	; Clock offset: -864


	; src_data blit 258
	ld sp,screenStartAddr+4368	; offset 0x0f01
	ld hl,2	; byte addr 0x1110, code offset 0x0f04
	push hl	; offset 0x0f05
	ld hl,15	; byte addr 0x110e, code offset 0x0f08
	push hl	; offset 0x0f09
	ld hl,0	; byte addr 0x110c, code offset 0x0f0c
	push hl	; offset 0x0f0d
	ld hl,0	; byte addr 0x110a, code offset 0x0f10
	push hl	; offset 0x0f11
	ld hl,255	; byte addr 0x1108, code offset 0x0f14
	push hl	; offset 0x0f15
	ld hl,65535	; byte addr 0x1106, code offset 0x0f18
	push hl	; offset 0x0f19
	ld hl,65535	; byte addr 0x1104, code offset 0x0f1c
	push hl	; offset 0x0f1d
	ld hl,65535	; byte addr 0x1102, code offset 0x0f20
	push hl	; offset 0x0f21

	; src_data blit 259
	ld sp,screenStartAddr+4384	; offset 0x0f24
	ld hl,65535	; byte addr 0x1120, code offset 0x0f27
	push hl	; offset 0x0f28
	ld hl,65535	; byte addr 0x111e, code offset 0x0f2b
	push hl	; offset 0x0f2c
	ld hl,65535	; byte addr 0x111c, code offset 0x0f2f
	push hl	; offset 0x0f30
	ld hl,65535	; byte addr 0x111a, code offset 0x0f33
	push hl	; offset 0x0f34
	ld hl,65535	; byte addr 0x1118, code offset 0x0f37
	push hl	; offset 0x0f38
	ld hl,3840	; byte addr 0x1116, code offset 0x0f3b
	push hl	; offset 0x0f3c
	ld hl,0	; byte addr 0x1114, code offset 0x0f3f
	push hl	; offset 0x0f40
	ld hl,0	; byte addr 0x1112, code offset 0x0f43
	push hl	; offset 0x0f44

	; src_data blit 260
	ld sp,screenStartAddr+4624	; offset 0x0f47
	ld hl,6	; byte addr 0x1210, code offset 0x0f4a
	push hl	; offset 0x0f4b
	ld hl,15	; byte addr 0x120e, code offset 0x0f4e
	push hl	; offset 0x0f4f
	ld hl,0	; byte addr 0x120c, code offset 0x0f52
	push hl	; offset 0x0f53
	ld hl,0	; byte addr 0x120a, code offset 0x0f56
	push hl	; offset 0x0f57
	ld hl,252	; byte addr 0x1208, code offset 0x0f5a
	push hl	; offset 0x0f5b
	ld hl,65535	; byte addr 0x1206, code offset 0x0f5e
	push hl	; offset 0x0f5f
	ld hl,65535	; byte addr 0x1204, code offset 0x0f62
	push hl	; offset 0x0f63
	ld hl,65535	; byte addr 0x1202, code offset 0x0f66
	push hl	; offset 0x0f67

	; src_data blit 261
	ld sp,screenStartAddr+4640	; offset 0x0f6a
	ld hl,65535	; byte addr 0x1220, code offset 0x0f6d
	push hl	; offset 0x0f6e
	ld hl,65535	; byte addr 0x121e, code offset 0x0f71
	push hl	; offset 0x0f72
	ld hl,65535	; byte addr 0x121c, code offset 0x0f75
	push hl	; offset 0x0f76
	ld hl,65535	; byte addr 0x121a, code offset 0x0f79
	push hl	; offset 0x0f7a
	ld hl,65535	; byte addr 0x1218, code offset 0x0f7d
	push hl	; offset 0x0f7e
	ld hl,3840	; byte addr 0x1216, code offset 0x0f81
	push hl	; offset 0x0f82
	ld hl,0	; byte addr 0x1214, code offset 0x0f85
	push hl	; offset 0x0f86
	ld hl,0	; byte addr 0x1212, code offset 0x0f89
	push hl	; offset 0x0f8a

	; src_data blit 262
	ld sp,screenStartAddr+4880	; offset 0x0f8d
	ld hl,6	; byte addr 0x1310, code offset 0x0f90
	push hl	; offset 0x0f91
	ld hl,30	; byte addr 0x130e, code offset 0x0f94
	push hl	; offset 0x0f95
	ld hl,0	; byte addr 0x130c, code offset 0x0f98
	push hl	; offset 0x0f99
	ld hl,0	; byte addr 0x130a, code offset 0x0f9c
	push hl	; offset 0x0f9d
	ld hl,248	; byte addr 0x1308, code offset 0x0fa0
	push hl	; offset 0x0fa1
	ld hl,65535	; byte addr 0x1306, code offset 0x0fa4
	push hl	; offset 0x0fa5
	ld hl,65535	; byte addr 0x1304, code offset 0x0fa8
	push hl	; offset 0x0fa9
	ld hl,65535	; byte addr 0x1302, code offset 0x0fac
	push hl	; offset 0x0fad

	; src_data blit 263
	ld sp,screenStartAddr+4896	; offset 0x0fb0
	ld hl,65535	; byte addr 0x1320, code offset 0x0fb3
	push hl	; offset 0x0fb4
	ld hl,65535	; byte addr 0x131e, code offset 0x0fb7
	push hl	; offset 0x0fb8
	ld hl,32766	; byte addr 0x131c, code offset 0x0fbb
	push hl	; offset 0x0fbc
	ld hl,65535	; byte addr 0x131a, code offset 0x0fbf
	push hl	; offset 0x0fc0
	ld hl,65535	; byte addr 0x1318, code offset 0x0fc3
	push hl	; offset 0x0fc4
	ld hl,3840	; byte addr 0x1316, code offset 0x0fc7
	push hl	; offset 0x0fc8
	ld hl,96	; byte addr 0x1314, code offset 0x0fcb
	push hl	; offset 0x0fcc
	ld hl,0	; byte addr 0x1312, code offset 0x0fcf
	push hl	; offset 0x0fd0

	; attr draw 2, code offset 0x0fd0
	ld sp,attr8and16vals+8
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,18552	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+64
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+64),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,20808	; src 24
	ld de,27746	; src 26
	ld hl,32373	; src 28
	ld sp,attrStartAddr+30+64
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,28279	; src 30
	ld (attrStartAddr+30+64),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 2, offset 0x1029
	; Clock offset: -864


	; src_data blit 264
	ld sp,screenStartAddr+5136	; offset 0x102c
	ld hl,14	; byte addr 0x1410, code offset 0x102f
	push hl	; offset 0x1030
	ld hl,30	; byte addr 0x140e, code offset 0x1033
	push hl	; offset 0x1034
	ld hl,0	; byte addr 0x140c, code offset 0x1037
	push hl	; offset 0x1038
	ld hl,0	; byte addr 0x140a, code offset 0x103b
	push hl	; offset 0x103c
	ld hl,252	; byte addr 0x1408, code offset 0x103f
	push hl	; offset 0x1040
	ld hl,65535	; byte addr 0x1406, code offset 0x1043
	push hl	; offset 0x1044
	ld hl,65535	; byte addr 0x1404, code offset 0x1047
	push hl	; offset 0x1048
	ld hl,65535	; byte addr 0x1402, code offset 0x104b
	push hl	; offset 0x104c

	; src_data blit 265
	ld sp,screenStartAddr+5152	; offset 0x104f
	ld hl,65535	; byte addr 0x1420, code offset 0x1052
	push hl	; offset 0x1053
	ld hl,65535	; byte addr 0x141e, code offset 0x1056
	push hl	; offset 0x1057
	ld hl,65532	; byte addr 0x141c, code offset 0x105a
	push hl	; offset 0x105b
	ld hl,65535	; byte addr 0x141a, code offset 0x105e
	push hl	; offset 0x105f
	ld hl,65535	; byte addr 0x1418, code offset 0x1062
	push hl	; offset 0x1063
	ld hl,3840	; byte addr 0x1416, code offset 0x1066
	push hl	; offset 0x1067
	ld hl,96	; byte addr 0x1414, code offset 0x106a
	push hl	; offset 0x106b
	ld hl,0	; byte addr 0x1412, code offset 0x106e
	push hl	; offset 0x106f

	; src_data blit 266
	ld sp,screenStartAddr+5392	; offset 0x1072
	ld hl,12	; byte addr 0x1510, code offset 0x1075
	push hl	; offset 0x1076
	ld hl,62	; byte addr 0x150e, code offset 0x1079
	push hl	; offset 0x107a
	ld hl,0	; byte addr 0x150c, code offset 0x107d
	push hl	; offset 0x107e
	ld hl,0	; byte addr 0x150a, code offset 0x1081
	push hl	; offset 0x1082
	ld hl,254	; byte addr 0x1508, code offset 0x1085
	push hl	; offset 0x1086
	ld hl,65535	; byte addr 0x1506, code offset 0x1089
	push hl	; offset 0x108a
	ld hl,65535	; byte addr 0x1504, code offset 0x108d
	push hl	; offset 0x108e
	ld hl,65535	; byte addr 0x1502, code offset 0x1091
	push hl	; offset 0x1092

	; src_data blit 267
	ld sp,screenStartAddr+5408	; offset 0x1095
	ld hl,65535	; byte addr 0x1520, code offset 0x1098
	push hl	; offset 0x1099
	ld hl,65535	; byte addr 0x151e, code offset 0x109c
	push hl	; offset 0x109d
	ld hl,65529	; byte addr 0x151c, code offset 0x10a0
	push hl	; offset 0x10a1
	ld hl,65535	; byte addr 0x151a, code offset 0x10a4
	push hl	; offset 0x10a5
	ld hl,65535	; byte addr 0x1518, code offset 0x10a8
	push hl	; offset 0x10a9
	ld hl,3840	; byte addr 0x1516, code offset 0x10ac
	push hl	; offset 0x10ad
	ld hl,96	; byte addr 0x1514, code offset 0x10b0
	push hl	; offset 0x10b1
	ld hl,0	; byte addr 0x1512, code offset 0x10b4
	push hl	; offset 0x10b5

	; src_data blit 268
	ld sp,screenStartAddr+5648	; offset 0x10b8
	ld hl,28	; byte addr 0x1610, code offset 0x10bb
	push hl	; offset 0x10bc
	ld hl,62	; byte addr 0x160e, code offset 0x10bf
	push hl	; offset 0x10c0
	ld hl,0	; byte addr 0x160c, code offset 0x10c3
	push hl	; offset 0x10c4
	ld hl,0	; byte addr 0x160a, code offset 0x10c7
	push hl	; offset 0x10c8
	ld hl,33023	; byte addr 0x1608, code offset 0x10cb
	push hl	; offset 0x10cc
	ld hl,65535	; byte addr 0x1606, code offset 0x10cf
	push hl	; offset 0x10d0
	ld hl,65535	; byte addr 0x1604, code offset 0x10d3
	push hl	; offset 0x10d4
	ld hl,65535	; byte addr 0x1602, code offset 0x10d7
	push hl	; offset 0x10d8

	; src_data blit 269
	ld sp,screenStartAddr+5664	; offset 0x10db
	ld hl,65535	; byte addr 0x1620, code offset 0x10de
	push hl	; offset 0x10df
	ld hl,65535	; byte addr 0x161e, code offset 0x10e2
	push hl	; offset 0x10e3
	ld hl,65507	; byte addr 0x161c, code offset 0x10e6
	push hl	; offset 0x10e7
	ld hl,65535	; byte addr 0x161a, code offset 0x10ea
	push hl	; offset 0x10eb
	ld hl,65535	; byte addr 0x1618, code offset 0x10ee
	push hl	; offset 0x10ef
	ld hl,7936	; byte addr 0x1616, code offset 0x10f2
	push hl	; offset 0x10f3
	ld hl,96	; byte addr 0x1614, code offset 0x10f6
	push hl	; offset 0x10f7
	ld hl,0	; byte addr 0x1612, code offset 0x10fa
	push hl	; offset 0x10fb

	; attr draw 3, code offset 0x10fb
	ld sp,attr8and16vals+12
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+96
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+96),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,18552	; src 24
	ld de,20808	; src 26
	ld hl,27746	; src 28
	ld sp,attrStartAddr+30+96
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,32373	; src 30
	ld (attrStartAddr+30+96),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 3, offset 0x1154
	; Clock offset: -864


	; src_data blit 270
	ld sp,screenStartAddr+5904	; offset 0x1157
	ld hl,28	; byte addr 0x1710, code offset 0x115a
	push hl	; offset 0x115b
	ld hl,124	; byte addr 0x170e, code offset 0x115e
	push hl	; offset 0x115f
	ld hl,0	; byte addr 0x170c, code offset 0x1162
	push hl	; offset 0x1163
	ld hl,0	; byte addr 0x170a, code offset 0x1166
	push hl	; offset 0x1167
	ld hl,49407	; byte addr 0x1708, code offset 0x116a
	push hl	; offset 0x116b
	ld hl,65535	; byte addr 0x1706, code offset 0x116e
	push hl	; offset 0x116f
	ld hl,65535	; byte addr 0x1704, code offset 0x1172
	push hl	; offset 0x1173
	ld hl,65535	; byte addr 0x1702, code offset 0x1176
	push hl	; offset 0x1177

	; src_data blit 271
	ld sp,screenStartAddr+5920	; offset 0x117a
	ld hl,65535	; byte addr 0x1720, code offset 0x117d
	push hl	; offset 0x117e
	ld hl,65535	; byte addr 0x171e, code offset 0x1181
	push hl	; offset 0x1182
	ld hl,65475	; byte addr 0x171c, code offset 0x1185
	push hl	; offset 0x1186
	ld hl,65535	; byte addr 0x171a, code offset 0x1189
	push hl	; offset 0x118a
	ld hl,65535	; byte addr 0x1718, code offset 0x118d
	push hl	; offset 0x118e
	ld hl,7936	; byte addr 0x1716, code offset 0x1191
	push hl	; offset 0x1192
	ld hl,224	; byte addr 0x1714, code offset 0x1195
	push hl	; offset 0x1196
	ld hl,0	; byte addr 0x1712, code offset 0x1199
	push hl	; offset 0x119a

	; src_data blit 272
	ld sp,screenStartAddr+4144	; offset 0x119d
	ld hl,56	; byte addr 0x1030, code offset 0x11a0
	push hl	; offset 0x11a1
	ld hl,120	; byte addr 0x102e, code offset 0x11a4
	push hl	; offset 0x11a5
	ld hl,0	; byte addr 0x102c, code offset 0x11a8
	push hl	; offset 0x11a9
	ld hl,0	; byte addr 0x102a, code offset 0x11ac
	push hl	; offset 0x11ad
	ld hl,61695	; byte addr 0x1028, code offset 0x11b0
	push hl	; offset 0x11b1
	ld hl,65535	; byte addr 0x1026, code offset 0x11b4
	push hl	; offset 0x11b5
	ld hl,65535	; byte addr 0x1024, code offset 0x11b8
	push hl	; offset 0x11b9
	ld hl,65535	; byte addr 0x1022, code offset 0x11bc
	push hl	; offset 0x11bd

	; src_data blit 273
	ld sp,screenStartAddr+4160	; offset 0x11c0
	ld hl,65535	; byte addr 0x1040, code offset 0x11c3
	push hl	; offset 0x11c4
	ld hl,65535	; byte addr 0x103e, code offset 0x11c7
	push hl	; offset 0x11c8
	ld hl,65415	; byte addr 0x103c, code offset 0x11cb
	push hl	; offset 0x11cc
	ld hl,65535	; byte addr 0x103a, code offset 0x11cf
	push hl	; offset 0x11d0
	ld hl,65535	; byte addr 0x1038, code offset 0x11d3
	push hl	; offset 0x11d4
	ld hl,7936	; byte addr 0x1036, code offset 0x11d7
	push hl	; offset 0x11d8
	ld hl,240	; byte addr 0x1034, code offset 0x11db
	push hl	; offset 0x11dc
	ld hl,0	; byte addr 0x1032, code offset 0x11df
	push hl	; offset 0x11e0

	; src_data blit 274
	ld sp,screenStartAddr+4400	; offset 0x11e3
	ld hl,56	; byte addr 0x1130, code offset 0x11e6
	push hl	; offset 0x11e7
	ld hl,248	; byte addr 0x112e, code offset 0x11ea
	push hl	; offset 0x11eb
	ld hl,0	; byte addr 0x112c, code offset 0x11ee
	push hl	; offset 0x11ef
	ld hl,0	; byte addr 0x112a, code offset 0x11f2
	push hl	; offset 0x11f3
	ld hl,63743	; byte addr 0x1128, code offset 0x11f6
	push hl	; offset 0x11f7
	ld hl,65535	; byte addr 0x1126, code offset 0x11fa
	push hl	; offset 0x11fb
	ld hl,65535	; byte addr 0x1124, code offset 0x11fe
	push hl	; offset 0x11ff
	ld hl,65535	; byte addr 0x1122, code offset 0x1202
	push hl	; offset 0x1203

	; src_data blit 275
	ld sp,screenStartAddr+4416	; offset 0x1206
	ld hl,65535	; byte addr 0x1140, code offset 0x1209
	push hl	; offset 0x120a
	ld hl,65535	; byte addr 0x113e, code offset 0x120d
	push hl	; offset 0x120e
	ld hl,65295	; byte addr 0x113c, code offset 0x1211
	push hl	; offset 0x1212
	ld hl,65535	; byte addr 0x113a, code offset 0x1215
	push hl	; offset 0x1216
	ld hl,65535	; byte addr 0x1138, code offset 0x1219
	push hl	; offset 0x121a
	ld hl,7936	; byte addr 0x1136, code offset 0x121d
	push hl	; offset 0x121e
	ld hl,240	; byte addr 0x1134, code offset 0x1221
	push hl	; offset 0x1222
	ld hl,0	; byte addr 0x1132, code offset 0x1225
	push hl	; offset 0x1226

	; attr draw 4, code offset 0x1226
	ld sp,attr8and16vals+16
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+128
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+128),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,18552	; src 26
	ld hl,20808	; src 28
	ld sp,attrStartAddr+30+128
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,27746	; src 30
	ld (attrStartAddr+30+128),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 4, offset 0x127f
	; Clock offset: -864


	; src_data blit 276
	ld sp,screenStartAddr+4656	; offset 0x1282
	ld hl,112	; byte addr 0x1230, code offset 0x1285
	push hl	; offset 0x1286
	ld hl,248	; byte addr 0x122e, code offset 0x1289
	push hl	; offset 0x128a
	ld hl,256	; byte addr 0x122c, code offset 0x128d
	push hl	; offset 0x128e
	ld hl,0	; byte addr 0x122a, code offset 0x1291
	push hl	; offset 0x1292
	ld hl,65279	; byte addr 0x1228, code offset 0x1295
	push hl	; offset 0x1296
	ld hl,65535	; byte addr 0x1226, code offset 0x1299
	push hl	; offset 0x129a
	ld hl,65535	; byte addr 0x1224, code offset 0x129d
	push hl	; offset 0x129e
	ld hl,65535	; byte addr 0x1222, code offset 0x12a1
	push hl	; offset 0x12a2

	; src_data blit 277
	ld sp,screenStartAddr+4672	; offset 0x12a5
	ld hl,65535	; byte addr 0x1240, code offset 0x12a8
	push hl	; offset 0x12a9
	ld hl,65535	; byte addr 0x123e, code offset 0x12ac
	push hl	; offset 0x12ad
	ld hl,65311	; byte addr 0x123c, code offset 0x12b0
	push hl	; offset 0x12b1
	ld hl,64767	; byte addr 0x123a, code offset 0x12b4
	push hl	; offset 0x12b5
	ld hl,65535	; byte addr 0x1238, code offset 0x12b8
	push hl	; offset 0x12b9
	ld hl,7936	; byte addr 0x1236, code offset 0x12bc
	push hl	; offset 0x12bd
	ld hl,240	; byte addr 0x1234, code offset 0x12c0
	push hl	; offset 0x12c1
	ld hl,0	; byte addr 0x1232, code offset 0x12c4
	push hl	; offset 0x12c5

	; src_data blit 278
	ld sp,screenStartAddr+4912	; offset 0x12c8
	ld hl,240	; byte addr 0x1330, code offset 0x12cb
	push hl	; offset 0x12cc
	ld hl,240	; byte addr 0x132e, code offset 0x12cf
	push hl	; offset 0x12d0
	ld hl,256	; byte addr 0x132c, code offset 0x12d3
	push hl	; offset 0x12d4
	ld hl,0	; byte addr 0x132a, code offset 0x12d7
	push hl	; offset 0x12d8
	ld hl,65535	; byte addr 0x1328, code offset 0x12db
	push hl	; offset 0x12dc
	ld hl,65529	; byte addr 0x1326, code offset 0x12df
	push hl	; offset 0x12e0
	ld hl,65535	; byte addr 0x1324, code offset 0x12e3
	push hl	; offset 0x12e4
	ld hl,65535	; byte addr 0x1322, code offset 0x12e7
	push hl	; offset 0x12e8

	; src_data blit 279
	ld sp,screenStartAddr+4928	; offset 0x12eb
	ld hl,65535	; byte addr 0x1340, code offset 0x12ee
	push hl	; offset 0x12ef
	ld hl,65535	; byte addr 0x133e, code offset 0x12f2
	push hl	; offset 0x12f3
	ld hl,65311	; byte addr 0x133c, code offset 0x12f6
	push hl	; offset 0x12f7
	ld hl,63743	; byte addr 0x133a, code offset 0x12fa
	push hl	; offset 0x12fb
	ld hl,65535	; byte addr 0x1338, code offset 0x12fe
	push hl	; offset 0x12ff
	ld hl,7936	; byte addr 0x1336, code offset 0x1302
	push hl	; offset 0x1303
	ld hl,240	; byte addr 0x1334, code offset 0x1306
	push hl	; offset 0x1307
	ld hl,256	; byte addr 0x1332, code offset 0x130a
	push hl	; offset 0x130b

	; src_data blit 280
	ld sp,screenStartAddr+5168	; offset 0x130e
	ld hl,33023	; byte addr 0x1430, code offset 0x1311
	push hl	; offset 0x1312
	ld hl,224	; byte addr 0x142e, code offset 0x1315
	push hl	; offset 0x1316
	ld hl,768	; byte addr 0x142c, code offset 0x1319
	push hl	; offset 0x131a
	ld hl,0	; byte addr 0x142a, code offset 0x131d
	push hl	; offset 0x131e
	ld hl,64767	; byte addr 0x1428, code offset 0x1321
	push hl	; offset 0x1322
	ld hl,65532	; byte addr 0x1426, code offset 0x1325
	push hl	; offset 0x1326
	ld hl,65535	; byte addr 0x1424, code offset 0x1329
	push hl	; offset 0x132a
	ld hl,65535	; byte addr 0x1422, code offset 0x132d
	push hl	; offset 0x132e

	; src_data blit 281
	ld sp,screenStartAddr+5184	; offset 0x1331
	ld hl,65535	; byte addr 0x1440, code offset 0x1334
	push hl	; offset 0x1335
	ld hl,65535	; byte addr 0x143e, code offset 0x1338
	push hl	; offset 0x1339
	ld hl,65343	; byte addr 0x143c, code offset 0x133c
	push hl	; offset 0x133d
	ld hl,61695	; byte addr 0x143a, code offset 0x1340
	push hl	; offset 0x1341
	ld hl,65535	; byte addr 0x1438, code offset 0x1344
	push hl	; offset 0x1345
	ld hl,7936	; byte addr 0x1436, code offset 0x1348
	push hl	; offset 0x1349
	ld hl,240	; byte addr 0x1434, code offset 0x134c
	push hl	; offset 0x134d
	ld hl,256	; byte addr 0x1432, code offset 0x1350
	push hl	; offset 0x1351

	; attr draw 5, code offset 0x1351
	ld sp,attr8and16vals+20
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+160
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+160),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+160
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,20808	; src 30
	ld (attrStartAddr+30+160),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 5, offset 0x13aa
	; Clock offset: -864


	; src_data blit 282
	ld sp,screenStartAddr+5424	; offset 0x13ad
	ld hl,33023	; byte addr 0x1530, code offset 0x13b0
	push hl	; offset 0x13b1
	ld hl,224	; byte addr 0x152e, code offset 0x13b4
	push hl	; offset 0x13b5
	ld hl,1792	; byte addr 0x152c, code offset 0x13b8
	push hl	; offset 0x13b9
	ld hl,0	; byte addr 0x152a, code offset 0x13bc
	push hl	; offset 0x13bd
	ld hl,63743	; byte addr 0x1528, code offset 0x13c0
	push hl	; offset 0x13c1
	ld hl,32766	; byte addr 0x1526, code offset 0x13c4
	push hl	; offset 0x13c5
	ld hl,65535	; byte addr 0x1524, code offset 0x13c8
	push hl	; offset 0x13c9
	ld hl,65535	; byte addr 0x1522, code offset 0x13cc
	push hl	; offset 0x13cd

	; src_data blit 283
	ld sp,screenStartAddr+5440	; offset 0x13d0
	ld hl,65535	; byte addr 0x1540, code offset 0x13d3
	push hl	; offset 0x13d4
	ld hl,65535	; byte addr 0x153e, code offset 0x13d7
	push hl	; offset 0x13d8
	ld hl,65407	; byte addr 0x153c, code offset 0x13db
	push hl	; offset 0x13dc
	ld hl,57599	; byte addr 0x153a, code offset 0x13df
	push hl	; offset 0x13e0
	ld hl,65535	; byte addr 0x1538, code offset 0x13e3
	push hl	; offset 0x13e4
	ld hl,7936	; byte addr 0x1536, code offset 0x13e7
	push hl	; offset 0x13e8
	ld hl,248	; byte addr 0x1534, code offset 0x13eb
	push hl	; offset 0x13ec
	ld hl,256	; byte addr 0x1532, code offset 0x13ef
	push hl	; offset 0x13f0

	; src_data blit 284
	ld sp,screenStartAddr+5680	; offset 0x13f3
	ld hl,32783	; byte addr 0x1630, code offset 0x13f6
	push hl	; offset 0x13f7
	ld hl,192	; byte addr 0x162e, code offset 0x13fa
	push hl	; offset 0x13fb
	ld hl,3840	; byte addr 0x162c, code offset 0x13fe
	push hl	; offset 0x13ff
	ld hl,0	; byte addr 0x162a, code offset 0x1402
	push hl	; offset 0x1403
	ld hl,57599	; byte addr 0x1628, code offset 0x1406
	push hl	; offset 0x1407
	ld hl,8191	; byte addr 0x1626, code offset 0x140a
	push hl	; offset 0x140b
	ld hl,65535	; byte addr 0x1624, code offset 0x140e
	push hl	; offset 0x140f
	ld hl,65535	; byte addr 0x1622, code offset 0x1412
	push hl	; offset 0x1413

	; src_data blit 285
	ld sp,screenStartAddr+5696	; offset 0x1416
	ld hl,65535	; byte addr 0x1640, code offset 0x1419
	push hl	; offset 0x141a
	ld hl,65535	; byte addr 0x163e, code offset 0x141d
	push hl	; offset 0x141e
	ld hl,65407	; byte addr 0x163c, code offset 0x1421
	push hl	; offset 0x1422
	ld hl,33023	; byte addr 0x163a, code offset 0x1425
	push hl	; offset 0x1426
	ld hl,65535	; byte addr 0x1638, code offset 0x1429
	push hl	; offset 0x142a
	ld hl,7936	; byte addr 0x1636, code offset 0x142d
	push hl	; offset 0x142e
	ld hl,248	; byte addr 0x1634, code offset 0x1431
	push hl	; offset 0x1432
	ld hl,256	; byte addr 0x1632, code offset 0x1435
	push hl	; offset 0x1436

	; src_data blit 286
	ld sp,screenStartAddr+5936	; offset 0x1439
	ld hl,15	; byte addr 0x1730, code offset 0x143c
	push hl	; offset 0x143d
	ld hl,128	; byte addr 0x172e, code offset 0x1440
	push hl	; offset 0x1441
	ld hl,3840	; byte addr 0x172c, code offset 0x1444
	push hl	; offset 0x1445
	ld hl,0	; byte addr 0x172a, code offset 0x1448
	push hl	; offset 0x1449
	ld hl,57599	; byte addr 0x1728, code offset 0x144c
	push hl	; offset 0x144d
	ld hl,4095	; byte addr 0x1726, code offset 0x1450
	push hl	; offset 0x1451
	ld hl,65535	; byte addr 0x1724, code offset 0x1454
	push hl	; offset 0x1455
	ld hl,65535	; byte addr 0x1722, code offset 0x1458
	push hl	; offset 0x1459

	; src_data blit 287
	ld sp,screenStartAddr+5952	; offset 0x145c
	ld hl,65535	; byte addr 0x1740, code offset 0x145f
	push hl	; offset 0x1460
	ld hl,65535	; byte addr 0x173e, code offset 0x1463
	push hl	; offset 0x1464
	ld hl,65535	; byte addr 0x173c, code offset 0x1467
	push hl	; offset 0x1468
	ld hl,255	; byte addr 0x173a, code offset 0x146b
	push hl	; offset 0x146c
	ld hl,65535	; byte addr 0x1738, code offset 0x146f
	push hl	; offset 0x1470
	ld hl,7936	; byte addr 0x1736, code offset 0x1473
	push hl	; offset 0x1474
	ld hl,248	; byte addr 0x1734, code offset 0x1477
	push hl	; offset 0x1478
	ld hl,256	; byte addr 0x1732, code offset 0x147b
	push hl	; offset 0x147c

	; attr draw 6, code offset 0x147c
	ld sp,attr8and16vals+24
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+192
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+192),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+192
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,18552	; src 30
	ld (attrStartAddr+30+192),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 6, offset 0x14d5
	; Clock offset: -864


	; src_data blit 288
	ld sp,screenStartAddr+4176	; offset 0x14d8
	ld hl,31	; byte addr 0x1050, code offset 0x14db
	push hl	; offset 0x14dc
	ld hl,128	; byte addr 0x104e, code offset 0x14df
	push hl	; offset 0x14e0
	ld hl,16128	; byte addr 0x104c, code offset 0x14e3
	push hl	; offset 0x14e4
	ld hl,0	; byte addr 0x104a, code offset 0x14e7
	push hl	; offset 0x14e8
	ld hl,61695	; byte addr 0x1048, code offset 0x14eb
	push hl	; offset 0x14ec
	ld hl,34815	; byte addr 0x1046, code offset 0x14ef
	push hl	; offset 0x14f0
	ld hl,65535	; byte addr 0x1044, code offset 0x14f3
	push hl	; offset 0x14f4
	ld hl,65535	; byte addr 0x1042, code offset 0x14f7
	push hl	; offset 0x14f8

	; src_data blit 289
	ld sp,screenStartAddr+4192	; offset 0x14fb
	ld hl,65535	; byte addr 0x1060, code offset 0x14fe
	push hl	; offset 0x14ff
	ld hl,65535	; byte addr 0x105e, code offset 0x1502
	push hl	; offset 0x1503
	ld hl,65535	; byte addr 0x105c, code offset 0x1506
	push hl	; offset 0x1507
	ld hl,511	; byte addr 0x105a, code offset 0x150a
	push hl	; offset 0x150b
	ld hl,65535	; byte addr 0x1058, code offset 0x150e
	push hl	; offset 0x150f
	ld hl,7936	; byte addr 0x1056, code offset 0x1512
	push hl	; offset 0x1513
	ld hl,4344	; byte addr 0x1054, code offset 0x1516
	push hl	; offset 0x1517
	ld hl,256	; byte addr 0x1052, code offset 0x151a
	push hl	; offset 0x151b

	; src_data blit 290
	ld sp,screenStartAddr+4432	; offset 0x151e
	ld hl,62	; byte addr 0x1150, code offset 0x1521
	push hl	; offset 0x1522
	ld hl,0	; byte addr 0x114e, code offset 0x1525
	push hl	; offset 0x1526
	ld hl,32256	; byte addr 0x114c, code offset 0x1529
	push hl	; offset 0x152a
	ld hl,0	; byte addr 0x114a, code offset 0x152d
	push hl	; offset 0x152e
	ld hl,61695	; byte addr 0x1148, code offset 0x1531
	push hl	; offset 0x1532
	ld hl,50175	; byte addr 0x1146, code offset 0x1535
	push hl	; offset 0x1536
	ld hl,65535	; byte addr 0x1144, code offset 0x1539
	push hl	; offset 0x153a
	ld hl,65535	; byte addr 0x1142, code offset 0x153d
	push hl	; offset 0x153e

	; src_data blit 291
	ld sp,screenStartAddr+4448	; offset 0x1541
	ld hl,65535	; byte addr 0x1160, code offset 0x1544
	push hl	; offset 0x1545
	ld hl,65535	; byte addr 0x115e, code offset 0x1548
	push hl	; offset 0x1549
	ld hl,65535	; byte addr 0x115c, code offset 0x154c
	push hl	; offset 0x154d
	ld hl,1020	; byte addr 0x115a, code offset 0x1550
	push hl	; offset 0x1551
	ld hl,65535	; byte addr 0x1158, code offset 0x1554
	push hl	; offset 0x1555
	ld hl,3840	; byte addr 0x1156, code offset 0x1558
	push hl	; offset 0x1559
	ld hl,12536	; byte addr 0x1154, code offset 0x155c
	push hl	; offset 0x155d
	ld hl,256	; byte addr 0x1152, code offset 0x1560
	push hl	; offset 0x1561

	; src_data blit 292
	ld sp,screenStartAddr+4688	; offset 0x1564
	ld hl,62	; byte addr 0x1250, code offset 0x1567
	push hl	; offset 0x1568
	ld hl,0	; byte addr 0x124e, code offset 0x156b
	push hl	; offset 0x156c
	ld hl,65024	; byte addr 0x124c, code offset 0x156f
	push hl	; offset 0x1570
	ld hl,0	; byte addr 0x124a, code offset 0x1573
	push hl	; offset 0x1574
	ld hl,63743	; byte addr 0x1248, code offset 0x1577
	push hl	; offset 0x1578
	ld hl,49407	; byte addr 0x1246, code offset 0x157b
	push hl	; offset 0x157c
	ld hl,65535	; byte addr 0x1244, code offset 0x157f
	push hl	; offset 0x1580
	ld hl,65535	; byte addr 0x1242, code offset 0x1583
	push hl	; offset 0x1584

	; src_data blit 293
	ld sp,screenStartAddr+4704	; offset 0x1587
	ld hl,65535	; byte addr 0x1260, code offset 0x158a
	push hl	; offset 0x158b
	ld hl,65535	; byte addr 0x125e, code offset 0x158e
	push hl	; offset 0x158f
	ld hl,65535	; byte addr 0x125c, code offset 0x1592
	push hl	; offset 0x1593
	ld hl,1016	; byte addr 0x125a, code offset 0x1596
	push hl	; offset 0x1597
	ld hl,65535	; byte addr 0x1258, code offset 0x159a
	push hl	; offset 0x159b
	ld hl,3840	; byte addr 0x1256, code offset 0x159e
	push hl	; offset 0x159f
	ld hl,28924	; byte addr 0x1254, code offset 0x15a2
	push hl	; offset 0x15a3
	ld hl,256	; byte addr 0x1252, code offset 0x15a6
	push hl	; offset 0x15a7

	; attr draw 7, code offset 0x15a7
	ld sp,attr8and16vals+28
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+224
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+224),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+224
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+224),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 7, offset 0x1600
	; Clock offset: -864


	; src_data blit 294
	ld sp,screenStartAddr+4944	; offset 0x1603
	ld hl,126	; byte addr 0x1350, code offset 0x1606
	push hl	; offset 0x1607
	ld hl,0	; byte addr 0x134e, code offset 0x160a
	push hl	; offset 0x160b
	ld hl,65283	; byte addr 0x134c, code offset 0x160e
	push hl	; offset 0x160f
	ld hl,0	; byte addr 0x134a, code offset 0x1612
	push hl	; offset 0x1613
	ld hl,63615	; byte addr 0x1348, code offset 0x1616
	push hl	; offset 0x1617
	ld hl,57599	; byte addr 0x1346, code offset 0x161a
	push hl	; offset 0x161b
	ld hl,65535	; byte addr 0x1344, code offset 0x161e
	push hl	; offset 0x161f
	ld hl,65535	; byte addr 0x1342, code offset 0x1622
	push hl	; offset 0x1623

	; src_data blit 295
	ld sp,screenStartAddr+4960	; offset 0x1626
	ld hl,65535	; byte addr 0x1360, code offset 0x1629
	push hl	; offset 0x162a
	ld hl,65535	; byte addr 0x135e, code offset 0x162d
	push hl	; offset 0x162e
	ld hl,65535	; byte addr 0x135c, code offset 0x1631
	push hl	; offset 0x1632
	ld hl,2032	; byte addr 0x135a, code offset 0x1635
	push hl	; offset 0x1636
	ld hl,65535	; byte addr 0x1358, code offset 0x1639
	push hl	; offset 0x163a
	ld hl,3840	; byte addr 0x1356, code offset 0x163d
	push hl	; offset 0x163e
	ld hl,61692	; byte addr 0x1354, code offset 0x1641
	push hl	; offset 0x1642
	ld hl,256	; byte addr 0x1352, code offset 0x1645
	push hl	; offset 0x1646

	; src_data blit 296
	ld sp,screenStartAddr+5200	; offset 0x1649
	ld hl,57407	; byte addr 0x1450, code offset 0x164c
	push hl	; offset 0x164d
	ld hl,128	; byte addr 0x144e, code offset 0x1650
	push hl	; offset 0x1651
	ld hl,65287	; byte addr 0x144c, code offset 0x1654
	push hl	; offset 0x1655
	ld hl,0	; byte addr 0x144a, code offset 0x1658
	push hl	; offset 0x1659
	ld hl,64575	; byte addr 0x1448, code offset 0x165c
	push hl	; offset 0x165d
	ld hl,61695	; byte addr 0x1446, code offset 0x1660
	push hl	; offset 0x1661
	ld hl,65535	; byte addr 0x1444, code offset 0x1664
	push hl	; offset 0x1665
	ld hl,65535	; byte addr 0x1442, code offset 0x1668
	push hl	; offset 0x1669

	; src_data blit 297
	ld sp,screenStartAddr+5216	; offset 0x166c
	ld hl,65535	; byte addr 0x1460, code offset 0x166f
	push hl	; offset 0x1670
	ld hl,65535	; byte addr 0x145e, code offset 0x1673
	push hl	; offset 0x1674
	ld hl,65535	; byte addr 0x145c, code offset 0x1677
	push hl	; offset 0x1678
	ld hl,4064	; byte addr 0x145a, code offset 0x167b
	push hl	; offset 0x167c
	ld hl,65535	; byte addr 0x1458, code offset 0x167f
	push hl	; offset 0x1680
	ld hl,3840	; byte addr 0x1456, code offset 0x1683
	push hl	; offset 0x1684
	ld hl,61692	; byte addr 0x1454, code offset 0x1687
	push hl	; offset 0x1688
	ld hl,256	; byte addr 0x1452, code offset 0x168b
	push hl	; offset 0x168c

	; src_data blit 298
	ld sp,screenStartAddr+5456	; offset 0x168f
	ld hl,61471	; byte addr 0x1550, code offset 0x1692
	push hl	; offset 0x1693
	ld hl,128	; byte addr 0x154e, code offset 0x1696
	push hl	; offset 0x1697
	ld hl,65295	; byte addr 0x154c, code offset 0x169a
	push hl	; offset 0x169b
	ld hl,0	; byte addr 0x154a, code offset 0x169e
	push hl	; offset 0x169f
	ld hl,64527	; byte addr 0x1548, code offset 0x16a2
	push hl	; offset 0x16a3
	ld hl,61695	; byte addr 0x1546, code offset 0x16a6
	push hl	; offset 0x16a7
	ld hl,65535	; byte addr 0x1544, code offset 0x16aa
	push hl	; offset 0x16ab
	ld hl,65535	; byte addr 0x1542, code offset 0x16ae
	push hl	; offset 0x16af

	; src_data blit 299
	ld sp,screenStartAddr+5472	; offset 0x16b2
	ld hl,65535	; byte addr 0x1560, code offset 0x16b5
	push hl	; offset 0x16b6
	ld hl,65535	; byte addr 0x155e, code offset 0x16b9
	push hl	; offset 0x16ba
	ld hl,65535	; byte addr 0x155c, code offset 0x16bd
	push hl	; offset 0x16be
	ld hl,8064	; byte addr 0x155a, code offset 0x16c1
	push hl	; offset 0x16c2
	ld hl,65535	; byte addr 0x1558, code offset 0x16c5
	push hl	; offset 0x16c6
	ld hl,3840	; byte addr 0x1556, code offset 0x16c9
	push hl	; offset 0x16ca
	ld hl,63740	; byte addr 0x1554, code offset 0x16cd
	push hl	; offset 0x16ce
	ld hl,256	; byte addr 0x1552, code offset 0x16d1
	push hl	; offset 0x16d2

	; attr draw 8, code offset 0x16d2
	ld sp,attr8and16vals+32
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+256
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+256),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+256
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+256),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 8, offset 0x172b
	; Clock offset: -864


	; src_data blit 300
	ld sp,screenStartAddr+5712	; offset 0x172e
	ld hl,61471	; byte addr 0x1650, code offset 0x1731
	push hl	; offset 0x1732
	ld hl,192	; byte addr 0x164e, code offset 0x1735
	push hl	; offset 0x1736
	ld hl,65311	; byte addr 0x164c, code offset 0x1739
	push hl	; offset 0x173a
	ld hl,0	; byte addr 0x164a, code offset 0x173d
	push hl	; offset 0x173e
	ld hl,64519	; byte addr 0x1648, code offset 0x1741
	push hl	; offset 0x1742
	ld hl,63743	; byte addr 0x1646, code offset 0x1745
	push hl	; offset 0x1746
	ld hl,65535	; byte addr 0x1644, code offset 0x1749
	push hl	; offset 0x174a
	ld hl,65535	; byte addr 0x1642, code offset 0x174d
	push hl	; offset 0x174e

	; src_data blit 301
	ld sp,screenStartAddr+5728	; offset 0x1751
	ld hl,65535	; byte addr 0x1660, code offset 0x1754
	push hl	; offset 0x1755
	ld hl,65535	; byte addr 0x165e, code offset 0x1758
	push hl	; offset 0x1759
	ld hl,65535	; byte addr 0x165c, code offset 0x175c
	push hl	; offset 0x175d
	ld hl,8064	; byte addr 0x165a, code offset 0x1760
	push hl	; offset 0x1761
	ld hl,65535	; byte addr 0x1658, code offset 0x1764
	push hl	; offset 0x1765
	ld hl,3840	; byte addr 0x1656, code offset 0x1768
	push hl	; offset 0x1769
	ld hl,63743	; byte addr 0x1654, code offset 0x176c
	push hl	; offset 0x176d
	ld hl,256	; byte addr 0x1652, code offset 0x1770
	push hl	; offset 0x1771

	; src_data blit 302
	ld sp,screenStartAddr+5968	; offset 0x1774
	ld hl,61455	; byte addr 0x1750, code offset 0x1777
	push hl	; offset 0x1778
	ld hl,224	; byte addr 0x174e, code offset 0x177b
	push hl	; offset 0x177c
	ld hl,65343	; byte addr 0x174c, code offset 0x177f
	push hl	; offset 0x1780
	ld hl,0	; byte addr 0x174a, code offset 0x1783
	push hl	; offset 0x1784
	ld hl,65027	; byte addr 0x1748, code offset 0x1787
	push hl	; offset 0x1788
	ld hl,64767	; byte addr 0x1746, code offset 0x178b
	push hl	; offset 0x178c
	ld hl,65535	; byte addr 0x1744, code offset 0x178f
	push hl	; offset 0x1790
	ld hl,65535	; byte addr 0x1742, code offset 0x1793
	push hl	; offset 0x1794

	; src_data blit 303
	ld sp,screenStartAddr+5984	; offset 0x1797
	ld hl,65535	; byte addr 0x1760, code offset 0x179a
	push hl	; offset 0x179b
	ld hl,65535	; byte addr 0x175e, code offset 0x179e
	push hl	; offset 0x179f
	ld hl,65535	; byte addr 0x175c, code offset 0x17a2
	push hl	; offset 0x17a3
	ld hl,16128	; byte addr 0x175a, code offset 0x17a6
	push hl	; offset 0x17a7
	ld hl,65279	; byte addr 0x1758, code offset 0x17aa
	push hl	; offset 0x17ab
	ld hl,3840	; byte addr 0x1756, code offset 0x17ae
	push hl	; offset 0x17af
	ld hl,63743	; byte addr 0x1754, code offset 0x17b2
	push hl	; offset 0x17b3
	ld hl,256	; byte addr 0x1752, code offset 0x17b6
	push hl	; offset 0x17b7

	; src_data blit 304
	ld sp,screenStartAddr+4208	; offset 0x17ba
	ld hl,63495	; byte addr 0x1070, code offset 0x17bd
	push hl	; offset 0x17be
	ld hl,240	; byte addr 0x106e, code offset 0x17c1
	push hl	; offset 0x17c2
	ld hl,65343	; byte addr 0x106c, code offset 0x17c5
	push hl	; offset 0x17c6
	ld hl,0	; byte addr 0x106a, code offset 0x17c9
	push hl	; offset 0x17ca
	ld hl,65281	; byte addr 0x1068, code offset 0x17cd
	push hl	; offset 0x17ce
	ld hl,64767	; byte addr 0x1066, code offset 0x17d1
	push hl	; offset 0x17d2
	ld hl,65535	; byte addr 0x1064, code offset 0x17d5
	push hl	; offset 0x17d6
	ld hl,65535	; byte addr 0x1062, code offset 0x17d9
	push hl	; offset 0x17da

	; src_data blit 305
	ld sp,screenStartAddr+4224	; offset 0x17dd
	ld hl,65535	; byte addr 0x1080, code offset 0x17e0
	push hl	; offset 0x17e1
	ld hl,65535	; byte addr 0x107e, code offset 0x17e4
	push hl	; offset 0x17e5
	ld hl,65535	; byte addr 0x107c, code offset 0x17e8
	push hl	; offset 0x17e9
	ld hl,32512	; byte addr 0x107a, code offset 0x17ec
	push hl	; offset 0x17ed
	ld hl,65279	; byte addr 0x1078, code offset 0x17f0
	push hl	; offset 0x17f1
	ld hl,1792	; byte addr 0x1076, code offset 0x17f4
	push hl	; offset 0x17f5
	ld hl,64767	; byte addr 0x1074, code offset 0x17f8
	push hl	; offset 0x17f9
	ld hl,256	; byte addr 0x1072, code offset 0x17fc
	push hl	; offset 0x17fd

	; attr draw 9, code offset 0x17fd
	ld sp,attr8and16vals+36
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+288
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+288),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+288
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+288),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 9, offset 0x1856
	; Clock offset: -864


	; src_data blit 306
	ld sp,screenStartAddr+4464	; offset 0x1859
	ld hl,63491	; byte addr 0x1170, code offset 0x185c
	push hl	; offset 0x185d
	ld hl,248	; byte addr 0x116e, code offset 0x1860
	push hl	; offset 0x1861
	ld hl,65311	; byte addr 0x116c, code offset 0x1864
	push hl	; offset 0x1865
	ld hl,0	; byte addr 0x116a, code offset 0x1868
	push hl	; offset 0x1869
	ld hl,32512	; byte addr 0x1168, code offset 0x186c
	push hl	; offset 0x186d
	ld hl,65279	; byte addr 0x1166, code offset 0x1870
	push hl	; offset 0x1871
	ld hl,65535	; byte addr 0x1164, code offset 0x1874
	push hl	; offset 0x1875
	ld hl,65535	; byte addr 0x1162, code offset 0x1878
	push hl	; offset 0x1879

	; src_data blit 307
	ld sp,screenStartAddr+4480	; offset 0x187c
	ld hl,65535	; byte addr 0x1180, code offset 0x187f
	push hl	; offset 0x1880
	ld hl,65535	; byte addr 0x117e, code offset 0x1883
	push hl	; offset 0x1884
	ld hl,65535	; byte addr 0x117c, code offset 0x1887
	push hl	; offset 0x1888
	ld hl,65280	; byte addr 0x117a, code offset 0x188b
	push hl	; offset 0x188c
	ld hl,63743	; byte addr 0x1178, code offset 0x188f
	push hl	; offset 0x1890
	ld hl,1792	; byte addr 0x1176, code offset 0x1893
	push hl	; offset 0x1894
	ld hl,64767	; byte addr 0x1174, code offset 0x1897
	push hl	; offset 0x1898
	ld hl,256	; byte addr 0x1172, code offset 0x189b
	push hl	; offset 0x189c

	; src_data blit 308
	ld sp,screenStartAddr+4720	; offset 0x189f
	ld hl,63491	; byte addr 0x1270, code offset 0x18a2
	push hl	; offset 0x18a3
	ld hl,248	; byte addr 0x126e, code offset 0x18a6
	push hl	; offset 0x18a7
	ld hl,65295	; byte addr 0x126c, code offset 0x18aa
	push hl	; offset 0x18ab
	ld hl,0	; byte addr 0x126a, code offset 0x18ae
	push hl	; offset 0x18af
	ld hl,32512	; byte addr 0x1268, code offset 0x18b2
	push hl	; offset 0x18b3
	ld hl,65535	; byte addr 0x1266, code offset 0x18b6
	push hl	; offset 0x18b7
	ld hl,65535	; byte addr 0x1264, code offset 0x18ba
	push hl	; offset 0x18bb
	ld hl,65535	; byte addr 0x1262, code offset 0x18be
	push hl	; offset 0x18bf

	; src_data blit 309
	ld sp,screenStartAddr+4736	; offset 0x18c2
	ld hl,65535	; byte addr 0x1280, code offset 0x18c5
	push hl	; offset 0x18c6
	ld hl,65535	; byte addr 0x127e, code offset 0x18c9
	push hl	; offset 0x18ca
	ld hl,65535	; byte addr 0x127c, code offset 0x18cd
	push hl	; offset 0x18ce
	ld hl,65280	; byte addr 0x127a, code offset 0x18d1
	push hl	; offset 0x18d2
	ld hl,61695	; byte addr 0x1278, code offset 0x18d5
	push hl	; offset 0x18d6
	ld hl,1792	; byte addr 0x1276, code offset 0x18d9
	push hl	; offset 0x18da
	ld hl,64767	; byte addr 0x1274, code offset 0x18dd
	push hl	; offset 0x18de
	ld hl,256	; byte addr 0x1272, code offset 0x18e1
	push hl	; offset 0x18e2

	; src_data blit 310
	ld sp,screenStartAddr+4976	; offset 0x18e5
	ld hl,63489	; byte addr 0x1370, code offset 0x18e8
	push hl	; offset 0x18e9
	ld hl,252	; byte addr 0x136e, code offset 0x18ec
	push hl	; offset 0x18ed
	ld hl,65295	; byte addr 0x136c, code offset 0x18f0
	push hl	; offset 0x18f1
	ld hl,128	; byte addr 0x136a, code offset 0x18f4
	push hl	; offset 0x18f5
	ld hl,7936	; byte addr 0x1368, code offset 0x18f8
	push hl	; offset 0x18f9
	ld hl,65535	; byte addr 0x1366, code offset 0x18fc
	push hl	; offset 0x18fd
	ld hl,65535	; byte addr 0x1364, code offset 0x1900
	push hl	; offset 0x1901
	ld hl,65535	; byte addr 0x1362, code offset 0x1904
	push hl	; offset 0x1905

	; src_data blit 311
	ld sp,screenStartAddr+4992	; offset 0x1908
	ld hl,65535	; byte addr 0x1380, code offset 0x190b
	push hl	; offset 0x190c
	ld hl,65535	; byte addr 0x137e, code offset 0x190f
	push hl	; offset 0x1910
	ld hl,65535	; byte addr 0x137c, code offset 0x1913
	push hl	; offset 0x1914
	ld hl,65281	; byte addr 0x137a, code offset 0x1917
	push hl	; offset 0x1918
	ld hl,57599	; byte addr 0x1378, code offset 0x191b
	push hl	; offset 0x191c
	ld hl,1792	; byte addr 0x1376, code offset 0x191f
	push hl	; offset 0x1920
	ld hl,64767	; byte addr 0x1374, code offset 0x1923
	push hl	; offset 0x1924
	ld hl,256	; byte addr 0x1372, code offset 0x1927
	push hl	; offset 0x1928

	; attr draw 10, code offset 0x1928
	ld sp,attr8and16vals+40
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+320
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+320),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 10, offset 0x1981
	; Clock offset: -864


	; src_data blit 312
	ld sp,screenStartAddr+5232	; offset 0x1984
	ld hl,63488	; byte addr 0x1470, code offset 0x1987
	push hl	; offset 0x1988
	ld hl,254	; byte addr 0x146e, code offset 0x198b
	push hl	; offset 0x198c
	ld hl,65295	; byte addr 0x146c, code offset 0x198f
	push hl	; offset 0x1990
	ld hl,128	; byte addr 0x146a, code offset 0x1993
	push hl	; offset 0x1994
	ld hl,3968	; byte addr 0x1468, code offset 0x1997
	push hl	; offset 0x1998
	ld hl,65535	; byte addr 0x1466, code offset 0x199b
	push hl	; offset 0x199c
	ld hl,65535	; byte addr 0x1464, code offset 0x199f
	push hl	; offset 0x19a0
	ld hl,65535	; byte addr 0x1462, code offset 0x19a3
	push hl	; offset 0x19a4

	; src_data blit 313
	ld sp,screenStartAddr+5248	; offset 0x19a7
	ld hl,65535	; byte addr 0x1480, code offset 0x19aa
	push hl	; offset 0x19ab
	ld hl,65535	; byte addr 0x147e, code offset 0x19ae
	push hl	; offset 0x19af
	ld hl,65535	; byte addr 0x147c, code offset 0x19b2
	push hl	; offset 0x19b3
	ld hl,65283	; byte addr 0x147a, code offset 0x19b6
	push hl	; offset 0x19b7
	ld hl,49407	; byte addr 0x1478, code offset 0x19ba
	push hl	; offset 0x19bb
	ld hl,1792	; byte addr 0x1476, code offset 0x19be
	push hl	; offset 0x19bf
	ld hl,64767	; byte addr 0x1474, code offset 0x19c2
	push hl	; offset 0x19c3
	ld hl,0	; byte addr 0x1472, code offset 0x19c6
	push hl	; offset 0x19c7

	; src_data blit 314
	ld sp,screenStartAddr+5488	; offset 0x19ca
	ld hl,63488	; byte addr 0x1570, code offset 0x19cd
	push hl	; offset 0x19ce
	ld hl,255	; byte addr 0x156e, code offset 0x19d1
	push hl	; offset 0x19d2
	ld hl,65287	; byte addr 0x156c, code offset 0x19d5
	push hl	; offset 0x19d6
	ld hl,192	; byte addr 0x156a, code offset 0x19d9
	push hl	; offset 0x19da
	ld hl,1984	; byte addr 0x1568, code offset 0x19dd
	push hl	; offset 0x19de
	ld hl,65535	; byte addr 0x1566, code offset 0x19e1
	push hl	; offset 0x19e2
	ld hl,65535	; byte addr 0x1564, code offset 0x19e5
	push hl	; offset 0x19e6
	ld hl,65535	; byte addr 0x1562, code offset 0x19e9
	push hl	; offset 0x19ea

	; src_data blit 315
	ld sp,screenStartAddr+5504	; offset 0x19ed
	ld hl,65535	; byte addr 0x1580, code offset 0x19f0
	push hl	; offset 0x19f1
	ld hl,65535	; byte addr 0x157e, code offset 0x19f4
	push hl	; offset 0x19f5
	ld hl,65535	; byte addr 0x157c, code offset 0x19f8
	push hl	; offset 0x19f9
	ld hl,65283	; byte addr 0x157a, code offset 0x19fc
	push hl	; offset 0x19fd
	ld hl,33023	; byte addr 0x1578, code offset 0x1a00
	push hl	; offset 0x1a01
	ld hl,1792	; byte addr 0x1576, code offset 0x1a04
	push hl	; offset 0x1a05
	ld hl,65279	; byte addr 0x1574, code offset 0x1a08
	push hl	; offset 0x1a09
	ld hl,0	; byte addr 0x1572, code offset 0x1a0c
	push hl	; offset 0x1a0d

	; src_data blit 316
	ld sp,screenStartAddr+5744	; offset 0x1a10
	ld hl,30720	; byte addr 0x1670, code offset 0x1a13
	push hl	; offset 0x1a14
	ld hl,33023	; byte addr 0x166e, code offset 0x1a17
	push hl	; offset 0x1a18
	ld hl,65283	; byte addr 0x166c, code offset 0x1a1b
	push hl	; offset 0x1a1c
	ld hl,192	; byte addr 0x166a, code offset 0x1a1f
	push hl	; offset 0x1a20
	ld hl,960	; byte addr 0x1668, code offset 0x1a23
	push hl	; offset 0x1a24
	ld hl,65535	; byte addr 0x1666, code offset 0x1a27
	push hl	; offset 0x1a28
	ld hl,65535	; byte addr 0x1664, code offset 0x1a2b
	push hl	; offset 0x1a2c
	ld hl,65535	; byte addr 0x1662, code offset 0x1a2f
	push hl	; offset 0x1a30

	; src_data blit 317
	ld sp,screenStartAddr+5760	; offset 0x1a33
	ld hl,65535	; byte addr 0x1680, code offset 0x1a36
	push hl	; offset 0x1a37
	ld hl,65535	; byte addr 0x167e, code offset 0x1a3a
	push hl	; offset 0x1a3b
	ld hl,65535	; byte addr 0x167c, code offset 0x1a3e
	push hl	; offset 0x1a3f
	ld hl,7936	; byte addr 0x167a, code offset 0x1a42
	push hl	; offset 0x1a43
	ld hl,255	; byte addr 0x1678, code offset 0x1a46
	push hl	; offset 0x1a47
	ld hl,768	; byte addr 0x1676, code offset 0x1a4a
	push hl	; offset 0x1a4b
	ld hl,65279	; byte addr 0x1674, code offset 0x1a4e
	push hl	; offset 0x1a4f
	ld hl,0	; byte addr 0x1672, code offset 0x1a52
	push hl	; offset 0x1a53

	; attr draw 11, code offset 0x1a53
	ld sp,attr8and16vals+44
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+352
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+352),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+352),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+352
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+352),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 11, offset 0x1aac
	; Clock offset: -864


	; src_data blit 318
	ld sp,screenStartAddr+6000	; offset 0x1aaf
	ld hl,15360	; byte addr 0x1770, code offset 0x1ab2
	push hl	; offset 0x1ab3
	ld hl,49407	; byte addr 0x176e, code offset 0x1ab6
	push hl	; offset 0x1ab7
	ld hl,65283	; byte addr 0x176c, code offset 0x1aba
	push hl	; offset 0x1abb
	ld hl,192	; byte addr 0x176a, code offset 0x1abe
	push hl	; offset 0x1abf
	ld hl,480	; byte addr 0x1768, code offset 0x1ac2
	push hl	; offset 0x1ac3
	ld hl,65535	; byte addr 0x1766, code offset 0x1ac6
	push hl	; offset 0x1ac7
	ld hl,65535	; byte addr 0x1764, code offset 0x1aca
	push hl	; offset 0x1acb
	ld hl,65535	; byte addr 0x1762, code offset 0x1ace
	push hl	; offset 0x1acf

	; src_data blit 319
	ld sp,screenStartAddr+6016	; offset 0x1ad2
	ld hl,65535	; byte addr 0x1780, code offset 0x1ad5
	push hl	; offset 0x1ad6
	ld hl,53247	; byte addr 0x177e, code offset 0x1ad9
	push hl	; offset 0x1ada
	ld hl,65535	; byte addr 0x177c, code offset 0x1add
	push hl	; offset 0x1ade
	ld hl,768	; byte addr 0x177a, code offset 0x1ae1
	push hl	; offset 0x1ae2
	ld hl,254	; byte addr 0x1778, code offset 0x1ae5
	push hl	; offset 0x1ae6
	ld hl,768	; byte addr 0x1776, code offset 0x1ae9
	push hl	; offset 0x1aea
	ld hl,65279	; byte addr 0x1774, code offset 0x1aed
	push hl	; offset 0x1aee
	ld hl,0	; byte addr 0x1772, code offset 0x1af1
	push hl	; offset 0x1af2

	; src_data blit 320
	ld sp,screenStartAddr+4240	; offset 0x1af5
	ld hl,7168	; byte addr 0x1090, code offset 0x1af8
	push hl	; offset 0x1af9
	ld hl,57599	; byte addr 0x108e, code offset 0x1afc
	push hl	; offset 0x1afd
	ld hl,65283	; byte addr 0x108c, code offset 0x1b00
	push hl	; offset 0x1b01
	ld hl,96	; byte addr 0x108a, code offset 0x1b04
	push hl	; offset 0x1b05
	ld hl,240	; byte addr 0x1088, code offset 0x1b08
	push hl	; offset 0x1b09
	ld hl,65535	; byte addr 0x1086, code offset 0x1b0c
	push hl	; offset 0x1b0d
	ld hl,65535	; byte addr 0x1084, code offset 0x1b10
	push hl	; offset 0x1b11
	ld hl,65535	; byte addr 0x1082, code offset 0x1b14
	push hl	; offset 0x1b15

	; src_data blit 321
	ld sp,screenStartAddr+4256	; offset 0x1b18
	ld hl,65535	; byte addr 0x10a0, code offset 0x1b1b
	push hl	; offset 0x1b1c
	ld hl,8176	; byte addr 0x109e, code offset 0x1b1f
	push hl	; offset 0x1b20
	ld hl,65343	; byte addr 0x109c, code offset 0x1b23
	push hl	; offset 0x1b24
	ld hl,0	; byte addr 0x109a, code offset 0x1b27
	push hl	; offset 0x1b28
	ld hl,255	; byte addr 0x1098, code offset 0x1b2b
	push hl	; offset 0x1b2c
	ld hl,768	; byte addr 0x1096, code offset 0x1b2f
	push hl	; offset 0x1b30
	ld hl,65279	; byte addr 0x1094, code offset 0x1b33
	push hl	; offset 0x1b34
	ld hl,0	; byte addr 0x1092, code offset 0x1b37
	push hl	; offset 0x1b38

	; src_data blit 322
	ld sp,screenStartAddr+4496	; offset 0x1b3b
	ld hl,7168	; byte addr 0x1190, code offset 0x1b3e
	push hl	; offset 0x1b3f
	ld hl,61583	; byte addr 0x118e, code offset 0x1b42
	push hl	; offset 0x1b43
	ld hl,65281	; byte addr 0x118c, code offset 0x1b46
	push hl	; offset 0x1b47
	ld hl,32	; byte addr 0x118a, code offset 0x1b4a
	push hl	; offset 0x1b4b
	ld hl,240	; byte addr 0x1188, code offset 0x1b4e
	push hl	; offset 0x1b4f
	ld hl,65535	; byte addr 0x1186, code offset 0x1b52
	push hl	; offset 0x1b53
	ld hl,65535	; byte addr 0x1184, code offset 0x1b56
	push hl	; offset 0x1b57
	ld hl,65535	; byte addr 0x1182, code offset 0x1b5a
	push hl	; offset 0x1b5b

	; src_data blit 323
	ld sp,screenStartAddr+4512	; offset 0x1b5e
	ld hl,65535	; byte addr 0x11a0, code offset 0x1b61
	push hl	; offset 0x1b62
	ld hl,32512	; byte addr 0x119e, code offset 0x1b65
	push hl	; offset 0x1b66
	ld hl,65287	; byte addr 0x119c, code offset 0x1b69
	push hl	; offset 0x1b6a
	ld hl,0	; byte addr 0x119a, code offset 0x1b6d
	push hl	; offset 0x1b6e
	ld hl,32927	; byte addr 0x1198, code offset 0x1b71
	push hl	; offset 0x1b72
	ld hl,256	; byte addr 0x1196, code offset 0x1b75
	push hl	; offset 0x1b76
	ld hl,65407	; byte addr 0x1194, code offset 0x1b79
	push hl	; offset 0x1b7a
	ld hl,0	; byte addr 0x1192, code offset 0x1b7d
	push hl	; offset 0x1b7e

	; attr draw 12, code offset 0x1b7e
	ld sp,attr8and16vals+48
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+384
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+384),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+384),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+384
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+384),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 12, offset 0x1bd7
	; Clock offset: -864


	; src_data blit 324
	ld sp,screenStartAddr+4752	; offset 0x1bda
	ld hl,3072	; byte addr 0x1290, code offset 0x1bdd
	push hl	; offset 0x1bde
	ld hl,6336	; byte addr 0x128e, code offset 0x1be1
	push hl	; offset 0x1be2
	ld hl,65280	; byte addr 0x128c, code offset 0x1be5
	push hl	; offset 0x1be6
	ld hl,16	; byte addr 0x128a, code offset 0x1be9
	push hl	; offset 0x1bea
	ld hl,248	; byte addr 0x1288, code offset 0x1bed
	push hl	; offset 0x1bee
	ld hl,65535	; byte addr 0x1286, code offset 0x1bf1
	push hl	; offset 0x1bf2
	ld hl,65535	; byte addr 0x1284, code offset 0x1bf5
	push hl	; offset 0x1bf6
	ld hl,65535	; byte addr 0x1282, code offset 0x1bf9
	push hl	; offset 0x1bfa

	; src_data blit 325
	ld sp,screenStartAddr+4768	; offset 0x1bfd
	ld hl,65535	; byte addr 0x12a0, code offset 0x1c00
	push hl	; offset 0x1c01
	ld hl,65281	; byte addr 0x129e, code offset 0x1c04
	push hl	; offset 0x1c05
	ld hl,0	; byte addr 0x129c, code offset 0x1c08
	push hl	; offset 0x1c09
	ld hl,0	; byte addr 0x129a, code offset 0x1c0c
	push hl	; offset 0x1c0d
	ld hl,49159	; byte addr 0x1298, code offset 0x1c10
	push hl	; offset 0x1c11
	ld hl,0	; byte addr 0x1296, code offset 0x1c14
	push hl	; offset 0x1c15
	ld hl,65407	; byte addr 0x1294, code offset 0x1c18
	push hl	; offset 0x1c19
	ld hl,0	; byte addr 0x1292, code offset 0x1c1c
	push hl	; offset 0x1c1d

	; src_data blit 326
	ld sp,screenStartAddr+5008	; offset 0x1c20
	ld hl,1536	; byte addr 0x1390, code offset 0x1c23
	push hl	; offset 0x1c24
	ld hl,224	; byte addr 0x138e, code offset 0x1c27
	push hl	; offset 0x1c28
	ld hl,65280	; byte addr 0x138c, code offset 0x1c2b
	push hl	; offset 0x1c2c
	ld hl,0	; byte addr 0x138a, code offset 0x1c2f
	push hl	; offset 0x1c30
	ld hl,252	; byte addr 0x1388, code offset 0x1c33
	push hl	; offset 0x1c34
	ld hl,65535	; byte addr 0x1386, code offset 0x1c37
	push hl	; offset 0x1c38
	ld hl,65535	; byte addr 0x1384, code offset 0x1c3b
	push hl	; offset 0x1c3c
	ld hl,65535	; byte addr 0x1382, code offset 0x1c3f
	push hl	; offset 0x1c40

	; src_data blit 327
	ld sp,screenStartAddr+5024	; offset 0x1c43
	ld hl,65535	; byte addr 0x13a0, code offset 0x1c46
	push hl	; offset 0x1c47
	ld hl,65287	; byte addr 0x139e, code offset 0x1c4a
	push hl	; offset 0x1c4b
	ld hl,0	; byte addr 0x139c, code offset 0x1c4e
	push hl	; offset 0x1c4f
	ld hl,0	; byte addr 0x139a, code offset 0x1c52
	push hl	; offset 0x1c53
	ld hl,57347	; byte addr 0x1398, code offset 0x1c56
	push hl	; offset 0x1c57
	ld hl,0	; byte addr 0x1396, code offset 0x1c5a
	push hl	; offset 0x1c5b
	ld hl,65407	; byte addr 0x1394, code offset 0x1c5e
	push hl	; offset 0x1c5f
	ld hl,0	; byte addr 0x1392, code offset 0x1c62
	push hl	; offset 0x1c63

	; src_data blit 328
	ld sp,screenStartAddr+5264	; offset 0x1c66
	ld hl,1536	; byte addr 0x1490, code offset 0x1c69
	push hl	; offset 0x1c6a
	ld hl,240	; byte addr 0x148e, code offset 0x1c6d
	push hl	; offset 0x1c6e
	ld hl,7936	; byte addr 0x148c, code offset 0x1c71
	push hl	; offset 0x1c72
	ld hl,0	; byte addr 0x148a, code offset 0x1c75
	push hl	; offset 0x1c76
	ld hl,252	; byte addr 0x1488, code offset 0x1c79
	push hl	; offset 0x1c7a
	ld hl,65535	; byte addr 0x1486, code offset 0x1c7d
	push hl	; offset 0x1c7e
	ld hl,65535	; byte addr 0x1484, code offset 0x1c81
	push hl	; offset 0x1c82
	ld hl,65535	; byte addr 0x1482, code offset 0x1c85
	push hl	; offset 0x1c86

	; src_data blit 329
	ld sp,screenStartAddr+5280	; offset 0x1c89
	ld hl,65535	; byte addr 0x14a0, code offset 0x1c8c
	push hl	; offset 0x1c8d
	ld hl,65311	; byte addr 0x149e, code offset 0x1c90
	push hl	; offset 0x1c91
	ld hl,0	; byte addr 0x149c, code offset 0x1c94
	push hl	; offset 0x1c95
	ld hl,0	; byte addr 0x149a, code offset 0x1c98
	push hl	; offset 0x1c99
	ld hl,49152	; byte addr 0x1498, code offset 0x1c9c
	push hl	; offset 0x1c9d
	ld hl,0	; byte addr 0x1496, code offset 0x1ca0
	push hl	; offset 0x1ca1
	ld hl,65404	; byte addr 0x1494, code offset 0x1ca4
	push hl	; offset 0x1ca5
	ld hl,0	; byte addr 0x1492, code offset 0x1ca8
	push hl	; offset 0x1ca9

	; attr draw 13, code offset 0x1ca9
	ld sp,attr8and16vals+52
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+416
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+416),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+416),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+416
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+416),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 13, offset 0x1d02
	; Clock offset: -864


	; src_data blit 330
	ld sp,screenStartAddr+5520	; offset 0x1d05
	ld hl,512	; byte addr 0x1590, code offset 0x1d08
	push hl	; offset 0x1d09
	ld hl,248	; byte addr 0x158e, code offset 0x1d0c
	push hl	; offset 0x1d0d
	ld hl,768	; byte addr 0x158c, code offset 0x1d10
	push hl	; offset 0x1d11
	ld hl,0	; byte addr 0x158a, code offset 0x1d14
	push hl	; offset 0x1d15
	ld hl,254	; byte addr 0x1588, code offset 0x1d18
	push hl	; offset 0x1d19
	ld hl,65535	; byte addr 0x1586, code offset 0x1d1c
	push hl	; offset 0x1d1d
	ld hl,65535	; byte addr 0x1584, code offset 0x1d20
	push hl	; offset 0x1d21
	ld hl,65535	; byte addr 0x1582, code offset 0x1d24
	push hl	; offset 0x1d25

	; src_data blit 331
	ld sp,screenStartAddr+5536	; offset 0x1d28
	ld hl,65535	; byte addr 0x15a0, code offset 0x1d2b
	push hl	; offset 0x1d2c
	ld hl,65407	; byte addr 0x159e, code offset 0x1d2f
	push hl	; offset 0x1d30
	ld hl,0	; byte addr 0x159c, code offset 0x1d33
	push hl	; offset 0x1d34
	ld hl,0	; byte addr 0x159a, code offset 0x1d37
	push hl	; offset 0x1d38
	ld hl,0	; byte addr 0x1598, code offset 0x1d3b
	push hl	; offset 0x1d3c
	ld hl,0	; byte addr 0x1596, code offset 0x1d3f
	push hl	; offset 0x1d40
	ld hl,16184	; byte addr 0x1594, code offset 0x1d43
	push hl	; offset 0x1d44
	ld hl,0	; byte addr 0x1592, code offset 0x1d47
	push hl	; offset 0x1d48

	; src_data blit 332
	ld sp,screenStartAddr+5776	; offset 0x1d4b
	ld hl,0	; byte addr 0x1690, code offset 0x1d4e
	push hl	; offset 0x1d4f
	ld hl,56	; byte addr 0x168e, code offset 0x1d52
	push hl	; offset 0x1d53
	ld hl,0	; byte addr 0x168c, code offset 0x1d56
	push hl	; offset 0x1d57
	ld hl,0	; byte addr 0x168a, code offset 0x1d5a
	push hl	; offset 0x1d5b
	ld hl,254	; byte addr 0x1688, code offset 0x1d5e
	push hl	; offset 0x1d5f
	ld hl,65535	; byte addr 0x1686, code offset 0x1d62
	push hl	; offset 0x1d63
	ld hl,65535	; byte addr 0x1684, code offset 0x1d66
	push hl	; offset 0x1d67
	ld hl,65535	; byte addr 0x1682, code offset 0x1d6a
	push hl	; offset 0x1d6b

	; src_data blit 333
	ld sp,screenStartAddr+5792	; offset 0x1d6e
	ld hl,65535	; byte addr 0x16a0, code offset 0x1d71
	push hl	; offset 0x1d72
	ld hl,65535	; byte addr 0x169e, code offset 0x1d75
	push hl	; offset 0x1d76
	ld hl,256	; byte addr 0x169c, code offset 0x1d79
	push hl	; offset 0x1d7a
	ld hl,57344	; byte addr 0x169a, code offset 0x1d7d
	push hl	; offset 0x1d7e
	ld hl,0	; byte addr 0x1698, code offset 0x1d81
	push hl	; offset 0x1d82
	ld hl,128	; byte addr 0x1696, code offset 0x1d85
	push hl	; offset 0x1d86
	ld hl,16176	; byte addr 0x1694, code offset 0x1d89
	push hl	; offset 0x1d8a
	ld hl,0	; byte addr 0x1692, code offset 0x1d8d
	push hl	; offset 0x1d8e

	; src_data blit 334
	ld sp,screenStartAddr+6032	; offset 0x1d91
	ld hl,0	; byte addr 0x1790, code offset 0x1d94
	push hl	; offset 0x1d95
	ld hl,0	; byte addr 0x178e, code offset 0x1d98
	push hl	; offset 0x1d99
	ld hl,0	; byte addr 0x178c, code offset 0x1d9c
	push hl	; offset 0x1d9d
	ld hl,0	; byte addr 0x178a, code offset 0x1da0
	push hl	; offset 0x1da1
	ld hl,0	; byte addr 0x1788, code offset 0x1da4
	push hl	; offset 0x1da5
	ld hl,0	; byte addr 0x1786, code offset 0x1da8
	push hl	; offset 0x1da9
	ld hl,64767	; byte addr 0x1784, code offset 0x1dac
	push hl	; offset 0x1dad
	ld hl,65535	; byte addr 0x1782, code offset 0x1db0
	push hl	; offset 0x1db1

	; src_data blit 335
	ld sp,screenStartAddr+6048	; offset 0x1db4
	ld hl,65535	; byte addr 0x17a0, code offset 0x1db7
	push hl	; offset 0x1db8
	ld hl,65535	; byte addr 0x179e, code offset 0x1dbb
	push hl	; offset 0x1dbc
	ld hl,51199	; byte addr 0x179c, code offset 0x1dbf
	push hl	; offset 0x1dc0
	ld hl,65281	; byte addr 0x179a, code offset 0x1dc3
	push hl	; offset 0x1dc4
	ld hl,0	; byte addr 0x1798, code offset 0x1dc7
	push hl	; offset 0x1dc8
	ld hl,128	; byte addr 0x1796, code offset 0x1dcb
	push hl	; offset 0x1dcc
	ld hl,3840	; byte addr 0x1794, code offset 0x1dcf
	push hl	; offset 0x1dd0
	ld hl,0	; byte addr 0x1792, code offset 0x1dd3
	push hl	; offset 0x1dd4

	; attr draw 14, code offset 0x1dd4
	ld sp,attr8and16vals+56
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+448
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+448),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+448),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+448
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+448),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 14, offset 0x1e2d
	; Clock offset: -864


	; src_data blit 336
	ld sp,screenStartAddr+4272	; offset 0x1e30
	ld hl,0	; byte addr 0x10b0, code offset 0x1e33
	push hl	; offset 0x1e34
	ld hl,0	; byte addr 0x10ae, code offset 0x1e37
	push hl	; offset 0x1e38
	ld hl,0	; byte addr 0x10ac, code offset 0x1e3b
	push hl	; offset 0x1e3c
	ld hl,0	; byte addr 0x10aa, code offset 0x1e3f
	push hl	; offset 0x1e40
	ld hl,0	; byte addr 0x10a8, code offset 0x1e43
	push hl	; offset 0x1e44
	ld hl,0	; byte addr 0x10a6, code offset 0x1e47
	push hl	; offset 0x1e48
	ld hl,65535	; byte addr 0x10a4, code offset 0x1e4b
	push hl	; offset 0x1e4c
	ld hl,65535	; byte addr 0x10a2, code offset 0x1e4f
	push hl	; offset 0x1e50

	; src_data blit 337
	ld sp,screenStartAddr+4288	; offset 0x1e53
	ld hl,65535	; byte addr 0x10c0, code offset 0x1e56
	push hl	; offset 0x1e57
	ld hl,65535	; byte addr 0x10be, code offset 0x1e5a
	push hl	; offset 0x1e5b
	ld hl,65535	; byte addr 0x10bc, code offset 0x1e5e
	push hl	; offset 0x1e5f
	ld hl,65283	; byte addr 0x10ba, code offset 0x1e62
	push hl	; offset 0x1e63
	ld hl,0	; byte addr 0x10b8, code offset 0x1e66
	push hl	; offset 0x1e67
	ld hl,128	; byte addr 0x10b6, code offset 0x1e6a
	push hl	; offset 0x1e6b
	ld hl,768	; byte addr 0x10b4, code offset 0x1e6e
	push hl	; offset 0x1e6f
	ld hl,0	; byte addr 0x10b2, code offset 0x1e72
	push hl	; offset 0x1e73

	; src_data blit 338
	ld sp,screenStartAddr+4528	; offset 0x1e76
	ld hl,0	; byte addr 0x11b0, code offset 0x1e79
	push hl	; offset 0x1e7a
	ld hl,0	; byte addr 0x11ae, code offset 0x1e7d
	push hl	; offset 0x1e7e
	ld hl,0	; byte addr 0x11ac, code offset 0x1e81
	push hl	; offset 0x1e82
	ld hl,0	; byte addr 0x11aa, code offset 0x1e85
	push hl	; offset 0x1e86
	ld hl,0	; byte addr 0x11a8, code offset 0x1e89
	push hl	; offset 0x1e8a
	ld hl,248	; byte addr 0x11a6, code offset 0x1e8d
	push hl	; offset 0x1e8e
	ld hl,65535	; byte addr 0x11a4, code offset 0x1e91
	push hl	; offset 0x1e92
	ld hl,65535	; byte addr 0x11a2, code offset 0x1e95
	push hl	; offset 0x1e96

	; src_data blit 339
	ld sp,screenStartAddr+4544	; offset 0x1e99
	ld hl,65535	; byte addr 0x11c0, code offset 0x1e9c
	push hl	; offset 0x1e9d
	ld hl,65535	; byte addr 0x11be, code offset 0x1ea0
	push hl	; offset 0x1ea1
	ld hl,65535	; byte addr 0x11bc, code offset 0x1ea4
	push hl	; offset 0x1ea5
	ld hl,65295	; byte addr 0x11ba, code offset 0x1ea8
	push hl	; offset 0x1ea9
	ld hl,0	; byte addr 0x11b8, code offset 0x1eac
	push hl	; offset 0x1ead
	ld hl,0	; byte addr 0x11b6, code offset 0x1eb0
	push hl	; offset 0x1eb1
	ld hl,0	; byte addr 0x11b4, code offset 0x1eb4
	push hl	; offset 0x1eb5
	ld hl,0	; byte addr 0x11b2, code offset 0x1eb8
	push hl	; offset 0x1eb9

	; src_data blit 340
	ld sp,screenStartAddr+4784	; offset 0x1ebc
	ld hl,0	; byte addr 0x12b0, code offset 0x1ebf
	push hl	; offset 0x1ec0
	ld hl,0	; byte addr 0x12ae, code offset 0x1ec3
	push hl	; offset 0x1ec4
	ld hl,0	; byte addr 0x12ac, code offset 0x1ec7
	push hl	; offset 0x1ec8
	ld hl,0	; byte addr 0x12aa, code offset 0x1ecb
	push hl	; offset 0x1ecc
	ld hl,0	; byte addr 0x12a8, code offset 0x1ecf
	push hl	; offset 0x1ed0
	ld hl,49407	; byte addr 0x12a6, code offset 0x1ed3
	push hl	; offset 0x1ed4
	ld hl,65535	; byte addr 0x12a4, code offset 0x1ed7
	push hl	; offset 0x1ed8
	ld hl,65535	; byte addr 0x12a2, code offset 0x1edb
	push hl	; offset 0x1edc

	; src_data blit 341
	ld sp,screenStartAddr+4800	; offset 0x1edf
	ld hl,65535	; byte addr 0x12c0, code offset 0x1ee2
	push hl	; offset 0x1ee3
	ld hl,65535	; byte addr 0x12be, code offset 0x1ee6
	push hl	; offset 0x1ee7
	ld hl,65535	; byte addr 0x12bc, code offset 0x1eea
	push hl	; offset 0x1eeb
	ld hl,65311	; byte addr 0x12ba, code offset 0x1eee
	push hl	; offset 0x1eef
	ld hl,0	; byte addr 0x12b8, code offset 0x1ef2
	push hl	; offset 0x1ef3
	ld hl,0	; byte addr 0x12b6, code offset 0x1ef6
	push hl	; offset 0x1ef7
	ld hl,0	; byte addr 0x12b4, code offset 0x1efa
	push hl	; offset 0x1efb
	ld hl,0	; byte addr 0x12b2, code offset 0x1efe
	push hl	; offset 0x1eff

	; attr draw 15, code offset 0x1eff
	ld sp,attr8and16vals+60
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+480
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+480),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+480),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+480
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+480),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 15, offset 0x1f58
	; Clock offset: -864


	; src_data blit 342
	ld sp,screenStartAddr+5040	; offset 0x1f5b
	ld hl,0	; byte addr 0x13b0, code offset 0x1f5e
	push hl	; offset 0x1f5f
	ld hl,0	; byte addr 0x13ae, code offset 0x1f62
	push hl	; offset 0x1f63
	ld hl,0	; byte addr 0x13ac, code offset 0x1f66
	push hl	; offset 0x1f67
	ld hl,0	; byte addr 0x13aa, code offset 0x1f6a
	push hl	; offset 0x1f6b
	ld hl,224	; byte addr 0x13a8, code offset 0x1f6e
	push hl	; offset 0x1f6f
	ld hl,65535	; byte addr 0x13a6, code offset 0x1f72
	push hl	; offset 0x1f73
	ld hl,65535	; byte addr 0x13a4, code offset 0x1f76
	push hl	; offset 0x1f77
	ld hl,65535	; byte addr 0x13a2, code offset 0x1f7a
	push hl	; offset 0x1f7b

	; src_data blit 343
	ld sp,screenStartAddr+5056	; offset 0x1f7e
	ld hl,65535	; byte addr 0x13c0, code offset 0x1f81
	push hl	; offset 0x1f82
	ld hl,65535	; byte addr 0x13be, code offset 0x1f85
	push hl	; offset 0x1f86
	ld hl,65535	; byte addr 0x13bc, code offset 0x1f89
	push hl	; offset 0x1f8a
	ld hl,65407	; byte addr 0x13ba, code offset 0x1f8d
	push hl	; offset 0x1f8e
	ld hl,0	; byte addr 0x13b8, code offset 0x1f91
	push hl	; offset 0x1f92
	ld hl,0	; byte addr 0x13b6, code offset 0x1f95
	push hl	; offset 0x1f96
	ld hl,0	; byte addr 0x13b4, code offset 0x1f99
	push hl	; offset 0x1f9a
	ld hl,0	; byte addr 0x13b2, code offset 0x1f9d
	push hl	; offset 0x1f9e

	; src_data blit 344
	ld sp,screenStartAddr+5296	; offset 0x1fa1
	ld hl,0	; byte addr 0x14b0, code offset 0x1fa4
	push hl	; offset 0x1fa5
	ld hl,0	; byte addr 0x14ae, code offset 0x1fa8
	push hl	; offset 0x1fa9
	ld hl,0	; byte addr 0x14ac, code offset 0x1fac
	push hl	; offset 0x1fad
	ld hl,0	; byte addr 0x14aa, code offset 0x1fb0
	push hl	; offset 0x1fb1
	ld hl,49407	; byte addr 0x14a8, code offset 0x1fb4
	push hl	; offset 0x1fb5
	ld hl,65535	; byte addr 0x14a6, code offset 0x1fb8
	push hl	; offset 0x1fb9
	ld hl,65535	; byte addr 0x14a4, code offset 0x1fbc
	push hl	; offset 0x1fbd
	ld hl,65535	; byte addr 0x14a2, code offset 0x1fc0
	push hl	; offset 0x1fc1

	; src_data blit 345
	ld sp,screenStartAddr+5312	; offset 0x1fc4
	ld hl,65535	; byte addr 0x14c0, code offset 0x1fc7
	push hl	; offset 0x1fc8
	ld hl,65535	; byte addr 0x14be, code offset 0x1fcb
	push hl	; offset 0x1fcc
	ld hl,65535	; byte addr 0x14bc, code offset 0x1fcf
	push hl	; offset 0x1fd0
	ld hl,65535	; byte addr 0x14ba, code offset 0x1fd3
	push hl	; offset 0x1fd4
	ld hl,0	; byte addr 0x14b8, code offset 0x1fd7
	push hl	; offset 0x1fd8
	ld hl,0	; byte addr 0x14b6, code offset 0x1fdb
	push hl	; offset 0x1fdc
	ld hl,0	; byte addr 0x14b4, code offset 0x1fdf
	push hl	; offset 0x1fe0
	ld hl,0	; byte addr 0x14b2, code offset 0x1fe3
	push hl	; offset 0x1fe4

	; src_data blit 346
	ld sp,screenStartAddr+5552	; offset 0x1fe7
	ld hl,0	; byte addr 0x15b0, code offset 0x1fea
	push hl	; offset 0x1feb
	ld hl,0	; byte addr 0x15ae, code offset 0x1fee
	push hl	; offset 0x1fef
	ld hl,0	; byte addr 0x15ac, code offset 0x1ff2
	push hl	; offset 0x1ff3
	ld hl,240	; byte addr 0x15aa, code offset 0x1ff6
	push hl	; offset 0x1ff7
	ld hl,65535	; byte addr 0x15a8, code offset 0x1ffa
	push hl	; offset 0x1ffb
	ld hl,65535	; byte addr 0x15a6, code offset 0x1ffe
	push hl	; offset 0x1fff
	ld hl,65535	; byte addr 0x15a4, code offset 0x2002
	push hl	; offset 0x2003
	ld hl,65535	; byte addr 0x15a2, code offset 0x2006
	push hl	; offset 0x2007

	; src_data blit 347
	ld sp,screenStartAddr+5568	; offset 0x200a
	ld hl,65535	; byte addr 0x15c0, code offset 0x200d
	push hl	; offset 0x200e
	ld hl,65535	; byte addr 0x15be, code offset 0x2011
	push hl	; offset 0x2012
	ld hl,65535	; byte addr 0x15bc, code offset 0x2015
	push hl	; offset 0x2016
	ld hl,65535	; byte addr 0x15ba, code offset 0x2019
	push hl	; offset 0x201a
	ld hl,256	; byte addr 0x15b8, code offset 0x201d
	push hl	; offset 0x201e
	ld hl,0	; byte addr 0x15b6, code offset 0x2021
	push hl	; offset 0x2022
	ld hl,0	; byte addr 0x15b4, code offset 0x2025
	push hl	; offset 0x2026
	ld hl,0	; byte addr 0x15b2, code offset 0x2029
	push hl	; offset 0x202a

	; attr draw 16, code offset 0x202a
	ld sp,attr8and16vals+64
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+512
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+512),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+512),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+512
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+512),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 16, offset 0x2083
	; Clock offset: -864


	; src_data blit 348
	ld sp,screenStartAddr+5808	; offset 0x2086
	ld hl,0	; byte addr 0x16b0, code offset 0x2089
	push hl	; offset 0x208a
	ld hl,0	; byte addr 0x16ae, code offset 0x208d
	push hl	; offset 0x208e
	ld hl,0	; byte addr 0x16ac, code offset 0x2091
	push hl	; offset 0x2092
	ld hl,63743	; byte addr 0x16aa, code offset 0x2095
	push hl	; offset 0x2096
	ld hl,65535	; byte addr 0x16a8, code offset 0x2099
	push hl	; offset 0x209a
	ld hl,65535	; byte addr 0x16a6, code offset 0x209d
	push hl	; offset 0x209e
	ld hl,65535	; byte addr 0x16a4, code offset 0x20a1
	push hl	; offset 0x20a2
	ld hl,65535	; byte addr 0x16a2, code offset 0x20a5
	push hl	; offset 0x20a6

	; src_data blit 349
	ld sp,screenStartAddr+5824	; offset 0x20a9
	ld hl,65535	; byte addr 0x16c0, code offset 0x20ac
	push hl	; offset 0x20ad
	ld hl,65535	; byte addr 0x16be, code offset 0x20b0
	push hl	; offset 0x20b1
	ld hl,65535	; byte addr 0x16bc, code offset 0x20b4
	push hl	; offset 0x20b5
	ld hl,65535	; byte addr 0x16ba, code offset 0x20b8
	push hl	; offset 0x20b9
	ld hl,1792	; byte addr 0x16b8, code offset 0x20bc
	push hl	; offset 0x20bd
	ld hl,0	; byte addr 0x16b6, code offset 0x20c0
	push hl	; offset 0x20c1
	ld hl,0	; byte addr 0x16b4, code offset 0x20c4
	push hl	; offset 0x20c5
	ld hl,0	; byte addr 0x16b2, code offset 0x20c8
	push hl	; offset 0x20c9

	; src_data blit 350
	ld sp,screenStartAddr+6064	; offset 0x20cc
	ld hl,0	; byte addr 0x17b0, code offset 0x20cf
	push hl	; offset 0x20d0
	ld hl,0	; byte addr 0x17ae, code offset 0x20d3
	push hl	; offset 0x20d4
	ld hl,0	; byte addr 0x17ac, code offset 0x20d7
	push hl	; offset 0x20d8
	ld hl,65535	; byte addr 0x17aa, code offset 0x20db
	push hl	; offset 0x20dc
	ld hl,65535	; byte addr 0x17a8, code offset 0x20df
	push hl	; offset 0x20e0
	ld hl,65535	; byte addr 0x17a6, code offset 0x20e3
	push hl	; offset 0x20e4
	ld hl,65535	; byte addr 0x17a4, code offset 0x20e7
	push hl	; offset 0x20e8
	ld hl,65535	; byte addr 0x17a2, code offset 0x20eb
	push hl	; offset 0x20ec

	; src_data blit 351
	ld sp,screenStartAddr+6080	; offset 0x20ef
	ld hl,65535	; byte addr 0x17c0, code offset 0x20f2
	push hl	; offset 0x20f3
	ld hl,65535	; byte addr 0x17be, code offset 0x20f6
	push hl	; offset 0x20f7
	ld hl,65535	; byte addr 0x17bc, code offset 0x20fa
	push hl	; offset 0x20fb
	ld hl,65535	; byte addr 0x17ba, code offset 0x20fe
	push hl	; offset 0x20ff
	ld hl,3840	; byte addr 0x17b8, code offset 0x2102
	push hl	; offset 0x2103
	ld hl,0	; byte addr 0x17b6, code offset 0x2106
	push hl	; offset 0x2107
	ld hl,0	; byte addr 0x17b4, code offset 0x210a
	push hl	; offset 0x210b
	ld hl,0	; byte addr 0x17b2, code offset 0x210e
	push hl	; offset 0x210f

	; src_data blit 352
	ld sp,screenStartAddr+4304	; offset 0x2112
	ld hl,0	; byte addr 0x10d0, code offset 0x2115
	push hl	; offset 0x2116
	ld hl,0	; byte addr 0x10ce, code offset 0x2119
	push hl	; offset 0x211a
	ld hl,0	; byte addr 0x10cc, code offset 0x211d
	push hl	; offset 0x211e
	ld hl,65279	; byte addr 0x10ca, code offset 0x2121
	push hl	; offset 0x2122
	ld hl,65535	; byte addr 0x10c8, code offset 0x2125
	push hl	; offset 0x2126
	ld hl,65535	; byte addr 0x10c6, code offset 0x2129
	push hl	; offset 0x212a
	ld hl,65535	; byte addr 0x10c4, code offset 0x212d
	push hl	; offset 0x212e
	ld hl,65535	; byte addr 0x10c2, code offset 0x2131
	push hl	; offset 0x2132

	; src_data blit 353
	ld sp,screenStartAddr+4320	; offset 0x2135
	ld hl,65535	; byte addr 0x10e0, code offset 0x2138
	push hl	; offset 0x2139
	ld hl,65535	; byte addr 0x10de, code offset 0x213c
	push hl	; offset 0x213d
	ld hl,65535	; byte addr 0x10dc, code offset 0x2140
	push hl	; offset 0x2141
	ld hl,65535	; byte addr 0x10da, code offset 0x2144
	push hl	; offset 0x2145
	ld hl,7936	; byte addr 0x10d8, code offset 0x2148
	push hl	; offset 0x2149
	ld hl,0	; byte addr 0x10d6, code offset 0x214c
	push hl	; offset 0x214d
	ld hl,0	; byte addr 0x10d4, code offset 0x2150
	push hl	; offset 0x2151
	ld hl,0	; byte addr 0x10d2, code offset 0x2154
	push hl	; offset 0x2155

	; attr draw 17, code offset 0x2155
	ld sp,attr8and16vals+68
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+544
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+544),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+544),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+544
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+544),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 17, offset 0x21ae
	; Clock offset: -864


	; src_data blit 354
	ld sp,screenStartAddr+4560	; offset 0x21b1
	ld hl,0	; byte addr 0x11d0, code offset 0x21b4
	push hl	; offset 0x21b5
	ld hl,0	; byte addr 0x11ce, code offset 0x21b8
	push hl	; offset 0x21b9
	ld hl,0	; byte addr 0x11cc, code offset 0x21bc
	push hl	; offset 0x21bd
	ld hl,64767	; byte addr 0x11ca, code offset 0x21c0
	push hl	; offset 0x21c1
	ld hl,65535	; byte addr 0x11c8, code offset 0x21c4
	push hl	; offset 0x21c5
	ld hl,65535	; byte addr 0x11c6, code offset 0x21c8
	push hl	; offset 0x21c9
	ld hl,65535	; byte addr 0x11c4, code offset 0x21cc
	push hl	; offset 0x21cd
	ld hl,65535	; byte addr 0x11c2, code offset 0x21d0
	push hl	; offset 0x21d1

	; src_data blit 355
	ld sp,screenStartAddr+4576	; offset 0x21d4
	ld hl,65535	; byte addr 0x11e0, code offset 0x21d7
	push hl	; offset 0x21d8
	ld hl,65535	; byte addr 0x11de, code offset 0x21db
	push hl	; offset 0x21dc
	ld hl,65535	; byte addr 0x11dc, code offset 0x21df
	push hl	; offset 0x21e0
	ld hl,65535	; byte addr 0x11da, code offset 0x21e3
	push hl	; offset 0x21e4
	ld hl,3840	; byte addr 0x11d8, code offset 0x21e7
	push hl	; offset 0x21e8
	ld hl,0	; byte addr 0x11d6, code offset 0x21eb
	push hl	; offset 0x21ec
	ld hl,0	; byte addr 0x11d4, code offset 0x21ef
	push hl	; offset 0x21f0
	ld hl,0	; byte addr 0x11d2, code offset 0x21f3
	push hl	; offset 0x21f4

	; src_data blit 356
	ld sp,screenStartAddr+4816	; offset 0x21f7
	ld hl,0	; byte addr 0x12d0, code offset 0x21fa
	push hl	; offset 0x21fb
	ld hl,0	; byte addr 0x12ce, code offset 0x21fe
	push hl	; offset 0x21ff
	ld hl,0	; byte addr 0x12cc, code offset 0x2202
	push hl	; offset 0x2203
	ld hl,61695	; byte addr 0x12ca, code offset 0x2206
	push hl	; offset 0x2207
	ld hl,65535	; byte addr 0x12c8, code offset 0x220a
	push hl	; offset 0x220b
	ld hl,65535	; byte addr 0x12c6, code offset 0x220e
	push hl	; offset 0x220f
	ld hl,65535	; byte addr 0x12c4, code offset 0x2212
	push hl	; offset 0x2213
	ld hl,65535	; byte addr 0x12c2, code offset 0x2216
	push hl	; offset 0x2217

	; src_data blit 357
	ld sp,screenStartAddr+4832	; offset 0x221a
	ld hl,65535	; byte addr 0x12e0, code offset 0x221d
	push hl	; offset 0x221e
	ld hl,65535	; byte addr 0x12de, code offset 0x2221
	push hl	; offset 0x2222
	ld hl,65535	; byte addr 0x12dc, code offset 0x2225
	push hl	; offset 0x2226
	ld hl,65535	; byte addr 0x12da, code offset 0x2229
	push hl	; offset 0x222a
	ld hl,768	; byte addr 0x12d8, code offset 0x222d
	push hl	; offset 0x222e
	ld hl,0	; byte addr 0x12d6, code offset 0x2231
	push hl	; offset 0x2232
	ld hl,0	; byte addr 0x12d4, code offset 0x2235
	push hl	; offset 0x2236
	ld hl,0	; byte addr 0x12d2, code offset 0x2239
	push hl	; offset 0x223a

	; src_data blit 358
	ld sp,screenStartAddr+5072	; offset 0x223d
	ld hl,0	; byte addr 0x13d0, code offset 0x2240
	push hl	; offset 0x2241
	ld hl,248	; byte addr 0x13ce, code offset 0x2244
	push hl	; offset 0x2245
	ld hl,7936	; byte addr 0x13cc, code offset 0x2248
	push hl	; offset 0x2249
	ld hl,49407	; byte addr 0x13ca, code offset 0x224c
	push hl	; offset 0x224d
	ld hl,65535	; byte addr 0x13c8, code offset 0x2250
	push hl	; offset 0x2251
	ld hl,65535	; byte addr 0x13c6, code offset 0x2254
	push hl	; offset 0x2255
	ld hl,65535	; byte addr 0x13c4, code offset 0x2258
	push hl	; offset 0x2259
	ld hl,65535	; byte addr 0x13c2, code offset 0x225c
	push hl	; offset 0x225d

	; src_data blit 359
	ld sp,screenStartAddr+5088	; offset 0x2260
	ld hl,65535	; byte addr 0x13e0, code offset 0x2263
	push hl	; offset 0x2264
	ld hl,65535	; byte addr 0x13de, code offset 0x2267
	push hl	; offset 0x2268
	ld hl,65535	; byte addr 0x13dc, code offset 0x226b
	push hl	; offset 0x226c
	ld hl,65407	; byte addr 0x13da, code offset 0x226f
	push hl	; offset 0x2270
	ld hl,0	; byte addr 0x13d8, code offset 0x2273
	push hl	; offset 0x2274
	ld hl,0	; byte addr 0x13d6, code offset 0x2277
	push hl	; offset 0x2278
	ld hl,0	; byte addr 0x13d4, code offset 0x227b
	push hl	; offset 0x227c
	ld hl,0	; byte addr 0x13d2, code offset 0x227f
	push hl	; offset 0x2280

	; attr draw 18, code offset 0x2280
	ld sp,attr8and16vals+72
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+576
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+576),hl	; dest 0
	ld hl,30840	; src 2
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+576
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+576),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 18, offset 0x22d9
	; Clock offset: -864


	; src_data blit 360
	ld sp,screenStartAddr+5328	; offset 0x22dc
	ld hl,224	; byte addr 0x14d0, code offset 0x22df
	push hl	; offset 0x22e0
	ld hl,65535	; byte addr 0x14ce, code offset 0x22e3
	push hl	; offset 0x22e4
	ld hl,65280	; byte addr 0x14cc, code offset 0x22e7
	push hl	; offset 0x22e8
	ld hl,255	; byte addr 0x14ca, code offset 0x22eb
	push hl	; offset 0x22ec
	ld hl,65535	; byte addr 0x14c8, code offset 0x22ef
	push hl	; offset 0x22f0
	ld hl,65535	; byte addr 0x14c6, code offset 0x22f3
	push hl	; offset 0x22f4
	ld hl,65535	; byte addr 0x14c4, code offset 0x22f7
	push hl	; offset 0x22f8
	ld hl,65535	; byte addr 0x14c2, code offset 0x22fb
	push hl	; offset 0x22fc

	; src_data blit 361
	ld sp,screenStartAddr+5344	; offset 0x22ff
	ld hl,65535	; byte addr 0x14e0, code offset 0x2302
	push hl	; offset 0x2303
	ld hl,65535	; byte addr 0x14de, code offset 0x2306
	push hl	; offset 0x2307
	ld hl,65535	; byte addr 0x14dc, code offset 0x230a
	push hl	; offset 0x230b
	ld hl,65311	; byte addr 0x14da, code offset 0x230e
	push hl	; offset 0x230f
	ld hl,0	; byte addr 0x14d8, code offset 0x2312
	push hl	; offset 0x2313
	ld hl,192	; byte addr 0x14d6, code offset 0x2316
	push hl	; offset 0x2317
	ld hl,1792	; byte addr 0x14d4, code offset 0x231a
	push hl	; offset 0x231b
	ld hl,0	; byte addr 0x14d2, code offset 0x231e
	push hl	; offset 0x231f

	; src_data blit 362
	ld sp,screenStartAddr+5584	; offset 0x2322
	ld hl,224	; byte addr 0x15d0, code offset 0x2325
	push hl	; offset 0x2326
	ld hl,65535	; byte addr 0x15ce, code offset 0x2329
	push hl	; offset 0x232a
	ld hl,65287	; byte addr 0x15cc, code offset 0x232d
	push hl	; offset 0x232e
	ld hl,252	; byte addr 0x15ca, code offset 0x2331
	push hl	; offset 0x2332
	ld hl,65535	; byte addr 0x15c8, code offset 0x2335
	push hl	; offset 0x2336
	ld hl,65535	; byte addr 0x15c6, code offset 0x2339
	push hl	; offset 0x233a
	ld hl,65535	; byte addr 0x15c4, code offset 0x233d
	push hl	; offset 0x233e
	ld hl,65535	; byte addr 0x15c2, code offset 0x2341
	push hl	; offset 0x2342

	; src_data blit 363
	ld sp,screenStartAddr+5600	; offset 0x2345
	ld hl,65535	; byte addr 0x15e0, code offset 0x2348
	push hl	; offset 0x2349
	ld hl,65535	; byte addr 0x15de, code offset 0x234c
	push hl	; offset 0x234d
	ld hl,65535	; byte addr 0x15dc, code offset 0x2350
	push hl	; offset 0x2351
	ld hl,65283	; byte addr 0x15da, code offset 0x2354
	push hl	; offset 0x2355
	ld hl,0	; byte addr 0x15d8, code offset 0x2358
	push hl	; offset 0x2359
	ld hl,63743	; byte addr 0x15d6, code offset 0x235c
	push hl	; offset 0x235d
	ld hl,768	; byte addr 0x15d4, code offset 0x2360
	push hl	; offset 0x2361
	ld hl,0	; byte addr 0x15d2, code offset 0x2364
	push hl	; offset 0x2365

	; src_data blit 364
	ld sp,screenStartAddr+5840	; offset 0x2368
	ld hl,192	; byte addr 0x16d0, code offset 0x236b
	push hl	; offset 0x236c
	ld hl,65535	; byte addr 0x16ce, code offset 0x236f
	push hl	; offset 0x2370
	ld hl,65407	; byte addr 0x16cc, code offset 0x2373
	push hl	; offset 0x2374
	ld hl,224	; byte addr 0x16ca, code offset 0x2377
	push hl	; offset 0x2378
	ld hl,65535	; byte addr 0x16c8, code offset 0x237b
	push hl	; offset 0x237c
	ld hl,65535	; byte addr 0x16c6, code offset 0x237f
	push hl	; offset 0x2380
	ld hl,65535	; byte addr 0x16c4, code offset 0x2383
	push hl	; offset 0x2384
	ld hl,65535	; byte addr 0x16c2, code offset 0x2387
	push hl	; offset 0x2388

	; src_data blit 365
	ld sp,screenStartAddr+5856	; offset 0x238b
	ld hl,65535	; byte addr 0x16e0, code offset 0x238e
	push hl	; offset 0x238f
	ld hl,65535	; byte addr 0x16de, code offset 0x2392
	push hl	; offset 0x2393
	ld hl,65535	; byte addr 0x16dc, code offset 0x2396
	push hl	; offset 0x2397
	ld hl,32512	; byte addr 0x16da, code offset 0x239a
	push hl	; offset 0x239b
	ld hl,224	; byte addr 0x16d8, code offset 0x239e
	push hl	; offset 0x239f
	ld hl,65535	; byte addr 0x16d6, code offset 0x23a2
	push hl	; offset 0x23a3
	ld hl,256	; byte addr 0x16d4, code offset 0x23a6
	push hl	; offset 0x23a7
	ld hl,0	; byte addr 0x16d2, code offset 0x23aa
	push hl	; offset 0x23ab

	; attr draw 19, code offset 0x23ab
	ld sp,attr8and16vals+76
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

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
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+608
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+608),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 19, offset 0x2404
	; Clock offset: -864


	; src_data blit 366
	ld sp,screenStartAddr+6096	; offset 0x2407
	ld hl,128	; byte addr 0x17d0, code offset 0x240a
	push hl	; offset 0x240b
	ld hl,65535	; byte addr 0x17ce, code offset 0x240e
	push hl	; offset 0x240f
	ld hl,65535	; byte addr 0x17cc, code offset 0x2412
	push hl	; offset 0x2413
	ld hl,896	; byte addr 0x17ca, code offset 0x2416
	push hl	; offset 0x2417
	ld hl,65535	; byte addr 0x17c8, code offset 0x241a
	push hl	; offset 0x241b
	ld hl,65535	; byte addr 0x17c6, code offset 0x241e
	push hl	; offset 0x241f
	ld hl,65535	; byte addr 0x17c4, code offset 0x2422
	push hl	; offset 0x2423
	ld hl,65535	; byte addr 0x17c2, code offset 0x2426
	push hl	; offset 0x2427

	; src_data blit 367
	ld sp,screenStartAddr+6112	; offset 0x242a
	ld hl,65535	; byte addr 0x17e0, code offset 0x242d
	push hl	; offset 0x242e
	ld hl,65535	; byte addr 0x17de, code offset 0x2431
	push hl	; offset 0x2432
	ld hl,65535	; byte addr 0x17dc, code offset 0x2435
	push hl	; offset 0x2436
	ld hl,3840	; byte addr 0x17da, code offset 0x2439
	push hl	; offset 0x243a
	ld hl,255	; byte addr 0x17d8, code offset 0x243d
	push hl	; offset 0x243e
	ld hl,65535	; byte addr 0x17d6, code offset 0x2441
	push hl	; offset 0x2442
	ld hl,0	; byte addr 0x17d4, code offset 0x2445
	push hl	; offset 0x2446
	ld hl,12	; byte addr 0x17d2, code offset 0x2449
	push hl	; offset 0x244a

	; src_data blit 368
	ld sp,screenStartAddr+4336	; offset 0x244d
	ld hl,0	; byte addr 0x10f0, code offset 0x2450
	push hl	; offset 0x2451
	ld hl,65535	; byte addr 0x10ee, code offset 0x2454
	push hl	; offset 0x2455
	ld hl,65535	; byte addr 0x10ec, code offset 0x2458
	push hl	; offset 0x2459
	ld hl,7936	; byte addr 0x10ea, code offset 0x245c
	push hl	; offset 0x245d
	ld hl,64767	; byte addr 0x10e8, code offset 0x2460
	push hl	; offset 0x2461
	ld hl,65535	; byte addr 0x10e6, code offset 0x2464
	push hl	; offset 0x2465
	ld hl,65535	; byte addr 0x10e4, code offset 0x2468
	push hl	; offset 0x2469
	ld hl,65535	; byte addr 0x10e2, code offset 0x246c
	push hl	; offset 0x246d

	; src_data blit 369
	ld sp,screenStartAddr+4352	; offset 0x2470
	ld hl,65535	; byte addr 0x1100, code offset 0x2473
	push hl	; offset 0x2474
	ld hl,65535	; byte addr 0x10fe, code offset 0x2477
	push hl	; offset 0x2478
	ld hl,65535	; byte addr 0x10fc, code offset 0x247b
	push hl	; offset 0x247c
	ld hl,256	; byte addr 0x10fa, code offset 0x247f
	push hl	; offset 0x2480
	ld hl,65535	; byte addr 0x10f8, code offset 0x2483
	push hl	; offset 0x2484
	ld hl,65343	; byte addr 0x10f6, code offset 0x2487
	push hl	; offset 0x2488
	ld hl,0	; byte addr 0x10f4, code offset 0x248b
	push hl	; offset 0x248c
	ld hl,61695	; byte addr 0x10f2, code offset 0x248f
	push hl	; offset 0x2490

	; src_data blit 370
	ld sp,screenStartAddr+4592	; offset 0x2493
	ld hl,1792	; byte addr 0x11f0, code offset 0x2496
	push hl	; offset 0x2497
	ld hl,65279	; byte addr 0x11ee, code offset 0x249a
	push hl	; offset 0x249b
	ld hl,65535	; byte addr 0x11ec, code offset 0x249e
	push hl	; offset 0x249f
	ld hl,65280	; byte addr 0x11ea, code offset 0x24a2
	push hl	; offset 0x24a3
	ld hl,61695	; byte addr 0x11e8, code offset 0x24a6
	push hl	; offset 0x24a7
	ld hl,65535	; byte addr 0x11e6, code offset 0x24aa
	push hl	; offset 0x24ab
	ld hl,65535	; byte addr 0x11e4, code offset 0x24ae
	push hl	; offset 0x24af
	ld hl,65535	; byte addr 0x11e2, code offset 0x24b2
	push hl	; offset 0x24b3

	; src_data blit 371
	ld sp,screenStartAddr+4608	; offset 0x24b6
	ld hl,65535	; byte addr 0x1200, code offset 0x24b9
	push hl	; offset 0x24ba
	ld hl,65535	; byte addr 0x11fe, code offset 0x24bd
	push hl	; offset 0x24be
	ld hl,65343	; byte addr 0x11fc, code offset 0x24c1
	push hl	; offset 0x24c2
	ld hl,252	; byte addr 0x11fa, code offset 0x24c5
	push hl	; offset 0x24c6
	ld hl,65535	; byte addr 0x11f8, code offset 0x24c9
	push hl	; offset 0x24ca
	ld hl,65311	; byte addr 0x11f6, code offset 0x24cd
	push hl	; offset 0x24ce
	ld hl,128	; byte addr 0x11f4, code offset 0x24d1
	push hl	; offset 0x24d2
	ld hl,65535	; byte addr 0x11f2, code offset 0x24d5
	push hl	; offset 0x24d6

	; attr draw 20, code offset 0x24d6
	ld sp,attr8and16vals+80
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

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
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+640
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+640),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 20, offset 0x252f
	; Clock offset: -864


	; src_data blit 372
	ld sp,screenStartAddr+4848	; offset 0x2532
	ld hl,32512	; byte addr 0x12f0, code offset 0x2535
	push hl	; offset 0x2536
	ld hl,64767	; byte addr 0x12ee, code offset 0x2539
	push hl	; offset 0x253a
	ld hl,65535	; byte addr 0x12ec, code offset 0x253d
	push hl	; offset 0x253e
	ld hl,65295	; byte addr 0x12ea, code offset 0x2541
	push hl	; offset 0x2542
	ld hl,49407	; byte addr 0x12e8, code offset 0x2545
	push hl	; offset 0x2546
	ld hl,65535	; byte addr 0x12e6, code offset 0x2549
	push hl	; offset 0x254a
	ld hl,65535	; byte addr 0x12e4, code offset 0x254d
	push hl	; offset 0x254e
	ld hl,65535	; byte addr 0x12e2, code offset 0x2551
	push hl	; offset 0x2552

	; src_data blit 373
	ld sp,screenStartAddr+4864	; offset 0x2555
	ld hl,65535	; byte addr 0x1300, code offset 0x2558
	push hl	; offset 0x2559
	ld hl,65535	; byte addr 0x12fe, code offset 0x255c
	push hl	; offset 0x255d
	ld hl,65287	; byte addr 0x12fc, code offset 0x2560
	push hl	; offset 0x2561
	ld hl,64767	; byte addr 0x12fa, code offset 0x2564
	push hl	; offset 0x2565
	ld hl,65535	; byte addr 0x12f8, code offset 0x2568
	push hl	; offset 0x2569
	ld hl,65287	; byte addr 0x12f6, code offset 0x256c
	push hl	; offset 0x256d
	ld hl,252	; byte addr 0x12f4, code offset 0x2570
	push hl	; offset 0x2571
	ld hl,65535	; byte addr 0x12f2, code offset 0x2574
	push hl	; offset 0x2575

	; src_data blit 374
	ld sp,screenStartAddr+5104	; offset 0x2578
	ld hl,65283	; byte addr 0x13f0, code offset 0x257b
	push hl	; offset 0x257c
	ld hl,63743	; byte addr 0x13ee, code offset 0x257f
	push hl	; offset 0x2580
	ld hl,65535	; byte addr 0x13ec, code offset 0x2583
	push hl	; offset 0x2584
	ld hl,65535	; byte addr 0x13ea, code offset 0x2587
	push hl	; offset 0x2588
	ld hl,255	; byte addr 0x13e8, code offset 0x258b
	push hl	; offset 0x258c
	ld hl,65535	; byte addr 0x13e6, code offset 0x258f
	push hl	; offset 0x2590
	ld hl,65535	; byte addr 0x13e4, code offset 0x2593
	push hl	; offset 0x2594
	ld hl,65535	; byte addr 0x13e2, code offset 0x2597
	push hl	; offset 0x2598

	; src_data blit 375
	ld sp,screenStartAddr+5120	; offset 0x259b
	ld hl,65535	; byte addr 0x1400, code offset 0x259e
	push hl	; offset 0x259f
	ld hl,65535	; byte addr 0x13fe, code offset 0x25a2
	push hl	; offset 0x25a3
	ld hl,65523	; byte addr 0x13fc, code offset 0x25a6
	push hl	; offset 0x25a7
	ld hl,65535	; byte addr 0x13fa, code offset 0x25aa
	push hl	; offset 0x25ab
	ld hl,65535	; byte addr 0x13f8, code offset 0x25ae
	push hl	; offset 0x25af
	ld hl,65283	; byte addr 0x13f6, code offset 0x25b2
	push hl	; offset 0x25b3
	ld hl,49407	; byte addr 0x13f4, code offset 0x25b6
	push hl	; offset 0x25b7
	ld hl,65535	; byte addr 0x13f2, code offset 0x25ba
	push hl	; offset 0x25bb

	; src_data blit 376
	ld sp,screenStartAddr+5360	; offset 0x25be
	ld hl,65311	; byte addr 0x14f0, code offset 0x25c1
	push hl	; offset 0x25c2
	ld hl,61695	; byte addr 0x14ee, code offset 0x25c5
	push hl	; offset 0x25c6
	ld hl,65535	; byte addr 0x14ec, code offset 0x25c9
	push hl	; offset 0x25ca
	ld hl,65535	; byte addr 0x14ea, code offset 0x25cd
	push hl	; offset 0x25ce
	ld hl,2044	; byte addr 0x14e8, code offset 0x25d1
	push hl	; offset 0x25d2
	ld hl,65535	; byte addr 0x14e6, code offset 0x25d5
	push hl	; offset 0x25d6
	ld hl,65535	; byte addr 0x14e4, code offset 0x25d9
	push hl	; offset 0x25da
	ld hl,65535	; byte addr 0x14e2, code offset 0x25dd
	push hl	; offset 0x25de

	; src_data blit 377
	ld sp,screenStartAddr+5376	; offset 0x25e1
	ld hl,65535	; byte addr 0x1500, code offset 0x25e4
	push hl	; offset 0x25e5
	ld hl,65535	; byte addr 0x14fe, code offset 0x25e8
	push hl	; offset 0x25e9
	ld hl,65535	; byte addr 0x14fc, code offset 0x25ec
	push hl	; offset 0x25ed
	ld hl,65535	; byte addr 0x14fa, code offset 0x25f0
	push hl	; offset 0x25f1
	ld hl,65535	; byte addr 0x14f8, code offset 0x25f4
	push hl	; offset 0x25f5
	ld hl,65281	; byte addr 0x14f6, code offset 0x25f8
	push hl	; offset 0x25f9
	ld hl,64767	; byte addr 0x14f4, code offset 0x25fc
	push hl	; offset 0x25fd
	ld hl,65535	; byte addr 0x14f2, code offset 0x2600
	push hl	; offset 0x2601

	; attr draw 21, code offset 0x2601
	ld sp,attr8and16vals+84
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+672
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+672),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+672),hl	; dest 2
	ld hl,30840	; src 14
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
	ld hl,30840	; src 30
	ld (attrStartAddr+30+672),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 21, offset 0x265a
	; Clock offset: -864


	; src_data blit 378
	ld sp,screenStartAddr+5616	; offset 0x265d
	ld hl,65535	; byte addr 0x15f0, code offset 0x2660
	push hl	; offset 0x2661
	ld hl,57855	; byte addr 0x15ee, code offset 0x2664
	push hl	; offset 0x2665
	ld hl,65535	; byte addr 0x15ec, code offset 0x2668
	push hl	; offset 0x2669
	ld hl,65535	; byte addr 0x15ea, code offset 0x266c
	push hl	; offset 0x266d
	ld hl,32752	; byte addr 0x15e8, code offset 0x2670
	push hl	; offset 0x2671
	ld hl,65535	; byte addr 0x15e6, code offset 0x2674
	push hl	; offset 0x2675
	ld hl,65535	; byte addr 0x15e4, code offset 0x2678
	push hl	; offset 0x2679
	ld hl,65535	; byte addr 0x15e2, code offset 0x267c
	push hl	; offset 0x267d

	; src_data blit 379
	ld sp,screenStartAddr+5632	; offset 0x2680
	ld hl,65535	; byte addr 0x1600, code offset 0x2683
	push hl	; offset 0x2684
	ld hl,65535	; byte addr 0x15fe, code offset 0x2687
	push hl	; offset 0x2688
	ld hl,65535	; byte addr 0x15fc, code offset 0x268b
	push hl	; offset 0x268c
	ld hl,65535	; byte addr 0x15fa, code offset 0x268f
	push hl	; offset 0x2690
	ld hl,65535	; byte addr 0x15f8, code offset 0x2693
	push hl	; offset 0x2694
	ld hl,65472	; byte addr 0x15f6, code offset 0x2697
	push hl	; offset 0x2698
	ld hl,65535	; byte addr 0x15f4, code offset 0x269b
	push hl	; offset 0x269c
	ld hl,65535	; byte addr 0x15f2, code offset 0x269f
	push hl	; offset 0x26a0

	; src_data blit 380
	ld sp,screenStartAddr+5872	; offset 0x26a3
	ld hl,65535	; byte addr 0x16f0, code offset 0x26a6
	push hl	; offset 0x26a7
	ld hl,53247	; byte addr 0x16ee, code offset 0x26aa
	push hl	; offset 0x26ab
	ld hl,65535	; byte addr 0x16ec, code offset 0x26ae
	push hl	; offset 0x26af
	ld hl,65535	; byte addr 0x16ea, code offset 0x26b2
	push hl	; offset 0x26b3
	ld hl,65511	; byte addr 0x16e8, code offset 0x26b6
	push hl	; offset 0x26b7
	ld hl,65535	; byte addr 0x16e6, code offset 0x26ba
	push hl	; offset 0x26bb
	ld hl,65535	; byte addr 0x16e4, code offset 0x26be
	push hl	; offset 0x26bf
	ld hl,65535	; byte addr 0x16e2, code offset 0x26c2
	push hl	; offset 0x26c3

	; src_data blit 381
	ld sp,screenStartAddr+5888	; offset 0x26c6
	ld hl,65535	; byte addr 0x1700, code offset 0x26c9
	push hl	; offset 0x26ca
	ld hl,65535	; byte addr 0x16fe, code offset 0x26cd
	push hl	; offset 0x26ce
	ld hl,65535	; byte addr 0x16fc, code offset 0x26d1
	push hl	; offset 0x26d2
	ld hl,65535	; byte addr 0x16fa, code offset 0x26d5
	push hl	; offset 0x26d6
	ld hl,65535	; byte addr 0x16f8, code offset 0x26d9
	push hl	; offset 0x26da
	ld hl,32760	; byte addr 0x16f6, code offset 0x26dd
	push hl	; offset 0x26de
	ld hl,65535	; byte addr 0x16f4, code offset 0x26e1
	push hl	; offset 0x26e2
	ld hl,65535	; byte addr 0x16f2, code offset 0x26e5
	push hl	; offset 0x26e6

	; src_data blit 382
	ld sp,screenStartAddr+6128	; offset 0x26e9
	ld hl,65535	; byte addr 0x17f0, code offset 0x26ec
	push hl	; offset 0x26ed
	ld hl,65535	; byte addr 0x17ee, code offset 0x26f0
	push hl	; offset 0x26f1
	ld hl,65535	; byte addr 0x17ec, code offset 0x26f4
	push hl	; offset 0x26f5
	ld hl,65535	; byte addr 0x17ea, code offset 0x26f8
	push hl	; offset 0x26f9
	ld hl,65535	; byte addr 0x17e8, code offset 0x26fc
	push hl	; offset 0x26fd
	ld hl,65535	; byte addr 0x17e6, code offset 0x2700
	push hl	; offset 0x2701
	ld hl,65535	; byte addr 0x17e4, code offset 0x2704
	push hl	; offset 0x2705
	ld hl,65535	; byte addr 0x17e2, code offset 0x2708
	push hl	; offset 0x2709

	; src_data blit 383
	ld sp,screenStartAddr+6144	; offset 0x270c
	ld hl,65535	; byte addr 0x1800, code offset 0x270f
	push hl	; offset 0x2710
	ld hl,65535	; byte addr 0x17fe, code offset 0x2713
	push hl	; offset 0x2714
	ld hl,65535	; byte addr 0x17fc, code offset 0x2717
	push hl	; offset 0x2718
	ld hl,65535	; byte addr 0x17fa, code offset 0x271b
	push hl	; offset 0x271c
	ld hl,65535	; byte addr 0x17f8, code offset 0x271f
	push hl	; offset 0x2720
	ld hl,65535	; byte addr 0x17f6, code offset 0x2723
	push hl	; offset 0x2724
	ld hl,65535	; byte addr 0x17f4, code offset 0x2727
	push hl	; offset 0x2728
	ld hl,65535	; byte addr 0x17f2, code offset 0x272b
	push hl	; offset 0x272c

	; attr draw 22, code offset 0x272c
	ld sp,attr8and16vals+88
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
	ld de,30840	; src 20
	ld hl,30840	; src 22
	ld ix,30840	; src 4
	ld iy,30840	; src 6
	exx
	ld bc,30840	; src 10
	ld de,30840	; src 12
	ld hl,30840	; src 0

	ld sp,attrStartAddr+16+704
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+704),hl	; dest 0
	ld hl,30840	; src 2
	ld (attrStartAddr+2+704),hl	; dest 2
	ld hl,30840	; src 14
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
	ld bc,30840	; src 24
	ld de,30840	; src 26
	ld hl,30840	; src 28
	ld sp,attrStartAddr+30+704
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,30840	; src 30
	ld (attrStartAddr+30+704),hl;	 dest 30
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 22, offset 0x2785
	; Clock offset: -864


	; Scan keyboard, and send codes to accelerator ROM
	ld hl,0x3fff	; Tells the ROM we're about to send 8 bytes containing scan codes
	ld d,(hl)
	ld bc,0xfefe
	in l,(c)
	ld d,(hl)
	ld b,0xfd
	in l,(c)
	ld d,(hl)
	ld b,0xfb
	in l,(c)
	ld d,(hl)
	ld b,0xf7
	in l,(c)
	ld d,(hl)
	ld b,0xef
	in l,(c)
	ld d,(hl)
	ld b,0xdf
	in l,(c)
	ld d,(hl)
	ld b,0xbf
	in l,(c)
	ld d,(hl)
	ld b,0x7f
	in l,(c)
	ld d,(hl)

	; delay to get start of scanline (1042 T-states) at offset 0x27b2
	ld b,36
ppe_scan_delay0:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay0
		; offset 0x27ba, 1 T-states remaining
	nop   	; offset 0x27bb, -3 T-states remaining


	; attr draw 23, code offset 0x27bb
	ld sp,attr8and16vals+92
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,30840	; src 18
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
	ld hl,30840	; src 14
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
	; end attr draw 23, offset 0x2811
	; Audio list init

	ld bc,0xfe
	ld de,0x0010
	; Start of audio list at offset 0x2817, 850 entries of 2 bytes each
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	out(c),d
	; End of audio list at offset 0x2ebb


	; Restore the stack pointer
	ld sp,(spBackupAddr)	; offset 0x2ebe
	ret

	SAVEBIN "sp48.rom",0,$