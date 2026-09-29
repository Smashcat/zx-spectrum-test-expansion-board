#include "TileLayer.h"

TileLayer tileLayer[MAX_TILE_LAYERS];
static uint8_t pixLineBuffer[260] __attribute__((aligned(4)));

static void blitTileLayerTransformed(const TileLayer *tL);
static void blitBitmapLayerTransformed(const TileLayer *tL);
static void buildColourTables(void);

void initLayers(void){
    buildColourTables();
    for(int n=0;n<MAX_TILE_LAYERS;n++){
        TileLayer *t=tileLayer+n;
        t->x=500;
        t->y=0;
        t->globalAttr=0;
        t->tileDefPtr=NULL;
        t->bitmapDefPtr=NULL;
        t->attrDefPtr=NULL;
        t->layerType=LT_TILE;
        t->pivotX=SCREEN_WIDTH_PIXELS/2;
        t->pivotY=SCREEN_HEIGHT_LINES/2;
        t->opaque=false;
        t->colourAware=true;
        clearLayerTransform(n);
        clearLayerLines(n,0,TILE_LAYER_HEIGHT);
    }
}

void clearLayerLines(int layerIX, int fromY, int numRows){
    TileLayer *t=tileLayer+layerIX;
    for(int y=fromY;y<fromY+numRows;y++){
        int yStart=(y%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH;
        int ayStart=(y%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH*2;
        for(int x=0;x<TILE_LAYER_WIDTH;x++){
            t->tileMap[yStart+x]=0;        // 0 should always be an empty tile
            t->attrMap[ayStart+(x*2)]=1<<7;     // High bit set = do not update attr when drawing the pixels under this attr block
            t->attrMap[ayStart+(x*2)+1]=1<<7;
        }
    }
}

void setLayerType(int layerIX, LayerType lt)
{
    tileLayer[layerIX].layerType=lt;
}

void setLayerBitmap(int layerIX, const uint8_t *bitmapData, const uint8_t *attrData)
{
    TileLayer *t=tileLayer+layerIX;
    t->bitmapDefPtr=bitmapData+4;
    t->attrDefPtr=attrData;
    t->bitmapCharWidth=bitmapData[0];
    t->bitmapHeight=(int)bitmapData[1]*8;
    // A zero attr width means one attribute for the whole bitmap, otherwise per cell attributes are in attrData
    // (clear any global attribute left from a previous bitmap, as it would take priority)
    t->globalAttr=(bitmapData[2]==0)?bitmapData[3]:0;
}

void blitRawToLayer(int layerIX, const uint8_t *tileDefs, const uint8_t *attrDefs, int x, int y, int len)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x;
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    while(len--){
        *tP++=*tileDefs++;
        *aP=*attrDefs++;
        *(aP+TILE_LAYER_WIDTH)=*attrDefs++;
        ++aP;
    }
}

void drawTxtToLayer(int layerIX, const char *s, uint8_t colorTop, uint8_t colorBottom, int x, int y)
{
    const int tOffset=((y%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH)+x;
    const int aOffset=((y%TILE_LAYER_HEIGHT)*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    while(*s){
        *tP=*s;
        if(*s && *s!=32){
            *aP=colorTop;
            *(aP+TILE_LAYER_WIDTH)=colorBottom;
        }else{
            *aP=0x80;
            *(aP+TILE_LAYER_WIDTH)=0x80;
        }
        ++tP;
        ++aP;
        ++s;
    }
}

void setLayerTile(int layerIX, uint8_t tileDefIX, uint8_t colorTop, uint8_t colorBottom, int x, int y)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x;
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x;
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    *tP=tileDefIX;
    *aP=colorTop;
    *(aP+TILE_LAYER_WIDTH)=colorBottom;
}

void drawIntNumToLayer(int layerIX, int32_t num, uint8_t colorTop, uint8_t colorBottom, int x, int y, int maxDigits)
{
    const int tOffset=(y*TILE_LAYER_WIDTH)+x+(maxDigits-1);
    const int aOffset=(y*TILE_LAYER_WIDTH*2)+x+(maxDigits-1);
    uint8_t *tP=tileLayer[layerIX].tileMap+tOffset;
    uint8_t *aP=tileLayer[layerIX].attrMap+aOffset;
    if(num<0){
        *(tP-(maxDigits-1))='-';
        --maxDigits;
        num=-num;
    }
    while(maxDigits){
        *tP=(num%10)+'0';
        num/=10;
        *aP=colorTop;
        *(aP+TILE_LAYER_WIDTH)=colorBottom;
        --tP;
        --aP;
        --maxDigits;
    }
}

void setLayerPos(int layerIX, int x, int y)
{
    tileLayer[layerIX].x=x;
    tileLayer[layerIX].y=y;
}

void setTileDefSet(int layerIX, const uint8_t *setRef)
{
    tileLayer[layerIX].tileDefPtr=setRef;
}

//__not_in_flash_func(
//    void blitLayerToRenderBuffer(int layerIX)
//)
void blitLayerToScratchBuffers(int layerIX)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->layerType!=LT_TILE){
        blitBitmapLayerToScratchBuffers(layerIX);
    }

    if(tL->tileDefPtr==NULL){
        return;
    }

    if(tL->transformed || tL->lineTransforms){
        blitTileLayerTransformed(tL);
        return;
    }

    // If layer is off screen, don't draw it
    if(
        (tL->x<=-TILE_LAYER_WIDTH*8*2) ||
        (tL->x>=SCREEN_WIDTH_PIXELS) ||
        (tL->y<=-TILE_LAYER_HEIGHT*8*2) ||
        (tL->y>=SCREEN_HEIGHT_LINES) 
    ){
        return;
    }

    // Find correct offset into tiles in Y axis. We wrap to stay within 0-63 in both axis
    int srcStartY=0;
    int srcRowOffY=(8-(tL->y&0x07))&0x07;
    if(tL->y<0){
        srcStartY=((-(tL->y/8) % TILE_LAYER_HEIGHT) + TILE_LAYER_HEIGHT) % TILE_LAYER_HEIGHT;
    }else{
        srcStartY=((-((tL->y+7)/8) % TILE_LAYER_HEIGHT) + TILE_LAYER_HEIGHT) % TILE_LAYER_HEIGHT;
    }

    int srcStartX=0;
    const int leftShift=(8-(tL->x&0x07))&0x07;
    if(tL->x<0){
        srcStartX=((-(tL->x/8) % TILE_LAYER_WIDTH) + TILE_LAYER_WIDTH) % TILE_LAYER_WIDTH;
    }else{
        srcStartX=((-((tL->x+7)/8) % TILE_LAYER_WIDTH) + TILE_LAYER_WIDTH) % TILE_LAYER_WIDTH;
    }

    uint8_t *spr=scratchPixRam;
    uint8_t *smr=scratchMaskRam;
    const uint8_t *tileData=tL->tileMap;
    int srcRow=srcStartY;

    // We now go through the 192 rows of the destination array, wrapping the X and Y src positions as needed
    for(int destRow=0;destRow<SCREEN_HEIGHT_LINES;destRow++){

        // Go through 32 cols for each pixel row, picking up the correct char defs for the 8x8 cell, and scan-line offset
        //TODO need to actually go through 33 cols, so that left shifting will scroll on the tile to the right of the display
        const uint8_t *tDef=tL->tileDefPtr+srcRowOffY; // Current line offset added, for quicker lookup
        int yOff=srcRow*TILE_LAYER_WIDTH;
        int srcCol=srcStartX;
        for(int destCol=0;destCol<SCREEN_WIDTH_CELLS;destCol++){
            int tileDef=*(tileData+yOff+srcCol);
            *spr++=*(tDef+(tileDef*8));
            *smr++=*(tDef+(tileDef*8)+(256*8));
            if(++srcCol==TILE_LAYER_WIDTH){
                srcCol=0;
            }
        }

        // Now shift pixels left if necessary

        if(leftShift){
            int tileDef=*(tileData+yOff+srcCol);
            uint8_t carry=*(tDef+(tileDef*8));
            uint8_t carryM=*(tDef+(tileDef*8)+(256*8));
            const int ramOff=(destRow*SCREEN_WIDTH_CELLS)+31;
            uint8_t *rotP=scratchPixRam+ramOff;
            uint8_t *rotM=scratchMaskRam+ramOff;
            for (int x=31;x>=0;x--){  // Process right-to-left
                uint8_t current=*rotP;
                uint8_t rotated=(current<<leftShift) | (carry>>(8-leftShift));
                *rotP=rotated;
                carry=current;
                --rotP;

                current=*rotM;
                rotated=(current<<leftShift) | (carryM>>(8-leftShift));
                *rotM=rotated;
                carryM=current;
                --rotM;
            }
        }

        if(++srcRowOffY==8){
            srcRowOffY=0;
            if(++srcRow==TILE_LAYER_HEIGHT){
                srcRow=0;
            }
        }

    }

    // Now draw attributes directly to the render buffer. Any attribute 
    // color with flashing bit set means (don't update this cell)
    srcRow=((srcStartY*8)+srcRowOffY)/4;
    const uint8_t *am=tL->attrMap;
    if(leftShift>3){
        if(++srcStartX==TILE_LAYER_WIDTH){
            srcStartX=0;
        }
    }

    uint8_t *destAttrBuffer=renderAttrBuffer;
    for(int destRow=0;destRow<(SCREEN_HEIGHT_CELLS*2);destRow++){
        // Go through 32 cols for each pixel row, picking up the correct char defs for the 8x8 cell, and scan-line offset
        int srcCol=srcStartX;
        int yOff=srcRow*(TILE_LAYER_WIDTH);
        for(int destCol=0;destCol<SCREEN_WIDTH_CELLS;destCol++){
            uint8_t col=*(am+yOff+srcCol);
            if((col&0x80)==0){
                *destAttrBuffer=col;
            }
            ++destAttrBuffer;
            if(++srcCol==TILE_LAYER_WIDTH){
                srcCol=0;
            }
        }
        if(++srcRow==TILE_LAYER_ATTR_HEIGHT){
            srcRow=0;
        }
    }

}

