//----------------------------------------------------------------------------//

function cKeyBuffer()

   local cBuffer := ""

   do while NextKey() != 0
      cBuffer += Chr( InKey( 0 ) )
   enddo

return cBuffer

//----------------------------------------------------------------------------//
