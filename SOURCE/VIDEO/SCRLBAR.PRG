//---------------------------------------------------------------------------//

function ScrollBar( nTop, nLeft, nBottom, nRight, nTotal, nActual, cColor )

   if nActual <= nTotal
      if nLeft == nRight
         @ nTop, nLeft SAY Chr( 30 ) COLOR cColor
         @ nBottom, nRight SAY Chr( 31 ) COLOR cColor
         @ nTop + 1, nLeft, nBottom - 1, nRight BOX "°" COLOR cColor
         @ nTop + 1 + ( ( nActual - 1 ) * ( ( nBottom - nTop - 2 ) / If( nTotal > 1,;
           nTotal - 1, nTotal ) ) ), nLeft SAY "²" COLOR cColor
      else
         @ nTop, nLeft SAY Chr( 17 ) COLOR cColor
         @ nBottom, nRight SAY Chr( 16 ) COLOR cColor
         @ nTop, nLeft + 1, nBottom, nRight - 1 BOX "°" COLOR cColor
         @ nTop, nLeft + 1 + ( ( nActual - 1 ) * ( ( nRight - nLeft - 2 ) / If( nTotal > 1,;
           nTotal - 1, nTotal ) ) ) SAY "²" COLOR cColor
      endif
   endif

return

//---------------------------------------------------------------------------//
