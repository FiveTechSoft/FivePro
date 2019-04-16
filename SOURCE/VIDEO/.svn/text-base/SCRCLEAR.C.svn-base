#include <extend.h>

CLIPPER ScrClear()
{
   unsigned char ucTop, ucLeft, ucBottom, ucRight, ucColor;

   ucTop    = _parni( 1 );
   ucLeft   = _parni( 2 );
   ucBottom = _parni( 3 );
   ucRight  = _parni( 4 );
   ucColor  = _parni( 5 );

   _BH = ucColor;
   _CH = ucTop;
   _CL = ucLeft;
   _DH = ucBottom;
   _DL = ucRight;
   _AH = 6;
   _AL = 0;
   asm int 0x10;
}
