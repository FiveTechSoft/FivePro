#include "Sde501.ch"
#include "InKey.ch"
#include "GetExit.ch"

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

CLASS TCtrRadio FROM TControl

   DATA   nTop, nLeft, nBottom, nRight
   DATA   cLabel
   DATA   oMnuRadio
   DATA   lVisible, lHorizontal

   METHOD New( nRow, nCol, bSetGet, acItems, cLabel, bWhen, bValid, cHorizontal )
   METHOD Display()
   METHOD KeyApply( nKey )
   METHOD SetFocus( lOnOff )
   METHOD CtrReader( oControl )
   METHOD cGetHotKey()

ENDCLASS

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD New( nRow, nCol, bSetGet, acItems, cLabel, bWhen, bValid, cHorizontal ) ;
   CLASS TCtrRadio

   local nOption := Eval( bSetGet )
   local nWidth  := 0
   local nPos    := 1

   DEFAULT cLabel := "", bWhen := { || .t. }, bValid := { || .t. },;
           cHorizontal := "VERTICAL"

   AEval( acItems, { | cItem | nWidth := Max( nWidth, Len( cItem ) + 1 ) } )

   Super:New()

   ::oMnuRadio   = TMenu():New( If( nOption == 0, 1, nOption ) )
   ::nTop        = nRow
   ::nLeft       = nCol
   ::nBottom     = nRow + Len( acItems ) + 1
   ::nRight      = nCol + nWidth + 5
   ::bBlock      = bSetGet
   ::cLabel      = cLabel
   ::PreBlock    = bWhen
   ::PostBlock   = bValid
   ::lVisible    = .f.
   ::lHorizontal = If( Upper( cHorizontal ) == "HORIZONTAL", .t., .f. )

   if ::lHorizontal
      AEval( acItems, { | cItem, n | AAdd( ::oMnuRadio:aoItems, TRadio():;
             New( nRow + 1, nCol + If( n == 1, 1, nPos ),;
                  cItem + " " ) ), nPos += 5 + Len( cItem ) } )
   else
      AEval( acItems, { | cItem, n | AAdd( ::oMnuRadio:aoItems, TRadio():;
             New( nRow + n, nCol + 1, PadR( cItem, nWidth ) ) ) } )
   endif

return Self

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD Display() CLASS TCtrRadio
   
   local nWidth := 0

   if ! ::lVisible
      ::lVisible = .t.
      if ::lHorizontal
         AEval( ::oMnuRadio:aoItems,;
                { | oRadio | nWidth += 4 + Len( oRadio:cText ) } )
         @ ::nTop, ::nLeft TO ::nTop + 2, ::nLeft + nWidth + 1
      else
         @ ::nTop, ::nLeft TO ::nBottom, ::nRight
      endif
      if ! Empty( ::cLabel )
         ScrSayHot( ::nTop, ::nLeft + 1, " " + ::cLabel + " ",;
                    cClrVentanas(), "BG+/" + SubStr( cClrVentanas(),;
                    At( "/", cClrVentanas() ) + 1 ) )
      endif
   endif

   ::oMnuRadio:aoItems[ ::oMnuRadio:nOption ]:lCheck = .t.
   ::oMnuRadio:Display()

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD SetFocus( lOnOff ) CLASS TCtrRadio
      
   if lOnOff
      ::oMnuRadio:aoItems[ ::oMnuRadio:nOption ]:SetFocus( lOnOff )
   else
      ::oMnuRadio:aoItems[ ::oMnuRadio:nOption ]:lFocus = .f.
      ::oMnuRadio:aoItems[ ::oMnuRadio:nOption ]:lCheck = .t.
      ::oMnuRadio:aoItems[ ::oMnuRadio:nOption ]:Display()
   endif

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD KeyApply( nKey ) CLASS TCtrRadio

   do case
      case nKey == K_HOME
           ::oMnuRadio:KeyApply( nKey )

      case nKey == K_END
           ::oMnuRadio:KeyApply( nKey )

      case nKey == K_DOWN
           if ! ::lHorizontal
              ::oMnuRadio:KeyApply( nKey )
           else
              Super:KeyApply( nKey )
           endif

      case nKey == K_UP
           if ! ::lHorizontal
              ::oMnuRadio:KeyApply( nKey )
           else
              Super:KeyApply( nKey )
           endif

      case nKey == K_LEFT
           if ::lHorizontal
              ::oMnuRadio:KeyApply( nKey )
           else
              Super:KeyApply( nKey )
           endif

      case nKey == K_RIGHT
           if ::lHorizontal
              ::oMnuRadio:KeyApply( nKey )
           else
              Super:KeyApply( nKey )
           endif

      otherwise
           Super:KeyApply( nKey )
   endcase
   Eval( ::bBlock, ::oMnuRadio:nOption )

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD CtrReader( oControl ) CLASS TCtrRadio

   if Eval( ::PreBlock )
      ::ExitState = GE_NOEXIT
      ::SetFocus( .t. )

      do while ::ExitState == GE_NOEXIT
         ::KeyApply( InKey( 0 ) )

         if ::ExitState != GE_ESCAPE .and. ;
            ( ( ! ::lHorizontal .and. LastKey() != K_DOWN .and. ;
                LastKey() != K_UP ) .or. ;
              ( ::lHorizontal .and. LastKey() != K_LEFT .and. ;
                LastKey() != K_RIGHT ) ) .and. ;
            LastKey() != K_HOME .and. LastKey() != K_END .and. ;
            ! Eval( ::PostBlock )
            ::ExitState = GE_NOEXIT
         else
            if ::ExitState == GE_CHANGETO
               if ! Eval( ::aGetList[ ::nChangeTo ]:PreBlock )
                  ::ExitState = GE_NOEXIT
               else
                  if ::aGetList[ ::nChangeTo ]:ClassName() == "TBUTTON"
                     KEYBOARD Chr( 32 )
                  endif
               endif
            endif
         endif
      enddo

      ::SetFocus( .f. )

   endif

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

METHOD cGetHotKey() CLASS TCtrRadio

   local nAt := At( "&", ::cLabel )

return If( nAt == 0, "", SubStr( ::cLabel, nAt + 1, 1 ) )

//----------------------------------------------------------------------------//
