#include 'FIVEPRO.ch'

// sustituto de alert, excepto en los colores.

FUNCTION  alert(cText,aOptions)
	local cOption:='',n:=0
	
	FOR n:=1 to len(aOptions)
		cOption := cOption + aOptions[n]
		if n<Len(aOptions)
			cOption := cOption + ';'
		end
	NEXT
	
	return nMsgBox(cText,cOption)
	
