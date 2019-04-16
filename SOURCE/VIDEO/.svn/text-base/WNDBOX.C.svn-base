#include <ClipApi.h>

void _gtClrReverse( WORD wColor )
{
   COLOR colors[ 5 ];
   RGB   rgbFore;

   _bcopy( ( LPBYTE ) colors, ( LPBYTE ) _colors, sizeof( COLOR ) * 5 );
   _bcopy( ( LPBYTE ) &rgbFore, ( LPBYTE ) &( colors[ wColor ].Fore ), sizeof( RGB ) );
   _bcopy( ( LPBYTE ) &( colors[ 0 ].Fore ), ( LPBYTE ) &( colors[ wColor ].Back ), sizeof( RGB ) );
   _bcopy( ( LPBYTE ) &( colors[ 0 ].Back ), ( LPBYTE ) &rgbFore, sizeof( RGB ) );
   _gtSetColor( colors );
}

void _gtWndBox( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight )
{
   WORD w;
   COLOR clrOld[ 5 ];
   COLOR clrNew[ 5 ];

   _gtRepChar( wTop, wLeft + 1, 207, wRight - wLeft - 1 );

   _gtClrReverse( 0 );
   for( w = 1; w < wBottom - wTop; w++ )
      _gtWriteAt( wTop + w, wLeft, "¾", 1 );
   _gtClrReverse( 0 );

   _gtColorSelect( 1 );
   for( w = 1; w < wBottom - wTop; w++ )
      _gtWriteAt( wTop + w, wRight, "½", 1 );
   _gtRepChar( wBottom, wLeft + 1, 208, wRight - wLeft - 1 );

   _gtColorSelect( 3 );
   _gtScroll( wTop + 1, wLeft + 1, wBottom - 1, wRight - 1, 0 );
   _gtColorSelect( 0 );
}

void _gtButton( WORD wRow, WORD wCol, LPSTR szText )
{
   _gtWndBox( wRow, wCol, wRow + 2, wCol + strlen( szText ) );
   _gtSayHot( wRow + 1, wCol + 1, szText, 0x70, 123 );
}

CLIPPER WndButton()
{
   _gtButton( _parni( 1 ), _parni( 2 ), _parc( 3 ) );
}

CLIPPER WndBox()
{
   _gtWndBox( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ) );
}
