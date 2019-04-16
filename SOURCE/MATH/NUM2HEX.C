#include <windows.h>
#include <ClipApi.h>

LPSTR _u2hex( WORD );

CLIPPER cNum2Hex()
{
   _retclen( _u2hex( _parni( 1 ) ), 4 );
}

CLIPPER nHiWord()
{
   _retni( HIWORD( _parnl( 1 ) ) );
}

CLIPPER nLoWord()
{
   _retni( LOWORD( _parnl( 1 ) ) );
}
