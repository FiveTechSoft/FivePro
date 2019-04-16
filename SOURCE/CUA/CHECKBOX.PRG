#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TCheckBox FROM TView

   DATA   bSetGet
   DATA   cText
   DATA   nClrHotKey

   METHOD New( nRow, nCol, cPrompt, bSetGet, cMsg, cColors, oWnd ) CONSTRUCTOR
   METHOD Display()
   METHOD Click( nRow, nCol )
   METHOD KeyPressed( nKey )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, cPrompt, bSetGet, cMsg, cColors, oWnd ) CLASS TCheckBox

   DEFAULT cColors := "W/B, W+/B"

   Super:New( nRow, nCol, nRow, nCol + nLabelLen( cPrompt ) + 3, oWnd )

   ::cText      = cPrompt
   ::cMsg       = cMsg
   ::bSetGet    = bSetGet
   ::nClrNormal = nColorToN( cStrBtw( cColors, ",", 1 ) )
   ::nClrFocus  = nColorToN( cStrBtw( cColors, ",", 2 ) )
   ::oWnd       = oWnd
   ::nClrHotKey = 27

   if oWnd != nil
      ::oWnd:AddControl( Self )
   endif

   ::lDrag:=.f.
   
return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TCheckBox

   MOff()
   SayHot( ::nTop, ::nLeft,;
           Chr( 219 ) + ;
           If( Eval( ::bSetGet ), Chr( 226 ), Chr( 194 ) ) + Chr( 228 ) + ;
           ::cText, If( ::lFocused, ::nClrFocus, ::nClrNormal ), ::nClrHotKey )
   MOn()

return

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TCheckBox

   if ::lDrag
      Super:Click( nRow, nCol )
   else
      Eval( ::bSetGet, ! Eval( ::bSetGet ) )
      ::Display()
      while lMPressed()
         MUpdate()
      end
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TCheckBox

   if nKey == 32
      Eval( ::bSetGet, ! Eval( ::bSetGet ) )
      ::Display()
      return 0
   endif

return nKey

//----------------------------------------------------------------------------//
