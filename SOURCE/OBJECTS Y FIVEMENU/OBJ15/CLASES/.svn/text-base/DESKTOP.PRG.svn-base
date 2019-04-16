// Clase TDesktop, un prototipo de despacho para inicio de aplicaciones

#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TDeskTop

   DATA   nTop, nLeft, nBottom, nRight
   DATA   cScrOld
   DATA   cClrBack
   DATA   cClrBars
   DATA   cTitle

   METHOD New( cTitle, aColors ) CONSTRUCTOR
   METHOD End()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( cTitle, aColors ) CLASS TDeskTop

   DEFAULT aColors := { "W+/B", "N/BG" }, cTitle := ""

   ::nTop     = 0
   ::nLeft    = 0
   ::nBottom  = MaxRow()
   ::nRight   = MaxCol()
   ::cScrOld  = SaveScreen( 0, 0, MaxRow(), MaxCol() )
   ::cClrBack = aColors[ 1 ]
   ::cClrBars = aColors[ 2 ]
   ::cTitle   = cTitle

   @ ::nTop, ::nLeft, ::nBottom, ::nRight BOX Space( 9 ) COLOR aColors[ 1 ]
   @ 0, 0 SAY Space( MaxCol() + 1 ) COLOR aColors[ 2 ]
   @ 0, 1 SAY Date() COLOR aColors[ 2 ]
   if ! Empty( ::cTitle )
      @ 0, ( MaxCol() / 2 ) - ( Len( ::cTitle ) / 2 ) SAY ::cTitle ;
      COLOR ::cClrBars
   endif
   @ MaxRow(), 0 SAY Space( MaxCol() + 1 ) COLOR aColors[ 2 ]

   SET SCOREBOARD OFF

return

//----------------------------------------------------------------------------//

METHOD End() CLASS TDeskTop

   RestScreen( ::nTop, ::nLeft, ::nBottom, ::nRight, ::cScrOld )
   ::cScrOld = ""

return

//----------------------------------------------------------------------------//
