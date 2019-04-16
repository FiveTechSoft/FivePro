#include "SVGA.h"
#include <ClipApi.h>
#include <dos.h>

void SetPixel( WORD, WORD, WORD );

extern WORD wClrFore, wClrBack;

static BYTE bFont[ 8192 ];

//----------------------------------------------------------------------------//

CLIPPER TEXTFONT()
{
   asm cli;
   outport( 0x3C4, 0x0402 );
   outport( 0x3C4, 0x0704 );
   outport( 0x3C4, 0x0300 );
   asm sti;

   outport( 0x3CE, 0x0204 );
   outport( 0x3CE, 0x0005 );
   outport( 0x3CE, 0x0006 );

   _bcopy( bFont, ( LPBYTE ) 0xA0000000, 8192 );

   asm cli;
   outport( 0x3C4, 0x0302 );
   outport( 0x3C4, 0x0304 );
   outport( 0x3C4, 0x0300 );
   asm sti;

   outport( 0x3CE, 0x0004 );
   outport( 0x3CE, 0x1005 );
   outport( 0x3CE, 0x0E06 );
}

//----------------------------------------------------------------------------//

CLIPPER SETTEXT()
{
   _AH = 0;
   _AL = 3;
   asm int 0x10;
}

//----------------------------------------------------------------------------//

CLIPPER SETPIXEL()
{
   SetPixel( _parni( 1 ), _parni( 2 ), _parni( 3 ) );
}

//----------------------------------------------------------------------------//

void HorLine( WORD wRow, WORD wCol, WORD wLen, WORD wColor )
{
   WORD w;

   for( w = wCol; w < wCol + wLen; w++ )
      SetPixel( wRow, w, wColor );
}

//----------------------------------------------------------------------------//

void VerLine( WORD wRow, WORD wCol, WORD wLen, WORD wColor )
{
   WORD w;

   for( w = wRow; w < wRow + wLen; w++ )
      SetPixel( w, wCol, wColor );
}

//----------------------------------------------------------------------------//

CLIPPER HORLINE()
{
   HorLine( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ) );
}

//----------------------------------------------------------------------------//

CLIPPER VERLINE()
{
   VerLine( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ) );
}

//----------------------------------------------------------------------------//

void Fill( WORD wStartTop, WORD wStartLeft, WORD wStartBottom,
           WORD wStartRight, WORD wColor )
{
   WORD wTop    = wStartTop    * 16;
   WORD wLeft   = wStartLeft   *  8;
   WORD wBottom = ( wStartBottom * 16 ) + 15;
   WORD wRight  = ( wStartRight  *  8 ) + 7;
   WORD wWidth  = wRight - wLeft + 1;
   WORD wRow;

   for( wRow = wTop; wRow <= wBottom; wRow++ )
      HorLine( wRow, wLeft, wWidth, wColor );
}

//----------------------------------------------------------------------------//

CLIPPER FILL()
{
   Fill( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ), _parni( 5 ) );
}

//----------------------------------------------------------------------------//

CLIPPER CHARFILL()
{
   WORD wTop   = _parni( 1 ) * 16;
   WORD wLeft  = _parni( 2 ) *  8;
   WORD wColor = _parni( 3 );
   WORD wRow;

   for( wRow = wTop; wRow <= wTop + 16; wRow++ )
      HorLine( wRow, wLeft, 8, wColor );
}

//----------------------------------------------------------------------------//

void SayChar( WORD wStartRow, WORD wStartCol, WORD wChar )
{
   WORD wRow = wStartRow * 16;
   WORD wCol = wStartCol *  8;
   WORD wCharRow, wBitPos;
   BYTE bByte, bMask;

   for( wCharRow = 0; wCharRow < 16; wCharRow++ )
   {
      bByte = bFont[ ( ( unsigned int ) wChar * 32 ) + wCharRow ];
      bMask = 128;

      if( ! bByte )
      {
         for( wBitPos = 0; wBitPos < 8; wBitPos++ )
            SetPixel( wRow + wCharRow, wCol + wBitPos, wClrBack );
      }
      else
      {
         for( wBitPos = 0; wBitPos < 8; wBitPos++ )
         {
            SetPixel( wRow + wCharRow, wCol + wBitPos,
                   ( bByte & bMask ) ? wClrFore: wClrBack );
            bMask >>= 1;
         }
      }
   }
}

//----------------------------------------------------------------------------//

CLIPPER SAYCHAR()
{
   SayChar( _parni( 1 ), _parni( 2 ), _parni( 3 ) );
}

//----------------------------------------------------------------------------//
