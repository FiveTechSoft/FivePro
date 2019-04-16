#include "FivePro.ch"

static oWndMain
static cParams := "                                          "

//----------------------------------------------------------------------------//

function Main()

   local oSay

   // SetDeskWallPaper( "FivePro2.pcx" )

   DEFINE WINDOW oWndMain ;
      FROM 0, 0 TO MaxRow(), MaxCol() ;
      TITLE "FivePro 2.0 - IDE" ;
      MENU BuildMenu() ;
      COLOR "W+/BG, N*/W" ;
      NOZOOM NOGROW NOFLOAT NOICONIZE

   DEFINE BUTTONBAR OF oWndMain

   // @ 5, 0 BITMAP FILENAME "FivePro.bin" SIZE 80, 10 OF oWndMain

   ACTIVATE WINDOW oWndMain

   CLS

return nil

//----------------------------------------------------------------------------//

function BuildMenu()

   local oMenu
   local oDesign

   MENU oMenu AT 1
      MENUITEM " &Bases de Datos " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Usar DBF... " ;
            MESSAGE "Visualizar los datos contenidos en un fichero DBF" ;
            ACTION DbfUse()
         MENUITEM " &Crear DBF... " ACTION Alert( cGetHotKey( "Hol&e" ) )
         MENUITEM " &Areas de Trabajo... "
         SEPARATOR
         MENUITEM " &Usar Indice... "
         MENUITEM " &Crear Indice... "
         SEPARATOR
         MENUITEM " &Relaciones... "
         MENU
            MENUITEM " &Revisar... "
            MENUITEM " &Establacer nueva... "
            MENUITEM " E&liminar... "
         ENDMENU
         MENUITEM " &Filtros... "
         MENUITEM " &RDDs... "
         SEPARATOR
         MENUITEM " &Terminar...  Alt-X " ;
            ACTION If( lMsgEnd(), oWndMain:End,) SHORTCUT K_ALT_X ;
            MESSAGE "Terminar de usar el IDE y regresar al DOS"
      ENDMENU

      MENUITEM " &Recursos " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Men£ Principal... "    ACTION DlgMenu()
         MENUITEM " &Cajas de Di logo...  " ACTION DlgNew()
         SEPARATOR
         MENUITEM " &Controles... " action alert('Prueba;ahora',{'si','no'})
         MENUITEM " C&olores... "
         SEPARATOR
         MENUITEM " &Listados... "
         MENUITEM " &Etiquetas... "
         MENUITEM " &Mailings... "
      ENDMENU

      MENUITEM " &Programa " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Editar Programa... " ACTION PrgEdit()
         MENUITEM " &Nuevo Programa... "  ACTION PrgNew()
         SEPARATOR
         MENUITEM " &Compilar... "  ACTION Compile()
         MENUITEM " &Enlazar... "   ACTION Link()
         MENUITEM " &Construir... " ACTION Make()
         MENUITEM " &Ejecutar... "  ACTION Execute()
         SEPARATOR
         MENUITEM " &Especificar Par metros... " ;
            ACTION lMsgGet( "Par metros ejecuci¢n", "&Especificar", @cParams )
      ENDMENU

      MENUITEM " Proy&ecto " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Usar Proyecto... " ;
            MESSAGE "Editar un proyecto en desarrollo" ;
            ACTION Project()

         MENUITEM " &Nuevo Proyecto... " ;
            MESSAGE "Comenzar un nuevo proyecto" ACTION PrjNew()
         SEPARATOR
         MENUITEM " &A¤adir Elemento...  " MESSAGE "A¤adir un nuevo elemento al proyecto"
         MENUITEM " &Modificar Elemento... " MESSAGE "Variar caracter¡sticas de un elemento"
         SEPARATOR
         MENUITEM " &Generar C¢digo... "
         MENU
            MENUITEM " &Plantillas... "
            MENUITEM " &Nuevas Clases... "
            MENUITEM " &Data-Driven... "
         ENDMENU
      ENDMENU

      MENUITEM " &Opciones " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Configuraci¢n IDE... "
         MENUITEM " &Directorios... " ;
            MESSAGE "Establecer los directorios de trabajo" ACTION Directories()
         SEPARATOR
         MENUITEM " &Personalizaci¢n...  "
         SEPARATOR
         MENUITEM " &Guardar opciones... " MESSAGE "Salvar a disco la configuraci¢n establecida"
      ENDMENU

      MENUITEM " &Utilidades "
      MENU
         MENUITEM " &Block de Notas... "
         MENUITEM " &Calculadora... " ACTION Calc( oWndMain ) ;
            MESSAGE "Utilizar la calculadora"
         MENUITEM " &Agenda... " ACTION Calendar( Date() )
         SEPARATOR
         MENUITEM " &Mosaico Ventanas " ACTION oWndMain:Tiled()
         MENUITEM " Ca&scada Ventanas " ACTION oWndMain:Cascade()
      ENDMENU

      MENUITEM " &Ayuda " MESSAGE "Mantenimiento de ficheros" ;
         ACTION ( MOff(), Alert( "Hola" ), MOn() )
      MENU
         MENUITEM " &Indice... "
         MENUITEM " &Buscar por... " ACTION BuscarPor()
         MENUITEM " &Ultima consulta...  "
         SEPARATOR
         MENUITEM " &Acerca de... " ACTION AcercaDe() ;
            MESSAGE "Informaci¢n acerca de este programa"
      ENDMENU
   ENDMENU