void blitBitmapLayerToScratchBuffers(int layerIX)
{
    const int lineBufferLen=260;
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->bitmapDefPtr==NULL){
        return; // Nothing to draw...
    }

    if(tL->transformed || tL->lineTransforms){
        blitBitmapLayerTransformed(tL);
        return;
    }

    // If layer is off screen, don't draw it
    if(
        (tL->x<=-(tL->bitmapCharWidth*8)) ||
        (tL->x>=SCREEN_WIDTH_PIXELS) ||
        (tL->y<=-(tL->bitmapHeight)) ||
        (tL->y>=SCREEN_HEIGHT_LINES) 
    ){
        return;
    }
    
    int srcY=0;
    int srcX=0;
    int dstWidth=tL->bitmapCharWidth;
    int dstHeight=tL->bitmapHeight;
    int dstXChar=(tL->x/8);
    int rightShift=(tL->x&0x07)&0x07;
    int dstY=tL->y;

    if(dstY<0){
        srcY=-dstY;
        dstY=0;
        dstHeight-=srcY;
    }

    if(tL->x<0){
        srcX=-dstXChar;
        dstXChar=0;
        dstWidth-=srcX;
        if(rightShift){
            ++srcX;
            --dstWidth;
        }
    }

    if((dstXChar+dstWidth)>SCREEN_WIDTH_CELLS){
        dstWidth=(SCREEN_WIDTH_CELLS-dstXChar);
    }

    // When shifted, the bits shifted out of the bitmap's last byte spill into one more screen byte. Only add it when
    // the bitmap's right edge is drawn and the extra byte is on screen - otherwise it would be written one byte past
    // the end of each row (and past the end of scratchPixRam and renderAttrBuffer on the last row)
    const int add1=(rightShift && ((srcX+dstWidth)==tL->bitmapCharWidth) && ((dstXChar+dstWidth)<SCREEN_WIDTH_CELLS))?1:0;

    if((dstY+dstHeight)>SCREEN_HEIGHT_LINES){
        dstHeight=(SCREEN_HEIGHT_LINES-dstY);
    }

    memset(pixLineBuffer,0,lineBufferLen);
    const uint8_t *srcP=tL->bitmapDefPtr+(tL->bitmapCharWidth*srcY)+srcX;
    const uint8_t *srcAP=tL->attrDefPtr+(tL->bitmapCharWidth*(srcY/ATTR_HEIGHT_PIXELS))+srcX;

    uint8_t *spr=scratchPixRam+(dstY*SCREEN_WIDTH_CELLS)+dstXChar;
    uint8_t *smr=scratchMaskRam+(dstY*SCREEN_WIDTH_CELLS)+dstXChar;
    uint8_t *rb=renderAttrBuffer+((dstY/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS)+dstXChar;
    int aLCnt=1;
    for(int y=0;y<dstHeight;y++){
        uint8_t carry=0;
        if((rightShift>0) && (srcX>0)){
            carry=*(srcP-1);
            carry<<=(8-rightShift);
        }
        if(rightShift){
            for(int x=0;x<dstWidth;x++){
                uint8_t b=*(srcP+x);
                uint8_t newCarry=b<<(8-rightShift);
                b=(b>>rightShift)|carry;
                carry=newCarry;
                *(spr+x)=b;
            }
            if(add1){
                *(spr+dstWidth)=carry;
            }
        }else{
            for(int x=0;x<dstWidth;x++){
                *(spr+x)=*(srcP+x);
            }
        }
        if(tL->opaque){
            // Clear the mask where the bitmap is, so it hides the layers behind. When shifted, the first byte (if the
            // bitmap's left edge is on screen) and the spill byte are only partly covered
            for(int x=0;x<dstWidth;x++){
                *(smr+x)=0;
            }
            if(rightShift){
                if(srcX==0 && dstWidth>0){
                    *smr=(uint8_t)(0xff<<(8-rightShift));
                }
                if(add1){
                    *(smr+dstWidth)=(uint8_t)(0xff>>rightShift);
                }
            }
        }
        srcP+=tL->bitmapCharWidth;
        spr+=SCREEN_WIDTH_CELLS;
        smr+=SCREEN_WIDTH_CELLS;

        if(--aLCnt==0){
            aLCnt=dstHeight-y;
            if(aLCnt>4){
                aLCnt=4;
            }
            const int attrWidth=(add1?dstWidth+1:dstWidth);
            if(tL->globalAttr>0){
                const uint8_t col=tL->globalAttr;
                if((col&0x80)==0){
                    for(int x=0;x<attrWidth;x++){
                        *(rb+x)=col;
                    }
                }
            }else{
                for(int x=0;x<attrWidth;x++){
                    // The spill byte (x==dstWidth) holds pixels from the bitmap's last column, so use its attribute
                    uint8_t col=*(srcAP+((x<dstWidth)?x:dstWidth-1));
                    if((col&0x80)==0){
                        *(rb+x)=col;
                    }
                }
                srcAP+=tL->bitmapCharWidth;
            }
            rb+=SCREEN_WIDTH_CELLS;
        }
    }


}


