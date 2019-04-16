#include <dos.h>
#include "extend.h"

CLIPPER nLogDrives()
{
   unsigned char nDefaultDrive;

   _AH = 0x19;
   geninterrupt( 0x21 );
   nDefaultDrive = _AL;

   _AH = 0x0E;
   _DL = nDefaultDrive;
   geninterrupt( 0x21 );

   _retni( _AL );
}
