// Hojeador de Clases en tiempo de ejecuci¢n

// (C) Antonio Linares, 1993

#include "InKey.ch"

//----------------------------------------------------------------------------//

function ClassBrowser()

   local aInfo      := { acClasses(), {}, {} }
   local brwClasses := TBrowseArray( 3, 3, 20, 15, aInfo[ 1 ] )
   local n, nKey, nBrwAt := 1, nCrsOld := SetCursor( 0 )
   local lEnd       := .f.
   local aBrowsers

   aInfo[ 2 ] = Array( Len( aInfo[ 1 ] ) )
   aInfo[ 3 ] = Array( Len( aInfo[ 1 ] ) )

   for n = 1 to Len( aInfo[ 1 ] )
       ClsInfo( n, aInfo[ 2 ][ n ] := {}, aInfo[ 3 ][ n ] := {} )
   next

   brwData = TBrowseArray( 3, 16, 20, 27, aInfo[ 2 ][ brwClasses:Cargo ] )
   brwMethods = TBrowseArray( 3, 29, 20, 40, aInfo[ 3 ][ brwClasses:Cargo ] )

   @  2,  2 TO 21, 42
   @  2,  6 SAY "CLASSES"
   @  2, 20 SAY "DATA"
   @  2, 30 SAY "METHODS"
   @ 21,  4 SAY " CLASS BROWSER 1.0 - (C) OBJECTS.LIB "

   do while ! lEnd

      do while ! brwClasses:Stabilize()
      enddo
      ScrollBar( 3, 15, 20, 15, Len( aInfo[ 1 ] ), brwClasses:Cargo )

      if nBrwAt == 1
         brwData = TBrowseArray( 3, 16, 20, 27, aInfo[ 2 ][ brwClasses:Cargo ] )
         brwMethods = TBrowseArray( 3, 29, 20, 40, aInfo[ 3 ][ brwClasses:Cargo ] )
         brwData:AutoLite = .f.
         brwMethods:AutoLite = .f.
      endif

      do while ! brwData:Stabilize()
      enddo
      ScrollBar( 3, 28, 20, 28, Len( aInfo[ 2 ][ brwClasses:Cargo ] ),;
                 brwData:Cargo )
      do while ! brwMethods:Stabilize()
      enddo
      ScrollBar( 3, 41, 20, 41, Len( aInfo[ 3 ][ brwClasses:Cargo ] ),;
                 brwMethods:Cargo )

      aBrowsers = { brwClasses, brwData, brwMethods }
      aBrowsers[ nBrwAt ]:Hilite()

      nKey = InKey( 0 )

      do case
         case nKey == K_ESC
              lEnd = .t.

         case nKey == K_LEFT
              nBrwAt = Max( nBrwAt - 1, 1 )

         case nKey == K_RIGHT
              nBrwAt = Min( nBrwAt + 1, 3 )

         otherwise
              BrwKeyApply( aBrowsers[ nBrwAt ], nKey )
      endcase
   enddo

   SetCursor( nCrsOld )

return

//----------------------------------------------------------------------------//

function acClasses()

   local acClasses := {}
   local n := 1

   do while ! Empty( __ClassNam( n ) )
      AAdd( acClasses, PadR( __ClassNam( n++ ), 10 ) )
   enddo

return acClasses

//----------------------------------------------------------------------------//

function ClsInfo( nClass, acClsData, acClsMethods )

   local acClsInfo := __ClassSel( nClass )
   local n

   for n = 1 to Len( acClsInfo )
       if SubStr( acClsInfo[ n ], 1, 1 ) != "_"
          if AScan( acClsInfo, { | cInfo | SubStr( "_" + acClsInfo[ n ],;
                    1, 10 ) == cInfo } ) != 0
             AAdd( acClsData, PadR( acClsInfo[ n ], 10 ) )
          else
             AAdd( acClsMethods, PadR( acClsInfo[ n ], 10 ) )
          endif
       endif
   next

   ASort( acClsData )
   ASort( acClsMethods )

return

//----------------------------------------------------------------------------//
