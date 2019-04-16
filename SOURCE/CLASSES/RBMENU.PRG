// Wed 04/05/1994 22:54:43  Correcci¢n de ancho de los items

#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TRdMenu FROM TView

   DATA   oLabel, oMenu
   DATA   bSetGet

   METHOD New( nRow, nCol, bSetGet, aItems, cLabel, oWnd ) CONSTRUCTOR
   METHOD Display()
   METHOD AddControl( oCtrl ) VIRTUAL
   METHOD ChangePos( nRow, nCol )

   METHOD KeyPressed( nKey )

   METHOD SetFocus( lOnOff ) BLOCK ;
          { | Self, lOnOff | Super:SetFocus( lOnOff ),;
                             ::oMenu:SetFocus( lOnOff ) }

   METHOD Click( nRow, nCol )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, bSetGet, aItems, cLabel, oWnd ) CLASS TRdMenu

   local n, nOption := Eval( bSetGet )
   local aTEmp:={}
   local nMaxLen    
   
	aeval(aitems,{|a|Aadd(aTemp,strtran(a,'&',''))})
    nMaxLen    := nAMaxLen( aTemp ) // Longitud real
    
   Super:New( nRow, nCol,;
              nRow + Len( aItems ) - 1, nCol + nMaxLen + 1, oWnd )

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

   ::bSetGet = bSetGet
   ::oMenu   = TMenu():New()
   ::oMenu:nOption = nOption
   ::oLabel  = TLabel():New( -1, 0, cLabel, Self )

   for n = 1 to Len( aItems )
       AAdd( ::oMenu:aItems, TRadio():New( n - 1, 0,;
             PadR( aItems[ n ], nMaxLen;
             +if(at('&',aitems[n])!=0,1,0) ), nOption == n,, Self ) )
   next
   ::lDrag:=.f. // no se debe mover (normalmente)
return

//----------------------------------------------------------------------------//

METHOD ChangePos( nRow, nCol ) CLASS TRdMenu

   Super:ChangePos( nRow, nCol )

   AEval( ::oMenu:aItems,;
          { | oRadio, n | oRadio:ChangePos( ::nTop + n - 1, ::nLeft ) } )

return

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TRdMenu

   local nAtRow

   if ::lDrag
      Super:Click( nRow, nCol )
   else
      DO
         if ( nAtRow := nRow - ::nTop + 1 ) > 0 .and. ;
            nAtRow <= Len( ::oMenu:aItems )
            ::oMenu:aItems[ ::oMenu:nOption ]:lChecked = .f.
            ::oMenu:aItems[ nAtRow ]:lChecked = .t.
            ::oMenu:SetOption( nAtRow )
            Eval( ::bSetGet, ::oMenu:nOption )
         endif
         MUpdate()
         nRow = nMRow()
      UNTIL ! lMPressed()
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TRdMenu

   @ ::nTop, ::nLeft, ::nBottom, ::nRight BOX Space( 9 ) ;
      COLOR "N/BG"

   ::oMenu:Display()
   if ::oLabel != nil
      ::oLabel:Display()
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TRdMenu

   local oMenu := ::oMenu

   if nKey == K_DOWN .or. nKey == K_UP .or. nKey == K_HOME .or. nKey == K_END
      oMenu:aItems[ oMenu:nOption ]:lChecked = .f.
      oMenu:KeyPressed( nKey )
      oMenu:aItems[ oMenu:nOption ]:lChecked = .t.
      oMenu:aItems[ oMenu:nOption ]:Display()
      Eval( ::bSetGet, oMenu:nOption )
      return 0
   endif

return nKey

//----------------------------------------------------------------------------//
