#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TMenu

   DATA   aItems, aClrItems
   DATA   lEnd, lOpened, lVisible
   DATA   nOption
   DATA   cVarName

   METHOD New() CONSTRUCTOR
   METHOD GoEnd()
   METHOD KeyPressed( nKey )
   METHOD SetOption( nOption )

   METHOD Display() BLOCK ;
          { | Self | AEval( ::aItems, { | oItem | oItem:Display() } ) }

   METHOD SetFocus( lOnOff ) BLOCK ;
          { | Self, lOnOff | If( ::nOption != 0,;
            ::aItems[ ::nOption ]:SetFocus( lOnOff ),) }

   METHOD nHotAt( cHotKey )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New() CLASS TMenu

   ::aItems   = {}
   ::lEnd     = .f.
   ::lOpened  = .t.
   ::lVisible = .f.
   ::nOption  = 1

return

//----------------------------------------------------------------------------//

METHOD GoEnd() CLASS TMenu

   if ::lOpened .and. ValType( ::aItems[ ::nOption ]:xAction ) == "O"
      ::aItems[ ::nOption ]:xAction:KeyPressed( K_END )
   else
      ::SetOption( Len( ::aItems ) )
      if ValType( ::aItems[ ::nOption ]:xAction ) == "O"
         ::aItems[ ::nOption ]:xAction:GoHome()
      endif
   endif

return


//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TMenu

   do case
      case nKey == K_UP
           ::SetOption( If( ::nOption == 1, Len( ::aItems ), ::nOption - 1 ) )
		   return 0

      case nKey == K_DOWN
           ::SetOption( If( ::nOption == Len( ::aItems ), 1, ::nOption + 1 ) )
		   return 0

      case nKey == K_HOME
           ::SetOption( 1 )
		   return 0

      case nKey == K_END
           ::SetOption( Len( ::aItems ) )
		   return 0
   endcase

return

//----------------------------------------------------------------------------//

METHOD SetOption( nOption ) CLASS TMenu

   if nOption != ::nOption
      if ::nOption != 0
         ::aItems[ ::nOption ]:SetFocus( .f. )
      endif

      ::nOption = nOption

      if ::nOption != 0
         ::aItems[ ::nOption ]:SetFocus( .t. )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD nHotAt( cHotKey ) CLASS TMenu

return AScan( ::aItems, { | oItem | oItem:cHotKey == cHotKey } )

//----------------------------------------------------------------------------//
