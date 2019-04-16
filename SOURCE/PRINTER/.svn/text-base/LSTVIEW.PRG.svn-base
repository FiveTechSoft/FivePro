#include "Sde501.ch"
#include "InKey.ch"
#include "FileIO.ch"

//----------------------------------------------------------------------------//

function ListView( cFileName )

   local oWnd := TWindow():NewCentered( MaxRow() - 4, MaxCol(), "Listados por Pantalla" )
   local oBrw := TBrowseText( oWnd:nTop + 1, oWnd:nLeft + 1,;
                  oWnd:nBottom - 1, oWnd:nRight - 1, cFileName )
   local nCrsOld := SetCursor( 0 )
   local lEnd    := .f.

   ACTIVATE WINDOW oWnd

   do while ! lEnd

      do while ! oBrw:Stabilize()
      enddo

      ScrollBar( oWnd:nTop + 1, oWnd:nRight, oWnd:nBottom - 1,;
                 oWnd:nRight, oBrw:Cargo[ 2 ],;
                 FSeek( oBrw:Cargo[ 1 ], 0, FS_RELATIVE ) + 1 )

      nKey = InKey( 0 )

      do case
         case nKey == K_ESC
              lEnd = .t.

         case nKey == K_LEFT
              oBrw:Cargo[ 4 ] = Max( oBrw:Cargo[ 4 ] - 10, 1 )
              oBrw:RefreshAll()

         case nKey == K_RIGHT
              oBrw:Cargo[ 4 ] += 10
              oBrw:RefreshAll()

         case nKey == K_HOME
              oBrw:Cargo[ 4 ] = 1
              oBrw:RefreshAll()

         case nKey == K_END
              oBrw:Cargo[ 4 ] = 55
              oBrw:RefreshAll()

         otherwise
              BrwKeyApply( oBrw, nKey )
      endcase
   enddo

   DEACTIVATE WINDOW oWnd
   FClose( oBrw:Cargo[ 1 ] )
   SetCursor( nCrsOld )

return

//----------------------------------------------------------------------------//
