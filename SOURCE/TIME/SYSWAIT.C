#include <extend.h>
#include <dos.h>

CLIPPER SysWait()
{
   unsigned int  uiTicks = _parni( 1 );
   unsigned long ulStart = * ( ( unsigned long * )( MK_FP( 0, 0x46C ) ) );

   while( ( * ( ( unsigned long * )( MK_FP( 0, 0x46C ) ) ) - ulStart )
          < uiTicks );
}
