#include "extend.h"
#include <dos.h>

static char _16LeftRadio[];
static char _16CenterRadio1[];
static char _16RightRadio[];
static char _16CenterRadio2[];
static char _8LeftRadio[];
static char _8CenterRadio1[];
static char _8RightRadio[];
static char _8CenterRadio2[];

static char _16LeftCheck[];
static char _16CenterCheck1[];
static char _16CenterCheck2[];
static char _16RightCheck[];

static char _8LeftCheck[];
static char _8CenterCheck1[];
static char _8CenterCheck2[];
static char _8RightCheck[];

/*----------------------------------------------------------------------------*/

static void SetChar( char pcFontDef[] )
{
   asm push es;
   asm push bp;
   _DH = 0;
   _DL = pcFontDef[ 0 ];
   _ES = FP_SEG( &pcFontDef[ 1 ] );
   _BP = FP_OFF( &pcFontDef[ 1 ] );
   _BX = 0x1000;
   _CX = 1;
   _AX = 0x1100;
   asm int 0x10;
   asm pop bp;
   asm pop es;
}

/*----------------------------------------------------------------------------*/

static unsigned char ucCharRows()
{
   _AH = 0x11;
   _AL = 0x30;
   _BH = 0;
   asm int 0x10;

   return _CX;
}

/*----------------------------------------------------------------------------*/

CLIPPER SetCuaFont()
{
   unsigned char ucRows = ucCharRows();

   switch( ucRows )
   {
      case 16:                                     // 25 Display Rows
           SetChar( _16LeftRadio );
           SetChar( _16CenterRadio1 );
           SetChar( _16RightRadio );
           SetChar( _16CenterRadio2 );
           SetChar( _16LeftCheck );
           SetChar( _16CenterCheck1 );
           SetChar( _16RightCheck );
           SetChar( _16CenterCheck2 );
           break;

      case 14:                                     // 28 Display Rows
           SetChar( _16LeftRadio );
           SetChar( _16CenterRadio1 );
           SetChar( _16RightRadio );
           SetChar( _16CenterRadio2 );
           SetChar( _16LeftCheck );
           SetChar( _16CenterCheck1 );
           SetChar( _16RightCheck );
           SetChar( _16CenterCheck2 );
           break;

      case 8:                                      // 50 Display Rows
           SetChar( _8LeftRadio );
           SetChar( _8CenterRadio1 );
           SetChar( _8RightRadio );
           SetChar( _8CenterRadio2 );
           SetChar( _8LeftCheck );
           SetChar( _8CenterCheck1 );
           SetChar( _8CenterCheck2 );
           SetChar( _8RightCheck );
           break;
   }
}

/*----------------------------------------------------------------------------*/

char _16LeftRadio[]          = { 193,   // Ë
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x1,   // 00000001
                                 0x2,   // 00000010
                                 0x2,   // 00000010
                                 0x4,   // 00000100
                                 0x4,   // 00000100
                                 0x4,   // 00000100
                                 0x4,   // 00000100
                                 0x2,   // 00000010
                                 0x2,   // 00000010
                                 0x1,   // 00000001
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _16CenterRadio1[]       = { 197,   // Î
                                 0x0,   // 00000000
                                0xFE,   // 11111110
                                 0x1,   // 00000001
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x1,   // 00000001
                                0xFE,   // 11111110
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _16RightRadio[]         = { 227,   // Õ
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                0x80,   // 10000000
                                0x80,   // 10000000
                                0x40,   // 01000000
                                0x40,   // 01000000
                                0x40,   // 01000000
                                0x40,   // 01000000
                                0x80,   // 10000000
                                0x80,   // 10000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _16CenterRadio2[]       = { 198,   // Æ
                                 0x0,   // 00000000
                                0xFE,   // 11111110
                                 0x1,   // 00000001
                                 0x0,   // 00000000
                                0x7C,   // 01111100
                                0xFE,   // 11111110
                                0xFE,   // 11111110
                                0xFE,   // 11111110
                                0xFE,   // 11111110
                                0x7C,   // 01111100
                                 0x0,   // 00000000
                                 0x1,   // 00000001
                                0xFE,   // 11111110
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _8LeftRadio[]           = { 193,   // Ë
                                 0x0,   // 00000000
                                 0x3,   // 00000011
                                 0x4,   // 00000100
                                 0x4,   // 00000100
                                 0x4,   // 00000100
                                 0x4,   // 00000100
                                 0x3,   // 00000011
                                 0x0 }; // 00000000

char _8CenterRadio1[]        = { 197,   // Î
                                0xFE,   // 11111110
                                 0x1,   // 00000001
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x1,   // 00000001
                                0xFE }; // 11111110

char _8RightRadio[]          = { 227,   // Õ
                                 0x0,   // 00000000
                                0x80,   // 10000000
                                0x40,   // 01000000
                                0x40,   // 01000000
                                0x40,   // 01000000
                                0x40,   // 01000000
                                0x80,   // 10000000
                                 0x0 }; // 00000000

char _8CenterRadio2[]        = { 198,   // Æ
                                0xFE,   // 11111110
                                 0x1,   // 00000001
                                0x7C,   // 01111100
                                0xFE,   // 11111110
                                0xFE,   // 11111110
                                0x7C,   // 01111100
                                 0x1,   // 00000001
                                0xFE }; // 11111110

char _16LeftCheck[]          = { 219,   // Ñ
                                 0x0,   // 00000000
                                 0x7,   // 00000111
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x7,   // 00000111
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _16CenterCheck1[]       = { 194,   // Ø
                                 0x0,   // 00000000
                                0xFF,   // 11111111
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                0xFF,   // 11111111
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _16CenterCheck2[]       = { 226,   // Ï
                                 0x0,   // 00000000
                                0xFF,   // 00000000
                                 0x0,   // 00000000
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                0x0C,   // 00001100
                                0x0C,   // 00001100
                                0x18,   // 00011000
                                0xB8,   // 10111000
                                0xF0,   // 11110000
                                0x70,   // 01110000
                                 0x0,   // 00000000
                                0xFF,   // 11111111
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _16RightCheck[]         = { 228,   // Ö
                                 0x0,   // 00000000
                                0xE0,   // 11100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0xE0,   // 11100000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0 }; // 00000000

char _8LeftCheck[]           = { 219,   // Ñ
                                 0x7,   // 00000111
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x6,   // 00000110
                                 0x7 }; // 00000111

char _8CenterCheck1[]        = { 194,   // Ø
                                0xFF,   // 11111111
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                 0x0,   // 00000000
                                0xFF }; // 11111111

char _8CenterCheck2[]        = { 226,   // Ï
                                0xFF,   // 11111111
                                 0x6,   // 00000110
                                0x0C,   // 00001100
                                0x18,   // 00011000
                                0xB8,   // 10111000
                                0xF0,   // 11110000
                                0x70,   // 01110000
                                0xFF }; // 11111111

char _8RightCheck[]          = { 228,   // Ö
                                0xE0,   // 11100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0x60,   // 01100000
                                0xE0 }; // 11100000

