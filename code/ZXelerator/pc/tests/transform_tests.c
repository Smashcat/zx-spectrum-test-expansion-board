// Tests for layer/sprite rotation, scaling and Mode 7 line transforms
//
// 1. Checks the transformed renderers produce exactly the same pixels as the existing fast renderers when the
//    transform is an identity (so the maths lines up with the known-good code), across many positions.
// 2. Renders some example scenes to BMP files for checking by eye.
//
// Usage: ZXeleratorTests [output folder for BMPs]

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#include "engine/Compositor.h"
#include "engine/level.h"
#include "engine/lzUnpack.h"
#include "lzPack.h"
#include "levels.h"

static int failures=0;
static const char *outDir=".";

static uint8_t refPix[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES];
static uint8_t refMask[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES];
static uint8_t refAttr[SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS];
static LayerLineTransform identityLines[SCREEN_HEIGHT_LINES];
static LayerLineTransform floorLines[SCREEN_HEIGHT_LINES];

// Tile set for the Mode 7 floor: tile 0 transparent, 1 solid ink, 2 solid paper, 3 checker
static uint8_t floorTiles[4096];

static void check(bool ok, const char *what, int a, int b)
{
    if(!ok){
        if(failures<20){
            printf("FAIL: %s (%d,%d)\n",what,a,b);
        }
        ++failures;
    }
}

// Checks clipSpan against stepping through every position, including values that need the 64 bit fallback
static uint32_t rngState=12345;
static uint32_t rng(void)
{
    rngState^=rngState<<13;
    rngState^=rngState>>17;
    rngState^=rngState<<5;
    return rngState;
}

static void testClipSpan(void)
{
    static const int32_t edges[]={0,1,-1,2,-2,0x7fff,0x10000,-0x10000,0x7fffffff,-0x7fffffff,INT32_MIN,0x40000000,-0x40000000,123456789,-123456789};
    const int numEdges=(int)(sizeof(edges)/sizeof(edges[0]));
    int tests=0;
    for(int n=0;n<200000;n++){
        int32_t p0, dp, lim;
        const uint32_t kind=rng()%4;
        if(kind==0){
            p0=edges[rng()%numEdges];
            dp=edges[rng()%numEdges];
            lim=edges[rng()%numEdges];
        }else if(kind==1){
            // Typical sprite/bitmap values
            p0=(int32_t)(rng()%(600<<16))-(300<<16);
            dp=(int32_t)(rng()%(8<<16))-(4<<16);
            lim=(int32_t)((1+(rng()%512))<<16);
        }else if(kind==2){
            // Small values, so spans start and end inside the line
            p0=(int32_t)(rng()%2000)-1000;
            dp=(int32_t)(rng()%41)-20;
            lim=(int32_t)(1+(rng()%500));
        }else{
            p0=(int32_t)rng();
            dp=(int32_t)rng();
            lim=(int32_t)(rng()>>1);
        }
        if(lim<=0){
            lim=1;
        }
        const int n0=(int)(rng()%64);
        const int n1=n0+(int)(rng()%300);

        int start=n0, end=n1;
        clipSpan(p0,dp,lim,&start,&end);

        // Expected: the positions inside the source always form one run
        int eStart=n1, eEnd=n1;
        for(int i=n0;i<n1;i++){
            const int64_t p=(int64_t)p0+((int64_t)i*dp);
            if(p>=0 && p<lim){
                if(eStart==n1){
                    eStart=i;
                }
                eEnd=i+1;
            }
        }
        const bool ok=(eStart==eEnd)?(start==end):(start==eStart && end==eEnd);
        if(!ok && failures<20){
            printf("FAIL: clipSpan p0=%d dp=%d lim=%d range=[%d,%d) got [%d,%d) expected [%d,%d)\n",
                p0,dp,lim,n0,n1,start,end,eStart,eEnd);
        }
        failures+=ok?0:1;
        ++tests;
    }
    printf("clipSpan: %d random/edge cases\n",tests);
}

static void buildIdentityLines(int x, int y)
{
    for(int n=0;n<SCREEN_HEIGHT_LINES;n++){
        identityLines[n].u=FIXED16(0.5f-(float)x);
        identityLines[n].v=FIXED16(((float)n+0.5f)-(float)y);
        identityLines[n].dudx=FIXED16_ONE;
        identityLines[n].dvdx=0;
        identityLines[n].enabled=1;
    }
}

static void renderLayerOnly(int layerIX)
{
    initScratchBuffers(true);
    blitLayerToScratchBuffers(layerIX);
}

static void saveReference(void)
{
    memcpy(refPix,scratchPixRam,sizeof(refPix));
    memcpy(refMask,scratchMaskRam,sizeof(refMask));
    memcpy(refAttr,renderAttrBuffer,sizeof(refAttr));
}

static void testTileLayerIdentity(void)
{
    const int layer=0;
    initLayers();
    setTileDefSet(layer,sideDaddyTileDef);
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            const uint8_t top=((x+y)%5==0)?0x80:(uint8_t)(0x40|((x*3+y)&0x3f));
            const uint8_t bottom=(uint8_t)(0x40|((x+y*7)&0x3f));
            setLayerTile(layer,(uint8_t)((x*7)+(y*13)),top,bottom,x,y);
        }
    }

    int tests=0;
    for(int y=-1000;y<SCREEN_HEIGHT_LINES;y+=41){
        for(int x=-1000;x<SCREEN_WIDTH_PIXELS;x+=37){
            for(int mode=0;mode<2;mode++){
                clearLayerTransform(layer);
                setLayerPos(layer,x,y);
                renderLayerOnly(layer);
                saveReference();

                if(mode==0){
                    // Line table path
                    buildIdentityLines(x,y);
                    setLayerLineTransforms(layer,identityLines);
                }else{
                    // Rotation/scale path, forced on with an identity transform
                    tileLayer[layer].transformed=true;
                }
                renderLayerOnly(layer);
                check(memcmp(refPix,scratchPixRam,sizeof(refPix))==0,mode?"tile layer pixels (matrix)":"tile layer pixels (lines)",x,y);
                check(memcmp(refMask,scratchMaskRam,sizeof(refMask))==0,mode?"tile layer mask (matrix)":"tile layer mask (lines)",x,y);
                // Transformed attributes are sampled at the centre of each cell, the fast path rounds differently
                // when not cell aligned, so only compare when aligned
                if((x&7)==0 && (y&3)==0){
                    check(memcmp(refAttr,renderAttrBuffer,sizeof(refAttr))==0,"tile layer attrs",x,y);
                }
                ++tests;
            }
        }
    }
    clearLayerTransform(layer);
    printf("Tile layer identity: %d comparisons\n",tests);
}

// ---------------------------------------------------------------------------
// 16x16 tile layers
// ---------------------------------------------------------------------------

// 64 random 16x16 tiles (tile 0 empty), and the same graphics as 8x8 tiles: 8x8 tile t*4+q is quarter q (top left, top
// right, bottom left, bottom right) of 16x16 tile t. A 16x16 layer and an 8x8 layer whose cells hold t*4+q then show
// exactly the same picture - so every renderer and pixel reader can be checked on 16x16 layers against the 8x8 code
static uint8_t tiles16[256*32*2] __attribute__((aligned(4)));
static uint8_t tiles16As8[256*8*2] __attribute__((aligned(4)));
#define L16     1       // The 16x16 layer
#define L16AS8  2       // The same picture, as an 8x8 layer

static void build16Layers(void)
{
    memset(tiles16,0,sizeof(tiles16));
    memset(tiles16As8,0,sizeof(tiles16As8));
    for(int t=1;t<64;t++){
        for(int n=0;n<32;n++){
            tiles16[(t*32)+n]=(uint8_t)rng();
            tiles16[(256*32)+(t*32)+n]=(uint8_t)rng();
        }
    }
    memset(tiles16+(256*32),0xff,32);       // Tile 0: empty, and see-through
    for(int t=0;t<64;t++){
        for(int q=0;q<4;q++){
            for(int r=0;r<8;r++){
                const int src=(t*32)+((((q>>1)*8)+r)*2)+(q&1);
                tiles16As8[((t*4+q)*8)+r]=tiles16[src];
                tiles16As8[(256*8)+((t*4+q)*8)+r]=tiles16[(256*32)+src];
            }
        }
    }
    setTileDefSet(L16,tiles16);
    setLayerTileSize(L16,16);
    setTileDefSet(L16AS8,tiles16As8);
    for(int ty=0;ty<TILE_LAYER_HEIGHT/2;ty++){
        for(int tx=0;tx<TILE_LAYER_WIDTH/2;tx++){
            const uint8_t t=(rng()%5==0)?0:(uint8_t)(1+(rng()%63));
            for(int q=0;q<4;q++){
                const int cx=(tx*2)+(q&1), cy=(ty*2)+(q>>1);
                const uint8_t top=(uint8_t)(0x40|((cx*3+cy)&0x3f)), bottom=(uint8_t)(0x40|((cx+cy*7)&0x3f));
                setLayerTile(L16,t,top,bottom,cx,cy);
                setLayerTile(L16AS8,(uint8_t)((t*4)+q),top,bottom,cx,cy);
            }
        }
    }
}

// Both layers drawn as they are set up now - the same pixels, mask and colours
static bool same16Render(void)
{
    syncFollowingLayers();
    renderLayerOnly(L16);
    saveReference();
    renderLayerOnly(L16AS8);
    return memcmp(refPix,scratchPixRam,sizeof(refPix))==0 && memcmp(refMask,scratchMaskRam,sizeof(refMask))==0 &&
        memcmp(refAttr,renderAttrBuffer,sizeof(refAttr))==0;
}

// The fast renderer straight from the 16x16 graphics: screen pixel x,y shows layer pixel (x-layerX, y-layerY)
static bool fast16MatchesReference(int px, int py)
{
    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
            uint8_t pix=0, msk=0;
            for(int b=0;b<8;b++){
                const uint32_t lx=(uint32_t)((cx*8)+b-px)&511, ly=(uint32_t)(y-py)&511;
                const uint32_t cell=((ly>>3)*TILE_LAYER_WIDTH)+(lx>>3);
                const uint32_t byte=((uint32_t)tileLayer[L16].tileMap[cell]*32)+((ly&15)*2)+((lx>>3)&1);
                pix=(uint8_t)((pix<<1)|((tiles16[byte]>>(7-(lx&7)))&1));
                msk=(uint8_t)((msk<<1)|((tiles16[(256*32)+byte]>>(7-(lx&7)))&1));
            }
            if(scratchPixRam[(y*SCREEN_WIDTH_CELLS)+cx]!=pix || scratchMaskRam[(y*SCREEN_WIDTH_CELLS)+cx]!=msk){
                return false;
            }
        }
    }
    return true;
}

static void test16x16Layers(void)
{
    initLayers();
    rngState=1616;
    build16Layers();
    int tests=0;

    // Scrolled (the paired column renderer - starting on either half of a tile, and the right edge's carry), against
    // the graphics directly and against the 8x8 layer, as are the line table and matrix paths with nothing transformed
    for(int y=-700;y<SCREEN_HEIGHT_LINES;y+=37){
        for(int x=-700;x<SCREEN_WIDTH_PIXELS;x+=29){
            clearLayerTransform(L16);
            clearLayerTransform(L16AS8);
            setLayerPos(L16,x,y);
            setLayerPos(L16AS8,x,y);
            renderLayerOnly(L16);
            check(fast16MatchesReference(x,y),"16x16 layer, scrolled, against its graphics",x,y);
            check(same16Render(),"16x16 layer, scrolled, as the same 8x8 layer",x,y);
            buildIdentityLines(x,y);
            setLayerLineTransforms(L16,identityLines);
            setLayerLineTransforms(L16AS8,identityLines);
            check(same16Render(),"16x16 layer, identity line table",x,y);
            ++tests;
        }
    }

    // Rotated and scaled
    for(int n=0;n<300;n++){
        const float a=(float)(rng()%628)/100.0f, sx=0.4f+((float)(rng()%250)/100.0f), sy=0.4f+((float)(rng()%250)/100.0f);
        const int x=(int)(rng()%1200)-600, y=(int)(rng()%1200)-600;
        for(int l=L16;l<=L16AS8;l++){
            clearLayerTransform(l);
            setLayerPos(l,x,y);
            setLayerTransform(l,a,sx,sy);
        }
        check(same16Render(),"16x16 layer, rotated and scaled",x,y);
        ++tests;
    }

    // Mode 7: perspective floors from all over the layer, heights and headings
    static LayerLineTransform floor16[SCREEN_HEIGHT_LINES];
    for(int n=0;n<200;n++){
        buildLayerPerspective(floor16,(float)(rng()%2048)-1024.0f,(float)(rng()%2048)-1024.0f,(float)(rng()%628)/100.0f,
            8.0f+(float)(rng()%120),20.0f+(float)(rng()%80),64.0f+(float)(rng()%160));
        setLayerLineTransforms(L16,floor16);
        setLayerLineTransforms(L16AS8,floor16);
        check(same16Render(),"16x16 layer, Mode 7 floor",n,0);
        ++tests;
    }

    // Collision readers: the same pixels from both layers, on screen (transformed or not) and in the layers' own pixels
    int bad=0;
    for(int n=0;n<4000;n++){
        for(int l=L16;l<=L16AS8;l++){
            clearLayerTransform(l);
            setLayerPos(l,-300,-200);
            if(n&1){
                setLayerTransform(l,0.7f,1.3f,0.8f);
            }
        }
        const int x=(int)(rng()%300)-20, y=(int)(rng()%200)-4, k=1+(int)(rng()%32);
        bad+=(getLayerPixelsN(L16,x,y,k)!=getLayerPixelsN(L16AS8,x,y,k))?1:0;
        const int lx=(int)(rng()%2000)-1000, ly=(int)(rng()%2000)-1000;
        bad+=(getLayerMapPixels(L16,lx,ly,k)!=getLayerMapPixels(L16AS8,lx,ly,k))?1:0;
        bad+=(isLayerMapPixelSet(L16,lx,ly)!=isLayerMapPixelSet(L16AS8,lx,ly))?1:0;
        bad+=(isLayerPixelSetAt(L16,x,y)!=isLayerPixelSetAt(L16AS8,x,y))?1:0;
    }
    check(bad==0,"16x16 layer collision readers, as the same 8x8 layer",bad,0);

    // Empty tiles (for skipping collision checks): a cell is only reported empty if its whole 16x16 tile is
    bad=0;
    for(int cy=0;cy<TILE_LAYER_HEIGHT;cy++){
        for(int cx=0;cx<TILE_LAYER_WIDTH;cx++){
            const int t=tileLayer[L16].tileMap[(cy*TILE_LAYER_WIDTH)+cx];
            bad+=(isLayerTileEmpty(L16,cx,cy)!=(t==0))?1:0;
        }
    }
    check(bad==0,"16x16 layer empty tiles",bad,0);
    clearLayerTransform(L16);
    clearLayerTransform(L16AS8);
    printf("16x16 tile layers: %d renders (scrolled, line tables, rotated, scaled, Mode 7) the same as 8x8, and collision readers\n",
        tests);
}

// Single colour layers: the same pixels, but the whole screen in the layer's colour (scrolled, rotated, and on the
// lines of a Mode 7 floor that are drawn) - or, with no colour, the colours left as they were
static void testLayerColour(void)
{
    initLayers();
    rngState=7070;
    build16Layers();
    static uint8_t attrsBefore[SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS];
    static LayerLineTransform floorLines16[SCREEN_HEIGHT_LINES];
    buildLayerPerspective(floorLines16,300.0f,200.0f,0.5f,30.0f,60.0f,128.0f);
    int tests=0;
    for(int mode=0;mode<3;mode++){
        for(int l=L16;l<=L16AS8;l++){
            for(int n=0;n<20;n++){
                const int x=(int)(rng()%1000)-500, y=(int)(rng()%1000)-500;
                clearLayerTransform(l);
                setLayerPos(l,x,y);
                if(mode==1){
                    setLayerTransform(l,(float)(rng()%628)/100.0f,1.2f,0.9f);
                }else if(mode==2){
                    setLayerLineTransforms(l,floorLines16);
                }

                // Per cell colours, as reference
                setLayerColour(l,LAYER_COLOUR_CELLS);
                renderLayerOnly(l);
                saveReference();

                // One colour: the same pixels and mask, and every cell that colour - except, on the floor, above the
                // horizon (lines the table leaves blank), which keep what was there
                setLayerColour(l,0x45);
                initScratchBuffers(true);
                memset(renderAttrBuffer,0x3A,sizeof(attrsBefore));
                blitLayerToScratchBuffers(l);
                bool ok=memcmp(refPix,scratchPixRam,sizeof(refPix))==0 && memcmp(refMask,scratchMaskRam,sizeof(refMask))==0;
                // (a scrolled layer placed at or beyond the right or bottom of the screen is hidden, so colours nothing)
                const bool hidden=(mode==0) && (x>=SCREEN_WIDTH_PIXELS || y>=SCREEN_HEIGHT_LINES);
                for(int cy=0;cy<ATTR_HEIGHT_CELLS && ok;cy++){
                    const bool drawn=!hidden && ((mode!=2) || floorLines16[(cy*ATTR_HEIGHT_PIXELS)+(ATTR_HEIGHT_PIXELS/2)].enabled);
                    for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                        ok=ok && renderAttrBuffer[(cy*SCREEN_WIDTH_CELLS)+cx]==(drawn?0x45:0x3A);
                    }
                }
                check(ok,"single colour layer",mode,n);

                // No colour: pixels only, the colours untouched
                setLayerColour(l,LAYER_COLOUR_NONE);
                initScratchBuffers(true);
                memset(renderAttrBuffer,0x3A,sizeof(attrsBefore));
                memcpy(attrsBefore,renderAttrBuffer,sizeof(attrsBefore));
                blitLayerToScratchBuffers(l);
                check(memcmp(refPix,scratchPixRam,sizeof(refPix))==0 &&
                    memcmp(attrsBefore,renderAttrBuffer,sizeof(attrsBefore))==0,"layer with no colour",mode,n);

                // And back to its cells' colours
                setLayerColour(l,LAYER_COLOUR_CELLS);
                renderLayerOnly(l);
                check(memcmp(refAttr,renderAttrBuffer,sizeof(refAttr))==0,"layer back to cell colours",mode,n);
                setLayerLineTransforms(l,NULL);
                ++tests;
            }
        }
    }
    initLayers();
    printf("Single colour layers: %d (8x8 and 16x16 - scrolled, rotated, Mode 7), and layers with no colour\n",tests);
}

