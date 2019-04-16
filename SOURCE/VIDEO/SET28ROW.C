#include "extend.h"

CLIPPER Set28Rows()
{
   _AX = 0x1111;
   _BL = 0;
   asm int 0x10;
}
