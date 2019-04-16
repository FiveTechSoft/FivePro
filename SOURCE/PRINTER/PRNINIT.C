#include "extend.h"

CLIPPER nPrnInit()
{
   unsigned int uiPort = _parni( 1 );
   unsigned char ucStatus;

   asm mov ah, 1;
   asm mov dx, uiPort;
   asm int 0x17;
   asm mov ucStatus, ah;

   _retnl( ucStatus );
}
