#include "FivePro.ch"

#define ACTUAL 1
#define TOTAL  2
#define OGET   3

//----------------------------------------------------------------------------//

function Calc( oWndMain )

   local oWnd, oGet

   DEFINE WINDOW oWnd SIZE 21, 14 TITLE "Calculadora" OF oWndMain NOGROW NOZOOM

   oWnd:Cargo = { 0, 0, nil }

   // SetKey( K_ENTER, { || __KeyBoard( "=" ) } )

   @  2,  2 GET oGet VAR oWnd:Cargo[ ACTUAL ] ;
      PICTURE "@E 99,999,999,999,999" COLOR "N/BG" ;
      OF oWnd WHEN .f.

   oWnd:Cargo[ 3 ] = oGet

   @  3,  1 BUTTON " &/ " OF oWnd ACTION ( oWnd:Cargo[ TOTAL ] /= oWnd:Cargo[ ACTUAL ], oWnd:Cargo[ ACTUAL ] := 0 )
   @  3,  6 BUTTON " &* " OF oWnd ACTION ( oWnd:Cargo[ TOTAL ] *= oWnd:Cargo[ ACTUAL ], oWnd:Cargo[ ACTUAL ] := 0 )
   @  3, 11 BUTTON " &- " OF oWnd ACTION ( oWnd:Cargo[ TOTAL ] -= oWnd:Cargo[ ACTUAL ], oWnd:Cargo[ ACTUAL ] := 0 )
   @  3, 16 BUTTON " &+ " OF oWnd ACTION ( oWnd:Cargo[ TOTAL ] += oWnd:Cargo[ ACTUAL ], oWnd:Cargo[ ACTUAL ] := 0, oWnd:Cargo[ OGET ]:Display() )
   @  5,  1 BUTTON " &7 " OF oWnd ACTION Key( 7, oWnd )
   @  5,  6 BUTTON " &8 " OF oWnd ACTION Key( 8, oWnd )
   @  5, 11 BUTTON " &9 " OF oWnd ACTION Key( 9, oWnd )
   @  5, 16 BUTTON " &C " OF oWnd ACTION oWnd:Cargo[ ACTUAL ] := 0
   @  7,  1 BUTTON " &4 " OF oWnd ACTION Key( 4, oWnd )
   @  7,  6 BUTTON " &5 " OF oWnd ACTION Key( 5, oWnd )
   @  7, 11 BUTTON " &6 " OF oWnd ACTION Key( 6, oWnd )
   @  7, 16 BUTTON " &A " OF oWnd ACTION ( oWnd:Cargo[ ACTUAL ] := 0, oWnd:Cargo[ TOTAL ] := 0 )
   @  9,  1 BUTTON " &1 " OF oWnd ACTION Key( 1, oWnd )
   @  9,  6 BUTTON " &2 " OF oWnd ACTION Key( 2, oWnd )
   @  9, 11 BUTTON " &3 " OF oWnd ACTION Key( 3, oWnd )
   @  9, 16 BUTTON " &P " OF oWnd ACTION ( oWnd:End(), KeyPlus( AllTrim( Str( oWnd:Cargo[ TOTAL ] ) ) ) )
   @ 11,  1 BUTTON " &0      " OF oWnd ACTION Key( 0, oWnd )
   @ 11, 11 BUTTON " &. " OF oWnd ACTION oWnd:Cargo[ ACTUAL ] *= 1.0
   @ 11, 16 BUTTON " &= " OF oWnd ACTION ( oWnd:Cargo[ ACTUAL ] := oWnd:Cargo[ TOTAL ], oWnd:Cargo[ ACTUAL ] := 0 )

   ACTIVATE WINDOW oWnd NOWAIT

return

//----------------------------------------------------------------------------//

static function Key( n, oWnd )

   if oWnd:Cargo[ ACTUAL ] < 1000000000000
      oWnd:Cargo[ ACTUAL ] = ( oWnd:Cargo[ ACTUAL ] * 10 ) + n
      oWnd:Cargo[ OGET ]:Display()
   endif

return

//----------------------------------------------------------------------------//
