// ZXelerator PC emulator
//
// Runs the game code as it would on the RP2350's game core, but instead of the Z80
// reading the generated ASM buffers, the display is decoded here and shown in an
// SDL window, and the PC keyboard is fed back into keyboardScan[].
//
// Keys:
//   Spectrum keys  - letters, digits, Enter, Space, Shift (CAPS SHIFT), Ctrl (SYMBOL SHIFT)
//   Cursor keys    - CAPS SHIFT + 5/6/7/8, Backspace = CAPS SHIFT + 0 (as on a Spectrum+)
//   F2             - toggle display source: ASM bank (what the Z80 would draw) / render buffer
//   F3             - mute / unmute beeper audio
//   F5             - pause / resume
//   F6             - step a single frame while paused
//   Tab (hold)     - fast forward (no frame rate limit)
//   F12            - save a screenshot (screenshot_NNNNN.bmp in the current directory)
//   Esc            - quit
//
// Command line:
//   --shot FRAME FILE.bmp   save a screenshot when FRAME is displayed (can be repeated), then
//                           exit after the last one - handy for automated checks
//   --fast                  run without the frame rate limit
//   --hold FROM TO KEY      hold a PC key down from frame FROM until frame TO (can be repeated), using SDL key
//                           names such as M, Space, Left - for scripted tests, e.g. --hold 40 45 M
//   --mute                  start with audio muted
//   --wav FILE.wav          record the beeper audio to a WAV file

#include <SDL.h>
#include <stdio.h>
#include <string.h>

#include "game.h"
#include "pc_audio.h"

#define FRAME_RATE      25      // The Z80 display code takes 2 TV frames per game frame
#define BORDER          32
#define WINDOW_WIDTH    (SCREEN_WIDTH_PIXELS+(BORDER*2))
#define WINDOW_HEIGHT   (SCREEN_HEIGHT_LINES+(BORDER*2))
#define DEFAULT_SCALE   3

static SDL_Window *window;
static SDL_Renderer *renderer;
static SDL_Texture *screenTexture;
static uint32_t screenPixels[SCREEN_WIDTH_PIXELS*SCREEN_HEIGHT_LINES];

static bool showRenderBuffer=false;
static bool paused=false;
static bool stepFrame=false;
static bool alwaysFast=false;

#define MAX_SHOTS 16
typedef struct Shot {
    uint32_t frame;
    const char *path;
} Shot;
static Shot shots[MAX_SHOTS];
static int numShots;
static int shotsTaken;

#define MAX_HOLDS 32
typedef struct KeyHold {
    uint32_t from;
    uint32_t to;
    SDL_Scancode scancode;
} KeyHold;
static KeyHold holds[MAX_HOLDS];
static int numHolds;

static bool scriptedKeyDown(SDL_Scancode sc)
{
    for(int n=0;n<numHolds;n++){
        if(holds[n].scancode==sc && frameDisplayed>=holds[n].from && frameDisplayed<holds[n].to){
            return true;
        }
    }
    return false;
}

static uint64_t perfFreq;
static uint64_t nextFrameTime;
static uint64_t workStartTime;
static uint64_t statsStartTime;
static uint64_t workTimeTotal;
static uint64_t workTimeMax;
static int statsFrames;

static const uint32_t zxColours[16]={
    0xff000000,0xff0000d7,0xffd70000,0xffd700d7,0xff00d700,0xff00d7d7,0xffd7d700,0xffd7d7d7,
    0xff000000,0xff0000ff,0xffff0000,0xffff00ff,0xff00ff00,0xff00ffff,0xffffff00,0xffffffff,
};

typedef struct KeyMapping {
    SDL_Scancode scancode;
    KeyMask key;
    KeyMask shiftKey;   // 0 for none
} KeyMapping;

