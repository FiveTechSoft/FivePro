// Escritura en pantalla de cadenas con 'HotKeys'

//----------------------------------------------------------------------------//

function ScrSayHot( nRow, nCol, cText, cClrNormal, cClrHot )

   local nHotPos := At( "&", cText )

   do case
      case nHotPos == 0
           @ nRow, nCol SAY cText COLOR cClrNormal

      case nHotPos == 1
           @ nRow, nCol SAY SubStr( cText, 2, 1 ) COLOR cClrHot
           @ nRow, nCol + 1 SAY SubStr( cText, 3 ) COLOR cClrNormal

      otherwise
           @ nRow, nCol SAY SubStr( cText, 1, nHotPos - 1 ) COLOR cClrNormal
           @ nRow, nCol + nHotPos - 1 SAY SubStr( cText, nHotPos + 1, 1 ) ;
             COLOR cClrHot
           @ nRow, nCol + nHotPos SAY SubStr( cText, nHotPos + 2 ) ;
             COLOR cClrNormal
   endcase

return

//----------------------------------------------------------------------------//