// The colour of every screen pixel (0-15, bright black counted as black), from the render buffers
static uint8_t colourRef[SCREEN_WIDTH_PIXELS*SCREEN_HEIGHT_LINES];
static uint8_t colourOut[SCREEN_WIDTH_PIXELS*SCREEN_HEIGHT_LINES];

static void renderedColours(uint8_t *out)
{
    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        for(int x=0;x<SCREEN_WIDTH_PIXELS;x++){
            const uint8_t attr=renderAttrBuffer[((y/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS)+(x>>3)];
            const bool ink=(renderBuffer[(y*SCREEN_WIDTH_CELLS)+(x>>3)]&(0x80>>(x&7)))!=0;
            int c=(ink?(attr&7):((attr>>3)&7))|((attr&0x40)?8:0);
            if((c&7)==0){
                c=0;
            }
            *out++=(uint8_t)c;
        }
    }
}

static void renderLayerComposited(int layerIX)
{
    initScratchBuffers(true);
    blitLayerToScratchBuffers(layerIX);
    blitScratchToRenderBuffer();
}

// Colour-aware resampling changes which bits are set, but where the transform lines up with the 8x4 cells (identity
// at cell aligned positions) the colours shown must be exactly the same as the untransformed renderer's
static void testBitmapColourAwareIdentity(const uint8_t *bitmap, const uint8_t *attrs, const char *name)
{
    const int layer=1;
    initLayers();
    setLayerType(layer,LT_BITMAP);
    setLayerBitmap(layer,bitmap,attrs);
    const int w=bitmap[0]*8;
    const int h=bitmap[1]*8;
    int tests=0;
    for(int opaque=0;opaque<2;opaque++){
        setLayerOpaque(layer,opaque!=0);
        for(int y=-h+4;y<SCREEN_HEIGHT_LINES;y+=4){
            for(int x=-w+8;x<SCREEN_WIDTH_PIXELS;x+=8){
                clearLayerTransform(layer);
                setLayerPos(layer,x,y);
                renderLayerComposited(layer);
                renderedColours(colourRef);

                buildIdentityLines(x,y);
                setLayerLineTransforms(layer,identityLines);
                renderLayerComposited(layer);
                renderedColours(colourOut);
                check(memcmp(colourRef,colourOut,sizeof(colourRef))==0,name,x,y);
                ++tests;
            }
        }
    }
    clearLayerTransform(layer);
    printf("Colour-aware bitmap identity (%s): %d comparisons\n",name,tests);
}

static void testBitmapLayerIdentity(const uint8_t *bitmap, const uint8_t *attrs, const char *name)
{
    const int layer=1;
    initLayers();
    setLayerType(layer,LT_BITMAP);
    setLayerBitmap(layer,bitmap,attrs);
    // Checks the geometry bit for bit, so resample pixels on their own
    setLayerColourAware(layer,false);
    const int w=bitmap[0]*8;
    const int h=bitmap[1]*8;

    int tests=0;
    const int stepX=(w<SCREEN_WIDTH_PIXELS)?1:5;
    const int stepY=(h>300)?53:((h<SCREEN_HEIGHT_LINES)?3:7);
    // Transparent (ORed) and opaque (masked) bitmap layers
    for(int opaque=0;opaque<2;opaque++){
        setLayerOpaque(layer,opaque!=0);
        for(int y=-h+1;y<SCREEN_HEIGHT_LINES;y+=stepY){
            for(int x=-w+1;x<SCREEN_WIDTH_PIXELS;x+=stepX){
                clearLayerTransform(layer);
                setLayerPos(layer,x,y);
                renderLayerOnly(layer);
                saveReference();

                buildIdentityLines(x,y);
                setLayerLineTransforms(layer,identityLines);
                renderLayerOnly(layer);
                check(memcmp(refPix,scratchPixRam,sizeof(refPix))==0,name,x,y);
                check(memcmp(refMask,scratchMaskRam,sizeof(refMask))==0,opaque?"opaque bitmap mask":"bitmap mask",x,y);
                ++tests;
            }
        }
    }
    setLayerOpaque(layer,false);
    clearLayerTransform(layer);
    printf("Bitmap layer identity (%s): %d comparisons\n",name,tests);
}

// A bitmap narrower and shorter than the screen, so its edges are on screen at every position (the game's bitmaps
// are all at least screen width, which hides edge handling bugs). Header: width in bytes, height in 8 line rows,
// attr width (non-zero = per cell attributes follow separately), unused
#define NARROW_W 5
#define NARROW_ROWS 3
static uint8_t narrowBitmap[4+(NARROW_W*NARROW_ROWS*8)];
static uint8_t narrowAttrs[NARROW_W*NARROW_ROWS*2];

static void buildNarrowBitmap(void)
{
    narrowBitmap[0]=NARROW_W;
    narrowBitmap[1]=NARROW_ROWS;
    narrowBitmap[2]=NARROW_W;
    narrowBitmap[3]=0;
    for(int n=0;n<NARROW_W*NARROW_ROWS*8;n++){
        narrowBitmap[4+n]=(uint8_t)((n*73)^0xa5);
    }
    for(int n=0;n<(int)sizeof(narrowAttrs);n++){
        narrowAttrs[n]=(uint8_t)(0x40|(n&0x3f));
    }
}

static void testSpriteIdentity(SpriteSize size, const uint8_t *def, const uint8_t *mask, int frames, const char *name)
{
    initSprites(1);
    setSpriteSize(0,size);
    setSpriteDef(0,def,mask);
    setSpriteLayer(0,0);
    setSpritePalette(0,2);
    const int w=spriteList[0].width;
    const int h=spriteList[0].height;

    int tests=0;
    for(int frame=0;frame<frames;frame++){
        spriteList[0].frame=frame;
        for(int y=-h;y<SCREEN_HEIGHT_LINES+h;y+=5){
            for(int x=-w;x<SCREEN_WIDTH_PIXELS+w;x+=3){
                // Background pattern, so the mask is tested too
                for(int n=0;n<(int)sizeof(refPix);n++){
                    renderBuffer[n]=(uint8_t)((n*37)^(n>>5));
                }
                memcpy(refMask,renderBuffer,sizeof(refMask));

                spriteList[0].isRotated=0;
                setSpriteRotation(0,0.0f);
                setSpritePos(0,(float)x,(float)y);
                blitSpritesToRenderBuffer(0);
                memcpy(refPix,renderBuffer,sizeof(refPix));

                // Transformed renderer, forced on with no rotation
                memcpy(renderBuffer,refMask,sizeof(refMask));
                spriteList[0].isRotated=1;
                spriteList[0].angle=0.0f;
                updateSpriteTransform(spriteList);
                setSpritePos(0,(float)x,(float)y);
                blitSpritesToRenderBuffer(0);
                check(memcmp(refPix,renderBuffer,sizeof(refPix))==0,name,x,y);
                ++tests;
            }
        }
    }
    printf("Sprite identity (%s): %d comparisons\n",name,tests);
}

// Tile sets as sprite graphics: 8x8 and 16x16 tiles are laid out like 8x8 and 16x16 sprite frames (masks 256 tiles
// on), so a sprite can draw tile n as frame n. Every pixel checked against the tile data, mask included, through the
// fast and the transformed sprite renderers
static void testTileSprites(void)
{
    static const struct { SpriteSize size; const uint8_t *tiles; int bytes; const char *name; } sets[]={
        {SIZE_8X8,levelDemoTileDef,8,"8x8"},
        {SIZE_16X16,levelDemo16TileDef,32,"16x16"},
    };
    int tests=0;
    for(int s=0;s<2;s++){
        // Through setSpriteTile, from a tile layer of that tile size
        initLayers();
        initSprites(1);
        setTileDefSet(3,sets[s].tiles);
        setLayerTileSize(3,(s==1)?16:8);
        setSpriteTile(0,3,1);
        setSpriteLayer(0,0);
        setSpritePalette(0,2);
        const int w=spriteList[0].width, h=spriteList[0].height, bpr=w>>3;
        for(int tile=1;tile<38;tile++){
            check(setSpriteTile(0,3,tile) && spriteList[0].frame==tile,"setSpriteTile",s,tile);
            const uint8_t *def=sets[s].tiles+(tile*sets[s].bytes);
            const uint8_t *mask=def+(256*sets[s].bytes);
            for(int n=0;n<12;n++){
                const int x=(int)(rng()%(SCREEN_WIDTH_PIXELS+w))-(w/2), y=(int)(rng()%(SCREEN_HEIGHT_LINES+h))-(h/2);
                for(int rotated=0;rotated<2;rotated++){
                    for(int i=0;i<(int)sizeof(refPix);i++){
                        renderBuffer[i]=(uint8_t)((i*37)^(i>>5));
                    }
                    memcpy(refMask,renderBuffer,sizeof(refMask));
                    spriteList[0].isRotated=0;
                    setSpriteRotation(0,0.0f);
                    if(rotated){
                        spriteList[0].isRotated=1;
                        spriteList[0].angle=0.0f;
                        updateSpriteTransform(spriteList);
                    }
                    setSpritePos(0,(float)x,(float)y);
                    blitSpritesToRenderBuffer(0);
                    // The position is the sprite's centre
                    bool ok=true;
                    for(int py=0;py<SCREEN_HEIGHT_LINES && ok;py++){
                        for(int px=0;px<SCREEN_WIDTH_PIXELS && ok;px++){
                            const int i=(py*SCREEN_WIDTH_CELLS)+(px>>3);
                            const uint8_t bit=(uint8_t)(0x80>>(px&7));
                            bool want=(refMask[i]&bit)!=0;
                            const int c=px-(x-(w/2)), r=py-(y-(h/2));
                            if(c>=0 && c<w && r>=0 && r<h){
                                const int b=(r*bpr)+(c>>3);
                                const uint8_t tb=(uint8_t)(0x80>>(c&7));
                                want=(want && (mask[b]&tb)) || (def[b]&tb);
                            }
                            ok=(((renderBuffer[i]&bit)!=0)==want);
                        }
                    }
                    check(ok,sets[s].name,tile,rotated);
                    ++tests;
                }
            }
        }
    }
    printf("Tiles as sprites (8x8 and 16x16 tile sets): %d tiles drawn, every pixel checked\n",tests);
}

// A captured frame shown on a layer on its own must reproduce the original frame exactly - both untransformed,
// and through an identity line transform
static FrameSnapshot testSnapshot;
static uint8_t snapRefPix[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES];
static uint8_t snapRefAttr[SCREEN_WIDTH_CELLS*ATTR_HEIGHT_CELLS];

static void testFrameSnapshot(void)
{
    // A busy frame: bitmap layer, text layer and rotated/scaled sprites
    initLayers();
    setLayerType(1,LT_BITMAP);
    setLayerBitmap(1,titleScreenBitmap,titleScreenAttr);
    setLayerPos(1,-13,7);
    setTileDefSet(0,defaultTileDef);
    drawTxtToLayer(0,"SNAPSHOT TEST",0x46,0x45,3,2);
    setLayerPos(0,5,3);
    initSprites(3);
    for(int n=0;n<3;n++){
        setSpriteSize(n,SIZE_32X40);
        setSpriteDef(n,titleLettersDef,titleLettersMaskDef);
        setSpritePalette(n,4);
        setSpriteLayer(n,0);
        spriteList[n].frame=n;
        setSpritePos(n,(float)(40+(n*80)),(float)(100+(n*20)));
        setSpriteRotation(n,(float)n*0.7f);
    }

    captureNextFrame(&testSnapshot);
    initScratchBuffers(true);
    compositeScene();
    memcpy(snapRefPix,renderBuffer,sizeof(snapRefPix));
    memcpy(snapRefAttr,renderAttrBuffer,sizeof(snapRefAttr));
    check(memcmp(testSnapshot.bitmap+4,snapRefPix,sizeof(snapRefPix))==0,"snapshot captured pixels",0,0);
    check(memcmp(testSnapshot.attrs,snapRefAttr,sizeof(snapRefAttr))==0,"snapshot captured attrs",0,0);

    // The snapshot alone, on a different layer, with a background layer behind it (which it must hide)
    initLayers();
    initSprites(0);
    setLayerType(4,LT_BITMAP_WRAP);
    setLayerBitmap(4,gameBackground0Bitmap,NULL);
    setLayerPos(4,-37,-11);
    setLayerSnapshot(2,&testSnapshot);
    setLayerPos(2,0,0);
    // Reference colours of the original frame
    memcpy(renderBuffer,snapRefPix,sizeof(snapRefPix));
    memcpy(renderAttrBuffer,snapRefAttr,sizeof(snapRefAttr));
    renderedColours(colourRef);
    for(int mode=0;mode<3;mode++){
        if(mode>0){
            // Line transformed - bit for bit with colour-aware off, and the same colours with it on
            buildIdentityLines(0,0);
            setLayerLineTransforms(2,identityLines);
            setLayerColourAware(2,mode==2);
        }
        initScratchBuffers(true);
        compositeScene();
        if(mode<2){
            check(memcmp(renderBuffer,snapRefPix,sizeof(snapRefPix))==0,mode?"snapshot layer pixels (line transform)":"snapshot layer pixels",0,0);
        }
        check(memcmp(renderAttrBuffer,snapRefAttr,sizeof(snapRefAttr))==0,"snapshot layer attrs",mode,0);
        renderedColours(colourOut);
        check(memcmp(colourRef,colourOut,sizeof(colourRef))==0,"snapshot layer colours",mode,0);
    }
    clearLayerTransform(2);
    printf("Frame snapshot: captured frame reproduced exactly, untransformed and line transformed\n");
}

// ---------------------------------------------------------------------------
// Collisions
// ---------------------------------------------------------------------------

static uint8_t drawnA[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES];
static uint8_t drawnB[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES];

/// @brief The pixels one sprite draws on its own (every other sprite hidden)
static void drawSpriteAlone(int ix, uint8_t *out)
{
    int16_t layers[8];
    for(int n=0;n<totalSprites;n++){
        layers[n]=spriteList[n].layer;
        if(n!=ix){
            spriteList[n].layer=-1;
        }
    }
    initScratchBuffers(true);
    blitSpritesToRenderBuffer(spriteList[ix].layer);
    memcpy(out,renderBuffer,SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES);
    for(int n=0;n<totalSprites;n++){
        spriteList[n].layer=layers[n];
    }
}

typedef struct TestSpriteType {
    SpriteSize size;
    const uint8_t *def;
    const uint8_t *mask;
    int frames;
} TestSpriteType;

static const TestSpriteType testSpriteTypes[]={
    {SIZE_8X8,sprite24x24Def,mask24x24Def,1},
    {SIZE_16X16,sprite24x24Def,mask24x24Def,1},
    {SIZE_24X24,sprite24x24Def,mask24x24Def,2},
    {SIZE_24X24,spriteBubbleDef,spriteBubbleMaskDef,3},
    {SIZE_32X40,titleLettersDef,titleLettersMaskDef,10},
};

static void randomSprite(int ix, int layer)
{
    const TestSpriteType *t=testSpriteTypes+(rng()%(sizeof(testSpriteTypes)/sizeof(testSpriteTypes[0])));
    setSpriteSize(ix,t->size);
    setSpriteDef(ix,t->def,t->mask);
    setSpriteLayer(ix,layer);
    setSpritePalette(ix,2);
    spriteList[ix].frame=(int16_t)(rng()%t->frames);
    spriteList[ix].isRotated=0;
    setSpriteRotation(ix,0.0f);
    const uint32_t kind=rng()%3;
    if(kind==1){
        const float s=0.4f+((float)(rng()%160)/100.0f);
        setSpriteScale(ix,s,0.4f+((float)(rng()%160)/100.0f));
    }else{
        setSpriteScale(ix,0.0f,0.0f);
    }
    if(kind==2 || (rng()%4)==0){
        setSpriteRotation(ix,(float)(rng()%628)/100.0f);
    }
}

