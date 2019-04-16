// Los caracteres que repiten el 8 bit van del 192 al 223 = 31 caracteres.
// Respetamos s¢lo las cajas de trazo simple.
//
// Del:
//      181 - 190      Redefinici¢n zona derecha (no requiere repetici¢n)
//      191 - 198      Lo dejamos igual - Cajas sencillas
//      199 - 204      Rat¢n (seis caracteres)
//      205 - 216      Redefinici¢n zona izquierda (requiere repetici¢n)
//      217 - 218      Lo dejamos igual - resto Cajas sencillas

#define WND_LCLOSE         1
#define WND_LFLOAT         2
#define WND_LGROW          4
#define WND_LHSCROLL       8
#define WND_LICONIZE      16
#define WND_LMAXIMIZED    32
#define WND_LMODAL        64
#define WND_LMINIMIZED   128
#define WND_LSHADOW      256
#define WND_LVSCROLL     512
#define WND_LZOOM       1024

#include <dos.h>
#include <ClipApi.h>

static BOOL bEga = TRUE;

enum { BORDERLEFT = 181,
       CLOSERIGHT,
       MAXIMIZERIGHT,
       MINIMIZERIGHT,
       RESTORERIGHT,
       ARROWUPRIGHT,
       ARROWDNRIGHT,
       ARROWLFRIGHT,
       ARROWRGRIGHT,
       THUMBRIGHT };

enum { BORDERRIGHT = 205,
       CLOSELEFT,
       MAXIMIZELEFT,
       MINIMIZELEFT,
       RESTORELEFT,
       ARROWUPLEFT,
       ARROWDNLEFT,
       ARROWLFLEFT,
       ARROWRGLEFT,
       THUMBLEFT,
       CORNERDLEFT,
       CORNERDRIGHT,
       BORDERUPLEFT  = 195,
       BORDERUPRIGHT = 192,
       BORDERBOTTOM  = 222,
       BORDERTOP     = 217,
       DOUBLELINE    = 219 };

#define FILLCHAR      32

WORD wChars[] = { BORDERRIGHT,
                  CLOSERIGHT,
                  MAXIMIZERIGHT,
                  MINIMIZERIGHT,
                  RESTORERIGHT,
                  CORNERDRIGHT,
                  ARROWUPRIGHT,
                  ARROWDNRIGHT,
                  ARROWLFRIGHT,
                  ARROWRGRIGHT,
                  THUMBRIGHT,

                  BORDERLEFT,
                  CLOSELEFT,
                  MAXIMIZELEFT,
                  MINIMIZELEFT,
                  RESTORELEFT,
                  CORNERDLEFT,
                  ARROWUPLEFT,
                  ARROWDNLEFT,
                  ARROWLFLEFT,
                  ARROWRGLEFT,
                  THUMBLEFT,
                  BORDERUPLEFT,
                  BORDERTOP,
                  BORDERUPRIGHT,
                  BORDERBOTTOM,
                  DOUBLELINE,
                  FILLCHAR };

static unsigned char ucCuaStatus = 0;

static BYTE bArrowUp[ 3 ] = { ARROWUPLEFT, ARROWUPRIGHT };
static BYTE bArrowDn[ 3 ] = { ARROWDNLEFT, ARROWDNRIGHT };
static BYTE bArrowLf[ 3 ] = { ARROWLFLEFT, ARROWLFRIGHT };
static BYTE bArrowRg[ 3 ] = { ARROWRGLEFT, ARROWRGRIGHT };
static BYTE bThumb[ 3 ]   = { THUMBLEFT,   THUMBRIGHT };

//----------------------------------------------------------------------------//

CLIPPER lIsCua()    { _retl( ucCuaStatus ); }
CLIPPER SETEGA()    { bEga = _parl( 1 ); }

//----------------------------------------------------------------------------//

static void SetChar( char * pFontDef )
{
   asm push es;
   asm push bp;
   _DH = 0;
   _DL = pFontDef[ 0 ];
   _ES = FP_SEG( &pFontDef[ 1 ] );
   _BP = FP_OFF( &pFontDef[ 1 ] );
   _BX = 0x1000;
   _CX = 1;
   _AX = 0x1100;
   asm int 0x10;
   asm pop bp;
   asm pop es;
}

//----------------------------------------------------------------------------//

static unsigned char ucCharRows( void )
{
   asm push bp;
   _AH = 0x11;
   _AL = 0x30;
   _BH = 0;
   asm int 0x10;
   asm pop bp;

   return _CX;
}

//----------------------------------------------------------------------------//

