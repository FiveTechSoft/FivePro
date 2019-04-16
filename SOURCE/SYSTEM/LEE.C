#include <ClipApi.h>
#include <dos.h>

CLIPPER PeekWord()
{
   _retnl( peek( _parni( 1 ), _parni( 2 ) ) );
}
