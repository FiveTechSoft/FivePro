// Objects.prg ver 1.5

//----------------------------------------------------------------------------//

#include "Objects.ch"
#include "Error.ch"

extern _DATA1,   _DATA2,  _DATA3,  _DATA4,  _DATA5,  _DATA6,  _DATA7,  _DATA8,;
       _DATA9,  _DATA10, _DATA11, _DATA12, _DATA13, _DATA14, _DATA15, _DATA16,;
       _DATA17, _DATA18, _DATA19, _DATA20, _DATA21, _DATA22, _DATA23, _DATA24,;
       _DATA25, _DATA26, _DATA27, _DATA28, _DATA29, _DATA30, _DATA31, _DATA32,;
       _DATA33, _DATA34, _DATA35, _DATA36, _DATA37, _DATA38, _DATA39, _DATA40,;
       _DATA41, _DATA42, _DATA43, _DATA44, _DATA45, _DATA46, _DATA47, _DATA48,;
       _DATA49, _DATA50, _DATA51, _DATA52, _DATA53, _DATA54, _DATA55, _DATA56,;
       _DATA57, _DATA58, _DATA59, _DATA60

#define CLS_nNAME    1
#define CLS_nPARENTS 2
#define CLS_nDATA    3
#define CLS_nMETHODS 4

#define DTA_nNAME    1
#define DTA_nSCOPE   2

#define MTH_nNAME    1
#define MTH_nBLOCK   2

static aThisClass, aClasses := {}
static bOldError

//----------------------------------------------------------------------------//

function cMethodName()

   local n := 0
   local cClassName  := ""
   local cMethodName := ""

   do while ! Empty( ProcName( n ) )
      if At( "(b)", ProcName( n ) ) != 0
         cClassName = SubStr( ProcName( n ), 4 )
      endif
      n++
   enddo

   if ! Empty( cClassName )
      cMethodName = cClassName + SubStr( ProcName( n - 2 ), 4 )
   endif

return cMethodName

//----------------------------------------------------------------------------//

function aClassTree( nClass )

   local aTree := { __ClassNam( nClass ), {} }

   if aClasses[ nClass ][ CLS_nPARENTS ] != nil
      for n = 1 to Len( aClasses[ nClass ][ CLS_nPARENTS ] )
          AAdd( aTree[ 2 ],;
                aClassTree( aClasses[ nClass ][ CLS_nPARENTS ][ n ] ) )
      next
   endif

return aTree

//----------------------------------------------------------------------------//

function lClsAscendant( nClass, cClass )

   local lFound    := .f.
   local anParents := aClasses[ nClass ][ CLS_nPARENTS ]
   local n         := 1

   if anParents != nil
      if AScan( anParents,;
                { | nClsParent | __ClassNam( nClsParent ) == cClass } ) != 0
         lFound = .t.
      endif
      if ! lFound
         do while n <= Len( anParents ) .and. ! lFound
            lFound = lClsAscendant( anParents[ n ], cClass )
            n++
         enddo
      endif
   endif

return lFound

//----------------------------------------------------------------------------//

function aGetClasses()
return aClasses

//----------------------------------------------------------------------------//

static function OopsError( Error )

return Eval( bOldError, Error )

//----------------------------------------------------------------------------//

function ClsNew( cClassName, abParents )

   local n
   local anParents := Array( Len( abParents ) )

   if bOldError == nil
      bOldError = ErrorBlock( { | oError | OopsError( oError ) } )
   endif

   AEval( abParents,;
          { | bParent, n | anParents[ n ] := bParent:Eval():ClassH() } )

   aThisClass = { Upper( cClassName ), anParents, {}, {} }

   for n = 1 to Len( anParents )
       AEval( aClasses[ anParents[ n ] ][ CLS_nDATA ], { | aData | ;
              ClsAddData( aData[ DTA_nNAME ], aData[ DTA_nSCOPE ] ) } )
       AEval( aClasses[ anParents[ n ] ][ CLS_nMETHODS ], { | aMethod | ;
              ClsAddMethod( aMethod[ MTH_nNAME ], aMethod[ MTH_nBLOCK ] ) } )
   next

return

//----------------------------------------------------------------------------//

function ClsAddData( cDataName, nScope )

   local nAt := AScan( aThisClass[ CLS_nDATA ],;
                       { | aData | aData[ DTA_nNAME ] == cDataName } )

   if nAt == 0
      AAdd( aThisClass[ CLS_nDATA ], { cDataName, nScope } )
   else
      aThisClass[ CLS_nDATA ][ nAt ] = { cDataName, nScope }
   endif

return

//----------------------------------------------------------------------------//

