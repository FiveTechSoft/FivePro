#include "Sde501.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

function Help()

   local oWnd
   local GetList := {}
   local cClrOld := SetColor( cClrVentanas() )
   local bF1     := SetKey( K_F1 )

   DEFINE WINDOW oWnd CENTERED SIZE 15, 60 TITLE "Ayuda general"
   ACTIVATE WINDOW oWnd

   @ 2, 2 SAY "F1 - Esta ayuda"     WINDOW oWnd
   @ 4, 2 SAY "F2 - Calculadora"    WINDOW oWnd
   @ 5, 2 SAY "F3 - Calendario"     WINDOW oWnd
   @ 6, 2 SAY "F4 - Block de Notas" WINDOW oWnd

   @ 8, 10 BUTTON OK     WINDOW oWnd
   @ 8, 25 BUTTON CANCEL WINDOW oWnd
   READ

   DEACTIVATE WINDOW oWnd
   SetKey( K_F1, bF1 )
   SetColor( cClrOld )

return

//----------------------------------------------------------------------------//
