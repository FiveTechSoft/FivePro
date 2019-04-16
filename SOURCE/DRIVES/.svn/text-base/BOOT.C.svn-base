#include <ClipApi.h>
#include <dos.h>

CLIPPER Boot()
{
   BYTE bBuffer[ 512 ];

   _CH = 0;
   _CL = 1;
   _DH = 1;
   _DL = 0x80;
   _ES = FP_SEG( bBuffer );
   _BX = FP_OFF( bBuffer );
   _AL = 1;
   _AH = 2;
   asm int 0x13;

   _retnl( * ( LONG * ) ( bBuffer + 0x27 ) );
}
