#include <ClipApi.h>
#include <dos.h>

//----------------------------------------------------------------------------//

typedef struct
{
   WORD wInfo;
   LONG lSerie;
   BYTE bName[ 11 ];
   BYTE bFat[ 8 ];
} INFO;

//----------------------------------------------------------------------------//

CLIPPER VolSerie()
{
   INFO Info;

   asm push ds;

   _DS = FP_SEG( &Info );
   _DX = FP_OFF( &Info );

   _BL = 3;
   _AL = 0;
   _AH = 0x69;

   asm int 0x21;

   asm pop ds;

   _retnl( Info.lSerie );
}

//----------------------------------------------------------------------------//
