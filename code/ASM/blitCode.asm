pop_push_even:
	ld (spBackupAddr),sp

	; Block attribute blit start
	ld sp,attrStartAddr+768	; Set sp to end of attr memory - code offset 0x15c

	ld hl,3662	; src offset 766, code offset 0x15f
	push hl		; code offset 0x160
	ld hl,3662	; src offset 764, code offset 0x163
	push hl		; code offset 0x164
	ld hl,3662	; src offset 762, code offset 0x167
	push hl		; code offset 0x168
	ld hl,3662	; src offset 760, code offset 0x16b
	push hl		; code offset 0x16c
	ld hl,3662	; src offset 758, code offset 0x16f
	push hl		; code offset 0x170
	ld hl,3662	; src offset 756, code offset 0x173
	push hl		; code offset 0x174
	ld hl,3662	; src offset 754, code offset 0x177
	push hl		; code offset 0x178
	ld hl,3662	; src offset 752, code offset 0x17b
	push hl		; code offset 0x17c
	ld hl,3662	; src offset 750, code offset 0x17f
	push hl		; code offset 0x180
	ld hl,3662	; src offset 748, code offset 0x183
	push hl		; code offset 0x184
	ld hl,3662	; src offset 746, code offset 0x187
	push hl		; code offset 0x188
	ld hl,3662	; src offset 744, code offset 0x18b
	push hl		; code offset 0x18c
	ld hl,3662	; src offset 742, code offset 0x18f
	push hl		; code offset 0x190
	ld hl,3662	; src offset 740, code offset 0x193
	push hl		; code offset 0x194
	ld hl,3662	; src offset 738, code offset 0x197
	push hl		; code offset 0x198
	ld hl,3662	; src offset 736, code offset 0x19b
	push hl		; code offset 0x19c
	ld hl,3662	; src offset 734, code offset 0x19f
	push hl		; code offset 0x1a0
	ld hl,3662	; src offset 732, code offset 0x1a3
	push hl		; code offset 0x1a4
	ld hl,3662	; src offset 730, code offset 0x1a7
	push hl		; code offset 0x1a8
	ld hl,3662	; src offset 728, code offset 0x1ab
	push hl		; code offset 0x1ac
	ld hl,3662	; src offset 726, code offset 0x1af
	push hl		; code offset 0x1b0
	ld hl,3662	; src offset 724, code offset 0x1b3
	push hl		; code offset 0x1b4
	ld hl,3662	; src offset 722, code offset 0x1b7
	push hl		; code offset 0x1b8
	ld hl,3662	; src offset 720, code offset 0x1bb
	push hl		; code offset 0x1bc
	ld hl,3662	; src offset 718, code offset 0x1bf
	push hl		; code offset 0x1c0
	ld hl,3662	; src offset 716, code offset 0x1c3
	push hl		; code offset 0x1c4
	ld hl,3662	; src offset 714, code offset 0x1c7
	push hl		; code offset 0x1c8
	ld hl,3662	; src offset 712, code offset 0x1cb
	push hl		; code offset 0x1cc
	ld hl,3662	; src offset 710, code offset 0x1cf
	push hl		; code offset 0x1d0
	ld hl,3662	; src offset 708, code offset 0x1d3
	push hl		; code offset 0x1d4
	ld hl,3662	; src offset 706, code offset 0x1d7
	push hl		; code offset 0x1d8
	ld hl,3662	; src offset 704, code offset 0x1db
	push hl		; code offset 0x1dc
	ld hl,3662	; src offset 702, code offset 0x1df
	push hl		; code offset 0x1e0
	ld hl,3662	; src offset 700, code offset 0x1e3
	push hl		; code offset 0x1e4
	ld hl,3662	; src offset 698, code offset 0x1e7
	push hl		; code offset 0x1e8
	ld hl,3662	; src offset 696, code offset 0x1eb
	push hl		; code offset 0x1ec
	ld hl,3662	; src offset 694, code offset 0x1ef
	push hl		; code offset 0x1f0
	ld hl,3662	; src offset 692, code offset 0x1f3
	push hl		; code offset 0x1f4
	ld hl,3662	; src offset 690, code offset 0x1f7
	push hl		; code offset 0x1f8
	ld hl,3662	; src offset 688, code offset 0x1fb
	push hl		; code offset 0x1fc
	ld hl,3662	; src offset 686, code offset 0x1ff
	push hl		; code offset 0x200
	ld hl,3662	; src offset 684, code offset 0x203
	push hl		; code offset 0x204
	ld hl,3662	; src offset 682, code offset 0x207
	push hl		; code offset 0x208
	ld hl,3662	; src offset 680, code offset 0x20b
	push hl		; code offset 0x20c
	ld hl,3662	; src offset 678, code offset 0x20f
	push hl		; code offset 0x210
	ld hl,3662	; src offset 676, code offset 0x213
	push hl		; code offset 0x214
	ld hl,3662	; src offset 674, code offset 0x217
	push hl		; code offset 0x218
	ld hl,3662	; src offset 672, code offset 0x21b
	push hl		; code offset 0x21c
	ld hl,3662	; src offset 670, code offset 0x21f
	push hl		; code offset 0x220
	ld hl,3662	; src offset 668, code offset 0x223
	push hl		; code offset 0x224
	ld hl,3662	; src offset 666, code offset 0x227
	push hl		; code offset 0x228
	ld hl,3662	; src offset 664, code offset 0x22b
	push hl		; code offset 0x22c
	ld hl,3662	; src offset 662, code offset 0x22f
	push hl		; code offset 0x230
	ld hl,3662	; src offset 660, code offset 0x233
	push hl		; code offset 0x234
	ld hl,3662	; src offset 658, code offset 0x237
	push hl		; code offset 0x238
	ld hl,3662	; src offset 656, code offset 0x23b
	push hl		; code offset 0x23c
	ld hl,3662	; src offset 654, code offset 0x23f
	push hl		; code offset 0x240
	ld hl,3662	; src offset 652, code offset 0x243
	push hl		; code offset 0x244
	ld hl,3662	; src offset 650, code offset 0x247
	push hl		; code offset 0x248
	ld hl,3662	; src offset 648, code offset 0x24b
	push hl		; code offset 0x24c
	ld hl,3662	; src offset 646, code offset 0x24f
	push hl		; code offset 0x250
	ld hl,3662	; src offset 644, code offset 0x253
	push hl		; code offset 0x254
	ld hl,3662	; src offset 642, code offset 0x257
	push hl		; code offset 0x258
	ld hl,3662	; src offset 640, code offset 0x25b
	push hl		; code offset 0x25c
	ld hl,3662	; src offset 638, code offset 0x25f
	push hl		; code offset 0x260
	ld hl,3662	; src offset 636, code offset 0x263
	push hl		; code offset 0x264
	ld hl,3662	; src offset 634, code offset 0x267
	push hl		; code offset 0x268
	ld hl,3662	; src offset 632, code offset 0x26b
	push hl		; code offset 0x26c
	ld hl,3662	; src offset 630, code offset 0x26f
	push hl		; code offset 0x270
	ld hl,3662	; src offset 628, code offset 0x273
	push hl		; code offset 0x274
	ld hl,3662	; src offset 626, code offset 0x277
	push hl		; code offset 0x278
	ld hl,3662	; src offset 624, code offset 0x27b
	push hl		; code offset 0x27c
	ld hl,3662	; src offset 622, code offset 0x27f
	push hl		; code offset 0x280
	ld hl,3662	; src offset 620, code offset 0x283
	push hl		; code offset 0x284
	ld hl,3662	; src offset 618, code offset 0x287
	push hl		; code offset 0x288
	ld hl,3662	; src offset 616, code offset 0x28b
	push hl		; code offset 0x28c
	ld hl,3662	; src offset 614, code offset 0x28f
	push hl		; code offset 0x290
	ld hl,3662	; src offset 612, code offset 0x293
	push hl		; code offset 0x294
	ld hl,3662	; src offset 610, code offset 0x297
	push hl		; code offset 0x298
	ld hl,3662	; src offset 608, code offset 0x29b
	push hl		; code offset 0x29c
	ld hl,3662	; src offset 606, code offset 0x29f
	push hl		; code offset 0x2a0
	ld hl,3662	; src offset 604, code offset 0x2a3
	push hl		; code offset 0x2a4
	ld hl,3662	; src offset 602, code offset 0x2a7
	push hl		; code offset 0x2a8
	ld hl,3662	; src offset 600, code offset 0x2ab
	push hl		; code offset 0x2ac
	ld hl,3662	; src offset 598, code offset 0x2af
	push hl		; code offset 0x2b0
	ld hl,3662	; src offset 596, code offset 0x2b3
	push hl		; code offset 0x2b4
	ld hl,3662	; src offset 594, code offset 0x2b7
	push hl		; code offset 0x2b8
	ld hl,3662	; src offset 592, code offset 0x2bb
	push hl		; code offset 0x2bc
	ld hl,3662	; src offset 590, code offset 0x2bf
	push hl		; code offset 0x2c0
	ld hl,3662	; src offset 588, code offset 0x2c3
	push hl		; code offset 0x2c4
	ld hl,3662	; src offset 586, code offset 0x2c7
	push hl		; code offset 0x2c8
	ld hl,3662	; src offset 584, code offset 0x2cb
	push hl		; code offset 0x2cc
	ld hl,3662	; src offset 582, code offset 0x2cf
	push hl		; code offset 0x2d0
	ld hl,3662	; src offset 580, code offset 0x2d3
	push hl		; code offset 0x2d4
	ld hl,3662	; src offset 578, code offset 0x2d7
	push hl		; code offset 0x2d8
	ld hl,3662	; src offset 576, code offset 0x2db
	push hl		; code offset 0x2dc
	ld hl,3662	; src offset 574, code offset 0x2df
	push hl		; code offset 0x2e0
	ld hl,3662	; src offset 572, code offset 0x2e3
	push hl		; code offset 0x2e4
	ld hl,3662	; src offset 570, code offset 0x2e7
	push hl		; code offset 0x2e8
	ld hl,3662	; src offset 568, code offset 0x2eb
	push hl		; code offset 0x2ec
	ld hl,3662	; src offset 566, code offset 0x2ef
	push hl		; code offset 0x2f0
	ld hl,3662	; src offset 564, code offset 0x2f3
	push hl		; code offset 0x2f4
	ld hl,3662	; src offset 562, code offset 0x2f7
	push hl		; code offset 0x2f8
	ld hl,3662	; src offset 560, code offset 0x2fb
	push hl		; code offset 0x2fc
	ld hl,3662	; src offset 558, code offset 0x2ff
	push hl		; code offset 0x300
	ld hl,3662	; src offset 556, code offset 0x303
	push hl		; code offset 0x304
	ld hl,3662	; src offset 554, code offset 0x307
	push hl		; code offset 0x308
	ld hl,3662	; src offset 552, code offset 0x30b
	push hl		; code offset 0x30c
	ld hl,3662	; src offset 550, code offset 0x30f
	push hl		; code offset 0x310
	ld hl,3662	; src offset 548, code offset 0x313
	push hl		; code offset 0x314
	ld hl,3662	; src offset 546, code offset 0x317
	push hl		; code offset 0x318
	ld hl,3662	; src offset 544, code offset 0x31b
	push hl		; code offset 0x31c
	ld hl,3662	; src offset 542, code offset 0x31f
	push hl		; code offset 0x320
	ld hl,3662	; src offset 540, code offset 0x323
	push hl		; code offset 0x324
	ld hl,3662	; src offset 538, code offset 0x327
	push hl		; code offset 0x328
	ld hl,3662	; src offset 536, code offset 0x32b
	push hl		; code offset 0x32c
	ld hl,3662	; src offset 534, code offset 0x32f
	push hl		; code offset 0x330
	ld hl,3662	; src offset 532, code offset 0x333
	push hl		; code offset 0x334
	ld hl,3662	; src offset 530, code offset 0x337
	push hl		; code offset 0x338
	ld hl,3662	; src offset 528, code offset 0x33b
	push hl		; code offset 0x33c
	ld hl,3662	; src offset 526, code offset 0x33f
	push hl		; code offset 0x340
	ld hl,3662	; src offset 524, code offset 0x343
	push hl		; code offset 0x344
	ld hl,3662	; src offset 522, code offset 0x347
	push hl		; code offset 0x348
	ld hl,3662	; src offset 520, code offset 0x34b
	push hl		; code offset 0x34c
	ld hl,3662	; src offset 518, code offset 0x34f
	push hl		; code offset 0x350
	ld hl,3662	; src offset 516, code offset 0x353
	push hl		; code offset 0x354
	ld hl,3662	; src offset 514, code offset 0x357
	push hl		; code offset 0x358
	ld hl,3662	; src offset 512, code offset 0x35b
	push hl		; code offset 0x35c
	ld hl,3662	; src offset 510, code offset 0x35f
	push hl		; code offset 0x360
	ld hl,3662	; src offset 508, code offset 0x363
	push hl		; code offset 0x364
	ld hl,3662	; src offset 506, code offset 0x367
	push hl		; code offset 0x368
	ld hl,3662	; src offset 504, code offset 0x36b
	push hl		; code offset 0x36c
	ld hl,3662	; src offset 502, code offset 0x36f
	push hl		; code offset 0x370
	ld hl,3662	; src offset 500, code offset 0x373
	push hl		; code offset 0x374
	ld hl,3662	; src offset 498, code offset 0x377
	push hl		; code offset 0x378
	ld hl,3662	; src offset 496, code offset 0x37b
	push hl		; code offset 0x37c
	ld hl,3662	; src offset 494, code offset 0x37f
	push hl		; code offset 0x380
	ld hl,3662	; src offset 492, code offset 0x383
	push hl		; code offset 0x384
	ld hl,3662	; src offset 490, code offset 0x387
	push hl		; code offset 0x388
	ld hl,3662	; src offset 488, code offset 0x38b
	push hl		; code offset 0x38c
	ld hl,3662	; src offset 486, code offset 0x38f
	push hl		; code offset 0x390
	ld hl,3662	; src offset 484, code offset 0x393
	push hl		; code offset 0x394
	ld hl,3662	; src offset 482, code offset 0x397
	push hl		; code offset 0x398
	ld hl,3662	; src offset 480, code offset 0x39b
	push hl		; code offset 0x39c
	ld hl,3662	; src offset 478, code offset 0x39f
	push hl		; code offset 0x3a0
	ld hl,3662	; src offset 476, code offset 0x3a3
	push hl		; code offset 0x3a4
	ld hl,3662	; src offset 474, code offset 0x3a7
	push hl		; code offset 0x3a8
	ld hl,3662	; src offset 472, code offset 0x3ab
	push hl		; code offset 0x3ac
	ld hl,3662	; src offset 470, code offset 0x3af
	push hl		; code offset 0x3b0
	ld hl,3662	; src offset 468, code offset 0x3b3
	push hl		; code offset 0x3b4
	ld hl,3662	; src offset 466, code offset 0x3b7
	push hl		; code offset 0x3b8
	ld hl,3662	; src offset 464, code offset 0x3bb
	push hl		; code offset 0x3bc
	ld hl,3662	; src offset 462, code offset 0x3bf
	push hl		; code offset 0x3c0
	ld hl,3662	; src offset 460, code offset 0x3c3
	push hl		; code offset 0x3c4
	ld hl,3662	; src offset 458, code offset 0x3c7
	push hl		; code offset 0x3c8
	ld hl,3662	; src offset 456, code offset 0x3cb
	push hl		; code offset 0x3cc
	ld hl,3662	; src offset 454, code offset 0x3cf
	push hl		; code offset 0x3d0
	ld hl,3662	; src offset 452, code offset 0x3d3
	push hl		; code offset 0x3d4
	ld hl,3662	; src offset 450, code offset 0x3d7
	push hl		; code offset 0x3d8
	ld hl,3662	; src offset 448, code offset 0x3db
	push hl		; code offset 0x3dc
	ld hl,3662	; src offset 446, code offset 0x3df
	push hl		; code offset 0x3e0
	ld hl,3662	; src offset 444, code offset 0x3e3
	push hl		; code offset 0x3e4
	ld hl,3662	; src offset 442, code offset 0x3e7
	push hl		; code offset 0x3e8
	ld hl,3662	; src offset 440, code offset 0x3eb
	push hl		; code offset 0x3ec
	ld hl,3662	; src offset 438, code offset 0x3ef
	push hl		; code offset 0x3f0
	ld hl,3662	; src offset 436, code offset 0x3f3
	push hl		; code offset 0x3f4
	ld hl,3662	; src offset 434, code offset 0x3f7
	push hl		; code offset 0x3f8
	ld hl,3662	; src offset 432, code offset 0x3fb
	push hl		; code offset 0x3fc
	ld hl,3662	; src offset 430, code offset 0x3ff
	push hl		; code offset 0x400
	ld hl,3662	; src offset 428, code offset 0x403
	push hl		; code offset 0x404
	ld hl,3662	; src offset 426, code offset 0x407
	push hl		; code offset 0x408
	ld hl,3662	; src offset 424, code offset 0x40b
	push hl		; code offset 0x40c
	ld hl,3662	; src offset 422, code offset 0x40f
	push hl		; code offset 0x410
	ld hl,3662	; src offset 420, code offset 0x413
	push hl		; code offset 0x414
	ld hl,3662	; src offset 418, code offset 0x417
	push hl		; code offset 0x418
	ld hl,3662	; src offset 416, code offset 0x41b
	push hl		; code offset 0x41c
	ld hl,3662	; src offset 414, code offset 0x41f
	push hl		; code offset 0x420
	ld hl,3662	; src offset 412, code offset 0x423
	push hl		; code offset 0x424
	ld hl,3662	; src offset 410, code offset 0x427
	push hl		; code offset 0x428
	ld hl,3662	; src offset 408, code offset 0x42b
	push hl		; code offset 0x42c
	ld hl,3662	; src offset 406, code offset 0x42f
	push hl		; code offset 0x430
	ld hl,3662	; src offset 404, code offset 0x433
	push hl		; code offset 0x434
	ld hl,3662	; src offset 402, code offset 0x437
	push hl		; code offset 0x438
	ld hl,3662	; src offset 400, code offset 0x43b
	push hl		; code offset 0x43c
	ld hl,3662	; src offset 398, code offset 0x43f
	push hl		; code offset 0x440
	ld hl,3662	; src offset 396, code offset 0x443
	push hl		; code offset 0x444
	ld hl,3662	; src offset 394, code offset 0x447
	push hl		; code offset 0x448
	ld hl,3662	; src offset 392, code offset 0x44b
	push hl		; code offset 0x44c
	ld hl,3662	; src offset 390, code offset 0x44f
	push hl		; code offset 0x450
	ld hl,3662	; src offset 388, code offset 0x453
	push hl		; code offset 0x454
	ld hl,3662	; src offset 386, code offset 0x457
	push hl		; code offset 0x458
	ld hl,3662	; src offset 384, code offset 0x45b
	push hl		; code offset 0x45c
	ld hl,3662	; src offset 382, code offset 0x45f
	push hl		; code offset 0x460
	ld hl,3662	; src offset 380, code offset 0x463
	push hl		; code offset 0x464
	ld hl,3662	; src offset 378, code offset 0x467
	push hl		; code offset 0x468
	ld hl,3662	; src offset 376, code offset 0x46b
	push hl		; code offset 0x46c
	ld hl,3662	; src offset 374, code offset 0x46f
	push hl		; code offset 0x470
	ld hl,3662	; src offset 372, code offset 0x473
	push hl		; code offset 0x474
	ld hl,3662	; src offset 370, code offset 0x477
	push hl		; code offset 0x478
	ld hl,3662	; src offset 368, code offset 0x47b
	push hl		; code offset 0x47c
	ld hl,3662	; src offset 366, code offset 0x47f
	push hl		; code offset 0x480
	ld hl,3662	; src offset 364, code offset 0x483
	push hl		; code offset 0x484
	ld hl,3662	; src offset 362, code offset 0x487
	push hl		; code offset 0x488
	ld hl,3662	; src offset 360, code offset 0x48b
	push hl		; code offset 0x48c
	ld hl,3662	; src offset 358, code offset 0x48f
	push hl		; code offset 0x490
	ld hl,3662	; src offset 356, code offset 0x493
	push hl		; code offset 0x494
	ld hl,3662	; src offset 354, code offset 0x497
	push hl		; code offset 0x498
	ld hl,3662	; src offset 352, code offset 0x49b
	push hl		; code offset 0x49c
	ld hl,3662	; src offset 350, code offset 0x49f
	push hl		; code offset 0x4a0
	ld hl,3662	; src offset 348, code offset 0x4a3
	push hl		; code offset 0x4a4
	ld hl,3662	; src offset 346, code offset 0x4a7
	push hl		; code offset 0x4a8
	ld hl,3662	; src offset 344, code offset 0x4ab
	push hl		; code offset 0x4ac
	ld hl,3662	; src offset 342, code offset 0x4af
	push hl		; code offset 0x4b0
	ld hl,3662	; src offset 340, code offset 0x4b3
	push hl		; code offset 0x4b4
	ld hl,3662	; src offset 338, code offset 0x4b7
	push hl		; code offset 0x4b8
	ld hl,3662	; src offset 336, code offset 0x4bb
	push hl		; code offset 0x4bc
	ld hl,3662	; src offset 334, code offset 0x4bf
	push hl		; code offset 0x4c0
	ld hl,3662	; src offset 332, code offset 0x4c3
	push hl		; code offset 0x4c4
	ld hl,3662	; src offset 330, code offset 0x4c7
	push hl		; code offset 0x4c8
	ld hl,3662	; src offset 328, code offset 0x4cb
	push hl		; code offset 0x4cc
	ld hl,3662	; src offset 326, code offset 0x4cf
	push hl		; code offset 0x4d0
	ld hl,3662	; src offset 324, code offset 0x4d3
	push hl		; code offset 0x4d4
	ld hl,3662	; src offset 322, code offset 0x4d7
	push hl		; code offset 0x4d8
	ld hl,3662	; src offset 320, code offset 0x4db
	push hl		; code offset 0x4dc
	ld hl,3662	; src offset 318, code offset 0x4df
	push hl		; code offset 0x4e0
	ld hl,3662	; src offset 316, code offset 0x4e3
	push hl		; code offset 0x4e4
	ld hl,3662	; src offset 314, code offset 0x4e7
	push hl		; code offset 0x4e8
	ld hl,3662	; src offset 312, code offset 0x4eb
	push hl		; code offset 0x4ec
	ld hl,3662	; src offset 310, code offset 0x4ef
	push hl		; code offset 0x4f0
	ld hl,3662	; src offset 308, code offset 0x4f3
	push hl		; code offset 0x4f4
	ld hl,3662	; src offset 306, code offset 0x4f7
	push hl		; code offset 0x4f8
	ld hl,3662	; src offset 304, code offset 0x4fb
	push hl		; code offset 0x4fc
	ld hl,3662	; src offset 302, code offset 0x4ff
	push hl		; code offset 0x500
	ld hl,3662	; src offset 300, code offset 0x503
	push hl		; code offset 0x504
	ld hl,3662	; src offset 298, code offset 0x507
	push hl		; code offset 0x508
	ld hl,3662	; src offset 296, code offset 0x50b
	push hl		; code offset 0x50c
	ld hl,3662	; src offset 294, code offset 0x50f
	push hl		; code offset 0x510
	ld hl,3662	; src offset 292, code offset 0x513
	push hl		; code offset 0x514
	ld hl,3662	; src offset 290, code offset 0x517
	push hl		; code offset 0x518
	ld hl,3662	; src offset 288, code offset 0x51b
	push hl		; code offset 0x51c
	ld hl,3662	; src offset 286, code offset 0x51f
	push hl		; code offset 0x520
	ld hl,3662	; src offset 284, code offset 0x523
	push hl		; code offset 0x524
	ld hl,3662	; src offset 282, code offset 0x527
	push hl		; code offset 0x528
	ld hl,3662	; src offset 280, code offset 0x52b
	push hl		; code offset 0x52c
	ld hl,3662	; src offset 278, code offset 0x52f
	push hl		; code offset 0x530
	ld hl,3662	; src offset 276, code offset 0x533
	push hl		; code offset 0x534
	ld hl,3662	; src offset 274, code offset 0x537
	push hl		; code offset 0x538
	ld hl,3662	; src offset 272, code offset 0x53b
	push hl		; code offset 0x53c
	ld hl,3662	; src offset 270, code offset 0x53f
	push hl		; code offset 0x540
	ld hl,3662	; src offset 268, code offset 0x543
	push hl		; code offset 0x544
	ld hl,3662	; src offset 266, code offset 0x547
	push hl		; code offset 0x548
	ld hl,3662	; src offset 264, code offset 0x54b
	push hl		; code offset 0x54c
	ld hl,3662	; src offset 262, code offset 0x54f
	push hl		; code offset 0x550
	ld hl,3662	; src offset 260, code offset 0x553
	push hl		; code offset 0x554
	ld hl,3662	; src offset 258, code offset 0x557
	push hl		; code offset 0x558
	ld hl,3662	; src offset 256, code offset 0x55b
	push hl		; code offset 0x55c
	ld hl,3662	; src offset 254, code offset 0x55f
	push hl		; code offset 0x560
	ld hl,3662	; src offset 252, code offset 0x563
	push hl		; code offset 0x564
	ld hl,3662	; src offset 250, code offset 0x567
	push hl		; code offset 0x568
	ld hl,3662	; src offset 248, code offset 0x56b
	push hl		; code offset 0x56c
	ld hl,3662	; src offset 246, code offset 0x56f
	push hl		; code offset 0x570
	ld hl,3662	; src offset 244, code offset 0x573
	push hl		; code offset 0x574
	ld hl,3662	; src offset 242, code offset 0x577
	push hl		; code offset 0x578
	ld hl,3662	; src offset 240, code offset 0x57b
	push hl		; code offset 0x57c
	ld hl,3662	; src offset 238, code offset 0x57f
	push hl		; code offset 0x580
	ld hl,3662	; src offset 236, code offset 0x583
	push hl		; code offset 0x584
	ld hl,3662	; src offset 234, code offset 0x587
	push hl		; code offset 0x588
	ld hl,3662	; src offset 232, code offset 0x58b
	push hl		; code offset 0x58c
	ld hl,3662	; src offset 230, code offset 0x58f
	push hl		; code offset 0x590
	ld hl,3662	; src offset 228, code offset 0x593
	push hl		; code offset 0x594
	ld hl,3662	; src offset 226, code offset 0x597
	push hl		; code offset 0x598
	ld hl,3662	; src offset 224, code offset 0x59b
	push hl		; code offset 0x59c
	ld hl,3662	; src offset 222, code offset 0x59f
	push hl		; code offset 0x5a0
	ld hl,3662	; src offset 220, code offset 0x5a3
	push hl		; code offset 0x5a4
	ld hl,3662	; src offset 218, code offset 0x5a7
	push hl		; code offset 0x5a8
	ld hl,3662	; src offset 216, code offset 0x5ab
	push hl		; code offset 0x5ac
	ld hl,3662	; src offset 214, code offset 0x5af
	push hl		; code offset 0x5b0
	ld hl,3662	; src offset 212, code offset 0x5b3
	push hl		; code offset 0x5b4
	ld hl,3662	; src offset 210, code offset 0x5b7
	push hl		; code offset 0x5b8
	ld hl,3662	; src offset 208, code offset 0x5bb
	push hl		; code offset 0x5bc
	ld hl,3662	; src offset 206, code offset 0x5bf
	push hl		; code offset 0x5c0
	ld hl,3662	; src offset 204, code offset 0x5c3
	push hl		; code offset 0x5c4
	ld hl,3662	; src offset 202, code offset 0x5c7
	push hl		; code offset 0x5c8
	ld hl,3662	; src offset 200, code offset 0x5cb
	push hl		; code offset 0x5cc
	ld hl,3662	; src offset 198, code offset 0x5cf
	push hl		; code offset 0x5d0
	ld hl,3662	; src offset 196, code offset 0x5d3
	push hl		; code offset 0x5d4
	ld hl,3662	; src offset 194, code offset 0x5d7
	push hl		; code offset 0x5d8
	ld hl,3662	; src offset 192, code offset 0x5db
	push hl		; code offset 0x5dc
	ld hl,3662	; src offset 190, code offset 0x5df
	push hl		; code offset 0x5e0
	ld hl,3662	; src offset 188, code offset 0x5e3
	push hl		; code offset 0x5e4
	ld hl,3662	; src offset 186, code offset 0x5e7
	push hl		; code offset 0x5e8
	ld hl,3662	; src offset 184, code offset 0x5eb
	push hl		; code offset 0x5ec
	ld hl,3662	; src offset 182, code offset 0x5ef
	push hl		; code offset 0x5f0
	ld hl,3662	; src offset 180, code offset 0x5f3
	push hl		; code offset 0x5f4
	ld hl,3662	; src offset 178, code offset 0x5f7
	push hl		; code offset 0x5f8
	ld hl,3662	; src offset 176, code offset 0x5fb
	push hl		; code offset 0x5fc
	ld hl,3662	; src offset 174, code offset 0x5ff
	push hl		; code offset 0x600
	ld hl,3662	; src offset 172, code offset 0x603
	push hl		; code offset 0x604
	ld hl,3662	; src offset 170, code offset 0x607
	push hl		; code offset 0x608
	ld hl,3662	; src offset 168, code offset 0x60b
	push hl		; code offset 0x60c
	ld hl,3662	; src offset 166, code offset 0x60f
	push hl		; code offset 0x610
	ld hl,3662	; src offset 164, code offset 0x613
	push hl		; code offset 0x614
	ld hl,3662	; src offset 162, code offset 0x617
	push hl		; code offset 0x618
	ld hl,3662	; src offset 160, code offset 0x61b
	push hl		; code offset 0x61c
	ld hl,3662	; src offset 158, code offset 0x61f
	push hl		; code offset 0x620
	ld hl,3662	; src offset 156, code offset 0x623
	push hl		; code offset 0x624
	ld hl,3662	; src offset 154, code offset 0x627
	push hl		; code offset 0x628
	ld hl,3662	; src offset 152, code offset 0x62b
	push hl		; code offset 0x62c
	ld hl,3662	; src offset 150, code offset 0x62f
	push hl		; code offset 0x630
	ld hl,3662	; src offset 148, code offset 0x633
	push hl		; code offset 0x634
	ld hl,3662	; src offset 146, code offset 0x637
	push hl		; code offset 0x638
	ld hl,3662	; src offset 144, code offset 0x63b
	push hl		; code offset 0x63c
	ld hl,3662	; src offset 142, code offset 0x63f
	push hl		; code offset 0x640
	ld hl,3662	; src offset 140, code offset 0x643
	push hl		; code offset 0x644
	ld hl,3662	; src offset 138, code offset 0x647
	push hl		; code offset 0x648
	ld hl,3662	; src offset 136, code offset 0x64b
	push hl		; code offset 0x64c
	ld hl,3662	; src offset 134, code offset 0x64f
	push hl		; code offset 0x650
	ld hl,3662	; src offset 132, code offset 0x653
	push hl		; code offset 0x654
	ld hl,3662	; src offset 130, code offset 0x657
	push hl		; code offset 0x658
	ld hl,3662	; src offset 128, code offset 0x65b
	push hl		; code offset 0x65c
	ld hl,3662	; src offset 126, code offset 0x65f
	push hl		; code offset 0x660
	ld hl,3662	; src offset 124, code offset 0x663
	push hl		; code offset 0x664
	ld hl,3662	; src offset 122, code offset 0x667
	push hl		; code offset 0x668
	ld hl,3662	; src offset 120, code offset 0x66b
	push hl		; code offset 0x66c
	ld hl,3662	; src offset 118, code offset 0x66f
	push hl		; code offset 0x670
	ld hl,3662	; src offset 116, code offset 0x673
	push hl		; code offset 0x674
	ld hl,3662	; src offset 114, code offset 0x677
	push hl		; code offset 0x678
	ld hl,3662	; src offset 112, code offset 0x67b
	push hl		; code offset 0x67c
	ld hl,3662	; src offset 110, code offset 0x67f
	push hl		; code offset 0x680
	ld hl,3662	; src offset 108, code offset 0x683
	push hl		; code offset 0x684
	ld hl,3662	; src offset 106, code offset 0x687
	push hl		; code offset 0x688
	ld hl,3662	; src offset 104, code offset 0x68b
	push hl		; code offset 0x68c
	ld hl,3662	; src offset 102, code offset 0x68f
	push hl		; code offset 0x690
	ld hl,3662	; src offset 100, code offset 0x693
	push hl		; code offset 0x694
	ld hl,3662	; src offset 98, code offset 0x697
	push hl		; code offset 0x698
	ld hl,3662	; src offset 96, code offset 0x69b
	push hl		; code offset 0x69c
	ld hl,3662	; src offset 94, code offset 0x69f
	push hl		; code offset 0x6a0
	ld hl,3662	; src offset 92, code offset 0x6a3
	push hl		; code offset 0x6a4
	ld hl,3662	; src offset 90, code offset 0x6a7
	push hl		; code offset 0x6a8
	ld hl,3662	; src offset 88, code offset 0x6ab
	push hl		; code offset 0x6ac
	ld hl,3662	; src offset 86, code offset 0x6af
	push hl		; code offset 0x6b0
	ld hl,3662	; src offset 84, code offset 0x6b3
	push hl		; code offset 0x6b4
	ld hl,3662	; src offset 82, code offset 0x6b7
	push hl		; code offset 0x6b8
	ld hl,3662	; src offset 80, code offset 0x6bb
	push hl		; code offset 0x6bc
	ld hl,3662	; src offset 78, code offset 0x6bf
	push hl		; code offset 0x6c0
	ld hl,3662	; src offset 76, code offset 0x6c3
	push hl		; code offset 0x6c4
	ld hl,3662	; src offset 74, code offset 0x6c7
	push hl		; code offset 0x6c8
	ld hl,3662	; src offset 72, code offset 0x6cb
	push hl		; code offset 0x6cc
	ld hl,3662	; src offset 70, code offset 0x6cf
	push hl		; code offset 0x6d0
	ld hl,3662	; src offset 68, code offset 0x6d3
	push hl		; code offset 0x6d4
	ld hl,3662	; src offset 66, code offset 0x6d7
	push hl		; code offset 0x6d8
	ld hl,3662	; src offset 64, code offset 0x6db
	push hl		; code offset 0x6dc
	ld hl,3662	; src offset 62, code offset 0x6df
	push hl		; code offset 0x6e0
	ld hl,3662	; src offset 60, code offset 0x6e3
	push hl		; code offset 0x6e4
	ld hl,3662	; src offset 58, code offset 0x6e7
	push hl		; code offset 0x6e8
	ld hl,3662	; src offset 56, code offset 0x6eb
	push hl		; code offset 0x6ec
	ld hl,3662	; src offset 54, code offset 0x6ef
	push hl		; code offset 0x6f0
	ld hl,3662	; src offset 52, code offset 0x6f3
	push hl		; code offset 0x6f4
	ld hl,3662	; src offset 50, code offset 0x6f7
	push hl		; code offset 0x6f8
	ld hl,3662	; src offset 48, code offset 0x6fb
	push hl		; code offset 0x6fc
	ld hl,3662	; src offset 46, code offset 0x6ff
	push hl		; code offset 0x700
	ld hl,3662	; src offset 44, code offset 0x703
	push hl		; code offset 0x704
	ld hl,3662	; src offset 42, code offset 0x707
	push hl		; code offset 0x708
	ld hl,3662	; src offset 40, code offset 0x70b
	push hl		; code offset 0x70c
	ld hl,3662	; src offset 38, code offset 0x70f
	push hl		; code offset 0x710
	ld hl,3662	; src offset 36, code offset 0x713
	push hl		; code offset 0x714
	ld hl,3662	; src offset 34, code offset 0x717
	push hl		; code offset 0x718
	ld hl,3662	; src offset 32, code offset 0x71b
	push hl		; code offset 0x71c
	ld hl,3662	; src offset 30, code offset 0x71f
	push hl		; code offset 0x720
	ld hl,3662	; src offset 28, code offset 0x723
	push hl		; code offset 0x724
	ld hl,3662	; src offset 26, code offset 0x727
	push hl		; code offset 0x728
	ld hl,3662	; src offset 24, code offset 0x72b
	push hl		; code offset 0x72c
	ld hl,3662	; src offset 22, code offset 0x72f
	push hl		; code offset 0x730
	ld hl,3662	; src offset 20, code offset 0x733
	push hl		; code offset 0x734
	ld hl,3662	; src offset 18, code offset 0x737
	push hl		; code offset 0x738
	ld hl,3662	; src offset 16, code offset 0x73b
	push hl		; code offset 0x73c
	ld hl,3662	; src offset 14, code offset 0x73f
	push hl		; code offset 0x740
	ld hl,3662	; src offset 12, code offset 0x743
	push hl		; code offset 0x744
	ld hl,3662	; src offset 10, code offset 0x747
	push hl		; code offset 0x748
	ld hl,3662	; src offset 8, code offset 0x74b
	push hl		; code offset 0x74c
	ld hl,3662	; src offset 6, code offset 0x74f
	push hl		; code offset 0x750
	ld hl,3662	; src offset 4, code offset 0x753
	push hl		; code offset 0x754
	ld hl,3662	; src offset 2, code offset 0x757
	push hl		; code offset 0x758
	ld hl,3662	; src offset 0, code offset 0x75b
	push hl		; code offset 0x75c

	; Block attribute blit end

	; delay to get start of scanline (30 T-states) at offset 0x75c
	ld b,1
