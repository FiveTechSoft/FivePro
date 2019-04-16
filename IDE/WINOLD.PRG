#include "FivePro.ch"

// modificado por CGR Wed 13-04-1994 10:35:33 am
// objetivo: corregir un buf al pulsar con el rat¢n 
// al mover la ventana principal

#define WND_LCLOSE         1
#define WND_LFLOAT         2 // que se mueva
#define WND_LGROW          4 // Que cambie de tama¤o
#define WND_LHSCROLL       8 // Barra Hor Scroll
#define WND_LICONIZE      16 // Posibilidad de iconizar
#define WND_LMAXIMIZED    32 //
#define WND_LMODAL        64
#define WND_LMINIMIZED   128 // Modo inicial
#define WND_LSHADOW      256
#define WND_LVSCROLL     512
#define WND_LZOOM       1024
#define WND_LFOCUSED    2048

static bTrue  := { || .t. }
static bClock := { || SayClock( Time() ) }

//----------------------------------------------------------------------------//

init procedure InitSystem()

   BoxFont()
   SetCuaFont()
   SetBlink( .f. )
   SetDac( 56, 32, 32, 32 )          // Color Gris al look Windows
   SET SCOREBOARD OFF
   MInit()
   MOn()

return

//----------------------------------------------------------------------------//

exit procedure CloseSystem()

   MOff()
   MReset()
   FntSystem()
return

//----------------------------------------------------------------------------//

