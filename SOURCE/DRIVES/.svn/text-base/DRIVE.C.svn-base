#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER cDrive()            // Devuelve la letra del Drive por defecto
{
   unsigned char nDrive;
   char cResult[ 2 ];

   asm mov ah, 0x19;
   asm int 0x21;
   asm mov nDrive, al;

   cResult[ 0 ] = nDrive + 65;
   cResult[ 1 ] = 0;

   _retc( cResult );
}

//----------------------------------------------------------------------------//
