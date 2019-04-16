#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TCtrBrowse FROM TView

   DATA   oBrowse, oScrBar
   DATA   bLogicLen

   METHOD New( nRow, nCol, nWidth, nHeight, oBrowse, cLabel, cMsg, oWnd,;
               bLogicLen ) CONSTRUCTOR
   METHOD Display()
   METHOD Click( nRow, nCol )
   METHOD ChangePos( nRow, nCol )
   METHOD KeyPressed( nKey )
   METHOD AddControl( oCtrl ) VIRTUAL

   METHOD SetFocus( lOnOff )

   METHOD GoUp()
   METHOD GoDown()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, nWidth, nHeight, oBrowse, cLabel, cMsg, oWnd,;
            bLogicLen ) CLASS TCtrBrowse

   local oScrBar

   DEFAULT cLabel := "&Browse", bLogicLen := { || RecCount() - 1 }

   Super:New( nRow, nCol, nRow + nHeight - 1, nCol + nWidth - 1, oWnd )

   ::oBrowse = oBrowse
   if oBrowse != nil
      oBrowse:nTop    = ::nTop + 1
      oBrowse:nLeft   = ::nLeft
      oBrowse:nBottom = ::nBottom
      oBrowse:nRight  = ::nRight - 2
   endif

   ::oLabel    = TLabel():New( 0, 0, cLabel, Self )
   ::cMsg      = cMsg
   ::bLogicLen = bLogicLen

   @ 1, ::nRight - ::nLeft - 1 SCROLLBAR oScrBar OF Self ;
      SIZE oBrowse:nBottom - oBrowse:nTop + 1 ;
      RANGE   Eval( ::bLogicLen ) ;
      ON UP   ::GoUp() ;
      ON DOWN ::GoDown()

   ::oScrBar = oScrBar

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TCtrBrowse

   ::oBrowse:InvalidateAll()
   BrwDisplay( ::oBrowse )

   ::oScrBar:Display()

return

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TCtrBrowse

   if ::oScrBar:lIsOver( nRow, nCol )
      ::oScrBar:Click( nRow, nCol )
   else
      if nRow > ::nTop
         BrwClick( ::oBrowse, nRow, nCol, ::oScrBar )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD ChangePos( nRow, nCol ) CLASS TCtrBrowse

   local oBrowse := ::oBrowse

   Super:ChangePos( nRow, nCol )

   oBrowse:nTop    = ::nTop    + 1
   oBrowse:nLeft   = ::nLeft
   oBrowse:nBottom = ::nBottom
   oBrowse:nRight  = ::nRight - 1

   ::oScrBar:ChangePos( ::nTop + 1, ::nRight )
   ::oLabel:ChangePos( ::nTop, ::nLeft )

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TCtrBrowse

   local oBrowse := ::oBrowse

   do case
      case nKey == K_UP
           DO
              ::GoUp()
           UNTIL ( nKey := If( NextKey() == K_UP, InKey( 0 ), 0 ) ) == 0
           return 0

      case nKey == K_DOWN
           DO
              ::GoDown()
           UNTIL ( nKey := If( NextKey() == K_DOWN, InKey( 0 ), 0 ) ) == 0
           return 0

      case nKey == K_HOME
           if ! oBrowse:HitTop
              BrwHide( oBrowse )
              oBrowse:GoTop()
              BrwDisplay( oBrowse )
              return 0
           endif

      case nKey == K_END
           if ! oBrowse:HitBottom
              BrwHide( oBrowse )
              oBrowse:GoBottom()
              BrwDisplay( oBrowse )
              return 0
           endif

      case nKey == K_PGUP
           if ! oBrowse:HitTop
              BrwHide( oBrowse )
              oBrowse:PageUp()
              BrwDisplay( oBrowse )
              return 0
           endif

      case nKey == K_PGDN
           if ! oBrowse:HitBottom
              BrwHide( oBrowse )
              oBrowse:PageDown()
              BrwDisplay( oBrowse )
              return 0
           endif
   endcase

return nKey

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TCtrBrowse

   Super:SetFocus( lOnOff )
   ::oScrBar:SetFocus( lOnOff )

return

//----------------------------------------------------------------------------//

METHOD GoUp() CLASS TCtrBrowse

   local oBrowse := ::oBrowse

   if ! oBrowse:HitTop
      BrwHide( oBrowse )
      oBrowse:Up()
      BrwDisplay( oBrowse )
   endif

return

//----------------------------------------------------------------------------//

METHOD GoDown() CLASS TCtrBrowse

   local oBrowse := ::oBrowse

   if ! oBrowse:HitBottom
      BrwHide( oBrowse )
      oBrowse:Down()
      BrwDisplay( oBrowse )
   endif

return

//----------------------------------------------------------------------------//