// Sprite sets: membership, moving between sets, taking sprites out (first, middle, last), looping through a set, and
// finding which set a sprite that was hit is in
static void testSpriteSets(void)
{
    initSprites(12);
    const int platforms=createSpriteSet(), enemies=createSpriteSet(), doors=createSpriteSet();
    check(platforms>=0 && enemies>=0 && doors>=0 && platforms!=enemies && enemies!=doors,"sprite sets created",
        platforms,enemies);
    for(int n=1;n<=5;n++){
        addSpriteToSet(n,platforms);
    }
    for(int n=6;n<=9;n++){
        addSpriteToSet(n,enemies);
    }
    addSpriteToSet(10,doors);
    check(getSpriteSetCount(platforms)==5 && getSpriteSetCount(enemies)==4 && getSpriteSetCount(doors)==1,
        "sprite set counts",getSpriteSetCount(platforms),getSpriteSetCount(enemies));
    check(isSpriteInSet(3,platforms) && !isSpriteInSet(3,enemies) && !isSpriteInSet(0,platforms) &&
        getSpriteSet(0)==SPRITE_SET_NONE && getSpriteSet(7)==enemies,"sprite set membership",getSpriteSet(7),enemies);

    // Move one to another set, take out the first, a middle one and the last
    addSpriteToSet(3,enemies);
    removeSpriteFromSet(1);
    removeSpriteFromSet(5);
    removeSpriteFromSet(8);
    int order[16], count=0;
    for(int ix=firstSpriteInSet(platforms);ix>=0 && count<16;ix=nextSpriteInSet(ix)){
        order[count++]=ix;
    }
    check(count==2 && order[0]==2 && order[1]==4 && getSpriteSetCount(platforms)==2,"sprites left in a set, in order",
        count,getSpriteSetCount(platforms));
    count=0;
    for(int ix=firstSpriteInSet(enemies);ix>=0 && count<16;ix=nextSpriteInSet(ix)){
        order[count++]=ix;
    }
    check(count==4 && order[0]==6 && order[1]==7 && order[2]==9 && order[3]==3 && getSpriteSetCount(enemies)==4,
        "sprites moved to another set go at its end",count,order[3]);
    check(getSpriteSet(1)==SPRITE_SET_NONE && getSpriteSet(8)==SPRITE_SET_NONE,"sprites taken out of a set",0,0);

    // Taking every sprite out while looping (getting the next one first)
    for(int ix=firstSpriteInSet(enemies),next;ix>=0;ix=next){
        next=nextSpriteInSet(ix);
        removeSpriteFromSet(ix);
    }
    check(getSpriteSetCount(enemies)==0 && firstSpriteInSet(enemies)<0 && getSpriteSet(6)==SPRITE_SET_NONE,
        "every sprite taken out of a set in a loop",getSpriteSetCount(enemies),0);

    // A deleted set frees its sprites, and its slot is reused
    deleteSpriteSet(platforms);
    check(getSpriteSet(2)==SPRITE_SET_NONE && getSpriteSet(4)==SPRITE_SET_NONE && firstSpriteInSet(platforms)<0,
        "deleting a set frees its sprites",getSpriteSet(2),0);
    check(createSpriteSet()==platforms,"a deleted set's slot is reused",0,0);
    int made=3;
    while(createSpriteSet()!=SPRITE_SET_NONE){
        ++made;
    }
    check(made==MAX_SPRITE_SETS,"MAX_SPRITE_SETS sets can be made",made,MAX_SPRITE_SETS);

    // Collisions: the player overlaps a platform and an enemy - which has it hit?
    initLayers();
    initSprites(4);
    const int plat=createSpriteSet(), foes=createSpriteSet();
    for(int n=0;n<4;n++){
        setSpriteSize(n,SIZE_24X24);
        setSpriteDef(n,sprite24x24Def,mask24x24Def);
        setSpriteLayer(n,2);
    }
    setSpritePos(0,100,100);
    setSpritePos(1,104,104);
    setSpritePos(2,96,98);
    setSpritePos(3,200,50);
    addSpriteToSet(1,plat);
    addSpriteToSet(2,foes);
    addSpriteToSet(3,foes);
    setSpriteCollisions(0,COLLIDE_SPRITES);
    setSpriteSetCollisions(plat,COLLIDE_TARGET);
    setSpriteSetCollisions(foes,COLLIDE_TARGET);
    detectCollisions();
    check(spriteList[0].spriteHitCount==2,"player hits a platform and an enemy",spriteList[0].spriteHitCount,2);
    check(getSpriteHitInSet(0,plat)==1 && getSpriteHitInSet(0,foes)==2,"which set each hit sprite is in",
        getSpriteHitInSet(0,plat),getSpriteHitInSet(0,foes));
    setSpriteSetCollisions(foes,COLLIDE_NONE);
    detectCollisions();
    check(getSpriteHitInSet(0,foes)<0 && getSpriteHitInSet(0,plat)==1,"a set's collisions switched off",
        getSpriteHitInSet(0,foes),-1);
    // Solid sprites: found in a box, in a layer's coordinates, only in solid sets, and only while solid
    initSprites(4);
    const int solids=createSpriteSet(), others=createSpriteSet();
    for(int n=0;n<4;n++){
        setSpriteSize(n,SIZE_16X32);
        setSpriteLayer(n,2);
        setSpriteSpace(n,SPRITE_SPACE_LAYER,-1);
    }
    setSpritePos(0,100,100);      // 92-107 across, 84-115 down
    setSpritePos(1,200,100);
    setSpritePos(2,300,100);
    addSpriteToSet(0,solids);
    addSpriteToSet(1,others);
    setSpriteSetSolid(solids,true);
    addSpriteToSet(2,solids);
    check(getSolidSpriteAt(2,107,115,120,130)==0 && getSolidSpriteAt(2,108,90,120,100)<0 &&
        getSolidSpriteAt(2,80,116,120,120)<0,"a solid sprite's box",getSolidSpriteAt(2,108,90,120,100),-1);
    check(getSolidSpriteAt(2,190,90,210,110)<0,"sprites in other sets aren't solid",0,0);
    check(getSolidSpriteAt(2,290,90,310,110)==2,"sprites added to a solid set are solid",0,0);
    check(getSolidSpriteAt(3,90,90,110,110)<0,"only the layer's own sprites",0,0);
    setSpriteSolid(0,false);
    check(getSolidSpriteAt(2,90,90,110,110)<0,"a sprite made not solid",0,0);
    setSpriteSolid(0,true);
    removeSpriteFromSet(0);
    check(getSolidSpriteAt(2,90,90,110,110)<0,"a sprite taken out of a solid set isn't solid",0,0);

    initSprites(1);
    check(firstSpriteInSet(plat)<0 && createSpriteSet()==0,"initSprites clears the sets",0,0);
    deleteSpriteSets();
    printf("Sprite sets: membership, moving, removing, looping, deleting, and hits by set\n");
}

static void testSpriteSpriteCollisions(void)
{
    initLayers();
    initSprites(2);
    rngState=4242;
    int tests=0, hits=0;
    for(int n=0;n<20000;n++){
        randomSprite(0,1);
        randomSprite(1,2);
        const int x=(int)(rng()%300)-22;
        const int y=(int)(rng()%236)-22;
        setSpritePos(0,(float)x,(float)y);
        setSpritePos(1,(float)(x+(int)(rng()%61)-30),(float)(y+(int)(rng()%61)-30));
        // Each sprite checks for collisions (half the time), is only a target, or isn't in collision tests at all
        static const uint8_t roles[4]={COLLIDE_SPRITES,COLLIDE_SPRITES,COLLIDE_TARGET,COLLIDE_NONE};
        const uint8_t roleA=roles[rng()%4];
        const uint8_t roleB=roles[rng()%4];
        setSpriteCollisions(0,roleA);
        setSpriteCollisions(1,roleB);

        drawSpriteAlone(0,drawnA);
        drawSpriteAlone(1,drawnB);
        bool overlap=false;
        for(int i=0;i<(int)sizeof(drawnA) && !overlap;i++){
            overlap=(drawnA[i]&drawnB[i])!=0;
        }
        // A sprite records a hit if the pixels overlap, it checks for collisions, and the other can be hit
        const bool expectA=overlap && roleA==COLLIDE_SPRITES && roleB!=COLLIDE_NONE;
        const bool expectB=overlap && roleB==COLLIDE_SPRITES && roleA!=COLLIDE_NONE;
        detectCollisions();
        const bool gotA=(spriteList[0].spriteHitCount==1 && spriteList[0].spriteHits[0]==1);
        const bool gotB=(spriteList[1].spriteHitCount==1 && spriteList[1].spriteHits[0]==0);
        const bool ok=(gotA==expectA) && (gotB==expectB) && (spriteList[0].spriteHitCount<=1) &&
            (spriteList[1].spriteHitCount<=1);
        check(ok,"sprite-sprite collision",x,y);
        const bool expected=overlap;
        if(!ok && failures<=8){
            for(int k=0;k<2;k++){
                const Sprite *s=spriteList+k;
                printf("   sprite %d: %dx%d scaled=%d(%.2f,%.2f) rotated=%d(%.2f) off=(%d,%d) scaledWH=(%d,%d) expected=%d got=%d\n",
                    k,s->width,s->height,s->isScaled,s->scaleX,s->scaleY,s->isRotated,s->angle,s->offX,s->offY,
                    s->scaledWidth,s->scaledHeight,expected,k?gotB:gotA);
                const uint8_t *drawn=k?drawnB:drawnA;
                int shown=0;
                for(int yy=0;yy<SCREEN_HEIGHT_LINES && shown<4;yy++){
                    for(int xx=0;xx<SCREEN_WIDTH_PIXELS && shown<4;xx+=32){
                        const uint32_t c=getSpritePixels32(s,xx,yy);
                        uint32_t d=0;
                        for(int b=0;b<4;b++){
                            d=(d<<8)|drawn[(yy*SCREEN_WIDTH_CELLS)+(xx>>3)+b];
                        }
                        if(c!=d){
                            printf("     line %d x %d: collision %08x drawn %08x\n",yy,xx,c,d);
                            ++shown;
                        }
                    }
                }
            }
        }
        hits+=expected?1:0;
        ++tests;
    }
    // A checks, B is a target, C isn't in collision tests, and a second target D - all on top of each other. Only A
    // records hits (B and D), and nothing is recorded for the targets or C
    initSprites(4);
    for(int n=0;n<4;n++){
        setSpriteSize(n,SIZE_24X24);
        setSpriteDef(n,sprite24x24Def,mask24x24Def);
        setSpriteLayer(n,1);
        setSpritePos(n,100.0f,100.0f);
    }
    setSpriteCollisions(0,COLLIDE_SPRITES);
    setSpriteCollisions(1,COLLIDE_TARGET);
    setSpriteCollisions(2,COLLIDE_NONE);
    setSpriteCollisions(3,COLLIDE_TARGET);
    detectCollisions();
    const Sprite *sl=spriteList;
    check(sl[0].spriteHitCount==2 && sl[0].spriteHits[0]==1 && sl[0].spriteHits[1]==3,"checking sprite hits targets only",
        sl[0].spriteHitCount,0);
    check(sl[1].spriteHitCount==0 && sl[2].spriteHitCount==0 && sl[3].spriteHitCount==0,"targets and others record nothing",
        sl[1].spriteHitCount+sl[3].spriteHitCount,sl[2].spriteHitCount);
    check(collisionPairsTested==2,"only pairs with a checking sprite are tested",(int)collisionPairsTested,2);

    // One checking sprite among 40 targets and 40 others: 40 pairs, rather than all 3240 pairs of the 81
    initSprites(81);
    for(int n=0;n<81;n++){
        setSpriteSize(n,SIZE_8X8);
        setSpriteDef(n,sprite24x24Def,mask24x24Def);
        setSpriteLayer(n,1);
        setSpritePos(n,(float)(10+((n*29)%236)),(float)(10+((n*17)%172)));
        setSpriteCollisions(n,(n==0)?COLLIDE_SPRITES:((n&1)?COLLIDE_TARGET:COLLIDE_NONE));
    }
    detectCollisions();
    check(collisionPairsTested==40,"pairs tested with one checking sprite and 40 targets",(int)collisionPairsTested,40);
    printf("Sprite-sprite collisions: %d random pairs (%d touching, random roles), matching the drawn pixels\n",tests,hits);
}

// Layer space sprites: drawn where the layer puts them, turning with it (or not)
static int countDiffBits(const uint8_t *a, const uint8_t *b, int *setBits)
{
    int diff=0, set=0;
    for(int i=0;i<SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES;i++){
        uint8_t d=a[i]^b[i], s=a[i];
        for(;d;d&=(uint8_t)(d-1)){
            ++diff;
        }
        for(;s;s&=(uint8_t)(s-1)){
            ++set;
        }
    }
    *setBits=set;
    return diff;
}

static void testLayerSpaceSprites(void)
{
    const int layer=1;
    initLayers();
    setTileDefSet(layer,defaultTileDef);
    initSprites(2);
    rngState=8080;
    int exact=0, rotating=0, maxDiffPercent=0, collisionTests=0;
    for(int n=0;n<3000;n++){
        const int kind=n%3;     // 0 scrolled layer, 1 rotated layer with an upright sprite, 2 rotating with the layer
        clearLayerTransform(layer);
        setLayerPos(layer,(int)(rng()%400)-200,(int)(rng()%400)-200);
        const float layerAngle=(float)(rng()%628)/100.0f;
        const float layerScale=0.6f+((float)(rng()%100)/100.0f);
        if(kind>0){
            setLayerTransform(layer,layerAngle,layerScale,layerScale);
        }

        // The layer space sprite (uniformly scaled, so its combined transform is still a rotation and a scale)
        randomSprite(0,layer);
        if(spriteList[0].isScaled){
            setSpriteScale(0,spriteList[0].scaleX,spriteList[0].scaleX);
        }
        spriteList[0].space=SPRITE_SPACE_SCREEN;
        setSpriteSpace(0,SPRITE_SPACE_LAYER,-1);
        setSpriteRotateWithLayer(0,kind==2);
        setSpritePos(0,(float)(rng()%600),(float)(rng()%600));
        placeLayerSprites();
        const int sx=spriteList[0].x, sy=spriteList[0].y;
        float ex, ey;
        layerToScreen(layer,spriteList[0].xF,spriteList[0].yF,&ex,&ey);
        check(sx==(int)floorf(ex+0.001f) && sy==(int)floorf(ey+0.001f),"layer space sprite position",sx,sy);
        drawSpriteAlone(0,drawnA);

        // The same sprite in screen space, at the same place on screen
        Sprite *s1=spriteList+1;
        const Sprite *s0=spriteList;
        setSpriteSize(1,s0->size);
        setSpriteDef(1,s0->defPtr,s0->maskPtr);
        setSpriteLayer(1,layer);
        s1->frame=s0->frame;
        s1->space=SPRITE_SPACE_SCREEN;
        const float ownScale=s0->isScaled?s0->scaleX:1.0f;
        if(kind==2){
            setSpriteScale(1,ownScale*layerScale,ownScale*layerScale);
            setSpriteRotation(1,s0->angle+layerAngle);
        }else{
            setSpriteScale(1,s0->isScaled?s0->scaleX:0.0f,s0->isScaled?s0->scaleY:0.0f);
            setSpriteRotation(1,s0->angle);
        }
        setSpritePos(1,(float)sx,(float)sy);
        drawSpriteAlone(1,drawnB);

        int setBits;
        const int diff=countDiffBits(drawnA,drawnB,&setBits);
        if(kind<2){
            check(diff==0,kind?"upright layer space sprite matches screen space":"layer space sprite on a scrolled layer matches screen space",n,diff);
            ++exact;
        }else{
            // The combined transform is worked out differently, so allow a few pixels at the edges
            const int allowed=4+(setBits*3/100);
            check(diff<=allowed,"layer space sprite rotating with the layer",diff,allowed);
            if(setBits>0 && (diff*100/setBits)>maxDiffPercent){
                maxDiffPercent=diff*100/setBits;
            }
            ++rotating;
        }

        // Collisions use what's drawn
        setSpriteCollisions(0,COLLIDE_SPRITES);
        setSpriteCollisions(1,COLLIDE_TARGET);
        setSpritePos(1,(float)(sx+(int)(rng()%41)-20),(float)(sy+(int)(rng()%41)-20));
        setSpriteRotation(1,(float)(rng()%628)/100.0f);
        drawSpriteAlone(1,drawnB);
        bool overlap=false;
        for(int i=0;i<(int)sizeof(drawnA) && !overlap;i++){
            overlap=(drawnA[i]&drawnB[i])!=0;
        }
        detectCollisions();
        check((spriteList[0].spriteHitCount==1)==overlap,"layer space sprite collision",n,overlap);
        ++collisionTests;

        // Back to screen space, and it stays in the same place
        setSpriteSpace(0,SPRITE_SPACE_SCREEN,-1);
        check(spriteList[0].x==sx && spriteList[0].y==sy,"back to screen space in the same place",spriteList[0].x-sx,spriteList[0].y-sy);
        setSpriteCollisions(0,COLLIDE_NONE);
        setSpriteCollisions(1,COLLIDE_NONE);
    }
    clearLayerTransform(layer);
    printf("Layer space sprites: %d exact matches (scrolled, and upright), %d rotating with the layer (within %d%% of pixels), %d collisions\n",
        exact,rotating,maxDiffPercent,collisionTests);
}

static void testSpriteLayerCollisions(void)
{
    static uint8_t layerPix[SCREEN_WIDTH_CELLS*SCREEN_HEIGHT_LINES];
    const int layer=2;
    initLayers();
    setTileDefSet(layer,defaultTileDef);
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            // A mix of empty (space) and text tiles
            const uint8_t tile=((x*7+y*3)%5==0)?' ':(uint8_t)('A'+((x+y)%26));
            setLayerTile(layer,tile,0x47,0x47,x,y);
        }
    }
    initSprites(1);
    rngState=777;
    int tests=0, hitTests=0;
    for(int n=0;n<6000;n++){
        clearLayerTransform(layer);
        setLayerPos(layer,(int)(rng()%1200)-900,(int)(rng()%1100)-900);
        const bool transformed=(n%3)==0;
        if(transformed){
            setLayerTransform(layer,(float)(rng()%628)/100.0f,0.5f+((float)(rng()%200)/100.0f),0.5f+((float)(rng()%200)/100.0f));
        }
        randomSprite(0,layer);
        setSpritePos(0,(float)((int)(rng()%290)-17),(float)((int)(rng()%226)-17));
        setSpriteCollisions(0,COLLIDE_LAYER);

        drawSpriteAlone(0,drawnA);
        initScratchBuffers(true);
        blitLayerToScratchBuffers(layer);
        memcpy(layerPix,scratchPixRam,sizeof(layerPix));

        // Tiles under every pixel where the sprite and the tiles' pixels overlap
        int expected[64][2];
        int numExpected=0;
        for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
            for(int x=0;x<SCREEN_WIDTH_PIXELS;x++){
                const int i=(y*SCREEN_WIDTH_CELLS)+(x>>3);
                if((drawnA[i]&layerPix[i]&(0x80>>(x&7)))==0){
                    continue;
                }
                int tx, ty;
                if(transformed){
                    getLayerTileAt(layer,x,y,&tx,&ty);
                }else{
                    tx=((x-tileLayer[layer].x)&511)>>3;
                    ty=((y-tileLayer[layer].y)&511)>>3;
                }
                bool found=false;
                for(int e=0;e<numExpected;e++){
                    found|=(expected[e][0]==tx && expected[e][1]==ty);
                }
                if(!found && numExpected<64){
                    expected[numExpected][0]=tx;
                    expected[numExpected][1]=ty;
                    ++numExpected;
                }
            }
        }

        detectCollisions();
        const Sprite *s=spriteList;
        bool ok=(s->tileHitCount==((numExpected<MAX_COLLISION_HITS)?numExpected:MAX_COLLISION_HITS));
        for(int h=0;h<s->tileHitCount && ok;h++){
            bool found=false;
            for(int e=0;e<numExpected;e++){
                found|=(expected[e][0]==s->tileHits[h].x && expected[e][1]==s->tileHits[h].y);
            }
            ok=found;
        }
        check(ok,transformed?"sprite-layer collision (rotated layer)":"sprite-layer collision",n,numExpected);
        hitTests+=(numExpected>0)?1:0;
        ++tests;
    }
    clearLayerTransform(layer);
    printf("Sprite-layer collisions: %d random tests (%d touching tiles), matching the drawn pixels and tiles\n",tests,hitTests);
}

