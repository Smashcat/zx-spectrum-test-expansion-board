// ZXelerator PC emulator - AVI recording (see pc_video.h)
//
// File layout (standard AVI 1.0):
//   RIFF 'AVI '
//     LIST 'hdrl'   avih, then a 'strl' list (strh + strf) for the video and for the audio stream
//     LIST 'movi'   '00db' (video frame) and '01wb' (audio) chunks, interleaved one of each per frame
//     idx1          index of every chunk
// Sizes and counts aren't known until the end, so they're written as zero and patched when the file is finished.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "pc_video.h"

#define FRAME_RATE          25
#define SCREEN_W            256
#define SCREEN_H            192
#define BORDER              32
#define VIDEO_W             (SCREEN_W+(BORDER*2))
#define VIDEO_H             (SCREEN_H+(BORDER*2))
#define AUDIO_RATE          48000
#define AUDIO_BYTES_PER_FRAME ((AUDIO_RATE/FRAME_RATE)*2)
#define MAX_FILE_BYTES      0x3f000000u     // Start a new part before 1GB

#define AVIF_HASINDEX       0x10
#define AVIF_ISINTERLEAVED  0x100
#define AVIIF_KEYFRAME      0x10

typedef struct IndexEntry {
    char ckid[4];
    uint32_t flags;
    uint32_t offset;
    uint32_t size;
} IndexEntry;

static FILE *file;
static char basePath[1024];
static int part;
static int scale=1;
static int width, height;
static uint32_t frameBytes;
static uint8_t *frameBuffer;
static uint32_t framesInFile;
static uint32_t audioBytesInFile;
static long hdrlListPos, riffSizePos, avihFramesPos, videoLengthPos, audioLengthPos, moviListPos, moviTypePos;
static IndexEntry *indexEntries;
static uint32_t indexCount, indexCapacity;

static void w32(uint32_t v)
{
    uint8_t b[4]={(uint8_t)v,(uint8_t)(v>>8),(uint8_t)(v>>16),(uint8_t)(v>>24)};
    fwrite(b,1,4,file);
}

static void w16(uint16_t v)
{
    uint8_t b[2]={(uint8_t)v,(uint8_t)(v>>8)};
    fwrite(b,1,2,file);
}

static void wfcc(const char *fcc)
{
    fwrite(fcc,1,4,file);
}

static void patch32(long pos, uint32_t v)
{
    const long here=ftell(file);
    fseek(file,pos,SEEK_SET);
    w32(v);
    fseek(file,here,SEEK_SET);
}

/// @brief Start a LIST, returning its position so endList can fill in the size
static long beginList(const char *type)
{
    const long pos=ftell(file);
    wfcc("LIST");
    w32(0);
    wfcc(type);
    return pos;
}

static void endList(long pos)
{
    patch32(pos+4,(uint32_t)(ftell(file)-pos-8));
}

/// @brief AVISTREAMHEADER (56 bytes). Returns the position of dwLength, for patching
static long writeStreamHeader(const char *type, const char *handler, uint32_t scaleVal, uint32_t rate,
    uint32_t bufferSize, uint32_t sampleSize, int16_t w, int16_t h)
{
    wfcc("strh");
    w32(56);
    wfcc(type);
    fwrite(handler,1,4,file);
    w32(0);                 // dwFlags
    w16(0);                 // wPriority
    w16(0);                 // wLanguage
    w32(0);                 // dwInitialFrames
    w32(scaleVal);          // dwScale
    w32(rate);              // dwRate (rate/scale = units per second)
    w32(0);                 // dwStart
    const long lengthPos=ftell(file);
    w32(0);                 // dwLength (patched)
    w32(bufferSize);        // dwSuggestedBufferSize
    w32(0xffffffff);        // dwQuality (default)
    w32(sampleSize);        // dwSampleSize
    w16(0);                 // rcFrame
    w16(0);
    w16((uint16_t)w);
    w16((uint16_t)h);
    return lengthPos;
}

