#include "FivePro.ch"

//----------------------------------------------------------------------------//

function MsgPalette()

   local oDlg
   local nRed := 0, nGreen := 0, nBlue := 0

   DEFINE DIALOG oDlg SIZE 63, 12 TITLE "Palette Control"

   @ 2, 2 BITMAP RESOURCE ColorsBmp() SIZE 12, 4 OF oDlg

   @  2, 23 SCROLLBAR nRed   RANGE 64 SIZE 36 PROMPT "&Red"   HORIZONTAL OF oDlg

   @  4, 23 SCROLLBAR nGreen RANGE 64 SIZE 36 PROMPT "&Green" HORIZONTAL OF oDlg

   @  6, 23 SCROLLBAR nBlue  RANGE 64 SIZE 36 PROMPT "&Blue"  HORIZONTAL OF oDlg

   @ 10, 12 BUTTON " &Aceptar "  OF oDlg ACTION oDlg:End()
   @ 10, 25 BUTTON " &Cancelar " OF oDlg ACTION oDlg:End()

   ACTIVATE DIALOG oDlg

return

//----------------------------------------------------------------------------//
