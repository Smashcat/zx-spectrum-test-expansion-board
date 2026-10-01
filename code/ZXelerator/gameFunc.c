#include "gameFunc.h"
#include <ctype.h>

void demoLoop(void){

    static const uint8_t bowser[64]={
        128,129,130,131,132,133,134,135,
        144,145,146,147,148,149,150,151,
        160,161,162,163,164,165,166,167,
        176,177,178,179,180,181,182,183,
        192,193,194,195,196,197,198,199,
        208,209,210,211,212,213,214,215,
        224,225,226,227,228,229,230,231,
        240,241,242,243,244,245,246,247
    };
    
    static const uint8_t bowserCol[128]={
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
        0x47,0x47,0x47,0x47,0x47,0x47,0x47,0x47,
    };
    
    static const uint8_t scoreBorder[28]={
        1,2,2,2,2,2,3,
        4,'S','C','O','R','E',20,
        4,'0','0','0','0','0',20,
        17,18,18,18,18,18,19
    };
    
    static const uint8_t scoreColor[56]={
        0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,
        0x4f,0x4f, 0x71,0x61,0x71,0x61,0x71,0x61,0x71,0x61,0x71,0x61, 0x4f,0x4f,
        0x4f,0x4f, 0x79,0x79,0x79,0x79,0x79,0x79,0x79,0x79,0x79,0x79, 0x4f,0x4f, 
        0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,0x4f,0x47,
    };

    bool tf=false;

    deleteParticleSets();
    const int particleSet=createParticleSet(1000,0);
    setParticleSetGravity(particleSet,0.2f);

    const int numSprites=100;
    initSprites(numSprites);
    for(int n=0;n<numSprites;n++){
        setSpritePos(n,(n==0?116:500),(n==0?84:500));
        setSpriteSize(n,SIZE_24X24);
        setSpriteDef(n,sprite24x24Def,mask24x24Def);
        setSpritePalette(n,(n==0?1:2));
        setSpriteLayer(n,1);
        if(n==0){
            setSpriteScale(n,4.5,3);
        }
    };

    const int hudLayer=0;
    const int frameCounterLayer=1;
    const int frontBowserLayer=2;
    const int backBowserLayer=3;

    setTileDefSet(hudLayer,defaultTileDef);

    setTileDefSet(frameCounterLayer,defaultTileDef);
    setTileDefSet(frontBowserLayer,defaultTileDef);
    setTileDefSet(backBowserLayer,defaultTileDef);

    for(int xPos=0;xPos<32;xPos+=8){
        for(int yPos=0;yPos<32;yPos+=8){
            for(int n=0;n<8;n++){
                blitRawToLayer(frontBowserLayer,bowser+(n*8),bowserCol+(n*16),xPos,yPos+n,8);
                blitRawToLayer(backBowserLayer,bowser+(n*8),bowserCol+(n*16),xPos,yPos+n,8);
            }
        }
    }

    for(int n=0;n<4;n++){
        blitRawToLayer(hudLayer,scoreBorder+(n*7),scoreColor+(n*14),0,n,7);
        blitRawToLayer(hudLayer,scoreBorder+(n*7),scoreColor+(n*14),25,n,7);
    }

    drawTxtToLayer(hudLayer,"xShift: 00",0b01000110,0b00000101,22,5);
    drawTxtToLayer(hudLayer,"xStart: 00",0b01000110,0b00000101,22,6);
    drawTxtToLayer(hudLayer,"Keyboard:",0b01000110,0b00000101,0,5);

    setLayerPos(frameCounterLayer,0,0);
    setLayerPos(frontBowserLayer,0,0);
    setLayerPos(hudLayer,0,0);

    int lYPos=0;
    int lYDir=1;
    int l1YPos=0;
    int l2YPos=0;

    float pSpriteScaleX=1;
    float pSpriteScaleY=1;
    float pSpriteScaleXInt=0.05;
    float pSpriteScaleYInt=-0.07;
    float spinOffX=0;
    float spinOffY=0;
    while(eroneousAddr==0){
        // Wait for core0 to wake us
        __wfe(); // Wait for event
        __dsb(); // Make sure memory is consistent
        // Render the frame here - generates the ASM
        // For now just keep copying the default ASM - title image
        
        if(gv.frameRendered>50){
            initScratchBuffers(true);

            if(particlesAlive(particleSet)==0){

                startParticles(
                    particleSet,
                    128,96,
                    1000,
                    0,2*M_PI,
                    0.5,3.9,
                    20,45   // min,max age
                );            

            }

            for(int n=0;n<24;n++){
                drawIntNumToLayer(frameCounterLayer,gv.frameRendered,0x57,0x0f,n,n,8);
            }
        
            setLayerPos(frameCounterLayer,lYPos,4);
            lYPos+=lYDir;
            if(lYPos==16){
                lYDir=-1;
            }else if(lYPos==-16){
                lYDir=1;
            }

            setLayerPos(frontBowserLayer,sin(((float)gv.frameRendered)/10.0)*50,l1YPos);
            l1YPos-=4;
            if(l1YPos==-64){
                l1YPos=0;
            }

            setLayerPos(backBowserLayer,sin(((float)gv.frameRendered)/17.0)*25,l2YPos);
            l2YPos+=2;
            if(l2YPos==2){
                l2YPos=-62;
            }

            for(int n=0;n<8;n++){
                if(keyboardScan[n]&0x1f){
                    const char *kName=keyScanToStr(n);
                    drawTxtToLayer(hudLayer,"     ",0x57,0x0f,0,7);
                    drawTxtToLayer(hudLayer,kName,0x57,0x0f,0,7);
                }
            }

            int spritesToDraw=(gv.frameRendered-100);
            if(spritesToDraw>numSprites){
                spritesToDraw=numSprites;
            }
            for(int n=1;n<spritesToDraw;n++){
                if(n<64){
                    setSpritePos(n,118+(sin((spinOffX+(n*0.15)))*100.0),84+(cos((spinOffY+(n*0.15)))*60.0));
                }else{
                    setSpritePos(n,118-(sin((spinOffX+(n*0.15)))*100.0),84+(cos((spinOffY+(n*0.15)))*60.0));
                }
            }
            spinOffX+=0.04;
            spinOffY+=0.15;

            if(keyDown(KEY_A)){
                setSpritePos(0,spriteList[0].x-2,spriteList[0].y);
                setSpriteDef(0,sprite24x24Def,mask24x24Def);
                if(--spriteList[0].frame<0){
                    spriteList[0].frame=7;
                }
            }

            if(keyDown(KEY_D)){
                setSpritePos(0,spriteList[0].x+2,spriteList[0].y);
                setSpriteDef(0,sprite24x24Def+(96*8),mask24x24Def+(96*8));
                if(++spriteList[0].frame==8){
                    spriteList[0].frame=0;
                }
            }

            if(keyDown(KEY_W)){
                setSpritePos(0,spriteList[0].x,spriteList[0].y-4);
            }

            if(keyDown(KEY_S)){
                setSpritePos(0,spriteList[0].x,spriteList[0].y+4);
            }

            setSpriteScale(0,pSpriteScaleX,pSpriteScaleY);
            pSpriteScaleX+=pSpriteScaleXInt;
            if(pSpriteScaleX>=6){pSpriteScaleXInt=-0.05;}
            if(pSpriteScaleX<=0.140){pSpriteScaleXInt=0.05;}
            pSpriteScaleY+=pSpriteScaleYInt;
            if(pSpriteScaleY>=6){pSpriteScaleYInt=-0.07;}
            if(pSpriteScaleY<=0.140){pSpriteScaleYInt=0.07;}
        
            drawIntNumToLayer(hudLayer,spriteList[0].x&0x07,0b01000110,0b00000101,30,5,2);
            drawIntNumToLayer(hudLayer,spriteList[0].x>>3,0b01000110,0b00000101,30,6,2);
            compositeScene();

            tf=(tf?false:true);
//            gpio_put(PIN_LED,tf);
            flipBank=1;
            __dsb();
        }
        ++gv.frameRendered;
    }
}

// ---------------------------------------------------------------------------
// Title screen "falling wall" transition
// ---------------------------------------------------------------------------

#define TITLE_WALL_LAYER    1
#define TITLE_WALL_DIST     256.0f      // Viewer's distance from the wall in pixels - sets the strength of the perspective
#define TITLE_LETTERS       10

static const int titleSpritePosX[TITLE_LETTERS]={
    0+16,24+16,56+16,80+16, 112+16,128+16,152+16,168+16,196+16,224+16
};
static LayerLineTransform titleWallLines[SCREEN_HEIGHT_LINES];
static float titleWallAngle, titleWallSpeed;
// The finished title screen (bitmap and letter sprites), captured so it can fall away as a single image
static FrameSnapshot titleSnapshot;

/// @brief The story screen's background drifts around - it starts while the title falls away, and carries on smoothly
static void scrollStoryBackground(void)
{
    setLayerPos(4,(sin((float)gv.iv/137)*100)-128,(sin((float)gv.iw/212)*100)-92);
    gv.iv+=3;
    gv.iw+=4;
}

/// @brief The title bitmap is a wall hinged along the bottom of the screen, with the viewer's eye level with the hinge.
/// Tipped back by angle, each screen line shows one row of the wall - the higher up the wall, the further away and
/// so the narrower it is. At 90 degrees the wall is edge-on, and gone
static void buildFallingWallLines(float angle)
{
    const float c=cosf(angle);
    const float s=sinf(angle);
    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        LayerLineTransform *l=titleWallLines+y;
        // Height above the hinge on screen, relative to the viewing distance, then the height up the wall it shows
        const float k=((float)SCREEN_HEIGHT_LINES-((float)y+0.5f))/TITLE_WALL_DIST;
        const float den=c-(k*s);
        const float h=(den>0.0001f)?(k*TITLE_WALL_DIST)/den:(float)SCREEN_HEIGHT_LINES;
        if(h>=(float)SCREEN_HEIGHT_LINES){
            // Above the top of the wall
            l->enabled=0;
            continue;
        }
        // Wall pixels per screen pixel along this line, centred on the middle of the screen
        const float scale=(TITLE_WALL_DIST+(h*s))/TITLE_WALL_DIST;
        const float halfW=(float)(SCREEN_WIDTH_PIXELS/2);
        l->u=FIXED16(halfW+((0.5f-halfW)*scale));
        l->v=FIXED16((float)SCREEN_HEIGHT_LINES-h);
        l->dudx=FIXED16(scale);
        l->dvdx=0;
        l->enabled=1;
    }
}

/// @brief Swap the title screen for the frame captured last frame (title and letters as one image), ready to fall
static void startTitleFall(void)
{
    titleWallAngle=0.0f;
    titleWallSpeed=0.0f;
    // The snapshot layer is opaque, so it hides the background that will be scrolling behind it from now on
    setLayerSnapshot(TITLE_WALL_LAYER,&titleSnapshot);
    for(int n=0;n<TITLE_LETTERS;n++){
        setSpritePos(n,300,300);
    }
    buildFallingWallLines(0.0f);
    setLayerLineTransforms(TITLE_WALL_LAYER,titleWallLines);
}

/// @return True once the title has fallen out of sight
static bool updateTitleFall(void)
{
    scrollStoryBackground();

    // Topples like a real wall - slowly at first, speeding up as it leans further over
    titleWallSpeed+=0.002f+(0.012f*sinf(titleWallAngle));
    titleWallAngle+=titleWallSpeed;
    if(titleWallAngle>=(float)(M_PI/2.0)){
        // Gone - stop drawing the title layer (setState(GS_title) puts the title bitmap back on it next time)
        setLayerLineTransforms(TITLE_WALL_LAYER,NULL);
        setLayerOpaque(TITLE_WALL_LAYER,false);
        setLayerPos(TITLE_WALL_LAYER,0,400);
        return true;
    }
    buildFallingWallLines(titleWallAngle);
    return false;
}

/// @brief Bubbles for the story screen
static void startStoryScreen(void)
{
    initSprites(20);
    for(int n=0;n<20;n++){
        setSpritePos(n,n*10,-30);
        setSpriteSize(n,SIZE_24X24);
        setSpriteDef(n,spriteBubbleDef,spriteBubbleMaskDef);
        setSpritePalette(n,0);
        setSpriteLayer(n,4);
        spriteList[n].frame=(n%3);
    };
}

