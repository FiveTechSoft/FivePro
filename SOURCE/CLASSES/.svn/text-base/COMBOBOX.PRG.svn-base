#include "objects.ch"
#include "inkey.ch"

//----------------------------------------------------------------------------//

CLASS ComboBox FROM Edit

   DATA cClrOpened
   DATA oListBox
   DATA lOpened

   METHOD New( nRow, nCol, nLen, cText, nId, cLabel, cMessage  )
   METHOD Display( )
   METHOD Hide( )
   METHOD KeyPressed( nKey  )
   METHOD Click( nMRow, nMCol  )
   METHOD DblClick( nMRow, nMCol  )
   METHOD lIsOver( nRow, nCol  )
   METHOD SetFocus( lOnOff, cClrFocus  )
   METHOD LbxSelect( oLbx  )
   METHOD LbxChanged( oLbx  )
   METHOD LbxChoosed( oLbx  )
   METHOD Open( )
   METHOD Close( )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD ComboBox::New( nRow, nCol, nLen, cText, nId, cLabel, cMessage )

   DEFAULT cLabel:= "&ComboBox"

   ::Parent:New( nRow, nCol, nLen, cText, nId, cLabel, cMessage )

   ::nRight++
   ::oListBox = ListBox():New( 1, 0, 5, ::nRight - ::nLeft, "", 0, "" )
   ::oListBox:oLabel   = nil
   ::oListBox:cMessage = nil
   ::oListBox:oParent  = Self
   ::lOpened           = .f.
   ::cClrOpened        = "BG+/BG"

return Self

//----------------------------------------------------------------------------//

METHOD Display() CLASS TComboBox

   SetCursor( 0 )
   MOff()
   @ ::nAbsTop(), ::nAbsLeft() + ::nLen + 2 ;
     SAY If( ::lOpened, Chr( 30 ), Chr( 31 ) ) COLOR "BG+/B"
   MOn()
   ::Parent:Display()

return

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TComboBox

   if ::lOpened
      ::Close()
   endif
   ::Parent:Hide()

return

//----------------------------------------------------------------------------//

METHOD ComboBox::KeyPressed( nKey )

   do case
      case nKey == K_ESC
           if ::lOpened
              ::Close()
           endif

      case nKey == K_ENTER .and. ::lOpened
           ::SetText( ::oListBox:acItems[ ::oListBox:nOption ] )
           ::Close()

      case ::lOpened
           ::oListBox:KeyPressed( nKey )

      case nKey == K_DOWN
           ::Open()

      otherwise
           ::Parent:KeyPressed( nKey )
   endcase

return

//----------------------------------------------------------------------------//

METHOD ComboBox::Click( nMRow, nMCol )

   if ::lOpened
      if ::oListBox:lIsOver( nMRow, nMCol )
         ::oListBox:Click( nMRow, nMCol )
      else
         if nMRow == ::nAbsTop() .and. ;
            nMCol == ::nAbsLeft() + ::nRight - ::nLeft
            ::Close()
         endif
      endif
   else
      if nMRow == ::nAbsTop() .and. nMCol == ::nAbsLeft() + ::nRight - ::nLeft
         ::Open()
      else
         ::Parent:Click( nMRow, nMCol )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD ComboBox::DblClick( nMRow, nMCol )

   if ::lOpened
      if ::oListBox:lIsOver( nMRow, nMCol )
         ::oListBox:DblClick( nMRow, nMCol )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD ComboBox::lIsOver( nRow, nCol )

   local lIsOver := .f.

   if ::lOpened
      lIsOver = ::oListBox:lIsOver( nRow, nCol )
   endif

   if ! lIsOver
      lIsOver = ::Parent:lIsOver( nRow, nCol )
   endif

return lIsOver

//----------------------------------------------------------------------------//

METHOD ComboBox::SetFocus( lOnOff, cClrFocus )

   if ! lOnOff .and. ::lOpened
      ::Close()
   endif
   ::Parent:SetFocus( lOnOff, cClrFocus )

return

//----------------------------------------------------------------------------//

METHOD ComboBox::LbxSelect( oLbx )
return

//----------------------------------------------------------------------------//

METHOD ComboBox::LbxChanged( oLbx )
return

//----------------------------------------------------------------------------//

METHOD ComboBox::LbxChoosed( oLbx )

   ::SetText( ::oListBox:acItems[ ::oListBox:nOption ] )
   ::Close()
   if ::oParent != nil
      ::oParent:CbxSelect( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD ComboBox::Open()

   local nMCrsOld := SetMCursor()

   if ! ::lOpened
      ::lOpened = .t.
      SetCursor( 0 )
      SetMCursor( 0 )
      @ ::nAbsTop(), ::nAbsLeft() SAY " " COLOR ::cClrNormal
      @ ::nAbsTop(), ::nAbsLeft() + ::nLen + 1 SAY " " COLOR ::cClrNormal
      @ ::nAbsTop(), ::nAbsLeft() + 1 ;
        SAY SubStr( ::cText, ::nStartCol, ::nLen ) COLOR ::cClrOpened
      @ ::nAbsTop(), ::nAbsLeft() + ::nRight - ::nLeft ;
        SAY Chr( 30 ) COLOR "BG+/B"
      ::oListBox:Show()
      ::oListBox:SetFocus( .t., ::cClrFocus )
      SetMCursor( nMCrsOld )
   endif

return

//----------------------------------------------------------------------------//

METHOD ComboBox::Close()

   local nMCrsOld := SetMCursor()

   if ::lOpened
      ::lOpened = .f.
      ::oListBox:Hide()
      SetMCursor( 0 )
      @ ::nAbsTop(), ::nAbsLeft() + ::nLen + 2 ;
        SAY Chr( 31 ) COLOR "BG+/B"
      ::BufDisplay()
      SetMCursor( nMCrsOld )
   endif

return

//----------------------------------------------------------------------------//
