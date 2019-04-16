#include "FivePro.ch"

static oWnd

//----------------------------------------------------------------------------//

function Main()

   DEFINE WINDOW oWnd FROM 0, 0 TO MaxRow(), MaxCol() ;
      TITLE "G‚nesis" NOZOOM NOFLOAT NOGROW ;
      COLOR "W+/W, N/BG" ;
      MENU BuildMenu()

   ACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//

function BuildMenu()

   local oMenu

   MENU oMenu
      MENUITEM " &Proyectos "
      MENU
         MENUITEM " &Seleccionar... "
         MENUITEM " &Nuevo "
         SEPARATOR
         MENUITEM " &Terminar " ACTION oWnd:End()
      ENDMENU
      MENUITEM " &Ficheros "
   ENDMENU

return oMenu

//----------------------------------------------------------------------------//
