#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TCtrColor FROM TControl

   DATA nRow, nCol
   DATA lVisible
   DATA cLabel

   METHOD New( nRow, nCol, bSetGet, cLabel ) CONSTRUCTOR
   METHOD Display()
   METHOD SetFocus( lOnOff )
   METHOD KeyApply( nKey )
   METHOD Mark( nStatus )
   METHOD cGetHotKey()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, bSetGet, cLabel ) CLASS TControl

   DEFAULT cLabel := ""

   Super:New()

   ::nRow     = nRow + 1
   ::nCol     = nCol + 1
   ::bBlock   = bSetGet
   ::lVisible = .f.
   ::cLabel   = cLabel

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TCtrColor

   local nRow, nCol, nColor

   SetBlink( .f. )

   if ! ::lVisible
      @ ::nRow - 1, ::nCol - 1 TO ::nRow + 8, ::nCol + 16
      if ! Empty( ::cLabel )
         ScrSayHot( ::nRow - 1, ::nCol, " " + ::cLabel + " ",;
                    cClrVentanas(), "BG+/" + SubStr( cClrVentanas(),;
                    At( "/", cClrVentanas() ) + 1 ) )
      endif
   endif

   for nRow = 0 to 3
       for nCol = 0 to 3
           nColor = ( nRow * 64 ) + ( nCol * 16 )
           RestScreen( ::nRow + ( nRow * 2 ),;
                       ::nCol + ( nCol * 4 ),;
                       ::nRow + ( nRow * 2 ) + 1,;
                       ::nCol + ( nCol * 4 ) + 3,;
                       " " + Chr( nColor ) + " " + Chr( nColor ) + ;
                       " " + Chr( nColor ) + " " + Chr( nColor ) + ;
                       " " + Chr( nColor ) + " " + Chr( nColor ) + ;
                       " " + Chr( nColor ) + " " + Chr( nColor ) )
       next
   next
*  ::Mark( 1 )

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TCtrColor

   ::HasFocus = lOnOff
   if lOnOff
      SetCursor( 0 )
   endif
   ::Mark( If( lOnOff, 2, 1 ) )

return

//----------------------------------------------------------------------------//

METHOD Mark( nStatus ) CLASS TCtrColor

   local nColor := Eval( ::bBlock ) * 16
   local nRow   := Int( Eval( ::bBlock ) / 4 )
   local nCol   := Eval( ::bBlock ) % 4


   nColor = If( nColor > ( 15 * 8 ), nColor, nColor +  15 )
   if nStatus == 1

      RestScreen( ::nRow + ( nRow * 2 ),;
               ::nCol + ( nCol * 4 ),;
               ::nRow + ( nRow * 2 ) + 1,;
               ::nCol + ( nCol * 4 ) + 3,;
               If( nStatus == 0,;
               " " + Chr( nColor ) + " " + Chr( nColor ) + ;
               " " + Chr( nColor ) + " " + Chr( nColor ) + ;
               " " + Chr( nColor ) + " " + Chr( nColor ) + ;
               " " + Chr( nColor ) + " " + Chr( nColor ),;
               "°" + Chr( nColor ) + "°" + Chr( nColor ) + ;
               "°" + Chr( nColor ) + "°" + Chr( nColor ) + ;
               "°" + Chr( nColor ) + "°" + Chr( nColor ) + ;
               "°" + Chr( nColor ) + "°" + Chr( nColor ) ) )
   else

      RestScreen( ::nRow + ( nRow * 2 ),;
               ::nCol + ( nCol * 4 ),;
               ::nRow + ( nRow * 2 ) + 1,;
               ::nCol + ( nCol * 4 ) + 3,;
               If( nStatus == 0,;
               " " + Chr( nColor ) + " " + Chr( nColor ) + ;
               " " + Chr( nColor ) + " " + Chr( nColor ) + ;
               " " + Chr( nColor ) + " " + Chr( nColor ) + ;
               " " + Chr( nColor ) + " " + Chr( nColor ),;
               "Ú" + Chr( nColor ) + "Ä" + Chr( nColor ) + ;
               "Ä" + Chr( nColor ) + "¿" + Chr( nColor ) + ;
               "À" + Chr( nColor ) + "Ä" + Chr( nColor ) + ;
               "Ä" + Chr( nColor ) + "Ù" + Chr( nColor ) ) )
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyApply( nKey ) CLASS TCtrColor

   local nColor := Eval( ::bBlock ) * 16
   local nRow   := Int( Eval( ::bBlock ) / 4 )
   local nCol   := Eval( ::bBlock ) % 4

   nColor = If( nColor > ( 7 * 8 ), nColor, nColor +  7 )

   do case
      case nKey == K_UP
           if Int( Eval( ::bBlock ) / 4 ) > 0
              ::Mark( 0 )
              Eval( ::bBlock, Eval( ::bBlock ) - 4 )
              ::Mark( 2 )
           endif

      case nKey == K_DOWN
           if Int( Eval( ::bBlock ) / 4 ) < 3
              ::Mark( 0 )
              Eval( ::bBlock, Eval( ::bBlock ) + 4 )
              ::Mark( 2 )
           endif

      case nKey == K_LEFT
           if ( Eval( ::bBlock ) % 4 ) > 0
              ::Mark( 0 )
              Eval( ::bBlock, Eval( ::bBlock ) - 1 )
              ::Mark( 2 )
           endif

      case nKey == K_RIGHT
           if ( Eval( ::bBlock ) % 4 ) < 3
              ::Mark( 0 )
              Eval( ::bBlock, Eval( ::bBlock ) + 1 )
              ::Mark( 2 )
           endif

      otherwise
           Super:KeyApply( nKey )
   endcase

return

//----------------------------------------------------------------------------//

METHOD cGetHotKey() CLASS TCtrColor

   local nAt := At( "&", ::cLabel )

return If( nAt == 0, "", SubStr( ::cLabel, nAt + 1, 1 ) )

//----------------------------------------------------------------------------//
