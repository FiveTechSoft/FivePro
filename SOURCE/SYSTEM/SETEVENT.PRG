static aEvents := {}

//----------------------------------------------------------------------------//

function SetEvent( bAction, nTime )

   AAdd( aEvents, { If( nTime == nil, 1, nTime ) * 3, bAction } )

   if Len( aEvents ) == 1
      Events()
   endif

return

//----------------------------------------------------------------------------//
