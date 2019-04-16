#include <dos.h>
#include <extend.h>

CLIPPER nCmosMemE()
{
   unsigned char ucLowMem = 0, ucHighMem = 0;

   outportb( 0x70, 0x17 );
   ucLowMem = inportb( 0x71 );
   outportb( 0x70, 0x18 );
   ucHighMem = inportb( 0x71 );

   _retni( ( ucHighMem * 256 ) + ucLowMem );
}
