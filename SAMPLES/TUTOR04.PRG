#include "FivePro.ch"

static oWnd

//----------------------------------------------------------------------------//

function Main()

   DEFINE WINDOW oWnd FROM 1, 1 TO 22, 75 ;
      TITLE OemToAnsi( "Ejemplo de construcci¢n del Men£ Principal" ) ;
      MENU  BuildMenu()

//   SET MESSAGE OF oWnd ;
//      TO OemToAnsi( "FiveWin 1.4, (c) A.Linares & F.Pulp¢n, 1993-4" )

   ACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//

function BuildMenu()

   local oMenu

   MENU oMenu
      MENUITEM OemToAnsi( "&Informaci¢n" )
      MENU
         MENUITEM "&Acerca de..." ;
            ACTION MsgInfo( OemToAnsi( "Mi primer programa" + Chr( 13 ) + ;
                            "Puedes poner varias l¡neas" ) )
         SEPARATOR
         MENUITEM "&Terminar..."  ;
            ACTION If( MsgYesNo( OemToAnsi( "¨ Desea terminar ?" ) ),;
                       oWnd:End(),)
      ENDMENU

      MENUITEM "&Clientes"
      MENU
         MENUITEM "&Altas..."           ACTION MsgStop( "Nuevos Clientes" )
         MENUITEM "&Modificaciones..."  ACTION MsgInfo( "Modif. Clientes" )
         MENUITEM "&Bajas..."           ACTION MsgAlert( "Bajas Clientes" )
      ENDMENU

      MENUITEM "&Utilidades"
      MENU
         MENUITEM "&Calculadora..." ACTION WinExec( "Calc" )
         MENUITEM "C&alendario..."  ACTION WinExec( "Calendar" )
      ENDMENU
   ENDMENU

return oMenu

//----------------------------------------------------------------------------//
