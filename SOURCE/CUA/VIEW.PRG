#include "FivePro.ch"

// modificado por CGR Wed 13-04-1994 10:35:33 am
// objetivo: corregir un buf al pulsar con el rat¢n 
// al mover la ventana principal

static bTrue := { || .t. }

//----------------------------------------------------------------------------//

CLASS TView

   DATA   bWhen, bValid, bClicked, bMoved
   DATA   cBack, cMsg, cVarName
   DATA   lActive, lDrag, lEndExec, lFocused, lVisible
   DATA   nTop, nLeft, nBottom, nRight
   DATA   nClrNormal, nClrFocus
   DATA   oWnd, oLabel
   DATA   nMinW, nMinH // ancho y alto minimos
   DATA   Cargo

   METHOD New( nTop, nLeft, nBottom, nRight, oWnd ) CONSTRUCTOR
   METHOD Show()

   METHOD Adjust() VIRTUAL

   METHOD Click( nMRow, nMCol )

   METHOD RClick( nRow, nCol ) VIRTUAL
   METHOD DblClick( nMRow, nMCol ) VIRTUAL

   METHOD Display() VIRTUAL

   METHOD End() INLINE ::lEnd := .t.

   METHOD Exec()
   METHOD Hide()
   METHOD Init() VIRTUAL
   METHOD lIsOver( nRow, nCol )

   METHOD DragOver()
   METHOD KeyPressed( nKey )

   METHOD MouseMove( nRow, nCol )

   METHOD SetFocus( lOnOff )
   METHOD Move( nRow, nCol )
   METHOD ChangePos( nRow, nCol )

   METHOD cGetHotKey() INLINE If( ::oLabel != nil, ::oLabel:cGetHotKey(), "" )

   METHOD GenCode() INLINE ""
   METHOD GenRC()   INLINE ""

   METHOD lValid() INLINE If( ::bValid != nil, Eval( ::bValid ), .t. )
   METHOD lWhen()  INLINE If( ::bWhen != nil, Eval( ::bWhen ), .t. )

   METHOD GetClientTop()  INLINE ::nTop
   METHOD GetClientLeft() INLINE ::nLeft

   METHOD ReSize()

   METHOD ReSized()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight, oWnd ) CLASS TView

   DEFAULT nTop := 0, nLeft := 0, nBottom := 0, nRight := 0

   ::nTop     = nTop    + If( oWnd != nil, oWnd:GetClientTop(), 0 )
   ::nLeft    = nLeft   + If( oWnd != nil, oWnd:GetClientLeft(), 0 )
   ::nBottom  = nBottom + If( oWnd != nil, oWnd:GetClientTop(), 0 )
   ::nRight   = nRight  + If( oWnd != nil, oWnd:GetClientLeft(), 0 )
   ::cBack    = ""
   ::cMsg     = ""
   ::lActive  = .t.
   ::lDrag    = .t.	// por defecto si se permite no??
   ::lEndExec = .f.
   ::lFocused = .f.
   ::lVisible = .f.
   ::oWnd     = oWnd
   ::bWhen    = bTrue
   ::bValid   = bTrue
   ::nMinW= 3
   ::nMinH= 3

return

//----------------------------------------------------------------------------//

METHOD Show() CLASS TView

   if ! ::lVisible
      ::lVisible = .t.
      ::cBack    =  SaveScreen( ::nTop - If( ::lDrag, 1, 0 ),;
                                ::nLeft - If( ::lDrag, 1, 0 ),;
                                ::nBottom + If( ::lDrag, 1, 0 ),;
                                ::nRight + If( ::lDrag, 2, 0 ) )
   endif
   ::Display()

return

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TView

   if ::lVisible
      ::lVisible = .f.
      ::lFocused = .f.
      if ::oLabel != nil
         ::oLabel:Hide()
      endif
      MOff()
      RestScreen( ::nTop - If( ::lDrag, 1, 0 ),;
                  ::nLeft - If( ::lDrag, 1, 0 ),;
                  ::nBottom + If( ::lDrag, 1, 0 ),;
                  ::nRight + If( ::lDrag, 2, 0 ), ::cBack )
      ::cBack = ""
      MOn()
   endif

return

//----------------------------------------------------------------------------//

METHOD Exec() CLASS TView

   local nKey
   local nOldMRow := 0, nOldMCol := 0
   local nLastClick := 0

   SetCursor( 0 )

   ::Show()
   if ! ::lFocused
      ::SetFocus( .t., "W+/B" )
   endif
   ::Init()
   ::lEndExec = .f.

   MOn()
   do while ! ::lEndExec
      nKey = nMKeyWait()
      do case
         case nKey == 0
              if ::lIsOver( nMRow(), nMCol() )
                 if Seconds() - nLastClick < 0.5 .and. ;
                    nMRow() == nOldMRow .and. nMCol() == nOldMCol
                    ::DblClick( nMRow(), nMCol() )
                 else
                    nLastClick  = Seconds()
                    nOldMRow    = nMRow()
                    nOldMCol    = nMCol()
                    ::Click( nMRow(), nMCol() )
                 endif
              else
                 Tone( 1000, 0.1 )
                 do while lMPressed()
                    MUpdate()
                 enddo
              endif

         otherwise
              ::KeyPressed( nKey )
      endcase
   enddo

