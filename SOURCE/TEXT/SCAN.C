#include <ClipApi.h>

WORD _fstrstr( LPSTR, LPSTR );

CLIPPER StrScan()
{
   _retni( _fstrstr( _parc( 1 ), _parc( 2 ) ) );
}
