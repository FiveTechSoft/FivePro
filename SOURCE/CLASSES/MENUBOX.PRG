#include "FivePro.ch"

// modificado por  CGR 1:23:14   Wed 13/04/1994
// Objetivo, a¤adir un spacio m s a los items, para la flechita de
// submenu no desaparezca.

static nClsBar

// ----------------------------------------------------------------------------

CLASS TMenuBox FROM TMenu

   DATA   cBack
   DATA   nTop, nLeft, nBottom, nRight
   DATA   oMenu

   METHOD New( nTop, nLeft, nBottom, nRight, aClrItems ) CONSTRUCTOR
   METHOD Display()
   METHOD Hide()
   METHOD Add( oItem )
   METHOD GoDown()
   METHOD GoUp()
   METHOD GoLeft()
   METHOD GoRight()
   METHOD GoHome()
   METHOD lShortCut( nKey )
   METHOD KeyPressed( nKey )
   METHOD ChangePos( nRow, nCol )
   METHOD Adjust()
   METHOD SetAction( bAction )
   METHOD lIsOver( nRow, nCol )
   METHOD Click( nRow, nCol )
   METHOD SetOption( nOption )
   METHOD nMsgRow() BLOCK ;
          { | Self | If( ::oMenu != nil, ::oMenu:nMsgRow(), nil ) }
   METHOD nMsgCol() BLOCK ;
          { | Self | If( ::oMenu != nil, ::oMenu:nMsgCol(), 0 ) }
   METHOD SetColor( aColor )

   METHOD SetMsg( cMsg ) BLOCK ;
          { | Self, cMsg | If( ::oMenu != nil, ::oMenu:SetMsg( cMsg ),) }

   METHOD GenRC( nId )

ENDCLASS

// ----------------------------------------------------------------------------

METHOD New( nTop, nLeft, nBottom, nRight, aClrItems ) CLASS TMenuBox

  DEFAULT nTop := 0, nLeft := 0, nBottom := 1, nRight := 1
  DEFAULT aClrItems := { "W+/B", "N/G", "R/W", "R/G", "N+/W", "N+/G" }

  if nClsBar == nil
     nClsBar = TMenuBar():ClassH
  end

  Super:New()

  ::aClrItems = aClrItems
  ::cBack     = ""
  ::lOpened   = .f.
  ::lVisible  = .f.
  ::nTop      = nTop
  ::nLeft     = nLeft
  ::nBottom   = nBottom
  ::nRight    = nRight
  ::nOption   := 0
return

// ----------------------------------------------------------------------------

METHOD Display() CLASS TMenuBox

  local n
  local nTop := ::nTop, nLeft := ::nLeft, nBottom := ::nBottom, nRight := ::nRight

  ::lVisible = .t.
  MOff()
  ::cBack = SaveScreen( nTop, nLeft, nBottom + 1, nRight + 2 )
  MBoxDisplay( nTop, nLeft, nBottom, nRight )
  Shadow( nTop + 1, nRight + 1, nBottom, nRight + 2 )
  Shadow( nBottom + 1, nLeft + 2, nBottom + 1, nRight + 2 )
  for n = 1 to Len( ::aItems )
      ::aItems[ n ]:Display( n == ::nOption )
  next
  MOn()

return

// ----------------------------------------------------------------------------

METHOD Hide() CLASS TMenuBox

   local oSubMenu

   if ::lOpened
      oSubMenu = ::aItems[ ::nOption ]:xAction
      oSubMenu:Hide()
      if ! oSubMenu:lVisible
         ::lOpened = .f.
         ::aItems[ ::nOption ]:Display( .t. )
      endif
   else
      MOff()
      RestScreen( ::nTop, ::nLeft, ::nBottom + 1, ::nRight + 2, ::cBack )
      MOn()
      ::cBack    = ""
      ::lVisible = .f.
   endif

return

// ----------------------------------------------------------------------------

METHOD Add( oItem ) CLASS TMenuBox

  local oLastItem := ATail( ::aItems )

  oItem:nCol  = ::nLeft + 1
  oItem:nRow  = If( oLastItem == nil, ::nTop + 1, oLastItem:nRow + 1 )
  oItem:oMenu = Self
  ::nBottom++
  ::nRight = ::nLeft + Max( ::nRight - ::nLeft, Len( oItem:cItem ) )
  AAdd( ::aItems, oItem )

return

// ----------------------------------------------------------------------------

METHOD GoDown() CLASS TMenuBox

   local oSubMenu := ::aItems[ ::nOption ]:xAction
   local lFirst   := .t.

   if ::lOpened
      oSubMenu:GoDown()
   else
      MOff()
      DO
         if ! lFirst
            Inkey()
         endif
         lFirst = .f.
         ::aItems[ ::nOption ]:Display( .f. )
         DO
            ::nOption++
            if ::nOption > Len( ::aItems )
               ::nOption = 1
            end
         UNTIL !Empty( ::aItems[ ::nOption ]:cItem )
         ::aItems[ ::nOption ]:Display( .t. )
      UNTIL NextKey() != K_DOWN
      MOn()
   end

