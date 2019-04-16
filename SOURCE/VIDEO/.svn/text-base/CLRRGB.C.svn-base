#include <extend.h>
#include <dos.h>

typedef unsigned char BYTE;

void _reta( unsigned int );

typedef struct
{
   BYTE Red, Green, Blue;
} RGB;

CLIPPER aColorRGB()
{
   RGB rgbColor;

   _reta( 3 );

   _BX = _parni( 1 );
   _CX = 1;
   _ES = FP_SEG( &rgbColor );
   _DX = FP_OFF( &rgbColor );
   _AX = 0x1017;
   asm int 0x10;

   _storni( rgbColor.Red,   -1, 1 );
   _storni( rgbColor.Green, -1, 2 );
   _storni( rgbColor.Blue,  -1, 3 );
}
