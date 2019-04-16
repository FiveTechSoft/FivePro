#include <ClipApi.h>

void Line( WORD, WORD, WORD, WORD, WORD );

void Frame( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight,
            WORD wColor, WORD wWidth )
{
   WORD w;

   for( w = 0; w < wWidth; w++ )
   {
      Line( wTop + w, wLeft + w, wTop + w, wRight - w, wColor );
      Line( wBottom - w, wLeft + w, wBottom - w, wRight - w, wColor );
      Line( wTop + w, wLeft + w, wBottom - w, wLeft + w, wColor );
      Line( wTop + w, wRight - w, wBottom - w, wRight - w, wColor );
   }
}

CLIPPER FRAME()
{
   Frame( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ),
          _parni( 5 ), _parni( 6 ) ? _parni( 6 ): 1 );
}
