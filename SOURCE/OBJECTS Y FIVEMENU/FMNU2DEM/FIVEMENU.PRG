#include "InKey.ch"
#include "Menu.ch"

// ----------------------------------------------------------------------------

function Main()

  SET CURSOR OFF
  SetBlink( .f. )
  SetCancel( .f. )

  TrueShadow( .t. )
  FntBoxRnd()

  RestScreen( 0, 0, MaxRow(), MaxCol(), MemoRead( "FiveMenu.Bin" ) )

  ACTIVATE MENU MenuBuild() ;
     ON IDLE ( DispClock(), ScrSave() )

  FntSystem()
  CLS

return

// ----------------------------------------------------------------------------

function MenuBuild()

   local oMenu
   local mitShadows
   local mitSombras
   local mitTrueShadows
   local mitVerSombras
   local mitChecked
   local mitChequeado
   local lShadows    := .t.
   local lTrueShadow := .t.
   local nShadow     := 7

   MENU oMenu AT 0 MESSAGE AT MaxRow() COLOR "W+/B", "N/BG", "R+/B", "R+/BG",;
                                             "W/B", "W/BG"
      MENUITEM " ð " MESSAGE "Informaci¢n general"
      MENU
         MENUITEM " &Acerca de...       F1 " SHORTCUT K_F1 ACTION AcercaDe() MESSAGE "Acerca de este producto"
         MENUITEM " &Distribuci¢n...    F2 " SHORTCUT K_F2 MESSAGE "Shareware - Probar antes de comprar" ;
            ACTION nAlert( " Reg¡strese por s¢lo 2.500 pts. ;" +;
                   " y recibir  la £ltima versi¢n ;" +;
                   " con derecho a soporte t‚cnico. ;;" +;
                   " Recibir  peri¢dicamente un cat logo ;" +;
                   " con otras utilidades que hemos realizado;" +;
                   " y muchas otras que estamos preparando.;;" +;
                   " Esta librer¡a contiene muchas otras ;" +;
                   " funciones que est n explicadas en la;" +;
                   " gu¡a Norton que acompa¤a a la versi¢n;" +;
                   " registrada! " )
         SEPARATOR
         MENUITEM " &Reg¡strate ya!...  F3" SHORTCUT K_F3 MESSAGE "Y obt‚n un mont¢n de ventajas" ;
            ACTION nAlert( " Este programa es la versi¢n de evaluaci¢n.;" +;
                   " S¡ le es de utilidad y est  convencido;" +;
                   " de su eficacia, debe registrarse.;;" +;
                   " De est  forma soporta el esfuerzo del;" +;
                   " autor y se beneficia del bajo coste.;;" +;
                   " Ayudar a la difusi¢n del ShareWare es;" +;
                   " ayudarte a t¡.", { "Gracias" } )
      ENDMENU
      MENUITEM " &The New "
      MENU
         MENUITEM " &PullDown Menu " MESSAGE "RUNsoft is proud to present ..."
         MENUITEM " &and PopMenu   " MESSAGE "The easiest menu system for Clipper 5"
         MENUITEM " &Classes "       MESSAGE "With a powerfull xBase syntax"
         MENUITEM " &Hierarchy "     MESSAGE "Builted with 100% OOPS technology"
         MENUITEM " &From "          MESSAGE "And without needing any OOPS external engine"
         MENUITEM " &RUNsoft "       MESSAGE "And all just for only 25$ - Order it NOW!"
      ENDMENU
      MENUITEM " &Features "
      MENU
         MENUITEM "  &Multiples " MESSAGE "No need for DO...CASE structures"
         MENU
            MENUITEM " &And Nested... "
            MENUITEM " &SubMenus  "
            MENUITEM " &with an "
            MENU
               MENUITEM " &Easy and "
               MENUITEM " &powerfull "
               MENUITEM " XBase &Sintax  "
               MENU
                  MENUITEM " &MENU "
                  MENUITEM "    M&ENUITEM ... MESSAGE ... ACTION ... "
                  MENUITEM "    ME&NUITEM ... MESSAGE ... ACTION ... "
                  MENUITEM "    MEN&U"
                  MENUITEM "       ...  (as many &levels as you need) "
                  MENUITEM "    EN&DMENU"
                  MENUITEM "    MENUITEM ... MESSAGE ... &ACTION ... "
                  MENUITEM " &ENDMENU "
               ENDMENU
            ENDMENU
         ENDMENU
         SEPARATOR
         MENUITEM "  S&eparators " MESSAGE "Automatic code evaluation"
         SEPARATOR
         MENUITEM mitChecked PROMPT "  C&hecked and " CHECKED ;
                  ACTION mitChecked:lChecked := !mitChecked:lChecked;
                  MESSAGE "Each menuitem is also an object!"
         MENUITEM "  &Inactive " MESSAGE "Modal and event driven execution" DISABLED
         MENUITEM "  &Options "  MESSAGE "Auto centered message line with configurable position"
         SEPARATOR
         MENUITEM "  Short&Cuts       Alt-V " SHORTCUT K_ALT_V MESSAGE "All with an incredible new graphical mouse driver!"
         SEPARATOR
         MENUITEM "  Configurable &Shadows  " MESSAGE "Great looking with total configurable shadows... Try True Shadows!"
         MENU
            MENUITEM mitShadows PROMPT "  &Activated " MESSAGE "Activate or deactivate shadows" ;
                                ACTION ( lShadows := !lShadows, mitShadows:lChecked := lShadows, mitSombras:lChecked := lShadows, SetShadow( lShadows ) ) ;
                                CHECKED
            MENUITEM mitTrueShadows PROMPT "  &True shadows " MESSAGE "True Shadows" ;
                                    ACTION ( lTrueShadows := !lTrueShadows, mitTrueShadows:lChecked := lTrueShadows, mitVerSombras:lChecked := lTrueShadows, TrueShadow( lTrueShadows ) ) ;
                                    CHECKED
            MENUITEM "  &With Colors... " ACTION ClrShadow( nShadow++ ) ;
                                          MESSAGE "Increments the shadow's color"
         ENDMENU
      ENDMENU
      MENUITEM " &El nuevo "
      MENU
         MENUITEM " &Menu de persiana " MESSAGE "RUNsoft se enorgullece de presentar..."
         MENUITEM " con jerarquia "     MESSAGE "El m s facil sistema de men£s para Clipper 5"
         MENUITEM " de clases "         MESSAGE "Construido 100% con tecnolog¡a OOPS"
         MENUITEM " &de "               MESSAGE "Y sin necesidad de maquinaria OOPS externa"
         MENUITEM " &RUNsoft "          MESSAGE "Todo por solo 2.500 ptas - ­P¡dalo!"
      ENDMENU
      MENUITEM " &Caracter¡sticas "
      MENU
         MENUITEM "  &Anidaci¢n " MESSAGE "Sin necesidad de estructura DO...CASE"
         MENU
            MENUITEM " &de submen£s "
            MENUITEM " &a m£ltiples  "
            MENUITEM " &niveles "
            MENUITEM " &con una... "
            MENU
               MENUITEM " &facil y "
               MENUITEM " &potente "
               MENUITEM " sintaxis &XBase "
               MENU
                  MENUITEM " &MENU "
                  MENUITEM "    M&ENUITEM ... MESSAGE ... ACTION ... "
                  MENUITEM "    ME&NUITEM ... MESSAGE ... ACTION ... "
                  MENUITEM "    MEN&U"
                  MENUITEM "       ...  (tantos niveles como necesite) "
                  MENUITEM "    EN&DMENU"
                  MENUITEM "    MENUITEM ... MESSAGE ... &ACTION ... "
                  MENUITEM " &ENDMENU "
               ENDMENU
            ENDMENU
         ENDMENU
         SEPARATOR
         MENUITEM "  S&eparadores " MESSAGE "Evaluaci¢n de c¢digo autom tica"
         SEPARATOR
         MENUITEM "  &Opciones " MESSAGE "L¡nea de mensaje auto centrada con posici¢n configurable"
         MENUITEM mitChequeado PROMPT "  C&hecked y " CHECKED ;
                  ACTION mitChequeado:lChecked := !mitChequeado:lChecked;
                  MESSAGE "Cada item de men£ es un objeto"
         MENUITEM "  &Inactiva " MESSAGE "Ejecuci¢n modal y conducida por eventos"  DISABLED
         SEPARATOR
         MENUITEM "  Short&Cuts       Alt-V " SHORTCUT K_ALT_V MESSAGE "Todo con un increible driver de rat¢n gr fico"
         SEPARATOR
         MENUITEM "  &Sombras configurables  " MESSAGE "Apariencia totalmente profesional... ­Prueba las sombras verdaderas!"
         MENU
            MENUITEM mitSombras PROMPT "  &Activadas " MESSAGE "Activa o desactiva las sombras" ;
                                ACTION ( lShadows := !lShadows, mitShadows:lChecked := lShadows, mitSombras:lChecked := lShadows, SetShadow( lShadows ) ) ;
                                CHECKED
            MENUITEM mitVerSombras PROMPT "  &Verdaderas " MESSAGE "Sombras verdaderas" ;
                                    ACTION ( lTrueShadows := !lTrueShadows, mitTrueShadows:lChecked := lTrueShadows, mitVerSombras:lChecked := lTrueShadows, TrueShadow( lTrueShadows ) ) ;
                                    CHECKED
            MENUITEM "  &Colores... " ACTION ClrShadow( nShadow++ ) ;
                                      MESSAGE "Aumenta en uno el color de la sombra"
         ENDMENU
      ENDMENU
      MENUITEM " &Salida " MESSAGE "Terminar la ejecuci¢n del programa"
      MENU
         MENUITEM " &Exit  Alt-X " SHORTCUT K_ALT_X MESSAGE "Salir al DOS" ;
            ACTION oMenu:lEnd := .t.
      ENDMENU
   ENDMENU

