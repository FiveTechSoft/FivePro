// Clipper 5.01 _gtColorSelect() function missing

#include <ClipApi.h>

CLIPPER SelColor()
{
   _gtColorSelect( _parni( 1 ) - 1 );       // 1 ... 5
}

WORD _gtColorSelect( WORD wColor )          // 0 ... 4
{
   return _gtSetColor( _colors + wColor );
}
