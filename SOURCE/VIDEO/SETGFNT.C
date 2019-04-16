#include <ClipApi.h>
#include <dos.h>

CLIPPER SetGFont()
{
   LPBYTE pFont = _parc( 1 );

   asm push bp;
   asm push es;

   _CX = 0x10;
   _BL = 0;
   _DL = 20;
   _ES = FP_SEG( pFont );
   _BP = FP_OFF( pFont );
   _AH = 0x11;
   _AL = 0x21;
   asm int 0x10;

   asm pop es;
   asm pop bp;
}
