#include "inputDevice.h"

const char keyStr[9][5][6]={
    {"SPACE",   "SYM",  "M","N","B"},
    {"ENTER",   "L",    "K","J","H"},
    {"P",       "O",    "I","U","Y"},
    {"0",       "9",    "8","7","6"},
    {"1",       "2",    "3","4","5"},
    {"Q",       "W",    "E","R","T"},
    {"A",       "S",    "D","F","G"},
    {"CAPS",    "Z",    "X","C","V"},
    {"NONE",    "MULTI",".",".","."}
};

int keyDown(KeyMask which)
{
    return (keyboardScan[which>>5]&(which&0x1f)?1:0);
}

const char *keyScanToStr(int ix){
    const char (*p)[6]=keyStr[ix];
    const int keyBit=keyboardScan[ix]&0x1f;
    switch(keyBit){
        case 0x01:
            return p[0];
        case 0x02:
            return p[1];
        case 0x04:
            return p[2];
        case 0x08:
            return p[3];
        case 0x10:
           return p[4];
        default:
            // Nothing pressed?
            if(keyBit==0){
                return keyStr[8][0];
            // Must be multiple pressed
            }else{
                return keyStr[8][1];
            }
    }
}