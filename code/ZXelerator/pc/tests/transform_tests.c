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
        setSpriteCollisions(0,COLLIDE_SPRITES);
        setSpriteCollisions(1,COLLIDE_SPRITES);

        drawSpriteAlone(0,drawnA);
        drawSpriteAlone(1,drawnB);
        bool expected=false;
        for(int i=0;i<(int)sizeof(drawnA) && !expected;i++){
            expected=(drawnA[i]&drawnB[i])!=0;
        }
        detectCollisions();
        const bool gotA=(spriteList[0].spriteHitCount==1 && spriteList[0].spriteHits[0]==1);
        const bool gotB=(spriteList[1].spriteHitCount==1 && spriteList[1].spriteHits[0]==0);
        check(gotA==expected && gotB==expected && (spriteList[0].spriteHitCount<=1),"sprite-sprite collision",x,y);
        if(!(gotA==expected && gotB==expected) && failures<=8){
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
    // Without the flag on both, nothing is recorded
    setSpriteCollisions(1,COLLIDE_NONE);
    setSpritePos(1,spriteList[0].x,spriteList[0].y);
    detectCollisions();
    check(spriteList[0].spriteHitCount==0,"sprite-sprite needs COLLIDE_SPRITES on both",0,0);
    printf("Sprite-sprite collisions: %d random pairs (%d touching), matching the drawn pixels\n",tests,hits);
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
    buildNarrowBitmap();
    testBitmapLayerIdentity(narrowBitmap,narrowAttrs,"narrow bitmap, edges on screen");
    testBitmapColourAwareIdentity(titleScreenBitmap,titleScreenAttr,"title screen bitmap");
    testBitmapColourAwareIdentity(narrowBitmap,narrowAttrs,"narrow bitmap");
    testSpriteIdentity(SIZE_8X8,sprite24x24Def,mask24x24Def,1,"8x8");
    testSpriteIdentity(SIZE_16X16,sprite24x24Def,mask24x24Def,1,"16x16");
    testSpriteIdentity(SIZE_24X24,sprite24x24Def,mask24x24Def,2,"24x24");
    testSpriteIdentity(SIZE_32X40,titleLettersDef,titleLettersMaskDef,2,"32x40");

    testFrameSnapshot();
    testSpriteSpriteCollisions();
    testSpriteLayerCollisions();
    testLayerSamplers();
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
