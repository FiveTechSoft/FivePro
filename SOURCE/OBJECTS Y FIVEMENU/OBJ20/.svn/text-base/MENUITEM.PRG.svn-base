// Clase base para Menu Items
// (C) Antonio Linares, 1993

#include "Objects.ch"

static nMsgLine

//----------------------------------------------------------------------------//

CLASS TMenuItem

   DATA  nRow, nCol
   DATA  cPrompt, cMsg, cColor
   DATA  bAction

   METHOD New( nRow, nCol, cPrompt, cMsg, bAction ) CONSTRUCTOR
   METHOD Display( cClrNormal, cClrHot )
   METHOD SetFocus( lOnOff )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, cPrompt, cMsg, bAction ) CLASS TMenuItem

   DEFAULT bAction := { || nil }, nMsgLine := MaxRow()

   ::nRow    = nRow
   ::nCol    = nCol
   ::cPrompt = cPrompt
   ::cMsg    = cMsg
   ::cColor  = "W+/B, R+/B"
   ::bAction = bAction

return

//----------------------------------------------------------------------------//

METHOD Display( cClrNormal, cClrHot ) CLASS TMenuItem

   DEFAULT cClrNormal := ::cColor,;
           cClrHot := SubStr( ::cColor, At( ",", ::cColor ) + 1 )

   ScrSayHot( ::nRow, ::nCol, ::cPrompt, cClrNormal, cClrHot )

   if ! Empty( ::cMsg )
      @ nMsgLine, 0 SAY PadC( ::cMsg, MaxCol() + 1 ) COLOR ::cColor
   endif

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TMenuItem

   ::Display( If( lOnOff, "N/BG",  "W+/B" ),;
              If( lOnOff, "R+/BG", "R+/B" ) )

return

//----------------------------------------------------------------------------//
