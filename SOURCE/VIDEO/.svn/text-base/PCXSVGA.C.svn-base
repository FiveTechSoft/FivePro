#include <stdio.h>
#include <dos.h>
#include <ClipApi.h>

#define SELDAC 0x3C8
#define IORGB  0x3C9

#define BUFSIZE 4000

extern WORD wVesaRows, wVesaCols;

void SetPixel( WORD, WORD, WORD );

typedef struct
{
   BYTE bId;
   BYTE bVersion;
   BYTE bSystem;
   BYTE bBitsByPixels;
   WORD wLeft, wTop, wRight, wBottom;
   WORD wResHor, wResVert;
   BYTE bPalette[ 48 ];
   BYTE bReserved;
   BYTE bPlanes;
   WORD wBytesByLine;
} PCX;

typedef struct { BYTE Red, Green, Blue; } PCXRGB;

static WORD wMin( WORD w1, WORD w2 ) { return ( w1 <= w2 ) ? w1: w2; }

//----------------------------------------------------------------------------//

static void SetPalette( PCXRGB * pRgb )
{
   WORD w;

   for( w = 0; w < 256; w++ )
   {
      outportb( SELDAC, w );
      outportb( IORGB, pRgb[ w ].Red / 4 );
      outportb( IORGB, pRgb[ w ].Green / 4 );
      outportb( IORGB, pRgb[ w ].Blue / 4 );
   }
}

//----------------------------------------------------------------------------//

void PcxSVGA( LPSTR szFileName, WORD wTop, WORD wLeft, WORD wBottom, WORD wRight )
{
   WORD wHandle;
   BYTE bBuffer[ BUFSIZE ], bByte;
   PCX  pcx;
   WORD wOffset     = 128;
   WORD wRow        = wTop;
   WORD wCol;
   WORD wCount, y;
   PCXRGB rgb[ 256 ];

   wBottom = wBottom ? wBottom: wVesaRows - 1 - wTop;
   wRight  = wRight ? wRight: wVesaCols - 1 - wLeft;

   if( ! ( wHandle = _topen( szFileName, 0 ) ) )
      return;

   _tlseek( wHandle, -769, 2 );
   _tread( wHandle, &y, 1 );

   // if( y == 0x0C )
   // {
      _tread( wHandle, rgb, 768 );
      SetPalette( rgb );
   // }

   _tlseek( wHandle, 0, 0 );
   _tread( wHandle, bBuffer, BUFSIZE );
   _bcopy( ( BYTE * ) &pcx, bBuffer, 128 );

   while( wRow < wMin( wTop + pcx.wBottom - pcx.wTop, wBottom ) )
   {
      wCol = wLeft;
      while( wCol < pcx.wBytesByLine + wLeft )
      {
         if( wOffset == BUFSIZE )
         {
            wOffset = 0;
            _tread( wHandle, bBuffer, BUFSIZE );
         }
         if( ( bByte = bBuffer[ wOffset++ ] ) > 0xC0 )
         {
            wCount = bByte - 0xC0;
            if( wOffset == BUFSIZE )
            {
               wOffset = 0;
               _tread( wHandle, bBuffer, BUFSIZE );
            }
            bByte  = bBuffer[ wOffset++ ];
            for( y = 1; y <= wCount; y++ )
            {
               if( wCol <= wRight )
                   SetPixel( wRow, wCol, bByte );
               wCol++;
             }
         }
         else
         {
            if( wCol <= wRight )
               SetPixel( wRow, wCol, bByte );
            wCol++;
         }
      }
      wRow++;
   }
   _tclose( wHandle );
}

//----------------------------------------------------------------------------//

CLIPPER PCXSVGA()
{
   PcxSVGA( _parc( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ), _parni( 5 ) );
}

//----------------------------------------------------------------------------//
