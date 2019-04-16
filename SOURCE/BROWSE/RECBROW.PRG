#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TRecBrowse FROM TABrowse

   METHOD New( nTop, nLeft, nBottom, nRight ) CONSTRUCTOR
   METHOD PageUp()
   METHOD PageDown()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight ) CLASS TRecBrowse

   local acFields := Array( FCount() )

   AEval( acFields,;
          { | cField, n | acFields[ n ] := PadR( Field( n ), 10 ) } )

   ::Parent:New( nTop, nLeft, nBottom, nRight, acFields )
   ::AddColumn( TBColumnNew( "",;
                { | u | If( PCount() > 0, FieldPut( ::nItem, u ),;
                      FieldGet( ::nItem ) ) } ) )
   ::GetColumn( 2 ):Width = ( nRight - nLeft ) - 14

return

//----------------------------------------------------------------------------//

METHOD PageUp() CLASS TRecBrowse

   if ::nItem == 1
      SKIP -1
      if BoF()
         GO TOP
         Tone( 200, 0.1 )
      else
         ::RefreshAll()
      endif
   else
      ::Parent:PageUp()
   endif

return

//----------------------------------------------------------------------------//

METHOD PageDown() CLASS TRecBrowse

   if ::nItem == ::nLen
      SKIP
      if EoF()
         GO BOTTOM
         Tone( 200, 0.1 )
      else
         ::RefreshAll()
      endif
   else
      ::Parent:PageDown()
   endif

return

//----------------------------------------------------------------------------//