void gameTitle(void)
{

    // M switches to the Mode 7 test scene, T to the audio test, C to the collision test, L to the level test
    if(keyDown(KEY_M)){
        setState(GS_mode7Test);
        return;
    }
    if(keyDown(KEY_T)){
        setState(GS_audioTest);
        return;
    }
    if(keyDown(KEY_C)){
        setState(GS_collisionTest);
        return;
    }
    if(keyDown(KEY_L)){
        setState(GS_levelTest);
        return;
    }

    if(gv.ix==0){
        float sinIX=(float)(gv.iy+14)/10.0;
        int yPos=(((sin(sinIX)+1)*250.0)/8);
        yPos*=4;
        setLayerPos(1,0,yPos);
        ++gv.iy;
        if(yPos==0){    // gv.iy is 32 here
            gv.ix=1;
            gv.iy=0;
        }
    }else if(gv.ix==1){
        bool oneChanged=false;
        for(int n=0;n<10;n++){
            if(spriteList[n].delay>0){
                --spriteList[n].delay;
                oneChanged=true;
            }else{
                float scale=spriteList[n].scaleX;
                if(scale<1.0){
                    oneChanged=true;
                    scale+=0.2;
                    if(scale>1.0){
                        scale=1.0;
                    }
                    setSpritePos(n,titleSpritePosX[n]-((1.0-scale)*15),161);
                    setSpriteScale(n,scale,1.0);
                }
            }
        }
        if(!oneChanged && (++gv.iy==50)){
            // After the pause, capture this frame (title and letters), which then falls away backwards as one image,
            // revealing the story screen's background
            captureNextFrame(&titleSnapshot);
            gv.iy=0;
            gv.ix=2;
        }
    }else if(gv.ix==2){
        if(gv.iy==0){
            startTitleFall();
            gv.iy=1;
        }
        if(updateTitleFall()){
            gv.iy=0;
            gv.ix=4;
            startStoryScreen();
        }
    }else if(gv.ix==4){
        if(gv.iy<108){
            gv.iy+=(gv.iy<40?4:(gv.iy<96?3:2));
            setLayerPos(3,256-gv.iy,80);
        }
        scrollStoryBackground();
    
        if(gv.storyTextCurrentLineIX==gv.storyTextNextSectionAtLineIX){
            if(gv.storyTextSectionIX<5){
                gv.storyTextNextSectionAtLineIX=drawStorySection(2, gv.storyTextSectionIX, gv.storyTextCurrentLineIX);
                int currentTextLines=(gv.storyTextNextSectionAtLineIX-gv.storyTextCurrentLineIX);
                int botGap=(24-currentTextLines)/2;
                gv.storyScrollCDStartLine=gv.storyTextCurrentLineIX+currentTextLines+botGap+2;
                gv.storyTextNextSectionAtLineIX=gv.storyTextCurrentLineIX+currentTextLines+botGap+7;
                ++gv.storyTextSectionIX;
                if(gv.storyTextSectionIX==5){
                    // Scroll on a little further after the last section. The rows scrolled onto are already blank,
                    // as each row is cleared when it scrolls off the top (see below)
                    gv.storyTextNextSectionAtLineIX+=20;
                }
            }else{
                gv.ix=5;
                gv.iy=104;
                gv.iw=0;
                gv.iv=0;
            }
        }

        if((gv.frameRendered%10)==0){
            setLayerPos(0,0,(tileLayer[0].y==24*8?22*8:24*8));
        }

        if(gv.storyScrollCD==0){
            const int linesPerFrame=4;
            gv.storyTextCurrentSubLineIX+=linesPerFrame;
            if(gv.storyTextCurrentSubLineIX>7){
                gv.storyTextCurrentSubLineIX-=8;
                ++gv.storyTextCurrentLineIX;
                // The layer only has 64 rows and wraps, so clear each row as soon as it has scrolled off the top of
                // the screen (the 24 rows above storyTextCurrentLineIX are on screen). It comes back round at the
                // bottom already blank, so new text never has to clear rows that might still be showing
                clearLayerLines(2,gv.storyTextCurrentLineIX-25,1);
                if(gv.storyTextCurrentLineIX==gv.storyScrollCDStartLine){
                    gv.storyScrollCD=150;
                }
            }
            int lPos=tileLayer[2].y;
            lPos-=linesPerFrame;
            if(lPos<-TILE_LAYER_HEIGHT*8){
                lPos+=(TILE_LAYER_HEIGHT*8);
            }
            setLayerPos(2,0,lPos);
        }else{
            --gv.storyScrollCD;
        }

        if((rand()%100)>85){
            int ix=(rand()%20);
            for(int n=0;n<20;n++){
                int six=(n+ix)%20;
                if(spriteList[six].y<-29){
                    setSpritePos(six,(308-gv.iy)+(10-six),130);
                    spriteList[six].yDir=(((float)(rand()%100))/70.0)+1.5;
                    spriteList[six].xDir=(((float)(rand()%200)-100)/500.0);
                    break;
                }
            }
        }

        for(int n=0;n<20;n++){
            if(spriteList[n].y>-30){
                if((rand()%100)>90){
                    spriteList[n].xDir=-spriteList[n].xDir;
                }
                setSpritePos(
                    n,
                    spriteList[n].xF + spriteList[n].xDir,
                    spriteList[n].yF-spriteList[n].yDir
                );
            }
        }

    }else if(gv.ix==5){
        bool allDone=true;
        if(tileLayer[4].y<192){
            setLayerPos(4,tileLayer[4].x,tileLayer[4].y+gv.iw);
            ++gv.iw;
            allDone=false;
        }
        for(int n=0;n<20;n++){
            if(spriteList[n].y>-30){
                allDone=false;
                if((rand()%100)>90){
                    spriteList[n].xDir=-spriteList[n].xDir;
                }
                setSpritePos(
                    n,
                    spriteList[n].xF + spriteList[n].xDir,
                    spriteList[n].yF-spriteList[n].yDir
                );
            }
        }
        if(gv.iy>0){
            ++gv.iv;
            gv.iy-=gv.iv;
            if(gv.iy<0){
                gv.iy=0;
            }
            setLayerPos(3,256-gv.iy,80);
            allDone=false;
        }

        if((gv.frameRendered%10)==0){
            setLayerPos(0,0,(tileLayer[0].y==24*8?22*8:24*8));
        }

        if(allDone){
            tileLayer[0].y=24*8;
            setState(GS_title);
        }
    }

}

