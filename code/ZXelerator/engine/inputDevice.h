#pragma once

#include "defs.h"
#include <stdint.h>
#include "shared.h"

/// @brief Converts a key name to the index in the matrix - this is the form 0bsssbbbbb where sss is the segment (1-5,6-0,q-t,y-p etc) then the key within that segment
typedef enum KeyMask{

    KEY_1       =   (0x4<<5)+0x01,
    KEY_2       =   (0x4<<5)+0x02,
    KEY_3       =   (0x4<<5)+0x04,
    KEY_4       =   (0x4<<5)+0x08,
    KEY_5       =   (0x4<<5)+0x10,

    KEY_6       =   (0x3<<5)+0x10,
    KEY_7       =   (0x3<<5)+0x08,
    KEY_8       =   (0x3<<5)+0x04,
    KEY_9       =   (0x3<<5)+0x02,
    KEY_0       =   (0x3<<5)+0x01,

    KEY_Q       =   (0x5<<5)+0x01,
    KEY_W       =   (0x5<<5)+0x02,
    KEY_E       =   (0x5<<5)+0x04,
    KEY_R       =   (0x5<<5)+0x08,
    KEY_T       =   (0x5<<5)+0x10,

    KEY_Y       =   (0x2<<5)+0x10,
    KEY_U       =   (0x2<<5)+0x08,
    KEY_I       =   (0x2<<5)+0x04,
    KEY_O       =   (0x2<<5)+0x02,
    KEY_P       =   (0x2<<5)+0x01,

    KEY_A       =   (0x6<<5)+0x01,
    KEY_S       =   (0x6<<5)+0x02,
    KEY_D       =   (0x6<<5)+0x04,
    KEY_F       =   (0x6<<5)+0x08,
    KEY_G       =   (0x6<<5)+0x10,

    KEY_H       =   (0x1<<5)+0x10,
    KEY_J       =   (0x1<<5)+0x08,
    KEY_K       =   (0x1<<5)+0x04,
    KEY_L       =   (0x1<<5)+0x02,
    KEY_ENTER   =   (0x1<<5)+0x01,

    KEY_CAPS    =   (0x7<<5)+0x01,
    KEY_Z       =   (0x7<<5)+0x02,
    KEY_X       =   (0x7<<5)+0x04,
    KEY_C       =   (0x7<<5)+0x08,
    KEY_V       =   (0x7<<5)+0x10,

    KEY_B       =   (0x0<<5)+0x10,
    KEY_N       =   (0x0<<5)+0x08,
    KEY_M       =   (0x0<<5)+0x04,
    KEY_SYM     =   (0x0<<5)+0x02,
    KEY_SPACE   =   (0x0<<5)+0x01,

} KeyMask;

int keyDown(KeyMask which);

const char *keyScanToStr(int ix);
