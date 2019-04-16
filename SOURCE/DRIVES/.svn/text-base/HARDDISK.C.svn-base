#include "extend.h"

CLIPPER nHardDisks()
{
   unsigned char n;

   asm mov ah, 8;
   asm mov dl, 0x80;
   asm int 0x13;
   asm mov n, dl;

   _retni( n );
}