CLASS TWindow FROM TView

   DATA   aControls, aWindows
   DATA   nClrTitle, nFocus
   DATA   bIconized, bPainted, bResized, bZoomed
   DATA   cFrame, cImage, cTitle
   DATA   nStyle
   DATA   lEnd, lModal 
   // ,lMinimized, lMaximized han pasado a tView, por que si no ..
   // como controla el resize cuando est  minimizada o maximizada
   // si no es un cacao.
   DATA   nOldTop, nOldLeft, nOldBottom, nOldRight
   DATA   nCrsOldRow, nCrsOldCol, nCrsOldValue
   DATA   oBar, oMenu, oSysMenu, oWnd


   METHOD New( nTop, nLeft, nBottom, nRight, nHeight, nWidth,;
               cTitle, cFrameStd, cFrame, cColorSpec, lMax, lMin, cClose,;
               cFloat, cGrow, cIconize, cZoom, lVScroll, lHScroll,;
               oMenu, lShadow, oWnd ) CONSTRUCTOR

   /*
   METHOD NewDlg( nTop, nLeft, nBottom, nRight, nHeight, nWidth, cTitle,;
                  cFrameStd, cFrame, cColorSpec, lMin, cClose, ;
                  cFloat, cIconize, lVScroll, lHScroll, ;
                  lShadow, oWnd ) CONSTRUCTOR */

   METHOD AddControl( oCtrl ) 

   METHOD AddWindow( oWnd ) BLOCK ;
      { | Self, oWnd | If( ! Empty( ::aWindows ),;
                       ATail( ::aWindows ):SetFocus( .f. ),),;
                       AAdd( ::aWindows, oWnd ), oWnd:oWnd := Self }

   METHOD Adjust() BLOCK ;
      { | Self | If( ::bReSized != nil, Eval( ::bReSized ),) }

   METHOD Cascade()

   METHOD ChangeFocus( oCtrl )

   METHOD ChangePos( nRow, nCol )

   METHOD CtrlChange( nCtrl )

   METHOD Destroy( oWnd )
   METHOD Display()

   METHOD GenRC()

   METHOD Maximize()
   METHOD Minimize()
   METHOD MouseMove( nRow, nCol )

   METHOD Normal()
   METHOD Activate( bWhen, bValid, bClicked, bIconized, bMoved,;
                    bPainted, bResized, bZoomed, lNoWait )
   METHOD Hide()
   METHOD DeActivate()
   METHOD End()
   METHOD lAtBorder( nRow, nCol ) BLOCK ;
      { | Self, nRow, nCol | nRow == ::nTop .or. nRow == ::nBottom .or. ;
                             nCol == ::nLeft .or. nCol == ::nRight }

   METHOD nAtWindow( nRow, nCol )
   METHOD nAtControl( nRow, nCol )

   METHOD Click( nRow, nCol )
   METHOD DblClick( nRow, nCol )

   METHOD Clicked( nRow, nCol )
   METHOD Say( nRow, nCol, cText, cColor, cPicture )
   METHOD lAtClose( nRow, nCol )
   METHOD lAtMaxBtn( nRow, nCol )
   METHOD lAtMinBtn( nRow, nCol )
   METHOD lAtResize( nRow, nCol )
   METHOD lAtTitle( nRow, nCol )
   METHOD Close()

   METHOD nHotCtrl( nKey )

   METHOD PrevControl()

   METHOD WndChange( nWindow )

   METHOD KeyPressed( nKey )
   METHOD SetFocus( lOnOff )

   METHOD SetMsg( cMsg ) BLOCK ;
       { | Self, cMsg | If( ::oWnd != nil, ::oWnd:SetMsg( cMsg ),;
                        SayHot( ::nBottom, ::nLeft,;
                        PadC( cMsg, ::nRight - ::nLeft + 1 ), 240 ) ),;
                        ::cMsg := cMsg }

   METHOD GenCode()

   METHOD NextControl()

   METHOD GetClientTop() BLOCK ;
      { | Self | ::nTop + If( ! Empty( ::cTitle ), 1, 0 ) ;
                 + If( ::oMenu != nil, If( Len( ::oMenu:aItems ) > 1, 1, 0 ), 0 ) ;
                 + If( ::oBar !=  nil, 1, 0 ) }

    METHOD GetClientLeft() INLINE ::nLeft + 1

	METHOD lIsOver(nRow,nCol) // determina si un punto le pertenece
			// modificada para tomar men£s que se salgan de los bordes

  Method Move (nRow,nCol) // modificado para el cambio de men£
  
ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, nHeight, nWidth,;
            cTitle, cFrameStd, cFrame, cColorSpec, lMax, lMin, cClose,;
            cFloat, cGrow, cIconize, cZoom, lVScroll, lHScroll,;
            oMenu, lShadow, oWnd ) CLASS TWindow

   DEFAULT cTitle := "Window", cColorSpec := "W+/B, N*/W",;
           lMax := .f., lMin := .f., cClose := "CLOSE", cFloat := "FLOAT",;
           cZoom := "ZOOM", cGrow := "GROW", cIconize := "ICONIZE",;
           lVScroll := .f., lHScroll := .f., lShadow := .t.

   if nHeight != nil .and. nWidth != nil
      if nTop == nil .and. nLeft == nil
         nTop    = Int( ( MaxRow() / 2 ) - ( nHeight / 2 ) ) - ;
                   If( oWnd != nil,  oWnd:GetClientTop(), 0 )
         nLeft   = Int( ( MaxCol() / 2 ) - ( nWidth / 2 ) )
         nBottom = nTop + nHeight
         nRight  = nLeft + nWidth
      endif
   endif

   Super:New( nTop, nLeft, nBottom, nRight, oWnd )

   ::aControls  = {}
   ::aWindows   = {}

   ::nClrNormal = nColorToN( cStrBtw( cColorSpec, ",", 1 ) )
   ::nClrTitle  = nColorToN( cStrBtw( cColorSpec, ",", 2 ) )

   ::lVisible   = .f.
   ::lMinimized = .f.
   ::lMaximized = .f.

   ::nCrsOldRow = 0
   ::nCrsOldCol = 0
   ::nCrsOldVal = 0
   ::nFocus     = 1

   ::nStyle     = 0

   ::nStyle     = nOR( ::nStyle,;
                       If( AllTrim( Upper( cClose ) ) == "CLOSE",;
                       WND_LCLOSE, 0 ) )

   ::nStyle     = nOR( ::nStyle,;
                       If( AllTrim( Upper( cFloat ) ) == "FLOAT",;
                       WND_LFLOAT, 0 ) )

   ::nStyle     = nOR( ::nStyle,;
                       If( AllTrim( Upper( cGrow ) ) == "GROW",;
                       WND_LGROW, 0 ) )

   ::nStyle     = nOR( ::nStyle,;
                       If( AllTrim( Upper( cIconize ) ) == "ICONIZE",;
                       WND_LICONIZE, 0 ) )

   ::nStyle     = nOR( ::nStyle,;
                       If( AllTrim( Upper( cZoom ) ) == "ZOOM",;
                       WND_LZOOM, 0 ) )

   ::nStyle     = nOR( ::nStyle, If( lHScroll, WND_LHSCROLL,   0 ),;
                                 If( lMax,     WND_LMAXIMIZED, 0 ),;
                                 If( lMin,     WND_LMINIMIZED, 0 ),;
                                 If( lShadow,  WND_LSHADOW,    0 ),;
                                 If( lVScroll, WND_LVSCROLL,   0 ) )

   if AllTrim( Upper( cFloat ) ) == "NOFLOAT"
      ::lDrag = .f.
   else
      ::lDrag = .t.
   endif

   ::cTitle   = cTitle
   ::bWhen    = bTrue
   ::cVarName = "oWnd"

   if oMenu == nil
      oMenu = TMenuBar():New()
      oMenu:lOpened = .f.
   endif

   ::oMenu      = oMenu
   ::oMenu:oWnd = Self
   oMenu:ChangePos( ::nTop + 1, ::GetClientLeft() )
   AAdd( oMenu:aItems, nil )
   AIns( oMenu:aItems )
   oMenu:aItems[ 1 ] = TMenuItem():New( ::nTop, ::nLeft, "Î¶& ",;
                            "System Menu", SysMenu( Self, oMenu ) )
   oMenu:aItems[ 1 ]:oMenu = oMenu
   oMenu:aItems[ 1 ]:aColors[ 1 ] = 240	// item inactivo
   oMenu:aItems[ 1 ]:aColors[ 2 ] = 143 //item activo
   oMenu:aItems[ 1 ]:aColors[ 3 ] = 240 // HotKey Inactiva
   oMenu:aItems[ 1 ]:aColors[ 4 ] = 240 // Hotkey activa
   oMenu:nOption = If( Len( oMenu:aItems ) > 1, 2, 0 )

   ::oWnd = oWnd
   if oWnd != nil
      oWnd:AddWindow( Self )
   endif
   ::oSysMenu:=SysMenu2(Self,::oSysMenu)
