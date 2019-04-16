function Main()

   Degrada( "B", "W" )
   InKey( 0 )
   Degrada( "B", "G" )
   InKey( 0 )
   Degrada( "b", "RB" )
   InKey( 0 )
   Degrada( "G", "BG" )
   InKey( 0 )

return

//----------------------------------------------------------------------------//

function Degrada( cClrStart, cClrEnd )

   local cBack     := ""
   local aColors   := { "N", "B", "G", "BG", "R", "RB", "GR", "W" }
   local nClrStart := AScan( aColors, Upper( cClrStart ) ) - 1
   local nClrEnd   := AScan( aColors, Upper( cClrEnd ) ) - 1

   cBack += Replicate( " " + Chr( ( nClrStart * 16 ) + 128 ), 240 )
   cBack += Replicate( "°" + Chr( ( nClrStart * 16 ) + nClrEnd + 136 ), 240 )
   cBack += Replicate( "²" + Chr( ( nClrEnd * 16 ) + nClrStart + 136 ), 240 )
   cBack += Replicate( "±" + Chr( ( nClrStart * 16 ) + nClrEnd + 136 ), 240 )
   cBack += Replicate( "±" + Chr( ( nClrEnd * 16 ) + nClrStart + 136 ), 240 )
   cBack += Replicate( "²" + Chr( ( nClrStart * 16 ) + nClrEnd + 136 ), 240 )
   cBack += Replicate( "°" + Chr( ( nClrEnd * 16 ) + nClrStart + 136 ), 240 )
   cBack += Replicate( " " + Chr( ( nClrEnd * 16 ) + 128 ), 320 )

   SetBlink( .f. )
   RestScreen( 0, 0, MaxRow(), MaxCol(), cBack )

return

//----------------------------------------------------------------------------//
