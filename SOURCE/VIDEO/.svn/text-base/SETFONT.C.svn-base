#include <dos.h>
#include "extend.h"

CLIPPER SetFont()
{
   if( PCOUNT )                 // Carga font
   {
      char * pcFont = _parc( 1 );
      char cBlock   = _parni( 2 );

      asm push es;
      asm push bp;

      _BH = 0x10;
      _BL = cBlock;
      _CX = 256;
      _DX = 0;
      _ES = FP_SEG( pcFont );
      _BP = FP_OFF( pcFont );
      _AX = 0x1100;
      asm int 0x10;

      asm pop bp;
      asm pop es;
   }
   else                         // Resetea a font de la ROM
   {
      _AX = 0x1114;
      _BL = 0;
      asm int 0x10;
   }
}