static const KeyMapping keyMap[]={
    {SDL_SCANCODE_1,KEY_1,0},{SDL_SCANCODE_2,KEY_2,0},{SDL_SCANCODE_3,KEY_3,0},{SDL_SCANCODE_4,KEY_4,0},{SDL_SCANCODE_5,KEY_5,0},
    {SDL_SCANCODE_6,KEY_6,0},{SDL_SCANCODE_7,KEY_7,0},{SDL_SCANCODE_8,KEY_8,0},{SDL_SCANCODE_9,KEY_9,0},{SDL_SCANCODE_0,KEY_0,0},
    {SDL_SCANCODE_Q,KEY_Q,0},{SDL_SCANCODE_W,KEY_W,0},{SDL_SCANCODE_E,KEY_E,0},{SDL_SCANCODE_R,KEY_R,0},{SDL_SCANCODE_T,KEY_T,0},
    {SDL_SCANCODE_Y,KEY_Y,0},{SDL_SCANCODE_U,KEY_U,0},{SDL_SCANCODE_I,KEY_I,0},{SDL_SCANCODE_O,KEY_O,0},{SDL_SCANCODE_P,KEY_P,0},
    {SDL_SCANCODE_A,KEY_A,0},{SDL_SCANCODE_S,KEY_S,0},{SDL_SCANCODE_D,KEY_D,0},{SDL_SCANCODE_F,KEY_F,0},{SDL_SCANCODE_G,KEY_G,0},
    {SDL_SCANCODE_H,KEY_H,0},{SDL_SCANCODE_J,KEY_J,0},{SDL_SCANCODE_K,KEY_K,0},{SDL_SCANCODE_L,KEY_L,0},{SDL_SCANCODE_RETURN,KEY_ENTER,0},
    {SDL_SCANCODE_Z,KEY_Z,0},{SDL_SCANCODE_X,KEY_X,0},{SDL_SCANCODE_C,KEY_C,0},{SDL_SCANCODE_V,KEY_V,0},
    {SDL_SCANCODE_B,KEY_B,0},{SDL_SCANCODE_N,KEY_N,0},{SDL_SCANCODE_M,KEY_M,0},{SDL_SCANCODE_SPACE,KEY_SPACE,0},
    {SDL_SCANCODE_LSHIFT,KEY_CAPS,0},{SDL_SCANCODE_RSHIFT,KEY_CAPS,0},
    {SDL_SCANCODE_LCTRL,KEY_SYM,0},{SDL_SCANCODE_RCTRL,KEY_SYM,0},
    {SDL_SCANCODE_LEFT,KEY_5,KEY_CAPS},{SDL_SCANCODE_DOWN,KEY_6,KEY_CAPS},
    {SDL_SCANCODE_UP,KEY_7,KEY_CAPS},{SDL_SCANCODE_RIGHT,KEY_8,KEY_CAPS},
    {SDL_SCANCODE_BACKSPACE,KEY_0,KEY_CAPS},
};

static void pressKey(uint8_t *scan, KeyMask k)
{
    scan[k>>5]|=(k&0x1f);
}

// Build keyboardScan[] as core0 does from the Z80's half-row reads (a set bit means the key is down)
static void updateKeyboard(void)
{
    uint8_t scan[8]={0};
    const Uint8 *state=SDL_GetKeyboardState(NULL);
    for(size_t n=0;n<sizeof(keyMap)/sizeof(keyMap[0]);n++){
        if(state[keyMap[n].scancode] || scriptedKeyDown(keyMap[n].scancode)){
            pressKey(scan,keyMap[n].key);
            if(keyMap[n].shiftKey){
                pressKey(scan,keyMap[n].shiftKey);
            }
        }
    }
    memcpy(keyboardScan,scan,sizeof(scan));
}

static void saveScreenshot(const char *path)
{
    SDL_Surface *surface=SDL_CreateRGBSurfaceWithFormatFrom(screenPixels,SCREEN_WIDTH_PIXELS,SCREEN_HEIGHT_LINES,
        32,SCREEN_WIDTH_PIXELS*sizeof(uint32_t),SDL_PIXELFORMAT_ARGB8888);
    if(!surface || SDL_SaveBMP(surface,path)!=0){
        fprintf(stderr,"Failed to save screenshot %s: %s\n",path,SDL_GetError());
    }else{
        printf("Saved %s (frame %u)\n",path,(unsigned)frameDisplayed);
    }
    SDL_FreeSurface(surface);
}

static void handleEvents(void)
{
    SDL_Event e;
    while(SDL_PollEvent(&e)){
        switch(e.type){
            case SDL_QUIT:
                exit(0);
            case SDL_KEYDOWN:
                if(e.key.repeat){
                    break;
                }
                switch(e.key.keysym.sym){
                    case SDLK_ESCAPE:
                        exit(0);
                    case SDLK_F2:
                        showRenderBuffer=!showRenderBuffer;
                        break;
                    case SDLK_F3:
                        printf("Audio %s\n",pcAudioToggleMute()?"muted":"on");
                        break;
                    case SDLK_F5:
                        paused=!paused;
                        break;
                    case SDLK_F6:
                        stepFrame=true;
                        break;
                    case SDLK_F12:
                    {
                        char path[64];
                        snprintf(path,sizeof(path),"screenshot_%05u.bmp",(unsigned)frameDisplayed);
                        saveScreenshot(path);
                        break;
                    }
                    default:
                        break;
                }
                break;
            default:
                break;
        }
    }
}

