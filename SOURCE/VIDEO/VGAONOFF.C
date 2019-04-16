#include <dos.h>
#include <extend.h>

typedef struct
{
   unsigned char ucRed, ucGreen, ucBlue;
} RGB;

static RGB aRegs[ 256 ];
static unsigned char ucSaved;

// ----------------------------------------------------------------------------

static void Save( void )
{
   if( ! ucSaved )
   {
      ucSaved = 1;
      _BX = 0;
      _CX = 255;
      _ES = FP_SEG( aRegs );
      _DX = FP_OFF( aRegs );
      _AX = 0x1017;
      asm int 0x10;
   }
}

// ----------------------------------------------------------------------------

CLIPPER VgaBlack()
{
   RGB rgbNull[ 256 ];
   unsigned int ui;

   for( ui = 0; ui < 256; ui++ )
   {
      rgbNull[ ui ].ucRed   = 0;
      rgbNull[ ui ].ucGreen = 0;
      rgbNull[ ui ].ucBlue  = 0;
   }

   Save();

   while( ! ( inport( 0x3DA ) & 8 ) );
   _BX = 0;
   _CX = 255;
   _ES = FP_SEG( rgbNull );
   _DX = FP_OFF( rgbNull );
   _AX = 0x1012;
   asm int 0x10;
}

// ----------------------------------------------------------------------------

CLIPPER VgaOff()
{
   RGB aTempRegs[ 256 ];
   unsigned char uc;
   unsigned int uiReg;

   Save();

   for( uc = 150; uc > 0; uc-- )
   {
      for( uiReg = 0; uiReg < 256; uiReg++ )
      {
         aTempRegs[ uiReg ].ucRed   = ( aRegs[ uiReg ].ucRed * uc ) / 150;
         aTempRegs[ uiReg ].ucGreen = ( aRegs[ uiReg ].ucGreen * uc ) / 150;
         aTempRegs[ uiReg ].ucBlue  = ( aRegs[ uiReg ].ucBlue * uc ) / 150;
      }

      while( ! ( inport( 0x3DA ) & 8 ) );
      _BX = 0;
      _CX = 256;
      _ES = FP_SEG( aTempRegs );
      _DX = FP_OFF( aTempRegs );
      _AX = 0x1012;
      asm int 0x10;
   }
}

// ----------------------------------------------------------------------------

CLIPPER VgaOn()
{
   RGB aTempRegs[ 256 ];
   unsigned char uc;
   unsigned int uiReg;

   if( ! ucSaved )
      return;

   for( uc = 0; uc < 150; uc++ )
   {
      for( uiReg = 0; uiReg < 256; uiReg++ )
      {
         aTempRegs[ uiReg ].ucRed   = ( aRegs[ uiReg ].ucRed * uc ) / 150;
         aTempRegs[ uiReg ].ucGreen = ( aRegs[ uiReg ].ucGreen * uc ) / 150;
         aTempRegs[ uiReg ].ucBlue  = ( aRegs[ uiReg ].ucBlue * uc ) / 150;
      }

      while( ! ( inport( 0x3DA ) & 8 ) );
      _BX = 0;
      _CX = 256;
      _ES = FP_SEG( aTempRegs );
      _DX = FP_OFF( aTempRegs );
      _AX = 0x1012;
      asm int 0x10;
   }
}

// ----------------------------------------------------------------------------