CLIPPER BoxFont()
{
   unsigned char ucRows = ucCharRows();

   char EightFill[ 17 ];

   char BorderLeft[ 17 ], BorderRight[ 17 ];

   char _16CloseLeft[ 17 ],    _16CloseRight[ 17 ];
   char _16MaximizeLeft[ 17 ], _16MaximizeRight[ 17 ];
   char _16MinimizeLeft[ 17 ], _16MinimizeRight[ 17 ];
   char _16RestoreLeft[ 17 ],  _16RestoreRight[ 17 ];
   char _16CornerDRight[ 17 ], _16CornerDLeft[ 17 ];

   char _16BorderUpLeft[ 17 ];
   char _16BorderTop[ 17 ];
   char _16BorderUpRight[ 17 ];

   char _16BorderBottom[ 17 ];
   char _16DoubleLine[ 17 ];
   char _16ArrowUpLeft[ 17 ],  _16ArrowUpRight[ 17 ];
   char _16ArrowDnLeft[ 17 ],  _16ArrowDnRight[ 17 ];
   char _16ArrowLfLeft[ 17 ],  _16ArrowLfRight[ 17 ];
   char _16ArrowRgLeft[ 17 ],  _16ArrowRgRight[ 17 ];
   char _16ThumbLeft[ 17 ],    _16ThumbRight[ 17 ];

   char _14CloseLeft[ 15 ],    _14CloseRight[ 15 ];
   char _14MaximizeLeft[ 15 ], _14MaximizeRight[ 15 ];
   char _14MinimizeLeft[ 15 ], _14MinimizeRight[ 15 ];
   char _14RestoreLeft[ 15 ],  _14RestoreRight[ 15 ];
   char _14CornerDRight[ 15 ], _14CornerDLeft[ 15 ];
   char _14BorderBottom[ 15 ];
   char _14DoubleLine[ 15 ];
   char _14ArrowUpLeft[ 15 ],  _14ArrowUpRight[ 15 ];
   char _14ArrowDnLeft[ 15 ],  _14ArrowDnRight[ 15 ];
   char _14ArrowLfLeft[ 15 ],  _14ArrowLfRight[ 15 ];
   char _14ArrowRgLeft[ 15 ],  _14ArrowRgRight[ 15 ];
   char _14ThumbLeft[ 15 ],    _14ThumbRight[ 15 ];

   char _8CloseLeft[ 9 ],    _8CloseRight[ 9 ];
   char _8MaximizeLeft[ 9 ], _8MaximizeRight[ 9 ];
   char _8MinimizeLeft[ 9 ], _8MinimizeRight[ 9 ];
   char _8RestoreLeft[ 9 ],  _8RestoreRight[ 9 ];
   char _8CornerDRight[ 9 ], _8CornerDLeft[ 9 ];
   char _8BorderBottom[ 9 ];
   char _8DoubleLine[ 9 ];
   char _8ArrowUpLeft[ 9 ],  _8ArrowUpRight[ 9 ];
   char _8ArrowDnLeft[ 9 ],  _8ArrowDnRight[ 9 ];
   char _8ArrowLfLeft[ 9 ],  _8ArrowLfRight[ 9 ];
   char _8ArrowRgLeft[ 9 ],  _8ArrowRgRight[ 9 ];
   char _8ThumbLeft[ 9 ],    _8ThumbRight[ 9 ];
   char _8HalfUpBlock[ 9 ];

   * ( BorderLeft +  0 ) =  BORDERLEFT;  // "Ý"
   * ( BorderLeft +  1 ) = 0xC0;  // 11000000
   * ( BorderLeft +  2 ) = 0xC0;  // 11000000
   * ( BorderLeft +  3 ) = 0xC0;  // 11000000
   * ( BorderLeft +  4 ) = 0xC0;  // 11000000
   * ( BorderLeft +  5 ) = 0xC0;  // 11000000
   * ( BorderLeft +  6 ) = 0xC0;  // 11000000
   * ( BorderLeft +  7 ) = 0xC0;  // 11000000
   * ( BorderLeft +  8 ) = 0xC0;  // 11000000
   * ( BorderLeft +  9 ) = 0xC0;  // 11000000
   * ( BorderLeft + 10 ) = 0xC0;  // 11000000
   * ( BorderLeft + 11 ) = 0xC0;  // 11000000
   * ( BorderLeft + 12 ) = 0xC0;  // 11000000
   * ( BorderLeft + 13 ) = 0xC0;  // 11000000
   * ( BorderLeft + 14 ) = 0xC0;  // 11000000
   * ( BorderLeft + 15 ) = 0xC0;  // 11000000
   * ( BorderLeft + 16 ) = 0xC0;  // 11000000

   * ( EightFill +  0 ) = 8;  // ""
   * ( EightFill +  1 ) = 0xFF;  // 11111111
   * ( EightFill +  2 ) = 0xFF;  // 11111111
   * ( EightFill +  3 ) = 0xFF;  // 11111111
   * ( EightFill +  4 ) = 0xFF;  // 11111111
   * ( EightFill +  5 ) = 0xFF;  // 11111111
   * ( EightFill +  6 ) = 0xFF;  // 11111111
   * ( EightFill +  7 ) = 0xFF;  // 11111111
   * ( EightFill +  8 ) = 0xFF;  // 11111111
   * ( EightFill +  9 ) = 0xFF;  // 11111111
   * ( EightFill + 10 ) = 0xFF;  // 11111111
   * ( EightFill + 11 ) = 0xFF;  // 11111111
   * ( EightFill + 12 ) = 0xFF;  // 11111111
   * ( EightFill + 13 ) = 0xFF;  // 11111111
   * ( EightFill + 14 ) = 0xFF;  // 11111111
   * ( EightFill + 15 ) = 0xFF;  // 11111111
   * ( EightFill + 16 ) = 0xFF;  // 11111111

   * ( BorderRight +  0 ) = BORDERRIGHT;  // "Þ"
   * ( BorderRight +  1 ) = 0x01;  // 00000001
   * ( BorderRight +  2 ) = 0x01;  // 00000001
   * ( BorderRight +  3 ) = 0x01;  // 00000001
   * ( BorderRight +  4 ) = 0x01;  // 00000001
   * ( BorderRight +  5 ) = 0x01;  // 00000001
   * ( BorderRight +  6 ) = 0x01;  // 00000001
   * ( BorderRight +  7 ) = 0x01;  // 00000001
   * ( BorderRight +  8 ) = 0x01;  // 00000001
   * ( BorderRight +  9 ) = 0x01;  // 00000001
   * ( BorderRight + 10 ) = 0x01;  // 00000001
   * ( BorderRight + 11 ) = 0x01;  // 00000001
   * ( BorderRight + 12 ) = 0x01;  // 00000001
   * ( BorderRight + 13 ) = 0x01;  // 00000001
   * ( BorderRight + 14 ) = 0x01;  // 00000001
   * ( BorderRight + 15 ) = 0x01;  // 00000001
   * ( BorderRight + 16 ) = 0x01;  // 00000001

   * ( _16CloseLeft +  0 ) = CLOSELEFT;  // "É"
   * ( _16CloseLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16CloseLeft +  2 ) = 0x00;  // 00000000 00000000
   * ( _16CloseLeft +  3 ) = 0x3F;  // 00111111 11111110
   * ( _16CloseLeft +  4 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft +  5 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft +  6 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft +  7 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft +  8 ) = 0x27;  // 00100111 11110010
   * ( _16CloseLeft +  9 ) = 0x27;  // 00100111 11110010
   * ( _16CloseLeft + 10 ) = 0x27;  // 00100111 11110010
   * ( _16CloseLeft + 11 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft + 12 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft + 13 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft + 14 ) = 0x20;  // 00100000 00000010
   * ( _16CloseLeft + 15 ) = 0x3F;  // 00111111 11111110
   * ( _16CloseLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16CloseRight +  0 ) = CLOSERIGHT; // "µ"
   * ( _16CloseRight +  1 ) = 0x00; // 00000000 00000000
   * ( _16CloseRight +  2 ) = 0x00; // 00000000 00000000
   * ( _16CloseRight +  3 ) = 0xFE; // 00111111 11111110
   * ( _16CloseRight +  4 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight +  5 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight +  6 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight +  7 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight +  8 ) = 0xF2; // 00100111 11110010
   * ( _16CloseRight +  9 ) = 0xF2; // 00100111 11110010
   * ( _16CloseRight + 10 ) = 0xF2; // 00100111 11110010
   * ( _16CloseRight + 11 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight + 12 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight + 13 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight + 14 ) = 0x02; // 00100000 00000010
   * ( _16CloseRight + 15 ) = 0xFE; // 00111111 11111110
   * ( _16CloseRight + 16 ) = 0x00; // 00000000 00000000

   * ( _16MaximizeLeft +  0 ) = MAXIMIZELEFT;  // "Ê"
   * ( _16MaximizeLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16MaximizeLeft +  2 ) = 0x00;  // 00000000 00000000
   * ( _16MaximizeLeft +  3 ) = 0x7F;  // 01111111 11111110
   * ( _16MaximizeLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft +  7 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft +  8 ) = 0x41;  // 01000001 10000010
   * ( _16MaximizeLeft +  9 ) = 0x43;  // 01000011 11000010
   * ( _16MaximizeLeft + 10 ) = 0x47;  // 01000111 11100010
   * ( _16MaximizeLeft + 11 ) = 0x4F;  // 01001111 11110010
   * ( _16MaximizeLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16MaximizeLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16MaximizeLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16MaximizeRight +  0 ) = MAXIMIZERIGHT;  // "¶"
   * ( _16MaximizeRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16MaximizeRight +  2 ) = 0x00;  // 00000000 00000000
   * ( _16MaximizeRight +  3 ) = 0xFE;  // 01111111 11111110
   * ( _16MaximizeRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight +  6 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight +  7 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight +  8 ) = 0x82;  // 01000001 10000010
   * ( _16MaximizeRight +  9 ) = 0xC2;  // 01000011 11000010
   * ( _16MaximizeRight + 10 ) = 0xE2;  // 01000111 11100010
   * ( _16MaximizeRight + 11 ) = 0xF2;  // 01001111 11110010
   * ( _16MaximizeRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16MaximizeRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16MaximizeRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16MinimizeLeft +  0 ) = MINIMIZELEFT;  // "Ë"
   * ( _16MinimizeLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16MinimizeLeft +  2 ) = 0x00;  // 00000000 00000000
   * ( _16MinimizeLeft +  3 ) = 0x7F;  // 01111111 11111110
   * ( _16MinimizeLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft +  7 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft +  8 ) = 0x4F;  // 01001111 11110010
   * ( _16MinimizeLeft +  9 ) = 0x47;  // 01000111 11100010
   * ( _16MinimizeLeft + 10 ) = 0x43;  // 01000011 11000010
   * ( _16MinimizeLeft + 11 ) = 0x41;  // 01000001 10000010
   * ( _16MinimizeLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16MinimizeLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16MinimizeLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16MinimizeRight +  0 ) = MINIMIZERIGHT;  // "·"
   * ( _16MinimizeRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16MinimizeRight +  2 ) = 0x00;  // 00000000 00000000
   * ( _16MinimizeRight +  3 ) = 0xFE;  // 01111111 11111110
   * ( _16MinimizeRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight +  6 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight +  7 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight +  8 ) = 0xF2;  // 01001111 11110010
   * ( _16MinimizeRight +  9 ) = 0xE2;  // 01000111 11100010
   * ( _16MinimizeRight + 10 ) = 0xC2;  // 01000011 11000010
   * ( _16MinimizeRight + 11 ) = 0x82;  // 01000001 10000010
   * ( _16MinimizeRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16MinimizeRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16MinimizeRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16RestoreLeft +  0 )   = RESTORELEFT;  // "Ì"
   * ( _16RestoreLeft +  1 )   = 0x00;  // 00000000 00000000
   * ( _16RestoreLeft +  2 )   = 0x00;  // 00000000 00000000
   * ( _16RestoreLeft +  3 )   = 0x7F;  // 01111111 11111110
   * ( _16RestoreLeft +  4 )   = 0x40;  // 01000000 00000010
   * ( _16RestoreLeft +  5 )   = 0x41;  // 01000001 10000010
   * ( _16RestoreLeft +  6 )   = 0x43;  // 01000011 11000010
   * ( _16RestoreLeft +  7 )   = 0x47;  // 01000111 11100010
   * ( _16RestoreLeft +  8 )   = 0x4F;  // 01001111 11110010
   * ( _16RestoreLeft +  9 )   = 0x40;  // 01000000 00000010
   * ( _16RestoreLeft + 10 )   = 0x4F;  // 01001111 11110010
   * ( _16RestoreLeft + 11 )   = 0x47;  // 01000111 11100010
   * ( _16RestoreLeft + 12 )   = 0x43;  // 01000011 11000010
   * ( _16RestoreLeft + 13 )   = 0x41;  // 01000001 10000010
   * ( _16RestoreLeft + 14 )   = 0x40;  // 01000000 00000010
   * ( _16RestoreLeft + 15 )   = 0x7F;  // 01111111 11111110
   * ( _16RestoreLeft + 16 )   = 0x00;  // 00000000 00000000

   * ( _16RestoreRight +  0 )  = RESTORERIGHT;  // "¸"
   * ( _16RestoreRight +  1 )  = 0x00;  // 00000000 00000000
   * ( _16RestoreRight +  2 )  = 0x00;  // 00000000 00000000
   * ( _16RestoreRight +  3 )  = 0xFE;  // 01111111 11111110
   * ( _16RestoreRight +  4 )  = 0x02;  // 01000000 00000010
   * ( _16RestoreRight +  5 )  = 0x82;  // 01000001 10000010
   * ( _16RestoreRight +  6 )  = 0xC2;  // 01000011 11000010
   * ( _16RestoreRight +  7 )  = 0xE2;  // 01000111 11100010
   * ( _16RestoreRight +  8 )  = 0xF2;  // 01001111 11110010
   * ( _16RestoreRight +  9 )  = 0x02;  // 01000000 00000010
   * ( _16RestoreRight + 10 )  = 0xF2;  // 01001111 11110010
   * ( _16RestoreRight + 11 )  = 0xE2;  // 01000111 11100010
   * ( _16RestoreRight + 12 )  = 0xC2;  // 01000011 11000010
   * ( _16RestoreRight + 13 )  = 0x82;  // 01000001 10000010
   * ( _16RestoreRight + 14 )  = 0x02;  // 01000000 00000010
   * ( _16RestoreRight + 15 )  = 0xFE;  // 01111111 11111110
   * ( _16RestoreRight + 16 )  = 0x00;  // 00000000 00000000

   * ( _16BorderBottom +  0 )  = BORDERBOTTOM;  // "Î"
   * ( _16BorderBottom +  1 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  2 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  3 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  4 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  5 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  6 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  7 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  8 )  = 0x00;  // 00000000
   * ( _16BorderBottom +  9 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 10 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 11 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 12 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 13 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 14 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 15 )  = 0x00;  // 00000000
   * ( _16BorderBottom + 16 )  = 0xFF;  // 11111111

   * ( _16CornerDLeft +  0 )  = CORNERDLEFT;  // "È"
   * ( _16CornerDLeft +  1 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  2 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  3 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  4 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  5 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  6 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  7 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  8 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft +  9 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 10 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 11 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 12 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 13 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 14 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 15 )  = 0xC0;  // 11000000
   * ( _16CornerDLeft + 16 )  = 0xFF;  // 11111111

   * ( _16CornerDRight +  0 )  = CORNERDRIGHT;  // "Í"
   * ( _16CornerDRight +  1 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  2 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  3 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  4 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  5 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  6 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  7 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  8 )  = 0x01;  // 00000001
   * ( _16CornerDRight +  9 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 10 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 11 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 12 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 13 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 14 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 15 )  = 0x01;  // 00000001
   * ( _16CornerDRight + 16 )  = 0xFF;  // 11111111

   * ( _16DoubleLine +  0 )  = DOUBLELINE;  // "Û"
   * ( _16DoubleLine +  1 )  = 0xFF;  // 11111111
   * ( _16DoubleLine +  2 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  3 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  4 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  5 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  6 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  7 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  8 )  = 0x00;  // 00000000
   * ( _16DoubleLine +  9 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 10 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 11 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 12 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 13 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 14 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 15 )  = 0x00;  // 00000000
   * ( _16DoubleLine + 16 )  = 0xFF;  // 11111111

   * ( _16ArrowUpLeft +  0 ) = ARROWUPLEFT;  // "Ï"
   * ( _16ArrowUpLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowUpLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowUpLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowUpLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowUpLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowUpLeft +  6 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowUpLeft +  7 ) = 0x43;  // 01000011 11000010
   * ( _16ArrowUpLeft +  8 ) = 0x47;  // 01000111 11100010
   * ( _16ArrowUpLeft +  9 ) = 0x4F;  // 01001111 11110010
   * ( _16ArrowUpLeft + 10 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowUpLeft + 11 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowUpLeft + 12 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowUpLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowUpLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowUpLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowUpLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowUpRight +  0 ) = ARROWUPRIGHT;  // "¹"
   * ( _16ArrowUpRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowUpRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowUpRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowUpRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowUpRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowUpRight +  6 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowUpRight +  7 ) = 0xC2;  // 01000011 11000010
   * ( _16ArrowUpRight +  8 ) = 0xE2;  // 01000111 11100010
   * ( _16ArrowUpRight +  9 ) = 0xF2;  // 01001111 11110010
   * ( _16ArrowUpRight + 10 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowUpRight + 11 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowUpRight + 12 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowUpRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowUpRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowUpRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowUpRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowDnLeft +  0 ) = ARROWDNLEFT;  // "Ð"
   * ( _16ArrowDnLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowDnLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowDnLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowDnLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowDnLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowDnLeft +  6 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowDnLeft +  7 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowDnLeft +  8 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowDnLeft +  9 ) = 0x4F;  // 01001111 11110010
   * ( _16ArrowDnLeft + 10 ) = 0x47;  // 01000111 11100010
   * ( _16ArrowDnLeft + 11 ) = 0x43;  // 01000011 11000010
   * ( _16ArrowDnLeft + 12 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowDnLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowDnLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowDnLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowDnLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowDnRight +  0 ) = ARROWDNRIGHT;  // "º"
   * ( _16ArrowDnRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowDnRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowDnRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowDnRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowDnRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowDnRight +  6 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowDnRight +  7 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowDnRight +  8 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowDnRight +  9 ) = 0xF2;  // 01001111 11110010
   * ( _16ArrowDnRight + 10 ) = 0xE2;  // 01000111 11100010
   * ( _16ArrowDnRight + 11 ) = 0xC2;  // 01000011 11000010
   * ( _16ArrowDnRight + 12 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowDnRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowDnRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowDnRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowDnRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowLfLeft +  0 ) = ARROWLFLEFT;  // "Ñ"
   * ( _16ArrowLfLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowLfLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowLfLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowLfLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowLfLeft +  5 ) = 0x41;  // 01000001 00000010
   * ( _16ArrowLfLeft +  6 ) = 0x43;  // 01000011 00000010
   * ( _16ArrowLfLeft +  7 ) = 0x47;  // 01000111 00000010
   * ( _16ArrowLfLeft +  8 ) = 0x4F;  // 01001111 11110010
   * ( _16ArrowLfLeft +  9 ) = 0x4F;  // 01001111 11110010
   * ( _16ArrowLfLeft + 10 ) = 0x47;  // 01000111 00000010
   * ( _16ArrowLfLeft + 11 ) = 0x43;  // 01000011 00000010
   * ( _16ArrowLfLeft + 12 ) = 0x41;  // 01000001 00000010
   * ( _16ArrowLfLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowLfLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowLfLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowLfLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowLfRight +  0 ) = ARROWLFRIGHT;  // "»"
   * ( _16ArrowLfRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowLfRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowLfRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowLfRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowLfRight +  5 ) = 0x02;  // 01000001 00000010
   * ( _16ArrowLfRight +  6 ) = 0x02;  // 01000011 00000010
   * ( _16ArrowLfRight +  7 ) = 0x02;  // 01000111 00000010
   * ( _16ArrowLfRight +  8 ) = 0xF2;  // 01001111 11110010
   * ( _16ArrowLfRight +  9 ) = 0xF2;  // 01001111 11110010
   * ( _16ArrowLfRight + 10 ) = 0x02;  // 01000111 00000010
   * ( _16ArrowLfRight + 11 ) = 0x02;  // 01000011 00000010
   * ( _16ArrowLfRight + 12 ) = 0x02;  // 01000001 00000010
   * ( _16ArrowLfRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowLfRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowLfRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowLfRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowRgLeft +  0 ) = ARROWRGLEFT;  // "Ò"
   * ( _16ArrowRgLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowRgLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowRgLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowRgLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowRgLeft +  5 ) = 0x41;  // 01000001 00000010
   * ( _16ArrowRgLeft +  6 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowRgLeft +  7 ) = 0x41;  // 01000001 11000010
   * ( _16ArrowRgLeft +  8 ) = 0x4F;  // 01001111 11100010
   * ( _16ArrowRgLeft +  9 ) = 0x4F;  // 01001111 11100010
   * ( _16ArrowRgLeft + 10 ) = 0x41;  // 01000001 11000010
   * ( _16ArrowRgLeft + 11 ) = 0x41;  // 01000001 10000010
   * ( _16ArrowRgLeft + 12 ) = 0x41;  // 01000001 00000010
   * ( _16ArrowRgLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowRgLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16ArrowRgLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16ArrowRgLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ArrowRgRight +  0 ) = ARROWRGRIGHT;  // "¼"
   * ( _16ArrowRgRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ArrowRgRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowRgRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowRgRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowRgRight +  5 ) = 0x02;  // 01000001 00000010
   * ( _16ArrowRgRight +  6 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowRgRight +  7 ) = 0xC2;  // 01000001 11000010
   * ( _16ArrowRgRight +  8 ) = 0xE2;  // 01001111 11100010
   * ( _16ArrowRgRight +  9 ) = 0xE2;  // 01001111 11100010
   * ( _16ArrowRgRight + 10 ) = 0xC2;  // 01000001 11000010
   * ( _16ArrowRgRight + 11 ) = 0x82;  // 01000001 10000010
   * ( _16ArrowRgRight + 12 ) = 0x02;  // 01000001 00000010
   * ( _16ArrowRgRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowRgRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16ArrowRgRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16ArrowRgRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ThumbLeft +  0 ) = THUMBLEFT;  // "Ó"
   * ( _16ThumbLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ThumbLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _16ThumbLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft +  7 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft +  8 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft +  9 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft + 10 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft + 11 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft + 13 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft + 14 ) = 0x40;  // 01000000 00000010
   * ( _16ThumbLeft + 15 ) = 0x7F;  // 01111111 11111110
   * ( _16ThumbLeft + 16 ) = 0x00;  // 00000000 00000000

   * ( _16ThumbRight +  0 ) = THUMBRIGHT;  // "½"
   * ( _16ThumbRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _16ThumbRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _16ThumbRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight +  6 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight +  7 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight +  8 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight +  9 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight + 10 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight + 11 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight + 13 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight + 14 ) = 0x02;  // 01000000 00000010
   * ( _16ThumbRight + 15 ) = 0xFE;  // 01111111 11111110
   * ( _16ThumbRight + 16 ) = 0x00;  // 00000000 00000000

   * ( _16BorderUpLeft +  0 ) = BORDERUPLEFT;  // "½"
   * ( _16BorderUpLeft +  1 ) = 0xFF;  // 11111111
   * ( _16BorderUpLeft +  2 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  3 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  4 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  5 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  6 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  7 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  8 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft +  9 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 10 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 11 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 12 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 13 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 14 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 15 ) = 0xC0;  // 11000000
   * ( _16BorderUpLeft + 16 ) = 0xC0;  // 00000000

   * ( _16BorderTop +  0 ) = BORDERTOP;  // "½"
   * ( _16BorderTop +  1 ) = 0xFF;  // 11111111
   * ( _16BorderTop +  2 ) = 0x00;  // 00000000
   * ( _16BorderTop +  3 ) = 0x00;  // 00000000
   * ( _16BorderTop +  4 ) = 0x00;  // 00000000
   * ( _16BorderTop +  5 ) = 0x00;  // 00000000
   * ( _16BorderTop +  6 ) = 0x00;  // 00000000
   * ( _16BorderTop +  7 ) = 0x00;  // 00000000
   * ( _16BorderTop +  8 ) = 0x00;  // 00000000
   * ( _16BorderTop +  9 ) = 0x00;  // 00000000
   * ( _16BorderTop + 10 ) = 0x00;  // 00000000
   * ( _16BorderTop + 11 ) = 0x00;  // 00000000
   * ( _16BorderTop + 12 ) = 0x00;  // 00000000
   * ( _16BorderTop + 13 ) = 0x00;  // 00000000
   * ( _16BorderTop + 14 ) = 0x00;  // 00000000
   * ( _16BorderTop + 15 ) = 0x00;  // 00000000
   * ( _16BorderTop + 16 ) = 0x00;  // 00000000

   * ( _16BorderUpRight +  0 ) = BORDERUPRIGHT;  // "½"
   * ( _16BorderUpRight +  1 ) = 0xFF;  // 11111111
   * ( _16BorderUpRight +  2 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  3 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  4 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  5 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  6 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  7 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  8 ) = 0x01;  // 00000001
   * ( _16BorderUpRight +  9 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 10 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 11 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 12 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 13 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 14 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 15 ) = 0x01;  // 00000001
   * ( _16BorderUpRight + 16 ) = 0x01;  // 00000001

   * ( _14CloseLeft +  0 ) = CLOSELEFT;
   * ( _14CloseLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14CloseLeft +  2 ) = 0x00;  // 00000000 00000000
   * ( _14CloseLeft +  3 ) = 0x3F;  // 00111111 11111111
   * ( _14CloseLeft +  4 ) = 0x20;  // 00100000 00000001
   * ( _14CloseLeft +  5 ) = 0x20;  // 00100000 00000001
   * ( _14CloseLeft +  6 ) = 0x20;  // 00100000 00000001
   * ( _14CloseLeft +  7 ) = 0x23;  // 00100011 11110001
   * ( _14CloseLeft +  8 ) = 0x23;  // 00100011 11110001
   * ( _14CloseLeft +  9 ) = 0x23;  // 00100011 11110001
   * ( _14CloseLeft + 10 ) = 0x20;  // 00100000 00000001
   * ( _14CloseLeft + 11 ) = 0x20;  // 00100000 00000001
   * ( _14CloseLeft + 12 ) = 0x20;  // 00100000 00000001
   * ( _14CloseLeft + 13 ) = 0x3F;  // 00111111 11111111
   * ( _14CloseLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14CloseRight +  0 ) = CLOSERIGHT;
   * ( _14CloseRight +  1 ) = 0x00; // 00000000 00000000
   * ( _14CloseRight +  2 ) = 0x00; // 00000000 00000000
   * ( _14CloseRight +  3 ) = 0xFF; // 00111111 11111111
   * ( _14CloseRight +  4 ) = 0x01; // 00100000 00000001
   * ( _14CloseRight +  5 ) = 0x01; // 00100000 00000001
   * ( _14CloseRight +  6 ) = 0x01; // 00100000 00000001
   * ( _14CloseRight +  7 ) = 0xF1; // 00100011 11110001
   * ( _14CloseRight +  8 ) = 0xF1; // 00100011 11110001
   * ( _14CloseRight +  9 ) = 0xF1; // 00100011 11110001
   * ( _14CloseRight + 10 ) = 0x01; // 00100000 00000001
   * ( _14CloseRight + 11 ) = 0x01; // 00100000 00000001
   * ( _14CloseRight + 12 ) = 0x01; // 00100000 00000001
   * ( _14CloseRight + 13 ) = 0xFF; // 00111111 11111111
   * ( _14CloseRight + 14 ) = 0x00; // 00000000 00000000

   * ( _14MaximizeLeft +  0 ) = MAXIMIZELEFT;
   * ( _14MaximizeLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14MaximizeLeft +  2 ) = 0x00;  // 00000000 00000000
   * ( _14MaximizeLeft +  3 ) = 0x7F;  // 01111111 11111110
   * ( _14MaximizeLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _14MaximizeLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _14MaximizeLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _14MaximizeLeft +  7 ) = 0x41;  // 01000001 10000010
   * ( _14MaximizeLeft +  8 ) = 0x43;  // 01000011 11000010
   * ( _14MaximizeLeft +  9 ) = 0x47;  // 01000111 11100010
   * ( _14MaximizeLeft + 10 ) = 0x4F;  // 01001111 11110010
   * ( _14MaximizeLeft + 11 ) = 0x40;  // 01000000 00000010
   * ( _14MaximizeLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14MaximizeLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14MaximizeLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14MaximizeRight +  0 ) = MAXIMIZERIGHT;
   * ( _14MaximizeRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14MaximizeRight +  2 ) = 0x00;  // 00000000 00000000
   * ( _14MaximizeRight +  3 ) = 0xFE;  // 01111111 11111110
   * ( _14MaximizeRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _14MaximizeRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _14MaximizeRight +  6 ) = 0x02;  // 01000000 00000010
   * ( _14MaximizeRight +  7 ) = 0x82;  // 01000001 10000010
   * ( _14MaximizeRight +  8 ) = 0xC2;  // 01000011 11000010
   * ( _14MaximizeRight +  9 ) = 0xE2;  // 01000111 11100010
   * ( _14MaximizeRight + 10 ) = 0xF2;  // 01001111 11110010
   * ( _14MaximizeRight + 11 ) = 0x02;  // 01000000 00000010
   * ( _14MaximizeRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14MaximizeRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14MaximizeRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14MinimizeLeft +  0 ) = MINIMIZELEFT;
   * ( _14MinimizeLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14MinimizeLeft +  2 ) = 0x00;  // 00000000 00000000
   * ( _14MinimizeLeft +  3 ) = 0x7F;  // 01111111 11111110
   * ( _14MinimizeLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _14MinimizeLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _14MinimizeLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _14MinimizeLeft +  7 ) = 0x4F;  // 01001111 11110010
   * ( _14MinimizeLeft +  8 ) = 0x47;  // 01000111 11100010
   * ( _14MinimizeLeft +  9 ) = 0x43;  // 01000011 11000010
   * ( _14MinimizeLeft + 10 ) = 0x41;  // 01000001 10000010
   * ( _14MinimizeLeft + 11 ) = 0x40;  // 01000000 00000010
   * ( _14MinimizeLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14MinimizeLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14MinimizeLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14MinimizeRight +  0 ) = MINIMIZERIGHT;
   * ( _14MinimizeRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14MinimizeRight +  2 ) = 0x00;  // 00000000 00000000
   * ( _14MinimizeRight +  3 ) = 0xFE;  // 01111111 11111110
   * ( _14MinimizeRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _14MinimizeRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _14MinimizeRight +  6 ) = 0x02;  // 01000000 00000010
   * ( _14MinimizeRight +  7 ) = 0xF2;  // 01001111 11110010
   * ( _14MinimizeRight +  8 ) = 0xE2;  // 01000111 11100010
   * ( _14MinimizeRight +  9 ) = 0xC2;  // 01000011 11000010
   * ( _14MinimizeRight + 10 ) = 0x82;  // 01000001 10000010
   * ( _14MinimizeRight + 11 ) = 0x02;  // 01000000 00000010
   * ( _14MinimizeRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14MinimizeRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14MinimizeRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14RestoreLeft +  0 )   = RESTORELEFT;
   * ( _14RestoreLeft +  1 )   = 0x00;  // 00000000 00000000
   * ( _14RestoreLeft +  2 )   = 0x00;  // 00000000 00000000
   * ( _14RestoreLeft +  3 )   = 0x7F;  // 01111111 11111110
   * ( _14RestoreLeft +  4 )   = 0x40;  // 01000000 00000010
   * ( _14RestoreLeft +  5 )   = 0x41;  // 01000001 10000010
   * ( _14RestoreLeft +  6 )   = 0x43;  // 01000011 11000010
   * ( _14RestoreLeft +  7 )   = 0x47;  // 01000111 11100010
   * ( _14RestoreLeft +  8 )   = 0x40;  // 01000000 00000010
   * ( _14RestoreLeft +  9 )   = 0x47;  // 01000111 11100010
   * ( _14RestoreLeft + 10 )   = 0x43;  // 01000011 11000010
   * ( _14RestoreLeft + 11 )   = 0x41;  // 01000001 10000010
   * ( _14RestoreLeft + 12 )   = 0x40;  // 01000000 00000010
   * ( _14RestoreLeft + 13 )   = 0x7F;  // 01111111 11111110
   * ( _14RestoreLeft + 14 )   = 0x00;  // 00000000 00000000

   * ( _14RestoreRight +  0 )  = RESTORERIGHT;
   * ( _14RestoreRight +  1 )  = 0x00;  // 00000000 00000000
   * ( _14RestoreRight +  2 )  = 0x00;  // 00000000 00000000
   * ( _14RestoreRight +  3 )  = 0xFE;  // 01111111 11111110
   * ( _14RestoreRight +  4 )  = 0x02;  // 01000000 00000010
   * ( _14RestoreRight +  5 )  = 0x82;  // 01000001 10000010
   * ( _14RestoreRight +  6 )  = 0xC2;  // 01000011 11000010
   * ( _14RestoreRight +  7 )  = 0xE2;  // 01000111 11100010
   * ( _14RestoreRight +  8 )  = 0x02;  // 01000000 00000010
   * ( _14RestoreRight +  9 )  = 0xE2;  // 01000111 11100010
   * ( _14RestoreRight + 10 )  = 0xC2;  // 01000011 11000010
   * ( _14RestoreRight + 11 )  = 0x82;  // 01000001 10000010
   * ( _14RestoreRight + 12 )  = 0x02;  // 01000000 00000010
   * ( _14RestoreRight + 13 )  = 0xFE;  // 01111111 11111110
   * ( _14RestoreRight + 14 )  = 0x00;  // 00000000 00000000

   * ( _14BorderBottom +  0 )  = BORDERBOTTOM;
   * ( _14BorderBottom +  1 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  2 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  3 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  4 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  5 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  6 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  7 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  8 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom +  9 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom + 10 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom + 11 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom + 12 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom + 13 )  = 0x00;  // 00000000 00000000
   * ( _14BorderBottom + 14 )  = 0xFF;  // 11111111 11111111

   * ( _14CornerDLeft +  0 )  = CORNERDLEFT;
   * ( _14CornerDLeft +  1 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  2 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  3 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  4 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  5 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  6 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  7 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  8 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft +  9 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft + 10 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft + 11 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft + 12 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft + 13 )  = 0xC0;  // 11000000
   * ( _14CornerDLeft + 14 )  = 0xFF;  // 11111111

   * ( _14CornerDRight +  0 )  = CORNERDRIGHT;
   * ( _14CornerDRight +  1 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  2 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  3 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  4 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  5 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  6 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  7 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  8 )  = 0x01;  // 00000001
   * ( _14CornerDRight +  9 )  = 0x01;  // 00000001
   * ( _14CornerDRight + 10 )  = 0x01;  // 00000001
   * ( _14CornerDRight + 11 )  = 0x01;  // 00000001
   * ( _14CornerDRight + 12 )  = 0x01;  // 00000001
   * ( _14CornerDRight + 13 )  = 0x01;  // 00000001
   * ( _14CornerDRight + 14 )  = 0xFF;  // 11111111

   * ( _14ArrowUpLeft +  0 ) = ARROWUPLEFT;  // "Ï"
   * ( _14ArrowUpLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowUpLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowUpLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowUpLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowUpLeft +  5 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowUpLeft +  6 ) = 0x43;  // 01000011 11000010
   * ( _14ArrowUpLeft +  7 ) = 0x47;  // 01000111 11100010
   * ( _14ArrowUpLeft +  8 ) = 0x4F;  // 01001111 11110010
   * ( _14ArrowUpLeft +  9 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowUpLeft + 10 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowUpLeft + 11 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowUpLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowUpLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowUpLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowUpRight +  0 ) = ARROWUPRIGHT;  // "¹"
   * ( _14ArrowUpRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowUpRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowUpRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowUpRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowUpRight +  5 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowUpRight +  6 ) = 0xC2;  // 01000011 11000010
   * ( _14ArrowUpRight +  7 ) = 0xE2;  // 01000111 11100010
   * ( _14ArrowUpRight +  8 ) = 0xF2;  // 01001111 11110010
   * ( _14ArrowUpRight +  9 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowUpRight + 10 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowUpRight + 11 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowUpRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowUpRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowUpRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowDnLeft +  0 ) = ARROWDNLEFT;  // "Ð"
   * ( _14ArrowDnLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowDnLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowDnLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowDnLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowDnLeft +  5 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowDnLeft +  6 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowDnLeft +  7 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowDnLeft +  8 ) = 0x4F;  // 01001111 11110010
   * ( _14ArrowDnLeft +  9 ) = 0x47;  // 01000111 11100010
   * ( _14ArrowDnLeft + 10 ) = 0x43;  // 01000011 11000010
   * ( _14ArrowDnLeft + 11 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowDnLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowDnLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowDnLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowDnRight +  0 ) = ARROWDNRIGHT;  // "º"
   * ( _14ArrowDnRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowDnRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowDnRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowDnRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowDnRight +  5 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowDnRight +  6 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowDnRight +  7 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowDnRight +  8 ) = 0xF2;  // 01001111 11110010
   * ( _14ArrowDnRight +  9 ) = 0xE2;  // 01000111 11100010
   * ( _14ArrowDnRight + 10 ) = 0xC2;  // 01000011 11000010
   * ( _14ArrowDnRight + 11 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowDnRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowDnRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowDnRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowLfLeft +  0 ) = ARROWLFLEFT;  // "Ñ"
   * ( _14ArrowLfLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowLfLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowLfLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowLfLeft +  4 ) = 0x41;  // 01000001 00000010
   * ( _14ArrowLfLeft +  5 ) = 0x43;  // 01000011 00000010
   * ( _14ArrowLfLeft +  6 ) = 0x47;  // 01000111 00000010
   * ( _14ArrowLfLeft +  7 ) = 0x4F;  // 01001111 11110010
   * ( _14ArrowLfLeft +  8 ) = 0x4F;  // 01001111 11110010
   * ( _14ArrowLfLeft +  9 ) = 0x47;  // 01000111 00000010
   * ( _14ArrowLfLeft + 10 ) = 0x43;  // 01000011 00000010
   * ( _14ArrowLfLeft + 11 ) = 0x41;  // 01000001 00000010
   * ( _14ArrowLfLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowLfLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowLfLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowLfRight +  0 ) = ARROWLFRIGHT;  // "»"
   * ( _14ArrowLfRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowLfRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowLfRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowLfRight +  4 ) = 0x02;  // 01000001 00000010
   * ( _14ArrowLfRight +  5 ) = 0x02;  // 01000011 00000010
   * ( _14ArrowLfRight +  6 ) = 0x02;  // 01000111 00000010
   * ( _14ArrowLfRight +  7 ) = 0xF2;  // 01001111 11110010
   * ( _14ArrowLfRight +  8 ) = 0xF2;  // 01001111 11110010
   * ( _14ArrowLfRight +  9 ) = 0x02;  // 01000111 00000010
   * ( _14ArrowLfRight + 10 ) = 0x02;  // 01000011 00000010
   * ( _14ArrowLfRight + 11 ) = 0x02;  // 01000001 00000010
   * ( _14ArrowLfRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowLfRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowLfRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowRgLeft +  0 ) = ARROWRGLEFT;  // "Ò"
   * ( _14ArrowRgLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowRgLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowRgLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowRgLeft +  4 ) = 0x41;  // 01000001 00000010
   * ( _14ArrowRgLeft +  5 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowRgLeft +  6 ) = 0x41;  // 01000001 11000010
   * ( _14ArrowRgLeft +  7 ) = 0x4F;  // 01001111 11100010
   * ( _14ArrowRgLeft +  8 ) = 0x4F;  // 01001111 11100010
   * ( _14ArrowRgLeft +  9 ) = 0x41;  // 01000001 11000010
   * ( _14ArrowRgLeft + 10 ) = 0x41;  // 01000001 10000010
   * ( _14ArrowRgLeft + 11 ) = 0x41;  // 01000001 00000010
   * ( _14ArrowRgLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14ArrowRgLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14ArrowRgLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ArrowRgRight +  0 ) = ARROWRGRIGHT;  // "¼"
   * ( _14ArrowRgRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ArrowRgRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowRgRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowRgRight +  4 ) = 0x02;  // 01000001 00000010
   * ( _14ArrowRgRight +  5 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowRgRight +  6 ) = 0xC2;  // 01000001 11000010
   * ( _14ArrowRgRight +  7 ) = 0xE2;  // 01001111 11100010
   * ( _14ArrowRgRight +  8 ) = 0xE2;  // 01001111 11100010
   * ( _14ArrowRgRight +  9 ) = 0xC2;  // 01000001 11000010
   * ( _14ArrowRgRight + 10 ) = 0x82;  // 01000001 10000010
   * ( _14ArrowRgRight + 11 ) = 0x02;  // 01000001 00000010
   * ( _14ArrowRgRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14ArrowRgRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14ArrowRgRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ThumbLeft +  0 ) = THUMBLEFT;  // "Ó"
   * ( _14ThumbLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ThumbLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _14ThumbLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft +  4 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft +  5 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft +  7 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft +  8 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft +  9 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft + 10 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft + 11 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft + 12 ) = 0x40;  // 01000000 00000010
   * ( _14ThumbLeft + 13 ) = 0x7F;  // 01111111 11111110
   * ( _14ThumbLeft + 14 ) = 0x00;  // 00000000 00000000

   * ( _14ThumbRight +  0 ) = THUMBRIGHT;  // "½"
   * ( _14ThumbRight +  1 ) = 0x00;  // 00000000 00000000
   * ( _14ThumbRight +  2 ) = 0xFE;  // 01111111 11111110
   * ( _14ThumbRight +  3 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight +  4 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight +  5 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight +  6 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight +  7 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight +  8 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight +  9 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight + 10 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight + 11 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight + 12 ) = 0x02;  // 01000000 00000010
   * ( _14ThumbRight + 13 ) = 0xFE;  // 01111111 11111110
   * ( _14ThumbRight + 14 ) = 0x00;  // 00000000 00000000

   * ( _14DoubleLine +  0 )  = DOUBLELINE;  // "Û"
   * ( _14DoubleLine +  1 )  = 0xFF;  // 11111111
   * ( _14DoubleLine +  2 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  3 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  4 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  5 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  6 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  7 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  8 )  = 0x00;  // 00000000
   * ( _14DoubleLine +  9 )  = 0x00;  // 00000000
   * ( _14DoubleLine + 10 )  = 0x00;  // 00000000
   * ( _14DoubleLine + 11 )  = 0x00;  // 00000000
   * ( _14DoubleLine + 12 )  = 0x00;  // 00000000
   * ( _14DoubleLine + 13 )  = 0x00;  // 00000000
   * ( _14DoubleLine + 14 )  = 0xFF;  // 11111111

   * ( _8CloseLeft +  0 ) = CLOSELEFT;
   * ( _8CloseLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _8CloseLeft +  2 ) = 0x3F;  // 00111111 11111111
   * ( _8CloseLeft +  3 ) = 0x20;  // 00100000 00000001
   * ( _8CloseLeft +  4 ) = 0x21;  // 00100001 11100001
   * ( _8CloseLeft +  5 ) = 0x21;  // 00100001 11100001
   * ( _8CloseLeft +  6 ) = 0x20;  // 00100000 00000001
   * ( _8CloseLeft +  7 ) = 0x3F;  // 00111111 11111111
   * ( _8CloseLeft +  8 ) = 0x00;  // 00000000 00000000

   * ( _8CloseRight +  0 ) = CLOSERIGHT;
   * ( _8CloseRight +  1 ) = 0x00; // 00000000 00000000
   * ( _8CloseRight +  2 ) = 0xFF; // 00111111 11111111
   * ( _8CloseRight +  3 ) = 0x01; // 00100000 00000001
   * ( _8CloseRight +  4 ) = 0xE1; // 00100001 11100001
   * ( _8CloseRight +  5 ) = 0xE1; // 00100001 11100001
   * ( _8CloseRight +  6 ) = 0x01; // 00100000 00000001
   * ( _8CloseRight +  7 ) = 0xFF; // 00111111 11111111
   * ( _8CloseRight +  8 ) = 0x00; // 00000000 00000000

   * ( _8MinimizeLeft +  0 ) = MINIMIZELEFT;
   * ( _8MinimizeLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _8MinimizeLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _8MinimizeLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _8MinimizeLeft +  4 ) = 0x43;  // 01000011 11000010
   * ( _8MinimizeLeft +  5 ) = 0x41;  // 01000001 10000010
   * ( _8MinimizeLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _8MinimizeLeft +  7 ) = 0x7F;  // 01111111 11111111
   * ( _8MinimizeLeft +  8 ) = 0x00;  // 00000000 00000000

   * ( _8MinimizeRight +  0 ) = MINIMIZERIGHT;
   * ( _8MinimizeRight +  1 ) = 0x00; // 00000000 00000000
   * ( _8MinimizeRight +  2 ) = 0xFE; // 01111111 11111110
   * ( _8MinimizeRight +  3 ) = 0x02; // 01000000 00000010
   * ( _8MinimizeRight +  4 ) = 0xC2; // 01000011 11000010
   * ( _8MinimizeRight +  5 ) = 0x82; // 01000001 10000010
   * ( _8MinimizeRight +  6 ) = 0x02; // 01000000 00000010
   * ( _8MinimizeRight +  7 ) = 0xFE; // 01111111 11111110
   * ( _8MinimizeRight +  8 ) = 0x00; // 00000000 00000000

   * ( _8MaximizeLeft +  0 ) = MAXIMIZELEFT;
   * ( _8MaximizeLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _8MaximizeLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _8MaximizeLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _8MaximizeLeft +  4 ) = 0x41;  // 01000001 10000010
   * ( _8MaximizeLeft +  5 ) = 0x43;  // 01000011 11000010
   * ( _8MaximizeLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _8MaximizeLeft +  7 ) = 0x7F;  // 01111111 11111110
   * ( _8MaximizeLeft +  8 ) = 0x00;  // 00000000 00000000

   * ( _8MaximizeRight +  0 ) = MAXIMIZERIGHT;
   * ( _8MaximizeRight +  1 ) = 0x00; // 00000000 00000000
   * ( _8MaximizeRight +  2 ) = 0xFE; // 01111111 11111110
   * ( _8MaximizeRight +  3 ) = 0x02; // 01000000 00000010
   * ( _8MaximizeRight +  4 ) = 0x82; // 01000001 10000010
   * ( _8MaximizeRight +  5 ) = 0xC2; // 01000011 11000010
   * ( _8MaximizeRight +  6 ) = 0x02; // 01000000 00000010
   * ( _8MaximizeRight +  7 ) = 0xFE; // 01111111 11111110
   * ( _8MaximizeRight +  8 ) = 0x00; // 00000000 00000000

   * ( _8BorderBottom +  0 )  = BORDERBOTTOM;
   * ( _8BorderBottom +  1 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  2 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  3 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  4 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  5 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  6 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  7 )  = 0x00;  // 00000000 00000000
   * ( _8BorderBottom +  8 )  = 0xFF;  // 11111111 11111111

   * ( _8CornerDLeft +  0 )  = CORNERDLEFT;
   * ( _8CornerDLeft +  1 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  2 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  3 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  4 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  5 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  6 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  7 )  = 0xC0;  // 11000000
   * ( _8CornerDLeft +  8 )  = 0xFF;  // 11111111

   * ( _8CornerDRight +  0 )  = CORNERDRIGHT;
   * ( _8CornerDRight +  1 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  2 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  3 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  4 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  5 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  6 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  7 )  = 0x01;  // 00000001
   * ( _8CornerDRight +  8 )  = 0xFF;  // 11111111

   * ( _8ArrowUpLeft +  0 ) = ARROWUPLEFT;  // "Ï"
   * ( _8ArrowUpLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _8ArrowUpLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowUpLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowUpLeft +  4 ) = 0x41;  // 01000001 10000010
   * ( _8ArrowUpLeft +  5 ) = 0x43;  // 01000011 11000010
   * ( _8ArrowUpLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowUpLeft +  7 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowUpLeft +  8 ) = 0x00;  // 00000000 00000000

   * ( _8ArrowUpRight +  0 ) = ARROWUPRIGHT;  // "¹"
   * ( _8ArrowUpRight +  1 ) = 0x00; // 00000000 00000000
   * ( _8ArrowUpRight +  2 ) = 0xFE; // 01111111 11111110
   * ( _8ArrowUpRight +  3 ) = 0x02; // 01000000 00000010
   * ( _8ArrowUpRight +  4 ) = 0x82; // 01000001 10000010
   * ( _8ArrowUpRight +  5 ) = 0xC2; // 01000011 11000010
   * ( _8ArrowUpRight +  6 ) = 0x02; // 01000000 00000010
   * ( _8ArrowUpRight +  7 ) = 0xFE; // 01111111 11111110
   * ( _8ArrowUpRight +  8 ) = 0x00; // 00000000 00000000

   * ( _8ArrowDnLeft +  0 ) = ARROWDNLEFT;  // "Ð"
   * ( _8ArrowDnLeft +  1 ) = 0x00;  // 00000000 00000000
   * ( _8ArrowDnLeft +  2 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowDnLeft +  3 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowDnLeft +  4 ) = 0x43;  // 01000011 11000010
   * ( _8ArrowDnLeft +  5 ) = 0x41;  // 01000001 10000010
   * ( _8ArrowDnLeft +  6 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowDnLeft +  7 ) = 0x7F;  // 01111111 11111111
   * ( _8ArrowDnLeft +  8 ) = 0x00;  // 00000000 00000000

   * ( _8ArrowDnRight +  0 ) = ARROWDNRIGHT;  // "º"
   * ( _8ArrowDnRight +  1 ) = 0x00; // 00000000 00000000
   * ( _8ArrowDnRight +  2 ) = 0xFE; // 01111111 11111110
   * ( _8ArrowDnRight +  3 ) = 0x02; // 01000000 00000010
   * ( _8ArrowDnRight +  4 ) = 0xC2; // 01000011 11000010
   * ( _8ArrowDnRight +  5 ) = 0x82; // 01000001 10000010
   * ( _8ArrowDnRight +  6 ) = 0x02; // 01000000 00000010
   * ( _8ArrowDnRight +  7 ) = 0xFE; // 01111111 11111110
   * ( _8ArrowDnRight +  8 ) = 0x00; // 00000000 00000000

   * ( _8ArrowLfLeft + 0 ) = ARROWLFLEFT;  // "Ñ"
   * ( _8ArrowLfLeft + 1 ) = 0x00;  // 00000000 00000000
   * ( _8ArrowLfLeft + 2 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowLfLeft + 3 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowLfLeft + 4 ) = 0x43;  // 01000011 00000010
   * ( _8ArrowLfLeft + 5 ) = 0x43;  // 01000011 00000010
   * ( _8ArrowLfLeft + 6 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowLfLeft + 7 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowLfLeft + 8 ) = 0x00;  // 00000000 00000000

   * ( _8ArrowLfRight + 0 ) = ARROWLFRIGHT;  // "»"
   * ( _8ArrowLfRight + 1 ) = 0x00;  // 00000000 00000000
   * ( _8ArrowLfRight + 2 ) = 0xFE;  // 01111111 11111110
   * ( _8ArrowLfRight + 3 ) = 0x02;  // 01000001 00000010
   * ( _8ArrowLfRight + 4 ) = 0x02;  // 01000011 00000010
   * ( _8ArrowLfRight + 5 ) = 0x02;  // 01000011 00000010
   * ( _8ArrowLfRight + 6 ) = 0x02;  // 01000001 00000010
   * ( _8ArrowLfRight + 7 ) = 0xFE;  // 01111111 11111110
   * ( _8ArrowLfRight + 8 ) = 0x00;  // 00000000 00000000

   * ( _8ArrowRgLeft + 0 ) = ARROWRGLEFT;  // "Ò"
   * ( _8ArrowRgLeft + 1 ) = 0x00;  // 00000000 00000000
   * ( _8ArrowRgLeft + 2 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowRgLeft + 3 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowRgLeft + 4 ) = 0x41;  // 01000001 11000010
   * ( _8ArrowRgLeft + 5 ) = 0x41;  // 01000001 11000010
   * ( _8ArrowRgLeft + 6 ) = 0x40;  // 01000000 00000010
   * ( _8ArrowRgLeft + 7 ) = 0x7F;  // 01111111 11111110
   * ( _8ArrowRgLeft + 8 ) = 0x00;  // 00000000 00000000

   * ( _8ArrowRgRight + 0 ) = ARROWRGRIGHT;  // "¼"
   * ( _8ArrowRgRight + 1 ) = 0x00;  // 00000000 00000000
   * ( _8ArrowRgRight + 2 ) = 0xFE;  // 01111111 11111110
   * ( _8ArrowRgRight + 3 ) = 0x02;  // 01000000 00000010
   * ( _8ArrowRgRight + 4 ) = 0xC2;  // 01000001 11000010
   * ( _8ArrowRgRight + 5 ) = 0xC2;  // 01000001 11000010
   * ( _8ArrowRgRight + 6 ) = 0x02;  // 01000000 00000010
   * ( _8ArrowRgRight + 7 ) = 0xFE;  // 01111111 11111110
   * ( _8ArrowRgRight + 8 ) = 0x00;  // 00000000 00000000

   * ( _8ThumbLeft + 0 )  = THUMBLEFT;  // "Ó"
   * ( _8ThumbLeft + 1 )  = 0x00;  // 00000000 00000000
   * ( _8ThumbLeft + 2 )  = 0x7F;  // 01111111 11111110
   * ( _8ThumbLeft + 3 )  = 0x40;  // 01000000 00000010
   * ( _8ThumbLeft + 4 )  = 0x40;  // 01000000 00000010
   * ( _8ThumbLeft + 5 )  = 0x40;  // 01000000 00000010
   * ( _8ThumbLeft + 6 )  = 0x40;  // 01000000 00000010
   * ( _8ThumbLeft + 7 )  = 0x7F;  // 01111111 11111110
   * ( _8ThumbLeft + 8 )  = 0x00;  // 00000000 00000000

   * ( _8ThumbRight + 0 ) = THUMBRIGHT;  // "½"
   * ( _8ThumbRight + 1 ) = 0x00;  // 00000000 00000000
   * ( _8ThumbRight + 2 ) = 0xFE;  // 01111111 11111110
   * ( _8ThumbRight + 3 ) = 0x02;  // 01000000 00000010
   * ( _8ThumbRight + 4 ) = 0x02;  // 01000000 00000010
   * ( _8ThumbRight + 5 ) = 0x02;  // 01000000 00000010
   * ( _8ThumbRight + 6 ) = 0x02;  // 01000000 00000010
   * ( _8ThumbRight + 7 ) = 0xFE;  // 01111111 11111110
   * ( _8ThumbRight + 8 ) = 0x00;  // 00000000 00000000

   * ( _8DoubleLine + 0 )  = DOUBLELINE;  // "Û"
   * ( _8DoubleLine + 1 )  = 0xFF;  // 11111111
   * ( _8DoubleLine + 2 )  = 0x00;  // 00000000
   * ( _8DoubleLine + 3 )  = 0x00;  // 00000000
   * ( _8DoubleLine + 4 )  = 0x00;  // 00000000
   * ( _8DoubleLine + 5 )  = 0x00;  // 00000000
   * ( _8DoubleLine + 6 )  = 0x00;  // 00000000
   * ( _8DoubleLine + 7 )  = 0x00;  // 00000000
   * ( _8DoubleLine + 8 )  = 0xFF;  // 11111111

   * ( _8HalfUpBlock + 0 )  = 223;  // "ß"
   * ( _8HalfUpBlock + 1 )  = 0xFF;  // 11111111
   * ( _8HalfUpBlock + 2 )  = 0xFF;  // 11111111
   * ( _8HalfUpBlock + 3 )  = 0xFF;  // 11111111
   * ( _8HalfUpBlock + 4 )  = 0xFF;  // 11111111
   * ( _8HalfUpBlock + 5 )  = 0xFF;  // 11111111
   * ( _8HalfUpBlock + 6 )  = 0x00;  // 00000000
   * ( _8HalfUpBlock + 7 )  = 0x00;  // 00000000
   * ( _8HalfUpBlock + 8 )  = 0x00;  // 00000000

   SetChar( BorderLeft );
   SetChar( BorderRight );

   switch( ucRows )
   {
      case 16:                                     // 25 Display Rows
           SetChar( _16CloseLeft );
           SetChar( _16CloseRight );
           SetChar( _16MaximizeLeft );
           SetChar( _16MaximizeRight );
           SetChar( _16MinimizeLeft );
           SetChar( _16MinimizeRight );
           SetChar( _16RestoreLeft );
           SetChar( _16RestoreRight );
           SetChar( _16BorderUpLeft );
           SetChar( _16BorderTop );
           SetChar( _16BorderUpRight );
           SetChar( _16BorderBottom );
           SetChar( _16CornerDRight );
           SetChar( _16CornerDLeft );

           // SetChar( _16DoubleLine );

           SetChar( _16ArrowUpLeft );
           SetChar( _16ArrowUpRight );
           SetChar( _16ArrowDnLeft );
           SetChar( _16ArrowDnRight );
           SetChar( _16ArrowLfLeft );
           SetChar( _16ArrowLfRight );
           SetChar( _16ArrowRgLeft );
           SetChar( _16ArrowRgRight );
           SetChar( _16ThumbLeft );
           SetChar( _16ThumbRight );
           SetChar( EightFill );
           break;

      case 14:                                     // 28 Display Rows
           SetChar( _14CloseLeft );
           SetChar( _14CloseRight );
           SetChar( _14MaximizeLeft );
           SetChar( _14MaximizeRight );
           SetChar( _14MinimizeLeft );
           SetChar( _14MinimizeRight );
           SetChar( _14RestoreLeft );
           SetChar( _14RestoreRight );

           SetChar( _16BorderUpLeft );
           SetChar( _16BorderTop );
           SetChar( _16BorderUpRight );

           SetChar( _14BorderBottom );
           SetChar( _14CornerDRight );
           SetChar( _14CornerDLeft );

           // SetChar( _14DoubleLine );

           SetChar( _14ArrowUpLeft );
           SetChar( _14ArrowUpRight );
           SetChar( _14ArrowDnLeft );
           SetChar( _14ArrowDnRight );
           SetChar( _14ArrowLfLeft );
           SetChar( _14ArrowLfRight );
           SetChar( _14ArrowRgLeft );
           SetChar( _14ArrowRgRight );
           SetChar( _14ThumbLeft );
           SetChar( _14ThumbRight );
           SetChar( EightFill );
           break;

      case 8:                                      // 43/50 Display Rows
           SetChar( _8CloseLeft );
           SetChar( _8CloseRight );
           SetChar( _8MaximizeLeft );
           SetChar( _8MaximizeRight );
           SetChar( _8MinimizeLeft );
           SetChar( _8MinimizeRight );
           SetChar( _8RestoreLeft );
           SetChar( _8RestoreRight );

           SetChar( _16BorderUpLeft );
           SetChar( _16BorderTop );
           SetChar( _16BorderUpRight );

           SetChar( _8BorderBottom );
           SetChar( _8CornerDRight );
           SetChar( _8CornerDLeft );
           SetChar( _8DoubleLine );
           SetChar( _8ArrowUpLeft );
           SetChar( _8ArrowUpRight );
           SetChar( _8ArrowDnLeft );
           SetChar( _8ArrowDnRight );
           SetChar( _8ArrowLfLeft );
           SetChar( _8ArrowLfRight );
           SetChar( _8ArrowRgLeft );
           SetChar( _8ArrowRgRight );
           SetChar( _8ThumbLeft );
           SetChar( _8ThumbRight );
           SetChar( _8HalfUpBlock );
           SetChar( EightFill );
   }
   ucCuaStatus = 1;
}

