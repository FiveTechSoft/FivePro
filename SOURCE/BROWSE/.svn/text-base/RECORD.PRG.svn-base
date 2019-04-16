#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TRecord

   DATA aGetList
   DATA bHitTop
   DATA lEdit

   METHOD New( aGetList )
   METHOD Display()
   METHOD KeyApply( nKey )
   METHOD Exec()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( aGetList ) CLASS TRecord

   ::aGetList = aGetList
   ::bHitTop  = { || Alert( "Comienzo de fichero" ) }
   ::lEdit    = .t.

return Self

//----------------------------------------------------------------------------//

METHOD Display() CLASS TRecord

   AEval( ::aGetList, { | oGet | oGet:Display() } )

return

//----------------------------------------------------------------------------//

METHOD KeyApply( nKey ) CLASS TRecord

   do case
      case nKey == K_ENTER
           if ::lEdit
              SET CURSOR ON
              ReadModal( ::aGetList )
              SET CURSOR OFF
           endif

      case nKey == K_PGUP
           SKIP -1
           if BoF()
              GO TOP
              Eval( ::bHitTop )
           else
              ::Display()
           endif

      case nKey == K_PGDN
           SKIP
           if EoF()
              GO BOTTOM
           else
              ::Display()
           endif

      case nKey == K_HOME
           if BoF()
              Eval( ::bHitTop )
           else
              GO TOP
              ::Display()
           endif

      case nKey == K_END
           GO BOTTOM
           ::Display()
   endcase

return

//----------------------------------------------------------------------------//

METHOD Exec() CLASS TRecord

   local lEnd := .f.
   local nKey

   do while ! lEnd
      if ( nKey := InKey( 0 ) ) == K_ESC
         lEnd = .t.
      else
         ::KeyApply( nKey )
      endif
   enddo

return

//----------------------------------------------------------------------------//
