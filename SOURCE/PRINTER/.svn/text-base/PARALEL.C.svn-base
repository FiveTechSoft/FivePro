#include <dos.h>
#include "extend.h"

CLIPPER nParallels()
{
   unsigned int uiEquipment = peek( 0, 0x410 );

   _retni( ( uiEquipment & 0xC000 ) >> 14 );
}
