#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TListBox FROM TView

   DATA   acItems
   DATA   nOption, nFirstRow
   DATA   nClrDataFocus, nClrOption
   DATA   bSelected, bChanged
   DATA   oScrBar

   METHOD New( nTop, nLeft, nWidth, nHeight, bSetGet, acItems,;
               cLabel, cMessage, oWnd ) CONSTRUCTOR
   METHOD Display()
   METHOD Hide()
   METHOD SetFocus( lOnOff )
   METHOD Hilite()
   METHOD DeHilite( cColor )
   METHOD KeyPressed( nKey )
   METHOD Click( nMRow, nMCol )
   METHOD DblClick( nMRow, nMCol )
   METHOD lIsOver( nRow, nCol )
   METHOD GoUp()
   METHOD GoDown()
   METHOD GoTop()
   METHOD GoBottom()
   METHOD PgUp()
   METHOD PgDn()
   METHOD AddItem( cItem  )
   METHOD SetItems( acItems  )
   METHOD LDelete( nItem  )

   METHOD Selected() BLOCK ;
      { | Self | If( ::bSelected != nil, Eval( ::bSelected ),) }

   METHOD Changed() BLOCK ;
      { | Self | If( ::bChanged != nil, Eval( ::bChanged ),) }
   METHOD ChangePos( nRow, nCol )

   METHOD AddControl( oCtrl ) VIRTUAL

   METHOD ReSize()

   METHOD nAbsTop () // provisional
   METHOD nAbsLeft () // provisional
ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nWidth, nHeight, bSetGet, acItems,;
            cLabel, cMessage, oWnd ) CLASS TListBox

   DEFAULT nTop:= 0, nLeft:= 0, nWidth := 10, nHeight := 7,;
           acItems := {}, cLabel:= "&TListBox", cMessage:= ""

   Super:New( nTop + If( cLabel != nil, 1, 0 ), nLeft,;
              nTop + nHeight - 1, nLeft + nWidth - 1, oWnd )

   ::acItems          = acItems
   ::nOption          = 1
   ::nFirstRow        = 1
   ::nClrDataFocus    = 63
   ::nClrOption       = 61
   ::nClrNormal       = 48
   ::cMsg             = cMessage
   ::oLabel           = TLabel():New( -1, 0, cLabel, Self )
   ::oScrBar          = TScrollBar():New( 0, ::nRight - ::nLeft - 2,;
                                       ,nHeight - 1,,,.f., Self ,,,,,nHeight )


   ::oScrBar:oLabel   = nil
   ::oScrBar:cMsg = nil
   ::oScrBar:nRange:=len(::acItems)
   
   if oWnd != nil
      oWnd:AddControl( Self )
   endif
   ::lDrag:=.f.
   ::oScrBar:ldrag:=.f.

return nil

//----------------------------------------------------------------------------//

METHOD Display() CLASS TListBox

   local n := 0, nItems := Len( ::acItems )
   local nRows  := ::nBottom - ::nTop + 1
   local nWidth := ::nRight - ::nLeft

   if ::oLabel != nil
      ::oLabel:Display()
   endif

   MOff()
   @ ::nTop() + Min( nItems, nRows ),;
     ::nLeft(), ::nBottom, ::nRight - 1 BOX "         " COLOR "N/BG"

   do while n < nRows .and. n < nItems
      SayHot( ::nTop + n, ::nLeft,;
              PadR( ::acItems[ n + ::nFirstRow ], nWidth - 1 ), ::nClrNormal )
      n++
   enddo
   ::oScrBar:Display()
   MOn()

return nil

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TListBox

   if ::oScrBar != nil
      ::oScrBar:Hide()
   endif
   Super:Hide()

return nil

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TListBox

   Super:SetFocus( lOnOff )
   ::oScrBar:SetFocus( lOnOff )
   if lOnOff
      ::Hilite()
   else
      ::Dehilite( ::nClrOption )
   endif

return nil

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TListBox

   do case
      case nKey == K_ESC
           ::DeHilite( ::nClrNormal )
           ::nOption = 0
           ::EndExec()

      case nKey == K_ENTER

      case nKey == K_DOWN
           ::GoDown()
		   return 0
      case nKey == K_UP
           ::GoUp()
		   return 0

      case nKey == K_HOME
           ::GoTop()
		   return 0

      case nKey == K_END
           ::GoBottom()
		   return 0

      case nKey == K_PGUP
           ::PgUp()
		   return 0

      case nKey == K_PGDN
           ::PgDn()
		   return 0

   endcase