static bool openPart(void)
{
    char path[1100];
    if(part==1){
        snprintf(path,sizeof(path),"%s",basePath);
    }else{
        // name.avi -> name_partN.avi
        const char *dot=strrchr(basePath,'.');
        const int stem=dot?(int)(dot-basePath):(int)strlen(basePath);
        snprintf(path,sizeof(path),"%.*s_part%d%s",stem,basePath,part,dot?dot:".avi");
    }
    file=fopen(path,"wb");
    if(!file){
        fprintf(stderr,"Can't create video file %s\n",path);
        return false;
    }
    framesInFile=0;
    audioBytesInFile=0;
    indexCount=0;

    wfcc("RIFF");
    riffSizePos=ftell(file);
    w32(0);
    wfcc("AVI ");

    hdrlListPos=beginList("hdrl");

    // MainAVIHeader
    wfcc("avih");
    w32(56);
    w32(1000000/FRAME_RATE);                                // dwMicroSecPerFrame
    w32((frameBytes+AUDIO_BYTES_PER_FRAME)*FRAME_RATE);     // dwMaxBytesPerSec
    w32(0);                                                 // dwPaddingGranularity
    w32(AVIF_HASINDEX|AVIF_ISINTERLEAVED);                  // dwFlags
    avihFramesPos=ftell(file);
    w32(0);                                                 // dwTotalFrames (patched)
    w32(0);                                                 // dwInitialFrames
    w32(2);                                                 // dwStreams
    w32(frameBytes);                                        // dwSuggestedBufferSize
    w32((uint32_t)width);
    w32((uint32_t)height);
    w32(0);
    w32(0);
    w32(0);
    w32(0);

    // Video stream - uncompressed bottom-up 24 bit DIB frames
    long strl=beginList("strl");
    videoLengthPos=writeStreamHeader("vids","DIB ",1,FRAME_RATE,frameBytes,0,(int16_t)width,(int16_t)height);
    wfcc("strf");
    w32(40);
    w32(40);                // biSize
    w32((uint32_t)width);   // biWidth
    w32((uint32_t)height);  // biHeight (positive = bottom-up)
    w16(1);                 // biPlanes
    w16(24);                // biBitCount
    w32(0);                 // biCompression (BI_RGB)
    w32(frameBytes);        // biSizeImage
    w32(0);
    w32(0);
    w32(0);                 // biClrUsed
    w32(0);                 // biClrImportant
    endList(strl);

    // Audio stream - 48kHz 16 bit mono PCM (dwScale/dwRate in blocks of 2 bytes)
    strl=beginList("strl");
    audioLengthPos=writeStreamHeader("auds","\0\0\0\0",2,AUDIO_RATE*2,AUDIO_BYTES_PER_FRAME,2,0,0);
    wfcc("strf");
    w32(18);
    w16(1);                 // wFormatTag (PCM)
    w16(1);                 // nChannels
    w32(AUDIO_RATE);        // nSamplesPerSec
    w32(AUDIO_RATE*2);      // nAvgBytesPerSec
    w16(2);                 // nBlockAlign
    w16(16);                // wBitsPerSample
    w16(0);                 // cbSize
    endList(strl);

    endList(hdrlListPos);

    moviListPos=beginList("movi");
    moviTypePos=moviListPos+8;
    printf("Recording to %s\n",path);
    return true;
}

static void closePart(void)
{
    if(!file){
        return;
    }
    endList(moviListPos);

    // Offsets are relative to the 'movi' list type
    wfcc("idx1");
    w32(indexCount*16);
    for(uint32_t n=0;n<indexCount;n++){
        fwrite(indexEntries[n].ckid,1,4,file);
        w32(indexEntries[n].flags);
        w32(indexEntries[n].offset);
        w32(indexEntries[n].size);
    }

    patch32(avihFramesPos,framesInFile);
    patch32(videoLengthPos,framesInFile);
    patch32(audioLengthPos,audioBytesInFile/2);
    patch32(riffSizePos,(uint32_t)(ftell(file)-8));
    fclose(file);
    file=NULL;
    printf("Recorded %u frames (%.1f seconds)\n",framesInFile,(double)framesInFile/FRAME_RATE);
}

static void writeChunk(const char *ckid, const void *data, uint32_t size)
{
    if(indexCount==indexCapacity){
        indexCapacity=indexCapacity?indexCapacity*2:1024;
        indexEntries=(IndexEntry *)realloc(indexEntries,indexCapacity*sizeof(IndexEntry));
    }
    IndexEntry *e=indexEntries+indexCount++;
    memcpy(e->ckid,ckid,4);
    e->flags=AVIIF_KEYFRAME;
    e->offset=(uint32_t)(ftell(file)-moviTypePos);
    e->size=size;

    wfcc(ckid);
    w32(size);
    fwrite(data,1,size,file);
    if(size&1){
        fputc(0,file);
    }
}

bool pcVideoStart(const char *path, int newScale)
{
    pcVideoStop();
    scale=(newScale<1)?1:((newScale>8)?8:newScale);
    width=VIDEO_W*scale;
    height=VIDEO_H*scale;
    frameBytes=(uint32_t)(width*height*3);  // Rows are a multiple of 4 bytes already
    frameBuffer=(uint8_t *)realloc(frameBuffer,frameBytes);
    snprintf(basePath,sizeof(basePath),"%s",path);
    part=1;
    return frameBuffer && openPart();
}

void pcVideoFrame(const uint32_t *screen, uint32_t border, const int16_t *samples, int numSamples)
{
    if(!file){
        return;
    }
    // Start a new part rather than go over the size limit
    if((uint32_t)ftell(file)+frameBytes+AUDIO_BYTES_PER_FRAME+64+((indexCount+2)*16)>MAX_FILE_BYTES){
        closePart();
        ++part;
        if(!openPart()){
            return;
        }
    }

    // Screen and border, scaled, as bottom-up BGR rows
    uint8_t *out=frameBuffer;
    for(int y=height-1;y>=0;y--){
        const int sy=(y/scale)-BORDER;
        for(int x=0;x<width;x++){
            const int sx=(x/scale)-BORDER;
            const uint32_t c=(sx>=0 && sx<SCREEN_W && sy>=0 && sy<SCREEN_H)?screen[(sy*SCREEN_W)+sx]:border;
            *out++=(uint8_t)c;
            *out++=(uint8_t)(c>>8);
            *out++=(uint8_t)(c>>16);
        }
    }
    writeChunk("00db",frameBuffer,frameBytes);
    ++framesInFile;

    // Audio (16 bit little endian, which matches the PC)
    if(samples && numSamples>0){
        writeChunk("01wb",samples,(uint32_t)numSamples*2);
        audioBytesInFile+=(uint32_t)numSamples*2;
    }
}

void pcVideoStop(void)
{
    closePart();
}

bool pcVideoRecording(void)
{
    return file!=NULL;
}
