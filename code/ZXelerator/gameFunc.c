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

    initParticles(1000);
    setGravity(0.2);

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

            if(particlesAlive==0){

                startParticles(
                    0,
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

void gameTitle(void)
{
    static const int titleSpritePosX[10]={
        0+16,24+16,56+16,80+16, 112+16,128+16,152+16,168+16,196+16,224+16
    };

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
            for(int n=0;n<10;n++){
                spriteList[n].delay=(n*2);
            }
            gv.iy=0;
            gv.ix=2;
        }
    }else if(gv.ix==2){
        bool oneChanged=false;
        for(int n=0;n<10;n++){
            if(spriteList[n].delay>0){
                --spriteList[n].delay;
                oneChanged=true;
            }else{
                float scale=spriteList[n].scaleX;
                if(scale>0.1){
                    scale-=0.1;
                    if(scale<0.05){
                        scale=0.05;
                        setSpritePos(n,300,300);
                    }else{
                        oneChanged=true;
                        setSpritePos(n,titleSpritePosX[n]+((1.0-scale)*10),161);
                    }
                    setSpriteScale(n,scale,1.0);
                }
            }
        }
        if(!oneChanged){
            gv.iy=38;
            gv.ix=3;
        }
    }else if(gv.ix==3){
        float sinIX=(float)(gv.iy+14)/10.0;
        int yPos=(((sin(sinIX)+1)*250.0)/8);
        yPos*=4;
        setLayerPos(1,0,yPos);
        ++gv.iy;
        if(yPos>200){    // gv.iy is 32 here
            gv.iy=0;
            gv.ix=4;
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
    }else if(gv.ix==4){
        if(gv.iy<108){
            gv.iy+=(gv.iy<40?4:(gv.iy<96?3:2));
            setLayerPos(3,256-gv.iy,80);
        }
        setLayerPos(4,(sin((float)gv.iv/137)*100)-128,(sin((float)gv.iw/212)*100)-92);
        gv.iv+=3;
        gv.iw+=4;
    
        if(gv.storyTextCurrentLineIX==gv.storyTextNextSectionAtLineIX){
            if(gv.storyTextSectionIX<5){
                gv.storyTextNextSectionAtLineIX=drawStorySection(2, gv.storyTextSectionIX, gv.storyTextCurrentLineIX);
                int currentTextLines=(gv.storyTextNextSectionAtLineIX-gv.storyTextCurrentLineIX);
                int botGap=(24-currentTextLines)/2;
                gv.storyScrollCDStartLine=gv.storyTextCurrentLineIX+currentTextLines+botGap+2;
                gv.storyTextNextSectionAtLineIX=gv.storyTextCurrentLineIX+currentTextLines+botGap+7;
                ++gv.storyTextSectionIX;
                if(gv.storyTextSectionIX==5){
                    gv.storyTextNextSectionAtLineIX+=20;
                    clearLayerLines(2,gv.storyTextNextSectionAtLineIX+40,30);
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