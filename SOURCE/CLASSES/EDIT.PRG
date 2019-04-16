#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TEdit FROM TView

   DATA   bSetGet
   DATA   cText
   DATA   cClrBlock, cClrFocus
   DATA   nCrsPos, nBlkStart, nBlkEnd
   DATA   nLen, nMaxLen, nStartCol
   DATA   lInsert
   DATA   oLabel

   METHOD New( nRow, nCol, bSetGet, cLabel, cMessage, oWnd ) CONSTRUCTOR
   METHOD Display()
   METHOD Hide()
   METHOD BufDisplay()
   METHOD lIsOver( nRow, nCol )
   METHOD KeyPressed( nKey )
   METHOD Click( nRow, nCol )
   METHOD GoLeft()
   METHOD GoRight()
   METHOD Clear()
   METHOD SetText( cText )
   METHOD SetFocus( lOnOff )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, bSetGet, cLabel, cMessage, oWnd ) CLASS TEdit

   DEFAULT nRow:= 0, nCol:= 0, cMessage:= ""

   Super:New()

   ::nTop            = nRow + If( oWnd != nil, oWnd:nTop, 0 ) + 1
   ::nLeft           = nCol + If( oWnd != nil, oWnd:nLeft, 0 )
   ::nBottom         = ::nTop
   ::nRight          = ::nLeft + nValLen( Eval( bSetGet ) ) - 1
//   ::nMaxLen         = nLen

   if cLabel != nil
      ::oLabel          = TLabel():New( ::nTop, ::nLeft, cLabel )
      ::oLabel:cMessage = nil
      ::oLabel:oParent  = Self
   endif

   ::cMessage        = cMessage
   ::cClrBlock       = "W+/G"
   ::cClrFocus       = "W+/R"
   ::cClrNormal      = "N/BG"
   ::nCrsPos         = 1
   ::nStartCol       = 1
   ::nBlkStart       = 0
   ::nBlkEnd         = 0
   ::lInsert         = .f.
   ::bSetGet         = bSetGet

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TEdit

   if ::oLabel != nil
      ::oLabel:Show()
   endif

   MOff()
   @ ::nTop, ::nLeft SAY Eval( ::bSetGet ) ;
      COLOR If( ::lFocused, ::cClrFocus, ::cClrNormal )
   MOn()

return

//----------------------------------------------------------------------------//

METHOD Hide() CLASS TEdit

   SetCursor( 0 )
   Super:Hide()

return

//----------------------------------------------------------------------------//

METHOD lIsOver( nRow, nCol ) CLASS TEdit

   local lIsOver := If( ::oLabel != nil, ::oLabel:lIsOver( nRow, nCol ), .f. )

   if ! lIsOver
      lIsOver = Super:lIsOver( nRow, nCol )
   endif

return lIsOver

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TEdit

   if ::lDrag
      Super:KeyPressed( nKey )
   else
      do case
         case nKey == K_ESC
              if ::oParent == nil
                 ::EndExec()
              endif

         case nKey >= 32
              ::cText= Stuff( ::cText, ::nCrsPos, If( ::lInsert, 0, 1 ), Chr( nKey ) )
              ::cText = SubStr( ::cText, 1, ::nMaxLen )
                 if ::nCrsPos < ::nLen
                    ::nCrsPos++
                 endif
              ::BufDisplay()
              /*
              if ::oParent != nil
                 ::oParent:EdtChanged( Self )
              endif
              */

         case nKey == K_HOME
              if ::nStartCol != 1 .or. ::nCrsPos != 1
                 ::nCrsPos   = 1
                 ::nStartCol = 1
                 ::BufDisplay()
              endif

         case nKey == K_END
              if ::nStartCol + ::nCrsPos - 1 < Len( ::cText )
                 ::nStartCol = If( Len( ::cText ) < ::nLen, 1,;
                                   Len( ::cText ) - ::nLen + 1 )
                 ::nCrsPos   = Min( ::nLen, Len( ::cText ) - ::nStartCol + 2 )
                 ::BufDisplay()
              endif

         case nKey == K_INS
              ::lInsert = ! ::lInsert
              SetCursor( If( ::lInsert, 2, 1 ) )

         case nKey == K_LEFT
              ::GoLeft()

         case nKey == K_RIGHT
              ::GoRight()

          case nKey == K_DEL
               if ::nCrsPos <= Len( ::cText )
                  ::cText = SubStr( ::cText, 1, ::nStartCol + ::nCrsPos - 2 ) + ;
                              SubStr( ::cText, ::nStartCol + ::nCrsPos )
                  ::BufDisplay()
                  /*
                  if ::oParent != nil
                     ::oParent:EdtChanged( Self )
                  endif
                  */
               endif

         case nKey == K_BS
              if ! Empty( ::cText )
                 ::cText = SubStr( ::cText, 1, ::nStartCol + ::nCrsPos - 3 ) + ;
                           SubStr( ::cText, ::nStartCol + ::nCrsPos - 1 )
                 if ::nCrsPos > 1
                    ::nCrsPos--
                 else
                    if ::nStartCol > 1
                       ::nStartCol--
                    endif
                 endif
                 ::BufDisplay()
                 /*
                 if ::oParent != nil
                    ::oParent:EdtChanged( Self )
                 endif
                 */
              endif
      endcase
   endif