return

// ----------------------------------------------------------------------------

METHOD GoUp() CLASS TMenuBox

   local oSubMenu := ::aItems[ ::nOption ]:xAction
   local lFirst   := .t.

   if ::lOpened
      oSubMenu:GoUp()
   else
      MOff()
      DO
         if ! lFirst
            Inkey()
         endif
         lFirst = .f.
         ::aItems[ ::nOption ]:Display( .f. )
         DO
            ::nOption--
            if ::nOption < 1
              ::nOption = Len( ::aItems )
            end
         UNTIL !Empty( ::aItems[ ::nOption ]:cItem )
         ::aItems[ ::nOption ]:Display( .t. )
      UNTIL NextKey() != K_UP
      MOn()
  endif

return

// ----------------------------------------------------------------------------

METHOD GoLeft() CLASS TMenuBox

   local oSubMenu := ::aItems[ ::nOption ]:xAction

   if ::lOpened
      oSubMenu:GoLeft()
      if ! oSubMenu:lVisible
         ::lOpened = .f.
      end
   else
      ::Hide()
   endif

return

// ----------------------------------------------------------------------------

METHOD GoRight() CLASS TMenuBox

   if ::lOpened
      ::aItems[ ::nOption ]:xAction:GoRight()
   else
      if ::oMenu:ClassH == nClsBar
         ::Hide()
      else
         ::GoDown()
      end
   end

return

// ----------------------------------------------------------------------------

METHOD GoHome() CLASS TMenuBar

   if ::lOpened
      ::aItems[ ::nOption ]:xAction:KeyPressed( K_HOME )
   else
      ::SetOption( 1 )
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TMenuBox

   local nNewOption
   local oSubMenu := ::aItems[ ::nOption ]:xAction

   do case

      case nKey == K_ENTER
           do case
              case ValType( oSubMenu ) == "O"
                   if ! oSubMenu:lVisible
                      if oSubMenu:nOption == 0
                         oSubMenu:nOption = 1
                      end
                      oSubMenu:Display()
                      ::lOpened = .t.
					   return 0
                      
                   else
                      oSubMenu:KeyPressed( K_ENTER )
					   return 0
                   endif

              case oSubMenu != nil .and. ::oMenu != nil .and. ;
                   ::aItems[ ::nOption ]:lActive
                   ::SetAction( oSubMenu )

              otherwise
                 if oSubMenu != nil
                    Eval( oSubMenu )
                 endif
           endcase

      case nKey == K_LEFT
           ::GoLeft()
		   return 0

      case nKey == K_RIGHT
           ::GoRight()
		   return 0

      case nKey == K_DOWN
           ::GoDown()
		   return 0

      case nKey == K_UP
           ::GoUp()
		   return 0

      case nKey == K_HOME
           ::GoHome()
		   return 0

      case nKey == K_END
           ::GoEnd()
		   return 0

      otherwise
         if ::lOpened
            oSubMenu:KeyPressed( nKey )
         else
            if ( nNewOption := ::nHotAt( Upper( Chr( nKey ) ) ) ) > 0
               ::SetOption( nNewOption )
               ::KeyPressed( K_ENTER )
            endif
         endif

   endcase

return

// ----------------------------------------------------------------------------

METHOD ChangePos( nRow, nCol ) CLASS TMenuBox

   local nHeight := Len( ::aItems ) + 1
   local nWidth  := ::nRight - ::nLeft
   local n
   local oSubMenu

//   ::nTop    = Min( nRow, MaxRow() - nHeight -2 )
	if nRow+nHeight>=MaxRow()
		::nTop:=nRow-nHeight
		else
		::nTop:=nRow
	end

   ::nLeft   = Min( nCol, MaxCol() - nWidth - 2 )

   ::nBottom = ::nTop + nHeight
   ::nRight  = ::nLeft + nWidth

   for n = 1 to Len( ::aItems )
       ::aItems[ n ]:ChangePos( ::nTop + n, ::nLeft + 1 )
       if ValType( oSubMenu := ::aItems[ n ]:xAction ) == "O"
          ::aItems[ n ]:SetMenu( oSubMenu )
       endif
   next

return

// ----------------------------------------------------------------------------

METHOD Adjust() CLASS TMenuBox

   local n
   local nMaxWidth := 0
   local oSubMenu

   for n = 1 to Len( ::aItems )
       nMaxWidth = Max( nMaxWidth, Len( ::aItems[ n ]:cItem )+1 )
   next

   nMaxWidth = Max( nMaxWidth, ::nRight - ::nLeft - 1 )

   for n = 1 to Len( ::aItems )
       ::aItems[ n ]:cItem = PadR( ::aItems[ n ]:cItem, nMaxWidth - ;
                             If( At( "&", ::aItems[ n ]:cItem ) > 0, 0, 1 ) )
   next
   ::nRight = ::nLeft + nMaxWidth
   if ::nRight + 2 > MaxCol()
      ::ChangePos( ::nTop + If( ::oMenu:ClassName() == "TMENUBOX", 1, 0 ),;
                MaxCol() )
   endif
   for n = 1 to Len( ::aItems )
       If ValType( oSubmenu := ::aItems[ n ]:xAction ) == "O"
          ::aItems[ n ]:SetMenu( oSubMenu )
       endif
   next

