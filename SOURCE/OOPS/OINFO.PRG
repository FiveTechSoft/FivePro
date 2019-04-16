static aObjects := {}

//----------------------------------------------------------------------------//

function aOInfo( oObject )

   local aData := aOData( oObject )
   local aInfo := {}
   local uData, n

   for n = 1 to Len( aData )
      uData = OSend( oObject, aData[ n ] )
      AAdd( aInfo, PadR( aData[ n ], 11 ) + ": " + cValToStr( uData ) )
   next

return aInfo

//----------------------------------------------------------------------------//
