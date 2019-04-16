#include "objects.ch"
#include "inkey.ch"

//----------------------------------------------------------------------------//

CLASS ComboBox FROM Tview

   DATA cClrOpened
   DATA oListBox
   DATA oGet
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

METHOD ComboBox.New( nRow, nCol, bSETGET, acItems, nWidth, nHeight, ;
			 oWnd,bValid,bWhen,cPicture,cLabel,cMsg )
 
   ::oGet:=New( 0, 0, bSetGet, , cLabel, cMsg, cPicture,;
               oWnd, bWhen, bValid )
   
   
   ::lDrag:=.f.
   ::oListBox = ListBox():New( nRow, nCol, nWidth, nHeight, bSetGet, acItems,;
            cLabel, cMsg, oWnd)
   ::oListBox:oLabel   = nil
   ::oListBox:cMessage = nil
   ::oListBox:oParent  = Self
   ::lOpened           = .f.
   ::cClrOpened        = "BG+/BG"

RETURN nil

//----------------------------------------------------------------------------//

METHOD Display() CLASS TComboBox

   SetCursor( 0 )
   MOff()
	::oget:Display()
	if ::lOpened
		::oListbox:Display()
	end	
	@ ::nTop , ::nLeft-1 say Chr( 210 ) + Chr( 186 ) 
   MOn()

RETURN nil

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TComboBox

   if ::lOpened
      ::oListBox:Hide()
   endif
   ::oGet:Hide()

RETURN nil

//----------------------------------------------------------------------------//

METHOD ComboBox.KeyPressed( nKey )

   do case
      case nKey == K_ESC
           if ::lOpened
              ::oListBox:Close()
              nkey:=0
           endif

      case nKey == K_ENTER .and. ::lOpened
           ::SetText( ::oListBox:acItems[ ::oListBox:nOption ] )
           ::oListBox:Hide()
			nKey:=0
      case ::lOpened
           nKey:=::oListBox:KeyPressed( nKey )

      case nKey == K_DOWN
      		::lOpened:=.t.
           ::oListBox:SetFocus(.t.)
           nKey:=0

      otherwise
           nKey:=::oGet:KeyPressed( nKey )
   endcase

RETURN nKey

//----------------------------------------------------------------------------//

METHOD ComboBox.Click( nMRow, nMCol )

   if ::lOpened
      if ::oListBox:lIsOver( nMRow, nMCol )
         ::oListBox:Click( nMRow, nMCol )
      else
         if nMRow == ::nTop .and. ;
            nMCol >= ::nRight .and.nMcol <= ::nLeft
            ::oListBox:Hide()
         endif
      endif
   else
      if nMRow == ::nTop() .and. (nMCol == ::nLeft .or. nMCol==::nLeft-1)
         ::oListBox:Hise()
      else
         ::Get:Click( nMRow, nMCol )
      endif
   endif

RETURN nil

//----------------------------------------------------------------------------//

METHOD ComboBox.DblClick( nMRow, nMCol )

   if ::lOpened
      if ::oListBox:lIsOver( nMRow, nMCol )
         ::oListBox:DblClick( nMRow, nMCol )
      endif
   endif

RETURN nil

//----------------------------------------------------------------------------//

METHOD ComboBox.lIsOver( nRow, nCol )

   local lIsOver := .f.

   if ::lOpened
      lIsOver = ::oListBox:lIsOver( nRow, nCol )
   endif

   if ! lIsOver
      lIsOver = ::oGet:lIsOver( nRow, nCol )
   endif

RETURN lIsOver

//----------------------------------------------------------------------------//

METHOD ComboBox.SetFocus( lOnOff, cClrFocus )

   if ! lOnOff .and. ::lOpened
      ::oListBox:Hide()
   endif
   ::oGet:SetFocus( lOnOff, cClrFocus )

RETURN nil

//----------------------------------------------------------------------------//
