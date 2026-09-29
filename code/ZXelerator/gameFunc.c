#include "gameFunc.h"

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

    // M switches to the Mode 7 test scene, T to the audio test, C to the collision test
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
                setSpriteCollisions(n,COLLIDE_SPRITES);
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
    initSprites(1+(CT_BUBBLES*2));
    setSpriteSize(0,SIZE_24X24);
    setSpriteDef(0,sprite24x24Def,mask24x24Def);
    setSpritePalette(0,1);
    setSpriteLayer(0,CT_LAYER);
    setSpritePos(0,60,60);
    setSpriteCollisions(0,COLLIDE_SPRITES|COLLIDE_LAYER);

    // Bubbles - collide with sprites only (the second half only when doubled)
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
    char txt[40];
    if(player->tileHitCount){
        snprintf(txt,sizeof(txt),"SPRITES:%d TILES:%2d AT %2d,%2d  ",player->spriteHitCount,player->tileHitCount,
            player->tileHits[0].x,player->tileHits[0].y);
    }else{
        snprintf(txt,sizeof(txt),"SPRITES:%d TILES:%2d          ",player->spriteHitCount,player->tileHitCount);
    }
    drawTxtToLayer(CT_HUD_LAYER,txt,0x46,0x46,1,0);

    float px=player->xF, py=player->yF;
    if(keyDown(KEY_O)){
        px-=2.0f;
    }
    if(keyDown(KEY_P)){
        px+=2.0f;
    }
    if(keyDown(KEY_Q)){
        py-=2.0f;
    }
    if(keyDown(KEY_A)){
        py+=2.0f;
    }
    setSpritePos(0,px,py);

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
        // Bubbles flash red while touching another sprite
        setSpritePalette(n,b->spriteHitCount?3:2);
    }
}