#include <extend.h>

CLIPPER cBin2Char()
{
   char * pcBin       = _parc( 1 );
   unsigned int uiLen = _parclen( 1 );
   char cChar         = 0;
   unsigned int ui;

   for( ui = 0; ui < uiLen; ui++ )
      cChar |= ( ( pcBin[ ui ] != '0' ) ?
                 ( 0x8000 >> ( 15 - ( uiLen - ui - 1 ) ) ): 0 );

   _retclen( &cChar, 1 );
}
