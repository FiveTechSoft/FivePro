#include "FivePro.ch"

static oWnd

//----------------------------------------------------------------------------//

function Main()

   BoxFont()
   SetBlink( .f. )

   DEFINE WINDOW oWnd ;
      FROM 0, 0 TO MaxRow(), MaxCol() ;
      MENU BuildMenu() ;
      TITLE "FivePro 2.0" ;
      NOICONIZE

   ACTIVATE WINDOW oWnd

   oWnd:Hide()
   FntSystem()

return

//----------------------------------------------------------------------------//

function BuildMenu()

   local oMenu

   MENU oMenu AT 1 MESSAGE AT MaxRow() - 2
      MENUITEM " &Informaci¢n "
      MENU
         MENUITEM " &Acerca de... " ACTION MakeChild()
         SEPARATOR
         MENUITEM " &Terminar... "
      ENDMENU
      MENUITEM " &Ficheros "
      MENUITEM " &Utilidades " ACTION Util()
   ENDMENU

   oMenu:lOpened = .f.
   oMenu:nOption = 0

return oMenu

//----------------------------------------------------------------------------//

function MakeChild()

   local oDlg, oBrw

   USE c:\FiveWin.10\ejemplos\Dialog NEW

   BROWSE oBrw COLOR "W/B"
      COLUMN TITLE "Nombre" SHOW Dialog->Name
   ENDBROWSE

   DEFINE DIALOG oDlg FROM 6, 6 TO 15, 40 ;
      TITLE "Hola" ;
      BROWSE oBrw ;
      OF oWnd

   @ 2, 2 BUTTON " &Hola " OF oWnd

   oDlg:Display()

return

//----------------------------------------------------------------------------//

function Util()

   local oDlg
   local cItem

   DEFINE WINDOW oDlg FROM 12, 30 TO 20, 50 TITLE "Hola" OF oWnd

   @ 14, 32 LISTBOX cItem ITEMS { "Uno", "Dos", "Tres" } ;
     PROMPT "&Elije" OF oDlg

   ACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//