return oMenu

//----------------------------------------------------------------------------//

function DbfUse()

   local oDlg, oBrw

   USE Dialog

   BROWSE oBrw COLOR "W+/BG, W+/N"
      COLUMN TITLE "Nombre"  SHOW Dialog->Name
      COLUMN TITLE "FivePro" SHOW Dialog->FivePro
      COLUMN TITLE "Dialog"  SHOW Dialog->Dialog
   ENDBROWSE

//   DEFINE window oDlg OF oWndMain ;
 //     FROM 1, 4 TO 18, 75 TITLE "Dialog Users" ;
   DEFINE window oDlg;
      FROM 1, 4 TO 18, 75 TITLE "Dialog Users" 


   DEFINE BUTTONBAR OF oDlg

   @  0,  2 LISTBOX BROWSE oBrw LOGICLEN Dialog->( RecCount() ) ;
      OF oDlg SIZE 67, 12

   @ 13,  2 BUTTON "   &New   " OF oDlg
   @ 13, 14 BUTTON "  &Edit  "  OF oDlg ACTION CliEdit()
   @ 13, 25 BUTTON "   &Del   " OF oDlg
   @ 13, 37 BUTTON "  &Seek  "  OF oDlg ACTION CliSeek()
   @ 13, 48 BUTTON "  &Print  " OF oDlg
   @ 13, 60 BUTTON "  E&xit  "  OF oDlg ACTION oDlg:End()

   ACTIVATE DIALOG oDlg 

return nil

//----------------------------------------------------------------------------//

function CliEdit()

   local oWnd
   local uVar     := Dialog->Name
   local lFivePro := Dialog->FivePro
   local lDialog  := Dialog->Dialog

   DEFINE WINDOW oWnd FROM 6, 12 TO 19, 70 ;
      TITLE "Edit Client"

   @  2,  2 SAY "&Nombre:" OF oWnd

   @  2, 10 GET uVar OF oWnd

   @  4,  2 CHECKBOX lFivePro PROMPT "&FivePro" OF oWnd
   @  5,  2 CHECKBOX lDialog  PROMPT "&Dialog"  OF oWnd

   @ 10, 15 BUTTON " &Aceptar "  OF oWnd ACTION oWnd:End()
   @ 10, 28 BUTTON " &Cancelar " OF oWnd ACTION oWnd:End()

   ACTIVATE WINDOW oWnd

return nil

//----------------------------------------------------------------------------//

