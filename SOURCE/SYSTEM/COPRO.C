#include <dos.h>
#include <extend.h>

CLIPPER lCoPro()
{
   unsigned int uiEquipment = peek( 0, 0x410 );

   _retl( uiEquipment & 2 );
}
