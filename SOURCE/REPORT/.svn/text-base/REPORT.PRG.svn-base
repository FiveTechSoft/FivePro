#include "Sde501.ch"
#include "InKey.ch"

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Report()

   local lEnd := .t.

   if ! File( "Reports.dbf" )
      DbCreate( "Reports", { { "nDbfLines" , "N",   4, 0 } , ; && 1  Dbf de las lineas
                             { "cTitle"    , "C",  50, 0 } , ; && 2  Titulo en la tabla
                             { "cHead1"    , "C", 132, 0 } , ; && 3  Cabecera 1
                             { "cEscHead1" , "C",  70, 0 } , ; && 4  Cabecera 1
                             { "cHead2"    , "C", 132, 0 } , ; && 5
                             { "cEscHead2" , "C",  70, 0 } , ; && 6
                             { "cHead3"    , "C", 132, 0 } , ; && 7
                             { "cEscHead3" , "C",  70, 0 } , ; && 8
                             { "cHead4"    , "C", 132, 0 } , ; && 9
                             { "cEscHead4" , "C",  70, 0 } , ; && 10
                             { "cFoot1"    , "C", 132, 0 } , ; && 11  Pie 1
                             { "cEscFoot1" , "C",  70, 0 } , ; && 12  Pie 1
                             { "cFoot2"    , "C", 132, 0 } , ; && 13
                             { "cEscFoot2" , "C",  70, 0 } , ; && 14
                             { "cFoot3"    , "C", 132, 0 } , ; && 15
                             { "cEscFoot3" , "C",  70, 0 } , ; && 16
                             { "cFoot4"    , "C", 132, 0 } , ; && 17
                             { "cEscFoot4" , "C",  70, 0 } , ; && 18
                             { "cGroup"    , "C",  10, 0 } , ; && 19  Campo del grupo
                             { "cTGroup"   , "C",  40, 0 } , ; && 20  Cabecera grupo
                             { "cSubGroup" , "C",  10, 0 } , ; && 21  Campo Subgrupo
                             { "cTSubGroup", "C",  40, 0 } , ; && 22  Cabecera Subgrupo
                             { "cArea1"    , "C",   8, 0 } , ; && 23  Area 1 y Dominio
                             { "cArea2"    , "C",   8, 0 } , ; && 24
                             { "cArea3"    , "C",   8, 0 } , ; && 25
                             { "cArea4"    , "C",   8, 0 } , ; && 26
                             { "cRelation1", "C",  10, 0 } , ; && 27
                             { "cRelation2", "C",  10, 0 } , ; && 28
                             { "cRelation3", "C",  10, 0 } , ; && 29
                             { "cIndex1"   , "C",   8, 0 } , ; && 30
                             { "cIndex2"   , "C",   8, 0 } , ; && 31
                             { "cIndex3"   , "C",   8, 0 } , ; && 32
                             { "cIndex4"   , "C",   8, 0 } , ; && 33
                             { "cFilter"   , "C", 120, 0 } , ; && 34  l¡nea de filtro
                             { "cIndexExp" , "C", 120, 0 } , ; && 35  L¡nea de orden
                             { "cEsDetail" , "C", 120, 0 } , ; && 36  L¡nea de orden
                             { "lTotalize" , "L",   1, 0 } } ) && 37
      USE Reports
      INDEX ON cTitle TO Reports1
      INDEX ON nDbfLines TO Reports2
      DbCloseAll()
   endif
   if ! File( "RLines.Dbf" )
      DbCreate( "RLines", { { "nDbfLines"  , "N",  4, 0 }, ;
                            { "cTiTle"     , "C", 40, 0 }, ;
                            { "cExpresion" , "C", 40, 0 }, ;
                            { "cPicture"   , "C", 20, 0 }, ;
                            { "nWidth"     , "N",  3, 0 }, ;
                            { "lTotal"     , "L",  1, 0 } } )
      USE RLInes
      INDEX ON nDbfLines TO RLines
      DbCloseAll()
   endif


   DbSelectArea( 100 )
   if lNetUse( "Reports", .f., 1 )
      SET INDEX TO Reports1, Reports2
      DbSelectArea( 101 )
      if lNetUse( "RLines", .f., 1 )
         SET INDEX TO RLines
         lEnd = .f.
      endif
   endif

   if ! lEnd
      SELECT Reports
      SET RELATION TO Reports->nDbfLines  INTO RLines
      BrwReports()
      DbCloseAll()
   else
      RecCaptured()
      DbCloseAll()
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function BrwReports()

   local oBrw

   BROWSE oBrw HEADSEP "Ä" SEPARATOR " "  ;
      FROM 4,5 TO MaxRow() - 5, MaxCol() - 6

      COLUMN TITLE "T¡tulo del Informe" SHOW Reports->CTitle

   END BROWSE

   ACTIVATE BROWSE oBrw TITLE "Mantenimiento del Fichero de Informes"      ;
   HOTKEYS { { "Det.", "ÄÄÙ" }, { "&Cabeza" }, { "&Pie" }, { "&Grupos" }, ;
             { "&Filtro" }, { "A&reas" }, { "&Orden" }, { "&T¡tulo" },     ;
             { "&A¤adir" }, { "&Elim." } }                                 ;
   ON KEY Asc( "A" ) DO lAdd( oBrw )                                       ;
   ON KEY Asc( "a" ) DO lAdd( oBrw )                                       ;
   ON KEY Asc( "E" ) DO If( ! EOF(), lDel( oBrw ), .f. )                   ;
   ON KEY Asc( "e" ) DO If( ! EOF(), lDel( oBrw ), .f. )                   ;
   ON KEY Asc( "T" ) DO If( ! EOF(), lModify( oBrw ), .f. )                ;
   ON KEY Asc( "t" ) DO If( ! EOF(), lModify( oBrw ), .f. )                ;
   ON KEY Asc( "C" ) DO If( ! EOF(), lHead( oBrw ), .f. )                  ;
   ON KEY Asc( "c" ) DO If( ! EOF(), lHead( oBrw ), .f. )                  ;
   ON KEY Asc( "P" ) DO If( ! EOF(), lFoot( oBrw ), .f. )                  ;
   ON KEY Asc( "p" ) DO If( ! EOF(), lFoot( oBrw ), .f. )                  ;
   ON KEY Asc( "R" ) DO If( ! EOF(), lArea( oBrw ), .f. )                  ;
   ON KEY Asc( "r" ) DO If( ! EOF(), lArea ( oBrw ), .f. )                 ;
   ON KEY Asc( "G" ) DO If( ! EOF(), lGroup( oBrw ), .f. )                 ;
   ON KEY Asc( "g" ) DO If( ! EOF(), lGroup( oBrw ), .f. )                 ;
   ON KEY Asc( "F" ) DO If( ! EOF(), lFilter( oBrw ), .f. )                ;
   ON KEY Asc( "f" ) DO If( ! EOF(), lFilter( oBrw ), .f. )                ;
   ON KEY Asc( "O" ) DO If( ! EOF(), lOrder( oBrw ), .f. )                 ;
   ON KEY Asc( "o" ) DO If( ! EOF(), lOrder( oBrw ), .f. )                 ;
   ON KEY K_ENTER    DO If( ! EOF(), lDetail( oBrw ), .f. )                ;
   ON KEY K_ENTER    DO If( ! EOF(), lDetail( oBrw ), .f. )


