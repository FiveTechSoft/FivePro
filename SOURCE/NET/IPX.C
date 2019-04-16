#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER lIsIpx()               // Comprueba si IPX est  instalado
{
   _AX = 0x7A00;
   asm int 0x2F;
   _retl( _AL == 0xFF );
}

//----------------------------------------------------------------------------//

CLIPPER IpxNewSock()   // et
{
   WORD wSocket = _parni( 1 );
   WORD wSwap   = ( ( wSocket & 0x00FF ) << 8 ) | ( ( wSocket & 0xFF00 ) >> 8 );

   _DX = wSwap;
   _BX = 0;
   _AL = 0xFF;
   _AH = 0;
   asm int 0x7A;
   _retl( ! _AL );
}

//----------------------------------------------------------------------------//