function CliSeek()

   local cName := Dialog->Name

   if lMsgGet( "Cliente a buscar", "&Nombre:", @cName )
   endif

return nil

//----------------------------------------------------------------------------//

function PrgEdit()

   MemoWrit( "Test.rc", oWndMain:GenRC() )
   Tone( 900, 0.2 )

return nil

//----------------------------------------------------------------------------//

function Project()

   local oDlg
   local cItem

   DEFINE DIALOG oDlg FROM 7, 30 TO 17, 60 ;
      TITLE "Proyecto" OF oWndMain 

   @  2,  2 LISTBOX cItem PROMPT "&Unidades" ;
      ITEMS { "Uno", "Dos", "Tres" } SIZE 10, 4 OF oDlg

   @  2, 14 BUTTON " &Hola  " OF oDlg ACTION ( MOff(), Alert( "Hola" ), MOn() )
   @  4, 14 BUTTON " &Adios " OF oDlg

   ACTIVATE DIALOG oDlg NOWAIT

return nil

//----------------------------------------------------------------------------//

function DlgNew()

   local oDlg, dlgTools
   local bPaint
   local nControl := 1

   DEFINE DIALOG oDlg ;
      FROM 2, 3 TO 17, 55 TITLE "Nueva Caja de Di logo" ;
      OF oWndMain

   ACTIVATE DIALOG oDlg NOWAIT ;
      ON PAINT DispBox( oDlg:nTop + 1, oDlg:nLeft + 1, oDlg:nBottom - 1,;
                        oDlg:nRight - 1, "úúúúúúúúú", "W+/B" )

   // Ahora construimos la ventana de herramientas

   DEFINE DIALOG dlgTools TITLE "Controles" ;
      FROM 1, 59 TO 21, 75 OF oWndMain 

   @ 1, 1 RADIO nControl ;
      ITEMS "&Label", "&PushButton", "L&istBox", "&ComboBox", "&Get",;
            "&Say", "C&heckBox", "&Radio", "&Box" ;
      OF dlgTools LABEL "&Controles"

   @  12, 1 BUTTON " &Add " OF dlgTools ACTION ControlAdd( oDlg, nControl )

   @  12, 8 BUTTON " &Try " OF dlgTools ;
      ACTION ( AEval( oDlg:aControls,;
               { | oCtrl | oCtrl:Hide(), oCtrl:lDrag := .f. } ),;
               oDlg:Hide(), bPaint := oDlg:bPainted,;
               oDlg:bPainted := nil, oDlg:Activate(), oDlg:bPainted := bPaint,;
               oDlg:Display(),;
               AEval( oDlg:aControls, { | oCtrl | oCtrl:lVisible := .f., oCtrl:lDrag := .t. } ) )

   @ 14, 1 BUTTON " &Gen " OF dlgTools ;
      ACTION ( MemoWrit( "Temp", oDlg:GenCode() ), Alert( "Fichero Temp creado" ) )

   @ 14, 8 BUTTON " &End " OF dlgTools

   @ 16, 1 BUTTON "   To &Disk  " OF dlgTools ;
      ACTION ( oDlg:Hide(), oDlg:oWnd := nil,;
               lOWrite( "Test.dlg", oDlg ),;
               oDlg:oWnd := oWndMain, oDlg:Display() )

   @ 18, 1 BUTTON " &Load " OF dlgTools ;
      ACTION ( oDlg:Hide(), ADeepCopy( oDlg, oORead( "Test.dlg" ) ),;
               oDlg:oWnd := oWndMain, oDlg:Display() )

   ACTIVATE DIALOG dlgTools NOWAIT

return nil

//----------------------------------------------------------------------------//