return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lArea( oBrw )

   local oWnd     := TWindow():NewCentered( 10, 57, "Areas, Indices y Relaciones" )
   local aVars    := aCamposLee()
   local nAction  := 0
   local GetList  := {}
   local cline    := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   if lNetRecLock( 1 )

      @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2  SAY "ÚÄÄ Areas ÄÄÄÄ¿   ÚÄÄ Indices ÄÄÄ¿   ÚÄ Claves ÄÄÄÄÄÄ¿"
      @ oWnd:nTop +  3, oWnd:nLeft + 2  SAY "³ 1.          ³   ³ 1.           ³   ³               ³"
      @ oWnd:nTop +  4, oWnd:nLeft + 2  SAY "³ 2.          ³   ³ 2.           ³   ³ 1.            ³"
      @ oWnd:nTop +  5, oWnd:nLeft + 2  SAY "³ 3.          ³   ³ 3.           ³   ³ 2.            ³"
      @ oWnd:nTop +  6, oWnd:nLeft + 2  SAY "³ 4.          ³   ³ 4.           ³   ³ 3.            ³"
      @ oWnd:nTop +  7, oWnd:nLeft + 2  SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"


      @ oWnd:nTop +  3, oWnd:nLeft + 6  GET aVars[ 23 ]
      @ oWnd:nTop +  4, oWnd:nLeft + 6  GET aVars[ 24 ]
      @ oWnd:nTop +  5, oWnd:nLeft + 6  GET aVars[ 25 ]
      @ oWnd:nTop +  6, oWnd:nLeft + 6  GET aVars[ 26 ]

      @ oWnd:nTop +  3, oWnd:nLeft + 24 GET aVars[ 30 ]
      @ oWnd:nTop +  4, oWnd:nLeft + 24 GET aVars[ 31 ]
      @ oWnd:nTop +  5, oWnd:nLeft + 24 GET aVars[ 32 ]
      @ oWnd:nTop +  6, oWnd:nLeft + 24 GET aVars[ 33 ]

      @ oWnd:nTop +  4, oWnd:nLeft + 43 GET aVars[ 27 ]
      @ oWnd:nTop +  5, oWnd:nLeft + 43 GET aVars[ 28 ]
      @ oWnd:nTop +  6, oWnd:nLeft + 43 GET aVars[ 29 ]

      @ oWnd:nTop +  8, oWnd:nLeft + 10 BUTTON "     &Aceptar     " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop +  8, oWnd:nLeft + 30 BUTTON "     &Cancelar     " ;
         ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLine )
   else
      RecCaptured()
   endif

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lFilter( oBrw )

   local oWnd     := TWindow():NewCentered( 6, 74, "Filtro del Informe" )
   local aVars    := aCamposLee()
   local nAction  := 0
   local GetList  := {}
   local cline    := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   if lNetRecLock( 1 )

      @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2  GET aVars[ 34 ] PICTURE "@S72"

      @ oWnd:nTop +  4, oWnd:nLeft + 20 BUTTON "     &Aceptar     " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop +  4, oWnd:nLeft + 40 BUTTON "     &Cancelar     " ;
         ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLine )
   else
      RecCaptured()
   endif

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lOrder( oBrw )

   local oWnd     := TWindow():NewCentered( 6, 74, "Expresion de Orden de Salida" )
   local aVars    := aCamposLee()
   local nAction  := 0
   local GetList  := {}
   local cline    := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   if lNetRecLock( 1 )

      @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2  GET aVars[ 35 ] PICTURE "@S72"

      @ oWnd:nTop +  4, oWnd:nLeft + 20 BUTTON "     &Aceptar     " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop +  4, oWnd:nLeft + 40 BUTTON "     &Cancelar     " ;
         ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLine )
   else
      RecCaptured()
   endif

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lGroup( oBrw )

   local oWnd     := TWindow():NewCentered( 12, 65, "Grupo y SubGrupos" )
   local aVars    := aCamposLee()
   local nAction  := 0
   local GetList  := {}
   local cline    := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   if lNetRecLock( 1 )

      @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2  SAY "ÚÄ GRUPO ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ oWnd:nTop +  3, oWnd:nLeft + 2  SAY "³  Clave            Texto                                    ³"
      @ oWnd:nTop +  4, oWnd:nLeft + 2  SAY "³                                                            ³"
      @ oWnd:nTop +  5, oWnd:nLeft + 2  SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

      @ oWnd:nTop +  6, oWnd:nLeft + 2  SAY "ÚÄ SUBGRUPO ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ oWnd:nTop +  7, oWnd:nLeft + 2  SAY "³  Clave            Texto                                    ³"
      @ oWnd:nTop +  8, oWnd:nLeft + 2  SAY "³                                                            ³"
      @ oWnd:nTop +  9, oWnd:nLeft + 2  SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"


      @ oWnd:nTop +  4, oWnd:nLeft + 5  GET aVars[ 19 ]
      @ oWnd:nTop +  4, oWnd:nLeft + 22 GET aVars[ 20 ]
      @ oWnd:nTop +  8, oWnd:nLeft + 5  GET aVars[ 21 ]
      @ oWnd:nTop +  8, oWnd:nLeft + 22 GET aVars[ 22 ]

      @ oWnd:nTop + 10, oWnd:nLeft + 12 BUTTON "      &Aceptar      " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop + 10, oWnd:nLeft + 33 BUTTON "      &Cancelar      " ;
         ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLine )
   else
      RecCaptured()
   endif

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lHead( oBrw )

   local oWnd     := TWindow():NewCentered( 16, 76, "Datos de la Cabecera" )
   local aVars    := aCamposLee()
   local nAction  := 0
   local GetList  := {}
   local cline    := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   if lNetRecLock( 1 )

      @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2  SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ CONTENIDO CABECERA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      @ oWnd:nTop +  3, oWnd:nLeft + 2  SAY "1."
      @ oWnd:nTop +  4, oWnd:nLeft + 2  SAY "2."
      @ oWnd:nTop +  5, oWnd:nLeft + 2  SAY "3."
      @ oWnd:nTop +  6, oWnd:nLeft + 2  SAY "4."
      @ oWnd:nTop +  9, oWnd:nLeft + 2  SAY "1."
      @ oWnd:nTop + 10, oWnd:nLeft + 2  SAY "2."
      @ oWnd:nTop + 11, oWnd:nLeft + 2  SAY "3."
      @ oWnd:nTop + 12, oWnd:nLeft + 2  SAY "4."

      @ oWnd:nTop +  3, oWnd:nLeft + 4  GET aVars[  3 ] PICTURE "@S70"
      @ oWnd:nTop +  4, oWnd:nLeft + 4  GET aVars[  5 ] PICTURE "@S70"
      @ oWnd:nTop +  5, oWnd:nLeft + 4  GET aVars[  7 ] PICTURE "@S70"
      @ oWnd:nTop +  6, oWnd:nLeft + 4  GET aVars[  9 ] PICTURE "@S70"

      @ oWnd:nTop +  8, oWnd:nLeft + 2  SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ CODIGOS DE ESCAPE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"

      @ oWnd:nTop +   9, oWnd:nLeft + 4  GET aVars[  4 ]
      @ oWnd:nTop +  10, oWnd:nLeft + 4  GET aVars[  6 ]
      @ oWnd:nTop +  11, oWnd:nLeft + 4  GET aVars[  8 ]
      @ oWnd:nTop +  12, oWnd:nLeft + 4  GET aVars[ 10 ]

      @ oWnd:nTop + 14, oWnd:nLeft + 22 BUTTON "      &Aceptar      " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop + 14, oWnd:nLeft + 43 BUTTON "      &Cancelar      " ;
         ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLine )
   else
      RecCaptured()
   endif

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lFoot( oBrw )

   local oWnd     := TWindow():NewCentered( 16, 76, "Datos de Pie de Informe" )
   local aVars    := aCamposLee()
   local nAction  := 0
   local GetList  := {}
   local cline    := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )

   if lNetRecLock( 1 )

      @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()
      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2  SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ CONTENIDO PIE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      @ oWnd:nTop +  3, oWnd:nLeft + 2  SAY "1."
      @ oWnd:nTop +  4, oWnd:nLeft + 2  SAY "2."
      @ oWnd:nTop +  5, oWnd:nLeft + 2  SAY "3."
      @ oWnd:nTop +  6, oWnd:nLeft + 2  SAY "4."
      @ oWnd:nTop +  9, oWnd:nLeft + 2  SAY "1."
      @ oWnd:nTop + 10, oWnd:nLeft + 2  SAY "2."
      @ oWnd:nTop + 11, oWnd:nLeft + 2  SAY "3."
      @ oWnd:nTop + 12, oWnd:nLeft + 2  SAY "4."

      @ oWnd:nTop +  3, oWnd:nLeft + 4  GET aVars[ 11 ] PICTURE "@S70"
      @ oWnd:nTop +  4, oWnd:nLeft + 4  GET aVars[ 13 ] PICTURE "@S70"
      @ oWnd:nTop +  5, oWnd:nLeft + 4  GET aVars[ 15 ] PICTURE "@S70"
      @ oWnd:nTop +  6, oWnd:nLeft + 4  GET aVars[ 17 ] PICTURE "@S70"

      @ oWnd:nTop +  8, oWnd:nLeft + 2  SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ CODIGOS DE ESCAPE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"

      @ oWnd:nTop +   9, oWnd:nLeft + 4  GET aVars[ 12 ]
      @ oWnd:nTop +  10, oWnd:nLeft + 4  GET aVars[ 14 ]
      @ oWnd:nTop +  11, oWnd:nLeft + 4  GET aVars[ 16 ]
      @ oWnd:nTop +  12, oWnd:nLeft + 4  GET aVars[ 18 ]

      @ oWnd:nTop + 14, oWnd:nLeft + 22 BUTTON "      &Aceptar      " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop + 14, oWnd:nLeft + 43 BUTTON "      &Cancelar      " ;
         ACTION nAction := nBtnCancel()

      SET CURSOR ON
      READ
      SET CURSOR OFF

      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
      endif

      DEACTIVATE WINDOW oWnd
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLine )

   else
      RecCaptured()
   endif

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lAdd( oBrw )

   local oWnd  := TWindow():NewCentered(  11, 65, "A¤adir Informe" )
   local lDisplay := .f.
   local aVars := aCamposBlank()
   local nAction  := 0
   local GetList  := {}
   local nNextRep

   ACTIVATE WINDOW oWnd

   @ oWnd:nTop +  4, oWnd:nLeft + 2  SAY "ÚÄ CODIGO DE ESCAPE DEL DETALLE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @ oWnd:nTop +  5, oWnd:nLeft + 2  SAY "³                                                            ³"
   @ oWnd:nTop +  6, oWnd:nLeft + 2  SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

   @ oWnd:nTop +  2, oWnd:nLeft + 3  GET aVars[ 2 ]
   @ oWnd:nTop +  5, oWnd:nLeft + 4  GET aVars[ 36 ] PICTURE "@S58"
   @ oWnd:nTop +  7, oWnd:nLeft + 3  GET aVars[ 37 ] CHECK ;
       "Totaliza al Final de Cada L¡nea" COLOR cClrVentanas()

   @ oWnd:nTop + 9, oWnd:nLeft + 22 BUTTON "      &Aceptar      " ;
      ACTION nAction := nBtnOk()
   @ oWnd:nTop + 9, oWnd:nLeft + 43 BUTTON "      &Cancelar      " ;
      ACTION nAction := nBtnCancel()

   SET CURSOR ON
   READ
   SET CURSOR OFF

   if nAction == 1

      SET ORDER TO 2

      DbGoBottom()
      nNextRep = nDbfLines + 1

      SET ORDER TO 1

      DbAppend()
      aCamposGraba( aVars )
      Reports->nDbfLines := nNextRep
      DbUnLock()
      UpStable( oBrw )
      oBrw:RefreshAll()
      lDisplay = .t.

   endif

   DEACTIVATE WINDOW oWnd

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lModify( oBrw )

   local oWnd  := TWindow():NewCentered(  11, 65, "Otros Datos Generales" )
   local lDisplay := .f.
   local aVars := aCamposLee()
   local nAction  := 0
   local GetList  := {}

   if lNetRecLock( 1 )

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  4, oWnd:nLeft + 2  SAY "ÚÄ CODIGO DE ESCAPE DEL DETALLE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
      @ oWnd:nTop +  5, oWnd:nLeft + 2  SAY "³                                                            ³"
      @ oWnd:nTop +  6, oWnd:nLeft + 2  SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

      @ oWnd:nTop +  2, oWnd:nLeft + 3  GET aVars[ 2 ]
      @ oWnd:nTop +  5, oWnd:nLeft + 4  GET aVars[ 36 ] PICTURE "@S58"
      @ oWnd:nTop +  7, oWnd:nLeft + 3  GET aVars[ 37 ] CHECK ;
          "Totaliza al Final de Cada L¡nea" COLOR cClrVentanas()


      @ oWnd:nTop + 9, oWnd:nLeft + 22 BUTTON "      &Aceptar      " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop + 9, oWnd:nLeft + 43 BUTTON "      &Cancelar      " ;
         ACTION nAction := nBtnCancel()

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

   else
      RecCaptured()
   endif

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lDel( oBrw )

   local lDisplay := .f.
   local nDelete
   local GetList  := {}

   if lNetRecLock( 1 )
      KEYBOARD Chr( K_RIGHT )
      nDelete = nMsgBox( "Confirme Borrado de Registro", " ELiminar Registro", ;
                         "   &Aceptar   ;   &Cancelar   " )
      if nDelete == 1
         SELECT RLines

         DbSeek( Reports->nDbfLines )
         while RLines->nDbfLines == Reports->nDbfLines
            if lNetRecLock()
               DbDelete()
            endif
            DbSkip()
         enddo

         SELECT Reports
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
      DbUnLockAll()
   else
      nMsgBox( "Este Registro No Se Puede Borrar; Est  Bloqueado", ;
               "Eliminar Registro", "           &Aceptar          " )
   endif

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function lDetail( oBrw )

   local brwDetail
   SELECT RLines

   BROWSE brwDetail HEADSEP "Ä" SEPARATOR " " ;
      FROM 8, 3 TO MaxRow() - 7, MaxCol() - 4  ;
      FILTER Rlines->nDbfLines FOR Reports->nDbfLines

     COLUMN TITLE "T¡tulo"    SHOW SubStr( cTitle, 1, 20 )
     COLUMN TITLE "Contenido" SHOW SubStr( cExpresion, 1, 20 )
     COLUMN TITLE "M scara"   SHOW cPicture
     COLUMN TITLE "Lg."       SHOW nWidth
     COLUMN TITLE "T."        SHOW lTotal

   END BROWSE

   ACTIVATE BROWSE brwDetail TITLE "Columnas del Informe" ;
   HOTKEYS { { "&A¤adir" }, { "&Modificar" }, { "&Eliminar" }, ;
             { "&Zoom" }, { "&Salir" } } ;
   ON KEY Asc( "Z" ) DO If( ! EOF(), lZoom( brwDetail ), .f. ) ;
   ON KEY Asc( "z" ) DO If( ! EOF(), lZoom( brwDetail ), .f. ) ;
   ON KEY Asc( "A" ) DO lDtlAdd( brwDetail ) ;
   ON KEY Asc( "a" ) DO lDtlAdd( brwDetail ) ;
   ON KEY Asc( "M" ) DO If( ! EOF(), lDtlModify( brwDetail ), .f. ) ;
   ON KEY Asc( "m" ) DO If( ! EOF(), lDtlModify( brwDetail ), .f. ) ;
   ON KEY Asc( "E" ) DO If( ! EOF(), lDtlDel( brwDetail ), .f. ) ;
   ON KEY Asc( "e" ) DO If( ! EOF(), lDtlDel( brwDetail ), .f. )

   SELECT Reports

