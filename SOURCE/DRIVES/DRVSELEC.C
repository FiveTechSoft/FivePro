#include "extend.h"

CLIPPER DvrSelect()
{
   unsigned char ucDrive = _parni( 1 );

   _AH = 0x0E;
   _DL = ucDrive;
   asm int 0x21;
}