function ControlAdd( oDlg, nControl )

   local oControl
   local cVar := "          "
   local nVar := 1
   local lVar := .t.

   do case
      case nControl == 1      // Label
           @ 2, 2 SAY oControl PROMPT "&Label" OF oDlg

      case nControl == 2      // PushButton
           @ 2, 2 BUTTON oControl PROMPT " &Button " OF oDlg

      case nControl == 3      // ListBox
           @ 2, 2 LISTBOX oControl VAR cVar ITEMS { "One", "Two", "Three" } ;
               OF oDlg SIZE 15, 12 PROMPT "&ListBox"

      case nControl == 5      // Get
           @ 2, 2 GET oControl VAR cVar OF oDlg COLOR "W+/BG, W+/R"

      case nControl == 7      // CheckBox
           @ 2, 2 CHECKBOX oControl VAR lVar PROMPT "&CheckBox" ;
              OF oDlg COLOR "W/B, W+/B"

      case nControl == 8      // Radio
           @ 2, 2 RADIO oControl VAR nVar ITEMS "&One", "&Two", "T&hree " ;
              OF oDlg
   endcase

   oControl:lDrag = .t.
   oControl:Display()

return nil

//----------------------------------------------------------------------------//

function NewLabel( oDlg )

   local oLabel

   @ 2, 2 SAY oLabel PROMPT "&Label" OF oDlg

   oLabel:lDrag = .t.
   oLabel:Show()

return oLabel

//----------------------------------------------------------------------------//

function NewButton( oDlg )

   local oBtn

   @ 2, 2 BUTTON oBtn PROMPT " &Button " OF oDlg

   oBtn:lDrag = .t.
   oBtn:Show()

return oBtn

//----------------------------------------------------------------------------//

function NewEdit( oDlg )

   local oEdit
   local cTemp := Space( 30 )

   @ 2, 2 GET oEdit VAR cTemp OF oDlg

   oEdit:lDrag = .t.
   oEdit:Show()

return oEdit

//----------------------------------------------------------------------------//

function NewListBox( oDlg )

   local oLbx
   local cTemp := ""

   @ 2, 2 LISTBOX oLbx VAR cTemp ITEMS { "Uno", "Dos", "Tres" } OF oDlg

   oLbx:lDrag = .t.
   oLbx:Show()

return oLbx

//----------------------------------------------------------------------------//

function AcercaDe()

   local oWnd

   DEFINE WINDOW oWnd SIZE 45, 10 ;
      TITLE "Acerca De" ;
      COLOR "W+/RB, N*/W" NOGROW NOZOOM

   @ 2, 20 SAY "IDE 1.0" OF oWnd
   @ 4, 16 SAY Transform( Memory( 0 ), "Memoria disponible: 99,999" ) OF oWnd

   @ 7, 17 BUTTON " &Continuar " OF oWnd ACTION oWnd:End()

   ACTIVATE WINDOW oWnd ON PAINT IcoIde( 2 + oWnd:nTop, 2 + oWnd:nLeft )

return nil

//----------------------------------------------------------------------------//

function DlgMenu()

   local oWnd
   local oMenu
   
   MENU oMenu
      MENUITEM " &Popup1 "
      MENU
         MENUITEM " &First... "
         MENUITEM " &Second... "
         MENUITEM " &Third... "
      ENDMENU

      MENUITEM " &Popup2 "
      MENU
         MENUITEM " &First... "
         MENUITEM " &Second... "
         MENUITEM " &Third... "
      ENDMENU
   ENDMENU

   DEFINE WINDOW oWnd OF oWndMain FROM 2, 3 TO 18, 75 ;
      TITLE "Men£ Principal" COLOR "W+*/G, G*/W";
      GROW ;
      MENU oMenu
   
   ACTIVATE WINDOW oWnd NOWAIT

return nil

//----------------------------------------------------------------------------//

function Compile()

   MOff()
   SAVE SCREEN
   SET COLOR TO "W/N"
   CLS
   SwpRunCmd( "IdeComp noname /n/w" )
   nMKeyWait( 0 )
   REST SCREEN
   MOn()

return nil

//----------------------------------------------------------------------------//

function Link()

   MOff()
   SAVE SCREEN
   SET COLOR TO "W/N"
   CLS
   SwpRunCmd( "IdeLink noname" )
   nMKeyWait( 0 )
   REST SCREEN
   MOn()