// Particle bounces: a flat floor only reverses Y, a vertical wall only reverses X, a slope changes both
static uint8_t physicsTiles[4096];

static void setupPhysicsLayer(int layer)
{
    memset(physicsTiles,0,sizeof(physicsTiles));
    for(int r=0;r<8;r++){
        physicsTiles[(1*8)+r]=0xff;                         // solid block
        physicsTiles[(2*8)+r]=(uint8_t)((1u<<(r+1))-1);     // slope, rising to the right (solid below the "/")
        physicsTiles[(3*8)+r]=(uint8_t)(0xffu<<(7-r));      // slope, rising to the left (solid below the "\")
    }
    initLayers();
    setTileDefSet(layer,physicsTiles);
    setLayerPos(layer,0,0);
}

static Particle *firstParticle(int set)
{
    return particleSets[set].particles;
}

static int runUntilBounce(int set, float *xDir, float *yDir, int frames)
{
    Particle *p=firstParticle(set);
    const float startX=p->xDir, startY=p->yDir;
    for(int f=0;f<frames;f++){
        updateParticles();
        if(p->xDir!=startX || p->yDir!=startY){
            *xDir=p->xDir;
            *yDir=p->yDir;
            return f+1;
        }
    }
    *xDir=p->xDir;
    *yDir=p->yDir;
    return 0;
}

static void launchParticle(int set, float x, float y, float xDir, float yDir)
{
    startParticles(set,0,0,1,0.0f,0.0f,0.0f,0.0f,1000,1001);
    Particle *p=firstParticle(set);
    p->x=x;
    p->y=y;
    p->xDir=xDir;
    p->yDir=yDir;
    p->delay=0;
}

// The tile at a screen point must be the one drawn there: with odd numbered tiles solid and even ones empty, a point's
// tile number is odd exactly when the renderer drew a pixel there - for scrolled, rotated/scaled and Mode 7 layers
static uint8_t oddSolidTiles[4096];
static LayerLineTransform tileAtLines[SCREEN_HEIGHT_LINES];

static void testTileAtPoint(void)
{
    const int layer=2;
    for(int t=0;t<256;t++){
        for(int r=0;r<8;r++){
            oddSolidTiles[(t*8)+r]=(t&1)?0xff:0x00;
            oddSolidTiles[2048+(t*8)+r]=(t&1)?0x00:0xff;
        }
    }
    initLayers();
    setTileDefSet(layer,oddSolidTiles);
    rngState=2024;
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            setLayerTile(layer,(uint8_t)(rng()&0xff),0x47,0x47,x,y);
        }
    }
    int tests=0;
    for(int t=0;t<300;t++){
        clearLayerTransform(layer);
        setLayerPos(layer,(int)(rng()%1000)-800,(int)(rng()%1000)-800);
        const int kind=t%3;
        if(kind==1){
            setLayerTransform(layer,(float)(rng()%628)/100.0f,0.5f+((float)(rng()%200)/100.0f),0.5f+((float)(rng()%200)/100.0f));
        }else if(kind==2){
            buildLayerPerspective(tileAtLines,(float)(rng()%512),(float)(rng()%512),(float)(rng()%628)/100.0f,24.0f,
                (float)(rng()%100),128.0f);
            setLayerLineTransforms(layer,tileAtLines);
        }
        initScratchBuffers(true);
        blitLayerToScratchBuffers(layer);
        const bool drawn=isLayerCollidable(layer);
        for(int k=0;k<200;k++){
            const int x=(int)(rng()%SCREEN_WIDTH_PIXELS);
            const int y=(int)(rng()%SCREEN_HEIGHT_LINES);
            const bool pixel=(scratchPixRam[(y*SCREEN_WIDTH_CELLS)+(x>>3)]&(0x80>>(x&7)))!=0;
            int tx=-1, ty=-1;
            const int tile=getLayerTileNumberAt(layer,x,y,&tx,&ty);
            if(!drawn){
                check(tile==-1 && !isLayerPixelSetAt(layer,x,y),"tile at a point, layer not drawn",x,y);
                continue;
            }
            check(isLayerPixelSetAt(layer,x,y)==pixel,"isLayerPixelSetAt matches the drawn pixel",x,y);
            // Mode 7 lines above the horizon aren't drawn, and have no tile
            if(tile<0){
                check(kind==2 && !pixel,"tile at a point missing",x,y);
                continue;
            }
            check(((tile&1)!=0)==pixel,"tile at a point is the one drawn",x,y);
            check(tile==tileLayer[layer].tileMap[(ty*TILE_LAYER_WIDTH)+tx],"tile number matches its map position",tx,ty);
            if(kind==0){
                check(tx==(((x-tileLayer[layer].x)&511)>>3) && ty==(((y-tileLayer[layer].y)&511)>>3),"tile position when scrolled",x,y);
            }
            ++tests;
        }
    }
    // Off screen points have no tile
    clearLayerTransform(layer);
    setLayerPos(layer,0,0);
    check(getLayerTileNumberAt(layer,-1,10,NULL,NULL)==-1 && getLayerTileNumberAt(layer,10,SCREEN_HEIGHT_LINES,NULL,NULL)==-1 &&
        !isLayerPixelSetAt(layer,SCREEN_WIDTH_PIXELS,0),"no tile off screen",0,0);
    printf("Tile at a point: %d points on scrolled, rotated/scaled and Mode 7 layers, matching the drawn tiles\n",tests);
}

// Tiles at points near layer space sprites: straight from the tile map, matching what's drawn at the same point on
// screen, and working off screen too
static void testSpriteTileAt(void)
{
    const int layer=2;
    initLayers();
    setTileDefSet(layer,oddSolidTiles);     // Built by testTileAtPoint: odd numbered tiles solid, even ones empty
    rngState=5150;
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            setLayerTile(layer,(uint8_t)(rng()&0xff),0x47,0x47,x,y);
        }
    }
    initSprites(1);
    int tests=0, onScreen=0, screenDiffers=0, plainTests=0;
    for(int t=0;t<2000;t++){
        clearLayerTransform(layer);
        setLayerPos(layer,(int)(rng()%300)-200,(int)(rng()%300)-200);
        if(t&1){
            const float scale=0.6f+((float)(rng()%100)/100.0f);
            setLayerTransform(layer,(float)(rng()%628)/100.0f,scale,scale);
        }
        randomSprite(0,layer);
        spriteList[0].space=SPRITE_SPACE_SCREEN;
        setSpriteSpace(0,SPRITE_SPACE_LAYER,-1);
        setSpriteRotateWithLayer(0,(rng()&1)!=0);
        setSpritePos(0,(float)(rng()%700)-100.0f,(float)(rng()%700)-100.0f);
        placeLayerSprites();
        for(int k=0;k<20;k++){
            const float dx=(float)((int)(rng()%61)-30);
            const float dy=(float)((int)(rng()%61)-30);
            int tx, ty;
            const int tile=getSpriteTileAt(0,dx,dy,&tx,&ty);
            float lu, lv;
            getSpritePoint(0,dx,dy,&lu,&lv);
            const int mapTile=tileLayer[layer].tileMap[((((int)floorf(lv))>>3)&63)*TILE_LAYER_WIDTH+((((int)floorf(lu))>>3)&63)];
            check(tile==mapTile,"sprite tile at a point is the map tile",tile,mapTile);
            check(isSpritePointSolid(0,dx,dy)==((tile&1)!=0),"isSpritePointSolid matches the tile",tile,0);
            // The whole pixel versions give the same answers (fast route or not)
            int tx2=-1, ty2=-1;
            check(getSpriteTileAtI(0,(int)dx,(int)dy,&tx2,&ty2)==tile && tx2==tx && ty2==ty,
                "getSpriteTileAtI matches getSpriteTileAt",tx2,tx);
            check(isSpritePointSolidI(0,(int)dx,(int)dy)==isSpritePointSolid(0,dx,dy),
                "isSpritePointSolidI matches isSpritePointSolid",(int)dx,(int)dy);
            plainTests+=(spriteList[0].rotSin==0.0f && !spriteList[0].isScaled)?1:0;
            ++tests;
            // The same point on screen (where it's on screen, and the layer is drawn)
            float sx, sy;
            layerToScreen(layer,lu,lv,&sx,&sy);
            if(sx>=0.0f && sx<(float)SCREEN_WIDTH_PIXELS && sy>=0.0f && sy<(float)SCREEN_HEIGHT_LINES){
                const int screenTile=getLayerTileNumberAt(layer,(int)sx,(int)sy,NULL,NULL);
                if(screenTile>=0){
                    ++onScreen;
                    if(screenTile!=tile){
                        // The screen lookup samples the centre of the screen pixel the point is in - up to ~1.2 layer
                        // pixels away when scaled - so it can only differ near a tile edge
                        ++screenDiffers;
                        const float fu=fmodf(fmodf(lu,8.0f)+8.0f,8.0f), fv=fmodf(fmodf(lv,8.0f)+8.0f,8.0f);
                        const float edge=fminf(fminf(fu,8.0f-fu),fminf(fv,8.0f-fv));
                        check(edge<1.5f,"sprite tile differs from the screen away from a tile edge",(int)(edge*10),0);
                    }
                }
            }
        }
        // And in screen space
        if((t&3)==0){
            setSpriteSpace(0,SPRITE_SPACE_SCREEN,-1);
            for(int k=0;k<10;k++){
                const int dx=(int)(rng()%61)-30, dy=(int)(rng()%61)-30;
                const int a=getSpriteTileAtI(0,dx,dy,NULL,NULL), b=getSpriteTileAt(0,(float)dx,(float)dy,NULL,NULL);
                check(a==b,"getSpriteTileAtI matches getSpriteTileAt in screen space",a,b);
                check(isSpritePointSolidI(0,dx,dy)==isSpritePointSolid(0,(float)dx,(float)dy),
                    "isSpritePointSolidI matches isSpritePointSolid in screen space",dx,dy);
            }
        }
    }

    // isLayerMapPixelSet reads single pixels as getLayerMapPixels does, with patterned tile graphics
    static uint8_t patternTiles[256*8];
    for(int n=0;n<256*8;n++){
        patternTiles[n]=(uint8_t)rng();
    }
    setTileDefSet(layer,patternTiles);
    for(int n=0;n<20000;n++){
        const int x=(int)(rng()%2000)-1000, y=(int)(rng()%2000)-1000;
        check(isLayerMapPixelSet(layer,x,y)==(getLayerMapPixels(layer,x,y,1)!=0),"isLayerMapPixelSet matches the map",x,y);
    }
    setTileDefSet(layer,oddSolidTiles);
    // Speed on a rotated layer (PC, and this build has AddressSanitizer, so only relative): the raw lookups, and a point
    // near the same sprite in screen space and in layer space (both including working out the point)
    setLayerTransform(layer,0.5f,1.0f,1.0f);
    setSpriteRotation(0,0.3f);
    volatile int sink=0;
    const int loops=400000;
    clock_t t0=clock();
    for(int n=0;n<loops;n++){
        sink+=getLayerTileNumberAt(layer,n&255,(n>>8)%192,NULL,NULL);
    }
    const double rawScreen=(double)(clock()-t0);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=getLayerMapTileNumber(layer,n&511,(n>>9)&511,NULL,NULL);
    }
    const double rawMap=(double)(clock()-t0);
    setSpriteSpace(0,SPRITE_SPACE_SCREEN,-1);
    setSpritePos(0,128.0f,96.0f);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=getSpriteTileAt(0,(float)((n&63)-32),(float)(((n>>6)&63)-32),NULL,NULL);
    }
    const double spriteScreen=(double)(clock()-t0);
    setSpriteSpace(0,SPRITE_SPACE_LAYER,-1);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=getSpriteTileAt(0,(float)((n&63)-32),(float)(((n>>6)&63)-32),NULL,NULL);
    }
    const double spriteLayer=(double)(clock()-t0);
    // The same sprite, not rotated or scaled (a player turning with the layer): float offsets, then whole pixel ones
    setSpriteRotateWithLayer(0,true);
    setSpriteScale(0,0.0f,0.0f);
    setSpriteRotation(0,0.0f);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=getSpriteTileAt(0,(float)((n&63)-32),(float)(((n>>6)&63)-32),NULL,NULL);
    }
    const double plainFloat=(double)(clock()-t0);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=getSpriteTileAtI(0,(n&63)-32,((n>>6)&63)-32,NULL,NULL);
    }
    const double plainInt=(double)(clock()-t0);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=isSpritePointSolid(0,(float)((n&63)-32),(float)(((n>>6)&63)-32))?1:0;
    }
    const double solidFloat=(double)(clock()-t0);
    t0=clock();
    for(int n=0;n<loops;n++){
        sink+=isSpritePointSolidI(0,(n&63)-32,((n>>6)&63)-32)?1:0;
    }
    const double solidInt=(double)(clock()-t0);
    (void)sink;
    clearLayerTransform(layer);
    printf("Sprite tile at a point: %d points (%d unrotated and unscaled), all matching the tile map (%d on screen, %d on screen differing only at tile edges)\n",
        tests,plainTests,onScreen,screenDiffers);
    printf("Tile at a point, rotated layer (PC): map lookup %.1fx faster than screen; near a sprite, layer space %.1fx faster than screen space\n",
        rawScreen/(rawMap>0?rawMap:1),spriteScreen/(spriteLayer>0?spriteLayer:1));
    printf("Unrotated, unscaled layer space sprite (PC): tile %.1fx and solid pixel %.1fx faster with whole pixel offsets; %.1fx faster than a rotated sprite in screen space\n",
        plainFloat/(plainInt>0?plainInt:1),solidFloat/(solidInt>0?solidInt:1),spriteScreen/(plainInt>0?plainInt:1));
}

// Which space the particle tests run in (they run in both)
static ParticleSpace testSpace=PARTICLE_SPACE_SCREEN;

// The narrow and layer space samplers against the full 32 pixel one (itself checked against the drawn pixels by the
// sprite-layer test), and the screen/layer conversions against what the renderer draws
static void testLayerSamplers(void)
{
    const int layer=2;
    initLayers();
    setTileDefSet(layer,defaultTileDef);
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            setLayerTile(layer,(uint8_t)('A'+((x*3+y*5)%26)),0x47,0x47,x,y);
        }
    }
    rngState=31337;
    int tests=0, mapMismatches=0, mapTests=0;
    for(int t=0;t<3000;t++){
        clearLayerTransform(layer);
        setLayerPos(layer,(int)(rng()%1000)-800,(int)(rng()%1000)-800);
        const bool rotated=(t&1)!=0;
        if(rotated){
            setLayerTransform(layer,(float)(rng()%628)/100.0f,0.5f+((float)(rng()%200)/100.0f),0.5f+((float)(rng()%200)/100.0f));
        }
        for(int k=0;k<20;k++){
            const int x=(int)(rng()%300)-20;
            const int y=(int)(rng()%192);
            const int n=1+(int)(rng()%32);
            const uint32_t full=getLayerPixels32(layer,x,y);
            const uint32_t top=(n==32)?full:(full&~(0xffffffffu>>n));
            check(getLayerPixelsN(layer,x,y,n)==top,"getLayerPixelsN",x,n);
            ++tests;
            if(!rotated && isLayerCollidable(layer)){
                // Scrolled (and drawn): layer coordinates are just offset
                const TileLayer *tL=tileLayer+layer;
                check(getLayerMapPixels(layer,x-tL->x,y-tL->y,n)==getLayerPixelsN(layer,x,y,n),"getLayerMapPixels",x,y);
            }
            // The layer pixel at a screen pixel's centre is the one drawn there (rounding at pixel edges can differ
            // slightly, between float and fixed point)
            if(x>=0 && x<SCREEN_WIDTH_PIXELS){
                float u, v;
                screenToLayer(layer,(float)x+0.5f,(float)y+0.5f,&u,&v);
                const uint32_t mapPix=getLayerMapPixels(layer,(int)floorf(u),(int)floorf(v),1);
                mapMismatches+=(mapPix!=getLayerPixelsN(layer,x,y,1))?1:0;
                ++mapTests;
                float sx, sy;
                layerToScreen(layer,u,v,&sx,&sy);
                check(fabsf(sx-((float)x+0.5f))<0.01f && fabsf(sy-((float)y+0.5f))<0.01f,"layerToScreen round trip",x,y);
            }
        }
    }
    clearLayerTransform(layer);
    check(mapMismatches*200<mapTests,"screenToLayer matches the drawn pixels",mapMismatches,mapTests);
    printf("Layer samplers: %d narrow samples, screenToLayer matches drawn pixels in %d of %d\n",tests,
        mapTests-mapMismatches,mapTests);
}

