//----------------------------------------------------------------------------//

function nAMaxLen( aArray )

   local n
   local nLen := 0

   for n = 1 to Len( aArray )
      nLen = Max( Len( aArray[ n ] ), nLen )
   next

return nLen

//----------------------------------------------------------------------------//
