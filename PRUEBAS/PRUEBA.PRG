
#include 'Fivepro.ch'

function main()
local ownd
local osay1,osay2,oSay3
local oget1,oget2,oget3,oGet4
local v1:='Prueba 1',v2:=222
local v3:=3,v4:=.f.,v5:=2
local cont:=0


define window ownd from 5,5 to 20,75  menu buildmenu() 
@ 2,1 say osay1 prompt 'Texto' of ownd
@ 2,10 get oget1 var v1 picture '@!' of ownd
@ 5,1 say osay2 prompt 'Numero' of ownd
@ 5,10 get oget2 var v2 picture '9,999.99'  of ownd
// radio
@ 2,30 RADIO oget3 VAR v3 ITEMS 'Primera','&Segunda',v1,'&tercera';
	 Prompt '&Radio' of ownd
@ 7,5 checkbox oGet4 Var v4 prompt 'Chech&box' of oWnd
@ 7,50 say osay3 prompt 'Contador:'+strzero(cont,2) of ownd
@ 1,67 scrollbar range 8 size 10 ;
	on up (cont--,oSay3:Display()) ;
	on down (cont++,oSay3:Display()) of oWnd
@ 0,30 scrollbar range 8 size 20 Horizontal;
	on up (cont--,oSay3:Display()) ;
	on down (cont++,oSay3:Display()) of oWnd
	
@ 10,55 button ' &fin ' action oWnd:end of oWnd
@ 6,15 listbox ;
  oGet5 var v5 size 10 , 5 Items {'Uno','Dos','Tres','Cuatro','Cinco',;
  'Uno','Dos','Tres','Cuatro','Cinco'} of Ownd
/*
@ 10,35 combobox v1 size 10,5 items	{'Uno','Dos','Tres','Cuatro','Cinco',;
  'Uno','Dos','Tres','Cuatro','Cinco'} window oWnd
  */
activate window ownd


function buildmenu()


   local oMenu

   MENU oMenu AT 1
      MENUITEM " &Bases de Datos " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Usar DBF... " ;
            MESSAGE "Visualizar los datos contenidos en un fichero DBF" ;
            // DbfUse()
         MENUITEM " &Crear DBF... " // Alert( cGetHotKey( "Hol&e" ) )
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
            // If( lMsgEnd(), oWndMain:End,) SHORTCUT K_ALT_X ;
            // MESSAGE "Terminar de usar el IDE y regresar al DOS"
      ENDMENU

      MENUITEM " &Recursos " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Men£ Principal... "    // DlgMenu()
         MENUITEM " &Cajas de Di logo...  " // DlgNew()
         SEPARATOR
         MENUITEM " &Controles... "
         MENUITEM " C&olores... "
         SEPARATOR
         MENUITEM " &Listados... "
         MENUITEM " &Etiquetas... "
         MENUITEM " &Mailings... "
      ENDMENU

      MENUITEM " &Programa " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Editar Programa... " // PrgEdit()
         MENUITEM " &Nuevo Programa... "  // PrgNew()
         SEPARATOR
         MENUITEM " &Compilar... "  // Compile()
         MENUITEM " &Enlazar... "   // Link()
         MENUITEM " &Construir... " // Make()
         MENUITEM " &Ejecutar... "  // Execute()
         SEPARATOR
         MENUITEM " &Especificar Par metros... " ;
            // lMsgGet( "Par metros ejecuci¢n", "&Especificar", @cParams )
      ENDMENU

      MENUITEM " Proy&ecto " MESSAGE "Mantenimiento de ficheros"
      MENU
         MENUITEM " &Usar Proyecto... " ;
            MESSAGE "Editar un proyecto en desarrollo" ;
            // Project()

         MENUITEM " &Nuevo Proyecto... " ;
            MESSAGE "Comenzar un nuevo proyecto" // PrjNew()
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
            MESSAGE "Establecer los directorios de trabajo" // Directories()
         SEPARATOR
         MENUITEM " &Personalizaci¢n...  "
         SEPARATOR
         MENUITEM " &Guardar opciones... " MESSAGE "Salvar a disco la configuraci¢n establecida"
      ENDMENU

      MENUITEM " &Utilidades "
      MENU
         MENUITEM " &Block de Notas... "
         MENUITEM " &Calculadora... " // Calc( oWndMain ) ;
            // MESSAGE "Utilizar la calculadora"
         MENUITEM " &Agenda... " // Calendar( Date() )
         SEPARATOR
         MENUITEM " &Mosaico Ventanas " // oWndMain:Tiled()
         MENUITEM " Ca&scada Ventanas " // oWndMain:Cascade()
      ENDMENU

      MENUITEM " &Ayuda " MESSAGE "Mantenimiento de ficheros" ;
         // ( MOff(), Alert( "Hola" ), MOn() )
      MENU
         MENUITEM " &Indice... "
         MENUITEM " &Buscar por... " // BuscarPor()
         MENUITEM " &Ultima consulta...  "
         SEPARATOR
         MENUITEM " &Acerca de... " // AcercaDe() ;
            // MESSAGE "Informaci¢n acerca de este programa"
      ENDMENU
   ENDMENU

return oMenu


