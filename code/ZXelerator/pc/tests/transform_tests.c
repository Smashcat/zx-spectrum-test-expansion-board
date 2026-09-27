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

static void testBitmapLayerIdentity(const uint8_t *bitmap, const uint8_t *attrs, const char *name)
{
    const int layer=1;
    initLayers();
    setLayerType(layer,LT_BITMAP);
    setLayerBitmap(layer,bitmap,attrs);
    const int w=bitmap[0]*8;
    const int h=bitmap[1]*8;

    int tests=0;
    for(int y=-h+1;y<SCREEN_HEIGHT_LINES;y+=(h>300?53:7)){
        for(int x=-w+1;x<SCREEN_WIDTH_PIXELS;x+=5){
            clearLayerTransform(layer);
            setLayerPos(layer,x,y);
            renderLayerOnly(layer);
            saveReference();

            buildIdentityLines(x,y);
            setLayerLineTransforms(layer,identityLines);
            renderLayerOnly(layer);
            check(memcmp(refPix,scratchPixRam,sizeof(refPix))==0,name,x,y);
            ++tests;
        }
    }
    clearLayerTransform(layer);
    printf("Bitmap layer identity (%s): %d comparisons\n",name,tests);
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
    testBitmapLayerIdentity(titleScreenBitmap,titleScreenAttr,"title screen bitmap");
    testBitmapLayerIdentity(gameBackground0Bitmap,NULL,"background bitmap");
    testSpriteIdentity(SIZE_8X8,sprite24x24Def,mask24x24Def,1,"8x8");
    testSpriteIdentity(SIZE_16X16,sprite24x24Def,mask24x24Def,1,"16x16");
    testSpriteIdentity(SIZE_24X24,sprite24x24Def,mask24x24Def,2,"24x24");
    testSpriteIdentity(SIZE_32X40,titleLettersDef,titleLettersMaskDef,2,"32x40");

    sceneRotatedTilesAndSprites();
    sceneRotatedSprites();
    sceneMode7Floor(0.0f,"mode7_floor.bmp");
    sceneMode7Floor(0.6f,"mode7_floor_turned.bmp");
    sceneRotatedBitmaps();
    relativeTimings();

    printf(failures?"%d FAILURES\n":"All tests passed\n",failures);
    return failures?1:0;
}