// ---------------------------------------------------------------------------
// Rotation, scaling and Mode 7 style line transforms
// ---------------------------------------------------------------------------

void setLayerTransform(int layerIX, float angle, float scaleX, float scaleY)
{
    TileLayer *t=tileLayer+layerIX;
    // Negative scales mirror the layer, but avoid dividing by zero
    if(fabsf(scaleX)<0.01f){
        scaleX=(scaleX<0.0f)?-0.01f:0.01f;
    }
    if(fabsf(scaleY)<0.01f){
        scaleY=(scaleY<0.0f)?-0.01f:0.01f;
    }
    t->angle=angle;
    t->scaleX=scaleX;
    t->scaleY=scaleY;

    // Inverse of rotate then scale, so each screen pixel can be mapped back to a layer pixel
    const float c=cosf(angle);
    const float s=sinf(angle);
    t->dudx=c/scaleX;
    t->dudy=s/scaleX;
    t->dvdx=-s/scaleY;
    t->dvdy=c/scaleY;
    // Forward (layer to screen) - scale then rotate
    t->fwdXX=c*scaleX;
    t->fwdXY=-s*scaleY;
    t->fwdYX=s*scaleX;
    t->fwdYY=c*scaleY;

    const float e=0.00001f;
    t->transformed=!(fabsf(t->dudx-1.0f)<e && fabsf(t->dudy)<e && fabsf(t->dvdx)<e && fabsf(t->dvdy-1.0f)<e);
}

