//----------------------------------------------------------------------------//

function nValLen( uValue )

   local cType := ValType( uValue )
   local nLen  := 0

   do case
      case cType $ "CMA"
           nLen = Len( uValue )

      case cType == "N"
           nLen = Len( Str( uValue ) )

      case cType == "L"
           nLen = 1

      case cType == "D"
           nLen = 8
   endcase

return nLen

//----------------------------------------------------------------------------//
