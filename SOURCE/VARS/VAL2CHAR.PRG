//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function cValToChar( uValue )

   local cType := ValType( uValue )

   do case
      case cType == "L"
           uValue = If( uValue, ".T.", ".F." )

      case cType == "N"
           uValue = AllTrim( Str( uvalue ) )

      case cType == "D"
           uValue = DToC( uValue )

   endcase

return uValue

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
