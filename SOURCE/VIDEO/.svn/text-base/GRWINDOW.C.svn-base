// Ventana gr fica con estilo Windows/OS2

#include <ClipApi.h>

void RectFill( WORD, WORD, WORD, WORD, WORD );
void Line( WORD, WORD, WORD, WORD, WORD );
void Frame( WORD, WORD, WORD, WORD, WORD, WORD );
void BoxIn( WORD, WORD, WORD, WORD );
void BoxOut( WORD, WORD, WORD, WORD );
void PcxSVga( LPSTR, WORD, WORD, WORD, WORD );

#define BR_WHITE   255        // Windows palette
#define BLACK        0
#define BLUE         4         // Windows palette
#define LT_GRAY    247
#define GRAY       248

#define TITLE_HEIGH 22
#define MSG_HEIGH   22

//----------------------------------------------------------------------------//

CLIPPER GWindow()
{
   WORD wTop       = _parni( 1 );
   WORD wLeft      = _parni( 2 );
   WORD wBottom    = _parni( 3 );
   WORD wRight     = _parni( 4 );
   LPSTR szPcxFile = _parc( 5 );

   RectFill( wTop, wLeft, wBottom, wRight, LT_GRAY );
   Line( wTop + 1, wLeft + 1, wBottom - 1, wLeft + 1, BR_WHITE );
   Line( wTop + 1, wLeft + 1, wTop + 1, wRight - 1, BR_WHITE );
   Line( wBottom, wLeft, wBottom, wRight, GRAY );
   Line( wTop, wRight, wBottom, wRight, GRAY );

   BoxIn( wTop + TITLE_HEIGH + 3, wLeft + 4,
          wBottom - MSG_HEIGH, wRight - 4 );
   RectFill( wTop + 4, wLeft + 4, wTop + TITLE_HEIGH, wRight - 4, BLUE );
   Line( wTop + TITLE_HEIGH + 1, wLeft + 4,
         wTop + TITLE_HEIGH + 1, wRight - 4, LT_GRAY );
   Line( wTop + TITLE_HEIGH + 2, wLeft + 4,
         wTop + TITLE_HEIGH + 2, wRight - 4, LT_GRAY );

   Frame( wTop + TITLE_HEIGH + 4, wLeft + 5, wBottom - MSG_HEIGH - 1,
          wRight - 5, BLACK, 1 );

   RectFill( wBottom - MSG_HEIGH + 1, wLeft + 3, wBottom - 2, wRight - 3,
             LT_GRAY );
   BoxIn( wBottom - MSG_HEIGH + 3, wLeft + 4,
          wBottom - 3, wRight - TITLE_HEIGH - 2 );

   // Bot¢n de cierre
   RectFill( wTop + 5, wLeft + 5, wTop + TITLE_HEIGH - 1, wLeft + TITLE_HEIGH - 1,
             LT_GRAY );
   BoxOut( wTop + 4, wLeft + 4, wTop + TITLE_HEIGH, wLeft + TITLE_HEIGH );

   if( szPcxFile )
      PcxSVga( szPcxFile, wTop + TITLE_HEIGH + 5, wLeft + 6,
               wBottom - MSG_HEIGH - 1, wRight - 6 );
   else
      RectFill( wTop + TITLE_HEIGH + 5, wLeft + 6, wBottom - MSG_HEIGH - 2,
                wRight - 6, GRAY );
}

//----------------------------------------------------------------------------//