return nil

//----------------------------------------------------------------------------//

function Make()

   local cClrOld := SetColor( "W/N" )

   MOff()
   SAVE SCREEN
   CLS
   SwpRunCmd( "IdeMake noname" )
   SetCursor( 1 )
   SetCursor( 0 )
   SetColor( cClrOld )
   REST SCREEN
   MOn()

return nil

//----------------------------------------------------------------------------//

function Execute()

   MOff()
   SwpRunCmd( "IdeExec noname" )

   MReset()
   MInit( .t. )

   SetCursor( 1 )
   SetCursor( 0 )
   MOn()

return nil

//----------------------------------------------------------------------------//

function BuscarPor()

   local cBusca := Space( 30 )

   if lMsgGet( "Buscar por", "&Expresi¢n", @cBusca )
   endif

return nil

//----------------------------------------------------------------------------//

function Directories()

   local oDlg
   local cInclude   := Space( 30 )
   local cLibraries := Space( 30 )
   local cBinary    := Space( 30 )

   DEFINE WINDOW oDlg FROM 6, 13 TO 17, 63 TITLE "Directorios"

   @ 2,  3 SAY "&Include    .CH:" OF oDlg
   @ 2, 19 GET cInclude OF oDlg
   @ 4,  3 SAY "&Libraries .LIB:" OF oDlg
   @ 4, 19 GET cLibraries OF oDlg
   @ 6,  3 SAY "&Binary    .EXE:" OF oDlg
   @ 6, 19 GET cBinary OF oDlg

   @ 8,  8 BUTTON " &Aceptar "  OF oDlg ACTION oDlg:End()
   @ 8, 21 BUTTON " &Cancelar " OF oDlg ACTION oDlg:End()
   @ 8, 35 BUTTON "  &Ayuda  "  OF oDlg

   ACTIVATE DIALOG oDlg

return nil

//----------------------------------------------------------------------------//

function PrgNew()

   local oWnd
   local cPrg  := "NONAME"
   local nFile := 1
   local cName := "NONAME01.PRG"

   while File( cName )
      cName = cPrg + PadL( nFile++, 2, "0" ) + ".prg"
   end

   MemoWrit( cName, "// FivePro 2.0" )

   DEFINE WINDOW oWnd FROM 2, 2 TO 12, 40 TITLE cName ;
     OF oWndMain

   ACTIVATE WINDOW oWnd NOWAIT

return nil

//----------------------------------------------------------------------------//

function PrjNew()

   local oDlg
   local oBrw

   USE Project

   BROWSE oBrw COLOR "W+/BG, W+/N"
      COLUMN SHOW Project->Type TITLE "Tipo"
      COLUMN SHOW Project->Name TITLE "Nombre"
   ENDBROWSE

   DEFINE DIALOG oDlg FROM 2, 30 TO 18, 75 ;
      TITLE "Nuevo Projecto" OF oWndMain 

   @  1,  2 LISTBOX BROWSE oBrw PROMPT "&Elementos" SIZE 32, 14 OF oDlg

   @  2, 37 BUTTON "&A¤adir" OF oDlg ACTION PrjAdd()

   @  4, 37 BUTTON "&Editar" OF oDlg ACTION ( oDlg:Minimize(), DlgNew() )

   ACTIVATE DIALOG oDlg NOWAIT

return nil

//----------------------------------------------------------------------------//

function PrjAdd()

   local oDlg
   local nElemento := 1

   DEFINE WINDOW oDlg FROM 8, 21 TO 16, 49 ;
      TITLE "Elemento a a¤adir"

   @  0,  0 RADIO nElemento ITEMS "&Menu", "&Di logo", "&Listado" ;
      PROMPT "&Tipos" OF oDlg

   @  2, 18 BUTTON "&Button" OF oDlg

   @  4, 18 BUTTON "&Button" OF oDlg

   ACTIVATE WINDOW oDlg

return nil

//----------------------------------------------------------------------------//
