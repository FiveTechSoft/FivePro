#include <extend.h>

CLIPPER nBin2Dec()
{
   char * pcBin          = _parc( 1 );
   unsigned int uiLen    = _parclen( 1 );
   unsigned int uiResult = 0;
   unsigned int ui;

   for( ui = 0; ui < uiLen; ui++ )
      uiResult |= ( ( pcBin[ ui ] != '0' ) ?
                    ( 0x8000 >> ( 15 - ( uiLen - ui - 1 ) ) ): 0 );

   _retni( uiResult );
}
