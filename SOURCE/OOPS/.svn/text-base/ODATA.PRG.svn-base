//----------------------------------------------------------------------------//

function aOData( oObject )

   local aInfo := ASort( __ClassSel( oObject:ClassH ) )
   local aData := {}
   local n     := 1

   while SubStr( aInfo[ n ], 1, 1 ) != "_"
      if AScan( aInfo, "_" + SubStr( aInfo[ n ], 1, 9 ), n + 1 ) != 0
         AAdd( aData, aInfo[ n ] )
      endif
      n++
   end

return aData

//----------------------------------------------------------------------------//
