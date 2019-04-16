#include "FivePro.ch"


// modificado el Tue 12/04/1994 por CGR
// objetivo, cambiar el uso de las teclas derecha e Izda. cuando hay un
// Submenu abierto, a fin  de que pase una posici¢n completa a la derecha o
// izda. facilita el movimiento, evita pulsar muchos Esc.

// 22:53:08   Wed 04/05/1994  ¨y si se sale de la ventana?

//----------------------------------------------------------------------------//

CLASS TMenuBar FROM TMenu

   DATA   bAction
   DATA   nRow, nCol, nMsgRow, nMsgCol
   DATA   oWnd
   DATA   nLines // numero de lineas del menu en curso.
   
   METHOD New( nRow, nMsgRow, nMsgCol, aClrItems ) CONSTRUCTOR
   METHOD Display()
   METHOD Add( oItem )
   METHOD GoLeft()
   METHOD GoRight()
   METHOD GoUp()
   METHOD GoDown()
   METHOD GoHome()
   METHOD KeyPressed( nKey )
   METHOD SetAction( bAction ) BLOCK { | Self, bAction | ::bAction := bAction }
   METHOD Activate( bIdle )
   METHOD DeActivate()
   METHOD Click( nRow, nCol )
   METHOD SetOption( nOption )
   METHOD lShortCut( nKey )

   METHOD ChangePos( nRow, nCol )

   METHOD lIsOver( nRow, nCol )
   METHOD SetColor( aColors )
   METHOD End() BLOCK { | Self | ::lEnd := .t. }

   METHOD SetMsg( cMsg ) BLOCK ;
          { | Self, cMsg | If( ::oWnd != nil, ::oWnd:SetMsg( cMsg ),) }

   METHOD GenRC()

ENDCLASS

// ----------------------------------------------------------------------------

METHOD New( nRow, nMsgRow, nMsgCol, aClrItems ) CLASS TMenuBar

  DEFAULT nRow := 1, nMsgRow := MaxRow(), nMsgCol := 0
  DEFAULT aClrItems := { "W+/B", "N/G", "R/W", "R/G", "N+/W", "N+/G" }

  Super:New()

  ::nRow      = nRow
  ::nCol      = 0
  ::nMsgRow   = nMsgRow
  ::nMsgCol   = nMsgCol
  ::aClrItems = aClrItems
  ::cVarName  = "oMenu"
  ::nLines    :=0
return nil

// ----------------------------------------------------------------------------

METHOD Display() CLASS TMenuBar

   local oSubMenu := If( ::nOption != 0, ::aItems[ ::nOption ]:xAction, nil )
   local n

   ::ChangePos(::nRow,::nCol)
   
   If Len( ::aItems ) > 1
      MOff()
      for n:=0 to ::nLines
        @ ::nRow + n, ::nCol - 1 SAY ;
          If( ::oWnd != nil,  "µ"+ Space( ::oWnd:nRight - ::oWnd:nLeft -1)+"Í",;
          Space( MaxCol() + 1 ) ) COLOR ::aClrItems[ 1 ]
      end
      AEval( ::aItems, { | o, n | o:Display( n == ::nOption ) } )
      MOn()
   endif

   if ::lOpened .and. ValType( oSubMenu ) == "O"
   	if oSubmenu:nOption=0
   		oSubmenu:nOption:=1
   	end
      oSubMenu:Display()
   end

return nil

// ----------------------------------------------------------------------------

METHOD Add( oItem ) CLASS TMenuBar

  local oLastItem := ATail( ::aItems )

  oItem:nCol = If( oLastItem == nil, 1, oLastItem:nCol + Len( oLastItem:cItem ) ;
               - If( At( "&", oLastItem:cItem ) != 0, 1, 0 )+5)
  // si se sale de la ventana ....
  if ::oWnd!=nil
  	if oItem:nCol+len(oItem:cItem)-If(At("&",oLastItem:cItem)!=0,1,0);
      >= ::oWnd:nRight
  		::nLines++
      oItem:nCol = ::oWnd:nLeft+1
  	end
  end
  oItem:nRow = ::nRow+::nLines
  oItem:oMenu = Self
  AAdd( ::aItems, oItem )

return nil

