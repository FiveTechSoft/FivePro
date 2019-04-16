// Implementaci¢n de la Clase TWindow para la creaci¢n de ventanas

#include "Objects.ch"
#include "Box.ch"

//----------------------------------------------------------------------------//

CLASS TWindow

   DATA   nTop, nLeft, nBottom, nRight
   DATA   cBack, cColor, cFrame, cTitle

   METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColor ) CONSTRUCTOR
   METHOD Display()
   METHOD Hide()
   METHOD Say( nRow, nCol, cText, cColor )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColor ) CLASS TWindow

   DEFAULT cColor := "W+/B, B/W", cTitle := "Window"

   ::nTop    = nTop
   ::nLeft   = nLeft
   ::nBottom = nBottom
   ::nRight  = nRight
   ::cBack   = ""
   ::cColor  = cColor
   ::cFrame  = B_SINGLE + " "
   ::cTitle  = cTitle

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TWindow

   ::cBack = SaveScreen( ::nTop, ::nLeft, ::nBottom + 1, ::nRight + 2 )
   @ ::nTop, ::nLeft, ::nBottom, ::nRight BOX ::cFrame COLOR ::cColor
   @ ::nTop, ::nLeft SAY PadC( ::cTitle, ::nRight - ::nLeft + 1 ) ;
     COLOR SubStr( ::cColor, At( ",", ::cColor ) + 1 )
   Shadow( ::nBottom + 1, ::nLeft + 2, ::nBottom + 1, ::nRight + 2 )
   Shadow( ::nTop + 1, ::nRight + 1, ::nBottom, ::nRight + 2 )

return

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TWindow

   RestScreen( ::nTop, ::nLeft, ::nBottom + 1, ::nRight + 2, ::cBack )
   ::cBack = ""

return

//----------------------------------------------------------------------------//

METHOD Say( nRow, nCol, cText, cColor ) CLASS TWindow

   @ ::nTop + nRow, ::nLeft + nCol SAY cText ;
     COLOR If( cColor == nil, ::cColor, cColor )

return

//----------------------------------------------------------------------------//
