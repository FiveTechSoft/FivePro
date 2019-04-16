#include <dos.h>
#include <extend.h>

CLIPPER SetChar()
{
   unsigned int uiChar      = _parni( 1 );
   unsigned char * pucBytes = _parc( 2 );

   asm push es;
   asm push bp;

   _BX = 0x1000;
   _CX = 1;
   _DX = uiChar;
   _ES = FP_SEG( pucBytes );
   _BP = FP_OFF( pucBytes );
   _AX = 0x1100;
   asm int 0x10;

   asm pop bp;
   asm pop es;
}