// ----------------------------------------------------------------------------

METHOD GoLeft() CLASS TMenuBar

   local lFirst     := .t.
   local nOption    := ::nOption

   MOff()
   DO
      if ! lFirst
         Inkey()
      endif
      lFirst = .f.
 	  if --nOption<1
 	  	nOption:=len(::aItems)
 	  end
 	  ::setoption(nOption)
 	  if ::lOpened.and.valtype(::aitems[nOption]:xaction)=='O'
 	  	::aitems[nOption]:xaction:setoption(1)
 	  end
     UNTIL NextKey() != K_LEFT
   MOn()

return nil

// ----------------------------------------------------------------------------

METHOD GoRight() CLASS TMenuBar

   local lFirst     := .t.
   local nOption    := ::nOption

   MOff()
   DO
      if ! lFirst
         Inkey()
      endif
      lFirst = .f.
      if ++nOption>len(::aItems)
      	nOption:=1
      end
      ::SetOption(nOption)
 	  if ::lOpened.and.valtype(::aitems[nOption]:xaction)=='O'
 	  	::aitems[nOption]:xaction:setoption(1)
 	  end

   UNTIL NextKey() != K_RIGHT
   MOn()

return nil

// ----------------------------------------------------------------------------

METHOD GoUp() CLASS TMenuBar

   local oSubMenu := ::aItems[ ::nOption ]:xAction

   if ::lOpened .and. ValType( oSubMenu ) == "O"
      oSubMenu:GoUp()
   else
      ::GoLeft()
   endif

return nil

// ----------------------------------------------------------------------------

METHOD GoDown() CLASS TMenuBar

   local oSubMenu := ::aItems[ ::nOption ]:xAction

   if ::lOpened .and. ValType( oSubMenu  ) == "O"
      oSubMenu:GoDown()
   else
     if ! ::lOpened
        ::lOpened := .t.
        if ValType( oSubMenu ) == "O"
           if oSubMenu:nOption == 0
              oSubMenu:nOption = 1
           endif
           oSubMenu:Display()
        else
           ::SetAction( oSubMenu )
        endif
     else
        ::GoRight()
     endif
   endif

return nil

// ----------------------------------------------------------------------------

METHOD GoHome() CLASS TMenuBar

   if ::lOpened .and. ValType( ::aItems[ ::nOption ]:xAction ) == "O"
      ::aItems[ ::nOption ]:xAction:KeyPressed( K_HOME )
   else
      ::SetOption( 1 )
      if ValType( ::aItems[ ::nOption ]:xAction ) == "O"
         ::aItems[ ::nOption ]:xAction:GoHome()
      endif
   endif

return nil

// ----------------------------------------------------------------------------

METHOD KeyPressed( nKey ) CLASS TMenuBar

   local nNewOption
   local cSinAlt
   local oSubMenu := If( ::nOption != 0, ::aItems[ ::nOption ]:xAction, nil )

   do case
      case nKey == K_RIGHT
           ::GoRight()

      case nKey == K_LEFT
           ::GoLeft()

      case nKey == K_UP
           ::GoUp()

      case nKey == K_DOWN
           ::GoDown()

      case nKey == 0
           ::Click( nMRow(), nMCol() )

      case ::lShortCut( nKey )
           // No hacer nada si es un ShortCut

      case nKey == K_ESC
           if ::lOpened
              if ValType( oSubMenu ) == "O"
                 oSubMenu:Hide()
                 if ! oSubMenu:lVisible
                    ::lOpened = .f.
                    ::aItems[ ::nOption ]:Display( .t. )
                 endif
              endif
           endif

      case nKey == K_ENTER
        if ! ::lOpened
           ::lOpened := .t.
           if ValType( oSubMenu ) == "O"
              if oSubMenu:nOption == 0
                 oSubMenu:nOption = 1
              endif
              oSubMenu:Display()
           else
              ::SetAction( oSubMenu )
           endif
        else
           if ValType( oSubMenu ) == "O"
              oSubMenu:KeyPressed( K_ENTER )
           else
              ::SetAction( oSubMenu )
           endif
        endif

      case nKey == K_HOME
           ::GoHome()

      case nKey == K_END
           ::GoEnd()

      case lAltChr( nKey, @cSinAlt )
         if ( nNewOption := ::nHotAt( cSinAlt ) ) != 0
            if ::nOption != nNewOption
               ::SetOption( nNewOption )
               if ! ::lOpened
                  ::KeyPressed( K_ENTER )
               endif
            endif
            if ValType( oSubMenu := ( ::aItems[ nNewOption ]:xAction ) ) == "O"
               oSubMenu:SetOption( 1 )
            endif
            nKey:=0
         endif

      otherwise
         if ::lOpened .and. ValType( oSubMenu ) == "O"
            nKey:=oSubMenu:KeyPressed( nKey )
         else
            if ( nNewOption := ::nHotAt( Upper( Chr( nKey ) ) ) ) > 0
               ::SetOption( nNewOption )
               ::KeyPressed( K_ENTER )
               nKey:=0
            endif
         endif
   endcase

