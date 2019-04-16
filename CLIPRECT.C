#include <ClipApi.h>

typedef struct
{
    WORD wType;
    LONG lDummy;
    WORD wTop;
    WORD wLeft;
    WORD wBottom;
    WORD wRight;
} CLIPRECT;

typedef CLIPRECT near * PCLIPRECT;

static PCLIPRECT near GetRect( void );

//---------------------------------------------------------------------------//

static PCLIPRECT near GetRect()
{
   PCLIPVAR Rect = _lbase + 2;

   if( ! Rect->wType & NUM_FLOAT )
   {
       if( Rect->wType & BY_REF ) // Local/Static Ref
           Rect = (PCLIPVAR) Rect->pPointer1;
       else
           Rect = 0;
   }

   return (PCLIPRECT) Rect;
}

//---------------------------------------------------------------------------//

static void near NewRect( PCLIPRECT pVar, WORD wTop, WORD wLeft,
                                     WORD wBottom, WORD wRight )
{
    pVar->wType   = NUM_FLOAT;
    pVar->wTop    = wTop;
    pVar->wLeft   = wLeft;
    pVar->wBottom = wBottom;
    pVar->wRight  = wRight;

}

//---------------------------------------------------------------------------//

static void near GetSet( WORD wIndex, WORD wPrmIdx )
{
    PCLIPRECT Rect = GetRect();
    wPrmIdx++;

    if( Rect )
    {
        if( ( _lbase + wPrmIdx )->wType & NUMERIC )
            ( (WORD near *) Rect )[ 2 + wIndex ] =
                                    (int) ( ( _lbase + wPrmIdx )->pPointer1 );

        if( _pcount > 1 )
            _bcopy( (LPBYTE) _eval, (LPBYTE) Rect, sizeof( CLIPVAR ) );
        else
            _retni( ( (WORD near *) Rect )[ 2 + wIndex ] );
    }

    // si no es NUM_FLOAT ¢ es una ref a MemVar -> devuelve nil
}

//---------------------------------------------------------------------------//

CLIPPER ClipRect() // ( nTop, nLeft, nBottom, nRight ) -> NewRect
{
    NewRect( (PCLIPRECT) _eval, _parni( 1 ), _parni( 2 ),
                                _parni( 3 ), _parni( 4 ) );
}

//---------------------------------------------------------------------------//

CLIPPER ScreenRect() // () -> WholeScreenRect
{
    NewRect( (PCLIPRECT) _eval, 0, 0, _gtMaxRow(), _gtMaxCol() );
}

//---------------------------------------------------------------------------//

CLIPPER CenterRect() // ( nHeight, nWidth ) -> RectCenteredInScreen
{
    WORD wHeight = _parni( 1 );
    WORD wWidth  = _parni( 2 );

    NewRect( (PCLIPRECT) _eval, ( _gtMaxRow() / 2 ) - ( wHeight / 2 ),
                                ( _gtMaxCol() / 2 ) - ( wWidth / 2 ),
                                ( (PCLIPRECT) _eval )->wTop  + wHeight,
                                ( (PCLIPRECT) _eval )->wLeft + wWidth );
}

//---------------------------------------------------------------------------//

CLIPPER BackWRect() // ( wndRect ) -> RectOfBackAreaOfShadowedWindow
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
    {
        Rect->wBottom++;
        Rect->wRight += 2;
        _bcopy( (LPBYTE) _eval, (LPBYTE) Rect, sizeof( CLIPVAR ) );
    }
}

//---------------------------------------------------------------------------//

CLIPPER RectTop()    // ( Rect [, NewSet ] ) -> Rect->wTop ¢ NewRect
{
    GetSet( 1, 2 );
}

//---------------------------------------------------------------------------//

CLIPPER RectLeft()   // ( Rect [, NewSet ] ) -> Rect->wLeft ¢ NewRect
{
    GetSet( 2, 2 );
}

//---------------------------------------------------------------------------//

CLIPPER RectBottom() // ( Rect [, NewSet ] ) -> Rect->wBottom ¢ NewRect
{
    GetSet( 3, 2 );
}

//---------------------------------------------------------------------------//

CLIPPER RectRight()  // ( Rect [, NewSet ] ) -> Rect->wRight ¢ NewRect
{
    GetSet( 4, 2 );
}

//---------------------------------------------------------------------------//

CLIPPER RectChange()  // ( Rect , [nTop], [nLeft], [nBott], [nRit] ) -> NewRect
{
    GetSet( 1, 2 );
    GetSet( 2, 3 );
    GetSet( 3, 4 );
    GetSet( 4, 5 );
}

//---------------------------------------------------------------------------//

CLIPPER RectWidth()  // ( Rect ) -> nRectWidth
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
        _retni( Rect->wRight - Rect->wLeft + 1 );
    else
        _retni( 0 );
}

//---------------------------------------------------------------------------//

CLIPPER RectHeight()  // ( Rect ) -> nRectHeight
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
        _retni( Rect->wBottom - Rect->wTop + 1 );
    else
        _retni( 0 );
}

//---------------------------------------------------------------------------//

CLIPPER lIsInRect() // ( Rect, nRow, nCol )
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
    {
        WORD wRow   = _parni( 2 );
        WORD wCol   = _parni( 3 );

        _retl( wRow >= Rect->wTop    &&
               wRow <= Rect->wBottom &&
               wCol >= Rect->wLeft   &&
               wCol <= Rect->wRight  );
    }
    else
        _retl( FALSE );
}

//---------------------------------------------------------------------------//

CLIPPER RectSave() // ( Rect ) cScreenDelimitadaPorElRect
{
    PCLIPRECT Rect = GetRect();
    WORD      wSize;

    if( Rect )
    {
        _gtRectSize( Rect->wTop, Rect->wLeft,
                     Rect->wBottom, Rect->wRight, &wSize );

        _BYTESNEW( wSize );

        _VSTRLOCK( _eval );

        _gtSave( Rect->wTop, Rect->wLeft,
                 Rect->wBottom, Rect->wRight, _VSTR( _eval ) );

        _VSTRUNLOCK( _eval );
    }
    else
        _retc( "" );
}

//---------------------------------------------------------------------------//

CLIPPER RectRest() // ( Rect, cScreenDelimitadaPorElRect )
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
        _gtRest( Rect->wTop, Rect->wLeft,
                 Rect->wBottom, Rect->wRight, _parc( 2 ) );
}

//---------------------------------------------------------------------------//

CLIPPER RectBox() // ( Rect, cBoxString )
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
        _gtBox( Rect->wTop, Rect->wLeft,
                Rect->wBottom, Rect->wRight, _parc( 2 ) );
}

//---------------------------------------------------------------------------//

CLIPPER RectSay() // ( Rect, nRow, Col, cString )
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
        _gtWriteAt( Rect->wTop  + _parni( 2 ),
                    Rect->wLeft + _parni( 3 ),
                    _parc( 4 ), _parclen( 4 ) );

}

//---------------------------------------------------------------------------//

CLIPPER RectShadow() // ( Rect )
{
    PCLIPRECT Rect = GetRect();

    if( Rect )
        _gtShadow( Rect->wTop, Rect->wLeft,
                   Rect->wBottom, Rect->wRight );

}

//---------------------------------------------------------------------------//
