#include <extend.h>

CLIPPER lPrnPaper()
{
   unsigned int uiPort = _parni( 1 );
   unsigned char ucStatus;

   _AH = 2;
   _DX = uiPort;
   asm int 0x17;
   ucStatus = _AH;

   _retl( ( ucStatus & 32 ) ? 0: 1 );
}
