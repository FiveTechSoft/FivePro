#include <ClipApi.h>

// Clipper functions to use the undocumented Clipper Windowing API
// (c) Antonio Linares 1993

//----------------------------------------------------------------------------//

CLIPPER WCreate()                     // Creates a new Window
{                                     // Params: nTop, nLeft, nBottom, nRight
   gtRECT rct;
   LONG hWnd;

   rct.wTop    = _parni( 1 );
   rct.wLeft   = _parni( 2 );
   rct.wHeight = _parni( 3 ) - _parni( 1 ) + 1;
   rct.wWidth  = _parni( 4 ) - _parni( 2 ) + 1;

   _gtWCreate( ( LPgtRECT ) &rct, &hWnd );
   _retnl( ( LONG ) hWnd );
}

//----------------------------------------------------------------------------//

CLIPPER WApp()
{
   LONG hWnd;

   _gtWApp( &hWnd );
   _retnl( hWnd );
}

//----------------------------------------------------------------------------//

CLIPPER WCurrent()
{
   LONG hWnd = _parnl( 1 );

   _gtWCurrent( ( gtHWND ) hWnd );
}

//----------------------------------------------------------------------------//

CLIPPER WVis()
{
   _gtWVis( ( gtHWND ) _parnl( 1 ), _parl( 2 ) );
}


//----------------------------------------------------------------------------//

CLIPPER WFlash()
{
   _gtWFlash();
}

//----------------------------------------------------------------------------//

CLIPPER WPos()
{
   gtRECT rct;
   LONG hWnd = _parnl( 1 );

   rct.wTop    = _parni( 2 );
   rct.wLeft   = _parni( 3 );
   rct.wHeight = _parni( 4 ) - _parni( 2 ) + 1;
   rct.wWidth  = _parni( 5 ) - _parni( 3 ) + 1;

   _gtWPos( ( gtHWND ) hWnd, ( LPgtRECT ) &rct );
}

//----------------------------------------------------------------------------//

CLIPPER WDisplay()
{
   gtHWND hDest    = _parnl( 1 );
   gtHWND hSource  = _parnl( 2 );
   LPBYTE pImage;

   _gtWCurrent( hSource );
   pImage = _xgrab( _gtMaxRow() * _gtMaxCol() * 2 );
   _gtSave( 0, 0, _gtMaxRow(), _gtMaxCol(), pImage );

   _gtWCurrent( hDest );
   _gtRest( hSource->wTop, hSource->wLeft,
            hSource->wTop  + hSource->wHeight - 1,
            hSource->wLeft + hSource->wWidth - 1,
            pImage );

   _xfree( pImage );
}

//----------------------------------------------------------------------------//
