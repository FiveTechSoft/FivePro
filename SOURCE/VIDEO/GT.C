// GT Module replacement - (c) Antonio Linares, 1993

#include <ClipApi.h>
#include <dos.h>

WORD _gtGetMode( void );
void Line( WORD, WORD, WORD, WORD, WORD );
void SayChar( WORD, WORD, WORD );
void Fill( WORD, WORD, WORD, WORD, WORD );

void HorLine( WORD, WORD, WORD, WORD );
void VerLine( WORD, WORD, WORD, WORD );

WORD wClrFore, wClrBack;

//----------------------------------------------------------------------------//

BYTE _gtCharLines()
{
   return peekb( 0, 0x485 );
}

//----------------------------------------------------------------------------//

WORD _gtRepChar( WORD wRow, WORD wCol, WORD wChar, WORD wCount )
{
   WORD w = 0;
   BYTE bText[ 1 ];

   bText[ 0 ] = wChar;

   while( w++ < wCount )
      _gtWriteAt( wRow, wCol++, bText, 1 );
}

//----------------------------------------------------------------------------//

WORD _gtSetPos( WORD wRow, WORD wCol )
{
   _DH = wRow;
   _DL = wCol;
   _BH = 0;
   _AH = 2;
   asm int 0x10;
   return 0;
}

//----------------------------------------------------------------------------//

WORD _gtGetPos( WORD * pRow, WORD * pCol )
{
   _BH = 0;
   _AH = 3;
   asm int 0x10;
   * pRow = _DH;
   * pCol = _DL;
   return 0;
}

//----------------------------------------------------------------------------//

WORD _gtMaxRow( void ) { return peekb( 0, 0x484 ); }
WORD _gtMaxCol( void ) {  return peekb( 0, 0x44A ) - 1; }

//----------------------------------------------------------------------------//

WORD _gtScrDim( WORD * pRows, WORD * pCols )
{
   * pRows = _gtMaxRow();
   * pCols = _gtMaxCol();
}

//----------------------------------------------------------------------------//

WORD _gtScroll( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, int iLines )
{
   BYTE bUp    = ( iLines > 0 ) ? 6: 7;
   BYTE bColor = _gtClrGet( 0 );

   if( _gtGetMode() != 3 )
      bColor >>= 4;

   if( iLines < 0 )
      iLines = -iLines;

   _CH = wTop;
   _CL = wLeft;
   _DH = wBottom;
   _DL = wRight;
   _BH = bColor;
   _AL = iLines;
   _AH = bUp;
   asm int 0x10;

   return 0;
}

//----------------------------------------------------------------------------//

WORD _gtGetMode( void )
{
   _AH = 0xF;
   asm int 0x10;
   return _AL;
}

//----------------------------------------------------------------------------//

WORD _gtWriteAt( WORD wRow, WORD wCol, LPSTR szText, WORD wLen )
{
   WORD w = 0;
   BYTE bColor = _gtClrGet( 0 );

   wClrFore = bColor & 0x0F;
   wClrBack = bColor & 0xF0;

   switch( wClrFore )
   {
      case 0x0F:              // Blanco brillante
         wClrFore = 255;      // Posici¢n en paleta Windows
         break;
   }

   switch( wClrBack )
   {
      case 0x10:              // Azul
         wClrBack = 4;        // Posici¢n en paleta Windows
         break;

      case 0x20:              // Verde
         wClrBack = 2;        // Posici¢n en paleta Windows
         break;

      case 0x30:              // Celeste
         wClrBack = 6;        // Posici¢n en paleta Windows
         break;

      case 0x40:              // Rojo
         wClrBack = 1;        // Posici¢n en paleta Windows
         break;

      case 0x50:              // RB
         wClrBack = 5;        // Windows RB
         break;

      case 0x70:              // Blanco
         wClrBack = 247;      // Posici¢n en paleta Windows
         break;

      case 0x80:              // N+
         wClrBack = 248;      // Windows N+
         break;
   }

   while( w++ < wLen )
      SayChar( wRow, wCol++, * szText++ );
}

//----------------------------------------------------------------------------//

WORD _gtWrite( LPSTR szText, WORD wLen )
{
   WORD wRow, wCol;

   _gtGetPos( &wRow, &wCol );

   _gtWriteAt( wRow, wCol, szText, wLen );
   return 0;
}

//----------------------------------------------------------------------------//

void _gtBoxS( WORD wCharTop, WORD wCharLeft, WORD wCharBottom, WORD wCharRight )
{
   WORD wTop    = wCharTop    * 16;
   WORD wLeft   = wCharLeft   *  8;
   WORD wBottom = ( wCharBottom * 16 ) + 15;
   WORD wRight  = ( wCharRight  *  8 ) +  7;

   Fill( wCharTop, wCharLeft, wCharBottom, wCharRight, 247 );  // Windows W
   HorLine( wTop, wLeft, wRight - wLeft + 1, 248 );         // Windows N+
   HorLine( wTop + 1, wLeft, wRight - wLeft + 1, 255 );     // Windows W+
   VerLine( wTop, wLeft, wBottom - wTop, 248 );             // Windows N+
   VerLine( wTop + 1, wLeft + 1, wBottom - wTop, 255 );     // Windows W+
   HorLine( wBottom, wLeft, wRight - wLeft + 1, 248 ); // Windows N+
   VerLine( wTop, wRight, wBottom - wTop, 248 );        // Windows N+
}

//----------------------------------------------------------------------------//

WORD _gtBox( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, LPSTR szText )
{
   _gtBoxS( wTop, wLeft, wBottom, wRight );
   _gtScroll( wTop + 1, wLeft + 1, wBottom - 1, wRight - 1, 0 );
   return 0;
}

//----------------------------------------------------------------------------//

CLIPPER FORE() { _retni( wClrFore ); }
CLIPPER BACK() { _retni( wClrBack ); }

//----------------------------------------------------------------------------//
