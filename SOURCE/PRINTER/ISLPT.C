#include <extend.h>

CLIPPER lIsLpt()
{
   _DX = _parni( 1 ) - 1;
   _AH = 2;
   asm int 0x17;
   _retl( _AH == 0x90 );
}
