#include "Sde501.ch"
#include "InKey.ch"

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

CLASS TRColumn

   DATA cTitle
   DATA cExpresion
   DATA cPicture
   DATA nWidth
   DATA lTotal
   DATA bExpresion
   DATA nTPage
   DATA nTGroup
   DATA nTSubGroup

   METHOD New()

ENDCLASS

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD TRColumn::New()

   ::cTitle      := AllTrim( RLines->cTiTle )
   ::cExpresion  := AllTrim( RLines->cExpresion )
   ::bExpresion  := &( "{ || " + ::cExpresion + "}" )
   ::cPicture    := AllTrim( RLines->cPicture )
   ::nWidth      := RLines->nWidth
   ::lTotal      := RLines->lTotal
   ::nTPage      := 0
   ::nTGroup     := 0
   ::nTSubGroup  := 0

return Self

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