return nil

//----------------------------------------------------------------------------//

METHOD Display() CLASS TWindow

   local nTop   := ::nTop, nLeft := ::nLeft, nBottom := ::nBottom,;
         nRight := ::nRight
   local n
   local oTemp
   local lLaunchMenu:=.f.
   ::lVisible = .t.

   MOff()
   DispBegin()

   ::cBack = SaveScreen( nTop, nLeft, nBottom + 1, nRight + 2 )

   if ! ::lMinimized
      WndDisplay( nTop, nLeft, nBottom, nRight, ::nStyle,;
                  ::nClrNormal, ::nClrTitle,;
                  SubStr( ::cTitle, 1, ::nRight - ::nLeft ),;
                  ::lMaximized )

      if ::oBar != nil
         ::oBar:Display()
      endif

      if ::bPainted != nil
         Eval( ::bPainted )
      endif
	  
      AEval( ::aControls, { | oControl | oControl:Show() } )
      ::oMenu:Display()
      AEval( ::aWindows,  { | oWnd | oWnd:Display() } )
   else
      n = nLeft + ( ( nRight - nLeft + 1 ) / 2 ) - 2
      MBoxDisplay( nTop, n, nTop + 1, n + 4 )
      SayHot( nBottom, nLeft, ::cTitle,;
              nOr( nAnd( ::nClrNormal, 240 ),;
              If( ::lFocused, 15, 0 ) ) )
   endif

   DispEnd()
   MOn()

return nil

//----------------------------------------------------------------------------//

METHOD Maximize() CLASS TWindow

            if ::oSysMenu:nOption>0
            	::oSysMenu:Deactivate()
            end
 
   if ! ::lMaximized.and.lAnd(::nStyle,WND_LGROW)
      ::lMaximized = .t.
      if !::lMinimized
           ::nOldTop    = ::nTop
           ::nOldLeft   = ::nLeft
           ::nOldBottom = ::nBottom
           ::nOldRight  = ::nRight
      else
      	::lMinimized:=.f.
      end
      if ::lVisible
         MOff()
         DispBegin()
         ::Hide()
         ::nTop     = If( ::oWnd != nil, ::oWnd:GetClientTop(), 0 )
         ::nLeft    = If( ::oWnd != nil, ::oWnd:nLeft, 0 )
         ::nBottom  = If( ::oWnd != nil, ::oWnd:nBottom - 1, MaxRow() )
         ::nRight   = If( ::oWnd != nil, ::oWnd:nRight, MaxCol() )

         if ::oMenu != nil
            ::oMenu:ChangePos( ::nTop + 1, ::GetClientLeft() )
          endif

         ::Display()
         DispEnd()
         MOn()
      endif
      if ::bZoomed != nil
         Eval( ::bZoomed )
      endif
   endif

return nil

//----------------------------------------------------------------------------//

METHOD MouseMove( nRow, nCol ) CLASS TWindow

   local nWnd := If( ! Empty( ::aWindows ), ::nAtWindow( nRow, nCol ), 0 )
   local nCtrl

	If !::lMinimized
      if ::oMenu != nil
         if ::oMenu:lIsOver( nRow, nCol )
            SetMCursor( IDC_ARROW )
            return nil
         endif
      endif
     
      if nWnd != 0
         ::aWindows[ nWnd ]:MouseMove( nRow, nCol )
      else
         if ::oBar != nil
            if ::oBar:lIsOver( nRow, nCol )
               ::oBar:MouseMove( nRow, nCol )
               return nil
            endif
         endif
     
         if ( nCtrl := If( ! Empty( ::aControls ),;
            AScan( ::aControls,;
            { | oCtrl | oCtrl:lIsOver( nRow, nCol ) } ), 0 ) ) != 0
            ::aControls[ nCtrl ]:MouseMove( nRow, nCol )
         else
            if ! ::lMaximized.and.lAnd(::nStyle,WND_LGROW)
               do case
                  case nRow == ::nBottom .and. nCol >= ::nRight - 1
                       SetMCursor( IDC_SIZENWSE )
     
                  case nCol == ::nRight .and. nRow > ::nTop .and. nRow < ::nBottom
                       SetMCursor( IDC_SIZEWE )
     
                  case nRow == ::nBottom .and. nCol > ::nLeft .and. nCol < ::nRight
                       SetMCursor( IDC_SIZENS )
     
                  case nRow == ::nTop .and. nCol > ::nLeft + 1 .and. ;
                       nCol <= ::nRight - If( lAnd( ::nStyle, WND_LICONIZE ), 2, 0 ) - ;
                               If( lAnd( ::nStyle, WND_LZOOM ), 2, 0 )
                       SetMCursor( IDC_CROSS )
     
                  otherwise
                       SetMCursor( IDC_ARROW )
               endcase
            else
               SetMCursor( IDC_ARROW )
            endif
         endif
      endif
	end
