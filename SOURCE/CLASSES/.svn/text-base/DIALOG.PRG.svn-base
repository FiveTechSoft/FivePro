#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TDialog FROM TWindow

   DATA   aControls
   DATA   nControl
   DATA   oMenu

   METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColors, oMenu,;
               oBrowse, oWnd ) CONSTRUCTOR
   METHOD AddControl( oControl )
   METHOD nAtControl( nRow, nCol )
   METHOD nCtrlHot( nKey )
   METHOD Click( nRow, nCol )
   METHOD DblClick( nMRow, nMCol )
   METHOD Display()
   METHOD Hide()
   METHOD KeyPressed( nKey )
   METHOD SetFocus( lOnOff, cColor )
   METHOD ChangeFocus( oControl )
   METHOD pbtDefault()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, cTitle, cColors, oMenu, oBrowse,;
            oWnd ) CLASS TDialog

   DEFAULT nTop:= 0, nLeft:= 0, nBottom:= MaxRow(), nRight:= MaxCol(),;
           cTitle:= ""

   Super:New( nTop, nLeft, nBottom, nRight, cTitle )

   ::aControls = {}
   ::nControl  = 0
   ::cClrFocus = "W+/W"
   ::oMenu     = oMenu
   ::oBrowse   = oBrowse
   ::oParent   = oWnd

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

   SetBlink( .f. )

return

//----------------------------------------------------------------------------//

METHOD AddControl( oControl ) CLASS TDialog

   AAdd( ::aControls, oControl )
   oControl:oParent = Self
   if ::nControl == 0
      ::nControl++
   endif

return

//----------------------------------------------------------------------------//

METHOD nAtControl( nRow, nCol ) CLASS TDialog

return AScan( ::aControls,;
              { | oControl | oControl:lIsOver( nRow, nCol ) } )

//----------------------------------------------------------------------------//

METHOD nCtrlHot( nKey ) CLASS TDialog

return AScan( ::aControls,;
       { | oCtrl | cAlt2Chr( nKey ) == Upper( oCtrl:cGetHotKey ) .and. ;
       oCtrl:lActive } )

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TDialog

   local nAtControl
   local pbtDefault

   do case
      case lKeyAlt() .and. At( Chr( nKey ), "\|@#{[]}" ) == 0
           nAtControl = ::nCtrlHot( nKey )
           if nAtControl != 0 .and. nAtControl != ::nControl
              ::aControls[ ::nControl ]:SetFocus( .f., ::cClrFocus )
              ::nControl = nAtControl
              ::aControls[ ::nControl ]:SetFocus( .t., ::cClrFocus )
              if ::aControls[ ::nControl ]:ClassName() == "PUSHBUTTON"
                 ::aControls[ ::nControl ]:KeyPressed( 32 )
              endif
           endif

      case nKey == K_ESC
           do case
              case Len( ::aControls ) > 0
                   if ::aControls[ ::nControl ]:ClassName() == "COMBOBOX"
                      if ::aControls[ ::nControl ]:lOpened
                         ::aControls[ ::nControl ]:KeyPressed( K_ESC )
                      else
                         ::EndExec()
                      endif
                   else
                      ::EndExec()
                   endif

              otherwise
                   ::EndExec()
           endcase

      case nKey == K_ENTER
           pbtDefault = ::pbtDefault()
           if pbtDefault != nil
              pbtDefault:KeyPressed( K_ENTER )
           else
              ::aControls[ ::nControl ]:KeyPressed( K_ENTER )
           endif

      case nKey == K_TAB
           if Len( ::aControls ) > 1
              ::aControls[ ::nControl ]:SetFocus( .f. )
              ::nControl++
              if ::nControl > Len( ::aControls )
                 ::nControl = 1
              endif
              do while ! ::aControls[ ::nControl ]:lActive
                 ::nControl++
                 if ::nControl > Len( ::aControls )
                    ::nControl = 1
                 endif
              enddo
              ::aControls[ ::nControl ]:SetFocus( .t., "w+/b" )
           endif

      case nKey == K_SH_TAB
           if Len( ::aControls ) > 1
              ::aControls[ ::nControl ]:SetFocus( .f. )
              ::nControl--
              if ::nControl < 1
                 ::nControl = Len( ::aControls )
              endif
              do while ! ::aControls[ ::nControl ]:lActive
                 ::nControl--
                 if ::nControl < 1
                    ::nControl = Len( ::aControls )
                 endif
              enddo
              ::aControls[ ::nControl ]:SetFocus( .t., "w+/b" )
           endif

      otherwise
           if ::oMenu != nil
              ::oMenu:Process( nKey )
           else
              if Len( ::aControls ) != 0
                 ::aControls[ ::nControl ]:KeyPressed( nKey )
              endif
           endif

   endcase

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff, cColor ) CLASS TDialog

   Super:SetFocus( lOnOff, cColor )

   if Len( ::aControls ) != 0
      if ! ::aControls[ ::nControl ]:lFocused
         ::aControls[ ::nControl ]:SetFocus( lOnOff, cColor )
      endif
   endif

   if ! Empty( ::cTitle )
      @ ::nAbsTop(), ::nAbsLeft() SAY PadC( ::cTitle, ::nRight - ::nLeft + 1 ) ;
         COLOR If( lOnOff, "N*/W", "N/W" )
      if ::lCloseable
         @ ::nAbsTop(), ::nAbsLeft() SAY "þ" COLOR If( lOnOff, "N*/W", "N/W" )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD ChangeFocus( oControl ) CLASS TDialog

   local nAt := AScan( ::aControls, { | oCtrl | oCtrl == oControl } )

   if nAt != ::nControl
      ::aControls[ ::nControl ]:SetFocus( .f., ::cClrFocus )
      ::nControl = nAt
      ::aControls[ ::nControl ]:SetFocus( .t., ::cClrFocus )
   endif