void setLayerPivot(int layerIX, float x, float y)
{
    tileLayer[layerIX].pivotX=x;
    tileLayer[layerIX].pivotY=y;
}

void clearLayerTransform(int layerIX)
{
    TileLayer *t=tileLayer+layerIX;
    t->angle=0.0f;
    t->scaleX=1.0f;
    t->scaleY=1.0f;
    t->dudx=1.0f;
    t->dudy=0.0f;
    t->dvdx=0.0f;
    t->dvdy=1.0f;
    t->fwdXX=1.0f;
    t->fwdXY=0.0f;
    t->fwdYX=0.0f;
    t->fwdYY=1.0f;
    t->transformed=false;
    t->lineTransforms=NULL;
}

void setLayerOpaque(int layerIX, bool opaque)
{
    tileLayer[layerIX].opaque=opaque;
}

void setLayerColourAware(int layerIX, bool colourAware)
{
    tileLayer[layerIX].colourAware=colourAware;
}

void setLayerLineTransforms(int layerIX, const LayerLineTransform *lines)
{
    tileLayer[layerIX].lineTransforms=lines;
}

void buildLayerPerspective(LayerLineTransform *lines, float camX, float camY, float angle, float camHeight, float horizonY, float focalLength)
{
    // Lines further away than this are left blank - they'd only show noise, and would overflow 16.16 fixed point
    const float maxDist=8192.0f;
    const float fwdX=sinf(angle);
    const float fwdY=-cosf(angle);
    const float rightX=cosf(angle);
    const float rightY=sinf(angle);
    const float left=0.5f-(float)(SCREEN_WIDTH_PIXELS/2);

    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        LayerLineTransform *l=lines+y;
        const float dy=((float)y+0.5f)-horizonY;
        const float dist=(dy>0.0f)?(camHeight*focalLength)/dy:maxDist;
        if(dist>=maxDist){
            l->enabled=0;
            continue;
        }
        // Layer pixels per screen pixel at this distance
        const float scale=dist/focalLength;
        const float centreX=camX+(fwdX*dist);
        const float centreY=camY+(fwdY*dist);
        l->u=FIXED16(centreX+(rightX*scale*left));
        l->v=FIXED16(centreY+(rightY*scale*left));
        l->dudx=FIXED16(rightX*scale);
        l->dvdx=FIXED16(rightY*scale);
        l->enabled=1;
    }
}

/// @brief Get how a screen line samples the layer, either from the line table, or from the layer's rotation/scale
/// @return False if the line should not be drawn
static inline bool getLayerLine(const TileLayer *tL, int y, LayerLineTransform *lt)
{
    if(tL->lineTransforms){
        *lt=tL->lineTransforms[y];
        return lt->enabled!=0;
    }
    // The layer position at the pivot, then step back to the centre of screen pixel 0 on this line
    const float dx=0.5f-tL->pivotX;
    const float dy=((float)y+0.5f)-tL->pivotY;
    const float pu=tL->pivotX-(float)tL->x;
    const float pv=tL->pivotY-(float)tL->y;
    lt->u=FIXED16(pu+(tL->dudx*dx)+(tL->dudy*dy));
    lt->v=FIXED16(pv+(tL->dvdx*dx)+(tL->dvdy*dy));
    lt->dudx=FIXED16(tL->dudx);
    lt->dvdx=FIXED16(tL->dvdx);
    lt->enabled=1;
    return true;
}

static inline int32_t wrapFixed(int64_t p, int32_t lim)
{
    // 32 bit modulo uses the hardware divider - 64 bit is a slow software routine on the Cortex-M33
    int32_t r=fitsInt32(p)?((int32_t)p%lim):(int32_t)(p%lim);
    return (r<0)?r+lim:r;
}

