#include <ClipApi.h>

void pascal SetColor( void );

// ----------------------------------------------------------------------------

WORD _gtColorSelect( WORD wColor )          // 0 ... 4

{
   return _gtSetColor( _colors + wColor );
}

// ----------------------------------------------------------------------------

CLIPPER ColorSelec()
{
   _gtColorSelect( _parni( 1 ) );           // 0 ... 4
}

// ----------------------------------------------------------------------------

static void SayHot( BYTE bRow, BYTE bCol, LPSTR szText, LPSTR szClr )
{
  BYTE b = 0;

  while( szText[ b ] && szText[ b ] != '&' )
    b++;

  _tos -= 4; _PutC( szClr ); _pcount = 1; SetColor();

  if( szText[ b ] )
  {
    _gtWriteAt( bRow, bCol, szText, b );
    _gtWriteAt( bRow, bCol + b + 1, szText + b + 2, strlen( szText + b + 2 ) );
    _gtColorSelect( 1 );
    _gtWriteAt( bRow, bCol + b, szText + b + 1, 1 );
  }
  else
    _gtWriteAt( bRow, bCol, szText, strlen( szText ) );

  _tos--; _PutC( _parc( -1 ) ); _pcount = 1; SetColor();
}

// ----------------------------------------------------------------------------

CLIPPER SAYHOT()
{
  SayHot( _parni( 1 ), _parni( 2 ), _parc( 3 ), _parc( 4 ) );
}

// ----------------------------------------------------------------------------
