// ZXelerator PC emulator - beeper audio
//
// Each frame, the speaker bits are read back from the ASM bank the Z80 is running (the same OUT lists
// the real Spectrum would execute), placed on a T-state timeline for the 2 TV frame period, then
// downsampled to 48kHz and queued to the SDL audio device (and optionally written to a WAV file)

#include <SDL.h>
#include <stdio.h>
#include <string.h>

#include "pc_audio.h"
#include "audio.h"

#define AUDIO_RATE              48000
#define TSTATES_PER_FRAME       AUDIO_TSTATES_PER_FRAME
#define SAMPLES_PER_FRAME       (AUDIO_RATE/25)
#define MAX_QUEUED_FRAMES       3
#define AMPLITUDE               12000.0f
// The OUT list timings (AUDIO_LIST0_START_T etc.) are in engine/audio.h, shared with the synth

static SDL_AudioDeviceID audioDevice;
static bool muted=false;
static uint8_t speakerLevel;
static uint8_t levelTimeline[TSTATES_PER_FRAME];
static int timelinePos;
static float dcPrevIn, dcPrevOut;
static int16_t frameSamples[SAMPLES_PER_FRAME];

static FILE *wavFile;
static uint32_t wavSamples;

static void levelUntil(int t)
{
    if(t>TSTATES_PER_FRAME){
        t=TSTATES_PER_FRAME;
    }
    if(t>timelinePos){
        memset(levelTimeline+timelinePos,speakerLevel,t-timelinePos);
        timelinePos=t;
    }
}

static void writeWavHeader(void)
{
    const uint32_t dataBytes=wavSamples*2;
    const uint32_t riffSize=36+dataBytes;
    const uint32_t fmtSize=16, rate=AUDIO_RATE, byteRate=AUDIO_RATE*2;
    const uint16_t format=1, channels=1, blockAlign=2, bits=16;
    fseek(wavFile,0,SEEK_SET);
    fwrite("RIFF",1,4,wavFile);
    fwrite(&riffSize,4,1,wavFile);
    fwrite("WAVEfmt ",1,8,wavFile);
    fwrite(&fmtSize,4,1,wavFile);
    fwrite(&format,2,1,wavFile);
    fwrite(&channels,2,1,wavFile);
    fwrite(&rate,4,1,wavFile);
    fwrite(&byteRate,4,1,wavFile);
    fwrite(&blockAlign,2,1,wavFile);
    fwrite(&bits,2,1,wavFile);
    fwrite("data",1,4,wavFile);
    fwrite(&dataBytes,4,1,wavFile);
    fseek(wavFile,0,SEEK_END);
}

void pcAudioInit(bool startMuted, const char *wavPath)
{
    muted=startMuted;

    if(wavPath){
        wavFile=fopen(wavPath,"wb");
        if(wavFile){
            writeWavHeader();
        }else{
            fprintf(stderr,"Unable to create %s\n",wavPath);
        }
    }

    SDL_AudioSpec want, have;
    SDL_zero(want);
    want.freq=AUDIO_RATE;
    want.format=AUDIO_S16SYS;
    want.channels=1;
    want.samples=512;
    audioDevice=SDL_OpenAudioDevice(NULL,0,&want,&have,0);
    if(!audioDevice){
        fprintf(stderr,"No audio: %s\n",SDL_GetError());
        return;
    }
    // Start with a frame of silence queued, to absorb timing jitter
    memset(frameSamples,0,sizeof(frameSamples));
    SDL_QueueAudio(audioDevice,frameSamples,sizeof(frameSamples));
    SDL_PauseAudioDevice(audioDevice,0);
}

void pcAudioShutdown(void)
{
    if(audioDevice){
        SDL_CloseAudioDevice(audioDevice);
        audioDevice=0;
    }
    if(wavFile){
        writeWavHeader();
        fclose(wavFile);
        wavFile=NULL;
    }
}

bool pcAudioToggleMute(void)
{
    muted=!muted;
    if(muted && audioDevice){
        SDL_ClearQueuedAudio(audioDevice);
    }
    return muted;
}

void pcAudioFrame(int bankIX)
{
    // Build the speaker level for every T-state of the frame (the level persists from the previous frame)
    timelinePos=0;
    levelUntil(AUDIO_BORDER_OUT_START_T);
    speakerLevel=0;
    for(int n=0;n<AUDIO_LIST0_LEN;n++){
        levelUntil(AUDIO_LIST0_START_T+(n*AUDIO_TSTATES_PER_SAMPLE));
        speakerLevel=getAudioBit(bankIX,n);
    }
    for(int n=0;n<AUDIO_LIST1_LEN;n++){
        levelUntil(AUDIO_LIST1_START_T+(n*AUDIO_TSTATES_PER_SAMPLE));
        speakerLevel=getAudioBit(bankIX,AUDIO_LIST0_LEN+n);
    }
    levelUntil(AUDIO_LIST1_START_T+(AUDIO_LIST1_LEN*AUDIO_TSTATES_PER_SAMPLE)+AUDIO_BORDER_OUT_END_DELAY_T);
    speakerLevel=0;
    levelUntil(TSTATES_PER_FRAME);

    // Downsample by averaging the level over each output sample, then remove DC so a held level
    // fades out as it does on a real speaker
    for(int s=0;s<SAMPLES_PER_FRAME;s++){
        const int t0=(int)(((int64_t)s*TSTATES_PER_FRAME)/SAMPLES_PER_FRAME);
        const int t1=(int)(((int64_t)(s+1)*TSTATES_PER_FRAME)/SAMPLES_PER_FRAME);
        int sum=0;
        for(int t=t0;t<t1;t++){
            sum+=levelTimeline[t];
        }
        const float in=(float)sum/(float)(t1-t0);
        const float out=in-dcPrevIn+(0.995f*dcPrevOut);
        dcPrevIn=in;
        dcPrevOut=out;
        float v=out*AMPLITUDE;
        if(v>32767.0f){
            v=32767.0f;
        }else if(v<-32768.0f){
            v=-32768.0f;
        }
        frameSamples[s]=(int16_t)v;
    }

    if(wavFile){
        fwrite(frameSamples,sizeof(int16_t),SAMPLES_PER_FRAME,wavFile);
        wavSamples+=SAMPLES_PER_FRAME;
    }

    // Skip queuing if we're running ahead (e.g. fast forward) to keep latency down
    if(audioDevice && !muted &&
        SDL_GetQueuedAudioSize(audioDevice)<(Uint32)(MAX_QUEUED_FRAMES*sizeof(frameSamples))){
        SDL_QueueAudio(audioDevice,frameSamples,sizeof(frameSamples));
    }
}

const int16_t *pcAudioFrameSamples(int *count)
{
    *count=SAMPLES_PER_FRAME;
    return frameSamples;
}