static void __no_inline_not_in_flash_func(blitTileLayerTransformed)(const TileLayer *tL)
{
    const uint8_t *defs=tL->tileDefPtr;
    const uint8_t *mDefs=defs+(256*8);
    const uint8_t *map=tL->tileMap;
    uint8_t *spr=scratchPixRam;
    uint8_t *smr=scratchMaskRam;
    LayerLineTransform lt;

    // The tile map is 512x512 pixels and always wraps, so positions are simply masked (unsigned maths wraps negatives too)
    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        if(!getLayerLine(tL,y,&lt)){
            spr+=SCREEN_WIDTH_CELLS;
            smr+=SCREEN_WIDTH_CELLS;
            continue;
        }
        uint32_t u=(uint32_t)lt.u;
        uint32_t v=(uint32_t)lt.v;
        const uint32_t du=(uint32_t)lt.dudx;
        const uint32_t dv=(uint32_t)lt.dvdx;

        if(dv==0){
            // Not rotated on this line, so it reads a single pixel row of the map, and neighbouring pixels usually
            // share a tile, so only look up the tile when the column changes
            const uint32_t vi=v>>16;
            const uint8_t *rowMap=map+((vi&0x1f8)<<3);
            const uint8_t *rowDefs=defs+(vi&7);
            const uint8_t *rowMDefs=mDefs+(vi&7);
            uint32_t lastCol=0xffffffff;
            uint32_t pb=0, mb=0xff;
            for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                uint32_t pix=0, msk=0;
                for(int b=0;b<8;b++){
                    const uint32_t ui=u>>16;
                    const uint32_t col=(ui>>3)&(TILE_LAYER_WIDTH-1);
                    if(col!=lastCol){
                        lastCol=col;
                        const uint32_t tileOff=(uint32_t)rowMap[col]<<3;
                        pb=rowDefs[tileOff];
                        mb=rowMDefs[tileOff];
                    }
                    const uint32_t sh=(~ui)&7;
                    pix=(pix<<1)|((pb>>sh)&1);
                    msk=(msk<<1)|((mb>>sh)&1);
                    u+=du;
                }
                *spr++=(uint8_t)pix;
                *smr++=(uint8_t)msk;
            }
        }else{
            for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                uint32_t pix=0, msk=0;
                for(int b=0;b<8;b++){
                    const uint32_t ui=u>>16;
                    const uint32_t vi=v>>16;
                    const uint32_t tileOff=((uint32_t)map[((vi&0x1f8)<<3)|((ui>>3)&(TILE_LAYER_WIDTH-1))]<<3)|(vi&7);
                    const uint32_t sh=(~ui)&7;
                    pix=(pix<<1)|((defs[tileOff]>>sh)&1);
                    msk=(msk<<1)|((mDefs[tileOff]>>sh)&1);
                    u+=du;
                    v+=dv;
                }
                *spr++=(uint8_t)pix;
                *smr++=(uint8_t)msk;
            }
        }
    }

    // Attributes are sampled at the centre of each 8x4 screen cell. Flash bit set means don't change the cell
    uint8_t *aP=renderAttrBuffer;
    for(int cy=0;cy<ATTR_HEIGHT_CELLS;cy++){
        if(getLayerLine(tL,(cy*ATTR_HEIGHT_PIXELS)+(ATTR_HEIGHT_PIXELS/2),&lt)){
            for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                const uint32_t px=(cx*8)+4;
                const uint32_t ui=((uint32_t)lt.u+(px*(uint32_t)lt.dudx))>>16;
                const uint32_t vi=((uint32_t)lt.v+(px*(uint32_t)lt.dvdx))>>16;
                const uint8_t col=tL->attrMap[(((vi>>2)&(TILE_LAYER_ATTR_HEIGHT-1))*TILE_LAYER_WIDTH)+((ui>>3)&(TILE_LAYER_WIDTH-1))];
                if((col&0x80)==0){
                    aP[cx]=col;
                }
            }
        }
        aP+=SCREEN_WIDTH_CELLS;
    }
}

// ---------------------------------------------------------------------------
// Colour-aware resampling, for transformed bitmap layers with per cell attributes
// ---------------------------------------------------------------------------
// Once a bitmap is scaled or rotated, its 8x4 attribute cells no longer line up with the screen's. Resampling the
// pixels and attributes separately then shows pixels in the wrong colours - e.g. art that draws black as "black ink"
// on solid pixels turns white where those pixels land in a cell with white ink. Instead, each pixel's actual colour
// (the ink or paper of its source cell) is found, and it's set if that colour is closer to the destination cell's ink
// than its paper.

// For each source attribute: (paper colour<<4)|ink colour, as 0-15 (bright in bit 3)
static uint8_t colourOfAttr[256];
// For each destination attribute: bit n set if colour n is drawn as ink (it's closer to the ink than the paper)
static uint16_t attrInkMask[256];
static bool colourTablesBuilt=false;

static void buildColourTables(void)
{
    if(colourTablesBuilt){
        return;
    }
    // Spectrum colours are GRB bits, at 215 (normal) or 255 (bright) - bright black is still black
    int rgb[16][3];
    for(int c=0;c<16;c++){
        const int level=(c&8)?255:215;
        rgb[c][0]=(c&2)?level:0;
        rgb[c][1]=(c&4)?level:0;
        rgb[c][2]=(c&1)?level:0;
    }
    for(int a=0;a<256;a++){
        const int bright=(a&0x40)?8:0;
        const int ink=(a&7)|bright;
        const int paper=((a>>3)&7)|bright;
        colourOfAttr[a]=(uint8_t)((paper<<4)|ink);
        uint32_t mask=0;
        for(int c=0;c<16;c++){
            int distInk=0, distPaper=0;
            for(int k=0;k<3;k++){
                const int di=rgb[c][k]-rgb[ink][k];
                const int dp=rgb[c][k]-rgb[paper][k];
                distInk+=di*di;
                distPaper+=dp*dp;
            }
            if(distInk<distPaper){
                mask|=1u<<c;
            }
        }
        attrInkMask[a]=(uint16_t)mask;
    }
    colourTablesBuilt=true;
}

