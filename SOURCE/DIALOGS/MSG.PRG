#include "FivePro.ch"

//----------------------------------------------------------------------------//

function MsgInfo( cText, cCaption )

   local oWnd
   local nLines  := nChrCount( Chr( 13 ), cText ) + 1
   local nTop    := Int( MaxRow() / 2 ) - Int( nLines / 2 )
   local nBottom := nTop + nLines + 3
   local nLeft   := 25
   local nRight  := 55

   DEFINE WINDOW oWnd FROM nTop, nLeft TO nBottom, nRight TITLE cCaption

   @ 4, 5 BUTTON " &Aceptar " OF oWnd ACTION oWnd:End()

   ACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//
