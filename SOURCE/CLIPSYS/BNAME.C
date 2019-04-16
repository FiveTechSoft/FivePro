#include <ClipApi.h>

LPSTR _tbname( PCLIPVAR, WORD );

CLIPPER BaseName()
{
   _retc( _tbname( _ActInfo( _parni( 1 ) ), _parni( 2 ) ) );
}
