#include <ClipApi.h>

#define MIN(x,y) (x<y?x:y)

WORD wLabelLen( LPSTR szLabel );

//----------------------------------------------------------------------------//

WORD _gtClrGet( WORD wClrPos )
{
   COLOR Colors[ 5 ];
   WORD wColor = 0;

   _gtGetColor( Colors );

   wColor |= ( Colors[ wClrPos ].Fore.Blue )  ? 0x01: 0;
   wColor |= ( Colors[ wClrPos ].Fore.Green ) ? 0x02: 0;
   wColor |= ( Colors[ wClrPos ].Fore.Red )   ? 0x04: 0;
   wColor |= ( Colors[ wClrPos ].Fore.Attr & 0x20 ) ? 0x08: 0;
   wColor |= ( Colors[ wClrPos ].Fore.Attr & 0x80 ) ? 0x80: 0;
   wColor |= ( Colors[ wClrPos ].Back.Blue )  ? 0x10: 0;
   wColor |= ( Colors[ wClrPos ].Back.Green ) ? 0x20: 0;
   wColor |= ( Colors[ wClrPos ].Back.Red )   ? 0x40: 0;

   return wColor;
}

//----------------------------------------------------------------------------//

WORD _gtClrSet( WORD wClrPos, WORD wColor )
{
   WORD wClrOld = _gtClrGet( wClrPos );
   COLOR Colors[ 5 ];

   Colors[ wClrPos ].Fore.Blue  = ( wColor & 0x01 ) ? 0xFF: 0;
   Colors[ wClrPos ].Fore.Green = ( wColor & 0x02 ) ? 0xFF: 0;
   Colors[ wClrPos ].Fore.Red   = ( wColor & 0x04 ) ? 0xFF: 0;
   Colors[ wClrPos ].Fore.Attr  = 0;
   Colors[ wClrPos ].Fore.Attr |= ( wColor & 0x08 ) ? 0x20: 0;   // +
   Colors[ wClrPos ].Fore.Attr |= ( wColor & 0x80 ) ? 0x80: 0;   // *
   Colors[ wClrPos ].Back.Blue  = ( wColor & 0x10 ) ? 0xFF: 0;
   Colors[ wClrPos ].Back.Green = ( wColor & 0x20 ) ? 0xFF: 0;
   Colors[ wClrPos ].Back.Red   = ( wColor & 0x40 ) ? 0xFF: 0;
   Colors[ wClrPos ].Back.Attr  = 0;
   Colors[ wClrPos ].Back.Attr |= ( wColor & 0x80 ) ? 0xFF: 0;   // *
   _gtSetColor( Colors );

   return wClrOld;
}

//----------------------------------------------------------------------------//

void _gtSayHot( WORD wRow, WORD wCol, LPSTR szText, WORD wClrNormal,
                WORD wClrHot )
{
   WORD wClrOld = _gtClrSet( 0, wClrNormal );
   LPSTR szTemp = szText;

   while( ( * szTemp ) && ( * szTemp != '&' ) )
      szTemp++;

   if( * szTemp == '&' )
   {
      _gtWriteAt( wRow, wCol, szText, szTemp - szText );
      _gtClrSet( 0, wClrHot );
      _gtWriteAt( wRow, wCol + ( szTemp - szText ), szTemp + 1, 1 );
      _gtClrSet( 0, wClrNormal );
      _gtWriteAt( wRow, wCol + ( szTemp - szText + 1 ), szTemp + 2,
                  strlen( szText ) - ( szTemp - szText ) - 2 );
   }
   else
      _gtWriteAt( wRow, wCol, szText, strlen( szText ) );
   _gtClrSet( 0, wClrOld );
}

//----------------------------------------------------------------------------//

void _gtWriteColor( WORD wRow, WORD wCol, LPSTR szText, WORD wColor )
{
   WORD wClrOld = _gtClrSet( 0, wColor );

   _gtWriteAt( wRow, wCol, szText, strlen( szText ) );
   _gtClrSet( 0, wClrOld );
}

//----------------------------------------------------------------------------//

CLIPPER BtnShadow()
{
   WORD  wTop     = _parni( 1 );
   WORD  wLeft    = _parni( 2 );
   LPSTR szLabel  = _parc( 3 );
   WORD  wLen     = wLabelLen( szLabel );
   LPWORD pShadow = ( LPWORD ) _xgrab( ( wLen + 1 ) * 4 );
   WORD  wSide;
   WORD  wMaxRow  = _gtMaxRow();
   WORD  wMaxCol  = _gtMaxCol();
   BYTE b;

   _gtSayHot( wTop, wLeft, szLabel, _parni( 4 ), _parni( 5 ) );

   if( ( wTop + 1 <= wMaxRow ) && ( wLeft + wLen <= wMaxCol ) )
   {
      _gtSave( wTop + 1, wLeft + 1, wTop + 2, wLeft + wLen, pShadow );

      for( b = 0; b < wLen; b++ )
        pShadow[ b ] = ( 223 | ( pShadow[ b ] & 0xF000 ) );

      _gtRest( wTop + 1, wLeft + 1, wTop + 2, wLeft + wLen, pShadow );
   }

   if( ( wTop <= wMaxRow ) && ( wLeft + wLen <= wMaxCol ) )
   {
      _gtSave( wTop, wLeft + wLen, wTop, wLeft + wLen, &wSide );
      wSide = ( 220 | ( wSide & 0xF000 ) );
      _gtRest( wTop, wLeft + wLen, wTop, wLeft + wLen, &wSide );
   }

   _xfree( pShadow );
}

//----------------------------------------------------------------------------//

CLIPPER SayHot()
{
   _gtSayHot( _parni( 1 ), _parni( 2 ), _parc( 3 ), _parni( 4 ), _parni( 5 ) );
}

//----------------------------------------------------------------------------//

CLIPPER nColor()
{
   WORD wOldColor;

   if( PCOUNT() > 1 )
      wOldColor = _gtClrSet( _parni( 1 ) - 1, _parni( 2 ) );
   else
      wOldColor = _gtClrGet( _parni( 1 ) - 1 );

   _retni( wOldColor );
}

//----------------------------------------------------------------------------//