// Decode the display into screenPixels, either from the ASM bank the Z80 would currently be
// executing (pixel bytes and the bi-colour attributes are embedded in the code), or directly
// from the compositor's render buffers
static void drawScreen(void)
{
    const uint8_t *bank0=(const uint8_t *)ram[readBank][0];
    const uint8_t *bank1=(const uint8_t *)ram[readBank][1];
    const bool flashInvert=((SDL_GetTicks()/320)&1)!=0;

    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
            const int pixIX=(y*SCREEN_WIDTH_CELLS)+cx;
            const int attrIX=((y/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS)+cx;
            uint8_t pix, attr;
            if(showRenderBuffer){
                pix=renderBuffer[pixIX];
                attr=renderAttrBuffer[attrIX];
            }else{
                pix=bank0[dispOffset[pixIX]];
                attr=bank1[attrOffset[1][attrIX]];
            }

            const int bright=(attr&0x40)?8:0;
            uint32_t ink=zxColours[(attr&0x07)+bright];
            uint32_t paper=zxColours[((attr>>3)&0x07)+bright];
            if((attr&0x80) && flashInvert){
                const uint32_t t=ink;
                ink=paper;
                paper=t;
            }

            uint32_t *out=screenPixels+(y*SCREEN_WIDTH_PIXELS)+(cx*8);
            for(int b=0;b<8;b++){
                out[b]=(pix&(0x80>>b))?ink:paper;
            }
        }
    }

    SDL_UpdateTexture(screenTexture,NULL,screenPixels,SCREEN_WIDTH_PIXELS*sizeof(uint32_t));
    SDL_SetRenderDrawColor(renderer,0,0,0,255);
    SDL_RenderClear(renderer);
    const SDL_Rect dst={BORDER,BORDER,SCREEN_WIDTH_PIXELS,SCREEN_HEIGHT_LINES};
    SDL_RenderCopy(renderer,screenTexture,NULL,&dst);
    SDL_RenderPresent(renderer);
}

static void updateStats(uint64_t now)
{
    if(now-statsStartTime<perfFreq){
        return;
    }
    char title[160];
    const double fps=(double)statsFrames*(double)perfFreq/(double)(now-statsStartTime);
    const double avgMs=statsFrames?(1000.0*(double)workTimeTotal/(double)perfFreq)/statsFrames:0.0;
    const double maxMs=1000.0*(double)workTimeMax/(double)perfFreq;
    snprintf(title,sizeof(title),"ZXelerator PC - %.1f fps - game+composite %.2fms avg, %.2fms max (PC time) - %s%s",
        fps,avgMs,maxMs,showRenderBuffer?"render buffer":"ASM bank",paused?" - PAUSED":"");
    SDL_SetWindowTitle(window,title);
    statsStartTime=now;
    statsFrames=0;
    workTimeTotal=0;
    workTimeMax=0;
}

void pc_waitForFrame(void)
{
    uint64_t now=SDL_GetPerformanceCounter();
    const uint64_t workTime=now-workStartTime;
    workTimeTotal+=workTime;
    if(workTime>workTimeMax){
        workTimeMax=workTime;
    }

    const uint64_t framePeriod=perfFreq/FRAME_RATE;
    for(;;){
        handleEvents();
        const bool fastForward=alwaysFast || SDL_GetKeyboardState(NULL)[SDL_SCANCODE_TAB]!=0;
        now=SDL_GetPerformanceCounter();

        if(paused && !stepFrame){
            drawScreen();
            updateStats(now);
            SDL_Delay(10);
            nextFrameTime=now;
            continue;
        }
        if(fastForward || now>=nextFrameTime){
            break;
        }
        const uint64_t remainingMs=((nextFrameTime-now)*1000)/perfFreq;
        if(remainingMs>1){
            SDL_Delay((Uint32)(remainingMs-1));
        }
    }
    stepFrame=false;

    // Keep to a steady rate, but don't try to catch up if we fell behind (e.g. while paused)
    nextFrameTime+=framePeriod;
    if(now>nextFrameTime){
        nextFrameTime=now+framePeriod;
    }

    // Emulate core0 at the start of a Z80 frame: swap to the newly generated ASM bank if ready
    if(flipBank){
        if(++readBank==TOTAL_RAMBANKS){
            readBank=0;
        }
        if(++writeBank==TOTAL_RAMBANKS){
            writeBank=0;
        }
    }
    ++frameDisplayed;
    flipBank=0;

    pcAudioFrame(readBank);
    drawScreen();
    for(int n=0;n<numShots;n++){
        if(shots[n].frame==frameDisplayed){
            saveScreenshot(shots[n].path);
            if(++shotsTaken==numShots){
                exit(0);
            }
        }
    }
    updateKeyboard();
    ++statsFrames;
    updateStats(now);

    workStartTime=SDL_GetPerformanceCounter();
}

