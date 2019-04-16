// Clase Base para Men£s
// (C) Antonio Linares, 1993

#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TMenu

   DATA   nOption
   DATA   aoItems
   DATA   lEnd

   METHOD New() CONSTRUCTOR
   METHOD KeyApply( nKey )
   METHOD Exec()
   METHOD SetOption( nOption )
   METHOD AddItem( oItem )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New() CLASS TMenu

   ::nOption = 1
   ::aoItems = {}
   ::lEnd    = .f.

return

//----------------------------------------------------------------------------//

METHOD KeyApply( nKey ) CLASS TMenu

   do case
      case nKey == K_ESC
           ::lEnd = .t.
           ::nOption = 0

      case nKey == K_ENTER
           ::lEnd = .t.

      case nKey == K_UP
           ::SetOption( If( ::nOption > 1, ::nOption - 1, Len( ::aoItems ) ) )

      case nKey == K_DOWN
           ::SetOption( If( ::nOption < Len( ::aoItems ), ::nOption + 1, 1 ) )

      case nKey == K_HOME
           ::SetOption ( 1 )

      case nKey == K_END
           ::SetOption( Len( ::aoItems ) )

   endcase

return

//----------------------------------------------------------------------------//

METHOD Exec() CLASS TMenu

   ::lEnd = .f.
   ::aoItems[ ::nOption ]:SetFocus( .t. )

   do while ! ::lEnd
      ::KeyApply( InKey( 0 ) )
   enddo

return

//----------------------------------------------------------------------------//

METHOD SetOption( nOption ) CLASS TMenu

   if nOption != ::nOption
      if ::nOption != 0
         ::aoItems[ ::nOption ]:SetFocus( .f. )
      endif
      ::nOption = nOption
      if nOption != 0
         ::aoItems[ nOption ]:SetFocus( .t. )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD AddItem( oItem ) CLASS TMenu

   AAdd( ::aoItems, oItem )
   ATail( ::aoItems ):Display()

return

//----------------------------------------------------------------------------//
