#pragma once 

#include "defs.h"
#include "myTypes.h"
#include "shared.h"
#include "funcs.h"

void gameLoop(void);
void setState(GameState newGS);
void resetStateVars();
void setAttrDirect(int ix, uint8_t v);
