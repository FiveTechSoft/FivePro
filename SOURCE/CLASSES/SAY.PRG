#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TSay FROM TView

   DATA   bGetText

   METHOD New( nRow, nCol, bGetText, cColor, oWnd ) CONSTRUCTOR
   METHOD Display()
   METHOD GenCode()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, bGetText, cColor, oWnd ) CLASS TSay

   DEFAULT bGetText := { || "&TSay" }

   Super:New()

   ::nTop       = nRow + If( oWnd != nil, oWnd:nTop, 0 )
   ::nLeft      = nCol + If( oWnd != nil, oWnd:nLeft, 0 )
   ::nBottom    = ::nTop
   ::nRight     = ::nLeft + nValLen( Eval( bGetText ) ) - 1
   ::bGetText   = bGetText
   ::nClrNormal = If( cColor != nil, nColorToN( cColor ), oWnd:nClrNormal )
   ::bWhen      = { || .f. }

   if oWnd != nil
      oWnd:AddControl( Self )
   endif
   ::lDrag:=.f. // para que no loarrastre el rat¢n
return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TSay
   local cText,nLen
   
   cText:=cValToChar( Eval( ::bGetText ) )
   // calculo de la por cion a visualizar sin salirse de la
   // ventana
   if ::oWnd!=Nil
   	  if ::nTop>::oWnd:nBottom-1 // est  fuera por abajo
   	  	return
   	  end
   		nLen:=::oWnd:nRight-::nLeft
   		if nLen>0
     		cText:=substr(cText,1,nLen) // recorte por la derecha
   		else
    		cText:=''
   		end
   end
   MOff()
   SayHot( ::nTop, ::nLeft, cText , ::nClrNormal, 27 )
   MOn()

return

//----------------------------------------------------------------------------//

METHOD GenCode() CLASS TSay

   local cCode := ""

   cCode += "   @ "
   cCode += Transform( ::nTop  - If( ::oWnd != nil, ::oWnd:nTop, 0 ), "99" ) + ", "
   cCode += Transform( ::nLeft - If( ::oWnd != nil, ::oWnd:nLeft, 0 ), "99" )
   cCode += ' SAY "' + Eval( ::bGetText ) + '"'
   cCode += " OF oWnd"

return cCode

//----------------------------------------------------------------------------//
