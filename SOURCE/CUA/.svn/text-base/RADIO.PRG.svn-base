//Wed 04/05/1994 22:54:11  funciona , correccion de m rgenes y tonter¡as

#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TRadio FROM TView

   DATA   cText
   DATA   lChecked

   METHOD New( nRow, nCol, cText, lChecked, cMessage, oWnd  ) CONSTRUCTOR
   METHOD Display()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, cText, lChecked, cMessage, oWnd ) CLASS TRadio

   DEFAULT cText:= "&RadioButton", lChecked := .f., cMessage:= ""

   Super:New( nRow, nCol, nRow, nCol + nLabelLen( cText ) + 3, oWnd )

   ::cText    = cText
   ::cMsg     = cMessage
   ::lChecked = lChecked

   if oWnd != nil
      oWnd:AddControl( Self )
   endif
   ::lDrag:=.t. // por defecto los radios no se mueven no?
return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TRadio

   MOff()
   SayHot( ::nTop, ::nLeft,;
           Chr( 193 ) + Chr( If( ::lChecked, 198, 197 ) ) + Chr( 227 ) + ;
           ::cText, If( ::lFocused, 63, 48 ), 59 )
   MOn()

return

//----------------------------------------------------------------------------//
