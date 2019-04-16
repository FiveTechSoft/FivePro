#include <extend.h>

CLIPPER nVgaRed()
{
   _BX = _parni( 1 );
   _AX = 0x1015;
   asm int 0x10;
   _retni( _DH );
}

CLIPPER nVgaGreen()
{
   _BX = _parni( 1 );
   _AX = 0x1015;
   asm int 0x10;
   _retni( _CH );
}

CLIPPER nVgaBlue()
{
   _BX = _parni( 1 );
   _AX = 0x1015;
   asm int 0x10;
   _retni( _CL );
}