void sleep_ms(uint32_t ms)
{
    SDL_Delay(ms);
}

void busy_wait_ms(uint32_t ms)
{
    SDL_Delay(ms);
}

void busy_wait_us_32(uint32_t us)
{
    const uint64_t end=SDL_GetPerformanceCounter()+((uint64_t)us*perfFreq)/1000000;
    while(SDL_GetPerformanceCounter()<end){
    }
}

uint64_t time_us_64(void)
{
    return (SDL_GetPerformanceCounter()*1000000)/perfFreq;
}

static void pcShutdown(void)
{
    pcAudioShutdown();
    if(screenTexture){
        SDL_DestroyTexture(screenTexture);
    }
    if(renderer){
        SDL_DestroyRenderer(renderer);
    }
    if(window){
        SDL_DestroyWindow(window);
    }
    SDL_Quit();
}

int main(int argc, char *argv[])
{
    bool startMuted=false;
    const char *wavPath=NULL;
    for(int n=1;n<argc;n++){
        if(strcmp(argv[n],"--shot")==0 && n+2<argc && numShots<MAX_SHOTS){
            shots[numShots].frame=(uint32_t)strtoul(argv[n+1],NULL,10);
            shots[numShots].path=argv[n+2];
            ++numShots;
            n+=2;
        }else if(strcmp(argv[n],"--fast")==0){
            alwaysFast=true;
        }else if(strcmp(argv[n],"--hold")==0 && n+3<argc && numHolds<MAX_HOLDS){
            holds[numHolds].from=(uint32_t)strtoul(argv[n+1],NULL,10);
            holds[numHolds].to=(uint32_t)strtoul(argv[n+2],NULL,10);
            holds[numHolds].scancode=SDL_GetScancodeFromName(argv[n+3]);
            if(holds[numHolds].scancode==SDL_SCANCODE_UNKNOWN){
                fprintf(stderr,"Unknown key name: %s\n",argv[n+3]);
                return 1;
            }
            ++numHolds;
            n+=3;
        }else if(strcmp(argv[n],"--mute")==0){
            startMuted=true;
        }else if(strcmp(argv[n],"--wav")==0 && n+1<argc){
            wavPath=argv[++n];
        }else{
            fprintf(stderr,"Unknown/incomplete option: %s\n",argv[n]);
            return 1;
        }
    }

    if(SDL_Init(SDL_INIT_VIDEO|SDL_INIT_TIMER|SDL_INIT_AUDIO)!=0){
        fprintf(stderr,"SDL_Init failed: %s\n",SDL_GetError());
        return 1;
    }
    atexit(pcShutdown);

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY,"0");
    window=SDL_CreateWindow("ZXelerator PC",SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,
        WINDOW_WIDTH*DEFAULT_SCALE,WINDOW_HEIGHT*DEFAULT_SCALE,SDL_WINDOW_RESIZABLE);
    renderer=window?SDL_CreateRenderer(window,-1,SDL_RENDERER_ACCELERATED):NULL;
    screenTexture=renderer?SDL_CreateTexture(renderer,SDL_PIXELFORMAT_ARGB8888,SDL_TEXTUREACCESS_STREAMING,
        SCREEN_WIDTH_PIXELS,SCREEN_HEIGHT_LINES):NULL;
    if(!screenTexture){
        fprintf(stderr,"SDL window setup failed: %s\n",SDL_GetError());
        return 1;
    }
    SDL_RenderSetLogicalSize(renderer,WINDOW_WIDTH,WINDOW_HEIGHT);
    SDL_RenderSetIntegerScale(renderer,SDL_TRUE);

    pcAudioInit(startMuted,wavPath);

    perfFreq=SDL_GetPerformanceFrequency();
    nextFrameTime=SDL_GetPerformanceCounter();
    statsStartTime=nextFrameTime;
    workStartTime=nextFrameTime;

    // As setupIO() does on the hardware - start all ASM banks with the reset data
    for(int n=0;n<TOTAL_RAMBANKS;n++){
        memcpy(ram[n][0],resetBank[0],sizeof(ram[n]));
    }

    gameLoop();
    return 0;
}
