#include <dos.h>
#include <extend.h>

CLIPPER nCmosMemB()
{
   unsigned char ucLowMem = 0, ucHighMem = 0;

   outportb( 0x70, 0x15 );
   ucLowMem = inportb( 0x71 );
   outportb( 0x70, 0x16 );
   ucHighMem = inportb( 0x71 );

   _retni( ( ucHighMem * 256 ) + ucLowMem );
}
