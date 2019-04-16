#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TLabel FROM TView

   DATA   cText

   METHOD New( nRow, nCol, cText, oWnd ) CONSTRUCTOR

   METHOD Display() BLOCK ;
          { | Self | MOff(), SayHot( ::nTop, ::nLeft, ::cText,;
            If( ::lFocused, ::nClrFocus, ::nClrNormal ), 27 ), MOn() }

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, cText, oWnd ) CLASS TLabel

   Super:New( nRow, nCol, nRow, nCol + nLabelLen( cText ) - 1, oWnd )

   ::cText      = cText
   ::nClrNormal = 23        // W/B
   ::nClrFocus  = 31        // W+/B

return

//----------------------------------------------------------------------------//
