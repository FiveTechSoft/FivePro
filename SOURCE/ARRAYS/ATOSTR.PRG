#include "FivePro.ch"

//----------------------------------------------------------------------------//

function cAToStr( aArray, nTab )

   local cResult := ""
   local n

   DEFAULT nTab := 0

   for n = 1 to Len( aArray )
      if ValType( aArray[ n ] ) == "A"
         cResult += cAToStr( aArray[ n ], nTab + 3 )
      else
         cResult += Chr( 13 ) + Chr( 10 ) + Space( nTab ) + aArray[ n ]
      endif
   next

return SubStr( cResult, 3 )

//----------------------------------------------------------------------------//
