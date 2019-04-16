#include "extend.h"

CLIPPER nPrnCount()
{
   unsigned int uiEquipmentCode;

   asm int 0x11;
   asm mov uiEquipmentCode, ax;

   _retni( ( uiEquipmentCode & 0xC0 ) / 64 );
}
