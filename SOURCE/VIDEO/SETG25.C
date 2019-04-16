#include <ClipApi.h>

CLIPPER SetG25()
{
   _AX = 0x1202;
   _BL = 0x30;
   asm int 0x10;
}
