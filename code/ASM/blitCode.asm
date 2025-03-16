pop_push_even:
	ld (spBackupAddr),sp

	; Block attribute blit start
	ld sp,attrStartAddr+768	; Set sp to end of attr memory - code offset 0x015d

	ld hl,3662	; src offset 766, code offset 0x0160
	push hl		; code offset 0x0161
	ld hl,3662	; src offset 764, code offset 0x0164
	push hl		; code offset 0x0165
	ld hl,3662	; src offset 762, code offset 0x0168
	push hl		; code offset 0x0169
	ld hl,3662	; src offset 760, code offset 0x016c
	push hl		; code offset 0x016d
	ld hl,3662	; src offset 758, code offset 0x0170
	push hl		; code offset 0x0171
	ld hl,3662	; src offset 756, code offset 0x0174
	push hl		; code offset 0x0175
	ld hl,3662	; src offset 754, code offset 0x0178
	push hl		; code offset 0x0179
	ld hl,3662	; src offset 752, code offset 0x017c
	push hl		; code offset 0x017d
	ld hl,3662	; src offset 750, code offset 0x0180
	push hl		; code offset 0x0181
	ld hl,3662	; src offset 748, code offset 0x0184
	push hl		; code offset 0x0185
	ld hl,3662	; src offset 746, code offset 0x0188
	push hl		; code offset 0x0189
	ld hl,3662	; src offset 744, code offset 0x018c
	push hl		; code offset 0x018d
	ld hl,3662	; src offset 742, code offset 0x0190
	push hl		; code offset 0x0191
	ld hl,3662	; src offset 740, code offset 0x0194
	push hl		; code offset 0x0195
	ld hl,3662	; src offset 738, code offset 0x0198
	push hl		; code offset 0x0199
	ld hl,3662	; src offset 736, code offset 0x019c
	push hl		; code offset 0x019d
	ld hl,3662	; src offset 734, code offset 0x01a0
	push hl		; code offset 0x01a1
	ld hl,3662	; src offset 732, code offset 0x01a4
	push hl		; code offset 0x01a5
	ld hl,3662	; src offset 730, code offset 0x01a8
	push hl		; code offset 0x01a9
	ld hl,3662	; src offset 728, code offset 0x01ac
	push hl		; code offset 0x01ad
	ld hl,3662	; src offset 726, code offset 0x01b0
	push hl		; code offset 0x01b1
	ld hl,3662	; src offset 724, code offset 0x01b4
	push hl		; code offset 0x01b5
	ld hl,3662	; src offset 722, code offset 0x01b8
	push hl		; code offset 0x01b9
	ld hl,3662	; src offset 720, code offset 0x01bc
	push hl		; code offset 0x01bd
	ld hl,3662	; src offset 718, code offset 0x01c0
	push hl		; code offset 0x01c1
	ld hl,3662	; src offset 716, code offset 0x01c4
	push hl		; code offset 0x01c5
	ld hl,3662	; src offset 714, code offset 0x01c8
	push hl		; code offset 0x01c9
	ld hl,3662	; src offset 712, code offset 0x01cc
	push hl		; code offset 0x01cd
	ld hl,3662	; src offset 710, code offset 0x01d0
	push hl		; code offset 0x01d1
	ld hl,3662	; src offset 708, code offset 0x01d4
	push hl		; code offset 0x01d5
	ld hl,3662	; src offset 706, code offset 0x01d8
	push hl		; code offset 0x01d9
	ld hl,3662	; src offset 704, code offset 0x01dc
	push hl		; code offset 0x01dd
	ld hl,3662	; src offset 702, code offset 0x01e0
	push hl		; code offset 0x01e1
	ld hl,3662	; src offset 700, code offset 0x01e4
	push hl		; code offset 0x01e5
	ld hl,3662	; src offset 698, code offset 0x01e8
	push hl		; code offset 0x01e9
	ld hl,3662	; src offset 696, code offset 0x01ec
	push hl		; code offset 0x01ed
	ld hl,3662	; src offset 694, code offset 0x01f0
	push hl		; code offset 0x01f1
	ld hl,3662	; src offset 692, code offset 0x01f4
	push hl		; code offset 0x01f5
	ld hl,3662	; src offset 690, code offset 0x01f8
	push hl		; code offset 0x01f9
	ld hl,3662	; src offset 688, code offset 0x01fc
	push hl		; code offset 0x01fd
	ld hl,3662	; src offset 686, code offset 0x0200
	push hl		; code offset 0x0201
	ld hl,3662	; src offset 684, code offset 0x0204
	push hl		; code offset 0x0205
	ld hl,3662	; src offset 682, code offset 0x0208
	push hl		; code offset 0x0209
	ld hl,3662	; src offset 680, code offset 0x020c
	push hl		; code offset 0x020d
	ld hl,3662	; src offset 678, code offset 0x0210
	push hl		; code offset 0x0211
	ld hl,3662	; src offset 676, code offset 0x0214
	push hl		; code offset 0x0215
	ld hl,3662	; src offset 674, code offset 0x0218
	push hl		; code offset 0x0219
	ld hl,3662	; src offset 672, code offset 0x021c
	push hl		; code offset 0x021d
	ld hl,3662	; src offset 670, code offset 0x0220
	push hl		; code offset 0x0221
	ld hl,3662	; src offset 668, code offset 0x0224
	push hl		; code offset 0x0225
	ld hl,3662	; src offset 666, code offset 0x0228
	push hl		; code offset 0x0229
	ld hl,3662	; src offset 664, code offset 0x022c
	push hl		; code offset 0x022d
	ld hl,3662	; src offset 662, code offset 0x0230
	push hl		; code offset 0x0231
	ld hl,3662	; src offset 660, code offset 0x0234
	push hl		; code offset 0x0235
	ld hl,3662	; src offset 658, code offset 0x0238
	push hl		; code offset 0x0239
	ld hl,3662	; src offset 656, code offset 0x023c
	push hl		; code offset 0x023d
	ld hl,3662	; src offset 654, code offset 0x0240
	push hl		; code offset 0x0241
	ld hl,3662	; src offset 652, code offset 0x0244
	push hl		; code offset 0x0245
	ld hl,3662	; src offset 650, code offset 0x0248
	push hl		; code offset 0x0249
	ld hl,3662	; src offset 648, code offset 0x024c
	push hl		; code offset 0x024d
	ld hl,3662	; src offset 646, code offset 0x0250
	push hl		; code offset 0x0251
	ld hl,3662	; src offset 644, code offset 0x0254
	push hl		; code offset 0x0255
	ld hl,3662	; src offset 642, code offset 0x0258
	push hl		; code offset 0x0259
	ld hl,3662	; src offset 640, code offset 0x025c
	push hl		; code offset 0x025d
	ld hl,3662	; src offset 638, code offset 0x0260
	push hl		; code offset 0x0261
	ld hl,3662	; src offset 636, code offset 0x0264
	push hl		; code offset 0x0265
	ld hl,3662	; src offset 634, code offset 0x0268
	push hl		; code offset 0x0269
	ld hl,3662	; src offset 632, code offset 0x026c
	push hl		; code offset 0x026d
	ld hl,3662	; src offset 630, code offset 0x0270
	push hl		; code offset 0x0271
	ld hl,3662	; src offset 628, code offset 0x0274
	push hl		; code offset 0x0275
	ld hl,3662	; src offset 626, code offset 0x0278
	push hl		; code offset 0x0279
	ld hl,3662	; src offset 624, code offset 0x027c
	push hl		; code offset 0x027d
	ld hl,3662	; src offset 622, code offset 0x0280
	push hl		; code offset 0x0281
	ld hl,3662	; src offset 620, code offset 0x0284
	push hl		; code offset 0x0285
	ld hl,3662	; src offset 618, code offset 0x0288
	push hl		; code offset 0x0289
	ld hl,3662	; src offset 616, code offset 0x028c
	push hl		; code offset 0x028d
	ld hl,3662	; src offset 614, code offset 0x0290
	push hl		; code offset 0x0291
	ld hl,3662	; src offset 612, code offset 0x0294
	push hl		; code offset 0x0295
	ld hl,3662	; src offset 610, code offset 0x0298
	push hl		; code offset 0x0299
	ld hl,3662	; src offset 608, code offset 0x029c
	push hl		; code offset 0x029d
	ld hl,3662	; src offset 606, code offset 0x02a0
	push hl		; code offset 0x02a1
	ld hl,3662	; src offset 604, code offset 0x02a4
	push hl		; code offset 0x02a5
	ld hl,3662	; src offset 602, code offset 0x02a8
	push hl		; code offset 0x02a9
	ld hl,3662	; src offset 600, code offset 0x02ac
	push hl		; code offset 0x02ad
	ld hl,3662	; src offset 598, code offset 0x02b0
	push hl		; code offset 0x02b1
	ld hl,3662	; src offset 596, code offset 0x02b4
	push hl		; code offset 0x02b5
	ld hl,3662	; src offset 594, code offset 0x02b8
	push hl		; code offset 0x02b9
	ld hl,3662	; src offset 592, code offset 0x02bc
	push hl		; code offset 0x02bd
	ld hl,3662	; src offset 590, code offset 0x02c0
	push hl		; code offset 0x02c1
	ld hl,3662	; src offset 588, code offset 0x02c4
	push hl		; code offset 0x02c5
	ld hl,3662	; src offset 586, code offset 0x02c8
	push hl		; code offset 0x02c9
	ld hl,3662	; src offset 584, code offset 0x02cc
	push hl		; code offset 0x02cd
	ld hl,3662	; src offset 582, code offset 0x02d0
	push hl		; code offset 0x02d1
	ld hl,3662	; src offset 580, code offset 0x02d4
	push hl		; code offset 0x02d5
	ld hl,3662	; src offset 578, code offset 0x02d8
	push hl		; code offset 0x02d9
	ld hl,3662	; src offset 576, code offset 0x02dc
	push hl		; code offset 0x02dd
	ld hl,3662	; src offset 574, code offset 0x02e0
	push hl		; code offset 0x02e1
	ld hl,3662	; src offset 572, code offset 0x02e4
	push hl		; code offset 0x02e5
	ld hl,3662	; src offset 570, code offset 0x02e8
	push hl		; code offset 0x02e9
	ld hl,3662	; src offset 568, code offset 0x02ec
	push hl		; code offset 0x02ed
	ld hl,3662	; src offset 566, code offset 0x02f0
	push hl		; code offset 0x02f1
	ld hl,3662	; src offset 564, code offset 0x02f4
	push hl		; code offset 0x02f5
	ld hl,3662	; src offset 562, code offset 0x02f8
	push hl		; code offset 0x02f9
	ld hl,3662	; src offset 560, code offset 0x02fc
	push hl		; code offset 0x02fd
	ld hl,3662	; src offset 558, code offset 0x0300
	push hl		; code offset 0x0301
	ld hl,3662	; src offset 556, code offset 0x0304
	push hl		; code offset 0x0305
	ld hl,3662	; src offset 554, code offset 0x0308
	push hl		; code offset 0x0309
	ld hl,3662	; src offset 552, code offset 0x030c
	push hl		; code offset 0x030d
	ld hl,3662	; src offset 550, code offset 0x0310
	push hl		; code offset 0x0311
	ld hl,3662	; src offset 548, code offset 0x0314
	push hl		; code offset 0x0315
	ld hl,3662	; src offset 546, code offset 0x0318
	push hl		; code offset 0x0319
	ld hl,3662	; src offset 544, code offset 0x031c
	push hl		; code offset 0x031d
	ld hl,3662	; src offset 542, code offset 0x0320
	push hl		; code offset 0x0321
	ld hl,3662	; src offset 540, code offset 0x0324
	push hl		; code offset 0x0325
	ld hl,3662	; src offset 538, code offset 0x0328
	push hl		; code offset 0x0329
	ld hl,3662	; src offset 536, code offset 0x032c
	push hl		; code offset 0x032d
	ld hl,3662	; src offset 534, code offset 0x0330
	push hl		; code offset 0x0331
	ld hl,3662	; src offset 532, code offset 0x0334
	push hl		; code offset 0x0335
	ld hl,3662	; src offset 530, code offset 0x0338
	push hl		; code offset 0x0339
	ld hl,3662	; src offset 528, code offset 0x033c
	push hl		; code offset 0x033d
	ld hl,3662	; src offset 526, code offset 0x0340
	push hl		; code offset 0x0341
	ld hl,3662	; src offset 524, code offset 0x0344
	push hl		; code offset 0x0345
	ld hl,3662	; src offset 522, code offset 0x0348
	push hl		; code offset 0x0349
	ld hl,3662	; src offset 520, code offset 0x034c
	push hl		; code offset 0x034d
	ld hl,3662	; src offset 518, code offset 0x0350
	push hl		; code offset 0x0351
	ld hl,3662	; src offset 516, code offset 0x0354
	push hl		; code offset 0x0355
	ld hl,3662	; src offset 514, code offset 0x0358
	push hl		; code offset 0x0359
	ld hl,3662	; src offset 512, code offset 0x035c
	push hl		; code offset 0x035d
	ld hl,3662	; src offset 510, code offset 0x0360
	push hl		; code offset 0x0361
	ld hl,3662	; src offset 508, code offset 0x0364
	push hl		; code offset 0x0365
	ld hl,3662	; src offset 506, code offset 0x0368
	push hl		; code offset 0x0369
	ld hl,3662	; src offset 504, code offset 0x036c
	push hl		; code offset 0x036d
	ld hl,3662	; src offset 502, code offset 0x0370
	push hl		; code offset 0x0371
	ld hl,3662	; src offset 500, code offset 0x0374
	push hl		; code offset 0x0375
	ld hl,3662	; src offset 498, code offset 0x0378
	push hl		; code offset 0x0379
	ld hl,3662	; src offset 496, code offset 0x037c
	push hl		; code offset 0x037d
	ld hl,3662	; src offset 494, code offset 0x0380
	push hl		; code offset 0x0381
	ld hl,3662	; src offset 492, code offset 0x0384
	push hl		; code offset 0x0385
	ld hl,3662	; src offset 490, code offset 0x0388
	push hl		; code offset 0x0389
	ld hl,3662	; src offset 488, code offset 0x038c
	push hl		; code offset 0x038d
	ld hl,3662	; src offset 486, code offset 0x0390
	push hl		; code offset 0x0391
	ld hl,3662	; src offset 484, code offset 0x0394
	push hl		; code offset 0x0395
	ld hl,3662	; src offset 482, code offset 0x0398
	push hl		; code offset 0x0399
	ld hl,3662	; src offset 480, code offset 0x039c
	push hl		; code offset 0x039d
	ld hl,3662	; src offset 478, code offset 0x03a0
	push hl		; code offset 0x03a1
	ld hl,3662	; src offset 476, code offset 0x03a4
	push hl		; code offset 0x03a5
	ld hl,3662	; src offset 474, code offset 0x03a8
	push hl		; code offset 0x03a9
	ld hl,3662	; src offset 472, code offset 0x03ac
	push hl		; code offset 0x03ad
	ld hl,3662	; src offset 470, code offset 0x03b0
	push hl		; code offset 0x03b1
	ld hl,3662	; src offset 468, code offset 0x03b4
	push hl		; code offset 0x03b5
	ld hl,3662	; src offset 466, code offset 0x03b8
	push hl		; code offset 0x03b9
	ld hl,3662	; src offset 464, code offset 0x03bc
	push hl		; code offset 0x03bd
	ld hl,3662	; src offset 462, code offset 0x03c0
	push hl		; code offset 0x03c1
	ld hl,3662	; src offset 460, code offset 0x03c4
	push hl		; code offset 0x03c5
	ld hl,3662	; src offset 458, code offset 0x03c8
	push hl		; code offset 0x03c9
	ld hl,3662	; src offset 456, code offset 0x03cc
	push hl		; code offset 0x03cd
	ld hl,3662	; src offset 454, code offset 0x03d0
	push hl		; code offset 0x03d1
	ld hl,3662	; src offset 452, code offset 0x03d4
	push hl		; code offset 0x03d5
	ld hl,3662	; src offset 450, code offset 0x03d8
	push hl		; code offset 0x03d9
	ld hl,3662	; src offset 448, code offset 0x03dc
	push hl		; code offset 0x03dd
	ld hl,3662	; src offset 446, code offset 0x03e0
	push hl		; code offset 0x03e1
	ld hl,3662	; src offset 444, code offset 0x03e4
	push hl		; code offset 0x03e5
	ld hl,3662	; src offset 442, code offset 0x03e8
	push hl		; code offset 0x03e9
	ld hl,3662	; src offset 440, code offset 0x03ec
	push hl		; code offset 0x03ed
	ld hl,3662	; src offset 438, code offset 0x03f0
	push hl		; code offset 0x03f1
	ld hl,3662	; src offset 436, code offset 0x03f4
	push hl		; code offset 0x03f5
	ld hl,3662	; src offset 434, code offset 0x03f8
	push hl		; code offset 0x03f9
	ld hl,3662	; src offset 432, code offset 0x03fc
	push hl		; code offset 0x03fd
	ld hl,3662	; src offset 430, code offset 0x0400
	push hl		; code offset 0x0401
	ld hl,3662	; src offset 428, code offset 0x0404
	push hl		; code offset 0x0405
	ld hl,3662	; src offset 426, code offset 0x0408
	push hl		; code offset 0x0409
	ld hl,3662	; src offset 424, code offset 0x040c
	push hl		; code offset 0x040d
	ld hl,3662	; src offset 422, code offset 0x0410
	push hl		; code offset 0x0411
	ld hl,3662	; src offset 420, code offset 0x0414
	push hl		; code offset 0x0415
	ld hl,3662	; src offset 418, code offset 0x0418
	push hl		; code offset 0x0419
	ld hl,3662	; src offset 416, code offset 0x041c
	push hl		; code offset 0x041d
	ld hl,3662	; src offset 414, code offset 0x0420
	push hl		; code offset 0x0421
	ld hl,3662	; src offset 412, code offset 0x0424
	push hl		; code offset 0x0425
	ld hl,3662	; src offset 410, code offset 0x0428
	push hl		; code offset 0x0429
	ld hl,3662	; src offset 408, code offset 0x042c
	push hl		; code offset 0x042d
	ld hl,3662	; src offset 406, code offset 0x0430
	push hl		; code offset 0x0431
	ld hl,3662	; src offset 404, code offset 0x0434
	push hl		; code offset 0x0435
	ld hl,3662	; src offset 402, code offset 0x0438
	push hl		; code offset 0x0439
	ld hl,3662	; src offset 400, code offset 0x043c
	push hl		; code offset 0x043d
	ld hl,3662	; src offset 398, code offset 0x0440
	push hl		; code offset 0x0441
	ld hl,3662	; src offset 396, code offset 0x0444
	push hl		; code offset 0x0445
	ld hl,3662	; src offset 394, code offset 0x0448
	push hl		; code offset 0x0449
	ld hl,3662	; src offset 392, code offset 0x044c
	push hl		; code offset 0x044d
	ld hl,3662	; src offset 390, code offset 0x0450
	push hl		; code offset 0x0451
	ld hl,3662	; src offset 388, code offset 0x0454
	push hl		; code offset 0x0455
	ld hl,3662	; src offset 386, code offset 0x0458
	push hl		; code offset 0x0459
	ld hl,3662	; src offset 384, code offset 0x045c
	push hl		; code offset 0x045d
	ld hl,3662	; src offset 382, code offset 0x0460
	push hl		; code offset 0x0461
	ld hl,3662	; src offset 380, code offset 0x0464
	push hl		; code offset 0x0465
	ld hl,3662	; src offset 378, code offset 0x0468
	push hl		; code offset 0x0469
	ld hl,3662	; src offset 376, code offset 0x046c
	push hl		; code offset 0x046d
	ld hl,3662	; src offset 374, code offset 0x0470
	push hl		; code offset 0x0471
	ld hl,3662	; src offset 372, code offset 0x0474
	push hl		; code offset 0x0475
	ld hl,3662	; src offset 370, code offset 0x0478
	push hl		; code offset 0x0479
	ld hl,3662	; src offset 368, code offset 0x047c
	push hl		; code offset 0x047d
	ld hl,3662	; src offset 366, code offset 0x0480
	push hl		; code offset 0x0481
	ld hl,3662	; src offset 364, code offset 0x0484
	push hl		; code offset 0x0485
	ld hl,3662	; src offset 362, code offset 0x0488
	push hl		; code offset 0x0489
	ld hl,3662	; src offset 360, code offset 0x048c
	push hl		; code offset 0x048d
	ld hl,3662	; src offset 358, code offset 0x0490
	push hl		; code offset 0x0491
	ld hl,3662	; src offset 356, code offset 0x0494
	push hl		; code offset 0x0495
	ld hl,3662	; src offset 354, code offset 0x0498
	push hl		; code offset 0x0499
	ld hl,3662	; src offset 352, code offset 0x049c
	push hl		; code offset 0x049d
	ld hl,3662	; src offset 350, code offset 0x04a0
	push hl		; code offset 0x04a1
	ld hl,3662	; src offset 348, code offset 0x04a4
	push hl		; code offset 0x04a5
	ld hl,3662	; src offset 346, code offset 0x04a8
	push hl		; code offset 0x04a9
	ld hl,3662	; src offset 344, code offset 0x04ac
	push hl		; code offset 0x04ad
	ld hl,3662	; src offset 342, code offset 0x04b0
	push hl		; code offset 0x04b1
	ld hl,3662	; src offset 340, code offset 0x04b4
	push hl		; code offset 0x04b5
	ld hl,3662	; src offset 338, code offset 0x04b8
	push hl		; code offset 0x04b9
	ld hl,3662	; src offset 336, code offset 0x04bc
	push hl		; code offset 0x04bd
	ld hl,3662	; src offset 334, code offset 0x04c0
	push hl		; code offset 0x04c1
	ld hl,3662	; src offset 332, code offset 0x04c4
	push hl		; code offset 0x04c5
	ld hl,3662	; src offset 330, code offset 0x04c8
	push hl		; code offset 0x04c9
	ld hl,3662	; src offset 328, code offset 0x04cc
	push hl		; code offset 0x04cd
	ld hl,3662	; src offset 326, code offset 0x04d0
	push hl		; code offset 0x04d1
	ld hl,3662	; src offset 324, code offset 0x04d4
	push hl		; code offset 0x04d5
	ld hl,3662	; src offset 322, code offset 0x04d8
	push hl		; code offset 0x04d9
	ld hl,3662	; src offset 320, code offset 0x04dc
	push hl		; code offset 0x04dd
	ld hl,3662	; src offset 318, code offset 0x04e0
	push hl		; code offset 0x04e1
	ld hl,3662	; src offset 316, code offset 0x04e4
	push hl		; code offset 0x04e5
	ld hl,3662	; src offset 314, code offset 0x04e8
	push hl		; code offset 0x04e9
	ld hl,3662	; src offset 312, code offset 0x04ec
	push hl		; code offset 0x04ed
	ld hl,3662	; src offset 310, code offset 0x04f0
	push hl		; code offset 0x04f1
	ld hl,3662	; src offset 308, code offset 0x04f4
	push hl		; code offset 0x04f5
	ld hl,3662	; src offset 306, code offset 0x04f8
	push hl		; code offset 0x04f9
	ld hl,3662	; src offset 304, code offset 0x04fc
	push hl		; code offset 0x04fd
	ld hl,3662	; src offset 302, code offset 0x0500
	push hl		; code offset 0x0501
	ld hl,3662	; src offset 300, code offset 0x0504
	push hl		; code offset 0x0505
	ld hl,3662	; src offset 298, code offset 0x0508
	push hl		; code offset 0x0509
	ld hl,3662	; src offset 296, code offset 0x050c
	push hl		; code offset 0x050d
	ld hl,3662	; src offset 294, code offset 0x0510
	push hl		; code offset 0x0511
	ld hl,3662	; src offset 292, code offset 0x0514
	push hl		; code offset 0x0515
	ld hl,3662	; src offset 290, code offset 0x0518
	push hl		; code offset 0x0519
	ld hl,3662	; src offset 288, code offset 0x051c
	push hl		; code offset 0x051d
	ld hl,3662	; src offset 286, code offset 0x0520
	push hl		; code offset 0x0521
	ld hl,3662	; src offset 284, code offset 0x0524
	push hl		; code offset 0x0525
	ld hl,3662	; src offset 282, code offset 0x0528
	push hl		; code offset 0x0529
	ld hl,3662	; src offset 280, code offset 0x052c
	push hl		; code offset 0x052d
	ld hl,3662	; src offset 278, code offset 0x0530
	push hl		; code offset 0x0531
	ld hl,3662	; src offset 276, code offset 0x0534
	push hl		; code offset 0x0535
	ld hl,3662	; src offset 274, code offset 0x0538
	push hl		; code offset 0x0539
	ld hl,3662	; src offset 272, code offset 0x053c
	push hl		; code offset 0x053d
	ld hl,3662	; src offset 270, code offset 0x0540
	push hl		; code offset 0x0541
	ld hl,3662	; src offset 268, code offset 0x0544
	push hl		; code offset 0x0545
	ld hl,3662	; src offset 266, code offset 0x0548
	push hl		; code offset 0x0549
	ld hl,3662	; src offset 264, code offset 0x054c
	push hl		; code offset 0x054d
	ld hl,3662	; src offset 262, code offset 0x0550
	push hl		; code offset 0x0551
	ld hl,3662	; src offset 260, code offset 0x0554
	push hl		; code offset 0x0555
	ld hl,3662	; src offset 258, code offset 0x0558
	push hl		; code offset 0x0559
	ld hl,3662	; src offset 256, code offset 0x055c
	push hl		; code offset 0x055d
	ld hl,3662	; src offset 254, code offset 0x0560
	push hl		; code offset 0x0561
	ld hl,3662	; src offset 252, code offset 0x0564
	push hl		; code offset 0x0565
	ld hl,3662	; src offset 250, code offset 0x0568
	push hl		; code offset 0x0569
	ld hl,3662	; src offset 248, code offset 0x056c
	push hl		; code offset 0x056d
	ld hl,3662	; src offset 246, code offset 0x0570
	push hl		; code offset 0x0571
	ld hl,3662	; src offset 244, code offset 0x0574
	push hl		; code offset 0x0575
	ld hl,3662	; src offset 242, code offset 0x0578
	push hl		; code offset 0x0579
	ld hl,3662	; src offset 240, code offset 0x057c
	push hl		; code offset 0x057d
	ld hl,3662	; src offset 238, code offset 0x0580
	push hl		; code offset 0x0581
	ld hl,3662	; src offset 236, code offset 0x0584
	push hl		; code offset 0x0585
	ld hl,3662	; src offset 234, code offset 0x0588
	push hl		; code offset 0x0589
	ld hl,3662	; src offset 232, code offset 0x058c
	push hl		; code offset 0x058d
	ld hl,3662	; src offset 230, code offset 0x0590
	push hl		; code offset 0x0591
	ld hl,3662	; src offset 228, code offset 0x0594
	push hl		; code offset 0x0595
	ld hl,3662	; src offset 226, code offset 0x0598
	push hl		; code offset 0x0599
	ld hl,3662	; src offset 224, code offset 0x059c
	push hl		; code offset 0x059d
	ld hl,3662	; src offset 222, code offset 0x05a0
	push hl		; code offset 0x05a1
	ld hl,3662	; src offset 220, code offset 0x05a4
	push hl		; code offset 0x05a5
	ld hl,3662	; src offset 218, code offset 0x05a8
	push hl		; code offset 0x05a9
	ld hl,3662	; src offset 216, code offset 0x05ac
	push hl		; code offset 0x05ad
	ld hl,3662	; src offset 214, code offset 0x05b0
	push hl		; code offset 0x05b1
	ld hl,3662	; src offset 212, code offset 0x05b4
	push hl		; code offset 0x05b5
	ld hl,3662	; src offset 210, code offset 0x05b8
	push hl		; code offset 0x05b9
	ld hl,3662	; src offset 208, code offset 0x05bc
	push hl		; code offset 0x05bd
	ld hl,3662	; src offset 206, code offset 0x05c0
	push hl		; code offset 0x05c1
	ld hl,3662	; src offset 204, code offset 0x05c4
	push hl		; code offset 0x05c5
	ld hl,3662	; src offset 202, code offset 0x05c8
	push hl		; code offset 0x05c9
	ld hl,3662	; src offset 200, code offset 0x05cc
	push hl		; code offset 0x05cd
	ld hl,3662	; src offset 198, code offset 0x05d0
	push hl		; code offset 0x05d1
	ld hl,3662	; src offset 196, code offset 0x05d4
	push hl		; code offset 0x05d5
	ld hl,3662	; src offset 194, code offset 0x05d8
	push hl		; code offset 0x05d9
	ld hl,3662	; src offset 192, code offset 0x05dc
	push hl		; code offset 0x05dd
	ld hl,3662	; src offset 190, code offset 0x05e0
	push hl		; code offset 0x05e1
	ld hl,3662	; src offset 188, code offset 0x05e4
	push hl		; code offset 0x05e5
	ld hl,3662	; src offset 186, code offset 0x05e8
	push hl		; code offset 0x05e9
	ld hl,3662	; src offset 184, code offset 0x05ec
	push hl		; code offset 0x05ed
	ld hl,3662	; src offset 182, code offset 0x05f0
	push hl		; code offset 0x05f1
	ld hl,3662	; src offset 180, code offset 0x05f4
	push hl		; code offset 0x05f5
	ld hl,3662	; src offset 178, code offset 0x05f8
	push hl		; code offset 0x05f9
	ld hl,3662	; src offset 176, code offset 0x05fc
	push hl		; code offset 0x05fd
	ld hl,3662	; src offset 174, code offset 0x0600
	push hl		; code offset 0x0601
	ld hl,3662	; src offset 172, code offset 0x0604
	push hl		; code offset 0x0605
	ld hl,3662	; src offset 170, code offset 0x0608
	push hl		; code offset 0x0609
	ld hl,3662	; src offset 168, code offset 0x060c
	push hl		; code offset 0x060d
	ld hl,3662	; src offset 166, code offset 0x0610
	push hl		; code offset 0x0611
	ld hl,3662	; src offset 164, code offset 0x0614
	push hl		; code offset 0x0615
	ld hl,3662	; src offset 162, code offset 0x0618
	push hl		; code offset 0x0619
	ld hl,3662	; src offset 160, code offset 0x061c
	push hl		; code offset 0x061d
	ld hl,3662	; src offset 158, code offset 0x0620
	push hl		; code offset 0x0621
	ld hl,3662	; src offset 156, code offset 0x0624
	push hl		; code offset 0x0625
	ld hl,3662	; src offset 154, code offset 0x0628
	push hl		; code offset 0x0629
	ld hl,3662	; src offset 152, code offset 0x062c
	push hl		; code offset 0x062d
	ld hl,3662	; src offset 150, code offset 0x0630
	push hl		; code offset 0x0631
	ld hl,3662	; src offset 148, code offset 0x0634
	push hl		; code offset 0x0635
	ld hl,3662	; src offset 146, code offset 0x0638
	push hl		; code offset 0x0639
	ld hl,3662	; src offset 144, code offset 0x063c
	push hl		; code offset 0x063d
	ld hl,3662	; src offset 142, code offset 0x0640
	push hl		; code offset 0x0641
	ld hl,3662	; src offset 140, code offset 0x0644
	push hl		; code offset 0x0645
	ld hl,3662	; src offset 138, code offset 0x0648
	push hl		; code offset 0x0649
	ld hl,3662	; src offset 136, code offset 0x064c
	push hl		; code offset 0x064d
	ld hl,3662	; src offset 134, code offset 0x0650
	push hl		; code offset 0x0651
	ld hl,3662	; src offset 132, code offset 0x0654
	push hl		; code offset 0x0655
	ld hl,3662	; src offset 130, code offset 0x0658
	push hl		; code offset 0x0659
	ld hl,3662	; src offset 128, code offset 0x065c
	push hl		; code offset 0x065d
	ld hl,3662	; src offset 126, code offset 0x0660
	push hl		; code offset 0x0661
	ld hl,3662	; src offset 124, code offset 0x0664
	push hl		; code offset 0x0665
	ld hl,3662	; src offset 122, code offset 0x0668
	push hl		; code offset 0x0669
	ld hl,3662	; src offset 120, code offset 0x066c
	push hl		; code offset 0x066d
	ld hl,3662	; src offset 118, code offset 0x0670
	push hl		; code offset 0x0671
	ld hl,3662	; src offset 116, code offset 0x0674
	push hl		; code offset 0x0675
	ld hl,3662	; src offset 114, code offset 0x0678
	push hl		; code offset 0x0679
	ld hl,3662	; src offset 112, code offset 0x067c
	push hl		; code offset 0x067d
	ld hl,3662	; src offset 110, code offset 0x0680
	push hl		; code offset 0x0681
	ld hl,3662	; src offset 108, code offset 0x0684
	push hl		; code offset 0x0685
	ld hl,3662	; src offset 106, code offset 0x0688
	push hl		; code offset 0x0689
	ld hl,3662	; src offset 104, code offset 0x068c
	push hl		; code offset 0x068d
	ld hl,3662	; src offset 102, code offset 0x0690
	push hl		; code offset 0x0691
	ld hl,3662	; src offset 100, code offset 0x0694
	push hl		; code offset 0x0695
	ld hl,3662	; src offset 98, code offset 0x0698
	push hl		; code offset 0x0699
	ld hl,3662	; src offset 96, code offset 0x069c
	push hl		; code offset 0x069d
	ld hl,3662	; src offset 94, code offset 0x06a0
	push hl		; code offset 0x06a1
	ld hl,3662	; src offset 92, code offset 0x06a4
	push hl		; code offset 0x06a5
	ld hl,3662	; src offset 90, code offset 0x06a8
	push hl		; code offset 0x06a9
	ld hl,3662	; src offset 88, code offset 0x06ac
	push hl		; code offset 0x06ad
	ld hl,3662	; src offset 86, code offset 0x06b0
	push hl		; code offset 0x06b1
	ld hl,3662	; src offset 84, code offset 0x06b4
	push hl		; code offset 0x06b5
	ld hl,3662	; src offset 82, code offset 0x06b8
	push hl		; code offset 0x06b9
	ld hl,3662	; src offset 80, code offset 0x06bc
	push hl		; code offset 0x06bd
	ld hl,3662	; src offset 78, code offset 0x06c0
	push hl		; code offset 0x06c1
	ld hl,3662	; src offset 76, code offset 0x06c4
	push hl		; code offset 0x06c5
	ld hl,3662	; src offset 74, code offset 0x06c8
	push hl		; code offset 0x06c9
	ld hl,3662	; src offset 72, code offset 0x06cc
	push hl		; code offset 0x06cd
	ld hl,3662	; src offset 70, code offset 0x06d0
	push hl		; code offset 0x06d1
	ld hl,3662	; src offset 68, code offset 0x06d4
	push hl		; code offset 0x06d5
	ld hl,3662	; src offset 66, code offset 0x06d8
	push hl		; code offset 0x06d9
	ld hl,3662	; src offset 64, code offset 0x06dc
	push hl		; code offset 0x06dd
	ld hl,3662	; src offset 62, code offset 0x06e0
	push hl		; code offset 0x06e1
	ld hl,3662	; src offset 60, code offset 0x06e4
	push hl		; code offset 0x06e5
	ld hl,3662	; src offset 58, code offset 0x06e8
	push hl		; code offset 0x06e9
	ld hl,3662	; src offset 56, code offset 0x06ec
	push hl		; code offset 0x06ed
	ld hl,3662	; src offset 54, code offset 0x06f0
	push hl		; code offset 0x06f1
	ld hl,3662	; src offset 52, code offset 0x06f4
	push hl		; code offset 0x06f5
	ld hl,3662	; src offset 50, code offset 0x06f8
	push hl		; code offset 0x06f9
	ld hl,3662	; src offset 48, code offset 0x06fc
	push hl		; code offset 0x06fd
	ld hl,3662	; src offset 46, code offset 0x0700
	push hl		; code offset 0x0701
	ld hl,3662	; src offset 44, code offset 0x0704
	push hl		; code offset 0x0705
	ld hl,3662	; src offset 42, code offset 0x0708
	push hl		; code offset 0x0709
	ld hl,3662	; src offset 40, code offset 0x070c
	push hl		; code offset 0x070d
	ld hl,3662	; src offset 38, code offset 0x0710
	push hl		; code offset 0x0711
	ld hl,3662	; src offset 36, code offset 0x0714
	push hl		; code offset 0x0715
	ld hl,3662	; src offset 34, code offset 0x0718
	push hl		; code offset 0x0719
	ld hl,3662	; src offset 32, code offset 0x071c
	push hl		; code offset 0x071d
	ld hl,3662	; src offset 30, code offset 0x0720
	push hl		; code offset 0x0721
	ld hl,3662	; src offset 28, code offset 0x0724
	push hl		; code offset 0x0725
	ld hl,3662	; src offset 26, code offset 0x0728
	push hl		; code offset 0x0729
	ld hl,3662	; src offset 24, code offset 0x072c
	push hl		; code offset 0x072d
	ld hl,3662	; src offset 22, code offset 0x0730
	push hl		; code offset 0x0731
	ld hl,3662	; src offset 20, code offset 0x0734
	push hl		; code offset 0x0735
	ld hl,3662	; src offset 18, code offset 0x0738
	push hl		; code offset 0x0739
	ld hl,3662	; src offset 16, code offset 0x073c
	push hl		; code offset 0x073d
	ld hl,3662	; src offset 14, code offset 0x0740
	push hl		; code offset 0x0741
	ld hl,3662	; src offset 12, code offset 0x0744
	push hl		; code offset 0x0745
	ld hl,3662	; src offset 10, code offset 0x0748
	push hl		; code offset 0x0749
	ld hl,3662	; src offset 8, code offset 0x074c
	push hl		; code offset 0x074d
	ld hl,3662	; src offset 6, code offset 0x0750
	push hl		; code offset 0x0751
	ld hl,3662	; src offset 4, code offset 0x0754
	push hl		; code offset 0x0755
	ld hl,3662	; src offset 2, code offset 0x0758
	push hl		; code offset 0x0759
	ld hl,3662	; src offset 0, code offset 0x075c
	push hl		; code offset 0x075d

	; Block attribute blit end

	; delay to get start of scanline (10 T-states) at offset 0x075d
	ld b,0
		; offset 0x075f, 8 T-states remaining
	nop   	; offset 0x0760, 4 T-states remaining
	nop   	; offset 0x0761, 0 T-states remaining


	; src_data blit 0
	ld sp,screenStartAddr+16	; offset 0x0764
	ld hl,44975	; offset 0x0767
	push hl	; offset 0x0768
	ld hl,44975	; offset 0x076b
	push hl	; offset 0x076c
	ld hl,44975	; offset 0x076f
	push hl	; offset 0x0770
	ld hl,44975	; offset 0x0773
	push hl	; offset 0x0774
	ld hl,44975	; offset 0x0777
	push hl	; offset 0x0778
	ld hl,44975	; offset 0x077b
	push hl	; offset 0x077c
	ld hl,44975	; offset 0x077f
	push hl	; offset 0x0780
	ld hl,44975	; offset 0x0783
	push hl	; offset 0x0784

	; src_data blit 1
	ld sp,screenStartAddr+32	; offset 0x0787
	ld hl,44975	; offset 0x078a
	push hl	; offset 0x078b
	ld hl,44975	; offset 0x078e
	push hl	; offset 0x078f
	ld hl,44975	; offset 0x0792
	push hl	; offset 0x0793
	ld hl,44975	; offset 0x0796
	push hl	; offset 0x0797
	ld hl,44975	; offset 0x079a
	push hl	; offset 0x079b
	ld hl,44975	; offset 0x079e
	push hl	; offset 0x079f
	ld hl,44975	; offset 0x07a2
	push hl	; offset 0x07a3
	ld hl,44975	; offset 0x07a6
	push hl	; offset 0x07a7

	; src_data blit 2
	ld sp,screenStartAddr+272	; offset 0x07aa
	ld hl,44975	; offset 0x07ad
	push hl	; offset 0x07ae
	ld hl,44975	; offset 0x07b1
	push hl	; offset 0x07b2
	ld hl,44975	; offset 0x07b5
	push hl	; offset 0x07b6
	ld hl,44975	; offset 0x07b9
	push hl	; offset 0x07ba
	ld hl,44975	; offset 0x07bd
	push hl	; offset 0x07be
	ld hl,44975	; offset 0x07c1
	push hl	; offset 0x07c2
	ld hl,44975	; offset 0x07c5
	push hl	; offset 0x07c6
	ld hl,44975	; offset 0x07c9
	push hl	; offset 0x07ca

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 0, offset 0x0823
	; Clock offset: -864


	; src_data blit 3
	ld sp,screenStartAddr+288	; offset 0x0826
	ld hl,44975	; offset 0x0829
	push hl	; offset 0x082a
	ld hl,44975	; offset 0x082d
	push hl	; offset 0x082e
	ld hl,44975	; offset 0x0831
	push hl	; offset 0x0832
	ld hl,44975	; offset 0x0835
	push hl	; offset 0x0836
	ld hl,44975	; offset 0x0839
	push hl	; offset 0x083a
	ld hl,44975	; offset 0x083d
	push hl	; offset 0x083e
	ld hl,44975	; offset 0x0841
	push hl	; offset 0x0842
	ld hl,44975	; offset 0x0845
	push hl	; offset 0x0846

	; src_data blit 4
	ld sp,screenStartAddr+528	; offset 0x0849
	ld hl,44975	; offset 0x084c
	push hl	; offset 0x084d
	ld hl,44975	; offset 0x0850
	push hl	; offset 0x0851
	ld hl,44975	; offset 0x0854
	push hl	; offset 0x0855
	ld hl,44975	; offset 0x0858
	push hl	; offset 0x0859
	ld hl,44975	; offset 0x085c
	push hl	; offset 0x085d
	ld hl,44975	; offset 0x0860
	push hl	; offset 0x0861
	ld hl,44975	; offset 0x0864
	push hl	; offset 0x0865
	ld hl,44975	; offset 0x0868
	push hl	; offset 0x0869

	; src_data blit 5
	ld sp,screenStartAddr+544	; offset 0x086c
	ld hl,44975	; offset 0x086f
	push hl	; offset 0x0870
	ld hl,44975	; offset 0x0873
	push hl	; offset 0x0874
	ld hl,44975	; offset 0x0877
	push hl	; offset 0x0878
	ld hl,44975	; offset 0x087b
	push hl	; offset 0x087c
	ld hl,44975	; offset 0x087f
	push hl	; offset 0x0880
	ld hl,44975	; offset 0x0883
	push hl	; offset 0x0884
	ld hl,44975	; offset 0x0887
	push hl	; offset 0x0888
	ld hl,44975	; offset 0x088b
	push hl	; offset 0x088c

	; src_data blit 6
	ld sp,screenStartAddr+784	; offset 0x088f
	ld hl,44975	; offset 0x0892
	push hl	; offset 0x0893
	ld hl,44975	; offset 0x0896
	push hl	; offset 0x0897
	ld hl,44975	; offset 0x089a
	push hl	; offset 0x089b
	ld hl,44975	; offset 0x089e
	push hl	; offset 0x089f
	ld hl,44975	; offset 0x08a2
	push hl	; offset 0x08a3
	ld hl,44975	; offset 0x08a6
	push hl	; offset 0x08a7
	ld hl,44975	; offset 0x08aa
	push hl	; offset 0x08ab
	ld hl,44975	; offset 0x08ae
	push hl	; offset 0x08af

	; src_data blit 7
	ld sp,screenStartAddr+800	; offset 0x08b2
	ld hl,44975	; offset 0x08b5
	push hl	; offset 0x08b6
	ld hl,44975	; offset 0x08b9
	push hl	; offset 0x08ba
	ld hl,44975	; offset 0x08bd
	push hl	; offset 0x08be
	ld hl,44975	; offset 0x08c1
	push hl	; offset 0x08c2
	ld hl,44975	; offset 0x08c5
	push hl	; offset 0x08c6
	ld hl,44975	; offset 0x08c9
	push hl	; offset 0x08ca
	ld hl,44975	; offset 0x08cd
	push hl	; offset 0x08ce
	ld hl,44975	; offset 0x08d1
	push hl	; offset 0x08d2

	; src_data blit 8
	ld sp,screenStartAddr+1040	; offset 0x08d5
	ld hl,44975	; offset 0x08d8
	push hl	; offset 0x08d9
	ld hl,44975	; offset 0x08dc
	push hl	; offset 0x08dd
	ld hl,44975	; offset 0x08e0
	push hl	; offset 0x08e1
	ld hl,44975	; offset 0x08e4
	push hl	; offset 0x08e5
	ld hl,44975	; offset 0x08e8
	push hl	; offset 0x08e9
	ld hl,44975	; offset 0x08ec
	push hl	; offset 0x08ed
	ld hl,44975	; offset 0x08f0
	push hl	; offset 0x08f1
	ld hl,44975	; offset 0x08f4
	push hl	; offset 0x08f5

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 1, offset 0x094e
	; Clock offset: -864


	; src_data blit 9
	ld sp,screenStartAddr+1056	; offset 0x0951
	ld hl,44975	; offset 0x0954
	push hl	; offset 0x0955
	ld hl,44975	; offset 0x0958
	push hl	; offset 0x0959
	ld hl,44975	; offset 0x095c
	push hl	; offset 0x095d
	ld hl,44975	; offset 0x0960
	push hl	; offset 0x0961
	ld hl,44975	; offset 0x0964
	push hl	; offset 0x0965
	ld hl,44975	; offset 0x0968
	push hl	; offset 0x0969
	ld hl,44975	; offset 0x096c
	push hl	; offset 0x096d
	ld hl,44975	; offset 0x0970
	push hl	; offset 0x0971

	; src_data blit 10
	ld sp,screenStartAddr+1296	; offset 0x0974
	ld hl,44975	; offset 0x0977
	push hl	; offset 0x0978
	ld hl,44975	; offset 0x097b
	push hl	; offset 0x097c
	ld hl,44975	; offset 0x097f
	push hl	; offset 0x0980
	ld hl,44975	; offset 0x0983
	push hl	; offset 0x0984
	ld hl,44975	; offset 0x0987
	push hl	; offset 0x0988
	ld hl,44975	; offset 0x098b
	push hl	; offset 0x098c
	ld hl,44975	; offset 0x098f
	push hl	; offset 0x0990
	ld hl,44975	; offset 0x0993
	push hl	; offset 0x0994

	; src_data blit 11
	ld sp,screenStartAddr+1312	; offset 0x0997
	ld hl,44975	; offset 0x099a
	push hl	; offset 0x099b
	ld hl,44975	; offset 0x099e
	push hl	; offset 0x099f
	ld hl,44975	; offset 0x09a2
	push hl	; offset 0x09a3
	ld hl,44975	; offset 0x09a6
	push hl	; offset 0x09a7
	ld hl,44975	; offset 0x09aa
	push hl	; offset 0x09ab
	ld hl,44975	; offset 0x09ae
	push hl	; offset 0x09af
	ld hl,44975	; offset 0x09b2
	push hl	; offset 0x09b3
	ld hl,44975	; offset 0x09b6
	push hl	; offset 0x09b7

	; src_data blit 12
	ld sp,screenStartAddr+1552	; offset 0x09ba
	ld hl,44975	; offset 0x09bd
	push hl	; offset 0x09be
	ld hl,44975	; offset 0x09c1
	push hl	; offset 0x09c2
	ld hl,44975	; offset 0x09c5
	push hl	; offset 0x09c6
	ld hl,44975	; offset 0x09c9
	push hl	; offset 0x09ca
	ld hl,44975	; offset 0x09cd
	push hl	; offset 0x09ce
	ld hl,44975	; offset 0x09d1
	push hl	; offset 0x09d2
	ld hl,44975	; offset 0x09d5
	push hl	; offset 0x09d6
	ld hl,44975	; offset 0x09d9
	push hl	; offset 0x09da

	; src_data blit 13
	ld sp,screenStartAddr+1568	; offset 0x09dd
	ld hl,44975	; offset 0x09e0
	push hl	; offset 0x09e1
	ld hl,44975	; offset 0x09e4
	push hl	; offset 0x09e5
	ld hl,44975	; offset 0x09e8
	push hl	; offset 0x09e9
	ld hl,44975	; offset 0x09ec
	push hl	; offset 0x09ed
	ld hl,44975	; offset 0x09f0
	push hl	; offset 0x09f1
	ld hl,44975	; offset 0x09f4
	push hl	; offset 0x09f5
	ld hl,44975	; offset 0x09f8
	push hl	; offset 0x09f9
	ld hl,44975	; offset 0x09fc
	push hl	; offset 0x09fd

	; src_data blit 14
	ld sp,screenStartAddr+1808	; offset 0x0a00
	ld hl,44975	; offset 0x0a03
	push hl	; offset 0x0a04
	ld hl,44975	; offset 0x0a07
	push hl	; offset 0x0a08
	ld hl,44975	; offset 0x0a0b
	push hl	; offset 0x0a0c
	ld hl,44975	; offset 0x0a0f
	push hl	; offset 0x0a10
	ld hl,44975	; offset 0x0a13
	push hl	; offset 0x0a14
	ld hl,44975	; offset 0x0a17
	push hl	; offset 0x0a18
	ld hl,44975	; offset 0x0a1b
	push hl	; offset 0x0a1c
	ld hl,44975	; offset 0x0a1f
	push hl	; offset 0x0a20

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 2, offset 0x0a79
	; Clock offset: -864


	; src_data blit 15
	ld sp,screenStartAddr+1824	; offset 0x0a7c
	ld hl,44975	; offset 0x0a7f
	push hl	; offset 0x0a80
	ld hl,44975	; offset 0x0a83
	push hl	; offset 0x0a84
	ld hl,44975	; offset 0x0a87
	push hl	; offset 0x0a88
	ld hl,44975	; offset 0x0a8b
	push hl	; offset 0x0a8c
	ld hl,44975	; offset 0x0a8f
	push hl	; offset 0x0a90
	ld hl,44975	; offset 0x0a93
	push hl	; offset 0x0a94
	ld hl,44975	; offset 0x0a97
	push hl	; offset 0x0a98
	ld hl,44975	; offset 0x0a9b
	push hl	; offset 0x0a9c

	; src_data blit 16
	ld sp,screenStartAddr+48	; offset 0x0a9f
	ld hl,44975	; offset 0x0aa2
	push hl	; offset 0x0aa3
	ld hl,44975	; offset 0x0aa6
	push hl	; offset 0x0aa7
	ld hl,44975	; offset 0x0aaa
	push hl	; offset 0x0aab
	ld hl,44975	; offset 0x0aae
	push hl	; offset 0x0aaf
	ld hl,44975	; offset 0x0ab2
	push hl	; offset 0x0ab3
	ld hl,44975	; offset 0x0ab6
	push hl	; offset 0x0ab7
	ld hl,44975	; offset 0x0aba
	push hl	; offset 0x0abb
	ld hl,44975	; offset 0x0abe
	push hl	; offset 0x0abf

	; src_data blit 17
	ld sp,screenStartAddr+64	; offset 0x0ac2
	ld hl,44975	; offset 0x0ac5
	push hl	; offset 0x0ac6
	ld hl,44975	; offset 0x0ac9
	push hl	; offset 0x0aca
	ld hl,44975	; offset 0x0acd
	push hl	; offset 0x0ace
	ld hl,44975	; offset 0x0ad1
	push hl	; offset 0x0ad2
	ld hl,44975	; offset 0x0ad5
	push hl	; offset 0x0ad6
	ld hl,44975	; offset 0x0ad9
	push hl	; offset 0x0ada
	ld hl,44975	; offset 0x0add
	push hl	; offset 0x0ade
	ld hl,44975	; offset 0x0ae1
	push hl	; offset 0x0ae2

	; src_data blit 18
	ld sp,screenStartAddr+304	; offset 0x0ae5
	ld hl,44975	; offset 0x0ae8
	push hl	; offset 0x0ae9
	ld hl,44975	; offset 0x0aec
	push hl	; offset 0x0aed
	ld hl,44975	; offset 0x0af0
	push hl	; offset 0x0af1
	ld hl,44975	; offset 0x0af4
	push hl	; offset 0x0af5
	ld hl,44975	; offset 0x0af8
	push hl	; offset 0x0af9
	ld hl,44975	; offset 0x0afc
	push hl	; offset 0x0afd
	ld hl,44975	; offset 0x0b00
	push hl	; offset 0x0b01
	ld hl,44975	; offset 0x0b04
	push hl	; offset 0x0b05

	; src_data blit 19
	ld sp,screenStartAddr+320	; offset 0x0b08
	ld hl,44975	; offset 0x0b0b
	push hl	; offset 0x0b0c
	ld hl,44975	; offset 0x0b0f
	push hl	; offset 0x0b10
	ld hl,44975	; offset 0x0b13
	push hl	; offset 0x0b14
	ld hl,44975	; offset 0x0b17
	push hl	; offset 0x0b18
	ld hl,44975	; offset 0x0b1b
	push hl	; offset 0x0b1c
	ld hl,44975	; offset 0x0b1f
	push hl	; offset 0x0b20
	ld hl,44975	; offset 0x0b23
	push hl	; offset 0x0b24
	ld hl,44975	; offset 0x0b27
	push hl	; offset 0x0b28

	; src_data blit 20
	ld sp,screenStartAddr+560	; offset 0x0b2b
	ld hl,44975	; offset 0x0b2e
	push hl	; offset 0x0b2f
	ld hl,44975	; offset 0x0b32
	push hl	; offset 0x0b33
	ld hl,44975	; offset 0x0b36
	push hl	; offset 0x0b37
	ld hl,44975	; offset 0x0b3a
	push hl	; offset 0x0b3b
	ld hl,44975	; offset 0x0b3e
	push hl	; offset 0x0b3f
	ld hl,44975	; offset 0x0b42
	push hl	; offset 0x0b43
	ld hl,44975	; offset 0x0b46
	push hl	; offset 0x0b47
	ld hl,44975	; offset 0x0b4a
	push hl	; offset 0x0b4b

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 3, offset 0x0ba4
	; Clock offset: -864


	; src_data blit 21
	ld sp,screenStartAddr+576	; offset 0x0ba7
	ld hl,44975	; offset 0x0baa
	push hl	; offset 0x0bab
	ld hl,44975	; offset 0x0bae
	push hl	; offset 0x0baf
	ld hl,44975	; offset 0x0bb2
	push hl	; offset 0x0bb3
	ld hl,44975	; offset 0x0bb6
	push hl	; offset 0x0bb7
	ld hl,44975	; offset 0x0bba
	push hl	; offset 0x0bbb
	ld hl,44975	; offset 0x0bbe
	push hl	; offset 0x0bbf
	ld hl,44975	; offset 0x0bc2
	push hl	; offset 0x0bc3
	ld hl,44975	; offset 0x0bc6
	push hl	; offset 0x0bc7

	; src_data blit 22
	ld sp,screenStartAddr+816	; offset 0x0bca
	ld hl,44975	; offset 0x0bcd
	push hl	; offset 0x0bce
	ld hl,44975	; offset 0x0bd1
	push hl	; offset 0x0bd2
	ld hl,44975	; offset 0x0bd5
	push hl	; offset 0x0bd6
	ld hl,44975	; offset 0x0bd9
	push hl	; offset 0x0bda
	ld hl,44975	; offset 0x0bdd
	push hl	; offset 0x0bde
	ld hl,44975	; offset 0x0be1
	push hl	; offset 0x0be2
	ld hl,44975	; offset 0x0be5
	push hl	; offset 0x0be6
	ld hl,44975	; offset 0x0be9
	push hl	; offset 0x0bea

	; src_data blit 23
	ld sp,screenStartAddr+832	; offset 0x0bed
	ld hl,44975	; offset 0x0bf0
	push hl	; offset 0x0bf1
	ld hl,44975	; offset 0x0bf4
	push hl	; offset 0x0bf5
	ld hl,44975	; offset 0x0bf8
	push hl	; offset 0x0bf9
	ld hl,44975	; offset 0x0bfc
	push hl	; offset 0x0bfd
	ld hl,44975	; offset 0x0c00
	push hl	; offset 0x0c01
	ld hl,44975	; offset 0x0c04
	push hl	; offset 0x0c05
	ld hl,44975	; offset 0x0c08
	push hl	; offset 0x0c09
	ld hl,44975	; offset 0x0c0c
	push hl	; offset 0x0c0d

	; src_data blit 24
	ld sp,screenStartAddr+1072	; offset 0x0c10
	ld hl,44975	; offset 0x0c13
	push hl	; offset 0x0c14
	ld hl,44975	; offset 0x0c17
	push hl	; offset 0x0c18
	ld hl,44975	; offset 0x0c1b
	push hl	; offset 0x0c1c
	ld hl,44975	; offset 0x0c1f
	push hl	; offset 0x0c20
	ld hl,44975	; offset 0x0c23
	push hl	; offset 0x0c24
	ld hl,44975	; offset 0x0c27
	push hl	; offset 0x0c28
	ld hl,44975	; offset 0x0c2b
	push hl	; offset 0x0c2c
	ld hl,44975	; offset 0x0c2f
	push hl	; offset 0x0c30

	; src_data blit 25
	ld sp,screenStartAddr+1088	; offset 0x0c33
	ld hl,44975	; offset 0x0c36
	push hl	; offset 0x0c37
	ld hl,44975	; offset 0x0c3a
	push hl	; offset 0x0c3b
	ld hl,44975	; offset 0x0c3e
	push hl	; offset 0x0c3f
	ld hl,44975	; offset 0x0c42
	push hl	; offset 0x0c43
	ld hl,44975	; offset 0x0c46
	push hl	; offset 0x0c47
	ld hl,44975	; offset 0x0c4a
	push hl	; offset 0x0c4b
	ld hl,44975	; offset 0x0c4e
	push hl	; offset 0x0c4f
	ld hl,44975	; offset 0x0c52
	push hl	; offset 0x0c53

	; src_data blit 26
	ld sp,screenStartAddr+1328	; offset 0x0c56
	ld hl,44975	; offset 0x0c59
	push hl	; offset 0x0c5a
	ld hl,44975	; offset 0x0c5d
	push hl	; offset 0x0c5e
	ld hl,44975	; offset 0x0c61
	push hl	; offset 0x0c62
	ld hl,44975	; offset 0x0c65
	push hl	; offset 0x0c66
	ld hl,44975	; offset 0x0c69
	push hl	; offset 0x0c6a
	ld hl,44975	; offset 0x0c6d
	push hl	; offset 0x0c6e
	ld hl,44975	; offset 0x0c71
	push hl	; offset 0x0c72
	ld hl,44975	; offset 0x0c75
	push hl	; offset 0x0c76

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 4, offset 0x0ccf
	; Clock offset: -864


	; src_data blit 27
	ld sp,screenStartAddr+1344	; offset 0x0cd2
	ld hl,44975	; offset 0x0cd5
	push hl	; offset 0x0cd6
	ld hl,44975	; offset 0x0cd9
	push hl	; offset 0x0cda
	ld hl,44975	; offset 0x0cdd
	push hl	; offset 0x0cde
	ld hl,44975	; offset 0x0ce1
	push hl	; offset 0x0ce2
	ld hl,44975	; offset 0x0ce5
	push hl	; offset 0x0ce6
	ld hl,44975	; offset 0x0ce9
	push hl	; offset 0x0cea
	ld hl,44975	; offset 0x0ced
	push hl	; offset 0x0cee
	ld hl,44975	; offset 0x0cf1
	push hl	; offset 0x0cf2

	; src_data blit 28
	ld sp,screenStartAddr+1584	; offset 0x0cf5
	ld hl,44975	; offset 0x0cf8
	push hl	; offset 0x0cf9
	ld hl,44975	; offset 0x0cfc
	push hl	; offset 0x0cfd
	ld hl,44975	; offset 0x0d00
	push hl	; offset 0x0d01
	ld hl,44975	; offset 0x0d04
	push hl	; offset 0x0d05
	ld hl,44975	; offset 0x0d08
	push hl	; offset 0x0d09
	ld hl,44975	; offset 0x0d0c
	push hl	; offset 0x0d0d
	ld hl,44975	; offset 0x0d10
	push hl	; offset 0x0d11
	ld hl,44975	; offset 0x0d14
	push hl	; offset 0x0d15

	; src_data blit 29
	ld sp,screenStartAddr+1600	; offset 0x0d18
	ld hl,44975	; offset 0x0d1b
	push hl	; offset 0x0d1c
	ld hl,44975	; offset 0x0d1f
	push hl	; offset 0x0d20
	ld hl,44975	; offset 0x0d23
	push hl	; offset 0x0d24
	ld hl,44975	; offset 0x0d27
	push hl	; offset 0x0d28
	ld hl,44975	; offset 0x0d2b
	push hl	; offset 0x0d2c
	ld hl,44975	; offset 0x0d2f
	push hl	; offset 0x0d30
	ld hl,44975	; offset 0x0d33
	push hl	; offset 0x0d34
	ld hl,44975	; offset 0x0d37
	push hl	; offset 0x0d38

	; src_data blit 30
	ld sp,screenStartAddr+1840	; offset 0x0d3b
	ld hl,44975	; offset 0x0d3e
	push hl	; offset 0x0d3f
	ld hl,44975	; offset 0x0d42
	push hl	; offset 0x0d43
	ld hl,44975	; offset 0x0d46
	push hl	; offset 0x0d47
	ld hl,44975	; offset 0x0d4a
	push hl	; offset 0x0d4b
	ld hl,44975	; offset 0x0d4e
	push hl	; offset 0x0d4f
	ld hl,44975	; offset 0x0d52
	push hl	; offset 0x0d53
	ld hl,44975	; offset 0x0d56
	push hl	; offset 0x0d57
	ld hl,44975	; offset 0x0d5a
	push hl	; offset 0x0d5b

	; src_data blit 31
	ld sp,screenStartAddr+1856	; offset 0x0d5e
	ld hl,44975	; offset 0x0d61
	push hl	; offset 0x0d62
	ld hl,44975	; offset 0x0d65
	push hl	; offset 0x0d66
	ld hl,44975	; offset 0x0d69
	push hl	; offset 0x0d6a
	ld hl,44975	; offset 0x0d6d
	push hl	; offset 0x0d6e
	ld hl,44975	; offset 0x0d71
	push hl	; offset 0x0d72
	ld hl,44975	; offset 0x0d75
	push hl	; offset 0x0d76
	ld hl,44975	; offset 0x0d79
	push hl	; offset 0x0d7a
	ld hl,44975	; offset 0x0d7d
	push hl	; offset 0x0d7e

	; src_data blit 32
	ld sp,screenStartAddr+80	; offset 0x0d81
	ld hl,44975	; offset 0x0d84
	push hl	; offset 0x0d85
	ld hl,44975	; offset 0x0d88
	push hl	; offset 0x0d89
	ld hl,44975	; offset 0x0d8c
	push hl	; offset 0x0d8d
	ld hl,44975	; offset 0x0d90
	push hl	; offset 0x0d91
	ld hl,44975	; offset 0x0d94
	push hl	; offset 0x0d95
	ld hl,44975	; offset 0x0d98
	push hl	; offset 0x0d99
	ld hl,44975	; offset 0x0d9c
	push hl	; offset 0x0d9d
	ld hl,44975	; offset 0x0da0
	push hl	; offset 0x0da1

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 5, offset 0x0dfa
	; Clock offset: -864


	; src_data blit 33
	ld sp,screenStartAddr+96	; offset 0x0dfd
	ld hl,44975	; offset 0x0e00
	push hl	; offset 0x0e01
	ld hl,44975	; offset 0x0e04
	push hl	; offset 0x0e05
	ld hl,44975	; offset 0x0e08
	push hl	; offset 0x0e09
	ld hl,44975	; offset 0x0e0c
	push hl	; offset 0x0e0d
	ld hl,44975	; offset 0x0e10
	push hl	; offset 0x0e11
	ld hl,44975	; offset 0x0e14
	push hl	; offset 0x0e15
	ld hl,44975	; offset 0x0e18
	push hl	; offset 0x0e19
	ld hl,44975	; offset 0x0e1c
	push hl	; offset 0x0e1d

	; src_data blit 34
	ld sp,screenStartAddr+336	; offset 0x0e20
	ld hl,44975	; offset 0x0e23
	push hl	; offset 0x0e24
	ld hl,44975	; offset 0x0e27
	push hl	; offset 0x0e28
	ld hl,44975	; offset 0x0e2b
	push hl	; offset 0x0e2c
	ld hl,44975	; offset 0x0e2f
	push hl	; offset 0x0e30
	ld hl,44975	; offset 0x0e33
	push hl	; offset 0x0e34
	ld hl,44975	; offset 0x0e37
	push hl	; offset 0x0e38
	ld hl,44975	; offset 0x0e3b
	push hl	; offset 0x0e3c
	ld hl,44975	; offset 0x0e3f
	push hl	; offset 0x0e40

	; src_data blit 35
	ld sp,screenStartAddr+352	; offset 0x0e43
	ld hl,44975	; offset 0x0e46
	push hl	; offset 0x0e47
	ld hl,44975	; offset 0x0e4a
	push hl	; offset 0x0e4b
	ld hl,44975	; offset 0x0e4e
	push hl	; offset 0x0e4f
	ld hl,44975	; offset 0x0e52
	push hl	; offset 0x0e53
	ld hl,44975	; offset 0x0e56
	push hl	; offset 0x0e57
	ld hl,44975	; offset 0x0e5a
	push hl	; offset 0x0e5b
	ld hl,44975	; offset 0x0e5e
	push hl	; offset 0x0e5f
	ld hl,44975	; offset 0x0e62
	push hl	; offset 0x0e63

	; src_data blit 36
	ld sp,screenStartAddr+592	; offset 0x0e66
	ld hl,44975	; offset 0x0e69
	push hl	; offset 0x0e6a
	ld hl,44975	; offset 0x0e6d
	push hl	; offset 0x0e6e
	ld hl,44975	; offset 0x0e71
	push hl	; offset 0x0e72
	ld hl,44975	; offset 0x0e75
	push hl	; offset 0x0e76
	ld hl,44975	; offset 0x0e79
	push hl	; offset 0x0e7a
	ld hl,44975	; offset 0x0e7d
	push hl	; offset 0x0e7e
	ld hl,44975	; offset 0x0e81
	push hl	; offset 0x0e82
	ld hl,44975	; offset 0x0e85
	push hl	; offset 0x0e86

	; src_data blit 37
	ld sp,screenStartAddr+608	; offset 0x0e89
	ld hl,44975	; offset 0x0e8c
	push hl	; offset 0x0e8d
	ld hl,44975	; offset 0x0e90
	push hl	; offset 0x0e91
	ld hl,44975	; offset 0x0e94
	push hl	; offset 0x0e95
	ld hl,44975	; offset 0x0e98
	push hl	; offset 0x0e99
	ld hl,44975	; offset 0x0e9c
	push hl	; offset 0x0e9d
	ld hl,44975	; offset 0x0ea0
	push hl	; offset 0x0ea1
	ld hl,44975	; offset 0x0ea4
	push hl	; offset 0x0ea5
	ld hl,44975	; offset 0x0ea8
	push hl	; offset 0x0ea9

	; src_data blit 38
	ld sp,screenStartAddr+848	; offset 0x0eac
	ld hl,44975	; offset 0x0eaf
	push hl	; offset 0x0eb0
	ld hl,44975	; offset 0x0eb3
	push hl	; offset 0x0eb4
	ld hl,44975	; offset 0x0eb7
	push hl	; offset 0x0eb8
	ld hl,44975	; offset 0x0ebb
	push hl	; offset 0x0ebc
	ld hl,44975	; offset 0x0ebf
	push hl	; offset 0x0ec0
	ld hl,44975	; offset 0x0ec3
	push hl	; offset 0x0ec4
	ld hl,44975	; offset 0x0ec7
	push hl	; offset 0x0ec8
	ld hl,44975	; offset 0x0ecb
	push hl	; offset 0x0ecc

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 6, offset 0x0f25
	; Clock offset: -864


	; src_data blit 39
	ld sp,screenStartAddr+864	; offset 0x0f28
	ld hl,44975	; offset 0x0f2b
	push hl	; offset 0x0f2c
	ld hl,44975	; offset 0x0f2f
	push hl	; offset 0x0f30
	ld hl,44975	; offset 0x0f33
	push hl	; offset 0x0f34
	ld hl,44975	; offset 0x0f37
	push hl	; offset 0x0f38
	ld hl,44975	; offset 0x0f3b
	push hl	; offset 0x0f3c
	ld hl,44975	; offset 0x0f3f
	push hl	; offset 0x0f40
	ld hl,44975	; offset 0x0f43
	push hl	; offset 0x0f44
	ld hl,44975	; offset 0x0f47
	push hl	; offset 0x0f48

	; src_data blit 40
	ld sp,screenStartAddr+1104	; offset 0x0f4b
	ld hl,44975	; offset 0x0f4e
	push hl	; offset 0x0f4f
	ld hl,44975	; offset 0x0f52
	push hl	; offset 0x0f53
	ld hl,44975	; offset 0x0f56
	push hl	; offset 0x0f57
	ld hl,44975	; offset 0x0f5a
	push hl	; offset 0x0f5b
	ld hl,44975	; offset 0x0f5e
	push hl	; offset 0x0f5f
	ld hl,44975	; offset 0x0f62
	push hl	; offset 0x0f63
	ld hl,44975	; offset 0x0f66
	push hl	; offset 0x0f67
	ld hl,44975	; offset 0x0f6a
	push hl	; offset 0x0f6b

	; src_data blit 41
	ld sp,screenStartAddr+1120	; offset 0x0f6e
	ld hl,44975	; offset 0x0f71
	push hl	; offset 0x0f72
	ld hl,44975	; offset 0x0f75
	push hl	; offset 0x0f76
	ld hl,44975	; offset 0x0f79
	push hl	; offset 0x0f7a
	ld hl,44975	; offset 0x0f7d
	push hl	; offset 0x0f7e
	ld hl,44975	; offset 0x0f81
	push hl	; offset 0x0f82
	ld hl,44975	; offset 0x0f85
	push hl	; offset 0x0f86
	ld hl,44975	; offset 0x0f89
	push hl	; offset 0x0f8a
	ld hl,44975	; offset 0x0f8d
	push hl	; offset 0x0f8e

	; src_data blit 42
	ld sp,screenStartAddr+1360	; offset 0x0f91
	ld hl,44975	; offset 0x0f94
	push hl	; offset 0x0f95
	ld hl,44975	; offset 0x0f98
	push hl	; offset 0x0f99
	ld hl,44975	; offset 0x0f9c
	push hl	; offset 0x0f9d
	ld hl,44975	; offset 0x0fa0
	push hl	; offset 0x0fa1
	ld hl,44975	; offset 0x0fa4
	push hl	; offset 0x0fa5
	ld hl,44975	; offset 0x0fa8
	push hl	; offset 0x0fa9
	ld hl,44975	; offset 0x0fac
	push hl	; offset 0x0fad
	ld hl,44975	; offset 0x0fb0
	push hl	; offset 0x0fb1

	; src_data blit 43
	ld sp,screenStartAddr+1376	; offset 0x0fb4
	ld hl,44975	; offset 0x0fb7
	push hl	; offset 0x0fb8
	ld hl,44975	; offset 0x0fbb
	push hl	; offset 0x0fbc
	ld hl,44975	; offset 0x0fbf
	push hl	; offset 0x0fc0
	ld hl,44975	; offset 0x0fc3
	push hl	; offset 0x0fc4
	ld hl,44975	; offset 0x0fc7
	push hl	; offset 0x0fc8
	ld hl,44975	; offset 0x0fcb
	push hl	; offset 0x0fcc
	ld hl,44975	; offset 0x0fcf
	push hl	; offset 0x0fd0
	ld hl,44975	; offset 0x0fd3
	push hl	; offset 0x0fd4

	; src_data blit 44
	ld sp,screenStartAddr+1616	; offset 0x0fd7
	ld hl,44975	; offset 0x0fda
	push hl	; offset 0x0fdb
	ld hl,44975	; offset 0x0fde
	push hl	; offset 0x0fdf
	ld hl,44975	; offset 0x0fe2
	push hl	; offset 0x0fe3
	ld hl,44975	; offset 0x0fe6
	push hl	; offset 0x0fe7
	ld hl,44975	; offset 0x0fea
	push hl	; offset 0x0feb
	ld hl,44975	; offset 0x0fee
	push hl	; offset 0x0fef
	ld hl,44975	; offset 0x0ff2
	push hl	; offset 0x0ff3
	ld hl,44975	; offset 0x0ff6
	push hl	; offset 0x0ff7

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 7, offset 0x1050
	; Clock offset: -864


	; src_data blit 45
	ld sp,screenStartAddr+1632	; offset 0x1053
	ld hl,44975	; offset 0x1056
	push hl	; offset 0x1057
	ld hl,44975	; offset 0x105a
	push hl	; offset 0x105b
	ld hl,44975	; offset 0x105e
	push hl	; offset 0x105f
	ld hl,44975	; offset 0x1062
	push hl	; offset 0x1063
	ld hl,44975	; offset 0x1066
	push hl	; offset 0x1067
	ld hl,44975	; offset 0x106a
	push hl	; offset 0x106b
	ld hl,44975	; offset 0x106e
	push hl	; offset 0x106f
	ld hl,44975	; offset 0x1072
	push hl	; offset 0x1073

	; src_data blit 46
	ld sp,screenStartAddr+1872	; offset 0x1076
	ld hl,44975	; offset 0x1079
	push hl	; offset 0x107a
	ld hl,44975	; offset 0x107d
	push hl	; offset 0x107e
	ld hl,44975	; offset 0x1081
	push hl	; offset 0x1082
	ld hl,44975	; offset 0x1085
	push hl	; offset 0x1086
	ld hl,44975	; offset 0x1089
	push hl	; offset 0x108a
	ld hl,44975	; offset 0x108d
	push hl	; offset 0x108e
	ld hl,44975	; offset 0x1091
	push hl	; offset 0x1092
	ld hl,44975	; offset 0x1095
	push hl	; offset 0x1096

	; src_data blit 47
	ld sp,screenStartAddr+1888	; offset 0x1099
	ld hl,44975	; offset 0x109c
	push hl	; offset 0x109d
	ld hl,44975	; offset 0x10a0
	push hl	; offset 0x10a1
	ld hl,44975	; offset 0x10a4
	push hl	; offset 0x10a5
	ld hl,44975	; offset 0x10a8
	push hl	; offset 0x10a9
	ld hl,44975	; offset 0x10ac
	push hl	; offset 0x10ad
	ld hl,44975	; offset 0x10b0
	push hl	; offset 0x10b1
	ld hl,44975	; offset 0x10b4
	push hl	; offset 0x10b5
	ld hl,44975	; offset 0x10b8
	push hl	; offset 0x10b9

	; src_data blit 48
	ld sp,screenStartAddr+112	; offset 0x10bc
	ld hl,44975	; offset 0x10bf
	push hl	; offset 0x10c0
	ld hl,44975	; offset 0x10c3
	push hl	; offset 0x10c4
	ld hl,44975	; offset 0x10c7
	push hl	; offset 0x10c8
	ld hl,44975	; offset 0x10cb
	push hl	; offset 0x10cc
	ld hl,44975	; offset 0x10cf
	push hl	; offset 0x10d0
	ld hl,44975	; offset 0x10d3
	push hl	; offset 0x10d4
	ld hl,44975	; offset 0x10d7
	push hl	; offset 0x10d8
	ld hl,44975	; offset 0x10db
	push hl	; offset 0x10dc

	; src_data blit 49
	ld sp,screenStartAddr+128	; offset 0x10df
	ld hl,44975	; offset 0x10e2
	push hl	; offset 0x10e3
	ld hl,44975	; offset 0x10e6
	push hl	; offset 0x10e7
	ld hl,44975	; offset 0x10ea
	push hl	; offset 0x10eb
	ld hl,44975	; offset 0x10ee
	push hl	; offset 0x10ef
	ld hl,44975	; offset 0x10f2
	push hl	; offset 0x10f3
	ld hl,44975	; offset 0x10f6
	push hl	; offset 0x10f7
	ld hl,44975	; offset 0x10fa
	push hl	; offset 0x10fb
	ld hl,44975	; offset 0x10fe
	push hl	; offset 0x10ff

	; src_data blit 50
	ld sp,screenStartAddr+368	; offset 0x1102
	ld hl,44975	; offset 0x1105
	push hl	; offset 0x1106
	ld hl,44975	; offset 0x1109
	push hl	; offset 0x110a
	ld hl,44975	; offset 0x110d
	push hl	; offset 0x110e
	ld hl,44975	; offset 0x1111
	push hl	; offset 0x1112
	ld hl,44975	; offset 0x1115
	push hl	; offset 0x1116
	ld hl,44975	; offset 0x1119
	push hl	; offset 0x111a
	ld hl,44975	; offset 0x111d
	push hl	; offset 0x111e
	ld hl,44975	; offset 0x1121
	push hl	; offset 0x1122

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 8, offset 0x117b
	; Clock offset: -864


	; src_data blit 51
	ld sp,screenStartAddr+384	; offset 0x117e
	ld hl,44975	; offset 0x1181
	push hl	; offset 0x1182
	ld hl,44975	; offset 0x1185
	push hl	; offset 0x1186
	ld hl,44975	; offset 0x1189
	push hl	; offset 0x118a
	ld hl,44975	; offset 0x118d
	push hl	; offset 0x118e
	ld hl,44975	; offset 0x1191
	push hl	; offset 0x1192
	ld hl,44975	; offset 0x1195
	push hl	; offset 0x1196
	ld hl,44975	; offset 0x1199
	push hl	; offset 0x119a
	ld hl,44975	; offset 0x119d
	push hl	; offset 0x119e

	; src_data blit 52
	ld sp,screenStartAddr+624	; offset 0x11a1
	ld hl,44975	; offset 0x11a4
	push hl	; offset 0x11a5
	ld hl,44975	; offset 0x11a8
	push hl	; offset 0x11a9
	ld hl,44975	; offset 0x11ac
	push hl	; offset 0x11ad
	ld hl,44975	; offset 0x11b0
	push hl	; offset 0x11b1
	ld hl,44975	; offset 0x11b4
	push hl	; offset 0x11b5
	ld hl,44975	; offset 0x11b8
	push hl	; offset 0x11b9
	ld hl,44975	; offset 0x11bc
	push hl	; offset 0x11bd
	ld hl,44975	; offset 0x11c0
	push hl	; offset 0x11c1

	; src_data blit 53
	ld sp,screenStartAddr+640	; offset 0x11c4
	ld hl,44975	; offset 0x11c7
	push hl	; offset 0x11c8
	ld hl,44975	; offset 0x11cb
	push hl	; offset 0x11cc
	ld hl,44975	; offset 0x11cf
	push hl	; offset 0x11d0
	ld hl,44975	; offset 0x11d3
	push hl	; offset 0x11d4
	ld hl,44975	; offset 0x11d7
	push hl	; offset 0x11d8
	ld hl,44975	; offset 0x11db
	push hl	; offset 0x11dc
	ld hl,44975	; offset 0x11df
	push hl	; offset 0x11e0
	ld hl,44975	; offset 0x11e3
	push hl	; offset 0x11e4

	; src_data blit 54
	ld sp,screenStartAddr+880	; offset 0x11e7
	ld hl,44975	; offset 0x11ea
	push hl	; offset 0x11eb
	ld hl,44975	; offset 0x11ee
	push hl	; offset 0x11ef
	ld hl,44975	; offset 0x11f2
	push hl	; offset 0x11f3
	ld hl,44975	; offset 0x11f6
	push hl	; offset 0x11f7
	ld hl,44975	; offset 0x11fa
	push hl	; offset 0x11fb
	ld hl,44975	; offset 0x11fe
	push hl	; offset 0x11ff
	ld hl,44975	; offset 0x1202
	push hl	; offset 0x1203
	ld hl,44975	; offset 0x1206
	push hl	; offset 0x1207

	; src_data blit 55
	ld sp,screenStartAddr+896	; offset 0x120a
	ld hl,44975	; offset 0x120d
	push hl	; offset 0x120e
	ld hl,44975	; offset 0x1211
	push hl	; offset 0x1212
	ld hl,44975	; offset 0x1215
	push hl	; offset 0x1216
	ld hl,44975	; offset 0x1219
	push hl	; offset 0x121a
	ld hl,44975	; offset 0x121d
	push hl	; offset 0x121e
	ld hl,44975	; offset 0x1221
	push hl	; offset 0x1222
	ld hl,44975	; offset 0x1225
	push hl	; offset 0x1226
	ld hl,44975	; offset 0x1229
	push hl	; offset 0x122a

	; src_data blit 56
	ld sp,screenStartAddr+1136	; offset 0x122d
	ld hl,44975	; offset 0x1230
	push hl	; offset 0x1231
	ld hl,44975	; offset 0x1234
	push hl	; offset 0x1235
	ld hl,44975	; offset 0x1238
	push hl	; offset 0x1239
	ld hl,44975	; offset 0x123c
	push hl	; offset 0x123d
	ld hl,44975	; offset 0x1240
	push hl	; offset 0x1241
	ld hl,44975	; offset 0x1244
	push hl	; offset 0x1245
	ld hl,44975	; offset 0x1248
	push hl	; offset 0x1249
	ld hl,44975	; offset 0x124c
	push hl	; offset 0x124d

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 9, offset 0x12a6
	; Clock offset: -864


	; src_data blit 57
	ld sp,screenStartAddr+1152	; offset 0x12a9
	ld hl,44975	; offset 0x12ac
	push hl	; offset 0x12ad
	ld hl,44975	; offset 0x12b0
	push hl	; offset 0x12b1
	ld hl,44975	; offset 0x12b4
	push hl	; offset 0x12b5
	ld hl,44975	; offset 0x12b8
	push hl	; offset 0x12b9
	ld hl,44975	; offset 0x12bc
	push hl	; offset 0x12bd
	ld hl,44975	; offset 0x12c0
	push hl	; offset 0x12c1
	ld hl,44975	; offset 0x12c4
	push hl	; offset 0x12c5
	ld hl,44975	; offset 0x12c8
	push hl	; offset 0x12c9

	; src_data blit 58
	ld sp,screenStartAddr+1392	; offset 0x12cc
	ld hl,44975	; offset 0x12cf
	push hl	; offset 0x12d0
	ld hl,44975	; offset 0x12d3
	push hl	; offset 0x12d4
	ld hl,44975	; offset 0x12d7
	push hl	; offset 0x12d8
	ld hl,44975	; offset 0x12db
	push hl	; offset 0x12dc
	ld hl,44975	; offset 0x12df
	push hl	; offset 0x12e0
	ld hl,44975	; offset 0x12e3
	push hl	; offset 0x12e4
	ld hl,44975	; offset 0x12e7
	push hl	; offset 0x12e8
	ld hl,44975	; offset 0x12eb
	push hl	; offset 0x12ec

	; src_data blit 59
	ld sp,screenStartAddr+1408	; offset 0x12ef
	ld hl,44975	; offset 0x12f2
	push hl	; offset 0x12f3
	ld hl,44975	; offset 0x12f6
	push hl	; offset 0x12f7
	ld hl,44975	; offset 0x12fa
	push hl	; offset 0x12fb
	ld hl,44975	; offset 0x12fe
	push hl	; offset 0x12ff
	ld hl,44975	; offset 0x1302
	push hl	; offset 0x1303
	ld hl,44975	; offset 0x1306
	push hl	; offset 0x1307
	ld hl,44975	; offset 0x130a
	push hl	; offset 0x130b
	ld hl,44975	; offset 0x130e
	push hl	; offset 0x130f

	; src_data blit 60
	ld sp,screenStartAddr+1648	; offset 0x1312
	ld hl,44975	; offset 0x1315
	push hl	; offset 0x1316
	ld hl,44975	; offset 0x1319
	push hl	; offset 0x131a
	ld hl,44975	; offset 0x131d
	push hl	; offset 0x131e
	ld hl,44975	; offset 0x1321
	push hl	; offset 0x1322
	ld hl,44975	; offset 0x1325
	push hl	; offset 0x1326
	ld hl,44975	; offset 0x1329
	push hl	; offset 0x132a
	ld hl,44975	; offset 0x132d
	push hl	; offset 0x132e
	ld hl,44975	; offset 0x1331
	push hl	; offset 0x1332

	; src_data blit 61
	ld sp,screenStartAddr+1664	; offset 0x1335
	ld hl,44975	; offset 0x1338
	push hl	; offset 0x1339
	ld hl,44975	; offset 0x133c
	push hl	; offset 0x133d
	ld hl,44975	; offset 0x1340
	push hl	; offset 0x1341
	ld hl,44975	; offset 0x1344
	push hl	; offset 0x1345
	ld hl,44975	; offset 0x1348
	push hl	; offset 0x1349
	ld hl,44975	; offset 0x134c
	push hl	; offset 0x134d
	ld hl,44975	; offset 0x1350
	push hl	; offset 0x1351
	ld hl,44975	; offset 0x1354
	push hl	; offset 0x1355

	; src_data blit 62
	ld sp,screenStartAddr+1904	; offset 0x1358
	ld hl,44975	; offset 0x135b
	push hl	; offset 0x135c
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
	ld hl,44975	; offset 0x1377
	push hl	; offset 0x1378

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 10, offset 0x13d1
	; Clock offset: -864


	; src_data blit 63
	ld sp,screenStartAddr+1920	; offset 0x13d4
	ld hl,44975	; offset 0x13d7
	push hl	; offset 0x13d8
	ld hl,44975	; offset 0x13db
	push hl	; offset 0x13dc
	ld hl,44975	; offset 0x13df
	push hl	; offset 0x13e0
	ld hl,44975	; offset 0x13e3
	push hl	; offset 0x13e4
	ld hl,44975	; offset 0x13e7
	push hl	; offset 0x13e8
	ld hl,44975	; offset 0x13eb
	push hl	; offset 0x13ec
	ld hl,44975	; offset 0x13ef
	push hl	; offset 0x13f0
	ld hl,44975	; offset 0x13f3
	push hl	; offset 0x13f4

	; src_data blit 64
	ld sp,screenStartAddr+144	; offset 0x13f7
	ld hl,44975	; offset 0x13fa
	push hl	; offset 0x13fb
	ld hl,44975	; offset 0x13fe
	push hl	; offset 0x13ff
	ld hl,44975	; offset 0x1402
	push hl	; offset 0x1403
	ld hl,44975	; offset 0x1406
	push hl	; offset 0x1407
	ld hl,44975	; offset 0x140a
	push hl	; offset 0x140b
	ld hl,44975	; offset 0x140e
	push hl	; offset 0x140f
	ld hl,44975	; offset 0x1412
	push hl	; offset 0x1413
	ld hl,44975	; offset 0x1416
	push hl	; offset 0x1417

	; src_data blit 65
	ld sp,screenStartAddr+160	; offset 0x141a
	ld hl,44975	; offset 0x141d
	push hl	; offset 0x141e
	ld hl,44975	; offset 0x1421
	push hl	; offset 0x1422
	ld hl,44975	; offset 0x1425
	push hl	; offset 0x1426
	ld hl,44975	; offset 0x1429
	push hl	; offset 0x142a
	ld hl,44975	; offset 0x142d
	push hl	; offset 0x142e
	ld hl,44975	; offset 0x1431
	push hl	; offset 0x1432
	ld hl,44975	; offset 0x1435
	push hl	; offset 0x1436
	ld hl,44975	; offset 0x1439
	push hl	; offset 0x143a

	; src_data blit 66
	ld sp,screenStartAddr+400	; offset 0x143d
	ld hl,44975	; offset 0x1440
	push hl	; offset 0x1441
	ld hl,44975	; offset 0x1444
	push hl	; offset 0x1445
	ld hl,44975	; offset 0x1448
	push hl	; offset 0x1449
	ld hl,44975	; offset 0x144c
	push hl	; offset 0x144d
	ld hl,44975	; offset 0x1450
	push hl	; offset 0x1451
	ld hl,44975	; offset 0x1454
	push hl	; offset 0x1455
	ld hl,44975	; offset 0x1458
	push hl	; offset 0x1459
	ld hl,44975	; offset 0x145c
	push hl	; offset 0x145d

	; src_data blit 67
	ld sp,screenStartAddr+416	; offset 0x1460
	ld hl,44975	; offset 0x1463
	push hl	; offset 0x1464
	ld hl,44975	; offset 0x1467
	push hl	; offset 0x1468
	ld hl,44975	; offset 0x146b
	push hl	; offset 0x146c
	ld hl,44975	; offset 0x146f
	push hl	; offset 0x1470
	ld hl,44975	; offset 0x1473
	push hl	; offset 0x1474
	ld hl,44975	; offset 0x1477
	push hl	; offset 0x1478
	ld hl,44975	; offset 0x147b
	push hl	; offset 0x147c
	ld hl,44975	; offset 0x147f
	push hl	; offset 0x1480

	; src_data blit 68
	ld sp,screenStartAddr+656	; offset 0x1483
	ld hl,44975	; offset 0x1486
	push hl	; offset 0x1487
	ld hl,44975	; offset 0x148a
	push hl	; offset 0x148b
	ld hl,44975	; offset 0x148e
	push hl	; offset 0x148f
	ld hl,44975	; offset 0x1492
	push hl	; offset 0x1493
	ld hl,44975	; offset 0x1496
	push hl	; offset 0x1497
	ld hl,44975	; offset 0x149a
	push hl	; offset 0x149b
	ld hl,44975	; offset 0x149e
	push hl	; offset 0x149f
	ld hl,44975	; offset 0x14a2
	push hl	; offset 0x14a3

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 11, offset 0x14fc
	; Clock offset: -864


	; src_data blit 69
	ld sp,screenStartAddr+672	; offset 0x14ff
	ld hl,44975	; offset 0x1502
	push hl	; offset 0x1503
	ld hl,44975	; offset 0x1506
	push hl	; offset 0x1507
	ld hl,44975	; offset 0x150a
	push hl	; offset 0x150b
	ld hl,44975	; offset 0x150e
	push hl	; offset 0x150f
	ld hl,44975	; offset 0x1512
	push hl	; offset 0x1513
	ld hl,44975	; offset 0x1516
	push hl	; offset 0x1517
	ld hl,44975	; offset 0x151a
	push hl	; offset 0x151b
	ld hl,44975	; offset 0x151e
	push hl	; offset 0x151f

	; src_data blit 70
	ld sp,screenStartAddr+912	; offset 0x1522
	ld hl,44975	; offset 0x1525
	push hl	; offset 0x1526
	ld hl,44975	; offset 0x1529
	push hl	; offset 0x152a
	ld hl,44975	; offset 0x152d
	push hl	; offset 0x152e
	ld hl,44975	; offset 0x1531
	push hl	; offset 0x1532
	ld hl,44975	; offset 0x1535
	push hl	; offset 0x1536
	ld hl,44975	; offset 0x1539
	push hl	; offset 0x153a
	ld hl,44975	; offset 0x153d
	push hl	; offset 0x153e
	ld hl,44975	; offset 0x1541
	push hl	; offset 0x1542

	; src_data blit 71
	ld sp,screenStartAddr+928	; offset 0x1545
	ld hl,44975	; offset 0x1548
	push hl	; offset 0x1549
	ld hl,44975	; offset 0x154c
	push hl	; offset 0x154d
	ld hl,44975	; offset 0x1550
	push hl	; offset 0x1551
	ld hl,44975	; offset 0x1554
	push hl	; offset 0x1555
	ld hl,44975	; offset 0x1558
	push hl	; offset 0x1559
	ld hl,44975	; offset 0x155c
	push hl	; offset 0x155d
	ld hl,44975	; offset 0x1560
	push hl	; offset 0x1561
	ld hl,44975	; offset 0x1564
	push hl	; offset 0x1565

	; src_data blit 72
	ld sp,screenStartAddr+1168	; offset 0x1568
	ld hl,44975	; offset 0x156b
	push hl	; offset 0x156c
	ld hl,44975	; offset 0x156f
	push hl	; offset 0x1570
	ld hl,44975	; offset 0x1573
	push hl	; offset 0x1574
	ld hl,44975	; offset 0x1577
	push hl	; offset 0x1578
	ld hl,44975	; offset 0x157b
	push hl	; offset 0x157c
	ld hl,44975	; offset 0x157f
	push hl	; offset 0x1580
	ld hl,44975	; offset 0x1583
	push hl	; offset 0x1584
	ld hl,44975	; offset 0x1587
	push hl	; offset 0x1588

	; src_data blit 73
	ld sp,screenStartAddr+1184	; offset 0x158b
	ld hl,44975	; offset 0x158e
	push hl	; offset 0x158f
	ld hl,44975	; offset 0x1592
	push hl	; offset 0x1593
	ld hl,44975	; offset 0x1596
	push hl	; offset 0x1597
	ld hl,44975	; offset 0x159a
	push hl	; offset 0x159b
	ld hl,44975	; offset 0x159e
	push hl	; offset 0x159f
	ld hl,44975	; offset 0x15a2
	push hl	; offset 0x15a3
	ld hl,44975	; offset 0x15a6
	push hl	; offset 0x15a7
	ld hl,44975	; offset 0x15aa
	push hl	; offset 0x15ab

	; src_data blit 74
	ld sp,screenStartAddr+1424	; offset 0x15ae
	ld hl,44975	; offset 0x15b1
	push hl	; offset 0x15b2
	ld hl,44975	; offset 0x15b5
	push hl	; offset 0x15b6
	ld hl,44975	; offset 0x15b9
	push hl	; offset 0x15ba
	ld hl,44975	; offset 0x15bd
	push hl	; offset 0x15be
	ld hl,44975	; offset 0x15c1
	push hl	; offset 0x15c2
	ld hl,44975	; offset 0x15c5
	push hl	; offset 0x15c6
	ld hl,44975	; offset 0x15c9
	push hl	; offset 0x15ca
	ld hl,44975	; offset 0x15cd
	push hl	; offset 0x15ce

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 12, offset 0x1627
	; Clock offset: -864


	; src_data blit 75
	ld sp,screenStartAddr+1440	; offset 0x162a
	ld hl,44975	; offset 0x162d
	push hl	; offset 0x162e
	ld hl,44975	; offset 0x1631
	push hl	; offset 0x1632
	ld hl,44975	; offset 0x1635
	push hl	; offset 0x1636
	ld hl,44975	; offset 0x1639
	push hl	; offset 0x163a
	ld hl,44975	; offset 0x163d
	push hl	; offset 0x163e
	ld hl,44975	; offset 0x1641
	push hl	; offset 0x1642
	ld hl,44975	; offset 0x1645
	push hl	; offset 0x1646
	ld hl,44975	; offset 0x1649
	push hl	; offset 0x164a

	; src_data blit 76
	ld sp,screenStartAddr+1680	; offset 0x164d
	ld hl,44975	; offset 0x1650
	push hl	; offset 0x1651
	ld hl,44975	; offset 0x1654
	push hl	; offset 0x1655
	ld hl,44975	; offset 0x1658
	push hl	; offset 0x1659
	ld hl,44975	; offset 0x165c
	push hl	; offset 0x165d
	ld hl,44975	; offset 0x1660
	push hl	; offset 0x1661
	ld hl,44975	; offset 0x1664
	push hl	; offset 0x1665
	ld hl,44975	; offset 0x1668
	push hl	; offset 0x1669
	ld hl,44975	; offset 0x166c
	push hl	; offset 0x166d

	; src_data blit 77
	ld sp,screenStartAddr+1696	; offset 0x1670
	ld hl,44975	; offset 0x1673
	push hl	; offset 0x1674
	ld hl,44975	; offset 0x1677
	push hl	; offset 0x1678
	ld hl,44975	; offset 0x167b
	push hl	; offset 0x167c
	ld hl,44975	; offset 0x167f
	push hl	; offset 0x1680
	ld hl,44975	; offset 0x1683
	push hl	; offset 0x1684
	ld hl,44975	; offset 0x1687
	push hl	; offset 0x1688
	ld hl,44975	; offset 0x168b
	push hl	; offset 0x168c
	ld hl,44975	; offset 0x168f
	push hl	; offset 0x1690

	; src_data blit 78
	ld sp,screenStartAddr+1936	; offset 0x1693
	ld hl,44975	; offset 0x1696
	push hl	; offset 0x1697
	ld hl,44975	; offset 0x169a
	push hl	; offset 0x169b
	ld hl,44975	; offset 0x169e
	push hl	; offset 0x169f
	ld hl,44975	; offset 0x16a2
	push hl	; offset 0x16a3
	ld hl,44975	; offset 0x16a6
	push hl	; offset 0x16a7
	ld hl,44975	; offset 0x16aa
	push hl	; offset 0x16ab
	ld hl,44975	; offset 0x16ae
	push hl	; offset 0x16af
	ld hl,44975	; offset 0x16b2
	push hl	; offset 0x16b3

	; src_data blit 79
	ld sp,screenStartAddr+1952	; offset 0x16b6
	ld hl,44975	; offset 0x16b9
	push hl	; offset 0x16ba
	ld hl,44975	; offset 0x16bd
	push hl	; offset 0x16be
	ld hl,44975	; offset 0x16c1
	push hl	; offset 0x16c2
	ld hl,44975	; offset 0x16c5
	push hl	; offset 0x16c6
	ld hl,44975	; offset 0x16c9
	push hl	; offset 0x16ca
	ld hl,44975	; offset 0x16cd
	push hl	; offset 0x16ce
	ld hl,44975	; offset 0x16d1
	push hl	; offset 0x16d2
	ld hl,44975	; offset 0x16d5
	push hl	; offset 0x16d6

	; src_data blit 80
	ld sp,screenStartAddr+176	; offset 0x16d9
	ld hl,44975	; offset 0x16dc
	push hl	; offset 0x16dd
	ld hl,44975	; offset 0x16e0
	push hl	; offset 0x16e1
	ld hl,44975	; offset 0x16e4
	push hl	; offset 0x16e5
	ld hl,44975	; offset 0x16e8
	push hl	; offset 0x16e9
	ld hl,44975	; offset 0x16ec
	push hl	; offset 0x16ed
	ld hl,44975	; offset 0x16f0
	push hl	; offset 0x16f1
	ld hl,44975	; offset 0x16f4
	push hl	; offset 0x16f5
	ld hl,44975	; offset 0x16f8
	push hl	; offset 0x16f9

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 13, offset 0x1752
	; Clock offset: -864


	; src_data blit 81
	ld sp,screenStartAddr+192	; offset 0x1755
	ld hl,44975	; offset 0x1758
	push hl	; offset 0x1759
	ld hl,44975	; offset 0x175c
	push hl	; offset 0x175d
	ld hl,44975	; offset 0x1760
	push hl	; offset 0x1761
	ld hl,44975	; offset 0x1764
	push hl	; offset 0x1765
	ld hl,44975	; offset 0x1768
	push hl	; offset 0x1769
	ld hl,44975	; offset 0x176c
	push hl	; offset 0x176d
	ld hl,44975	; offset 0x1770
	push hl	; offset 0x1771
	ld hl,44975	; offset 0x1774
	push hl	; offset 0x1775

	; src_data blit 82
	ld sp,screenStartAddr+432	; offset 0x1778
	ld hl,44975	; offset 0x177b
	push hl	; offset 0x177c
	ld hl,44975	; offset 0x177f
	push hl	; offset 0x1780
	ld hl,44975	; offset 0x1783
	push hl	; offset 0x1784
	ld hl,44975	; offset 0x1787
	push hl	; offset 0x1788
	ld hl,44975	; offset 0x178b
	push hl	; offset 0x178c
	ld hl,44975	; offset 0x178f
	push hl	; offset 0x1790
	ld hl,44975	; offset 0x1793
	push hl	; offset 0x1794
	ld hl,44975	; offset 0x1797
	push hl	; offset 0x1798

	; src_data blit 83
	ld sp,screenStartAddr+448	; offset 0x179b
	ld hl,44975	; offset 0x179e
	push hl	; offset 0x179f
	ld hl,44975	; offset 0x17a2
	push hl	; offset 0x17a3
	ld hl,44975	; offset 0x17a6
	push hl	; offset 0x17a7
	ld hl,44975	; offset 0x17aa
	push hl	; offset 0x17ab
	ld hl,44975	; offset 0x17ae
	push hl	; offset 0x17af
	ld hl,44975	; offset 0x17b2
	push hl	; offset 0x17b3
	ld hl,44975	; offset 0x17b6
	push hl	; offset 0x17b7
	ld hl,44975	; offset 0x17ba
	push hl	; offset 0x17bb

	; src_data blit 84
	ld sp,screenStartAddr+688	; offset 0x17be
	ld hl,44975	; offset 0x17c1
	push hl	; offset 0x17c2
	ld hl,44975	; offset 0x17c5
	push hl	; offset 0x17c6
	ld hl,44975	; offset 0x17c9
	push hl	; offset 0x17ca
	ld hl,44975	; offset 0x17cd
	push hl	; offset 0x17ce
	ld hl,44975	; offset 0x17d1
	push hl	; offset 0x17d2
	ld hl,44975	; offset 0x17d5
	push hl	; offset 0x17d6
	ld hl,44975	; offset 0x17d9
	push hl	; offset 0x17da
	ld hl,44975	; offset 0x17dd
	push hl	; offset 0x17de

	; src_data blit 85
	ld sp,screenStartAddr+704	; offset 0x17e1
	ld hl,44975	; offset 0x17e4
	push hl	; offset 0x17e5
	ld hl,44975	; offset 0x17e8
	push hl	; offset 0x17e9
	ld hl,44975	; offset 0x17ec
	push hl	; offset 0x17ed
	ld hl,44975	; offset 0x17f0
	push hl	; offset 0x17f1
	ld hl,44975	; offset 0x17f4
	push hl	; offset 0x17f5
	ld hl,44975	; offset 0x17f8
	push hl	; offset 0x17f9
	ld hl,44975	; offset 0x17fc
	push hl	; offset 0x17fd
	ld hl,44975	; offset 0x1800
	push hl	; offset 0x1801

	; src_data blit 86
	ld sp,screenStartAddr+944	; offset 0x1804
	ld hl,44975	; offset 0x1807
	push hl	; offset 0x1808
	ld hl,44975	; offset 0x180b
	push hl	; offset 0x180c
	ld hl,44975	; offset 0x180f
	push hl	; offset 0x1810
	ld hl,44975	; offset 0x1813
	push hl	; offset 0x1814
	ld hl,44975	; offset 0x1817
	push hl	; offset 0x1818
	ld hl,44975	; offset 0x181b
	push hl	; offset 0x181c
	ld hl,44975	; offset 0x181f
	push hl	; offset 0x1820
	ld hl,44975	; offset 0x1823
	push hl	; offset 0x1824

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 14, offset 0x187d
	; Clock offset: -864


	; src_data blit 87
	ld sp,screenStartAddr+960	; offset 0x1880
	ld hl,44975	; offset 0x1883
	push hl	; offset 0x1884
	ld hl,44975	; offset 0x1887
	push hl	; offset 0x1888
	ld hl,44975	; offset 0x188b
	push hl	; offset 0x188c
	ld hl,44975	; offset 0x188f
	push hl	; offset 0x1890
	ld hl,44975	; offset 0x1893
	push hl	; offset 0x1894
	ld hl,44975	; offset 0x1897
	push hl	; offset 0x1898
	ld hl,44975	; offset 0x189b
	push hl	; offset 0x189c
	ld hl,44975	; offset 0x189f
	push hl	; offset 0x18a0

	; src_data blit 88
	ld sp,screenStartAddr+1200	; offset 0x18a3
	ld hl,44975	; offset 0x18a6
	push hl	; offset 0x18a7
	ld hl,44975	; offset 0x18aa
	push hl	; offset 0x18ab
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

	; src_data blit 89
	ld sp,screenStartAddr+1216	; offset 0x18c6
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
	ld hl,44975	; offset 0x18e1
	push hl	; offset 0x18e2
	ld hl,44975	; offset 0x18e5
	push hl	; offset 0x18e6

	; src_data blit 90
	ld sp,screenStartAddr+1456	; offset 0x18e9
	ld hl,44975	; offset 0x18ec
	push hl	; offset 0x18ed
	ld hl,44975	; offset 0x18f0
	push hl	; offset 0x18f1
	ld hl,44975	; offset 0x18f4
	push hl	; offset 0x18f5
	ld hl,44975	; offset 0x18f8
	push hl	; offset 0x18f9
	ld hl,44975	; offset 0x18fc
	push hl	; offset 0x18fd
	ld hl,44975	; offset 0x1900
	push hl	; offset 0x1901
	ld hl,44975	; offset 0x1904
	push hl	; offset 0x1905
	ld hl,44975	; offset 0x1908
	push hl	; offset 0x1909

	; src_data blit 91
	ld sp,screenStartAddr+1472	; offset 0x190c
	ld hl,44975	; offset 0x190f
	push hl	; offset 0x1910
	ld hl,44975	; offset 0x1913
	push hl	; offset 0x1914
	ld hl,44975	; offset 0x1917
	push hl	; offset 0x1918
	ld hl,44975	; offset 0x191b
	push hl	; offset 0x191c
	ld hl,44975	; offset 0x191f
	push hl	; offset 0x1920
	ld hl,44975	; offset 0x1923
	push hl	; offset 0x1924
	ld hl,44975	; offset 0x1927
	push hl	; offset 0x1928
	ld hl,44975	; offset 0x192b
	push hl	; offset 0x192c

	; src_data blit 92
	ld sp,screenStartAddr+1712	; offset 0x192f
	ld hl,44975	; offset 0x1932
	push hl	; offset 0x1933
	ld hl,44975	; offset 0x1936
	push hl	; offset 0x1937
	ld hl,44975	; offset 0x193a
	push hl	; offset 0x193b
	ld hl,44975	; offset 0x193e
	push hl	; offset 0x193f
	ld hl,44975	; offset 0x1942
	push hl	; offset 0x1943
	ld hl,44975	; offset 0x1946
	push hl	; offset 0x1947
	ld hl,44975	; offset 0x194a
	push hl	; offset 0x194b
	ld hl,44975	; offset 0x194e
	push hl	; offset 0x194f

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 15, offset 0x19a8
	; Clock offset: -864


	; src_data blit 93
	ld sp,screenStartAddr+1728	; offset 0x19ab
	ld hl,44975	; offset 0x19ae
	push hl	; offset 0x19af
	ld hl,44975	; offset 0x19b2
	push hl	; offset 0x19b3
	ld hl,44975	; offset 0x19b6
	push hl	; offset 0x19b7
	ld hl,44975	; offset 0x19ba
	push hl	; offset 0x19bb
	ld hl,44975	; offset 0x19be
	push hl	; offset 0x19bf
	ld hl,44975	; offset 0x19c2
	push hl	; offset 0x19c3
	ld hl,44975	; offset 0x19c6
	push hl	; offset 0x19c7
	ld hl,44975	; offset 0x19ca
	push hl	; offset 0x19cb

	; src_data blit 94
	ld sp,screenStartAddr+1968	; offset 0x19ce
	ld hl,44975	; offset 0x19d1
	push hl	; offset 0x19d2
	ld hl,44975	; offset 0x19d5
	push hl	; offset 0x19d6
	ld hl,44975	; offset 0x19d9
	push hl	; offset 0x19da
	ld hl,44975	; offset 0x19dd
	push hl	; offset 0x19de
	ld hl,44975	; offset 0x19e1
	push hl	; offset 0x19e2
	ld hl,44975	; offset 0x19e5
	push hl	; offset 0x19e6
	ld hl,44975	; offset 0x19e9
	push hl	; offset 0x19ea
	ld hl,44975	; offset 0x19ed
	push hl	; offset 0x19ee

	; src_data blit 95
	ld sp,screenStartAddr+1984	; offset 0x19f1
	ld hl,44975	; offset 0x19f4
	push hl	; offset 0x19f5
	ld hl,44975	; offset 0x19f8
	push hl	; offset 0x19f9
	ld hl,44975	; offset 0x19fc
	push hl	; offset 0x19fd
	ld hl,44975	; offset 0x1a00
	push hl	; offset 0x1a01
	ld hl,44975	; offset 0x1a04
	push hl	; offset 0x1a05
	ld hl,44975	; offset 0x1a08
	push hl	; offset 0x1a09
	ld hl,44975	; offset 0x1a0c
	push hl	; offset 0x1a0d
	ld hl,44975	; offset 0x1a10
	push hl	; offset 0x1a11

	; src_data blit 96
	ld sp,screenStartAddr+208	; offset 0x1a14
	ld hl,44975	; offset 0x1a17
	push hl	; offset 0x1a18
	ld hl,44975	; offset 0x1a1b
	push hl	; offset 0x1a1c
	ld hl,44975	; offset 0x1a1f
	push hl	; offset 0x1a20
	ld hl,44975	; offset 0x1a23
	push hl	; offset 0x1a24
	ld hl,44975	; offset 0x1a27
	push hl	; offset 0x1a28
	ld hl,44975	; offset 0x1a2b
	push hl	; offset 0x1a2c
	ld hl,44975	; offset 0x1a2f
	push hl	; offset 0x1a30
	ld hl,44975	; offset 0x1a33
	push hl	; offset 0x1a34

	; src_data blit 97
	ld sp,screenStartAddr+224	; offset 0x1a37
	ld hl,44975	; offset 0x1a3a
	push hl	; offset 0x1a3b
	ld hl,44975	; offset 0x1a3e
	push hl	; offset 0x1a3f
	ld hl,44975	; offset 0x1a42
	push hl	; offset 0x1a43
	ld hl,44975	; offset 0x1a46
	push hl	; offset 0x1a47
	ld hl,44975	; offset 0x1a4a
	push hl	; offset 0x1a4b
	ld hl,44975	; offset 0x1a4e
	push hl	; offset 0x1a4f
	ld hl,44975	; offset 0x1a52
	push hl	; offset 0x1a53
	ld hl,44975	; offset 0x1a56
	push hl	; offset 0x1a57

	; src_data blit 98
	ld sp,screenStartAddr+464	; offset 0x1a5a
	ld hl,44975	; offset 0x1a5d
	push hl	; offset 0x1a5e
	ld hl,44975	; offset 0x1a61
	push hl	; offset 0x1a62
	ld hl,44975	; offset 0x1a65
	push hl	; offset 0x1a66
	ld hl,44975	; offset 0x1a69
	push hl	; offset 0x1a6a
	ld hl,44975	; offset 0x1a6d
	push hl	; offset 0x1a6e
	ld hl,44975	; offset 0x1a71
	push hl	; offset 0x1a72
	ld hl,44975	; offset 0x1a75
	push hl	; offset 0x1a76
	ld hl,44975	; offset 0x1a79
	push hl	; offset 0x1a7a

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 16, offset 0x1ad3
	; Clock offset: -864


	; src_data blit 99
	ld sp,screenStartAddr+480	; offset 0x1ad6
	ld hl,44975	; offset 0x1ad9
	push hl	; offset 0x1ada
	ld hl,44975	; offset 0x1add
	push hl	; offset 0x1ade
	ld hl,44975	; offset 0x1ae1
	push hl	; offset 0x1ae2
	ld hl,44975	; offset 0x1ae5
	push hl	; offset 0x1ae6
	ld hl,44975	; offset 0x1ae9
	push hl	; offset 0x1aea
	ld hl,44975	; offset 0x1aed
	push hl	; offset 0x1aee
	ld hl,44975	; offset 0x1af1
	push hl	; offset 0x1af2
	ld hl,44975	; offset 0x1af5
	push hl	; offset 0x1af6

	; src_data blit 100
	ld sp,screenStartAddr+720	; offset 0x1af9
	ld hl,44975	; offset 0x1afc
	push hl	; offset 0x1afd
	ld hl,44975	; offset 0x1b00
	push hl	; offset 0x1b01
	ld hl,44975	; offset 0x1b04
	push hl	; offset 0x1b05
	ld hl,44975	; offset 0x1b08
	push hl	; offset 0x1b09
	ld hl,44975	; offset 0x1b0c
	push hl	; offset 0x1b0d
	ld hl,44975	; offset 0x1b10
	push hl	; offset 0x1b11
	ld hl,44975	; offset 0x1b14
	push hl	; offset 0x1b15
	ld hl,44975	; offset 0x1b18
	push hl	; offset 0x1b19

	; src_data blit 101
	ld sp,screenStartAddr+736	; offset 0x1b1c
	ld hl,44975	; offset 0x1b1f
	push hl	; offset 0x1b20
	ld hl,44975	; offset 0x1b23
	push hl	; offset 0x1b24
	ld hl,44975	; offset 0x1b27
	push hl	; offset 0x1b28
	ld hl,44975	; offset 0x1b2b
	push hl	; offset 0x1b2c
	ld hl,44975	; offset 0x1b2f
	push hl	; offset 0x1b30
	ld hl,44975	; offset 0x1b33
	push hl	; offset 0x1b34
	ld hl,44975	; offset 0x1b37
	push hl	; offset 0x1b38
	ld hl,44975	; offset 0x1b3b
	push hl	; offset 0x1b3c

	; src_data blit 102
	ld sp,screenStartAddr+976	; offset 0x1b3f
	ld hl,44975	; offset 0x1b42
	push hl	; offset 0x1b43
	ld hl,44975	; offset 0x1b46
	push hl	; offset 0x1b47
	ld hl,44975	; offset 0x1b4a
	push hl	; offset 0x1b4b
	ld hl,44975	; offset 0x1b4e
	push hl	; offset 0x1b4f
	ld hl,44975	; offset 0x1b52
	push hl	; offset 0x1b53
	ld hl,44975	; offset 0x1b56
	push hl	; offset 0x1b57
	ld hl,44975	; offset 0x1b5a
	push hl	; offset 0x1b5b
	ld hl,44975	; offset 0x1b5e
	push hl	; offset 0x1b5f

	; src_data blit 103
	ld sp,screenStartAddr+992	; offset 0x1b62
	ld hl,44975	; offset 0x1b65
	push hl	; offset 0x1b66
	ld hl,44975	; offset 0x1b69
	push hl	; offset 0x1b6a
	ld hl,44975	; offset 0x1b6d
	push hl	; offset 0x1b6e
	ld hl,44975	; offset 0x1b71
	push hl	; offset 0x1b72
	ld hl,44975	; offset 0x1b75
	push hl	; offset 0x1b76
	ld hl,44975	; offset 0x1b79
	push hl	; offset 0x1b7a
	ld hl,44975	; offset 0x1b7d
	push hl	; offset 0x1b7e
	ld hl,44975	; offset 0x1b81
	push hl	; offset 0x1b82

	; src_data blit 104
	ld sp,screenStartAddr+1232	; offset 0x1b85
	ld hl,44975	; offset 0x1b88
	push hl	; offset 0x1b89
	ld hl,44975	; offset 0x1b8c
	push hl	; offset 0x1b8d
	ld hl,44975	; offset 0x1b90
	push hl	; offset 0x1b91
	ld hl,44975	; offset 0x1b94
	push hl	; offset 0x1b95
	ld hl,44975	; offset 0x1b98
	push hl	; offset 0x1b99
	ld hl,44975	; offset 0x1b9c
	push hl	; offset 0x1b9d
	ld hl,44975	; offset 0x1ba0
	push hl	; offset 0x1ba1
	ld hl,44975	; offset 0x1ba4
	push hl	; offset 0x1ba5

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 17, offset 0x1bfe
	; Clock offset: -864


	; src_data blit 105
	ld sp,screenStartAddr+1248	; offset 0x1c01
	ld hl,44975	; offset 0x1c04
	push hl	; offset 0x1c05
	ld hl,44975	; offset 0x1c08
	push hl	; offset 0x1c09
	ld hl,44975	; offset 0x1c0c
	push hl	; offset 0x1c0d
	ld hl,44975	; offset 0x1c10
	push hl	; offset 0x1c11
	ld hl,44975	; offset 0x1c14
	push hl	; offset 0x1c15
	ld hl,44975	; offset 0x1c18
	push hl	; offset 0x1c19
	ld hl,44975	; offset 0x1c1c
	push hl	; offset 0x1c1d
	ld hl,44975	; offset 0x1c20
	push hl	; offset 0x1c21

	; src_data blit 106
	ld sp,screenStartAddr+1488	; offset 0x1c24
	ld hl,44975	; offset 0x1c27
	push hl	; offset 0x1c28
	ld hl,44975	; offset 0x1c2b
	push hl	; offset 0x1c2c
	ld hl,44975	; offset 0x1c2f
	push hl	; offset 0x1c30
	ld hl,44975	; offset 0x1c33
	push hl	; offset 0x1c34
	ld hl,44975	; offset 0x1c37
	push hl	; offset 0x1c38
	ld hl,44975	; offset 0x1c3b
	push hl	; offset 0x1c3c
	ld hl,44975	; offset 0x1c3f
	push hl	; offset 0x1c40
	ld hl,44975	; offset 0x1c43
	push hl	; offset 0x1c44

	; src_data blit 107
	ld sp,screenStartAddr+1504	; offset 0x1c47
	ld hl,44975	; offset 0x1c4a
	push hl	; offset 0x1c4b
	ld hl,44975	; offset 0x1c4e
	push hl	; offset 0x1c4f
	ld hl,44975	; offset 0x1c52
	push hl	; offset 0x1c53
	ld hl,44975	; offset 0x1c56
	push hl	; offset 0x1c57
	ld hl,44975	; offset 0x1c5a
	push hl	; offset 0x1c5b
	ld hl,44975	; offset 0x1c5e
	push hl	; offset 0x1c5f
	ld hl,44975	; offset 0x1c62
	push hl	; offset 0x1c63
	ld hl,44975	; offset 0x1c66
	push hl	; offset 0x1c67

	; src_data blit 108
	ld sp,screenStartAddr+1744	; offset 0x1c6a
	ld hl,44975	; offset 0x1c6d
	push hl	; offset 0x1c6e
	ld hl,44975	; offset 0x1c71
	push hl	; offset 0x1c72
	ld hl,44975	; offset 0x1c75
	push hl	; offset 0x1c76
	ld hl,44975	; offset 0x1c79
	push hl	; offset 0x1c7a
	ld hl,44975	; offset 0x1c7d
	push hl	; offset 0x1c7e
	ld hl,44975	; offset 0x1c81
	push hl	; offset 0x1c82
	ld hl,44975	; offset 0x1c85
	push hl	; offset 0x1c86
	ld hl,44975	; offset 0x1c89
	push hl	; offset 0x1c8a

	; src_data blit 109
	ld sp,screenStartAddr+1760	; offset 0x1c8d
	ld hl,44975	; offset 0x1c90
	push hl	; offset 0x1c91
	ld hl,44975	; offset 0x1c94
	push hl	; offset 0x1c95
	ld hl,44975	; offset 0x1c98
	push hl	; offset 0x1c99
	ld hl,44975	; offset 0x1c9c
	push hl	; offset 0x1c9d
	ld hl,44975	; offset 0x1ca0
	push hl	; offset 0x1ca1
	ld hl,44975	; offset 0x1ca4
	push hl	; offset 0x1ca5
	ld hl,44975	; offset 0x1ca8
	push hl	; offset 0x1ca9
	ld hl,44975	; offset 0x1cac
	push hl	; offset 0x1cad

	; src_data blit 110
	ld sp,screenStartAddr+2000	; offset 0x1cb0
	ld hl,44975	; offset 0x1cb3
	push hl	; offset 0x1cb4
	ld hl,44975	; offset 0x1cb7
	push hl	; offset 0x1cb8
	ld hl,44975	; offset 0x1cbb
	push hl	; offset 0x1cbc
	ld hl,44975	; offset 0x1cbf
	push hl	; offset 0x1cc0
	ld hl,44975	; offset 0x1cc3
	push hl	; offset 0x1cc4
	ld hl,44975	; offset 0x1cc7
	push hl	; offset 0x1cc8
	ld hl,44975	; offset 0x1ccb
	push hl	; offset 0x1ccc
	ld hl,44975	; offset 0x1ccf
	push hl	; offset 0x1cd0

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 18, offset 0x1d29
	; Clock offset: -864


	; src_data blit 111
	ld sp,screenStartAddr+2016	; offset 0x1d2c
	ld hl,44975	; offset 0x1d2f
	push hl	; offset 0x1d30
	ld hl,44975	; offset 0x1d33
	push hl	; offset 0x1d34
	ld hl,44975	; offset 0x1d37
	push hl	; offset 0x1d38
	ld hl,44975	; offset 0x1d3b
	push hl	; offset 0x1d3c
	ld hl,44975	; offset 0x1d3f
	push hl	; offset 0x1d40
	ld hl,44975	; offset 0x1d43
	push hl	; offset 0x1d44
	ld hl,44975	; offset 0x1d47
	push hl	; offset 0x1d48
	ld hl,44975	; offset 0x1d4b
	push hl	; offset 0x1d4c

	; src_data blit 112
	ld sp,screenStartAddr+240	; offset 0x1d4f
	ld hl,44975	; offset 0x1d52
	push hl	; offset 0x1d53
	ld hl,44975	; offset 0x1d56
	push hl	; offset 0x1d57
	ld hl,44975	; offset 0x1d5a
	push hl	; offset 0x1d5b
	ld hl,44975	; offset 0x1d5e
	push hl	; offset 0x1d5f
	ld hl,44975	; offset 0x1d62
	push hl	; offset 0x1d63
	ld hl,44975	; offset 0x1d66
	push hl	; offset 0x1d67
	ld hl,44975	; offset 0x1d6a
	push hl	; offset 0x1d6b
	ld hl,44975	; offset 0x1d6e
	push hl	; offset 0x1d6f

	; src_data blit 113
	ld sp,screenStartAddr+256	; offset 0x1d72
	ld hl,44975	; offset 0x1d75
	push hl	; offset 0x1d76
	ld hl,44975	; offset 0x1d79
	push hl	; offset 0x1d7a
	ld hl,44975	; offset 0x1d7d
	push hl	; offset 0x1d7e
	ld hl,44975	; offset 0x1d81
	push hl	; offset 0x1d82
	ld hl,44975	; offset 0x1d85
	push hl	; offset 0x1d86
	ld hl,44975	; offset 0x1d89
	push hl	; offset 0x1d8a
	ld hl,44975	; offset 0x1d8d
	push hl	; offset 0x1d8e
	ld hl,44975	; offset 0x1d91
	push hl	; offset 0x1d92

	; src_data blit 114
	ld sp,screenStartAddr+496	; offset 0x1d95
	ld hl,44975	; offset 0x1d98
	push hl	; offset 0x1d99
	ld hl,44975	; offset 0x1d9c
	push hl	; offset 0x1d9d
	ld hl,44975	; offset 0x1da0
	push hl	; offset 0x1da1
	ld hl,44975	; offset 0x1da4
	push hl	; offset 0x1da5
	ld hl,44975	; offset 0x1da8
	push hl	; offset 0x1da9
	ld hl,44975	; offset 0x1dac
	push hl	; offset 0x1dad
	ld hl,44975	; offset 0x1db0
	push hl	; offset 0x1db1
	ld hl,44975	; offset 0x1db4
	push hl	; offset 0x1db5

	; src_data blit 115
	ld sp,screenStartAddr+512	; offset 0x1db8
	ld hl,44975	; offset 0x1dbb
	push hl	; offset 0x1dbc
	ld hl,44975	; offset 0x1dbf
	push hl	; offset 0x1dc0
	ld hl,44975	; offset 0x1dc3
	push hl	; offset 0x1dc4
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

	; src_data blit 116
	ld sp,screenStartAddr+752	; offset 0x1ddb
	ld hl,44975	; offset 0x1dde
	push hl	; offset 0x1ddf
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
	ld hl,44975	; offset 0x1dfa
	push hl	; offset 0x1dfb

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 19, offset 0x1e54
	; Clock offset: -864


	; src_data blit 117
	ld sp,screenStartAddr+768	; offset 0x1e57
	ld hl,44975	; offset 0x1e5a
	push hl	; offset 0x1e5b
	ld hl,44975	; offset 0x1e5e
	push hl	; offset 0x1e5f
	ld hl,44975	; offset 0x1e62
	push hl	; offset 0x1e63
	ld hl,44975	; offset 0x1e66
	push hl	; offset 0x1e67
	ld hl,44975	; offset 0x1e6a
	push hl	; offset 0x1e6b
	ld hl,44975	; offset 0x1e6e
	push hl	; offset 0x1e6f
	ld hl,44975	; offset 0x1e72
	push hl	; offset 0x1e73
	ld hl,44975	; offset 0x1e76
	push hl	; offset 0x1e77

	; src_data blit 118
	ld sp,screenStartAddr+1008	; offset 0x1e7a
	ld hl,44975	; offset 0x1e7d
	push hl	; offset 0x1e7e
	ld hl,44975	; offset 0x1e81
	push hl	; offset 0x1e82
	ld hl,44975	; offset 0x1e85
	push hl	; offset 0x1e86
	ld hl,44975	; offset 0x1e89
	push hl	; offset 0x1e8a
	ld hl,44975	; offset 0x1e8d
	push hl	; offset 0x1e8e
	ld hl,44975	; offset 0x1e91
	push hl	; offset 0x1e92
	ld hl,44975	; offset 0x1e95
	push hl	; offset 0x1e96
	ld hl,44975	; offset 0x1e99
	push hl	; offset 0x1e9a

	; src_data blit 119
	ld sp,screenStartAddr+1024	; offset 0x1e9d
	ld hl,44975	; offset 0x1ea0
	push hl	; offset 0x1ea1
	ld hl,44975	; offset 0x1ea4
	push hl	; offset 0x1ea5
	ld hl,44975	; offset 0x1ea8
	push hl	; offset 0x1ea9
	ld hl,44975	; offset 0x1eac
	push hl	; offset 0x1ead
	ld hl,44975	; offset 0x1eb0
	push hl	; offset 0x1eb1
	ld hl,44975	; offset 0x1eb4
	push hl	; offset 0x1eb5
	ld hl,44975	; offset 0x1eb8
	push hl	; offset 0x1eb9
	ld hl,44975	; offset 0x1ebc
	push hl	; offset 0x1ebd

	; src_data blit 120
	ld sp,screenStartAddr+1264	; offset 0x1ec0
	ld hl,44975	; offset 0x1ec3
	push hl	; offset 0x1ec4
	ld hl,44975	; offset 0x1ec7
	push hl	; offset 0x1ec8
	ld hl,44975	; offset 0x1ecb
	push hl	; offset 0x1ecc
	ld hl,44975	; offset 0x1ecf
	push hl	; offset 0x1ed0
	ld hl,44975	; offset 0x1ed3
	push hl	; offset 0x1ed4
	ld hl,44975	; offset 0x1ed7
	push hl	; offset 0x1ed8
	ld hl,44975	; offset 0x1edb
	push hl	; offset 0x1edc
	ld hl,44975	; offset 0x1edf
	push hl	; offset 0x1ee0

	; src_data blit 121
	ld sp,screenStartAddr+1280	; offset 0x1ee3
	ld hl,44975	; offset 0x1ee6
	push hl	; offset 0x1ee7
	ld hl,44975	; offset 0x1eea
	push hl	; offset 0x1eeb
	ld hl,44975	; offset 0x1eee
	push hl	; offset 0x1eef
	ld hl,44975	; offset 0x1ef2
	push hl	; offset 0x1ef3
	ld hl,44975	; offset 0x1ef6
	push hl	; offset 0x1ef7
	ld hl,44975	; offset 0x1efa
	push hl	; offset 0x1efb
	ld hl,44975	; offset 0x1efe
	push hl	; offset 0x1eff
	ld hl,44975	; offset 0x1f02
	push hl	; offset 0x1f03

	; src_data blit 122
	ld sp,screenStartAddr+1520	; offset 0x1f06
	ld hl,44975	; offset 0x1f09
	push hl	; offset 0x1f0a
	ld hl,44975	; offset 0x1f0d
	push hl	; offset 0x1f0e
	ld hl,44975	; offset 0x1f11
	push hl	; offset 0x1f12
	ld hl,44975	; offset 0x1f15
	push hl	; offset 0x1f16
	ld hl,44975	; offset 0x1f19
	push hl	; offset 0x1f1a
	ld hl,44975	; offset 0x1f1d
	push hl	; offset 0x1f1e
	ld hl,44975	; offset 0x1f21
	push hl	; offset 0x1f22
	ld hl,44975	; offset 0x1f25
	push hl	; offset 0x1f26

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 20, offset 0x1f7f
	; Clock offset: -864


	; src_data blit 123
	ld sp,screenStartAddr+1536	; offset 0x1f82
	ld hl,44975	; offset 0x1f85
	push hl	; offset 0x1f86
	ld hl,44975	; offset 0x1f89
	push hl	; offset 0x1f8a
	ld hl,44975	; offset 0x1f8d
	push hl	; offset 0x1f8e
	ld hl,44975	; offset 0x1f91
	push hl	; offset 0x1f92
	ld hl,44975	; offset 0x1f95
	push hl	; offset 0x1f96
	ld hl,44975	; offset 0x1f99
	push hl	; offset 0x1f9a
	ld hl,44975	; offset 0x1f9d
	push hl	; offset 0x1f9e
	ld hl,44975	; offset 0x1fa1
	push hl	; offset 0x1fa2

	; src_data blit 124
	ld sp,screenStartAddr+1776	; offset 0x1fa5
	ld hl,44975	; offset 0x1fa8
	push hl	; offset 0x1fa9
	ld hl,44975	; offset 0x1fac
	push hl	; offset 0x1fad
	ld hl,44975	; offset 0x1fb0
	push hl	; offset 0x1fb1
	ld hl,44975	; offset 0x1fb4
	push hl	; offset 0x1fb5
	ld hl,44975	; offset 0x1fb8
	push hl	; offset 0x1fb9
	ld hl,44975	; offset 0x1fbc
	push hl	; offset 0x1fbd
	ld hl,44975	; offset 0x1fc0
	push hl	; offset 0x1fc1
	ld hl,44975	; offset 0x1fc4
	push hl	; offset 0x1fc5

	; src_data blit 125
	ld sp,screenStartAddr+1792	; offset 0x1fc8
	ld hl,44975	; offset 0x1fcb
	push hl	; offset 0x1fcc
	ld hl,44975	; offset 0x1fcf
	push hl	; offset 0x1fd0
	ld hl,44975	; offset 0x1fd3
	push hl	; offset 0x1fd4
	ld hl,44975	; offset 0x1fd7
	push hl	; offset 0x1fd8
	ld hl,44975	; offset 0x1fdb
	push hl	; offset 0x1fdc
	ld hl,44975	; offset 0x1fdf
	push hl	; offset 0x1fe0
	ld hl,44975	; offset 0x1fe3
	push hl	; offset 0x1fe4
	ld hl,44975	; offset 0x1fe7
	push hl	; offset 0x1fe8

	; src_data blit 126
	ld sp,screenStartAddr+2032	; offset 0x1feb
	ld hl,44975	; offset 0x1fee
	push hl	; offset 0x1fef
	ld hl,44975	; offset 0x1ff2
	push hl	; offset 0x1ff3
	ld hl,44975	; offset 0x1ff6
	push hl	; offset 0x1ff7
	ld hl,44975	; offset 0x1ffa
	push hl	; offset 0x1ffb
	ld hl,44975	; offset 0x1ffe
	push hl	; offset 0x1fff
	ld hl,44975	; offset 0x2002
	push hl	; offset 0x2003
	ld hl,44975	; offset 0x2006
	push hl	; offset 0x2007
	ld hl,44975	; offset 0x200a
	push hl	; offset 0x200b

	; src_data blit 127
	ld sp,screenStartAddr+2048	; offset 0x200e
	ld hl,44975	; offset 0x2011
	push hl	; offset 0x2012
	ld hl,44975	; offset 0x2015
	push hl	; offset 0x2016
	ld hl,44975	; offset 0x2019
	push hl	; offset 0x201a
	ld hl,44975	; offset 0x201d
	push hl	; offset 0x201e
	ld hl,44975	; offset 0x2021
	push hl	; offset 0x2022
	ld hl,44975	; offset 0x2025
	push hl	; offset 0x2026
	ld hl,44975	; offset 0x2029
	push hl	; offset 0x202a
	ld hl,44975	; offset 0x202d
	push hl	; offset 0x202e

	; src_data blit 128
	ld sp,screenStartAddr+2064	; offset 0x2031
	ld hl,44975	; offset 0x2034
	push hl	; offset 0x2035
	ld hl,44975	; offset 0x2038
	push hl	; offset 0x2039
	ld hl,44975	; offset 0x203c
	push hl	; offset 0x203d
	ld hl,44975	; offset 0x2040
	push hl	; offset 0x2041
	ld hl,44975	; offset 0x2044
	push hl	; offset 0x2045
	ld hl,44975	; offset 0x2048
	push hl	; offset 0x2049
	ld hl,44975	; offset 0x204c
	push hl	; offset 0x204d
	ld hl,44975	; offset 0x2050
	push hl	; offset 0x2051

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 21, offset 0x20aa
	; Clock offset: -864


	; src_data blit 129
	ld sp,screenStartAddr+2080	; offset 0x20ad
	ld hl,44975	; offset 0x20b0
	push hl	; offset 0x20b1
	ld hl,44975	; offset 0x20b4
	push hl	; offset 0x20b5
	ld hl,44975	; offset 0x20b8
	push hl	; offset 0x20b9
	ld hl,44975	; offset 0x20bc
	push hl	; offset 0x20bd
	ld hl,44975	; offset 0x20c0
	push hl	; offset 0x20c1
	ld hl,44975	; offset 0x20c4
	push hl	; offset 0x20c5
	ld hl,44975	; offset 0x20c8
	push hl	; offset 0x20c9
	ld hl,44975	; offset 0x20cc
	push hl	; offset 0x20cd

	; src_data blit 130
	ld sp,screenStartAddr+2320	; offset 0x20d0
	ld hl,44975	; offset 0x20d3
	push hl	; offset 0x20d4
	ld hl,44975	; offset 0x20d7
	push hl	; offset 0x20d8
	ld hl,44975	; offset 0x20db
	push hl	; offset 0x20dc
	ld hl,44975	; offset 0x20df
	push hl	; offset 0x20e0
	ld hl,44975	; offset 0x20e3
	push hl	; offset 0x20e4
	ld hl,44975	; offset 0x20e7
	push hl	; offset 0x20e8
	ld hl,44975	; offset 0x20eb
	push hl	; offset 0x20ec
	ld hl,44975	; offset 0x20ef
	push hl	; offset 0x20f0

	; src_data blit 131
	ld sp,screenStartAddr+2336	; offset 0x20f3
	ld hl,44975	; offset 0x20f6
	push hl	; offset 0x20f7
	ld hl,44975	; offset 0x20fa
	push hl	; offset 0x20fb
	ld hl,44975	; offset 0x20fe
	push hl	; offset 0x20ff
	ld hl,44975	; offset 0x2102
	push hl	; offset 0x2103
	ld hl,44975	; offset 0x2106
	push hl	; offset 0x2107
	ld hl,44975	; offset 0x210a
	push hl	; offset 0x210b
	ld hl,44975	; offset 0x210e
	push hl	; offset 0x210f
	ld hl,44975	; offset 0x2112
	push hl	; offset 0x2113

	; src_data blit 132
	ld sp,screenStartAddr+2576	; offset 0x2116
	ld hl,44975	; offset 0x2119
	push hl	; offset 0x211a
	ld hl,44975	; offset 0x211d
	push hl	; offset 0x211e
	ld hl,44975	; offset 0x2121
	push hl	; offset 0x2122
	ld hl,44975	; offset 0x2125
	push hl	; offset 0x2126
	ld hl,44975	; offset 0x2129
	push hl	; offset 0x212a
	ld hl,44975	; offset 0x212d
	push hl	; offset 0x212e
	ld hl,44975	; offset 0x2131
	push hl	; offset 0x2132
	ld hl,44975	; offset 0x2135
	push hl	; offset 0x2136

	; src_data blit 133
	ld sp,screenStartAddr+2592	; offset 0x2139
	ld hl,44975	; offset 0x213c
	push hl	; offset 0x213d
	ld hl,44975	; offset 0x2140
	push hl	; offset 0x2141
	ld hl,44975	; offset 0x2144
	push hl	; offset 0x2145
	ld hl,44975	; offset 0x2148
	push hl	; offset 0x2149
	ld hl,44975	; offset 0x214c
	push hl	; offset 0x214d
	ld hl,44975	; offset 0x2150
	push hl	; offset 0x2151
	ld hl,44975	; offset 0x2154
	push hl	; offset 0x2155
	ld hl,44975	; offset 0x2158
	push hl	; offset 0x2159

	; src_data blit 134
	ld sp,screenStartAddr+2832	; offset 0x215c
	ld hl,44975	; offset 0x215f
	push hl	; offset 0x2160
	ld hl,44975	; offset 0x2163
	push hl	; offset 0x2164
	ld hl,44975	; offset 0x2167
	push hl	; offset 0x2168
	ld hl,44975	; offset 0x216b
	push hl	; offset 0x216c
	ld hl,44975	; offset 0x216f
	push hl	; offset 0x2170
	ld hl,44975	; offset 0x2173
	push hl	; offset 0x2174
	ld hl,44975	; offset 0x2177
	push hl	; offset 0x2178
	ld hl,44975	; offset 0x217b
	push hl	; offset 0x217c

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 22, offset 0x21d5
	; Clock offset: -864


	; src_data blit 135
	ld sp,screenStartAddr+2848	; offset 0x21d8
	ld hl,44975	; offset 0x21db
	push hl	; offset 0x21dc
	ld hl,44975	; offset 0x21df
	push hl	; offset 0x21e0
	ld hl,44975	; offset 0x21e3
	push hl	; offset 0x21e4
	ld hl,44975	; offset 0x21e7
	push hl	; offset 0x21e8
	ld hl,44975	; offset 0x21eb
	push hl	; offset 0x21ec
	ld hl,44975	; offset 0x21ef
	push hl	; offset 0x21f0
	ld hl,44975	; offset 0x21f3
	push hl	; offset 0x21f4
	ld hl,44975	; offset 0x21f7
	push hl	; offset 0x21f8

	; src_data blit 136
	ld sp,screenStartAddr+3088	; offset 0x21fb
	ld hl,44975	; offset 0x21fe
	push hl	; offset 0x21ff
	ld hl,44975	; offset 0x2202
	push hl	; offset 0x2203
	ld hl,44975	; offset 0x2206
	push hl	; offset 0x2207
	ld hl,44975	; offset 0x220a
	push hl	; offset 0x220b
	ld hl,44975	; offset 0x220e
	push hl	; offset 0x220f
	ld hl,44975	; offset 0x2212
	push hl	; offset 0x2213
	ld hl,44975	; offset 0x2216
	push hl	; offset 0x2217
	ld hl,44975	; offset 0x221a
	push hl	; offset 0x221b

	; src_data blit 137
	ld sp,screenStartAddr+3104	; offset 0x221e
	ld hl,44975	; offset 0x2221
	push hl	; offset 0x2222
	ld hl,44975	; offset 0x2225
	push hl	; offset 0x2226
	ld hl,44975	; offset 0x2229
	push hl	; offset 0x222a
	ld hl,44975	; offset 0x222d
	push hl	; offset 0x222e
	ld hl,44975	; offset 0x2231
	push hl	; offset 0x2232
	ld hl,44975	; offset 0x2235
	push hl	; offset 0x2236
	ld hl,44975	; offset 0x2239
	push hl	; offset 0x223a
	ld hl,44975	; offset 0x223d
	push hl	; offset 0x223e

	; src_data blit 138
	ld sp,screenStartAddr+3344	; offset 0x2241
	ld hl,44975	; offset 0x2244
	push hl	; offset 0x2245
	ld hl,44975	; offset 0x2248
	push hl	; offset 0x2249
	ld hl,44975	; offset 0x224c
	push hl	; offset 0x224d
	ld hl,44975	; offset 0x2250
	push hl	; offset 0x2251
	ld hl,44975	; offset 0x2254
	push hl	; offset 0x2255
	ld hl,44975	; offset 0x2258
	push hl	; offset 0x2259
	ld hl,44975	; offset 0x225c
	push hl	; offset 0x225d
	ld hl,44975	; offset 0x2260
	push hl	; offset 0x2261

	; src_data blit 139
	ld sp,screenStartAddr+3360	; offset 0x2264
	ld hl,44975	; offset 0x2267
	push hl	; offset 0x2268
	ld hl,44975	; offset 0x226b
	push hl	; offset 0x226c
	ld hl,44975	; offset 0x226f
	push hl	; offset 0x2270
	ld hl,44975	; offset 0x2273
	push hl	; offset 0x2274
	ld hl,44975	; offset 0x2277
	push hl	; offset 0x2278
	ld hl,44975	; offset 0x227b
	push hl	; offset 0x227c
	ld hl,44975	; offset 0x227f
	push hl	; offset 0x2280
	ld hl,44975	; offset 0x2283
	push hl	; offset 0x2284

	; src_data blit 140
	ld sp,screenStartAddr+3600	; offset 0x2287
	ld hl,44975	; offset 0x228a
	push hl	; offset 0x228b
	ld hl,44975	; offset 0x228e
	push hl	; offset 0x228f
	ld hl,44975	; offset 0x2292
	push hl	; offset 0x2293
	ld hl,44975	; offset 0x2296
	push hl	; offset 0x2297
	ld hl,44975	; offset 0x229a
	push hl	; offset 0x229b
	ld hl,44975	; offset 0x229e
	push hl	; offset 0x229f
	ld hl,44975	; offset 0x22a2
	push hl	; offset 0x22a3
	ld hl,44975	; offset 0x22a6
	push hl	; offset 0x22a7

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
	ld b,8
