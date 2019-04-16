#include 'Fivepro.ch'



/*
--------------------------------------------------------------------
Clase   :  TsMenu
Fecha   : Sat 11/06/1994 22:30:55  
Objetivo: enu de sistema de cada ventana
---------------------------------------------------------------------*/
Class TsMenu from tMenuBox

	Data oWnd
	
	Method Activate()  
	Method Deactivate()
	
end class


/*
--------------------------------------------------------------------
Clase   : TsMenu
Method  : Activate
Fecha   : Sun 12/06/199410:47:28  
Objetivo: activar el menu
---------------------------------------------------------------------*/
Method tsmenu.activate()
	local nLen:=Len(::aItems)
	local nTop
	local nLeft
	if ::oWnd#nil
		nTop:=::oWnd:nTop
		nLeft:=::oWnd:nLeft
	end
	
	if nTop+nLen+2>MaxRow() // se sale por  debajo ....
		nTop:=nTop-nlen+2
	end
	::ChangePos(nTop,nLeft)
	::nOption:=1
//	::lOpened:=.t.
	::Display()
	return nil
	
/*
--------------------------------------------------------------------
Clase   : tsmenu
Method  : Deactivate
Fecha   : Sun 12/06/199423:13:04  
Objetivo: Desactivar el 'Omenu'
---------------------------------------------------------------------*/
Method TsMenu.Deactivate()
	::Hide()
	::nOption:=0
  //  ::lOpened:=.f.
	return nil
