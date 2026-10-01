// levelconv - converts Tiled maps into packed ZXelerator levels (engine/level.h), and makes Tiled tile sets from the
// engine's tile graphics. See levels/README.md
//
//   levelconv level <map.tmx|.tmj> [output folder]    Convert a level (output defaults to the map's folder)
//   levelconv all <folder> [output folder]            Convert every map in a folder
//   levelconv tileset <tileset.tsj> [engine tiles]    Make a Tiled tile set for engine tile graphics (e.g.
//                                                     levelDemoTileDef), or redraw its image after changing its colours
//   Options (before the command): --tiled <path to tiled.exe>
//
// Maps are read through Tiled's own command line export (so .tmx, .tsx and every layer format work), falling back to
// reading .tmj files directly (with embedded or .tsj tile sets) if Tiled can't be found

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <stdbool.h>
#include <ctype.h>
#include <math.h>
#include <sys/stat.h>
#ifdef _WIN32
#include <process.h>
#include <io.h>
#include <windows.h>
#else
#include <dirent.h>
#include <unistd.h>
#endif

#include "cJSON.h"
#include "miniz.h"
#include "lzPack.h"
#include "lzUnpack.h"
#include "tileSetRegistry.h"
#include "defs.h"
#include "level.h"
#include "palette.h"

#define MAX_TILESETS    16
#define MAX_LAYERS      32
#define MAX_ANIMS       64
#define MAX_FRAMES      32
#define MAX_OBJECTS     4096
#define MAX_CLASSES     250
#define MAX_PROPS       250
#define FLIP_BITS       0xF0000000u
#define FLIP_X_BIT      0x80000000u
#define FLIP_Y_BIT      0x40000000u

static const char *tiledExe=NULL;
static const char *currentFile="";
static int warnings=0;

static void fail(const char *fmt, ...)
{
    va_list ap;
    va_start(ap,fmt);
    fprintf(stderr,"%s: error: ",currentFile);
    vfprintf(stderr,fmt,ap);
    fprintf(stderr,"\n");
    va_end(ap);
    exit(1);
}

static void warn(const char *fmt, ...)
{
    va_list ap;
    va_start(ap,fmt);
    fprintf(stderr,"%s: warning: ",currentFile);
    vfprintf(stderr,fmt,ap);
    fprintf(stderr,"\n");
    va_end(ap);
    ++warnings;
}

static char *readFile(const char *path, size_t *size)
{
    FILE *f=fopen(path,"rb");
    if(!f){
        return NULL;
    }
    fseek(f,0,SEEK_END);
    const long n=ftell(f);
    fseek(f,0,SEEK_SET);
    char *buf=malloc((size_t)n+1);
    if(fread(buf,1,(size_t)n,f)!=(size_t)n){
        fclose(f);
        free(buf);
        return NULL;
    }
    buf[n]=0;
    fclose(f);
    if(size){
        *size=(size_t)n;
    }
    return buf;
}

static bool fileExists(const char *path)
{
    struct stat st;
    return stat(path,&st)==0;
}

static bool endsWith(const char *s, const char *end)
{
    const size_t a=strlen(s), b=strlen(end);
    if(a<b){
        return false;
    }
    for(size_t n=0;n<b;n++){
        if(tolower((unsigned char)s[a-b+n])!=tolower((unsigned char)end[n])){
            return false;
        }
    }
    return true;
}

// Folder part of a path (with a trailing separator), or "" if there's none
static void dirOf(const char *path, char *out, size_t outSize)
{
    snprintf(out,outSize,"%s",path);
    char *s=strrchr(out,'/');
    char *b=strrchr(out,'\\');
    if(b>s){
        s=b;
    }
    if(s){
        s[1]=0;
    }else{
        out[0]=0;
    }
}

// File name without its folder or extension
static void baseName(const char *path, char *out, size_t outSize)
{
    const char *s=strrchr(path,'/');
    const char *b=strrchr(path,'\\');
    if(b>s){
        s=b;
    }
    snprintf(out,outSize,"%s",s?s+1:path);
    char *dot=strrchr(out,'.');
    if(dot){
        *dot=0;
    }
}

