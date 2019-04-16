#include <extend.h>

CLIPPER cBin2C()
{
   char * pcBin          = _parc( 1 );
   unsigned int uiLen    = _parclen( 1 );
   unsigned char ucChar[ 1 ];
   unsigned char uc;

   ucChar[ 0 ] = 0;

   for( uc = 0; uc < uiLen; uc++ )
      ucChar[ 0 ] |= ( ( pcBin[ uc ] != '0' ) ?
                       ( 0x8000 >> ( 15 - ( uiLen - uc - 1 ) ) ): 0 );

   _retclen( ucChar, 1 );
}
