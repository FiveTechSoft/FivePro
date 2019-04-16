#include "InKey.Ch"
#include "Menu.Ch"

// ----------------------------------------------------------------------------

function Main()

   SetCursor( 0 )
   SetBlink( .f. )
   SetColor( "W+/N*" )
   // SetShadow( .f. )
   FntBoxRnd()
   CLS

   Alert( "This is only a Windows 3.1 clone menu;Eso es solo una copia del men£ de Windows 3.1" )
   @ 0, 0 TO MaxRow(), MaxCol()
   @ 0, 0 SAY PadC( "Administrador de programas", MaxCol() + 1 ) COLOR "W+/B"
   @ 0, MaxCol() - 2 SAY " " COLOR "W+/N*"

   ACTIVATE MENU WinMenu()

   SetColor( "W/N" )
   FntSystem()
   CLS
   SetCursor( 1 )

return

// ----------------------------------------------------------------------------

function WinMenu()

   local oMenu

   MENU oMenu AT 1 MESSAGE AT MaxRow() + 1 COLOR "B/W", "W/B", "B+/W", "B+/B", "N+/W", "N+/B"
      MENUITEM " þ " AT 0, 0 COLOR "W/N*"
      MENU
         MENUITEM " &Restaurar " DISABLED
         MENUITEM " &Mover "
         MENUITEM " &Tama¤o "
         MENUITEM " Mi&nimizar "
         MENUITEM " Ma&ximizar "
         SEPARATOR
         MENUITEM " &Cerrar        Alt+F4 " SHORTCUT K_ALT_F4 ;
                                            ACTION oMenu:lEnd := .t.
         SEPARATOR
         MENUITEM " Cam&biar a...  Ctrl+Esc "
      ENDMENU
      MENUITEM " &Archivo "
      MENU
         MENUITEM " &Nuevo... "
         MENUITEM " &Abrir           Entrar "
         MENUITEM " &Mover...        F7 " DISABLED
         MENUITEM " &Copiar...       F8 " DISABLED
         MENUITEM " &Eliminar        Supr "
         MENUITEM " &Propiedades...  Alt+Entrar "
         SEPARATOR
         MENUITEM " &Ejecutar... " 
         SEPARATOR
         MENUITEM " &Salir de Windows... " ACTION oMenu:lEnd := .t.
      ENDMENU
      MENUITEM " &Opciones "
      MENU
         MENUITEM "  &Organizaci¢n autom tica " CHECKED
         MENUITEM "  &Minimizar " CHECKED
         MENUITEM "  &Guardar configuraci¢n al salir " CHECKED
      ENDMENU
      MENUITEM " &Ventana "
      MENU
         MENUITEM " &Cascada   May£sculas+F5 "
         MENUITEM " &Mosaico   May£sculas+F4 "
         MENUITEM " &Organizar iconos "
         SEPARATOR
         MENUITEM " &1 Principal "
         MENUITEM " &2 Accesorios "
         MENUITEM " &3 Aplicaciones "
         MENUITEM " &4 BORLAND C++ 3.1 "
      ENDMENU
      MENUITEM " &Ayuda "
      MENU
         MENUITEM " &Indice "
         MENUITEM " &Buscar ayuda sobre... "
         SEPARATOR
         MENUITEM " &Uso de la ayuda "
         MENUITEM " &Tutorial de Windows "
         SEPARATOR
         MENUITEM " &Acerca del administrador de programas... "
      ENDMENU
   ENDMENU

   oMenu:nOption = 2

return oMenu

// ----------------------------------------------------------------------------
