//----------------------------------------------------------------------------//

function Main( cFileName )

   if PCount() == 1

      TxtEval( cFileName, { | cLine | Process( cLine ) } )
   endif

return

//----------------------------------------------------------------------------//

function Process( cLine, n )

   ? cLine

return

/*

   local nWinApi := At( "WINAPI", cLine )
   local nParentesis
   local cTemp

   if nWinApi != 0
      nWinApi += 6
      // while SubStr( cLine, nWinApi++, 1 ) == Chr( 32 ) ; end
      nParentesis = At( "(", cLine )
      if nParentesis - --nWinApi <= 10
         ?  cLine
         // ?? PadR( cTemp := SubStr( cLine, nWinApi, nParentesis - nWinApi ), 20 )
         // ?? "_"
         // ?? cTemp
      endif
   endif

return

*/

//----------------------------------------------------------------------------//
