// Inspector gen‚rico de Objetos

// (C) Antonio Linares, 1993

#include "InKey.ch"

//----------------------------------------------------------------------------//

function OInspect( oObject, nAtRow, nAtCol )

   local acClsData  := acClsData( oObject:ClassH() )
   local bColBlock  := { || cValToChar( uOGetData( oObject,;
                            acClsData[ brwClsData:Cargo ] ) ) }
   local cData
   local GetList    := {}
   local lEnd       := .f.
   local nKey
   local nCrsOld    := SetCursor( 0 )
   local nRow       := If( nAtRow == nil, 5, nAtRow )
   local nCol       := If( nAtCol == nil, 5, nAtCol )
   local cScrOld    := SaveScreen( nRow, nCol, nRow + 15, nCol + 44 )
   local brwClsData := TBrowseArray( nRow + 1, nCol + 1, nRow + 14,;
                                     nCol + 43, acClsData )

   brwClsData:AddColumn( TbColumnNew( , bColBlock ) )
   brwClsData:GetColumn( 2 ):Width = 30
   brwClsData:ColPos = 2

   @ nRow, nCol TO nRow + 15, nCol + 44

   do while ! lEnd

      do while ! brwClsData:Stabilize()
      enddo

      nKey = InKey( 0 )

      do case
         case nKey == K_ESC
              lEnd = .t.

         case nKey == K_ENTER
              cData = PadR( Eval( bColBlock ), 30 )

              if AllTrim( cData ) == "Object"
                 OInspect( uOGetData( oObject,;
                           acClsData[ brwClsData:Cargo ] ),;
                           nRow + 1, nCol + 2 )
              else
                 @ Row(), Col() GET cData ;
                   WHEN If( AllTrim( cData ) == "{ || ... }",;
                            Alert( "No editable" ) == 2, .t. ) ;
                   VALID ValType( If( lExpCheck( @cData ),;
                         OSetData( oObject, acClsData[ brwClsData:Cargo ],;
                         cData ), .f. ) ) != "L"

                 SET CURSOR ON
                 READ
                 SET CURSOR OFF

                 brwClsData:RefreshCurrent()
              endif

         case nKey == K_DEL
              if Alert( "Confirme Borrado", { "S¡", "No" } ) == 1
                 OSetData( oObject, acClsData[ brwClsData:Cargo ], nil )
                 brwClsData:RefreshCurrent()
              endif

         case nKey == K_UP
              brwClsData:Up()

         case nKey == K_DOWN
              brwClsData:Down()

         case nKey == K_PGUP
              brwClsData:PageUp()

         case nKey == K_PGDN
              brwClsData:PageDown()
      endcase
   enddo

   RestScreen( nRow, nCol, nRow + 15, nCol + 44, cScrOld )
   SetCursor( nCrsOld )

return

//----------------------------------------------------------------------------//

function acClsData( nClass )

   local acClsInfo := ASort( __ClassSel( nClass ) )
   local acClsData := {}
   local n

   for n = 1 to Len( acClsInfo )
       if SubStr( acClsInfo[ n ], 1, 1 ) != "_" .and. ;
          AScan( acClsInfo, { | cInfo | SubStr( "_" + ;
          acClsInfo[ n ], 1, 10 ) == cInfo } ) != 0
             AAdd( acClsData, PadR( acClsInfo[ n ], 10 ) )
       endif
   next

return acClsData

//----------------------------------------------------------------------------//

function uOGetData( oObject, cDataName )

return Eval( &( "{ | o | o:" + cDataName + "}" ), oObject )

//----------------------------------------------------------------------------//

function OSetData( oObject, cDataName, u )

   Eval( &( "{ | o, u | o:_" + cDataName + "( u ) }" ), oObject, u )

return

//----------------------------------------------------------------------------//

static function cValToChar( uValue )

    local cType   := ValType( uValue )
    local cResult := "NIL"

    do case
       case cType == "A"
            cResult = "{ ... }"

       case cType == "C"
            cResult = '"' + uValue + '"'

       case cType == "D"
            cResult = DToC( uValue )

       case cType == "L"
            cResult = If( uValue, ".T.", ".F." )

       case cType == "N"
            cResult = LTrim( Str( uValue ) )

       case cType == "O"
            cResult = "Object"

       case cType == "B"
            cResult = "{ || ... }"
    endcase

return cResult

//----------------------------------------------------------------------------//

static function uCharToVal( cExpr )

   local uResult
   local cType

   cExpr = AllTrim( cExpr )
   cType = Type( cExpr )

   do case
      case Empty( cExpr ) .or. Upper( cExpr ) == "NIL"
           uResult = nil

      case cType == "C"
           uResult = &( cExpr )

      case cType == "D"
           uResult = CToD( cExpr )

      case cType == "L"
           uResult = &( cExpr )

      case cType == "N"
           uResult = Val( cExpr )
   endcase

return uResult

//----------------------------------------------------------------------------//

static function lExpCheck( cData )

   local lOk

   if ! ( lOk := ( Type( cData ) != "UE" ) )
      Alert( "Invalid Expression" )
   else
      cData = &( AllTrim( cData ) )
   endif

return lOk

//----------------------------------------------------------------------------//