return oMenu

// ----------------------------------------------------------------------------

function DispClock()

   local nCrsOld := SetCursor( 0 )
   local nRow    := Row()
   local nCol    := Col()
   local lMOver  := .f.

   static cOldTime

   if cOldTime == nil
      cOldTime = Time()
   endif

   if cOldTime != Time()

      if nMRow() == 0 .and. nMCol() >= MaxCol() - 8
         MOff()
         lMOver = .t.
      endif

      @ 0, MaxCol() - 8 SAY Time() COLOR "GR+/B"

      if lMOver
         MOn()
      endif

      SetPos( nRow, nCol )
      SetCursor( nCrsOld )
      cOldTime = Time()
   endif

return

// ----------------------------------------------------------------------------

function ScrSave()

   static nTimes   := 0

   if ! lIsIdle()
      nTimes   = 0
   else
      if nTimes++ == 15000
         AbsoluteDark()
         nTimes = 0
      end
   end

return

// ----------------------------------------------------------------------------

function AbsoluteDark()

   local nMOldRow := nMRow()
   local nMOldCol := nMCol()

   VgaOff()

   while Inkey() == 0 .and. !lMPressed() .and. ;
         nMOldRow == nMRow() .and. nMOldCol == nMCol()
      MUpdate()
   end

   VgaOn()

return

// ----------------------------------------------------------------------------

function AcercaDe()

   nAlert( "FiveMenu 2.0 for Clipper 5;(Antes FastMenu); 1.993 RUNsoft;;Completamente codificado en OOPS;y con sintaxis xBase;;Realizado por:; Juan Miguel Sosso; Antonio Linares" )
   nAlert( "RUNsoft;M laga 40, 3§;29600 Marbella (MA);Spain;;B.B.S. bAuHaUs;+34-5-221-3374 (24h);RUNsoft area;;2:345/201.8@fidonet.org;CIS: 100114,1776" )

return

// ----------------------------------------------------------------------------
// Es como Alert solo que desactiva la flecha del rat¢n

function nAlert( cMsg, aOp, cClr )

   MOff()
   Alert( cMsg, aOp, cClr )
   MOn()

return

// ----------------------------------------------------------------------------
