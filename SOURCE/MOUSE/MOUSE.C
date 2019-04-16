#include "ClipApi.h"

void KeyStuff( WORD );
void MouseInit( BYTE );
void MouseReset( void );
void MouseOn( BYTE );
void MouseOff( void );
BYTE bMouseRow( void );
BYTE bMouseCol( void );
void MouseUpdate( void );
BOOL bMouseLeft( void );
BOOL bMouseCenter( void );
BOOL bMouseRight( void );
void MouseKeyLeft( WORD wKey );
void MouseKeyCenter( WORD wKey );
void MouseKeyRight( WORD wKey );
void MouseChars( LPBYTE );
BOOL bMousePressed( void );
BYTE bMouseCursor( void );
void MouseSetArea( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight );
void MouseSetCursor( WORD wCursor );

//----------------------------------------------------------------------------//

CLIPPER MInit()      { MouseInit( _parl( 1 ) ); }
CLIPPER MReset()     { MouseReset(); }
CLIPPER MOn()        { MouseOn( _parni( 1 ) ); }
CLIPPER MOff()       { MouseOff(); }
CLIPPER nMRow()      { _retni( bMouseRow() ); }
CLIPPER nMCol()      { _retni( bMouseCol() ); }
CLIPPER MUpdate()    { MouseUpdate(); }
CLIPPER lMLeft()     { _retl( bMouseLeft() ); }
CLIPPER lMCenter()   { _retl( bMouseCenter() ); }
CLIPPER lMRight()    { _retl( bMouseRight() ); }
CLIPPER lMPressed()  { _retl( bMousePressed() ); }
CLIPPER SetMKLeft()  { MouseKeyLeft( _parni( 1 ) ); }
CLIPPER SetMKRight() { MouseKeyRight( _parni( 1 ) ); }
CLIPPER SetMKCente() { MouseKeyCenter( _parni( 1 ) ); }
CLIPPER SetMChars()  { MouseChars( _parc( 1 ) ); }
CLIPPER nMCursor()   { bMouseCursor(); }

//----------------------------------------------------------------------------//

CLIPPER SetMArea()
{
   MouseSetArea( _parni( 1 ) * 16 * 8,
                 _parni( 2 ) * 9 * 8,
                 _parni( 3 ) * 16 * 8,
                 _parni( 4 ) *  9 * 8 );
}

//----------------------------------------------------------------------------//

CLIPPER SetMCursor()
{
   WORD wOldCursor = bMouseCursor();

   MouseSetCursor( _parni( 1 ) );
   _retni( wOldCursor );
}

//----------------------------------------------------------------------------//
