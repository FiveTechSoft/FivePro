#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TLabel FROM TControl

   DATA cText
   DATA cClrHot

   METHOD New( nRow, nCol, cText, cClrNormal, cClrHot, oParent )
   METHOD Display()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD TLabel::New( nRow, nCol, cText, cClrNormal, cClrHot, oParent )

   ::Parent:New( nRow, nCol, nRow,;
                 nCol + Len( cText ) - If( "&" $ cText, 2, 1 ) )
   ::cText      = cText
   ::cClrNormal = cClrNormal
   ::cClrHot    = cClrHot
   ::oParent    = oParent

return Self

//----------------------------------------------------------------------------//

METHOD TLabel::Display()

   ScrSayHot( ::nAbsTop(), ::nAbsLeft(), ::cText, ::cClrNormal, ::cClrHot )

return

//----------------------------------------------------------------------------//