return nil

//----------------------------------------------------------------------------//

METHOD Normal() CLASS TWindow

            ::lMInimized = .f.
            ::lMaximized = .f.
            if ::oSysMenu:nOption>0
            	::oSysMenu:Deactivate()
            end
            if ::lVisible
               MOff()
               DispBegin()
               ::Hide()
               ::nTop    = ::nOldTop
               ::nLeft   = ::nOldLeft
               ::nBottom = ::nOldBottom
               ::nRight  = ::nOldRight
               if ::oMenu != nil
                  ::oMenu:ChangePos( ::nTop + 1, ::GetClientLeft() )
               endif
               ::Display()
               DispEnd()
               MOn()
            endif


return nil

//----------------------------------------------------------------------------//

METHOD Activate( bWhen, bValid, bClicked, bIconized, bMoved,;
                 bPainted, bResized, bScrollUp, bScrollDown, bScrollLeft,;
                 bScrollRight, bZoomed, lNoWait ) CLASS TWindow

   local nKey, nMRow, nMCol, nSeconds
   local nOldMRow := 0, nOldMCol := 0
   local nLastClick := 0
   local nOldControl

   DEFAULT bWhen := bTrue, bValid := bTrue, lNoWait := .f.

   ::nCrsOldRow   = Row()
   ::nCrsOldCol   = Col()
   ::nCrsOldVal   = SetCursor( 0 )

   if Eval( ::bWhen )
      if ! ::lVisible
         ::lFocused = .t.
         ::Display()
      endif
   endif
	
	// en el caso de que el menu est‚ cerrado, si es que existe
	if !(::oMenu=nil.or.(::oMenu!=nil.and.::oMenu:lOpened))
	
   // en el caso en que existan controles, hay que activarlos no??
      if len(::aControls)>0
      	    nOldCOntrol:=::nFocus
      	    while !::aControls[ ::nFocus ]:lWhen()
             ::nFocus = If( ::nFocus < len(::aControls), ::nFocus + 1, 1 )
             if nOldControl=::nFocus
             	exit
             end
           enddo
       	  if ::aControls[::nFocus]:lWHen()
               ::aControls[ ::nFocus ]:SetFocus( .t. )
             end
      	end
   end
   ::lEnd   = .f.
   ::lModal = ! lNoWait

   if ! lNoWait
      while ! ::lEnd
      	  
         if ( nKey := nMKeyWait( 0, bClock ) ) == 0
		  	
            nMRow := nMRow()
            nMCol := nMCol()
            if lMPressed()
               nSeconds = Seconds() - nLastClick

               if nSeconds < 0.4 .and. ;
                  nMRow == nOldMRow .and. nMCol == nOldMCol
                  ::DblClick( nMRow, nMCol )
               else
                  nLastClick  = Seconds()
                  ::Click( nOldMRow := nMRow, nOldMCol := nMCol )
               endif
               while lMPressed() ; MUpdate() ; end


            else
               ::MouseMove( nMRow, nMCol )
            endif
         else
            ::KeyPressed( nKey )
         endif
         
      end
      ::Hide()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TWindow

   if ::oMenu != nil .and. ::oMenu:lOpened
      ::oMenu:DeActivate()
   endif

   ::lVisible = .f.
   MOff()
   RestScreen( ::nTop, ::nLeft, ::nBottom + 1, ::nRight + 2, ::cBack )
   ::cBack  = ""
   ::cImage = ""
   MOn()

return nil

//----------------------------------------------------------------------------//

METHOD DeActivate() CLASS TWindow

   ::Hide()
   SetPos( ::nCrsOldRow, ::nCrsOldCol )
   SetCursor( ::nCrsOldVal )

return nil

//----------------------------------------------------------------------------//

METHOD lIsOver(nRow,nCol) CLASS TWindow

  local lOver :=.f.
	
  if ::oMenu != nil
    lOver = ::oMenu:lIsover( nRow, nCol )
	end
  if ! lOver
    lOver = Super:lIsover( nRow, nCol )
	end
	
