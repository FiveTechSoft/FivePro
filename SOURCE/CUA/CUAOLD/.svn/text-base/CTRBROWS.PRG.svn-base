#include "Sde501.ch"
#include "Inkey.ch"

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

CLASS TCtrBrowse FROM TControl

   DATA   oBrowse, lVisible, cLabel
   DATA   lBox, lMark
   DATA   aHotKeys
   DATA   aKeysDef
   DATA   cKeysOld

   METHOD New( oBrowse, cLabel, bWhen, bValid, lBox, lMark, aHotKeys, aKeysDef )
   METHOD DeHilite()
   METHOD Display()
   METHOD Hilite()
   METHOD KeyApply( nKey )
   METHOD SetFocus( lOnOff )
   METHOD cGetHotKey()

ENDCLASS

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD TCtrBrowse::New( oBrowse, cLabel, bWhen, bValid, lBox, lMark, aHotKeys,;
                        aKeysDef )

   DEFAULT cLabel := "", bWhen := { || .t. }, bValid := { || .t. },;
           lBox := .t., lMark := .t.

   Super:New()

   if aKeysDef != nil
      ASize( aKeysDef, Len( aKeysDef ) - 1 )   // Ultimo elemento viene vacio
   endif

   ::oBrowse    = oBrowse
   ::lVisible	= .f.
   ::cLabel     = cLabel
   ::PreBlock   = bWhen
   ::PostBlock  = bValid
   ::lBox       = lBox
   ::lMark      = lMark
   ::aHotKeys   = aHotKeys
   ::aKeysDef   = aKeysDef

   ::oBrowse:AutoLite = .f.

return Self

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD Hilite() CLASS TCtrBrowse

   local n

   if ::lMark
      @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nLeft + ;
        If( ::lBox, 1, -1 ) SAY " "
      @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nRight - ;
        If( ::lBox, 1, -1 ) SAY " "
   endif

   ::oBrowse:ColPos = 1
   for n = 1 to ::oBrowse:ColCount
       ::oBrowse:Hilite()
       ::oBrowse:ColPos++
   next
   ::oBrowse:ColPos = 1

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD DeHilite() CLASS TCtrBrowse

   local n

   if ::lMark
      @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nLeft + ;
        If( ::lBox, 1, -1 ) SAY " "
      @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nRight - ;
        If( ::lBox, 1, -1 ) SAY " "
   endif

   ::oBrowse:ColPos = 1
   for n = 1 to ::oBrowse:ColCount
       ::oBrowse:DeHilite()
       ::oBrowse:ColPos++
   next
   ::oBrowse:ColPos = 1

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD TCtrBrowse::Display()

   local n

   if ! ::lVisible
      ::lVisible = .t.
      ::cKeysOld = SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() + 1 )
      if ::lBox
         @ ::oBrowse:nTop - 1, ::oBrowse:nLeft - 1 TO ;
           ::oBrowse:nBottom + 1, ::oBrowse:nRight + 1 COLOR cClrVentanas()
      endif
      if ! Empty( ::cLabel )
         ScrSayHot( ::oBrowse:nTop - 1, ::oBrowse:nLeft, " " + ::cLabel + " ",;
                    cClrVentanas(), "BG+/" + SubStr( cClrVentanas(),;
                    At( "/", cClrVentanas() ) + 1 ) )
      endif
   endif

   do while ! ::oBrowse:Stabilize()
   enddo
   if( ::HasFocus, ::Hilite(), ::DeHilite() )

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD TCtrBrowse::KeyApply( nKey )

   local n
   local nAtKey
   local lProcess := .f.

   nKey = If( nKey > 96 .and. nKey < 123, nKey - 32, nKey )

   if ::aKeysDef != nil
      if ( ( nAtKey := AScan( ::aKeysDef, { | aKey | aKey[ 1 ] == nKey } ) ) != 0 )
         if Eval( ::aKeysDef[ nAtKey ][ 2 ] )
            do while ! ::oBrowse:Stabilize()
            enddo
            ::Hilite()
         endif
         lProcess = .t.
      endif
   endif

   if ! lProcess
      do case
         case nKey == K_UP
          if ! ::oBrowse:HitTop
             ::DeHilite()
             ::oBrowse:Up()
             ::Display()
          else
             Super:KeyApply( nKey )
          endif

         case nKey == K_DOWN
          if ! ::oBrowse:HitBottom
             ::DeHilite()
             ::oBrowse:Down()
             ::Display()
          else
             Super:KeyApply( nKey )
          endif

         case nKey == K_PGUP
              ::DeHilite()
              ::oBrowse:PageUp()
              ::Display()

         case nKey == K_PGDN
              ::DeHilite()
              ::oBrowse:PageDown()
              ::Display()

         case nKey == K_HOME
              ::DeHilite()
              ::oBrowse:GoTop()
              ::Display()

         case nKey == K_END
              ::DeHilite()
              ::oBrowse:GoBottom()
              ::Display()

         otherwise
          Super:KeyApply( nKey )
      endcase
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD TCtrBrowse::SetFocus( lOnOff )

   local acColors   := aStr2Array( ::oBrowse:ColorSpec )
   local oColumn    := ::oBrowse:GetColumn( ::oBrowse:ColPos )
   local anColors   := If( oColumn:ColorBlock != nil,;
                           Eval( oColumn:ColorBlock ), nil )
   local cClrNormal := If( anColors != nil, acColors[ anColors[ 1 ] ],;
                           acColors[ 1 ] )
   local cClrFocus  := If( anColors != nil, acColors[ anColors[ 2 ] ],;
                           acColors[ 2 ] )

   ::HasFocus = lOnOff
   if lOnOff
      SetCursor( 0 )
   endif

   if lOnOff
      ::Display()
      if ::lMark
         @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nLeft  ;
           SAY If( lOnOff, " ", "" ) COLOR cClrFocus
         @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nRight  ;
           SAY If( lOnOff, " ", "" ) COLOR cClrFocus
      endif
      if ::aHotKeys != nil
         @ MaxRow(), 0 SAY Space( 80 ) COLOR cClrArrBars()
         DevPos( MaxRow(), 0 )
         AEval( ::aHotKeys, { | aKeys | AEval( aKeys, { | Key, n | ;
                            If( n == 1, ScrSayHot( MaxRow(), Col() + 2, Key, ;
                                cClrArrBars(), cClrArrKeys() ),;
                If( Key != nil, Eval( { | key | DevPos( MaxRow(), Col() + 1 ), ;
               DevOut( Key, cClrArrKeys() ) }, Key ), ) ) } ) } )
      endif
   else
      ::Display()
      if ::lMark
         @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nLeft  ;
           SAY If( lOnOff, " ", "" ) COLOR cClrNormal
         @ ::oBrowse:nTop + ::oBrowse:RowPos - 1, ::oBrowse:nRight  ;
           SAY If( lOnOff, " ", "" ) COLOR cClrNormal
      endif
      RestScreen( MaxRow(), 0, MaxRow(), MaxCol() + 1, ::cKeysOld )
   endif

return

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//

METHOD TCrtBrowse::cGetHotKey()

   local nAt := At( "&", ::cLabel )

return If( nAt != 0, SubStr( ::cLabel, nAt + 1, 1 ), "" )

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ//