// A C identifier from a name
static void identifier(const char *name, char *out, size_t outSize)
{
    size_t n=0;
    for(const char *p=name;*p && n+1<outSize;p++){
        out[n++]=isalnum((unsigned char)*p)?*p:'_';
    }
    out[n]=0;
    if(n==0 || isdigit((unsigned char)out[0])){
        memmove(out+1,out,n+1);
        out[0]='_';
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Tiled's JSON
// ---------------------------------------------------------------------------------------------------------------------

static int jsonInt(const cJSON *o, const char *name, int def)
{
    const cJSON *v=cJSON_GetObjectItemCaseSensitive(o,name);
    return cJSON_IsNumber(v)?(int)v->valuedouble:def;
}

static double jsonDouble(const cJSON *o, const char *name, double def)
{
    const cJSON *v=cJSON_GetObjectItemCaseSensitive(o,name);
    return cJSON_IsNumber(v)?v->valuedouble:def;
}

static const char *jsonString(const cJSON *o, const char *name, const char *def)
{
    const cJSON *v=cJSON_GetObjectItemCaseSensitive(o,name);
    return cJSON_IsString(v)?v->valuestring:def;
}

// A custom property's value (from a "properties" list), or NULL
static const cJSON *property(const cJSON *o, const char *name)
{
    const cJSON *props=cJSON_GetObjectItemCaseSensitive(o,"properties");
    const cJSON *p;
    cJSON_ArrayForEach(p,props){
        const char *n=jsonString(p,"name",NULL);
        if(n && strcmp(n,name)==0){
            return cJSON_GetObjectItemCaseSensitive(p,"value");
        }
    }
    return NULL;
}

static bool propBool(const cJSON *o, const char *name, bool def)
{
    const cJSON *v=property(o,name);
    if(cJSON_IsBool(v)){
        return cJSON_IsTrue(v);
    }
    if(cJSON_IsNumber(v)){
        return v->valuedouble!=0;
    }
    if(cJSON_IsString(v)){
        return strcmp(v->valuestring,"true")==0 || strcmp(v->valuestring,"1")==0;
    }
    return def;
}

static int propInt(const cJSON *o, const char *name, int def)
{
    const cJSON *v=property(o,name);
    if(cJSON_IsNumber(v)){
        return (int)v->valuedouble;
    }
    if(cJSON_IsString(v) && v->valuestring[0]){
        return atoi(v->valuestring);
    }
    return def;
}

static const char *propString(const cJSON *o, const char *name)
{
    const cJSON *v=property(o,name);
    return (cJSON_IsString(v) && v->valuestring[0])?v->valuestring:NULL;
}

static const char *colourNames[8]={"black","blue","red","magenta","green","cyan","yellow","white"};

// A colour property: a ZXColour name, or 0-7. -1 if it isn't set
static int propColour(const cJSON *o, const char *name)
{
    const cJSON *v=property(o,name);
    if(cJSON_IsNumber(v)){
        return ((int)v->valuedouble)&7;
    }
    if(cJSON_IsString(v)){
        for(int n=0;n<8;n++){
            if(strcmp(v->valuestring,colourNames[n])==0){
                return n;
            }
        }
        if(isdigit((unsigned char)v->valuestring[0])){
            return atoi(v->valuestring)&7;
        }
        if(v->valuestring[0]){
            warn("unknown colour \"%s\" for property %s",v->valuestring,name);
        }
    }
    return -1;
}

// ---------------------------------------------------------------------------------------------------------------------
// Tile sets
// ---------------------------------------------------------------------------------------------------------------------

typedef struct Anim {
    int def;
    int frameCount;
    int frames[MAX_FRAMES];
    int ticks[MAX_FRAMES];
} Anim;

typedef struct TileSet {
    const cJSON *json;
    int firstGid;
    int tileCount;
    const char *name;
    const char *engineName;
    const uint8_t *tiles;
    int tileSize;               // 8 or 16
    uint8_t attrs[2048];        // 2 a tile (8x8), or 8 a tile (16x16: top and bottom of each quarter)
    uint8_t flags[256];
    Anim anims[MAX_ANIMS];
    int animCount;
    bool used;
    int levelIndex;
    // Sprite sheets (tile sets made from engine sprite graphics, for placing sprites as tile objects)
    const char *spriteName;
    const char *maskName;
    const uint8_t *spriteData;
    const uint8_t *maskData;
    int spriteW, spriteH, frames, palette;
    const char *alignment;
    bool spriteUsed;
    bool layerUsed;             // Used by a tile layer (not just tile objects)
    int sheetIndex;
    // Imported from a PNG (levelconv import / importsprites): its graphics are read from the image each time, and
    // written to levels/gfx_<engine name>.c - rather than coming from engine/tileDefs.c or spriteDefs.c
    bool imported;
    uint8_t *importedData;      // Tiles: graphics then masks. Sprites: graphics, then masks at importedMask
    uint8_t *importedMask;
    int importedSize;           // Bytes of graphics (and as many of masks)
} TileSet;

// Engine sprite sizes (SpriteSize) that sprite sheets can be
static const int spriteSizes[][2]={{8,4},{8,8},{8,12},{8,16},{16,8},{16,12},{16,16},{16,24},{24,24},{24,32},{24,40},{24,48},
    {24,64},{32,40},{32,8},{16,32}};

static bool spriteSizeValid(int w, int h)
{
    for(int n=0;n<(int)(sizeof(spriteSizes)/sizeof(spriteSizes[0]));n++){
        if(spriteSizes[n][0]==w && spriteSizes[n][1]==h){
            return true;
        }
    }
    return false;
}

static int spriteBytesPerRow(int w)
{
    return (w==24)?4:(w>>3);
}

// ---------------------------------------------------------------------------
// Imported graphics: PNG images turned into engine tiles and sprites
// ---------------------------------------------------------------------------

// The Spectrum's colours: 0-7, then 8-15 bright
static const uint8_t zxColours[16][3]={
    {0,0,0},{0,0,0xD7},{0xD7,0,0},{0xD7,0,0xD7},{0,0xD7,0},{0,0xD7,0xD7},{0xD7,0xD7,0},{0xD7,0xD7,0xD7},
    {0,0,0},{0,0,0xFF},{0xFF,0,0},{0xFF,0,0xFF},{0,0xFF,0},{0,0xFF,0xFF},{0xFF,0xFF,0},{0xFF,0xFF,0xFF},
};

// Where maps are (images are looked for there too, for maps read without Tiled)
static char mapDirectory[1024];
// Where Tiled exported the map to (its embedded tile sets' images are relative to there, when they're on the same drive)
static char exportDirectory[1024];

static uint32_t be32(const uint8_t *p)
{
    return ((uint32_t)p[0]<<24)|((uint32_t)p[1]<<16)|((uint32_t)p[2]<<8)|p[3];
}

static int paeth(int a, int b, int c)
{
    const int p=a+b-c, pa=abs(p-a), pb=abs(p-b), pc=abs(p-c);
    return (pa<=pb && pa<=pc)?a:((pb<=pc)?b:c);
}

// A PNG image as RGBA (8 bits each) - any colour type and bit depth, not interlaced. NULL if it can't be read
static uint8_t *loadPNG(const char *path, int *outW, int *outH)
{
    size_t size=0;
    uint8_t *file=(uint8_t *)readFile(path,&size);
    static const uint8_t sig[8]={0x89,'P','N','G','\r','\n',0x1A,'\n'};
    if(!file || size<8 || memcmp(file,sig,8)!=0){
        free(file);
        return NULL;
    }
    int w=0, h=0, depth=0, type=0;
    uint8_t pal[256][4];
    memset(pal,255,sizeof(pal));
    int keyR=-1, keyG=-1, keyB=-1;
    uint8_t *idat=NULL;
    size_t idatLen=0;
    for(size_t at=8;at+12<=size;){
        const uint32_t len=be32(file+at);
        const uint8_t *t=file+at+4, *d=file+at+8;
        if(at+12+len>size){
            break;
        }
        if(memcmp(t,"IHDR",4)==0){
            w=(int)be32(d);
            h=(int)be32(d+4);
            depth=d[8];
            type=d[9];
            if(d[12]!=0){
                fail("%s is interlaced - save it without interlacing",path);
            }
        }else if(memcmp(t,"PLTE",4)==0){
            for(uint32_t n=0;n<len/3 && n<256;n++){
                pal[n][0]=d[n*3];
                pal[n][1]=d[(n*3)+1];
                pal[n][2]=d[(n*3)+2];
            }
        }else if(memcmp(t,"tRNS",4)==0){
            if(type==3){
                for(uint32_t n=0;n<len && n<256;n++){
                    pal[n][3]=d[n];
                }
            }else if(type==0 && len>=2){
                keyR=keyG=keyB=(d[0]<<8)|d[1];
            }else if(type==2 && len>=6){
                keyR=(d[0]<<8)|d[1];
                keyG=(d[2]<<8)|d[3];
                keyB=(d[4]<<8)|d[5];
            }
        }else if(memcmp(t,"IDAT",4)==0){
            idat=realloc(idat,idatLen+len);
            memcpy(idat+idatLen,d,len);
            idatLen+=len;
        }else if(memcmp(t,"IEND",4)==0){
            break;
        }
        at+=12+len;
    }
    free(file);
    const int channels=(type==0)?1:((type==2)?3:((type==3)?1:((type==4)?2:((type==6)?4:0))));
    if(!idat || w<=0 || h<=0 || !channels){
        free(idat);
        return NULL;
    }
    size_t rawLen=0;
    uint8_t *raw=(uint8_t *)tinfl_decompress_mem_to_heap(idat,idatLen,&rawLen,TINFL_FLAG_PARSE_ZLIB_HEADER);
    free(idat);
    const int bits=channels*depth, stride=((w*bits)+7)/8, step=(bits<8)?1:(bits/8);
    if(!raw || rawLen<(size_t)(stride+1)*(size_t)h){
        free(raw);
        return NULL;
    }
    // Undo each row's filter, in place (each row starts with its filter type)
    for(int y=0;y<h;y++){
        uint8_t *row=raw+((size_t)y*(stride+1))+1;
        const uint8_t *up=(y>0)?row-(stride+1):NULL;
        const int filter=row[-1];
        for(int x=0;x<stride;x++){
            const int a=(x>=step)?row[x-step]:0, b=up?up[x]:0, c=(up && x>=step)?up[x-step]:0;
            row[x]=(uint8_t)(row[x]+((filter==1)?a:((filter==2)?b:((filter==3)?((a+b)>>1):((filter==4)?paeth(a,b,c):0)))));
        }
    }
    uint8_t *rgba=malloc((size_t)w*h*4);
    const int maxSample=(1<<depth)-1;
    for(int y=0;y<h;y++){
        const uint8_t *row=raw+((size_t)y*(stride+1))+1;
        for(int x=0;x<w;x++){
            int s[4]={0,0,0,0};
            for(int c=0;c<channels;c++){
                if(depth==16){
                    const uint8_t *p=row+(((x*channels)+c)*2);
                    s[c]=(p[0]<<8)|p[1];
                }else if(depth==8){
                    s[c]=row[(x*channels)+c];
                }else{
                    const int bit=((x*channels)+c)*depth;
                    s[c]=(row[bit>>3]>>(8-depth-(bit&7)))&maxSample;
                }
            }
            uint8_t *o=rgba+(((size_t)y*w)+x)*4;
            if(type==3){
                memcpy(o,pal[s[0]&255],4);
                continue;
            }
            // (to 8 bits: the top byte of 16, or a smaller sample scaled up)
            #define TO8(v) ((uint8_t)((depth==16)?((v)>>8):(((v)*255)/maxSample)))
            if(type==0 || type==4){
                o[0]=o[1]=o[2]=TO8(s[0]);
                o[3]=(type==4)?TO8(s[1]):((s[0]==keyR)?0:255);
            }else{
                o[0]=TO8(s[0]);
                o[1]=TO8(s[1]);
                o[2]=TO8(s[2]);
                o[3]=(type==6)?TO8(s[3]):((s[0]==keyR && s[1]==keyG && s[2]==keyB)?0:255);
            }
            #undef TO8
        }
    }
    free(raw);
    *outW=w;
    *outH=h;
    return rgba;
}

// The nearest Spectrum colour to a pixel: 0-7, plus 8 if bright (black is never bright)
static int zxColourOf(const uint8_t *px)
{
    int best=0, bestD=0x7fffffff;
    for(int n=0;n<16;n++){
        const int dr=px[0]-zxColours[n][0], dg=px[1]-zxColours[n][1], db=px[2]-zxColours[n][2];
        const int d=(dr*dr)+(dg*dg)+(db*db);
        if(d<bestD){
            best=n;
            bestD=d;
        }
    }
    return (best==8)?0:best;
}

// What an image pixel is: transparent (alpha under half - not drawn, what's behind shows), paper (the image's paper
// colour, black unless set - drawn, but a clear pixel), or ink (any other colour - a set pixel)
#define IMG_CLEAR   0
#define IMG_PAPER   1
#define IMG_INK     2
static int imagePixel(const uint8_t *rgba, int imgW, int x, int y, int paper)
{
    const uint8_t *px=rgba+(((size_t)y*imgW)+x)*4;
    if(px[3]<128){
        return IMG_CLEAR;
    }
    return ((zxColourOf(px)&7)==paper)?IMG_PAPER:IMG_INK;
}

// A w x h block of an image (a tile, or a sprite frame) as engine graphics and mask, bpr bytes a row (a 24 wide sprite
// has a fourth byte, never drawn)
static void importBlock(const uint8_t *rgba, int imgW, int x0, int y0, int w, int h, int bpr, int paper, uint8_t *pix,
    uint8_t *mask)
{
    memset(pix,0,(size_t)bpr*h);
    memset(mask,0xFF,(size_t)bpr*h);
    for(int y=0;y<h;y++){
        for(int x=0;x<w;x++){
            const int k=imagePixel(rgba,imgW,x0+x,y0+y,paper);
            const uint8_t bit=(uint8_t)(0x80>>(x&7));
            if(k!=IMG_CLEAR){
                mask[(y*bpr)+(x>>3)]&=(uint8_t)~bit;
            }
            if(k==IMG_INK){
                pix[(y*bpr)+(x>>3)]|=bit;
            }
        }
    }
}

// An 8x4 attribute cell of an image: ink the most common ink colour, paper the paper colour, bright if the ink is
// (or, with no ink, the paper is). A cell that's all transparent leaves the colours under it alone (0x80). More than
// one ink colour in a cell can't be shown - counted in clashes
static uint8_t importAttr(const uint8_t *rgba, int imgW, int x0, int y0, int paper, int *clashes)
{
    int counts[16]={0}, opaque=0, brightPaper=0, inks=0;
    for(int y=0;y<4;y++){
        for(int x=0;x<8;x++){
            const uint8_t *px=rgba+(((size_t)(y0+y)*imgW)+x0+x)*4;
            if(px[3]<128){
                continue;
            }
            ++opaque;
            const int c=zxColourOf(px);
            if((c&7)==paper){
                brightPaper+=(c&8)?1:0;
            }else{
                inks+=(counts[c]++==0)?1:0;
            }
        }
    }
    if(opaque==0){
        return 0x80;
    }
    int ink=-1;
    for(int c=0;c<16;c++){
        ink=(counts[c]>0 && (ink<0 || counts[c]>counts[ink]))?c:ink;
    }
    if(inks>1){
        ++*clashes;
    }
    const bool bright=(ink>=0)?((ink&8)!=0):(brightPaper*2>opaque);
    return (uint8_t)((bright?0x40:0)|(paper<<3)|((ink>=0)?(ink&7):7));
}

// A tile set's image (its "image", relative to the map or the tile set, or absolute)
static uint8_t *loadTileSetImage(const cJSON *ts, const char *name, int *w, int *h)
{
    const char *image=jsonString(ts,"image","");
    char path[2100];
    snprintf(path,sizeof(path),"%s%s",mapDirectory,image);
    const bool absolute=(image[0]=='/' || image[0]=='\\' || (image[0] && image[1]==':'));
    uint8_t *rgba=absolute?NULL:loadPNG(path,w,h);
    if(!rgba && !absolute && exportDirectory[0]){
        snprintf(path,sizeof(path),"%s%s",exportDirectory,image);
        rgba=loadPNG(path,w,h);
    }
    if(!rgba){
        rgba=loadPNG(image,w,h);
    }
    if(!rgba){
        fail("tile set \"%s\": can't read its image %s (a PNG)",name,image);
    }
    return rgba;
}

// True if a tile has colours set in Tiled (any ink, paper, bright or transparent property) - which an imported tile
// set uses instead of its image's
static bool hasColourProps(const cJSON *tile)
{
    const cJSON *p;
    cJSON_ArrayForEach(p,cJSON_GetObjectItemCaseSensitive(tile,"properties")){
        const char *n=jsonString(p,"name","");
        if(strncmp(n,"ink",3)==0 || strncmp(n,"paper",5)==0 || strncmp(n,"bright",6)==0 || strncmp(n,"transparent",11)==0){
            return true;
        }
    }
    return false;
}

// The paper colour of an imported image: its "imagePaper" property (a ZXColour), black if not set
static int importPaper(const cJSON *ts)
{
    return property(ts,"imagePaper")?propColour(ts,"imagePaper"):0;
}

// An imported tile set's tiles, from its image: graphics and masks (8x8: 8 bytes a tile; 16x16: 32, a row of 2 bytes
// at a time), and the colours of each tile's attribute cells into attrs (as readTileSet keeps them). Tile 0 is
// always empty. Returns how many cells had clashing colours
static int importTiles(const uint8_t *rgba, int imgW, int imgH, int size, int paper, const char *name, uint8_t *data,
    uint8_t *attrs)
{
    const int cols=imgW/size, rows=imgH/size, tileBytes=size*size/8;
    if(imgW%size || imgH%size){
        fail("tile set \"%s\": its image is %dx%d - not a whole number of %dx%d tiles",name,imgW,imgH,size,size);
    }
    if(cols*rows>256){
        fail("tile set \"%s\": its image has %d tiles - the engine has 256 a tile set",name,cols*rows);
    }
    memset(data,0,(size_t)256*tileBytes);
    memset(data+(256*tileBytes),0xFF,(size_t)256*tileBytes);
    int clashes=0;
    for(int t=0;t<cols*rows;t++){
        const int x0=(t%cols)*size, y0=(t/cols)*size;
        if(t==0){
            for(int y=0;y<size;y++){
                for(int x=0;x<size;x++){
                    if(imagePixel(rgba,imgW,x0+x,y0+y,paper)!=IMG_CLEAR){
                        warn("tile set \"%s\": its first tile isn't empty - tile 0 is always empty in the engine (leave "
                            "the top left tile clear)",name);
                        y=size;
                        break;
                    }
                }
            }
            continue;
        }
        importBlock(rgba,imgW,x0,y0,size,size,size/8,paper,data+(t*tileBytes),data+(256*tileBytes)+(t*tileBytes));
        if(attrs){
            if(size==16){
                // 8 a tile: each quarter's top and bottom 8x4 cells
                for(int q=0;q<4;q++){
                    for(int half=0;half<2;half++){
                        attrs[(t*8)+(q*2)+half]=importAttr(rgba,imgW,x0+((q&1)*8),y0+((q>>1)*8)+(half*4),paper,&clashes);
                    }
                }
            }else{
                attrs[t*2]=importAttr(rgba,imgW,x0,y0,paper,&clashes);
                attrs[(t*2)+1]=importAttr(rgba,imgW,x0,y0+4,paper,&clashes);
            }
        }
    }
    return clashes;
}

// An imported sprite sheet's frames, from its image (frames left to right, then down): graphics, then masks
static void importSprites(const uint8_t *rgba, int imgW, int imgH, int w, int h, int paper, const char *name,
    uint8_t *data, uint8_t *mask, int frames)
{
    const int cols=imgW/w, bpr=spriteBytesPerRow(w);
    if(imgW%w || imgH%h){
        fail("sprite sheet \"%s\": its image is %dx%d - not a whole number of %dx%d frames",name,imgW,imgH,w,h);
    }
    for(int f=0;f<frames;f++){
        importBlock(rgba,imgW,(f%cols)*w,(f/cols)*h,w,h,bpr,paper,data+(f*bpr*h),mask+(f*bpr*h));
    }
}

// Write a file only if it's changed (so builds don't recompile what hasn't)
static void writeIfChanged(const char *path, const char *text)
{
    size_t oldSize=0;
    char *old=readFile(path,&oldSize);
    const bool same=old && oldSize==strlen(text) && memcmp(old,text,oldSize)==0;
    free(old);
    if(same){
        return;
    }
    FILE *f=fopen(path,"wb");
    if(!f || fputs(text,f)<0){
        fail("can't write %s",path);
    }
    fclose(f);
}

// Append to a growing string
static void appendf(char **s, size_t *len, size_t *cap, const char *fmt, ...)
{
    va_list ap;
    va_start(ap,fmt);
    char tmp[512];
    const int n=vsnprintf(tmp,sizeof(tmp),fmt,ap);
    va_end(ap);
    if(*len+(size_t)n+1>*cap){
        *cap=(*cap+(size_t)n+1)*2;
        *s=realloc(*s,*cap);
    }
    memcpy(*s+*len,tmp,(size_t)n+1);
    *len+=(size_t)n;
}

static void appendArray(char **s, size_t *len, size_t *cap, const char *name, const uint8_t *data, int n)
{
    appendf(s,len,cap,"const uint8_t %s[%d] __attribute__((aligned(4)))={",name,n);
    for(int k=0;k<n;k++){
        appendf(s,len,cap,"%s0x%02X",(k%32)?",":(k?",\n    ":"\n    "),data[k]);
    }
    appendf(s,len,cap,"\n};\n");
}

// The engine graphics of an imported tile set or sprite sheet, as levels/gfx_<name>.c and .h (compiled into the game
// with the levels)
static void writeImportedGfx(const char *outDir, const char *image, const char *name, const uint8_t *data,
    const char *maskName, const uint8_t *mask, int size)
{
    char *s=NULL, path[1400];
    size_t len=0, cap=0;
    appendf(&s,&len,&cap,"// Generated by levelconv from %s - edit the image and convert again, rather than editing this\n\n"
        "#include \"gfx_%s.h\"\n\n",image,name);
    appendArray(&s,&len,&cap,name,data,size);
    if(maskName){
        appendf(&s,&len,&cap,"\n");
        appendArray(&s,&len,&cap,maskName,mask,size);
    }
    snprintf(path,sizeof(path),"%sgfx_%s.c",outDir,name);
    writeIfChanged(path,s);
    len=0;
    appendf(&s,&len,&cap,"// Generated by levelconv from %s\n#pragma once\n\n#include <stdint.h>\n\nextern const uint8_t %s[%d];\n",
        image,name,size);
    if(maskName){
        appendf(&s,&len,&cap,"extern const uint8_t %s[%d];\n",maskName,size);
    }
    snprintf(path,sizeof(path),"%sgfx_%s.h",outDir,name);
    writeIfChanged(path,s);
    free(s);
}

static const SpriteDefEntry *engineSprite(const char *name)
{
    for(const SpriteDefEntry *e=spriteDefRegistry;e->name;e++){
        if(strcmp(e->name,name)==0){
            return e;
        }
    }
    return NULL;
}

// A sprite sheet: its engine sprite graphics and mask, size, frames and palette
static void readSpriteSheet(TileSet *s, const cJSON *ts)
{
    s->maskName=propString(ts,"engineMask");
    s->spriteW=jsonInt(ts,"tilewidth",0);
    s->spriteH=jsonInt(ts,"tileheight",0);
    s->frames=s->tileCount;
    s->palette=propInt(ts,"palette",0);
    s->alignment=jsonString(ts,"objectalignment","unspecified");
    if(!spriteSizeValid(s->spriteW,s->spriteH)){
        fail("sprite sheet \"%s\" is %dx%d - not an engine sprite size",s->name,s->spriteW,s->spriteH);
    }
    s->imported=propBool(ts,"imported",false);
    if(s->imported){
        // From its image: graphics and masks
        if(!s->maskName){
            fail("sprite sheet \"%s\" is imported, but has no \"engineMask\" property (the name of its masks)",s->name);
        }
        int w=0, h=0;
        uint8_t *rgba=loadTileSetImage(ts,s->name,&w,&h);
        s->importedSize=s->frames*spriteBytesPerRow(s->spriteW)*s->spriteH;
        s->importedData=malloc((size_t)s->importedSize);
        s->importedMask=malloc((size_t)s->importedSize);
        importSprites(rgba,w,h,s->spriteW,s->spriteH,importPaper(ts),s->name,s->importedData,s->importedMask,s->frames);
        free(rgba);
        s->spriteData=s->importedData;
        s->maskData=s->importedMask;
        return;
    }
    const SpriteDefEntry *d=engineSprite(s->spriteName);
    const SpriteDefEntry *m=s->maskName?engineSprite(s->maskName):NULL;
    if(!d){
        fail("sprite sheet \"%s\": no engine sprite graphics called \"%s\" in engine/spriteDefs.h",s->name,s->spriteName);
    }
    if(!m){
        fail("sprite sheet \"%s\": no mask \"%s\" in engine/spriteDefs.h (set its \"engineMask\" property)",s->name,
            s->maskName?s->maskName:"");
    }
    const int frameBytes=spriteBytesPerRow(s->spriteW)*s->spriteH;
    if(s->frames*frameBytes>d->size || s->frames*frameBytes>m->size){
        fail("sprite sheet \"%s\" has %d frames, but %s holds %d",s->name,s->frames,s->spriteName,d->size/frameBytes);
    }
    s->spriteData=d->data;
    s->maskData=m->data;
}

static const TileSetEntry *engineTiles(const char *name)
{
    for(const TileSetEntry *e=tileSetRegistry;e->name;e++){
        if(strcmp(e->name,name)==0){
            return e;
        }
    }
    return NULL;
}

// Bytes of a tile set's attributes: 2 per 8x8 tile, 8 per 16x16 (the top and bottom of each quarter)
static int attrBytes(const TileSet *s)
{
    return (s->tileSize==16)?2048:512;
}

static const cJSON *tileEntry(const cJSON *ts, int id)
{
    const cJSON *t;
    cJSON_ArrayForEach(t,cJSON_GetObjectItemCaseSensitive(ts,"tiles")){
        if(jsonInt(t,"id",-1)==id){
            return t;
        }
    }
    return NULL;
}

// An attribute from a tile's properties: ink, paper, bright and transparent, with a suffix ("" for the top, "Bottom"
// for the bottom half, "Row1"-"Row3" for 16x16 tiles' rows). Anything not set is as fallback - or, with no fallback
// (-1), the tile set's own properties, as defaults
static uint8_t suffixAttr(const cJSON *tile, const cJSON *ts, const char *suffix, int fallback)
{
    int ink=-1, paper=-1;
    int bright=-1, transparent=-1;
    if(tile){
        char name[64];
        snprintf(name,sizeof(name),"ink%s",suffix);
        ink=propColour(tile,name);
        snprintf(name,sizeof(name),"paper%s",suffix);
        paper=propColour(tile,name);
        snprintf(name,sizeof(name),"bright%s",suffix);
        bright=property(tile,name)?(propBool(tile,name,false)?1:0):-1;
        snprintf(name,sizeof(name),"transparent%s",suffix);
        transparent=property(tile,name)?(propBool(tile,name,false)?1:0):-1;
    }
    if(fallback>=0){
        if(ink<0){
            ink=fallback&7;
        }
        if(paper<0){
            paper=(fallback>>3)&7;
        }
        if(bright<0){
            bright=(fallback>>6)&1;
        }
        if(transparent<0){
            transparent=(fallback>>7)&1;
        }
    }else{
        if(ink<0){
            ink=propColour(ts,"ink");
            ink=(ink<0)?7:ink;
        }
        if(paper<0){
            paper=propColour(ts,"paper");
            paper=(paper<0)?0:paper;
        }
        if(bright<0){
            bright=propBool(ts,"bright",false)?1:0;
        }
        if(transparent<0){
            transparent=propBool(ts,"transparent",false)?1:0;
        }
    }
    return (uint8_t)((transparent?0x80:0)|(bright?0x40:0)|(paper<<3)|ink);
}

static long enumValue(const char *typeName, const cJSON *v, const char *where);

// Colours, flags and animations of a Tiled tile set
static void readTileSet(TileSet *s, const cJSON *ts)
{
    s->json=ts;
    s->name=jsonString(ts,"name","tileset");
    s->tileCount=jsonInt(ts,"tilecount",0);
    s->spriteName=propString(ts,"engineSprite");
    if(s->spriteName){
        readSpriteSheet(s,ts);
        return;
    }
    s->engineName=propString(ts,"engineTiles");
    s->tileSize=jsonInt(ts,"tilewidth",8);
    if((s->tileSize!=8 && s->tileSize!=16) || jsonInt(ts,"tileheight",8)!=s->tileSize){
        fail("tile set \"%s\" has to have 8x8 or 16x16 tiles",s->name);
    }
    // As tile objects: sprites of its tiles, 8x8 or 16x16, in its "spritePalette" (0, the default, has no colour)
    s->spriteW=s->tileSize;
    s->spriteH=s->tileSize;
    s->frames=s->tileCount;
    s->palette=propInt(ts,"spritePalette",0);
    s->alignment=jsonString(ts,"objectalignment","unspecified");
    // Imported from a PNG: the graphics (and the colours of tiles without colour properties) come from the image
    s->imported=propBool(ts,"imported",false);
    static uint8_t imageAttrs[2048];
    if(s->imported){
        if(!s->engineName){
            fail("tile set \"%s\" is imported, but has no \"engineTiles\" property (the name of its graphics)",s->name);
        }
        int w=0, h=0;
        uint8_t *rgba=loadTileSetImage(ts,s->name,&w,&h);
        s->importedSize=256*s->tileSize*s->tileSize/8;
        s->importedData=malloc((size_t)s->importedSize*2);
        memset(imageAttrs,0x80,sizeof(imageAttrs));
        const int clashes=importTiles(rgba,w,h,s->tileSize,importPaper(ts),s->name,s->importedData,imageAttrs);
        if(clashes){
            warn("tile set \"%s\": %d attribute cells (8x4 pixels) of its image have more than one ink colour - each "
                "shows its most common",s->name,clashes);
        }
        free(rgba);
        s->tiles=s->importedData;
    }
    const TileSetEntry *e=(s->engineName && !s->imported)?engineTiles(s->engineName):NULL;
    if(!s->imported){
        s->tiles=e?e->tiles:NULL;
    }
    if(e && e->size!=256*s->tileSize*s->tileSize/4){
        fail("tile set \"%s\" has %dx%d tiles, but %s is %d bytes - %s tile graphics are %d",s->name,s->tileSize,
            s->tileSize,s->engineName,e->size,(s->tileSize==16)?"16x16":"8x8",256*s->tileSize*s->tileSize/4);
    }
    if(s->tileCount>256){
        fail("tile set \"%s\" has %d tiles - the engine has 256 per tile set",s->name,s->tileCount);
    }
    for(int n=0;n<256;n++){
        const cJSON *tile=tileEntry(ts,n);
        const uint8_t top=suffixAttr(tile,ts,"",-1);
        if(s->tileSize==16){
            // Its 4 rows of attributes (4 pixels each): the top, then each row as the one above unless set - "Bottom"
            // being the bottom half's (rows 2 and 3). The top quarters are rows 0 and 1, the bottom quarters 2 and 3,
            // and left and right are the same
            const uint8_t row1=suffixAttr(tile,ts,"Row1",top);
            const uint8_t row2=suffixAttr(tile,ts,"Row2",suffixAttr(tile,ts,"Bottom",row1));
            const uint8_t row3=suffixAttr(tile,ts,"Row3",row2);
            const uint8_t rows[4]={top,row1,row2,row3};
            for(int q=0;q<4;q++){
                s->attrs[(n*8)+(q*2)]=rows[(q>>1)*2];
                s->attrs[(n*8)+(q*2)+1]=rows[((q>>1)*2)+1];
            }
        }else{
            s->attrs[n*2]=top;
            s->attrs[(n*2)+1]=suffixAttr(tile,ts,"Bottom",top);
        }
        if(s->imported && !hasColourProps(tile)){
            const int k=(s->tileSize==16)?8:2;
            memcpy(s->attrs+(n*k),imageAttrs+(n*k),(size_t)k);
        }
        uint8_t f=0;
        if(tile){
            f|=propBool(tile,"solid",false)?LEVEL_TILE_SOLID:0;
            f|=propBool(tile,"platform",false)?LEVEL_TILE_PLATFORM:0;
            f|=propBool(tile,"hazard",false)?LEVEL_TILE_HAZARD:0;
            f|=propBool(tile,"collect",false)?LEVEL_TILE_COLLECT:0;
            f|=(uint8_t)propInt(tile,"flags",0);
            // Its type (the project's TileType enum, or a number) in bits 4-7
            const cJSON *type=property(tile,"tileType");
            if(type){
                char where[300];
                snprintf(where,sizeof(where),"tile set \"%s\" tile %d",s->name,n);
                long t=enumValue("TileType",type,where);
                if(t<0){
                    t=cJSON_IsNumber(type)?(long)type->valuedouble:(cJSON_IsString(type)?atol(type->valuestring):0);
                }
                if(t<0 || t>15){
                    fail("%s: tileType is %ld - tile types are 0-15",where,t);
                }
                f=(uint8_t)((f&0x0f)|(t<<4));
            }
        }
        s->flags[n]=f;
    }
    // Tile 0 is always empty, with attributes that leave the colours under it alone
    memset(s->attrs,0x80,(s->tileSize==16)?8:2);
    s->flags[0]=0;

    s->animCount=0;
    const cJSON *tile;
    cJSON_ArrayForEach(tile,cJSON_GetObjectItemCaseSensitive(ts,"tiles")){
        const cJSON *frames=cJSON_GetObjectItemCaseSensitive(tile,"animation");
        const int count=cJSON_GetArraySize(frames);
        if(count<1){
            continue;
        }
        if(s->animCount>=MAX_ANIMS){
            fail("tile set \"%s\" has more than %d animated tiles",s->name,MAX_ANIMS);
        }
        if(count>MAX_FRAMES){
            fail("tile %d of tile set \"%s\" has more than %d frames",jsonInt(tile,"id",0),s->name,MAX_FRAMES);
        }
        Anim *a=s->anims+s->animCount++;
        a->def=jsonInt(tile,"id",0);
        a->frameCount=count;
        for(int n=0;n<count;n++){
            const cJSON *fr=cJSON_GetArrayItem(frames,n);
            a->frames[n]=jsonInt(fr,"tileid",0);
            // Durations in milliseconds, to 25fps frames
            int t=(jsonInt(fr,"duration",100)+20)/40;
            a->ticks[n]=(t<1)?1:((t>255)?255:t);
            if(a->frames[n]>255){
                fail("animation of tile %d uses tile %d - frames have to be in the first 256 tiles",a->def,a->frames[n]);
            }
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Layers
// ---------------------------------------------------------------------------------------------------------------------

typedef struct RawLayer {
    const cJSON *json;
    const char *name;
    uint32_t *gids;
    double parallaxX, parallaxY;
    int offsetX, offsetY;
} RawLayer;

typedef struct OutLayer {
    RawLayer *raw;
    RawLayer *fg;
    int layer, fgLayer;
    int tileSet, fgTileSet;
    int tileX, tileY, width, height;
    int fgCount;
    uint8_t flags;
    uint8_t *packed;
    int packedSize;
    int unpackedSize;
    // One colour for the whole layer (its "ink", "paper", "bright" or "transparent" properties), if set
    int singleColour, colour;
} OutLayer;

static RawLayer rawLayers[MAX_LAYERS];
static int rawCount=0;
static int mapW, mapH;
static int mapTile=8;      // The map's tile size: 8 or 16

static uint8_t *base64Decode(const char *s, size_t *outLen)
{
    static const char *chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    const size_t len=strlen(s);
    uint8_t *out=malloc((len*3)/4+4);
    size_t n=0;
    uint32_t acc=0;
    int bits=0;
    for(size_t i=0;i<len;i++){
        const char *p=strchr(chars,s[i]);
        if(!p || !s[i]){
            continue;   // Padding and whitespace
        }
        acc=(acc<<6)|(uint32_t)(p-chars);
        bits+=6;
        if(bits>=8){
            bits-=8;
            out[n++]=(uint8_t)(acc>>bits);
        }
    }
    *outLen=n;
    return out;
}

static uint32_t *layerGids(const cJSON *l, const char *name)
{
    const size_t cells=(size_t)mapW*mapH;
    uint32_t *gids=calloc(cells,sizeof(uint32_t));
    const cJSON *data=cJSON_GetObjectItemCaseSensitive(l,"data");
    if(cJSON_IsArray(data)){
        if((size_t)cJSON_GetArraySize(data)!=cells){
            fail("layer \"%s\" has %d tiles - expected %d",name,cJSON_GetArraySize(data),(int)cells);
        }
        size_t n=0;
        const cJSON *v;
        cJSON_ArrayForEach(v,data){
            gids[n++]=(uint32_t)v->valuedouble;
        }
        return gids;
    }
    if(!cJSON_IsString(data)){
        fail("layer \"%s\" has no tile data (infinite maps aren't supported - untick Infinite in the map properties)",name);
    }
    size_t rawLen;
    uint8_t *raw=base64Decode(data->valuestring,&rawLen);
    const char *comp=jsonString(l,"compression","");
    uint8_t *bytes=raw;
    size_t byteLen=rawLen;
    if(strcmp(comp,"zlib")==0 || strcmp(comp,"gzip")==0){
        size_t start=0;
        int flags=TINFL_FLAG_PARSE_ZLIB_HEADER;
        if(strcmp(comp,"gzip")==0){
            // Skip the gzip header, then it's raw deflate
            if(rawLen<18 || raw[0]!=0x1f || raw[1]!=0x8b){
                fail("layer \"%s\" has bad gzip data",name);
            }
            const uint8_t f=raw[3];
            start=10;
            if(f&4){
                start+=2+(size_t)(raw[start]|(raw[start+1]<<8));
            }
            if(f&8){
                while(start<rawLen && raw[start++]){}
            }
            if(f&16){
                while(start<rawLen && raw[start++]){}
            }
            if(f&2){
                start+=2;
            }
            flags=0;
        }
        bytes=malloc(cells*4);
        byteLen=tinfl_decompress_mem_to_mem(bytes,cells*4,raw+start,rawLen-start,flags);
        free(raw);
    }else if(comp[0]){
        fail("layer \"%s\" uses %s compression - set the map's Tile Layer Format to CSV, or Base64 zlib/gzip",name,comp);
    }
    if(byteLen!=cells*4){
        fail("layer \"%s\" data is %d bytes - expected %d",name,(int)byteLen,(int)(cells*4));
    }
    for(size_t n=0;n<cells;n++){
        gids[n]=(uint32_t)bytes[n*4]|((uint32_t)bytes[(n*4)+1]<<8)|((uint32_t)bytes[(n*4)+2]<<16)|((uint32_t)bytes[(n*4)+3]<<24);
    }
    free(bytes);
    return gids;
}

// Object layers, with their offsets (including their groups') and the engine layer their sprites go on
typedef struct ObjLayer {
    const cJSON *json;
    int offsetX, offsetY;
    int layer;
} ObjLayer;

static ObjLayer objLayers[MAX_LAYERS];
static int objLayerCount=0;

// Every tile layer and object layer, groups flattened (their parallax factors multiply, offsets add)
static void collectLayers(const cJSON *list, double px, double py, int ox, int oy)
{
    const cJSON *l;
    cJSON_ArrayForEach(l,list){
        const char *type=jsonString(l,"type","");
        const double lpx=px*jsonDouble(l,"parallaxx",1.0);
        const double lpy=py*jsonDouble(l,"parallaxy",1.0);
        const int lox=ox+jsonInt(l,"offsetx",0);
        const int loy=oy+jsonInt(l,"offsety",0);
        if(strcmp(type,"group")==0){
            collectLayers(cJSON_GetObjectItemCaseSensitive(l,"layers"),lpx,lpy,lox,loy);
        }else if(strcmp(type,"tilelayer")==0){
            if(rawCount>=MAX_LAYERS){
                fail("too many tile layers");
            }
            RawLayer *r=rawLayers+rawCount++;
            r->json=l;
            r->name=jsonString(l,"name","");
            r->gids=layerGids(l,r->name);
            r->parallaxX=lpx;
            r->parallaxY=lpy;
            r->offsetX=lox;
            r->offsetY=loy;
        }else if(strcmp(type,"objectgroup")==0){
            if(objLayerCount>=MAX_LAYERS){
                fail("too many object layers");
            }
            ObjLayer *ol=objLayers+objLayerCount++;
            ol->json=l;
            ol->offsetX=lox;
            ol->offsetY=loy;
            ol->layer=propInt(l,"layer",-1);
            if(ol->layer>=MAX_TILE_LAYERS){
                fail("object layer \"%s\": \"layer\" is %d - the engine has layers 0-%d",jsonString(l,"name",""),ol->layer,
                    MAX_TILE_LAYERS-1);
            }
        }
    }
}

// The tile set a layer's tiles come from (they all have to be from one), or -1 if it's empty
static int layerTileSet(const RawLayer *r, TileSet *sets, int setCount)
{
    int found=-1;
    for(int n=0;n<mapW*mapH;n++){
        const uint32_t gid=r->gids[n];
        if(gid==0){
            continue;
        }
        if(gid&FLIP_BITS){
            fail("layer \"%s\": the tile at %d,%d is flipped or rotated - the engine can't draw those",r->name,n%mapW,n/mapW);
        }
        int s=-1;
        for(int k=0;k<setCount;k++){
            if((int)gid>=sets[k].firstGid && (int)gid<sets[k].firstGid+sets[k].tileCount){
                s=k;
            }
        }
        if(s<0){
            fail("layer \"%s\": tile %u at %d,%d isn't in any tile set",r->name,gid,n%mapW,n/mapW);
        }
        if(found>=0 && s!=found){
            fail("layer \"%s\" uses tiles from two tile sets (\"%s\" and \"%s\") - a layer can only use one",r->name,
                sets[found].name,sets[s].name);
        }
        if(sets[s].spriteName){
            fail("layer \"%s\" uses sprite sheet \"%s\" - sprites go on object layers (as tile objects)",r->name,
                sets[s].name);
        }
        found=s;
    }
    return found;
}

static inline int tileAt(const RawLayer *r, const TileSet *s, int x, int y)
{
    const uint32_t gid=r->gids[(y*mapW)+x];
    return gid?(int)gid-s->firstGid:0;
}

static void packLayer(OutLayer *o, TileSet *sets)
{
    const TileSet *s=sets+o->tileSet;
    const TileSet *fs=o->fg?sets+o->fgTileSet:NULL;

    // Trim to the tiles used
    int x0=mapW, y0=mapH, x1=-1, y1=-1;
    for(int y=0;y<mapH;y++){
        for(int x=0;x<mapW;x++){
            if(tileAt(o->raw,s,x,y) || (fs && tileAt(o->fg,fs,x,y))){
                x0=(x<x0)?x:x0;
                y0=(y<y0)?y:y0;
                x1=(x>x1)?x:x1;
                y1=(y>y1)?y:y1;
            }
        }
    }
    if(x1<0){
        x0=y0=x1=y1=0;
    }
    o->tileX=x0;
    o->tileY=y0;
    o->width=x1-x0+1;
    o->height=y1-y0+1;

    // Tiles, padded to 4 bytes, then the foreground bits and tiles
    const int tileBytes=((o->width*o->height)+3)&~3;
    const int rowWords=(o->width+31)>>5;
    uint8_t *fgTiles=malloc((size_t)o->width*o->height);
    uint8_t *bits=calloc((size_t)o->height*rowWords,4);
    o->fgCount=0;
    uint8_t *tiles=calloc((size_t)tileBytes,1);
    for(int y=0;y<o->height;y++){
        for(int x=0;x<o->width;x++){
            tiles[(y*o->width)+x]=(uint8_t)tileAt(o->raw,s,x0+x,y0+y);
            const int fg=fs?tileAt(o->fg,fs,x0+x,y0+y):0;
            if(fg){
                const int w=(y*rowWords)+(x>>5);
                bits[(w*4)+((x&31)>>3)]|=(uint8_t)(1u<<(x&7));
                fgTiles[o->fgCount++]=(uint8_t)fg;
            }
        }
    }
    if(o->fgCount>65535){
        fail("layer \"%s\" has %d foreground tiles - the most is 65535",o->raw->name,o->fgCount);
    }
    const int bitBytes=o->fgCount?o->height*rowWords*4:0;
    o->unpackedSize=tileBytes+bitBytes+o->fgCount;
    uint8_t *all=malloc((size_t)o->unpackedSize);
    memcpy(all,tiles,(size_t)tileBytes);
    memcpy(all+tileBytes,bits,(size_t)bitBytes);
    memcpy(all+tileBytes+bitBytes,fgTiles,(size_t)o->fgCount);

    o->packed=malloc(LZ_PACK_BOUND(o->unpackedSize));
    o->packedSize=lzPack(all,o->unpackedSize,o->packed);

    // Check it unpacks to the same
    uint8_t *check=malloc((size_t)o->unpackedSize);
    if(lzUnpack(o->packed,o->packedSize,check,o->unpackedSize)!=o->unpackedSize ||
        memcmp(check,all,(size_t)o->unpackedSize)!=0){
        fail("layer \"%s\" didn't unpack to the same data - this is a bug in the packer",o->raw->name);
    }
    free(check);
    free(all);
    free(tiles);
    free(bits);
    free(fgTiles);
}

static uint32_t align4(uint32_t n)
{
    return (n+3u)&~3u;
}

// ---------------------------------------------------------------------------------------------------------------------
// Objects, and the classes and properties set up in the Tiled project
// ---------------------------------------------------------------------------------------------------------------------

typedef struct Project {
    cJSON *json;
    char path[1024];
    const cJSON *classes[MAX_CLASSES];      // Class 1 is classes[0] (0 is LEVEL_CLASS_NONE)
    int classCount;
    const char *props[MAX_PROPS];
    int propCount;
    const cJSON *enums[64];
    int enumCount;
} Project;

static Project project;

// Every level (map) in the maps' folder, in name order - a level's number (LEVEL_ID_...) is its place in this list
#define MAX_LEVELS 256
static char levelNames[MAX_LEVELS][128];
static int levelNameCount=0;

static int compareNames(const void *a, const void *b)
{
    const char *x=(const char *)a, *y=(const char *)b;
    for(;*x && tolower((unsigned char)*x)==tolower((unsigned char)*y);x++,y++){}
    return tolower((unsigned char)*x)-tolower((unsigned char)*y);
}

static void addLevelName(const char *file)
{
    char base[256];
    baseName(file,base,sizeof(base));
    for(int n=0;n<levelNameCount;n++){
        if(strcmp(levelNames[n],base)==0){
            return;     // (a .tmx and .tmj of the same level)
        }
    }
    if(levelNameCount<MAX_LEVELS){
        snprintf(levelNames[levelNameCount++],sizeof(levelNames[0]),"%s",base);
    }
}

static void findLevels(const char *mapDir)
{
    levelNameCount=0;
#ifdef _WIN32
    const char *patterns[2]={"*.tmx","*.tmj"};
    for(int p=0;p<2;p++){
        char pattern[1100];
        snprintf(pattern,sizeof(pattern),"%s%s",mapDir,patterns[p]);
        WIN32_FIND_DATAA fd;
        HANDLE h=FindFirstFileA(pattern,&fd);
        if(h==INVALID_HANDLE_VALUE){
            continue;
        }
        do{
            addLevelName(fd.cFileName);
        }while(FindNextFileA(h,&fd));
        FindClose(h);
    }
#else
    DIR *d=opendir(mapDir[0]?mapDir:".");
    struct dirent *e;
    while(d && (e=readdir(d))){
        if(endsWith(e->d_name,".tmx") || endsWith(e->d_name,".tmj")){
            addLevelName(e->d_name);
        }
    }
    if(d){
        closedir(d);
    }
#endif
    qsort(levelNames,(size_t)levelNameCount,sizeof(levelNames[0]),compareNames);
}

// A level's number, from its map's file name (or path), or -1
static int levelID(const char *file)
{
    char base[256];
    baseName(file,base,sizeof(base));
    for(int n=0;n<levelNameCount;n++){
        if(strcmp(levelNames[n],base)==0){
            return n;
        }
    }
    return -1;
}

// A value of one of the project's enums (e.g. a SwitchMode or SwitchId property): its number (its place in the enum's
// list of values, or the number itself for enums stored as numbers), or -1 if the type isn't an enum
static long enumValue(const char *typeName, const cJSON *v, const char *where)
{
    for(int n=0;n<project.enumCount;n++){
        const cJSON *e=project.enums[n];
        if(strcmp(jsonString(e,"name",""),typeName)!=0){
            continue;
        }
        if(cJSON_IsNumber(v)){
            return (long)v->valuedouble;
        }
        int ix=0;
        const cJSON *val;
        cJSON_ArrayForEach(val,cJSON_GetObjectItemCaseSensitive(e,"values")){
            if(cJSON_IsString(val) && cJSON_IsString(v) && strcmp(val->valuestring,v->valuestring)==0){
                return ix;
            }
            ++ix;
        }
        if(cJSON_IsString(v) && v->valuestring[0]){
            warn("%s: \"%s\" isn't one of %s's values",where,v->valuestring,typeName);
        }
        return 0;
    }
    return -1;
}

// The Tiled project: the first .tiled-project in the map's folder, or a folder above it
static bool findProject(const char *mapPath)
{
    char dir[1024];
    dirOf(mapPath,dir,sizeof(dir));
    for(int depth=0;depth<6;depth++){
#ifdef _WIN32
        char pattern[1100];
        snprintf(pattern,sizeof(pattern),"%s*.tiled-project",dir);
        WIN32_FIND_DATAA fd;
        HANDLE h=FindFirstFileA(pattern,&fd);
        if(h!=INVALID_HANDLE_VALUE){
            snprintf(project.path,sizeof(project.path),"%s%s",dir,fd.cFileName);
            FindClose(h);
            return true;
        }
#else
        DIR *d=opendir(dir[0]?dir:".");
        struct dirent *e;
        while(d && (e=readdir(d))){
            if(endsWith(e->d_name,".tiled-project")){
                snprintf(project.path,sizeof(project.path),"%s%s",dir,e->d_name);
                closedir(d);
                return true;
            }
        }
        if(d){
            closedir(d);
        }
#endif
        const size_t n=strlen(dir);
        if(n+4>=sizeof(dir)){
            break;
        }
        strcat(dir,"../");
    }
    return false;
}

static void loadProject(const char *mapPath)
{
    if(project.json){
        cJSON_Delete(project.json);
    }
    memset(&project,0,sizeof(project));
    if(!findProject(mapPath)){
        return;
    }
    char *text=readFile(project.path,NULL);
    project.json=text?cJSON_Parse(text):NULL;
    free(text);
    if(!project.json){
        fail("can't read the Tiled project %s",project.path);
    }
    const cJSON *t;
    cJSON_ArrayForEach(t,cJSON_GetObjectItemCaseSensitive(project.json,"propertyTypes")){
        if(strcmp(jsonString(t,"type",""),"enum")==0 && project.enumCount<64){
            project.enums[project.enumCount++]=t;
            continue;
        }
        if(strcmp(jsonString(t,"type",""),"class")!=0){
            continue;
        }
        if(project.classCount>=MAX_CLASSES){
            fail("the project has more than %d classes",MAX_CLASSES);
        }
        project.classes[project.classCount++]=t;
        const cJSON *m;
        cJSON_ArrayForEach(m,cJSON_GetObjectItemCaseSensitive(t,"members")){
            const char *name=jsonString(m,"name","");
            bool known=false;
            for(int n=0;n<project.propCount && !known;n++){
                known=strcmp(project.props[n],name)==0;
            }
            if(!known){
                if(project.propCount>=MAX_PROPS){
                    fail("the project's classes have more than %d properties",MAX_PROPS);
                }
                project.props[project.propCount++]=name;
            }
        }
    }
}

static int classID(const char *name)
{
    for(int n=0;n<project.classCount;n++){
        if(strcmp(jsonString(project.classes[n],"name",""),name)==0){
            return n+1;
        }
    }
    return -1;
}

static int propID(const char *name)
{
    for(int n=0;n<project.propCount;n++){
        if(strcmp(project.props[n],name)==0){
            return n;
        }
    }
    return -1;
}

// A name as a C macro: PlayerStart -> PLAYER_START, waitForCamera -> WAIT_FOR_CAMERA
static void macroName(const char *name, char *out, size_t outSize)
{
    size_t n=0;
    for(const char *p=name;*p && n+2<outSize;p++){
        if(isupper((unsigned char)*p) && p>name && (islower((unsigned char)p[-1]) || isdigit((unsigned char)p[-1]))){
            out[n++]='_';
        }
        out[n++]=isalnum((unsigned char)*p)?(char)toupper((unsigned char)*p):'_';
    }
    out[n]=0;
}

// levels/levelObjects.h: the project's classes and properties, numbered
static void writeObjectsHeader(const char *outDir)
{
    char path[1100], macro[256];
    snprintf(path,sizeof(path),"%slevelObjects.h",outDir);
    FILE *f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fprintf(f,"// Generated by levelconv from the Tiled project (%s) - the object classes and their properties set up\n"
        "// there, numbered for LevelObject's cls and the getLevelObject... functions\n#pragma once\n\n",
        project.json?project.path:"none found");
    fprintf(f,"#define LEVEL_CLASS_NONE                0\n");
    for(int n=0;n<project.classCount;n++){
        macroName(jsonString(project.classes[n],"name",""),macro,sizeof(macro));
        fprintf(f,"#define LEVEL_CLASS_%-20s %d\n",macro,n+1);
    }
    fprintf(f,"#define LEVEL_CLASS_COUNT               %d\n\n",project.classCount+1);
    for(int n=0;n<project.propCount;n++){
        macroName(project.props[n],macro,sizeof(macro));
        fprintf(f,"#define LEVEL_PROP_%-21s %d\n",macro,n);
    }
    // Enums: each value of each (e.g. SwitchId's gateA is SWITCH_ID_GATE_A)
    for(int n=0;n<project.enumCount;n++){
        char type[128];
        macroName(jsonString(project.enums[n],"name",""),type,sizeof(type));
        fprintf(f,"\n// %s\n",jsonString(project.enums[n],"name",""));
        int ix=0;
        const cJSON *val;
        cJSON_ArrayForEach(val,cJSON_GetObjectItemCaseSensitive(project.enums[n],"values")){
            macroName(cJSON_IsString(val)?val->valuestring:"",macro,sizeof(macro));
            fprintf(f,"#define %s_%-*s %d\n",type,(int)(31-strlen(type)),macro,ix++);
        }
        fprintf(f,"#define %s_COUNT %d\n",type,ix);
    }
    fclose(f);
}

typedef struct OutProp {
    int id;
    int type;
    long i;
    double f;
    const char *s;
    int objectID;       // Object properties: the Tiled object id, until it's turned into an index
} OutProp;

#define MAX_OBJECT_PROPS 32

typedef struct OutObject {
    int tiledID;
    int cls;
    const char *className;
    int sheet;
    int frame;
    int flags;
    int layer;
    int x, y, w, h;
    OutProp props[MAX_OBJECT_PROPS];
    int propCount;
    int *points;
    int pointCount;
    const char *name;
    // Switches and remembered state ("persist", "value", "mode", "time", "startOn")
    int slot;
    long value, mode, time, startOn;
} OutObject;

static OutObject *objects=NULL;
static int objCount=0;

static int roundi(double v)
{
    return (int)floor(v+0.5);
}

// Set a property from a Tiled property (name, type, value) - replacing one already set (a class default)
static void setObjectProp(OutObject *o, const cJSON *p, const char *where)
{
    const char *name=jsonString(p,"name","");
    const char *type=jsonString(p,"type","string");
    const cJSON *v=cJSON_GetObjectItemCaseSensitive(p,"value");
    // Enums (their type is in "propertytype" on objects, "propertyType" in the project's class members) are numbers
    const char *enumType=jsonString(p,"propertytype",jsonString(p,"propertyType",NULL));
    if(!enumType && o->cls>0){
        // Tiled's export doesn't load the project, so an object's own enum properties can lose their type - use the
        // type its class gives the property
        const cJSON *m;
        cJSON_ArrayForEach(m,cJSON_GetObjectItemCaseSensitive(project.classes[o->cls-1],"members")){
            if(strcmp(jsonString(m,"name",""),name)==0){
                enumType=jsonString(m,"propertyType",jsonString(m,"propertytype",NULL));
            }
        }
    }
    const long enumNumber=enumType?enumValue(enumType,v,where):-1;
    OutProp np;
    memset(&np,0,sizeof(np));
    if(enumNumber>=0){
        np.type=LEVEL_PROP_TYPE_INT;
        np.i=enumNumber;
    }else if(strcmp(type,"file")==0 && cJSON_IsString(v) && (endsWith(v->valuestring,".tmx") || endsWith(v->valuestring,".tmj"))){
        // A link to another level: its number
        np.type=LEVEL_PROP_TYPE_INT;
        np.i=levelID(v->valuestring);
        if(np.i<0){
            warn("%s: \"%s\" links to %s, which isn't in the levels folder",where,name,v->valuestring);
        }
    }else if(strcmp(type,"float")==0){
        np.type=LEVEL_PROP_TYPE_FLOAT;
        np.f=cJSON_IsNumber(v)?v->valuedouble:0.0;
    }else if(strcmp(type,"int")==0){
        np.type=LEVEL_PROP_TYPE_INT;
        np.i=cJSON_IsNumber(v)?(long)v->valuedouble:(cJSON_IsString(v)?atol(v->valuestring):0);
    }else if(strcmp(type,"bool")==0){
        np.type=LEVEL_PROP_TYPE_INT;
        np.i=cJSON_IsTrue(v)?1:0;
    }else if(strcmp(type,"color")==0){
        np.type=LEVEL_PROP_TYPE_INT;
        np.i=(cJSON_IsString(v) && v->valuestring[0]=='#')?(long)strtoul(v->valuestring+1,NULL,16):0;
    }else if(strcmp(type,"object")==0){
        np.type=LEVEL_PROP_TYPE_OBJECT;
        np.objectID=cJSON_IsNumber(v)?(int)v->valuedouble:0;
    }else if(strcmp(type,"class")==0){
        warn("%s: property \"%s\" is a class - only plain properties are included",where,name);
        return;
    }else{
        np.type=LEVEL_PROP_TYPE_STRING;
        np.s=cJSON_IsString(v)?v->valuestring:"";
    }

    // Properties the engine uses itself
    const long number=(np.type==LEVEL_PROP_TYPE_FLOAT)?(long)np.f:np.i;
    bool engineProp=true;
    if(strcmp(name,"waitForCamera")==0){
        o->flags=number?(o->flags|LEVEL_OBJ_WAIT):(o->flags&~LEVEL_OBJ_WAIT);
    }else if(strcmp(name,"persist")==0){
        o->flags=number?(o->flags|LEVEL_OBJ_PERSIST):(o->flags&~LEVEL_OBJ_PERSIST);
    }else if(strcmp(name,"mode")==0){
        o->flags|=LEVEL_OBJ_SWITCH;
        o->mode=number;
    }else if(strcmp(name,"value")==0){
        o->value=number;
    }else if(strcmp(name,"time")==0){
        o->time=number;
    }else if(strcmp(name,"startOn")==0){
        o->startOn=number;
    }else{
        engineProp=false;
    }
    np.id=propID(name);
    if(np.id<0){
        if(!engineProp){
            warn("%s: property \"%s\" isn't in any class in the Tiled project, so isn't included",where,name);
        }
        return;
    }
    for(int n=0;n<o->propCount;n++){
        if(o->props[n].id==np.id){
            o->props[n]=np;
            return;
        }
    }
    if(o->propCount>=MAX_OBJECT_PROPS){
        fail("%s has more than %d properties",where,MAX_OBJECT_PROPS);
    }
    o->props[o->propCount++]=np;
}

// Every object in the map's object layers
static void collectObjects(TileSet *sets, int setCount)
{
    free(objects);
    objects=calloc(MAX_OBJECTS,sizeof(OutObject));
    objCount=0;
    for(int l=0;l<objLayerCount;l++){
        const ObjLayer *ol=objLayers+l;
        const cJSON *j;
        cJSON_ArrayForEach(j,cJSON_GetObjectItemCaseSensitive(ol->json,"objects")){
            if(objCount>=MAX_OBJECTS){
                fail("more than %d objects",MAX_OBJECTS);
            }
            OutObject *o=objects+objCount++;
            o->tiledID=jsonInt(j,"id",0);
            o->name=jsonString(j,"name","");
            o->layer=ol->layer;
            o->sheet=-1;
            char where[300];
            snprintf(where,sizeof(where),"object %d%s%s%s",o->tiledID,o->name[0]?" (\"":"",o->name,o->name[0]?"\")":"");
            const double x=jsonDouble(j,"x",0.0)+ol->offsetX, y=jsonDouble(j,"y",0.0)+ol->offsetY;
            const double w=jsonDouble(j,"width",0.0), h=jsonDouble(j,"height",0.0);
            if(jsonDouble(j,"rotation",0.0)!=0.0){
                warn("%s is rotated in Tiled - its rotation is ignored (set sprite angles in the game)",where);
            }

            // Its class: the object's own, or its tile's
            const char *cls=jsonString(j,"type",jsonString(j,"class",""));
            const cJSON *gidItem=cJSON_GetObjectItemCaseSensitive(j,"gid");
            const TileSet *sheet=NULL;
            if(cJSON_IsNumber(gidItem)){
                const uint32_t gid=(uint32_t)gidItem->valuedouble;
                const int g=(int)(gid&~FLIP_BITS);
                for(int k=0;k<setCount;k++){
                    if(g>=sets[k].firstGid && g<sets[k].firstGid+sets[k].tileCount){
                        sheet=sets+k;
                    }
                }
                if(!sheet){
                    fail("%s: its tile isn't in any tile set",where);
                }
                if(!sheet->spriteName && !sheet->engineName){
                    fail("%s is a tile from \"%s\", which is neither a sprite sheet (see levelconv sprites) nor engine tiles",
                        where,sheet->name);
                }
                o->frame=g-sheet->firstGid;
                o->flags|=(gid&FLIP_X_BIT)?LEVEL_OBJ_FLIP_X:0;
                o->flags|=(gid&FLIP_Y_BIT)?LEVEL_OBJ_FLIP_Y:0;
                if(!cls[0]){
                    const cJSON *tile=tileEntry(sheet->json,o->frame);
                    cls=tile?jsonString(tile,"type",jsonString(tile,"class","")):"";
                }
            }
            o->className=cls;
            o->cls=0;
            if(cls[0]){
                o->cls=classID(cls);
                if(o->cls<0){
                    fail("%s has class \"%s\", which isn't in the Tiled project (%s)",where,cls,
                        project.json?project.path:"no project found");
                }
                // The class's properties, with their defaults
                const cJSON *m;
                cJSON_ArrayForEach(m,cJSON_GetObjectItemCaseSensitive(project.classes[o->cls-1],"members")){
                    setObjectProp(o,m,where);
                }
            }
            const cJSON *p;
            const cJSON *tileProps=(sheet && !sheet->spriteName)?
                cJSON_GetObjectItemCaseSensitive(tileEntry(sheet->json,o->frame),"properties"):NULL;
            cJSON_ArrayForEach(p,cJSON_GetObjectItemCaseSensitive(j,"properties")){
                // A level tile's own properties (its colours, "solid", ...) come with it - they're the tile's, not the
                // object's
                const char *pn=jsonString(p,"name","");
                bool fromTile=false;
                const cJSON *tp;
                cJSON_ArrayForEach(tp,tileProps){
                    fromTile=fromTile || strcmp(jsonString(tp,"name",""),pn)==0;
                }
                if(fromTile && propID(pn)<0){
                    continue;
                }
                setObjectProp(o,p,where);
            }

            // Position (centre) and size
            const cJSON *poly=cJSON_GetObjectItemCaseSensitive(j,"polyline");
            if(!poly){
                poly=cJSON_GetObjectItemCaseSensitive(j,"polygon");
                o->flags|=poly?LEVEL_OBJ_CLOSED:0;
            }
            if(sheet){
                o->sheet=0;     // Numbered once every object's been read
                o->w=sheet->spriteW;
                o->h=sheet->spriteH;
                if(roundi(w)!=sheet->spriteW || roundi(h)!=sheet->spriteH){
                    warn("%s is resized in Tiled - sprites are drawn at their own size",where);
                }
                // Where Tiled puts a tile object's position, by the sprite sheet's object alignment
                const char *al=sheet->alignment;
                double cx=x+(w/2.0), cy=y-(h/2.0);      // Bottom left (the default for orthogonal maps)
                if(strcmp(al,"center")==0){
                    cx=x;
                    cy=y;
                }else if(strcmp(al,"top")==0){
                    cx=x;
                    cy=y+(h/2.0);
                }else if(strcmp(al,"bottom")==0){
                    cx=x;
                    cy=y-(h/2.0);
                }else if(strcmp(al,"topleft")==0){
                    cy=y+(h/2.0);
                }else if(strcmp(al,"left")==0){
                    cy=y;
                }else if(strcmp(al,"topright")==0){
                    cx=x-(w/2.0);
                    cy=y+(h/2.0);
                }else if(strcmp(al,"right")==0){
                    cx=x-(w/2.0);
                    cy=y;
                }else if(strcmp(al,"bottomright")==0){
                    cx=x-(w/2.0);
                }
                o->x=roundi(cx);
                o->y=roundi(cy);
            }else if(poly){
                o->x=roundi(x);
                o->y=roundi(y);
                o->pointCount=cJSON_GetArraySize(poly);
                if(o->pointCount>255){
                    fail("%s has more than 255 points",where);
                }
                o->points=malloc(sizeof(int)*2*(size_t)(o->pointCount?o->pointCount:1));
                int n=0;
                const cJSON *pt;
                cJSON_ArrayForEach(pt,poly){
                    o->points[n*2]=roundi(x+jsonDouble(pt,"x",0.0));
                    o->points[(n*2)+1]=roundi(y+jsonDouble(pt,"y",0.0));
                    ++n;
                }
            }else if(cJSON_IsTrue(cJSON_GetObjectItemCaseSensitive(j,"point"))){
                o->x=roundi(x);
                o->y=roundi(y);
            }else{
                // A rectangle (or ellipse): its centre and size
                o->x=roundi(x+(w/2.0));
                o->y=roundi(y+(h/2.0));
                o->w=roundi(w);
                o->h=roundi(h);
            }
            if(sheet){
                // Remember which sheet, to number it below
                o->sheet=(int)(sheet-sets)+1000;
            }
        }
    }

    // Number the sprite sheets used, and turn object properties into object indexes
    int sheets=0;
    for(int n=0;n<objCount;n++){
        OutObject *o=objects+n;
        if(o->sheet>=1000){
            TileSet *s=sets+(o->sheet-1000);
            if(!s->spriteUsed){
                s->spriteUsed=true;
                s->used=s->used || !s->spriteName;       // Level tiles: the level copies the tile set to RAM
                s->sheetIndex=sheets++;
            }
            o->sheet=s->sheetIndex;
            if(o->frame>=s->frames){
                fail("object %d uses frame %d of \"%s\", which has %d",o->tiledID,o->frame,s->name,s->frames);
            }
        }
        for(int k=0;k<o->propCount;k++){
            OutProp *p=o->props+k;
            if(p->type!=LEVEL_PROP_TYPE_OBJECT){
                continue;
            }
            p->i=-1;
            for(int m=0;m<objCount && p->objectID;m++){
                if(objects[m].tiledID==p->objectID){
                    p->i=m;
                }
            }
            if(p->objectID && p->i<0){
                warn("object %d refers to object %d, which isn't in the level",o->tiledID,p->objectID);
            }
        }
    }
    if(sheets>127){
        fail("more than 127 sprite sheets");
    }

    // A slot in the level's remembered state for each persistent object; switches with graphics need an "on" frame
    int slots=0;
    for(int n=0;n<objCount;n++){
        OutObject *o=objects+n;
        o->slot=(o->flags&LEVEL_OBJ_PERSIST)?slots++:-1;
        if((o->flags&LEVEL_OBJ_SWITCH) && o->sheet>=0){
            for(int s=0;s<setCount;s++){
                if(sets[s].spriteUsed && sets[s].sheetIndex==o->sheet && o->frame+1>=sets[s].frames){
                    fail("switch %d (\"%s\") shows frame %d of \"%s\" - switches show the sheet's last frame (or a level tile, the next tile) when on, so need a later one, which it "
                        "doesn't have",o->tiledID,o->name,o->frame,sets[s].name);
                }
            }
        }
    }
}

static void writeCString(FILE *f, const char *s)
{
    fputc('"',f);
    for(;*s;s++){
        if(*s=='"' || *s=='\\'){
            fputc('\\',f);
        }
        if(*s=='\n'){
            fputs("\\n",f);
            continue;
        }
        fputc(*s,f);
    }
    fputc('"',f);
}

// A table of properties (an object's, or the level's own) in the level's .c file
static void writeProps(FILE *f, const char *table, const OutProp *props, int count)
{
    char macro[256];
    fprintf(f,"static const LevelProp %s[]={",table);
    for(int k=0;k<count;k++){
        const OutProp *p=props+k;
        macroName(project.props[p->id],macro,sizeof(macro));
        fprintf(f,"%s{LEVEL_PROP_%s,",k?",":"",macro);
        switch(p->type){
            case LEVEL_PROP_TYPE_FLOAT:
            {
                // A float literal needs a point (1f isn't valid C, 1.0f is)
                char num[64];
                snprintf(num,sizeof(num),"%.7g",p->f);
                if(!strpbrk(num,".eEn")){
                    strcat(num,".0");
                }
                fprintf(f,"LEVEL_PROP_TYPE_FLOAT,{.f=%sf}}",num);
                break;
            }
            case LEVEL_PROP_TYPE_STRING:
                fprintf(f,"LEVEL_PROP_TYPE_STRING,{.s=");
                writeCString(f,p->s);
                fprintf(f,"}}");
                break;
            case LEVEL_PROP_TYPE_OBJECT:
                fprintf(f,"LEVEL_PROP_TYPE_OBJECT,{.i=%ld}}",p->i);
                break;
            default:
                fprintf(f,"LEVEL_PROP_TYPE_INT,{.i=%ld}}",p->i);
                break;
        }
    }
    fprintf(f,"};\n");
}

// The level's own properties (Map > Map Properties in Tiled): its class's (e.g. Level's levelType, levelName and
// levelDescription), with their defaults, then the map's own
static OutObject levelProps;

static void collectLevelProps(const cJSON *map)
{
    memset(&levelProps,0,sizeof(levelProps));
    levelProps.slot=-1;
    const char *where="the map";
    const char *cls=jsonString(map,"class","");      // (a map's "type" is always "map")
    if(cls[0]){
        levelProps.cls=classID(cls);
        if(levelProps.cls<0){
            fail("the map has class \"%s\", which isn't in the Tiled project (%s)",cls,
                project.json?project.path:"no project found");
        }
        const cJSON *m;
        cJSON_ArrayForEach(m,cJSON_GetObjectItemCaseSensitive(project.classes[levelProps.cls-1],"members")){
            setObjectProp(&levelProps,m,where);
        }
    }
    const cJSON *p;
    cJSON_ArrayForEach(p,cJSON_GetObjectItemCaseSensitive(map,"properties")){
        setObjectProp(&levelProps,p,where);
    }
    // Links to objects: their indexes
    for(int k=0;k<levelProps.propCount;k++){
        OutProp *lp=levelProps.props+k;
        if(lp->type!=LEVEL_PROP_TYPE_OBJECT){
            continue;
        }
        lp->i=-1;
        for(int m=0;m<objCount && lp->objectID;m++){
            if(objects[m].tiledID==lp->objectID){
                lp->i=m;
            }
        }
    }
}

// A level property's int value (e.g. its levelType), or def
static long levelPropInt(const char *name, long def)
{
    const int id=propID(name);
    for(int k=0;k<levelProps.propCount && id>=0;k++){
        if(levelProps.props[k].id==id){
            return (levelProps.props[k].type==LEVEL_PROP_TYPE_FLOAT)?(long)levelProps.props[k].f:levelProps.props[k].i;
        }
    }
    return def;
}

// The objects' tables in the level's .c file
static void writeObjects(FILE *f, TileSet *sets, int setCount)
{
    if(objCount==0){
        return;
    }
    // (objects can all be without sprites, e.g. only exits and entrances)
    bool anySheets=false;
    for(int n=0;n<setCount;n++){
        anySheets=anySheets || sets[n].spriteUsed;
    }
    if(anySheets){
        fprintf(f,"\n// Sprite sheets\nstatic const LevelSpriteSheet sheets[]={\n");
    }
    for(int s=0;anySheets;s++){
        const TileSet *found=NULL;
        for(int n=0;n<setCount;n++){
            if(sets[n].spriteUsed && sets[n].sheetIndex==s){
                found=sets+n;
            }
        }
        if(!found){
            break;
        }
        int size=0;
        for(int k=0;k<(int)(sizeof(spriteSizes)/sizeof(spriteSizes[0]));k++){
            if(spriteSizes[k][0]==found->spriteW && spriteSizes[k][1]==found->spriteH){
                size=k;
            }
        }
        if(found->spriteName){
            fprintf(f,"    {%s,%s,%d,%d,%d,0},      // \"%s\" (SIZE_%dX%d)\n",found->spriteName,found->maskName,size,
                found->palette,found->frames,found->name,found->spriteW,found->spriteH);
        }else{
            // Level tiles: the level's RAM copy of the tile set
            fprintf(f,"    {NULL,NULL,%d,%d,%d,%d},      // \"%s\" tiles (SIZE_%dX%d)\n",size,found->palette,
                (found->frames>255)?255:found->frames,found->levelIndex+1,found->name,found->spriteW,found->spriteH);
        }
    }
    fprintf(f,"%s\n// Objects' properties and paths\n",anySheets?"};\n":"");
    for(int n=0;n<objCount;n++){
        const OutObject *o=objects+n;
        if(o->propCount){
            char table[64];
            snprintf(table,sizeof(table),"object%dProps",n);
            writeProps(f,table,o->props,o->propCount);
        }
        if(o->pointCount){
            fprintf(f,"static const LevelPoint object%dPoints[]={",n);
            for(int k=0;k<o->pointCount;k++){
                fprintf(f,"%s{%d,%d}",k?",":"",o->points[k*2],o->points[(k*2)+1]);
            }
            fprintf(f,"};\n");
        }
    }
    fprintf(f,"\nstatic const LevelObject objects[]={\n");
    for(int n=0;n<objCount;n++){
        const OutObject *o=objects+n;
        char cls[256]="NONE";
        if(o->cls>0){
            macroName(o->className,cls,sizeof(cls));
        }
        char props[64]="NULL", points[64]="NULL";
        if(o->propCount){
            snprintf(props,sizeof(props),"object%dProps",n);
        }
        if(o->pointCount){
            snprintf(points,sizeof(points),"object%dPoints",n);
        }
        fprintf(f,"    {LEVEL_CLASS_%s,%d,%d,0x%02X,%d,%d,%d,%d,%d,%d,%d,%s,%s,",cls,o->sheet,o->frame,o->flags,o->layer,
            o->propCount,o->pointCount,o->x,o->y,o->w,o->h,props,points);
        writeCString(f,o->name);
        fprintf(f,",%d,%ld,%ld,%ld,%ld},    // %d: Tiled object %d\n",o->slot,o->value,o->time,o->mode,o->startOn?1L:0L,n,
            o->tiledID);
    }
    fprintf(f,"};\n");
}

// ---------------------------------------------------------------------------------------------------------------------
// Output
// ---------------------------------------------------------------------------------------------------------------------

static void writeBytes(FILE *f, const uint8_t *data, int n)
{
    for(int i=0;i<n;i++){
        fprintf(f,"%s0x%02X,",(i%24==0)?"\n    ":"",data[i]);
    }
    fprintf(f,"\n");
}

// A tile set's colours, flags and animations, in its own files (tileset_<name>.c/.h), shared by every level using it -
// rather than a copy in each level. Rewritten by each level's conversion (they're the same, from the same tile set)
static void writeTileSet(const TileSet *s, const char *outDir, char *setName, size_t setNameSize)
{
    identifier(s->name,setName,setNameSize);
    char path[1400];
    snprintf(path,sizeof(path),"%stileset_%s.c",outDir,setName);
    FILE *f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    // (an imported tile set's graphics are written from its image, to levels/gfx_<engine name>.c)
    char gfxHeader[300];
    snprintf(gfxHeader,sizeof(gfxHeader),s->imported?"gfx_%s.h":"tileDefs.h",s->engineName);
    if(s->imported){
        writeImportedGfx(outDir,jsonString(s->json,"image",""),s->engineName,s->importedData,NULL,NULL,s->importedSize*2);
    }
    fprintf(f,"// Generated by levelconv from tile set \"%s\" (engine tiles %s) - shared by the levels using it\n\n"
        "#include <stddef.h>\n#include \"tileset_%s.h\"\n#include \"%s\"\n\nstatic const uint8_t attrs[%d]={",s->name,
        s->engineName,setName,gfxHeader,attrBytes(s));
    writeBytes(f,s->attrs,attrBytes(s));
    fprintf(f,"};\nstatic const uint8_t flags[256]={");
    writeBytes(f,s->flags,256);
    fprintf(f,"};\n");
    for(int a=0;a<s->animCount;a++){
        const Anim *an=s->anims+a;
        fprintf(f,"static const LevelAnimFrame anim%dFrames[]={",a);
        for(int k=0;k<an->frameCount;k++){
            fprintf(f,"%s{%d,%d}",k?",":"",an->frames[k],an->ticks[k]);
        }
        fprintf(f,"};\n");
    }
    if(s->animCount){
        fprintf(f,"static const LevelAnim anims[]={\n");
        for(int a=0;a<s->animCount;a++){
            fprintf(f,"    {%d,%d,anim%dFrames},\n",s->anims[a].def,s->anims[a].frameCount,a);
        }
        fprintf(f,"};\n");
    }
    fprintf(f,"\nconst LevelTileSet tileSet_%s={%s,attrs,flags,%d,%s,%d};\n",setName,s->engineName,s->animCount,
        s->animCount?"anims":"NULL",s->tileSize);
    fclose(f);

    snprintf(path,sizeof(path),"%stileset_%s.h",outDir,setName);
    f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fprintf(f,"// Generated by levelconv from tile set \"%s\"\n#pragma once\n\n#include \"level.h\"\n\n"
        "extern const LevelTileSet tileSet_%s;\n",s->name,setName);
    fclose(f);
}

// levels.h and levelList.c in the output folder: every level in the maps' folder, numbered (LEVEL_ID_...), and the
// list of them (levelList - NULL for any not converted yet)
static void writeLevelsHeader(const char *outDir)
{
    char path[1024], name[256], macro[256], file[1400];
    bool converted[MAX_LEVELS];
    for(int n=0;n<levelNameCount;n++){
        identifier(levelNames[n],name,sizeof(name));
        snprintf(file,sizeof(file),"%slevel_%s.h",outDir,name);
        converted[n]=fileExists(file);
    }

    snprintf(path,sizeof(path),"%slevels.h",outDir);
    FILE *f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fprintf(f,"// Generated by levelconv - every level, numbered by the order of their maps' names (levelList in engine/level.h)\n"
        "#pragma once\n\n#include \"level.h\"\n#include \"levelObjects.h\"\n");
    for(int n=0;n<levelNameCount;n++){
        identifier(levelNames[n],name,sizeof(name));
        if(converted[n]){
            fprintf(f,"#include \"level_%s.h\"\n",name);
        }
    }
    fprintf(f,"\n");
    for(int n=0;n<levelNameCount;n++){
        macroName(levelNames[n],macro,sizeof(macro));
        fprintf(f,"#define LEVEL_ID_%-24s %d\n",macro,n);
    }
    fprintf(f,"#define LEVEL_COUNT                       %d\n",levelNameCount);
    fclose(f);

    snprintf(path,sizeof(path),"%slevelList.c",outDir);
    f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fprintf(f,"// Generated by levelconv - every level, by LEVEL_ID_...\n#include <stddef.h>\n#include \"levels.h\"\n\n"
        "const LevelDef *const levelList[%d]={\n",levelNameCount?levelNameCount:1);
    for(int n=0;n<levelNameCount;n++){
        identifier(levelNames[n],name,sizeof(name));
        if(converted[n]){
            fprintf(f,"    &level_%s,\n",name);
        }else{
            fprintf(f,"    NULL,       // %s isn't converted yet\n",levelNames[n]);
        }
    }
    if(!levelNameCount){
        fprintf(f,"    NULL\n");
    }
    fprintf(f,"};\nconst int levelCount=%d;\n",levelNameCount);
    fclose(f);
}

static int runTiledExport(const char *mapPath, const char *jsonPath)
{
    const char *exe=tiledExe;
    if(!exe){
        exe=getenv("TILED_EXE");
    }
#ifdef _WIN32
    if(!exe){
        exe="C:\\Program Files\\Tiled\\tiled.exe";
    }
    if(!fileExists(exe)){
        return -1;
    }
    char qMap[1100], qJson[1100];
    snprintf(qMap,sizeof(qMap),"\"%s\"",mapPath);
    snprintf(qJson,sizeof(qJson),"\"%s\"",jsonPath);
    remove(jsonPath);
    const intptr_t r=_spawnl(_P_WAIT,exe,"tiled","--export-map","--embed-tilesets","--resolve-types-and-properties",
        "json",qMap,qJson,NULL);
    return (r==0 && fileExists(jsonPath))?0:1;
#else
    if(!exe){
        exe="tiled";
    }
    char cmd[4096];
    snprintf(cmd,sizeof(cmd),"\"%s\" --export-map --embed-tilesets --resolve-types-and-properties json \"%s\" \"%s\"",exe,
        mapPath,jsonPath);
    remove(jsonPath);
    return (system(cmd)==0 && fileExists(jsonPath))?0:1;
#endif
}

// A map's JSON, with its tile sets embedded
static cJSON *loadMap(const char *mapPath)
{
    char tmp[1024];
#ifdef _WIN32
    char tmpDir[MAX_PATH];
    GetTempPathA(sizeof(tmpDir),tmpDir);
    snprintf(tmp,sizeof(tmp),"%slevelconv_%u.json",tmpDir,(unsigned)GetCurrentProcessId());
#else
    snprintf(tmp,sizeof(tmp),"/tmp/levelconv_%u.json",(unsigned)getpid());
#endif
    dirOf(tmp,exportDirectory,sizeof(exportDirectory));
    const int r=runTiledExport(mapPath,tmp);
    char *text=NULL;
    if(r==0){
        text=readFile(tmp,NULL);
        remove(tmp);
    }else if(r>0){
        fail("Tiled couldn't export the map (is it a valid map?)");
    }else if(endsWith(mapPath,".tmj") || endsWith(mapPath,".json")){
        text=readFile(mapPath,NULL);
    }else{
        fail("Tiled wasn't found (use --tiled <path to tiled.exe>, or set TILED_EXE) - it's needed to read .tmx maps");
    }
    if(!text){
        fail("can't read the map");
    }
    cJSON *map=cJSON_Parse(text);
    free(text);
    if(!map){
        fail("the map isn't valid JSON");
    }

    // Tile sets not embedded (when read directly): load .tsj files
    char dir[1024];
    dirOf(mapPath,dir,sizeof(dir));
    cJSON *ts;
    cJSON_ArrayForEach(ts,cJSON_GetObjectItemCaseSensitive(map,"tilesets")){
        const char *src=jsonString(ts,"source",NULL);
        if(!src){
            continue;
        }
        if(!endsWith(src,".tsj") && !endsWith(src,".json")){
            fail("tile set %s has to be a .tsj file when Tiled isn't available",src);
        }
        char path[2048];
        snprintf(path,sizeof(path),"%s%s",dir,src);
        char *t=readFile(path,NULL);
        cJSON *tj=t?cJSON_Parse(t):NULL;
        free(t);
        if(!tj){
            fail("can't read tile set %s",path);
        }
        cJSON *child=tj->child;
        while(child){
            if(strcmp(child->string,"firstgid")!=0){
                cJSON_AddItemToObject(ts,child->string,cJSON_Duplicate(child,true));
            }
            child=child->next;
        }
        cJSON_Delete(tj);
    }
    return map;
}

static void convertLevel(const char *mapPath, const char *outDirArg)
{
    currentFile=mapPath;
    char outDir[1024];
    if(outDirArg){
        snprintf(outDir,sizeof(outDir),"%s",outDirArg);
        const size_t n=strlen(outDir);
        if(n && outDir[n-1]!='/' && outDir[n-1]!='\\'){
            strcat(outDir,"/");
        }
    }else{
        dirOf(mapPath,outDir,sizeof(outDir));
    }

    cJSON *map=loadMap(mapPath);
    loadProject(mapPath);
    objLayerCount=0;
    char mapDir[1024];
    dirOf(mapPath,mapDir,sizeof(mapDir));
    snprintf(mapDirectory,sizeof(mapDirectory),"%s",mapDir);
    findLevels(mapDir);
    if(strcmp(jsonString(map,"orientation","orthogonal"),"orthogonal")!=0){
        fail("the map has to be orthogonal");
    }
    if(cJSON_IsTrue(cJSON_GetObjectItemCaseSensitive(map,"infinite"))){
        fail("infinite maps aren't supported - untick Infinite in the map properties");
    }
    mapTile=jsonInt(map,"tilewidth",8);
    if((mapTile!=8 && mapTile!=16) || jsonInt(map,"tileheight",8)!=mapTile){
        fail("the map's tiles have to be 8x8 or 16x16");
    }
    mapW=jsonInt(map,"width",0);
    mapH=jsonInt(map,"height",0);
    if(mapW<1 || mapH<1 || mapW>4096 || mapH>4096){
        fail("the map is %dx%d tiles",mapW,mapH);
    }

    // Tile sets
    static TileSet sets[MAX_TILESETS];
    int setCount=0;
    const cJSON *ts;
    cJSON_ArrayForEach(ts,cJSON_GetObjectItemCaseSensitive(map,"tilesets")){
        if(setCount>=MAX_TILESETS){
            fail("too many tile sets");
        }
        memset(sets+setCount,0,sizeof(TileSet));
        sets[setCount].firstGid=jsonInt(ts,"firstgid",1);
        readTileSet(sets+setCount,ts);
        ++setCount;
    }

    // Layers: those with a "layer" property are level layers, those with "foregroundOf" too are foreground tiles of
    // another layer
    rawCount=0;
    collectLayers(cJSON_GetObjectItemCaseSensitive(map,"layers"),1.0,1.0,0,0);
    static OutLayer out[MAX_TILE_LAYERS];
    int outCount=0;
    bool engineUsed[MAX_TILE_LAYERS]={false};
    for(int n=0;n<rawCount;n++){
        RawLayer *r=rawLayers+n;
        const int layer=propInt(r->json,"layer",-1);
        if(layer<0){
            warn("layer \"%s\" has no \"layer\" property (the engine layer to show it on, 0-%d), so isn't included",
                r->name,MAX_TILE_LAYERS-1);
            continue;
        }
        if(layer>=MAX_TILE_LAYERS){
            fail("layer \"%s\": \"layer\" is %d - the engine has layers 0-%d",r->name,layer,MAX_TILE_LAYERS-1);
        }
        if(engineUsed[layer]){
            fail("two layers are on engine layer %d (layer \"%s\")",layer,r->name);
        }
        engineUsed[layer]=true;
        if(propString(r->json,"foregroundOf")){
            continue;
        }
        OutLayer *o=out+outCount++;
        memset(o,0,sizeof(*o));
        o->raw=r;
        o->layer=layer;
        o->fgLayer=-1;
        o->tileSet=layerTileSet(r,sets,setCount);
        o->flags=(propBool(r->json,"wrapX",false)?LEVEL_WRAP_X:0)|(propBool(r->json,"wrapY",false)?LEVEL_WRAP_Y:0);
        // A single colour layer: its own ink, paper and bright (white on black unless set), or transparent (its pixels
        // only, leaving the colours under it alone)
        if(property(r->json,"ink") || property(r->json,"paper") || property(r->json,"bright") ||
            property(r->json,"transparent")){
            const int ink=propColour(r->json,"ink"), paper=propColour(r->json,"paper");
            o->singleColour=1;
            o->colour=propBool(r->json,"transparent",false)?0x80:
                ((propBool(r->json,"bright",false)?0x40:0)|(((paper<0)?0:paper)<<3)|((ink<0)?7:ink));
        }
    }
    for(int n=0;n<rawCount;n++){
        RawLayer *r=rawLayers+n;
        const char *parent=propString(r->json,"foregroundOf");
        const int layer=propInt(r->json,"layer",-1);
        if(!parent || layer<0){
            continue;
        }
        OutLayer *o=NULL;
        for(int k=0;k<outCount;k++){
            if(strcmp(out[k].raw->name,parent)==0){
                o=out+k;
            }
        }
        if(!o){
            fail("layer \"%s\" is the foreground of \"%s\", which isn't a level layer",r->name,parent);
        }
        if(o->fg){
            fail("layer \"%s\" has two foreground layers",parent);
        }
        if(layer>=o->layer){
            fail("foreground layer \"%s\" is on engine layer %d - it has to be on a lower numbered layer than \"%s\" (%d), "
                "so it's drawn in front of its sprites",r->name,layer,parent,o->layer);
        }
        if(r->parallaxX!=o->raw->parallaxX || r->parallaxY!=o->raw->parallaxY || r->offsetX!=o->raw->offsetX ||
            r->offsetY!=o->raw->offsetY){
            warn("foreground layer \"%s\" moves with \"%s\" - its own parallax and offset are ignored",r->name,parent);
        }
        o->fg=r;
        o->fgLayer=layer;
        o->fgTileSet=layerTileSet(r,sets,setCount);
    }
    if(outCount==0){
        fail("no layers have a \"layer\" property, so there's nothing to convert");
    }

    // Tile sets used, and the engine tile graphics they're for
    int levelSets=0;
    for(int n=0;n<outCount;n++){
        OutLayer *o=out+n;
        if(o->tileSet<0){
            o->tileSet=(o->fgTileSet>=0 && o->fg)?o->fgTileSet:0;
        }
        if(o->fg && o->fgTileSet<0){
            o->fgTileSet=o->tileSet;
        }
        if(!o->fg){
            o->fgTileSet=o->tileSet;
        }
        sets[o->tileSet].used=true;
        sets[o->fgTileSet].used=true;
    }
    for(int n=0;n<setCount;n++){
        sets[n].layerUsed=sets[n].used;
    }

    // Objects (read before the tile sets are numbered, as level tiles placed as objects need their tile set)
    collectObjects(sets,setCount);
    collectLevelProps(map);
    for(int n=0;n<setCount;n++){
        if(!sets[n].used){
            continue;
        }
        if(!sets[n].engineName){
            fail("tile set \"%s\" has no \"engineTiles\" property (the engine tile graphics it shows, e.g. "
                "levelDemoTileDef) - make tile sets with \"levelconv tileset\"",sets[n].name);
        }
        if(!sets[n].tiles){
            fail("tile set \"%s\": no engine tile graphics called \"%s\" in engine/tileDefs.h",sets[n].name,
                sets[n].engineName);
        }
        if(sets[n].layerUsed && sets[n].tileSize!=mapTile){
            fail("tile set \"%s\" has %dx%d tiles, but the map's are %dx%d - a map's tile layers use tile sets of its "
                "tile size",sets[n].name,sets[n].tileSize,sets[n].tileSize,mapTile,mapTile);
        }
        sets[n].levelIndex=levelSets++;
    }

    // Pack (each tile set is copied to RAM: 4KB for 8x8 tiles, 16KB for 16x16)
    uint32_t ram=0;
    for(int n=0;n<setCount;n++){
        ram+=sets[n].used?(uint32_t)(256*sets[n].tileSize*sets[n].tileSize/4):0u;
    }
    int totalPacked=0, totalUnpacked=0;
    for(int n=0;n<outCount;n++){
        OutLayer *o=out+n;
        packLayer(o,sets);
        ram+=align4((uint32_t)o->unpackedSize)+(o->fgCount?align4((uint32_t)o->height*2u):0u);
        totalPacked+=o->packedSize;
        totalUnpacked+=o->unpackedSize;
    }

    // Objects (and an actor for each in RAM)
    ram+=(uint32_t)objCount*(uint32_t)sizeof(LevelActor);
    if(ram>LEVEL_RAM_SIZE){
        fail("the level needs %u bytes of RAM - more than LEVEL_RAM_SIZE (%d, engine/defs.h)",ram,LEVEL_RAM_SIZE);
    }

    // Write the level's .c and .h
    char base[256], name[256], path[1200];
    baseName(mapPath,base,sizeof(base));
    identifier(base,name,sizeof(name));
    snprintf(path,sizeof(path),"%slevel_%s.c",outDir,name);
    FILE *f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fprintf(f,"// Generated by levelconv from %s.%s - edit the level in Tiled and convert it again, rather than editing this\n\n",
        base,endsWith(mapPath,".tmx")?"tmx":"tmj");
    fprintf(f,"#include <stddef.h>\n#include \"level.h\"\n#include \"tileDefs.h\"\n#include \"spriteDefs.h\"\n#include \"levelObjects.h\"\n");
    for(int n=0;n<setCount;n++){
        if(sets[n].used){
            char setName[256];
            writeTileSet(sets+n,outDir,setName,sizeof(setName));
            fprintf(f,"#include \"tileset_%s.h\"\n",setName);
        }
        // Imported sprite sheets' graphics, from their images
        if(sets[n].spriteUsed && sets[n].imported){
            writeImportedGfx(outDir,jsonString(sets[n].json,"image",""),sets[n].spriteName,sets[n].importedData,
                sets[n].maskName,sets[n].importedMask,sets[n].importedSize);
            fprintf(f,"#include \"gfx_%s.h\"\n",sets[n].spriteName);
        }
    }
    for(int n=0;n<outCount;n++){
        const OutLayer *o=out+n;
        fprintf(f,"\n// Layer \"%s\"%s%s%s: %dx%d tiles from %d,%d, %d foreground tiles - %d bytes packed to %d\n",
            o->raw->name,o->fg?" (foreground \"":"",o->fg?o->fg->name:"",o->fg?"\")":"",o->width,o->height,o->tileX,
            o->tileY,o->fgCount,o->unpackedSize,o->packedSize);
        fprintf(f,"static const uint8_t layer%dData[%d]={",n,o->packedSize);
        writeBytes(f,o->packed,o->packedSize);
        fprintf(f,"};\n");
    }
    fprintf(f,"\n// Tile sets (shared with other levels using them)\nstatic const LevelTileSet *const tileSets[]={\n");
    for(int n=0;n<setCount;n++){
        if(sets[n].used){
            char setName[256];
            identifier(sets[n].name,setName,sizeof(setName));
            fprintf(f,"    &tileSet_%s,\n",setName);
        }
    }
    fprintf(f,"};\n\nstatic const LevelLayer layers[]={\n");
    for(int n=0;n<outCount;n++){
        const OutLayer *o=out+n;
        const int px=(int)(o->raw->parallaxX*256.0+0.5), py=(int)(o->raw->parallaxY*256.0+0.5);
        fprintf(f,"    {layer%dData,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,\"%s\",%d,0x%02X},\n",n,o->packedSize,o->width,
            o->height,o->tileX,o->tileY,o->raw->offsetX,o->raw->offsetY,px,py,o->fgCount,sets[o->tileSet].levelIndex,
            sets[o->fgTileSet].levelIndex,o->layer,o->fgLayer,o->flags,o->raw->name,o->singleColour,o->colour);
    }
    fprintf(f,"};\n");
    writeObjects(f,sets,setCount);
    if(levelProps.propCount){
        fprintf(f,"\n// The level's own properties\n");
        writeProps(f,"levelProps",levelProps.props,levelProps.propCount);
    }
    int sheetCount=0;
    for(int n=0;n<setCount;n++){
        sheetCount+=sets[n].spriteUsed?1:0;
    }
    int stateBytes=0;
    for(int n=0;n<objCount;n++){
        stateBytes+=(objects[n].slot>=0)?1:0;
    }
    fprintf(f,"\nconst LevelDef level_%s={\"%s\",%d,%d,%u,%d,%d,%d,%d,tileSets,layers,%s,%s,%d,%d,%d,%s,%d,%ld};\n",name,base,mapW,mapH,
        ram,levelSets,outCount,sheetCount,objCount,sheetCount?"sheets":"NULL",objCount?"objects":"NULL",levelID(mapPath),
        stateBytes,mapTile,levelProps.propCount?"levelProps":"NULL",levelProps.propCount,levelPropInt("levelType",0));
    fclose(f);

    snprintf(path,sizeof(path),"%slevel_%s.h",outDir,name);
    f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fprintf(f,"// Generated by levelconv from %s\n#pragma once\n\n#include \"level.h\"\n\nextern const LevelDef level_%s;\n",
        base,name);
    // Named persistent objects' slots, for setLevelSwitchState etc
    char levelMacro[256], objMacro[256];
    macroName(base,levelMacro,sizeof(levelMacro));
    bool anySlots=false;
    for(int n=0;n<objCount;n++){
        const OutObject *o=objects+n;
        if(o->slot<0 || !o->name[0]){
            continue;
        }
        if(!anySlots){
            fprintf(f,"\n// Remembered objects' slots (setLevelSwitchState)\n");
            anySlots=true;
        }
        macroName(o->name,objMacro,sizeof(objMacro));
        fprintf(f,"#define LEVEL_SLOT_%s_%s %d\n",levelMacro,objMacro,o->slot);
    }
    fclose(f);
    writeObjectsHeader(outDir);
    writeLevelsHeader(outDir);

    printf("%s: level_%s - %dx%d tiles, %d layers, %d objects, %d bytes packed from %d (%.1fx), needs %u bytes of RAM (of %d)%s\n",
        mapPath,name,mapW,mapH,outCount,objCount,totalPacked,totalUnpacked,
        totalPacked?(double)totalUnpacked/(double)totalPacked:0.0,ram,LEVEL_RAM_SIZE,warnings?" - see warnings":"");
    for(int n=0;n<outCount;n++){
        const OutLayer *o=out+n;
        printf("  layer %d \"%s\": %dx%d tiles at %d,%d%s%s, parallax %.2f,%.2f, %d -> %d bytes",o->layer,o->raw->name,
            o->width,o->height,o->tileX,o->tileY,(o->flags&LEVEL_WRAP_X)?", wraps across":"",
            (o->flags&LEVEL_WRAP_Y)?", wraps down":"",o->raw->parallaxX,o->raw->parallaxY,o->unpackedSize,o->packedSize);
        if(o->fg){
            printf(", foreground \"%s\" on layer %d (%d tiles)",o->fg->name,o->fgLayer,o->fgCount);
        }
        printf("\n");
    }
    for(int n=0;n<rawCount;n++){
        free(rawLayers[n].gids);
    }
    for(int n=0;n<outCount;n++){
        free(out[n].packed);
    }
    for(int n=0;n<objCount;n++){
        free(objects[n].points);
    }
    objCount=0;
    cJSON_Delete(map);
}

// ---------------------------------------------------------------------------------------------------------------------
// Tile sets for Tiled
// ---------------------------------------------------------------------------------------------------------------------


static void writeJSON(const char *path, cJSON *json)
{
    char *out=cJSON_Print(json);
    FILE *f=fopen(path,"wb");
    if(!f){
        fail("can't write %s",path);
    }
    fputs(out,f);
    fclose(f);
    free(out);
}

static void writePNG(const char *tsPath, const cJSON *ts, const uint8_t *rgba, int w, int h)
{
    size_t pngSize=0;
    void *png=tdefl_write_image_to_png_file_in_memory(rgba,w,h,4,&pngSize);
    char dir[1024], pngPath[1400];
    dirOf(tsPath,dir,sizeof(dir));
    snprintf(pngPath,sizeof(pngPath),"%s%s",dir,jsonString(ts,"image","tiles.png"));
    FILE *f=fopen(pngPath,"wb");
    if(!f || fwrite(png,1,pngSize,f)!=pngSize){
        fail("can't write %s",pngPath);
    }
    fclose(f);
    mz_free(png);
    printf("%s: drawn\n",pngPath);
}

// A sprite sheet's image: every frame, in its palette's colours, clear where the mask lets the background show
static void drawSpriteSheet(const char *tsPath, cJSON *ts)
{
    TileSet s;
    memset(&s,0,sizeof(s));
    readTileSet(&s,ts);
    if(s.palette<0 || s.palette>=PALETTE_COUNT){
        fail("palette %d doesn't exist (engine/palette.c has %d)",s.palette,PALETTE_COUNT);
    }
    const int columns=jsonInt(ts,"columns",8);
    const int rows=(s.frames+columns-1)/columns;
    const int w=columns*s.spriteW, h=rows*s.spriteH;
    uint8_t *rgba=calloc((size_t)w*h,4);
    const int bpr=spriteBytesPerRow(s.spriteW);
    for(int fr=0;fr<s.frames;fr++){
        const uint8_t *def=s.spriteData+(fr*bpr*s.spriteH);
        const uint8_t *mask=s.maskData+(fr*bpr*s.spriteH);
        for(int y=0;y<s.spriteH;y++){
            const uint8_t attr=palette[s.palette][y/4];
            for(int x=0;x<s.spriteW;x++){
                const bool on=(def[(y*bpr)+(x>>3)]&(0x80>>(x&7)))!=0;
                const bool clear=(mask[(y*bpr)+(x>>3)]&(0x80>>(x&7)))!=0;
                uint8_t *px=rgba+(((((fr/columns)*s.spriteH)+y)*w)+((fr%columns)*s.spriteW)+x)*4;
                if(!on && clear){
                    continue;
                }
                const int bright=(attr&0x40)?8:0;
                const uint8_t *col=(attr&0x80)?zxColours[on?15:0]:zxColours[(on?(attr&7):((attr>>3)&7))+bright];
                px[0]=col[0];
                px[1]=col[1];
                px[2]=col[2];
                px[3]=255;
            }
        }
    }
    cJSON_ReplaceItemInObjectCaseSensitive(ts,"imagewidth",cJSON_CreateNumber(w));
    cJSON_ReplaceItemInObjectCaseSensitive(ts,"imageheight",cJSON_CreateNumber(h));
    writeJSON(tsPath,ts);
    writePNG(tsPath,ts,rgba,w,h);
    free(rgba);
}

static cJSON *readJSONFile(const char *path)
{
    char *text=readFile(path,NULL);
    if(!text){
        return NULL;
    }
    cJSON *j=cJSON_Parse(text);
    free(text);
    if(!j){
        fail("isn't valid JSON");
    }
    return j;
}

static void addProperty(cJSON *props, const char *name, const char *type, cJSON *value)
{
    cJSON *p=cJSON_CreateObject();
    cJSON_AddStringToObject(p,"name",name);
    cJSON_AddStringToObject(p,"type",type);
    cJSON_AddItemToObject(p,"value",value);
    cJSON_AddItemToArray(props,p);
}

// A Tiled tile set of engine sprite graphics, one tile per frame, for placing sprites as tile objects
static void makeSpriteSheet(const char *tsPath, const char *def, const char *mask, const char *size, int pal)
{
    currentFile=tsPath;
    cJSON *ts=readJSONFile(tsPath);
    if(ts && propBool(ts,"imported",false)){
        printf("%s: imported from its image - nothing to redraw (edit the image, then convert the levels)\n",tsPath);
        cJSON_Delete(ts);
        return;
    }
    if(!ts){
        int w=0, h=0;
        if(!def || !mask || !size || sscanf(size,"%dx%d",&w,&h)!=2){
            fail("doesn't exist - make it with: levelconv sprites %s <sprite graphics> <mask> <width>x<height> [palette]",
                tsPath);
        }
        const SpriteDefEntry *d=engineSprite(def);
        if(!d){
            fail("no engine sprite graphics called \"%s\" in engine/spriteDefs.h",def);
        }
        if(!spriteSizeValid(w,h)){
            fail("%dx%d isn't an engine sprite size",w,h);
        }
        const int frames=d->size/(spriteBytesPerRow(w)*h);
        char base[256], image[300];
        baseName(tsPath,base,sizeof(base));
        snprintf(image,sizeof(image),"%s.png",base);
        ts=cJSON_CreateObject();
        cJSON_AddNumberToObject(ts,"columns",(frames<8)?frames:8);
        cJSON_AddStringToObject(ts,"image",image);
        cJSON_AddNumberToObject(ts,"imageheight",h);
        cJSON_AddNumberToObject(ts,"imagewidth",w);
        cJSON_AddNumberToObject(ts,"margin",0);
        cJSON_AddStringToObject(ts,"name",base);
        // Tile objects' positions are their centres, as sprites' are
        cJSON_AddStringToObject(ts,"objectalignment","center");
        cJSON *props=cJSON_AddArrayToObject(ts,"properties");
        addProperty(props,"engineMask","string",cJSON_CreateString(mask));
        addProperty(props,"engineSprite","string",cJSON_CreateString(def));
        addProperty(props,"palette","int",cJSON_CreateNumber(pal));
        cJSON_AddNumberToObject(ts,"spacing",0);
        cJSON_AddNumberToObject(ts,"tilecount",frames);
        cJSON_AddStringToObject(ts,"tiledversion","1.12.2");
        cJSON_AddNumberToObject(ts,"tileheight",h);
        cJSON_AddNumberToObject(ts,"tilewidth",w);
        cJSON_AddStringToObject(ts,"type","tileset");
        cJSON_AddStringToObject(ts,"version","1.10");
        printf("%s: new sprite sheet for %s (%d frames of %dx%d)\n",tsPath,def,frames,w,h);
    }
    if(!propString(ts,"engineSprite")){
        fail("isn't a sprite sheet (it has no \"engineSprite\" property)");
    }
    drawSpriteSheet(tsPath,ts);
    cJSON_Delete(ts);
}

static void makeTileSet(const char *tsPath, const char *engineName)
{
    currentFile=tsPath;
    cJSON *ts=readJSONFile(tsPath);
    if(ts && propBool(ts,"imported",false)){
        // Its image is the artist's: never drawn over
        printf("%s: imported from its image - nothing to redraw (edit the image, then convert the levels)\n",tsPath);
        cJSON_Delete(ts);
        return;
    }
    if(ts && propString(ts,"engineSprite")){
        // A sprite sheet - redraw it
        drawSpriteSheet(tsPath,ts);
        cJSON_Delete(ts);
        return;
    }
    char base[256];
    baseName(tsPath,base,sizeof(base));
    if(!ts){
        if(!engineName){
            fail("doesn't exist - give the engine tile graphics to make it for, e.g. levelconv tileset %s levelDemoTileDef",
                tsPath);
        }
        // A new tile set: 256 tiles (8x8, or 16x16 for a 16KB array), the engine graphics they show, and default colours
        const TileSetEntry *e=engineTiles(engineName);
        if(!e){
            fail("no engine tile graphics called \"%s\" in engine/tileDefs.h",engineName);
        }
        const int size=(e->size==16384)?16:8;
        ts=cJSON_CreateObject();
        cJSON_AddNumberToObject(ts,"columns",16);
        char image[300];
        snprintf(image,sizeof(image),"%s.png",base);
        cJSON_AddStringToObject(ts,"image",image);
        cJSON_AddNumberToObject(ts,"imageheight",16*size);
        cJSON_AddNumberToObject(ts,"imagewidth",16*size);
        cJSON_AddNumberToObject(ts,"margin",0);
        cJSON_AddStringToObject(ts,"name",base);
        cJSON *props=cJSON_AddArrayToObject(ts,"properties");
        cJSON *p=cJSON_CreateObject();
        cJSON_AddStringToObject(p,"name","engineTiles");
        cJSON_AddStringToObject(p,"type","string");
        cJSON_AddStringToObject(p,"value",engineName);
        cJSON_AddItemToArray(props,p);
        const char *defaults[2][2]={{"ink","white"},{"paper","black"}};
        for(int n=0;n<2;n++){
            p=cJSON_CreateObject();
            cJSON_AddStringToObject(p,"name",defaults[n][0]);
            cJSON_AddStringToObject(p,"propertytype","ZXColour");
            cJSON_AddStringToObject(p,"type","string");
            cJSON_AddStringToObject(p,"value",defaults[n][1]);
            cJSON_AddItemToArray(props,p);
        }
        cJSON_AddNumberToObject(ts,"spacing",0);
        cJSON_AddNumberToObject(ts,"tilecount",256);
        cJSON_AddStringToObject(ts,"tiledversion","1.12.2");
        cJSON_AddNumberToObject(ts,"tileheight",size);
        cJSON_AddNumberToObject(ts,"tilewidth",size);
        cJSON_AddStringToObject(ts,"type","tileset");
        cJSON_AddStringToObject(ts,"version","1.10");
        char *out=cJSON_Print(ts);
        FILE *f=fopen(tsPath,"wb");
        if(!f){
            fail("can't write it");
        }
        fputs(out,f);
        fclose(f);
        free(out);
        printf("%s: new tile set for %s\n",tsPath,engineName);
    }

    TileSet s;
    memset(&s,0,sizeof(s));
    readTileSet(&s,ts);
    if(!s.engineName){
        fail("has no \"engineTiles\" property (the engine tile graphics it shows)");
    }
    if(!s.tiles){
        fail("no engine tile graphics called \"%s\" in engine/tileDefs.h",s.engineName);
    }

    // Draw the tiles in their colours (paper left clear where the tile's attributes are transparent), 16 across
    const int size=s.tileSize, w=16*size;
    static uint8_t rgba[256*256*4];
    for(int t=0;t<256;t++){
        for(int r=0;r<size;r++){
            for(int c=0;c<size;c++){
                // 8x8 tiles: a byte a row, 2 attributes; 16x16: 2 bytes a row (left, right), 2 attributes a quarter
                const uint8_t bits=(size==16)?s.tiles[(t*32)+(r*2)+(c>>3)]:s.tiles[(t*8)+r];
                const uint8_t attr=(size==16)?s.attrs[(t*8)+(((((r>>3)<<1)|(c>>3)))*2)+(((r&7)>=4)?1:0)]:
                    s.attrs[(t*2)+((r<4)?0:1)];
                const int bright=(attr&0x40)?8:0;
                uint8_t *px=rgba+(((((t/16)*size)+r)*w)+((t%16)*size)+c)*4;
                const bool on=(bits&(0x80>>(c&7)))!=0;
                if(t==0 || ((attr&0x80) && !on)){
                    px[0]=px[1]=px[2]=px[3]=0;
                    continue;
                }
                const uint8_t *col=(attr&0x80)?zxColours[15]:zxColours[(on?(attr&7):((attr>>3)&7))+bright];
                px[0]=col[0];
                px[1]=col[1];
                px[2]=col[2];
                px[3]=255;
            }
        }
    }
    size_t pngSize=0;
    void *png=tdefl_write_image_to_png_file_in_memory(rgba,w,w,4,&pngSize);
    char dir[1024], pngPath[1400];
    dirOf(tsPath,dir,sizeof(dir));
    snprintf(pngPath,sizeof(pngPath),"%s%s",dir,jsonString(ts,"image","tiles.png"));
    FILE *f=fopen(pngPath,"wb");
    if(!f || fwrite(png,1,pngSize,f)!=pngSize){
        fail("can't write %s",pngPath);
    }
    fclose(f);
    mz_free(png);
    printf("%s: drew %s in its tiles' colours\n",pngPath,s.engineName);
    cJSON_Delete(ts);
}

// ---------------------------------------------------------------------------------------------------------------------

// A C identifier (for an imported image's graphics array)
static void checkIdentifier(const char *name)
{
    bool ok=name && (isalpha((unsigned char)name[0]) || name[0]=='_');
    for(const char *c=name;ok && *c;c++){
        ok=isalnum((unsigned char)*c) || *c=='_';
    }
    if(!ok){
        fail("\"%s\" isn't a C name for the graphics (letters, digits and _, e.g. caveTiles)",name?name:"");
    }
}

static void setProperty(cJSON *ts, const char *name, const char *type, cJSON *value, const char *propertyType)
{
    cJSON *props=cJSON_GetObjectItemCaseSensitive(ts,"properties");
    if(!props){
        props=cJSON_AddArrayToObject(ts,"properties");
    }
    for(int n=cJSON_GetArraySize(props)-1;n>=0;n--){
        if(strcmp(jsonString(cJSON_GetArrayItem(props,n),"name",""),name)==0){
            cJSON_DeleteItemFromArray(props,n);
        }
    }
    cJSON *p=cJSON_CreateObject();
    cJSON_AddStringToObject(p,"name",name);
    if(propertyType){
        cJSON_AddStringToObject(p,"propertytype",propertyType);
    }
    cJSON_AddStringToObject(p,"type",type);
    cJSON_AddItemToObject(p,"value",value);
    cJSON_AddItemToArray(props,p);
}

static void setNumber(cJSON *o, const char *name, double v)
{
    cJSON_DeleteItemFromObjectCaseSensitive(o,name);
    cJSON_AddNumberToObject(o,name,v);
}

static void setString(cJSON *o, const char *name, const char *v)
{
    cJSON_DeleteItemFromObjectCaseSensitive(o,name);
    cJSON_AddStringToObject(o,name,v);
}

// The Tiled tile set for an imported image (made, or updated - keeping its tiles' properties, animations and other
// settings), next to the image: its image, size and graphics name
static cJSON *importedTileSet(const char *pngPath, char *tsPath, size_t tsPathSize, int imgW, int imgH, int tileW,
    int tileH)
{
    char dir[1024], base[256], image[300];
    dirOf(pngPath,dir,sizeof(dir));
    baseName(pngPath,base,sizeof(base));
    snprintf(tsPath,tsPathSize,"%s%s.tsj",dir,base);
    snprintf(image,sizeof(image),"%s.png",base);
    cJSON *ts=readJSONFile(tsPath);
    if(ts && !propBool(ts,"imported",false)){
        fail("%s is already a tile set of engine graphics, not an imported one - import the image under another name",
            tsPath);
    }
    if(!ts){
        ts=cJSON_CreateObject();
        cJSON_AddStringToObject(ts,"name",base);
        cJSON_AddStringToObject(ts,"type","tileset");
        cJSON_AddStringToObject(ts,"version","1.10");
        cJSON_AddStringToObject(ts,"tiledversion","1.12.2");
        setNumber(ts,"margin",0);
        setNumber(ts,"spacing",0);
        setProperty(ts,"imagePaper","string",cJSON_CreateString("black"),"ZXColour");
    }
    const int cols=imgW/tileW, rows=imgH/tileH;
    setString(ts,"image",image);
    setNumber(ts,"imagewidth",imgW);
    setNumber(ts,"imageheight",imgH);
    setNumber(ts,"columns",cols);
    setNumber(ts,"tilecount",cols*rows);
    setNumber(ts,"tilewidth",tileW);
    setNumber(ts,"tileheight",tileH);
    setProperty(ts,"imported","bool",cJSON_CreateTrue(),NULL);
    snprintf(mapDirectory,sizeof(mapDirectory),"%s",dir);
    return ts;
}

// levelconv import <image.png> <graphics name> [8|16]: a PNG of tiles (left to right, then down; the first is tile 0,
// always empty) as a Tiled tile set, and the engine tile graphics (levels/gfx_<name>.c)
static void importTileImage(const char *pngPath, const char *name, int size)
{
    currentFile=pngPath;
    checkIdentifier(name);
    if(size!=8 && size!=16){
        fail("tiles are 8 or 16 pixels square, not %d",size);
    }
    int w=0, h=0;
    uint8_t *rgba=loadPNG(pngPath,&w,&h);
    if(!rgba){
        fail("can't read it - it has to be a PNG");
    }
    free(rgba);
    char tsPath[1300], outDir[1100];
    cJSON *ts=importedTileSet(pngPath,tsPath,sizeof(tsPath),w,h,size,size);
    setProperty(ts,"engineTiles","string",cJSON_CreateString(name),NULL);
    writeJSON(tsPath,ts);

    // Read back as the converter will, and write its graphics
    TileSet s;
    memset(&s,0,sizeof(s));
    readTileSet(&s,ts);
    snprintf(outDir,sizeof(outDir),"%s../",mapDirectory);
    writeImportedGfx(outDir,jsonString(ts,"image",""),name,s.importedData,NULL,NULL,s.importedSize*2);
    printf("%s: %d tiles of %dx%d from %s, graphics %s in %sgfx_%s.c\n",tsPath,(w/size)*(h/size),size,size,pngPath,
        name,outDir,name);
    free(s.importedData);
    cJSON_Delete(ts);
}

// levelconv importsprites <image.png> <graphics name> <width>x<height> [palette]: a PNG of sprite frames (left to
// right, then down) as a Tiled sprite sheet, and the engine sprite graphics and masks (levels/gfx_<name>.c - the
// masks are <name>Mask)
static void importSpriteImage(const char *pngPath, const char *name, const char *sizeText, int pal)
{
    currentFile=pngPath;
    checkIdentifier(name);
    int fw=0, fh=0;
    if(!sizeText || sscanf(sizeText,"%dx%d",&fw,&fh)!=2 || !spriteSizeValid(fw,fh)){
        fail("give the sprites' size, one of the engine's (e.g. 16x16 or 24x24)");
    }
    int w=0, h=0;
    uint8_t *rgba=loadPNG(pngPath,&w,&h);
    if(!rgba){
        fail("can't read it - it has to be a PNG");
    }
    free(rgba);
    if(w%fw || h%fh){
        fail("it's %dx%d - not a whole number of %dx%d frames",w,h,fw,fh);
    }
    char tsPath[1300], outDir[1100], maskName[300];
    snprintf(maskName,sizeof(maskName),"%sMask",name);
    cJSON *ts=importedTileSet(pngPath,tsPath,sizeof(tsPath),w,h,fw,fh);
    setProperty(ts,"engineSprite","string",cJSON_CreateString(name),NULL);
    setProperty(ts,"engineMask","string",cJSON_CreateString(maskName),NULL);
    if(pal>=0 || !property(ts,"palette")){
        setProperty(ts,"palette","int",cJSON_CreateNumber((pal<0)?0:pal),NULL);
    }
    // Tile objects' positions are their centres, as sprites' are
    setString(ts,"objectalignment","center");
    writeJSON(tsPath,ts);

    TileSet s;
    memset(&s,0,sizeof(s));
    readTileSet(&s,ts);
    snprintf(outDir,sizeof(outDir),"%s../",mapDirectory);
    writeImportedGfx(outDir,jsonString(ts,"image",""),name,s.importedData,maskName,s.importedMask,s.importedSize);
    printf("%s: %d frames of %dx%d from %s, graphics %s and %s in %sgfx_%s.c\n",tsPath,s.frames,fw,fh,pngPath,name,
        maskName,outDir,name);
    free(s.importedData);
    free(s.importedMask);
    cJSON_Delete(ts);
}

static void convertAll(const char *dir, const char *outDir)
{
    char d[1024];
    snprintf(d,sizeof(d),"%s",dir);
    const size_t n=strlen(d);
    if(n && d[n-1]!='/' && d[n-1]!='\\'){
        strcat(d,"/");
    }
    int count=0;
#ifdef _WIN32
    const char *patterns[2]={"*.tmx","*.tmj"};
    for(int p=0;p<2;p++){
        char pattern[1100];
        snprintf(pattern,sizeof(pattern),"%s%s",d,patterns[p]);
        WIN32_FIND_DATAA fd;
        HANDLE h=FindFirstFileA(pattern,&fd);
        if(h==INVALID_HANDLE_VALUE){
            continue;
        }
        do{
            char path[1400];
            snprintf(path,sizeof(path),"%s%s",d,fd.cFileName);
            convertLevel(path,outDir);
            ++count;
        }while(FindNextFileA(h,&fd));
        FindClose(h);
    }
#else
    DIR *dd=opendir(d);
    struct dirent *e;
    while(dd && (e=readdir(dd))){
        if(endsWith(e->d_name,".tmx") || endsWith(e->d_name,".tmj")){
            char path[1400];
            snprintf(path,sizeof(path),"%s%s",d,e->d_name);
            convertLevel(path,outDir);
            ++count;
        }
    }
    if(dd){
        closedir(dd);
    }
#endif
    printf("%d levels converted\n",count);
}

static void usage(void)
{
    fprintf(stderr,
        "levelconv level <map.tmx|.tmj> [output folder]   convert a Tiled map to a level (engine/level.h)\n"
        "levelconv all <folder> [output folder]           convert every map in a folder\n"
        "levelconv tileset <tileset.tsj> [engine tiles]   make a Tiled tile set for engine tile graphics (e.g.\n"
        "                                                 levelDemoTileDef), or redraw its image after changing colours\n"
        "levelconv sprites <sheet.tsj> <graphics> <mask> <width>x<height> [palette]\n"
        "                                                 make a Tiled tile set of engine sprite graphics (e.g.\n"
        "                                                 sprite24x24Def mask24x24Def 24x24 5), to place sprites as\n"
        "                                                 tile objects - or redraw one\n"
        "levelconv import <tiles.png> <graphics name> [8|16]\n"
        "                                                 import a PNG of 8x8 (or 16x16) tiles: makes tiles.tsj next to\n"
        "                                                 it, and the engine graphics in levels/gfx_<name>.c\n"
        "levelconv importsprites <sheet.png> <graphics name> <width>x<height> [palette]\n"
        "                                                 import a PNG of sprite frames: makes sheet.tsj next to it, and\n"
        "                                                 the engine graphics and masks (<name>Mask) in levels/gfx_<name>.c\n"
        "options: --tiled <path to tiled.exe>\n");
    exit(2);
}

int main(int argc, char **argv)
{
    int a=1;
    while(a<argc && strncmp(argv[a],"--",2)==0){
        if(strcmp(argv[a],"--tiled")==0 && a+1<argc){
            tiledExe=argv[a+1];
            a+=2;
        }else{
            usage();
        }
    }
    if(a+1>=argc){
        usage();
    }
    const char *cmd=argv[a];
    const char *arg1=argv[a+1];
    const char *arg2=(a+2<argc)?argv[a+2]:NULL;
    if(strcmp(cmd,"level")==0){
        convertLevel(arg1,arg2);
    }else if(strcmp(cmd,"all")==0){
        convertAll(arg1,arg2);
    }else if(strcmp(cmd,"tileset")==0){
        makeTileSet(arg1,arg2);
    }else if(strcmp(cmd,"sprites")==0){
        makeSpriteSheet(arg1,arg2,(a+3<argc)?argv[a+3]:NULL,(a+4<argc)?argv[a+4]:NULL,(a+5<argc)?atoi(argv[a+5]):0);
    }else if(strcmp(cmd,"import")==0 && arg2){
        importTileImage(arg1,arg2,(a+3<argc)?atoi(argv[a+3]):8);
    }else if(strcmp(cmd,"importsprites")==0 && arg2){
        importSpriteImage(arg1,arg2,(a+3<argc)?argv[a+3]:NULL,(a+4<argc)?atoi(argv[a+4]):-1);
    }else{
        usage();
    }
    return 0;
}
