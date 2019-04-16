#include <stdio.h>
#include <dos.h>
#include <ClipApi.h>

#define SELDAC 0x3C8
#define IORGB  0x3C9

#define BUFSIZE 3000

#define ANCHO    640
#define ALTO     400

extern WORD maxx, maxy, xwidth;
void point( WORD, WORD, WORD );

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

void PcxSVGA( LPSTR szFileName, WORD wStartRow, WORD wStartCol )
{
   WORD wHandle;
   BYTE bBuffer[ BUFSIZE ], bByte;
   PCX  pcx;
   WORD wOffset     = 128;
   WORD wTop        = wStartRow * 16;
   WORD wLeft       = wStartCol * 8;
   WORD wRow        = wTop;
   WORD wCol;
   WORD wCount, y;
   PCXRGB rgb[ 256 ];

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

   while( wRow < wMin( wTop + pcx.wBottom - pcx.wTop, ALTO - 1 ) )
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
                point( wCol++, wRow, bByte );
         }
         else
            point( wCol++, wRow, bByte );
      }
      wRow++;
   }
   _tclose( wHandle );
}

//----------------------------------------------------------------------------//

CLIPPER PCXSVGA()
{
   PcxSVGA( _parc( 1 ), _parni( 2 ), _parni( 3 ) );
}

//----------------------------------------------------------------------------//
