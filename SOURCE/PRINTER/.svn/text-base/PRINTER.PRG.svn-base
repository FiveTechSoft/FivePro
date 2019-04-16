#include "Sde501.Ch"
#include "InKey.ch"

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static cPrnPrinter
static nPrnProtocolo
static cPrnReset
static cPrn10Cpi
static cPrn15Cpi
static cPrnBoldActivate
static cPrnBoldDeActivate
static cPrnExpActivate
static cPrnExpDeActivate
static cPrnPaperType
static cPrnOpt1
static cPrnOpt2
static cPrnOpt3
static cPrnOpt4
static nPrnPaperLine
static nPrnPaperFoot
static lPrnLan

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function PrinterLoad()

          cPrnPrinter( Usuarios->cPrinter   )
        nPrnProtocolo( Usuarios->nProtocolo )
            cPrnReset( Usuarios->cReset     )
            cPrn10Cpi( Usuarios->c10Cpi     )
            cPrn15Cpi( Usuarios->c15Cpi     )
     cPrnBoldActivate( Usuarios->cBoldActiv )
   cPrnBoldDeActivate( Usuarios->cBoldDeAct )
      cPrnExpActivate( Usuarios->cExpandAct )
    cPrnExpDeActivate( Usuarios->cExpandDeA )
        cPrnPaperType( Usuarios->cPaperType )
             cPrnOpt1( Usuarios->cOptional1 )
             cPrnOpt2( Usuarios->cOptional2 )
             cPrnOpt3( Usuarios->cOptional3 )
             cPrnOpt4( Usuarios->cOptional4 )
        nPrnPaperLine( Usuarios->nPaperLine )
        nPrnPaperFoot( Usuarios->nPaperFoot )
              lPrnLan( Usuarios->lLan       )

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function PrinterSave()


   if lNetRecLock( 0 )

      Usuarios->cPrinter    :=        cPrnPrinter()
      Usuarios->nProtocolo  :=      nPrnProtocolo()
      Usuarios->cReset      :=          cPrnReset()
      Usuarios->c10Cpi      :=          cPrn10Cpi()
      Usuarios->c15Cpi      :=          cPrn15Cpi()
      Usuarios->cBoldActiv  :=   cPrnBoldActivate()
      Usuarios->cBoldDeAct  := cPrnBoldDeActivate()
      Usuarios->cExpandAct  :=    cPrnExpActivate()
      Usuarios->cExpandDeA  :=  cPrnExpDeActivate()
      Usuarios->cPaperType  :=      cPrnPaperType()
      Usuarios->cOptional1  :=           cPrnOpt1()
      Usuarios->cOptional2  :=           cPrnOpt2()
      Usuarios->cOptional3  :=           cPrnOpt3()
      Usuarios->cOptional4  :=           cPrnOpt4()
      Usuarios->nPaperLine  :=      nPrnPaperLine()
      Usuarios->nPaperFoot  :=      nPrnPaperFoot()
      Usuarios->lLan        :=            lPrnLan()

      DbUnLock()
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnPrinter( cNewPrinter )

   local cOldPrinter := cPrnPrinter

   if cNewPrinter != nil
      cPrnPrinter = cNewPrinter
   endif

return cOldPrinter

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function nPrnProtocolo( nNewProtocolo )

   local nOldProtocolo := nPrnProtocolo

    if nNewProtocolo != nil
       nPrnProtocolo = nNewProtocolo
    endif

return nOldProtocolo

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnReset( cNewReset )

   local cOldReset := cPrnReset

   if cNewReset != nil
      cPrnReset = cNewReset
   endif

return cOldReset

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrn10Cpi( cNew10Cpi )

   local cOld10Cpi := cPrn10Cpi

   if cNew10Cpi != nil
      cPrn10Cpi = cNew10Cpi
   endif

return cOld10Cpi

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrn15Cpi( cNew15Cpi )

   local cOld15Cpi := cPrn15Cpi

   if cNew15Cpi != nil
      cPrn15Cpi = cNew15Cpi
   endif