return

//----------------------------------------------------------------------------//

METHOD DragOver() CLASS TView

   local nTop     := ::nTop
   local nLeft    := ::nLeft
   local nBottom  := ::nBottom
   local nRight   := ::nRight
   local nWidth   := nRight - nLeft + 1
   local nHeight  := nBottom - nTop + 1
   local nMOldRow := nMRow()
   local nMOldCol := nMCol()
   local nMHor    := nMOldRow - ::nTop
   local nMVer    := nMOldCol - ::nLeft
   local lMoved   := .f.

      	if ::oWnd!=nil.and.::ChildLevel( TWindow() ) == 0
            SetMArea( ::oWnd:nTop + 1 + nMHor,;
                      ::oWnd:nLeft + 1 + nMVer,;
                      ::oWnd:nBottom - ( ::nBottom - ::nTop + 1 ) + nMHor,;
                      ::oWnd:nRight - ( ::nRight - ::nLeft + 1 ) + nMVer )
         else
            if ::lMinimized
               SetMArea( ::oWnd:GetClientTop() + nMHor,;
                         ::oWnd:nLeft + 1 + nMVer,;
                         ::oWnd:nBottom - ( ::nBottom - ::nTop + 1 ) + nMHor,;
                         ::oWnd:nRight - ( ::nRight - ::nLeft + 1 ) + nMVer )
            endif
         endif
      
         MOff()
         SAVE SCREEN
         @ nTop, nLeft, nBottom, nRight BOX "þ-þ|þ-þ|" COLOR "W+/N"
         MOn( IDC_CROSS )
      
         do while lMPressed()
            if nMRow() != nMOldRow .or. nMCol() != nMOldCol
               nTop    = nMRow() - nMHor
               nLeft   = nMCol() - nMVer
               nBottom = nTop + nHeight - 1
               nRight  = nLeft + nWidth - 1
               MOff()
               DispBegin()
               REST SCREEN
               SAVE SCREEN
               @ nTop, nLeft, nBottom, nRight BOX "þ-þ|þ-þ|" COLOR "W+/N"
               DispEnd()
               MOn( IDC_CROSS )
               nMOldRow = nMRow()
               nMOldCol = nMCol()
            endif
            MUpdate()
         enddo
      
         MOff()
         REST SCREEN
         if ::nTop != nTop .or. ::nLeft != nLeft
            lMoved = .t.
            ::Move( nTop, nLeft )
         endif
         MOn()
      
         SetMArea( 0, 0, MaxRow(), MaxCol() )
return lMoved

//----------------------------------------------------------------------------//

METHOD Move( nRow, nCol ) CLASS TView

   local lWasVisible := ::lVisible

   MOff()
   DispBegin()
   if ::lVisible
      ::Hide()
   endif
   ::ChangePos( nRow, nCol )
   if lWasVisible
      ::Show()
      ::SetFocus( .t. )
   endif
   DispEnd()
   MOn()

   if ::bMoved != nil
      Eval( ::bMoved )
   endif

return

//----------------------------------------------------------------------------//

METHOD ChangePos( nRow, nCol ) CLASS TView

   local nOldTop  := ::nTop
   local nOldLeft := ::nLeft
   local nWidth   := ::nRight - ::nLeft
   local nHeigh   := ::nBottom - ::nTop

   ::nTop    = nRow
   ::nLeft   = nCol
   ::nBottom = nRow + nHeigh
   ::nRight  = nCol + nWidth

   if ::oLabel != nil
      ::oLabel:ChangePos( ::nTop + ( ::oLabel:nTop - nOldTop ),;
                          ::nLeft + ( ::oLabel:nLeft - nOldLeft ) )
   endif

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TView

   ::lFocused = lOnOff

   ::Display()
   if ::oLabel != nil
      ::oLabel:SetFocus( lOnOff )
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TView

   if ::lDrag
      do case
         case nKey == K_UP
              if ::nTop > ::oWnd:nTop + 2
                 ::Move( ::nTop - 1, ::nLeft )
              endif
              return 0

         case nKey == K_DOWN
              if ::nBottom < ::oWnd:nBottom - 1
                 ::Move( ::nTop + 1, ::nLeft )
              endif
              return 0

         case nKey == K_LEFT
              if ::nLeft > ::oWnd:nLeft + 2
                 ::Move( ::nTop, ::nLeft - 1 )
              endif
              return 0

         case nKey == K_RIGHT
              if ::nRight < ::oWnd:nRight - 1
                 ::Move( ::nTop, ::nLeft + 1 )
              endif
              return 0
      endcase
   endif

