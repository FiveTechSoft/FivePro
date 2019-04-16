#include "Sde501.ch"
#include "Inkey.ch"

//----------------------------------------------------------------------------//

CLASS TButton FROM TControl

   DATA   Row, Col, cText, cBack

   METHOD New( Row, Col, cText, bAction, bWhen, bValid ) CONSTRUCTOR
   METHOD Display()
   METHOD KeyApply( nKey )
   METHOD cGetHotKey()
   METHOD lIsOver( nRow, nCol )
   METHOD Click() BLOCK { || __KeyBoard( 32 ) }

ENDCLASS

//----------------------------------------------------------------------------//

METHOD TButton::New( Row, Col, cText, bAction, bWhen, bValid )

   DEFAULT bAction := { || nil }, bWhen := { || .t. }, bValid := { || .t. }

   Super:New()

   ::Row       := Row
   ::Col       := Col
   ::cText     := cText
   ::cBack     := SaveScreen( Row, Col, Row + 1, Col + Len( cText ) )
   ::bAction   := bAction
   ::PreBlock  := bWhen
   ::PostBlock := bValid

return

//----------------------------------------------------------------------------//

METHOD TButton::Display()

   BtnDraw( ::Row, ::Col, ::cText, If( ::HasFocus, 127, 112 ), 123 )

return

//----------------------------------------------------------------------------//

METHOD TButton::KeyApply( nKey )

   if SetKey( nKey ) != nil
      Eval( SetKey( nKey ) )
   else
      If nKey == K_ENTER .or. nKey == K_SPACE
         MOff()
         RestScreen( ::Row, ::Col, ::Row + 1, ::Col + Len( ::cText ), ;
             ::cBack )

         ScrSayHot( ::Row, ::Col + 1, ::cText, "W+/W", "BG+/W" )

         SysWait( 4 )

         MOn()
         Eval( ::bAction )
         MOff()
         RestScreen( ::Row, ::Col, ::Row + 1, ::Col + Len( ::cText ), ;
             ::cBack )
         ::Display()
         MOn()
      else
         Super:KeyApply( nKey )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD TButton::cGetHotKey()

   local nAt := At( "&", ::cText )

return If( nAt == 0, "", SubStr( ::cText, nAt + 1, 1 ) )

//----------------------------------------------------------------------------//

METHOD lIsOver( nRow, nCol ) CLASS TButton

return nRow == ::Row .and. nCol >= ::Col .and. nCol <= ::Col + Len( ::cText ) - 1

//----------------------------------------------------------------------------//

function nBtnOk()                             // Friend Function

   KEYBOARD Chr( K_CTRL_W )

return 1

//----------------------------------------------------------------------------//

function nBtnCancel()                        // Friend Function

   KEYBOARD Chr( K_ESC )

return 0

//----------------------------------------------------------------------------//

function BtnHelp()                          // Friend function

   KEYBOARD Chr( K_F1 )

return

//----------------------------------------------------------------------------//