return cOld15Cpi

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnBoldActivate( cNewBoldActivate )

   local cOldBoldActivate := cPrnBoldActivate

   if cNewBoldActivate != nil
      cPrnBoldActivate = cNewBoldActivate
   endif

return cOldBoldActivate

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnBoldDeActivate( cNewBoldDeActivate )

   local cOldBoldDeActivate := cPrnBoldDeActivate

   if cNewBoldDeActivate != nil
      cPrnBoldDeActivate = cNewBoldDeActivate
   endif

return cOLdBoldDeActivate

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnExpActivate( cNewExpActivate )

   local cOldExpActivate := cPrnExpActivate

   if cNewExpActivate != nil
      cPrnExpActivate = cNewExpActivate
   endif

return cOldExpActivate

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnExpDeActivate( cNewExpDeActivate )

   local cOldExpDeActivate := cPrnExpDeActivate

   if cNewExpDeActivate != nil
      cPrnExpDeActivate = cNewExpDeActivate
   endif

return cOldExpDeActivate

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function  cPrnPaperType( cNewPaperType )

   local cOldPaperType := cPrnPaperType

   if cNewPaperType != nil
      cPrnPaperType = cNewPaperType
   endif

return cOldPaperType

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnOpt1( cNewOpt1 )

   local cOldOpt1 := cPrnOpt1

   if cNewOpt1 != nil
      cPrnOpt1 = cNewOpt1
   endif

return cOldOpt1

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnOpt2( cNewOpt2 )

   local cOldOpt2 := cPrnOpt2

   if cNewOpt2 != nil
      cPrnOpt2 = cNewOpt2
   endif

return cOldOpt2

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnOpt3( cNewOpt3 )

   local cOldOpt3 := cPrnOpt3

   if cNewOpt3 != nil
      cPrnOpt3 = cNewOpt3
   endif

return cOldOpt3

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cPrnOpt4( cNewOpt4 )

   local cOldOpt4 := cPrnOpt4

   if cNewOpt4 != nil
      cPrnOpt4 = cNewOpt4
   endif

return cOldOpt4

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function nPrnPaperLine( nNewPaperLine )

   local nOldPaperLine := nPrnPaperLine

   if nNewPaperLine != nil
      nPrnPaperLine = nNewPaperLine
   endif

return nOldPaperLine

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function nPrnPaperFoot( nNewPaperFoot )

   local nOldPaperFoot := nPrnPaperFoot

   if nNewPaperFoot != nil
      nPrnPaperFoot = nNewPaperFoot
   endif

return nOldPaperFoot

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function lPrnLan( lNewLan )

   local lOldLan := lPrnLan

   if lNewLan != nil
      lPrnLan = lNewLan
   endif

return lOldLan

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function GetPrn()

   VIEW
      DBF cPathStart() + "Printers" ALIAS "Printers" INDEX cPathStart() + "Printers"
   ENDVIEW

   PrnBrowse()

   RESTORE VIEW

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function PrnBrowse()

   local oBrw
   local aKeys := { { "&A¤adir" }, { "&Modificar" }, { "&Eliminar" }, ;
                    { "&Localizar" }, { "&Zoom" },                    ;
                    { "Establecer", "ÄÙ"}, { "&Salir" } }

   BROWSE oBrw FROM 5, 15 TO 18, 65
      COLUMN TITLE "Nombre de Impresora" SHOW Printers->cPrinter ;
         COLORSEL If( Printers->cPrinter == cPrnPrinter(), { 3,4 }, { 1,2 } )
      COLUMN TITLE "Comunicaci¢n"        SHOW lProtocol()
   ENDBROWSE

   ACTIVATE BROWSE oBrw TITLE AllTrim( cPrnPrinter() )     ;
   HOTKEYS aKeys                                           ;
   ON KEY Asc( "M" ) DO If( ! Eof(), lModify( oBrw ), .f.) ;
   ON KEY Asc( "A" ) DO              lAdd(    oBrw )       ;
   ON KEY Asc( "E" ) DO If( ! Eof(), lDel(    oBrw ), .f.) ;
   ON KEY Asc( "L" ) DO If( ! Eof(), lFind(   oBrw ), .f.) ;
   ON KEY Asc( "Z" ) DO If( ! Eof(), lZoom(   oBrw ), .f.) ;
   ON KEY K_ENTER    DO If( ! Eof(), lSet(    oBrw ), .f.)

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function lProtocol()
return If( Printers->nProtocolo == 1, "Paralelo", "Serie   " )

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//


