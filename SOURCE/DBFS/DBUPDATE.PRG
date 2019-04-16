#include "InKey.ch"

//----------------------------------------------------------------------------//

function DbUpdate( lAltas, acFields, auValues )

   if LastKey() != K_ESC
      if lAltas
         lNetRecAdd()
      endif
      lNetRecLock( 0 )
      AEval( acFields,;
             { | cField, n | FieldPut( FieldPos( cField ), auValues[ n ] ) } )
      UNLOCK
   endif

return

//----------------------------------------------------------------------------//
