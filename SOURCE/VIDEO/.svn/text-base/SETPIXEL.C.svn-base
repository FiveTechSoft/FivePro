#include <ClipApi.h>
#include <dos.h>

extern WORD wVesaCols;

void VesaBank( WORD );

//----------------------------------------------------------------------------//

void SetPixel( WORD wRow, WORD wCol, BYTE bColor )
{
   WORD wOffset;

   _BX = wVesaCols;
   _AX = wRow;
   _CX = wCol;
   _DX = 0;
   asm mul bx;
   asm add ax, cx;
   asm adc dx, 0;
   wOffset = _AX;

   VesaBank( _DX );

   * ( ( LPBYTE ) 0xA0000000 + wOffset ) = bColor;
}

//----------------------------------------------------------------------------//

CLIPPER SETPIXEL()
{
   SetPixel( _parni( 1 ), _parni( 2 ), _parni( 3 ) );
}

//----------------------------------------------------------------------------//