/// @brief Draw screen pixels x to end of one line of a non-wrapping transformed bitmap (all inside the bitmap).
/// colourAware and rowFixed are constants at each call, so the compiler builds a separate loop for each combination.
/// rowFixed is for unrotated lines (dv==0), which read a single row of the bitmap and its attributes
static inline __attribute__((always_inline)) void drawBitmapSpan(const TileLayer *tL, int32_t u, int32_t v,
    const int32_t du, const int32_t dv, int x, const int end, uint8_t *spr, uint8_t *smr, const uint8_t *destAttrRow,
    const bool colourAware, const bool rowFixed)
{
    const int charWidth=tL->bitmapCharWidth;
    const uint8_t *bmp=tL->bitmapDefPtr;
    const uint8_t *attrs=tL->attrDefPtr;
    const uint8_t *bmpRow=bmp+((v>>16)*charWidth);
    const uint8_t *attrRow=colourAware?attrs+(((v>>16)>>2)*charWidth):NULL;
    const bool opaque=tL->opaque;

    while(x<end){
        const int cell=x>>3;
        const int cellEnd=((cell+1)*8<end)?(cell+1)*8:end;
        const int cellStart=x;
        const uint32_t inkMask=colourAware?attrInkMask[destAttrRow[cell]]:0;
        uint32_t pix=0;
        for(;x<cellEnd;x++){
            const int32_t ui=u>>16;
            const int col=ui>>3;
            const uint8_t *row=rowFixed?bmpRow:bmp+((v>>16)*charWidth);
            uint32_t set=(row[col]<<(ui&7))&0x80;
            if(colourAware){
                // The pixel's actual colour, then whether that's ink in the screen cell it's drawn into
                const uint8_t *aRow=rowFixed?attrRow:attrs+(((v>>16)>>2)*charWidth);
                const uint32_t colours=colourOfAttr[aRow[col]];
                set=(inkMask>>(set?(colours&15):(colours>>4)))&1;
            }
            if(set){
                pix|=0x80>>(x&7);
            }
            u+=du;
            if(!rowFixed){
                v+=dv;
            }
        }
        spr[cell]|=(uint8_t)pix;
        if(opaque){
            // Clear the mask for the pixels of this cell inside the bitmap
            const int lo=cellStart&7;
            const uint32_t covered=(0xffu>>lo)&~(0xffu>>(lo+(cellEnd-cellStart)));
            smr[cell]&=(uint8_t)~covered;
        }
    }
}

static void __no_inline_not_in_flash_func(blitBitmapLayerTransformed)(const TileLayer *tL)
{
    const int charWidth=tL->bitmapCharWidth;
    const int32_t limU=(charWidth*8)<<16;
    const int32_t limV=tL->bitmapHeight<<16;
    const bool wrap=(tL->layerType==LT_BITMAP_WRAP);
    const uint8_t *bmp=tL->bitmapDefPtr;
    const uint8_t *attrs=tL->attrDefPtr;
    const bool colourAware=tL->colourAware && tL->globalAttr==0 && attrs!=NULL;
    LayerLineTransform lt;

    if(limU==0 || limV==0){
        return;
    }

    // Attributes first - sampled at the centre of each 8x4 screen cell - as colour-aware pixels need the colours of
    // the screen cells they're drawn into. Cells not covered keep the colour of the layers behind
    if(tL->globalAttr>0 || attrs!=NULL){
        uint8_t *aP=renderAttrBuffer;
        for(int cy=0;cy<ATTR_HEIGHT_CELLS;cy++){
            if(getLayerLine(tL,(cy*ATTR_HEIGHT_PIXELS)+(ATTR_HEIGHT_PIXELS/2),&lt)){
                for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                    const int64_t px=(cx*8)+4;
                    int64_t u=lt.u+(px*lt.dudx);
                    int64_t v=lt.v+(px*lt.dvdx);
                    if(wrap){
                        u=wrapFixed(u,limU);
                        v=wrapFixed(v,limV);
                    }else if(u<0 || u>=limU || v<0 || v>=limV){
                        continue;
                    }
                    const uint8_t col=(tL->globalAttr>0)?tL->globalAttr:attrs[(((int32_t)(v>>16)>>2)*charWidth)+((int32_t)(u>>16)>>3)];
                    if((col&0x80)==0){
                        aP[cx]=col;
                    }
                }
            }
            aP+=SCREEN_WIDTH_CELLS;
        }
    }

    // Bitmap layers have no mask of their own - set pixels are ORed onto the layers behind (or hide them, if opaque)
    for(int y=0;y<SCREEN_HEIGHT_LINES;y++){
        if(!getLayerLine(tL,y,&lt)){
            continue;
        }
        uint8_t *spr=scratchPixRam+(y*SCREEN_WIDTH_CELLS);
        uint8_t *smr=scratchMaskRam+(y*SCREEN_WIDTH_CELLS);
        const uint8_t *destAttrRow=renderAttrBuffer+((y/ATTR_HEIGHT_PIXELS)*SCREEN_WIDTH_CELLS);

        if(wrap){
            // A wrapping bitmap covers the whole line
            if(tL->opaque){
                memset(smr,0,SCREEN_WIDTH_CELLS);
            }
            // Keep the position inside the bitmap, which only needs a single add/subtract per pixel as long as
            // the step is smaller than the bitmap
            int32_t u=wrapFixed(lt.u,limU);
            int32_t v=wrapFixed(lt.v,limV);
            const int32_t du=lt.dudx%limU;
            const int32_t dv=lt.dvdx%limV;
            for(int cx=0;cx<SCREEN_WIDTH_CELLS;cx++){
                const uint32_t inkMask=colourAware?attrInkMask[destAttrRow[cx]]:0;
                uint32_t pix=0;
                for(int b=0;b<8;b++){
                    const int32_t ui=u>>16;
                    const int32_t vi=v>>16;
                    uint32_t set=(bmp[(vi*charWidth)+(ui>>3)]>>((~ui)&7))&1;
                    if(colourAware){
                        const uint32_t colours=colourOfAttr[attrs[((vi>>2)*charWidth)+(ui>>3)]];
                        set=(inkMask>>(set?(colours&15):(colours>>4)))&1;
                    }
                    pix=(pix<<1)|set;
                    u+=du;
                    if(u>=limU){
                        u-=limU;
                    }else if(u<0){
                        u+=limU;
                    }
                    v+=dv;
                    if(v>=limV){
                        v-=limV;
                    }else if(v<0){
                        v+=limV;
                    }
                }
                spr[cx]|=(uint8_t)pix;
            }
        }else{
            // Only visit the pixels on this line that land inside the bitmap
            int start=0, end=SCREEN_WIDTH_PIXELS;
            clipSpan(lt.u,lt.dudx,limU,&start,&end);
            clipSpan(lt.v,lt.dvdx,limV,&start,&end);
            if(start>=end){
                continue;
            }
            const int32_t u=(int32_t)(lt.u+((int64_t)start*lt.dudx));
            const int32_t v=(int32_t)(lt.v+((int64_t)start*lt.dvdx));
            if(lt.dvdx==0){
                if(colourAware){
                    drawBitmapSpan(tL,u,v,lt.dudx,0,start,end,spr,smr,destAttrRow,true,true);
                }else{
                    drawBitmapSpan(tL,u,v,lt.dudx,0,start,end,spr,smr,destAttrRow,false,true);
                }
            }else{
                if(colourAware){
                    drawBitmapSpan(tL,u,v,lt.dudx,lt.dvdx,start,end,spr,smr,destAttrRow,true,false);
                }else{
                    drawBitmapSpan(tL,u,v,lt.dudx,lt.dvdx,start,end,spr,smr,destAttrRow,false,false);
                }
            }
        }
    }
}