static function lSet( oBrw )

             cPrnPrinter( Printers->cPrinter   )
           nPrnProtocolo( Printers->nProtocolo )
               cPrnReset( Printers->cReset     )
               cPrn10Cpi( Printers->c10Cpi     )
               cPrn15Cpi( Printers->c15Cpi     )
        cPrnBoldActivate( Printers->cBoldActiv )
      cPrnBoldDeActivate( Printers->cBoldDeAct )
         cPrnExpActivate( Printers->cExpandAct )
       cPrnExpDeActivate( Printers->cExpandDea )
           cPrnPaperType( Printers->cPaperType )
                cPrnOpt1( Printers->cOptional1 )
                cPrnOpt2( Printers->cOptional2 )
                cPrnOpt3( Printers->cOptional3 )
                cPrnOpt4( Printers->cOptional4 )
           nPrnPaperLine( Printers->nPaperLine )
           nPrnPaperFoot( Printers->nPaperFoot )
                 lPrnLan( Printers->lLan       )


   USE ( cPathStart() + "Usuarios" ) NEW SHARED

   LOCATE FOR Usuarios->nCodigo == nUsuario()
   PrinterSave()

   DbCloseArea()

   SELECT Printers

   @ 5, 17 SAY PadC( AllTrim( cPrnPrinter() ), 47 ) ;
      COLOR cClrVntTitle()

   oBrw:RefreshAll()

