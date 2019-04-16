#include "InKey.ch"

//----------------------------------------------------------------------------//

function BrwExec( oBrowse )

   local lEnd := .f.
   local cScrOld := SaveScreen( oBrowse:nTop, oBrowse:nLeft,;
                                oBrowse:nBottom, oBrowse:nRight )
   local nKey

   do while ! lEnd

      do while ! oBrowse:Stabilize()
      enddo

      nKey = InKey( 0 )

      do case
         case nKey == K_ESC
              lEnd = .t.

         case nKey == K_UP
              oBrowse:Up()

         case nKey == K_DOWN
              oBrowse:Down()

         case nKey == K_PGUP
              oBrowse:PageUp()

         case nKey == K_PGDN
              oBrowse:PageDown()

         case nKey == K_CTRL_PGUP
              oBrowse:GoTop()

         case nKey == K_CTRL_PGDN
              oBrowse:GoBottom()
      endcase
   enddo

   RestScreen( oBrowse:nTop, oBrowse:nLeft, oBrowse:nBottom, oBrowse:nRight,;
               cScrOld )

return

//----------------------------------------------------------------------------//