return

//----------------------------------------------------------------------------//

METHOD pbtDefault() CLASS TDialog

   local pbtDefault
   local n := 1

   do while n <= Len( ::aControls ) .and. pbtDefault == nil
      if ::aControls[ n ]:ClassName() == "PUSHBUTTON"
         if ::aControls[ n ]:lActive .and. ::aControls[ n ]:lDefault
            pbtDefault = ::aControls[ n ]
         endif
      endif
      n++
   enddo

return pbtDefault

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TDialog

   local nAt

   if ::lDrag
      ::DragOver()
   else
      if ::oMenu != nil
         if ::oMenu:lIsOver( nRow, nCol )
            ::oMenu:Click( nRow, nCol )
         endif
      endif

      if ( nAt := ::nAtControl( nRow, nCol ) ) != 0
         if ::aControls[ nAt ]:lActive
            if nAt != ::nControl
               ::aControls[ ::nControl ]:SetFocus( .f. )
               ::nControl = nAt
               ::aControls[ ::nControl ]:SetFocus( .t., "W+/B" )
            endif
            ::aControls[ ::nControl ]:Click( nRow, nCol )
         endif
      else
         Super:Click( nRow, nCol )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD DblClick( nMRow, nMCol ) CLASS TDialog

   if Len( ::aControls ) > 0
      if ::aControls[ ::nControl ]:lIsOver( nMRow, nMCol )
         ::aControls[ ::nControl ]:DblClick( nMRow, nMCol )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TDialog

   Super:Display()
   if Len( ::aControls ) > 0
      AEval( ::aControls, { | oControl | oControl:Show() } )
   endif
   if ::oMenu != nil
      ::oMenu:Display()
   endif
   if ::oBrowse != nil
      while ! ::oBrowse:Stabilize
      end
   endif

return

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TDialog

   AEval( ::aControls, { | oControl | oControl:Hide() } )
   Super:Hide()

return

//----------------------------------------------------------------------------//
