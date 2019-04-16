#include "objects.ch"
#include "inkey.ch"

//----------------------------------------------------------------------------//

CLASS CbMenu FROM Menu

   DATA oLabel
   DATA lHorizontal

   METHOD New( nRow, nCol, cLabel, nId, cMessage, lHorizontal  )
   METHOD AddItem( cText  )
   METHOD Display( )
   METHOD Hide( )
   METHOD lIsOver( nRow, nCol  )
   METHOD SetFocus( lOnOff, cClrFocus  )
   METHOD KeyPressed( nKey  )
   METHOD Click( nMRow, nMCol  )
   METHOD cGetHotKey( )
   METHOD CbtChanged( oCheckBtn  )
   METHOD SetValue( nItem, lOnOff  )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD CbMenu::New( nRow, nCol, cLabel, nId, cMessage, lHorizontal )

   DEFAULT nRow:= 0, nCol:= 0, cLabel:= "&CbMenu", nId:= 0, lHorizontal:= .f.

   ::Parent:New()

   ::nTop            = nRow
   ::nLeft           = nCol
   ::nBottom         = nRow
   ::nRight          = nCol
   ::oLabel          = Label():New( -1, 0, cLabel )
   ::oLabel:cMessage = nil
   ::oLabel:oParent  = Self
   ::nId             = nId
   ::cMessage        = cMessage
   ::lHorizontal     = lHorizontal
   ::cClrNormal      = "N/BG"
   ::cClrFocus       = "W+/N"
   ::nOption         = 1

return Self

//----------------------------------------------------------------------------//

METHOD CbMenu::AddItem( cText )

   local oLastItem := ATail( ::aItems )
   local oNewItem  := CheckBtn():New( 0, 0, cText, 0 )
   local nMaxWidth := 0

   if ::lHorizontal
      oNewItem:Move( 0,;
                     If( oLastItem != nil,;
                     oLastItem:nLeft + nLabelLen( oLastItem:cText ) + 5, 0 ) )
      ::nRight += nLabelLen( oNewItem:cText )
   else
      oNewItem:Move( If( oLastItem != nil, oLastItem:nTop + 1, 0 ), 0 )
      ::nBottom++
      ::nRight = ::nLeft + Max( ::nRight - ::nLeft,;
                                nLabelLen( oNewItem:cText ) )
   endif

   oNewItem:cClrNormal = "N/BG"
   oNewItem:cClrFocus  = ::cClrFocus
   oNewItem:cMessage   = nil
   ::Parent:AddItem( oNewItem )

   if ! ::lHorizontal
      AEval( ::aItems,;
          { | oItem | nMaxWidth := Max( nMaxWidth, nLabelLen( oItem:cText ) ) } )
      AEval( ::aItems,;
          { | oItem | oItem:SetText( PadR( oItem:cText, nMaxWidth + ;
          If( At( "&", oItem:cText ) != 0, 1, 0 ) ) ) } )
   endif

return

//----------------------------------------------------------------------------//

METHOD CbMenu::Display()

   if ::oLabel != nil
      ::oLabel:Show()
   endif
   ::lActive = .T.
   ::Parent:Display()

return

//----------------------------------------------------------------------------//

METHOD CbMenu::Hide()

   if ::oLabel != nil
      ::oLabel:Hide()
   endif
   ::lActive = .f.
   ::Parent:Hide()

return

//----------------------------------------------------------------------------//

METHOD CbMenu::lIsOver( nRow, nCol )

   local lIsOver := If( ::oLabel != nil, ::oLabel:lIsOver( nRow, nCol ), .f. )

   if ! lIsOver
      lIsOver = ::Parent:lIsOver( nRow, nCol )
   endif

return lIsOver

//----------------------------------------------------------------------------//

METHOD CbMenu::SetFocus( lOnOff, cClrFocus )

   if ::oLabel != nil
      ::oLabel:SetFocus( lOnOff, cClrFocus )
   endif
   ::Parent:SetFocus( lOnOff, cClrFocus )

return

//----------------------------------------------------------------------------//

METHOD CbMenu::KeyPressed( nKey )

   do case
      case nKey == 32 .or. nKey == K_ENTER
           if ::nOption != 0
              ::aItems[ ::nOption ]:KeyPressed( nKey )
           endif

      otherwise
           ::Parent:KeyPressed( nKey )
   endcase

return

//----------------------------------------------------------------------------//

METHOD CbMenu::Click( nMRow, nMCol )

   ::Parent:Click( nMRow, nMCol )
   if ::nOption != 0
      if ::aItems[ ::nOption ]:lIsOver( nMRow(), nMCol() )
         ::aItems[ ::nOption ]:KeyPressed( 32 )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD  CbMenu::cGetHotKey()

return If( ::oLabel != nil, ::oLabel:cGetHotKey(), "" )

//----------------------------------------------------------------------------//

METHOD CbMenu::CbtChanged( oCheckBtn )

   if ::oParent != nil
      ::oParent:CbmChanged( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD CbMenu::SetValue( nItem, lOnOff )

   ::aItems[ nItem ]:lChecked = lOnOff
   ::aItems[ nItem ]:Display()

return

//----------------------------------------------------------------------------//
