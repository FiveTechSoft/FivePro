#include "Objects.ch"
#include "InKey.ch"
#include "Set.ch"

#define K_UNDO  K_CTRL_U

//----------------------------------------------------------------------------//

CLASS TMGet FROM TView

   DATA   bSetGet
   DATA   nCrsRow, nCrsCol, nLines, nRowPos
   DATA   oScrBar

   METHOD New( nRow, nCol, nWidth, nHeight, bSetGet, cColors, cLabel,;
               cMessage, oWnd ) CONSTRUCTOR

   METHOD Display()

   METHOD KeyPressed( nKey )
   METHOD Click( nRow, nCol )

   METHOD ChangePos( nRow, nCol ) BLOCK ;
          { | Self, nRow, nCol | Super:ChangePos( nRow, nCol ),;
                                 ::oGet:Row := nRow, ::oGet:Col := nCol }
   METHOD GenCode()
   METHOD AddControl() VIRTUAL

   METHOD SetFocus( lOnOff )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, nWidth, nHeight, bSetGet, cColors, cLabel, cMessage,;
            oWnd ) CLASS TView

   DEFAULT cColors := "N/BG, W+/BG", nWidth := 10, nHeight := 10

   Super:New( nRow + If( oWnd != nil, oWnd:nTop, 0 ),;
              nCol + If( oWnd != nil, oWnd:nLeft, 0 ),;
              nRow + If( oWnd != nil, oWnd:nTop, 0 ) + nHeight - 1,;
              nCol + If( oWnd != nil, oWnd:nLeft, 0 ) + nWidth - 1 )

   ::bSetGet = bSetGet
   ::nCrsRow = 0
   ::nCrsCol = 0
   ::nRowPos = 0
   ::nLines  = MLCount( Eval( bSetGet ) )

   ::oWnd    = oWnd
   ::oScrBar = TScrollBar():New( 0, ::nRight - ::nLeft - 1,,;
                                 nHeight,,,,,, Self )

   ::oScrBar:bOnUp   = { || ::nRowPos--, ::Display() }
   ::oScrBar:bOnDown = { || ::nRowPos++, ::Display() }
   ::oScrBar:nRange  = MLCount( Eval( bSetGet ) )
   ::oScrBar:nValue  = 1

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TMGet

   local cClrOld := SetColor( If( ::lFocused, "W+/BG", "N/BG" ) )

   MOff()
   DispBegin()
   __KeyBoard( Chr( 27 ) )
   MemoEdit( Eval( ::bSetGet ), ::nTop, ::nLeft, ::nBottom, ::nRight,;
             ,,,, ::nRowPos )
   SetColor( cClrOld )
   ::oScrBar:Display()
   DispEnd()
   MOn()

return

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TMGet

   if ::oScrBar:lIsOver( nRow, nCol )
      ::oScrBar:Click( nRow, nCol )
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TGet

   do case
      case nKey == K_UP
           ::oScrBar:Up()

      case nKey == K_DOWN
           ::oScrBar:Down()

      case nKey == K_PGUP
           if ::nRowPos > 1
              ::nRowPos -= ( ::nBottom - ::nTop )
              if ::nRowPos < 1
                 ::nRowPos = 1
              endif
              ::Display()
           endif

      case nKey == K_PGDN
           if ::nRowPos < ::nLines
              ::nRowPos += ( ::nBottom - ::nTop )
              if ::nRowPos > ::nLines
                 ::nRowPos = ::nLines - ( ::nBottom - ::nTop )
              endif
              ::Display()
           endif

      case nKey == K_HOME
           if ::nRowPos > 1
              ::nRowPos = 1
              ::oScrBar:GoTop()
              ::Display()
           endif

      case nKey == K_END
           if ::nRowPos < ::nLines - ( ::nBottom - ::nTop )
              ::nRowPos = ::nLines - ( ::nBottom - ::nTop )
              ::oScrBar:GoBottom()
              ::Display()
           endif

      case nKey == K_LEFT
           ::oGet:Left()

      case nKey == K_RIGHT
           ::oGet:Right()

      case nKey == K_HOME
           ::oGet:Home()

      case nKey == K_END
           ::oGet:End()

      case nKey == K_CTRL_LEFT
           ::oGet:WordLeft()

      case nKey == K_CTRL_RIGHT
           ::oGet:WordRight()

      case nKey == K_BS
           ::oGet:BackSpace()

      case nKey == K_DEL
           ::oGet:Delete()

      case nKey == K_CTRL_T
           ::oGet:DelWordRight()

      case nKey == K_CTRL_Y
           ::oGet:DelEnd()

      case nKey == K_CTRL_BS
           ::oGet:DelWordLeft()

      case nKey == K_INS
         Set( _SET_INSERT, ! Set( _SET_INSERT ) )
         SetCursor( If( SetCursor() == 1, 2, 1 ) )

      case nKey == K_UNDO
           ::oGet:UnDo()

      case ::oGet:Type == "N" .and. ;
           Chr( nKey ) == "." .OR. Chr( nKey ) == ","
           ::oGet:ToDecPos()

      otherwise
           if Set( _SET_INSERT )
              ::oGet:Insert( Chr( nKey ) )
           else
              ::oGet:OverStrike( Chr( nKey ) )
           endif
   endcase

return

//----------------------------------------------------------------------------//

METHOD GenCode() CLASS TGet

   local cCode := ""

   cCode += "   @ "
   cCode += Transform( ::nTop - If( ::oWnd != nil, ::oWnd:nTop, 0 ), "99" )
   cCode += ", " + Transform( ::nLeft - If( ::oWnd != nil, ::oWnd:nLeft, 0 ), "99" )
   cCode += " GET uVar OF oWnd"

return cCode

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TMGet

   ::oScrBar:SetFocus( lOnOff )
   Super:SetFocus( lOnOff )

return

//----------------------------------------------------------------------------//
