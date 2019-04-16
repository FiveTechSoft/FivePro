#include <dos.h>
#include "extend.h"

static void MemCopy( char * pcSource, char * pcDest, unsigned int uiLen )
{
   unsigned int ui = 0;

   while( ui < uiLen )
      pcDest[ ui ] = pcSource[ ui++ ];
}

CLIPPER cFontGet()
{
   char * pcFontDir;
   char pcFont[ 256 * 16 ];

   _AX = 0x1130;
   _BH = 0x01;
   asm push bp;
   geninterrupt( 0x10 );
   _AX = _BP;
   asm pop bp;
   pcFontDir = MK_FP( _ES, _AX );
   MemCopy( pcFontDir + ( 256 * 9 ) + ( 256 * 14 ) + 45, pcFont, 256 * 16 );

   _AX = 0x1130;
   _BH = 0;
   asm push bp;
   geninterrupt( 0x10 );
   _AX = _BP;
   asm pop bp;
   pcFontDir = MK_FP( _ES, _AX );
   MemCopy( pcFontDir + ( 256 * 9 ) + ( 256 * 14 ) + ( 128 * 16 ),
            pcFont + ( 128 * 16 ), 128 * 16 );

   _retclen( pcFont, 256 * 16 );
}
