#include "sde501.ch"

static cRadEmpty, cRadFull

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

CLASS TRadio

     DATA    nRow, nCol
     DATA    cText, cClrNormal, cClrFocus
     DATA    lCheck, lFocus

     METHOD  New( nRow, nCol, cText )
     METHOD  SetFocus( lOnOff )
     METHOD  Display( cColor, lCheck )

ENDCLASS

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD New( nRow, nCol, cText ) CLASS TRadio

   ::nRow         = nRow
   ::nCol         = nCol
   ::cText        = cText
   ::cClrFocus    = cClrVntFA()
   ::cClrNormal   = cClrVntDeskTop()
   ::lCheck       = .f.
   ::lFocus       = .f.

   if cRadEmpty == nil
      cRadEmpty = If( lIsCua(), Chr( 203 ) + Chr( 206 ) + Chr( 213 ), "( )" )
      cRadFull  = If( lIsCua(), Chr( 203 ) + Chr( 198 ) + Chr( 213 ), "()" )
   endif

return Self

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD SetFocus( lOnOff ) CLASS TRadio

   ::lFocus = lOnOff
   ::lCheck = lOnOff
   ::Display()

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD Display() CLASS TRadio

   @ ::nRow, ::nCol SAY If( ::lCheck, cRadFull, cRadEmpty ) + " " + ::cText ;
      COLOR If( ::lFocus, ::cClrFocus, ::cClrNormal )

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