ppe_scan_delay0:
	nop
	nop
	nop
	nop
	djnz ppe_scan_delay0
		; offset 0x764, 4 T-states remaining
	nop   	; offset 0x765, 0 T-states remaining

	; src_data blit 0
	ld sp,screenStartAddr+12	; offset 0x768
	ld hl,44975	; offset 0x76b
	push hl	; offset 0x76c
	ld hl,44975	; offset 0x76f
	push hl	; offset 0x770
	ld hl,44975	; offset 0x773
	push hl	; offset 0x774
	ld hl,44975	; offset 0x777
	push hl	; offset 0x778
	ld hl,44975	; offset 0x77b
	push hl	; offset 0x77c
	ld hl,44975	; offset 0x77f
	push hl	; offset 0x780
	; src_data blit 1
	ld sp,screenStartAddr+24	; offset 0x783
	ld hl,44975	; offset 0x786
	push hl	; offset 0x787
	ld hl,44975	; offset 0x78a
	push hl	; offset 0x78b
	ld hl,44975	; offset 0x78e
	push hl	; offset 0x78f
	ld hl,44975	; offset 0x792
	push hl	; offset 0x793
	ld hl,44975	; offset 0x796
	push hl	; offset 0x797
	ld hl,44975	; offset 0x79a
	push hl	; offset 0x79b
	; src_data blit 2
	ld sp,screenStartAddr+276	; offset 0x79e
	ld hl,44975	; offset 0x7a1
	push hl	; offset 0x7a2
	ld hl,44975	; offset 0x7a5
	push hl	; offset 0x7a6
	ld hl,44975	; offset 0x7a9
	push hl	; offset 0x7aa
	ld hl,44975	; offset 0x7ad
	push hl	; offset 0x7ae
	ld hl,44975	; offset 0x7b1
	push hl	; offset 0x7b2
	ld hl,44975	; offset 0x7b5
	push hl	; offset 0x7b6

	; attr draw 0
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+0
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+0),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+0),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+0
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+0),hl;	 dest 30
	; end attr draw 0, offset 0x95d
	; Clock offset: -1152

	; src_data blit 3
	ld sp,screenStartAddr+288	; offset 0x960
	ld hl,44975	; offset 0x963
	push hl	; offset 0x964
	ld hl,44975	; offset 0x967
	push hl	; offset 0x968
	ld hl,44975	; offset 0x96b
	push hl	; offset 0x96c
	ld hl,44975	; offset 0x96f
	push hl	; offset 0x970
	ld hl,44975	; offset 0x973
	push hl	; offset 0x974
	ld hl,44975	; offset 0x977
	push hl	; offset 0x978
	; src_data blit 4
	ld sp,screenStartAddr+528	; offset 0x97b
	ld hl,44975	; offset 0x97e
	push hl	; offset 0x97f
	ld hl,44975	; offset 0x982
	push hl	; offset 0x983
	ld hl,44975	; offset 0x986
	push hl	; offset 0x987
	ld hl,44975	; offset 0x98a
	push hl	; offset 0x98b
	ld hl,44975	; offset 0x98e
	push hl	; offset 0x98f
	ld hl,44975	; offset 0x992
	push hl	; offset 0x993
	; src_data blit 5
	ld sp,screenStartAddr+540	; offset 0x996
	ld hl,44975	; offset 0x999
	push hl	; offset 0x99a
	ld hl,44975	; offset 0x99d
	push hl	; offset 0x99e
	ld hl,44975	; offset 0x9a1
	push hl	; offset 0x9a2
	ld hl,44975	; offset 0x9a5
	push hl	; offset 0x9a6
	ld hl,44975	; offset 0x9a9
	push hl	; offset 0x9aa
	ld hl,44975	; offset 0x9ad
	push hl	; offset 0x9ae
	; src_data blit 6
	ld sp,screenStartAddr+780	; offset 0x9b1
	ld hl,44975	; offset 0x9b4
	push hl	; offset 0x9b5
	ld hl,44975	; offset 0x9b8
	push hl	; offset 0x9b9
	ld hl,44975	; offset 0x9bc
	push hl	; offset 0x9bd
	ld hl,44975	; offset 0x9c0
	push hl	; offset 0x9c1
	ld hl,44975	; offset 0x9c4
	push hl	; offset 0x9c5
	ld hl,44975	; offset 0x9c8
	push hl	; offset 0x9c9
	; src_data blit 7
	ld sp,screenStartAddr+792	; offset 0x9cc
	ld hl,44975	; offset 0x9cf
	push hl	; offset 0x9d0
	ld hl,44975	; offset 0x9d3
	push hl	; offset 0x9d4
	ld hl,44975	; offset 0x9d7
	push hl	; offset 0x9d8
	ld hl,44975	; offset 0x9db
	push hl	; offset 0x9dc
	ld hl,44975	; offset 0x9df
	push hl	; offset 0x9e0
	ld hl,44975	; offset 0x9e3
	push hl	; offset 0x9e4
	; src_data blit 8
	ld sp,screenStartAddr+1044	; offset 0x9e7
	ld hl,44975	; offset 0x9ea
	push hl	; offset 0x9eb
	ld hl,44975	; offset 0x9ee
	push hl	; offset 0x9ef
	ld hl,44975	; offset 0x9f2
	push hl	; offset 0x9f3
	ld hl,44975	; offset 0x9f6
	push hl	; offset 0x9f7
	ld hl,44975	; offset 0x9fa
	push hl	; offset 0x9fb
	ld hl,44975	; offset 0x9fe
	push hl	; offset 0x9ff
	; src_data blit 9
	ld sp,screenStartAddr+1056	; offset 0xa02
	ld hl,44975	; offset 0xa05
	push hl	; offset 0xa06
	ld hl,44975	; offset 0xa09
	push hl	; offset 0xa0a
	ld hl,44975	; offset 0xa0d
	push hl	; offset 0xa0e
	ld hl,44975	; offset 0xa11
	push hl	; offset 0xa12
	ld hl,44975	; offset 0xa15
	push hl	; offset 0xa16
	ld hl,44975	; offset 0xa19
	push hl	; offset 0xa1a
	; src_data blit 10
	ld sp,screenStartAddr+1296	; offset 0xa1d
	ld hl,44975	; offset 0xa20
	push hl	; offset 0xa21
	ld hl,44975	; offset 0xa24
	push hl	; offset 0xa25
	ld hl,44975	; offset 0xa28
	push hl	; offset 0xa29
	ld hl,44975	; offset 0xa2c
	push hl	; offset 0xa2d
	ld hl,44975	; offset 0xa30
	push hl	; offset 0xa31
	ld hl,44975	; offset 0xa34
	push hl	; offset 0xa35

	; attr draw 1
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+32
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+32),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+32),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+32
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+32),hl;	 dest 30
	; end attr draw 1, offset 0xbdc
	; Clock offset: -1152

	; src_data blit 11
	ld sp,screenStartAddr+1308	; offset 0xbdf
	ld hl,44975	; offset 0xbe2
	push hl	; offset 0xbe3
	ld hl,44975	; offset 0xbe6
	push hl	; offset 0xbe7
	ld hl,44975	; offset 0xbea
	push hl	; offset 0xbeb
	ld hl,44975	; offset 0xbee
	push hl	; offset 0xbef
	ld hl,44975	; offset 0xbf2
	push hl	; offset 0xbf3
	ld hl,44975	; offset 0xbf6
	push hl	; offset 0xbf7
	; src_data blit 12
	ld sp,screenStartAddr+1548	; offset 0xbfa
	ld hl,44975	; offset 0xbfd
	push hl	; offset 0xbfe
	ld hl,44975	; offset 0xc01
	push hl	; offset 0xc02
	ld hl,44975	; offset 0xc05
	push hl	; offset 0xc06
	ld hl,44975	; offset 0xc09
	push hl	; offset 0xc0a
	ld hl,44975	; offset 0xc0d
	push hl	; offset 0xc0e
	ld hl,44975	; offset 0xc11
	push hl	; offset 0xc12
	; src_data blit 13
	ld sp,screenStartAddr+1560	; offset 0xc15
	ld hl,44975	; offset 0xc18
	push hl	; offset 0xc19
	ld hl,44975	; offset 0xc1c
	push hl	; offset 0xc1d
	ld hl,44975	; offset 0xc20
	push hl	; offset 0xc21
	ld hl,44975	; offset 0xc24
	push hl	; offset 0xc25
	ld hl,44975	; offset 0xc28
	push hl	; offset 0xc29
	ld hl,44975	; offset 0xc2c
	push hl	; offset 0xc2d
	; src_data blit 14
	ld sp,screenStartAddr+1812	; offset 0xc30
	ld hl,44975	; offset 0xc33
	push hl	; offset 0xc34
	ld hl,44975	; offset 0xc37
	push hl	; offset 0xc38
	ld hl,44975	; offset 0xc3b
	push hl	; offset 0xc3c
	ld hl,44975	; offset 0xc3f
	push hl	; offset 0xc40
	ld hl,44975	; offset 0xc43
	push hl	; offset 0xc44
	ld hl,44975	; offset 0xc47
	push hl	; offset 0xc48
	; src_data blit 15
	ld sp,screenStartAddr+1824	; offset 0xc4b
	ld hl,44975	; offset 0xc4e
	push hl	; offset 0xc4f
	ld hl,44975	; offset 0xc52
	push hl	; offset 0xc53
	ld hl,44975	; offset 0xc56
	push hl	; offset 0xc57
	ld hl,44975	; offset 0xc5a
	push hl	; offset 0xc5b
	ld hl,44975	; offset 0xc5e
	push hl	; offset 0xc5f
	ld hl,44975	; offset 0xc62
	push hl	; offset 0xc63
	; src_data blit 16
	ld sp,screenStartAddr+36	; offset 0xc66
	ld hl,44975	; offset 0xc69
	push hl	; offset 0xc6a
	ld hl,44975	; offset 0xc6d
	push hl	; offset 0xc6e
	ld hl,44975	; offset 0xc71
	push hl	; offset 0xc72
	ld hl,44975	; offset 0xc75
	push hl	; offset 0xc76
	ld hl,44975	; offset 0xc79
	push hl	; offset 0xc7a
	ld hl,44975	; offset 0xc7d
	push hl	; offset 0xc7e
	; src_data blit 17
	ld sp,screenStartAddr+264	; offset 0xc81
	ld hl,44975	; offset 0xc84
	push hl	; offset 0xc85
	ld hl,44975	; offset 0xc88
	push hl	; offset 0xc89
	ld hl,44975	; offset 0xc8c
	push hl	; offset 0xc8d
	ld hl,44975	; offset 0xc90
	push hl	; offset 0xc91
	ld hl,44975	; offset 0xc94
	push hl	; offset 0xc95
	ld hl,44975	; offset 0xc98
	push hl	; offset 0xc99
	; src_data blit 18
	ld sp,screenStartAddr+516	; offset 0xc9c
	ld hl,44975	; offset 0xc9f
	push hl	; offset 0xca0
	ld hl,44975	; offset 0xca3
	push hl	; offset 0xca4
	ld hl,44975	; offset 0xca7
	push hl	; offset 0xca8
	ld hl,44975	; offset 0xcab
	push hl	; offset 0xcac
	ld hl,44975	; offset 0xcaf
	push hl	; offset 0xcb0
	ld hl,44975	; offset 0xcb3
	push hl	; offset 0xcb4

	; attr draw 2
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+64
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+64),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+64),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+64
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+64),hl;	 dest 30
	; end attr draw 2, offset 0xe5b
	; Clock offset: -1152

	; src_data blit 19
	ld sp,screenStartAddr+552	; offset 0xe5e
	ld hl,44975	; offset 0xe61
	push hl	; offset 0xe62
	ld hl,44975	; offset 0xe65
	push hl	; offset 0xe66
	ld hl,44975	; offset 0xe69
	push hl	; offset 0xe6a
	ld hl,44975	; offset 0xe6d
	push hl	; offset 0xe6e
	ld hl,44975	; offset 0xe71
	push hl	; offset 0xe72
	ld hl,44975	; offset 0xe75
	push hl	; offset 0xe76
	; src_data blit 20
	ld sp,screenStartAddr+804	; offset 0xe79
	ld hl,44975	; offset 0xe7c
	push hl	; offset 0xe7d
	ld hl,44975	; offset 0xe80
	push hl	; offset 0xe81
	ld hl,44975	; offset 0xe84
	push hl	; offset 0xe85
	ld hl,44975	; offset 0xe88
	push hl	; offset 0xe89
	ld hl,44975	; offset 0xe8c
	push hl	; offset 0xe8d
	ld hl,44975	; offset 0xe90
	push hl	; offset 0xe91
	; src_data blit 21
	ld sp,screenStartAddr+1032	; offset 0xe94
	ld hl,44975	; offset 0xe97
	push hl	; offset 0xe98
	ld hl,44975	; offset 0xe9b
	push hl	; offset 0xe9c
	ld hl,44975	; offset 0xe9f
	push hl	; offset 0xea0
	ld hl,44975	; offset 0xea3
	push hl	; offset 0xea4
	ld hl,44975	; offset 0xea7
	push hl	; offset 0xea8
	ld hl,44975	; offset 0xeab
	push hl	; offset 0xeac
	; src_data blit 22
	ld sp,screenStartAddr+1284	; offset 0xeaf
	ld hl,44975	; offset 0xeb2
	push hl	; offset 0xeb3
	ld hl,44975	; offset 0xeb6
	push hl	; offset 0xeb7
	ld hl,44975	; offset 0xeba
	push hl	; offset 0xebb
	ld hl,44975	; offset 0xebe
	push hl	; offset 0xebf
	ld hl,44975	; offset 0xec2
	push hl	; offset 0xec3
	ld hl,44975	; offset 0xec6
	push hl	; offset 0xec7
	; src_data blit 23
	ld sp,screenStartAddr+1320	; offset 0xeca
	ld hl,44975	; offset 0xecd
	push hl	; offset 0xece
	ld hl,44975	; offset 0xed1
	push hl	; offset 0xed2
	ld hl,44975	; offset 0xed5
	push hl	; offset 0xed6
	ld hl,44975	; offset 0xed9
	push hl	; offset 0xeda
	ld hl,44975	; offset 0xedd
	push hl	; offset 0xede
	ld hl,44975	; offset 0xee1
	push hl	; offset 0xee2
	; src_data blit 24
	ld sp,screenStartAddr+1572	; offset 0xee5
	ld hl,44975	; offset 0xee8
	push hl	; offset 0xee9
	ld hl,44975	; offset 0xeec
	push hl	; offset 0xeed
	ld hl,44975	; offset 0xef0
	push hl	; offset 0xef1
	ld hl,44975	; offset 0xef4
	push hl	; offset 0xef5
	ld hl,44975	; offset 0xef8
	push hl	; offset 0xef9
	ld hl,44975	; offset 0xefc
	push hl	; offset 0xefd
	; src_data blit 25
	ld sp,screenStartAddr+1800	; offset 0xf00
	ld hl,44975	; offset 0xf03
	push hl	; offset 0xf04
	ld hl,44975	; offset 0xf07
	push hl	; offset 0xf08
	ld hl,44975	; offset 0xf0b
	push hl	; offset 0xf0c
	ld hl,44975	; offset 0xf0f
	push hl	; offset 0xf10
	ld hl,44975	; offset 0xf13
	push hl	; offset 0xf14
	ld hl,44975	; offset 0xf17
	push hl	; offset 0xf18
	; src_data blit 26
	ld sp,screenStartAddr+48	; offset 0xf1b
	ld hl,44975	; offset 0xf1e
	push hl	; offset 0xf1f
	ld hl,44975	; offset 0xf22
	push hl	; offset 0xf23
	ld hl,44975	; offset 0xf26
	push hl	; offset 0xf27
	ld hl,44975	; offset 0xf2a
	push hl	; offset 0xf2b
	ld hl,44975	; offset 0xf2e
	push hl	; offset 0xf2f
	ld hl,44975	; offset 0xf32
	push hl	; offset 0xf33

	; attr draw 3
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+96
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+96),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+96),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+96
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+96),hl;	 dest 30
	; end attr draw 3, offset 0x10da
	; Clock offset: -1152

	; src_data blit 27
	ld sp,screenStartAddr+60	; offset 0x10dd
	ld hl,44975	; offset 0x10e0
	push hl	; offset 0x10e1
	ld hl,44975	; offset 0x10e4
	push hl	; offset 0x10e5
	ld hl,44975	; offset 0x10e8
	push hl	; offset 0x10e9
	ld hl,44975	; offset 0x10ec
	push hl	; offset 0x10ed
	ld hl,44975	; offset 0x10f0
	push hl	; offset 0x10f1
	ld hl,44975	; offset 0x10f4
	push hl	; offset 0x10f5
	; src_data blit 28
	ld sp,screenStartAddr+72	; offset 0x10f8
	ld hl,44975	; offset 0x10fb
	push hl	; offset 0x10fc
	ld hl,44975	; offset 0x10ff
	push hl	; offset 0x1100
	ld hl,44975	; offset 0x1103
	push hl	; offset 0x1104
	ld hl,44975	; offset 0x1107
	push hl	; offset 0x1108
	ld hl,44975	; offset 0x110b
	push hl	; offset 0x110c
	ld hl,44975	; offset 0x110f
	push hl	; offset 0x1110
	; src_data blit 29
	ld sp,screenStartAddr+300	; offset 0x1113
	ld hl,44975	; offset 0x1116
	push hl	; offset 0x1117
	ld hl,44975	; offset 0x111a
	push hl	; offset 0x111b
	ld hl,44975	; offset 0x111e
	push hl	; offset 0x111f
	ld hl,44975	; offset 0x1122
	push hl	; offset 0x1123
	ld hl,44975	; offset 0x1126
	push hl	; offset 0x1127
	ld hl,44975	; offset 0x112a
	push hl	; offset 0x112b
	; src_data blit 30
	ld sp,screenStartAddr+312	; offset 0x112e
	ld hl,44975	; offset 0x1131
	push hl	; offset 0x1132
	ld hl,44975	; offset 0x1135
	push hl	; offset 0x1136
	ld hl,44975	; offset 0x1139
	push hl	; offset 0x113a
	ld hl,44975	; offset 0x113d
	push hl	; offset 0x113e
	ld hl,44975	; offset 0x1141
	push hl	; offset 0x1142
	ld hl,44975	; offset 0x1145
	push hl	; offset 0x1146
	; src_data blit 31
	ld sp,screenStartAddr+324	; offset 0x1149
	ld hl,44975	; offset 0x114c
	push hl	; offset 0x114d
	ld hl,44975	; offset 0x1150
	push hl	; offset 0x1151
	ld hl,44975	; offset 0x1154
	push hl	; offset 0x1155
	ld hl,44975	; offset 0x1158
	push hl	; offset 0x1159
	ld hl,44975	; offset 0x115c
	push hl	; offset 0x115d
	ld hl,44975	; offset 0x1160
	push hl	; offset 0x1161
	; src_data blit 32
	ld sp,screenStartAddr+564	; offset 0x1164
	ld hl,44975	; offset 0x1167
	push hl	; offset 0x1168
	ld hl,44975	; offset 0x116b
	push hl	; offset 0x116c
	ld hl,44975	; offset 0x116f
	push hl	; offset 0x1170
	ld hl,44975	; offset 0x1173
	push hl	; offset 0x1174
	ld hl,44975	; offset 0x1177
	push hl	; offset 0x1178
	ld hl,44975	; offset 0x117b
	push hl	; offset 0x117c
	; src_data blit 33
	ld sp,screenStartAddr+576	; offset 0x117f
	ld hl,44975	; offset 0x1182
	push hl	; offset 0x1183
	ld hl,44975	; offset 0x1186
	push hl	; offset 0x1187
	ld hl,44975	; offset 0x118a
	push hl	; offset 0x118b
	ld hl,44975	; offset 0x118e
	push hl	; offset 0x118f
	ld hl,44975	; offset 0x1192
	push hl	; offset 0x1193
	ld hl,44975	; offset 0x1196
	push hl	; offset 0x1197
	; src_data blit 34
	ld sp,screenStartAddr+816	; offset 0x119a
	ld hl,44975	; offset 0x119d
	push hl	; offset 0x119e
	ld hl,44975	; offset 0x11a1
	push hl	; offset 0x11a2
	ld hl,44975	; offset 0x11a5
	push hl	; offset 0x11a6
	ld hl,44975	; offset 0x11a9
	push hl	; offset 0x11aa
	ld hl,44975	; offset 0x11ad
	push hl	; offset 0x11ae
	ld hl,44975	; offset 0x11b1
	push hl	; offset 0x11b2

	; attr draw 4
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+128
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+128),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+128),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+128
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+128),hl;	 dest 30
	; end attr draw 4, offset 0x1359
	; Clock offset: -1152

	; src_data blit 35
	ld sp,screenStartAddr+828	; offset 0x135c
	ld hl,44975	; offset 0x135f
	push hl	; offset 0x1360
	ld hl,44975	; offset 0x1363
	push hl	; offset 0x1364
	ld hl,44975	; offset 0x1367
	push hl	; offset 0x1368
	ld hl,44975	; offset 0x136b
	push hl	; offset 0x136c
	ld hl,44975	; offset 0x136f
	push hl	; offset 0x1370
	ld hl,44975	; offset 0x1373
	push hl	; offset 0x1374
	; src_data blit 36
	ld sp,screenStartAddr+840	; offset 0x1377
	ld hl,44975	; offset 0x137a
	push hl	; offset 0x137b
	ld hl,44975	; offset 0x137e
	push hl	; offset 0x137f
	ld hl,44975	; offset 0x1382
	push hl	; offset 0x1383
	ld hl,44975	; offset 0x1386
	push hl	; offset 0x1387
	ld hl,44975	; offset 0x138a
	push hl	; offset 0x138b
	ld hl,44975	; offset 0x138e
	push hl	; offset 0x138f
	; src_data blit 37
	ld sp,screenStartAddr+1068	; offset 0x1392
	ld hl,44975	; offset 0x1395
	push hl	; offset 0x1396
	ld hl,44975	; offset 0x1399
	push hl	; offset 0x139a
	ld hl,44975	; offset 0x139d
	push hl	; offset 0x139e
	ld hl,44975	; offset 0x13a1
	push hl	; offset 0x13a2
	ld hl,44975	; offset 0x13a5
	push hl	; offset 0x13a6
	ld hl,44975	; offset 0x13a9
	push hl	; offset 0x13aa
	; src_data blit 38
	ld sp,screenStartAddr+1080	; offset 0x13ad
	ld hl,44975	; offset 0x13b0
	push hl	; offset 0x13b1
	ld hl,44975	; offset 0x13b4
	push hl	; offset 0x13b5
	ld hl,44975	; offset 0x13b8
	push hl	; offset 0x13b9
	ld hl,44975	; offset 0x13bc
	push hl	; offset 0x13bd
	ld hl,44975	; offset 0x13c0
	push hl	; offset 0x13c1
	ld hl,44975	; offset 0x13c4
	push hl	; offset 0x13c5
	; src_data blit 39
	ld sp,screenStartAddr+1092	; offset 0x13c8
	ld hl,44975	; offset 0x13cb
	push hl	; offset 0x13cc
	ld hl,44975	; offset 0x13cf
	push hl	; offset 0x13d0
	ld hl,44975	; offset 0x13d3
	push hl	; offset 0x13d4
	ld hl,44975	; offset 0x13d7
	push hl	; offset 0x13d8
	ld hl,44975	; offset 0x13db
	push hl	; offset 0x13dc
	ld hl,44975	; offset 0x13df
	push hl	; offset 0x13e0
	; src_data blit 40
	ld sp,screenStartAddr+1332	; offset 0x13e3
	ld hl,44975	; offset 0x13e6
	push hl	; offset 0x13e7
	ld hl,44975	; offset 0x13ea
	push hl	; offset 0x13eb
	ld hl,44975	; offset 0x13ee
	push hl	; offset 0x13ef
	ld hl,44975	; offset 0x13f2
	push hl	; offset 0x13f3
	ld hl,44975	; offset 0x13f6
	push hl	; offset 0x13f7
	ld hl,44975	; offset 0x13fa
	push hl	; offset 0x13fb
	; src_data blit 41
	ld sp,screenStartAddr+1344	; offset 0x13fe
	ld hl,44975	; offset 0x1401
	push hl	; offset 0x1402
	ld hl,44975	; offset 0x1405
	push hl	; offset 0x1406
	ld hl,44975	; offset 0x1409
	push hl	; offset 0x140a
	ld hl,44975	; offset 0x140d
	push hl	; offset 0x140e
	ld hl,44975	; offset 0x1411
	push hl	; offset 0x1412
	ld hl,44975	; offset 0x1415
	push hl	; offset 0x1416
	; src_data blit 42
	ld sp,screenStartAddr+1584	; offset 0x1419
	ld hl,44975	; offset 0x141c
	push hl	; offset 0x141d
	ld hl,44975	; offset 0x1420
	push hl	; offset 0x1421
	ld hl,44975	; offset 0x1424
	push hl	; offset 0x1425
	ld hl,44975	; offset 0x1428
	push hl	; offset 0x1429
	ld hl,44975	; offset 0x142c
	push hl	; offset 0x142d
	ld hl,44975	; offset 0x1430
	push hl	; offset 0x1431

	; attr draw 5
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+160
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+160),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+160),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+160
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+160),hl;	 dest 30
	; end attr draw 5, offset 0x15d8
	; Clock offset: -1152

	; src_data blit 43
	ld sp,screenStartAddr+1596	; offset 0x15db
	ld hl,44975	; offset 0x15de
	push hl	; offset 0x15df
	ld hl,44975	; offset 0x15e2
	push hl	; offset 0x15e3
	ld hl,44975	; offset 0x15e6
	push hl	; offset 0x15e7
	ld hl,44975	; offset 0x15ea
	push hl	; offset 0x15eb
	ld hl,44975	; offset 0x15ee
	push hl	; offset 0x15ef
	ld hl,44975	; offset 0x15f2
	push hl	; offset 0x15f3
	; src_data blit 44
	ld sp,screenStartAddr+1608	; offset 0x15f6
	ld hl,44975	; offset 0x15f9
	push hl	; offset 0x15fa
	ld hl,44975	; offset 0x15fd
	push hl	; offset 0x15fe
	ld hl,44975	; offset 0x1601
	push hl	; offset 0x1602
	ld hl,44975	; offset 0x1605
	push hl	; offset 0x1606
	ld hl,44975	; offset 0x1609
	push hl	; offset 0x160a
	ld hl,44975	; offset 0x160d
	push hl	; offset 0x160e
	; src_data blit 45
	ld sp,screenStartAddr+1836	; offset 0x1611
	ld hl,44975	; offset 0x1614
	push hl	; offset 0x1615
	ld hl,44975	; offset 0x1618
	push hl	; offset 0x1619
	ld hl,44975	; offset 0x161c
	push hl	; offset 0x161d
	ld hl,44975	; offset 0x1620
	push hl	; offset 0x1621
	ld hl,44975	; offset 0x1624
	push hl	; offset 0x1625
	ld hl,44975	; offset 0x1628
	push hl	; offset 0x1629
	; src_data blit 46
	ld sp,screenStartAddr+1848	; offset 0x162c
	ld hl,44975	; offset 0x162f
	push hl	; offset 0x1630
	ld hl,44975	; offset 0x1633
	push hl	; offset 0x1634
	ld hl,44975	; offset 0x1637
	push hl	; offset 0x1638
	ld hl,44975	; offset 0x163b
	push hl	; offset 0x163c
	ld hl,44975	; offset 0x163f
	push hl	; offset 0x1640
	ld hl,44975	; offset 0x1643
	push hl	; offset 0x1644
	; src_data blit 47
	ld sp,screenStartAddr+1860	; offset 0x1647
	ld hl,44975	; offset 0x164a
	push hl	; offset 0x164b
	ld hl,44975	; offset 0x164e
	push hl	; offset 0x164f
	ld hl,44975	; offset 0x1652
	push hl	; offset 0x1653
	ld hl,44975	; offset 0x1656
	push hl	; offset 0x1657
	ld hl,44975	; offset 0x165a
	push hl	; offset 0x165b
	ld hl,44975	; offset 0x165e
	push hl	; offset 0x165f
	; src_data blit 48
	ld sp,screenStartAddr+84	; offset 0x1662
	ld hl,44975	; offset 0x1665
	push hl	; offset 0x1666
	ld hl,44975	; offset 0x1669
	push hl	; offset 0x166a
	ld hl,44975	; offset 0x166d
	push hl	; offset 0x166e
	ld hl,44975	; offset 0x1671
	push hl	; offset 0x1672
	ld hl,44975	; offset 0x1675
	push hl	; offset 0x1676
	ld hl,44975	; offset 0x1679
	push hl	; offset 0x167a
	; src_data blit 49
	ld sp,screenStartAddr+96	; offset 0x167d
	ld hl,44975	; offset 0x1680
	push hl	; offset 0x1681
	ld hl,44975	; offset 0x1684
	push hl	; offset 0x1685
	ld hl,44975	; offset 0x1688
	push hl	; offset 0x1689
	ld hl,44975	; offset 0x168c
	push hl	; offset 0x168d
	ld hl,44975	; offset 0x1690
	push hl	; offset 0x1691
	ld hl,44975	; offset 0x1694
	push hl	; offset 0x1695
	; src_data blit 50
	ld sp,screenStartAddr+336	; offset 0x1698
	ld hl,44975	; offset 0x169b
	push hl	; offset 0x169c
	ld hl,44975	; offset 0x169f
	push hl	; offset 0x16a0
	ld hl,44975	; offset 0x16a3
	push hl	; offset 0x16a4
	ld hl,44975	; offset 0x16a7
	push hl	; offset 0x16a8
	ld hl,44975	; offset 0x16ab
	push hl	; offset 0x16ac
	ld hl,44975	; offset 0x16af
	push hl	; offset 0x16b0

	; attr draw 6
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+192
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+192),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+192),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+192
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+192),hl;	 dest 30
	; end attr draw 6, offset 0x1857
	; Clock offset: -1152

	; src_data blit 51
	ld sp,screenStartAddr+348	; offset 0x185a
	ld hl,44975	; offset 0x185d
	push hl	; offset 0x185e
	ld hl,44975	; offset 0x1861
	push hl	; offset 0x1862
	ld hl,44975	; offset 0x1865
	push hl	; offset 0x1866
	ld hl,44975	; offset 0x1869
	push hl	; offset 0x186a
	ld hl,44975	; offset 0x186d
	push hl	; offset 0x186e
	ld hl,44975	; offset 0x1871
	push hl	; offset 0x1872
	; src_data blit 52
	ld sp,screenStartAddr+360	; offset 0x1875
	ld hl,44975	; offset 0x1878
	push hl	; offset 0x1879
	ld hl,44975	; offset 0x187c
	push hl	; offset 0x187d
	ld hl,44975	; offset 0x1880
	push hl	; offset 0x1881
	ld hl,44975	; offset 0x1884
	push hl	; offset 0x1885
	ld hl,44975	; offset 0x1888
	push hl	; offset 0x1889
	ld hl,44975	; offset 0x188c
	push hl	; offset 0x188d
	; src_data blit 53
	ld sp,screenStartAddr+588	; offset 0x1890
	ld hl,44975	; offset 0x1893
	push hl	; offset 0x1894
	ld hl,44975	; offset 0x1897
	push hl	; offset 0x1898
	ld hl,44975	; offset 0x189b
	push hl	; offset 0x189c
	ld hl,44975	; offset 0x189f
	push hl	; offset 0x18a0
	ld hl,44975	; offset 0x18a3
	push hl	; offset 0x18a4
	ld hl,44975	; offset 0x18a7
	push hl	; offset 0x18a8
	; src_data blit 54
	ld sp,screenStartAddr+600	; offset 0x18ab
	ld hl,44975	; offset 0x18ae
	push hl	; offset 0x18af
	ld hl,44975	; offset 0x18b2
	push hl	; offset 0x18b3
	ld hl,44975	; offset 0x18b6
	push hl	; offset 0x18b7
	ld hl,44975	; offset 0x18ba
	push hl	; offset 0x18bb
	ld hl,44975	; offset 0x18be
	push hl	; offset 0x18bf
	ld hl,44975	; offset 0x18c2
	push hl	; offset 0x18c3
	; src_data blit 55
	ld sp,screenStartAddr+612	; offset 0x18c6
	ld hl,44975	; offset 0x18c9
	push hl	; offset 0x18ca
	ld hl,44975	; offset 0x18cd
	push hl	; offset 0x18ce
	ld hl,44975	; offset 0x18d1
	push hl	; offset 0x18d2
	ld hl,44975	; offset 0x18d5
	push hl	; offset 0x18d6
	ld hl,44975	; offset 0x18d9
	push hl	; offset 0x18da
	ld hl,44975	; offset 0x18dd
	push hl	; offset 0x18de
	; src_data blit 56
	ld sp,screenStartAddr+852	; offset 0x18e1
	ld hl,44975	; offset 0x18e4
	push hl	; offset 0x18e5
	ld hl,44975	; offset 0x18e8
	push hl	; offset 0x18e9
	ld hl,44975	; offset 0x18ec
	push hl	; offset 0x18ed
	ld hl,44975	; offset 0x18f0
	push hl	; offset 0x18f1
	ld hl,44975	; offset 0x18f4
	push hl	; offset 0x18f5
	ld hl,44975	; offset 0x18f8
	push hl	; offset 0x18f9
	; src_data blit 57
	ld sp,screenStartAddr+864	; offset 0x18fc
	ld hl,44975	; offset 0x18ff
	push hl	; offset 0x1900
	ld hl,44975	; offset 0x1903
	push hl	; offset 0x1904
	ld hl,44975	; offset 0x1907
	push hl	; offset 0x1908
	ld hl,44975	; offset 0x190b
	push hl	; offset 0x190c
	ld hl,44975	; offset 0x190f
	push hl	; offset 0x1910
	ld hl,44975	; offset 0x1913
	push hl	; offset 0x1914
	; src_data blit 58
	ld sp,screenStartAddr+1104	; offset 0x1917
	ld hl,44975	; offset 0x191a
	push hl	; offset 0x191b
	ld hl,44975	; offset 0x191e
	push hl	; offset 0x191f
	ld hl,44975	; offset 0x1922
	push hl	; offset 0x1923
	ld hl,44975	; offset 0x1926
	push hl	; offset 0x1927
	ld hl,44975	; offset 0x192a
	push hl	; offset 0x192b
	ld hl,44975	; offset 0x192e
	push hl	; offset 0x192f

	; attr draw 7
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+224
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+224),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+224),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+224
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+224),hl;	 dest 30
	; end attr draw 7, offset 0x1ad6
	; Clock offset: -1152

	; src_data blit 59
	ld sp,screenStartAddr+1116	; offset 0x1ad9
	ld hl,44975	; offset 0x1adc
	push hl	; offset 0x1add
	ld hl,44975	; offset 0x1ae0
	push hl	; offset 0x1ae1
	ld hl,44975	; offset 0x1ae4
	push hl	; offset 0x1ae5
	ld hl,44975	; offset 0x1ae8
	push hl	; offset 0x1ae9
	ld hl,44975	; offset 0x1aec
	push hl	; offset 0x1aed
	ld hl,44975	; offset 0x1af0
	push hl	; offset 0x1af1
	; src_data blit 60
	ld sp,screenStartAddr+1128	; offset 0x1af4
	ld hl,44975	; offset 0x1af7
	push hl	; offset 0x1af8
	ld hl,44975	; offset 0x1afb
	push hl	; offset 0x1afc
	ld hl,44975	; offset 0x1aff
	push hl	; offset 0x1b00
	ld hl,44975	; offset 0x1b03
	push hl	; offset 0x1b04
	ld hl,44975	; offset 0x1b07
	push hl	; offset 0x1b08
	ld hl,44975	; offset 0x1b0b
	push hl	; offset 0x1b0c
	; src_data blit 61
	ld sp,screenStartAddr+1356	; offset 0x1b0f
	ld hl,44975	; offset 0x1b12
	push hl	; offset 0x1b13
	ld hl,44975	; offset 0x1b16
	push hl	; offset 0x1b17
	ld hl,44975	; offset 0x1b1a
	push hl	; offset 0x1b1b
	ld hl,44975	; offset 0x1b1e
	push hl	; offset 0x1b1f
	ld hl,44975	; offset 0x1b22
	push hl	; offset 0x1b23
	ld hl,44975	; offset 0x1b26
	push hl	; offset 0x1b27
	; src_data blit 62
	ld sp,screenStartAddr+1368	; offset 0x1b2a
	ld hl,44975	; offset 0x1b2d
	push hl	; offset 0x1b2e
	ld hl,44975	; offset 0x1b31
	push hl	; offset 0x1b32
	ld hl,44975	; offset 0x1b35
	push hl	; offset 0x1b36
	ld hl,44975	; offset 0x1b39
	push hl	; offset 0x1b3a
	ld hl,44975	; offset 0x1b3d
	push hl	; offset 0x1b3e
	ld hl,44975	; offset 0x1b41
	push hl	; offset 0x1b42
	; src_data blit 63
	ld sp,screenStartAddr+1380	; offset 0x1b45
	ld hl,44975	; offset 0x1b48
	push hl	; offset 0x1b49
	ld hl,44975	; offset 0x1b4c
	push hl	; offset 0x1b4d
	ld hl,44975	; offset 0x1b50
	push hl	; offset 0x1b51
	ld hl,44975	; offset 0x1b54
	push hl	; offset 0x1b55
	ld hl,44975	; offset 0x1b58
	push hl	; offset 0x1b59
	ld hl,44975	; offset 0x1b5c
	push hl	; offset 0x1b5d
	; src_data blit 64
	ld sp,screenStartAddr+1620	; offset 0x1b60
	ld hl,44975	; offset 0x1b63
	push hl	; offset 0x1b64
	ld hl,44975	; offset 0x1b67
	push hl	; offset 0x1b68
	ld hl,44975	; offset 0x1b6b
	push hl	; offset 0x1b6c
	ld hl,44975	; offset 0x1b6f
	push hl	; offset 0x1b70
	ld hl,44975	; offset 0x1b73
	push hl	; offset 0x1b74
	ld hl,44975	; offset 0x1b77
	push hl	; offset 0x1b78
	; src_data blit 65
	ld sp,screenStartAddr+1632	; offset 0x1b7b
	ld hl,44975	; offset 0x1b7e
	push hl	; offset 0x1b7f
	ld hl,44975	; offset 0x1b82
	push hl	; offset 0x1b83
	ld hl,44975	; offset 0x1b86
	push hl	; offset 0x1b87
	ld hl,44975	; offset 0x1b8a
	push hl	; offset 0x1b8b
	ld hl,44975	; offset 0x1b8e
	push hl	; offset 0x1b8f
	ld hl,44975	; offset 0x1b92
	push hl	; offset 0x1b93
	; src_data blit 66
	ld sp,screenStartAddr+1872	; offset 0x1b96
	ld hl,44975	; offset 0x1b99
	push hl	; offset 0x1b9a
	ld hl,44975	; offset 0x1b9d
	push hl	; offset 0x1b9e
	ld hl,44975	; offset 0x1ba1
	push hl	; offset 0x1ba2
	ld hl,44975	; offset 0x1ba5
	push hl	; offset 0x1ba6
	ld hl,44975	; offset 0x1ba9
	push hl	; offset 0x1baa
	ld hl,44975	; offset 0x1bad
	push hl	; offset 0x1bae

	; attr draw 8
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+256
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+256),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+256),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+256
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+256),hl;	 dest 30
	; end attr draw 8, offset 0x1d55
	; Clock offset: -1152

	; src_data blit 67
	ld sp,screenStartAddr+1884	; offset 0x1d58
	ld hl,44975	; offset 0x1d5b
	push hl	; offset 0x1d5c
	ld hl,44975	; offset 0x1d5f
	push hl	; offset 0x1d60
	ld hl,44975	; offset 0x1d63
	push hl	; offset 0x1d64
	ld hl,44975	; offset 0x1d67
	push hl	; offset 0x1d68
	ld hl,44975	; offset 0x1d6b
	push hl	; offset 0x1d6c
	ld hl,44975	; offset 0x1d6f
	push hl	; offset 0x1d70
	; src_data blit 68
	ld sp,screenStartAddr+1896	; offset 0x1d73
	ld hl,44975	; offset 0x1d76
	push hl	; offset 0x1d77
	ld hl,44975	; offset 0x1d7a
	push hl	; offset 0x1d7b
	ld hl,44975	; offset 0x1d7e
	push hl	; offset 0x1d7f
	ld hl,44975	; offset 0x1d82
	push hl	; offset 0x1d83
	ld hl,44975	; offset 0x1d86
	push hl	; offset 0x1d87
	ld hl,44975	; offset 0x1d8a
	push hl	; offset 0x1d8b
	; src_data blit 69
	ld sp,screenStartAddr+108	; offset 0x1d8e
	ld hl,44975	; offset 0x1d91
	push hl	; offset 0x1d92
	ld hl,44975	; offset 0x1d95
	push hl	; offset 0x1d96
	ld hl,44975	; offset 0x1d99
	push hl	; offset 0x1d9a
	ld hl,44975	; offset 0x1d9d
	push hl	; offset 0x1d9e
	ld hl,44975	; offset 0x1da1
	push hl	; offset 0x1da2
	ld hl,44975	; offset 0x1da5
	push hl	; offset 0x1da6
	; src_data blit 70
	ld sp,screenStartAddr+120	; offset 0x1da9
	ld hl,44975	; offset 0x1dac
	push hl	; offset 0x1dad
	ld hl,44975	; offset 0x1db0
	push hl	; offset 0x1db1
	ld hl,44975	; offset 0x1db4
	push hl	; offset 0x1db5
	ld hl,44975	; offset 0x1db8
	push hl	; offset 0x1db9
	ld hl,44975	; offset 0x1dbc
	push hl	; offset 0x1dbd
	ld hl,44975	; offset 0x1dc0
	push hl	; offset 0x1dc1
	; src_data blit 71
	ld sp,screenStartAddr+132	; offset 0x1dc4
	ld hl,44975	; offset 0x1dc7
	push hl	; offset 0x1dc8
	ld hl,44975	; offset 0x1dcb
	push hl	; offset 0x1dcc
	ld hl,44975	; offset 0x1dcf
	push hl	; offset 0x1dd0
	ld hl,44975	; offset 0x1dd3
	push hl	; offset 0x1dd4
	ld hl,44975	; offset 0x1dd7
	push hl	; offset 0x1dd8
	ld hl,44975	; offset 0x1ddb
	push hl	; offset 0x1ddc
	; src_data blit 72
	ld sp,screenStartAddr+372	; offset 0x1ddf
	ld hl,44975	; offset 0x1de2
	push hl	; offset 0x1de3
	ld hl,44975	; offset 0x1de6
	push hl	; offset 0x1de7
	ld hl,44975	; offset 0x1dea
	push hl	; offset 0x1deb
	ld hl,44975	; offset 0x1dee
	push hl	; offset 0x1def
	ld hl,44975	; offset 0x1df2
	push hl	; offset 0x1df3
	ld hl,44975	; offset 0x1df6
	push hl	; offset 0x1df7
	; src_data blit 73
	ld sp,screenStartAddr+384	; offset 0x1dfa
	ld hl,44975	; offset 0x1dfd
	push hl	; offset 0x1dfe
	ld hl,44975	; offset 0x1e01
	push hl	; offset 0x1e02
	ld hl,44975	; offset 0x1e05
	push hl	; offset 0x1e06
	ld hl,44975	; offset 0x1e09
	push hl	; offset 0x1e0a
	ld hl,44975	; offset 0x1e0d
	push hl	; offset 0x1e0e
	ld hl,44975	; offset 0x1e11
	push hl	; offset 0x1e12
	; src_data blit 74
	ld sp,screenStartAddr+624	; offset 0x1e15
	ld hl,44975	; offset 0x1e18
	push hl	; offset 0x1e19
	ld hl,44975	; offset 0x1e1c
	push hl	; offset 0x1e1d
	ld hl,44975	; offset 0x1e20
	push hl	; offset 0x1e21
	ld hl,44975	; offset 0x1e24
	push hl	; offset 0x1e25
	ld hl,44975	; offset 0x1e28
	push hl	; offset 0x1e29
	ld hl,44975	; offset 0x1e2c
	push hl	; offset 0x1e2d

	; attr draw 9
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+288
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+288),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+288),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+288
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+288),hl;	 dest 30
	; end attr draw 9, offset 0x1fd4
	; Clock offset: -1152

	; src_data blit 75
	ld sp,screenStartAddr+636	; offset 0x1fd7
	ld hl,44975	; offset 0x1fda
	push hl	; offset 0x1fdb
	ld hl,44975	; offset 0x1fde
	push hl	; offset 0x1fdf
	ld hl,44975	; offset 0x1fe2
	push hl	; offset 0x1fe3
	ld hl,44975	; offset 0x1fe6
	push hl	; offset 0x1fe7
	ld hl,44975	; offset 0x1fea
	push hl	; offset 0x1feb
	ld hl,44975	; offset 0x1fee
	push hl	; offset 0x1fef
	; src_data blit 76
	ld sp,screenStartAddr+648	; offset 0x1ff2
	ld hl,44975	; offset 0x1ff5
	push hl	; offset 0x1ff6
	ld hl,44975	; offset 0x1ff9
	push hl	; offset 0x1ffa
	ld hl,44975	; offset 0x1ffd
	push hl	; offset 0x1ffe
	ld hl,44975	; offset 0x2001
	push hl	; offset 0x2002
	ld hl,44975	; offset 0x2005
	push hl	; offset 0x2006
	ld hl,44975	; offset 0x2009
	push hl	; offset 0x200a
	; src_data blit 77
	ld sp,screenStartAddr+876	; offset 0x200d
	ld hl,44975	; offset 0x2010
	push hl	; offset 0x2011
	ld hl,44975	; offset 0x2014
	push hl	; offset 0x2015
	ld hl,44975	; offset 0x2018
	push hl	; offset 0x2019
	ld hl,44975	; offset 0x201c
	push hl	; offset 0x201d
	ld hl,44975	; offset 0x2020
	push hl	; offset 0x2021
	ld hl,44975	; offset 0x2024
	push hl	; offset 0x2025
	; src_data blit 78
	ld sp,screenStartAddr+888	; offset 0x2028
	ld hl,44975	; offset 0x202b
	push hl	; offset 0x202c
	ld hl,44975	; offset 0x202f
	push hl	; offset 0x2030
	ld hl,44975	; offset 0x2033
	push hl	; offset 0x2034
	ld hl,44975	; offset 0x2037
	push hl	; offset 0x2038
	ld hl,44975	; offset 0x203b
	push hl	; offset 0x203c
	ld hl,44975	; offset 0x203f
	push hl	; offset 0x2040
	; src_data blit 79
	ld sp,screenStartAddr+900	; offset 0x2043
	ld hl,44975	; offset 0x2046
	push hl	; offset 0x2047
	ld hl,44975	; offset 0x204a
	push hl	; offset 0x204b
	ld hl,44975	; offset 0x204e
	push hl	; offset 0x204f
	ld hl,44975	; offset 0x2052
	push hl	; offset 0x2053
	ld hl,44975	; offset 0x2056
	push hl	; offset 0x2057
	ld hl,44975	; offset 0x205a
	push hl	; offset 0x205b
	; src_data blit 80
	ld sp,screenStartAddr+1140	; offset 0x205e
	ld hl,44975	; offset 0x2061
	push hl	; offset 0x2062
	ld hl,44975	; offset 0x2065
	push hl	; offset 0x2066
	ld hl,44975	; offset 0x2069
	push hl	; offset 0x206a
	ld hl,44975	; offset 0x206d
	push hl	; offset 0x206e
	ld hl,44975	; offset 0x2071
	push hl	; offset 0x2072
	ld hl,44975	; offset 0x2075
	push hl	; offset 0x2076
	; src_data blit 81
	ld sp,screenStartAddr+1152	; offset 0x2079
	ld hl,44975	; offset 0x207c
	push hl	; offset 0x207d
	ld hl,44975	; offset 0x2080
	push hl	; offset 0x2081
	ld hl,44975	; offset 0x2084
	push hl	; offset 0x2085
	ld hl,44975	; offset 0x2088
	push hl	; offset 0x2089
	ld hl,44975	; offset 0x208c
	push hl	; offset 0x208d
	ld hl,44975	; offset 0x2090
	push hl	; offset 0x2091
	; src_data blit 82
	ld sp,screenStartAddr+1392	; offset 0x2094
	ld hl,44975	; offset 0x2097
	push hl	; offset 0x2098
	ld hl,44975	; offset 0x209b
	push hl	; offset 0x209c
	ld hl,44975	; offset 0x209f
	push hl	; offset 0x20a0
	ld hl,44975	; offset 0x20a3
	push hl	; offset 0x20a4
	ld hl,44975	; offset 0x20a7
	push hl	; offset 0x20a8
	ld hl,44975	; offset 0x20ab
	push hl	; offset 0x20ac

	; attr draw 10
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+320
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+320),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+320),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+320
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+320),hl;	 dest 30
	; end attr draw 10, offset 0x2253
	; Clock offset: -1152

	; src_data blit 83
	ld sp,screenStartAddr+1404	; offset 0x2256
	ld hl,44975	; offset 0x2259
	push hl	; offset 0x225a
	ld hl,44975	; offset 0x225d
	push hl	; offset 0x225e
	ld hl,44975	; offset 0x2261
	push hl	; offset 0x2262
	ld hl,44975	; offset 0x2265
	push hl	; offset 0x2266
	ld hl,44975	; offset 0x2269
	push hl	; offset 0x226a
	ld hl,44975	; offset 0x226d
	push hl	; offset 0x226e
	; src_data blit 84
	ld sp,screenStartAddr+1416	; offset 0x2271
	ld hl,44975	; offset 0x2274
	push hl	; offset 0x2275
	ld hl,44975	; offset 0x2278
	push hl	; offset 0x2279
	ld hl,44975	; offset 0x227c
	push hl	; offset 0x227d
	ld hl,44975	; offset 0x2280
	push hl	; offset 0x2281
	ld hl,44975	; offset 0x2284
	push hl	; offset 0x2285
	ld hl,44975	; offset 0x2288
	push hl	; offset 0x2289
	; src_data blit 85
	ld sp,screenStartAddr+1644	; offset 0x228c
	ld hl,44975	; offset 0x228f
	push hl	; offset 0x2290
	ld hl,44975	; offset 0x2293
	push hl	; offset 0x2294
	ld hl,44975	; offset 0x2297
	push hl	; offset 0x2298
	ld hl,44975	; offset 0x229b
	push hl	; offset 0x229c
	ld hl,44975	; offset 0x229f
	push hl	; offset 0x22a0
	ld hl,44975	; offset 0x22a3
	push hl	; offset 0x22a4
	; src_data blit 86
	ld sp,screenStartAddr+1656	; offset 0x22a7
	ld hl,44975	; offset 0x22aa
	push hl	; offset 0x22ab
	ld hl,44975	; offset 0x22ae
	push hl	; offset 0x22af
	ld hl,44975	; offset 0x22b2
	push hl	; offset 0x22b3
	ld hl,44975	; offset 0x22b6
	push hl	; offset 0x22b7
	ld hl,44975	; offset 0x22ba
	push hl	; offset 0x22bb
	ld hl,44975	; offset 0x22be
	push hl	; offset 0x22bf
	; src_data blit 87
	ld sp,screenStartAddr+1668	; offset 0x22c2
	ld hl,44975	; offset 0x22c5
	push hl	; offset 0x22c6
	ld hl,44975	; offset 0x22c9
	push hl	; offset 0x22ca
	ld hl,44975	; offset 0x22cd
	push hl	; offset 0x22ce
	ld hl,44975	; offset 0x22d1
	push hl	; offset 0x22d2
	ld hl,44975	; offset 0x22d5
	push hl	; offset 0x22d6
	ld hl,44975	; offset 0x22d9
	push hl	; offset 0x22da
	; src_data blit 88
	ld sp,screenStartAddr+1908	; offset 0x22dd
	ld hl,44975	; offset 0x22e0
	push hl	; offset 0x22e1
	ld hl,44975	; offset 0x22e4
	push hl	; offset 0x22e5
	ld hl,44975	; offset 0x22e8
	push hl	; offset 0x22e9
	ld hl,44975	; offset 0x22ec
	push hl	; offset 0x22ed
	ld hl,44975	; offset 0x22f0
	push hl	; offset 0x22f1
	ld hl,44975	; offset 0x22f4
	push hl	; offset 0x22f5
	; src_data blit 89
	ld sp,screenStartAddr+1920	; offset 0x22f8
	ld hl,44975	; offset 0x22fb
	push hl	; offset 0x22fc
	ld hl,44975	; offset 0x22ff
	push hl	; offset 0x2300
	ld hl,44975	; offset 0x2303
	push hl	; offset 0x2304
	ld hl,44975	; offset 0x2307
	push hl	; offset 0x2308
	ld hl,44975	; offset 0x230b
	push hl	; offset 0x230c
	ld hl,44975	; offset 0x230f
	push hl	; offset 0x2310
	; src_data blit 90
	ld sp,screenStartAddr+144	; offset 0x2313
	ld hl,44975	; offset 0x2316
	push hl	; offset 0x2317
	ld hl,44975	; offset 0x231a
	push hl	; offset 0x231b
	ld hl,44975	; offset 0x231e
	push hl	; offset 0x231f
	ld hl,44975	; offset 0x2322
	push hl	; offset 0x2323
	ld hl,44975	; offset 0x2326
	push hl	; offset 0x2327
	ld hl,44975	; offset 0x232a
	push hl	; offset 0x232b

	; attr draw 11
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+352
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+352),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+352),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+352
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+352),hl;	 dest 30
	; end attr draw 11, offset 0x24d2
	; Clock offset: -1152

	; src_data blit 91
	ld sp,screenStartAddr+156	; offset 0x24d5
	ld hl,44975	; offset 0x24d8
	push hl	; offset 0x24d9
	ld hl,44975	; offset 0x24dc
	push hl	; offset 0x24dd
	ld hl,44975	; offset 0x24e0
	push hl	; offset 0x24e1
	ld hl,44975	; offset 0x24e4
	push hl	; offset 0x24e5
	ld hl,44975	; offset 0x24e8
	push hl	; offset 0x24e9
	ld hl,44975	; offset 0x24ec
	push hl	; offset 0x24ed
	; src_data blit 92
	ld sp,screenStartAddr+168	; offset 0x24f0
	ld hl,44975	; offset 0x24f3
	push hl	; offset 0x24f4
	ld hl,44975	; offset 0x24f7
	push hl	; offset 0x24f8
	ld hl,44975	; offset 0x24fb
	push hl	; offset 0x24fc
	ld hl,44975	; offset 0x24ff
	push hl	; offset 0x2500
	ld hl,44975	; offset 0x2503
	push hl	; offset 0x2504
	ld hl,44975	; offset 0x2507
	push hl	; offset 0x2508
	; src_data blit 93
	ld sp,screenStartAddr+396	; offset 0x250b
	ld hl,44975	; offset 0x250e
	push hl	; offset 0x250f
	ld hl,44975	; offset 0x2512
	push hl	; offset 0x2513
	ld hl,44975	; offset 0x2516
	push hl	; offset 0x2517
	ld hl,44975	; offset 0x251a
	push hl	; offset 0x251b
	ld hl,44975	; offset 0x251e
	push hl	; offset 0x251f
	ld hl,44975	; offset 0x2522
	push hl	; offset 0x2523
	; src_data blit 94
	ld sp,screenStartAddr+408	; offset 0x2526
	ld hl,44975	; offset 0x2529
	push hl	; offset 0x252a
	ld hl,44975	; offset 0x252d
	push hl	; offset 0x252e
	ld hl,44975	; offset 0x2531
	push hl	; offset 0x2532
	ld hl,44975	; offset 0x2535
	push hl	; offset 0x2536
	ld hl,44975	; offset 0x2539
	push hl	; offset 0x253a
	ld hl,44975	; offset 0x253d
	push hl	; offset 0x253e
	; src_data blit 95
	ld sp,screenStartAddr+420	; offset 0x2541
	ld hl,44975	; offset 0x2544
	push hl	; offset 0x2545
	ld hl,44975	; offset 0x2548
	push hl	; offset 0x2549
	ld hl,44975	; offset 0x254c
	push hl	; offset 0x254d
	ld hl,44975	; offset 0x2550
	push hl	; offset 0x2551
	ld hl,44975	; offset 0x2554
	push hl	; offset 0x2555
	ld hl,44975	; offset 0x2558
	push hl	; offset 0x2559
	; src_data blit 96
	ld sp,screenStartAddr+660	; offset 0x255c
	ld hl,44975	; offset 0x255f
	push hl	; offset 0x2560
	ld hl,44975	; offset 0x2563
	push hl	; offset 0x2564
	ld hl,44975	; offset 0x2567
	push hl	; offset 0x2568
	ld hl,44975	; offset 0x256b
	push hl	; offset 0x256c
	ld hl,44975	; offset 0x256f
	push hl	; offset 0x2570
	ld hl,44975	; offset 0x2573
	push hl	; offset 0x2574
	; src_data blit 97
	ld sp,screenStartAddr+672	; offset 0x2577
	ld hl,44975	; offset 0x257a
	push hl	; offset 0x257b
	ld hl,44975	; offset 0x257e
	push hl	; offset 0x257f
	ld hl,44975	; offset 0x2582
	push hl	; offset 0x2583
	ld hl,44975	; offset 0x2586
	push hl	; offset 0x2587
	ld hl,44975	; offset 0x258a
	push hl	; offset 0x258b
	ld hl,44975	; offset 0x258e
	push hl	; offset 0x258f
	; src_data blit 98
	ld sp,screenStartAddr+912	; offset 0x2592
	ld hl,44975	; offset 0x2595
	push hl	; offset 0x2596
	ld hl,44975	; offset 0x2599
	push hl	; offset 0x259a
	ld hl,44975	; offset 0x259d
	push hl	; offset 0x259e
	ld hl,44975	; offset 0x25a1
	push hl	; offset 0x25a2
	ld hl,44975	; offset 0x25a5
	push hl	; offset 0x25a6
	ld hl,44975	; offset 0x25a9
	push hl	; offset 0x25aa

	; attr draw 12
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+384
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+384),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+384),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+384
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+384),hl;	 dest 30
	; end attr draw 12, offset 0x2751
	; Clock offset: -1152

	; src_data blit 99
	ld sp,screenStartAddr+924	; offset 0x2754
	ld hl,44975	; offset 0x2757
	push hl	; offset 0x2758
	ld hl,44975	; offset 0x275b
	push hl	; offset 0x275c
	ld hl,44975	; offset 0x275f
	push hl	; offset 0x2760
	ld hl,44975	; offset 0x2763
	push hl	; offset 0x2764
	ld hl,44975	; offset 0x2767
	push hl	; offset 0x2768
	ld hl,44975	; offset 0x276b
	push hl	; offset 0x276c
	; src_data blit 100
	ld sp,screenStartAddr+936	; offset 0x276f
	ld hl,44975	; offset 0x2772
	push hl	; offset 0x2773
	ld hl,44975	; offset 0x2776
	push hl	; offset 0x2777
	ld hl,44975	; offset 0x277a
	push hl	; offset 0x277b
	ld hl,44975	; offset 0x277e
	push hl	; offset 0x277f
	ld hl,44975	; offset 0x2782
	push hl	; offset 0x2783
	ld hl,44975	; offset 0x2786
	push hl	; offset 0x2787
	; src_data blit 101
	ld sp,screenStartAddr+1164	; offset 0x278a
	ld hl,44975	; offset 0x278d
	push hl	; offset 0x278e
	ld hl,44975	; offset 0x2791
	push hl	; offset 0x2792
	ld hl,44975	; offset 0x2795
	push hl	; offset 0x2796
	ld hl,44975	; offset 0x2799
	push hl	; offset 0x279a
	ld hl,44975	; offset 0x279d
	push hl	; offset 0x279e
	ld hl,44975	; offset 0x27a1
	push hl	; offset 0x27a2
	; src_data blit 102
	ld sp,screenStartAddr+1176	; offset 0x27a5
	ld hl,44975	; offset 0x27a8
	push hl	; offset 0x27a9
	ld hl,44975	; offset 0x27ac
	push hl	; offset 0x27ad
	ld hl,44975	; offset 0x27b0
	push hl	; offset 0x27b1
	ld hl,44975	; offset 0x27b4
	push hl	; offset 0x27b5
	ld hl,44975	; offset 0x27b8
	push hl	; offset 0x27b9
	ld hl,44975	; offset 0x27bc
	push hl	; offset 0x27bd
	; src_data blit 103
	ld sp,screenStartAddr+1188	; offset 0x27c0
	ld hl,44975	; offset 0x27c3
	push hl	; offset 0x27c4
	ld hl,44975	; offset 0x27c7
	push hl	; offset 0x27c8
	ld hl,44975	; offset 0x27cb
	push hl	; offset 0x27cc
	ld hl,44975	; offset 0x27cf
	push hl	; offset 0x27d0
	ld hl,44975	; offset 0x27d3
	push hl	; offset 0x27d4
	ld hl,44975	; offset 0x27d7
	push hl	; offset 0x27d8
	; src_data blit 104
	ld sp,screenStartAddr+1428	; offset 0x27db
	ld hl,44975	; offset 0x27de
	push hl	; offset 0x27df
	ld hl,44975	; offset 0x27e2
	push hl	; offset 0x27e3
	ld hl,44975	; offset 0x27e6
	push hl	; offset 0x27e7
	ld hl,44975	; offset 0x27ea
	push hl	; offset 0x27eb
	ld hl,44975	; offset 0x27ee
	push hl	; offset 0x27ef
	ld hl,44975	; offset 0x27f2
	push hl	; offset 0x27f3
	; src_data blit 105
	ld sp,screenStartAddr+1440	; offset 0x27f6
	ld hl,44975	; offset 0x27f9
	push hl	; offset 0x27fa
	ld hl,44975	; offset 0x27fd
	push hl	; offset 0x27fe
	ld hl,44975	; offset 0x2801
	push hl	; offset 0x2802
	ld hl,44975	; offset 0x2805
	push hl	; offset 0x2806
	ld hl,44975	; offset 0x2809
	push hl	; offset 0x280a
	ld hl,44975	; offset 0x280d
	push hl	; offset 0x280e
	; src_data blit 106
	ld sp,screenStartAddr+1680	; offset 0x2811
	ld hl,44975	; offset 0x2814
	push hl	; offset 0x2815
	ld hl,44975	; offset 0x2818
	push hl	; offset 0x2819
	ld hl,44975	; offset 0x281c
	push hl	; offset 0x281d
	ld hl,44975	; offset 0x2820
	push hl	; offset 0x2821
	ld hl,44975	; offset 0x2824
	push hl	; offset 0x2825
	ld hl,44975	; offset 0x2828
	push hl	; offset 0x2829

	; attr draw 13
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+416
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+416),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+416),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+416
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+416),hl;	 dest 30
	; end attr draw 13, offset 0x29d0
	; Clock offset: -1152

	; src_data blit 107
	ld sp,screenStartAddr+1692	; offset 0x29d3
	ld hl,44975	; offset 0x29d6
	push hl	; offset 0x29d7
	ld hl,44975	; offset 0x29da
	push hl	; offset 0x29db
	ld hl,44975	; offset 0x29de
	push hl	; offset 0x29df
	ld hl,44975	; offset 0x29e2
	push hl	; offset 0x29e3
	ld hl,44975	; offset 0x29e6
	push hl	; offset 0x29e7
	ld hl,44975	; offset 0x29ea
	push hl	; offset 0x29eb
	; src_data blit 108
	ld sp,screenStartAddr+1704	; offset 0x29ee
	ld hl,44975	; offset 0x29f1
	push hl	; offset 0x29f2
	ld hl,44975	; offset 0x29f5
	push hl	; offset 0x29f6
	ld hl,44975	; offset 0x29f9
	push hl	; offset 0x29fa
	ld hl,44975	; offset 0x29fd
	push hl	; offset 0x29fe
	ld hl,44975	; offset 0x2a01
	push hl	; offset 0x2a02
	ld hl,44975	; offset 0x2a05
	push hl	; offset 0x2a06
	; src_data blit 109
	ld sp,screenStartAddr+1932	; offset 0x2a09
	ld hl,44975	; offset 0x2a0c
	push hl	; offset 0x2a0d
	ld hl,44975	; offset 0x2a10
	push hl	; offset 0x2a11
	ld hl,44975	; offset 0x2a14
	push hl	; offset 0x2a15
	ld hl,44975	; offset 0x2a18
	push hl	; offset 0x2a19
	ld hl,44975	; offset 0x2a1c
	push hl	; offset 0x2a1d
	ld hl,44975	; offset 0x2a20
	push hl	; offset 0x2a21
	; src_data blit 110
	ld sp,screenStartAddr+1944	; offset 0x2a24
	ld hl,44975	; offset 0x2a27
	push hl	; offset 0x2a28
	ld hl,44975	; offset 0x2a2b
	push hl	; offset 0x2a2c
	ld hl,44975	; offset 0x2a2f
	push hl	; offset 0x2a30
	ld hl,44975	; offset 0x2a33
	push hl	; offset 0x2a34
	ld hl,44975	; offset 0x2a37
	push hl	; offset 0x2a38
	ld hl,44975	; offset 0x2a3b
	push hl	; offset 0x2a3c
	; src_data blit 111
	ld sp,screenStartAddr+1956	; offset 0x2a3f
	ld hl,44975	; offset 0x2a42
	push hl	; offset 0x2a43
	ld hl,44975	; offset 0x2a46
	push hl	; offset 0x2a47
	ld hl,44975	; offset 0x2a4a
	push hl	; offset 0x2a4b
	ld hl,44975	; offset 0x2a4e
	push hl	; offset 0x2a4f
	ld hl,44975	; offset 0x2a52
	push hl	; offset 0x2a53
	ld hl,44975	; offset 0x2a56
	push hl	; offset 0x2a57
	; src_data blit 112
	ld sp,screenStartAddr+180	; offset 0x2a5a
	ld hl,44975	; offset 0x2a5d
	push hl	; offset 0x2a5e
	ld hl,44975	; offset 0x2a61
	push hl	; offset 0x2a62
	ld hl,44975	; offset 0x2a65
	push hl	; offset 0x2a66
	ld hl,44975	; offset 0x2a69
	push hl	; offset 0x2a6a
	ld hl,44975	; offset 0x2a6d
	push hl	; offset 0x2a6e
	ld hl,44975	; offset 0x2a71
	push hl	; offset 0x2a72
	; src_data blit 113
	ld sp,screenStartAddr+192	; offset 0x2a75
	ld hl,44975	; offset 0x2a78
	push hl	; offset 0x2a79
	ld hl,44975	; offset 0x2a7c
	push hl	; offset 0x2a7d
	ld hl,44975	; offset 0x2a80
	push hl	; offset 0x2a81
	ld hl,44975	; offset 0x2a84
	push hl	; offset 0x2a85
	ld hl,44975	; offset 0x2a88
	push hl	; offset 0x2a89
	ld hl,44975	; offset 0x2a8c
	push hl	; offset 0x2a8d
	; src_data blit 114
	ld sp,screenStartAddr+432	; offset 0x2a90
	ld hl,44975	; offset 0x2a93
	push hl	; offset 0x2a94
	ld hl,44975	; offset 0x2a97
	push hl	; offset 0x2a98
	ld hl,44975	; offset 0x2a9b
	push hl	; offset 0x2a9c
	ld hl,44975	; offset 0x2a9f
	push hl	; offset 0x2aa0
	ld hl,44975	; offset 0x2aa3
	push hl	; offset 0x2aa4
	ld hl,44975	; offset 0x2aa7
	push hl	; offset 0x2aa8

	; attr draw 14
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+448
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+448),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+448),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+448
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+448),hl;	 dest 30
	; end attr draw 14, offset 0x2c4f
	; Clock offset: -1152

	; src_data blit 115
	ld sp,screenStartAddr+444	; offset 0x2c52
	ld hl,44975	; offset 0x2c55
	push hl	; offset 0x2c56
	ld hl,44975	; offset 0x2c59
	push hl	; offset 0x2c5a
	ld hl,44975	; offset 0x2c5d
	push hl	; offset 0x2c5e
	ld hl,44975	; offset 0x2c61
	push hl	; offset 0x2c62
	ld hl,44975	; offset 0x2c65
	push hl	; offset 0x2c66
	ld hl,44975	; offset 0x2c69
	push hl	; offset 0x2c6a
	; src_data blit 116
	ld sp,screenStartAddr+456	; offset 0x2c6d
	ld hl,44975	; offset 0x2c70
	push hl	; offset 0x2c71
	ld hl,44975	; offset 0x2c74
	push hl	; offset 0x2c75
	ld hl,44975	; offset 0x2c78
	push hl	; offset 0x2c79
	ld hl,44975	; offset 0x2c7c
	push hl	; offset 0x2c7d
	ld hl,44975	; offset 0x2c80
	push hl	; offset 0x2c81
	ld hl,44975	; offset 0x2c84
	push hl	; offset 0x2c85
	; src_data blit 117
	ld sp,screenStartAddr+684	; offset 0x2c88
	ld hl,44975	; offset 0x2c8b
	push hl	; offset 0x2c8c
	ld hl,44975	; offset 0x2c8f
	push hl	; offset 0x2c90
	ld hl,44975	; offset 0x2c93
	push hl	; offset 0x2c94
	ld hl,44975	; offset 0x2c97
	push hl	; offset 0x2c98
	ld hl,44975	; offset 0x2c9b
	push hl	; offset 0x2c9c
	ld hl,44975	; offset 0x2c9f
	push hl	; offset 0x2ca0
	; src_data blit 118
	ld sp,screenStartAddr+696	; offset 0x2ca3
	ld hl,44975	; offset 0x2ca6
	push hl	; offset 0x2ca7
	ld hl,44975	; offset 0x2caa
	push hl	; offset 0x2cab
	ld hl,44975	; offset 0x2cae
	push hl	; offset 0x2caf
	ld hl,44975	; offset 0x2cb2
	push hl	; offset 0x2cb3
	ld hl,44975	; offset 0x2cb6
	push hl	; offset 0x2cb7
	ld hl,44975	; offset 0x2cba
	push hl	; offset 0x2cbb
	; src_data blit 119
	ld sp,screenStartAddr+708	; offset 0x2cbe
	ld hl,44975	; offset 0x2cc1
	push hl	; offset 0x2cc2
	ld hl,44975	; offset 0x2cc5
	push hl	; offset 0x2cc6
	ld hl,44975	; offset 0x2cc9
	push hl	; offset 0x2cca
	ld hl,44975	; offset 0x2ccd
	push hl	; offset 0x2cce
	ld hl,44975	; offset 0x2cd1
	push hl	; offset 0x2cd2
	ld hl,44975	; offset 0x2cd5
	push hl	; offset 0x2cd6
	; src_data blit 120
	ld sp,screenStartAddr+948	; offset 0x2cd9
	ld hl,44975	; offset 0x2cdc
	push hl	; offset 0x2cdd
	ld hl,44975	; offset 0x2ce0
	push hl	; offset 0x2ce1
	ld hl,44975	; offset 0x2ce4
	push hl	; offset 0x2ce5
	ld hl,44975	; offset 0x2ce8
	push hl	; offset 0x2ce9
	ld hl,44975	; offset 0x2cec
	push hl	; offset 0x2ced
	ld hl,44975	; offset 0x2cf0
	push hl	; offset 0x2cf1
	; src_data blit 121
	ld sp,screenStartAddr+960	; offset 0x2cf4
	ld hl,44975	; offset 0x2cf7
	push hl	; offset 0x2cf8
	ld hl,44975	; offset 0x2cfb
	push hl	; offset 0x2cfc
	ld hl,44975	; offset 0x2cff
	push hl	; offset 0x2d00
	ld hl,44975	; offset 0x2d03
	push hl	; offset 0x2d04
	ld hl,44975	; offset 0x2d07
	push hl	; offset 0x2d08
	ld hl,44975	; offset 0x2d0b
	push hl	; offset 0x2d0c
	; src_data blit 122
	ld sp,screenStartAddr+1200	; offset 0x2d0f
	ld hl,44975	; offset 0x2d12
	push hl	; offset 0x2d13
	ld hl,44975	; offset 0x2d16
	push hl	; offset 0x2d17
	ld hl,44975	; offset 0x2d1a
	push hl	; offset 0x2d1b
	ld hl,44975	; offset 0x2d1e
	push hl	; offset 0x2d1f
	ld hl,44975	; offset 0x2d22
	push hl	; offset 0x2d23
	ld hl,44975	; offset 0x2d26
	push hl	; offset 0x2d27

	; attr draw 15
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+480
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+480),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+480),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+480
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+480),hl;	 dest 30
	; end attr draw 15, offset 0x2ece
	; Clock offset: -1152

	; src_data blit 123
	ld sp,screenStartAddr+1212	; offset 0x2ed1
	ld hl,44975	; offset 0x2ed4
	push hl	; offset 0x2ed5
	ld hl,44975	; offset 0x2ed8
	push hl	; offset 0x2ed9
	ld hl,44975	; offset 0x2edc
	push hl	; offset 0x2edd
	ld hl,44975	; offset 0x2ee0
	push hl	; offset 0x2ee1
	ld hl,44975	; offset 0x2ee4
	push hl	; offset 0x2ee5
	ld hl,44975	; offset 0x2ee8
	push hl	; offset 0x2ee9
	; src_data blit 124
	ld sp,screenStartAddr+1224	; offset 0x2eec
	ld hl,44975	; offset 0x2eef
	push hl	; offset 0x2ef0
	ld hl,44975	; offset 0x2ef3
	push hl	; offset 0x2ef4
	ld hl,44975	; offset 0x2ef7
	push hl	; offset 0x2ef8
	ld hl,44975	; offset 0x2efb
	push hl	; offset 0x2efc
	ld hl,44975	; offset 0x2eff
	push hl	; offset 0x2f00
	ld hl,44975	; offset 0x2f03
	push hl	; offset 0x2f04
	; src_data blit 125
	ld sp,screenStartAddr+1452	; offset 0x2f07
	ld hl,44975	; offset 0x2f0a
	push hl	; offset 0x2f0b
	ld hl,44975	; offset 0x2f0e
	push hl	; offset 0x2f0f
	ld hl,44975	; offset 0x2f12
	push hl	; offset 0x2f13
	ld hl,44975	; offset 0x2f16
	push hl	; offset 0x2f17
	ld hl,44975	; offset 0x2f1a
	push hl	; offset 0x2f1b
	ld hl,44975	; offset 0x2f1e
	push hl	; offset 0x2f1f
	; src_data blit 126
	ld sp,screenStartAddr+1464	; offset 0x2f22
	ld hl,44975	; offset 0x2f25
	push hl	; offset 0x2f26
	ld hl,44975	; offset 0x2f29
	push hl	; offset 0x2f2a
	ld hl,44975	; offset 0x2f2d
	push hl	; offset 0x2f2e
	ld hl,44975	; offset 0x2f31
	push hl	; offset 0x2f32
	ld hl,44975	; offset 0x2f35
	push hl	; offset 0x2f36
	ld hl,44975	; offset 0x2f39
	push hl	; offset 0x2f3a
	; src_data blit 127
	ld sp,screenStartAddr+1476	; offset 0x2f3d
	ld hl,44975	; offset 0x2f40
	push hl	; offset 0x2f41
	ld hl,44975	; offset 0x2f44
	push hl	; offset 0x2f45
	ld hl,44975	; offset 0x2f48
	push hl	; offset 0x2f49
	ld hl,44975	; offset 0x2f4c
	push hl	; offset 0x2f4d
	ld hl,44975	; offset 0x2f50
	push hl	; offset 0x2f51
	ld hl,44975	; offset 0x2f54
	push hl	; offset 0x2f55
	; src_data blit 128
	ld sp,screenStartAddr+1716	; offset 0x2f58
	ld hl,44975	; offset 0x2f5b
	push hl	; offset 0x2f5c
	ld hl,44975	; offset 0x2f5f
	push hl	; offset 0x2f60
	ld hl,44975	; offset 0x2f63
	push hl	; offset 0x2f64
	ld hl,44975	; offset 0x2f67
	push hl	; offset 0x2f68
	ld hl,44975	; offset 0x2f6b
	push hl	; offset 0x2f6c
	ld hl,44975	; offset 0x2f6f
	push hl	; offset 0x2f70
	; src_data blit 129
	ld sp,screenStartAddr+1728	; offset 0x2f73
	ld hl,44975	; offset 0x2f76
	push hl	; offset 0x2f77
	ld hl,44975	; offset 0x2f7a
	push hl	; offset 0x2f7b
	ld hl,44975	; offset 0x2f7e
	push hl	; offset 0x2f7f
	ld hl,44975	; offset 0x2f82
	push hl	; offset 0x2f83
	ld hl,44975	; offset 0x2f86
	push hl	; offset 0x2f87
	ld hl,44975	; offset 0x2f8a
	push hl	; offset 0x2f8b
	; src_data blit 130
	ld sp,screenStartAddr+1968	; offset 0x2f8e
	ld hl,44975	; offset 0x2f91
	push hl	; offset 0x2f92
	ld hl,44975	; offset 0x2f95
	push hl	; offset 0x2f96
	ld hl,44975	; offset 0x2f99
	push hl	; offset 0x2f9a
	ld hl,44975	; offset 0x2f9d
	push hl	; offset 0x2f9e
	ld hl,44975	; offset 0x2fa1
	push hl	; offset 0x2fa2
	ld hl,44975	; offset 0x2fa5
	push hl	; offset 0x2fa6

	; attr draw 16
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+512
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+512),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+512),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+512
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+512),hl;	 dest 30
	; end attr draw 16, offset 0x314d
	; Clock offset: -1152

	; src_data blit 131
	ld sp,screenStartAddr+1980	; offset 0x3150
	ld hl,44975	; offset 0x3153
	push hl	; offset 0x3154
	ld hl,44975	; offset 0x3157
	push hl	; offset 0x3158
	ld hl,44975	; offset 0x315b
	push hl	; offset 0x315c
	ld hl,44975	; offset 0x315f
	push hl	; offset 0x3160
	ld hl,44975	; offset 0x3163
	push hl	; offset 0x3164
	ld hl,44975	; offset 0x3167
	push hl	; offset 0x3168
	; src_data blit 132
	ld sp,screenStartAddr+1992	; offset 0x316b
	ld hl,44975	; offset 0x316e
	push hl	; offset 0x316f
	ld hl,44975	; offset 0x3172
	push hl	; offset 0x3173
	ld hl,44975	; offset 0x3176
	push hl	; offset 0x3177
	ld hl,44975	; offset 0x317a
	push hl	; offset 0x317b
	ld hl,44975	; offset 0x317e
	push hl	; offset 0x317f
	ld hl,44975	; offset 0x3182
	push hl	; offset 0x3183
	; src_data blit 133
	ld sp,screenStartAddr+204	; offset 0x3186
	ld hl,44975	; offset 0x3189
	push hl	; offset 0x318a
	ld hl,44975	; offset 0x318d
	push hl	; offset 0x318e
	ld hl,44975	; offset 0x3191
	push hl	; offset 0x3192
	ld hl,44975	; offset 0x3195
	push hl	; offset 0x3196
	ld hl,44975	; offset 0x3199
	push hl	; offset 0x319a
	ld hl,44975	; offset 0x319d
	push hl	; offset 0x319e
	; src_data blit 134
	ld sp,screenStartAddr+216	; offset 0x31a1
	ld hl,44975	; offset 0x31a4
	push hl	; offset 0x31a5
	ld hl,44975	; offset 0x31a8
	push hl	; offset 0x31a9
	ld hl,44975	; offset 0x31ac
	push hl	; offset 0x31ad
	ld hl,44975	; offset 0x31b0
	push hl	; offset 0x31b1
	ld hl,44975	; offset 0x31b4
	push hl	; offset 0x31b5
	ld hl,44975	; offset 0x31b8
	push hl	; offset 0x31b9
	; src_data blit 135
	ld sp,screenStartAddr+228	; offset 0x31bc
	ld hl,44975	; offset 0x31bf
	push hl	; offset 0x31c0
	ld hl,44975	; offset 0x31c3
	push hl	; offset 0x31c4
	ld hl,44975	; offset 0x31c7
	push hl	; offset 0x31c8
	ld hl,44975	; offset 0x31cb
	push hl	; offset 0x31cc
	ld hl,44975	; offset 0x31cf
	push hl	; offset 0x31d0
	ld hl,44975	; offset 0x31d3
	push hl	; offset 0x31d4
	; src_data blit 136
	ld sp,screenStartAddr+468	; offset 0x31d7
	ld hl,44975	; offset 0x31da
	push hl	; offset 0x31db
	ld hl,44975	; offset 0x31de
	push hl	; offset 0x31df
	ld hl,44975	; offset 0x31e2
	push hl	; offset 0x31e3
	ld hl,44975	; offset 0x31e6
	push hl	; offset 0x31e7
	ld hl,44975	; offset 0x31ea
	push hl	; offset 0x31eb
	ld hl,44975	; offset 0x31ee
	push hl	; offset 0x31ef
	; src_data blit 137
	ld sp,screenStartAddr+480	; offset 0x31f2
	ld hl,44975	; offset 0x31f5
	push hl	; offset 0x31f6
	ld hl,44975	; offset 0x31f9
	push hl	; offset 0x31fa
	ld hl,44975	; offset 0x31fd
	push hl	; offset 0x31fe
	ld hl,44975	; offset 0x3201
	push hl	; offset 0x3202
	ld hl,44975	; offset 0x3205
	push hl	; offset 0x3206
	ld hl,44975	; offset 0x3209
	push hl	; offset 0x320a
	; src_data blit 138
	ld sp,screenStartAddr+720	; offset 0x320d
	ld hl,44975	; offset 0x3210
	push hl	; offset 0x3211
	ld hl,44975	; offset 0x3214
	push hl	; offset 0x3215
	ld hl,44975	; offset 0x3218
	push hl	; offset 0x3219
	ld hl,44975	; offset 0x321c
	push hl	; offset 0x321d
	ld hl,44975	; offset 0x3220
	push hl	; offset 0x3221
	ld hl,44975	; offset 0x3224
	push hl	; offset 0x3225

	; attr draw 17
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+544
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+544),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+544),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+544
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+544),hl;	 dest 30
	; end attr draw 17, offset 0x33cc
	; Clock offset: -1152

	; src_data blit 139
	ld sp,screenStartAddr+732	; offset 0x33cf
	ld hl,44975	; offset 0x33d2
	push hl	; offset 0x33d3
	ld hl,44975	; offset 0x33d6
	push hl	; offset 0x33d7
	ld hl,44975	; offset 0x33da
	push hl	; offset 0x33db
	ld hl,44975	; offset 0x33de
	push hl	; offset 0x33df
	ld hl,44975	; offset 0x33e2
	push hl	; offset 0x33e3
	ld hl,44975	; offset 0x33e6
	push hl	; offset 0x33e7
	; src_data blit 140
	ld sp,screenStartAddr+744	; offset 0x33ea
	ld hl,44975	; offset 0x33ed
	push hl	; offset 0x33ee
	ld hl,44975	; offset 0x33f1
	push hl	; offset 0x33f2
	ld hl,44975	; offset 0x33f5
	push hl	; offset 0x33f6
	ld hl,44975	; offset 0x33f9
	push hl	; offset 0x33fa
	ld hl,44975	; offset 0x33fd
	push hl	; offset 0x33fe
	ld hl,44975	; offset 0x3401
	push hl	; offset 0x3402
	; src_data blit 141
	ld sp,screenStartAddr+972	; offset 0x3405
	ld hl,44975	; offset 0x3408
	push hl	; offset 0x3409
	ld hl,44975	; offset 0x340c
	push hl	; offset 0x340d
	ld hl,44975	; offset 0x3410
	push hl	; offset 0x3411
	ld hl,44975	; offset 0x3414
	push hl	; offset 0x3415
	ld hl,44975	; offset 0x3418
	push hl	; offset 0x3419
	ld hl,44975	; offset 0x341c
	push hl	; offset 0x341d
	; src_data blit 142
	ld sp,screenStartAddr+984	; offset 0x3420
	ld hl,44975	; offset 0x3423
	push hl	; offset 0x3424
	ld hl,44975	; offset 0x3427
	push hl	; offset 0x3428
	ld hl,44975	; offset 0x342b
	push hl	; offset 0x342c
	ld hl,44975	; offset 0x342f
	push hl	; offset 0x3430
	ld hl,44975	; offset 0x3433
	push hl	; offset 0x3434
	ld hl,44975	; offset 0x3437
	push hl	; offset 0x3438
	; src_data blit 143
	ld sp,screenStartAddr+996	; offset 0x343b
	ld hl,44975	; offset 0x343e
	push hl	; offset 0x343f
	ld hl,44975	; offset 0x3442
	push hl	; offset 0x3443
	ld hl,44975	; offset 0x3446
	push hl	; offset 0x3447
	ld hl,44975	; offset 0x344a
	push hl	; offset 0x344b
	ld hl,44975	; offset 0x344e
	push hl	; offset 0x344f
	ld hl,44975	; offset 0x3452
	push hl	; offset 0x3453
	; src_data blit 144
	ld sp,screenStartAddr+1236	; offset 0x3456
	ld hl,44975	; offset 0x3459
	push hl	; offset 0x345a
	ld hl,44975	; offset 0x345d
	push hl	; offset 0x345e
	ld hl,44975	; offset 0x3461
	push hl	; offset 0x3462
	ld hl,44975	; offset 0x3465
	push hl	; offset 0x3466
	ld hl,44975	; offset 0x3469
	push hl	; offset 0x346a
	ld hl,44975	; offset 0x346d
	push hl	; offset 0x346e
	; src_data blit 145
	ld sp,screenStartAddr+1248	; offset 0x3471
	ld hl,44975	; offset 0x3474
	push hl	; offset 0x3475
	ld hl,44975	; offset 0x3478
	push hl	; offset 0x3479
	ld hl,44975	; offset 0x347c
	push hl	; offset 0x347d
	ld hl,44975	; offset 0x3480
	push hl	; offset 0x3481
	ld hl,44975	; offset 0x3484
	push hl	; offset 0x3485
	ld hl,44975	; offset 0x3488
	push hl	; offset 0x3489
	; src_data blit 146
	ld sp,screenStartAddr+1488	; offset 0x348c
	ld hl,44975	; offset 0x348f
	push hl	; offset 0x3490
	ld hl,44975	; offset 0x3493
	push hl	; offset 0x3494
	ld hl,44975	; offset 0x3497
	push hl	; offset 0x3498
	ld hl,44975	; offset 0x349b
	push hl	; offset 0x349c
	ld hl,44975	; offset 0x349f
	push hl	; offset 0x34a0
	ld hl,44975	; offset 0x34a3
	push hl	; offset 0x34a4

	; attr draw 18
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+576
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+576),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+576),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+576
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+576),hl;	 dest 30
	; end attr draw 18, offset 0x364b
	; Clock offset: -1152

	; src_data blit 147
	ld sp,screenStartAddr+1500	; offset 0x364e
	ld hl,44975	; offset 0x3651
	push hl	; offset 0x3652
	ld hl,44975	; offset 0x3655
	push hl	; offset 0x3656
	ld hl,44975	; offset 0x3659
	push hl	; offset 0x365a
	ld hl,44975	; offset 0x365d
	push hl	; offset 0x365e
	ld hl,44975	; offset 0x3661
	push hl	; offset 0x3662
	ld hl,44975	; offset 0x3665
	push hl	; offset 0x3666
	; src_data blit 148
	ld sp,screenStartAddr+1512	; offset 0x3669
	ld hl,44975	; offset 0x366c
	push hl	; offset 0x366d
	ld hl,44975	; offset 0x3670
	push hl	; offset 0x3671
	ld hl,44975	; offset 0x3674
	push hl	; offset 0x3675
	ld hl,44975	; offset 0x3678
	push hl	; offset 0x3679
	ld hl,44975	; offset 0x367c
	push hl	; offset 0x367d
	ld hl,44975	; offset 0x3680
	push hl	; offset 0x3681
	; src_data blit 149
	ld sp,screenStartAddr+1740	; offset 0x3684
	ld hl,44975	; offset 0x3687
	push hl	; offset 0x3688
	ld hl,44975	; offset 0x368b
	push hl	; offset 0x368c
	ld hl,44975	; offset 0x368f
	push hl	; offset 0x3690
	ld hl,44975	; offset 0x3693
	push hl	; offset 0x3694
	ld hl,44975	; offset 0x3697
	push hl	; offset 0x3698
	ld hl,44975	; offset 0x369b
	push hl	; offset 0x369c
	; src_data blit 150
	ld sp,screenStartAddr+1752	; offset 0x369f
	ld hl,44975	; offset 0x36a2
	push hl	; offset 0x36a3
	ld hl,44975	; offset 0x36a6
	push hl	; offset 0x36a7
	ld hl,44975	; offset 0x36aa
	push hl	; offset 0x36ab
	ld hl,44975	; offset 0x36ae
	push hl	; offset 0x36af
	ld hl,44975	; offset 0x36b2
	push hl	; offset 0x36b3
	ld hl,44975	; offset 0x36b6
	push hl	; offset 0x36b7
	; src_data blit 151
	ld sp,screenStartAddr+1764	; offset 0x36ba
	ld hl,44975	; offset 0x36bd
	push hl	; offset 0x36be
	ld hl,44975	; offset 0x36c1
	push hl	; offset 0x36c2
	ld hl,44975	; offset 0x36c5
	push hl	; offset 0x36c6
	ld hl,44975	; offset 0x36c9
	push hl	; offset 0x36ca
	ld hl,44975	; offset 0x36cd
	push hl	; offset 0x36ce
	ld hl,44975	; offset 0x36d1
	push hl	; offset 0x36d2
	; src_data blit 152
	ld sp,screenStartAddr+2004	; offset 0x36d5
	ld hl,44975	; offset 0x36d8
	push hl	; offset 0x36d9
	ld hl,44975	; offset 0x36dc
	push hl	; offset 0x36dd
	ld hl,44975	; offset 0x36e0
	push hl	; offset 0x36e1
	ld hl,44975	; offset 0x36e4
	push hl	; offset 0x36e5
	ld hl,44975	; offset 0x36e8
	push hl	; offset 0x36e9
	ld hl,44975	; offset 0x36ec
	push hl	; offset 0x36ed
	; src_data blit 153
	ld sp,screenStartAddr+2016	; offset 0x36f0
	ld hl,44975	; offset 0x36f3
	push hl	; offset 0x36f4
	ld hl,44975	; offset 0x36f7
	push hl	; offset 0x36f8
	ld hl,44975	; offset 0x36fb
	push hl	; offset 0x36fc
	ld hl,44975	; offset 0x36ff
	push hl	; offset 0x3700
	ld hl,44975	; offset 0x3703
	push hl	; offset 0x3704
	ld hl,44975	; offset 0x3707
	push hl	; offset 0x3708
	; src_data blit 154
	ld sp,screenStartAddr+240	; offset 0x370b
	ld hl,44975	; offset 0x370e
	push hl	; offset 0x370f
	ld hl,44975	; offset 0x3712
	push hl	; offset 0x3713
	ld hl,44975	; offset 0x3716
	push hl	; offset 0x3717
	ld hl,44975	; offset 0x371a
	push hl	; offset 0x371b
	ld hl,44975	; offset 0x371e
	push hl	; offset 0x371f
	ld hl,44975	; offset 0x3722
	push hl	; offset 0x3723

	; attr draw 19
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+608
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+608),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+608),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+608
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+608),hl;	 dest 30
	; end attr draw 19, offset 0x38ca
	; Clock offset: -1152

	; src_data blit 155
	ld sp,screenStartAddr+252	; offset 0x38cd
	ld hl,44975	; offset 0x38d0
	push hl	; offset 0x38d1
	ld hl,44975	; offset 0x38d4
	push hl	; offset 0x38d5
	ld hl,44975	; offset 0x38d8
	push hl	; offset 0x38d9
	ld hl,44975	; offset 0x38dc
	push hl	; offset 0x38dd
	ld hl,44975	; offset 0x38e0
	push hl	; offset 0x38e1
	ld hl,44975	; offset 0x38e4
	push hl	; offset 0x38e5
	; src_data blit 156
	ld sp,screenStartAddr+492	; offset 0x38e8
	ld hl,44975	; offset 0x38eb
	push hl	; offset 0x38ec
	ld hl,44975	; offset 0x38ef
	push hl	; offset 0x38f0
	ld hl,44975	; offset 0x38f3
	push hl	; offset 0x38f4
	ld hl,44975	; offset 0x38f7
	push hl	; offset 0x38f8
	ld hl,44975	; offset 0x38fb
	push hl	; offset 0x38fc
	ld hl,44975	; offset 0x38ff
	push hl	; offset 0x3900
	; src_data blit 157
	ld sp,screenStartAddr+504	; offset 0x3903
	ld hl,44975	; offset 0x3906
	push hl	; offset 0x3907
	ld hl,44975	; offset 0x390a
	push hl	; offset 0x390b
	ld hl,44975	; offset 0x390e
	push hl	; offset 0x390f
	ld hl,44975	; offset 0x3912
	push hl	; offset 0x3913
	ld hl,44975	; offset 0x3916
	push hl	; offset 0x3917
	ld hl,44975	; offset 0x391a
	push hl	; offset 0x391b
	; src_data blit 158
	ld sp,screenStartAddr+756	; offset 0x391e
	ld hl,44975	; offset 0x3921
	push hl	; offset 0x3922
	ld hl,44975	; offset 0x3925
	push hl	; offset 0x3926
	ld hl,44975	; offset 0x3929
	push hl	; offset 0x392a
	ld hl,44975	; offset 0x392d
	push hl	; offset 0x392e
	ld hl,44975	; offset 0x3931
	push hl	; offset 0x3932
	ld hl,44975	; offset 0x3935
	push hl	; offset 0x3936
	; src_data blit 159
	ld sp,screenStartAddr+768	; offset 0x3939
	ld hl,44975	; offset 0x393c
	push hl	; offset 0x393d
	ld hl,44975	; offset 0x3940
	push hl	; offset 0x3941
	ld hl,44975	; offset 0x3944
	push hl	; offset 0x3945
	ld hl,44975	; offset 0x3948
	push hl	; offset 0x3949
	ld hl,44975	; offset 0x394c
	push hl	; offset 0x394d
	ld hl,44975	; offset 0x3950
	push hl	; offset 0x3951
	; src_data blit 160
	ld sp,screenStartAddr+1008	; offset 0x3954
	ld hl,44975	; offset 0x3957
	push hl	; offset 0x3958
	ld hl,44975	; offset 0x395b
	push hl	; offset 0x395c
	ld hl,44975	; offset 0x395f
	push hl	; offset 0x3960
	ld hl,44975	; offset 0x3963
	push hl	; offset 0x3964
	ld hl,44975	; offset 0x3967
	push hl	; offset 0x3968
	ld hl,44975	; offset 0x396b
	push hl	; offset 0x396c
	; src_data blit 161
	ld sp,screenStartAddr+1020	; offset 0x396f
	ld hl,44975	; offset 0x3972
	push hl	; offset 0x3973
	ld hl,44975	; offset 0x3976
	push hl	; offset 0x3977
	ld hl,44975	; offset 0x397a
	push hl	; offset 0x397b
	ld hl,44975	; offset 0x397e
	push hl	; offset 0x397f
	ld hl,44975	; offset 0x3982
	push hl	; offset 0x3983
	ld hl,44975	; offset 0x3986
	push hl	; offset 0x3987
	; src_data blit 162
	ld sp,screenStartAddr+1260	; offset 0x398a
	ld hl,44975	; offset 0x398d
	push hl	; offset 0x398e
	ld hl,44975	; offset 0x3991
	push hl	; offset 0x3992
	ld hl,44975	; offset 0x3995
	push hl	; offset 0x3996
	ld hl,44975	; offset 0x3999
	push hl	; offset 0x399a
	ld hl,44975	; offset 0x399d
	push hl	; offset 0x399e
	ld hl,44975	; offset 0x39a1
	push hl	; offset 0x39a2

	; attr draw 20
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+640
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+640),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+640),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+640
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+640),hl;	 dest 30
	; end attr draw 20, offset 0x3b49
	; Clock offset: -1152

	; src_data blit 163
	ld sp,screenStartAddr+1272	; offset 0x3b4c
	ld hl,44975	; offset 0x3b4f
	push hl	; offset 0x3b50
	ld hl,44975	; offset 0x3b53
	push hl	; offset 0x3b54
	ld hl,44975	; offset 0x3b57
	push hl	; offset 0x3b58
	ld hl,44975	; offset 0x3b5b
	push hl	; offset 0x3b5c
	ld hl,44975	; offset 0x3b5f
	push hl	; offset 0x3b60
	ld hl,44975	; offset 0x3b63
	push hl	; offset 0x3b64
	; src_data blit 164
	ld sp,screenStartAddr+1524	; offset 0x3b67
	ld hl,44975	; offset 0x3b6a
	push hl	; offset 0x3b6b
	ld hl,44975	; offset 0x3b6e
	push hl	; offset 0x3b6f
	ld hl,44975	; offset 0x3b72
	push hl	; offset 0x3b73
	ld hl,44975	; offset 0x3b76
	push hl	; offset 0x3b77
	ld hl,44975	; offset 0x3b7a
	push hl	; offset 0x3b7b
	ld hl,44975	; offset 0x3b7e
	push hl	; offset 0x3b7f
	; src_data blit 165
	ld sp,screenStartAddr+1536	; offset 0x3b82
	ld hl,44975	; offset 0x3b85
	push hl	; offset 0x3b86
	ld hl,44975	; offset 0x3b89
	push hl	; offset 0x3b8a
	ld hl,44975	; offset 0x3b8d
	push hl	; offset 0x3b8e
	ld hl,44975	; offset 0x3b91
	push hl	; offset 0x3b92
	ld hl,44975	; offset 0x3b95
	push hl	; offset 0x3b96
	ld hl,44975	; offset 0x3b99
	push hl	; offset 0x3b9a
	; src_data blit 166
	ld sp,screenStartAddr+1776	; offset 0x3b9d
	ld hl,44975	; offset 0x3ba0
	push hl	; offset 0x3ba1
	ld hl,44975	; offset 0x3ba4
	push hl	; offset 0x3ba5
	ld hl,44975	; offset 0x3ba8
	push hl	; offset 0x3ba9
	ld hl,44975	; offset 0x3bac
	push hl	; offset 0x3bad
	ld hl,44975	; offset 0x3bb0
	push hl	; offset 0x3bb1
	ld hl,44975	; offset 0x3bb4
	push hl	; offset 0x3bb5
	; src_data blit 167
	ld sp,screenStartAddr+1788	; offset 0x3bb8
	ld hl,44975	; offset 0x3bbb
	push hl	; offset 0x3bbc
	ld hl,44975	; offset 0x3bbf
	push hl	; offset 0x3bc0
	ld hl,44975	; offset 0x3bc3
	push hl	; offset 0x3bc4
	ld hl,44975	; offset 0x3bc7
	push hl	; offset 0x3bc8
	ld hl,44975	; offset 0x3bcb
	push hl	; offset 0x3bcc
	ld hl,44975	; offset 0x3bcf
	push hl	; offset 0x3bd0
	; src_data blit 168
	ld sp,screenStartAddr+2028	; offset 0x3bd3
	ld hl,44975	; offset 0x3bd6
	push hl	; offset 0x3bd7
	ld hl,44975	; offset 0x3bda
	push hl	; offset 0x3bdb
	ld hl,44975	; offset 0x3bde
	push hl	; offset 0x3bdf
	ld hl,44975	; offset 0x3be2
	push hl	; offset 0x3be3
	ld hl,44975	; offset 0x3be6
	push hl	; offset 0x3be7
	ld hl,44975	; offset 0x3bea
	push hl	; offset 0x3beb
	; src_data blit 169
	ld sp,screenStartAddr+2040	; offset 0x3bee
	ld hl,44975	; offset 0x3bf1
	push hl	; offset 0x3bf2
	ld hl,44975	; offset 0x3bf5
	push hl	; offset 0x3bf6
	ld hl,44975	; offset 0x3bf9
	push hl	; offset 0x3bfa
	ld hl,44975	; offset 0x3bfd
	push hl	; offset 0x3bfe
	ld hl,44975	; offset 0x3c01
	push hl	; offset 0x3c02
	ld hl,44975	; offset 0x3c05
	push hl	; offset 0x3c06
	; src_data blit 170
	ld sp,screenStartAddr+2052	; offset 0x3c09
	ld hl,44975	; offset 0x3c0c
	push hl	; offset 0x3c0d
	ld hl,44975	; offset 0x3c10
	push hl	; offset 0x3c11
	ld hl,44975	; offset 0x3c14
	push hl	; offset 0x3c15
	ld hl,44975	; offset 0x3c18
	push hl	; offset 0x3c19
	ld hl,44975	; offset 0x3c1c
	push hl	; offset 0x3c1d
	ld hl,44975	; offset 0x3c20
	push hl	; offset 0x3c21

	; attr draw 21
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+672
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+672),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+672),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+672
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+672),hl;	 dest 30
	; end attr draw 21, offset 0x3dc8
	; Clock offset: -1152

	; src_data blit 171
	ld sp,screenStartAddr+2064	; offset 0x3dcb
	ld hl,44975	; offset 0x3dce
	push hl	; offset 0x3dcf
	ld hl,44975	; offset 0x3dd2
	push hl	; offset 0x3dd3
	ld hl,44975	; offset 0x3dd6
	push hl	; offset 0x3dd7
	ld hl,44975	; offset 0x3dda
	push hl	; offset 0x3ddb
	ld hl,44975	; offset 0x3dde
	push hl	; offset 0x3ddf
	ld hl,44975	; offset 0x3de2
	push hl	; offset 0x3de3
	; src_data blit 172
	ld sp,screenStartAddr+2076	; offset 0x3de6
	ld hl,44975	; offset 0x3de9
	push hl	; offset 0x3dea
	ld hl,44975	; offset 0x3ded
	push hl	; offset 0x3dee
	ld hl,44975	; offset 0x3df1
	push hl	; offset 0x3df2
	ld hl,44975	; offset 0x3df5
	push hl	; offset 0x3df6
	ld hl,44975	; offset 0x3df9
	push hl	; offset 0x3dfa
	ld hl,44975	; offset 0x3dfd
	push hl	; offset 0x3dfe
	; src_data blit 173
	ld sp,screenStartAddr+2088	; offset 0x3e01
	ld hl,44975	; offset 0x3e04
	push hl	; offset 0x3e05
	ld hl,44975	; offset 0x3e08
	push hl	; offset 0x3e09
	ld hl,44975	; offset 0x3e0c
	push hl	; offset 0x3e0d
	ld hl,44975	; offset 0x3e10
	push hl	; offset 0x3e11
	ld hl,44975	; offset 0x3e14
	push hl	; offset 0x3e15
	ld hl,44975	; offset 0x3e18
	push hl	; offset 0x3e19
	; src_data blit 174
	ld sp,screenStartAddr+2316	; offset 0x3e1c
	ld hl,44975	; offset 0x3e1f
	push hl	; offset 0x3e20
	ld hl,44975	; offset 0x3e23
	push hl	; offset 0x3e24
	ld hl,44975	; offset 0x3e27
	push hl	; offset 0x3e28
	ld hl,44975	; offset 0x3e2b
	push hl	; offset 0x3e2c
	ld hl,44975	; offset 0x3e2f
	push hl	; offset 0x3e30
	ld hl,44975	; offset 0x3e33
	push hl	; offset 0x3e34
	; src_data blit 175
	ld sp,screenStartAddr+2328	; offset 0x3e37
	ld hl,44975	; offset 0x3e3a
	push hl	; offset 0x3e3b
	ld hl,44975	; offset 0x3e3e
	push hl	; offset 0x3e3f
	ld hl,44975	; offset 0x3e42
	push hl	; offset 0x3e43
	ld hl,44975	; offset 0x3e46
	push hl	; offset 0x3e47
	ld hl,44975	; offset 0x3e4a
	push hl	; offset 0x3e4b
	ld hl,44975	; offset 0x3e4e
	push hl	; offset 0x3e4f
	; src_data blit 176
	ld sp,screenStartAddr+2340	; offset 0x3e52
	ld hl,44975	; offset 0x3e55
	push hl	; offset 0x3e56
	ld hl,44975	; offset 0x3e59
	push hl	; offset 0x3e5a
	ld hl,44975	; offset 0x3e5d
	push hl	; offset 0x3e5e
	ld hl,44975	; offset 0x3e61
	push hl	; offset 0x3e62
	ld hl,44975	; offset 0x3e65
	push hl	; offset 0x3e66
	ld hl,44975	; offset 0x3e69
	push hl	; offset 0x3e6a
	; src_data blit 177
	ld sp,screenStartAddr+2568	; offset 0x3e6d
	ld hl,44975	; offset 0x3e70
	push hl	; offset 0x3e71
	ld hl,44975	; offset 0x3e74
	push hl	; offset 0x3e75
	ld hl,44975	; offset 0x3e78
	push hl	; offset 0x3e79
	ld hl,44975	; offset 0x3e7c
	push hl	; offset 0x3e7d
	ld hl,44975	; offset 0x3e80
	push hl	; offset 0x3e81
	ld hl,44975	; offset 0x3e84
	push hl	; offset 0x3e85
	; src_data blit 178
	ld sp,screenStartAddr+2580	; offset 0x3e88
	ld hl,44975	; offset 0x3e8b
	push hl	; offset 0x3e8c
	ld hl,44975	; offset 0x3e8f
	push hl	; offset 0x3e90
	ld hl,44975	; offset 0x3e93
	push hl	; offset 0x3e94
	ld hl,44975	; offset 0x3e97
	push hl	; offset 0x3e98
	ld hl,44975	; offset 0x3e9b
	push hl	; offset 0x3e9c
	ld hl,44975	; offset 0x3e9f
	push hl	; offset 0x3ea0

	; attr draw 22
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+704
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+704),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+704),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+704
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+704),hl;	 dest 30
	; end attr draw 22, offset 0x4047
	; Clock offset: -1152

	; src_data blit 179
	ld sp,screenStartAddr+2592	; offset 0x404a
	ld hl,44975	; offset 0x404d
	push hl	; offset 0x404e
	ld hl,44975	; offset 0x4051
	push hl	; offset 0x4052
	ld hl,44975	; offset 0x4055
	push hl	; offset 0x4056
	ld hl,44975	; offset 0x4059
	push hl	; offset 0x405a
	ld hl,44975	; offset 0x405d
	push hl	; offset 0x405e
	ld hl,44975	; offset 0x4061
	push hl	; offset 0x4062
	; src_data blit 180
	ld sp,screenStartAddr+2820	; offset 0x4065
	ld hl,44975	; offset 0x4068
	push hl	; offset 0x4069
	ld hl,44975	; offset 0x406c
	push hl	; offset 0x406d
	ld hl,44975	; offset 0x4070
	push hl	; offset 0x4071
	ld hl,44975	; offset 0x4074
	push hl	; offset 0x4075
	ld hl,44975	; offset 0x4078
	push hl	; offset 0x4079
	ld hl,44975	; offset 0x407c
	push hl	; offset 0x407d
	; src_data blit 181
	ld sp,screenStartAddr+2832	; offset 0x4080
	ld hl,44975	; offset 0x4083
	push hl	; offset 0x4084
	ld hl,44975	; offset 0x4087
	push hl	; offset 0x4088
	ld hl,44975	; offset 0x408b
	push hl	; offset 0x408c
	ld hl,44975	; offset 0x408f
	push hl	; offset 0x4090
	ld hl,44975	; offset 0x4093
	push hl	; offset 0x4094
	ld hl,44975	; offset 0x4097
	push hl	; offset 0x4098
	; src_data blit 182
	ld sp,screenStartAddr+2844	; offset 0x409b
	ld hl,44975	; offset 0x409e
	push hl	; offset 0x409f
	ld hl,44975	; offset 0x40a2
	push hl	; offset 0x40a3
	ld hl,44975	; offset 0x40a6
	push hl	; offset 0x40a7
	ld hl,44975	; offset 0x40aa
	push hl	; offset 0x40ab
	ld hl,44975	; offset 0x40ae
	push hl	; offset 0x40af
	ld hl,44975	; offset 0x40b2
	push hl	; offset 0x40b3
	; src_data blit 183
	ld sp,screenStartAddr+2856	; offset 0x40b6
	ld hl,44975	; offset 0x40b9
	push hl	; offset 0x40ba
	ld hl,44975	; offset 0x40bd
	push hl	; offset 0x40be
	ld hl,44975	; offset 0x40c1
	push hl	; offset 0x40c2
	ld hl,44975	; offset 0x40c5
	push hl	; offset 0x40c6
	ld hl,44975	; offset 0x40c9
	push hl	; offset 0x40ca
	ld hl,44975	; offset 0x40cd
	push hl	; offset 0x40ce
	; src_data blit 184
	ld sp,screenStartAddr+3084	; offset 0x40d1
	ld hl,44975	; offset 0x40d4
	push hl	; offset 0x40d5
	ld hl,44975	; offset 0x40d8
	push hl	; offset 0x40d9
	ld hl,44975	; offset 0x40dc
	push hl	; offset 0x40dd
	ld hl,44975	; offset 0x40e0
	push hl	; offset 0x40e1
	ld hl,44975	; offset 0x40e4
	push hl	; offset 0x40e5
	ld hl,44975	; offset 0x40e8
	push hl	; offset 0x40e9
	; src_data blit 185
	ld sp,screenStartAddr+3096	; offset 0x40ec
	ld hl,44975	; offset 0x40ef
	push hl	; offset 0x40f0
	ld hl,44975	; offset 0x40f3
	push hl	; offset 0x40f4
	ld hl,44975	; offset 0x40f7
	push hl	; offset 0x40f8
	ld hl,44975	; offset 0x40fb
	push hl	; offset 0x40fc
	ld hl,44975	; offset 0x40ff
	push hl	; offset 0x4100
	ld hl,44975	; offset 0x4103
	push hl	; offset 0x4104
	; src_data blit 186
	ld sp,screenStartAddr+3108	; offset 0x4107
	ld hl,44975	; offset 0x410a
	push hl	; offset 0x410b
	ld hl,44975	; offset 0x410e
	push hl	; offset 0x410f
	ld hl,44975	; offset 0x4112
	push hl	; offset 0x4113
	ld hl,44975	; offset 0x4116
	push hl	; offset 0x4117
	ld hl,44975	; offset 0x411a
	push hl	; offset 0x411b
	ld hl,44975	; offset 0x411e
	push hl	; offset 0x411f

	; attr draw 23
	ld sp,attr8and16vals+4
	pop af	; src 16
	ex af,af'
	pop af	; src 8
	ld bc,10280	; src 18
	ld de,10280	; src 20
	ld hl,10280	; src 22
	ld ix,10280	; src 4
	ld iy,10280	; src 6
	exx
	ld bc,10280	; src 10
	ld de,10280	; src 12
	ld hl,10280	; src 0

	ld sp,attrStartAddr+16+736
	; start chasing raster here to update ATTR memory

	ld (attrStartAddr+736),hl	; dest 0
	ld hl,10280	; src 2
	ld (attrStartAddr+2+736),hl	; dest 2
	ld hl,10280	; src 14
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
	ld bc,10280	; src 24
	ld de,10280	; src 16
	ld hl,10280	; src 28
	ld sp,attrStartAddr+30+736
	push hl	; dest 28
	push de	; dest 26
	push bc	; dest 24
	ld hl,10280	; src 30
	ld (attrStartAddr+30+736),hl;	 dest 30
	; Inter-frame delay
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	; end attr draw 23, offset 0x42ce
	; Clock offset: -1152

	; src_data blit 187
	ld sp,screenStartAddr+3336	; offset 0x42d1
	ld hl,44975	; offset 0x42d4
	push hl	; offset 0x42d5
	ld hl,44975	; offset 0x42d8
	push hl	; offset 0x42d9
	ld hl,44975	; offset 0x42dc
	push hl	; offset 0x42dd
	ld hl,44975	; offset 0x42e0
	push hl	; offset 0x42e1
	ld hl,44975	; offset 0x42e4
	push hl	; offset 0x42e5
	ld hl,44975	; offset 0x42e8
	push hl	; offset 0x42e9
	; src_data blit 188
	ld sp,screenStartAddr+3348	; offset 0x42ec
	ld hl,44975	; offset 0x42ef
	push hl	; offset 0x42f0
	ld hl,44975	; offset 0x42f3
	push hl	; offset 0x42f4
	ld hl,44975	; offset 0x42f7
	push hl	; offset 0x42f8
	ld hl,44975	; offset 0x42fb
	push hl	; offset 0x42fc
	ld hl,44975	; offset 0x42ff
	push hl	; offset 0x4300
	ld hl,44975	; offset 0x4303
	push hl	; offset 0x4304
	; src_data blit 189
	ld sp,screenStartAddr+3360	; offset 0x4307
	ld hl,44975	; offset 0x430a
	push hl	; offset 0x430b
	ld hl,44975	; offset 0x430e
	push hl	; offset 0x430f
	ld hl,44975	; offset 0x4312
	push hl	; offset 0x4313
	ld hl,44975	; offset 0x4316
	push hl	; offset 0x4317
	ld hl,44975	; offset 0x431a
	push hl	; offset 0x431b
	ld hl,44975	; offset 0x431e
	push hl	; offset 0x431f
	; src_data blit 190
	ld sp,screenStartAddr+3588	; offset 0x4322
	ld hl,44975	; offset 0x4325
	push hl	; offset 0x4326
	ld hl,44975	; offset 0x4329
	push hl	; offset 0x432a
	ld hl,44975	; offset 0x432d
	push hl	; offset 0x432e
	ld hl,44975	; offset 0x4331
	push hl	; offset 0x4332
	ld hl,44975	; offset 0x4335
	push hl	; offset 0x4336
	ld hl,44975	; offset 0x4339
	push hl	; offset 0x433a
	; src_data blit 191
	ld sp,screenStartAddr+3600	; offset 0x433d
	ld hl,44975	; offset 0x4340
	push hl	; offset 0x4341
	ld hl,44975	; offset 0x4344
	push hl	; offset 0x4345
	ld hl,44975	; offset 0x4348
	push hl	; offset 0x4349
	ld hl,44975	; offset 0x434c
	push hl	; offset 0x434d
	ld hl,44975	; offset 0x4350
	push hl	; offset 0x4351
	ld hl,44975	; offset 0x4354
	push hl	; offset 0x4355
	; src_data blit 192
	ld sp,screenStartAddr+3612	; offset 0x4358
	ld hl,44975	; offset 0x435b
	push hl	; offset 0x435c
	ld hl,44975	; offset 0x435f
	push hl	; offset 0x4360
	ld hl,44975	; offset 0x4363
	push hl	; offset 0x4364
	ld hl,44975	; offset 0x4367
	push hl	; offset 0x4368
	ld hl,44975	; offset 0x436b
	push hl	; offset 0x436c
	ld hl,44975	; offset 0x436f
	push hl	; offset 0x4370
	; src_data blit 193
	ld sp,screenStartAddr+3624	; offset 0x4373
	ld hl,44975	; offset 0x4376
	push hl	; offset 0x4377
	ld hl,44975	; offset 0x437a
	push hl	; offset 0x437b
	ld hl,44975	; offset 0x437e
	push hl	; offset 0x437f
	ld hl,44975	; offset 0x4382
	push hl	; offset 0x4383
	ld hl,44975	; offset 0x4386
	push hl	; offset 0x4387
	ld hl,44975	; offset 0x438a
	push hl	; offset 0x438b
	; src_data blit 194
	ld sp,screenStartAddr+3852	; offset 0x438e
	ld hl,44975	; offset 0x4391
	push hl	; offset 0x4392
	ld hl,44975	; offset 0x4395
	push hl	; offset 0x4396
	ld hl,44975	; offset 0x4399
	push hl	; offset 0x439a
	ld hl,44975	; offset 0x439d
	push hl	; offset 0x439e
	ld hl,44975	; offset 0x43a1
	push hl	; offset 0x43a2
	ld hl,44975	; offset 0x43a5
	push hl	; offset 0x43a6
	; src_data blit 195
	ld sp,screenStartAddr+3864	; offset 0x43a9
	ld hl,44975	; offset 0x43ac
	push hl	; offset 0x43ad
	ld hl,44975	; offset 0x43b0
	push hl	; offset 0x43b1
	ld hl,44975	; offset 0x43b4
	push hl	; offset 0x43b5
	ld hl,44975	; offset 0x43b8
	push hl	; offset 0x43b9
	ld hl,44975	; offset 0x43bc
	push hl	; offset 0x43bd
	ld hl,44975	; offset 0x43c0
	push hl	; offset 0x43c1
	; delay to get start of scanline (-144 T-states) at offset 0x43c1

	; src_data blit 196
	ld sp,screenStartAddr+3876	; offset 0x43c4
	ld hl,44975	; offset 0x43c7
	push hl	; offset 0x43c8
	ld hl,44975	; offset 0x43cb
	push hl	; offset 0x43cc
	ld hl,44975	; offset 0x43cf
	push hl	; offset 0x43d0
	ld hl,44975	; offset 0x43d3
	push hl	; offset 0x43d4
	ld hl,44975	; offset 0x43d7
	push hl	; offset 0x43d8
	ld hl,44975	; offset 0x43db
	push hl	; offset 0x43dc
	; delay to get start of scanline (-144 T-states) at offset 0x43dc

	; src_data blit 197
	ld sp,screenStartAddr+2100	; offset 0x43df
	ld hl,44975	; offset 0x43e2
	push hl	; offset 0x43e3
	ld hl,44975	; offset 0x43e6
	push hl	; offset 0x43e7
	ld hl,44975	; offset 0x43ea
	push hl	; offset 0x43eb
	ld hl,44975	; offset 0x43ee
	push hl	; offset 0x43ef
	ld hl,44975	; offset 0x43f2
	push hl	; offset 0x43f3
	ld hl,44975	; offset 0x43f6
	push hl	; offset 0x43f7
	; delay to get start of scanline (-144 T-states) at offset 0x43f7

	; src_data blit 198
	ld sp,screenStartAddr+2112	; offset 0x43fa
	ld hl,44975	; offset 0x43fd
	push hl	; offset 0x43fe
	ld hl,44975	; offset 0x4401
	push hl	; offset 0x4402
	ld hl,44975	; offset 0x4405
	push hl	; offset 0x4406
	ld hl,44975	; offset 0x4409
	push hl	; offset 0x440a
	ld hl,44975	; offset 0x440d
	push hl	; offset 0x440e
	ld hl,44975	; offset 0x4411
	push hl	; offset 0x4412
	; delay to get start of scanline (-144 T-states) at offset 0x4412

	; src_data blit 199
	ld sp,screenStartAddr+2352	; offset 0x4415
	ld hl,44975	; offset 0x4418
	push hl	; offset 0x4419
	ld hl,44975	; offset 0x441c
	push hl	; offset 0x441d
	ld hl,44975	; offset 0x4420
	push hl	; offset 0x4421
	ld hl,44975	; offset 0x4424
	push hl	; offset 0x4425
	ld hl,44975	; offset 0x4428
	push hl	; offset 0x4429
	ld hl,44975	; offset 0x442c
	push hl	; offset 0x442d
	; delay to get start of scanline (-144 T-states) at offset 0x442d

	; src_data blit 200
	ld sp,screenStartAddr+2364	; offset 0x4430
	ld hl,44975	; offset 0x4433
	push hl	; offset 0x4434
	ld hl,44975	; offset 0x4437
	push hl	; offset 0x4438
	ld hl,44975	; offset 0x443b
	push hl	; offset 0x443c
	ld hl,44975	; offset 0x443f
	push hl	; offset 0x4440
	ld hl,44975	; offset 0x4443
	push hl	; offset 0x4444
	ld hl,44975	; offset 0x4447
	push hl	; offset 0x4448
	; delay to get start of scanline (-144 T-states) at offset 0x4448

	; src_data blit 201
	ld sp,screenStartAddr+2376	; offset 0x444b
	ld hl,44975	; offset 0x444e
	push hl	; offset 0x444f
	ld hl,44975	; offset 0x4452
	push hl	; offset 0x4453
	ld hl,44975	; offset 0x4456
	push hl	; offset 0x4457
	ld hl,44975	; offset 0x445a
	push hl	; offset 0x445b
	ld hl,44975	; offset 0x445e
	push hl	; offset 0x445f
	ld hl,44975	; offset 0x4462
	push hl	; offset 0x4463
	; delay to get start of scanline (-144 T-states) at offset 0x4463

	; src_data blit 202
	ld sp,screenStartAddr+2604	; offset 0x4466
	ld hl,44975	; offset 0x4469
	push hl	; offset 0x446a
	ld hl,44975	; offset 0x446d
	push hl	; offset 0x446e
	ld hl,44975	; offset 0x4471
	push hl	; offset 0x4472
	ld hl,44975	; offset 0x4475
	push hl	; offset 0x4476
	ld hl,44975	; offset 0x4479
	push hl	; offset 0x447a
	ld hl,44975	; offset 0x447d
	push hl	; offset 0x447e
	; delay to get start of scanline (-144 T-states) at offset 0x447e

	; src_data blit 203
	ld sp,screenStartAddr+2616	; offset 0x4481
	ld hl,44975	; offset 0x4484
	push hl	; offset 0x4485
	ld hl,44975	; offset 0x4488
	push hl	; offset 0x4489
	ld hl,44975	; offset 0x448c
	push hl	; offset 0x448d
	ld hl,44975	; offset 0x4490
	push hl	; offset 0x4491
	ld hl,44975	; offset 0x4494
	push hl	; offset 0x4495
	ld hl,44975	; offset 0x4498
	push hl	; offset 0x4499
	; delay to get start of scanline (-144 T-states) at offset 0x4499

	; src_data blit 204
	ld sp,screenStartAddr+2628	; offset 0x449c
	ld hl,44975	; offset 0x449f
	push hl	; offset 0x44a0
	ld hl,44975	; offset 0x44a3
	push hl	; offset 0x44a4
	ld hl,44975	; offset 0x44a7
	push hl	; offset 0x44a8
	ld hl,44975	; offset 0x44ab
	push hl	; offset 0x44ac
	ld hl,44975	; offset 0x44af
	push hl	; offset 0x44b0
	ld hl,44975	; offset 0x44b3
	push hl	; offset 0x44b4
	; delay to get start of scanline (-144 T-states) at offset 0x44b4

	; src_data blit 205
	ld sp,screenStartAddr+2868	; offset 0x44b7
	ld hl,44975	; offset 0x44ba
	push hl	; offset 0x44bb
	ld hl,44975	; offset 0x44be
	push hl	; offset 0x44bf
	ld hl,44975	; offset 0x44c2
	push hl	; offset 0x44c3
	ld hl,44975	; offset 0x44c6
	push hl	; offset 0x44c7
	ld hl,44975	; offset 0x44ca
	push hl	; offset 0x44cb
	ld hl,44975	; offset 0x44ce
	push hl	; offset 0x44cf
	; delay to get start of scanline (-144 T-states) at offset 0x44cf

	; src_data blit 206
	ld sp,screenStartAddr+2880	; offset 0x44d2
	ld hl,44975	; offset 0x44d5
	push hl	; offset 0x44d6
	ld hl,44975	; offset 0x44d9
	push hl	; offset 0x44da
	ld hl,44975	; offset 0x44dd
	push hl	; offset 0x44de
	ld hl,44975	; offset 0x44e1
	push hl	; offset 0x44e2
	ld hl,44975	; offset 0x44e5
	push hl	; offset 0x44e6
	ld hl,44975	; offset 0x44e9
	push hl	; offset 0x44ea
	; delay to get start of scanline (-144 T-states) at offset 0x44ea

	; src_data blit 207
	ld sp,screenStartAddr+3120	; offset 0x44ed
	ld hl,44975	; offset 0x44f0
	push hl	; offset 0x44f1
	ld hl,44975	; offset 0x44f4
	push hl	; offset 0x44f5
	ld hl,44975	; offset 0x44f8
	push hl	; offset 0x44f9
	ld hl,44975	; offset 0x44fc
	push hl	; offset 0x44fd
	ld hl,44975	; offset 0x4500
	push hl	; offset 0x4501
	ld hl,44975	; offset 0x4504
	push hl	; offset 0x4505
	; delay to get start of scanline (-144 T-states) at offset 0x4505

	; src_data blit 208
	ld sp,screenStartAddr+3132	; offset 0x4508
	ld hl,44975	; offset 0x450b
	push hl	; offset 0x450c
	ld hl,44975	; offset 0x450f
	push hl	; offset 0x4510
	ld hl,44975	; offset 0x4513
	push hl	; offset 0x4514
	ld hl,44975	; offset 0x4517
	push hl	; offset 0x4518
	ld hl,44975	; offset 0x451b
	push hl	; offset 0x451c
	ld hl,44975	; offset 0x451f
	push hl	; offset 0x4520
	; delay to get start of scanline (-144 T-states) at offset 0x4520

	; src_data blit 209
	ld sp,screenStartAddr+3144	; offset 0x4523
	ld hl,44975	; offset 0x4526
	push hl	; offset 0x4527
	ld hl,44975	; offset 0x452a
	push hl	; offset 0x452b
	ld hl,44975	; offset 0x452e
	push hl	; offset 0x452f
	ld hl,44975	; offset 0x4532
	push hl	; offset 0x4533
	ld hl,44975	; offset 0x4536
	push hl	; offset 0x4537
	ld hl,44975	; offset 0x453a
	push hl	; offset 0x453b
	; delay to get start of scanline (-144 T-states) at offset 0x453b

	; src_data blit 210
	ld sp,screenStartAddr+3372	; offset 0x453e
	ld hl,44975	; offset 0x4541
	push hl	; offset 0x4542
	ld hl,44975	; offset 0x4545
	push hl	; offset 0x4546
	ld hl,44975	; offset 0x4549
	push hl	; offset 0x454a
	ld hl,44975	; offset 0x454d
	push hl	; offset 0x454e
	ld hl,44975	; offset 0x4551
	push hl	; offset 0x4552
	ld hl,44975	; offset 0x4555
	push hl	; offset 0x4556
	; delay to get start of scanline (-144 T-states) at offset 0x4556

	; src_data blit 211
	ld sp,screenStartAddr+3384	; offset 0x4559
	ld hl,44975	; offset 0x455c
	push hl	; offset 0x455d
	ld hl,44975	; offset 0x4560
	push hl	; offset 0x4561
	ld hl,44975	; offset 0x4564
	push hl	; offset 0x4565
	ld hl,44975	; offset 0x4568
	push hl	; offset 0x4569
	ld hl,44975	; offset 0x456c
	push hl	; offset 0x456d
	ld hl,44975	; offset 0x4570
	push hl	; offset 0x4571
	; delay to get start of scanline (-144 T-states) at offset 0x4571

	; src_data blit 212
	ld sp,screenStartAddr+3396	; offset 0x4574
	ld hl,44975	; offset 0x4577
	push hl	; offset 0x4578
	ld hl,44975	; offset 0x457b
	push hl	; offset 0x457c
	ld hl,44975	; offset 0x457f
	push hl	; offset 0x4580
	ld hl,44975	; offset 0x4583
	push hl	; offset 0x4584
	ld hl,44975	; offset 0x4587
	push hl	; offset 0x4588
	ld hl,44975	; offset 0x458b
	push hl	; offset 0x458c
	; delay to get start of scanline (-144 T-states) at offset 0x458c

	; src_data blit 213
	ld sp,screenStartAddr+3636	; offset 0x458f
	ld hl,44975	; offset 0x4592
	push hl	; offset 0x4593
	ld hl,44975	; offset 0x4596
	push hl	; offset 0x4597
	ld hl,44975	; offset 0x459a
	push hl	; offset 0x459b
	ld hl,44975	; offset 0x459e
	push hl	; offset 0x459f
	ld hl,44975	; offset 0x45a2
	push hl	; offset 0x45a3
	ld hl,44975	; offset 0x45a6
	push hl	; offset 0x45a7
	; delay to get start of scanline (-144 T-states) at offset 0x45a7

	; src_data blit 214
	ld sp,screenStartAddr+3648	; offset 0x45aa
	ld hl,44975	; offset 0x45ad
	push hl	; offset 0x45ae
	ld hl,44975	; offset 0x45b1
	push hl	; offset 0x45b2
	ld hl,44975	; offset 0x45b5
	push hl	; offset 0x45b6
	ld hl,44975	; offset 0x45b9
	push hl	; offset 0x45ba
	ld hl,44975	; offset 0x45bd
	push hl	; offset 0x45be
	ld hl,44975	; offset 0x45c1
	push hl	; offset 0x45c2
	; delay to get start of scanline (-144 T-states) at offset 0x45c2

	; src_data blit 215
	ld sp,screenStartAddr+3888	; offset 0x45c5
	ld hl,44975	; offset 0x45c8
	push hl	; offset 0x45c9
	ld hl,44975	; offset 0x45cc
	push hl	; offset 0x45cd
	ld hl,44975	; offset 0x45d0
	push hl	; offset 0x45d1
	ld hl,44975	; offset 0x45d4
	push hl	; offset 0x45d5
	ld hl,44975	; offset 0x45d8
	push hl	; offset 0x45d9
	ld hl,44975	; offset 0x45dc
	push hl	; offset 0x45dd
	; delay to get start of scanline (-144 T-states) at offset 0x45dd

	; src_data blit 216
	ld sp,screenStartAddr+3900	; offset 0x45e0
	ld hl,44975	; offset 0x45e3
	push hl	; offset 0x45e4
	ld hl,44975	; offset 0x45e7
	push hl	; offset 0x45e8
	ld hl,44975	; offset 0x45eb
	push hl	; offset 0x45ec
	ld hl,44975	; offset 0x45ef
	push hl	; offset 0x45f0
	ld hl,44975	; offset 0x45f3
	push hl	; offset 0x45f4
	ld hl,44975	; offset 0x45f7
	push hl	; offset 0x45f8
	; delay to get start of scanline (-144 T-states) at offset 0x45f8

	; src_data blit 217
	ld sp,screenStartAddr+3912	; offset 0x45fb
	ld hl,44975	; offset 0x45fe
	push hl	; offset 0x45ff
	ld hl,44975	; offset 0x4602
	push hl	; offset 0x4603
	ld hl,44975	; offset 0x4606
	push hl	; offset 0x4607
	ld hl,44975	; offset 0x460a
	push hl	; offset 0x460b
	ld hl,44975	; offset 0x460e
	push hl	; offset 0x460f
	ld hl,44975	; offset 0x4612
	push hl	; offset 0x4613
	; delay to get start of scanline (-144 T-states) at offset 0x4613

	; src_data blit 218
	ld sp,screenStartAddr+2124	; offset 0x4616
	ld hl,44975	; offset 0x4619
	push hl	; offset 0x461a
	ld hl,44975	; offset 0x461d
	push hl	; offset 0x461e
	ld hl,44975	; offset 0x4621
	push hl	; offset 0x4622
	ld hl,44975	; offset 0x4625
	push hl	; offset 0x4626
	ld hl,44975	; offset 0x4629
	push hl	; offset 0x462a
	ld hl,44975	; offset 0x462d
	push hl	; offset 0x462e
	; delay to get start of scanline (-144 T-states) at offset 0x462e

	; src_data blit 219
	ld sp,screenStartAddr+2136	; offset 0x4631
	ld hl,44975	; offset 0x4634
	push hl	; offset 0x4635
	ld hl,44975	; offset 0x4638
	push hl	; offset 0x4639
	ld hl,44975	; offset 0x463c
	push hl	; offset 0x463d
	ld hl,44975	; offset 0x4640
	push hl	; offset 0x4641
	ld hl,44975	; offset 0x4644
	push hl	; offset 0x4645
	ld hl,44975	; offset 0x4648
	push hl	; offset 0x4649
	; delay to get start of scanline (-144 T-states) at offset 0x4649

	; src_data blit 220
	ld sp,screenStartAddr+2148	; offset 0x464c
	ld hl,44975	; offset 0x464f
	push hl	; offset 0x4650
	ld hl,44975	; offset 0x4653
	push hl	; offset 0x4654
	ld hl,44975	; offset 0x4657
	push hl	; offset 0x4658
	ld hl,44975	; offset 0x465b
	push hl	; offset 0x465c
	ld hl,44975	; offset 0x465f
	push hl	; offset 0x4660
	ld hl,44975	; offset 0x4663
	push hl	; offset 0x4664
	; delay to get start of scanline (-144 T-states) at offset 0x4664

	; src_data blit 221
	ld sp,screenStartAddr+2388	; offset 0x4667
	ld hl,44975	; offset 0x466a
	push hl	; offset 0x466b
	ld hl,44975	; offset 0x466e
	push hl	; offset 0x466f
	ld hl,44975	; offset 0x4672
	push hl	; offset 0x4673
	ld hl,44975	; offset 0x4676
	push hl	; offset 0x4677
	ld hl,44975	; offset 0x467a
	push hl	; offset 0x467b
	ld hl,44975	; offset 0x467e
	push hl	; offset 0x467f
	; delay to get start of scanline (-144 T-states) at offset 0x467f

	; src_data blit 222
	ld sp,screenStartAddr+2400	; offset 0x4682
	ld hl,44975	; offset 0x4685
	push hl	; offset 0x4686
	ld hl,44975	; offset 0x4689
	push hl	; offset 0x468a
	ld hl,44975	; offset 0x468d
	push hl	; offset 0x468e
	ld hl,44975	; offset 0x4691
	push hl	; offset 0x4692
	ld hl,44975	; offset 0x4695
	push hl	; offset 0x4696
	ld hl,44975	; offset 0x4699
	push hl	; offset 0x469a
	; delay to get start of scanline (-144 T-states) at offset 0x469a

	; src_data blit 223
	ld sp,screenStartAddr+2640	; offset 0x469d
	ld hl,44975	; offset 0x46a0
	push hl	; offset 0x46a1
	ld hl,44975	; offset 0x46a4
	push hl	; offset 0x46a5
	ld hl,44975	; offset 0x46a8
	push hl	; offset 0x46a9
	ld hl,44975	; offset 0x46ac
	push hl	; offset 0x46ad
	ld hl,44975	; offset 0x46b0
	push hl	; offset 0x46b1
	ld hl,44975	; offset 0x46b4
	push hl	; offset 0x46b5
	; delay to get start of scanline (-144 T-states) at offset 0x46b5

	; src_data blit 224
	ld sp,screenStartAddr+2652	; offset 0x46b8
	ld hl,44975	; offset 0x46bb
	push hl	; offset 0x46bc
	ld hl,44975	; offset 0x46bf
	push hl	; offset 0x46c0
	ld hl,44975	; offset 0x46c3
	push hl	; offset 0x46c4
	ld hl,44975	; offset 0x46c7
	push hl	; offset 0x46c8
	ld hl,44975	; offset 0x46cb
	push hl	; offset 0x46cc
	ld hl,44975	; offset 0x46cf
	push hl	; offset 0x46d0
	; delay to get start of scanline (-144 T-states) at offset 0x46d0

	; src_data blit 225
	ld sp,screenStartAddr+2664	; offset 0x46d3
	ld hl,44975	; offset 0x46d6
	push hl	; offset 0x46d7
	ld hl,44975	; offset 0x46da
	push hl	; offset 0x46db
	ld hl,44975	; offset 0x46de
	push hl	; offset 0x46df
	ld hl,44975	; offset 0x46e2
	push hl	; offset 0x46e3
	ld hl,44975	; offset 0x46e6
	push hl	; offset 0x46e7
	ld hl,44975	; offset 0x46ea
	push hl	; offset 0x46eb
	; delay to get start of scanline (-144 T-states) at offset 0x46eb

	; src_data blit 226
	ld sp,screenStartAddr+2892	; offset 0x46ee
	ld hl,44975	; offset 0x46f1
	push hl	; offset 0x46f2
	ld hl,44975	; offset 0x46f5
	push hl	; offset 0x46f6
	ld hl,44975	; offset 0x46f9
	push hl	; offset 0x46fa
	ld hl,44975	; offset 0x46fd
	push hl	; offset 0x46fe
	ld hl,44975	; offset 0x4701
	push hl	; offset 0x4702
	ld hl,44975	; offset 0x4705
	push hl	; offset 0x4706
	; delay to get start of scanline (-144 T-states) at offset 0x4706

	; src_data blit 227
	ld sp,screenStartAddr+2904	; offset 0x4709
	ld hl,44975	; offset 0x470c
	push hl	; offset 0x470d
	ld hl,44975	; offset 0x4710
	push hl	; offset 0x4711
	ld hl,44975	; offset 0x4714
	push hl	; offset 0x4715
	ld hl,44975	; offset 0x4718
	push hl	; offset 0x4719
	ld hl,44975	; offset 0x471c
	push hl	; offset 0x471d
	ld hl,44975	; offset 0x4720
	push hl	; offset 0x4721
	; delay to get start of scanline (-144 T-states) at offset 0x4721

	; src_data blit 228
	ld sp,screenStartAddr+2916	; offset 0x4724
	ld hl,44975	; offset 0x4727
	push hl	; offset 0x4728
	ld hl,44975	; offset 0x472b
	push hl	; offset 0x472c
	ld hl,44975	; offset 0x472f
	push hl	; offset 0x4730
	ld hl,44975	; offset 0x4733
	push hl	; offset 0x4734
	ld hl,44975	; offset 0x4737
	push hl	; offset 0x4738
	ld hl,44975	; offset 0x473b
	push hl	; offset 0x473c
	; delay to get start of scanline (-144 T-states) at offset 0x473c

	; src_data blit 229
	ld sp,screenStartAddr+3156	; offset 0x473f
	ld hl,44975	; offset 0x4742
	push hl	; offset 0x4743
	ld hl,44975	; offset 0x4746
	push hl	; offset 0x4747
	ld hl,44975	; offset 0x474a
	push hl	; offset 0x474b
	ld hl,44975	; offset 0x474e
	push hl	; offset 0x474f
	ld hl,44975	; offset 0x4752
	push hl	; offset 0x4753
	ld hl,44975	; offset 0x4756
	push hl	; offset 0x4757
	; delay to get start of scanline (-144 T-states) at offset 0x4757

	; src_data blit 230
	ld sp,screenStartAddr+3168	; offset 0x475a
	ld hl,44975	; offset 0x475d
	push hl	; offset 0x475e
	ld hl,44975	; offset 0x4761
	push hl	; offset 0x4762
	ld hl,44975	; offset 0x4765
	push hl	; offset 0x4766
	ld hl,44975	; offset 0x4769
	push hl	; offset 0x476a
	ld hl,44975	; offset 0x476d
	push hl	; offset 0x476e
	ld hl,44975	; offset 0x4771
	push hl	; offset 0x4772
	; delay to get start of scanline (-144 T-states) at offset 0x4772

	; src_data blit 231
	ld sp,screenStartAddr+3408	; offset 0x4775
	ld hl,44975	; offset 0x4778
	push hl	; offset 0x4779
	ld hl,44975	; offset 0x477c
	push hl	; offset 0x477d
	ld hl,44975	; offset 0x4780
	push hl	; offset 0x4781
	ld hl,44975	; offset 0x4784
	push hl	; offset 0x4785
	ld hl,44975	; offset 0x4788
	push hl	; offset 0x4789
	ld hl,44975	; offset 0x478c
	push hl	; offset 0x478d
	; delay to get start of scanline (-144 T-states) at offset 0x478d

	; src_data blit 232
	ld sp,screenStartAddr+3420	; offset 0x4790
	ld hl,44975	; offset 0x4793
	push hl	; offset 0x4794
	ld hl,44975	; offset 0x4797
	push hl	; offset 0x4798
	ld hl,44975	; offset 0x479b
	push hl	; offset 0x479c
	ld hl,44975	; offset 0x479f
	push hl	; offset 0x47a0
	ld hl,44975	; offset 0x47a3
	push hl	; offset 0x47a4
	ld hl,44975	; offset 0x47a7
	push hl	; offset 0x47a8
	; delay to get start of scanline (-144 T-states) at offset 0x47a8

	; src_data blit 233
	ld sp,screenStartAddr+3432	; offset 0x47ab
	ld hl,44975	; offset 0x47ae
	push hl	; offset 0x47af
	ld hl,44975	; offset 0x47b2
	push hl	; offset 0x47b3
	ld hl,44975	; offset 0x47b6
	push hl	; offset 0x47b7
	ld hl,44975	; offset 0x47ba
	push hl	; offset 0x47bb
	ld hl,44975	; offset 0x47be
	push hl	; offset 0x47bf
	ld hl,44975	; offset 0x47c2
	push hl	; offset 0x47c3
	; delay to get start of scanline (-144 T-states) at offset 0x47c3

	; src_data blit 234
	ld sp,screenStartAddr+3660	; offset 0x47c6
	ld hl,44975	; offset 0x47c9
	push hl	; offset 0x47ca
	ld hl,44975	; offset 0x47cd
	push hl	; offset 0x47ce
	ld hl,44975	; offset 0x47d1
	push hl	; offset 0x47d2
	ld hl,44975	; offset 0x47d5
	push hl	; offset 0x47d6
	ld hl,44975	; offset 0x47d9
	push hl	; offset 0x47da
	ld hl,44975	; offset 0x47dd
	push hl	; offset 0x47de
	; delay to get start of scanline (-144 T-states) at offset 0x47de

	; src_data blit 235
	ld sp,screenStartAddr+3672	; offset 0x47e1
	ld hl,44975	; offset 0x47e4
	push hl	; offset 0x47e5
	ld hl,44975	; offset 0x47e8
	push hl	; offset 0x47e9
	ld hl,44975	; offset 0x47ec
	push hl	; offset 0x47ed
	ld hl,44975	; offset 0x47f0
	push hl	; offset 0x47f1
	ld hl,44975	; offset 0x47f4
	push hl	; offset 0x47f5
	ld hl,44975	; offset 0x47f8
	push hl	; offset 0x47f9
	; delay to get start of scanline (-144 T-states) at offset 0x47f9

	; src_data blit 236
	ld sp,screenStartAddr+3684	; offset 0x47fc
	ld hl,44975	; offset 0x47ff
	push hl	; offset 0x4800
	ld hl,44975	; offset 0x4803
	push hl	; offset 0x4804
	ld hl,44975	; offset 0x4807
	push hl	; offset 0x4808
	ld hl,44975	; offset 0x480b
	push hl	; offset 0x480c
	ld hl,44975	; offset 0x480f
	push hl	; offset 0x4810
	ld hl,44975	; offset 0x4813
	push hl	; offset 0x4814
	; delay to get start of scanline (-144 T-states) at offset 0x4814

	; src_data blit 237
	ld sp,screenStartAddr+3924	; offset 0x4817
	ld hl,44975	; offset 0x481a
	push hl	; offset 0x481b
	ld hl,44975	; offset 0x481e
	push hl	; offset 0x481f
	ld hl,44975	; offset 0x4822
	push hl	; offset 0x4823
	ld hl,44975	; offset 0x4826
	push hl	; offset 0x4827
	ld hl,44975	; offset 0x482a
	push hl	; offset 0x482b
	ld hl,44975	; offset 0x482e
	push hl	; offset 0x482f
	; delay to get start of scanline (-144 T-states) at offset 0x482f

	; src_data blit 238
	ld sp,screenStartAddr+3936	; offset 0x4832
	ld hl,44975	; offset 0x4835
	push hl	; offset 0x4836
	ld hl,44975	; offset 0x4839
	push hl	; offset 0x483a
	ld hl,44975	; offset 0x483d
	push hl	; offset 0x483e
	ld hl,44975	; offset 0x4841
	push hl	; offset 0x4842
	ld hl,44975	; offset 0x4845
	push hl	; offset 0x4846
	ld hl,44975	; offset 0x4849
	push hl	; offset 0x484a
	; delay to get start of scanline (-144 T-states) at offset 0x484a

	; src_data blit 239
	ld sp,screenStartAddr+2160	; offset 0x484d
	ld hl,44975	; offset 0x4850
	push hl	; offset 0x4851
	ld hl,44975	; offset 0x4854
	push hl	; offset 0x4855
	ld hl,44975	; offset 0x4858
	push hl	; offset 0x4859
	ld hl,44975	; offset 0x485c
	push hl	; offset 0x485d
	ld hl,44975	; offset 0x4860
	push hl	; offset 0x4861
	ld hl,44975	; offset 0x4864
	push hl	; offset 0x4865
	; delay to get start of scanline (-144 T-states) at offset 0x4865

	; src_data blit 240
	ld sp,screenStartAddr+2172	; offset 0x4868
	ld hl,44975	; offset 0x486b
	push hl	; offset 0x486c
	ld hl,44975	; offset 0x486f
	push hl	; offset 0x4870
	ld hl,44975	; offset 0x4873
	push hl	; offset 0x4874
	ld hl,44975	; offset 0x4877
	push hl	; offset 0x4878
	ld hl,44975	; offset 0x487b
	push hl	; offset 0x487c
	ld hl,44975	; offset 0x487f
	push hl	; offset 0x4880
	; delay to get start of scanline (-144 T-states) at offset 0x4880

	; src_data blit 241
	ld sp,screenStartAddr+2184	; offset 0x4883
	ld hl,44975	; offset 0x4886
	push hl	; offset 0x4887
	ld hl,44975	; offset 0x488a
	push hl	; offset 0x488b
	ld hl,44975	; offset 0x488e
	push hl	; offset 0x488f
	ld hl,44975	; offset 0x4892
	push hl	; offset 0x4893
	ld hl,44975	; offset 0x4896
	push hl	; offset 0x4897
	ld hl,44975	; offset 0x489a
	push hl	; offset 0x489b
	; delay to get start of scanline (-144 T-states) at offset 0x489b

	; src_data blit 242
	ld sp,screenStartAddr+2412	; offset 0x489e
	ld hl,44975	; offset 0x48a1
	push hl	; offset 0x48a2
	ld hl,44975	; offset 0x48a5
	push hl	; offset 0x48a6
	ld hl,44975	; offset 0x48a9
	push hl	; offset 0x48aa
	ld hl,44975	; offset 0x48ad
	push hl	; offset 0x48ae
	ld hl,44975	; offset 0x48b1
	push hl	; offset 0x48b2
	ld hl,44975	; offset 0x48b5
	push hl	; offset 0x48b6
	; delay to get start of scanline (-144 T-states) at offset 0x48b6

	; src_data blit 243
	ld sp,screenStartAddr+2424	; offset 0x48b9
	ld hl,44975	; offset 0x48bc
	push hl	; offset 0x48bd
	ld hl,44975	; offset 0x48c0
	push hl	; offset 0x48c1
	ld hl,44975	; offset 0x48c4
	push hl	; offset 0x48c5
	ld hl,44975	; offset 0x48c8
	push hl	; offset 0x48c9
	ld hl,44975	; offset 0x48cc
	push hl	; offset 0x48cd
	ld hl,44975	; offset 0x48d0
	push hl	; offset 0x48d1
	; delay to get start of scanline (-144 T-states) at offset 0x48d1

	; src_data blit 244
	ld sp,screenStartAddr+2436	; offset 0x48d4
	ld hl,44975	; offset 0x48d7
	push hl	; offset 0x48d8
	ld hl,44975	; offset 0x48db
	push hl	; offset 0x48dc
	ld hl,44975	; offset 0x48df
	push hl	; offset 0x48e0
	ld hl,44975	; offset 0x48e3
	push hl	; offset 0x48e4
	ld hl,44975	; offset 0x48e7
	push hl	; offset 0x48e8
	ld hl,44975	; offset 0x48eb
	push hl	; offset 0x48ec
	; delay to get start of scanline (-144 T-states) at offset 0x48ec

	; src_data blit 245
	ld sp,screenStartAddr+2676	; offset 0x48ef
	ld hl,44975	; offset 0x48f2
	push hl	; offset 0x48f3
	ld hl,44975	; offset 0x48f6
	push hl	; offset 0x48f7
	ld hl,44975	; offset 0x48fa
	push hl	; offset 0x48fb
	ld hl,44975	; offset 0x48fe
	push hl	; offset 0x48ff
	ld hl,44975	; offset 0x4902
	push hl	; offset 0x4903
	ld hl,44975	; offset 0x4906
	push hl	; offset 0x4907
	; delay to get start of scanline (-144 T-states) at offset 0x4907

	; src_data blit 246
	ld sp,screenStartAddr+2688	; offset 0x490a
	ld hl,44975	; offset 0x490d
	push hl	; offset 0x490e
	ld hl,44975	; offset 0x4911
	push hl	; offset 0x4912
	ld hl,44975	; offset 0x4915
	push hl	; offset 0x4916
	ld hl,44975	; offset 0x4919
	push hl	; offset 0x491a
	ld hl,44975	; offset 0x491d
	push hl	; offset 0x491e
	ld hl,44975	; offset 0x4921
	push hl	; offset 0x4922
	; delay to get start of scanline (-144 T-states) at offset 0x4922

	; src_data blit 247
	ld sp,screenStartAddr+2928	; offset 0x4925
	ld hl,44975	; offset 0x4928
	push hl	; offset 0x4929
	ld hl,44975	; offset 0x492c
	push hl	; offset 0x492d
	ld hl,44975	; offset 0x4930
	push hl	; offset 0x4931
	ld hl,44975	; offset 0x4934
	push hl	; offset 0x4935
	ld hl,44975	; offset 0x4938
	push hl	; offset 0x4939
	ld hl,44975	; offset 0x493c
	push hl	; offset 0x493d
	; delay to get start of scanline (-144 T-states) at offset 0x493d

	; src_data blit 248
	ld sp,screenStartAddr+2940	; offset 0x4940
	ld hl,44975	; offset 0x4943
	push hl	; offset 0x4944
	ld hl,44975	; offset 0x4947
	push hl	; offset 0x4948
	ld hl,44975	; offset 0x494b
	push hl	; offset 0x494c
	ld hl,44975	; offset 0x494f
	push hl	; offset 0x4950
	ld hl,44975	; offset 0x4953
	push hl	; offset 0x4954
	ld hl,44975	; offset 0x4957
	push hl	; offset 0x4958
	; delay to get start of scanline (-144 T-states) at offset 0x4958

	; src_data blit 249
	ld sp,screenStartAddr+2952	; offset 0x495b
	ld hl,44975	; offset 0x495e
	push hl	; offset 0x495f
	ld hl,44975	; offset 0x4962
	push hl	; offset 0x4963
	ld hl,44975	; offset 0x4966
	push hl	; offset 0x4967
	ld hl,44975	; offset 0x496a
	push hl	; offset 0x496b
	ld hl,44975	; offset 0x496e
	push hl	; offset 0x496f
	ld hl,44975	; offset 0x4972
	push hl	; offset 0x4973
	; delay to get start of scanline (-144 T-states) at offset 0x4973

	; src_data blit 250
	ld sp,screenStartAddr+3180	; offset 0x4976
	ld hl,44975	; offset 0x4979
	push hl	; offset 0x497a
	ld hl,44975	; offset 0x497d
	push hl	; offset 0x497e
	ld hl,44975	; offset 0x4981
	push hl	; offset 0x4982
	ld hl,44975	; offset 0x4985
	push hl	; offset 0x4986
	ld hl,44975	; offset 0x4989
	push hl	; offset 0x498a
	ld hl,44975	; offset 0x498d
	push hl	; offset 0x498e
	; delay to get start of scanline (-144 T-states) at offset 0x498e

	; src_data blit 251
	ld sp,screenStartAddr+3192	; offset 0x4991
	ld hl,44975	; offset 0x4994
	push hl	; offset 0x4995
	ld hl,44975	; offset 0x4998
	push hl	; offset 0x4999
	ld hl,44975	; offset 0x499c
	push hl	; offset 0x499d
	ld hl,44975	; offset 0x49a0
	push hl	; offset 0x49a1
	ld hl,44975	; offset 0x49a4
	push hl	; offset 0x49a5
	ld hl,44975	; offset 0x49a8
	push hl	; offset 0x49a9
	; delay to get start of scanline (-144 T-states) at offset 0x49a9

	; src_data blit 252
	ld sp,screenStartAddr+3204	; offset 0x49ac
	ld hl,44975	; offset 0x49af
	push hl	; offset 0x49b0
	ld hl,44975	; offset 0x49b3
	push hl	; offset 0x49b4
	ld hl,44975	; offset 0x49b7
	push hl	; offset 0x49b8
	ld hl,44975	; offset 0x49bb
	push hl	; offset 0x49bc
	ld hl,44975	; offset 0x49bf
	push hl	; offset 0x49c0
	ld hl,44975	; offset 0x49c3
	push hl	; offset 0x49c4
	; delay to get start of scanline (-144 T-states) at offset 0x49c4

	; src_data blit 253
	ld sp,screenStartAddr+3444	; offset 0x49c7
	ld hl,44975	; offset 0x49ca
	push hl	; offset 0x49cb
	ld hl,44975	; offset 0x49ce
	push hl	; offset 0x49cf
	ld hl,44975	; offset 0x49d2
	push hl	; offset 0x49d3
	ld hl,44975	; offset 0x49d6
	push hl	; offset 0x49d7
	ld hl,44975	; offset 0x49da
	push hl	; offset 0x49db
	ld hl,44975	; offset 0x49de
	push hl	; offset 0x49df
	; delay to get start of scanline (-144 T-states) at offset 0x49df

	; src_data blit 254
	ld sp,screenStartAddr+3456	; offset 0x49e2
	ld hl,44975	; offset 0x49e5
	push hl	; offset 0x49e6
	ld hl,44975	; offset 0x49e9
	push hl	; offset 0x49ea
	ld hl,44975	; offset 0x49ed
	push hl	; offset 0x49ee
	ld hl,44975	; offset 0x49f1
	push hl	; offset 0x49f2
	ld hl,44975	; offset 0x49f5
	push hl	; offset 0x49f6
	ld hl,44975	; offset 0x49f9
	push hl	; offset 0x49fa
	; delay to get start of scanline (-144 T-states) at offset 0x49fa

	; src_data blit 255
	ld sp,screenStartAddr+3696	; offset 0x49fd
	ld hl,44975	; offset 0x4a00
	push hl	; offset 0x4a01
	ld hl,44975	; offset 0x4a04
	push hl	; offset 0x4a05
	ld hl,44975	; offset 0x4a08
	push hl	; offset 0x4a09
	ld hl,44975	; offset 0x4a0c
	push hl	; offset 0x4a0d
	ld hl,44975	; offset 0x4a10
	push hl	; offset 0x4a11
	ld hl,44975	; offset 0x4a14
	push hl	; offset 0x4a15
	; delay to get start of scanline (-144 T-states) at offset 0x4a15

	; src_data blit 256
	ld sp,screenStartAddr+3708	; offset 0x4a18
	ld hl,44975	; offset 0x4a1b
	push hl	; offset 0x4a1c
	ld hl,44975	; offset 0x4a1f
	push hl	; offset 0x4a20
	ld hl,44975	; offset 0x4a23
	push hl	; offset 0x4a24
	ld hl,44975	; offset 0x4a27
	push hl	; offset 0x4a28
	ld hl,44975	; offset 0x4a2b
	push hl	; offset 0x4a2c
	ld hl,44975	; offset 0x4a2f
	push hl	; offset 0x4a30
	; delay to get start of scanline (-144 T-states) at offset 0x4a30

	; src_data blit 257
	ld sp,screenStartAddr+3720	; offset 0x4a33
	ld hl,44975	; offset 0x4a36
	push hl	; offset 0x4a37
	ld hl,44975	; offset 0x4a3a
	push hl	; offset 0x4a3b
	ld hl,44975	; offset 0x4a3e
	push hl	; offset 0x4a3f
	ld hl,44975	; offset 0x4a42
	push hl	; offset 0x4a43
	ld hl,44975	; offset 0x4a46
	push hl	; offset 0x4a47
	ld hl,44975	; offset 0x4a4a
	push hl	; offset 0x4a4b
	; delay to get start of scanline (-144 T-states) at offset 0x4a4b

	; src_data blit 258
	ld sp,screenStartAddr+3948	; offset 0x4a4e
	ld hl,44975	; offset 0x4a51
	push hl	; offset 0x4a52
	ld hl,44975	; offset 0x4a55
	push hl	; offset 0x4a56
	ld hl,44975	; offset 0x4a59
	push hl	; offset 0x4a5a
	ld hl,44975	; offset 0x4a5d
	push hl	; offset 0x4a5e
	ld hl,44975	; offset 0x4a61
	push hl	; offset 0x4a62
	ld hl,44975	; offset 0x4a65
	push hl	; offset 0x4a66
	; delay to get start of scanline (-144 T-states) at offset 0x4a66

	; src_data blit 259
	ld sp,screenStartAddr+3960	; offset 0x4a69
	ld hl,44975	; offset 0x4a6c
	push hl	; offset 0x4a6d
	ld hl,44975	; offset 0x4a70
	push hl	; offset 0x4a71
	ld hl,44975	; offset 0x4a74
	push hl	; offset 0x4a75
	ld hl,44975	; offset 0x4a78
	push hl	; offset 0x4a79
	ld hl,44975	; offset 0x4a7c
	push hl	; offset 0x4a7d
	ld hl,44975	; offset 0x4a80
	push hl	; offset 0x4a81
	; delay to get start of scanline (-144 T-states) at offset 0x4a81

	; src_data blit 260
	ld sp,screenStartAddr+3972	; offset 0x4a84
	ld hl,44975	; offset 0x4a87
	push hl	; offset 0x4a88
	ld hl,44975	; offset 0x4a8b
	push hl	; offset 0x4a8c
	ld hl,44975	; offset 0x4a8f
	push hl	; offset 0x4a90
	ld hl,44975	; offset 0x4a93
	push hl	; offset 0x4a94
	ld hl,44975	; offset 0x4a97
	push hl	; offset 0x4a98
	ld hl,44975	; offset 0x4a9b
	push hl	; offset 0x4a9c
	; delay to get start of scanline (-144 T-states) at offset 0x4a9c

	; src_data blit 261
	ld sp,screenStartAddr+2196	; offset 0x4a9f
	ld hl,44975	; offset 0x4aa2
	push hl	; offset 0x4aa3
	ld hl,44975	; offset 0x4aa6
	push hl	; offset 0x4aa7
	ld hl,44975	; offset 0x4aaa
	push hl	; offset 0x4aab
	ld hl,44975	; offset 0x4aae
	push hl	; offset 0x4aaf
	ld hl,44975	; offset 0x4ab2
	push hl	; offset 0x4ab3
	ld hl,44975	; offset 0x4ab6
	push hl	; offset 0x4ab7
	; delay to get start of scanline (-144 T-states) at offset 0x4ab7

	; src_data blit 262
	ld sp,screenStartAddr+2208	; offset 0x4aba
	ld hl,44975	; offset 0x4abd
	push hl	; offset 0x4abe
	ld hl,44975	; offset 0x4ac1
	push hl	; offset 0x4ac2
	ld hl,44975	; offset 0x4ac5
	push hl	; offset 0x4ac6
	ld hl,44975	; offset 0x4ac9
	push hl	; offset 0x4aca
	ld hl,44975	; offset 0x4acd
	push hl	; offset 0x4ace
	ld hl,44975	; offset 0x4ad1
	push hl	; offset 0x4ad2
	; delay to get start of scanline (-144 T-states) at offset 0x4ad2

	; src_data blit 263
	ld sp,screenStartAddr+2448	; offset 0x4ad5
	ld hl,44975	; offset 0x4ad8
	push hl	; offset 0x4ad9
	ld hl,44975	; offset 0x4adc
	push hl	; offset 0x4add
	ld hl,44975	; offset 0x4ae0
	push hl	; offset 0x4ae1
	ld hl,44975	; offset 0x4ae4
	push hl	; offset 0x4ae5
	ld hl,44975	; offset 0x4ae8
	push hl	; offset 0x4ae9
	ld hl,44975	; offset 0x4aec
	push hl	; offset 0x4aed
	; delay to get start of scanline (-144 T-states) at offset 0x4aed

	; src_data blit 264
	ld sp,screenStartAddr+2460	; offset 0x4af0
	ld hl,44975	; offset 0x4af3
	push hl	; offset 0x4af4
	ld hl,44975	; offset 0x4af7
	push hl	; offset 0x4af8
	ld hl,44975	; offset 0x4afb
	push hl	; offset 0x4afc
	ld hl,44975	; offset 0x4aff
	push hl	; offset 0x4b00
	ld hl,44975	; offset 0x4b03
	push hl	; offset 0x4b04
	ld hl,44975	; offset 0x4b07
	push hl	; offset 0x4b08
	; delay to get start of scanline (-144 T-states) at offset 0x4b08

	; src_data blit 265
	ld sp,screenStartAddr+2472	; offset 0x4b0b
	ld hl,44975	; offset 0x4b0e
	push hl	; offset 0x4b0f
	ld hl,44975	; offset 0x4b12
	push hl	; offset 0x4b13
	ld hl,44975	; offset 0x4b16
	push hl	; offset 0x4b17
	ld hl,44975	; offset 0x4b1a
	push hl	; offset 0x4b1b
	ld hl,44975	; offset 0x4b1e
	push hl	; offset 0x4b1f
	ld hl,44975	; offset 0x4b22
	push hl	; offset 0x4b23
	; delay to get start of scanline (-144 T-states) at offset 0x4b23

	; src_data blit 266
	ld sp,screenStartAddr+2700	; offset 0x4b26
	ld hl,44975	; offset 0x4b29
	push hl	; offset 0x4b2a
	ld hl,44975	; offset 0x4b2d
	push hl	; offset 0x4b2e
	ld hl,44975	; offset 0x4b31
	push hl	; offset 0x4b32
	ld hl,44975	; offset 0x4b35
	push hl	; offset 0x4b36
	ld hl,44975	; offset 0x4b39
	push hl	; offset 0x4b3a
	ld hl,44975	; offset 0x4b3d
	push hl	; offset 0x4b3e
	; delay to get start of scanline (-144 T-states) at offset 0x4b3e

	; src_data blit 267
	ld sp,screenStartAddr+2712	; offset 0x4b41
	ld hl,44975	; offset 0x4b44
	push hl	; offset 0x4b45
	ld hl,44975	; offset 0x4b48
	push hl	; offset 0x4b49
	ld hl,44975	; offset 0x4b4c
	push hl	; offset 0x4b4d
	ld hl,44975	; offset 0x4b50
	push hl	; offset 0x4b51
	ld hl,44975	; offset 0x4b54
	push hl	; offset 0x4b55
	ld hl,44975	; offset 0x4b58
	push hl	; offset 0x4b59
	; delay to get start of scanline (-144 T-states) at offset 0x4b59

	; Jump to second half of frame render (normally jumps back to pop_push_even, and MCU swaps buffer pointer so new command list exists in same memory space)
	jp fake_jmp
fake_jmp:

	; Restore the stack pointer
	ld sp,(spBackupAddr)	; offset 0x4b5f
	ret

	SAVEBIN "sp48.rom",0,$