static void testParticleBounces(void)
{
    const int layer=3;
    float xd, yd;

    // Flat floor along tile row 15 (pixels 120-127)
    setupPhysicsLayer(layer);
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        setLayerTile(layer,1,0x47,0x47,x,15);
    }
    deleteParticleSets();
    int set=createParticleSet(4,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetBounce(set,1.0f);
    launchParticle(set,100.3f,90.0f,1.5f,3.0f);
    int f=runUntilBounce(set,&xd,&yd,30);
    check(f>0 && xd==1.5f && yd==-3.0f,"particle bounce off floor (Y only)",(int)(xd*100),(int)(yd*100));
    const float restY=firstParticle(set)->y;
    check(restY+2.0f<120.0f,"particle stops above floor",(int)restY,0);

    // Vertical wall along tile column 20 (pixels 160-167)
    setupPhysicsLayer(layer);
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        setLayerTile(layer,1,0x47,0x47,20,y);
    }
    deleteParticleSets();
    set=createParticleSet(4,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetBounce(set,1.0f);
    launchParticle(set,140.0f,50.2f,2.5f,0.7f);
    f=runUntilBounce(set,&xd,&yd,30);
    check(f>0 && xd==-2.5f && yd==0.7f,"particle bounce off wall (X only)",(int)(xd*100),(int)(yd*100));

    // A slope, rising to the right, across tile row 12 (with solid tiles below it)
    setupPhysicsLayer(layer);
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        setLayerTile(layer,2,0x47,0x47,x,12);
        setLayerTile(layer,1,0x47,0x47,x,13);
    }
    deleteParticleSets();
    set=createParticleSet(4,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetBounce(set,1.0f);
    launchParticle(set,100.0f,80.0f,0.0f,3.0f);
    f=runUntilBounce(set,&xd,&yd,30);
    check(f>0 && xd<-0.5f && yd<0.0f && yd>-3.0f,"particle bounce off slope (X and Y)",(int)(xd*100),(int)(yd*100));

    // With gravity, particles bounce lower and lower and settle on the floor - never inside it
    setupPhysicsLayer(layer);
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        setLayerTile(layer,1,0x47,0x47,x,15);
    }
    deleteParticleSets();
    set=createParticleSet(64,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetGravity(set,0.3f);
    rngState=99;
    startParticles(set,128,40,64,-1.0f,1.0f,0.5f,3.0f,1000,1001);
    setParticleSetStillLimit(set,0);
    bool inside=false;
    for(int n=0;n<300;n++){
        updateParticles();
        for(int i=0;i<64;i++){
            const Particle *p=particleSets[set].particles+i;
            if(p->timeToLive>0 && p->x>-2 && p->x<250 && ((int)p->y)+2>=120){
                inside=true;
            }
        }
    }
    int resting=0;
    for(int i=0;i<64;i++){
        const Particle *p=particleSets[set].particles+i;
        if(p->timeToLive>0 && fabsf(p->yDir)<1.0f && ((int)p->y)+2==119){
            ++resting;
        }
    }
    check(!inside,"particles never enter the floor",0,0);
    check(resting>32,"particles settle on the floor",resting,0);
    deleteParticleSets();
    printf("Particle bounces: floor (Y only), wall (X only), slope (both), settling under gravity (%d of 64 resting)\n",resting);
}

// Particles on continuous 45 degree ramps (slope tiles laid diagonally, with solid tiles below): they should bounce
// off to the side and slide down, not stop on the slope or bounce straight up
static bool particleOnSlopeTile(int layer, const Particle *p)
{
    // The tiles just under the particle's 2x2 block (pixels x+1..x+2, y+1..y+3)
    for(int dy=1;dy<=3;dy++){
        for(int dx=1;dx<=2;dx++){
            int tx, ty;
            if(getLayerTileAt(layer,(int)p->x+dx,(int)p->y+dy,&tx,&ty)){
                const uint8_t t=tileLayer[layer].tileMap[(ty*TILE_LAYER_WIDTH)+tx];
                if(t==2 || t==3){
                    return true;
                }
            }
        }
    }
    return false;
}

// Counts a particle bouncing straight up from a slope 3 times without moving more than a pixel or so sideways - the
// "bouncing in place" artefact (a single upward deflection can be right, e.g. rolling into the bottom of a ramp)
typedef struct BounceTrack {
    int count;
    float x;
} BounceTrack;

static bool trackVerticalBounce(BounceTrack *t, const Particle *p)
{
    if(t->count==0 || fabsf(p->x-t->x)>1.5f){
        t->count=1;
        t->x=p->x;
        return false;
    }
    return ++t->count==3;
}

static void testParticleSlopes(void)
{
    const int layer=3;
    setupPhysicsLayer(layer);
    // Floor
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        for(int y=21;y<24;y++){
            setLayerTile(layer,1,0x47,0x47,x,y);
        }
    }
    // Ramp up (rising to the right) from tile column 4, a plateau, then a ramp down
    for(int i=0;i<8;i++){
        setLayerTile(layer,2,0x47,0x47,4+i,20-i);
        for(int y=21-i;y<21;y++){
            setLayerTile(layer,1,0x47,0x47,4+i,y);
        }
        setLayerTile(layer,3,0x47,0x47,20+i,13+i);
        for(int y=14+i;y<21;y++){
            setLayerTile(layer,1,0x47,0x47,20+i,y);
        }
    }
    for(int x=12;x<20;x++){
        for(int y=13;y<21;y++){
            setLayerTile(layer,1,0x47,0x47,x,y);
        }
    }

    deleteParticleSets();
    const int total=48;
    const int set=createParticleSet(total,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetGravity(set,0.12f);
    setParticleSetBounce(set,0.7f);
    setParticleSetStillLimit(set,0);   // Don't remove still particles here - we're looking for them
    for(int n=0;n<total;n++){
        // Half above the rising ramp, half above the falling one
        const float x=(n<total/2)?(36.0f+(float)(n*2)):(164.0f+(float)((n-total/2)*2));
        emitParticle(set,x+0.3f,20.0f+(float)(n%5),0.0f,0.0f,2000);
    }

    int stillFrames[48]={0};
    int lastX[48], lastY[48];
    int stuck=0, bounces=0, verticalBounces=0, inPlace=0;
    bool counted[48]={false};
    BounceTrack track[48]={{0}};
    for(int n=0;n<total;n++){
        lastX[n]=-1000;
        lastY[n]=-1000;
    }
    for(int f=0;f<400;f++){
        float vx[48], vy[48];
        for(int n=0;n<total;n++){
            vx[n]=particleSets[set].particles[n].xDir;
            vy[n]=particleSets[set].particles[n].yDir;
        }
        updateParticles();
        for(int n=0;n<total;n++){
            const Particle *p=particleSets[set].particles+n;
            if(p->timeToLive<=0){
                continue;
            }
            // A bounce - the velocity changed by more than gravity - while over a slope
            const float gx=p->xDir-vx[n], gy=p->yDir-vy[n]-0.12f;
            const bool bounced=(fabsf(gx)>0.05f || fabsf(gy)>0.05f) && (fabsf(vx[n])+fabsf(vy[n])>0.8f);
            if(bounced && particleOnSlopeTile(layer,p)){
                ++bounces;
                if(fabsf(p->xDir)<0.1f*(fabsf(p->xDir)+fabsf(p->yDir)) && p->yDir<0.0f){
                    ++verticalBounces;
                    inPlace+=trackVerticalBounce(track+n,p)?1:0;
                }
            }
            const int ix=(int)p->x, iy=(int)p->y;
            if(ix==lastX[n] && iy==lastY[n]){
                if(++stillFrames[n]==30 && particleOnSlopeTile(layer,p) && !counted[n]){
                    ++stuck;
                    counted[n]=true;
                }
            }else{
                stillFrames[n]=0;
            }
            lastX[n]=ix;
            lastY[n]=iy;
        }
    }
    check(stuck==0,"particles stuck on slopes",stuck,total);
    check(inPlace==0,"particles bouncing up and down in place on slopes",inPlace,verticalBounces);
    printf("Particle slopes: %d particles, %d stuck on a slope, %d bouncing in place (%d of %d slope bounces upward)\n",
        total,stuck,inPlace,verticalBounces,bounces);
    deleteParticleSets();
}

// The collision test scene's layout (as gameFunc.c builds it): single ramp tiles at the ends of a floating platform,
// a hill on the floor, steps and bumps, with the same particle fountain
static void testParticleSceneSlopes(void)
{
    static const uint8_t bump[8]={0x00,0x18,0x3c,0x7e,0xff,0xff,0xff,0xff};
    const int layer=1;
    setupPhysicsLayer(layer);
    for(int r=0;r<8;r++){
        physicsTiles[(4*8)+r]=bump[r];
    }
    for(int x=0;x<SCREEN_WIDTH_CELLS;x++){
        for(int y=21;y<SCREEN_HEIGHT_CELLS;y++){
            setLayerTile(layer,1,0x44,0x44,x,y);
        }
    }
    for(int y=3;y<21;y++){
        setLayerTile(layer,1,0x42,0x42,0,y);
        setLayerTile(layer,1,0x42,0x42,31,y);
    }
    setLayerTile(layer,2,0x46,0x46,3,14);
    for(int x=4;x<11;x++){
        setLayerTile(layer,1,0x44,0x44,x,14);
    }
    setLayerTile(layer,3,0x46,0x46,11,14);
    for(int x=18;x<27;x++){
        setLayerTile(layer,4,0x45,0x45,x,9);
    }
    setLayerTile(layer,2,0x46,0x46,13,20);
    setLayerTile(layer,1,0x44,0x44,14,20);
    setLayerTile(layer,1,0x44,0x44,15,20);
    setLayerTile(layer,3,0x46,0x46,16,20);
    for(int s=0;s<3;s++){
        for(int y=20-s;y<21;y++){
            setLayerTile(layer,1,0x44,0x44,26+s,y);
        }
    }

    deleteParticleSets();
    const int total=300;
    const int set=createParticleSet(total,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetGravity(set,0.12f);
    setParticleSetCollisions(set,true);
    setParticleSetBounce(set,0.7f);
    setParticleSetStillLimit(set,0);
    srand(1234);

    static int stillFrames[300], lastX[300], lastY[300];
    static bool counted[300];
    for(int n=0;n<total;n++){
        stillFrames[n]=0;
        lastX[n]=-1000;
        lastY[n]=-1000;
        counted[n]=false;
    }
    int stuck=0, bounces=0, verticalBounces=0, inPlace=0;
    static BounceTrack track[300];
    memset(track,0,sizeof(track));
    for(int f=0;f<1500;f++){
        for(int n=0;n<2;n++){
            const float dx=((float)(rand()%240)-120.0f)/100.0f;
            const float dy=-1.5f-((float)(rand()%150)/100.0f);
            emitParticle(set,126.0f,28.0f,dx,dy,250+(rand()%100));
        }
        static float vx[300], vy[300];
        static int ttl[300];
        for(int n=0;n<total;n++){
            vx[n]=particleSets[set].particles[n].xDir;
            vy[n]=particleSets[set].particles[n].yDir;
            ttl[n]=particleSets[set].particles[n].timeToLive;
        }
        updateParticles();
        for(int n=0;n<total;n++){
            const Particle *p=particleSets[set].particles+n;
            if(p->timeToLive<=0 || ttl[n]<=0 || p->delay>0){
                stillFrames[n]=0;
                lastX[n]=-1000;
                continue;
            }
            if(ttl[n]<p->timeToLive){
                // Particle slot reused
                counted[n]=false;
                track[n].count=0;
            }
            const float gx=p->xDir-vx[n], gy=p->yDir-vy[n]-0.12f;
            const bool bounced=(fabsf(gx)>0.05f || fabsf(gy)>0.05f) && (fabsf(vx[n])+fabsf(vy[n])>0.8f);
            if(bounced && particleOnSlopeTile(layer,p)){
                ++bounces;
                if(fabsf(p->xDir)<0.1f*(fabsf(p->xDir)+fabsf(p->yDir)) && p->yDir<0.0f){
                    ++verticalBounces;
                    inPlace+=trackVerticalBounce(track+n,p)?1:0;
                }
            }
            // Stuck: on the same pixel for over a second (a particle rolling up a slope can pause on a pixel for a
            // while as it turns back, so this is longer than that)
            const int ix=(int)p->x, iy=(int)p->y;
            if(ix==lastX[n] && iy==lastY[n]){
                if(++stillFrames[n]==30 && particleOnSlopeTile(layer,p) && !counted[n]){
                    ++stuck;
                    counted[n]=true;
                }
            }else{
                stillFrames[n]=0;
            }
            lastX[n]=ix;
            lastY[n]=iy;
        }
    }
    check(stuck==0,"scene: particles stuck on slopes",stuck,0);
    check(inPlace==0,"scene: particles bouncing up and down in place on slopes",inPlace,verticalBounces);
    printf("Particle scene slopes: %d stuck on a slope, %d bouncing in place (%d of %d slope bounces upward)\n",stuck,
        inPlace,verticalBounces,bounces);
    deleteParticleSets();
}

// A rotating layer sweeps into particles resting on it - they must be pushed back out (and carried), never left
// inside the layer or falling through it
static void testParticlesOnRotatingLayer(void)
{
    const int layer=1;
    setupPhysicsLayer(layer);
    // Floor across the whole map, rows 21-23 (nothing below it)
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        for(int y=21;y<24;y++){
            setLayerTile(layer,1,0x44,0x44,x,y);
        }
    }
    deleteParticleSets();
    const int total=120;
    const int set=createParticleSet(total,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetGravity(set,0.12f);
    setParticleSetBounce(set,0.7f);
    setParticleSetStillLimit(set,0);
    for(int n=0;n<total;n++){
        emitParticle(set,40.0f+(float)(n*1.5f),120.0f+(float)(n%7),0.0f,0.0f,5000);
    }
    // Settle, then swing the layer back and forth
    for(int f=0;f<120;f++){
        updateParticles();
    }
    int inside=0, fellThrough=0, checks=0;
    for(int f=0;f<400;f++){
        setLayerTransform(layer,(30.0f*(float)M_PI/180.0f)*sinf((float)f*0.025f),1.0f,1.0f);
        updateParticles();
        for(int n=0;n<total;n++){
            const Particle *p=particleSets[set].particles+n;
            const int px=(int)p->x, py=(int)p->y;
            if(testSpace==PARTICLE_SPACE_LAYER){
                // Positions are layer coordinates - check against the tile map directly
                if(p->timeToLive<=0 || px<0 || py<0 || py>=TILE_LAYER_HEIGHT*8){
                    continue;
                }
                ++checks;
                if((getLayerMapPixels(layer,px+1,py+1,2)|getLayerMapPixels(layer,px+1,py+2,2))!=0){
                    ++inside;
                }
                if(((py+1)>>3)>=24 && ((py+1)>>3)<48){
                    ++fellThrough;
                }
                continue;
            }
            if(p->timeToLive<=0 || px<0 || px>SCREEN_WIDTH_PIXELS-4 || py<0 || py>SCREEN_HEIGHT_LINES-4){
                continue;
            }
            ++checks;
            if(((getLayerPixels32(layer,px+1,py+1)|getLayerPixels32(layer,px+1,py+2))>>30)!=0){
                ++inside;
            }
            int tx, ty;
            if(getLayerTileAt(layer,px+1,py+1,&tx,&ty) && ty>=24 && ty<48){
                ++fellThrough;
            }
        }
    }
    clearLayerTransform(layer);
    check(inside==0,"particles left inside a rotating layer",inside,checks);
    check(fellThrough==0,"particles falling through a rotating layer",fellThrough,checks);
    printf("Particles on a rotating layer: %d checks, %d inside the layer, %d fallen through\n",checks,inside,fellThrough);
    deleteParticleSets();
}

// Rough relative cost of particle collisions on the PC (not RP2350 timings): the doubled fountain on a rotating layer,
// in screen space and layer space, and the narrow sampler against the full 32 pixel one
static double timeParticleRun(ParticleSpace space, bool rotate)
{
    const int layer=1;
    setupPhysicsLayer(layer);
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        for(int y=21;y<24;y++){
            setLayerTile(layer,1,0x44,0x44,x,y);
        }
    }
    for(int x=4;x<11;x++){
        setLayerTile(layer,1,0x44,0x44,x,14);
    }
    setLayerTile(layer,2,0x46,0x46,3,14);
    setLayerTile(layer,3,0x46,0x46,11,14);
    deleteParticleSets();
    const int set=createParticleSet(600,layer);
    setParticleSetSpace(set,space);
    setParticleSetCollisions(set,true);
    setParticleSetGravity(set,0.12f);
    setParticleSetBounce(set,0.7f);
    srand(99);
    clock_t total=0;
    for(int f=0;f<600;f++){
        if(rotate){
            setLayerTransform(layer,(30.0f*(float)M_PI/180.0f)*sinf((float)f*0.025f),1.0f,1.0f);
        }
        for(int n=0;n<4;n++){
            float x=126.0f, y=28.0f;
            float dx=((float)(rand()%240)-120.0f)/100.0f, dy=-1.5f-((float)(rand()%150)/100.0f);
            if(space==PARTICLE_SPACE_LAYER){
                float u, v;
                screenToLayer(layer,x+2.0f,y+2.0f,&u,&v);
                x=u-2.0f;
                y=v-2.0f;
                screenToLayerVector(layer,dx,dy,&dx,&dy);
            }
            emitParticle(set,x,y,dx,dy,250+(rand()%100));
        }
        const clock_t t0=clock();
        updateParticles();
        total+=clock()-t0;
    }
    clearLayerTransform(layer);
    deleteParticleSets();
    return (double)total;
}

