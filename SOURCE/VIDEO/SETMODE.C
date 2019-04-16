#include <ClipApi.h>

CLIPPER SETMODE()
{
   _AL = _parni( 1 );
   _AH = 0;
   asm int 0x10;
}
