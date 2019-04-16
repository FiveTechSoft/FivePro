#include <ClipApi.h>

CLIPPER LocalVal()
{
   _bcopy( ( LPBYTE ) _eval,
           ( LPBYTE ) ( _ActInfo( 1 ) + _parni( 1 ) + 1 ),
           sizeof( CLIPVAR ) );
}
