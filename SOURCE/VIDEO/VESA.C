#include <dos.h>
#include <ClipApi.h>

#define  _320x200x256  0x013
#define  _640x400x256  0x100
#define  _640x480x256  0x101
#define  _800x600x256  0x103
#define _1024x768x256  0x105

WORD wVesaRows, wVesaCols;

//----------------------------------------------------------------------------//

typedef struct
{
   char  cSignature[ 4 ];
   BYTE  bVersionHi, bVersionLo;
   LPBYTE pOEM;
   BYTE  abCapabilities[ 4 ];
   LPBYTE pOEMmodes;
   BYTE  bReserved[ 238 ];
} VESAINFO;

typedef struct
{
   WORD  wAtributtes;
   BYTE  bWindowA, bWindowB;
   WORD  wGranularity;
   WORD  wWindowSize;
   WORD  wStartA, wStartB;
   LPBYTE pPosFunc;
   WORD  wBytesPerScanLine;
   WORD  wWidth, wHeight;
   BYTE  bCharWidth, bCharHeigth;
   BYTE  bPlanes;
   BYTE  bBitsPerPixel;
   BYTE  bBanks;
   BYTE  bMemoryModel;
   BYTE  bSizeBank;
   BYTE  bReserved[ 0xFF ];
} MODEINFO;

//----------------------------------------------------------------------------//

BOOL lIsVesa( void )
{
   VESAINFO vesa;

   _ES = FP_SEG( &vesa );
   _DI = FP_OFF( &vesa );
   _AX = 0x4F00;
   asm int 0x10;

   return _AH != 0x4F;
}

//----------------------------------------------------------------------------//

CLIPPER LISVESA()
{
   _retl( lIsVesa() );
}

//----------------------------------------------------------------------------//

CLIPPER cVesaVer()
{
   VESAINFO vesa;
   BYTE abVer[ 3 ];

   _ES = FP_SEG( &vesa );
   _DI = FP_OFF( &vesa );
   _AX = 0x4F00;
   asm int 0x10;

   abVer[ 0 ] = vesa.bVersionHi + '0';
   abVer[ 1 ] = '.';
   abVer[ 2 ] = vesa.bVersionLo + '0';

   _retclen( abVer, 3 );
}

//----------------------------------------------------------------------------//

CLIPPER cVesaOem()
{
   VESAINFO vesa;

   _ES = FP_SEG( &vesa );
   _DI = FP_OFF( &vesa );
   _AX = 0x4F00;
   asm int 0x10;

   _retc( vesa.pOEM );
}

//----------------------------------------------------------------------------//

CLIPPER nPlanes()
{
   MODEINFO info;

   _ES = FP_SEG( &info );
   _DI = FP_OFF( &info );
   _AX = 0x4F01;
   asm int 0x10;

   _retclen( &info, 256 );
}

//----------------------------------------------------------------------------//

void VesaBank( WORD wBank )
{
   static WORD wOldBank;

   if( wOldBank != wBank )
   {
      wOldBank = wBank;
      _BX = 0;
      _DX = wBank;
      _AX = 0x4F05;
      asm int 0x10;
   }
}

//----------------------------------------------------------------------------//

CLIPPER VESABANK()
{
   VesaBank( _parni( 1 ) );
}

//----------------------------------------------------------------------------//

void VesaMode( WORD wMode )
{
   switch( wMode )
   {
      case _320x200x256:
         wVesaRows = 200;
         wVesaCols = 320;
         break;

      case _640x400x256:
         wVesaRows = 400;
         wVesaCols = 640;
         break;

      case _640x480x256:
         wVesaRows = 480;
         wVesaCols = 640;
         break;

      case _800x600x256:
         wVesaRows = 600;
         wVesaCols = 800;
         break;

      case _1024x768x256:
         wVesaRows = 768;
         wVesaCols = 1024;
         break;
   }

   _BX = wMode;
   _AX = 0x4F02;
   asm int 0x10;
}

//----------------------------------------------------------------------------//

CLIPPER VESAMODE()
{
   VesaMode( _parni( 1 ) );
}

//----------------------------------------------------------------------------//
