#include "FivePro.ch"

//----------------------------------------------------------------------------//

function Main()

   VesaMode( _640x480x256 )
   PcxSVGA( "Batman.pcx" )

   Inkey( 0 )

   VesaMode( _800x600x256 )
   PcxSVGA( "Batman.pcx" )

   Inkey( 0 )

   VesaMode( _1024x768x256 )
   PcxSVGA( "Batman.pcx" )

   Inkey( 0 )

   VesaMode( _640x480x256 )

   MInit( .t. )

   GWindow( 50, 50, 400, 600, "KimBass.pcx" )
   MOn()

   InKey( 0 )

   SetVideo( 3 )

return

//----------------------------------------------------------------------------//