return lOver

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TWindow

   local nCtrlAt, nWndAt
   local nMRow, nMCol

   if ::lIsOver( nRow, nCol )
   	 if !::lMinimized
      if ::lAtBorder( nRow, nCol )
         do case
            case ::lAtClose( nRow, nCol )
                 if ::oMenu != nil
                    if ::oMenu:lIsOver( nRow, nCol )
                       if ! Empty( ::aControls )
                          ::aControls[ ::nFocus ]:SetFocus( .f. )
                       endif
                       ::oMenu:Click( nRow, nCol )
                    else
                       ::Close()
                    endif
                 else
                    ::Close()
                 endif

            case ::lAtMinBtn( nRow, nCol )
                 if ! ::lMinimized
                    ::Minimize()
                 endif

            case ::lAtMaxBtn( nRow, nCol )
                 if ! ::lMaximized
                    ::Maximize()
                 else
                    ::Normal()
                 endif

            case ::lAtTitle( nRow, nCol ) .and. ::lDrag.and.!::lMaximized
                 ::DragOver()

            case ::lAtResize( nRow, nCol ) .and.;
             !(::lminimized.or.::lMaximized)
            	 if ::oMenu!=nil
            	 	::oMenu:deactivate()
            	 end
               ::Resize()

         endcase
      else
         do case
            case ::oMenu != nil .and. ::oMenu:lIsOver( nRow, nCol )
                 ::oMenu:Click( nRow, nCol )

            case ( nWndAt := ::nAtWindow( nRow, nCol ) ) != 0
                 if ::oMenu != nil .and. ::oMenu:lOpened
                    ::oMenu:DeActivate()
                 endif
                 if nWndAt != Len( ::aWindows )
                    ::WndChange( nWndAt )
                 endif
                 ATail( ::aWindows ):Click( nRow, nCol )

            case ( nCtrlAt := ::nAtControl( nRow, nCol ) ) != 0
                 if ::oMenu != nil .and. ::oMenu:lOpened
                    ::oMenu:DeActivate()
                 endif
                 if nCtrlAt != ::nFocus
                    ::CtrlChange( nCtrlAt )
                 endif
                 if LMLeft()
                    ::aControls[ nCtrlAt ]:Click( nRow, nCol )
                 else
                    ::aControls[ nCtrlAt ]:RClick( nRow, nCol )
                 endif

            otherwise
                 if ::oMenu != nil .and. ::oMenu:nOption != 0
                    ::oMenu:DeActivate()
                 endif
                 ::Clicked( nRow, nCol )
         endcase
      endif
    else // est  minimizado
    	nMCol:=nMCol()
    	nMRow:=nMRow()
    	if ::oSysMenu#nil.and.::oSysMenu:nOption>0
    		::oSysMenu:Click(nmCol,nMRow)
    	else
    	::dragOver()
    	if (nMCol=nMCol().and.nMRow=nMRow()).and.::oSysMenu#nil
    		::oSysMenu:Activate()
    	end
    	end	
    	
	end 
   else
      Tone( 1000, 0.01 )
   endif

return nil

//----------------------------------------------------------------------------//

METHOD Clicked( nRow, nCol ) CLASS TWindow

   if ::bClicked != nil
      Eval( ::bClicked )
   endif

return nil

//----------------------------------------------------------------------------//

METHOD Say( nRow, nCol, cText, cColor, cPicture ) CLASS TWindow

   local nCrsOld := SetCursor( 0 )
   local nCrsRow := Row()
   local nCrsCol := Col()

   DEFAULT cColor := ::cColorSpec

   if cPicture == nil
      @ ::nTop + nRow, ::nLeft + nCol SAY cText COLOR cColor
   else
      @ ::nTop + nRow, ::nLeft + nCol SAY cText COLOR cColor PICTURE cPicture
   endif

   SetPos( nRow, nCol )
   SetCursor( nCrsOld )

return nil

//----------------------------------------------------------------------------//

METHOD lAtClose( nRow, nCol ) CLASS TWindow

   local lAt := .f.

   if lAnd( ::nStyle, WND_LCLOSE )
      if nRow == ::nTop .and. ;
         ( ::nLeft <= nCol .and. nCol <= ::nLeft + 1 )
         lAt = .t.
      endif
   endif

return lAt

//----------------------------------------------------------------------------//

METHOD lAtMaxBtn( nRow, nCol ) CLASS TWindow

   local lAt := .f.

   if lAnd( ::nStyle, WND_LZOOM )
      if nRow == ::nTop .and. ;
         ( nCol >= ::nRight - 1 .and. nCol <= ::nRight )
         lAt = .t.
      endif
   endif

return lAt

//----------------------------------------------------------------------------//

METHOD lAtMinBtn( nRow, nCol ) CLASS TWindow

   local lAt      := .f.
   local lIconize := lAnd( ::nStyle, WND_LICONIZE )
   local lZoom    := lAnd( ::nStyle, WND_LZOOM )

   if lIconize
      lAt = nRow == ::nTop .and. ;
            nCol <= ::nRight - If( lZoom, 2, 1 ) .and. ;
            nCol >= ::nRight - If( lZoom, 3, 1 )
   endif

return lAt

//----------------------------------------------------------------------------//

