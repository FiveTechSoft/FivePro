#include <ClipApi.h>
#include "dos.h"

#define DRV_A 0
#define DRV_B 1
#define DRV_C 2

static WORD wError;

CLIPPER cAbsRead()
{
   BYTE byDrive        = _parni( 1 );
   WORD wSectorNumber  = _parni( 2 );
   BYTE byBuffer[ 512 ];
   WORD wBufferSegment = FP_SEG( byBuffer );
   WORD wBufferOffset  = FP_OFF( byBuffer );
   char cResult;

   asm push ds;
   asm mov cx, 1;                    // n£mero de sectores a leer
   asm mov dx, wSectorNumber;
   asm mov ds, wBufferSegment;
   asm mov bx, wBufferOffset;
   asm mov al, byDrive;
   asm int 0x25;
   asm mov wError, ax;
   asm pop ax;                       // retira los FLAGS del Stack
   asm pop ds;
   asm and ax, 1;                    // Test CF
   asm mov cResult, al;

   _retclen( byBuffer, cResult == 0 ? 512: 0 );
}

CLIPPER nAbsRdErro()
{
   _retni( wError & 0xFF );
}
