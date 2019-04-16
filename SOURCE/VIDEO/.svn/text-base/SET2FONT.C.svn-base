#include <ClipApi.h>

CLIPPER SetTwoFont()
{
  BYTE bBlocks = ( _parni( 2 ) << 2 ) | _parni( 1 );

  _AX = 0x1103;
  _BL = bBlocks;
  asm int 0x10;
}