//----------------------------------------------------------------------------//

CLIPPER WndDisplay()
{
   WORD wTop       = _parni( 1 );
   int  iLeft      = _parni( 2 );
   WORD wBottom    = _parni( 3 );
   WORD wRight     = _parni( 4 );
   WORD wStyle     = _parni( 5 );
   WORD wClrNormal = ( WORD ) _parni( 6 );
   WORD wClrTitle  = ( WORD ) _parni( 7 );
   LPSTR szTitle   = _parc( 8 );
   BOOL lMaximized = _parl( 9 );
   WORD wClrOld    = _gtClrGet( 0 );
   BYTE bFrame[ 10 ];
   BYTE bClose[ 2 ], bMinimize[ 2 ], bMaximize[ 2 ], bRestore[ 2 ];

   if( bEga )
   {
      bFrame[ 0 ] = ' ';
      bFrame[ 1 ] = ' ';
      bFrame[ 2 ] = ' ';
      bFrame[ 3 ] = BORDERRIGHT;
      bFrame[ 4 ] = CORNERDRIGHT;
      bFrame[ 5 ] = BORDERBOTTOM;
      bFrame[ 6 ] = CORNERDLEFT;
      bFrame[ 7 ] = BORDERLEFT;
      bFrame[ 8 ] = FILLCHAR;
   }
   else
   {
      bFrame[ 0 ] = ' ';
      bFrame[ 1 ] = ' ';
      bFrame[ 2 ] = ' ';
      bFrame[ 3 ] = '³';
      bFrame[ 4 ] = 'Ù';
      bFrame[ 5 ] = 'Ä';
      bFrame[ 6 ] = 'À';
      bFrame[ 7 ] = '³';
      bFrame[ 8 ] = FILLCHAR;
   }

   if( bEga )
   {
      bClose[ 0 ] = CLOSELEFT;
      bClose[ 1 ] = CLOSERIGHT;

      bMinimize[ 0 ] = MINIMIZELEFT;
      bMinimize[ 1 ] = MINIMIZERIGHT;

      bMaximize[ 0 ] = MAXIMIZELEFT;
      bMaximize[ 1 ] = MAXIMIZERIGHT;

      bRestore[ 0 ] = RESTORELEFT;
      bRestore[ 1 ] = RESTORERIGHT;
   }
   else
   {
      bClose[ 0 ] = 'þ';
      bClose[ 1 ] = 'þ';
   }

   _gtClrSet( 0, wClrNormal );
   _gtBox( wTop, iLeft, wBottom, wRight, bFrame );

   _gtClrSet( 0, wClrTitle );
   _gtRepChar( wTop, ( iLeft >= 0 ) ? iLeft: 0,
               32, wRight - ( iLeft > 0 ? iLeft : 0 ) + 1 );
   _gtWriteAt( wTop, iLeft + ( wRight - iLeft ) / 2 - _parclen( 8 ) / 2,
               szTitle, _parclen( 8 ) );
   _gtWriteAt( wTop, iLeft, bClose, 2 );

   if( wStyle & WND_LICONIZE )
   {
      _gtWriteAt( wTop, wRight - 1 - IF( wStyle & WND_LZOOM, 2, 0 ), bMinimize, 2 );
   }
   if( wStyle & WND_LZOOM )
   {
      _gtWriteAt( wTop, wRight - 1, IF( lMaximized, bRestore, bMaximize ), 2 );
   }

   _gtClrSet( 0, wClrOld );

   if( wStyle & WND_LSHADOW )
   {
      if( ! lMaximized )
      {
         _gtShadow( wBottom + 1, iLeft + 2, wBottom + 1, wRight + 2 );
         _gtShadow( wTop + 1, wRight + 1, wBottom, wRight + 2 );
      }
   }
}

