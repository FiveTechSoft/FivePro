#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TCtrMemo FROM TControl

   DATA nTop, nLeft, nBottom, nRight
   DATA cText

   METHOD New( nTop, nLeft, nHeight, nWidth, cText ) CONSTRUCTOR
   METHOD Display()
   METHOD SetFocus( lOnOff )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nHeight, nWidth, cText ) CLASS TCtrMemo

   Super:New()

   ::nTop       = nTop
   ::nLeft      = nLeft
   ::nBottom    = nTop + nHeight - 1
   ::nRight     = nLeft + nWidth - 1
   ::cText      = cText
   ::cColorSpec = "N/BG, W+/BG"

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TCtrMemo

   local cClrOld := SetColor( ::cColorSpec )

   KEYBOARD Chr( K_ESC )
   MemoEdit( ::cText, ::nTop, ::nLeft, ::nBottom, ::nRight )

   SetColor( cClrOld )

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TCtrMemo

   local cClrOld := SetColor( SubStr( ::cColorSpec,;
                              At( ",", ::cColorSpec ) + 1 ) )
   local bOldEsc, bOldTab

   Super:SetFocus( lOnOff )
   if lOnOff
      SetCursor( 1 )
      bOldEsc = SetKey( K_ESC, { || __KeyBoard( Chr( K_CTRL_W ) ) } )
      bOldTab = SetKey( K_TAB, { || __KeyBoard( Chr( K_CTRL_W ) ) } )
      MemoEdit( ::cText, ::nTop, ::nLeft, ::nBottom, ::nRight )
      SetKey( K_ESC, bOldEsc )
      SetKey( K_TAB, bOldTab )
   endif

   ::Display()
   SetCursor( 0 )
   SetColor( cClrOld )

return

//----------------------------------------------------------------------------//
