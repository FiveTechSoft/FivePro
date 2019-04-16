#include <ClipApi.h>

#define BLACK  0
#define BLUE   1
#define GRAY   7
#define WHITE 15

void Frame( WORD, WORD, WORD, WORD, WORD, WORD );
void RectFill( WORD, WORD, WORD, WORD, WORD );
void Button( WORD, WORD, WORD, WORD, WORD, WORD, WORD );
void Line( WORD, WORD, WORD, WORD, WORD );

void WndDisplay( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight,
                 WORD wClrTitle, WORD wClrPane )
{
   WORD wAbsTop    = wTop * 16;
   WORD wAbsLeft   = wLeft * 9;
   WORD wAbsBottom = wBottom * 16;
   WORD wAbsRight  = wRight * 9;

   Frame( wAbsTop, wAbsLeft, wAbsBottom, wAbsRight, BLACK, 1 );
   Frame( wAbsTop + 1, wAbsLeft + 1, wAbsBottom - 1, wAbsRight - 1, 7, 2 );
   Frame( wAbsTop + 3, wAbsLeft + 3, wAbsBottom - 3, wAbsRight - 3, BLACK, 1 );

   RectFill( wAbsTop + 4, wAbsLeft + 4, wAbsTop + 22, wAbsRight - 4, wClrTitle );
   RectFill( wAbsTop + 24, wAbsLeft + 4, wAbsBottom - 4, wAbsRight - 4, wClrPane );

   Line( wAbsTop + 23, wAbsLeft, wAbsTop + 23, wAbsRight, BLACK );

   Frame( wAbsTop, wAbsLeft, wAbsTop + 23, wAbsLeft + 23, BLACK, 1 );
   RectFill( wAbsTop + 4, wAbsLeft + 4, wAbsTop + 22, wAbsLeft + 22, GRAY );
   Frame( wAbsTop + 12, wAbsLeft + 8, wAbsTop + 14, wAbsLeft + 18, BLACK, 1 );
   Line( wAbsTop + 13, wAbsLeft + 9, wAbsTop + 13, wAbsLeft + 17, WHITE );

   Button( wAbsTop + 3, wAbsRight - 23, 21, 21, GRAY, WHITE, 8 );
   Button( wAbsTop + 3, wAbsRight - 43, 21, 21, GRAY, WHITE, 8 );
}

CLIPPER _WNDDISPLA()
{
   WndDisplay( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ),
               _parni( 5 ), _parni( 6 ) );
}
