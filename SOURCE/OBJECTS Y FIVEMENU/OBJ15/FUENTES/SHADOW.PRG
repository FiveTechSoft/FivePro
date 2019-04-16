// Sombrea areas de pantalla

// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

function ScrShadow( nTop, nLeft, nBottom, nRight )

return RestScreen( nTop, nLeft, nBottom, nRight,;
          Transform( SaveScreen( nTop, nLeft, nBottom, nRight ),;
          Replicate( "X" + Chr( 7 ), ( nBottom - nTop + 1 ) * ;
          ( nRight - nLeft + 1 ) ) ) )

//----------------------------------------------------------------------------//