ifDelay:
	djnz ifDelay

	nop
	nop

	; end attr draw 23, offset 0x2303
	; Clock offset: -864


	; src_data blit 141
	ld sp,screenStartAddr+3616	; offset 0x2306
	ld hl,44975	; offset 0x2309
	push hl	; offset 0x230a
	ld hl,44975	; offset 0x230d
	push hl	; offset 0x230e
	ld hl,44975	; offset 0x2311
	push hl	; offset 0x2312
	ld hl,44975	; offset 0x2315
	push hl	; offset 0x2316
	ld hl,44975	; offset 0x2319
	push hl	; offset 0x231a
	ld hl,44975	; offset 0x231d
	push hl	; offset 0x231e
	ld hl,44975	; offset 0x2321
	push hl	; offset 0x2322
	ld hl,44975	; offset 0x2325
	push hl	; offset 0x2326

	; src_data blit 142
	ld sp,screenStartAddr+3856	; offset 0x2329
	ld hl,44975	; offset 0x232c
	push hl	; offset 0x232d
	ld hl,44975	; offset 0x2330
	push hl	; offset 0x2331
	ld hl,44975	; offset 0x2334
	push hl	; offset 0x2335
	ld hl,44975	; offset 0x2338
	push hl	; offset 0x2339
	ld hl,44975	; offset 0x233c
	push hl	; offset 0x233d
	ld hl,44975	; offset 0x2340
	push hl	; offset 0x2341
	ld hl,44975	; offset 0x2344
	push hl	; offset 0x2345
	ld hl,44975	; offset 0x2348
	push hl	; offset 0x2349

	; src_data blit 143
	ld sp,screenStartAddr+3872	; offset 0x234c
	ld hl,44975	; offset 0x234f
	push hl	; offset 0x2350
	ld hl,44975	; offset 0x2353
	push hl	; offset 0x2354
	ld hl,44975	; offset 0x2357
	push hl	; offset 0x2358
	ld hl,44975	; offset 0x235b
	push hl	; offset 0x235c
	ld hl,44975	; offset 0x235f
	push hl	; offset 0x2360
	ld hl,44975	; offset 0x2363
	push hl	; offset 0x2364
	ld hl,44975	; offset 0x2367
	push hl	; offset 0x2368
	ld hl,44975	; offset 0x236b
	push hl	; offset 0x236c

	; src_data blit 144
	ld sp,screenStartAddr+2096	; offset 0x236f
	ld hl,44975	; offset 0x2372
	push hl	; offset 0x2373
	ld hl,44975	; offset 0x2376
	push hl	; offset 0x2377
	ld hl,44975	; offset 0x237a
	push hl	; offset 0x237b
	ld hl,44975	; offset 0x237e
	push hl	; offset 0x237f
	ld hl,44975	; offset 0x2382
	push hl	; offset 0x2383
	ld hl,44975	; offset 0x2386
	push hl	; offset 0x2387
	ld hl,44975	; offset 0x238a
	push hl	; offset 0x238b
	ld hl,44975	; offset 0x238e
	push hl	; offset 0x238f

	; src_data blit 145
	ld sp,screenStartAddr+2112	; offset 0x2392
	ld hl,44975	; offset 0x2395
	push hl	; offset 0x2396
	ld hl,44975	; offset 0x2399
	push hl	; offset 0x239a
	ld hl,44975	; offset 0x239d
	push hl	; offset 0x239e
	ld hl,44975	; offset 0x23a1
	push hl	; offset 0x23a2
	ld hl,44975	; offset 0x23a5
	push hl	; offset 0x23a6
	ld hl,44975	; offset 0x23a9
	push hl	; offset 0x23aa
	ld hl,44975	; offset 0x23ad
	push hl	; offset 0x23ae
	ld hl,44975	; offset 0x23b1
	push hl	; offset 0x23b2

	; src_data blit 146
	ld sp,screenStartAddr+2352	; offset 0x23b5
	ld hl,44975	; offset 0x23b8
	push hl	; offset 0x23b9
	ld hl,44975	; offset 0x23bc
	push hl	; offset 0x23bd
	ld hl,44975	; offset 0x23c0
	push hl	; offset 0x23c1
	ld hl,44975	; offset 0x23c4
	push hl	; offset 0x23c5
	ld hl,44975	; offset 0x23c8
	push hl	; offset 0x23c9
	ld hl,44975	; offset 0x23cc
	push hl	; offset 0x23cd
	ld hl,44975	; offset 0x23d0
	push hl	; offset 0x23d1
	ld hl,44975	; offset 0x23d4
	push hl	; offset 0x23d5

	; src_data blit 147
	ld sp,screenStartAddr+2368	; offset 0x23d8
	ld hl,44975	; offset 0x23db
	push hl	; offset 0x23dc
	ld hl,44975	; offset 0x23df
	push hl	; offset 0x23e0
	ld hl,44975	; offset 0x23e3
	push hl	; offset 0x23e4
	ld hl,44975	; offset 0x23e7
	push hl	; offset 0x23e8
	ld hl,44975	; offset 0x23eb
	push hl	; offset 0x23ec
	ld hl,44975	; offset 0x23ef
	push hl	; offset 0x23f0
	ld hl,44975	; offset 0x23f3
	push hl	; offset 0x23f4
	ld hl,44975	; offset 0x23f7
	push hl	; offset 0x23f8
	; delay to get start of scanline (-144 T-states) at offset 0x23f8


	; src_data blit 148
	ld sp,screenStartAddr+2608	; offset 0x23fb
	ld hl,44975	; offset 0x23fe
	push hl	; offset 0x23ff
	ld hl,44975	; offset 0x2402
	push hl	; offset 0x2403
	ld hl,44975	; offset 0x2406
	push hl	; offset 0x2407
	ld hl,44975	; offset 0x240a
	push hl	; offset 0x240b
	ld hl,44975	; offset 0x240e
	push hl	; offset 0x240f
	ld hl,44975	; offset 0x2412
	push hl	; offset 0x2413
	ld hl,44975	; offset 0x2416
	push hl	; offset 0x2417
	ld hl,44975	; offset 0x241a
	push hl	; offset 0x241b
	; delay to get start of scanline (-144 T-states) at offset 0x241b


	; src_data blit 149
	ld sp,screenStartAddr+2624	; offset 0x241e
	ld hl,44975	; offset 0x2421
	push hl	; offset 0x2422
	ld hl,44975	; offset 0x2425
	push hl	; offset 0x2426
	ld hl,44975	; offset 0x2429
	push hl	; offset 0x242a
	ld hl,44975	; offset 0x242d
	push hl	; offset 0x242e
	ld hl,44975	; offset 0x2431
	push hl	; offset 0x2432
	ld hl,44975	; offset 0x2435
	push hl	; offset 0x2436
	ld hl,44975	; offset 0x2439
	push hl	; offset 0x243a
	ld hl,44975	; offset 0x243d
	push hl	; offset 0x243e
	; delay to get start of scanline (-144 T-states) at offset 0x243e


	; src_data blit 150
	ld sp,screenStartAddr+2864	; offset 0x2441
	ld hl,44975	; offset 0x2444
	push hl	; offset 0x2445
	ld hl,44975	; offset 0x2448
	push hl	; offset 0x2449
	ld hl,44975	; offset 0x244c
	push hl	; offset 0x244d
	ld hl,44975	; offset 0x2450
	push hl	; offset 0x2451
	ld hl,44975	; offset 0x2454
	push hl	; offset 0x2455
	ld hl,44975	; offset 0x2458
	push hl	; offset 0x2459
	ld hl,44975	; offset 0x245c
	push hl	; offset 0x245d
	ld hl,44975	; offset 0x2460
	push hl	; offset 0x2461
	; delay to get start of scanline (-144 T-states) at offset 0x2461


	; src_data blit 151
	ld sp,screenStartAddr+2880	; offset 0x2464
	ld hl,44975	; offset 0x2467
	push hl	; offset 0x2468
	ld hl,44975	; offset 0x246b
	push hl	; offset 0x246c
	ld hl,44975	; offset 0x246f
	push hl	; offset 0x2470
	ld hl,44975	; offset 0x2473
	push hl	; offset 0x2474
	ld hl,44975	; offset 0x2477
	push hl	; offset 0x2478
	ld hl,44975	; offset 0x247b
	push hl	; offset 0x247c
	ld hl,44975	; offset 0x247f
	push hl	; offset 0x2480
	ld hl,44975	; offset 0x2483
	push hl	; offset 0x2484
	; delay to get start of scanline (-144 T-states) at offset 0x2484


	; src_data blit 152
	ld sp,screenStartAddr+3120	; offset 0x2487
	ld hl,44975	; offset 0x248a
	push hl	; offset 0x248b
	ld hl,44975	; offset 0x248e
	push hl	; offset 0x248f
	ld hl,44975	; offset 0x2492
	push hl	; offset 0x2493
	ld hl,44975	; offset 0x2496
	push hl	; offset 0x2497
	ld hl,44975	; offset 0x249a
	push hl	; offset 0x249b
	ld hl,44975	; offset 0x249e
	push hl	; offset 0x249f
	ld hl,44975	; offset 0x24a2
	push hl	; offset 0x24a3
	ld hl,44975	; offset 0x24a6
	push hl	; offset 0x24a7
	; delay to get start of scanline (-144 T-states) at offset 0x24a7


	; src_data blit 153
	ld sp,screenStartAddr+3136	; offset 0x24aa
	ld hl,44975	; offset 0x24ad
	push hl	; offset 0x24ae
	ld hl,44975	; offset 0x24b1
	push hl	; offset 0x24b2
	ld hl,44975	; offset 0x24b5
	push hl	; offset 0x24b6
	ld hl,44975	; offset 0x24b9
	push hl	; offset 0x24ba
	ld hl,44975	; offset 0x24bd
	push hl	; offset 0x24be
	ld hl,44975	; offset 0x24c1
	push hl	; offset 0x24c2
	ld hl,44975	; offset 0x24c5
	push hl	; offset 0x24c6
	ld hl,44975	; offset 0x24c9
	push hl	; offset 0x24ca
	; delay to get start of scanline (-144 T-states) at offset 0x24ca


	; src_data blit 154
	ld sp,screenStartAddr+3376	; offset 0x24cd
	ld hl,44975	; offset 0x24d0
	push hl	; offset 0x24d1
	ld hl,44975	; offset 0x24d4
	push hl	; offset 0x24d5
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
	; delay to get start of scanline (-144 T-states) at offset 0x24ed


	; src_data blit 155
	ld sp,screenStartAddr+3392	; offset 0x24f0
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
	ld hl,44975	; offset 0x250b
	push hl	; offset 0x250c
	ld hl,44975	; offset 0x250f
	push hl	; offset 0x2510
	; delay to get start of scanline (-144 T-states) at offset 0x2510


	; src_data blit 156
	ld sp,screenStartAddr+3632	; offset 0x2513
	ld hl,44975	; offset 0x2516
	push hl	; offset 0x2517
	ld hl,44975	; offset 0x251a
	push hl	; offset 0x251b
	ld hl,44975	; offset 0x251e
	push hl	; offset 0x251f
	ld hl,44975	; offset 0x2522
	push hl	; offset 0x2523
	ld hl,44975	; offset 0x2526
	push hl	; offset 0x2527
	ld hl,44975	; offset 0x252a
	push hl	; offset 0x252b
	ld hl,44975	; offset 0x252e
	push hl	; offset 0x252f
	ld hl,44975	; offset 0x2532
	push hl	; offset 0x2533
	; delay to get start of scanline (-144 T-states) at offset 0x2533


	; src_data blit 157
	ld sp,screenStartAddr+3648	; offset 0x2536
	ld hl,44975	; offset 0x2539
	push hl	; offset 0x253a
	ld hl,44975	; offset 0x253d
	push hl	; offset 0x253e
	ld hl,44975	; offset 0x2541
	push hl	; offset 0x2542
	ld hl,44975	; offset 0x2545
	push hl	; offset 0x2546
	ld hl,44975	; offset 0x2549
	push hl	; offset 0x254a
	ld hl,44975	; offset 0x254d
	push hl	; offset 0x254e
	ld hl,44975	; offset 0x2551
	push hl	; offset 0x2552
	ld hl,44975	; offset 0x2555
	push hl	; offset 0x2556
	; delay to get start of scanline (-144 T-states) at offset 0x2556


	; src_data blit 158
	ld sp,screenStartAddr+3888	; offset 0x2559
	ld hl,44975	; offset 0x255c
	push hl	; offset 0x255d
	ld hl,44975	; offset 0x2560
	push hl	; offset 0x2561
	ld hl,44975	; offset 0x2564
	push hl	; offset 0x2565
	ld hl,44975	; offset 0x2568
	push hl	; offset 0x2569
	ld hl,44975	; offset 0x256c
	push hl	; offset 0x256d
	ld hl,44975	; offset 0x2570
	push hl	; offset 0x2571
	ld hl,44975	; offset 0x2574
	push hl	; offset 0x2575
	ld hl,44975	; offset 0x2578
	push hl	; offset 0x2579
	; delay to get start of scanline (-144 T-states) at offset 0x2579


	; src_data blit 159
	ld sp,screenStartAddr+3904	; offset 0x257c
	ld hl,44975	; offset 0x257f
	push hl	; offset 0x2580
	ld hl,44975	; offset 0x2583
	push hl	; offset 0x2584
	ld hl,44975	; offset 0x2587
	push hl	; offset 0x2588
	ld hl,44975	; offset 0x258b
	push hl	; offset 0x258c
	ld hl,44975	; offset 0x258f
	push hl	; offset 0x2590
	ld hl,44975	; offset 0x2593
	push hl	; offset 0x2594
	ld hl,44975	; offset 0x2597
	push hl	; offset 0x2598
	ld hl,44975	; offset 0x259b
	push hl	; offset 0x259c
	; delay to get start of scanline (-144 T-states) at offset 0x259c


	; src_data blit 160
	ld sp,screenStartAddr+2128	; offset 0x259f
	ld hl,44975	; offset 0x25a2
	push hl	; offset 0x25a3
	ld hl,44975	; offset 0x25a6
	push hl	; offset 0x25a7
	ld hl,44975	; offset 0x25aa
	push hl	; offset 0x25ab
	ld hl,44975	; offset 0x25ae
	push hl	; offset 0x25af
	ld hl,44975	; offset 0x25b2
	push hl	; offset 0x25b3
	ld hl,44975	; offset 0x25b6
	push hl	; offset 0x25b7
	ld hl,44975	; offset 0x25ba
	push hl	; offset 0x25bb
	ld hl,44975	; offset 0x25be
	push hl	; offset 0x25bf
	; delay to get start of scanline (-144 T-states) at offset 0x25bf


	; src_data blit 161
	ld sp,screenStartAddr+2144	; offset 0x25c2
	ld hl,44975	; offset 0x25c5
	push hl	; offset 0x25c6
	ld hl,44975	; offset 0x25c9
	push hl	; offset 0x25ca
	ld hl,44975	; offset 0x25cd
	push hl	; offset 0x25ce
	ld hl,44975	; offset 0x25d1
	push hl	; offset 0x25d2
	ld hl,44975	; offset 0x25d5
	push hl	; offset 0x25d6
	ld hl,44975	; offset 0x25d9
	push hl	; offset 0x25da
	ld hl,44975	; offset 0x25dd
	push hl	; offset 0x25de
	ld hl,44975	; offset 0x25e1
	push hl	; offset 0x25e2
	; delay to get start of scanline (-144 T-states) at offset 0x25e2


	; src_data blit 162
	ld sp,screenStartAddr+2384	; offset 0x25e5
	ld hl,44975	; offset 0x25e8
	push hl	; offset 0x25e9
	ld hl,44975	; offset 0x25ec
	push hl	; offset 0x25ed
	ld hl,44975	; offset 0x25f0
	push hl	; offset 0x25f1
	ld hl,44975	; offset 0x25f4
	push hl	; offset 0x25f5
	ld hl,44975	; offset 0x25f8
	push hl	; offset 0x25f9
	ld hl,44975	; offset 0x25fc
	push hl	; offset 0x25fd
	ld hl,44975	; offset 0x2600
	push hl	; offset 0x2601
	ld hl,44975	; offset 0x2604
	push hl	; offset 0x2605
	; delay to get start of scanline (-144 T-states) at offset 0x2605


	; src_data blit 163
	ld sp,screenStartAddr+2400	; offset 0x2608
	ld hl,44975	; offset 0x260b
	push hl	; offset 0x260c
	ld hl,44975	; offset 0x260f
	push hl	; offset 0x2610
	ld hl,44975	; offset 0x2613
	push hl	; offset 0x2614
	ld hl,44975	; offset 0x2617
	push hl	; offset 0x2618
	ld hl,44975	; offset 0x261b
	push hl	; offset 0x261c
	ld hl,44975	; offset 0x261f
	push hl	; offset 0x2620
	ld hl,44975	; offset 0x2623
	push hl	; offset 0x2624
	ld hl,44975	; offset 0x2627
	push hl	; offset 0x2628
	; delay to get start of scanline (-144 T-states) at offset 0x2628


	; src_data blit 164
	ld sp,screenStartAddr+2640	; offset 0x262b
	ld hl,44975	; offset 0x262e
	push hl	; offset 0x262f
	ld hl,44975	; offset 0x2632
	push hl	; offset 0x2633
	ld hl,44975	; offset 0x2636
	push hl	; offset 0x2637
	ld hl,44975	; offset 0x263a
	push hl	; offset 0x263b
	ld hl,44975	; offset 0x263e
	push hl	; offset 0x263f
	ld hl,44975	; offset 0x2642
	push hl	; offset 0x2643
	ld hl,44975	; offset 0x2646
	push hl	; offset 0x2647
	ld hl,44975	; offset 0x264a
	push hl	; offset 0x264b
	; delay to get start of scanline (-144 T-states) at offset 0x264b


	; src_data blit 165
	ld sp,screenStartAddr+2656	; offset 0x264e
	ld hl,44975	; offset 0x2651
	push hl	; offset 0x2652
	ld hl,44975	; offset 0x2655
	push hl	; offset 0x2656
	ld hl,44975	; offset 0x2659
	push hl	; offset 0x265a
	ld hl,44975	; offset 0x265d
	push hl	; offset 0x265e
	ld hl,44975	; offset 0x2661
	push hl	; offset 0x2662
	ld hl,44975	; offset 0x2665
	push hl	; offset 0x2666
	ld hl,44975	; offset 0x2669
	push hl	; offset 0x266a
	ld hl,44975	; offset 0x266d
	push hl	; offset 0x266e
	; delay to get start of scanline (-144 T-states) at offset 0x266e


	; src_data blit 166
	ld sp,screenStartAddr+2896	; offset 0x2671
	ld hl,44975	; offset 0x2674
	push hl	; offset 0x2675
	ld hl,44975	; offset 0x2678
	push hl	; offset 0x2679
	ld hl,44975	; offset 0x267c
	push hl	; offset 0x267d
	ld hl,44975	; offset 0x2680
	push hl	; offset 0x2681
	ld hl,44975	; offset 0x2684
	push hl	; offset 0x2685
	ld hl,44975	; offset 0x2688
	push hl	; offset 0x2689
	ld hl,44975	; offset 0x268c
	push hl	; offset 0x268d
	ld hl,44975	; offset 0x2690
	push hl	; offset 0x2691
	; delay to get start of scanline (-144 T-states) at offset 0x2691


	; src_data blit 167
	ld sp,screenStartAddr+2912	; offset 0x2694
	ld hl,44975	; offset 0x2697
	push hl	; offset 0x2698
	ld hl,44975	; offset 0x269b
	push hl	; offset 0x269c
	ld hl,44975	; offset 0x269f
	push hl	; offset 0x26a0
	ld hl,44975	; offset 0x26a3
	push hl	; offset 0x26a4
	ld hl,44975	; offset 0x26a7
	push hl	; offset 0x26a8
	ld hl,44975	; offset 0x26ab
	push hl	; offset 0x26ac
	ld hl,44975	; offset 0x26af
	push hl	; offset 0x26b0
	ld hl,44975	; offset 0x26b3
	push hl	; offset 0x26b4
	; delay to get start of scanline (-144 T-states) at offset 0x26b4


	; src_data blit 168
	ld sp,screenStartAddr+3152	; offset 0x26b7
	ld hl,44975	; offset 0x26ba
	push hl	; offset 0x26bb
	ld hl,44975	; offset 0x26be
	push hl	; offset 0x26bf
	ld hl,44975	; offset 0x26c2
	push hl	; offset 0x26c3
	ld hl,44975	; offset 0x26c6
	push hl	; offset 0x26c7
	ld hl,44975	; offset 0x26ca
	push hl	; offset 0x26cb
	ld hl,44975	; offset 0x26ce
	push hl	; offset 0x26cf
	ld hl,44975	; offset 0x26d2
	push hl	; offset 0x26d3
	ld hl,44975	; offset 0x26d6
	push hl	; offset 0x26d7
	; delay to get start of scanline (-144 T-states) at offset 0x26d7


	; src_data blit 169
	ld sp,screenStartAddr+3168	; offset 0x26da
	ld hl,44975	; offset 0x26dd
	push hl	; offset 0x26de
	ld hl,44975	; offset 0x26e1
	push hl	; offset 0x26e2
	ld hl,44975	; offset 0x26e5
	push hl	; offset 0x26e6
	ld hl,44975	; offset 0x26e9
	push hl	; offset 0x26ea
	ld hl,44975	; offset 0x26ed
	push hl	; offset 0x26ee
	ld hl,44975	; offset 0x26f1
	push hl	; offset 0x26f2
	ld hl,44975	; offset 0x26f5
	push hl	; offset 0x26f6
	ld hl,44975	; offset 0x26f9
	push hl	; offset 0x26fa
	; delay to get start of scanline (-144 T-states) at offset 0x26fa


	; src_data blit 170
	ld sp,screenStartAddr+3408	; offset 0x26fd
	ld hl,44975	; offset 0x2700
	push hl	; offset 0x2701
	ld hl,44975	; offset 0x2704
	push hl	; offset 0x2705
	ld hl,44975	; offset 0x2708
	push hl	; offset 0x2709
	ld hl,44975	; offset 0x270c
	push hl	; offset 0x270d
	ld hl,44975	; offset 0x2710
	push hl	; offset 0x2711
	ld hl,44975	; offset 0x2714
	push hl	; offset 0x2715
	ld hl,44975	; offset 0x2718
	push hl	; offset 0x2719
	ld hl,44975	; offset 0x271c
	push hl	; offset 0x271d
	; delay to get start of scanline (-144 T-states) at offset 0x271d


	; src_data blit 171
	ld sp,screenStartAddr+3424	; offset 0x2720
	ld hl,44975	; offset 0x2723
	push hl	; offset 0x2724
	ld hl,44975	; offset 0x2727
	push hl	; offset 0x2728
	ld hl,44975	; offset 0x272b
	push hl	; offset 0x272c
	ld hl,44975	; offset 0x272f
	push hl	; offset 0x2730
	ld hl,44975	; offset 0x2733
	push hl	; offset 0x2734
	ld hl,44975	; offset 0x2737
	push hl	; offset 0x2738
	ld hl,44975	; offset 0x273b
	push hl	; offset 0x273c
	ld hl,44975	; offset 0x273f
	push hl	; offset 0x2740
	; delay to get start of scanline (-144 T-states) at offset 0x2740


	; src_data blit 172
	ld sp,screenStartAddr+3664	; offset 0x2743
	ld hl,44975	; offset 0x2746
	push hl	; offset 0x2747
	ld hl,44975	; offset 0x274a
	push hl	; offset 0x274b
	ld hl,44975	; offset 0x274e
	push hl	; offset 0x274f
	ld hl,44975	; offset 0x2752
	push hl	; offset 0x2753
	ld hl,44975	; offset 0x2756
	push hl	; offset 0x2757
	ld hl,44975	; offset 0x275a
	push hl	; offset 0x275b
	ld hl,44975	; offset 0x275e
	push hl	; offset 0x275f
	ld hl,44975	; offset 0x2762
	push hl	; offset 0x2763
	; delay to get start of scanline (-144 T-states) at offset 0x2763


	; src_data blit 173
	ld sp,screenStartAddr+3680	; offset 0x2766
	ld hl,44975	; offset 0x2769
	push hl	; offset 0x276a
	ld hl,44975	; offset 0x276d
	push hl	; offset 0x276e
	ld hl,44975	; offset 0x2771
	push hl	; offset 0x2772
	ld hl,44975	; offset 0x2775
	push hl	; offset 0x2776
	ld hl,44975	; offset 0x2779
	push hl	; offset 0x277a
	ld hl,44975	; offset 0x277d
	push hl	; offset 0x277e
	ld hl,44975	; offset 0x2781
	push hl	; offset 0x2782
	ld hl,44975	; offset 0x2785
	push hl	; offset 0x2786
	; delay to get start of scanline (-144 T-states) at offset 0x2786


	; src_data blit 174
	ld sp,screenStartAddr+3920	; offset 0x2789
	ld hl,44975	; offset 0x278c
	push hl	; offset 0x278d
	ld hl,44975	; offset 0x2790
	push hl	; offset 0x2791
	ld hl,44975	; offset 0x2794
	push hl	; offset 0x2795
	ld hl,44975	; offset 0x2798
	push hl	; offset 0x2799
	ld hl,44975	; offset 0x279c
	push hl	; offset 0x279d
	ld hl,44975	; offset 0x27a0
	push hl	; offset 0x27a1
	ld hl,44975	; offset 0x27a4
	push hl	; offset 0x27a5
	ld hl,44975	; offset 0x27a8
	push hl	; offset 0x27a9
	; delay to get start of scanline (-144 T-states) at offset 0x27a9


	; src_data blit 175
	ld sp,screenStartAddr+3936	; offset 0x27ac
	ld hl,44975	; offset 0x27af
	push hl	; offset 0x27b0
	ld hl,44975	; offset 0x27b3
	push hl	; offset 0x27b4
	ld hl,44975	; offset 0x27b7
	push hl	; offset 0x27b8
	ld hl,44975	; offset 0x27bb
	push hl	; offset 0x27bc
	ld hl,44975	; offset 0x27bf
	push hl	; offset 0x27c0
	ld hl,44975	; offset 0x27c3
	push hl	; offset 0x27c4
	ld hl,44975	; offset 0x27c7
	push hl	; offset 0x27c8
	ld hl,44975	; offset 0x27cb
	push hl	; offset 0x27cc
	; delay to get start of scanline (-144 T-states) at offset 0x27cc


	; src_data blit 176
	ld sp,screenStartAddr+2160	; offset 0x27cf
	ld hl,44975	; offset 0x27d2
	push hl	; offset 0x27d3
	ld hl,44975	; offset 0x27d6
	push hl	; offset 0x27d7
	ld hl,44975	; offset 0x27da
	push hl	; offset 0x27db
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
	; delay to get start of scanline (-144 T-states) at offset 0x27ef


	; src_data blit 177
	ld sp,screenStartAddr+2176	; offset 0x27f2
	ld hl,44975	; offset 0x27f5
	push hl	; offset 0x27f6
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
	ld hl,44975	; offset 0x2811
	push hl	; offset 0x2812
	; delay to get start of scanline (-144 T-states) at offset 0x2812


	; src_data blit 178
	ld sp,screenStartAddr+2416	; offset 0x2815
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
	ld hl,44975	; offset 0x282c
	push hl	; offset 0x282d
	ld hl,44975	; offset 0x2830
	push hl	; offset 0x2831
	ld hl,44975	; offset 0x2834
	push hl	; offset 0x2835
	; delay to get start of scanline (-144 T-states) at offset 0x2835


	; src_data blit 179
	ld sp,screenStartAddr+2432	; offset 0x2838
	ld hl,44975	; offset 0x283b
	push hl	; offset 0x283c
	ld hl,44975	; offset 0x283f
	push hl	; offset 0x2840
	ld hl,44975	; offset 0x2843
	push hl	; offset 0x2844
	ld hl,44975	; offset 0x2847
	push hl	; offset 0x2848
	ld hl,44975	; offset 0x284b
	push hl	; offset 0x284c
	ld hl,44975	; offset 0x284f
	push hl	; offset 0x2850
	ld hl,44975	; offset 0x2853
	push hl	; offset 0x2854
	ld hl,44975	; offset 0x2857
	push hl	; offset 0x2858
	; delay to get start of scanline (-144 T-states) at offset 0x2858


	; src_data blit 180
	ld sp,screenStartAddr+2672	; offset 0x285b
	ld hl,44975	; offset 0x285e
	push hl	; offset 0x285f
	ld hl,44975	; offset 0x2862
	push hl	; offset 0x2863
	ld hl,44975	; offset 0x2866
	push hl	; offset 0x2867
	ld hl,44975	; offset 0x286a
	push hl	; offset 0x286b
	ld hl,44975	; offset 0x286e
	push hl	; offset 0x286f
	ld hl,44975	; offset 0x2872
	push hl	; offset 0x2873
	ld hl,44975	; offset 0x2876
	push hl	; offset 0x2877
	ld hl,44975	; offset 0x287a
	push hl	; offset 0x287b
	; delay to get start of scanline (-144 T-states) at offset 0x287b


	; src_data blit 181
	ld sp,screenStartAddr+2688	; offset 0x287e
	ld hl,44975	; offset 0x2881
	push hl	; offset 0x2882
	ld hl,44975	; offset 0x2885
	push hl	; offset 0x2886
	ld hl,44975	; offset 0x2889
	push hl	; offset 0x288a
	ld hl,44975	; offset 0x288d
	push hl	; offset 0x288e
	ld hl,44975	; offset 0x2891
	push hl	; offset 0x2892
	ld hl,44975	; offset 0x2895
	push hl	; offset 0x2896
	ld hl,44975	; offset 0x2899
	push hl	; offset 0x289a
	ld hl,44975	; offset 0x289d
	push hl	; offset 0x289e
	; delay to get start of scanline (-144 T-states) at offset 0x289e


	; src_data blit 182
	ld sp,screenStartAddr+2928	; offset 0x28a1
	ld hl,44975	; offset 0x28a4
	push hl	; offset 0x28a5
	ld hl,44975	; offset 0x28a8
	push hl	; offset 0x28a9
	ld hl,44975	; offset 0x28ac
	push hl	; offset 0x28ad
	ld hl,44975	; offset 0x28b0
	push hl	; offset 0x28b1
	ld hl,44975	; offset 0x28b4
	push hl	; offset 0x28b5
	ld hl,44975	; offset 0x28b8
	push hl	; offset 0x28b9
	ld hl,44975	; offset 0x28bc
	push hl	; offset 0x28bd
	ld hl,44975	; offset 0x28c0
	push hl	; offset 0x28c1
	; delay to get start of scanline (-144 T-states) at offset 0x28c1


	; src_data blit 183
	ld sp,screenStartAddr+2944	; offset 0x28c4
	ld hl,44975	; offset 0x28c7
	push hl	; offset 0x28c8
	ld hl,44975	; offset 0x28cb
	push hl	; offset 0x28cc
	ld hl,44975	; offset 0x28cf
	push hl	; offset 0x28d0
	ld hl,44975	; offset 0x28d3
	push hl	; offset 0x28d4
	ld hl,44975	; offset 0x28d7
	push hl	; offset 0x28d8
	ld hl,44975	; offset 0x28db
	push hl	; offset 0x28dc
	ld hl,44975	; offset 0x28df
	push hl	; offset 0x28e0
	ld hl,44975	; offset 0x28e3
	push hl	; offset 0x28e4
	; delay to get start of scanline (-144 T-states) at offset 0x28e4


	; src_data blit 184
	ld sp,screenStartAddr+3184	; offset 0x28e7
	ld hl,44975	; offset 0x28ea
	push hl	; offset 0x28eb
	ld hl,44975	; offset 0x28ee
	push hl	; offset 0x28ef
	ld hl,44975	; offset 0x28f2
	push hl	; offset 0x28f3
	ld hl,44975	; offset 0x28f6
	push hl	; offset 0x28f7
	ld hl,44975	; offset 0x28fa
	push hl	; offset 0x28fb
	ld hl,44975	; offset 0x28fe
	push hl	; offset 0x28ff
	ld hl,44975	; offset 0x2902
	push hl	; offset 0x2903
	ld hl,44975	; offset 0x2906
	push hl	; offset 0x2907
	; delay to get start of scanline (-144 T-states) at offset 0x2907


	; src_data blit 185
	ld sp,screenStartAddr+3200	; offset 0x290a
	ld hl,44975	; offset 0x290d
	push hl	; offset 0x290e
	ld hl,44975	; offset 0x2911
	push hl	; offset 0x2912
	ld hl,44975	; offset 0x2915
	push hl	; offset 0x2916
	ld hl,44975	; offset 0x2919
	push hl	; offset 0x291a
	ld hl,44975	; offset 0x291d
	push hl	; offset 0x291e
	ld hl,44975	; offset 0x2921
	push hl	; offset 0x2922
	ld hl,44975	; offset 0x2925
	push hl	; offset 0x2926
	ld hl,44975	; offset 0x2929
	push hl	; offset 0x292a
	; delay to get start of scanline (-144 T-states) at offset 0x292a


	; src_data blit 186
	ld sp,screenStartAddr+3440	; offset 0x292d
	ld hl,44975	; offset 0x2930
	push hl	; offset 0x2931
	ld hl,44975	; offset 0x2934
	push hl	; offset 0x2935
	ld hl,44975	; offset 0x2938
	push hl	; offset 0x2939
	ld hl,44975	; offset 0x293c
	push hl	; offset 0x293d
	ld hl,44975	; offset 0x2940
	push hl	; offset 0x2941
	ld hl,44975	; offset 0x2944
	push hl	; offset 0x2945
	ld hl,44975	; offset 0x2948
	push hl	; offset 0x2949
	ld hl,44975	; offset 0x294c
	push hl	; offset 0x294d
	; delay to get start of scanline (-144 T-states) at offset 0x294d


	; src_data blit 187
	ld sp,screenStartAddr+3456	; offset 0x2950
	ld hl,44975	; offset 0x2953
	push hl	; offset 0x2954
	ld hl,44975	; offset 0x2957
	push hl	; offset 0x2958
	ld hl,44975	; offset 0x295b
	push hl	; offset 0x295c
	ld hl,44975	; offset 0x295f
	push hl	; offset 0x2960
	ld hl,44975	; offset 0x2963
	push hl	; offset 0x2964
	ld hl,44975	; offset 0x2967
	push hl	; offset 0x2968
	ld hl,44975	; offset 0x296b
	push hl	; offset 0x296c
	ld hl,44975	; offset 0x296f
	push hl	; offset 0x2970
	; delay to get start of scanline (-144 T-states) at offset 0x2970


	; src_data blit 188
	ld sp,screenStartAddr+3696	; offset 0x2973
	ld hl,44975	; offset 0x2976
	push hl	; offset 0x2977
	ld hl,44975	; offset 0x297a
	push hl	; offset 0x297b
	ld hl,44975	; offset 0x297e
	push hl	; offset 0x297f
	ld hl,44975	; offset 0x2982
	push hl	; offset 0x2983
	ld hl,44975	; offset 0x2986
	push hl	; offset 0x2987
	ld hl,44975	; offset 0x298a
	push hl	; offset 0x298b
	ld hl,44975	; offset 0x298e
	push hl	; offset 0x298f
	ld hl,44975	; offset 0x2992
	push hl	; offset 0x2993
	; delay to get start of scanline (-144 T-states) at offset 0x2993


	; src_data blit 189
	ld sp,screenStartAddr+3712	; offset 0x2996
	ld hl,44975	; offset 0x2999
	push hl	; offset 0x299a
	ld hl,44975	; offset 0x299d
	push hl	; offset 0x299e
	ld hl,44975	; offset 0x29a1
	push hl	; offset 0x29a2
	ld hl,44975	; offset 0x29a5
	push hl	; offset 0x29a6
	ld hl,44975	; offset 0x29a9
	push hl	; offset 0x29aa
	ld hl,44975	; offset 0x29ad
	push hl	; offset 0x29ae
	ld hl,44975	; offset 0x29b1
	push hl	; offset 0x29b2
	ld hl,44975	; offset 0x29b5
	push hl	; offset 0x29b6
	; delay to get start of scanline (-144 T-states) at offset 0x29b6


	; src_data blit 190
	ld sp,screenStartAddr+3952	; offset 0x29b9
	ld hl,44975	; offset 0x29bc
	push hl	; offset 0x29bd
	ld hl,44975	; offset 0x29c0
	push hl	; offset 0x29c1
	ld hl,44975	; offset 0x29c4
	push hl	; offset 0x29c5
	ld hl,44975	; offset 0x29c8
	push hl	; offset 0x29c9
	ld hl,44975	; offset 0x29cc
	push hl	; offset 0x29cd
	ld hl,44975	; offset 0x29d0
	push hl	; offset 0x29d1
	ld hl,44975	; offset 0x29d4
	push hl	; offset 0x29d5
	ld hl,44975	; offset 0x29d8
	push hl	; offset 0x29d9
	; delay to get start of scanline (-144 T-states) at offset 0x29d9


	; src_data blit 191
	ld sp,screenStartAddr+3968	; offset 0x29dc
	ld hl,44975	; offset 0x29df
	push hl	; offset 0x29e0
	ld hl,44975	; offset 0x29e3
	push hl	; offset 0x29e4
	ld hl,44975	; offset 0x29e7
	push hl	; offset 0x29e8
	ld hl,44975	; offset 0x29eb
	push hl	; offset 0x29ec
	ld hl,44975	; offset 0x29ef
	push hl	; offset 0x29f0
	ld hl,44975	; offset 0x29f3
	push hl	; offset 0x29f4
	ld hl,44975	; offset 0x29f7
	push hl	; offset 0x29f8
	ld hl,44975	; offset 0x29fb
	push hl	; offset 0x29fc
	; delay to get start of scanline (-144 T-states) at offset 0x29fc


	; src_data blit 192
	ld sp,screenStartAddr+2192	; offset 0x29ff
	ld hl,44975	; offset 0x2a02
	push hl	; offset 0x2a03
	ld hl,44975	; offset 0x2a06
	push hl	; offset 0x2a07
	ld hl,44975	; offset 0x2a0a
	push hl	; offset 0x2a0b
	ld hl,44975	; offset 0x2a0e
	push hl	; offset 0x2a0f
	ld hl,44975	; offset 0x2a12
	push hl	; offset 0x2a13
	ld hl,44975	; offset 0x2a16
	push hl	; offset 0x2a17
	ld hl,44975	; offset 0x2a1a
	push hl	; offset 0x2a1b
	ld hl,44975	; offset 0x2a1e
	push hl	; offset 0x2a1f
	; delay to get start of scanline (-144 T-states) at offset 0x2a1f


	; src_data blit 193
	ld sp,screenStartAddr+2208	; offset 0x2a22
	ld hl,44975	; offset 0x2a25
	push hl	; offset 0x2a26
	ld hl,44975	; offset 0x2a29
	push hl	; offset 0x2a2a
	ld hl,44975	; offset 0x2a2d
	push hl	; offset 0x2a2e
	ld hl,44975	; offset 0x2a31
	push hl	; offset 0x2a32
	ld hl,44975	; offset 0x2a35
	push hl	; offset 0x2a36
	ld hl,44975	; offset 0x2a39
	push hl	; offset 0x2a3a
	ld hl,44975	; offset 0x2a3d
	push hl	; offset 0x2a3e
	ld hl,44975	; offset 0x2a41
	push hl	; offset 0x2a42
	; delay to get start of scanline (-144 T-states) at offset 0x2a42


	; src_data blit 194
	ld sp,screenStartAddr+2448	; offset 0x2a45
	ld hl,44975	; offset 0x2a48
	push hl	; offset 0x2a49
	ld hl,44975	; offset 0x2a4c
	push hl	; offset 0x2a4d
	ld hl,44975	; offset 0x2a50
	push hl	; offset 0x2a51
	ld hl,44975	; offset 0x2a54
	push hl	; offset 0x2a55
	ld hl,44975	; offset 0x2a58
	push hl	; offset 0x2a59
	ld hl,44975	; offset 0x2a5c
	push hl	; offset 0x2a5d
	ld hl,44975	; offset 0x2a60
	push hl	; offset 0x2a61
	ld hl,44975	; offset 0x2a64
	push hl	; offset 0x2a65
	; delay to get start of scanline (-144 T-states) at offset 0x2a65


	; src_data blit 195
	ld sp,screenStartAddr+2464	; offset 0x2a68
	ld hl,44975	; offset 0x2a6b
	push hl	; offset 0x2a6c
	ld hl,44975	; offset 0x2a6f
	push hl	; offset 0x2a70
	ld hl,44975	; offset 0x2a73
	push hl	; offset 0x2a74
	ld hl,44975	; offset 0x2a77
	push hl	; offset 0x2a78
	ld hl,44975	; offset 0x2a7b
	push hl	; offset 0x2a7c
	ld hl,44975	; offset 0x2a7f
	push hl	; offset 0x2a80
	ld hl,44975	; offset 0x2a83
	push hl	; offset 0x2a84
	ld hl,44975	; offset 0x2a87
	push hl	; offset 0x2a88
	; delay to get start of scanline (-144 T-states) at offset 0x2a88


	; src_data blit 196
	ld sp,screenStartAddr+2704	; offset 0x2a8b
	ld hl,44975	; offset 0x2a8e
	push hl	; offset 0x2a8f
	ld hl,44975	; offset 0x2a92
	push hl	; offset 0x2a93
	ld hl,44975	; offset 0x2a96
	push hl	; offset 0x2a97
	ld hl,44975	; offset 0x2a9a
	push hl	; offset 0x2a9b
	ld hl,44975	; offset 0x2a9e
	push hl	; offset 0x2a9f
	ld hl,44975	; offset 0x2aa2
	push hl	; offset 0x2aa3
	ld hl,44975	; offset 0x2aa6
	push hl	; offset 0x2aa7
	ld hl,44975	; offset 0x2aaa
	push hl	; offset 0x2aab
	; delay to get start of scanline (-144 T-states) at offset 0x2aab


	; src_data blit 197
	ld sp,screenStartAddr+2720	; offset 0x2aae
	ld hl,44975	; offset 0x2ab1
	push hl	; offset 0x2ab2
	ld hl,44975	; offset 0x2ab5
	push hl	; offset 0x2ab6
	ld hl,44975	; offset 0x2ab9
	push hl	; offset 0x2aba
	ld hl,44975	; offset 0x2abd
	push hl	; offset 0x2abe
	ld hl,44975	; offset 0x2ac1
	push hl	; offset 0x2ac2
	ld hl,44975	; offset 0x2ac5
	push hl	; offset 0x2ac6
	ld hl,44975	; offset 0x2ac9
	push hl	; offset 0x2aca
	ld hl,44975	; offset 0x2acd
	push hl	; offset 0x2ace
	; delay to get start of scanline (-144 T-states) at offset 0x2ace


	; src_data blit 198
	ld sp,screenStartAddr+2960	; offset 0x2ad1
	ld hl,44975	; offset 0x2ad4
	push hl	; offset 0x2ad5
	ld hl,44975	; offset 0x2ad8
	push hl	; offset 0x2ad9
	ld hl,44975	; offset 0x2adc
	push hl	; offset 0x2add
	ld hl,44975	; offset 0x2ae0
	push hl	; offset 0x2ae1
	ld hl,44975	; offset 0x2ae4
	push hl	; offset 0x2ae5
	ld hl,44975	; offset 0x2ae8
	push hl	; offset 0x2ae9
	ld hl,44975	; offset 0x2aec
	push hl	; offset 0x2aed
	ld hl,44975	; offset 0x2af0
	push hl	; offset 0x2af1
	; delay to get start of scanline (-144 T-states) at offset 0x2af1


	; src_data blit 199
	ld sp,screenStartAddr+2976	; offset 0x2af4
	ld hl,44975	; offset 0x2af7
	push hl	; offset 0x2af8
	ld hl,44975	; offset 0x2afb
	push hl	; offset 0x2afc
	ld hl,44975	; offset 0x2aff
	push hl	; offset 0x2b00
	ld hl,44975	; offset 0x2b03
	push hl	; offset 0x2b04
	ld hl,44975	; offset 0x2b07
	push hl	; offset 0x2b08
	ld hl,44975	; offset 0x2b0b
	push hl	; offset 0x2b0c
	ld hl,44975	; offset 0x2b0f
	push hl	; offset 0x2b10
	ld hl,44975	; offset 0x2b13
	push hl	; offset 0x2b14
	; delay to get start of scanline (-144 T-states) at offset 0x2b14


	; src_data blit 200
	ld sp,screenStartAddr+3216	; offset 0x2b17
	ld hl,44975	; offset 0x2b1a
	push hl	; offset 0x2b1b
	ld hl,44975	; offset 0x2b1e
	push hl	; offset 0x2b1f
	ld hl,44975	; offset 0x2b22
	push hl	; offset 0x2b23
	ld hl,44975	; offset 0x2b26
	push hl	; offset 0x2b27
	ld hl,44975	; offset 0x2b2a
	push hl	; offset 0x2b2b
	ld hl,44975	; offset 0x2b2e
	push hl	; offset 0x2b2f
	ld hl,44975	; offset 0x2b32
	push hl	; offset 0x2b33
	ld hl,44975	; offset 0x2b36
	push hl	; offset 0x2b37
	; delay to get start of scanline (-144 T-states) at offset 0x2b37


	; src_data blit 201
	ld sp,screenStartAddr+3232	; offset 0x2b3a
	ld hl,44975	; offset 0x2b3d
	push hl	; offset 0x2b3e
	ld hl,44975	; offset 0x2b41
	push hl	; offset 0x2b42
	ld hl,44975	; offset 0x2b45
	push hl	; offset 0x2b46
	ld hl,44975	; offset 0x2b49
	push hl	; offset 0x2b4a
	ld hl,44975	; offset 0x2b4d
	push hl	; offset 0x2b4e
	ld hl,44975	; offset 0x2b51
	push hl	; offset 0x2b52
	ld hl,44975	; offset 0x2b55
	push hl	; offset 0x2b56
	ld hl,44975	; offset 0x2b59
	push hl	; offset 0x2b5a
	; delay to get start of scanline (-144 T-states) at offset 0x2b5a


	; src_data blit 202
	ld sp,screenStartAddr+3472	; offset 0x2b5d
	ld hl,44975	; offset 0x2b60
	push hl	; offset 0x2b61
	ld hl,44975	; offset 0x2b64
	push hl	; offset 0x2b65
	ld hl,44975	; offset 0x2b68
	push hl	; offset 0x2b69
	ld hl,44975	; offset 0x2b6c
	push hl	; offset 0x2b6d
	ld hl,44975	; offset 0x2b70
	push hl	; offset 0x2b71
	ld hl,44975	; offset 0x2b74
	push hl	; offset 0x2b75
	ld hl,44975	; offset 0x2b78
	push hl	; offset 0x2b79
	ld hl,44975	; offset 0x2b7c
	push hl	; offset 0x2b7d
	; delay to get start of scanline (-144 T-states) at offset 0x2b7d

	; Jump to second half of frame render (normally jumps back to pop_push_even, and MCU swaps 	; buffer pointer so new command list exists in same memory space)
	ld a,(0x3ffd)	; This informs ROM we need the bank for the second half of the screen (racing the beam)
	jp fake_jmp
