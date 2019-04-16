#include <dos.h>
#include "extend.h"

CLIPPER lIsEga()
{
   _AH = 0x12;
   _BX = 0xFF10;
   asm int 0x10;

   _retl( _BX != 0xFF10 );
}