function ClsAddMethod( cMethodName, bMethod )

   local nAt

   cMethodName = Upper( cMethodName )

   nAt = AScan( aThisClass[ CLS_nMETHODS ],;
                { | aVar | aVar[ 1 ] == cMethodName } )
   if nAt == 0
      AAdd( aThisClass[ CLS_nMETHODS ], { cMethodName, bMethod } )
   else
      aThisClass[ CLS_nMETHODS ][ nAt ] = { cMethodName, bMethod }
   endif

return

//----------------------------------------------------------------------------//

function nClsMake()

   local nHandle := __ClassNew( aThisClass[ CLS_nNAME ],;
                                Len( aThisClass[ CLS_nDATA ] ) )
   local cUdf
   local n

   for n = 1 to Len( aThisClass[ CLS_nDATA ] )
       if ! Empty( aThisClass[ CLS_nDATA ][ n ][ 1 ] )
          cUdf = If( aThisClass[ CLS_nDATA ][ n ][ 2 ] == 0,;
                     "_DATA", "_PDATA" ) + AllTrim( Str( n ) )
          __ClassAdd( nHandle, "_" + aThisClass[ CLS_nDATA ][ n ][ 1 ], cUdf )
          __ClassAdd( nHandle, aThisClass[ CLS_nDATA ][ n ][ 1 ], cUdf )
       endif
   next

   AEval( aThisClass[ CLS_nMETHODS ],;
   { | aMethod, n | cUdf := "_METHOD" + AllTrim( Str( n ) ),;
                    __ClassAdd( nHandle, aMethod[ MTH_nNAME ], cUdf ) } )

   ASize( aClasses, nHandle )
   aClasses[ nHandle ] = aThisClass

return nHandle

//----------------------------------------------------------------------------//

function bClsMethod( cClassName, cMethodName )

   local nClass
   local nMethodAt
   local oError

   cMethodName = Upper( cMethodName )
   nClass      = &( Upper( cClassName ) + "()" ):ClassH()
   nMethodAt   = AScan( aClasses[ nClass ][ CLS_nMETHODS ],;
                        { | aMethod | aMethod[ 1 ] == cMethodName } )

   if nClass == 0 .or. nMethodAt == 0
      oError = ErrorNew()
      oError:CanDefault    = .f.
      oError:CanRetry      = .f.
      oError:CanSubstitute = .f.
      oError:GenCode       = 0
      oError:SubCode       = 2
      oError:Operation     = "Method not found"
      oError:SubSystem     = "Objects"
      oError:Severity      = ES_CATASTROPHIC
      Eval( ErrorBlock(), oError )
   endif

return aClasses[ nClass ][ CLS_nMETHODS ][ nMethodAt ][ 2 ]

//----------------------------------------------------------------------------//

function nClsParent( nClass, nParent )

   DEFAULT nParent := 1

return aClasses[ nClass ][ CLS_nPARENTS ][ nParent ]

//----------------------------------------------------------------------------//

