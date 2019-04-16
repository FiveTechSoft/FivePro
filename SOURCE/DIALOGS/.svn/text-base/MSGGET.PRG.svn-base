#include "FivePro.ch"

//----------------------------------------------------------------------------//

function lMsgGet( cTitle, cText, uValue, cPicture, bValid )

   local oWnd
   local nLen    := Max( nLabelLen( cText ) + 1 + nValLen( uValue ) + 3, 40 )
   local nAction := 0
   local uTemp   := uValue
   local oBtn

   DEFAULT bValid := { || .t. }

   DEFINE WINDOW oWnd SIZE nLen, 8 TITLE cTitle NORESIZE NOZOOM

   @ 3, 2 SAY cText OF oWnd
   @ 3, 3 + nLabelLen( cText ) GET uTemp OF oWnd PICTURE cPicture

   @ 5, Int( nLen / 2 ) - 10 BUTTON oBtn PROMPT " &Aceptar " OF oWnd ;
      ACTION ( nAction := 1, uValue := uTemp, oWnd:End() )

   @ 5, oBtn:nRight + 3 - oWnd:nLeft BUTTON " &Cancelar " OF oWnd ;
     ACTION oWnd:End()

   ACTIVATE WINDOW oWnd

return nAction == 1

//----------------------------------------------------------------------------//
