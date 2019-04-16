#include <extend.h>

CLIPPER SetText()
{
   _AH = 0;
   _AL = 3;
   asm int 0x10;
}
