//----------------------------------------------------------------------------//

function aBrwCols( oBrw )

   local anCols  := {}
   local nColPos := oBrw:ColPos
   local n

   for n = 1 to oBrw:ColCount
       oBrw:ColPos = n
       oBrw:Hilite()
       AAdd( anCols, Col() )
       oBrw:ColPos++
   next

   oBrw:ColPos = nColPos

return anCols

//----------------------------------------------------------------------------//
