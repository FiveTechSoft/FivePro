#include "Sde501.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

function FromTo( brw )

   local wnd
   local GetList := {}
   local uDesde  := Space( 30 )
   local uHasta  := Space( 30 )
   local nRecDesde, nRecHasta
   local cLine
   local anCols  := aBrwCols( brw )
   local cTitles := ""
   local lEnd    := .f.

   if ! Empty( IndexKey( IndexOrd() ) )
      brw:GoTop()
      do while ! brw:Stabilize() ; enddo
      uDesde = &( IndexKey( IndexOrd() ) )
      nDesde = RecNo()
      brw:GoBottom()
      do while ! brw:Stabilize() ; enddo
      uHasta = &( IndexKey( IndexOrd() ) )
      nHasta = RecNo()
   endif

   DEFINE WINDOW wnd SIZE 11, 50 TITLE "Imprimir"
   ACTIVATE WINDOW wnd

   @ 2,  2 SAY "Desde" GET uDesde WINDOW wnd PICTURE "@S40"
   @ 4,  2 SAY "Hasta" GET uHasta WINDOW wnd PICTURE "@S40"
   @ 6,  2 SAY "Localiza por: " + If( ! Empty( IndexKey( IndexOrd() ) ),;
     IndexKey( IndexOrd() ), "B£squeda secuencial" ) WINDOW wnd
   @ 9, 13 BUTTON OK     WINDOW wnd
   @ 9, 27 BUTTON CANCEL WINDOW wnd

   SET CURSOR ON
   READ
   SET CURSOR OFF

   DEACTIVATE WINDOW wnd

   if LastKey() != K_ESC
      if DbSeek( uHasta )
         nRecHasta = RecNo()
      endif
      if DbSeek( uDesde )
         nRecDesde = RecNo()
      else
         brw:GoTop()
      endif
      brw:InvalidateAll()
      do while ! brw:Stabilize(); enddo
      if lPrintTo()
         for n = 1 to brw:ColCount
             cTitles = PadR( cTitles, anCols[ n ] ) + ;
                       brw:GetColumn( n ):Heading
         next
         ListBegin( { PadC( oWndActive():cTitle, MaxCol() ), "", cTitles, "" } )
         do while ! lEnd
            cLine = ""
            for n = 1 to brw:ColCount
                cLine = PadR( cLine, anCols[ n ] ) + ;
                        cValToChar( Eval( brw:GetColumn( n ):Block ) )
            next
            ListLine( cLine )
            Eval( brw:SkipBlock, 1 )
            if RecNo() == nRecHasta
               lEnd = .t.
            endif
         enddo
         ListEnd()
         PrintDo()
      endif
   endif

return .t.

//----------------------------------------------------------------------------//