static void particleTimings(void)
{
    const double screenFlat=timeParticleRun(PARTICLE_SPACE_SCREEN,false);
    const double screenRot=timeParticleRun(PARTICLE_SPACE_SCREEN,true);
    const double layerRot=timeParticleRun(PARTICLE_SPACE_LAYER,true);
    // The samplers alone, on a rotated layer
    setLayerTransform(1,0.4f,1.0f,1.0f);
    volatile uint32_t sink=0;
    clock_t t0=clock();
    for(int n=0;n<300000;n++){
        sink+=getLayerPixelsN(1,n&255,(n>>8)%192,32);
    }
    const double wide=(double)(clock()-t0);
    t0=clock();
    for(int n=0;n<300000;n++){
        sink+=getLayerPixelsN(1,n&255,(n>>8)%192,2);
    }
    const double narrow=(double)(clock()-t0);
    clearLayerTransform(1);
    (void)sink;
    printf("Particle cost (PC, 600 particles): screen space flat 1.0, screen space rotating %.1fx, layer space rotating %.1fx\n",
        screenRot/screenFlat,layerRot/screenFlat);
    printf("Rotated layer sampler (PC): 2 pixels is %.0fx cheaper than 32\n",wide/(narrow>0?narrow:1));
}

// Particles that stay on the same pixel for the set's still limit are removed
static void testParticleStillLimit(void)
{
    const int layer=3;
    setupPhysicsLayer(layer);
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        setLayerTile(layer,1,0x47,0x47,x,15);
    }
    deleteParticleSets();
    const int set=createParticleSet(4,layer);
    setParticleSetSpace(set,testSpace);
    setParticleSetCollisions(set,true);
    setParticleSetGravity(set,0.3f);
    setParticleSetStillLimit(set,20);
    emitParticle(set,100.0f,110.0f,0.0f,0.0f,5000);
    int removedAt=-1;
    int lastMoveFrame=0;
    int lx=-1, ly=-1;
    for(int f=0;f<200 && removedAt<0;f++){
        updateParticles();
        const Particle *p=particleSets[set].particles;
        if(p->timeToLive<=0){
            removedAt=f;
        }else if((int)p->x!=lx || (int)p->y!=ly){
            lastMoveFrame=f;
            lx=(int)p->x;
            ly=(int)p->y;
        }
    }
    check(removedAt>=0 && (removedAt-lastMoveFrame)==20,"still particle removed after the still limit",removedAt,lastMoveFrame);
    printf("Particle still limit: settled at frame %d, removed at frame %d (limit 20)\n",lastMoveFrame,removedAt);
    deleteParticleSets();
}

// ---------------------------------------------------------------------------
// Levels
// ---------------------------------------------------------------------------

// Pack and unpack all sorts of data: random, runs, repeating patterns, and more than the 64KB match window
static void testLzPack(void)
{
    static uint8_t src[200000], packed[LZ_PACK_BOUND(200000)], out[200000];
    const int sizes[]={0,1,3,4,5,15,16,19,20,255,270,1000,4096,65535,65536,65537,70000,200000};
    int tests=0;
    long totalIn=0, totalOut=0;
    for(int kind=0;kind<5;kind++){
        for(int s=0;s<(int)(sizeof(sizes)/sizeof(sizes[0]));s++){
            const int n=sizes[s];
            for(int i=0;i<n;i++){
                switch(kind){
                    case 0: src[i]=(uint8_t)rng(); break;                           // Random
                    case 1: src[i]=7; break;                                        // One run
                    case 2: src[i]=(uint8_t)((i/((rng()%40)+1))&3); break;          // Short runs
                    case 3: src[i]=(uint8_t)((i%13)*(i%7)); break;                  // Repeating pattern
                    default: src[i]=(rng()%10)?0:(uint8_t)rng(); break;             // Sparse, like a foreground
                }
            }
            const int p=lzPack(src,n,packed);
            check(p<=LZ_PACK_BOUND(n),"packed data fits LZ_PACK_BOUND",p,LZ_PACK_BOUND(n));
            memset(out,0xAA,(size_t)n);
            const int u=lzUnpack(packed,p,out,n);
            check(u==n && memcmp(out,src,(size_t)n)==0,"data unpacks to what was packed",kind,n);
            // Cut short, it's reported as corrupt rather than read past the end
            if(p>1){
                check(lzUnpack(packed,p-1,out,n)<0,"truncated packed data is found",kind,n);
            }
            ++tests;
            totalIn+=n;
            totalOut+=p;
        }
    }
    printf("LZ packing: %d round trips, %ld bytes packed to %ld\n",tests,totalIn,totalOut);
}

// A level built here: a big layer with foreground tiles, and a small repeating parallax layer
#define TL_W        200
#define TL_H        150
#define TL_BACK_W   37
#define TL_BACK_H   23
static uint8_t tlTiles[TL_W*TL_H], tlFg[TL_W*TL_H], tlBack[TL_BACK_W*TL_BACK_H];
static uint8_t tlTileSet[4096], tlAttrs[512], tlFlags[256];
static LevelAnimFrame tlFrames[3]={{50,2},{51,3},{52,1}};
static LevelAnim tlAnim={49,3,tlFrames};
static LevelTileSet tlSets[1];
static LevelLayer tlLayers[2];
static LevelDef tlLevel;
static uint8_t tlPacked[2][LZ_PACK_BOUND(TL_W*TL_H*3)];

static int tlExpectTile(int layer, int tx, int ty)
{
    if(layer==2){
        tx-=5;
        ty-=-7;
        return (tx>=0 && tx<TL_W && ty>=0 && ty<TL_H)?tlTiles[(ty*TL_W)+tx]:0;
    }
    tx=((tx%TL_BACK_W)+TL_BACK_W)%TL_BACK_W;
    ty=((ty%TL_BACK_H)+TL_BACK_H)%TL_BACK_H;
    return tlBack[(ty*TL_BACK_W)+tx];
}

static int tlExpectFg(int tx, int ty)
{
    tx-=5;
    ty-=-7;
    return (tx>=0 && tx<TL_W && ty>=0 && ty<TL_H)?tlFg[(ty*TL_W)+tx]:0;
}

static void buildTestLevel(void)
{
    // Tiles in runs, a few foreground tiles, a patterned repeating layer
    int t=0;
    for(int n=0;n<TL_W*TL_H;n++){
        if(rng()%8==0){
            t=(int)(rng()%60);
        }
        tlTiles[n]=(uint8_t)t;
        tlFg[n]=(rng()%20==0)?(uint8_t)(1+(rng()%60)):0;
    }
    for(int n=0;n<TL_BACK_W*TL_BACK_H;n++){
        tlBack[n]=(uint8_t)(n%11);
    }
    for(int n=0;n<4096;n++){
        tlTileSet[n]=(uint8_t)rng();
    }
    for(int n=0;n<256;n++){
        tlAttrs[n*2]=(uint8_t)n;
        tlAttrs[(n*2)+1]=(uint8_t)(n^0x55);
        tlFlags[n]=(uint8_t)(n&3);
    }
    tlAttrs[0]=0x80;
    tlAttrs[1]=0x80;
    tlSets[0]=(LevelTileSet){tlTileSet,tlAttrs,tlFlags,1,&tlAnim};

    // Main layer: tiles, then foreground bits (rows of 32 bit words) and tiles, as the converter packs them
    static uint8_t stream[TL_W*TL_H*3];
    const int tileBytes=(TL_W*TL_H+3)&~3;
    const int rowWords=(TL_W+31)/32;
    memset(stream,0,sizeof(stream));
    memcpy(stream,tlTiles,TL_W*TL_H);
    int fgCount=0;
    uint8_t *list=stream+tileBytes+(TL_H*rowWords*4);
    for(int y=0;y<TL_H;y++){
        for(int x=0;x<TL_W;x++){
            if(tlFg[(y*TL_W)+x]){
                uint32_t *w=(uint32_t *)(stream+tileBytes)+(y*rowWords)+(x>>5);
                *w|=1u<<(x&31);
                list[fgCount++]=tlFg[(y*TL_W)+x];
            }
        }
    }
    const int mainSize=tileBytes+(TL_H*rowWords*4)+fgCount;
    const int mainPacked=lzPack(stream,mainSize,tlPacked[0]);
    tlLayers[0]=(LevelLayer){tlPacked[0],(uint32_t)mainPacked,TL_W,TL_H,5,-7,0,0,256,256,(uint16_t)fgCount,0,0,2,1,0,"main"};

    // Background: repeats, half speed, offset (its tiles padded to 4 bytes too)
    static uint8_t backStream[(TL_BACK_W*TL_BACK_H+3)&~3];
    memcpy(backStream,tlBack,TL_BACK_W*TL_BACK_H);
    const int backPacked=lzPack(backStream,sizeof(backStream),tlPacked[1]);
    tlLayers[1]=(LevelLayer){tlPacked[1],(uint32_t)backPacked,TL_BACK_W,TL_BACK_H,0,0,3,-5,128,128,0,0,0,4,-1,
        LEVEL_WRAP_X|LEVEL_WRAP_Y,"back"};

    const uint32_t ram=4096+((mainSize+3)&~3)+((TL_H*2+3)&~3)+((TL_BACK_W*TL_BACK_H+3)&~3);
    static const LevelTileSet *tlSetList[1]={tlSets};
    tlLevel=(LevelDef){"test",TL_W+5,TL_H,ram,1,2,0,0,tlSetList,tlLayers,NULL,NULL};
}

// Every tile within 28 tiles of the middle of the screen (inside the 64x64 window around it) is in the engine layer,
// with its colours - and the foreground's
// (cu,cv: the level pixel at the middle of the screen, for this layer - from the camera, its parallax and offset)
static int checkLevelWindow(int layer, int cu, int cv)
{
    const TileLayer *t=tileLayer+layer;
    const int cx=cu>>3, cy=cv>>3;
    int bad=0;
    for(int ty=cy-28;ty<=cy+28;ty++){
        for(int tx=cx-28;tx<=cx+28;tx++){
            const int r=((ty&63)*TILE_LAYER_WIDTH)+(tx&63);
            const int a=((ty&63)*TILE_LAYER_WIDTH*2)+(tx&63);
            const int e=tlExpectTile(layer,tx,ty);
            bad+=(t->tileMap[r]!=e || t->attrMap[a]!=tlAttrs[e*2] || t->attrMap[a+TILE_LAYER_WIDTH]!=tlAttrs[(e*2)+1])?1:0;
            if(layer==2){
                const int f=tlExpectFg(tx,ty);
                const TileLayer *fl=tileLayer+1;
                bad+=(fl->tileMap[r]!=f || fl->attrMap[a]!=tlAttrs[f*2] || fl->attrMap[a+TILE_LAYER_WIDTH]!=tlAttrs[(f*2)+1])?1:0;
            }
        }
    }
    return bad;
}

static void testLevelStreaming(void)
{
    initLayers();
    rngState=4242;
    buildTestLevel();
    check(loadLevel(&tlLevel),"test level loads",0,0);

    // Lookups straight from the level in RAM
    int bad=0;
    for(int ty=-10;ty<TL_H+10;ty++){
        for(int tx=-10;tx<TL_W+20;tx++){
            bad+=(getLevelTile(2,tx,ty)!=tlExpectTile(2,tx,ty))?1:0;
            bad+=(getLevelForegroundTile(2,tx,ty)!=tlExpectFg(tx,ty))?1:0;
            bad+=(getLevelTileFlags(2,tx,ty)!=(tlExpectTile(2,tx,ty)&3))?1:0;
            bad+=(getLevelTile(4,tx,ty)!=tlExpectTile(4,tx,ty))?1:0;
        }
    }
    check(bad==0,"level tile lookups match the level",bad,0);
    check(getLevelTile(3,0,0)==-1,"layers that aren't the level's have no level tiles",getLevelTile(3,0,0),-1);

    // The camera wanders, jumps, goes off the level's edges, and the main layer rotates and scales - the tiles around
    // the view are always right
    int moves=0, badMoves=0;
    int camX=0, camY=0;
    for(int n=0;n<3000;n++){
        const uint32_t r=rng()%100;
        if(r<80){
            camX+=(int)(rng()%33)-16;
            camY+=(int)(rng()%33)-16;
        }else if(r<95){
            camX=(int)(rng()%2400)-400;
            camY=(int)(rng()%1600)-400;
        }else{
            camX+=(int)(rng()%1025)-512;
        }
        if(n%500==250){
            setLayerTransform(2,(float)(rng()%628)/100.0f,0.7f+((float)(rng()%80)/100.0f),1.0f);
        }else if(n%500==0){
            clearLayerTransform(2);
        }
        setLevelCamera(camX,camY);
        // (the back layer: half speed, offset 3,-5)
        const int b=checkLevelWindow(2,camX+128,camY+96)+
            checkLevelWindow(4,128-3+((camX*128)>>8),96+5+((camY*128)>>8));
        badMoves+=b?1:0;
        ++moves;
        if(b){
            check(false,"level tiles around the view after a camera move",b,n);
        }
        // The layers are where the camera says (the background at half speed, plus its offset)
        if(!tileLayer[2].transformed){
            float u, v;
            screenToLayer(2,0.0f,0.0f,&u,&v);
            // (a whole 512 pixel repeat away if the camera is left of or above the level, as the layer can't go right of
            // or below the screen)
            check(((int)floorf(u)-camX)%512==0 && ((int)floorf(v)-camY)%512==0,"main layer at the camera",(int)floorf(u),camX);
        }
        const int bx=3-((camX*128)>>8);
        check(((tileLayer[4].x-bx)%512)==0 && tileLayer[4].x<SCREEN_WIDTH_PIXELS,"parallax layer position",tileLayer[4].x,bx);
    }
    clearLayerTransform(2);
    check(badMoves==0,"camera moves with wrong tiles",badMoves,moves);

    // The foreground layer follows the main layer's position and transform
    setLayerTransform(2,0.4f,1.2f,0.9f);
    setLevelCamera(333,222);
    syncFollowingLayers();
    check(tileLayer[1].x==tileLayer[2].x && tileLayer[1].y==tileLayer[2].y && tileLayer[1].transformed &&
        tileLayer[1].dudx==tileLayer[2].dudx && tileLayer[1].dvdy==tileLayer[2].dvdy,"foreground layer follows",0,0);
    clearLayerTransform(2);

    // Changing a tile changes it on screen, and in the level
    setLevelCamera(400,300);
    const int tx=(400/8)+10, ty=(300/8)+5;
    setLevelTile(2,tx,ty,33);
    check(getLevelTile(2,tx,ty)==33,"setLevelTile changes the level",getLevelTile(2,tx,ty),33);
    const int r=((ty&63)*TILE_LAYER_WIDTH)+(tx&63);
    check(tileLayer[2].tileMap[r]==33 && tileLayer[2].attrMap[((ty&63)*128)+(tx&63)]==33,"setLevelTile changes the screen",
        tileLayer[2].tileMap[r],33);
    tlTiles[((ty+7)*TL_W)+(tx-5)]=33;

    // Animated tile 49: its graphic (in the RAM copy of the tile set) cycles through tiles 50, 51 and 52
    const uint8_t *ram=tileLayer[2].tileDefPtr;
    check(ram!=tlTileSet && memcmp(ram+(49*8),tlTileSet+(50*8),8)==0,"animated tile starts on its first frame",0,0);
    const int expect[]={50,50,51,51,51,52,50,50,51};
    bad=0;
    for(int f=0;f<9;f++){
        bad+=(memcmp(ram+(49*8),tlTileSet+(expect[f]*8),8)!=0 || memcmp(ram+(256*8)+(49*8),tlTileSet+(256*8)+(expect[f]*8),8)!=0)?1:0;
        updateLevel();
    }
    check(bad==0,"animated tile frames and timings",bad,0);

    // Too big for LEVEL_RAM_SIZE is refused
    LevelDef big=tlLevel;
    big.ramSize=LEVEL_RAM_SIZE+1;
    check(!loadLevel(&big),"a level too big for RAM is refused",0,0);
    printf("Level streaming: %d camera moves (with jumps, rotation, scaling and parallax), foreground, animation and tile changes\n",
        moves);
}

static void saveScreenBMP(const char *name);

// Every cell of a 16x16 level's layer (and its foreground) within 28 cells of the middle of the screen holds its 16x16
// tile, with that quarter's colours
// (cu,cv: the level pixel at the middle of the screen, for this layer)
static int checkLevel16Window(int layer, int fgLayer, const LevelTileSet *ts, int cu, int cv)
{
    const TileLayer *t=tileLayer+layer;
    const int ccx=cu>>3, ccy=cv>>3;
    int bad=0;
    for(int cy=ccy-28;cy<=ccy+28;cy++){
        for(int cx=ccx-28;cx<=ccx+28;cx++){
            const int r=((cy&63)*TILE_LAYER_WIDTH)+(cx&63);
            const int a=((cy&63)*TILE_LAYER_WIDTH*2)+(cx&63);
            const int q=((cy&1)<<1)|(cx&1);
            const int tile=getLevelTile(layer,cx>>1,cy>>1);
            // (a single colour layer's cells' colours aren't copied - they stay as the layer was cleared)
            const bool cells=(t->colour<0);
            bad+=(t->tileMap[r]!=tile || t->attrMap[a]!=(cells?ts->attrs[(tile*8)+(q*2)]:0x80) ||
                t->attrMap[a+TILE_LAYER_WIDTH]!=(cells?ts->attrs[(tile*8)+(q*2)+1]:0x80))?1:0;
            if(fgLayer>=0){
                bad+=(tileLayer[fgLayer].tileMap[r]!=getLevelForegroundTile(layer,cx>>1,cy>>1))?1:0;
            }
        }
    }
    return bad;
}

