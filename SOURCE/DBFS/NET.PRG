#include "sde501.ch"

//----------------------------------------------------------------------------//

function lNetRecAdd( nWaitSeconds )

   local lForEver

   APPEND BLANK

   if ! NetErr()
      return .t.
   endif

   lForEver = ( nWaitSeconds == 0 )

   do while ( lForEver .or. nWaitSeconds > 0 )
      APPEND BLANK
      if ! NetErr()
         return .t.
      endif
      InKey( .5 )
      nWaitSeconds -= .5
   enddo

return .f.

//----------------------------------------------------------------------------//

function lInsertar( nWaitSeconds )

return lNetRecAdd( nWaitSeconds )

//----------------------------------------------------------------------------//

/***
*  FilLock( <nWaitSeconds> ) --> lSuccess
*  Attempt to FLOCK() with optional retry
*/
FUNCTION FilLock( nSeconds )
   LOCAL lForever
   IF FLOCK()
      RETURN (.T.)      // Locked
   ENDIF
   lForever = (nSeconds = 0)
   DO WHILE (lForever .OR. nSeconds > 0)
      INKEY(.5)         // Wait 1/2 second
      nSeconds = nSeconds - .5
      IF FLOCK()
         RETURN (.T.)   // Locked
      ENDIF
   ENDDO
   RETURN (.F.)         // Not locked

//----------------------------------------------------------------------------//

function lNetUse( cDataBase, lOpenMode, nSeconds, cAlias, lMsg )

   local lForever

   DEFAULT lOpenMode := .f.
   DEFAULT nSeconds  := 1
   DEFAULT lMsg      := .t.

   lForever := ( nSeconds == 0 )

   while ( lForever .or. nSeconds > 0 )
     DbUseArea( .f.,, cDataBase, cAlias, ! lOpenMode, )
     if ! NetErr()
        return .t.
     endif
     InKey( 1 )
     nSeconds--
   enddo

   if lMsg
      nMsgBox( " Fichero(s) Bloqueado(s); Acceso Denegado", "Atenci¢n" )
   endif

return .f.

//----------------------------------------------------------------------------//

function lAbrir( cDataBase, lOpenMode, nSeconds )

return lNetUse( cDataBase, lOpenMode, nSeconds )

//----------------------------------------------------------------------------//

function lNetRecLock( nSeconds )

   local lForever

   DEFAULT nSeconds := 1

   if RLock()
      return .t.
   endif
   lForever = ( nSeconds == 0 )

   do while ( lForever .OR. nSeconds > 0 )
      if RLock()
         return .t.
      endif
      InKey( .5 )
      nSeconds -= .5
   enddo

   nMsgBox( " Registro Bloqueado; Acceso Denegado", "Atenci¢n" )

return .f.

//----------------------------------------------------------------------------//

function lR_Llave( nSeconds )

return lNetRecLock( nSeconds )

//----------------------------------------------------------------------------//