function _Method1( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 1 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method2( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 2 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method3( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 3 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method4( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 4 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method5( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 5 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method6( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 6 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method7( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 7 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method8( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 8 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method9( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 9 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method10( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 10 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method11( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 11 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method12( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 12 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method13( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 13 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method14( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 14 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method15( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 15 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method16( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 16 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method17( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 17 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method18( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 18 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method19( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 19 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method20( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 20 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method21( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 21 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method22( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 22 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method23( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 23 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method24( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 24 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method25( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 25 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method26( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 26 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method27( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 27 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method28( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 28 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method29( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 29 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method30( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 30 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method31( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 31 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method32( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 32 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method33( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 33 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method34( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 34 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method35( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 35 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method36( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 36 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method37( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 37 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method38( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 38 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method39( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 39 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method40( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 40 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method41( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 41 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method42( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 42 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method43( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 43 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method44( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 44 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method45( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 45 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method46( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 46 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method47( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 47 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method48( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 48 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method49( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 49 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method50( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 50 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method51( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 51 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method52( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 52 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method53( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 53 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method54( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 54 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method55( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 55 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method56( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 56 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method57( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 57 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method58( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 58 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method59( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 59 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method60( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 60 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method61( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 61 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method62( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 62 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method63( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 63 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method64( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 64 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method65( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 65 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method66( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 66 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method67( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 67 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method68( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 68 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method69( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 69 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method70( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 70 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method71( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 71 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method72( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 72 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method73( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 73 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method74( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 74 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method75( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 75 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method76( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 76 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method77( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 77 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method78( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 78 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method79( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 79 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method80( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 80 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method81( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 81 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method82( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 82 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method83( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 83 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method84( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 84 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method85( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 85 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method86( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 86 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method87( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 87 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method88( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 88 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method89( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 89 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method90( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 90 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method91( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 91 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method92( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 92 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method93( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 93 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method94( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 94 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method95( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 95 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method96( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 96 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method97( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 97 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method98( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 98 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method99( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 99 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function _Method100( u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

return Eval( aClasses[ QSelf():ClassH() ][ CLS_nMETHODS ][ 100 ][ 2 ],;
             QSelf(), u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 )

//----------------------------------------------------------------------------//

function uCheckReadOnly( Self, nPCount, u, nData )

   local oError
   local cMethodName
   local cClass

   if nPCount > 0

      cMethodName = cMethodName()
      cClass      = SubStr( cMethodName, 1, At( ":", cMethodName ) - 1 )

      if Empty( cMethodName ) .or. ;
         ( Self:ClassName() != cClass .and. ;
           ! lClsAscendant( Self:ClassH(), cClass ) )

         oError = ErrorNew()
         oError:CanDefault    = .f.
         oError:CanRetry      = .f.
         oError:CanSubstitute = .f.
         oError:GenCode       = 0
         oError:SubCode       = 1
         oError:Operation     = "Acceso denegado a dato READONLY"
         oError:SubSystem     = "Objects"
         oError:Severity      = ES_CATASTROPHIC
         Eval( ErrorBlock(), oError )
      else
         Self[ nData ] = u
      endif
   endif

return Self[ nData ]

//----------------------------------------------------------------------------//

function _PDATA1( u )

return uCheckReadOnly( QSelf(), PCount(), u, 1 )

//----------------------------------------------------------------------------//

function _PDATA2( u )

return uCheckReadOnly( QSelf(), PCount(), u, 2 )

//----------------------------------------------------------------------------//

function _PDATA3( u )

return uCheckReadOnly( QSelf(), PCount(), u, 3 )

//----------------------------------------------------------------------------//

function _PDATA4( u )

return uCheckReadOnly( QSelf(), PCount(), u, 4 )

//----------------------------------------------------------------------------//

function _PDATA5( u )

return uCheckReadOnly( QSelf(), PCount(), u, 5 )

//----------------------------------------------------------------------------//

function _PDATA6( u )

return uCheckReadOnly( QSelf(), PCount(), u, 6 )

//----------------------------------------------------------------------------//

function _PDATA7( u )

return uCheckReadOnly( QSelf(), PCount(), u, 7 )

//----------------------------------------------------------------------------//

function _PDATA8( u )

return uCheckReadOnly( QSelf(), PCount(), u, 8 )

//----------------------------------------------------------------------------//

function _PDATA9( u )

return uCheckReadOnly( QSelf(), PCount(), u, 9 )

//----------------------------------------------------------------------------//

function _PDATA10( u )

return uCheckReadOnly( QSelf(), PCount(), u, 10 )

//----------------------------------------------------------------------------//

function _PDATA11( u )

return uCheckReadOnly( QSelf(), PCount(), u, 11 )

//----------------------------------------------------------------------------//

function _PDATA12( u )

return uCheckReadOnly( QSelf(), PCount(), u, 12 )

//----------------------------------------------------------------------------//

function _PDATA13( u )

return uCheckReadOnly( QSelf(), PCount(), u, 13 )

//----------------------------------------------------------------------------//

function _PDATA14( u )

return uCheckReadOnly( QSelf(), PCount(), u, 14 )

//----------------------------------------------------------------------------//

function _PDATA15( u )

return uCheckReadOnly( QSelf(), PCount(), u, 15 )

//----------------------------------------------------------------------------//

function _PDATA16( u )

return uCheckReadOnly( QSelf(), PCount(), u, 16 )

//----------------------------------------------------------------------------//

function _PDATA17( u )

return uCheckReadOnly( QSelf(), PCount(), u, 17 )

//----------------------------------------------------------------------------//

function _PDATA18( u )

return uCheckReadOnly( QSelf(), PCount(), u, 18 )

//----------------------------------------------------------------------------//

function _PDATA19( u )

return uCheckReadOnly( QSelf(), PCount(), u, 19 )

//----------------------------------------------------------------------------//

function _PDATA20( u )

return uCheckReadOnly( QSelf(), PCount(), u, 20 )

//----------------------------------------------------------------------------//

function _PDATA21( u )

return uCheckReadOnly( QSelf(), PCount(), u, 21 )

//----------------------------------------------------------------------------//

function _PDATA22( u )

return uCheckReadOnly( QSelf(), PCount(), u, 22 )

//----------------------------------------------------------------------------//

function _PDATA23( u )

return uCheckReadOnly( QSelf(), PCount(), u, 23 )

//----------------------------------------------------------------------------//

function _PDATA24( u )

return uCheckReadOnly( QSelf(), PCount(), u, 24 )

//----------------------------------------------------------------------------//

function _PDATA25( u )

return uCheckReadOnly( QSelf(), PCount(), u, 25 )

//----------------------------------------------------------------------------//

function _PDATA26( u )

return uCheckReadOnly( QSelf(), PCount(), u, 26 )

//----------------------------------------------------------------------------//

function _PDATA27( u )

return uCheckReadOnly( QSelf(), PCount(), u, 27 )

//----------------------------------------------------------------------------//

function _PDATA28( u )

return uCheckReadOnly( QSelf(), PCount(), u, 28 )

//----------------------------------------------------------------------------//

function _PDATA29( u )

return uCheckReadOnly( QSelf(), PCount(), u, 29 )

//----------------------------------------------------------------------------//

function _PDATA30( u )

return uCheckReadOnly( QSelf(), PCount(), u, 30 )

//----------------------------------------------------------------------------//

function _PDATA31( u )

return uCheckReadOnly( QSelf(), PCount(), u, 31 )

//----------------------------------------------------------------------------//

function _PDATA32( u )

return uCheckReadOnly( QSelf(), PCount(), u, 32 )

//----------------------------------------------------------------------------//

function _PDATA33( u )

return uCheckReadOnly( QSelf(), PCount(), u, 33 )

//----------------------------------------------------------------------------//

function _PDATA34( u )

return uCheckReadOnly( QSelf(), PCount(), u, 34 )

//----------------------------------------------------------------------------//

function _PDATA35( u )

return uCheckReadOnly( QSelf(), PCount(), u, 35 )

//----------------------------------------------------------------------------//

function _PDATA36( u )

return uCheckReadOnly( QSelf(), PCount(), u, 36 )

//----------------------------------------------------------------------------//

function _PDATA37( u )

return uCheckReadOnly( QSelf(), PCount(), u, 37 )

//----------------------------------------------------------------------------//

function _PDATA38( u )

return uCheckReadOnly( QSelf(), PCount(), u, 38 )

//----------------------------------------------------------------------------//

function _PDATA39( u )

return uCheckReadOnly( QSelf(), PCount(), u, 39 )

//----------------------------------------------------------------------------//

function _PDATA40( u )

return uCheckReadOnly( QSelf(), PCount(), u, 40 )

//----------------------------------------------------------------------------//

function _PDATA41( u )

return uCheckReadOnly( QSelf(), PCount(), u, 41 )

//----------------------------------------------------------------------------//

function _PDATA42( u )

return uCheckReadOnly( QSelf(), PCount(), u, 42 )

//----------------------------------------------------------------------------//

function _PDATA43( u )

return uCheckReadOnly( QSelf(), PCount(), u, 43 )

//----------------------------------------------------------------------------//

function _PDATA44( u )

return uCheckReadOnly( QSelf(), PCount(), u, 44 )

//----------------------------------------------------------------------------//

function _PDATA45( u )

return uCheckReadOnly( QSelf(), PCount(), u, 45 )

//----------------------------------------------------------------------------//

function _PDATA46( u )

return uCheckReadOnly( QSelf(), PCount(), u, 46 )

//----------------------------------------------------------------------------//

function _PDATA47( u )

return uCheckReadOnly( QSelf(), PCount(), u, 47 )

//----------------------------------------------------------------------------//

function _PDATA48( u )

return uCheckReadOnly( QSelf(), PCount(), u, 48 )

//----------------------------------------------------------------------------//

function _PDATA49( u )

return uCheckReadOnly( QSelf(), PCount(), u, 49 )

//----------------------------------------------------------------------------//

function _PDATA50( u )

return uCheckReadOnly( QSelf(), PCount(), u, 50 )

//----------------------------------------------------------------------------//

function _PDATA51( u )

return uCheckReadOnly( QSelf(), PCount(), u, 51 )

//----------------------------------------------------------------------------//

function _PDATA52( u )

return uCheckReadOnly( QSelf(), PCount(), u, 52 )

//----------------------------------------------------------------------------//

function _PDATA53( u )

return uCheckReadOnly( QSelf(), PCount(), u, 53 )

//----------------------------------------------------------------------------//

function _PDATA54( u )

return uCheckReadOnly( QSelf(), PCount(), u, 54 )

//----------------------------------------------------------------------------//

function _PDATA55( u )

return uCheckReadOnly( QSelf(), PCount(), u, 55 )

//----------------------------------------------------------------------------//

function _PDATA56( u )

return uCheckReadOnly( QSelf(), PCount(), u, 56 )

//----------------------------------------------------------------------------//

function _PDATA57( u )

return uCheckReadOnly( QSelf(), PCount(), u, 57 )

//----------------------------------------------------------------------------//

function _PDATA58( u )

return uCheckReadOnly( QSelf(), PCount(), u, 58 )

//----------------------------------------------------------------------------//

function _PDATA59( u )

return uCheckReadOnly( QSelf(), PCount(), u, 59 )

//----------------------------------------------------------------------------//

function _PDATA60( u )

return uCheckReadOnly( QSelf(), PCount(), u, 60 )

//----------------------------------------------------------------------------//