// A level of 16x16 tiles (levels/tiled/demo16.tmx): streamed into the 8x8 cell engine layers 2x2 cells a tile, as the
// camera moves, rotation included
static void testLevel16(void)
{
    initLayers();
    initSprites(20);
    check(loadLevel(&level_demo16) && getLevelTileSize()==16 && getLevelWidth()==80*16 && tileLayer[2].tile16,
        "16x16 level loads",getLevelTileSize(),16);
    const LevelTileSet *ts=level_demo16.tileSets[0];
    // The level's own properties (its map's, in Tiled): its type, name and description - and any level's, unloaded
    check(getLevelType()==LEVEL_TYPE_PLATFORM && strcmp(getLevelPropString(LEVEL_PROP_LEVEL_NAME,""),"Big Tiles")==0 &&
        getLevelPropString(LEVEL_PROP_LEVEL_DESCRIPTION,"")[0] && getLevelPropInt(LEVEL_PROP_SPEED,-7)==-7 &&
        strcmp(getLevelPropString(LEVEL_PROP_SPEED,"none"),"none")==0,"level properties",getLevelType(),0);
    check(levelList[LEVEL_ID_FLIGHT]->type==LEVEL_TYPE_SHOOTER &&
        getLevelDefInt(levelList[LEVEL_ID_FLIGHT],LEVEL_PROP_LEVEL_TYPE,-1)==LEVEL_TYPE_SHOOTER &&
        strcmp(getLevelDefString(levelList[LEVEL_ID_FLIGHT],LEVEL_PROP_LEVEL_NAME,""),"Sky Tunnel")==0 &&
        levelList[LEVEL_ID_DEMO]->type==LEVEL_TYPE_PLATFORM,"level types",levelList[LEVEL_ID_FLIGHT]->type,1);
    // Its sky is one colour, its level and foreground draw their pixels only
    check(tileLayer[4].colour==0x4F && tileLayer[2].colour==LAYER_COLOUR_NONE && tileLayer[1].colour==LAYER_COLOUR_NONE,
        "16x16 level's single colour layers",tileLayer[4].colour,0x4F);
    check(getLevelTile(2,0,17)==1 && getLevelTile(2,14,16)==4 && getLevelForegroundTile(2,42,12)==17,
        "16x16 level tiles",getLevelTile(2,14,16),4);
    check(getLevelTile(4,3+16*4,2)==27,"16x16 level's repeating sky",getLevelTile(4,3+16*4,2),27);
    check((getLevelTileFlags(2,5,17)&LEVEL_TILE_SOLID) && (getLevelTileFlags(2,16,12)&LEVEL_TILE_COLLECT),
        "16x16 level tile flags",0,0);
    // Tile types (Tiled's TileType enum, in bits 4-7), alongside the other flags: the conveyors and springboard
    check(LEVEL_TILE_TYPE(getLevelTileFlags(2,6,17))==TILE_TYPE_CONVEYOR_RIGHT &&
        LEVEL_TILE_TYPE(getLevelTileFlags(2,36,17))==TILE_TYPE_CONVEYOR_LEFT &&
        LEVEL_TILE_TYPE(getLevelTileFlags(2,62,16))==TILE_TYPE_SUPER_JUMP && (getLevelTileFlags(2,62,16)&LEVEL_TILE_SOLID) &&
        LEVEL_TILE_TYPE(getLevelTileFlags(2,5,17))==TILE_TYPE_NONE &&
        LEVEL_TILE_TYPE(getLevelTileSetFlags(2,40))==TILE_TYPE_SUPER_JUMP && getLevelTileSetFlags(2,35)==0,
        "16x16 level tile types",getLevelTileFlags(2,6,17),0x21);
    // The ground's grass is in its top row of pixels; a 16x16 slope rises a pixel a pixel across the whole tile
    check(!isLevelPixelSolid(2,5*16,17*16) && isLevelPixelSolid(2,5*16+1,17*16) && isLevelPixelSolid(2,5*16,17*16+2),
        "16x16 level pixels",0,0);
    check(isLevelPixelSolid(2,14*16+15,16*16) && !isLevelPixelSolid(2,14*16+14,16*16) &&
        isLevelPixelSolid(2,14*16,16*16+15) && !isLevelPixelSolid(2,14*16,16*16+14),"16x16 slope",0,0);

    // Camera moves: wandering, jumping, the level rotating and scaling
    int bad=0, badPixels=0;
    int camX=0, camY=0;
    for(int n=0;n<1500;n++){
        if(rng()%10){
            camX+=(int)(rng()%41)-20;
            camY+=(int)(rng()%41)-20;
        }else{
            camX=(int)(rng()%1600)-200;
            camY=(int)(rng()%600)-200;
        }
        if(n%300==150){
            setLayerTransform(2,(float)(rng()%628)/100.0f,0.8f,0.8f);
        }else if(n%300==0){
            clearLayerTransform(2);
        }
        setLevelCamera(camX,camY);
        // (the sky: a quarter speed)
        bad+=checkLevel16Window(2,1,ts,camX+128,camY+96)?1:0;
        bad+=checkLevel16Window(4,-1,ts,128+((camX*64)>>8),96+((camY*64)>>8))?1:0;
        // The level's pixels (from the level in RAM) are the drawn layer's (from its cells - 512 pixels a repeat)
        for(int k=0;k<20;k++){
            const int x=camX+(int)(rng()%256), y=camY+(int)(rng()%192);
            badPixels+=(isLevelPixelSet(2,x,y)!=isLayerMapPixelSet(2,x,y))?1:0;
        }
    }
    clearLayerTransform(2);
    check(bad==0,"16x16 level streamed into the layer",bad,0);
    check(badPixels==0,"16x16 level pixels are the layer's",badPixels,0);

    // A tile changed fills all 4 of its cells
    setLevelCamera(100,100);
    setLevelTile(2,12,10,3);
    bad=0;
    for(int q=0;q<4;q++){
        const int cx=24+(q&1), cy=20+(q>>1);
        bad+=(tileLayer[2].tileMap[((cy&63)*TILE_LAYER_WIDTH)+(cx&63)]!=3)?1:0;
    }
    check(bad==0 && getLevelTile(2,12,10)==3,"setLevelTile on a 16x16 level",bad,0);

    // Animated 16x16 tiles: the water surface (7) shows its second frame (8) after 5 frames - all 32 bytes, and mask
    const uint8_t *ram=tileLayer[2].tileDefPtr;
    for(int n=0;n<5;n++){
        updateLevel();
    }
    check(memcmp(ram+(7*32),levelDemo16TileDef+(8*32),32)==0 &&
        memcmp(ram+(256*32)+(7*32),levelDemo16TileDef+(256*32)+(8*32),32)==0,"16x16 tiles animate",0,0);

    // Level tiles placed as tile objects: sprites of the tile set's RAM copy (so they animate too), the tile their frame
    const int lift=findLevelObjectByName("brick lift"), torch=findLevelObjectByName("torch");
    check(lift>=0 && torch>=0,"16x16 level's tile objects",lift,torch);
    for(int n=0;n<2;n++){
        const int obj=n?torch:lift;
        const LevelActor *a=getLevelActor(obj);
        setLevelCamera((int)a->x-128,(int)a->y-96);
        updateLevel();
        const int ix=a->sprite;
        check(ix>=0 && spriteList[ix].defPtr==ram && spriteList[ix].maskPtr==ram+(256*32) &&
            spriteList[ix].width==16 && spriteList[ix].height==16 && spriteList[ix].frame==(n?30:3),
            "tile object is a sprite of its level tile",n,ix);
    }
    // setSpriteTile: a layer's tile as a sprite
    const int tileSprite=allocateSprite();
    check(setSpriteTile(tileSprite,2,12) && spriteList[tileSprite].defPtr==ram && spriteList[tileSprite].frame==12 &&
        spriteList[tileSprite].width==16 && spriteList[tileSprite].maskPtr==ram+(256*32),"setSpriteTile",0,0);
    check(!setSpriteTile(tileSprite,0,12) && !setSpriteTile(tileSprite,MAX_TILE_LAYERS,1),"setSpriteTile, no tile set",0,0);
    freeSprite(tileSprite);

    // Pictures: the level, and a Mode 7 floor of 16x16 tiles
    initSprites(1);
    setLevelCamera(160,80);
    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("level_demo16.bmp");
    static LayerLineTransform floor16[SCREEN_HEIGHT_LINES];
    buildLayerPerspective(floor16,480.0f,250.0f,0.4f,40.0f,40.0f,128.0f);
    setLayerLineTransforms(2,floor16);
    setLayerPos(4,SCREEN_WIDTH_PIXELS,0);
    setLayerPos(1,SCREEN_WIDTH_PIXELS,0);
    tileLayer[1].follow=-1;
    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("mode7_floor16.bmp");
    setLayerLineTransforms(2,NULL);
    initLayers();
    printf("16x16 level: tiles, flags, pixels, 1500 camera moves (rotated and scaled too), tile changes, animation\n");
}

static int shows=0, hides=0, lastShown=-1, lastHidden=-1;
static void onShow(int objectIX, int spriteIX)
{
    ++shows;
    lastShown=objectIX;
    check(spriteList[spriteIX].levelObject==objectIX && getLevelActor(objectIX)->sprite==spriteIX,
        "show callback gets the actor's sprite",objectIX,spriteIX);
}
static void onHide(int objectIX, int spriteIX)
{
    ++hides;
    lastHidden=objectIX;
    check(spriteList[spriteIX].inUse && getLevelActor(objectIX)->sprite<0,"hide callback before the sprite's freed",
        objectIX,spriteIX);
}

// Objects and actors, from the demo level as converted from Tiled (levels/tiled/demo.tmx): its objects are the player
// start (0), enemies (1-4, and 5 waiting for the camera), a platform (6) and its path (7), and a bubble generator (8)
static void testLevelActors(void)
{
    initLayers();
    initSprites(40);
    check(loadLevel(&level_demo),"demo level loads",0,0);
    check(getLevelObjectCount()==20,"demo level objects",getLevelObjectCount(),20);
    const LevelObject *start=getLevelObject(0);
    check(start->cls==LEVEL_CLASS_PLAYER_START && start->x==40 && start->y==261 && start->sheet>=0 && start->frame==11,
        "player start object",start->x,start->y);
    check(findLevelObject(LEVEL_CLASS_PLATFORM)==6 && findLevelObject(LEVEL_CLASS_GENERATOR)==8,"finding objects by class",
        findLevelObject(LEVEL_CLASS_PLATFORM),6);

    // Properties: class defaults from the Tiled project, and each object's own
    check(getLevelObjectFloat(1,LEVEL_PROP_SPEED,-1.0f)==0.5f && getLevelObjectInt(1,LEVEL_PROP_ALERT_RANGE,-1)==96,
        "class default properties",getLevelObjectInt(1,LEVEL_PROP_ALERT_RANGE,-1),96);
    check(getLevelObjectInt(4,LEVEL_PROP_ALERT_RANGE,-1)==0 && getLevelObjectFloat(5,LEVEL_PROP_SPEED,-1.0f)==1.0f,
        "an object's own properties",getLevelObjectInt(4,LEVEL_PROP_ALERT_RANGE,-1),0);
    check(getLevelObjectInt(8,LEVEL_PROP_INTERVAL,-1)==25 && getLevelObjectInt(8,LEVEL_PROP_MAX,-1)==5,
        "generator properties",getLevelObjectInt(8,LEVEL_PROP_INTERVAL,-1),25);
    check(getLevelObjectInt(6,LEVEL_PROP_PATH,-1)==7,"object links become object indexes",
        getLevelObjectInt(6,LEVEL_PROP_PATH,-1),7);
    check(getLevelObjectInt(0,LEVEL_PROP_SPEED,-9)==-9 && strcmp(getLevelObjectString(1,LEVEL_PROP_SPEED,"x"),"x")==0,
        "missing properties give the default",0,0);
    check((getLevelObject(5)->flags&LEVEL_OBJ_WAIT) && !(getLevelObject(1)->flags&LEVEL_OBJ_WAIT),"waitForCamera flag",0,0);
    const LevelObject *g=getLevelObject(8);
    check(g->x==368 && g->y==280 && g->width==80 && g->height==8 && g->sheet<0,"an area object",g->x,g->y);

    // Paths
    check(fabsf(getLevelPathLength(7)-176.0f)<0.01f,"path length",(int)getLevelPathLength(7),176);
    float px, py;
    getLevelPathPoint(7,88.0f,&px,&py);
    check(px==1262.0f && py==174.0f,"a point along a path",(int)px,(int)py);
    getLevelPathPoint(7,500.0f,&px,&py);
    check(py==86.0f,"points along a path stop at its end",(int)py,86);

    // Actors: every object has one, where it was placed. The one waiting for the camera starts dormant
    check(getLevelActor(1)->x==280.0f && getLevelActor(1)->sprite==-1 && isLevelActorActive(1) && !isLevelActorActive(5),
        "actors start where their objects are",(int)getLevelActor(1)->x,280);
    const int enemies=createSpriteSet();
    setLevelClassSprites(LEVEL_CLASS_ENEMY,enemies,COLLIDE_TARGET);
    setLevelActorCallbacks(onShow,onHide);
    killLevelActor(0);

    // Camera at the start: the first enemy (x 280) is within 32 pixels of the view, so gets a sprite; others don't
    setLevelCamera(0,128);
    updateLevel();
    const int s1=getLevelActor(1)->sprite;
    check(s1>=0 && getLevelActor(2)->sprite<0 && getLevelActor(0)->sprite<0,"sprites for actors near the camera",s1,0);
    check(s1>=0 && spriteList[s1].layer==2 && spriteList[s1].space==SPRITE_SPACE_LAYER && spriteList[s1].xF==280.0f &&
        spriteList[s1].frame==3 && isSpriteInSet(s1,enemies) && spriteList[s1].collideWith==COLLIDE_TARGET &&
        getSpriteLevelObject(s1)==1,"an actor's sprite is set up from its object and class",s1,0);
    // (the first enemy, and the door to the cave by the start)
    check(shows==2 && getLevelActor(findLevelObjectByName("to cave"))->sprite>=0,"show callback",shows,2);

    // The game moves an actor: its sprite follows. Off the view, but within the hide margin, it keeps it
    getLevelActor(1)->x=340.0f;
    getLevelActor(1)->frame=9;
    updateLevel();
    check(spriteList[s1].xF==340.0f && spriteList[s1].frame==9,"sprites follow their actors",(int)spriteList[s1].xF,340);

    // Far along: the first enemy's sprite goes, the waiting one wakes and gets one
    setLevelCamera(1000,128);
    updateLevel();
    // (the freed sprite may already be another actor's)
    check(getLevelActor(1)->sprite<0 && spriteList[s1].levelObject!=1 && hides==2,"sprites taken from far actors",hides,2);
    check(isLevelActorActive(5) && (getLevelActor(5)->flags&LEVEL_ACTOR_WOKE) && getLevelActor(5)->sprite>=0,
        "waiting actors wake when the camera reaches them",getLevelActor(5)->flags,0);
    updateLevel();
    check(!(getLevelActor(5)->flags&LEVEL_ACTOR_WOKE),"woke is only set the frame they wake",getLevelActor(5)->flags,0);

    // Killed: its sprite goes, and it isn't updated or shown again
    const int s5=getLevelActor(5)->sprite;
    killLevelActor(5);
    updateLevel();
    check(!isLevelActorActive(5) && getLevelActor(5)->sprite<0 && !spriteList[s5].inUse && getSpriteLevelObject(s5)==-1,
        "killed actors lose their sprite",0,0);

    // Running out of sprites: actors wait for one, then get one when a sprite's freed
    initSprites(1);
    loadLevel(&level_demo);
    killLevelActor(0);
    const int taken=allocateSprite();
    setLevelCamera(0,128);
    updateLevel();
    check(taken==0 && getLevelActor(1)->sprite<0,"no sprite free, no sprite",getLevelActor(1)->sprite,-1);
    freeSprite(taken);
    updateLevel();
    check(getLevelActor(1)->sprite==0,"an actor gets a sprite once one's free",getLevelActor(1)->sprite,0);
    check(allocateSprite()==-1,"allocateSprite when every sprite's in use",0,0);
    initSprites(1);
    printf("Level objects and actors: properties, links, paths, sprites near the camera, waking, killing\n");
}

// Switch handler calls, recorded
typedef struct SwitchCall {
    int value;
    bool on;
    int objectIX;
    uint8_t why;
} SwitchCall;
static SwitchCall switchCalls[32];
static int switchCallCount=0, setupCalls=0;

static void recordSwitch(int value, bool on, int objectIX, uint8_t why)
{
    if(switchCallCount<32){
        switchCalls[switchCallCount++]=(SwitchCall){value,on,objectIX,why};
    }
}

static void countSetup(const LevelDef *lv)
{
    (void)lv;
    ++setupCalls;
}

// A switch handler call was made (value, on, why)
static bool switchCalled(int value, bool on, uint8_t why)
{
    for(int n=0;n<switchCallCount;n++){
        if(switchCalls[n].value==value && switchCalls[n].on==on && switchCalls[n].why==why){
            return true;
        }
    }
    return false;
}

