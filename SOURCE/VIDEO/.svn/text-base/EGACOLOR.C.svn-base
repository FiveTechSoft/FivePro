#include "extend.h"

CLIPPER EgaColor()
{
   unsigned char ucRegister = _parni( 1 );
   unsigned char ucValue    = _parni( 2 );

   _AL = 0;
   _BL = ucRegister;
   _BH = ucValue;
   _AH = 0x10;
   asm int 0x10;
}
