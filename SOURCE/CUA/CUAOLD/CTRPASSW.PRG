#include "Objects.ch"
#include "InKey.ch"
#include "GetExit.ch"

//----------------------------------------------------------------------------//

CLASS TCtrPass FROM TControl

   DATA nRow, nCol, nLen, nPos
   DATA cText

   METHOD New( nRow, nCol, bSetGet, nLen, bWhen, bValid )
   METHOD Display()
   METHOD SetFocus( lOnOff )
   METHOD KeyApply( nKey )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD TCtrPass::New( nRow, nCol, bSetGet, nLen, bWhen, bValid )

   Super:New()

   DEFAULT bWhen := { || .t. }, bValid := { || .t. }

   ::nRow       = nRow
   ::nCol       = nCol
   ::bBlock     = bSetGet
   ::cText      = ""
   ::nLen       = nLen
   ::nPos       = 0
   ::bPreBlock  = bWhen
   ::bPostBlock = bValid

return Self

//----------------------------------------------------------------------------//

METHOD TCtrPass::Display()

   local acColors := aStr2Array( cClrVentana() )

   @ ::nRow, ::nCol ;
     SAY Replicate( "*", Len( ::cText ) ) + ;
         Replicate( "°", ::nLen - Len( ::cText ) );
     COLOR If( ::HasFocus, acColors[ 2 ], acColors[ 5 ] )

return

//----------------------------------------------------------------------------//

METHOD TCtrPass::SetFocus( lOnOff )

   Super:SetFocus( lOnOff )
   if lOnOff
      SetCursor( 1 )
   endif

   if lOnOff
      ::cText = Eval( ::bBlock )
      SetPos( ::nRow, ::nCol + ::nPos - If( ::nPos == ::nLen, 1, 0 ) )
   else
      Eval( ::bBlock, ::cText )
   endif

return

//----------------------------------------------------------------------------//

METHOD TCtrPass::KeyApply( nKey )

   do case
      case nKey == 8
           if ::nPos > 0
              ::cText = SubStr( ::cText, 1, Len( ::cText ) - 1 )
              ::nPos--
              ::Display()
              SetPos( ::nRow, ::nCol + ::nPos - If( ::nPos == ::nLen, 1, 0 ) )
           endif

      case nKey >= 32 .and. nKey <= 255
           if Len( ::cText ) < ::nLen
              ::cText += Chr( nKey )
              ::nPos++
              ::Display()
              SetPos( ::nRow, ::nCol + ::nPos )
              if ::nPos == ::nLen
                 ::ExitState = GE_ENTER
              endif
           endif

      otherwise
           Super:KeyApply( nKey )
   endcase

return

//----------------------------------------------------------------------------//
