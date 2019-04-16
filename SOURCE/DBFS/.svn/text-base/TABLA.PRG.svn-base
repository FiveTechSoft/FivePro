#include "Sde501.ch"
#include "Inkey.ch"

static aTablas := {}

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function Tabla( cTitulo, acCampos, acTitulos,;
                bAdd, bModif, bDel, bEnter, bZoom, aFind,;
                nTop, nLeft, nBottom, nRight )

   local brwTabla
   local lTerminar := .f.
   local n, nKey := 0, nCrsOld := SetCursor( 0 ), nRecNo
   local oWnd
   local uFind

   DEFAULT acTitulos := acCampos,;
           nTop := 1, nLeft := 0, nBottom := MaxRow() - 1,;
           nRight := MaxCol()

   brwTabla = TBrowseDb( nTop + 1, nLeft + 1, nBottom - 1, nRight - 1 )
   AAdd( aTablas, brwTabla )

   brwTabla:ColorSpec = cClrVentanas()
   brwTabla:HeadSep   = "Ä"
   brwTabla:ColSep    = " "
   AEval( acCampos, { | cCampo, n | brwTabla:AddColumn( TBColumnNew( ;
                       acTitulos[ n ], FieldBlock( cCampo ) ) ) } )

   DEFINE WINDOW oWnd FROM nTop, nLeft TO nBottom, nRight ;
      TITLE cTitulo COLOR cClrVentanas()

   ACTIVATE WINDOW oWnd

   Teclas( { { Chr( 27 ) + Chr( 26) + "", .t. },;
             { "ÄÙ", bEnter != nil },;
             { "&A¤adir", bAdd != nil },;
             { "&Modificar", bModif != nil },;
             { "&Eliminar", bDel != nil },;
             { "&Buscar", aFind != nil },;
             { "&Zoom", bZoom != nil },;
             { "&Salir", .t. } } )

   do while ! lTerminar

      if lDspStabilize( nKey, brwTabla )
         for n = brwTabla:ColCount  to 1 step - 1
            brwTabla:ColPos = n
            brwTabla:DeHilite()
         next

         do while ! brwTabla:Stabilize()
         enddo
         for n = brwTabla:ColCount to 0 step - 1
            brwTabla:ColPos = n
            brwTabla:Hilite()
         next
      endif

      if IndexOrd() == 0
         ScrollBar( nTop + 3, nRight, nBottom - 1, nRight, RecCount(), RecNo() )
      endif

      nKey = InKey( 0 )

      do case
         case nKey == K_ESC .or. Chr( nKey ) $ "sS"
              lTerminar = .t.

         case nKey == K_ENTER
              if bEnter != nil
                 Eval( bEnter )
                 brwTabla:RefreshAll()
              endif

         case nKey == K_UP
              if ! brwTabla:HitTop
                 brwTabla:Up()
              endif

         case nKey == K_DOWN
              if ! brwTabla:HitBottom
                 brwTabla:Down()
              endif

         case nKey == K_HOME
              brwTabla:GoTop()

         case nKey == K_END
              brwTabla:GoBottom()

         case nKey == K_PGUP
              brwTabla:PageUp()

         case nKey == K_PGDN
              brwTabla:PageDown()

         case nKey == K_RIGHT
              if brwTabla:ColPos < brwTabla:ColCount
                 brwTabla:Right()
              endif

         case nKey == K_LEFT
              if brwTabla:ColPos > 1
                 brwTabla:Left()
              endif

         case Chr( nKey ) $ "Aa"
              if bAdd != nil
                 Eval( bAdd )
                 brwTabla:RefreshAll()
              endif

         case Chr( nKey ) $ "Mm"
              if bModif != nil
                 Eval( bModif )
                 brwTabla:RefreshAll()
              endif

         case Chr( nKey ) $ "Ee"
              if bDel != nil
                 Eval( bDel )
                 brwTabla:GoTop()
                 brwTabla:RefreshAll()
              endif

         case Chr( nKey ) $ "Bb"
              if aFind != nil
                 uFind = aFind[ 2 ]
                 if nMsgGet( "Buscar por", aFind[ 1 ], @uFind ) == 1
                    if IndexOrd() != 0
                       nRecNo = RecNo()
                       brwTabla:GoTop()
                       SEEK If( ValType( uFind ) == "C", RTrim( uFind ), uFind )
                       if ! Found()
                          GO nRecNo
                          nMsgBox( "No encuentro ning£n registro;" + ;
                                   "que cumpla esa condici¢n", "Atenci¢n",;
                                   "   &Ok   " )
                       else
                          brwTabla:RefreshAll()
                       endif
                    endif
                 endif
              endif

         case Chr( nKey ) $ "Zz"
              if bZoom != nil
                 Eval( bZoom )
                 brwTabla:RefreshAll()
              endif

      endcase
   enddo

   Teclas()
   ASize( aTablas, Len( aTablas ) - 1 )
   DEACTIVATE WINDOW oWnd
   SetCursor( nCrsOld )

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function GetTabla()

return ATail( aTablas )

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

static function lDspStabilize( nKey, brwTabla )

   local lStabilize := .t.
   local nkeyPush := nKey

   if nKeyPush == K_DOWN
      DbSkip()
      if Eof()
         Go Bottom
         lStabilize = .f.
      else
         DbSkip( -1 )
         if Bof()
            lStabilize = .f.
         endif
      endif
   endif

   if nKeyPush == K_UP
      DbSkip( -1 )
      if Bof()
         lStabilize = .f.
      else
         DbSkip()
         if Eof()
            Go Bottom
         endif
      endif
   endif

   if nKeyPush == K_RIGHT .and. brwTabla:ColPos == brwTabla:ColCount
      lStabilize = .f.
   endif

   if nKeyPush == K_LEFT .and. brwTabla:ColPos == 1
      lStabilize = .f.
   endif
    
return lStabilize

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function aTablaModifica()

   local GetList  := {}
   local aGets    := Array( GetTabla():ColCount )
   local n

   for n = 1 to Len( aGets )
       GetTabla():ColPos = n
       GetTabla():Hilite()
       aGets[ n ] = Eval( GetTabla():GetColumn( n ):Block )
       @ Row(), Col() GET aGets[ n ]
   next
   SET CURSOR ON
   READ
   SET CURSOR OFF

return aGets

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

function nTablaAltas( aGets )

   local GetList    := {}
   local anCols     := {}
   local n, nAction := 0
   local oWnd       := TWindow():NewCentered( 6, GetTabla():nRight - ;
                                              GetTabla():nLeft,;
                                              "A¤adir", cClrVentanas() )
   for n = 1 to GetTabla():ColCount
       GetTabla():ColPos = n
       GetTabla():Hilite()
       AAdd( aGets, uValBlank( Eval( GetTabla():GetColumn( n ):Block ) ) )
       AAdd( anCols, Col() )
   next
   ACTIVATE WINDOW oWnd
   for n = 1 to Len( anCols )
       @ oWnd:nTop + 2, anCols[ n ] GET aGets[ n ]
   next
   @ oWnd:nTop + 4, oWnd:nRight - 30 BUTTON "   &Ok   "   ACTION ( nAction := 1, __KeyBoard( Chr( 27 ) ) )
   @ oWnd:nTop + 4, oWnd:nRight - 17 BUTTON " &Cancelar " ACTION ( nAction := 0, __KeyBoard( Chr( 27 ) ) )

   SET CURSOR ON
   READ
   SET CURSOR OFF
   DEACTIVATE WINDOW oWnd

return nAction

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//
