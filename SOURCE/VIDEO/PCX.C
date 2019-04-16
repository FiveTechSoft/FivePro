#include <stdio.h>
#include <dos.h>
#include <ClipApi.h>

#define BUFSIZE 2000

typedef struct
{
   BYTE bId;
   BYTE bVersion;
   BYTE bSystem;
   BYTE bBitsByPixels;
   WORD wLeft, wTop, wRight, wDown;
   WORD wResHor, wResVert;
   BYTE bPalette[ 48 ];
   BYTE bReserved;
   BYTE bPlanes;
   WORD wBytesByLine;
} PCX;

static WORD wMin( WORD w1, WORD w2 ) { return ( w1 <= w2 ) ? w1: w2; }

void SetEgaPal( BYTE * pPalette )
{
   BYTE bRegister   = 0;
   BYTE bValue      = 0;
   BYTE bRed[ 4 ]   = { 0x00, 0x20, 0x04, 0x24 };
   BYTE bGreen[ 4 ] = { 0x00, 0x10, 0x02, 0x12 };
   BYTE bBlue[ 4 ]  = { 0x00, 0x08, 0x01, 0x09 };

   while( bRegister < 16 )
   {
      bValue = 0;
      bValue += bRed[ ( * pPalette++ ) / 64 ];
      bValue += bGreen[ ( * pPalette++ ) / 64 ];
      bValue += bBlue[ ( * pPalette++ ) / 64 ];
      _AX = 0x1000;
      _BL = bRegister;
      _BH = bValue;
      asm int 0x10;
      bRegister++;
   }
}

/*----------------------------------------------------------------------------*/

CLIPPER PcxDisplay()
{
   int  iHandle;
   BYTE bBuffer[ BUFSIZE ];
   PCX  pcx;
   WORD wOffset     = 128;
   WORD wRowOffset;
   WORD wTop        = ( PCOUNT() > 1 ) ? ( _parni( 2 ) * 14 ): 0;
   WORD wLeft       = ( PCOUNT() > 1 ) ? _parni( 3 ): 0;
   WORD wRow        = wTop;
   WORD wCol;
   BYTE bByte, bPlane;
   WORD wCount, y;
   char * pcVideo    = ( char * ) 0xA0000000;

   if( ( iHandle = _topen( _parc( 1 ), 0 ) ) == -1 )
      return;

   _tread( iHandle, bBuffer, BUFSIZE );
   _bcopy( &pcx, bBuffer, 128 );

   if( ! _parl( 4 ) );
   {
      if( pcx.bVersion == 2 || pcx.bVersion == 5 )
         SetEgaPal( pcx.bPalette );
   }

   outportb( 964, 2 );

   while( wRow < wMin( wTop + pcx.wDown - pcx.wTop, 479 ) )
   {
      wRowOffset  = wRow * 80;
      for( bPlane = 0; bPlane < pcx.bPlanes; bPlane++ )
      {
         outportb( 965, 1 << bPlane );
         wCol = wLeft;
         while( wCol < pcx.wBytesByLine + wLeft )
         {
            if( wOffset == BUFSIZE )
            {
               wOffset = 0;
               _tread( iHandle, bBuffer, BUFSIZE );
            }
            if( ( bByte = bBuffer[ wOffset++ ] ) > 0xC0 )
            {
               wCount = bByte - 0xC0;
               if( wOffset == BUFSIZE )
               {
                  wOffset = 0;
                  _tread( iHandle, bBuffer, BUFSIZE );
               }
               bByte  = bBuffer[ wOffset++ ];
               for( y = 1; y <= wCount; y++ )
                  pcVideo[ wRowOffset + wCol++ ] = bByte;
            }
            else
               pcVideo[ wRowOffset + wCol++ ] = bByte;
         }
      }
      wRow++;
   }
   outportb( 965, 15 );
   _tclose( iHandle );
}

/*----------------------------------------------------------------------------*/
