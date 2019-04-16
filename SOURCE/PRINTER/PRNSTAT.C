#include <dos.h>
#include "extend.h"

CLIPPER nPrnStatus()
{
   unsigned int uiPort = _parni( 1 );
   unsigned char ucStatus;

   asm mov ah, 2;
   asm mov dx, uiPort;
   asm int 0x17;
   asm mov ucStatus, ah;

   _retnl( ucStatus );
}
