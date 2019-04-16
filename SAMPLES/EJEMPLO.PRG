#include "Sde501.ch"
#include "InKey.Ch"

//----------------------------------------------------------------------------//

function Main()

   Arranque( "Programa de Ejemplo" )

   if lIdentifica()
      MenuBar( aMenuInit() )
   endif

   LogOut()
   Cierre()

return

//----------------------------------------------------------------------------//

function aMenuInit()

   MENU
      MENUITEM " ð "
      MENU
         MENUITEM " &Acerca de...  " ;
            ACTION nMsgBox( "Texto dentro de la Caja;varias l¡neas",;
                            "T¡tulo Caja" )
         SEPARATOR
         MENUITEM " &Terminar...   " ACTION Terminar()
      ENDMENU
      MENUITEM "  &Ficheros  "
      MENU
         MENUITEM "  &Altas   "
         MENUITEM "  &Tablas  " ACTION BrowseTest()
         MENUITEM "  &GetTest " ACTION GetTest()
      ENDMENU
      MENUITEM "  &Varios  "
      MENU
         MENUITEM "  &Imprimir... " ACTION Impresion()
      ENDMENU
      MENUITEM "  &Utilidades  "
      MENU
         MENUITEM " &Calculadora...    F2" ACTION Calc()
         MENUITEM " C&alendario...     F3" ACTION Calendar()
         MENUITEM " &Block de Notas... F4" ACTION cBlock()
         MENUITEM " &Chequear Errores... " ACTION TestError( Pepe++ )
         SEPARATOR
         MENUITEM " C&onfiguraci¢n       "
         MENU
            MENUITEM " &Monitor          " ACTION Monitor()
            MENUITEM " Paleta &VGA       " ACTION VgaPalette()
            MENUITEM " Paleta.&EGA       " ACTION Paleta()
            MENUITEM " &Usuarios         " ACTION Usuarios()
            MENUITEM " &Impresora        " ACTION GetPrn()
         ENDMENU
      ENDMENU
   ENDMENU

return

//----------------------------------------------------------------------------//

function BrowseTest()

   local oBrw

   VIEW
      DBF "Usuarios"
   ENDVIEW

   BROWSE oBrw FROM 3, 3 TO 20, 60
      COLUMN SHOW Usuarios->cNombre TITLE "Usuarios"
      COLUMN SHOW "Hola"            TITLE "Otro"
   ENDBROWSE

   ACTIVATE BROWSE oBrw TITLE "Probando" ;
      HOTKEYS { { "Aceptar", "-?" } } ;
      ON KEY Asc( "a" ) DO Alert( "Aqu¡ estamos" ) == 1

   cFldSelect()

return

//----------------------------------------------------------------------------//

function GetTest()

   local GetList := {}
   local oWnd
   local nAction := 0
   local nTest   := 1

   DEFINE WINDOW oWnd CENTERED SIZE 14, 50 TITLE "Probando Gets..."
   ACTIVATE WINDOW oWnd

   @ 2,  2 GET nTest RADIO { "Uno", "Dos", "Tres", "Cuatro" } ;
     WINDOW oWnd LABEL "&Test" VALID ( Alert( "Valida" ), .t. ) HORIZONTAL

   @ 5,  2 GET nTest RADIO { "Uno", "Dos", "Tres", "Cuatro" } ;
     WINDOW oWnd LABEL "T&est" VALID ( Alert( "Valida" ), .t. )

   @ 12, 14 BUTTON " &Aceptar  " WINDOW oWnd ACTION nAction := nBtnOk()
   @ 12, 28 BUTTON " &Cancelar " WINDOW oWnd ACTION nAction := nBtnCancel()
   READ
   SET CURSOR OFF

   DEACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//

function TestImprimir()

   if lPrintTo()

      ListBegin( { "Primera L¡nea cabecera",;
                   "Segunda L¡nea cabecera {1}" },;
                 { "1¦ l¡nea Pie", "2¦ l¡nea pie" },;
                 { { || Time() } } )

      ListLine( "Uno" )
      ListLine( "Dos" )
      ListLine( "Tres" )
      ListNextPage()
      ListEnd()

      PrintDo()
   endif

return

//----------------------------------------------------------------------------//

static function TestPixel()

   local cClrOld := SetColor( "N/N" )
   local n

 *  SET CLOCK OFF
   SAVE SCREEN
   CLS

   SetVideo( 16 )
   ScrClear( 0, 0, MaxRow(), MaxCol(), CLR_WHITE )
   ScrClear( 0, 0, 0, MaxCol(), CLR_CYAN )
   ScrClear( 1, 0, 1, MaxCol(), CLR_BLUE )
   ScrClear( MaxRow() - 1, 0, MaxRow() - 1, MaxCol(), CLR_BLUE )
   ScrClear( MaxRow(), 0, MaxRow(), MaxCol(), CLR_CYAN )
   ScrSay( 0, 15, "Programa de Ejemplo", BLACK_ON_CYAN )

   for n = 1 to 100
       SetPixel( n, 10, n )
   next
   InKey( 0 )
   SetVideo( 3 )

   SetCuaFont()
   SetBlink( .f. )
   RESTORE SCREEN
*   SET CLOCK ON
   SET CURSOR ON
   SET CURSOR OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//


function Paleta()

   local oWnd
   local nColor := 0

   DEFINE WINDOW oWnd SIZE 15, 50 TITLE "Paletas de Colores"
   ACTIVATE WINDOW oWnd

   @ oWnd:nTop + 2, oWnd:nLeft + 2 GET COLOR nColor LABEL "&Colores"
   @ oWnd:nBottom - 2, oWnd:nRight - 30 BUTTON OK
   @ oWnd:nBottom - 2, oWnd:nRight - 15 BUTTON CANCEL

   READ

   DEACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//

function Impresion()

   if lPrintTo()
   endif

return

//----------------------------------------------------------------------------//

function TestError()

   lNetUse( "printers", .f. )
   lNetRecLock( 0 )
   InKey( 0 )
   UNLOCK
   USE

return

//----------------------------------------------------------------------------//
