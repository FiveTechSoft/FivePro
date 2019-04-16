#include "FivePro.ch"

//----------------------------------------------------------------------------//

function aStr2Array( cList, cDelimiter )

   local nPos
   local aList := {}

   DEFAULT cDelimiter := ","

   while ( nPos := At( cDelimiter, cList ) ) != 0
      AAdd( aList, SubStr( cList, 1, nPos - 1 ) )
      cList = SubStr( cList, nPos + 1 )
   enddo

   AAdd( aList, cList )

return aList

//----------------------------------------------------------------------------//
