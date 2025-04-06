#include "palette.h"

// bits are F B PPP III - flash bit means "do not change current attribute here" - so it's impossible to have flashing attribute tiles - I hate them, so, deal with it!
const uint8_t palette[4][6]={
    {0x87,0x87,0x87,0x87,0x87,0x87},    // No color - sprite will adopt color from the background
    {0x47,0x47,0x47,0x47,0x47,0x46},    // Used for player sprite - mostly white with yellow boots
    {0x47,0x47,0x47,0x47,0x47,0x47},    // All white, used for testing
    {0x42,0x42,0x42,0x42,0x42,0x42},    // All red, used for testing
};