#include <ClipApi.h>

void SetPixel( WORD, WORD, WORD );

//----------------------------------------------------------------------------//

void RectFill( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, WORD wColor )
{
   WORD wRow, wCol;

   for( wRow = wTop; wRow <= wBottom; wRow++ )
   {
      for( wCol = wLeft; wCol <= wRight; wCol++ )
         SetPixel( wRow, wCol, wColor );
   }
}

//----------------------------------------------------------------------------//

CLIPPER RECTFILL()
{
   RectFill( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ),
             _parni( 5 ) );
}

//----------------------------------------------------------------------------//