return nKey

//----------------------------------------------------------------------------//

METHOD lIsOver( nRow, nCol ) CLASS TView

   local lResult := If( ::oLabel != nil, ::oLabel:lIsOver( nRow, nCol ), .f. )

return If( lResult, .t., nRow >= ::nTop .and. nRow <= ::nBottom .and. ;
                         nCol >= ::nLeft .and. nCol <= ::nRight )

//----------------------------------------------------------------------------//

METHOD MouseMove( nRow, nCol ) CLASS TView

   if ::lDrag
      if ::nTop == ::nBottom
         do case
            case nCol == ::nRight
                 SetMCursor( IDC_SIZEWE )

            otherwise
                 SetMCursor( IDC_CROSS )
         endcase
      else
         do case
            case nRow == ::nBottom .and. nCol == ::nRight
                 SetMCursor( IDC_SIZENWSE )

            case nRow >= ::nTop .and. nRow < ::nBottom .and. nCol == ::nRight
                 SetMCursor( IDC_SIZEWE )

            case nRow == ::nBottom .and. nCol >= ::nLeft .and. nCol < ::nRight
                 SetMCursor( IDC_SIZENS )

            otherwise
                 SetMCursor( IDC_CROSS )
         endcase
      endif
   else
      SetMCursor( IDC_ARROW )
   endif

return

//----------------------------------------------------------------------------//

METHOD ReSize() CLASS TView

   local nMRow      := nMRow()
   local nMCol      := nMCol()
   local nCrsRow    := Row()
   local nCrsCol    := Col()
   local nCrsStatus := SetCursor( 0 )
   local cBack
   local nMOLdRow:=2000  // coordenadas imposibles
   Local nMOldCol:=2000  //     "           "
   local nModo // modo de funcionamiento

   MOff()
   cBack = SaveScreen()
   @ ::nTop, ::nLeft, ::nBottom, ::nRight BOX "þ-þ|þ-þ|" COLOR "W+/N"

//  con el raton ...
	do case
       case nMRow == ::nBottom .and. nMCol >= ::nRight - 1
            SetMCursor( IDC_SIZENWSE )
			nModo:=1
       case nMCol == ::nRight .and. nMRow > ::nTop .and. nMRow < ::nBottom
            SetMCursor( IDC_SIZEWE )
            nModo:=2
            nMRow:=::nBottom
            
       case nMRow == ::nBottom .and. nMCol > ::nLeft .and. nMCol < ::nRight
            SetMCursor( IDC_SIZENS )
            nModo:=3
            nMcol:=::nRight

       otherwise
            SetMCursor( IDC_ARROW )
            return
    endcase

  
   while lMLeft()
      MUpdate()

      if nMCol() != nMCol .or. nMRow() != nMRow
      	 nMOldCol:=nMcol
      	 nMOldRow:=nMRow
      	 if nModo=1.or.nModo=2
	         nMCol = nMCol()
           if nMcol-::nLeft+1<::nMinW
           		tone(1000,.1)
            	nMCol:=nMOldCol
           end
	     end
	     if nModo=1.or.nModo=3
         	nMRow = nMRow()
            if nMRow-::nTop+1<::nMinH
               tone(1000,.1)
               nMRow:=nMOldRow
            end
         end
         MOff()
         DispBegin()
         RestScreen( 0, 0, MaxRow(), MaxCol(), cBack )
         cBack = SaveScreen()
         @ ::nTop, ::nLeft, nMRow, nMCol BOX "þ-þ|þ-þ|" COLOR "W+/N"
         DispEnd()
         MOn()
      endif
   end

   MOff()
   RestScreen( 0, 0, MaxRow(), MaxCol(), cBack )
   MOn()
   SetMArea( 0, 0, MaxRow(), MaxCol() )

   if nMRow != ::nBottom .or. nMRow != ::nRight
      MOff()
      ::Hide()
      ::nBottom = nMRow
      ::nRight  = nMCol
      ::ReSized()
      ::Show()
      MOn()
   endif

   SetPos( nCrsRow, nCrsCol )
   SetCursor( nCrsStatus )
   Mon()
   SetMCursor( IDC_ARROW )

return

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TView

   if ::lDrag
      if nRow == ::nBottom .and. nCol == ::nRight
         ::ReSize()
      else
         ::DragOver( nRow, nCol )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD ReSized() CLASS TView

   if ::lDrag
      ::Adjust()
   else
      if ::bReSized != nil
         Eval( ::bReSized )
      endif
   endif

return

//----------------------------------------------------------------------------//
