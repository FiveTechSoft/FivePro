#include "Sde501.ch"
#include "GetExit.ch"
#include "Inkey.ch"
#include "Set.ch"

//----------------------------------------------------------------------------//

CLASS TControl

   DATA   ExitState, Name, SubScript, Reader, cColorSpec
   DATA   bBlock, PreBlock, PostBlock, bAction
   DATA   HasFocus
   DATA   aGetList
   DATA   nChangeTo
   DATA   Row, Col

   METHOD New()
   METHOD Display() VIRTUAL
   METHOD SetFocus( lOnOff )
   METHOD KeyApply( nKey )
   METHOD UnDo() VIRTUAL
   METHOD CtrReader( oControl )
   METHOD cGetHotKey()
   METHOD lIsOver( nRow, nCol ) BLOCK { || .f. }
   METHOD Click() VIRTUAL

ENDCLASS

//----------------------------------------------------------------------------//

METHOD TControl::New()

   ::Name       = ""
   ::Reader     = { | oControl | oControl:CtrReader( oControl ) }
   ::PreBlock  = { || .t. }
   ::PostBlock = { || .t. }
   ::HasFocus	= .f.
   ::bAction    = { || nil }
   ::nChangeTo  = 0
   ::Row        = 0
   ::Col        = 0

return Self

//----------------------------------------------------------------------------//

METHOD TControl::SetFocus( lOnOff )

   ::HasFocus = lOnOff
   if lOnOff
      SetCursor( 0 )
   endif
   ::Display()

return

//----------------------------------------------------------------------------//

METHOD TControl::KeyApply( nKey )

   local nCtrlAt
   local nGoCtrl

   if SetKey( nKey ) != nil
      Eval( SetKey( nKey ) )    // , ProcName(), ProcLine, ReadVar() )
   else
      do case
         case nKey == 0         // Pulsaci¢n de rat¢n
              if ( nGoCtrl := nAtGetList( ::aGetList, nMRow(), nMCol() ) ) != 0
                 ::exitState = GE_CHANGETO
                 ::nChangeTo = nGoCtrl
              endif

         case nKey == K_ESC
              if Set( _SET_ESCAPE )
                 ::UnDo()
                 ::ExitState = GE_ESCAPE
              endif

         case nKey == K_ENTER
              ::ExitState = GE_ENTER

         case nKey == K_CTRL_W
              ::ExitState = GE_WRITE

         case nKey == K_UP
              ::ExitState = GE_UP

         case nKey == K_SH_TAB
              ::ExitState = GE_UP

         case nKey == K_DOWN
              ::ExitState = GE_DOWN

         case nKey == K_TAB
              ::ExitState = GE_DOWN

         case nKey == K_RIGHT
              ::ExitState = GE_DOWN

         case nKey == K_LEFT
              ::ExitState = GE_UP

         otherwise
              if ( nCtrlAt := AScan( ::aGetList,;
                   { | oCtrl | If( oCtrl:ClassName() == "GET", .f.,;
                               Upper( oCtrl:cGetHotKey() ) == ;
                               Upper( Chr( nKey ) ) ) } ) ) != 0
                 ::ExitState = GE_CHANGETO
                 ::nChangeTo = nCtrlAt
              endif

      endcase
   endif

return

//----------------------------------------------------------------------------//

METHOD TControl::CtrReader( oControl )

   if Eval( ::PreBlock )
      ::ExitState = GE_NOEXIT
      ::SetFocus( .t. )

      do while ::ExitState == GE_NOEXIT
         ::KeyApply( nMKeyWait( 0 ) )

         if ::ExitState != GE_ESCAPE .and. ;
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

//----------------------------------------------------------------------------//

METHOD TControl::cGetHotKey()

return ""

//----------------------------------------------------------------------------//

function nAtGetList( aGetList, nRow, nCol )

   local nAt := 0
   local n   := 1

   if aGetList != nil
      while n <= Len( aGetList ) .and. nAt == 0
         if aGetList[ n ]:ClassName == "GET"
            if nRow == aGetList[ n ]:Row .and. ;
               nCol >= aGetList[ n ]:Col .and. ;
               nCol <= aGetList[ n ]:Col + ;
               nValLen( Eval( aGetList[ n ]:Block ) ) - 1
               nAt = n
            endif
         else
            if aGetList[ n ]:lIsOver( nRow, nCol )
               nAt = n
            endif
         endif
         n++
      end
   endif

return nAt

//----------------------------------------------------------------------------//