void drawBigTxtToLayer(int layerIX, const char *s, const uint8_t *colors, int x, int y)
{
    const int tOffset=((y%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH)+x;
    const int aOffset=((y%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH*2)+x;
    const int tOffset1=(((y+1)%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH)+x;
    const int aOffset1=(((y+1)%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    uint8_t *tP1=tileLayer[layerIX].tileMap+tOffset1;
    uint8_t *aP1=tileLayer[layerIX].attrMap+aOffset1;
    while(*s){
        if(*s>='0' && *s<=']'){
            *tP=(*s)+80;
            *tP1=(*s)+80+48;
            if(*s!=32){
                *aP=colors[0];
                *(aP+TILE_LAYER_WIDTH)=colors[1];
                *aP1=colors[2];
                *(aP1+TILE_LAYER_WIDTH)=colors[3];
            }else{
                *aP=0x80;
                *(aP+TILE_LAYER_WIDTH)=0x80;
                *aP1=0x80;
                *(aP1+TILE_LAYER_WIDTH)=0x80;
            }
        }
        ++tP;
        ++aP;
        ++tP1;
        ++aP1;
        ++s;
    }
}

// ---------------------------------------------------------------------------
// Mode 7 test scene
// ---------------------------------------------------------------------------

#define MODE7_HORIZON       56          // Screen line of the horizon
#define MODE7_FOCAL         128.0f      // Projection distance (~90 degree field of view)
#define MODE7_VIEW_DIST     1500.0f     // Floor further away than this is not drawn (it's just noise), the sky shows instead
#define MODE7_SKY_V         180         // Row of the background bitmap shown at the top of the screen
#define MODE7_HUD_LAYER     0
#define MODE7_FLOOR_LAYER   3
#define MODE7_SKY_LAYER     4
#define MODE7_TWO_PI        6.2831853f

// The floor tiles are built in RAM, as rotated layers read tile data in a scattered order, which is quicker
// from SRAM than through the flash cache
static uint8_t mode7Tiles[256*8*2];
static LayerLineTransform mode7FloorLines[SCREEN_HEIGHT_LINES];
static LayerLineTransform mode7SkyLines[SCREEN_HEIGHT_LINES];
static float mode7CamX, mode7CamY, mode7Angle, mode7Speed, mode7Height, mode7Bank;
static int mode7Frame;

static void buildMode7Floor(void)
{
    // Tiles: 0 transparent, 1 solid ink, 2 kerb checker, 3 vertical dash, 4 horizontal dash, 5 solid paper
    uint8_t *mask=mode7Tiles+(256*8);
    memset(mode7Tiles,0,sizeof(mode7Tiles));
    for(int r=0;r<8;r++){
        mask[r]=0xff;
        mode7Tiles[(1*8)+r]=0xff;
        mode7Tiles[(2*8)+r]=(r&2)?0x33:0xcc;
        mode7Tiles[(3*8)+r]=(r<4)?0x18:0x00;
        mode7Tiles[(4*8)+r]=(r==3 || r==4)?0xf0:0x00;
    }
    setTileDefSet(MODE7_FLOOR_LAYER,mode7Tiles);

    // Grass in two shades of green, with a grid of roads every 16 tiles (the map wraps, so the grid is endless)
    for(int y=0;y<TILE_LAYER_HEIGHT;y++){
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            const int rx=x&15, ry=y&15;
            const bool onV=(rx>=6 && rx<=8);
            const bool onH=(ry>=6 && ry<=8);
            uint8_t tile, attr;
            if(onV && onH){
                tile=5;
                attr=0x47;
            }else if(onV){
                tile=(rx==7)?3:2;
                attr=(rx==7)?0x47:0x7a;
            }else if(onH){
                tile=(ry==7)?4:2;
                attr=(ry==7)?0x47:0x7a;
            }else{
                tile=1;
                attr=(((x>>2)+(y>>2))&1)?0x44:0x04;
            }
            setLayerTile(MODE7_FLOOR_LAYER,tile,attr,attr,x,y);
        }
    }
}

static void updateMode7View(void)
{
    buildLayerPerspective(mode7FloorLines,mode7CamX,mode7CamY,mode7Angle,mode7Height,MODE7_HORIZON,MODE7_FOCAL);

    // Leave out the far distance, and let the sky continue down to meet the floor
    int floorStart=MODE7_HORIZON+(int)ceilf((mode7Height*MODE7_FOCAL)/MODE7_VIEW_DIST);
    if(floorStart>SCREEN_HEIGHT_LINES){
        floorStart=SCREEN_HEIGHT_LINES;
    }
    for(int y=0;y<floorStart;y++){
        mode7FloorLines[y].enabled=0;
    }

    // The sky pans with the heading - one full turn scrolls exactly one bitmap width, so it wraps seamlessly
    const float skyU=(mode7Angle/MODE7_TWO_PI)*512.0f;
    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        LayerLineTransform *l=mode7SkyLines+y;
        l->u=FIXED16(skyU+0.5f);
        l->v=FIXED16((float)(y+MODE7_SKY_V)+0.5f);
        l->dudx=FIXED16_ONE;
        l->dvdx=0;
        l->enabled=(y<floorStart)?1:0;
    }
}

void setupMode7Test(void)
{
    initLayers();

    // Sky - uses a line table too, so it wraps as it pans, and isn't drawn under the floor
    setLayerType(MODE7_SKY_LAYER,LT_BITMAP_WRAP);
    setLayerBitmap(MODE7_SKY_LAYER,gameBackground0Bitmap,NULL);
    setLayerLineTransforms(MODE7_SKY_LAYER,mode7SkyLines);

    buildMode7Floor();
    setLayerLineTransforms(MODE7_FLOOR_LAYER,mode7FloorLines);

    // Controls help, over everything else
    setTileDefSet(MODE7_HUD_LAYER,defaultTileDef);
    setLayerPos(MODE7_HUD_LAYER,0,0);
    drawTxtToLayer(MODE7_HUD_LAYER,"O/P TURN Q/A SPEED W/S HEIGHT",0x45,0x47,1,22);
    drawTxtToLayer(MODE7_HUD_LAYER,"SPACE: TITLE",0x45,0x47,10,23);

    // Sprite 0 - player, banks when turning (rotation). Sprite 1 - spinning, pulsing letter (rotation and scale)
    initSprites(2);
    setSpriteSize(0,SIZE_24X24);
    setSpriteDef(0,sprite24x24Def,mask24x24Def);
    setSpritePalette(0,1);
    setSpriteLayer(0,1);
    setSpritePos(0,128,150);
    setSpriteScale(0,1.5f,1.5f);

    setSpriteSize(1,SIZE_32X40);
    setSpriteDef(1,titleLettersDef,titleLettersMaskDef);
    setSpritePalette(1,4);
    setSpriteLayer(1,1);
    setSpritePos(1,208,26);

    // Start driving along a road
    mode7CamX=(7*8)+4+256;
    mode7CamY=256.0f;
    mode7Angle=0.0f;
    mode7Speed=2.0f;
    mode7Height=24.0f;
    mode7Bank=0.0f;
    mode7Frame=0;
    updateMode7View();
}

void mode7Test(void)
{
    if(keyDown(KEY_SPACE)){
        setState(GS_title);
        return;
    }

    float turn=0.0f;
    if(keyDown(KEY_O)){
        turn=-0.05f;
    }
    if(keyDown(KEY_P)){
        turn=0.05f;
    }
    mode7Angle+=turn;
    if(mode7Angle>=MODE7_TWO_PI){
        mode7Angle-=MODE7_TWO_PI;
    }else if(mode7Angle<0.0f){
        mode7Angle+=MODE7_TWO_PI;
    }
    if(keyDown(KEY_Q) && mode7Speed<6.0f){
        mode7Speed+=0.2f;
    }
    if(keyDown(KEY_A) && mode7Speed>-3.0f){
        mode7Speed-=0.2f;
    }
    if(keyDown(KEY_W) && mode7Height<80.0f){
        mode7Height+=1.0f;
    }
    if(keyDown(KEY_S) && mode7Height>8.0f){
        mode7Height-=1.0f;
    }

    // Move forwards along the heading, keeping the camera within the (wrapping) 512x512 map
    mode7CamX+=sinf(mode7Angle)*mode7Speed;
    mode7CamY-=cosf(mode7Angle)*mode7Speed;
    mode7CamX=fmodf(mode7CamX,512.0f);
    mode7CamY=fmodf(mode7CamY,512.0f);
    if(mode7CamX<0.0f){
        mode7CamX+=512.0f;
    }
    if(mode7CamY<0.0f){
        mode7CamY+=512.0f;
    }
    updateMode7View();

    // Bank the player into turns, easing back when not turning
    mode7Bank+=((turn*6.0f)-mode7Bank)*0.2f;
    setSpriteRotation(0,mode7Bank);

    // Spin and pulse the letter, changing letter every couple of seconds
    ++mode7Frame;
    spriteList[1].frame=(mode7Frame/50)%10;
    const float pulse=0.8f+(0.3f*sinf((float)mode7Frame*0.1f));
    setSpriteScale(1,pulse,pulse);
    setSpriteRotation(1,(float)mode7Frame*0.08f);
}

// ---------------------------------------------------------------------------
// Audio test - a single note, a chord, a low note, then a short 3 part tune
// ---------------------------------------------------------------------------

typedef struct AudioTestStep {
    // MIDI notes for each voice (0 = silent): melody, bass, harmony
    uint8_t notes[SYNTH_VOICES];
    // Length in frames (25 per second)
    uint8_t frames;
    // Shown while this step plays (NULL keeps the previous label)
    const char *label;
} AudioTestStep;

#define AT_BEAT 10
static const AudioTestStep audioTestSteps[]={
    {{69,0,0},25,"SINGLE NOTE: A4 440HZ"},
    {{0,0,0},10,NULL},
    {{60,64,67},25,"CHORD: C MAJOR"},
    {{0,0,0},10,NULL},
    {{48,0,0},25,"LOW NOTE: C3 131HZ"},
    {{0,0,0},10,NULL},
    // Twinkle Twinkle Little Star (traditional) - melody, bass and harmony
    {{72,48,64},AT_BEAT,"TUNE: 3 VOICES"},
    {{72,48,64},AT_BEAT,NULL},
    {{79,48,64},AT_BEAT,NULL},
    {{79,48,64},AT_BEAT,NULL},
    {{81,53,65},AT_BEAT,NULL},
    {{81,53,65},AT_BEAT,NULL},
    {{79,48,64},AT_BEAT*2,NULL},
    {{77,53,65},AT_BEAT,NULL},
    {{77,53,65},AT_BEAT,NULL},
    {{76,48,64},AT_BEAT,NULL},
    {{76,48,64},AT_BEAT,NULL},
    {{74,43,62},AT_BEAT,NULL},
    {{74,43,62},AT_BEAT,NULL},
    {{72,48,64},AT_BEAT*2,NULL},
    {{0,0,0},AT_BEAT*2,NULL},
};
#define AT_NUM_STEPS ((int)(sizeof(audioTestSteps)/sizeof(audioTestSteps[0])))

static int audioTestStepIX;
static int audioTestFrame;

static void startAudioTestStep(void)
{
    const AudioTestStep *st=audioTestSteps+audioTestStepIX;
    for(int v=0;v<SYNTH_VOICES;v++){
        synthSetNote(v,st->notes[v]);
    }
    if(st->label){
        clearLayerLines(0,11,1);
        const int len=(int)strlen(st->label);
        drawTxtToLayer(0,st->label,0x45,0x45,(SCREEN_WIDTH_CELLS-len)/2,11);
    }
}

void setupAudioTest(void)
{
    initLayers();
    initSprites(0);
    setTileDefSet(0,defaultTileDef);
    setLayerPos(0,0,0);
    drawTxtToLayer(0,"BEEPER AUDIO TEST",0x46,0x46,7,3);
    drawTxtToLayer(0,"3 VOICES, EXISTING OUT LISTS",0x47,0x47,2,5);
    drawTxtToLayer(0,"SPACE: TITLE",0x45,0x47,10,21);

    synthInit();
    audioTestStepIX=0;
    audioTestFrame=0;
    startAudioTestStep();
}

void audioTest(void)
{
    if(keyDown(KEY_SPACE)){
        // Silence every bank, otherwise the last frame's audio keeps playing
        synthInit();
        clearAudioAllBanks();
        setState(GS_title);
        return;
    }

    // Release the melody for the last frame of each step, so repeated notes are heard separately
    const AudioTestStep *st=audioTestSteps+audioTestStepIX;
    if(audioTestFrame==st->frames-1){
        synthSetNote(0,0);
    }
    synthRender();

    if(++audioTestFrame>=st->frames){
        audioTestFrame=0;
        if(++audioTestStepIX==AT_NUM_STEPS){
            audioTestStepIX=0;
        }
        startAudioTestStep();
    }
}

// ---------------------------------------------------------------------------
// Collision test - particles bouncing off a tile layer, and a player sprite showing what it collides with
// ---------------------------------------------------------------------------

#define CT_LAYER        1       // The tile layer - the particles and sprites are drawn over it, so collide with it
#define CT_HUD_LAYER    0       // Text, drawn in front of everything (nothing collides with it)
#define CT_BG_LAYER     4       // Scrolling background bitmap, behind everything
#define CT_BUBBLES      3       // Bubbles and particles emitted per frame - doubled with N
#define CT_EMIT         2
#define CT_PARTICLES    600     // Enough for the doubled fountain
#define CT_LETTERS      (1+(CT_BUBBLES*2))  // First of two letter sprites standing in the tile layer's world

static uint8_t collisionTestTiles[256*8*2];
static int ctParticleSet=-1;
static float ctBubbleDX[(CT_BUBBLES*2)+1];
static float ctBubbleDY[(CT_BUBBLES*2)+1];
// B toggles the background, N doubles the particles and bubbles, R swings the tile layer back and forth - to see the
// effect, and compare performance
static bool ctBackground, ctDouble, ctRotate, ctPrevB, ctPrevN, ctPrevR, ctPrevL;
static int ctScroll, ctSwing;
// Measured frame rate: game frames per displayed Z80 frame (below 25 when frames take too long, on the hardware)
static uint32_t ctFpsMark, ctFpsFrames, ctFps;

static void ctShowBubbles(void)
{
    const int active=ctDouble?CT_BUBBLES*2:CT_BUBBLES;
    for(int n=1;n<=CT_BUBBLES*2;n++){
        if(n<=active){
            if(spriteList[n].collideWith==COLLIDE_NONE){
                setSpritePos(n,(float)(40+(n*30)),(float)(40+((n*23)%100)));
                setSpriteCollisions(n,COLLIDE_TARGET);
            }
        }else{
            setSpritePos(n,300,300);
            setSpriteCollisions(n,COLLIDE_NONE);
        }
    }
}

static void ctTile(int tile, int x, int y, uint8_t attr)
{
    setLayerTile(CT_LAYER,(uint8_t)tile,attr,attr,x,y);
}

static void buildCollisionTestLayer(void)
{
    // Tiles: 1 solid, 2 slope rising to the right, 3 slope rising to the left, 4 bump - masked so only their pixels show
    static const uint8_t bump[8]={0x00,0x18,0x3c,0x7e,0xff,0xff,0xff,0xff};
    uint8_t *mask=collisionTestTiles+(256*8);
    memset(collisionTestTiles,0,256*8);
    memset(mask,0xff,256*8);
    for(int r=0;r<8;r++){
        collisionTestTiles[(1*8)+r]=0xff;
        collisionTestTiles[(2*8)+r]=(uint8_t)((1u<<(r+1))-1);
        collisionTestTiles[(3*8)+r]=(uint8_t)(0xff<<(7-r));
        collisionTestTiles[(4*8)+r]=bump[r];
    }
    for(int n=8;n<5*8;n++){
        mask[n]=(uint8_t)~collisionTestTiles[n];
    }
    setTileDefSet(CT_LAYER,collisionTestTiles);
    setLayerPos(CT_LAYER,0,0);

    const uint8_t ground=0x44, wall=0x42, ramp=0x46, bumps=0x45;
    // Floor (right across the tile map, so there's no gap at its ends when the layer is rotated) and side walls
    for(int x=0;x<TILE_LAYER_WIDTH;x++){
        for(int y=21;y<SCREEN_HEIGHT_CELLS;y++){
            ctTile(1,x,y,ground);
        }
    }
    for(int y=3;y<21;y++){
        ctTile(1,0,y,wall);
        ctTile(1,31,y,wall);
    }
    // A platform with ramps at each end
    ctTile(2,3,14,ramp);
    for(int x=4;x<11;x++){
        ctTile(1,x,14,ground);
    }
    ctTile(3,11,14,ramp);
    // A bumpy platform
    for(int x=18;x<27;x++){
        ctTile(4,x,9,bumps);
    }
    // A hill, and some steps
    ctTile(2,13,20,ramp);
    ctTile(1,14,20,ground);
    ctTile(1,15,20,ground);
    ctTile(3,16,20,ramp);
    for(int s=0;s<3;s++){
        for(int y=20-s;y<21;y++){
            ctTile(1,26+s,y,ground);
        }
    }
}

void setupCollisionTest(void)
{
    initLayers();
    buildCollisionTestLayer();

    setTileDefSet(CT_HUD_LAYER,defaultTileDef);
    setLayerPos(CT_HUD_LAYER,0,0);
    drawTxtToLayer(CT_HUD_LAYER,"B:BG N:X2 R:ROT L:LAYER SPC:EXIT",0x45,0x45,0,1);

    // Scrolling background, behind the tiles (bitmap layers don't collide)
    setLayerType(CT_BG_LAYER,LT_BITMAP);
    setLayerBitmap(CT_BG_LAYER,gameBackground0Bitmap,NULL);
    ctBackground=true;
    ctDouble=true;
    ctRotate=true;
    ctPrevB=false;
    ctPrevN=false;
    ctPrevR=false;
    ctPrevL=false;
    ctScroll=0;
    ctSwing=0;
    ctFpsMark=frameDisplayed;
    ctFpsFrames=0;
    ctFps=25;

    // Player - collides with sprites and the tile layer it's drawn over
    initSprites(CT_LETTERS+2);
    setSpriteSize(0,SIZE_24X24);
    setSpriteDef(0,sprite24x24Def,mask24x24Def);
    setSpritePalette(0,1);
    setSpriteLayer(0,CT_LAYER);
    setSpritePos(0,60,60);
    setSpriteCollisions(0,COLLIDE_SPRITES|COLLIDE_LAYER);

    // Bubbles - targets the player can hit, but they don't check for collisions themselves (the second half only when
    // doubled)
    for(int n=1;n<=CT_BUBBLES*2;n++){
        setSpriteSize(n,SIZE_24X24);
        setSpriteDef(n,spriteBubbleDef,spriteBubbleMaskDef);
        setSpritePalette(n,2);
        setSpriteLayer(n,CT_LAYER);
        spriteList[n].frame=(int16_t)(n%3);
        setSpriteCollisions(n,COLLIDE_NONE);
        ctBubbleDX[n]=(n&1)?1.3f:-1.1f;
        ctBubbleDY[n]=(n&2)?0.9f:-0.7f;
    }
    ctShowBubbles();

    // Two letters standing in the tile layer's world (layer space), so they move with it as it swings: the E on the
    // platform turns with the layer, the R on the floor stays upright. They're scenery, so have no collision flags
    for(int n=0;n<2;n++){
        const int ix=CT_LETTERS+n;
        setSpriteSize(ix,SIZE_32X40);
        setSpriteDef(ix,titleLettersDef,titleLettersMaskDef);
        setSpritePalette(ix,2);
        setSpriteLayer(ix,CT_LAYER);
        spriteList[ix].frame=(int16_t)(n?2:0);
        setSpriteSpace(ix,SPRITE_SPACE_LAYER,-1);
        setSpriteRotateWithLayer(ix,n==0);
        setSpritePos(ix,n?180.0f:60.0f,n?148.0f:92.0f);
    }

    // Particles bouncing off the tile layer
    deleteParticleSets();
    ctParticleSet=createParticleSet(CT_PARTICLES,CT_LAYER);
    setParticleSetGravity(ctParticleSet,0.12f);
    setParticleSetCollisions(ctParticleSet,true);
    setParticleSetBounce(ctParticleSet,0.7f);
    // The particles live in the tile layer's world, so they turn with it (L switches to screen space, to compare)
    setParticleSetSpace(ctParticleSet,PARTICLE_SPACE_LAYER);
}

void collisionTest(void)
{
    if(keyDown(KEY_SPACE)){
        deleteParticleSets();
        ctParticleSet=-1;
        setState(GS_title);
        return;
    }

    // B toggles the background, N the doubled particles and bubbles, R the swinging tile layer (on each key press)
    const bool bDown=keyDown(KEY_B)!=0;
    const bool nDown=keyDown(KEY_N)!=0;
    const bool rDown=keyDown(KEY_R)!=0;
    const bool lDown=keyDown(KEY_L)!=0;
    if(lDown && !ctPrevL){
        const bool inLayer=(particleSets[ctParticleSet].space==PARTICLE_SPACE_LAYER);
        setParticleSetSpace(ctParticleSet,inLayer?PARTICLE_SPACE_SCREEN:PARTICLE_SPACE_LAYER);
    }
    ctPrevL=lDown;
    if(bDown && !ctPrevB){
        ctBackground=!ctBackground;
    }
    if(nDown && !ctPrevN){
        ctDouble=!ctDouble;
        ctShowBubbles();
    }
    if(rDown && !ctPrevR){
        ctRotate=!ctRotate;
    }
    ctPrevB=bDown;
    ctPrevN=nDown;
    ctPrevR=rDown;

    // The tile layer swings smoothly between -30 and 30 degrees, around the screen centre. Particles resting on it are
    // pushed and carried by it, and the sprites' tile collisions follow it too
    if(ctRotate){
        const float maxAngle=30.0f*(float)M_PI/180.0f;
        setLayerTransform(CT_LAYER,maxAngle*sinf((float)ctSwing*0.025f),1.0f,1.0f);
        ++ctSwing;
    }else{
        clearLayerTransform(CT_LAYER);
    }

    // Background drifts around, as on the story screen (or off screen, so it isn't drawn)
    if(ctBackground){
        setLayerPos(CT_BG_LAYER,(int)(sinf((float)ctScroll/137.0f)*100.0f)-128,(int)(sinf((float)ctScroll/159.0f)*100.0f)-92);
        ctScroll+=3;
    }else{
        setLayerPos(CT_BG_LAYER,400,0);
    }

    // Frame rate and time taken, measured on the hardware (on the PC, the time is PC time, and it's always 25fps)
    ++ctFpsFrames;
    const uint32_t displayed=frameDisplayed-ctFpsMark;
    if(displayed>=25){
        ctFps=(ctFpsFrames*25)/displayed;
        ctFpsMark=frameDisplayed;
        ctFpsFrames=0;
    }
    char status[40];
    snprintf(status,sizeof(status),"B:%d N:%d R:%d L:%d CPU:%3u%% FPS:%2u",ctBackground?1:0,ctDouble?2:1,ctRotate?1:0,
        (particleSets[ctParticleSet].space==PARTICLE_SPACE_LAYER)?1:0,(unsigned)(gv.frameTimeUs/400),(unsigned)ctFps);
    drawTxtToLayer(CT_HUD_LAYER,status,0x47,0x47,0,2);

    // Fountain
    for(int n=0;n<(ctDouble?CT_EMIT*2:CT_EMIT);n++){
        float x=126.0f, y=28.0f;
        float dx=((float)(rand()%240)-120.0f)/100.0f;
        float dy=-1.5f-((float)(rand()%150)/100.0f);
        if(particleSets[ctParticleSet].space==PARTICLE_SPACE_LAYER){
            // The fountain stays put on screen - convert its position (the particle's centre) and velocity to the layer
            float u, v;
            screenToLayer(CT_LAYER,x+2.0f,y+2.0f,&u,&v);
            x=u-2.0f;
            y=v-2.0f;
            screenToLayerVector(CT_LAYER,dx,dy,&dx,&dy);
        }
        emitParticle(ctParticleSet,x,y,dx,dy,250+(rand()%100));
    }

    // Player - these are the collisions found when the last frame was drawn
    Sprite *player=spriteList;
    setSpritePalette(0,(player->spriteHitCount || player->tileHitCount)?3:1);
    // Points around the player: the tile just under its feet, and whether there's anything solid just to its left and
    // right - these follow the layer however it's rotated (-1 = off screen)
    const int feetTile=getLayerTileNumberAt(CT_LAYER,player->x,player->y+(player->height/2),NULL,NULL);
    const bool wallLeft=isLayerPixelSetAt(CT_LAYER,player->x-(player->width/2)-1,player->y);
    const bool wallRight=isLayerPixelSetAt(CT_LAYER,player->x+(player->width/2),player->y);
    char txt[40];
    snprintf(txt,sizeof(txt),"SPR:%d TILES:%2d FEET:%3d L:%d R:%d",player->spriteHitCount,player->tileHitCount,feetTile,
        wallLeft?1:0,wallRight?1:0);
    drawTxtToLayer(CT_HUD_LAYER,txt,0x46,0x46,0,0);

    // Move a pixel at a time (2 a frame), only if the point just beyond the player's edge in that direction isn't
    // solid - so it stops at floors and walls, even as the layer rotates
    int px=player->x, py=player->y;
    const int halfW=player->width/2, halfH=player->height/2;
    for(int step=0;step<2;step++){
        if(keyDown(KEY_O) && !isLayerPixelSetAt(CT_LAYER,px-halfW-1,py)){
            --px;
        }
        if(keyDown(KEY_P) && !isLayerPixelSetAt(CT_LAYER,px+halfW,py)){
            ++px;
        }
        if(keyDown(KEY_Q) && !isLayerPixelSetAt(CT_LAYER,px,py-halfH-1)){
            --py;
        }
        if(keyDown(KEY_A) && !isLayerPixelSetAt(CT_LAYER,px,py+halfH)){
            ++py;
        }
    }
    setSpritePos(0,(float)px,(float)py);

    // Bubbles drift around, bouncing off the screen edges
    for(int n=1;n<=(ctDouble?CT_BUBBLES*2:CT_BUBBLES);n++){
        Sprite *b=spriteList+n;
        float bx=b->xF+ctBubbleDX[n];
        float by=b->yF+ctBubbleDY[n];
        if(bx<20.0f || bx>236.0f){
            ctBubbleDX[n]=-ctBubbleDX[n];
        }
        if(by<36.0f || by>156.0f){
            ctBubbleDY[n]=-ctBubbleDY[n];
        }
        setSpritePos(n,bx,by);
        // Bubbles flash red while the player is touching them (targets keep no hit lists, so look in the player's)
        bool hitByPlayer=false;
        for(int h=0;h<player->spriteHitCount;h++){
            hitByPlayer|=(player->spriteHits[h]==n);
        }
        setSpritePalette(n,hitByPlayer?3:2);
    }
}
// ---------------------------------------------------------------------------
// Level test - the demo level made in Tiled (levels/tiled/demo.tmx, converted to levels/level_demo.c): a player who
// runs, jumps and collects coins, walking behind pillars (the level's foreground layer), over parallax hills and sky
// ---------------------------------------------------------------------------

#define LV_LAYER        2       // The level layer the player is in - its foreground tiles are on layer 1
#define LV_HUD_LAYER    0       // Text, in front of everything (the level uses layers 1-4)
#define LV_SPRITES      40      // Sprites for the player, the actors near the camera and bubbles

// The player's (and the enemies') hitbox, around its position (the sprite's centre): the part of the 24x24 graphic the
// character fills
#define LV_LEFT         8       // Pixels left of the centre
#define LV_RIGHT        7       // ...right
#define LV_TOP          11      // ...above
#define LV_BOTTOM       10      // ...below (the feet)

// Movement, in pixels per frame. On the ground, speed is along the level; in the air, velocity is on screen, so a jump
// goes up the screen whichever way the level is tilted
#define LV_WALK         1.25f   // Speed on first moving
#define LV_ACCEL        0.06f   // Build up to...
#define LV_RUN          3.25f   // ...the top speed, the longer the player runs
#define LV_FRICTION     0.12f   // Slowing down, when nothing's pressed
#define LV_SKID         0.30f   // Slowing down, when pushing the other way
#define LV_AIR_CONTROL  0.16f   // Steering in the air
#define LV_GRAVITY      0.32f
#define LV_MAX_FALL     6.0f
#define LV_JUMP         5.4f
#define LV_STOMP        4.0f    // Bounce off an enemy stomped on
#define LV_CLIMB        2       // Steepest slope climbed: pixels up for each pixel across
#define LV_CONVEYOR     1.0f    // Pixels a frame a conveyor carries the player along
#define LV_SPRING       8.0f    // A springboard's bounce...
#define LV_SPRING_HIGH  10.5f   // ...holding jump
#define LV_SPRING_SQUASH 8      // Frames a springboard shows squashed after a bounce
#define LV_SHIP_ACCEL   0.35f   // Shooter levels: the player flies - speeding up the way pushed...
#define LV_SHIP_DRAG    0.90f   // ...slowing down (each frame's speed is multiplied by this)...
#define LV_SHIP_MAX     3.0f    // ...up to this, across and up or down
#define LV_TITLE_TIME   100     // Frames the level's name, then its description, show on entering it
#define LV_MAX_BULLETS  6       // Shooter levels: bullets flying at once...
#define LV_BULLET_SPEED 6.0f    // ...their speed, on top of the player's...
#define LV_FIRE_DELAY   7       // ...frames between shots, holding fire (M)...
#define LV_BULLET_RANGE 220     // ...and how far ahead of the player they go
#define LV_SPARKS       400     // Particles for explosions
#define LV_FLYER_GONE   360     // Flyers this far across from the player have flown past, and are gone
#define LV_MAX_SHOTS    16      // Enemy shots flying at once...
#define LV_SHOT_LIFE    150     // ...and the frames each lasts
#define LV_SHOT_RANGE   140     // Flyers only shoot at a player this close across (about on screen)
#define LV_TURRET_ARC   1.4f    // A turret's gun turns this far (radians) either side of straight out of its floor or roof
#define LV_LAUNCH_TURN  0.08f   // How quickly a launched mine turns towards the player
#define LV_LAUNCHED     3       // (a launch pattern flyer's state once it's launched: 1 is waiting)

// Sprite frames: 0-7 face left, 8-15 right. Each 8 is a run cycle; frame 3 has the feet together (standing)
#define LV_FRAMES_RIGHT 8
#define LV_FRAME_STAND  3
#define LV_FRAME_JUMP   4
#define LV_FRAME_SKID   0
#define LV_STRIDE       5.0f    // Pixels run per frame of the cycle

// Palettes: the player, bubbles
#define LV_PALETTE      5
#define LV_SHIP_PALETTE 2       // ...white on black, flying in shooter levels
#define LV_BUBBLE_PAL   8

// Enemy AI states
#define LV_PATROL       0
#define LV_CHASE        1

// Bubbles from generators (sprites the game makes itself - they aren't level objects)
#define LV_MAX_BUBBLES  12
#define LV_BUBBLE_LIFE  220

typedef struct LvBubble {
    int16_t sprite;             // -1 if not in use
    int16_t generator;          // The generator object it came from
    int16_t age;
    float baseX, y, rise;
} LvBubble;

static int lvX, lvY;                    // Position in level pixels
static float lvFracX, lvFracY;          // ...and the fraction of a pixel moved towards the next
static float lvSpeed;                   // On the ground: speed along the level (+ is right)
static float lvVX, lvVY;                // In the air: velocity on screen
static bool lvOnGround, lvSkidding, lvRotate, lvPrevR, lvPrevQ, lvLoaded;
static int lvFacing, lvCoins, lvLost, lvSwing, lvStomped, lvPopped, lvPlayer, lvStartX, lvStartY;
static float lvStride, lvCamX, lvCamY;
// Frames left of not being hurt after losing a life (the player flashes)
static int lvSafe;
#define LV_SAFE_TIME    50
static int lvEnemies, lvPlatforms, lvBubbles, lvPistons, lvDoors;  // Sprite sets (pistons and doors are solid)

// The level's tiles are 8x8 (shift 3) or 16x16 (shift 4): a level pixel position >> lvTileShift is its tile position
static int lvTileShift=3;

// Set by the switch handler (as switches change, and when entering a level with them on)
static bool lvPistonsStopped, lvLiftCalled;
// Keys the player carries (a bit per SwitchId - a key opens doors with the same value), and the use key (A)
static uint32_t lvKeys;
static bool lvPrevA;
// The springboard showing squashed (its tile position, and its own tile to put back), and for how many more frames
static int lvSpringX, lvSpringY, lvSpringTile, lvSpringTimer;
// Frames since entering the level (for showing its name and description), and what the HUD's second line shows
static int lvTitleTimer, lvHudLine=-1;
// The player's bullets (sprites, in the bullets set), the explosions' particle set, and frames until the next shot
typedef struct LvBullet {
    int16_t sprite;
    int8_t dir;
    float x, y;
} LvBullet;
static LvBullet lvBulletList[LV_MAX_BULLETS];
static int lvBullets=-1, lvSparks=-1, lvFireTimer;
// The enemies' shots (sprites), moving in a straight line
typedef struct LvShot {
    int16_t sprite;
    int16_t age;
    float x, y, vx, vy;
} LvShot;
static LvShot lvShotList[LV_MAX_SHOTS];
static void lvFreeShots(void);
// An exit used this frame: the level and entrance to go to
static int lvGoLevel=-1;
static const char *lvGoEntrance;

// Doors (gate doors and doors to other levels) play their frames when opening: the actor's state while they do, and
// frames each is shown for
#define LV_DOOR_SHUT        0
#define LV_DOOR_OPENING     1
#define LV_DOOR_TICKS       5
// The door to another level the player's going through (it opens, then they go), or -1
static int lvLeaving=-1;

// Piston states (in the actor's state), and a piston head's box in level pixels (inclusive)
#define LV_PISTON_IN        0   // Waiting, pulled in
#define LV_PISTON_OUT       1   // Pushing out - its front crushes
#define LV_PISTON_WAIT_OUT  2
#define LV_PISTON_BACK      3   // Pulling back in

typedef struct LvBox {
    int x0, y0, x1, y1;
} LvBox;

static LvBox lvBoxOf(int obj)
{
    const LevelActor *a=getLevelActor(obj);
    const LevelObject *o=getLevelObject(obj);
    LvBox b;
    b.x0=(int)floorf(a->x)-(o->width/2);
    b.y0=(int)floorf(a->y)-(o->height/2);
    b.x1=b.x0+o->width-1;
    b.y1=b.y0+o->height-1;
    return b;
}

static LvBubble lvBubbleList[LV_MAX_BUBBLES];

// Solid pixels in a column of the hitbox (at level x cx), or a row (at level y cy) - every pixel, so nothing slips
// between the checks - and solid sprites (piston heads, closed doors) in the way
static bool lvColumnBlocked(int cx, int y)
{
    for(int py=y-LV_TOP;py<=y+LV_BOTTOM;py++){
        if(isLevelPixelSolid(LV_LAYER,cx,py)){
            return true;
        }
    }
    return getSolidSpriteAt(LV_LAYER,cx,y-LV_TOP,cx,y+LV_BOTTOM)>=0;
}

static bool lvRowBlocked(int x, int cy)
{
    for(int px=x-LV_LEFT;px<=x+LV_RIGHT;px++){
        if(isLevelPixelSolid(LV_LAYER,px,cy)){
            return true;
        }
    }
    return getSolidSpriteAt(LV_LAYER,x-LV_LEFT,cy,x+LV_RIGHT,cy)>=0;
}

// (the player and enemies are stopped by the same things)
#define lvPlayerColumnBlocked lvColumnBlocked
#define lvPlayerRowBlocked lvRowBlocked

// Level ground just under the feet: solid, or the top pixel of a one way platform tile
static bool lvOnLevelGround(int x, int y)
{
    const int fy=y+LV_BOTTOM+1;
    for(int px=x-LV_LEFT;px<=x+LV_RIGHT;px++){
        if(isLevelPixelSolid(LV_LAYER,px,fy)){
            return true;
        }
        if((getLevelTileFlags(LV_LAYER,px>>lvTileShift,fy>>lvTileShift)&LEVEL_TILE_PLATFORM) && isLevelPixelSet(LV_LAYER,px,fy) &&
            !isLevelPixelSet(LV_LAYER,px,fy-1)){
            return true;
        }
    }
    return false;
}

// The moving platform just under the player's feet (its object), or -1 - looking through the platforms sprite set,
// which only has the platforms near the camera, where the player is. slack lets the platform's top be that many pixels
// above the feet: a rising platform can move up into a falling player between frames, so landing allows for it
static int lvPlatformUnderSlack(int x, int y, int slack)
{
    for(int ix=firstSpriteInSet(lvPlatforms);ix>=0;ix=nextSpriteInSet(ix)){
        const int obj=getSpriteLevelObject(ix);
        const LevelActor *a=getLevelActor(obj);
        const LevelObject *o=getLevelObject(obj);
        if(!a || !o){
            continue;
        }
        const int top=(int)floorf(a->y)-(o->height/2);
        const int left=(int)floorf(a->x)-(o->width/2);
        const int under=y+LV_BOTTOM+1;
        if(under>=top && under<=top+slack && x+LV_RIGHT>=left && x-LV_LEFT<left+o->width){
            return obj;
        }
    }
    return -1;
}

static int lvPlatformUnder(int x, int y)
{
    return lvPlatformUnderSlack(x,y,0);
}

// A platform that moved up through the player's feet this frame (it was below them, now it's at or above them) - a
// rising platform catching the player near the top of a jump, when they're hardly falling. -1 if none
static int lvPlatformRoseInto(int x, int y)
{
    const int under=y+LV_BOTTOM+1;
    for(int ix=firstSpriteInSet(lvPlatforms);ix>=0;ix=nextSpriteInSet(ix)){
        const int obj=getSpriteLevelObject(ix);
        const LevelActor *a=getLevelActor(obj);
        const LevelObject *o=getLevelObject(obj);
        if(!a || !o){
            continue;
        }
        const int top=(int)floorf(a->y)-(o->height/2);
        const int prevTop=(int)floorf(a->y-a->vy)-(o->height/2);
        const int left=(int)floorf(a->x)-(o->width/2);
        if(under<=prevTop && under>=top && x+LV_RIGHT>=left && x-LV_LEFT<left+o->width){
            return obj;
        }
    }
    return -1;
}

// Stand the player on a platform's top
static void lvStandOn(int obj)
{
    lvY=(int)floorf(getLevelActor(obj)->y)-(getLevelObject(obj)->height/2)-LV_BOTTOM-1;
}

static bool lvGrounded(int x, int y)
{
    return lvOnLevelGround(x,y) || lvPlatformUnder(x,y)>=0 ||
        getSolidSpriteAt(LV_LAYER,x-LV_LEFT,y+LV_BOTTOM+1,x+LV_RIGHT,y+LV_BOTTOM+1)>=0;
}

// Move the player a pixel across the level. On the ground, it climbs slopes up to LV_CLIMB pixels high per pixel across
// (if there's head room), and follows the ground down slopes as steep. False if a wall's in the way
static bool lvStepAcross(int dir, bool onGround)
{
    const int cx=(dir>0)?lvX+LV_RIGHT+1:lvX-LV_LEFT-1;
    if(!lvPlayerColumnBlocked(cx,lvY)){
        lvX+=dir;
        if(onGround && !lvGrounded(lvX,lvY)){
            for(int k=1;k<=LV_CLIMB;k++){
                if(lvGrounded(lvX,lvY+k)){
                    lvY+=k;
                    break;
                }
            }
        }
        return true;
    }
    if(onGround){
        for(int k=1;k<=LV_CLIMB;k++){
            if(lvPlayerRowBlocked(lvX,lvY-LV_TOP-k)){
                break;
            }
            if(!lvPlayerColumnBlocked(cx,lvY-k)){
                lvX+=dir;
                lvY-=k;
                return true;
            }
        }
    }
    return false;
}

static void lvRespawn(void)
{
    lvFreeShots();          // (a fresh start: no shots already on their way)
    lvSafe=LV_SAFE_TIME;
    lvX=lvStartX;
    lvY=lvStartY;
    lvFracX=0.0f;
    lvFracY=0.0f;
    lvSpeed=0.0f;
    lvVX=0.0f;
    lvVY=0.0f;
    lvOnGround=false;
    lvSkidding=false;
    lvFacing=1;
}

// Leave the ground: the speed along the level becomes a velocity on screen, plus the jump (straight up the screen)
static void lvTakeOff(float jump)
{
    layerToScreenVector(LV_LAYER,lvSpeed,0.0f,&lvVX,&lvVY);
    lvVY-=jump;
    lvOnGround=false;
    lvSkidding=false;
    lvFracY=0.0f;
}

static void lvRun(int dir)
{
    // Mario style: a walk to start, building up speed the longer it runs one way. Pushing the other way skids, and
    // letting go slides to a stop
    lvSkidding=false;
    if(dir && lvSpeed*(float)dir<0.0f){
        lvSkidding=true;
        lvSpeed+=(float)dir*LV_SKID;
        if(lvSpeed*(float)dir>0.0f){
            lvSpeed=0.0f;
        }
    }else if(dir){
        lvSpeed=(fabsf(lvSpeed)<LV_WALK)?(float)dir*LV_WALK:lvSpeed+((float)dir*LV_ACCEL);
        if(fabsf(lvSpeed)>LV_RUN){
            lvSpeed=(float)dir*LV_RUN;
        }
    }else if(fabsf(lvSpeed)<=LV_FRICTION){
        lvSpeed=0.0f;
    }else{
        lvSpeed-=(lvSpeed>0.0f)?LV_FRICTION:-LV_FRICTION;
    }

    lvFracX+=lvSpeed;
    while(fabsf(lvFracX)>=1.0f){
        const int step=(lvFracX>0.0f)?1:-1;
        if(!lvStepAcross(step,true)){
            lvSpeed=0.0f;
            lvFracX=0.0f;
            break;
        }
        lvFracX-=(float)step;
        lvStride+=1.0f;
    }
    // Ran off an edge
    if(!lvGrounded(lvX,lvY)){
        lvTakeOff(0.0f);
    }
}

// Shooter levels (levelType "shooter" in Tiled): the player flies freely in any direction, with no gravity - moving
// through the level a pixel at a time, stopped by the same walls, floors and ceilings as on foot
static float lvShipAxis(float v, int dir)
{
    v=(v+((float)dir*LV_SHIP_ACCEL))*LV_SHIP_DRAG;
    v=(v>LV_SHIP_MAX)?LV_SHIP_MAX:((v<-LV_SHIP_MAX)?-LV_SHIP_MAX:v);
    return (fabsf(v)<0.05f)?0.0f:v;
}

static void lvShip(int dx, int dy)
{
    lvOnGround=false;
    lvSkidding=false;
    lvVX=lvShipAxis(lvVX,dx);
    lvVY=lvShipAxis(lvVY,dy);
    lvFracX+=lvVX;
    lvFracY+=lvVY;
    while(fabsf(lvFracX)>=1.0f){
        const int step=(lvFracX>0.0f)?1:-1;
        if(!lvStepAcross(step,false)){
            lvFracX=0.0f;
            lvVX=0.0f;
            break;
        }
        lvFracX-=(float)step;
    }
    while(fabsf(lvFracY)>=1.0f){
        const int step=(lvFracY>0.0f)?1:-1;
        if(lvPlayerRowBlocked(lvX,(step<0)?lvY-LV_TOP-1:lvY+LV_BOTTOM+1)){
            lvFracY=0.0f;
            lvVY=0.0f;
            break;
        }
        lvY+=step;
        lvFracY-=(float)step;
    }
}

// The type of the tile under the player's feet (its TileType in Tiled: TILE_TYPE_...), and where it is - the one under
// the middle of the feet first, then either side
static int lvGroundType(int *tileX, int *tileY)
{
    const int ty=(lvY+LV_BOTTOM+1)>>lvTileShift;
    const int xs[3]={lvX,lvX-LV_LEFT,lvX+LV_RIGHT};
    for(int n=0;n<3;n++){
        const int tx=xs[n]>>lvTileShift;
        const int type=LEVEL_TILE_TYPE(getLevelTileFlags(LV_LAYER,tx,ty));
        if(type!=TILE_TYPE_NONE){
            *tileX=tx;
            *tileY=ty;
            return type;
        }
    }
    return TILE_TYPE_NONE;
}

// Put back the springboard showing squashed
static void lvUnsquashSpring(void)
{
    if(lvSpringTimer>0){
        setLevelTile(LV_LAYER,lvSpringX,lvSpringY,(uint8_t)lvSpringTile);
        lvSpringTimer=0;
    }
}

// Bounced up by a springboard (higher holding jump). It shows squashed for a moment: the next tile along in the tile
// set, if that's a springboard too
static void lvSpringBounce(int tileX, int tileY, bool high)
{
    lvTakeOff(high?LV_SPRING_HIGH:LV_SPRING);
    lvUnsquashSpring();
    const int tile=getLevelTile(LV_LAYER,tileX,tileY);
    if(tile<255 && LEVEL_TILE_TYPE(getLevelTileSetFlags(LV_LAYER,(uint8_t)(tile+1)))==TILE_TYPE_SUPER_JUMP){
        lvSpringX=tileX;
        lvSpringY=tileY;
        lvSpringTile=tile;
        lvSpringTimer=LV_SPRING_SQUASH;
        setLevelTile(LV_LAYER,tileX,tileY,(uint8_t)(tile+1));
    }
}

// What the tile under the feet does: conveyors carry the player along (following the ground, stopped by walls),
// springboards bounce them up
static void lvGroundTiles(bool jumpHeld)
{
    if(lvSpringTimer>0 && --lvSpringTimer==0){
        lvSpringTimer=1;
        lvUnsquashSpring();
    }
    int tx, ty;
    const int type=lvOnGround?lvGroundType(&tx,&ty):TILE_TYPE_NONE;
    if(type==TILE_TYPE_CONVEYOR_LEFT || type==TILE_TYPE_CONVEYOR_RIGHT){
        static float carried;
        carried+=(type==TILE_TYPE_CONVEYOR_RIGHT)?LV_CONVEYOR:-LV_CONVEYOR;
        while(fabsf(carried)>=1.0f){
            const int step=(carried>0.0f)?1:-1;
            if(!lvStepAcross(step,true)){
                carried=0.0f;
                break;
            }
            carried-=(float)step;
        }
        // (carried off the end)
        if(!lvGrounded(lvX,lvY)){
            lvTakeOff(0.0f);
        }
    }else if(type==TILE_TYPE_SUPER_JUMP){
        lvSpringBounce(tx,ty,jumpHeld);
    }
}

static void lvFly(int dir)
{
    lvVX+=(float)dir*LV_AIR_CONTROL;
    lvVX=(lvVX>LV_RUN)?LV_RUN:((lvVX<-LV_RUN)?-LV_RUN:lvVX);
    lvVY+=LV_GRAVITY;
    lvVY=(lvVY>LV_MAX_FALL)?LV_MAX_FALL:lvVY;

    // The velocity on screen, in the level's direction (the level may be tilted), a pixel at a time across and down
    float du, dv;
    screenToLayerVector(LV_LAYER,lvVX,lvVY,&du,&dv);

    // Caught by a platform rising into the player (unless they're still jumping up fast, away from it)
    const int caught=(dv>-1.5f)?lvPlatformRoseInto(lvX,lvY):-1;
    if(caught>=0){
        lvStandOn(caught);
        lvOnGround=true;
        lvSpeed=du;
        lvFracY=0.0f;
        return;
    }
    lvFracX+=du;
    lvFracY+=dv;
    while(fabsf(lvFracX)>=1.0f || fabsf(lvFracY)>=1.0f){
        if(fabsf(lvFracX)>=1.0f){
            const int step=(lvFracX>0.0f)?1:-1;
            if(lvStepAcross(step,false)){
                lvFracX-=(float)step;
            }else{
                // Hit a wall: stop moving across the level
                lvFracX=0.0f;
                du=0.0f;
                layerToScreenVector(LV_LAYER,du,dv,&lvVX,&lvVY);
            }
        }
        if(lvFracY>=1.0f){
            const int plat=lvPlatformUnderSlack(lvX,lvY,4);
            if(plat>=0){
                lvStandOn(plat);
            }
            if(plat>=0 || lvGrounded(lvX,lvY)){
                // Landed: carry on at the speed it was moving along the level
                lvOnGround=true;
                lvSpeed=du;
                lvFracY=0.0f;
                return;
            }
            ++lvY;
            lvFracY-=1.0f;
        }else if(lvFracY<=-1.0f){
            if(lvPlayerRowBlocked(lvX,lvY-LV_TOP-1)){
                // Head hit something: stop going up the level
                lvFracY=0.0f;
                dv=0.0f;
                layerToScreenVector(LV_LAYER,du,dv,&lvVX,&lvVY);
            }else{
                --lvY;
                lvFracY+=1.0f;
            }
        }
    }
}

// ---------------------------------------------------------------------------
// Actors - every level object is updated each frame, wherever it is: enemies patrol off screen too. They only react to
// the player when near them
// ---------------------------------------------------------------------------

// Enemies patrol, turning at walls and ledges. One facing the player, close enough and at about the same height, gives
// chase (faster), until the player gets away
static void lvUpdateEnemy(int ix, LevelActor *a)
{
    const float speed=getLevelObjectFloat(ix,LEVEL_PROP_SPEED,0.5f);
    const float chaseSpeed=getLevelObjectFloat(ix,LEVEL_PROP_CHASE_SPEED,1.25f);
    const int range=getLevelObjectInt(ix,LEVEL_PROP_ALERT_RANGE,96);
    const float dx=(float)lvX-a->x, dy=(float)lvY-a->y;
    if(a->state==LV_PATROL){
        if(range>0 && fabsf(dx)<(float)range && fabsf(dy)<24.0f && dx*(float)a->dir>0.0f){
            a->state=LV_CHASE;
        }
    }else if(fabsf(dx)>(float)range*1.5f || fabsf(dy)>48.0f){
        a->state=LV_PATROL;
    }
    if(a->state==LV_CHASE && fabsf(dx)>2.0f){
        a->dir=(dx>0.0f)?1:-1;
    }

    // Fall until on the ground
    int x=(int)floorf(a->x), y=(int)floorf(a->y);
    if(!lvOnLevelGround(x,y)){
        a->vy=(a->vy+LV_GRAVITY>LV_MAX_FALL)?LV_MAX_FALL:a->vy+LV_GRAVITY;
        for(int n=0;n<(int)a->vy && !lvOnLevelGround(x,y);n++){
            ++y;
        }
        a->y=(float)y;
        return;
    }
    a->vy=0.0f;

    // Walk a pixel at a time (vx holds the fraction of a pixel), up and down slopes as the player does. At a wall, or a
    // ledge (the ground drops more than a slope would), a patroller turns and a chaser waits
    a->vx+=(a->state==LV_CHASE)?chaseSpeed:speed;
    while(a->vx>=1.0f){
        a->vx-=1.0f;
        x=(int)floorf(a->x);
        y=(int)floorf(a->y);
        const int nx=x+a->dir;
        const int ahead=(a->dir>0)?nx+LV_RIGHT:nx-LV_LEFT;
        int ny=-1;
        for(int k=0;k<=LV_CLIMB && ny<0;k++){
            if(k>0 && lvRowBlocked(x,y-LV_TOP-k)){
                break;
            }
            if(!lvColumnBlocked(ahead,y-k)){
                ny=y-k;
            }
        }
        if(ny>=0 && !lvOnLevelGround(nx,ny)){
            const int top=ny;
            ny=-1;
            for(int k=1;k<=LV_CLIMB && ny<0;k++){
                ny=lvOnLevelGround(nx,top+k)?top+k:-1;
            }
        }
        if(ny<0){
            if(a->state==LV_PATROL){
                a->dir=(int8_t)-a->dir;
            }
            a->vx=0.0f;
            break;
        }
        a->x=(float)nx;
        a->y=(float)ny;
        a->timer=(int16_t)(a->timer+1);
    }
    const int stride=(a->state==LV_CHASE)?3:6;
    a->frame=(uint8_t)(((a->timer/stride)&7)+((a->dir>0)?LV_FRAMES_RIGHT:0));
}

// Moving platforms go back and forth along their path, waiting a moment at each end, carrying the player. vx/vy are how
// far they moved this frame (to carry the player), angle how far along the path they are, and timer the wait
#define LV_PLATFORM_WAIT 40
static void lvUpdatePlatform(int ix, LevelActor *a)
{
    const int path=getLevelObjectInt(ix,LEVEL_PROP_PATH,-1);
    const float len=getLevelPathLength(path);
    a->vx=0.0f;
    a->vy=0.0f;
    if(len<=0.0f){
        return;
    }
    // Called (the lift plate's on): straight back to the start of its path, and wait there
    if(lvLiftCalled){
        a->timer=0;
        a->dir=-1;
    }
    if(a->timer>0){
        --a->timer;
        return;
    }
    a->angle+=getLevelObjectFloat(ix,LEVEL_PROP_SPEED,0.75f)*(float)a->dir;
    if(a->angle>=len){
        a->angle=len;
        a->dir=-1;
        a->timer=LV_PLATFORM_WAIT;
    }else if(a->angle<=0.0f){
        a->angle=0.0f;
        a->dir=lvLiftCalled?-1:1;
        a->timer=lvLiftCalled?0:LV_PLATFORM_WAIT;
    }
    float x, y;
    getLevelPathPoint(path,a->angle,&x,&y);
    a->vx=x-a->x;
    a->vy=y-a->y;
    a->x=x;
    a->y=y;
}

// Generators make bubbles every so often, up to a limit - only when the player's near (so off screen ones don't use up
// sprites)
static void lvUpdateGenerator(int ix, LevelActor *a)
{
    const LevelObject *o=getLevelObject(ix);
    if(fabsf((float)lvX-a->x)>200.0f || fabsf((float)lvY-a->y)>150.0f){
        return;
    }
    if(++a->timer<getLevelObjectInt(ix,LEVEL_PROP_INTERVAL,40)){
        return;
    }
    a->timer=0;
    int count=0, freeSlot=-1;
    for(int n=0;n<LV_MAX_BUBBLES;n++){
        count+=(lvBubbleList[n].sprite>=0 && lvBubbleList[n].generator==ix)?1:0;
        freeSlot=(lvBubbleList[n].sprite<0 && freeSlot<0)?n:freeSlot;
    }
    if(count>=getLevelObjectInt(ix,LEVEL_PROP_MAX,5) || freeSlot<0){
        return;
    }
    const int s=allocateSprite();
    if(s<0){
        return;
    }
    LvBubble *b=lvBubbleList+freeSlot;
    b->sprite=(int16_t)s;
    b->generator=(int16_t)ix;
    b->age=0;
    b->baseX=a->x+(float)((rand()%(o->width+1))-(o->width/2));
    b->y=a->y;
    b->rise=getLevelObjectFloat(ix,LEVEL_PROP_SPEED,0.6f)*(0.7f+((float)(rand()%60)/100.0f));
    setSpriteSize(s,SIZE_24X24);
    setSpriteDef(s,spriteBubbleDef,spriteBubbleMaskDef);
    setSpritePalette(s,LV_BUBBLE_PAL);
    setSpriteLayer(s,LV_LAYER);
    setSpriteSpace(s,SPRITE_SPACE_LAYER,-1);
    addSpriteToSet(s,lvBubbles);
    setSpriteCollisions(s,COLLIDE_TARGET);
    setSpritePos(s,b->baseX,b->y);
}

static void lvFreeBubble(LvBubble *b)
{
    freeSprite(b->sprite);
    b->sprite=-1;
}

static void lvUpdateBubbles(void)
{
    for(int n=0;n<LV_MAX_BUBBLES;n++){
        LvBubble *b=lvBubbleList+n;
        if(b->sprite<0){
            continue;
        }
        b->y-=b->rise;
        if(++b->age>LV_BUBBLE_LIFE){
            lvFreeBubble(b);
            continue;
        }
        spriteList[b->sprite].frame=(int16_t)((b->age/10)%3);
        setSpritePos(b->sprite,b->baseX+(sinf((float)b->age*0.08f)*6.0f),b->y);
    }
}

// A piston's shaft: solid tiles written into the level behind its head, from where the head starts (pulled in) to
// the head's back edge - two tiles across (shaftTile and shaftTile+1). Only the tiles that change are written, as the
// head crosses into another tile; hp holds how many tiles long the shaft is. The partly filled tile at the head end
// is covered by the head (8 pixels long in the direction it moves). The shaft's path must be empty in the map, as the
// tiles are cleared to 0 as it pulls back
static void lvPistonShaft(int ix, LevelActor *a, const LevelObject *path)
{
    const LevelObject *o=getLevelObject(ix);
    const LevelPoint *p0=path->points, *p1=path->points+(path->pointCount-1);
    const bool vertical=(p0->x==p1->x);
    const int dir=vertical?((p1->y>p0->y)?1:-1):((p1->x>p0->x)?1:-1);
    const int half=(vertical?o->height:o->width)/2;
    const int back0=(vertical?p0->y:p0->x)-(dir*half);
    const int back=(int)floorf(vertical?a->y:a->x)-(dir*half);

    // Whole tiles (of the level's tile size) from the base (where the head starts) to the head
    const int sh=lvTileShift, size=1<<sh;
    int base, n=0;
    if(dir>0){
        base=(back0+size-1)>>sh;
        const int last=(back-1)>>sh;
        n=(back>back0 && last>=base)?last-base+1:0;
    }else{
        base=(back0>>sh)-1;
        const int first=back>>sh;
        n=(back<back0 && base>=first)?base-first+1:0;
    }
    // The shaft is 16 pixels thick: two 8x8 tiles, or one 16x16
    const int shaftTile=getLevelObjectInt(ix,LEVEL_PROP_SHAFT_TILE,34);
    const int thick=16>>sh;
    const int across=((int)floorf(vertical?a->x:a->y)-8)>>sh;
    const int from=(n<a->hp)?n:a->hp, to=(n<a->hp)?a->hp:n;
    for(int k=from;k<to;k++){
        const int along=base+(k*dir);
        for(int j=0;j<thick;j++){
            const uint8_t tile=(uint8_t)((k<n)?shaftTile+j:0);
            if(vertical){
                setLevelTile(LV_LAYER,across+j,along,tile);
            }else{
                setLevelTile(LV_LAYER,along,across+j,tile);
            }
        }
    }
    a->hp=(int16_t)n;
}

// Pistons push out fast along their path, wait, pull back slowly, and wait - starting after their phase, so a row of
// them can fire one after another
static void lvUpdatePiston(int ix, LevelActor *a)
{
    const int path=getLevelObjectInt(ix,LEVEL_PROP_PATH,-1);
    const LevelObject *po=getLevelObject(path);
    const float len=getLevelPathLength(path);
    if(!po || len<=0.0f){
        return;
    }
    // Stopped (the lever's on): pull back in, and stay there
    if(lvPistonsStopped){
        if(a->state!=LV_PISTON_IN){
            a->state=LV_PISTON_BACK;
        }else{
            getLevelPathPoint(path,a->angle,&a->x,&a->y);
            lvPistonShaft(ix,a,po);
            return;
        }
    }
    switch(a->state){
        case LV_PISTON_IN:
            if(--a->timer<=0){
                a->state=LV_PISTON_OUT;
            }
        break;
        case LV_PISTON_OUT:
            a->angle+=getLevelObjectFloat(ix,LEVEL_PROP_SPEED_OUT,3.0f);
            if(a->angle>=len){
                a->angle=len;
                a->state=LV_PISTON_WAIT_OUT;
                a->timer=(int16_t)getLevelObjectInt(ix,LEVEL_PROP_WAIT_OUT,20);
            }
        break;
        case LV_PISTON_WAIT_OUT:
            if(--a->timer<=0){
                a->state=LV_PISTON_BACK;
            }
        break;
        default:
            a->angle-=getLevelObjectFloat(ix,LEVEL_PROP_SPEED_IN,0.75f);
            if(a->angle<=0.0f){
                a->angle=0.0f;
                a->state=LV_PISTON_IN;
                a->timer=(int16_t)getLevelObjectInt(ix,LEVEL_PROP_WAIT_IN,50);
            }
        break;
    }
    getLevelPathPoint(path,a->angle,&a->x,&a->y);
    lvPistonShaft(ix,a,po);
}

// A piston's front: true if a point is ahead of its head, in the direction it pushes
static bool lvInFrontOfPiston(int obj, float x, float y)
{
    const LevelObject *po=getLevelObject(getLevelObjectInt(obj,LEVEL_PROP_PATH,-1));
    const LevelActor *a=getLevelActor(obj);
    if(!po || po->pointCount<2){
        return false;
    }
    const float dx=(float)(po->points[po->pointCount-1].x-po->points[0].x);
    const float dy=(float)(po->points[po->pointCount-1].y-po->points[0].y);
    return ((x-a->x)*dx)+((y-a->y)*dy)>0.0f;
}

// Piston heads that moved into the player this frame: the front of one pushing out crushes them. Otherwise (a head
// coming down while the player's safe after losing a life, or its side), they're pushed out to the nearer side. Uses
// the heads' boxes and the player's hitbox, the same as the solid collisions. False if the player was crushed
static bool lvPistonsHitPlayer(void)
{
    const int px0=lvX-LV_LEFT, px1=lvX+LV_RIGHT, py0=lvY-LV_TOP, py1=lvY+LV_BOTTOM;
    for(int ix=firstSpriteInSet(lvPistons);ix>=0;ix=nextSpriteInSet(ix)){
        const int obj=getSpriteLevelObject(ix);
        const LvBox b=lvBoxOf(obj);
        if(px1<b.x0 || px0>b.x1 || py1<b.y0 || py0>b.y1){
            continue;
        }
        const LevelActor *a=getLevelActor(obj);
        if(lvSafe==0 && a->state==LV_PISTON_OUT && lvInFrontOfPiston(obj,(float)lvX,(float)lvY)){
            ++lvLost;
            lvRespawn();
            return false;
        }
        // Out of the way, across the direction the piston moves
        const LevelObject *po=getLevelObject(getLevelObjectInt(obj,LEVEL_PROP_PATH,-1));
        const bool vertical=po && po->pointCount>1 && po->points[0].x==po->points[po->pointCount-1].x;
        // (the nearer side, unless something solid's in the way there)
        if(vertical){
            const int left=b.x0-LV_RIGHT-1, right=b.x1+LV_LEFT+1;
            const bool leftFree=!lvColumnBlocked(left-LV_LEFT,lvY) && !lvColumnBlocked(left+LV_RIGHT,lvY);
            const bool rightFree=!lvColumnBlocked(right-LV_LEFT,lvY) && !lvColumnBlocked(right+LV_RIGHT,lvY);
            lvX=(leftFree && (!rightFree || lvX-left<right-lvX))?left:right;
        }else{
            const int up=b.y0-LV_BOTTOM-1, down=b.y1+LV_TOP+1;
            const bool upFree=!lvRowBlocked(lvX,up-LV_TOP) && !lvRowBlocked(lvX,up+LV_BOTTOM);
            const bool downFree=!lvRowBlocked(lvX,down-LV_TOP) && !lvRowBlocked(lvX,down+LV_BOTTOM);
            lvY=(upFree && (!downFree || lvY-up<down-lvY))?up:down;
        }
    }
    return true;
}

static void lvUpdateDoor(int ix, LevelActor *a);

// ---------------------------------------------------------------------------
// Shooter levels: flying enemies, the player's bullets, and explosions
// ---------------------------------------------------------------------------

// The way from a point to the player, as an angle (0 up, clockwise - as sprite rotations)
static float lvAngleToPlayer(float x, float y)
{
    return atan2f((float)lvX-x,y-(float)lvY);
}

// An enemy shot, from a point, at an angle (0 up, clockwise)
static void lvEnemyFire(float x, float y, float angle, float speed)
{
    for(int n=0;n<LV_MAX_SHOTS;n++){
        LvShot *s=lvShotList+n;
        if(s->sprite>=0){
            continue;
        }
        const int ix=allocateSprite();
        if(ix<0){
            return;
        }
        s->sprite=(int16_t)ix;
        s->age=0;
        s->x=x;
        s->y=y;
        s->vx=sinf(angle)*speed;
        s->vy=-cosf(angle)*speed;
        setSpriteSize(ix,SIZE_8X8);
        setSpriteDef(ix,enemyShotDef,enemyShotMaskDef);
        setSpritePalette(ix,0);
        setSpriteLayer(ix,LV_LAYER);
        setSpriteSpace(ix,SPRITE_SPACE_LAYER,-1);
        setSpritePos(ix,x,y);
        return;
    }
}

static void lvFreeShots(void)
{
    for(int n=0;n<LV_MAX_SHOTS;n++){
        if(lvShotList[n].sprite>=0){
            freeSprite(lvShotList[n].sprite);
            lvShotList[n].sprite=-1;
        }
    }
}

// Enemy shots fly straight on until they hit a wall (a little puff), run out of time, or hit the player
static void lvUpdateShots(void)
{
    for(int n=0;n<LV_MAX_SHOTS;n++){
        LvShot *s=lvShotList+n;
        if(s->sprite<0){
            continue;
        }
        s->x+=s->vx;
        s->y+=s->vy;
        bool gone=(++s->age>LV_SHOT_LIFE);
        if(!gone && isLevelPixelSolid(LV_LAYER,(int)s->x,(int)s->y)){
            startParticles(lvSparks,(int)s->x,(int)s->y,5,0.0f,6.2832f,0.3f,1.0f,5,10);
            gone=true;
        }
        if(gone){
            freeSprite(s->sprite);
            s->sprite=-1;
            continue;
        }
        spriteList[s->sprite].frame=(int16_t)((s->age/4)&1);
        setSpritePos(s->sprite,s->x,s->y);
        // (the shot's middle 2x2 pixels against the player's box)
        if(lvSafe==0 && s->x+1.0f>=(float)(lvX-LV_LEFT) && s->x-1.0f<=(float)(lvX+LV_RIGHT) &&
            s->y+1.0f>=(float)(lvY-LV_TOP) && s->y-1.0f<=(float)(lvY+LV_BOTTOM)){
            ++lvLost;
            lvRespawn();
            return;
        }
    }
}

// A turret (a Turret in Tiled, placed where its gun turns, on a turret tile in the floor or roof): its gun turns
// towards the player, as far as it can either side of straight out, and fires when it's pointing at them and they're
// in range
static void lvUpdateTurret(int ix, LevelActor *a)
{
    const float base=getLevelObjectInt(ix,LEVEL_PROP_CEILING,0)?3.1416f:0.0f;
    const int fireRate=getLevelObjectInt(ix,LEVEL_PROP_FIRE_RATE,70);
    if(a->state==0){
        a->state=1;
        a->hp=(int16_t)getLevelObjectInt(ix,LEVEL_PROP_HP,3);
        a->timer=(int16_t)(fireRate/2);
        a->angle=0.0f;
    }
    // Where it wants to point, relative to straight out (wrapped to +/- half a turn), within its arc
    float want=lvAngleToPlayer(a->x,a->y)-base;
    want=(want>3.1416f)?want-6.2832f:((want<-3.1416f)?want+6.2832f:want);
    want=(want>LV_TURRET_ARC)?LV_TURRET_ARC:((want<-LV_TURRET_ARC)?-LV_TURRET_ARC:want);
    const float turn=getLevelObjectFloat(ix,LEVEL_PROP_TURN_SPEED,0.05f);
    a->angle+=(want>a->angle+turn)?turn:((want<a->angle-turn)?-turn:(want-a->angle));
    if(a->sprite>=0){
        setSpriteRotation(a->sprite,base+a->angle);
    }
    if(a->timer>0){
        --a->timer;
    }
    const float dx=(float)lvX-a->x, dy=(float)lvY-a->y, range=(float)getLevelObjectInt(ix,LEVEL_PROP_RANGE,150);
    if(a->timer==0 && fireRate>0 && (dx*dx)+(dy*dy)<range*range && fabsf(want-a->angle)<0.12f){
        // From the end of its gun
        const float g=base+a->angle;
        lvEnemyFire(a->x+(sinf(g)*8.0f),a->y-(cosf(g)*8.0f),g,getLevelObjectFloat(ix,LEVEL_PROP_SHOT_SPEED,1.75f));
        a->timer=(int16_t)fireRate;
    }
}

// A flying enemy (a Flyer in Tiled), following its pattern. It sets off towards the player when the camera reaches it
// (waitForCamera), so waves come at the player from whichever side they're flying from
static void lvUpdateFlyer(int ix, LevelActor *a)
{
    const LevelObject *o=getLevelObject(ix);
    const float speed=getLevelObjectFloat(ix,LEVEL_PROP_SPEED,1.5f);
    const float amplitude=(float)getLevelObjectInt(ix,LEVEL_PROP_AMPLITUDE,24);
    const int period=getLevelObjectInt(ix,LEVEL_PROP_PERIOD,80);
    const int pattern=getLevelObjectInt(ix,LEVEL_PROP_PATTERN,FLY_PATTERN_STRAIGHT);
    const int fireRate=getLevelObjectInt(ix,LEVEL_PROP_FIRE_RATE,0);
    if(a->state==0){
        a->state=1;
        a->dir=((float)lvX<a->x)?-1:1;
        a->hp=(int16_t)getLevelObjectInt(ix,LEVEL_PROP_HP,1);
        a->timer=0;
        a->vx=(float)a->dir*speed;
        a->vy=0.0f;
        // (angle counts down to its first shot - staggered, so a wave doesn't all fire at once)
        a->angle=(float)((fireRate/2)+((fireRate>0)?(rand()%fireRate):0));
    }
    ++a->timer;

    // Launchers wait on the roof or floor until the player comes in range, then go for them
    if(pattern==FLY_PATTERN_LAUNCH){
        const float dx=(float)lvX-a->x, dy=(float)lvY-a->y;
        const float range=(float)getLevelObjectInt(ix,LEVEL_PROP_RANGE,80);
        if(a->state!=LV_LAUNCHED){
            a->frame=0;
            if((dx*dx)+(dy*dy)<range*range){
                // Off the roof or floor, straight towards the player's height, then turning to chase them
                a->state=LV_LAUNCHED;
                a->vx=0.0f;
                a->vy=(dy>0.0f)?speed:-speed;
            }
            return;
        }
        const float d=sqrtf((dx*dx)+(dy*dy));
        if(d>1.0f){
            a->vx+=(((dx/d)*speed)-a->vx)*LV_LAUNCH_TURN;
            a->vy+=(((dy/d)*speed)-a->vy)*LV_LAUNCH_TURN;
        }
        a->x+=a->vx;
        a->y+=a->vy;
        a->frame=(uint8_t)((a->timer/4)&1);
        if(fabsf(a->x-(float)lvX)>LV_FLYER_GONE || a->y<-32.0f || a->y>(float)getLevelHeight()+32.0f){
            killLevelActor(ix);
        }
        return;
    }
    switch(pattern){
        case FLY_PATTERN_SINE:
            // Across, weaving up and down around where it was placed
            a->x+=(float)a->dir*speed;
            a->y=(float)o->y+(amplitude*sinf((float)a->timer*6.2832f/(float)((period>0)?period:80)));
        break;
        case FLY_PATTERN_SWOOP:
            // Straight in until close across, then curving up or down through the player, and on
            if(a->state==1 && fabsf((float)lvX-a->x)<amplitude*3.0f){
                a->state=2;
            }
            if(a->state==2){
                a->vy+=((float)lvY>a->y)?0.12f:-0.12f;
                a->vy=(a->vy>speed*1.5f)?speed*1.5f:((a->vy<-speed*1.5f)?-speed*1.5f:a->vy);
            }
            a->x+=a->vx;
            a->y+=a->vy;
        break;
        case FLY_PATTERN_PATH:
        {
            // Along its path (a polygon loops; off the end of a polyline, it carries on the way it was going)
            const int path=getLevelObjectInt(ix,LEVEL_PROP_PATH,-1);
            const float d=(float)a->timer*speed;
            float px, py;
            if(path>=0 && ((getLevelObject(path)->flags&LEVEL_OBJ_CLOSED) || d<getLevelPathLength(path)) &&
                getLevelPathPoint(path,d,&px,&py)){
                a->vx=px-a->x;
                a->vy=py-a->y;
                a->x=px;
                a->y=py;
            }else{
                a->x+=a->vx;
                a->y+=a->vy;
            }
        }
        break;
        case FLY_PATTERN_HOMING:
        {
            // Turning towards the player, a little at a time
            const float dx=(float)lvX-a->x, dy=(float)lvY-a->y, d=sqrtf((dx*dx)+(dy*dy));
            if(d>1.0f){
                a->vx+=(((dx/d)*speed)-a->vx)*0.04f;
                a->vy+=(((dy/d)*speed)-a->vy)*0.04f;
            }
            a->x+=a->vx;
            a->y+=a->vy;
        }
        break;
        default:
            a->x+=(float)a->dir*speed;
        break;
    }
    a->frame=(uint8_t)((a->timer/6)&1);
    // Shooting at the player (fireRate frames apart), while they're about on screen
    if(fireRate>0 && fabsf((float)lvX-a->x)<LV_SHOT_RANGE && fabsf((float)lvY-a->y)<100.0f){
        a->angle-=1.0f;
        if(a->angle<=0.0f){
            lvEnemyFire(a->x,a->y,lvAngleToPlayer(a->x,a->y),getLevelObjectFloat(ix,LEVEL_PROP_SHOT_SPEED,1.75f));
            a->angle=(float)fireRate;
        }
    }
    // Flown past the player, or out of the level
    if(fabsf(a->x-(float)lvX)>LV_FLYER_GONE || a->y<-32.0f || a->y>(float)getLevelHeight()+32.0f){
        killLevelActor(ix);
    }
}

// An enemy hit by a shot going one way (dir): a big burst of particles carried on the way the shot was going, and
// smaller ones up, down and back the other way. Angles are 0 up, clockwise
static void lvExplode(float x, float y, int dir)
{
    const float ahead=(dir>0)?1.5708f:4.7124f, behind=(dir>0)?4.7124f:1.5708f;
    startParticles(lvSparks,(int)x,(int)y,70,ahead-0.6f,ahead+0.6f,1.5f,5.5f,18,45);
    startParticles(lvSparks,(int)x,(int)y,16,-0.5f,0.5f,0.6f,2.2f,10,28);
    startParticles(lvSparks,(int)x,(int)y,16,3.1416f-0.5f,3.1416f+0.5f,0.6f,2.2f,10,28);
    startParticles(lvSparks,(int)x,(int)y,12,behind-0.5f,behind+0.5f,0.5f,1.8f,8,22);
}

static void lvFreeBullet(LvBullet *b)
{
    freeSprite(b->sprite);
    b->sprite=-1;
}

static void lvFreeBullets(void)
{
    for(int n=0;n<LV_MAX_BULLETS;n++){
        if(lvBulletList[n].sprite>=0){
            lvFreeBullet(lvBulletList+n);
        }
    }
}

// Fire a bullet the way the player faces, from in front of them
static void lvFire(void)
{
    for(int n=0;n<LV_MAX_BULLETS;n++){
        LvBullet *b=lvBulletList+n;
        if(b->sprite>=0){
            continue;
        }
        const int s=allocateSprite();
        if(s<0){
            return;
        }
        b->sprite=(int16_t)s;
        b->dir=(int8_t)lvFacing;
        b->x=(float)(lvX+(lvFacing*14));
        b->y=(float)(lvY+2);
        setSpriteSize(s,SIZE_8X4);
        setSpriteDef(s,bulletDef,bulletMaskDef);
        setSpritePalette(s,0);
        setSpriteLayer(s,LV_LAYER);
        setSpriteSpace(s,SPRITE_SPACE_LAYER,-1);
        addSpriteToSet(s,lvBullets);
        setSpritePos(s,b->x,b->y);
        return;
    }
}

// Bullets fly on until they hit a wall (a puff of sparks back off it), an enemy (which explodes, if that was its last
// hit point), or go out of range
static void lvUpdateBullets(void)
{
    for(int n=0;n<LV_MAX_BULLETS;n++){
        LvBullet *b=lvBulletList+n;
        if(b->sprite<0){
            continue;
        }
        bool gone=false;
        // In 2 pixel steps, so nothing thin is skipped over
        const float speed=LV_BULLET_SPEED+fabsf(lvVX);
        for(float moved=0.0f;moved<speed && !gone;moved+=2.0f){
            b->x+=(float)b->dir*2.0f;
            const int tipX=(int)b->x+(b->dir*4);
            if(isLevelPixelSolid(LV_LAYER,tipX,(int)b->y) || isLevelPixelSolid(LV_LAYER,tipX,(int)b->y+1)){
                startParticles(lvSparks,tipX,(int)b->y,8,(b->dir>0)?4.7124f-0.8f:1.5708f-0.8f,
                    (b->dir>0)?4.7124f+0.8f:1.5708f+0.8f,0.5f,1.5f,6,14);
                gone=true;
                break;
            }
            for(int ix=firstSpriteInSet(lvEnemies);ix>=0 && !gone;ix=nextSpriteInSet(ix)){
                const int obj=getSpriteLevelObject(ix);
                LevelActor *a=getLevelActor(obj);
                const LevelObject *o=getLevelObject(obj);
                if(!a || fabsf(a->x-b->x)>(float)(o->width/2)+4.0f || fabsf(a->y-b->y)>(float)(o->height/2)+2.0f){
                    continue;
                }
                gone=true;
                if(--a->hp<=0){
                    lvExplode(a->x,a->y,b->dir);
                    killLevelActor(obj);
                    ++lvStomped;
                }else{
                    startParticles(lvSparks,(int)b->x,(int)b->y,6,0.0f,6.2832f,0.5f,1.5f,6,12);
                }
            }
        }
        if(gone || fabsf(b->x-(float)lvX)>LV_BULLET_RANGE){
            lvFreeBullet(b);
        }else{
            setSpritePos(b->sprite,b->x,b->y);
        }
    }
}

static void lvUpdateActors(void)
{
    for(int ix=0;ix<getLevelObjectCount();ix++){
        if(!isLevelActorActive(ix)){
            continue;
        }
        LevelActor *a=getLevelActor(ix);
        switch(getLevelObject(ix)->cls){
            case LEVEL_CLASS_ENEMY:
                lvUpdateEnemy(ix,a);
            break;
            case LEVEL_CLASS_PLATFORM:
                lvUpdatePlatform(ix,a);
            break;
            case LEVEL_CLASS_PISTON:
                lvUpdatePiston(ix,a);
            break;
            case LEVEL_CLASS_DOOR:
            case LEVEL_CLASS_EXIT:
                lvUpdateDoor(ix,a);
            break;
            case LEVEL_CLASS_GENERATOR:
                lvUpdateGenerator(ix,a);
            break;
            case LEVEL_CLASS_FLYER:
                lvUpdateFlyer(ix,a);
            break;
            case LEVEL_CLASS_TURRET:
                lvUpdateTurret(ix,a);
            break;
            default:
            break;
        }
    }
    lvUpdateBubbles();
}

// What the player touched when the last frame was drawn: enemies are stomped on from above, or cost a life; bubbles pop
static void lvPlayerHits(void)
{
    const Sprite *p=spriteList+lvPlayer;
    if(lvSafe>0){
        --lvSafe;
    }
    for(int n=0;n<p->spriteHitCount;n++){
        const int hit=p->spriteHits[n];
        if(isSpriteInSet(hit,lvEnemies)){
            const int obj=getSpriteLevelObject(hit);
            const LevelActor *a=getLevelActor(obj);
            if(!a){
                continue;
            }
            // (stomped on from above - on foot only)
            if(getLevelType()!=LEVEL_TYPE_SHOOTER && !lvOnGround && lvVY>0.0f && (float)lvY<a->y-6.0f){
                killLevelActor(obj);
                ++lvStomped;
                lvVY=-LV_STOMP;
            }else if(lvSafe==0){
                ++lvLost;
                lvRespawn();
                return;
            }
        }else if(isSpriteInSet(hit,lvBubbles)){
            for(int b=0;b<LV_MAX_BUBBLES;b++){
                if(lvBubbleList[b].sprite==hit){
                    lvFreeBubble(lvBubbleList+b);
                    ++lvPopped;
                }
            }
        }
    }
}

// The camera catches up with the player - faster the further the player is from the middle of the screen, and slowly
// centring on them when they stop
static void lvCamera(bool snap)
{
    const float maxX=(float)(getLevelWidth()-SCREEN_WIDTH_PIXELS), maxY=(float)(getLevelHeight()-SCREEN_HEIGHT_LINES);
    float tx=(float)lvX-(SCREEN_WIDTH_PIXELS/2);
    float ty=(float)lvY-(SCREEN_HEIGHT_LINES/2);
    tx=(tx<0.0f)?0.0f:((tx>maxX)?maxX:tx);
    ty=(ty<0.0f)?0.0f:((ty>maxY)?maxY:ty);
    if(snap){
        lvCamX=tx;
        lvCamY=ty;
    }else{
        const float dx=tx-lvCamX, dy=ty-lvCamY;
        const float kx=0.03f+(fabsf(dx)*0.001f), ky=0.03f+(fabsf(dy)*0.001f);
        lvCamX+=dx*((kx>1.0f)?1.0f:kx);
        lvCamY+=dy*((ky>1.0f)?1.0f:ky);
    }
    setLevelCamera((int)floorf(lvCamX+0.5f),(int)floorf(lvCamY+0.5f));
}

// ---------------------------------------------------------------------------
// Switches, keys, doors, and moving between levels
// ---------------------------------------------------------------------------

#define LV_DOOR_OPEN        2

// A gate door is solid until it's fully open (doors to other levels open into the screen, so never block the way)
static void lvDoorSolidity(int objectIX)
{
    const LevelActor *a=getLevelActor(objectIX);
    if(a->sprite>=0){
        setSpriteSolid(a->sprite,!getLevelSwitch(objectIX) || a->state==LV_DOOR_OPENING);
    }
}

// Doors play their opening frames, from the one placed in Tiled to the last of their sprite sheet. A door to another
// level takes the player there once it's open
static void lvUpdateDoor(int ix, LevelActor *a)
{
    const LevelObject *o=getLevelObject(ix);
    if(a->state==LV_DOOR_OPENING && o->sheet>=0){
        const int last=getLevel()->sheets[o->sheet].frames-1;
        int frame=o->frame+(++a->timer/LV_DOOR_TICKS);
        if(frame>=last){
            frame=last;
            a->state=LV_DOOR_OPEN;
            if(ix==lvLeaving){
                lvGoLevel=getLevelObjectInt(ix,LEVEL_PROP_TO_LEVEL,-1);
                lvGoEntrance=getLevelObjectString(ix,LEVEL_PROP_TO_ENTRANCE,"start");
                lvLeaving=-1;
            }
        }
        a->frame=(uint8_t)frame;
    }
    if(o->cls==LEVEL_CLASS_DOOR){
        lvDoorSolidity(ix);
    }
}

static void lvOpenDoor(int objectIX)
{
    LevelActor *a=getLevelActor(objectIX);
    a->state=LV_DOOR_OPENING;
    a->timer=0;
    a->frame=getLevelObject(objectIX)->frame;
}

// As an actor gets its sprite: a gate door's is solid or not, as the door is
static void lvOnShow(int objectIX, int spriteIX)
{
    (void)spriteIX;
    if(getLevelObject(objectIX)->cls==LEVEL_CLASS_DOOR){
        lvDoorSolidity(objectIX);
    }
}

// The one switch handler for every switch in every level - by the switch's value (its SwitchId in Tiled). Called when
// a switch changes, and again for switches that are on when a level's entered (LEVEL_SWITCH_REPLAY) - so everything
// here sets up a state (the pistons are stopped, the door's open), rather than starting an animation - except a door
// the player's just opened, which plays its opening frames
static void lvOnSwitch(int value, bool on, int objectIX, uint8_t why)
{
    if(getLevelObject(objectIX)->cls==LEVEL_CLASS_DOOR){
        if(on && why==LEVEL_SWITCH_USED){
            lvOpenDoor(objectIX);
        }else{
            getLevelActor(objectIX)->state=on?LV_DOOR_OPEN:LV_DOOR_SHUT;
        }
        lvDoorSolidity(objectIX);
        return;
    }
    switch(value){
        case SWITCH_ID_PISTONS:
            lvPistonsStopped=on;
        break;
        case SWITCH_ID_LIFT_CALL:
            lvLiftCalled=on;
        break;
        default:
        break;
    }
}

// Each level's setup, as it's entered (before its switches are replayed): the game's per level state, sprite sets for
// its classes, and its actors' starting states
static void lvSetupLevel(const LevelDef *lv)
{
    (void)lv;
    lvTileShift=(getLevelTileSize()==16)?4:3;
    // Bullets and explosions are only in the level they were in
    lvFreeBullets();
    lvFireTimer=0;
    lvFreeShots();
    if(lvSparks>=0){
        deleteParticleSet(lvSparks);
    }
    lvSparks=createParticleSet(LV_SPARKS,LV_LAYER);
    setParticleSetSpace(lvSparks,PARTICLE_SPACE_LAYER);
    setParticleSetGravity(lvSparks,0.03f);
    lvPistonsStopped=false;
    lvLiftCalled=false;
    for(int n=0;n<LV_MAX_BUBBLES;n++){
        if(lvBubbleList[n].sprite>=0){
            freeSprite(lvBubbleList[n].sprite);
        }
        lvBubbleList[n].sprite=-1;
    }
    // Sprites near the camera join a set by their class, so what the player hits says what it is
    setLevelClassSprites(LEVEL_CLASS_ENEMY,lvEnemies,COLLIDE_TARGET);
    setLevelClassSprites(LEVEL_CLASS_FLYER,lvEnemies,COLLIDE_TARGET);
    setLevelClassSprites(LEVEL_CLASS_TURRET,lvEnemies,COLLIDE_TARGET);
    setLevelClassSprites(LEVEL_CLASS_PLATFORM,lvPlatforms,COLLIDE_NONE);
    setLevelClassSprites(LEVEL_CLASS_PISTON,lvPistons,COLLIDE_NONE);
    setLevelClassSprites(LEVEL_CLASS_DOOR,lvDoors,COLLIDE_NONE);
    setLevelActorCallbacks(lvOnShow,NULL);
    lvLeaving=-1;
    for(int ix=0;ix<getLevelObjectCount();ix++){
        const LevelObject *o=getLevelObject(ix);
        LevelActor *a=getLevelActor(ix);
        switch(o->cls){
            case LEVEL_CLASS_ENEMY:
                // Setting off the way they face in Tiled (frames 0-7 face left)
                a->dir=(o->frame<LV_FRAMES_RIGHT)?-1:1;
            break;
            case LEVEL_CLASS_PISTON:
                // Pulled in, waiting for their phase
                a->timer=(int16_t)(getLevelObjectInt(ix,LEVEL_PROP_PHASE,0)+getLevelObjectInt(ix,LEVEL_PROP_WAIT_IN,50));
            break;
            case LEVEL_CLASS_PLAYER_START:
                // Just marks where the player starts - not shown
                killLevelActor(ix);
            break;
            default:
            break;
        }
    }
}

// Go to a level, arriving at an entrance (its switches are replayed first, so everything's as it was left)
static bool lvEnter(int levelID, const char *entrance)
{
    lvSpringTimer=0;        // (a squashed springboard is back to normal in the level when it's loaded again)
    lvTitleTimer=0;
    lvHudLine=-1;
    const int e=enterLevel(levelID,entrance);
    if(e==-2){
        return false;
    }
    lvStartX=40;
    lvStartY=250;
    if(e>=0){
        lvStartX=(int)getLevelActor(e)->x;
        lvStartY=(int)getLevelActor(e)->y;
    }
    lvRespawn();
    if(e>=0){
        lvFacing=getLevelActor(e)->dir;
    }
    setSpritePos(lvPlayer,(float)lvX,(float)lvY);
    lvCamera(true);
    updateLevel();
    return true;
}

// Is the player touching an object (its box, grown by margin pixels)?
static bool lvTouching(int objectIX, int margin)
{
    const LevelActor *a=getLevelActor(objectIX);
    const LevelObject *o=getLevelObject(objectIX);
    const int hw=(o->width/2)+margin, hh=(o->height/2)+margin;
    const int cx=(int)floorf(a->x), cy=(int)floorf(a->y);
    return lvX+LV_RIGHT>=cx-hw && lvX-LV_LEFT<cx+hw && lvY+LV_BOTTOM>=cy-hh && lvY-LV_TOP<cy+hh;
}

// Switches (levers used with A, pressure plates stood on), keys picked up, locked doors opened with their key, and
// exits used with A
// touchExits: exits are taken by touching them (flying, in a shooter level), rather than with the use key
static void lvUseThings(bool usePressed, bool touchExits)
{
    for(int ix=0;ix<getLevelObjectCount();ix++){
        if(!isLevelActorActive(ix)){
            continue;
        }
        const LevelObject *o=getLevelObject(ix);
        switch(o->cls){
            case LEVEL_CLASS_SWITCH:
                if(lvTouching(ix,0) && (o->mode==LEVEL_SWITCH_TIMED || usePressed)){
                    useLevelSwitch(ix);
                }
            break;
            case LEVEL_CLASS_KEY:
                if(lvTouching(ix,0)){
                    // Gone for good - it persists, so it isn't there when the level's entered again
                    lvKeys|=1u<<o->value;
                    killLevelActor(ix);
                }
            break;
            case LEVEL_CLASS_DOOR:
                if(!getLevelSwitch(ix) && (lvKeys&(1u<<o->value)) && lvTouching(ix,2)){
                    useLevelSwitch(ix);
                }
            break;
            case LEVEL_CLASS_EXIT:
                // A door opens first (lvUpdateDoor then takes the player through); an exit without one is immediate
                if((usePressed || touchExits) && lvLeaving<0 && lvTouching(ix,0)){
                    if(o->sheet>=0){
                        lvOpenDoor(ix);
                        lvLeaving=ix;
                    }else{
                        lvGoLevel=getLevelObjectInt(ix,LEVEL_PROP_TO_LEVEL,-1);
                        lvGoEntrance=getLevelObjectString(ix,LEVEL_PROP_TO_ENTRANCE,"start");
                    }
                }
            break;
            default:
            break;
        }
    }
}

void setupLevelTest(void)
{
    initLayers();
    initSprites(LV_SPRITES);
    setTileDefSet(LV_HUD_LAYER,defaultTileDef);
    setLayerPos(LV_HUD_LAYER,0,0);
    drawTxtToLayer(LV_HUD_LAYER,"O/P:RUN Q:JUMP A:USE R:TILT     ",0x45,0x45,0,1);

    // Sprite sets, for what the player touches
    lvEnemies=createSpriteSet();
    lvPlatforms=createSpriteSet();
    lvBubbles=createSpriteSet();
    lvPistons=createSpriteSet();
    lvDoors=createSpriteSet();
    lvBullets=createSpriteSet();
    // Piston heads and closed doors block the way, like walls
    setSpriteSetSolid(lvPistons,true);
    setSpriteSetSolid(lvDoors,true);
    for(int n=0;n<LV_MAX_BULLETS;n++){
        lvBulletList[n].sprite=-1;
    }
    for(int n=0;n<LV_MAX_SHOTS;n++){
        lvShotList[n].sprite=-1;
    }
    deleteParticleSets();
    lvSparks=-1;
    for(int n=0;n<LV_MAX_BUBBLES;n++){
        lvBubbleList[n].sprite=-1;
    }

    // The player lives in the level (layer space), so its position is in level pixels and it moves with the level
    lvPlayer=allocateSprite();
    setSpriteSize(lvPlayer,SIZE_24X24);
    setSpriteDef(lvPlayer,sprite24x24Def,mask24x24Def);
    setSpritePalette(lvPlayer,LV_PALETTE);
    setSpriteLayer(lvPlayer,LV_LAYER);
    setSpriteSpace(lvPlayer,SPRITE_SPACE_LAYER,-1);
    setSpriteCollisions(lvPlayer,COLLIDE_SPRITES);
    lvCoins=0;
    lvLost=0;
    lvStomped=0;
    lvPopped=0;
    lvSwing=0;
    lvStride=0.0f;
    lvRotate=false;
    lvPrevR=false;
    lvPrevQ=false;
    lvPrevA=false;
    lvKeys=0;
    lvGoLevel=-1;

    // A new game: nothing remembered yet. Then into the demo level, at its start
    clearLevelStateStore();
    setLevelHandlers(lvSetupLevel,lvOnSwitch);
    lvLoaded=lvEnter(LEVEL_ID_DEMO,NULL);
    if(!lvLoaded){
        drawTxtToLayer(LV_HUD_LAYER,"LEVEL DOESN'T FIT IN RAM",0x42,0x42,4,10);
    }
}

void levelTest(void)
{
    if(keyDown(KEY_SPACE)){
        setState(GS_title);
        return;
    }
    if(!lvLoaded){
        return;
    }
    const bool rDown=keyDown(KEY_R)!=0;
    if(rDown && !lvPrevR){
        lvRotate=!lvRotate;
    }
    lvPrevR=rDown;

    // The level swings gently around the middle of the screen (the foreground follows it, the hills and sky don't) -
    // set first, as the player's jumps and falls go by the screen
    if(lvRotate){
        setLayerTransform(LV_LAYER,0.2f*sinf((float)lvSwing*0.03f),1.0f,1.0f);
        ++lvSwing;
    }else{
        clearLayerTransform(LV_LAYER);
    }

    // What the player touched last frame
    lvPlayerHits();

    // Every actor, then the player - carried by the platform they're standing on
    const int riding=lvOnGround?lvPlatformUnder(lvX,lvY):-1;
    lvUpdateActors();
    lvPistonsHitPlayer();
    if(riding>=0){
        const LevelActor *pa=getLevelActor(riding);
        lvFracX+=pa->vx;
        while(fabsf(lvFracX)>=1.0f){
            const int step=(lvFracX>0.0f)?1:-1;
            if(!lvStepAcross(step,false)){
                lvFracX=0.0f;
                break;
            }
            lvFracX-=(float)step;
        }
        lvStandOn(riding);
    }
    // The level's type, from Tiled: on foot in platform levels, flying in shooter levels
    const bool shooter=(getLevelType()==LEVEL_TYPE_SHOOTER);
    if(!shooter){
        lvGroundTiles(keyDown(KEY_Q)!=0 && lvLeaving<0);
    }

    // (no control while going through a door to another level)
    const int dir=(lvLeaving>=0)?0:(keyDown(KEY_O)?-1:(keyDown(KEY_P)?1:0));
    if(dir){
        lvFacing=dir;
    }
    const bool qDown=keyDown(KEY_Q)!=0;
    const bool aDown=keyDown(KEY_A)!=0;
    if(shooter){
        // Flying: Q up, A down
        lvShip(dir,(lvLeaving>=0)?0:(qDown?-1:(aDown?1:0)));
    }else{
        if(qDown && !lvPrevQ && lvOnGround && lvLeaving<0){
            lvTakeOff(LV_JUMP);
        }
        if(lvOnGround){
            lvRun(dir);
        }else{
            lvFly(dir);
        }
    }
    lvPrevQ=qDown;
    if(shooter){
        // Fire (M - SPACE leaves the level test) - held, a shot every LV_FIRE_DELAY frames
        if(lvFireTimer>0){
            --lvFireTimer;
        }
        if(keyDown(KEY_M) && lvFireTimer==0 && lvLeaving<0){
            lvFire();
            lvFireTimer=LV_FIRE_DELAY;
        }
        lvUpdateBullets();
        lvUpdateShots();
    }

    // Switches, keys, doors and exits (A uses things - or, flying, exits are taken by flying into them) - an exit
    // takes the player to another level straight away
    lvUseThings(aDown && !lvPrevA && !shooter,shooter);
    lvPrevA=aDown;
    if(lvGoLevel>=0){
        const int to=lvGoLevel;
        lvGoLevel=-1;
        lvEnter(to,lvGoEntrance);
        return;
    }

    // Coins: collected by touching them (the tile's taken out of the level, and off the screen)
    const int px[5]={lvX,lvX-LV_LEFT,lvX+LV_RIGHT,lvX,lvX};
    const int py[5]={lvY,lvY,lvY,lvY-LV_TOP,lvY+LV_BOTTOM};
    for(int n=0;n<5;n++){
        if(getLevelTileFlags(LV_LAYER,px[n]>>lvTileShift,py[n]>>lvTileShift)&LEVEL_TILE_COLLECT){
            setLevelTile(LV_LAYER,px[n]>>lvTileShift,py[n]>>lvTileShift,0);
            ++lvCoins;
        }
    }
    // Water and spikes, or off the bottom of the level: back to the start
    if((getLevelTileFlags(LV_LAYER,lvX>>lvTileShift,(lvY+LV_BOTTOM-1)>>lvTileShift)&LEVEL_TILE_HAZARD) || lvY>getLevelHeight()+LV_TOP){
        ++lvLost;
        lvRespawn();
    }

    // Frame: standing, running (the cycle moving on with the distance run), skidding or in the air
    int frame=LV_FRAME_STAND;
    if(!lvOnGround){
        frame=LV_FRAME_JUMP;
    }else if(lvSkidding){
        frame=LV_FRAME_SKID;
    }else if(lvSpeed!=0.0f){
        frame=((int)(lvStride/LV_STRIDE))&7;
    }
    spriteList[lvPlayer].frame=(int16_t)(frame+((lvFacing>0)?LV_FRAMES_RIGHT:0));
    // Flashing (taking the background's colours every other few frames) while safe after losing a life
    setSpritePalette(lvPlayer,(lvSafe>0 && (lvSafe&4))?0:(shooter?LV_SHIP_PALETTE:LV_PALETTE));
    setSpritePos(lvPlayer,(float)lvX,(float)lvY);

    // The camera, then the level: animated tiles, sprites for the actors near the camera, placed where they are now
    lvCamera(false);
    updateLevel();

    char status[64];
    char where[8];
    snprintf(where,sizeof(where),"%s",getLevel()->name);

    // The second line: on entering the level, its name and then its description (its levelName and levelDescription
    // in Tiled), then the controls - for walking, or flying in a shooter level
    const char *name=getLevelPropString(LEVEL_PROP_LEVEL_NAME,"");
    const char *desc=getLevelPropString(LEVEL_PROP_LEVEL_DESCRIPTION,"");
    int line=2;
    if(lvTitleTimer<LV_TITLE_TIME && name[0]){
        line=0;
    }else if(lvTitleTimer<LV_TITLE_TIME*2 && desc[0]){
        line=1;
    }
    ++lvTitleTimer;
    if(line!=lvHudLine){
        lvHudLine=line;
        char text[40];
        if(line<2){
            snprintf(text,sizeof(text),"%-32.32s",line?desc:name);
        }else{
            snprintf(text,sizeof(text),"%-32s",(getLevelType()==LEVEL_TYPE_SHOOTER)?"O/P/Q/A:FLY M:FIRE R:TILT":
                "O/P:RUN Q:JUMP A:USE R:TILT");
        }
        for(char *c=text;*c;c++){
            *c=(char)toupper((unsigned char)*c);
        }
        drawTxtToLayer(LV_HUD_LAYER,text,(line<2)?0x47:0x45,(line<2)?0x47:0x45,0,1);
    }
    for(char *c=where;*c;c++){
        *c=(char)toupper((unsigned char)*c);
    }
    if(getLevelType()==LEVEL_TYPE_SHOOTER){
        // (enemies shot down, instead of the key)
        snprintf(status,sizeof(status),"%-5s COIN:%2d LOST:%2d HIT:%2d %2u%% ",where,lvCoins,lvLost,lvStomped%100,
            (unsigned)(gv.frameTimeUs/400));
    }else{
        snprintf(status,sizeof(status),"%-5s COIN:%2d LOST:%2d KEY:%s %2u%% ",where,lvCoins,lvLost,lvKeys?"Y":"N",
            (unsigned)(gv.frameTimeUs/400));
    }
    drawTxtToLayer(LV_HUD_LAYER,status,0x46,0x46,0,0);
}