return .t.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lAdd( oBrw )

   local oWnd
   local nAction  := 0
   local aVars    := aCamposBlank()
   local GetList  := {}
   local lDisplay := .f.
   local cScreen  := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )
   local bSetF2   := if( SetKey( K_F2 ) != nil, SetKey( K_F2 ), nil )


   DEFINE WINDOW oWnd CENTERED SIZE 18, 70 TITLE "A¤adir Impresora"
   ACTIVATE WINDOW oWnd

   @ MaxRow(), 0 SAY Space( MaxCol() + 1 ) COLOR CClrArrBars()
   @ MaxRow(), 2 SAY "F2 ->" COLOR cClrArrKeys()
   @ MaxRow(), Col() + 2 SAY "Obtener Cuadro ASCII" COLOR cClrArrBars()

   PrnDisplay( oWnd )

   @  2, 19 GET aVars[  1 ] WINDOW oWnd ;
     WHEN ( SetKey( K_F2, bSetF2 ), .t. )
   @  5, 19 GET aVars[  2 ] WINDOW oWnd ;
     WHEN ( SetKey( K_F2, { || nGetAscii( GetList ) } ), .t. )
   @  6, 19 GET aVars[  3 ] WINDOW oWnd
   @  7, 19 GET aVars[  4 ] WINDOW oWnd
   @  8, 19 GET aVars[  5 ] WINDOW oWnd
   @  9, 19 GET aVars[  6 ] WINDOW oWnd
   @ 10, 19 GET aVars[  7 ] WINDOW oWnd
   @ 11, 19 GET aVars[  8 ] WINDOW oWnd
   @ 12, 19 GET aVars[  9 ] WINDOW oWnd
   @ 13, 19 GET aVars[ 10 ] WINDOW oWnd
   @ 14, 19 GET aVars[ 11 ] WINDOW oWnd
   @ 15, 19 GET aVars[ 12 ] WINDOW oWnd
   @ 16, 19 GET aVars[ 13 ] WINDOW oWnd ;
     WHEN ( SetKey( K_F2, { || nGetAscii( GetList ) } ), .t. )

   @  4, 48 GET aVars[ 14 ] RADIO { "Paralelo     ", "Serie" } ;
      WINDOW oWnd LABEL "Protocolo" ;
      WHEN ( SetKey( K_F2, bSetF2 ), .t. )

   @  8, 64 GET aVars[ 15 ] WINDOW oWnd PICTURE "999"
   @  9, 65 GET aVars[ 16 ] WINDOW oWnd PICTURE "99"
   @ 11, 50 GET aVars[ 17 ] CHECK "Red Local" WINDOW oWnd COLOR cClrVentanas()

   @ 14, 48 BUTTON "      &Aceptar       " WINDOW oWnd ACTION nAction := nBtnOk()
   @ 16, 48 BUTTON "      &Cancelar      " WINDOW oWnd ACTION nAction := nBtnCancel()

   SET CURSOR ON
   READ
   SET CURSOR OFF

   if nAction == 1
      DbAppend()
      aCamposGraba( aVars )
      DbUnLock()
      UpStable( oBrw )
      oBrw:RefreshAll()
      lDisplay = .t.
   endif

   DEACTIVATE WINDOW oWnd
   RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cScreen )

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lZoom( oBrw )

   local oWnd
   local nAction  := 0
   local aVars    := aCamposLee()
   local GetList  := {}
   local lDisplay := .f.
   local cScreen  := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   DEFINE WINDOW oWnd CENTERED SIZE 18, 70 TITLE "Caracter¡sticas"
   ACTIVATE WINDOW oWnd

   @ MaxRow(), 0 SAY Space( MaxCol() + 1 ) COLOR CClrArrBars()

   PrnDisplay( oWnd )

   @  2, 19 GET aVars[  1 ] WINDOW oWnd
   @  5, 19 GET aVars[  2 ] WINDOW oWnd
   @  6, 19 GET aVars[  3 ] WINDOW oWnd
   @  7, 19 GET aVars[  4 ] WINDOW oWnd
   @  8, 19 GET aVars[  5 ] WINDOW oWnd
   @  9, 19 GET aVars[  6 ] WINDOW oWnd
   @ 10, 19 GET aVars[  7 ] WINDOW oWnd
   @ 11, 19 GET aVars[  8 ] WINDOW oWnd
   @ 12, 19 GET aVars[  9 ] WINDOW oWnd
   @ 13, 19 GET aVars[ 10 ] WINDOW oWnd
   @ 14, 19 GET aVars[ 11 ] WINDOW oWnd
   @ 15, 19 GET aVars[ 12 ] WINDOW oWnd
   @ 16, 19 GET aVars[ 13 ] WINDOW oWnd
   @  4, 48 GET aVars[ 14 ] RADIO { "Paralelo     ", "Serie" } ;
      WINDOW oWnd LABEL "Protocolo"
   @  8, 64 GET aVars[ 15 ] WINDOW oWnd PICTURE "999"
   @  9, 65 GET aVars[ 16 ] WINDOW oWnd PICTURE "99"
   @ 11, 50 GET aVars[ 17 ] CHECK "Red Local" WINDOW oWnd COLOR cClrVentanas() ;
      VALID ( SayRed( aVars[ 17 ] ), .t. )

   GetList = {}

   @ 16, 48 BUTTON "      &Aceptar       " WINDOW oWnd ACTION nAction := nBtnOk()

   SET CURSOR ON
   READ
   SET CURSOR OFF

   DEACTIVATE WINDOW oWnd
   RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cScreen )

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lModify( oBrw )

   local oWnd
   local nAction  := 0
   local aVars    := aCamposLee()
   local GetList  := {}
   local lDisplay := .f.
   local cScreen  := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )
   local bSetF2   := if( SetKey( K_F2 ) != nil, SetKey( K_F2 ), nil )

   if lNetRecLock()

      DEFINE WINDOW oWnd CENTERED SIZE 18, 70 TITLE "Modificar Impresora"
      ACTIVATE WINDOW oWnd

      @ MaxRow(), 0 SAY Space( MaxCol() + 1 ) COLOR CClrArrBars()
      @ MaxRow(), 2 SAY "F2 ->" COLOR cClrArrKeys()
      @ MaxRow(), Col() + 2 SAY "Obtener Cuadro ASCII" COLOR cClrArrBars()

      PrnDisplay( oWnd )

      @  2, 19 GET aVars[  1 ] WINDOW oWnd ;
        WHEN ( SetKey( K_F2, bSetF2 ), .t. )
      @  5, 19 GET aVars[  2 ] WINDOW oWnd ;
        WHEN ( SetKey( K_F2, { || nGetAscii( GetList ) } ), .t. )
      @  6, 19 GET aVars[  3 ] WINDOW oWnd
      @  7, 19 GET aVars[  4 ] WINDOW oWnd
      @  8, 19 GET aVars[  5 ] WINDOW oWnd
      @  9, 19 GET aVars[  6 ] WINDOW oWnd
      @ 10, 19 GET aVars[  7 ] WINDOW oWnd
      @ 11, 19 GET aVars[  8 ] WINDOW oWnd
      @ 12, 19 GET aVars[  9 ] WINDOW oWnd
      @ 13, 19 GET aVars[ 10 ] WINDOW oWnd
      @ 14, 19 GET aVars[ 11 ] WINDOW oWnd
      @ 15, 19 GET aVars[ 12 ] WINDOW oWnd
      @ 16, 19 GET aVars[ 13 ] WINDOW oWnd ;
        WHEN ( SetKey( K_F2, { || nGetAscii( GetList ) } ), .t. )

      @  4, 48 GET aVars[ 14 ] RADIO { "Paralelo     ", "Serie" } ;
         WINDOW oWnd LABEL "Protocolo" ;
         WHEN ( SetKey( K_F2, bSetF2 ), .t. )

      @  8, 64 GET aVars[ 15 ] WINDOW oWnd PICTURE "999"
      @  9, 65 GET aVars[ 16 ] WINDOW oWnd PICTURE "99"
      @ 11, 50 GET aVars[ 17 ] CHECK "Red Local" WINDOW oWnd COLOR cClrVentanas() ;
         VALID ( SayRed( aVars[ 17 ] ), .t. )

      @ 14, 48 BUTTON "      &Aceptar       " WINDOW oWnd ACTION nAction := nBtnOk()
      @ 16, 48 BUTTON "      &Cancelar      " WINDOW oWnd ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
         UpStable( oBrw )
         oBrw:RefreshAll()
         lDisplay = .t.
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cScreen )
   endif

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lDel( oBrw )

   local lDisplay := .f.
   local nDelete
   local GetList  := {}

   if lNetRecLock()
      KEYBOARD Chr( K_RIGHT )
      nDelete = nMsgBox( "Confirme Borrado de Registro", " ELiminar Registro", ;
                         "   &Aceptar   ;   &Cancelar   " )
      if nDelete == 1
         DbDelete()
         DbSkip( -1 )
         If BOF()
            DbGoTop()
            if EOF()
               @ oBrw:nTop, oBrw:nLeft CLEAR TO ;
                 oBrw:nBottom, oBrw:nRight
            endif
         endif
         lDisplay = .t.
         oBrw:RefreshAll()
      endif
      DbUnLock()
   else
      nMsgBox( "Este Registro No Se Puede Borrar; Est  Bloqueado", ;
               "Eliminar Registro", "           &Aceptar          " )
   endif

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lFind( oBrw )

   local oWnd
   local lDisplay   := .f.
   local lEnd       := .f.
   local GetList    := {}
   local nRecNo     := RecNo()
   local nAction    := 0
   local cPrinter   := Space( 25 )


   DEFINE WINDOW oWnd CENTERED SIZE 6, 50 TITLE "Localizar Impresora"
   ACTIVATE WINDOW oWnd

   @  2,  8 SAY "Nombre" GET cPrinter WINDOW oWnd
   @  4,  4 BUTTON "      &Aceptar      "  WINDOW oWnd ACTION nAction := nBtnOk()
   @  4, 26 BUTTON "      &Cancelar      " WINDOW oWnd ACTION nAction := nBtnCancel()

   SET CURSOR ON
   READ
   SET CURSOR OFF

   if nAction == 1
      if cPrinter != Space( 25 )
         DbSeek( AllTrim( cPrinter ) )
      else
         lEnd = .t.
      endif
      if ! lEnd
         if EOF()
            nMsgBox( "Registro No Localizado", "Atenci¢n",;
                     "     &Aceptar     " )
            DbGoTo( nRecno )
         endif
         UpStable( oBrw )
         oBrw:RefreshAll()
         lDisplay = .t.
      endif
   endif

   DEACTIVATE WINDOW oWnd

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function PrnDisplay( oWnd )


   @  8, 50 SAY "L¡neas Papel " WINDOW oWnd
   @  9, 50 SAY "L¡neas Pie   " WINDOW oWnd

   @  2,  4 SAY "Impresora      " WINDOW oWnd
   @  4,  2 TO 17, 45 WINDOW oWnd
   @  4,  3 SAY PadC( " C¢digos de Escape ", 42, "Ä" ) WINDOW oWnd
   @  5,  4 SAY "10 C.P.I.      " WINDOW oWnd
   @  6,  4 SAY "15 C.P.I.      " WINDOW oWnd
   @  7,  4 SAY "Negrita   ON   " WINDOW oWnd
   @  8,  4 SAY "Negrita   OFF  " WINDOW oWnd
   @  9,  4 SAY "Expandida ON   " WINDOW oWnd
   @ 10,  4 SAY "Expandida OFF  " WINDOW oWnd
   @ 11,  4 SAY "Tama¤o Papel   " WINDOW oWnd
   @ 12,  4 SAY "Reset          " WINDOW oWnd
   @ 13,  4 SAY "Opcional 1     " WINDOW oWnd
   @ 14,  4 SAY "Opcional 2     " WINDOW oWnd
   @ 15,  4 SAY "Opcional 3     " WINDOW oWnd
   @ 16,  4 SAY "Opcional 4     " WINDOW oWnd

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function nGetAscii( aoGetList )

   local oWnd
   local lEnd    := .f.
   local nRow    := 3
   local nCol    := 4
   local nAction := 0
   local nKey
   local cChar   := Chr( 1 )
   local cCrsOld := SetCursor()
   local GetList := {}
   local nPosition
   local nGet
   local cString

   SET CURSOR OFF

   DEFINE WINDOW oWnd CENTERED SIZE 10, 65 TITLE "Tabla ASCII"
   ACTIVATE WINDOW oWnd


   @  6, 49 BUTTON "    &Aceptar    " WINDOW oWnd ACTION nAction := nBtnOk()
   @  8, 49 BUTTON "    &Cancelar   " WINDOW oWnd ACTION nAction := nBtnCancel()

   @  2,  2 TO  9, 47 WINDOW oWnd
   @  2, 49 TO  4, 55 WINDOW oWnd
   for n = 1 to 252
       @ nRow, nCol SAY Chr( n ) WINDOW oWnd
       nCol++
       if nCol > 45
          nCol = 4
          nRow++
       endif
   next

   nRow    := 3
   nCol    := 4

   @ nRow, nCol SAY cChar WINDOW oWnd COLOR cClrVntFA()

   while ! lEnd

      @ 3, 51 SAY Str( Asc( cChar ), 3  ) WINDOW oWnd
      nKey = InKey( 0 )
      @ nRow, nCol SAY cChar WINDOW oWnd

      do case
         case nKey == K_DOWN .and. nRow < 8
              nRow++
              cChar = Chr( Asc( cChar ) + 42 )
         case nKey == K_UP .and. nRow > 3
              nRow--
              cChar = Chr( Asc( cChar ) - 42 )
         case nKey = K_RIGHT .and. nCol < 45
              nCol++
              cChar = Chr( Asc( cChar ) + 1 )
         case nKey = K_LEFT .and. nCol > 4
              nCol--
              cChar = Chr( Asc( cChar ) - 1 )
         case nKey = K_ENTER .or. nKey == K_ESC
              lEnd = .t.
      endcase

      @ nRow, nCol SAY cChar WINDOW oWnd COLOR cClrVntFA()
   enddo

   READ

   DEACTIVATE WINDOW oWnd

    SetCursor( cCrsOld )

   if nAction == 1
      nPosition = aoGetList[ AScan( aoGetList, { | oGet | oGet:HasFocus } ) ]:Pos
      nGet = AScan( aoGetList, { | oGet | oGet:HasFocus } )
      cString = aoGetList[ nGet ]:VarGet()
      cString = Stuff( cString, nPosition, 1, cChar )
      aoGetList[ nGet ]:VarPut( cString )
   endif


