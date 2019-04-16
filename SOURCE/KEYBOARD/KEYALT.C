#include <ClipApi.h>
#include <dos.h>

// Para modo protegido Blinker 3.0

WORD pascal DosGetBiosSeg( WORD * );

//----------------------------------------------------------------------------//

CLIPPER lKeyAlt()
{
   WORD wBios;
   BYTE bKeyInfo;

   // DosGetBiosSeg( &wBios );
   // bKeyInfo = * ( ( LPBYTE ) MK_FP( wBios, 0 ) + 0x17 );

   bKeyInfo = * ( char * ) 0x00000417;

   _retl( bKeyInfo & 8 );
}

//----------------------------------------------------------------------------//
