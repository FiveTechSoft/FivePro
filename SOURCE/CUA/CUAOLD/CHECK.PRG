#include "Sde501.ch"
#include "GetExit.ch"
#include "Set.ch"
#include "Inkey.ch"

static cCheckEmpty, cCheckFull

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

CLASS TCheck FROM TControl

   DATA   cLabel

   METHOD New( nRow, nCol, cLabel, bBlock, cName, cColors, bWhen, bValid )
   METHOD Display()
   METHOD KeyApply( nKey )

ENDCLASS

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD New( nRow, nCol, cLabel, bBlock, cName, cColors, bWhen, bValid ) ;
   CLASS TCheck

   local acColors := aStr2Array( SetColor() )

   Super:New()

   DEFAULT bWhen := { || .t. }, bValid := { || .t. },;
	   cColors := acColors[ 5 ] + "," + acColors[ 2 ]

   ::Row        := nRow
   ::Col        := nCol
   ::cLabel     := cLabel
   ::bBlock     := bBlock
   ::Name       := cName
   ::cColorSpec := cColors
   ::PreBlock   := bWhen
   ::PostBlock  := bValid

   if cCheckEmpty == nil
      cCheckEmpty = If( lIsCua(), Chr( 209 ) + Chr( 216 ) + Chr( 214 ), "[ ]" )
      cCheckFull  = If( lIsCua(), Chr( 209 ) + Chr( 207 ) + Chr( 214 ), "[X]" )
   endif

return self

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD Display() CLASS TCheck

  @ ::Row, ::Col SAY If( Eval( ::bBlock ), cCheckFull, cCheckEmpty ) + ;
    " " + ::cLabel COLOR aStr2Array( ::cColorSpec )[ If( ::HasFocus, 2, 1 ) ]

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD KeyApply( nKey ) CLASS TCheck

   do case
      case nKey == K_SPACE
	   Eval( ::bBlock, ! Eval( ::bBlock ) )
	   ::Display()

      otherwise
      Super:KeyApply( nKey )

   endcase

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
