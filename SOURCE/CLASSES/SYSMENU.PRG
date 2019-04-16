//----------------------------------------------------------------------------//

function SysMenu( oWnd, oMnu )

   local oMenu := TMenuBox():New( oWnd:nTop + 1, oWnd:nLeft+1,;
                                  oWnd:nTop + 2, oWnd:nLeft + 11 )
   
   oMenu:Add( TMenuItem():New( 0, 0, " &Restaurar " ,,{||oWnd:Normal()}) )
   oMenu:Add( TMenuItem():New( 0, 0, " &Mover " ) )
   oMenu:Add( TMenuItem():New( 0, 0, " &Tama¤o " ) )
   oMenu:Add( TMenuItem():New( 0, 0, " &Minimizar ",, { || oWnd:Minimize() } ) )
   oMenu:Add( TMenuItem():New( 0, 0, " &Maximizar ",, { || oWnd:Maximize() } ) )
   oMenu:Add( TMenuItem():New( 0, 0, "" ) )

   oMenu:Add( TMenuItem():New( 0, 0, " &Cerrar  Alt-F4 ",,;
              { || oWnd:End() },,, -33 ) )

   oMenu:lOpened = .f.
   oMenu:Adjust()

   if oMnu != nil
      oMenu:oMenu = oMnu
   endif

return oMenu
 