fake_jmp:
	; Block attribute blit start
	ld sp,attrStartAddr+768	; Set sp to end of attr memory - code offset 0x2b83

	ld hl,3662	; src offset 766, code offset 0x2b86
	push hl		; code offset 0x2b87
	ld hl,3662	; src offset 764, code offset 0x2b8a
	push hl		; code offset 0x2b8b
	ld hl,3662	; src offset 762, code offset 0x2b8e
	push hl		; code offset 0x2b8f
	ld hl,3662	; src offset 760, code offset 0x2b92
	push hl		; code offset 0x2b93
	ld hl,3662	; src offset 758, code offset 0x2b96
	push hl		; code offset 0x2b97
	ld hl,3662	; src offset 756, code offset 0x2b9a
	push hl		; code offset 0x2b9b
	ld hl,3662	; src offset 754, code offset 0x2b9e
	push hl		; code offset 0x2b9f
	ld hl,3662	; src offset 752, code offset 0x2ba2
	push hl		; code offset 0x2ba3
	ld hl,3662	; src offset 750, code offset 0x2ba6
	push hl		; code offset 0x2ba7
	ld hl,3662	; src offset 748, code offset 0x2baa
	push hl		; code offset 0x2bab
	ld hl,3662	; src offset 746, code offset 0x2bae
	push hl		; code offset 0x2baf
	ld hl,3662	; src offset 744, code offset 0x2bb2
	push hl		; code offset 0x2bb3
	ld hl,3662	; src offset 742, code offset 0x2bb6
	push hl		; code offset 0x2bb7
	ld hl,3662	; src offset 740, code offset 0x2bba
	push hl		; code offset 0x2bbb
	ld hl,3662	; src offset 738, code offset 0x2bbe
	push hl		; code offset 0x2bbf
	ld hl,3662	; src offset 736, code offset 0x2bc2
	push hl		; code offset 0x2bc3
	ld hl,3662	; src offset 734, code offset 0x2bc6
	push hl		; code offset 0x2bc7
	ld hl,3662	; src offset 732, code offset 0x2bca
	push hl		; code offset 0x2bcb
	ld hl,3662	; src offset 730, code offset 0x2bce
	push hl		; code offset 0x2bcf
	ld hl,3662	; src offset 728, code offset 0x2bd2
	push hl		; code offset 0x2bd3
	ld hl,3662	; src offset 726, code offset 0x2bd6
	push hl		; code offset 0x2bd7
	ld hl,3662	; src offset 724, code offset 0x2bda
	push hl		; code offset 0x2bdb
	ld hl,3662	; src offset 722, code offset 0x2bde
	push hl		; code offset 0x2bdf
	ld hl,3662	; src offset 720, code offset 0x2be2
	push hl		; code offset 0x2be3
	ld hl,3662	; src offset 718, code offset 0x2be6
	push hl		; code offset 0x2be7
	ld hl,3662	; src offset 716, code offset 0x2bea
	push hl		; code offset 0x2beb
	ld hl,3662	; src offset 714, code offset 0x2bee
	push hl		; code offset 0x2bef
	ld hl,3662	; src offset 712, code offset 0x2bf2
	push hl		; code offset 0x2bf3
	ld hl,3662	; src offset 710, code offset 0x2bf6
	push hl		; code offset 0x2bf7
	ld hl,3662	; src offset 708, code offset 0x2bfa
	push hl		; code offset 0x2bfb
	ld hl,3662	; src offset 706, code offset 0x2bfe
	push hl		; code offset 0x2bff
	ld hl,3662	; src offset 704, code offset 0x2c02
	push hl		; code offset 0x2c03
	ld hl,3662	; src offset 702, code offset 0x2c06
	push hl		; code offset 0x2c07
	ld hl,3662	; src offset 700, code offset 0x2c0a
	push hl		; code offset 0x2c0b
	ld hl,3662	; src offset 698, code offset 0x2c0e
	push hl		; code offset 0x2c0f
	ld hl,3662	; src offset 696, code offset 0x2c12
	push hl		; code offset 0x2c13
	ld hl,3662	; src offset 694, code offset 0x2c16
	push hl		; code offset 0x2c17
	ld hl,3662	; src offset 692, code offset 0x2c1a
	push hl		; code offset 0x2c1b
	ld hl,3662	; src offset 690, code offset 0x2c1e
	push hl		; code offset 0x2c1f
	ld hl,3662	; src offset 688, code offset 0x2c22
	push hl		; code offset 0x2c23
	ld hl,3662	; src offset 686, code offset 0x2c26
	push hl		; code offset 0x2c27
	ld hl,3662	; src offset 684, code offset 0x2c2a
	push hl		; code offset 0x2c2b
	ld hl,3662	; src offset 682, code offset 0x2c2e
	push hl		; code offset 0x2c2f
	ld hl,3662	; src offset 680, code offset 0x2c32
	push hl		; code offset 0x2c33
	ld hl,3662	; src offset 678, code offset 0x2c36
	push hl		; code offset 0x2c37
	ld hl,3662	; src offset 676, code offset 0x2c3a
	push hl		; code offset 0x2c3b
	ld hl,3662	; src offset 674, code offset 0x2c3e
	push hl		; code offset 0x2c3f
	ld hl,3662	; src offset 672, code offset 0x2c42
	push hl		; code offset 0x2c43
	ld hl,3662	; src offset 670, code offset 0x2c46
	push hl		; code offset 0x2c47
	ld hl,3662	; src offset 668, code offset 0x2c4a
	push hl		; code offset 0x2c4b
	ld hl,3662	; src offset 666, code offset 0x2c4e
	push hl		; code offset 0x2c4f
	ld hl,3662	; src offset 664, code offset 0x2c52
	push hl		; code offset 0x2c53
	ld hl,3662	; src offset 662, code offset 0x2c56
	push hl		; code offset 0x2c57
	ld hl,3662	; src offset 660, code offset 0x2c5a
	push hl		; code offset 0x2c5b
	ld hl,3662	; src offset 658, code offset 0x2c5e
	push hl		; code offset 0x2c5f
	ld hl,3662	; src offset 656, code offset 0x2c62
	push hl		; code offset 0x2c63
	ld hl,3662	; src offset 654, code offset 0x2c66
	push hl		; code offset 0x2c67
	ld hl,3662	; src offset 652, code offset 0x2c6a
	push hl		; code offset 0x2c6b
	ld hl,3662	; src offset 650, code offset 0x2c6e
	push hl		; code offset 0x2c6f
	ld hl,3662	; src offset 648, code offset 0x2c72
	push hl		; code offset 0x2c73
	ld hl,3662	; src offset 646, code offset 0x2c76
	push hl		; code offset 0x2c77
	ld hl,3662	; src offset 644, code offset 0x2c7a
	push hl		; code offset 0x2c7b
	ld hl,3662	; src offset 642, code offset 0x2c7e
	push hl		; code offset 0x2c7f
	ld hl,3662	; src offset 640, code offset 0x2c82
	push hl		; code offset 0x2c83
	ld hl,3662	; src offset 638, code offset 0x2c86
	push hl		; code offset 0x2c87
	ld hl,3662	; src offset 636, code offset 0x2c8a
	push hl		; code offset 0x2c8b
	ld hl,3662	; src offset 634, code offset 0x2c8e
	push hl		; code offset 0x2c8f
	ld hl,3662	; src offset 632, code offset 0x2c92
	push hl		; code offset 0x2c93
	ld hl,3662	; src offset 630, code offset 0x2c96
	push hl		; code offset 0x2c97
	ld hl,3662	; src offset 628, code offset 0x2c9a
	push hl		; code offset 0x2c9b
	ld hl,3662	; src offset 626, code offset 0x2c9e
	push hl		; code offset 0x2c9f
	ld hl,3662	; src offset 624, code offset 0x2ca2
	push hl		; code offset 0x2ca3
	ld hl,3662	; src offset 622, code offset 0x2ca6
	push hl		; code offset 0x2ca7
	ld hl,3662	; src offset 620, code offset 0x2caa
	push hl		; code offset 0x2cab
	ld hl,3662	; src offset 618, code offset 0x2cae
	push hl		; code offset 0x2caf
	ld hl,3662	; src offset 616, code offset 0x2cb2
	push hl		; code offset 0x2cb3
	ld hl,3662	; src offset 614, code offset 0x2cb6
	push hl		; code offset 0x2cb7
	ld hl,3662	; src offset 612, code offset 0x2cba
	push hl		; code offset 0x2cbb
	ld hl,3662	; src offset 610, code offset 0x2cbe
	push hl		; code offset 0x2cbf
	ld hl,3662	; src offset 608, code offset 0x2cc2
	push hl		; code offset 0x2cc3
	ld hl,3662	; src offset 606, code offset 0x2cc6
	push hl		; code offset 0x2cc7
	ld hl,3662	; src offset 604, code offset 0x2cca
	push hl		; code offset 0x2ccb
	ld hl,3662	; src offset 602, code offset 0x2cce
	push hl		; code offset 0x2ccf
	ld hl,3662	; src offset 600, code offset 0x2cd2
	push hl		; code offset 0x2cd3
	ld hl,3662	; src offset 598, code offset 0x2cd6
	push hl		; code offset 0x2cd7
	ld hl,3662	; src offset 596, code offset 0x2cda
	push hl		; code offset 0x2cdb
	ld hl,3662	; src offset 594, code offset 0x2cde
	push hl		; code offset 0x2cdf
	ld hl,3662	; src offset 592, code offset 0x2ce2
	push hl		; code offset 0x2ce3
	ld hl,3662	; src offset 590, code offset 0x2ce6
	push hl		; code offset 0x2ce7
	ld hl,3662	; src offset 588, code offset 0x2cea
	push hl		; code offset 0x2ceb
	ld hl,3662	; src offset 586, code offset 0x2cee
	push hl		; code offset 0x2cef
	ld hl,3662	; src offset 584, code offset 0x2cf2
	push hl		; code offset 0x2cf3
	ld hl,3662	; src offset 582, code offset 0x2cf6
	push hl		; code offset 0x2cf7
	ld hl,3662	; src offset 580, code offset 0x2cfa
	push hl		; code offset 0x2cfb
	ld hl,3662	; src offset 578, code offset 0x2cfe
	push hl		; code offset 0x2cff
	ld hl,3662	; src offset 576, code offset 0x2d02
	push hl		; code offset 0x2d03
	ld hl,3662	; src offset 574, code offset 0x2d06
	push hl		; code offset 0x2d07
	ld hl,3662	; src offset 572, code offset 0x2d0a
	push hl		; code offset 0x2d0b
	ld hl,3662	; src offset 570, code offset 0x2d0e
	push hl		; code offset 0x2d0f
	ld hl,3662	; src offset 568, code offset 0x2d12
	push hl		; code offset 0x2d13
	ld hl,3662	; src offset 566, code offset 0x2d16
	push hl		; code offset 0x2d17
	ld hl,3662	; src offset 564, code offset 0x2d1a
	push hl		; code offset 0x2d1b
	ld hl,3662	; src offset 562, code offset 0x2d1e
	push hl		; code offset 0x2d1f
	ld hl,3662	; src offset 560, code offset 0x2d22
	push hl		; code offset 0x2d23
	ld hl,3662	; src offset 558, code offset 0x2d26
	push hl		; code offset 0x2d27
	ld hl,3662	; src offset 556, code offset 0x2d2a
	push hl		; code offset 0x2d2b
	ld hl,3662	; src offset 554, code offset 0x2d2e
	push hl		; code offset 0x2d2f
	ld hl,3662	; src offset 552, code offset 0x2d32
	push hl		; code offset 0x2d33
	ld hl,3662	; src offset 550, code offset 0x2d36
	push hl		; code offset 0x2d37
	ld hl,3662	; src offset 548, code offset 0x2d3a
	push hl		; code offset 0x2d3b
	ld hl,3662	; src offset 546, code offset 0x2d3e
	push hl		; code offset 0x2d3f
	ld hl,3662	; src offset 544, code offset 0x2d42
	push hl		; code offset 0x2d43
	ld hl,3662	; src offset 542, code offset 0x2d46
	push hl		; code offset 0x2d47
	ld hl,3662	; src offset 540, code offset 0x2d4a
	push hl		; code offset 0x2d4b
	ld hl,3662	; src offset 538, code offset 0x2d4e
	push hl		; code offset 0x2d4f
	ld hl,3662	; src offset 536, code offset 0x2d52
	push hl		; code offset 0x2d53
	ld hl,3662	; src offset 534, code offset 0x2d56
	push hl		; code offset 0x2d57
	ld hl,3662	; src offset 532, code offset 0x2d5a
	push hl		; code offset 0x2d5b
	ld hl,3662	; src offset 530, code offset 0x2d5e
	push hl		; code offset 0x2d5f
	ld hl,3662	; src offset 528, code offset 0x2d62
	push hl		; code offset 0x2d63
	ld hl,3662	; src offset 526, code offset 0x2d66
	push hl		; code offset 0x2d67
	ld hl,3662	; src offset 524, code offset 0x2d6a
	push hl		; code offset 0x2d6b
	ld hl,3662	; src offset 522, code offset 0x2d6e
	push hl		; code offset 0x2d6f
	ld hl,3662	; src offset 520, code offset 0x2d72
	push hl		; code offset 0x2d73
	ld hl,3662	; src offset 518, code offset 0x2d76
	push hl		; code offset 0x2d77
	ld hl,3662	; src offset 516, code offset 0x2d7a
	push hl		; code offset 0x2d7b
	ld hl,3662	; src offset 514, code offset 0x2d7e
	push hl		; code offset 0x2d7f
	ld hl,3662	; src offset 512, code offset 0x2d82
	push hl		; code offset 0x2d83
	ld hl,3662	; src offset 510, code offset 0x2d86
	push hl		; code offset 0x2d87
	ld hl,3662	; src offset 508, code offset 0x2d8a
	push hl		; code offset 0x2d8b
	ld hl,3662	; src offset 506, code offset 0x2d8e
	push hl		; code offset 0x2d8f
	ld hl,3662	; src offset 504, code offset 0x2d92
	push hl		; code offset 0x2d93
	ld hl,3662	; src offset 502, code offset 0x2d96
	push hl		; code offset 0x2d97
	ld hl,3662	; src offset 500, code offset 0x2d9a
	push hl		; code offset 0x2d9b
	ld hl,3662	; src offset 498, code offset 0x2d9e
	push hl		; code offset 0x2d9f
	ld hl,3662	; src offset 496, code offset 0x2da2
	push hl		; code offset 0x2da3
	ld hl,3662	; src offset 494, code offset 0x2da6
	push hl		; code offset 0x2da7
	ld hl,3662	; src offset 492, code offset 0x2daa
	push hl		; code offset 0x2dab
	ld hl,3662	; src offset 490, code offset 0x2dae
	push hl		; code offset 0x2daf
	ld hl,3662	; src offset 488, code offset 0x2db2
	push hl		; code offset 0x2db3
	ld hl,3662	; src offset 486, code offset 0x2db6
	push hl		; code offset 0x2db7
	ld hl,3662	; src offset 484, code offset 0x2dba
	push hl		; code offset 0x2dbb
	ld hl,3662	; src offset 482, code offset 0x2dbe
	push hl		; code offset 0x2dbf
	ld hl,3662	; src offset 480, code offset 0x2dc2
	push hl		; code offset 0x2dc3
	ld hl,3662	; src offset 478, code offset 0x2dc6
	push hl		; code offset 0x2dc7
	ld hl,3662	; src offset 476, code offset 0x2dca
	push hl		; code offset 0x2dcb
	ld hl,3662	; src offset 474, code offset 0x2dce
	push hl		; code offset 0x2dcf
	ld hl,3662	; src offset 472, code offset 0x2dd2
	push hl		; code offset 0x2dd3
	ld hl,3662	; src offset 470, code offset 0x2dd6
	push hl		; code offset 0x2dd7
	ld hl,3662	; src offset 468, code offset 0x2dda
	push hl		; code offset 0x2ddb
	ld hl,3662	; src offset 466, code offset 0x2dde
	push hl		; code offset 0x2ddf
	ld hl,3662	; src offset 464, code offset 0x2de2
	push hl		; code offset 0x2de3
	ld hl,3662	; src offset 462, code offset 0x2de6
	push hl		; code offset 0x2de7
	ld hl,3662	; src offset 460, code offset 0x2dea
	push hl		; code offset 0x2deb
	ld hl,3662	; src offset 458, code offset 0x2dee
	push hl		; code offset 0x2def
	ld hl,3662	; src offset 456, code offset 0x2df2
	push hl		; code offset 0x2df3
	ld hl,3662	; src offset 454, code offset 0x2df6
	push hl		; code offset 0x2df7
	ld hl,3662	; src offset 452, code offset 0x2dfa
	push hl		; code offset 0x2dfb
	ld hl,3662	; src offset 450, code offset 0x2dfe
	push hl		; code offset 0x2dff
	ld hl,3662	; src offset 448, code offset 0x2e02
	push hl		; code offset 0x2e03
	ld hl,3662	; src offset 446, code offset 0x2e06
	push hl		; code offset 0x2e07
	ld hl,3662	; src offset 444, code offset 0x2e0a
	push hl		; code offset 0x2e0b
	ld hl,3662	; src offset 442, code offset 0x2e0e
	push hl		; code offset 0x2e0f
	ld hl,3662	; src offset 440, code offset 0x2e12
	push hl		; code offset 0x2e13
	ld hl,3662	; src offset 438, code offset 0x2e16
	push hl		; code offset 0x2e17
	ld hl,3662	; src offset 436, code offset 0x2e1a
	push hl		; code offset 0x2e1b
	ld hl,3662	; src offset 434, code offset 0x2e1e
	push hl		; code offset 0x2e1f
	ld hl,3662	; src offset 432, code offset 0x2e22
	push hl		; code offset 0x2e23
	ld hl,3662	; src offset 430, code offset 0x2e26
	push hl		; code offset 0x2e27
	ld hl,3662	; src offset 428, code offset 0x2e2a
	push hl		; code offset 0x2e2b
	ld hl,3662	; src offset 426, code offset 0x2e2e
	push hl		; code offset 0x2e2f
	ld hl,3662	; src offset 424, code offset 0x2e32
	push hl		; code offset 0x2e33
	ld hl,3662	; src offset 422, code offset 0x2e36
	push hl		; code offset 0x2e37
	ld hl,3662	; src offset 420, code offset 0x2e3a
	push hl		; code offset 0x2e3b
	ld hl,3662	; src offset 418, code offset 0x2e3e
	push hl		; code offset 0x2e3f
	ld hl,3662	; src offset 416, code offset 0x2e42
	push hl		; code offset 0x2e43
	ld hl,3662	; src offset 414, code offset 0x2e46
	push hl		; code offset 0x2e47
	ld hl,3662	; src offset 412, code offset 0x2e4a
	push hl		; code offset 0x2e4b
	ld hl,3662	; src offset 410, code offset 0x2e4e
	push hl		; code offset 0x2e4f
	ld hl,3662	; src offset 408, code offset 0x2e52
	push hl		; code offset 0x2e53
	ld hl,3662	; src offset 406, code offset 0x2e56
	push hl		; code offset 0x2e57
	ld hl,3662	; src offset 404, code offset 0x2e5a
	push hl		; code offset 0x2e5b
	ld hl,3662	; src offset 402, code offset 0x2e5e
	push hl		; code offset 0x2e5f
	ld hl,3662	; src offset 400, code offset 0x2e62
	push hl		; code offset 0x2e63
	ld hl,3662	; src offset 398, code offset 0x2e66
	push hl		; code offset 0x2e67
	ld hl,3662	; src offset 396, code offset 0x2e6a
	push hl		; code offset 0x2e6b
	ld hl,3662	; src offset 394, code offset 0x2e6e
	push hl		; code offset 0x2e6f
	ld hl,3662	; src offset 392, code offset 0x2e72
	push hl		; code offset 0x2e73
	ld hl,3662	; src offset 390, code offset 0x2e76
	push hl		; code offset 0x2e77
	ld hl,3662	; src offset 388, code offset 0x2e7a
	push hl		; code offset 0x2e7b
	ld hl,3662	; src offset 386, code offset 0x2e7e
	push hl		; code offset 0x2e7f
	ld hl,3662	; src offset 384, code offset 0x2e82
	push hl		; code offset 0x2e83
	ld hl,3662	; src offset 382, code offset 0x2e86
	push hl		; code offset 0x2e87
	ld hl,3662	; src offset 380, code offset 0x2e8a
	push hl		; code offset 0x2e8b
	ld hl,3662	; src offset 378, code offset 0x2e8e
	push hl		; code offset 0x2e8f
	ld hl,3662	; src offset 376, code offset 0x2e92
	push hl		; code offset 0x2e93
	ld hl,3662	; src offset 374, code offset 0x2e96
	push hl		; code offset 0x2e97
	ld hl,3662	; src offset 372, code offset 0x2e9a
	push hl		; code offset 0x2e9b
	ld hl,3662	; src offset 370, code offset 0x2e9e
	push hl		; code offset 0x2e9f
	ld hl,3662	; src offset 368, code offset 0x2ea2
	push hl		; code offset 0x2ea3
	ld hl,3662	; src offset 366, code offset 0x2ea6
	push hl		; code offset 0x2ea7
	ld hl,3662	; src offset 364, code offset 0x2eaa
	push hl		; code offset 0x2eab
	ld hl,3662	; src offset 362, code offset 0x2eae
	push hl		; code offset 0x2eaf
	ld hl,3662	; src offset 360, code offset 0x2eb2
	push hl		; code offset 0x2eb3
	ld hl,3662	; src offset 358, code offset 0x2eb6
	push hl		; code offset 0x2eb7
	ld hl,3662	; src offset 356, code offset 0x2eba
	push hl		; code offset 0x2ebb
	ld hl,3662	; src offset 354, code offset 0x2ebe
	push hl		; code offset 0x2ebf
	ld hl,3662	; src offset 352, code offset 0x2ec2
	push hl		; code offset 0x2ec3
	ld hl,3662	; src offset 350, code offset 0x2ec6
	push hl		; code offset 0x2ec7
	ld hl,3662	; src offset 348, code offset 0x2eca
	push hl		; code offset 0x2ecb
	ld hl,3662	; src offset 346, code offset 0x2ece
	push hl		; code offset 0x2ecf
	ld hl,3662	; src offset 344, code offset 0x2ed2
	push hl		; code offset 0x2ed3
	ld hl,3662	; src offset 342, code offset 0x2ed6
	push hl		; code offset 0x2ed7
	ld hl,3662	; src offset 340, code offset 0x2eda
	push hl		; code offset 0x2edb
	ld hl,3662	; src offset 338, code offset 0x2ede
	push hl		; code offset 0x2edf
	ld hl,3662	; src offset 336, code offset 0x2ee2
	push hl		; code offset 0x2ee3
	ld hl,3662	; src offset 334, code offset 0x2ee6
	push hl		; code offset 0x2ee7
	ld hl,3662	; src offset 332, code offset 0x2eea
	push hl		; code offset 0x2eeb
	ld hl,3662	; src offset 330, code offset 0x2eee
	push hl		; code offset 0x2eef
	ld hl,3662	; src offset 328, code offset 0x2ef2
	push hl		; code offset 0x2ef3
	ld hl,3662	; src offset 326, code offset 0x2ef6
	push hl		; code offset 0x2ef7
	ld hl,3662	; src offset 324, code offset 0x2efa
	push hl		; code offset 0x2efb
	ld hl,3662	; src offset 322, code offset 0x2efe
	push hl		; code offset 0x2eff
	ld hl,3662	; src offset 320, code offset 0x2f02
	push hl		; code offset 0x2f03
	ld hl,3662	; src offset 318, code offset 0x2f06
	push hl		; code offset 0x2f07
	ld hl,3662	; src offset 316, code offset 0x2f0a
	push hl		; code offset 0x2f0b
	ld hl,3662	; src offset 314, code offset 0x2f0e
	push hl		; code offset 0x2f0f
	ld hl,3662	; src offset 312, code offset 0x2f12
	push hl		; code offset 0x2f13
	ld hl,3662	; src offset 310, code offset 0x2f16
	push hl		; code offset 0x2f17
	ld hl,3662	; src offset 308, code offset 0x2f1a
	push hl		; code offset 0x2f1b
	ld hl,3662	; src offset 306, code offset 0x2f1e
	push hl		; code offset 0x2f1f
	ld hl,3662	; src offset 304, code offset 0x2f22
	push hl		; code offset 0x2f23
	ld hl,3662	; src offset 302, code offset 0x2f26
	push hl		; code offset 0x2f27
	ld hl,3662	; src offset 300, code offset 0x2f2a
	push hl		; code offset 0x2f2b
	ld hl,3662	; src offset 298, code offset 0x2f2e
	push hl		; code offset 0x2f2f
	ld hl,3662	; src offset 296, code offset 0x2f32
	push hl		; code offset 0x2f33
	ld hl,3662	; src offset 294, code offset 0x2f36
	push hl		; code offset 0x2f37
	ld hl,3662	; src offset 292, code offset 0x2f3a
	push hl		; code offset 0x2f3b
	ld hl,3662	; src offset 290, code offset 0x2f3e
	push hl		; code offset 0x2f3f
	ld hl,3662	; src offset 288, code offset 0x2f42
	push hl		; code offset 0x2f43
	ld hl,3662	; src offset 286, code offset 0x2f46
	push hl		; code offset 0x2f47
	ld hl,3662	; src offset 284, code offset 0x2f4a
	push hl		; code offset 0x2f4b
	ld hl,3662	; src offset 282, code offset 0x2f4e
	push hl		; code offset 0x2f4f
	ld hl,3662	; src offset 280, code offset 0x2f52
	push hl		; code offset 0x2f53
	ld hl,3662	; src offset 278, code offset 0x2f56
	push hl		; code offset 0x2f57
	ld hl,3662	; src offset 276, code offset 0x2f5a
	push hl		; code offset 0x2f5b
	ld hl,3662	; src offset 274, code offset 0x2f5e
	push hl		; code offset 0x2f5f
	ld hl,3662	; src offset 272, code offset 0x2f62
	push hl		; code offset 0x2f63
	ld hl,3662	; src offset 270, code offset 0x2f66
	push hl		; code offset 0x2f67
	ld hl,3662	; src offset 268, code offset 0x2f6a
	push hl		; code offset 0x2f6b
	ld hl,3662	; src offset 266, code offset 0x2f6e
	push hl		; code offset 0x2f6f
	ld hl,3662	; src offset 264, code offset 0x2f72
	push hl		; code offset 0x2f73
	ld hl,3662	; src offset 262, code offset 0x2f76
	push hl		; code offset 0x2f77
	ld hl,3662	; src offset 260, code offset 0x2f7a
	push hl		; code offset 0x2f7b
	ld hl,3662	; src offset 258, code offset 0x2f7e
	push hl		; code offset 0x2f7f
	ld hl,3662	; src offset 256, code offset 0x2f82
	push hl		; code offset 0x2f83
	ld hl,3662	; src offset 254, code offset 0x2f86
	push hl		; code offset 0x2f87
	ld hl,3662	; src offset 252, code offset 0x2f8a
	push hl		; code offset 0x2f8b
	ld hl,3662	; src offset 250, code offset 0x2f8e
	push hl		; code offset 0x2f8f
	ld hl,3662	; src offset 248, code offset 0x2f92
	push hl		; code offset 0x2f93
	ld hl,3662	; src offset 246, code offset 0x2f96
	push hl		; code offset 0x2f97
	ld hl,3662	; src offset 244, code offset 0x2f9a
	push hl		; code offset 0x2f9b
	ld hl,3662	; src offset 242, code offset 0x2f9e
	push hl		; code offset 0x2f9f
	ld hl,3662	; src offset 240, code offset 0x2fa2
	push hl		; code offset 0x2fa3
	ld hl,3662	; src offset 238, code offset 0x2fa6
	push hl		; code offset 0x2fa7
	ld hl,3662	; src offset 236, code offset 0x2faa
	push hl		; code offset 0x2fab
	ld hl,3662	; src offset 234, code offset 0x2fae
	push hl		; code offset 0x2faf
	ld hl,3662	; src offset 232, code offset 0x2fb2
	push hl		; code offset 0x2fb3
	ld hl,3662	; src offset 230, code offset 0x2fb6
	push hl		; code offset 0x2fb7
	ld hl,3662	; src offset 228, code offset 0x2fba
	push hl		; code offset 0x2fbb
	ld hl,3662	; src offset 226, code offset 0x2fbe
	push hl		; code offset 0x2fbf
	ld hl,3662	; src offset 224, code offset 0x2fc2
	push hl		; code offset 0x2fc3
	ld hl,3662	; src offset 222, code offset 0x2fc6
	push hl		; code offset 0x2fc7
	ld hl,3662	; src offset 220, code offset 0x2fca
	push hl		; code offset 0x2fcb
	ld hl,3662	; src offset 218, code offset 0x2fce
	push hl		; code offset 0x2fcf
	ld hl,3662	; src offset 216, code offset 0x2fd2
	push hl		; code offset 0x2fd3
	ld hl,3662	; src offset 214, code offset 0x2fd6
	push hl		; code offset 0x2fd7
	ld hl,3662	; src offset 212, code offset 0x2fda
	push hl		; code offset 0x2fdb
	ld hl,3662	; src offset 210, code offset 0x2fde
	push hl		; code offset 0x2fdf
	ld hl,3662	; src offset 208, code offset 0x2fe2
	push hl		; code offset 0x2fe3
	ld hl,3662	; src offset 206, code offset 0x2fe6
	push hl		; code offset 0x2fe7
	ld hl,3662	; src offset 204, code offset 0x2fea
	push hl		; code offset 0x2feb
	ld hl,3662	; src offset 202, code offset 0x2fee
	push hl		; code offset 0x2fef
	ld hl,3662	; src offset 200, code offset 0x2ff2
	push hl		; code offset 0x2ff3
	ld hl,3662	; src offset 198, code offset 0x2ff6
	push hl		; code offset 0x2ff7
	ld hl,3662	; src offset 196, code offset 0x2ffa
	push hl		; code offset 0x2ffb
	ld hl,3662	; src offset 194, code offset 0x2ffe
	push hl		; code offset 0x2fff
	ld hl,3662	; src offset 192, code offset 0x3002
	push hl		; code offset 0x3003
	ld hl,3662	; src offset 190, code offset 0x3006
	push hl		; code offset 0x3007
	ld hl,3662	; src offset 188, code offset 0x300a
	push hl		; code offset 0x300b
	ld hl,3662	; src offset 186, code offset 0x300e
	push hl		; code offset 0x300f
	ld hl,3662	; src offset 184, code offset 0x3012
	push hl		; code offset 0x3013
	ld hl,3662	; src offset 182, code offset 0x3016
	push hl		; code offset 0x3017
	ld hl,3662	; src offset 180, code offset 0x301a
	push hl		; code offset 0x301b
	ld hl,3662	; src offset 178, code offset 0x301e
	push hl		; code offset 0x301f
	ld hl,3662	; src offset 176, code offset 0x3022
	push hl		; code offset 0x3023
	ld hl,3662	; src offset 174, code offset 0x3026
	push hl		; code offset 0x3027
	ld hl,3662	; src offset 172, code offset 0x302a
	push hl		; code offset 0x302b
	ld hl,3662	; src offset 170, code offset 0x302e
	push hl		; code offset 0x302f
	ld hl,3662	; src offset 168, code offset 0x3032
	push hl		; code offset 0x3033
	ld hl,3662	; src offset 166, code offset 0x3036
	push hl		; code offset 0x3037
	ld hl,3662	; src offset 164, code offset 0x303a
	push hl		; code offset 0x303b
	ld hl,3662	; src offset 162, code offset 0x303e
	push hl		; code offset 0x303f
	ld hl,3662	; src offset 160, code offset 0x3042
	push hl		; code offset 0x3043
	ld hl,3662	; src offset 158, code offset 0x3046
	push hl		; code offset 0x3047
	ld hl,3662	; src offset 156, code offset 0x304a
	push hl		; code offset 0x304b
	ld hl,3662	; src offset 154, code offset 0x304e
	push hl		; code offset 0x304f
	ld hl,3662	; src offset 152, code offset 0x3052
	push hl		; code offset 0x3053
	ld hl,3662	; src offset 150, code offset 0x3056
	push hl		; code offset 0x3057
	ld hl,3662	; src offset 148, code offset 0x305a
	push hl		; code offset 0x305b
	ld hl,3662	; src offset 146, code offset 0x305e
	push hl		; code offset 0x305f
	ld hl,3662	; src offset 144, code offset 0x3062
	push hl		; code offset 0x3063
	ld hl,3662	; src offset 142, code offset 0x3066
	push hl		; code offset 0x3067
	ld hl,3662	; src offset 140, code offset 0x306a
	push hl		; code offset 0x306b
	ld hl,3662	; src offset 138, code offset 0x306e
	push hl		; code offset 0x306f
	ld hl,3662	; src offset 136, code offset 0x3072
	push hl		; code offset 0x3073
	ld hl,3662	; src offset 134, code offset 0x3076
	push hl		; code offset 0x3077
	ld hl,3662	; src offset 132, code offset 0x307a
	push hl		; code offset 0x307b
	ld hl,3662	; src offset 130, code offset 0x307e
	push hl		; code offset 0x307f
	ld hl,3662	; src offset 128, code offset 0x3082
	push hl		; code offset 0x3083
	ld hl,3662	; src offset 126, code offset 0x3086
	push hl		; code offset 0x3087
	ld hl,3662	; src offset 124, code offset 0x308a
	push hl		; code offset 0x308b
	ld hl,3662	; src offset 122, code offset 0x308e
	push hl		; code offset 0x308f
	ld hl,3662	; src offset 120, code offset 0x3092
	push hl		; code offset 0x3093
	ld hl,3662	; src offset 118, code offset 0x3096
	push hl		; code offset 0x3097
	ld hl,3662	; src offset 116, code offset 0x309a
	push hl		; code offset 0x309b
	ld hl,3662	; src offset 114, code offset 0x309e
	push hl		; code offset 0x309f
	ld hl,3662	; src offset 112, code offset 0x30a2
	push hl		; code offset 0x30a3
	ld hl,3662	; src offset 110, code offset 0x30a6
	push hl		; code offset 0x30a7
	ld hl,3662	; src offset 108, code offset 0x30aa
	push hl		; code offset 0x30ab
	ld hl,3662	; src offset 106, code offset 0x30ae
	push hl		; code offset 0x30af
	ld hl,3662	; src offset 104, code offset 0x30b2
	push hl		; code offset 0x30b3
	ld hl,3662	; src offset 102, code offset 0x30b6
	push hl		; code offset 0x30b7
	ld hl,3662	; src offset 100, code offset 0x30ba
	push hl		; code offset 0x30bb
	ld hl,3662	; src offset 98, code offset 0x30be
	push hl		; code offset 0x30bf
	ld hl,3662	; src offset 96, code offset 0x30c2
	push hl		; code offset 0x30c3
	ld hl,3662	; src offset 94, code offset 0x30c6
	push hl		; code offset 0x30c7
	ld hl,3662	; src offset 92, code offset 0x30ca
	push hl		; code offset 0x30cb
	ld hl,3662	; src offset 90, code offset 0x30ce
	push hl		; code offset 0x30cf
	ld hl,3662	; src offset 88, code offset 0x30d2
	push hl		; code offset 0x30d3
	ld hl,3662	; src offset 86, code offset 0x30d6
	push hl		; code offset 0x30d7
	ld hl,3662	; src offset 84, code offset 0x30da
	push hl		; code offset 0x30db
	ld hl,3662	; src offset 82, code offset 0x30de
	push hl		; code offset 0x30df
	ld hl,3662	; src offset 80, code offset 0x30e2
	push hl		; code offset 0x30e3
	ld hl,3662	; src offset 78, code offset 0x30e6
	push hl		; code offset 0x30e7
	ld hl,3662	; src offset 76, code offset 0x30ea
	push hl		; code offset 0x30eb
	ld hl,3662	; src offset 74, code offset 0x30ee
	push hl		; code offset 0x30ef
	ld hl,3662	; src offset 72, code offset 0x30f2
	push hl		; code offset 0x30f3
	ld hl,3662	; src offset 70, code offset 0x30f6
	push hl		; code offset 0x30f7
	ld hl,3662	; src offset 68, code offset 0x30fa
	push hl		; code offset 0x30fb
	ld hl,3662	; src offset 66, code offset 0x30fe
	push hl		; code offset 0x30ff
	ld hl,3662	; src offset 64, code offset 0x3102
	push hl		; code offset 0x3103
	ld hl,3662	; src offset 62, code offset 0x3106
	push hl		; code offset 0x3107
	ld hl,3662	; src offset 60, code offset 0x310a
	push hl		; code offset 0x310b
	ld hl,3662	; src offset 58, code offset 0x310e
	push hl		; code offset 0x310f
	ld hl,3662	; src offset 56, code offset 0x3112
	push hl		; code offset 0x3113
	ld hl,3662	; src offset 54, code offset 0x3116
	push hl		; code offset 0x3117
	ld hl,3662	; src offset 52, code offset 0x311a
	push hl		; code offset 0x311b
	ld hl,3662	; src offset 50, code offset 0x311e
	push hl		; code offset 0x311f
	ld hl,3662	; src offset 48, code offset 0x3122
	push hl		; code offset 0x3123
	ld hl,3662	; src offset 46, code offset 0x3126
	push hl		; code offset 0x3127
	ld hl,3662	; src offset 44, code offset 0x312a
	push hl		; code offset 0x312b
	ld hl,3662	; src offset 42, code offset 0x312e
	push hl		; code offset 0x312f
	ld hl,3662	; src offset 40, code offset 0x3132
	push hl		; code offset 0x3133
	ld hl,3662	; src offset 38, code offset 0x3136
	push hl		; code offset 0x3137
	ld hl,3662	; src offset 36, code offset 0x313a
	push hl		; code offset 0x313b
	ld hl,3662	; src offset 34, code offset 0x313e
	push hl		; code offset 0x313f
	ld hl,3662	; src offset 32, code offset 0x3142
	push hl		; code offset 0x3143
	ld hl,3662	; src offset 30, code offset 0x3146
	push hl		; code offset 0x3147
	ld hl,3662	; src offset 28, code offset 0x314a
	push hl		; code offset 0x314b
	ld hl,3662	; src offset 26, code offset 0x314e
	push hl		; code offset 0x314f
	ld hl,3662	; src offset 24, code offset 0x3152
	push hl		; code offset 0x3153
	ld hl,3662	; src offset 22, code offset 0x3156
	push hl		; code offset 0x3157
	ld hl,3662	; src offset 20, code offset 0x315a
	push hl		; code offset 0x315b
	ld hl,3662	; src offset 18, code offset 0x315e
	push hl		; code offset 0x315f
	ld hl,3662	; src offset 16, code offset 0x3162
	push hl		; code offset 0x3163
	ld hl,3662	; src offset 14, code offset 0x3166
	push hl		; code offset 0x3167
	ld hl,3662	; src offset 12, code offset 0x316a
	push hl		; code offset 0x316b
	ld hl,3662	; src offset 10, code offset 0x316e
	push hl		; code offset 0x316f
	ld hl,3662	; src offset 8, code offset 0x3172
	push hl		; code offset 0x3173
	ld hl,3662	; src offset 6, code offset 0x3176
	push hl		; code offset 0x3177
	ld hl,3662	; src offset 4, code offset 0x317a
	push hl		; code offset 0x317b
	ld hl,3662	; src offset 2, code offset 0x317e
	push hl		; code offset 0x317f
	ld hl,3662	; src offset 0, code offset 0x3182
	push hl		; code offset 0x3183

	; Block attribute blit end


	; src_data blit 203
	ld sp,screenStartAddr+3488	; offset 0x3186
	ld hl,52428	; offset 0x3189
	push hl	; offset 0x318a
	ld hl,52428	; offset 0x318d
	push hl	; offset 0x318e
	ld hl,52428	; offset 0x3191
	push hl	; offset 0x3192
	ld hl,52428	; offset 0x3195
	push hl	; offset 0x3196
	ld hl,52428	; offset 0x3199
	push hl	; offset 0x319a
	ld hl,52428	; offset 0x319d
	push hl	; offset 0x319e
	ld hl,52428	; offset 0x31a1
	push hl	; offset 0x31a2
	ld hl,52428	; offset 0x31a5
	push hl	; offset 0x31a6

	; src_data blit 204
	ld sp,screenStartAddr+3728	; offset 0x31a9
	ld hl,52428	; offset 0x31ac
	push hl	; offset 0x31ad
	ld hl,52428	; offset 0x31b0
	push hl	; offset 0x31b1
	ld hl,52428	; offset 0x31b4
	push hl	; offset 0x31b5
	ld hl,52428	; offset 0x31b8
	push hl	; offset 0x31b9
	ld hl,52428	; offset 0x31bc
	push hl	; offset 0x31bd
	ld hl,52428	; offset 0x31c0
	push hl	; offset 0x31c1
	ld hl,52428	; offset 0x31c4
	push hl	; offset 0x31c5
	ld hl,52428	; offset 0x31c8
	push hl	; offset 0x31c9

	; src_data blit 205
	ld sp,screenStartAddr+3744	; offset 0x31cc
	ld hl,52428	; offset 0x31cf
	push hl	; offset 0x31d0
	ld hl,52428	; offset 0x31d3
	push hl	; offset 0x31d4
	ld hl,52428	; offset 0x31d7
	push hl	; offset 0x31d8
	ld hl,52428	; offset 0x31db
	push hl	; offset 0x31dc
	ld hl,52428	; offset 0x31df
	push hl	; offset 0x31e0
	ld hl,52428	; offset 0x31e3
	push hl	; offset 0x31e4
	ld hl,52428	; offset 0x31e7
	push hl	; offset 0x31e8
	ld hl,52428	; offset 0x31eb
	push hl	; offset 0x31ec

	; src_data blit 206
	ld sp,screenStartAddr+3984	; offset 0x31ef
	ld hl,52428	; offset 0x31f2
	push hl	; offset 0x31f3
	ld hl,52428	; offset 0x31f6
	push hl	; offset 0x31f7
	ld hl,52428	; offset 0x31fa
	push hl	; offset 0x31fb
	ld hl,52428	; offset 0x31fe
	push hl	; offset 0x31ff
	ld hl,52428	; offset 0x3202
	push hl	; offset 0x3203
	ld hl,52428	; offset 0x3206
	push hl	; offset 0x3207
	ld hl,52428	; offset 0x320a
	push hl	; offset 0x320b
	ld hl,52428	; offset 0x320e
	push hl	; offset 0x320f

	; src_data blit 207
	ld sp,screenStartAddr+4000	; offset 0x3212
	ld hl,52428	; offset 0x3215
	push hl	; offset 0x3216
	ld hl,52428	; offset 0x3219
	push hl	; offset 0x321a
	ld hl,52428	; offset 0x321d
	push hl	; offset 0x321e
	ld hl,52428	; offset 0x3221
	push hl	; offset 0x3222
	ld hl,52428	; offset 0x3225
	push hl	; offset 0x3226
	ld hl,52428	; offset 0x3229
	push hl	; offset 0x322a
	ld hl,52428	; offset 0x322d
	push hl	; offset 0x322e
	ld hl,52428	; offset 0x3231
	push hl	; offset 0x3232

	; src_data blit 208
	ld sp,screenStartAddr+2224	; offset 0x3235
	ld hl,52428	; offset 0x3238
	push hl	; offset 0x3239
	ld hl,52428	; offset 0x323c
	push hl	; offset 0x323d
	ld hl,52428	; offset 0x3240
	push hl	; offset 0x3241
	ld hl,52428	; offset 0x3244
	push hl	; offset 0x3245
	ld hl,52428	; offset 0x3248
	push hl	; offset 0x3249
	ld hl,52428	; offset 0x324c
	push hl	; offset 0x324d
	ld hl,52428	; offset 0x3250
	push hl	; offset 0x3251
	ld hl,52428	; offset 0x3254
	push hl	; offset 0x3255

	; src_data blit 209
	ld sp,screenStartAddr+2240	; offset 0x3258
	ld hl,52428	; offset 0x325b
	push hl	; offset 0x325c
	ld hl,52428	; offset 0x325f
	push hl	; offset 0x3260
	ld hl,52428	; offset 0x3263
	push hl	; offset 0x3264
	ld hl,52428	; offset 0x3267
	push hl	; offset 0x3268
	ld hl,52428	; offset 0x326b
	push hl	; offset 0x326c
	ld hl,52428	; offset 0x326f
	push hl	; offset 0x3270
	ld hl,52428	; offset 0x3273
	push hl	; offset 0x3274
	ld hl,52428	; offset 0x3277
	push hl	; offset 0x3278

	; src_data blit 210
	ld sp,screenStartAddr+2480	; offset 0x327b
	ld hl,52428	; offset 0x327e
	push hl	; offset 0x327f
	ld hl,52428	; offset 0x3282
	push hl	; offset 0x3283
	ld hl,52428	; offset 0x3286
	push hl	; offset 0x3287
	ld hl,52428	; offset 0x328a
	push hl	; offset 0x328b
	ld hl,52428	; offset 0x328e
	push hl	; offset 0x328f
	ld hl,52428	; offset 0x3292
	push hl	; offset 0x3293
	ld hl,52428	; offset 0x3296
	push hl	; offset 0x3297
	ld hl,52428	; offset 0x329a
	push hl	; offset 0x329b

	; src_data blit 211
	ld sp,screenStartAddr+2496	; offset 0x329e
	ld hl,52428	; offset 0x32a1
	push hl	; offset 0x32a2
	ld hl,52428	; offset 0x32a5
	push hl	; offset 0x32a6
	ld hl,52428	; offset 0x32a9
	push hl	; offset 0x32aa
	ld hl,52428	; offset 0x32ad
	push hl	; offset 0x32ae
	ld hl,52428	; offset 0x32b1
	push hl	; offset 0x32b2
	ld hl,52428	; offset 0x32b5
	push hl	; offset 0x32b6
	ld hl,52428	; offset 0x32b9
	push hl	; offset 0x32ba
	ld hl,52428	; offset 0x32bd
	push hl	; offset 0x32be

	; src_data blit 212
	ld sp,screenStartAddr+2736	; offset 0x32c1
	ld hl,52428	; offset 0x32c4
	push hl	; offset 0x32c5
	ld hl,52428	; offset 0x32c8
	push hl	; offset 0x32c9
	ld hl,52428	; offset 0x32cc
	push hl	; offset 0x32cd
	ld hl,52428	; offset 0x32d0
	push hl	; offset 0x32d1
	ld hl,52428	; offset 0x32d4
	push hl	; offset 0x32d5
	ld hl,52428	; offset 0x32d8
	push hl	; offset 0x32d9
	ld hl,52428	; offset 0x32dc
	push hl	; offset 0x32dd
	ld hl,52428	; offset 0x32e0
	push hl	; offset 0x32e1

	; src_data blit 213
	ld sp,screenStartAddr+2752	; offset 0x32e4
	ld hl,52428	; offset 0x32e7
	push hl	; offset 0x32e8
	ld hl,52428	; offset 0x32eb
	push hl	; offset 0x32ec
	ld hl,52428	; offset 0x32ef
	push hl	; offset 0x32f0
	ld hl,52428	; offset 0x32f3
	push hl	; offset 0x32f4
	ld hl,52428	; offset 0x32f7
	push hl	; offset 0x32f8
	ld hl,52428	; offset 0x32fb
	push hl	; offset 0x32fc
	ld hl,52428	; offset 0x32ff
	push hl	; offset 0x3300
	ld hl,52428	; offset 0x3303
	push hl	; offset 0x3304

	; src_data blit 214
	ld sp,screenStartAddr+2992	; offset 0x3307
	ld hl,52428	; offset 0x330a
	push hl	; offset 0x330b
	ld hl,52428	; offset 0x330e
	push hl	; offset 0x330f
	ld hl,52428	; offset 0x3312
	push hl	; offset 0x3313
	ld hl,52428	; offset 0x3316
	push hl	; offset 0x3317
	ld hl,52428	; offset 0x331a
	push hl	; offset 0x331b
	ld hl,52428	; offset 0x331e
	push hl	; offset 0x331f
	ld hl,52428	; offset 0x3322
	push hl	; offset 0x3323
	ld hl,52428	; offset 0x3326
	push hl	; offset 0x3327

	; src_data blit 215
	ld sp,screenStartAddr+3008	; offset 0x332a
	ld hl,52428	; offset 0x332d
	push hl	; offset 0x332e
	ld hl,52428	; offset 0x3331
	push hl	; offset 0x3332
	ld hl,52428	; offset 0x3335
	push hl	; offset 0x3336
	ld hl,52428	; offset 0x3339
	push hl	; offset 0x333a
	ld hl,52428	; offset 0x333d
	push hl	; offset 0x333e
	ld hl,52428	; offset 0x3341
	push hl	; offset 0x3342
	ld hl,52428	; offset 0x3345
	push hl	; offset 0x3346
	ld hl,52428	; offset 0x3349
	push hl	; offset 0x334a

	; src_data blit 216
	ld sp,screenStartAddr+3248	; offset 0x334d
	ld hl,52428	; offset 0x3350
	push hl	; offset 0x3351
	ld hl,52428	; offset 0x3354
	push hl	; offset 0x3355
	ld hl,52428	; offset 0x3358
	push hl	; offset 0x3359
	ld hl,52428	; offset 0x335c
	push hl	; offset 0x335d
	ld hl,52428	; offset 0x3360
	push hl	; offset 0x3361
	ld hl,52428	; offset 0x3364
	push hl	; offset 0x3365
	ld hl,52428	; offset 0x3368
	push hl	; offset 0x3369
	ld hl,52428	; offset 0x336c
	push hl	; offset 0x336d

	; src_data blit 217
	ld sp,screenStartAddr+3264	; offset 0x3370
	ld hl,52428	; offset 0x3373
	push hl	; offset 0x3374
	ld hl,52428	; offset 0x3377
	push hl	; offset 0x3378
	ld hl,52428	; offset 0x337b
	push hl	; offset 0x337c
	ld hl,52428	; offset 0x337f
	push hl	; offset 0x3380
	ld hl,52428	; offset 0x3383
	push hl	; offset 0x3384
	ld hl,52428	; offset 0x3387
	push hl	; offset 0x3388
	ld hl,52428	; offset 0x338b
	push hl	; offset 0x338c
	ld hl,52428	; offset 0x338f
	push hl	; offset 0x3390

	; src_data blit 218
	ld sp,screenStartAddr+3504	; offset 0x3393
	ld hl,52428	; offset 0x3396
	push hl	; offset 0x3397
	ld hl,52428	; offset 0x339a
	push hl	; offset 0x339b
	ld hl,52428	; offset 0x339e
	push hl	; offset 0x339f
	ld hl,52428	; offset 0x33a2
	push hl	; offset 0x33a3
	ld hl,52428	; offset 0x33a6
	push hl	; offset 0x33a7
	ld hl,52428	; offset 0x33aa
	push hl	; offset 0x33ab
	ld hl,52428	; offset 0x33ae
	push hl	; offset 0x33af
	ld hl,52428	; offset 0x33b2
	push hl	; offset 0x33b3

	; src_data blit 219
	ld sp,screenStartAddr+3520	; offset 0x33b6
	ld hl,52428	; offset 0x33b9
	push hl	; offset 0x33ba
	ld hl,52428	; offset 0x33bd
	push hl	; offset 0x33be
	ld hl,52428	; offset 0x33c1
	push hl	; offset 0x33c2
	ld hl,52428	; offset 0x33c5
	push hl	; offset 0x33c6
	ld hl,52428	; offset 0x33c9
	push hl	; offset 0x33ca
	ld hl,52428	; offset 0x33cd
	push hl	; offset 0x33ce
	ld hl,52428	; offset 0x33d1
	push hl	; offset 0x33d2
	ld hl,52428	; offset 0x33d5
	push hl	; offset 0x33d6

	; src_data blit 220
	ld sp,screenStartAddr+3760	; offset 0x33d9
	ld hl,52428	; offset 0x33dc
	push hl	; offset 0x33dd
	ld hl,52428	; offset 0x33e0
	push hl	; offset 0x33e1
	ld hl,52428	; offset 0x33e4
	push hl	; offset 0x33e5
	ld hl,52428	; offset 0x33e8
	push hl	; offset 0x33e9
	ld hl,52428	; offset 0x33ec
	push hl	; offset 0x33ed
	ld hl,52428	; offset 0x33f0
	push hl	; offset 0x33f1
	ld hl,52428	; offset 0x33f4
	push hl	; offset 0x33f5
	ld hl,52428	; offset 0x33f8
	push hl	; offset 0x33f9

	; src_data blit 221
	ld sp,screenStartAddr+3776	; offset 0x33fc
	ld hl,52428	; offset 0x33ff
	push hl	; offset 0x3400
	ld hl,52428	; offset 0x3403
	push hl	; offset 0x3404
	ld hl,52428	; offset 0x3407
	push hl	; offset 0x3408
	ld hl,52428	; offset 0x340b
	push hl	; offset 0x340c
	ld hl,52428	; offset 0x340f
	push hl	; offset 0x3410
	ld hl,52428	; offset 0x3413
	push hl	; offset 0x3414
	ld hl,52428	; offset 0x3417
	push hl	; offset 0x3418
	ld hl,52428	; offset 0x341b
	push hl	; offset 0x341c

	; src_data blit 222
	ld sp,screenStartAddr+4016	; offset 0x341f
	ld hl,52428	; offset 0x3422
	push hl	; offset 0x3423
	ld hl,52428	; offset 0x3426
	push hl	; offset 0x3427
	ld hl,52428	; offset 0x342a
	push hl	; offset 0x342b
	ld hl,52428	; offset 0x342e
	push hl	; offset 0x342f
	ld hl,52428	; offset 0x3432
	push hl	; offset 0x3433
	ld hl,52428	; offset 0x3436
	push hl	; offset 0x3437
	ld hl,52428	; offset 0x343a
	push hl	; offset 0x343b
	ld hl,52428	; offset 0x343e
	push hl	; offset 0x343f

	; src_data blit 223
	ld sp,screenStartAddr+4032	; offset 0x3442
	ld hl,52428	; offset 0x3445
	push hl	; offset 0x3446
	ld hl,52428	; offset 0x3449
	push hl	; offset 0x344a
	ld hl,52428	; offset 0x344d
	push hl	; offset 0x344e
	ld hl,52428	; offset 0x3451
	push hl	; offset 0x3452
	ld hl,52428	; offset 0x3455
	push hl	; offset 0x3456
	ld hl,52428	; offset 0x3459
	push hl	; offset 0x345a
	ld hl,52428	; offset 0x345d
	push hl	; offset 0x345e
	ld hl,52428	; offset 0x3461
	push hl	; offset 0x3462

	; src_data blit 224
	ld sp,screenStartAddr+2256	; offset 0x3465
	ld hl,52428	; offset 0x3468
	push hl	; offset 0x3469
	ld hl,52428	; offset 0x346c
	push hl	; offset 0x346d
	ld hl,52428	; offset 0x3470
	push hl	; offset 0x3471
	ld hl,52428	; offset 0x3474
	push hl	; offset 0x3475
	ld hl,52428	; offset 0x3478
	push hl	; offset 0x3479
	ld hl,52428	; offset 0x347c
	push hl	; offset 0x347d
	ld hl,52428	; offset 0x3480
	push hl	; offset 0x3481
	ld hl,52428	; offset 0x3484
	push hl	; offset 0x3485

	; src_data blit 225
	ld sp,screenStartAddr+2272	; offset 0x3488
	ld hl,52428	; offset 0x348b
	push hl	; offset 0x348c
	ld hl,52428	; offset 0x348f
	push hl	; offset 0x3490
	ld hl,52428	; offset 0x3493
	push hl	; offset 0x3494
	ld hl,52428	; offset 0x3497
	push hl	; offset 0x3498
	ld hl,52428	; offset 0x349b
	push hl	; offset 0x349c
	ld hl,52428	; offset 0x349f
	push hl	; offset 0x34a0
	ld hl,52428	; offset 0x34a3
	push hl	; offset 0x34a4
	ld hl,52428	; offset 0x34a7
	push hl	; offset 0x34a8

	; src_data blit 226
	ld sp,screenStartAddr+2512	; offset 0x34ab
	ld hl,52428	; offset 0x34ae
	push hl	; offset 0x34af
	ld hl,52428	; offset 0x34b2
	push hl	; offset 0x34b3
	ld hl,52428	; offset 0x34b6
	push hl	; offset 0x34b7
	ld hl,52428	; offset 0x34ba
	push hl	; offset 0x34bb
	ld hl,52428	; offset 0x34be
	push hl	; offset 0x34bf
	ld hl,52428	; offset 0x34c2
	push hl	; offset 0x34c3
	ld hl,52428	; offset 0x34c6
	push hl	; offset 0x34c7
	ld hl,52428	; offset 0x34ca
	push hl	; offset 0x34cb

	; src_data blit 227
	ld sp,screenStartAddr+2528	; offset 0x34ce
	ld hl,52428	; offset 0x34d1
	push hl	; offset 0x34d2
	ld hl,52428	; offset 0x34d5
	push hl	; offset 0x34d6
	ld hl,52428	; offset 0x34d9
	push hl	; offset 0x34da
	ld hl,52428	; offset 0x34dd
	push hl	; offset 0x34de
	ld hl,52428	; offset 0x34e1
	push hl	; offset 0x34e2
	ld hl,52428	; offset 0x34e5
	push hl	; offset 0x34e6
	ld hl,52428	; offset 0x34e9
	push hl	; offset 0x34ea
	ld hl,52428	; offset 0x34ed
	push hl	; offset 0x34ee

	; src_data blit 228
	ld sp,screenStartAddr+2768	; offset 0x34f1
	ld hl,52428	; offset 0x34f4
	push hl	; offset 0x34f5
	ld hl,52428	; offset 0x34f8
	push hl	; offset 0x34f9
	ld hl,52428	; offset 0x34fc
	push hl	; offset 0x34fd
	ld hl,52428	; offset 0x3500
	push hl	; offset 0x3501
	ld hl,52428	; offset 0x3504
	push hl	; offset 0x3505
	ld hl,52428	; offset 0x3508
	push hl	; offset 0x3509
	ld hl,52428	; offset 0x350c
	push hl	; offset 0x350d
	ld hl,52428	; offset 0x3510
	push hl	; offset 0x3511

	; src_data blit 229
	ld sp,screenStartAddr+2784	; offset 0x3514
	ld hl,52428	; offset 0x3517
	push hl	; offset 0x3518
	ld hl,52428	; offset 0x351b
	push hl	; offset 0x351c
	ld hl,52428	; offset 0x351f
	push hl	; offset 0x3520
	ld hl,52428	; offset 0x3523
	push hl	; offset 0x3524
	ld hl,52428	; offset 0x3527
	push hl	; offset 0x3528
	ld hl,52428	; offset 0x352b
	push hl	; offset 0x352c
	ld hl,52428	; offset 0x352f
	push hl	; offset 0x3530
	ld hl,52428	; offset 0x3533
	push hl	; offset 0x3534

	; src_data blit 230
	ld sp,screenStartAddr+3024	; offset 0x3537
	ld hl,52428	; offset 0x353a
	push hl	; offset 0x353b
	ld hl,52428	; offset 0x353e
	push hl	; offset 0x353f
	ld hl,52428	; offset 0x3542
	push hl	; offset 0x3543
	ld hl,52428	; offset 0x3546
	push hl	; offset 0x3547
	ld hl,52428	; offset 0x354a
	push hl	; offset 0x354b
	ld hl,52428	; offset 0x354e
	push hl	; offset 0x354f
	ld hl,52428	; offset 0x3552
	push hl	; offset 0x3553
	ld hl,52428	; offset 0x3556
	push hl	; offset 0x3557

	; src_data blit 231
	ld sp,screenStartAddr+3040	; offset 0x355a
	ld hl,52428	; offset 0x355d
	push hl	; offset 0x355e
	ld hl,52428	; offset 0x3561
	push hl	; offset 0x3562
	ld hl,52428	; offset 0x3565
	push hl	; offset 0x3566
	ld hl,52428	; offset 0x3569
	push hl	; offset 0x356a
	ld hl,52428	; offset 0x356d
	push hl	; offset 0x356e
	ld hl,52428	; offset 0x3571
	push hl	; offset 0x3572
	ld hl,52428	; offset 0x3575
	push hl	; offset 0x3576
	ld hl,52428	; offset 0x3579
	push hl	; offset 0x357a

	; src_data blit 232
	ld sp,screenStartAddr+3280	; offset 0x357d
	ld hl,52428	; offset 0x3580
	push hl	; offset 0x3581
	ld hl,52428	; offset 0x3584
	push hl	; offset 0x3585
	ld hl,52428	; offset 0x3588
	push hl	; offset 0x3589
	ld hl,52428	; offset 0x358c
	push hl	; offset 0x358d
	ld hl,52428	; offset 0x3590
	push hl	; offset 0x3591
	ld hl,52428	; offset 0x3594
	push hl	; offset 0x3595
	ld hl,52428	; offset 0x3598
	push hl	; offset 0x3599
	ld hl,52428	; offset 0x359c
	push hl	; offset 0x359d

	; src_data blit 233
	ld sp,screenStartAddr+3296	; offset 0x35a0
	ld hl,52428	; offset 0x35a3
	push hl	; offset 0x35a4
	ld hl,52428	; offset 0x35a7
	push hl	; offset 0x35a8
	ld hl,52428	; offset 0x35ab
	push hl	; offset 0x35ac
	ld hl,52428	; offset 0x35af
	push hl	; offset 0x35b0
	ld hl,52428	; offset 0x35b3
	push hl	; offset 0x35b4
	ld hl,52428	; offset 0x35b7
	push hl	; offset 0x35b8
	ld hl,52428	; offset 0x35bb
	push hl	; offset 0x35bc
	ld hl,52428	; offset 0x35bf
	push hl	; offset 0x35c0

	; src_data blit 234
	ld sp,screenStartAddr+3536	; offset 0x35c3
	ld hl,52428	; offset 0x35c6
	push hl	; offset 0x35c7
	ld hl,52428	; offset 0x35ca
	push hl	; offset 0x35cb
	ld hl,52428	; offset 0x35ce
	push hl	; offset 0x35cf
	ld hl,52428	; offset 0x35d2
	push hl	; offset 0x35d3
	ld hl,52428	; offset 0x35d6
	push hl	; offset 0x35d7
	ld hl,52428	; offset 0x35da
	push hl	; offset 0x35db
	ld hl,52428	; offset 0x35de
	push hl	; offset 0x35df
	ld hl,52428	; offset 0x35e2
	push hl	; offset 0x35e3

	; src_data blit 235
	ld sp,screenStartAddr+3552	; offset 0x35e6
	ld hl,52428	; offset 0x35e9
	push hl	; offset 0x35ea
	ld hl,52428	; offset 0x35ed
	push hl	; offset 0x35ee
	ld hl,52428	; offset 0x35f1
	push hl	; offset 0x35f2
	ld hl,52428	; offset 0x35f5
	push hl	; offset 0x35f6
	ld hl,52428	; offset 0x35f9
	push hl	; offset 0x35fa
	ld hl,52428	; offset 0x35fd
	push hl	; offset 0x35fe
	ld hl,52428	; offset 0x3601
	push hl	; offset 0x3602
	ld hl,52428	; offset 0x3605
	push hl	; offset 0x3606

	; src_data blit 236
	ld sp,screenStartAddr+3792	; offset 0x3609
	ld hl,52428	; offset 0x360c
	push hl	; offset 0x360d
	ld hl,52428	; offset 0x3610
	push hl	; offset 0x3611
	ld hl,52428	; offset 0x3614
	push hl	; offset 0x3615
	ld hl,52428	; offset 0x3618
	push hl	; offset 0x3619
	ld hl,52428	; offset 0x361c
	push hl	; offset 0x361d
	ld hl,52428	; offset 0x3620
	push hl	; offset 0x3621
	ld hl,52428	; offset 0x3624
	push hl	; offset 0x3625
	ld hl,52428	; offset 0x3628
	push hl	; offset 0x3629

	; src_data blit 237
	ld sp,screenStartAddr+3808	; offset 0x362c
	ld hl,52428	; offset 0x362f
	push hl	; offset 0x3630
	ld hl,52428	; offset 0x3633
	push hl	; offset 0x3634
	ld hl,52428	; offset 0x3637
	push hl	; offset 0x3638
	ld hl,52428	; offset 0x363b
	push hl	; offset 0x363c
	ld hl,52428	; offset 0x363f
	push hl	; offset 0x3640
	ld hl,52428	; offset 0x3643
	push hl	; offset 0x3644
	ld hl,52428	; offset 0x3647
	push hl	; offset 0x3648
	ld hl,52428	; offset 0x364b
	push hl	; offset 0x364c

	; src_data blit 238
	ld sp,screenStartAddr+4048	; offset 0x364f
	ld hl,52428	; offset 0x3652
	push hl	; offset 0x3653
	ld hl,52428	; offset 0x3656
	push hl	; offset 0x3657
	ld hl,52428	; offset 0x365a
	push hl	; offset 0x365b
	ld hl,52428	; offset 0x365e
	push hl	; offset 0x365f
	ld hl,52428	; offset 0x3662
	push hl	; offset 0x3663
	ld hl,52428	; offset 0x3666
	push hl	; offset 0x3667
	ld hl,52428	; offset 0x366a
	push hl	; offset 0x366b
	ld hl,52428	; offset 0x366e
	push hl	; offset 0x366f

	; src_data blit 239
	ld sp,screenStartAddr+4064	; offset 0x3672
	ld hl,52428	; offset 0x3675
	push hl	; offset 0x3676
	ld hl,52428	; offset 0x3679
	push hl	; offset 0x367a
	ld hl,52428	; offset 0x367d
	push hl	; offset 0x367e
	ld hl,52428	; offset 0x3681
	push hl	; offset 0x3682
	ld hl,52428	; offset 0x3685
	push hl	; offset 0x3686
	ld hl,52428	; offset 0x3689
	push hl	; offset 0x368a
	ld hl,52428	; offset 0x368d
	push hl	; offset 0x368e
	ld hl,52428	; offset 0x3691
	push hl	; offset 0x3692

	; src_data blit 240
	ld sp,screenStartAddr+2288	; offset 0x3695
	ld hl,52428	; offset 0x3698
	push hl	; offset 0x3699
	ld hl,52428	; offset 0x369c
	push hl	; offset 0x369d
	ld hl,52428	; offset 0x36a0
	push hl	; offset 0x36a1
	ld hl,52428	; offset 0x36a4
	push hl	; offset 0x36a5
	ld hl,52428	; offset 0x36a8
	push hl	; offset 0x36a9
	ld hl,52428	; offset 0x36ac
	push hl	; offset 0x36ad
	ld hl,52428	; offset 0x36b0
	push hl	; offset 0x36b1
	ld hl,52428	; offset 0x36b4
	push hl	; offset 0x36b5

	; src_data blit 241
	ld sp,screenStartAddr+2304	; offset 0x36b8
	ld hl,52428	; offset 0x36bb
	push hl	; offset 0x36bc
	ld hl,52428	; offset 0x36bf
	push hl	; offset 0x36c0
	ld hl,52428	; offset 0x36c3
	push hl	; offset 0x36c4
	ld hl,52428	; offset 0x36c7
	push hl	; offset 0x36c8
	ld hl,52428	; offset 0x36cb
	push hl	; offset 0x36cc
	ld hl,52428	; offset 0x36cf
	push hl	; offset 0x36d0
	ld hl,52428	; offset 0x36d3
	push hl	; offset 0x36d4
	ld hl,52428	; offset 0x36d7
	push hl	; offset 0x36d8

	; src_data blit 242
	ld sp,screenStartAddr+2544	; offset 0x36db
	ld hl,52428	; offset 0x36de
	push hl	; offset 0x36df
	ld hl,52428	; offset 0x36e2
	push hl	; offset 0x36e3
	ld hl,52428	; offset 0x36e6
	push hl	; offset 0x36e7
	ld hl,52428	; offset 0x36ea
	push hl	; offset 0x36eb
	ld hl,52428	; offset 0x36ee
	push hl	; offset 0x36ef
	ld hl,52428	; offset 0x36f2
	push hl	; offset 0x36f3
	ld hl,52428	; offset 0x36f6
	push hl	; offset 0x36f7
	ld hl,52428	; offset 0x36fa
	push hl	; offset 0x36fb

	; src_data blit 243
	ld sp,screenStartAddr+2560	; offset 0x36fe
	ld hl,52428	; offset 0x3701
	push hl	; offset 0x3702
	ld hl,52428	; offset 0x3705
	push hl	; offset 0x3706
	ld hl,52428	; offset 0x3709
	push hl	; offset 0x370a
	ld hl,52428	; offset 0x370d
	push hl	; offset 0x370e
	ld hl,52428	; offset 0x3711
	push hl	; offset 0x3712
	ld hl,52428	; offset 0x3715
	push hl	; offset 0x3716
	ld hl,52428	; offset 0x3719
	push hl	; offset 0x371a
	ld hl,52428	; offset 0x371d
	push hl	; offset 0x371e

	; src_data blit 244
	ld sp,screenStartAddr+2800	; offset 0x3721
	ld hl,52428	; offset 0x3724
	push hl	; offset 0x3725
	ld hl,52428	; offset 0x3728
	push hl	; offset 0x3729
	ld hl,52428	; offset 0x372c
	push hl	; offset 0x372d
	ld hl,52428	; offset 0x3730
	push hl	; offset 0x3731
	ld hl,52428	; offset 0x3734
	push hl	; offset 0x3735
	ld hl,52428	; offset 0x3738
	push hl	; offset 0x3739
	ld hl,52428	; offset 0x373c
	push hl	; offset 0x373d
	ld hl,52428	; offset 0x3740
	push hl	; offset 0x3741

	; src_data blit 245
	ld sp,screenStartAddr+2816	; offset 0x3744
	ld hl,52428	; offset 0x3747
	push hl	; offset 0x3748
	ld hl,52428	; offset 0x374b
	push hl	; offset 0x374c
	ld hl,52428	; offset 0x374f
	push hl	; offset 0x3750
	ld hl,52428	; offset 0x3753
	push hl	; offset 0x3754
	ld hl,52428	; offset 0x3757
	push hl	; offset 0x3758
	ld hl,52428	; offset 0x375b
	push hl	; offset 0x375c
	ld hl,52428	; offset 0x375f
	push hl	; offset 0x3760
	ld hl,52428	; offset 0x3763
	push hl	; offset 0x3764

	; src_data blit 246
	ld sp,screenStartAddr+3056	; offset 0x3767
	ld hl,52428	; offset 0x376a
	push hl	; offset 0x376b
	ld hl,52428	; offset 0x376e
	push hl	; offset 0x376f
	ld hl,52428	; offset 0x3772
	push hl	; offset 0x3773
	ld hl,52428	; offset 0x3776
	push hl	; offset 0x3777
	ld hl,52428	; offset 0x377a
	push hl	; offset 0x377b
	ld hl,52428	; offset 0x377e
	push hl	; offset 0x377f
	ld hl,52428	; offset 0x3782
	push hl	; offset 0x3783
	ld hl,52428	; offset 0x3786
	push hl	; offset 0x3787

	; src_data blit 247
	ld sp,screenStartAddr+3072	; offset 0x378a
	ld hl,52428	; offset 0x378d
	push hl	; offset 0x378e
	ld hl,52428	; offset 0x3791
	push hl	; offset 0x3792
	ld hl,52428	; offset 0x3795
	push hl	; offset 0x3796
	ld hl,52428	; offset 0x3799
	push hl	; offset 0x379a
	ld hl,52428	; offset 0x379d
	push hl	; offset 0x379e
	ld hl,52428	; offset 0x37a1
	push hl	; offset 0x37a2
	ld hl,52428	; offset 0x37a5
	push hl	; offset 0x37a6
	ld hl,52428	; offset 0x37a9
	push hl	; offset 0x37aa

	; src_data blit 248
	ld sp,screenStartAddr+3312	; offset 0x37ad
	ld hl,52428	; offset 0x37b0
	push hl	; offset 0x37b1
	ld hl,52428	; offset 0x37b4
	push hl	; offset 0x37b5
	ld hl,52428	; offset 0x37b8
	push hl	; offset 0x37b9
	ld hl,52428	; offset 0x37bc
	push hl	; offset 0x37bd
	ld hl,52428	; offset 0x37c0
	push hl	; offset 0x37c1
	ld hl,52428	; offset 0x37c4
	push hl	; offset 0x37c5
	ld hl,52428	; offset 0x37c8
	push hl	; offset 0x37c9
	ld hl,52428	; offset 0x37cc
	push hl	; offset 0x37cd

	; src_data blit 249
	ld sp,screenStartAddr+3328	; offset 0x37d0
	ld hl,52428	; offset 0x37d3
	push hl	; offset 0x37d4
	ld hl,52428	; offset 0x37d7
	push hl	; offset 0x37d8
	ld hl,52428	; offset 0x37db
	push hl	; offset 0x37dc
	ld hl,52428	; offset 0x37df
	push hl	; offset 0x37e0
	ld hl,52428	; offset 0x37e3
	push hl	; offset 0x37e4
	ld hl,52428	; offset 0x37e7
	push hl	; offset 0x37e8
	ld hl,52428	; offset 0x37eb
	push hl	; offset 0x37ec
	ld hl,52428	; offset 0x37ef
	push hl	; offset 0x37f0

	; src_data blit 250
	ld sp,screenStartAddr+3568	; offset 0x37f3
	ld hl,52428	; offset 0x37f6
	push hl	; offset 0x37f7
	ld hl,52428	; offset 0x37fa
	push hl	; offset 0x37fb
	ld hl,52428	; offset 0x37fe
	push hl	; offset 0x37ff
	ld hl,52428	; offset 0x3802
	push hl	; offset 0x3803
	ld hl,52428	; offset 0x3806
	push hl	; offset 0x3807
	ld hl,52428	; offset 0x380a
	push hl	; offset 0x380b
	ld hl,52428	; offset 0x380e
	push hl	; offset 0x380f
	ld hl,52428	; offset 0x3812
	push hl	; offset 0x3813

	; src_data blit 251
	ld sp,screenStartAddr+3584	; offset 0x3816
	ld hl,52428	; offset 0x3819
	push hl	; offset 0x381a
	ld hl,52428	; offset 0x381d
	push hl	; offset 0x381e
	ld hl,52428	; offset 0x3821
	push hl	; offset 0x3822
	ld hl,52428	; offset 0x3825
	push hl	; offset 0x3826
	ld hl,52428	; offset 0x3829
	push hl	; offset 0x382a
	ld hl,52428	; offset 0x382d
	push hl	; offset 0x382e
	ld hl,52428	; offset 0x3831
	push hl	; offset 0x3832
	ld hl,52428	; offset 0x3835
	push hl	; offset 0x3836

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
	; Inter-bi-color delay
	nop
	nop
	nop
	; end attr draw 0, offset 0x388f
	; Clock offset: -864


	; Restore the stack pointer
	ld sp,(spBackupAddr)	; offset 0x3892
	ret

	SAVEBIN "sp48.rom",0,$
