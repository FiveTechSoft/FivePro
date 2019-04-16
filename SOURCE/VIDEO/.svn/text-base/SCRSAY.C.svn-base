#include <dos.h>
#include <extend.h>

CLIPPER ScrSay()
{
   unsigned char ucRow       = _parni( 1 );
   unsigned char ucCol       = _parni( 2 );
   char * szText             = _parc( 3 );
   unsigned int uiLen        = _parclen( 3 );
   unsigned char ucBackColor = _parni( 4 ) >> 4;
   unsigned char ucColor     = ( _parni( 4 ) ^ ucBackColor ) | 128;
   unsigned char ucRight     = ucCol + uiLen - 1;

   asm push AX;
   asm push BX;
   asm push CX;
   asm push DX;
   asm push DS;
   asm push ES;
   asm push SS;
   asm push BP;
   asm push SP;

   _AX = 0x0600;
   _BH = ucBackColor;
   _CH = ucRow;
   _CL = ucCol;
   _DH = ucRow;
   _DL = ucRight;
   geninterrupt( 0x10 );

   _DH = ucRow;
   _DL = ucCol;
   _BH = 0;
   _BL = ucColor;
   _CX = uiLen;
   _ES = FP_SEG( szText );
   _BP = FP_OFF( szText );
   _AH = 0x13;
   _AL = 0;
   geninterrupt( 0x10 );

   asm pop SP;
   asm pop BP;
   asm pop SS;
   asm pop ES;
   asm pop DS;
   asm pop DX;
   asm pop CX;
   asm pop BX;
   asm pop AX;
}