METHOD lAtResize( nRow, nCol ) CLASS TWindow

   local lAt := .f.

   if lAnd( ::nStyle, WND_LGROW ) .and. ! lAnd( ::nStyle, WND_LMAXIMIZED )
      if (nCol == ::nRight .and. nRow >= ::nTop .and. nRow <= ::nBottom) .or.;
         ( nRow == ::nBottom .and. nCol >= ::nLeft .and. nCol <= ::nRight)
         lAt = .t.
      endif
   endif

return lAt

//----------------------------------------------------------------------------//

METHOD lAtTitle( nRow, nCol ) CLASS TWindow

return nRow == ::nTop .and. nCol >= ::nLeft .and. nCol <= ::nRight

//----------------------------------------------------------------------------//

METHOD Close() CLASS TWindow

   if Eval( ::bValid )
      if ! ::lModal .and. ::oWnd != nil
         ::oWnd:Destroy( Self )
      endif
   endif

return nil

//----------------------------------------------------------------------------//

METHOD WndChange( nWindow ) CLASS TWindow

   local n       := Len( ::aWindows )
   local wndLast := ::aWindows[ n ]
   local wndNew  := ::aWindows[ nWindow ]

   MOff()
   DispBegin()

   while n >= nWindow
      ::aWindows[ n ]:Hide()
      n--
   end
   n++

   ADel( ::aWindows, nWindow )
   ::aWindows[ Len( ::aWindows ) ] = wndNew

   wndLast:SetFocus( .f. )
   wndNew:SetFocus( .t. )

   while n <= Len( ::aWindows )
      ::aWindows[ n ]:Display()
      n++
   end

   DispEnd()
   MOn()

return nil

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TWindow

   local nAt

 if !::lMinimized

   if ::oMenu != nil.and.nKey>0
      if ::oMenu:nOption != 0
         ::oMenu:KeyPressed( nKey )
         if ::oMenu:bAction != nil
            ::oMenu:DeActivate()
            Eval( ::oMenu:bAction )
            ::oMenu:bAction = nil
         endif
         return nil
      else
         if lKeyAlt()
            ::oMenu:KeyPressed( nKey )
         endif
      endif
   endif

   if Len( ::aWindows ) > 0
      ATail( ::aWindows ):KeyPressed( nKey )
   else
      do case
         case nKey == K_ESC
         	  if ::oMenu!=nil.and. ::oMenu:nOption!=0
         	  	   ::oMenu:deactivate()
				else         	  	
              ::End()
         	  end
			   return 0
         case nKey == K_TAB
              ::NextControl()
			   return 0

         case nKey == K_SH_TAB
              ::PrevControl()
			   return 0

         otherwise
              if ! Empty( ::aControls )
                 if ( nKey := ::aControls[ ::nFocus ]:KeyPressed( nKey ) ) != 0
                    do case
                       case nKey == K_LEFT .or. nKey == K_UP
                            ::PrevControl()
			    			   return 0

                       case nKey == K_RIGHT .or. nKey == K_DOWN .or. ;
                            nKey == K_ENTER
                            ::NextControl()
			    			   return 0

                       case nKey >= 0 .and. nKey <= 255
                            if ( nAt := ::nHotCtrl( nKey ) ) != 0
                               ::ChangeFocus( ::aControls[ nAt ] )
                               ::aControls[ nAt ]:KeyPressed( nKey )
                            endif
                    endcase
                 endif
              endif
      endcase
   endif
 else
  if ::lMinimized
  	if nKey=13.and.!::oSysMenu:nOption>0
  		::oSysMenu:Activate()
  	elseif ::oSysMenu:nOption>0
  		::oSysMenu:KeyPressed(nKey)
  	
  	end
  	// pinta el menu del systema
  end
 end
  

return nil

//----------------------------------------------------------------------------//

METHOD Destroy( oWnd ) CLASS TWindow

   local aWindows := ::aWindows
   local nAt      := AScan( aWindows, { | oWindow | oWindow == oWnd } )
   local n        := Len( aWindows )

   MOff()
   DispBegin()
   while n >= nAt
      aWindows[ n-- ]:Hide()
   end
   ADel( aWindows, nAt )
   ASize( aWindows, Len( aWindows ) - 1 )
   if Len( aWindows ) > 0
      while n < Len( aWindows )
         aWindows[ n++ ]:Show()
      end
   endif
   DispEnd()
   MOn()

return nil

//----------------------------------------------------------------------------//

METHOD Minimize() CLASS TWindow
   if lAnd(::nStyle,WND_LGROW).and.!::lMinimized
      ::nOldTop    = ::nTop
      ::nOldLeft   = ::nLeft
      ::nOldBottom = ::nBottom
      ::nOldRight  = ::nRight
     
      ::Hide()
     
      ::nTop       = MaxRow() - 4
      ::nLeft      = 5
      ::nBottom    = ::nTop + 2
      ::nRight     = ::nLeft + Len( ::cTitle ) - 1
      ::lMinimized = .t.
     
      ::Display()
   end
