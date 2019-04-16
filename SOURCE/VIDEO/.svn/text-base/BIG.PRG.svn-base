// Demo de utilizaci¢n de letras grandes
// (c) Antonio Linares, 1994
// Enlazar con BigLette.obj

//----------------------------------------------------------------------------//

function Main()

   SET COLOR TO "W+/B"
   CLS

   DrawText( 1, 1, "Hola", "Û", "N/B" )
   DrawText( 0, 0, "Hola", "²", "GR+/B" )

   DrawText( 11, 11, "Jose M¦", "Û", "N/B" )
   DrawText( 10, 10, "Jose M¦", "²", "R+/B" )

   DrawText( 1, 40, "OK ?", "Û", "N/B" )
   DrawText( 0, 39, "OK ?", "²", "G+/B" )

   InKey( 0 )

   CLS
   DrawText( 5, 10, "Clipper", "Û", "RB+/B" )
   DrawText( 4,  9, "Clipper", "Û", "R+/B" )
   DrawText( 3,  8, "Clipper", "Û", "GR+/B" )
   DrawText( 2,  7, "Clipper", "Û", "B+/B" )
   InKey( 0 )

return

//----------------------------------------------------------------------------//

function DrawText( nRow, nCol, cText, cChar, cColor )

   local n

   for n = 1 to Len( cText )
      DrawLetter( nRow, @nCol, BigLetter( Asc( SubStr( cText, n, 1 ) ) ),;
                  cChar, cColor )
   next

return

//----------------------------------------------------------------------------//

function DrawLetter( nRow, nCol, aLetra, cChar, cColor )

   local nFila
   local nChar

   for n = 1 to Len( aLetra )
      for nChar = 1 to 8
         if SubStr( aLetra[ n ], nChar, 1 ) != " "
            @ nRow + n - 1, nCol + nChar SAY cChar COLOR cColor
         endif
      next
   next

   nCol += 9

return

//----------------------------------------------------------------------------//
