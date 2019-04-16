#include <extend.h>
#include <dos.h>

CLIPPER VertRetrac()
{
   while( ! ( inport( 0x3DA ) & 8 ) );
}
