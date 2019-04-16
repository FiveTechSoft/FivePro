#include <process.h>

typedef unsigned long LONG;

void main()
{
   LONG lSectores, lClusters, lBytes;

   _DL = 0;
   _AH = 0x36;
   asm int 0x21;

   lSectores = _AX;
   lClusters = _BX;
   lBytes    = _CX;

   if( ( lSectores * lClusters * lBytes ) < 4000000 )
      exit( 1 );
}
