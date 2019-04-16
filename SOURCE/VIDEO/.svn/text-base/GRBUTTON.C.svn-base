#include <ClipApi.h>

void Line( WORD, WORD, WORD, WORD, WORD );
void RectFill( WORD, WORD, WORD, WORD, WORD );

void Button( WORD wRow, WORD wCol, WORD wWidth, WORD wHeight,
             WORD wClrFace, WORD wClrTop, WORD wClrBottom )
{
   WORD w;
   WORD wTop    = wRow;
   WORD wLeft   = wCol;
   WORD wBottom = wRow + wHeight - 1;
   WORD wRight  = wCol + wWidth - 1;

   Line( wTop, wLeft, wTop, wRight, 0 );
   Line( wTop, wLeft, wBottom, wLeft, 0 );
   Line( wBottom, wLeft, wBottom, wRight, 0 );
   Line( wTop, wRight, wBottom, wRight, 0 );

   Line( wTop + 1, wLeft + 1, wTop + 1, wRight - 1, wClrTop );
   Line( wTop + 2, wLeft + 1, wTop + 2, wRight - 2, wClrTop );
   Line( wTop + 1, wLeft + 1, wBottom - 1, wLeft + 1, wClrTop );
   Line( wTop + 1, wLeft + 2, wBottom - 2, wLeft + 2, wClrTop );

   Line( wTop + 2, wRight - 2, wBottom - 2, wRight - 2, wClrBottom );
   Line( wTop + 1, wRight - 1, wBottom - 1, wRight - 1, wClrBottom );
   Line( wBottom - 2, wLeft + 2, wBottom - 2, wRight - 2, wClrBottom );
   Line( wBottom - 1, wLeft + 1, wBottom - 1, wRight - 1, wClrBottom );

   RectFill( wTop + 3, wLeft + 3, wBottom - 3, wRight - 3, wClrFace );
}

CLIPPER BUTTON()
{
   Button( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ),
           _parni( 5 ), _parni( 6 ), _parni( 7 ) );
}
