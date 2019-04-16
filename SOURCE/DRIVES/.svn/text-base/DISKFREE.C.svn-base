#include <extend.h>

CLIPPER nDiskFree()
{
   _AH = 0x36;
   _DL = 0;
   asm int 0x21;

   _retnl( _AX * _BX * _CX );
}