return

// ----------------------------------------------------------------------------

METHOD SetAction( bAction ) CLASS TMenuBox

   if ::oMenu != nil
      ::oMenu:SetAction( bAction )
   endif

return

// ----------------------------------------------------------------------------

METHOD lIsOver( nRow, nCol ) CLASS TMenuBox

   local lIsOver := nRow >= ::nTop .and. nRow <= ::nBottom .and. ;
                    nCol >= ::nLeft .and. nCol <= ::nRight

   if ! lIsOver .and. ::nOption != 0
      if ValType( ::aItems[ ::nOption ]:xAction ) == "O" .and. ::lOpened
         lIsOver = ::aItems[ ::nOption ]:xAction:lIsOver( nRow, nCol )
      endif
   endif

return lIsOver

// ----------------------------------------------------------------------------

METHOD Click( nRow, nCol ) CLASS TMenuBox

   local nAt
   local oSubMenu

   DO
       if ::lOpened .and. ::nOption != 0
          if ValType( oSubMenu := ::aItems[ ::nOption ]:xAction ) == "O"
             if oSubMenu:lIsOver( nRow, nCol )
                oSubMenu:Click( nRow, nCol )
             else
                if ::lIsOver( nRow, nCol )
                   if ( nAt := AScan( ::aItems, { | oItem | oItem:lIsOver( nRow, nCol ) } ) ) != 0
                      if nAt != ::nOption
                         ::SetOption( nAt )
                      else
                         oSubMenu:SetOption( 0 )
                      endif
                   endif
                endif
             endif
          endif
       else
          if ( nAt := AScan( ::aItems, { | oItem | oItem:lIsOver( nRow, nCol ) } ) ) != 0
             ::SetOption( nAt )
          else
             ::SetOption( 0 )  // ¨Ser  esto?
          end
       end

       MUpdate()
       nRow = nMRow()
       nCol = nMCol()

   UNTIL ! lMPressed() .or. ! ::lIsOver( nRow, nCol )

   if ! ::lIsOver( nRow, nCol )
      ::SetOption( 0 )
   end

   if ::lIsOver( nRow, nCol ) .and. ::nOption != 0
      if ! ::lOpened
         if ! Empty( ::aItems[ ::nOption ]:cItem )
            ::KeyPressed( K_ENTER )
         end
      else
         if oSubMenu:nOption == 0
            oSubMenu:SetOption( 1 )
         endif
      endif
   endif

   if ::nOption != 0
      if Empty( ::aItems[ ::nOption ]:cItem )
         ::SetOption( 1 )
      end
   end

return

// ----------------------------------------------------------------------------

METHOD SetOption( nOption ) CLASS TMenuBox

   if ::nOption != nOption
      MOff()
      if ::nOption != 0
         if ValType( ::aItems[ ::nOption ]:xAction ) == "O" .and. ::lOpened
            while ::lOpened
               ::aItems[ ::nOption ]:xAction:Hide()
               if ! ::aItems[ ::nOption ]:xAction:lVisible
                  ::lOpened = .f.
               endif
            end
         endif
         ::aItems[ ::nOption ]:Display( .f. )
      endif
      ::nOption = nOption

      if nOption != 0
         ::nOption = nOption
         ::aItems[ ::nOption ]:Display( .t. )
      endif
   endif
   MOn()

return

//----------------------------------------------------------------------------//

METHOD lShortCut( nKey ) CLASS TMenuBox

   local lSal := .f.
   local n    := 0

   while ++n <= Len( ::aItems ) .and. !lSal
      if ValType( ::aItems[ n ]:xAction ) == "O"
         lSal = ::aItems[ n ]:xAction:lShortCut( nKey )
      else
         if ::aItems[ n ]:nShortCut == nKey
            if ::aItems[ n ]:xAction != nil .and. ;
               ::aItems[ n ]:lActive
               ::SetAction( ::aItems[ n ]:xAction )
            endif
            lSal = .t.
         end
      end
   end

return lSal

// ----------------------------------------------------------------------------

METHOD SetColor( aClr ) CLASS TMenuBox

   local n
   local oSubMenu

   for n = 1 to Len( ::aItems )
      ::aClrItems = aClr
      if ValType( oSubMenu := ::aItems[ n ]:xAction ) == "O"
         oSubMenu:SetColor( aClr )
      end
   next

return

// ----------------------------------------------------------------------------

METHOD GenRC( nId ) CLASS TMenuBox

   local cRC := ""

   AEval( ::aItems, { | oItem, n | cRC += oItem:GenRC( ( nId * 10 ) + ( n * 10 ) ) } )

return cRC

// ----------------------------------------------------------------------------