return 

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function lPrnSet()

   local lReady := .f.
   local lEnd   := .f.
   local nOption

   if IsPrinter()
      lReady = .t.
   else
      do while ! lEnd
         nOption := nMsgBox( "La impresora no est  preparada", "Atenci¢n", ;
                             "  &Reintentar  ;  &Cancelar  " )
         if nOption == 1
            if IsPrinter()
               lReady = .t.
               lEnd   = .t.
            endif
         else
            lEnd = .t.
         endif
      enddo
   endif

return lReady

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function NormalType()

   SET PRINTER ON
   ?? AllTrim( cPrn10Cpi )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Compressed()

   SET PRINTER ON
   ?? AllTrim( cPrn15Cpi )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function ExpandActivate()

   SET PRINTER ON
   ?? AllTrim( cPrnExpActivate )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function ExpandDeactivate()

   SET PRINTER ON
   ?? AllTrim( cPrnExpDeActivate )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function cExpandActivate()

return AllTrim( cPrnExpActivate )

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//
function cExpandDeActivate()

return AllTrim( cPrnExpDeActivate )

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function BoldActivate()

   SET PRINTER ON
   ?? AllTrim( cPrnBoldActivate )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function BoldDeactivate()

   SET PRINTER ON
   ?? AllTrim( cPrnBoldDeActivate )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function PageFormat()

   SET PRINTER ON
   ?? AllTrim( cPrnPaperType )
   SET PRINTER OFF

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Reset()

   if cPrnReset != Space( 25 )
      SET PRINTER ON
      ?? AllTrim( cPrnReset )
      SET PRINTER OFF
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Optional1()

   if cPrnOpt1 != Space( 25 )
      SET PRINTER ON
      ?? AllTrim( cPrnOpt1 )
      SET PRINTER OFF
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Optional2()

   if cPrnOpt2 != Space( 25 )
      SET PRINTER ON
      ?? AllTrim( cPrnOpt2 )
      SET PRINTER OFF
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Optional3()

   if cPrnOpt3 != Space( 25 )
      SET PRINTER ON
      ?? AllTrim( cPrnOpt3 )
      SET PRINTER OFF
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Optional4()

   if cPrnOpt4 != Space( 25 )
      SET PRINTER ON
      ?? AllTrim( cPrnOpt4 )
      SET PRINTER OFF
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Optional()

   Optional1()
   Optional2()
   Optional3()
   Optional4()

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function SayRed( lVar )


  if lVar
     nMsgBox( "Con Impresora en Red Local La Asignaci¢n Ser :;" + ;
              "       Local --> LPT1                         ;" + ;
              "       Remota -> LPT2                         ;" + ;
              "Debe Configurar Su Spooler de Impresora de Red Para LPT2", ;
              "Impresora en Red Local", "     &Continuar    " )
  endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//
