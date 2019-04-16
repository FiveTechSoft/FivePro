#include <ClipApi.h>
#include <dos.h>

CLIPPER CgaBlink()
{
   outport( 0x3D9, _parl( 1 ) );

   _BL = 0;
   _AX = 0x1003;
   asm int 0x10;
}
