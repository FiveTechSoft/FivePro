static aArrays := {}

//----------------------------------------------------------------------------//

function ADeepCopy( aTarget, aSource )

   local n, nAt

   ASize( aTarget, Len( aSource ) )
   AAdd( aArrays, aTarget )

   for n = 1 to Len( aSource )
      if ValType( aSource[ n ] ) $ "AO"
         if ( nAt := AScan( aArrays, { | u | u == aSource[ n ] } ) ) == 0
            ADeepCopy( aTarget[ n ], aSource[ n ] )
         else
            ADeepCopy( aTarget[ n ], aArrays[ nAt ] )
         endif
      else
         aTarget[ n ] = aSource[ n ]
      endif
   next

return

//----------------------------------------------------------------------------//
