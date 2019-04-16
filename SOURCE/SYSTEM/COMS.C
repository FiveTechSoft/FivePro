#include <dos.h>
#include <extend.h>

CLIPPER nComs()
{
   unsigned int uiEquipment = peek( 0, 0x410 );

   _retni( ( uiEquipment & 0x0E00 ) >> 9 );
}
