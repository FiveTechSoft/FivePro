#include <extend.h>

CLIPPER lIsSpooler()
{
   _AX = 0x0100;
   asm int 0x2F;
   _retl( _AL == 0xFF );
}
