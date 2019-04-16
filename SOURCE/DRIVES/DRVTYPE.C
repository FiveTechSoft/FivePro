/* Devuelve el tipo de Drive:
       0 Desconocido
       1 360K, 5.25, 40 pistas
       2 1.2M, 5.25, 80 pistas
       3 720K, 3.5 , 80 pistas
       4 1.4M, 3.5 , 80 pistas ???
*/

#include "extend.h"
#include <dos.h>

CLIPPER nDriveType()
{
   char cDrive = _parni( 1 );
   char cType = 1;

   _AH = 8;
   _DL = cDrive;
   geninterrupt( 0x13 );
   cType = _BL;

   _retni( cType );
}