return nil

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TWindow

   ::lFocused  = lOnOff
   ::nClrTitle = If( lOnOff, 240, 248 )
   if ::oMenu#Nil
   	::oMenu:Deactivate()
   end
return nil

//----------------------------------------------------------------------------//

METHOD GenCode() CLASS TWindow

  local cCode := ""

  cCode += "   DEFINE WINDOW " + ::cVarName
  cCode += " FROM " + cValToChar( ::nTop    - If( ::oWnd != nil, ::oWnd:GetClientTop(), 0 ) )
  cCode += ", "     + cValToChar( ::nLeft   - If( ::oWnd != nil, ::oWnd:nLeft, 0 ) )
  cCode += " TO "   + cValToChar( ::nBottom - If( ::oWnd != nil, ::oWnd:GetClientTop(), 0 ) )
  cCode += ", "     + cValToChar( ::nRight  - If( ::oWnd != nil, ::oWnd:nLeft, 0 ) )
  cCode += " ;" + CRLF
  cCode += '      TITLE "' + ::cTitle + '"'

  AEval( ::aControls,;
         { | oCtrl | cCode += CRLF + CRLF + oCtrl:GenCode() } )

  cCode += CRLF + CRLF + "   ACTIVATE WINDOW " + ::cVarName

return cCode

//----------------------------------------------------------------------------//

METHOD NextControl() CLASS TWindow
   local nOLdFocus

   if Len( ::aControls ) > 0
      if ::aControls[ ::nFocus ]:lValid()
         ::aControls[ ::nFocus ]:SetFocus( .f. )
      endif
	  nOldFocus:=::nFocus

      DO
         ::nFocus = If( ::nFocus < Len( ::aControls ), ::nFocus + 1, 1 )
      UNTIL ::aControls[ ::nFocus ]:lWhen().or.nOldFocus=::nFocus

	  if ::aControls[ ::nFocus ]:lWhen()
          ::aControls[ ::nFocus ]:SetFocus( .t. )
      end
   endif

return nil

//----------------------------------------------------------------------------//

METHOD PrevControl() CLASS TWindow
   local nOLdFocus
   if Len( ::aControls ) > 0
      if ::aControls[ ::nFocus ]:lValid()
         ::aControls[ ::nFocus ]:SetFocus( .f. )
      endif
      
	  nOldFocus:=::nFocus
      DO
         ::nFocus = If( ::nFocus > 1, ::nFocus - 1, Len( ::aControls ) )
      UNTIL ::aControls[ ::nFocus ]:lWhen().or.nOldFocus=::nFocus 
      
	  if ::aControls[ ::nFocus ]:lWhen()
          ::aControls[ ::nFocus ]:SetFocus( .t. )
      end
   endif

return nil

//----------------------------------------------------------------------------//

METHOD End() CLASS TWindow

   ::lEnd = .t.

   if ! Empty( ::aControls )
      ::aControls[ ::nFocus ]:SetFocus( .f. )
   endif

   if ::oSysMenu:nOption>1
   	::oSysMenu:deactivate()
   end
   if ! ::lModal
      ::Close()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD nHotCtrl( nKey ) CLASS TWindow

return AScan( ::aControls,;
       { | oCtrl | Upper( oCtrl:cGetHotKey() ) == Upper( Chr( nKey ) ) } )

//----------------------------------------------------------------------------//

METHOD ChangeFocus( oCtrl ) CLASS TWindow

   if ! Empty( ::aControls )
      if Eval( ::aControls[ ::nFocus ]:bValid ) .and. Eval( oCtrl:bWhen )
         ::aControls[ ::nFocus ]:SetFocus( .f. )
         ::nFocus = AScan( ::aControls, { | oControl | oCtrl == oControl } )
         ::aControls[ ::nFocus ]:SetFocus( .t. )
      endif
   endif

return nil

//----------------------------------------------------------------------------//

METHOD ChangePos( nRow, nCol ) CLASS TWindow

   local n, oControl
   local nOldRow := ::nTop
   local nOldCol := ::nLeft

	Super:ChangePos( nRow, nCol)
	
   if ! ::lMinimized
      if ::oBar != nil
         ::oBar:ChangePos( ::nTop + 1, ::nLeft )
      endif

      if ! Empty( ::aControls )
         for n = 1 to Len( ::aControls )
             oControl = ::aControls[ n ]
             oControl:ChangePos( oControl:nTop  - nOldRow + ::nTop,;
                                 oControl:nLeft - nOldCol + ::nLeft )
         next
      endif

      if ::oMenu != nil
         ::oMenu:ChangePos( ::nTop +1 , ::GetClientLeft() )
      endif
      if ::oSysMenu:nOption>0
      	::oSysMenu:Deactivate()
      end
   endif

return nil

//----------------------------------------------------------------------------//

