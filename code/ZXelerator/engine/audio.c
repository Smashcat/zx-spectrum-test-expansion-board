#include "audio.h"

static uint8_t *audioOpcodePtr(int bankIX, int ix)
{
    if(ix<0){
        return NULL;
    }
    if(ix<AUDIO_LIST0_LEN){
        return ram[bankIX][0]+AUDIO_LIST0_OFFSET+(ix*2)+1;
    }
    ix-=AUDIO_LIST0_LEN;
    if(ix<AUDIO_LIST1_LEN){
        return ram[bankIX][1]+AUDIO_LIST1_OFFSET+(ix*2)+1;
    }
    return NULL;
}

void setAudioBit(int ix, bool on)
{
    uint8_t *p=audioOpcodePtr(writeBank,ix);
    if(p){
        *p=(on?AUDIO_OUT_ON:AUDIO_OUT_OFF);
    }
}

static void clearAudioBank(int bankIX)
{
    uint8_t *p=ram[bankIX][0]+AUDIO_LIST0_OFFSET+1;
    for(int n=0;n<AUDIO_LIST0_LEN;n++){
        *p=AUDIO_OUT_OFF;
        p+=2;
    }
    p=ram[bankIX][1]+AUDIO_LIST1_OFFSET+1;
    for(int n=0;n<AUDIO_LIST1_LEN;n++){
        *p=AUDIO_OUT_OFF;
        p+=2;
    }
}

void clearAudio(void)
{
    clearAudioBank(writeBank);
}

void clearAudioAllBanks(void)
{
    for(int n=0;n<TOTAL_RAMBANKS;n++){
        clearAudioBank(n);
    }
}

bool getAudioBit(int bankIX, int ix)
{
    const uint8_t *p=audioOpcodePtr(bankIX,ix);
    return p && (*p==AUDIO_OUT_ON);
}
