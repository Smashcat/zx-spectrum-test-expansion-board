#include "synth.h"
#include <math.h>

// Phase is a 32 bit fraction of a cycle, so the top bit is the square wave output. The increment is per T-state,
// so the phase at any T-state in the frame is phase+(inc*t), wrapping naturally
static uint32_t voicePhase[SYNTH_VOICES];
static uint32_t voiceInc[SYNTH_VOICES];

void synthInit(void)
{
    for(int n=0;n<SYNTH_VOICES;n++){
        voicePhase[n]=0;
        voiceInc[n]=0;
    }
}

void synthSetFrequency(int voice, float hz)
{
    if(voice<0 || voice>=SYNTH_VOICES){
        return;
    }
    voiceInc[voice]=(hz>0.0f)?(uint32_t)(hz*(4294967296.0f/(float)AUDIO_Z80_CLOCK_HZ)):0;
}

void synthSetNote(int voice, int note)
{
    synthSetFrequency(voice,(note>0)?440.0f*powf(2.0f,(float)(note-69)/12.0f):0.0f);
}

void synthRender(void)
{
    int active[SYNTH_VOICES];
    int numActive=0;
    for(int n=0;n<SYNTH_VOICES;n++){
        if(voiceInc[n]){
            active[numActive++]=n;
        }
    }

    if(numActive==0){
        clearAudio();
    }else{
        // Each OUT plays the next active voice in turn
        int slot=0;
        for(int n=0;n<AUDIO_SAMPLES_PER_FRAME;n++){
            const int v=active[slot];
            if(++slot==numActive){
                slot=0;
            }
            const uint32_t phase=voicePhase[v]+(voiceInc[v]*audioSampleTState(n));
            setAudioBit(n,(phase>>31)!=0);
        }
    }

    // Keep the voices running in real time, ready for the next frame
    for(int n=0;n<SYNTH_VOICES;n++){
        voicePhase[n]+=voiceInc[n]*(uint32_t)AUDIO_TSTATES_PER_FRAME;
    }
}
