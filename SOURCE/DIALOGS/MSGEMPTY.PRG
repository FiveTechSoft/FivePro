//----------------------------------------------------------------------------//

function lMsgEmpty( cValue, cMessage )

   local lEmpty := Empty( cValue )

   if lEmpty
      nMsgBox( cMessage, "Atenci¢n", "   &Ok   " )
   endif

return ! lEmpty

//----------------------------------------------------------------------------//