METHOD GenRC() CLASS TWindow

   local cRC := ""

   cRC += '#include "FivePro.ch"' + CRLF + CRLF

   cRC += ::cVarName + " DIALOG " + Str( ::nLeft * 4, 3 ) + "," + ;
          Str( ::nTop * 12, 3 ) + "," + ;
          Str( ( ::nRight - ::nLeft + 1 ) *  4, 3 ) + "," + ;
          Str( ( ::nBottom - ::nTop + 1 ) * 12, 3 ) + CRLF
   cRC += 'CAPTION "' + ::cTitle + '"' + CRLF
   cRC += "BEGIN" + CRLF

   AEval( ::aControls, { | oCtrl, n | cRC += oCtrl:GenRC( n * 10 ) } )

   cRC += "END" + CRLF + CRLF

   if ::oMenu != nil
      cRC += ::oMenu:GenRC()
   endif

return cRC

//----------------------------------------------------------------------------//

METHOD DblClick( nRow, nCol ) CLASS TWindow

   local nAt

   if ::lMinimized
      ::Normal()
   else
      do case
         case ( nAt := ::nAtWindow( nRow, nCol ) ) != 0
              ::aWindows[ nAt ]:DblClick( nRow, nCol )

         case ( nAt := ::nAtControl( nRow, nCol ) ) != 0
              ::aControls[ nAt ]:DblClick( nRow, nCol )
      endcase
   endif

return nil

//----------------------------------------------------------------------------//

METHOD Cascade() CLASS TWindow

   local n
   local nRow := ::GetClientTop()
   local nCol := 0
   local oWnd

   if ! Empty( ::aWindows )
      if ! ATail( ::aWindows ):lMaximized
         MOff()
         DispBegin()
         for n = Len( ::aWindows ) to 1 step -1
            ::aWindows[ n ]:Hide()
         next
         for n = 1 to Len( ::aWindows )
             oWnd = ::aWindows[ n ]
             if ! oWnd:lMinimized
                oWnd:ChangePos( nRow++, nCol )
                nCol += 2
             endif
             oWnd:Show()
         next
         DispEnd()
         MOn()
      endif
   endif

return nil

//----------------------------------------------------------------------------//

METHOD nAtWindow( nRow, nCol ) CLASS TWindow

return RAScan( ::aWindows, { | oWnd | oWnd:lIsOver( nRow, nCol ) } )

//----------------------------------------------------------------------------//

METHOD nAtControl( nRow, nCol ) CLASS TWindow

return RAScan( ::aControls, { | oCtrl | oCtrl:lIsOver( nRow, nCol ) } )

//----------------------------------------------------------------------------//

METHOD CtrlChange( nCtrl ) CLASS TWindow

   local n
   local nOLdFocus

   if ::aControls[ nCtrl ]:lDrag

      n = Len( ::aControls )

      MOff()

      while n >= ::nFocus
         ::aControls[ n-- ]:Hide()
      end
      ::aControls[ ++n ]:SetFocus( .f. )

      if n < nCtrl
         while n < nCtrl
            ::aControls[ n++ ]:Show()
         end
      else
         while n > nCtrl
            ::aControls[ n-- ]:Hide()
         end
      endif

      ::aControls[ n ]:SetFocus( .t. )

      while n <= Len( ::aControls )
         ::aControls[ n++ ]:Show()
      end

      MOn()
     ::nFocus = nCtrl

   else
   if Len( ::aControls ) > 0
      if ::aControls[ ::nFocus ]:lValid()
         ::aControls[ ::nFocus ]:SetFocus( .f. )
      endif
      ::nFocus:=nCtrl
	  nOldFocus:=::nFocus
      while !::aControls[ ::nFocus ]:lWhen()
          ::nFocus = If( ::nFocus < len(::aControls), ::nFocus + 1, 1 )
          if nOldFocus=::nFocus
          	exit
          end
	  enddo
	  if ::aControls[::nFocus]:lWHen()
	      ::aControls[ ::nFocus ]:SetFocus( .t. )
	  end
   endif

   endif


return nil

//----------------------------------------------------------------------------//

Method AddControl(oCtrl) class TWindow
	AAdd( ::aControls, oCtrl )
	oCtrl:oWnd := Self
	if oCtrl:nBottom>::nMinH+::nTop
		::nMinH:=oCtrl:nBottom-::nTop+2
	end
	if oCtrl:nRight>::nMinW+::nLeft
		::nMinW:=oCtrl:nRight-::nLeft+2
	end
  return nil

//----------------------------------------------------------------------------//

// metodo move reescrito para desactivar los menus ( si estubieran activos..

METHOD Move( nRow, nCol ) CLASS TWindow

   local lWasVisible := ::lVisible

   MOff()
   DispBegin()
   if ::lVisible
      if ::oMenu!=nil
      		::oMenu:Deactivate()
      end
      ::Hide()
   endif
   ::ChangePos( nRow, nCol )
   if lWasVisible
      ::Show()
      ::SetFocus( .t. )
   endif
   DispEnd()
   MOn()

return nil
