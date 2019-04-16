#include <extend.h>

CLIPPER cDosVer()
{
   unsigned char ucMayor, ucMinor;
   unsigned char aucDosVer[ 5 ];

   _AH     = 0x30;
   asm int 0x21;
   ucMayor = _AL;
   ucMinor = _AH;

   aucDosVer[ 0 ] = ucMayor + 48;
   aucDosVer[ 1 ] = '.';
   aucDosVer[ 2 ] = ucMinor + 48;
   aucDosVer[ 3 ] = 48;
   aucDosVer[ 4 ] = 0;

   _retc( aucDosVer );
}
