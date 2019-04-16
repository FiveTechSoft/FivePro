#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TWndText FROM TWindow

   DATA   oText

   METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColors, cText ) CONSTRUCTOR
   METHOD Adjust()
   METHOD Display()
   METHOD ReSize()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColors, cText ) CLASS TWndText

   Super:New( nTop, nLeft, nBottom, nRight )

   ::cTitle      = cTitle
   ::cColorSpec  = "W+/RB, N*/W"
   ::oText       = TText():New( nTop + 2, nLeft + 1, nBottom - 1,;
                                nRight - 2, cText )
   ::oMenu       = BuildMenu()
   ::oMenu:oWnd  = Self
   ::oMenu:ChangePos( nTop + 1, nLeft + 1 )

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TWndText

   Super:Display()

   ::oText:Display()

return

//----------------------------------------------------------------------------//

METHOD ReSize() CLASS TWndText

   Super:ReSize()
   ::Adjust()

return

//----------------------------------------------------------------------------//

METHOD Adjust() CLASS TWndText

   ::oText:nTop    = ::nTop    + 2
   ::oText:nLeft   = ::nLeft   + 1
   ::oText:nBottom = ::nBottom - 1
   ::oText:nRight  = ::nRight  - 2
   ::oText:Display()

return

//----------------------------------------------------------------------------//

static function BuildMenu()

   local oMenu

   MENU oMenu
      MENUITEM " &Ficheros "
      MENU
         MENUITEM " &Nuevo "
         MENUITEM " &Abrir... "
         SEPARATOR
         MENUITEM " &Guardar "
         MENUITEM " Guardar &como... "
      ENDMENU

      MENUITEM " &Edici¢n "
      MENU
         MENUITEM " &Deshacer "
         SEPARATOR
         MENUITEM " &Cortar    "
         MENUITEM " C&opiar    "
         MENUITEM " &Pegar     "
      ENDMENU
   ENDMENU

return oMenu

//----------------------------------------------------------------------------//
