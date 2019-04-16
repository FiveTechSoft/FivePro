//----------------------------------------------------------------------------//

function RecCopy( cAlias )

   local nFields := FCount()

   for n = 1 to nFields
       FieldPut( n, ( cAlias )->( FieldGet( n ) ) )
   next

return

//----------------------------------------------------------------------------//
