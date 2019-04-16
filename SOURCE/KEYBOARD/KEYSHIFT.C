#include <dos.h>
#include "extend.h"

CLIPPER lKeyShift()                  // Comprueba pulsaci¢n may£sculas
{
   _retl( peekb( 0, 0x417 ) & 3 );
}