return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lZoom( brwDetail )

   local lDisplay := .f.
   local GetList  := {}
   local oWnd     := TWindow():NewCentered( 14, 53, "Contenido de la Columna" )


   ACTIVATE WINDOW oWnd

   @ oWnd:nTop +  2, oWnd:nLeft + 2 SAY "T¡tulo"
   @ oWnd:nTop +  4, oWnd:nLeft + 2 SAY "Expresi¢n"
   @ oWnd:nTop +  6, oWnd:nLeft + 2 SAY "M scara"
   @ oWnd:nTop +  8, oWnd:nLeft + 2 SAY "Longitud"

   SetColor( cClrVntField() )

   @ oWnd:nTop +  2, oWnd:nLeft + 12 SAY cTitle
   @ oWnd:nTop +  4, oWnd:nLeft + 12 SAY cExpresion
   @ oWnd:nTop +  6, oWnd:nLeft + 12 SAY cPicture
   @ oWnd:nTop +  8, oWnd:nLeft + 12 SAY nWidth

   SetColor( cClrVentanas() )

   @ oWnd:nTop + 10, oWnd:nLeft + 2 GET lTotal CHECK "Totaliza Listado";
      COLOR cClrVentanas()
   CLEAR GETS

   @ oWnd:nTop + 12, oWnd:nLeft + 20 BUTTON "     &Aceptar     " ACTION nBtnOk()

   READ
   SET CURSOR OFF

   DEACTIVATE WINDOW oWnd


