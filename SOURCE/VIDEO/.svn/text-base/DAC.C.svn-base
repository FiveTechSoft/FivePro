#include <ClipApi.h>
#include <dos.h>

CLIPPER SetDac()
{
   BYTE bDac = _parni( 1 );
   BYTE bColor[ 3 ];

   bColor[ 0 ] = _parni( 2 );
   bColor[ 1 ] = _parni( 3 );
   bColor[ 2 ] = _parni( 4 );

   while( ! ( inport( 0x3DA ) & 8 ) );
   _BX = bDac;
   _CX = 1;
   _ES = FP_SEG( bColor );
   _DX = FP_OFF( bColor );
   _AX = 0x1012;
   asm int 0x10;
}
