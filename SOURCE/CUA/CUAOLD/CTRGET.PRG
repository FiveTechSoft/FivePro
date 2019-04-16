#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TCtrGet FROM TControl

   DATA oGet

   METHOD New( oGet )
   METHOD Display()
   METHOD KeyApply( nKey )
   METHOD SetFocus( lOnOff )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD TCtrGet::New( oGet )

   ::Parent:New()

   ::oGet = oGet

return Self

//----------------------------------------------------------------------------//

METHOD TCtrGet::Display()

   ::oGet:Display()

return

//----------------------------------------------------------------------------//

METHOD TCtrGet::KeyApply( nKey )

   do case
      case nKey == K_LEFT
           ::oGet:Left()

      case nKey == K_RIGHT
           ::oGet:Right()

      case nKey >= 32 .and. nKey <= 255
           ::oGet:OverStrike( Chr( nKey ) )

      otherwise
           ::Parent:KeyApply( nKey )
   endcase

return

//----------------------------------------------------------------------------//

METHOD TCtrGet::SetFocus( lOnOff )

   ::Parent:SetFocus( lOnOff )

   if lOnOff
      ::oGet:SetFocus()
      ::oGet:Buffer = "****"
   else
      ::oGet:KillFocus()
   endif
   SetCursor( 1 )

return

//----------------------------------------------------------------------------//