return .f.

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lDtlAdd( brwDetail )

   local oWnd     := TWindow():NewCentered( 14, 53, "A¤adir Columna" )
   local lDisplay := .f.
   local aVars    := aCamposBlank()
   local nAction  := 0
   local GetList  := {}

   ACTIVATE WINDOW oWnd

   @ oWnd:nTop +  2, oWnd:nLeft + 2 SAY "T¡tulo"
   @ oWnd:nTop +  4, oWnd:nLeft + 2 SAY "Expresi¢n"
   @ oWnd:nTop +  6, oWnd:nLeft + 2 SAY "M scara"
   @ oWnd:nTop +  8, oWnd:nLeft + 2 SAY "Longitud"

   @ oWnd:nTop +  2, oWnd:nLeft + 12 GET aVars[ 2 ]
   @ oWnd:nTop +  4, oWnd:nLeft + 12 GET aVars[ 3 ]
   @ oWnd:nTop +  6, oWnd:nLeft + 12 GET aVars[ 4 ]
   @ oWnd:nTop +  8, oWnd:nLeft + 12 GET aVars[ 5 ] PICTURE "999"

   @ oWnd:nTop + 10, oWnd:nLeft + 2 GET aVars[ 6 ] CHECK "Totaliza Listado"
   @ oWnd:nTop + 12, oWnd:nLeft + 20 BUTTON "   &Aceptar   " ;
      ACTION nAction := nBtnOk()
   @ oWnd:nTop + 12, oWnd:nLeft + 35 BUTTON "   &Cancelar  " ;
      ACTION nAction := nBtnCancel()


   SET CURSOR ON
   READ
   SET CURSOR OFF

   if nAction == 1

      DbAppend()
      aCamposGraba( aVars )
      RLines->nDbfLines := Reports->nDbfLines
      DbUnLock()
      brwDetail:RefreshAll()
      lDisplay = .t.

   endif

   DEACTIVATE WINDOW oWnd

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lDtlModify( brwDetail )

   local oWnd  := TWindow():NewCentered( 14, 53, "Modificar Columna" )
   local lDisplay := .f.
   local aVars := aCamposLee()
   local nAction  := 0
   local GetList  := {}

   if lNetRecLock( 1 )

      ACTIVATE WINDOW oWnd

      @ oWnd:nTop +  2, oWnd:nLeft + 2 SAY "T¡tulo"
      @ oWnd:nTop +  4, oWnd:nLeft + 2 SAY "Expresi¢n"
      @ oWnd:nTop +  6, oWnd:nLeft + 2 SAY "M scara"
      @ oWnd:nTop +  8, oWnd:nLeft + 2 SAY "Longitud"

      @ oWnd:nTop +  2, oWnd:nLeft + 12 GET aVars[ 2 ]
      @ oWnd:nTop +  4, oWnd:nLeft + 12 GET aVars[ 3 ]
      @ oWnd:nTop +  6, oWnd:nLeft + 12 GET aVars[ 4 ]
      @ oWnd:nTop +  8, oWnd:nLeft + 12 GET aVars[ 5 ] PICTURE "999"

      @ oWnd:nTop + 10, oWnd:nLeft + 2 GET aVars[ 6 ] CHECK "Totaliza Listado"
      @ oWnd:nTop + 12, oWnd:nLeft + 20 BUTTON "   &Aceptar   " ;
         ACTION nAction := nBtnOk()
      @ oWnd:nTop + 12, oWnd:nLeft + 35 BUTTON "   &Cancelar  " ;
         ACTION nAction := nBtnCancel()


      SET CURSOR ON
      READ
      SET CURSOR OFF


      if nAction == 1
         aCamposGraba( aVars )
         DbUnLock()
         brwDetail:RefreshAll()
         lDisplay = .t.
      endif

      DEACTIVATE WINDOW oWnd

   else
      RecCaptured()
   endif

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lDtlDel( brwDetail )

   local lDisplay := .f.
   local nDelete
   local GetList  := {}
   local nRowPos

   if lNetRecLock( 1 )
      KEYBOARD Chr( K_RIGHT )
      nDelete = nMsgBox( "Confirme Borrado de Registro", " ELiminar Registro", ;
                         "   &Aceptar   ;   &Cancelar   " )
      if nDelete == 1
         DbDelete()
         nRowPos := brwDetail:RowPos
         brwDeatail:GoTop()
         brwDetail:RowPos := nRowPos
         @ brwDetail:nTop, brwDetail:nLeft  CLEAR TO ;
           brwDetail:nBottom, brwDetail:nRight
         lDisplay = .t.
         brwDetail:RefreshAll()
      endif
      DbUnLock()
   else
      nMsgBox( "Este Registro No Se Puede Borrar; Est  Bloqueado", ;
               "Eliminar Registro", "           &Aceptar          " )
   endif

return lDisplay

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

