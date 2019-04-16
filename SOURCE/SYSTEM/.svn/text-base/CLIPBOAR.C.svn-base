// (C) Antonio Linares, 1993
// Funciones para la utilizaci¢n del ClipBoard de Windows desde un
// programa Clipper funcionando en una ventana DOS

// Con FiveWin 1.0 esto ser  prehistoria... :-)

#include <extend.h>
#include <dos.h>

#define MAKELONG(low, high) ((unsigned long)(((unsigned int)(low)) | \
                            (((unsigned long)((unsigned int)(high))) << 16)))

//----------------------------------------------------------------------------//

CLIPPER OpenClipbo()
{
   _AX = 0x1701;
   asm int 0x2F;

   _retl( _AX );
}

//----------------------------------------------------------------------------//

CLIPPER SetClipboa()
{
   unsigned int uiFormat = _parni( 1 );
   char * szText         = _parc( 2 );
   unsigned int uiLen    = _parclen( 2 );

   _ES = FP_SEG( szText );
   _BX = FP_OFF( szText );
   _SI = 0;
   _CX = uiLen;
   _DX = uiFormat;
   _AX = 0x1703;
   asm int 0x2F;

   _retl( _AX );
}

//----------------------------------------------------------------------------//

CLIPPER CloseClipb()
{
   _AX = 0x1708;
   asm int 0x2F;

   _retl( _AX );
}

//----------------------------------------------------------------------------//

CLIPPER GetClipboa()
{
   char szBuffer[ 250 ];

   _DX = 7;
   _ES = FP_SEG( szBuffer );
   _BX = FP_OFF( szBuffer );
   _AX = 0x1705;
   asm int 0x2F;

   _retc( szBuffer );
}

//----------------------------------------------------------------------------//

CLIPPER GetClpSize()
{
   unsigned int uiLow, uiHigh;

   _DX = _parni( 1 );
   _AX = 0x1704;
   asm int 0x2F;
   uiLow  = _AX;
   uiHigh = _DX;

   _retnl( MAKELONG( uiLow, uiHigh ) );
}

//----------------------------------------------------------------------------//
