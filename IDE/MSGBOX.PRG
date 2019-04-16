#include "fivepro.ch"

//----------------------------------------------------------------------------//

function nMsgBox( cText, cTitle, cOptions )

   local n, nCol, nLenOptions := 0, acTxtLines
   local acOptions
   local nTop    := 6
   local nLeft   := ( MaxCol() / 2 )
   local nLen
   local nWidth:=0
   local oWnd
   local nOption := 0
   local noffset:=0
   

   DEFAULT cOptions := " &Aceptar "

   acOptions := aStr2Array( cOptions, ";" )

   acTxtLines = aStr2Array( cText, ";" )

   AEval( acTxtLines, { | cLine | nWidth := Max( nWidth, Len( cLine ) + 3 ) } )
   AEval( acOptions, { | cOption | nLenOptions += Len( cOption ) + 2 } )
   nLenOptions -= 2
   nWidth     = Max( nWidth, nLenOptions + 4 )
   nTop       = Min( nTop, ( MaxRow() / 2 ) - ( Len( acTxtLines ) / 2 ) - 3 )
   nLeft      = Min( nLeft, ( MaxCol() / 2 ) - ( nWidth / 2 ) )
   nLen       = Max( 5, len(acTxtLines)+3 )

   DEFINE DIALOG oWnd FROM nTop, nLeft size nLen, nWidth ;
      TITLE cTitle COLOR "W+/B, N*/W"
      
	   for n = 1 to Len( acTxtLines )
           TSay():New( n + 1, ( nWidth / 2 ) - ( Len( acTxtLines[ n ] ) / 2 ) + 0.5,&('{||"'+acTxtLines[ n ]+'"}'),, oWnd )
	   next

   for n = 1 to Len( acOptions )
       @ -2 + oWnd:nBottom, oWnd:nLeft+nOffset+1 BUTTON acOptions[ n ] ;
         ACTION  (nOption :=len(oWnd:aControls)-oWnd:nFocus+1,oWnd:End) of oWnd
       nOffset+=len(acOptions[n])+2
   end
   ACTIVATE WINDOW oWnd

return nOption

//----------------------------------------------------------------------------//

Function aStr2Array(cText,cSep)
	local n,aTemp:={}
	do while (n:=at(cSep,cText))#0
		if n>1
			aadd(aTemp,substr(cTExt,1,n-1))
		else
			aadd(aTemp,'')
		end
		if n<len(cText)
			cText:=substr(cText,n+1,len(cText)-n)
		else
			cText:=''
		end
	end
	aadd(aTemp,cText)
	return aTemp