// ---------------------------------------------------------------------------
// Collision support - tile layers only, using the tiles' pixels (not their masks), mapped to the screen exactly as
// the renderers draw them
// ---------------------------------------------------------------------------

bool isLayerCollidable(int layerIX)
{
    if(layerIX<0 || layerIX>=MAX_TILE_LAYERS){
        return false;
    }
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->layerType!=LT_TILE || tL->tileDefPtr==NULL){
        return false;
    }
    if(tL->transformed || tL->lineTransforms){
        return true;
    }
    // The same off screen test as the renderer
    return !((tL->x<=-TILE_LAYER_WIDTH*8*2) || (tL->x>=SCREEN_WIDTH_PIXELS) ||
        (tL->y<=-TILE_LAYER_HEIGHT*8*2) || (tL->y>=SCREEN_HEIGHT_LINES));
}

/// @brief n pixels (1-32) of the tile map at layer pixel lx,ly (wrapping at 512), in the top n bits. Only the tile bytes
/// covering those pixels are read
static inline uint32_t mapPixels(const TileLayer *tL, uint32_t lx, uint32_t ly, int n)
{
    lx&=(TILE_LAYER_WIDTH*8)-1;
    ly&=(TILE_LAYER_HEIGHT*8)-1;
    const uint8_t *rowDefs=tL->tileDefPtr+(ly&7);
    const uint8_t *rowMap=tL->tileMap+((ly>>3)*TILE_LAYER_WIDTH);
    const uint32_t tx=lx>>3;
    const int bytes=(int)(((lx&7)+(uint32_t)n+7)>>3);
    uint64_t bits=0;
    for(int b=0;b<bytes;b++){
        bits=(bits<<8)|rowDefs[(uint32_t)rowMap[(tx+(uint32_t)b)&(TILE_LAYER_WIDTH-1)]<<3];
    }
    // Line the bytes up as if all 5 had been read, then shift the first pixel into bit 31
    bits<<=8*(5-bytes);
    const uint32_t out=(uint32_t)(bits>>(8-(lx&7)));
    return (n>=32)?out:(out&~(0xffffffffu>>n));
}

uint32_t __not_in_flash_func(getLayerPixelsN)(int layerIX, int x, int y, int n)
{
    if(y<0 || y>=SCREEN_HEIGHT_LINES || !isLayerCollidable(layerIX)){
        return 0;
    }
    const TileLayer *tL=tileLayer+layerIX;

    if(tL->transformed || tL->lineTransforms){
        // Sample as blitTileLayerTransformed does - screen pixel x is at lt.u+(x*dudx)
        const uint8_t *defs=tL->tileDefPtr;
        const uint8_t *map=tL->tileMap;
        LayerLineTransform lt;
        if(!getLayerLine(tL,y,&lt)){
            return 0;
        }
        uint32_t u=(uint32_t)lt.u+((uint32_t)x*(uint32_t)lt.dudx);
        uint32_t v=(uint32_t)lt.v+((uint32_t)x*(uint32_t)lt.dvdx);
        uint32_t bits=0;
        for(int i=0;i<n;i++){
            const uint32_t ui=u>>16;
            const uint32_t vi=v>>16;
            const uint32_t tileOff=((uint32_t)map[((vi&0x1f8)<<3)|((ui>>3)&(TILE_LAYER_WIDTH-1))]<<3)|(vi&7);
            bits=(bits<<1)|((defs[tileOff]>>((~ui)&7))&1);
            u+=(uint32_t)lt.dudx;
            v+=(uint32_t)lt.dvdx;
        }
        return (n>=32)?bits:(bits<<(32-n));
    }

    // Scrolled only: screen pixel x,y shows layer pixel (x-layerX, y-layerY)
    return mapPixels(tL,(uint32_t)(x-tL->x),(uint32_t)(y-tL->y),n);
}

uint32_t getLayerPixels32(int layerIX, int x, int y)
{
    return getLayerPixelsN(layerIX,x,y,32);
}

