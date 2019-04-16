//----------------------------------------------------------------------------//

function cEncripta( cText )

   local n
   local cChar1, cChar2, cResult

   cText += Chr( Random255() )

   for n = 9 to 1 step -1
       cChar1  = SubStr( cText, n + 1, 1 )
       cChar2  = SubStr( cText, n, 1 )
       cResult = Left( cText, n - 1 ) + Chr( Asc( cChar2 ) + ;
                 Asc( cChar1 ) % 87 ) + Right( cText, 10 - n )
   next

return cResult

//----------------------------------------------------------------------------//

function cDesEncripta( cText )

   local n
   local cChar1, cChar2, cResult

   for n = 1 to 9
       cChar1  = SubStr( cText, n + 1, 1 )
       cChar2  = SubStr( cText, n, 1 )
       cResult = Left( cText, n - 1 ) + Chr( Asc( cChar2 ) - ;
                 Asc( cChar1 ) % 87 ) + Right( cText, 10 - n )
   next

return Left( cResult, 9 )

//----------------------------------------------------------------------------//

function Random255()

   local cTime := Time()
   local n     := Val( SubStr( cTime, 5, 1 ) + SubStr( cTime, 7, 2 ) )

return n % 256

//----------------------------------------------------------------------------//
