#include <ClipApi.h>
#include <dos.h>

#define ZERO_FLAG 0x40

CLIPPER lKeyCheck()
{
   WORD wKey;

   _AH = 1;
   asm int 0x16;
   wKey = ( _FLAGS & ZERO_FLAG ) ? 0: _AX;

   if( wKey == _parni( 1 ) )
   {
      _AX = 0;
      asm int 0x16;
      _retl( 1 );
   }

   _retl( 0 );
}
