#include "extend.h"
#define BYTE unsigned char

static BYTE nError;

CLIPPER nVrfSector()
{
   BYTE nDriveNumber    = _parni( 1 );
   BYTE nCylinderNumber = _parni( 2 );
   BYTE nSectorNumber   = _parni( 3 );
   BYTE nHeadNumber     = _parni( 4 );
   char nResult;

   asm mov ah, 4;
   asm mov al, 1;
   asm mov ch, nCylinderNumber;
   asm mov cl, nSectorNumber;
   asm mov dh, nHeadNumber;
   asm mov dl, nDriveNumber;
   asm int 0x13;
   asm mov nError, ah;
   asm pushf;
   asm pop ax;
   asm and al, 1;                             /* CF */
   asm mov nResult, al;

   _retni( nResult == 0 ? 0 : -1 );
}

CLIPPER nVrfSctErr()
{
   _retni( nError );
}
