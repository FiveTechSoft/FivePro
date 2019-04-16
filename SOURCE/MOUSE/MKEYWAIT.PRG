static lIdle := .f.

// ----------------------------------------------------------------------------

function nMKeyWait( nTime, bAction )

   local nKeyCode := 0
   local nStart   := Seconds()
   local nMRowOld := nMRow()
   local nMColOld := nMCol()

   nTime = If( nTime == nil, 0, nTime )
   MUpdate()

   while ( nKeyCode := InKey() ) == 0 .and. ! lMPressed() .and. ;
           If( nTime == 0, .t., Seconds() - nStart < nTime )

      lIdle = .t.
      MUpdate()
      if nMRow() != nMRowOld .or. nMCol() != nMColOld
         lIdle = .f.
         nMRowOld = nMRow()
         nMColOld = nMCol()
      else
         lIdle = .t.
      end
      if bAction != nil .and. NextKey() == 0
         Eval( bAction )
      end
   end
   lIdle = .f.
   if NextKey() == 0
      if bAction != nil
         Eval( bAction )
      end
   endif

   if SetKey( nKeyCode ) != nil
      Eval( SetKey( nKeyCode ) )
   end

return nKeyCode

// ----------------------------------------------------------------------------

function lIsIdle() ; return lIdle

// ----------------------------------------------------------------------------