return nKey

// ----------------------------------------------------------------------------

METHOD Deactivate() CLASS TMenuBar

   local oSubMenu := If( ::nOption != 0, ::aItems[ ::nOption ]:xAction, nil )

   if oSubMenu != nil .and. ValType( oSubMenu ) == "O"
      while ::lOpened
         ::aItems[ ::nOption ]:xAction:Hide()
         if ! ::aItems[ ::nOption ]:xAction:lVisible
            ::lOpened = .f.
         endif
      enddo
   endif

   if ::nOption != 0
      ::aItems[ ::nOption ]:Display( .f. )
      ::nOption = 0
   endif

return nil

// ----------------------------------------------------------------------------

METHOD Activate( bIdle ) CLASS TMenuBar

  static nControl := 0
  local  oSubMenu
  local  nOldRow

  ::lEnd = .f.
  ::Display()
  MOn()

  while ! ::lEnd
     ::KeyPressed( nMKeyWait( 0, bIdle ) )
     if ::bAction != nil
        nOldRow = ::nMsgRow
        ::nMsgRow = MaxRow() + 1
        ::DeActivate()
        Eval( ::bAction )
        ::nMsgRow = nOldRow
        if ! ::lEnd
           ::bAction = nil
           ::aItems[ ::nOption ]:Display( .t. )
           oSubMenu := ::aItems[ ::nOption ]:xAction
           while ValType( oSubMenu ) == "O"
              ::KeyPressed( K_ENTER )
              oSubMenu := oSubMenu:aItems[ oSubMenu:nOption ]:xAction
           enddo
        endif
     endif
  enddo

  // MOff()
  ::DeActivate()
  MReset()

return nil

// ----------------------------------------------------------------------------

METHOD Click( nRow, nCol ) CLASS TMenuBar

   local nAt
   local oSubMenu

   ::bAction = nil

   DO
     if ( nAt := AScan( ::aItems, { | oItem | oItem:lIsOver( nRow, nCol ) } ) ) == 0
        if ::nOption != 0
           if ValType( oSubMenu := ::aItems[ ::nOption ]:xAction ) == "O"
              if oSubMenu:lIsOver( nRow, nCol )
                 oSubMenu:Click( nRow, nCol )
              else
                 ::SetOption( 0 )
              endif
           else
              ::SetOption( 0 )
           endif
        endif
     else
        ::SetOption( nAt )
        if ValType( oSubMenu := ::aItems[ ::nOption ]:xAction ) == "O"
           if ! oSubMenu:lVisible
              oSubMenu:Display()
              ::lOpened = .t.
           else
              oSubMenu:SetOption( 0 )
           endif
        endif
     endif

     MUpdate()
     nRow = nMRow()
     nCol = nMCol()

  UNTIL ! lMPressed()

  if ::nOption != 0
     if ValType( oSubMenu := ::aItems[ ::nOption ]:xAction ) == "O"
        if oSubMenu:nOption == 0
           oSubMenu:SetOption( 1 )
        endif
     else
        if ::aItems[ ::nOption ]:xAction != nil .and. ;
           ::aItems[ ::nOption ]:lIsOver( nMRow(), nMCol() )
           Eval( ::aItems[ ::nOption ]:xAction )
        endif
     endif
  endif

  if ::bAction != nil
     ::DeActivate()
     Eval( ::bAction )
  endif

return nil

