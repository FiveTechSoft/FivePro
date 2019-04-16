#include <ClipApi.h>

void SetPixel( WORD, WORD, WORD );

//----------------------------------------------------------------------------//

void Line( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, WORD wColor )
{
   WORD w;

   if( wTop == wBottom )
   {
      for( w = wLeft; w <= wRight; w++ )
         SetPixel( wTop, w, wColor );
   }
   else
   {
      for( w = wTop; w <= wBottom; w++ )
         SetPixel( w, wLeft, wColor );
   }
}

//----------------------------------------------------------------------------//

CLIPPER LINE()
{
   Line( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ), _parni( 5 ) );
}

//----------------------------------------------------------------------------//
