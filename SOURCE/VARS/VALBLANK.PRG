//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function uValBlank( uValue )

   local cType := ValType( uValue )
   local uResult

   do case
      case cType $ "CM"
       uResult = Space( Len( uValue ) )

      case cType == "N"
       uResult =  uValue - uValue

      case cType == "L"
       uResult = .f.

      case cType == "D"
       uResult = CToD( "  -  -  " )

   endcase

return uResult

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