uint32_t __not_in_flash_func(getLayerMapPixels)(int layerIX, int x, int y, int n)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(layerIX<0 || layerIX>=MAX_TILE_LAYERS || tL->layerType!=LT_TILE || tL->tileDefPtr==NULL){
        return 0;
    }
    return mapPixels(tL,(uint32_t)x,(uint32_t)y,n);
}

bool getLayerTileAt(int layerIX, int x, int y, int *tileX, int *tileY)
{
    if(x<0 || x>=SCREEN_WIDTH_PIXELS || y<0 || y>=SCREEN_HEIGHT_LINES || !isLayerCollidable(layerIX)){
        return false;
    }
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->transformed || tL->lineTransforms){
        LayerLineTransform lt;
        if(!getLayerLine(tL,y,&lt)){
            return false;
        }
        const uint32_t u=(uint32_t)lt.u+((uint32_t)x*(uint32_t)lt.dudx);
        const uint32_t v=(uint32_t)lt.v+((uint32_t)x*(uint32_t)lt.dvdx);
        *tileX=(int)((u>>19)&(TILE_LAYER_WIDTH-1));
        *tileY=(int)((v>>19)&(TILE_LAYER_HEIGHT-1));
    }else{
        *tileX=(int)((((uint32_t)(x-tL->x))>>3)&(TILE_LAYER_WIDTH-1));
        *tileY=(int)((((uint32_t)(y-tL->y))>>3)&(TILE_LAYER_HEIGHT-1));
    }
    return true;
}

// Which tiles of a tile set have no pixels, for the tile set used most recently. If a tile set's graphics are changed
// in RAM after use, they're picked up next time a different tile set is looked at
static const uint8_t *emptyTilesFor=NULL;
static uint32_t emptyTiles[256/32];

bool isLayerTileEmpty(int layerIX, int tileX, int tileY)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->tileDefPtr==NULL){
        return true;
    }
    if(emptyTilesFor!=tL->tileDefPtr){
        emptyTilesFor=tL->tileDefPtr;
        for(int t=0;t<256;t++){
            const uint8_t *d=tL->tileDefPtr+(t*8);
            const bool empty=(d[0]|d[1]|d[2]|d[3]|d[4]|d[5]|d[6]|d[7])==0;
            if(empty){
                emptyTiles[t>>5]|=1u<<(t&31);
            }else{
                emptyTiles[t>>5]&=~(1u<<(t&31));
            }
        }
    }
    const uint32_t t=tL->tileMap[((tileY&(TILE_LAYER_HEIGHT-1))*TILE_LAYER_WIDTH)+(tileX&(TILE_LAYER_WIDTH-1))];
    return (emptyTiles[t>>5]>>(t&31))&1;
}

bool isLayerAreaEmpty(int layerIX, int x0, int y0, int x1, int y1)
{
    if(!isLayerCollidable(layerIX)){
        return true;
    }
    const TileLayer *tL=tileLayer+layerIX;
    if(tL->transformed || tL->lineTransforms){
        return false;
    }
    return isLayerMapAreaEmpty(layerIX,x0-tL->x,y0-tL->y,x1-tL->x,y1-tL->y);
}

bool isLayerMapAreaEmpty(int layerIX, int x0, int y0, int x1, int y1)
{
    const TileLayer *tL=tileLayer+layerIX;
    if(layerIX<0 || layerIX>=MAX_TILE_LAYERS || tL->layerType!=LT_TILE || tL->tileDefPtr==NULL){
        return true;
    }
    // Tiles covering the area (wrapping)
    for(int ty=y0>>3;ty<=(y1>>3);ty++){
        for(int tx=x0>>3;tx<=(x1>>3);tx++){
            if(!isLayerTileEmpty(layerIX,tx,ty)){
                return false;
            }
        }
    }
    return true;
}

// ---------------------------------------------------------------------------
// Converting between screen and layer coordinates (scrolled, rotated and scaled layers - not line transformed)
// ---------------------------------------------------------------------------

void screenToLayer(int layerIX, float x, float y, float *u, float *v)
{
    // As getLayerLine: the layer point at the pivot, plus the inverse transform of the offset from the pivot
    const TileLayer *tL=tileLayer+layerIX;
    const float dx=x-tL->pivotX;
    const float dy=y-tL->pivotY;
    *u=(tL->pivotX-(float)tL->x)+(tL->dudx*dx)+(tL->dudy*dy);
    *v=(tL->pivotY-(float)tL->y)+(tL->dvdx*dx)+(tL->dvdy*dy);
}

void layerToScreen(int layerIX, float u, float v, float *x, float *y)
{
    const TileLayer *tL=tileLayer+layerIX;
    const float du=u-(tL->pivotX-(float)tL->x);
    const float dv=v-(tL->pivotY-(float)tL->y);
    *x=tL->pivotX+(tL->fwdXX*du)+(tL->fwdXY*dv);
    *y=tL->pivotY+(tL->fwdYX*du)+(tL->fwdYY*dv);
}

void screenToLayerVector(int layerIX, float dx, float dy, float *du, float *dv)
{
    const TileLayer *tL=tileLayer+layerIX;
    *du=(tL->dudx*dx)+(tL->dudy*dy);
    *dv=(tL->dvdx*dx)+(tL->dvdy*dy);
}

void layerToScreenVector(int layerIX, float du, float dv, float *dx, float *dy)
{
    const TileLayer *tL=tileLayer+layerIX;
    *dx=(tL->fwdXX*du)+(tL->fwdXY*dv);
    *dy=(tL->fwdYX*du)+(tL->fwdYY*dv);
}
