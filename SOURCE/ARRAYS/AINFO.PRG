static aArrays := {}

//----------------------------------------------------------------------------//

function aAInfo( aArray, cName )

   local aInfo := {}
   local n, nAt

   if ( nAt := AScan( aArrays, aArray ) ) != 0
      AAdd( aInfo, "Array[ " + Str( nAt, 3 ) + "]" )
   else
      for n = 1 to Len( aArray )
         do case
            case ValType( aArray[ n ] ) == "A"
                 if ( nAt := AScan( aArrays, aArray[ n ] ) ) != 0
                    AAdd( aInfo, "Array[ " + Str( nAt, 3 ) + "]" )
                 else
                    AAdd( aInfo, aAInfo( aArray[ n ] ) )
                    AAdd( aArrays, aArray[ n ] )
                 endif

            case ValType( aArray[ n ] ) == "O"
                 AAdd( aInfo, aOInfo( aArray[ n ] ) )

            otherwise
                 AAdd( aInfo, cName + "[ " + Str( n, 3 ) + " ]: " + ;
                       cValToStr( aArray[ n ] ) )
         endcase
      next
      AAdd( aArrays, aArray )
   endif

return aInfo

//----------------------------------------------------------------------------//
