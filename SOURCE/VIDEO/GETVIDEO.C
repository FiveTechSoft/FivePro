#include <dos.h>
#include "extend.h"

CLIPPER nGetVideo()
{
   _AH = 0x0F;
   geninterrupt( 0x10 );
   _retni( _AL );
}