// Switches, and what's remembered moving between levels - with the demo level and the cave (levels/tiled)
static void testLevelSwitches(void)
{
    initLayers();
    initSprites(20);
    clearLevelStateStore();
    setLevelHandlers(countSetup,recordSwitch);
    switchCallCount=0;
    setupCalls=0;

    // Into the demo level at its start: set up, nothing on to replay
    const int start=enterLevel(LEVEL_ID_DEMO,NULL);
    check(start>=0 && strcmp(getLevelObject(start)->name,"start")==0 && getLevelID()==LEVEL_ID_DEMO,
        "entering a level finds its start",start,0);
    check(setupCalls==1 && switchCallCount==0,"level setup called, nothing replayed",setupCalls,switchCallCount);
    check(enterLevel(LEVEL_ID_DEMO,"cave door")==findLevelObjectByName("cave door"),"entering at a named entrance",0,0);
    check(enterLevel(99,NULL)==-2,"a level that doesn't exist",0,0);
    enterLevel(LEVEL_ID_DEMO,NULL);
    switchCallCount=0;

    // Toggle (the piston lever): on, off, on - the handler told each time, its frame following
    const int lever=findLevelObjectByName("piston lever");
    check(lever>=0 && getLevelObject(lever)->mode==LEVEL_SWITCH_TOGGLE && getLevelObject(lever)->slot>=0,"the lever",lever,0);
    check(useLevelSwitch(lever) && getLevelSwitch(lever) && getLevelActor(lever)->frame==1 &&
        switchCalled(SWITCH_ID_PISTONS,true,LEVEL_SWITCH_USED),"a toggle switch turns on",switchCallCount,1);
    check(useLevelSwitch(lever) && !getLevelSwitch(lever) && getLevelActor(lever)->frame==0 &&
        switchCalled(SWITCH_ID_PISTONS,false,LEVEL_SWITCH_USED),"and off",switchCallCount,2);
    useLevelSwitch(lever);

    // Once (the locked door): opens, and stays open
    const int door=findLevelObjectByName("treasure door");
    check(getLevelActor(door)->frame==0,"a door starts shut (its placed frame)",getLevelActor(door)->frame,0);
    check(useLevelSwitch(door) && getLevelSwitch(door) && !useLevelSwitch(door) && getLevelSwitch(door),
        "a once switch stays on",0,0);
    check(getLevelActor(door)->frame==3,"on, a switch shows the last frame of its sheet (the door open)",
        getLevelActor(door)->frame,3);

    // Timed (the lift plate): on, then off by itself after its time - used again while on restarts the time
    const int plate=findLevelObjectByName("lift plate");
    useLevelSwitch(plate);
    for(int n=0;n<60;n++){
        updateLevel();
    }
    check(!useLevelSwitch(plate) && getLevelSwitch(plate),"using a timed switch that's on restarts it",0,0);
    for(int n=0;n<119;n++){
        updateLevel();
    }
    check(getLevelSwitch(plate),"a timed switch stays on for its time",0,0);
    updateLevel();
    check(!getLevelSwitch(plate) && switchCalled(SWITCH_ID_LIFT_CALL,false,LEVEL_SWITCH_EXPIRED),
        "then turns itself off",0,0);

    // The game's own remembered bits
    setLevelObjectMemory(lever,21);
    check(getLevelObjectMemory(lever)==21 && getLevelObjectMemory(plate)==0,"object memory",getLevelObjectMemory(lever),21);

    // To the cave: its key's there. Take it
    const int from=enterLevel(LEVEL_ID_CAVE,"from demo");
    check(from>=0 && getLevelID()==LEVEL_ID_CAVE,"into the cave at its entrance",from,0);
    const int key=findLevelObjectByName("door key");
    check(key>=0 && isLevelActorActive(key),"the key's in the cave",key,0);
    killLevelActor(key);

    // Back to the demo level: the lever and door were left on, so are replayed; the plate doesn't persist
    switchCallCount=0;
    enterLevel(LEVEL_ID_DEMO,"cave door");
    check(getLevelSwitch(lever) && getLevelSwitch(door) && !getLevelSwitch(plate),"switches as they were left",0,0);
    check(switchCallCount==2 && switchCalled(SWITCH_ID_PISTONS,true,LEVEL_SWITCH_REPLAY) &&
        switchCalled(SWITCH_ID_DOOR_A,true,LEVEL_SWITCH_REPLAY),"switches left on are replayed",switchCallCount,2);
    check(getLevelActor(lever)->frame==1 && getLevelObjectMemory(lever)==21,"frame and memory remembered",
        getLevelObjectMemory(lever),21);

    // The key stays gone
    enterLevel(LEVEL_ID_CAVE,"from demo");
    check(!isLevelActorActive(findLevelObjectByName("door key")),"a collected key stays gone",0,0);

    // A switch in another level, changed from here: the lever off
    check(getLevelSwitchState(LEVEL_ID_DEMO,LEVEL_SLOT_DEMO_PISTON_LEVER),"another level's switch, read",0,0);
    setLevelSwitchState(LEVEL_ID_DEMO,LEVEL_SLOT_DEMO_PISTON_LEVER,false);
    check(!getLevelSwitchState(LEVEL_ID_DEMO,LEVEL_SLOT_DEMO_PISTON_LEVER),"another level's switch, set",0,0);
    switchCallCount=0;
    enterLevel(LEVEL_ID_DEMO,NULL);
    check(!getLevelSwitch(lever) && getLevelSwitch(door) && switchCallCount==1,"it's off when the level's entered",
        switchCallCount,1);

    // Saving and loading a game: the whole store
    static uint8_t saved[LEVEL_STATE_SIZE];
    memcpy(saved,getLevelStateStore(),LEVEL_STATE_SIZE);
    clearLevelStateStore();
    enterLevel(LEVEL_ID_DEMO,NULL);
    check(!getLevelSwitch(door),"a new game forgets",0,0);
    memcpy(getLevelStateStore(),saved,LEVEL_STATE_SIZE);
    enterLevel(LEVEL_ID_DEMO,NULL);
    check(getLevelSwitch(door),"a loaded game remembers",0,0);

    setLevelHandlers(NULL,NULL);
    clearLevelStateStore();
    initSprites(1);
    printf("Level switches: modes, handler, replay entering levels, entrances, keys staying gone, other levels' switches, saving\n");
}

// The demo level (levels/tiled/demo.tmx, converted into levels/level_demo.c) - loads, matches the map, and a view of it
static void testDemoLevel(void)
{
    initLayers();
    initSprites(1);
    check(loadLevel(&level_demo),"demo level loads",0,0);
    check(getLevelWidth()==192*8 && getLevelHeight()==40*8,"demo level size",getLevelWidth(),getLevelHeight());
    // A few tiles from the map: ground, the pool's platform, a pillar in front, sky that repeats
    check(getLevelTile(2,10,34)==1 && getLevelTile(2,43,31)==6 && getLevelTile(2,40,35)==7,"demo level tiles",
        getLevelTile(2,43,31),6);
    check(getLevelForegroundTile(2,74,30)==16 && getLevelForegroundTile(2,75,26)==19 && getLevelTile(2,74,30)==0,
        "demo level foreground tiles",getLevelForegroundTile(2,74,30),16);
    check(getLevelTile(4,5,20)==24 && getLevelTile(4,5+64*3,20)==24,"demo level sky repeats",getLevelTile(4,5+64*3,20),24);
    check((getLevelTileFlags(2,10,34)&LEVEL_TILE_SOLID) && (getLevelTileFlags(2,43,31)&LEVEL_TILE_PLATFORM) &&
        (getLevelTileFlags(2,24,29)&LEVEL_TILE_COLLECT),"demo level tile flags",getLevelTileFlags(2,24,29),0);
    check(isLevelPixelSolid(2,10*8,34*8+4) && !isLevelPixelSolid(2,10*8,33*8+4),"demo level solid pixels",0,0);

    // A view by the pillars, with a sprite behind one
    setLayerPos(0,400,0);
    setLevelCamera(560,112);
    setSpriteSize(0,SIZE_16X16);
    setSpriteDef(0,sprite24x24Def,mask24x24Def);
    setSpriteLayer(0,2);
    setSpritePalette(0,1);
    setSpritePos(0,(float)(74*8+18-560),(float)(33*8-112));
    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("level_demo.bmp");
    setLevelCamera(1100,0);
    setLayerTransform(2,0.25f,1.0f,1.0f);
    setLevelCamera(1100,0);
    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("level_demo_rotated.bmp");
    clearLayerTransform(2);
}

// ---------------------------------------------------------------------------
// Example scenes
// ---------------------------------------------------------------------------

static void saveScreenBMP(const char *name)
{
    static const uint8_t rgb[16][3]={
        {0,0,0},{0,0,215},{215,0,0},{215,0,215},{0,215,0},{0,215,215},{215,215,0},{215,215,215},
        {0,0,0},{0,0,255},{255,0,0},{255,0,255},{0,255,0},{0,255,255},{255,255,0},{255,255,255},
    };
    char path[512];
    snprintf(path,sizeof(path),"%s/%s",outDir,name);
    FILE *f=fopen(path,"wb");
    if(!f){
        printf("Can't write %s\n",path);
        return;
    }
    const int w=SCREEN_WIDTH_PIXELS, h=SCREEN_HEIGHT_LINES;
    const uint32_t dataSize=w*h*3;
    uint8_t header[54]={'B','M'};
    const uint32_t fileSize=54+dataSize;
    memcpy(header+2,&fileSize,4);
    header[10]=54;
    header[14]=40;
    const int32_t bw=w, bh=h;
    memcpy(header+18,&bw,4);
    memcpy(header+22,&bh,4);
    header[26]=1;
    header[28]=24;
    memcpy(header+34,&dataSize,4);
    fwrite(header,1,54,f);
    for(int y=h-1;y>=0;y--){
        for(int x=0;x<w;x++){
            const uint8_t attr=renderAttrBuffer[((y/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS)+(x>>3)];
            const bool ink=(renderBuffer[(y*SCREEN_WIDTH_CELLS)+(x>>3)]&(0x80>>(x&7)))!=0;
            const int bright=(attr&0x40)?8:0;
            const uint8_t *c=rgb[(ink?(attr&7):((attr>>3)&7))+bright];
            const uint8_t bgr[3]={c[2],c[1],c[0]};
            fwrite(bgr,1,3,f);
        }
    }
    fclose(f);
    printf("Saved %s\n",path);
}

static void sceneRotatedTilesAndSprites(void)
{
    initLayers();

    // Layer 2 - text tiles, rotated and scaled around the screen centre
    setTileDefSet(2,defaultTileDef);
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        const uint8_t col=(uint8_t)(0x40|((1+(y%6))));
        drawTxtToLayer(2,"ZXELERATOR ROTATION TEST * ZXELERATOR ROTATION TEST * ZXELERATOR ",col,col,0,y);
    }
    setLayerPos(2,0,0);
    setLayerTransform(2,0.35f,1.5f,1.5f);

    // Rotated/scaled sprites in front
    initSprites(5);
    const float angles[5]={0.0f,0.4f,1.2f,-0.7f,3.14159f};
    const float scales[5]={1.0f,1.0f,1.6f,0.8f,1.2f};
    for(int n=0;n<5;n++){
        setSpriteSize(n,SIZE_32X40);
        setSpriteDef(n,titleLettersDef,titleLettersMaskDef);
        setSpritePalette(n,4);
        setSpriteLayer(n,0);
        spriteList[n].frame=n;
        setSpritePos(n,(float)(28+(n*50)),(float)(n==2?120:60+(n&1)*80));
        setSpriteScale(n,scales[n],scales[n]);
        setSpriteRotation(n,angles[n]);
    }

    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("rotate_tiles_sprites.bmp");
}

static void sceneRotatedSprites(void)
{
    initLayers();

    // Letters Z X E L E R A T O R at different angles and scales, some hanging off the screen edges
    const int count=12;
    initSprites(count);
    for(int n=0;n<count;n++){
        const int row=n/5, col=n%5;
        setSpriteSize(n,SIZE_32X40);
        setSpriteDef(n,titleLettersDef,titleLettersMaskDef);
        setSpritePalette(n,(n&1)?2:3);
        setSpriteLayer(n,0);
        spriteList[n].frame=n%10;
        setSpritePos(n,(float)(26+(col*51)),(float)(34+(row*62)));
        setSpriteScale(n,(row==1)?1.4f:1.0f,(row==1)?1.4f:1.0f);
        setSpriteRotation(n,(float)n*0.45f);
    }
    // Off the top/left edges (rotated), and a scaled unrotated one off the top (tests the scaled path clipping)
    setSpritePos(10,4.0f,-6.0f);
    setSpritePos(11,236.0f,-10.0f);
    setSpriteRotation(11,0.0f);
    setSpriteScale(11,1.8f,1.8f);

    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("rotate_sprites.bmp");
}

static void buildFloorTiles(void)
{
    memset(floorTiles,0,sizeof(floorTiles));
    for(int r=0;r<8;r++){
        floorTiles[(0*8)+r]=0x00;           floorTiles[2048+(0*8)+r]=0xff;  // transparent
        floorTiles[(1*8)+r]=0xff;           floorTiles[2048+(1*8)+r]=0x00;  // solid ink
        floorTiles[(2*8)+r]=0x00;           floorTiles[2048+(2*8)+r]=0x00;  // solid paper
        floorTiles[(3*8)+r]=(r&1)?0x55:0xaa; floorTiles[2048+(3*8)+r]=0x00; // checker
    }
}

static void sceneMode7Floor(float camAngle, const char *name)
{
    initLayers();
    buildFloorTiles();

    // Layer 4 (back) - wrapped bitmap for the sky
    setLayerType(4,LT_BITMAP_WRAP);
    setLayerBitmap(4,gameBackground0Bitmap,NULL);
    setLayerPos(4,0,-200);

    // Layer 3 - checkerboard floor in perspective, with a road of checker tiles
    setTileDefSet(3,floorTiles);
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            const bool road=((x&15)==7 || (x&15)==8);
            const bool light=(((x>>2)+(y>>2))&1)!=0;
            const uint8_t col=road?0x46:(light?0x44:0x41);
            setLayerTile(3,road?3:1,col,col,x,y);
        }
    }
    buildLayerPerspective(floorLines,256.0f,256.0f,camAngle,24.0f,64.0f,128.0f);
    setLayerLineTransforms(3,floorLines);

    // A sprite standing on the floor
    initSprites(1);
    setSpriteSize(0,SIZE_24X24);
    setSpriteDef(0,spriteBubbleDef,spriteBubbleMaskDef);
    setSpritePalette(0,2);
    setSpriteLayer(0,0);
    setSpritePos(0,128.0f,150.0f);
    setSpriteScale(0,2.0f,2.0f);
    setSpriteRotation(0,0.3f);

    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP(name);
}

static void sceneRotatedBitmaps(void)
{
    initLayers();
    initSprites(0);

    // Layer 4 - wrapped bitmap, rotated and zoomed out
    setLayerType(4,LT_BITMAP_WRAP);
    setLayerBitmap(4,gameBackground0Bitmap,NULL);
    setLayerPos(4,0,0);
    setLayerTransform(4,0.5f,0.8f,0.8f);

    // Layer 1 - the title screen bitmap, rotated and shrunk, transparent outside the bitmap
    setLayerType(1,LT_BITMAP);
    setLayerBitmap(1,titleScreenBitmap,titleScreenAttr);
    setLayerPos(1,0,0);
    setLayerTransform(1,-0.3f,0.6f,0.6f);

    initScratchBuffers(true);
    compositeScene();
    saveScreenBMP("rotate_bitmaps.bmp");
}

// Rough relative cost of the renderers on the PC (not RP2350 timings)
static void relativeTimings(void)
{
    initLayers();
    setTileDefSet(0,sideDaddyTileDef);
    setLayerPos(0,3,5);
    const int iterations=2000;

    clock_t t0=clock();
    for(int n=0;n<iterations;n++){
        blitLayerToScratchBuffers(0);
    }
    const double fast=(double)(clock()-t0);

    setLayerTransform(0,0.0f,2.0f,2.0f);
    t0=clock();
    for(int n=0;n<iterations;n++){
        blitLayerToScratchBuffers(0);
    }
    const double scaled=(double)(clock()-t0);

    setLayerTransform(0,0.5f,1.3f,1.3f);
    t0=clock();
    for(int n=0;n<iterations;n++){
        blitLayerToScratchBuffers(0);
    }
    const double rotated=(double)(clock()-t0);

    printf("Relative cost of a full screen tile layer (PC): scroll only 1.0, scaled %.1fx, rotated %.1fx\n",
        scaled/fast,rotated/fast);
}

int main(int argc, char *argv[])
{
    if(argc>1){
        outDir=argv[1];
    }

    testClipSpan();
    testTileLayerIdentity();
    test16x16Layers();
    testLayerColour();
    testBitmapLayerIdentity(titleScreenBitmap,titleScreenAttr,"title screen bitmap");
    testBitmapLayerIdentity(gameBackground0Bitmap,NULL,"background bitmap");
    buildNarrowBitmap();
    testBitmapLayerIdentity(narrowBitmap,narrowAttrs,"narrow bitmap, edges on screen");
    testBitmapColourAwareIdentity(titleScreenBitmap,titleScreenAttr,"title screen bitmap");
    testBitmapColourAwareIdentity(narrowBitmap,narrowAttrs,"narrow bitmap");
    testSpriteIdentity(SIZE_8X8,sprite24x24Def,mask24x24Def,1,"8x8");
    testSpriteIdentity(SIZE_16X16,sprite24x24Def,mask24x24Def,1,"16x16");
    testSpriteIdentity(SIZE_24X24,sprite24x24Def,mask24x24Def,2,"24x24");
    testSpriteIdentity(SIZE_32X40,titleLettersDef,titleLettersMaskDef,2,"32x40");
    testSpriteIdentity(SIZE_32X8,platformSpriteDef,platformSpriteMaskDef,1,"32x8");
    testSpriteIdentity(SIZE_16X32,gateDoorDef,gateDoorMaskDef,4,"16x32");

    testTileSprites();
    testFrameSnapshot();
    testSpriteSets();
    testSpriteSpriteCollisions();
    testSpriteLayerCollisions();
    testLayerSpaceSprites();
    testLayerSamplers();
    testTileAtPoint();
    testSpriteTileAt();
    testLzPack();
    testLevelStreaming();
    testDemoLevel();
    testLevelActors();
    testLevelSwitches();
    testLevel16();
    for(int space=0;space<2;space++){
        testSpace=space?PARTICLE_SPACE_LAYER:PARTICLE_SPACE_SCREEN;
        printf("Particles in %s space:\n",space?"layer":"screen");
        testParticleBounces();
        testParticleSlopes();
        testParticleSceneSlopes();
        testParticleStillLimit();
        testParticlesOnRotatingLayer();
    }

    sceneRotatedTilesAndSprites();
    sceneRotatedSprites();
    sceneMode7Floor(0.0f,"mode7_floor.bmp");
    sceneMode7Floor(0.6f,"mode7_floor_turned.bmp");
    sceneRotatedBitmaps();
    relativeTimings();
    particleTimings();

    printf(failures?"%d FAILURES\n":"All tests passed\n",failures);
    return failures?1:0;
}
