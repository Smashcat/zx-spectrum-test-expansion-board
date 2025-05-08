#include "gameStrings.h"

const int totalStoryEntries=5;

const StoryEntry storyEntry[5]={
    {
        " AWAKEN",

        "Stolen as a child and "
        "genetically modified "
        "to serve as a worker & "
        "guardian to little "
        "sisters. Your mind has "
        "broken its bonds. "
        "You have to save your "
        "little sisters from "
        "this underwater hell "
        "and escape to the "
        "surface!"
    },
    {
        "SAVIOUR",

        "Use your ship to "
        "move between areas "
        "in Rapture, and enter "
        "the airlocks to find "
        "and rescue the sisters "
        "from their captors! "
        "Your ethics will be "
        "tested..."
    },
    {
        " MAKER",

        "Along the way you "
        "may find "
        "useful tools and "
        "upgrades to help "
        "with your mission. "
        "When you collect a "
        "part you will be "
        "shown the parts it "
        "needs to augment "
        "your suit and craft."
    },
    {
        "FIGHTER",

        "Powerful forces "
        "will seek to "
        "maintain their "
        "control over the "
        "city. These must "
        "be overcome to "
        "reach your goal. "
        "You also face danger "
        "from the citizenry "
        "if you anger them."
    },
    {
        "  HERO",

        "Your notoriety rises "
        "with each success in the "
        "city. Will you use your "
        "fame for good, or ill?"
    }
};

int drawStorySection(int layerIX, int storySectionIX, int yPos){
    const char barGfx[9]={24,25,26,27,28,29,30,31,0};
    clearLayerLines(layerIX,yPos,30);
    drawBigTxtToLayer(layerIX,storyEntry[storySectionIX].title,palette[4],1,yPos);
    drawTxtToLayer(layerIX,barGfx,0x44,0x47,1,yPos+2);
    const char *src=storyEntry[storySectionIX].body;
    const int srcLen=strlen(src);
    char lineBuff[25];
    yPos+=4;
    int fromIX=0;
    while(fromIX<srcLen){
        int cpyLen=19;
        if(fromIX+cpyLen>srcLen){
            cpyLen=srcLen-fromIX;
            if(cpyLen==0){
                return yPos;
            }
        }
        memcpy(lineBuff,src+fromIX,cpyLen);
        lineBuff[cpyLen]=0;
        if(cpyLen==19){
            --cpyLen;
            while((lineBuff[cpyLen]!=0) && (lineBuff[cpyLen]!=' ') && (cpyLen>0)){
                --cpyLen;
            }
            if(cpyLen>0){
                lineBuff[cpyLen]=0;
            }
        }
        fromIX+=cpyLen;
        if(*(src+fromIX)==' '){
            ++fromIX;
        }
        drawTxtToLayer(layerIX,lineBuff,0x45,0x47,1,yPos);
        ++yPos;
    }
    return yPos-1;
}