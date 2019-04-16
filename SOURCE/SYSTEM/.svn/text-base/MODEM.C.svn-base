#include <dos.h>
#include <extend.h>

CLIPPER lModem()
{
   unsigned int uiEquipment = peek( 0, 0x410 );

   _retl( uiEquipment & 0x2000 );
}