//----------------------------------------------------------------------------//

CLIPPER MBoxDispla()   // y
{
   WORD wTop    = _parni( 1 );
   WORD wLeft   = _parni( 2 );
   WORD wBottom = _parni( 3 );
   WORD wRight  = _parni( 4 );
   WORD wClrOld = _gtClrSet( 0, 25 );
   WORD w;
   BYTE bBorderUpLeft  = BORDERUPLEFT;
   BYTE bBorderUpRight = BORDERUPRIGHT;
   BYTE bBorderLeft    = BORDERLEFT;
   BYTE bBorderRight   = BORDERRIGHT;
   BYTE bCornerDLeft   = CORNERDLEFT;
   BYTE bCornerDRight  = CORNERDRIGHT;

   _gtClrSet( 0, 25 );
   _gtWriteAt( wTop, wLeft, &bBorderUpLeft, 1 );
   _gtRepChar( wTop, wLeft + 1, BORDERTOP, wRight - wLeft - 1 );
   _gtClrSet( 0, 24 );
   _gtWriteAt( wTop, wRight, &bBorderUpRight, 1 );

   for( w = wTop + 1; w < wBottom; w++ )
   {
      _gtClrSet( 0, 25 );
      _gtWriteAt( w, wLeft, &bBorderLeft, 1 );
      _gtRepChar( w, wLeft + 1, ' ', wRight - wLeft - 1 );
      _gtClrSet( 0, 24 );
      _gtWriteAt( w, wRight, &bBorderRight, 1 );
   }
   _gtClrSet( 0, 25 );
   _gtWriteAt( wBottom, wLeft, &bCornerDLeft, 1 );
   _gtClrSet( 0, 24 );
   _gtRepChar( w, wLeft + 1, BORDERBOTTOM, wRight - wLeft - 1 );
   _gtWriteAt( wBottom, wRight, &bCornerDRight, 1 );
   _gtClrSet( 0, wClrOld );
}

//----------------------------------------------------------------------------//

CLIPPER SepDisplay()
{
   WORD wRow    = _parni( 1 );
   WORD wLeft   = _parni( 2 );
   WORD wRight  = _parni( 3 );
   WORD wClrOld = _gtClrSet( 0, 25 );
   BYTE bBorderLeft  = BORDERLEFT;
   BYTE bBorderRight = BORDERRIGHT;

   _gtWriteAt( wRow, wLeft, &bBorderLeft, 1 );
   _gtRepChar( wRow, wLeft + 1, 'Ä', wRight - wLeft - 1 );
   _gtClrSet( 0, 24 );
   _gtWriteAt( wRow, wRight, &bBorderRight, 1 );
   _gtClrSet( 0, wClrOld );
}

//----------------------------------------------------------------------------//
