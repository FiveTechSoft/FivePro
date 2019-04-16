#include <ClipApi.h>

void Line( WORD, WORD, WORD, WORD, WORD );

#define BR_WHITE   255        // Windows palette
#define BLACK        0
#define BLUE         4         // Windows palette
#define LT_GRAY    247
#define GRAY       248

//----------------------------------------------------------------------------//

void BoxIn( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight )
{
   Line( wTop, wLeft, wBottom, wLeft, GRAY );
   Line( wTop, wLeft, wTop, wRight, GRAY );
   Line( wBottom, wLeft, wBottom, wRight, BR_WHITE );
   Line( wTop, wRight, wBottom, wRight, BR_WHITE );
}

//----------------------------------------------------------------------------//

void BoxOut( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight )
{
   Line( wTop, wLeft, wBottom, wLeft, BR_WHITE );
   Line( wTop, wLeft, wTop, wRight, BR_WHITE );
   Line( wBottom, wLeft, wBottom, wRight, GRAY );
   Line( wTop, wRight, wBottom, wRight, GRAY );
}

//----------------------------------------------------------------------------//

CLIPPER GBoxIn()
{
   BoxIn( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ) );
}

//----------------------------------------------------------------------------//

CLIPPER GBoxOut()
{
   BoxOut( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ) );
}

//----------------------------------------------------------------------------//
