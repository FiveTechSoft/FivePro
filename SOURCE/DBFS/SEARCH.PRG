#include "Sde501.ch"

//----------------------------------------------------------------------------//

function Search( brw, cTitle )

   local nRecNo    := RecNo()
   local lSoftSeek := Set( _SET_SOFTSEEK, .t. )
   local uValue    := If( IndexOrd() != 0, uValBlank( IndexKey( IndexOrd() ) ),;
                          Space( 40 ) )

   DEFAULT cTitle := "Expresi¢n"

   if lMsgGet( "Buscar por", cTitle, @uValue )
      if ValType( uValue ) == "C"
         uValue = RTrim( uValue )
      endif
      brw:GoTop()
      if IndexOrd() != 0
         if ! DbSeek( uValue )
            nMsgBox( "La expresi¢n buscada no aparece", "Atenci¢n" )
            GO nRecNo
         endif
      else
         LOCATE for lFieldCheck( uValue )
         if ! Found()
            nMsgBox( "La expresi¢n buscada no aparece", "Atenci¢n" )
            GO nRecNo
         endif
      endif
   endif

   Set( _SET_SOFTSEEK, lSoftSeek )

return .t.

//----------------------------------------------------------------------------//

static function lFieldCheck( uValue )

   local n := 1
   local lFound := .f.

   do while n <= FCount() .and. ! lFound
      if AllTrim( cValToChar( uValue ) ) $ ;
         AllTrim( cValToChar( FieldGet( n ) ) )
         lFound = .t.
      endif
      n++
   enddo

return lFound

//----------------------------------------------------------------------------//
