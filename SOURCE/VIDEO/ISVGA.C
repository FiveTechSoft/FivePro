#include <dos.h>
#include "extend.h"

CLIPPER lIsVga()
{
   unsigned char ucVga = 0;

   _AX = 0x1A00;
   geninterrupt( 0x10 );

   if( _AL == 0x1A )
   {
     switch( _BL )
     {
        case  7:
        case  8:
        case 11:
        case 12:
             ucVga = 1;
             break;
     }
   }

   _retl( ucVga );
}
