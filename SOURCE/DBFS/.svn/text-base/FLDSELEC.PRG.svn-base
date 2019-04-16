#include "Sde501.ch"

//----------------------------------------------------------------------------//

function cFldSelect()

   local GetList  := {}
   local oWnd
   local cField   := ""
   local acFields := Array( FCount() )

   DEFINE WINDOW oWnd CENTERED SIZE 10, 30 TITLE "Seleccione"

   ACTIVATE WINDOW oWnd

   AEval( acFields, { | cField, n | acFields[ n ] := Field( n ) } )

   @ oWnd:nTop + 3, oWnd:nLeft +  3 GET cField ;
     LISTBOX acFields SIZE 6 LABEL "&Campos"
   @ oWnd:nTop + 3, oWnd:nLeft + 17 BUTTON " &Aceptar  " ACTION nBtnOk()
   @ oWnd:nTop + 6, oWnd:nLeft + 17 BUTTON " &Cancelar " ACTION nBtnOk()

   READ
   SET CURSOR OFF
   DEACTIVATE WINDOW oWnd

return cField

//----------------------------------------------------------------------------//
