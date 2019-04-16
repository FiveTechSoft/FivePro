#include <extend.h>
#include <dos.h>

typedef unsigned char BYTE;

typedef struct
{
   BYTE Red, Green, Blue;
} RGB;

//----------------------------------------------------------------------------//

CLIPPER ColorSet()
{
   BYTE bClr = _parni( 1 );
   quant w, wStep   = _parni( 3 );
   RGB rgbFrom, rgbTo, rgbTemp;

   _BX = bClr;
   _CX = 1;
   _ES = FP_SEG( &rgbFrom );
   _DX = FP_OFF( &rgbFrom );
   _AX = 0x1017;
   asm int 0x10;

   rgbTo.Red   = _parni( 2, 1 );
   rgbTo.Green = _parni( 2, 2 );
   rgbTo.Blue  = _parni( 2, 3 );

   for( w = 0; w < wStep; w++ )
   {
      if( rgbTo.Red > rgbFrom.Red )
         rgbTemp.Red = rgbFrom.Red + ( ( rgbTo.Red - rgbFrom.Red ) * w ) / wStep;
      else
         rgbTemp.Red = rgbFrom.Red - ( ( rgbFrom.Red - rgbTo.Red ) * w ) / wStep;

      if( rgbTo.Green > rgbFrom.Green )
         rgbTemp.Green = rgbFrom.Green + ( ( rgbTo.Green - rgbFrom.Green ) * w ) / wStep;
      else
         rgbTemp.Green = rgbFrom.Green - ( ( rgbFrom.Green - rgbTo.Green ) * w ) / wStep;

      if( rgbTo.Blue > rgbFrom.Blue )
         rgbTemp.Blue = rgbFrom.Blue + ( ( rgbTo.Blue - rgbFrom.Blue ) * w ) / wStep;
      else
         rgbTemp.Blue = rgbFrom.Blue - ( ( rgbFrom.Blue - rgbTo.Blue ) * w ) / wStep;

      while( ! ( inport( 0x3DA ) & 8 ) );
      _BX = bClr;
      _CX = 1;
      _ES = FP_SEG( &rgbTemp );
      _DX = FP_OFF( &rgbTemp );
      _AX = 0x1012;
      asm int 0x10;
   }

   while( ! ( inport( 0x3DA ) & 8 ) );
   _BX = bClr;
   _CX = 1;
   _ES = FP_SEG( &rgbTo );
   _DX = FP_OFF( &rgbTo );
   _AX = 0x1012;
   asm int 0x10;
}

//----------------------------------------------------------------------------//