return nKey

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TListBox

   local nNewOption

   if ::lDrag
      Super:Click( nRow, nCol )
   else
      do case
         case ::oScrBar:lIsOver( nRow, nCol )
              ::oScrBar:Click( nRow, nCol )

         // case ! Super:lIsOver( nRow, nCol )

         otherwise
              do
                 if Super:lIsOver( nRow, nCol ) .and. ;
                    ( nNewOption := nRow - ::nTop + ::nFirstRow ) ;
                    != ::nOption .and. nNewOption > 0 .and. ;
                    nNewOption <= Len( ::acItems )

                    ::DeHilite( ::nClrNormal )
                    ::nOption = nNewOption
                    ::oScrBar:nValue = ::nOption
                    ::oScrBar:ThmCheck()
                    ::Selected()
                    ::Hilite()
                 else
                    do case
                       case nRow < ::nTop
                            ::GoUp()

                       case nRow > ::nBottom
                            ::GoDown()
                    endcase
                 endif
                 MUpdate()
                 nRow = nMRow()
                 nCol = nMCol()
              UNTIL ! lMPressed()
      endcase
   endif

return nil

//----------------------------------------------------------------------------//

METHOD DblClick( nMRow, nMCol ) CLASS TListBox

   local nSelected

   if Super:lIsOver( nMRow, nMCol )  .and. ;
      ! ::oScrBar:lIsOver( nMRow, nMCol ) .and. ;
      ( nSelected := nMRow - ::nAbsTop() + ::nFirstRow ) > 0 .and. ;
      nSelected <= Len( ::acItems )

      ::Changed()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD lIsOver( nRow, nCol ) CLASS TListBox

   local lIsOver := If( ::oLabel != nil, ::oLabel:lIsOver( nRow, nCol ), .f. )

   if ! lIsOver
      lIsOver = Super:lIsOver( nRow, nCol )
   endif

return lIsOver

//----------------------------------------------------------------------------//

METHOD GoUp() CLASS TListBox

   if ::nOption > 1
      ::DeHilite( ::nClrNormal )
      ::nOption--
      if ::nOption < ::nFirstRow
         MOff()
         Scroll( ::nTop(),;
                 ::nLeft(),;
                 ::nTop() + ::nBottom - ::nTop,;
                 ::nLeft() + ::nRight - ::nLeft - 1,;
                 -1 )
         MOn()
         ::nFirstRow--
      endif
      ::Hilite()
      ::oScrBar:nValue = ::nOption
      ::oScrBar:ThmCheck()
      ::Selected()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD GoDown() CLASS TListBox

   local nRows := ::nBottom - ::nTop + 1

   MOff()
   if ::nOption < Len( ::acItems )
      ::DeHilite( ::nClrNormal )
      ::nOption++
      if ::nOption - ::nFirstRow == nRows
         MOff()
         Scroll( ::nAbsTop(),;
                 ::nAbsLeft(),;
                 ::nAbsTop() + ::nBottom - ::nTop,;
                 ::nAbsLeft() + ::nRight - ::nLeft - 1,;
                 1 )
         MOn()
         ::nFirstRow++
      endif
      ::Hilite()
      ::oScrBar:nValue = ::nOption
      ::oScrBar:ThmCheck()
      ::Selected()
   endif
   MOn()

return nil

//----------------------------------------------------------------------------//

