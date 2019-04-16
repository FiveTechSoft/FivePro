#include <ClipApi.h>
#include <dos.h>

extern WORD _F000H;

CLIPPER nBiosPtr()
{
   _retnl( ( LONG ) MK_FP( FP_OFF( &_F000H ), _parni( 1 ) ) );
}
