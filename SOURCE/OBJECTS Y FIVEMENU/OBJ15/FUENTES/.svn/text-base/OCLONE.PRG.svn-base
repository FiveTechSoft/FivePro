// Genera un nuevo Objeto duplicado a partir de otro

//----------------------------------------------------------------------------//

function oOClone( oObject )

   local oClone := __ClassIns( oObject:ClassH() )
   local n

   ASize( oClone, Len( oObject ) )

   for n = 1 to Len( oObject )
       do case
          case ValType( oObject[ n ] ) == "A"
               oClone[ n ] = aAClone( oObject[ n ] )

          case ValType( oObject[ n ] ) == "O"
               oClone[ n ] = oOClone( oObject[ n ] )

          otherwise
               oClone[ n ] = oObject[ n ]
       endcase
   next

return oClone

//----------------------------------------------------------------------------//

function aAClone( aArray )

   local aResult := Array( Len( aArray ) )
   local n

   for n = 1 to Len( aArray )
       do case
          case ValType( aArray[ n ] ) == "A"
               aResult[ n ] = aAClone( aArray[ n ] )

          case ValType( aArray[ n ] ) == "O"
               aResult[ n ] = oOClone( aArray[ n ] )

          otherwise
              aResult[ n ] = aArray[ n ]
       endcase
   next

return aResult

//----------------------------------------------------------------------------//