METHOD PgDn() CLASS TListBox

   local nRows  := ::nBottom - ::nTop + 1
   local nItems  := Len( ::acItems )

   if ::nOption < nItems
      ::Dehilite( ::nClrNormal )
      if nItems - ::nOption < nRows                // Est  en la £ltima pantalla
         if ::nFirstRow != Max( nItems - ( nRows - 1 ), 1 )  // No est  mostrada completa
            ::nFirstRow = Max( nItems - ( nRows - 1 ), 1 )
            ::Display()
         else
            ::nOption = nItems
            ::oScrBar:nValue = ::nOption
            ::oScrBar:ThmCheck()
            ::Selected()
         endif
      else                                    // No est  en la £ltima pantalla
         ::nOption += nRows
         ::nFirstRow = ::nOption
         if nItems - ::nOption < nRows     // Est  ya en la £ltima
            ::nOption = nItems - ( nRows - 1 )  // primera l¡nea £ltima pantalla
            ::nFirstRow = ::nOption
         endif
         ::oScrBar:nValue = ::nOption
         ::oScrBar:ThmCheck()
         ::Display()
         ::Selected()
      endif
      ::Hilite()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD Hilite() CLASS TListBox

   local nWidth := ::nRight - ::nLeft

   if Len( ::acItems ) != 0
      MOff()
      SayHot( ::nTop + ( ::nOption - ::nFirstRow ), ::nLeft,;
              PadR( ::acItems[ ::nOption ], nWidth - 2 ), ::nClrDataFocus )
      MOn()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD DeHilite( nColor ) CLASS TListBox

   local nWidth := ::nRight - ::nLeft

   if Len( ::acItems ) != 0
      MOff()
      SayHot( ::nTop + ( ::nOption - ::nFirstRow ), ::nLeft,;
              PadR( ::acItems[ ::nOption ], nWidth -2 ), nColor )
      MOn()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD PgUp() CLASS TListBox

   local nRows := ::nBottom - ::nTop + 1

   if ::nOption > 1
      ::Dehilite( ::nClrNormal )
      if ::nOption <= nRows             // Est  en la primera pantalla
         if ::nFirstRow != 1            // No est  mostrada la
            ::nFirstRow = 1
            ::Display()
         else
            ::nOption = 1
            ::oScrBar:nValue = 1
            ::oScrBar:ThmCheck()
            ::Selected()
         endif
      else                              // No est  en la primera pantalla
         ::nOption -= ( nRows - 1 )
         ::nFirstRow = ::nOption - ( nRows - 1 )
         if ::nOption < nRows            // Est  ya en la primera
            ::nOption = nRows            // £ltima l¡nea primera pantalla
            ::nFirstRow = 1
          endif
         ::oScrBar:nValue = ::nOption
         ::oScrBar:ThmCheck()
         ::Display()
         ::Selected()
      endif
      ::Hilite()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD GoTop() CLASS TListBox

   if ::nOption != 1
      ::DeHilite( ::nClrNormal )
      ::nOption = 1
      if ::nFirstRow != 1
         ::nFirstRow = 1
         ::Display()
      endif
      ::oScrBar:nValue = ::nOption
      ::oScrBar:ThmCheck()
      ::Selected()
      ::Hilite()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD GoBottom() CLASS TListBox

   local nItems  := Len( ::acItems )
   local nRows := ::nBottom - ::nTop + 1

   if nItems > 0
      if ::nOption != nItems
         ::DeHilite( ::nClrNormal )
         ::nOption  = nItems
         if ::nFirstRow != Max( nItems - ( nRows - 1 ), 1 )
            ::nFirstRow = Max( nItems - ( nRows - 1 ), 1 )
            ::Display()
         endif
         ::oScrBar:nValue = ::nOption
         ::oScrBar:ThmCheck()
         ::Selected()
         ::Hilite()
      endif
   endif

return nil

//----------------------------------------------------------------------------//

METHOD AddItem( cItem ) CLASS TListBox

   AAdd( ::acItems, cItem )
   ::Changed()

return nil

//----------------------------------------------------------------------------//

METHOD SetItems( acItems ) CLASS TListBox

   ::acItems        = acItems
   ::nOption        = 1
   ::nFirstRow      = 1
   ::oScrBar:nValue = 1
   ::oScrBar:nRange = Len( ::acItems )
   ::oScrBar:ThmCheck()
   ::Display()
   ::Changed()

return nil

//----------------------------------------------------------------------------//

METHOD LDelete( nItem ) CLASS TListBox

   if Len( ::acItems ) > 0 .and. nItem <= Len( ::acItems )
      ADel( ::acItems, nItem )
      ASize( ::acItems, Len( ::acItems ) - 1 )
      ::nOption = Min( ::nOption, Len( ::acItems ) )
      ::oScrBar:nValue = ::nOption
      ::oScrBar:nRange = Len( ::acItems )
      ::oScrBar:ThmCheck()
      ::Changed()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD ChangePos( nRow, nCol ) CLASS TListBox

  Super:ChangePos( nRow, nCol )

  ::oScrBar:ChangePos( ::nTop, ::nRight - 1 )

return nil

//----------------------------------------------------------------------------//


// estos dos m‚todos son provisionales
method nAbsTop class TlistBox

	return ::nTop+if(!empty(::oLabel:cText),1,0)
	
METHOD 	nAbsLeft class TlistBox

Return ::nLeft

//----------------------------------------------------------------------------//

METHOD ReSize() CLASS TListBox

   Super:ReSize()
   ::oScrBar:Hide()
   ::oScrBar:nBottom = ::nBottom
   ::oScrBar:Display()

return nil

//----------------------------------------------------------------------------//
