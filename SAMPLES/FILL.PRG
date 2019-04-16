//----------------------------------------------------------------------------//

function Main()

   Rellena( 10, 10, 1, 2 )

return

//----------------------------------------------------------------------------//

function Rellena( nRow, nCol, nColor1, nColor2 )

   if GetPixel( nRow, nCol ) != nColor1
      if GetPixel( nRow, nCol ) != nColor2
         SetPixel( nRow, nCol, nColor1 )
      else
         return
      endif
   endif

   Rellena( nRow - 1, nCol - 1, nColor1, nColor2 )
   Rellena( nRow - 1, nCol,     nColor1, nColor2 )
   Rellena( nRow - 1, nCol + 1, nColor1, nColor2 )
   Rellena( nRow,  nCol - 1,    nColor1, nColor2 )
   Rellena( nRow, nCol + 1,     nColor1, nColor2 )
   Rellena( nRow + 1, nCol - 1, nColor1, nColor2 )
   Rellena( nRow + 1, nCol,     nColor1, nColor2 )
   Rellena( nRow + 1, nCol + 1, nColor1, nColor2 )

return

//----------------------------------------------------------------------------//
