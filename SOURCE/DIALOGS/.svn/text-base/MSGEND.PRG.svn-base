#include "FivePro.ch"

//----------------------------------------------------------------------------//

function lMsgEnd()

   local oDlg
   local lEnd := .f.

   DEFINE WINDOW oDlg SIZE 41, 8 ;
      COLOR "W+/RB, N*/W" ;
      TITLE "Atenci¢n" NOGROW NOZOOM NOICONIZE

   @ 3,  11 SAY "¨ Desea terminar la ejecuci¢n " OF oDlg
   @ 4,  13 SAY "  y volver al DOS ?" OF oDlg

   @ 5, 13 BUTTON " &Aceptar "  OF oDlg ACTION ( lEnd := .t., oDlg:End() )
   @ 5, 26 BUTTON " &Cancelar " OF oDlg ACTION oDlg:End()

   ACTIVATE WINDOW oDlg ON PAINT AskIco( 2 + oDlg:nTop, 2 + oDlg:nLeft )

return lEnd

//----------------------------------------------------------------------------//
