#include <extend.h>

CLIPPER nMemExtend()
{
   _AH = 0x88;
   asm int 0x15;
   _retni( _AX * 1024 );
}