// ----------------------------------------------------------------------------

METHOD SetOption( nOption ) CLASS TMenuBar

   local lWasOpened := ::lOpened
   local oSubMenu

   if nOption != ::nOption
      if ::nOption != 0
         if ValType( oSubMenu := ::aItems[ ::nOption ]:xAction ) == "O"
            while oSubMenu:lVisible
               oSubMenu:Hide()
            end
            oSubMenu:nOption = 0
            ::lOpened = .f.
         endif
         MOff()
         ::aItems[ ::nOption ]:Display( .f. )
         MOn()
      endif

      MOff()
      ::nOption = nOption
      if nOption != 0
         ::aItems[ nOption ]:Display( .t. )
      endif
      MOn()

      if lWasOpened .and. nOption != 0
         ::lOpened = .t.
         if ValType( oSubMenu := ::aItems[ ::nOption ]:xAction ) == "O"
            oSubMenu:nOption = 0
            oSubMenu:Display()
         endif
      endif
   endif

return nil

// ----------------------------------------------------------------------------

METHOD lShortCut( nKey ) CLASS TMenuBar

   local lSal := .f.
   local n    := 0

   while ++n <= Len( ::aItems ) .and. !lSal
      if ValType( ::aItems[ n ]:xAction ) == "O"
         lSal = ::aItems[ n ]:xAction:lShortCut( nKey )
      end
   end

return lSal

// ----------------------------------------------------------------------------

METHOD ChangePos( nRow, nCol ) CLASS TMenuBar

  local n, nPos := nCol + 1
//   local n, nPos 
   local oSubMenu

   ::nRow = nRow
   ::nCol = nCol
//   if len(::aItems)>0
//	   nPos:= nCol -if(::aItems[1]:cMsg=='System Menu',1,0)
//   end

	::nLines:=0
   for n = 1 to Len( ::aItems )
	   if ::aItems[n]:cMsg=='System Menu'
	   	   	::aItems[n]:ChangePos(::oWnd:nTop,::oWnd:nLeft )
	   else
	   if ::oWnd!=nil
		   if nPos+Len( ::aItems[ n ]:cItem ) - ;
               If( At( "&", ::aItems[ n ]:cItem ) != 0, 1, 0 );
               >::oWnd:nRight
               ::nLines++
               nRow++
               nPos:=::oWnd:nLeft+1
           end
       end
       ::aItems[ n ]:ChangePos( nRow, nPos )
       nPos += Len( ::aItems[ n ]:cItem ) - ;
               If( At( "&", ::aItems[ n ]:cItem ) != 0, 1, 0 )
       if ValType( oSubMenu := ::aItems[ n ]:xAction ) == "O"
          ::aItems[ n ]:SetMenu( oSubMenu )
       endif
       endif

   next

return nil

//----------------------------------------------------------------------------//

METHOD lIsOver( nRow, nCol ) CLASS TMenuBar

   local oMenu
   local lIsOver := ( AScan( ::aItems,;
                      { | oItem | oItem:lIsOver( nRow, nCol ) } ) != 0 )

   if ! lIsOver .and. ::lOpened
      if ::nOption != 0
         if ValType( oMenu := ::aItems[ ::nOption ]:xAction ) == "O"
            lIsOver = oMenu:lIsOver( nRow, nCol )
         endif
      endif
   endif

return lIsOver

//----------------------------------------------------------------------------//

METHOD SetColor( aClr ) CLASS TMenuBar

   local n
   local oSubMenu

   ::Deactivate()
   ::aClrItems = aClr
   for n = 1 to Len( ::aItems )
      if ValType( oSubMenu := ::aItems[ n ]:xAction ) == "O"
         oSubMenu:SetColor( aClr )
      end
   next
   ::Display()

return nil

// ----------------------------------------------------------------------------

METHOD GenRC() CLASS TMenuBar

   local cRC := ::cVarName + " MENU" + CRLF
   local n

   if Len( ::aItems ) > 1
      cRC += "BEGIN" + CRLF

      for n = 2 to Len( ::aItems )
         cRC += ::aItems[ n ]:GenRC( n * 10 )
      next

      cRC += "END"
   endif

return cRC + CRLF

// ----------------------------------------------------------------------------