return

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TEdit

   if ::lDrag
      ::DragOver()
   else
      do case
         case ::nTop() == nRow .and. ::nLeft() == nCol
              do while lMPressed()
                 if ::nTop() == nRow .and. ::nLeft() == nCol
                    ::GoLeft()
                 endif
                 MUpdate()
              enddo

         case ::nTop() == nRow .and. ::nRight == nCol
              do while lMPressed()
                 if ::nTop() == nRow .and. ::nRight == nCol
                    ::GoRight()
                 endif
                 MUpdate()
              enddo
      endcase
   endif

return

//----------------------------------------------------------------------------//

METHOD GoLeft() CLASS TEdit

   if ::nCrsPos > 1
      ::nCrsPos--
      @ ::nTop, ::nLeft + ::nCrsPos SAY ""
   else
      if ::nStartCol > 1
         ::nStartCol--
         ::BufDisplay()
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD GoRight() CLASS TEdit

   if ::nStartCol + ::nCrsPos - 1 < Len( ::cText ) + 1
      if ::nCrsPos < ::nLen
         ::nCrsPos++
         @ ::nTop, ::nLeft + ::nCrsPos SAY ""
      else
         if ::nStartCol < Len( ::cText ) - ::nLen + 1
            ::nStartCol++
            ::BufDisplay()
         endif
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD BufDisplay() CLASS TEdit

   MOff()
   SetCursor( 0 )

   @ ::nTop, ::nLeft SAY If( ::nStartCol > 1, Chr( 17 ), " " ) ;
     COLOR If( ::nStartCol > 1, "BG+/B", ::cClrNormal )
   @ ::nTop, ::nLeft + ::nLen + 1 SAY ;
     If( Len( ::cText ) - ::nStartCol > ::nLen - 1, Chr( 16 ),;
     " " ) COLOR If( Len( ::cText ) - ::nStartCol > ::nLen - 1,;
     "BG+/B", ::cClrNormal )

   @ ::nTop, ::nLeft + 1 ;
     SAY SubStr( ::cText, ::nStartCol, ::nLen ) ;
     COLOR If( ::lFocused, ::cClrFocus, ::cClrNormal )
   if Len( ::cText ) - ::nStartCol < ::nLen
      @ ::nTop, ::nLeft + 2 + Len( ::cText ) - ::nStartCol ;
        SAY Space( ::nLen - 1 - ;
            ( Len( ::cText ) - ::nStartCol ) ) ;
        COLOR ::cClrNormal
   endif
   if ::lFocused
      @ ::nTop, ::nLeft + ::nCrsPos SAY ""
      SetCursor( If( ::lInsert, 2, 1 ) )
   endif
   MOn()

return

//----------------------------------------------------------------------------//

METHOD Clear() CLASS TEdit

   ::cText     = ""
   ::nCrsPos   = 1
   ::nStartCol = 1
   ::nBlkStart = 0
   ::nBlkEnd   = 0
   ::BufDisplay()

return

//----------------------------------------------------------------------------//

METHOD SetText( cText ) CLASS TEdit

   ::cText     = SubStr( cText, 1, ::nMaxLen )
   ::nCrsPos   = 1
   ::nStartCol = 1
   ::nBlkStart = 0
   ::nBlkEnd   = 0
   ::BufDisplay()

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TEdit

   if ! lOnOff
      SetCursor( 0 )
   endif

   Super:SetFocus( lOnOff )

   if ! ::lDrag .and. lOnOff
      SetPos( ::nTop, ::nLeft + ::nCrsPos - 1 )
      SetCursor( If( ::lInsert, 2, 1 ) )
   endif

return

//----------------------------------------------------------------------------//
