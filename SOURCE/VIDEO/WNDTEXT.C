#include <ClipApi.h>

#define WS_CAPTION   0x01
#define WS_CLOSE     0x02
#define WS_MAXIMIZE  0x04
#define WS_MINIMIZE  0x08

#define CLOSELEFT     216
#define CLOSERIGHT    243
#define BORDERLEFT    189
#define BORDERRIGHT   190
#define MINIMIZELEFT  214
#define MINIMIZERIGHT 237
#define MAXIMIZELEFT  212
#define MAXIMIZERIGHT 235

//----------------------------------------------------------------------------//

CLIPPER WndDisplay()
{
   WORD wTop = _parni( 1 ), wLeft = _parni( 2 ), wBottom = _parni( 3 ),
        wRight = _parni( 4 ), wClrNormal = _parni( 5 ), wClrTitle = _parni( 6 );
   WORD wStyle = _parni( 7 );
   WORD w;
   BYTE bClose[ 2 ] = { CLOSELEFT, CLOSERIGHT };

   _gtClrSet( 0, wClrNormal );
   _gtScroll( wTop + 1, wLeft + 1, wBottom - 1, wRight - 1, 0 );

   if( wStyle & WS_CAPTION )
   {
      _gtClrSet( 0, wClrTitle );
      _gtRepChar( wTop, wLeft, ' ', wRight - wLeft + 1 );
   }
   if( wStyle & WS_CLOSE )
   {
      _gtClrSet( 0, 0x70 );
      _gtWriteAt( wTop, wLeft, &bClose[ 0 ], 1 );
      _gtClrSet( 0, 0x07 );
      _gtWriteAt( wTop, wLeft + 1, &bClose[ 1 ], 1 );
   }

   if( ( wStyle & WS_MAXIMIZE ) && ( wStyle & WS_MINIMIZE ) )
   {
      _gtClrSet( 0, 0x70 );
      _gtRepChar( wTop, wRight - 3, MINIMIZELEFT,  1 );
      _gtClrSet( 0, 0x07 );
      _gtRepChar( wTop, wRight - 2, MINIMIZERIGHT, 1 );
      _gtClrSet( 0, 0x70 );
      _gtRepChar( wTop, wRight - 1, MAXIMIZELEFT,  1 );
      _gtClrSet( 0, 0x07 );
      _gtRepChar( wTop, wRight    , MAXIMIZERIGHT, 1 );
   }
   else if( ( wStyle & WS_MAXIMIZE ) )
   {
      _gtClrSet( 0, 0x70 );
      _gtRepChar( wTop, wRight - 1, MAXIMIZELEFT,  1 );
      _gtClrSet( 0, 0x07 );
      _gtRepChar( wTop, wRight    , MAXIMIZERIGHT, 1 );
   }
   else if( wStyle & WS_MINIMIZE )
   {
      _gtClrSet( 0, 0x70 );
      _gtRepChar( wTop, wRight - 1, MINIMIZELEFT,  1 );
      _gtClrSet( 0, 0x07 );
      _gtRepChar( wTop, wRight    , MINIMIZERIGHT, 1 );
   }

   _gtClrSet( 0, wClrNormal );
   for( w = 0; w < wBottom - wTop - 1; w++ )
      _gtRepChar( wTop + 1 + w, wLeft, BORDERLEFT, 1 );
   _gtWriteAt( wBottom, wLeft, "À", 1 );
   _gtRepChar( wBottom, wLeft + 1, 'Ï', wRight - wLeft - 1 );

   _gtClrReverse( 0 );
   for( w = 0; w < wBottom - wTop - 1; w++ )
      _gtRepChar( wTop + 1 + w, wRight, BORDERRIGHT, 1 );
   _gtWriteAt( wBottom, wRight, "ô", 1 );
   _gtClrReverse( 0 );

   _gtShadow( wBottom + 1, wLeft + 2, wBottom + 1, wRight + 2 );
   _gtShadow( wTop + 1, wRight + 1, wBottom, wRight + 2 );
}

//----------------------------------------------------------------------------//
