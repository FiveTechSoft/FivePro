/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: oInspect.prg                                          บ
บ Lenguaje: Clipper 5.0x + ObjectsP                             บ
บ Fecha: Marzo  1993                                            บ
บ Compilar: Clipper oInspect /a /n /w                           บ
บ Desc.:Demo/Test de la clase Command y TBArray                 บ
บ                                                               บ
บ  Enlazar mขdulos: oInspect, nAchoice, TBArray                 บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

#include "InKey.ch"
#include "ObjectsP.ch"

#ifdef _OINSPECT_DEMO

func main()

 local  o := TBArray():New( 10, 10, 20, 60 )
 local  i
 local aaToChoice := {}
 local aHeadings  := {}

       CLEAR SCREEN
       o:cargo = Get():New()
       OInspect( o, 5, 8 )

       @ 12, 4 say "Ahora una demo de un nAchoice Multiple"

       o = { Error(), Get(), TBrowse(), TBColumn() }
       for i = 1 to len( o )
           aadd( aaToChoice, acClsData( o[ i ] ) )
           aadd( aHeadings, padr( o[ i ]:Classname(), 12 ) )
       next

       inkey(0)

       CLEAR SCREEN

       o = anAchoice( aaToChoice, aHeadings, 5, 16 )

       if o[ 2 ] > 0
          @ 12, 4 say 'Your choice: Class "'+ rtrim(aHeadings[ o[1] ]) + '" Variable "' + aaTochoice[ o[1], o[2] ] + '"'
       else
          @ 12, 4 say "No Choice"
       endif

       inkey(0)

       CLEAR SCREEN
       use demo

       aHeadings = { "FieldName " ,;
                     "Type"       ,;
                     "Len "       ,;
                     "Decimals" }

       aaToChoice = array( 4, 0 )
       aeval( DBStruct(), { |a| aadd( aaToChoice[ 1 ], a[ 1 ] ),;
                                aadd( aaToChoice[ 2 ], a[ 2 ] ),;
                                aadd( aaToChoice[ 3 ], str( a[ 3 ], 4 ) ),;
                                aadd( aaToChoice[ 4 ], str( a[ 4 ], 4 ) ) } )

       o = anAchoice( aaToChoice, aHeadings, 5, 16 )

       if o[ 2 ] > 0
          @ 12, 4 say 'Your choice: Data "'+ rtrim(aHeadings[ o[1] ]) + '" Value "' + aaTochoice[ o[1], o[2] ] + '"'
       else
          @ 12, 4 say "No Choice"
       endif

Return nil

#endif

/***********
*/
function OInspect( Object, nRow, nCol )

   local aClsData   := acClsData( Object )
   local GetList    := {}
   local nCrsOld    := SetCursor( 0 )

   local cScrOld, oBrwData, nKey, oColumn
   local uData, cData, cType

   DEFAULT    nRow = 5, nCol = 5

   cScrOld  = SaveScreen( nRow, nCol, nRow + 15, nCol + 44 )
   oBrwData = TBArray():New( nRow + 1, nCol + 1, nRow + 14,;
                             nCol + 43 )

   oBrwData:AddColumn( " VarName ", aClsData )

   oBrwData:AddColumn( " Contain ", aClsData )

     oColumn = oBrwData:GetColumn( 2 )
     oColumn:block   = { || cValToChar( Object:send( Command( aClsData[ oBrwData:nIndex ] ) ) ) }
     oColumn:Width = 30

   oBrwData:colPos = 2

   @ nRow, nCol TO nRow + 15, nCol + 44

   while .T.

      oBrwData:SetStable()

      nKey = InKey( 0 )

      if ! oBrwData:lKeyEval( nKey )

         do case
            case nKey == K_ESC
                 EXIT

            case nKey == K_ENTER .and. oBrwData:colPos == 2

                 uData = Object:send( Command( aClsData[ oBrwData:nIndex ] ) )
                 cData = PadR( cValToChar( uData ), 30 )
                 cType = ValType( uData )

                 if cType == "A" .or. cType == "B"
                    Alert( "Variable No editable" )

                 elseif cType == "O"
                    OInspect( uData, nRow + 1, nCol + 2 )

                 else

                    @ Row(), Col() GET cData

                    SET CURSOR ON
                    READ
                    SET CURSOR OFF

                    if lastKey() == K_ENTER .and. lExpCheck( @cData )
                       Object:send( Command( "_"+aClsData[ oBrwData:nIndex ] ), cData )
                    endif

                    oBrwData:RefreshCurrent()

                 endif

            case nKey == K_DEL
                 if Alert( "Confirme Borrado", { "Sก", "No" } ) == 1
                    Object:send( Command( "_"+ aClsData[ oBrwData:nIndex ] ), nil )
                    oBrwData:RefreshCurrent()
                 endif

         endcase

      endif

   end

   RestScreen( nRow, nCol, nRow + 15, nCol + 44, cScrOld )
   SetCursor( nCrsOld )

Return nil

/***********
*/
Function acClsData( Object )

   local acClsInfo := ASort( __ClassSel( Object:ClassH() ) )
   local aClsData
   local n, n2, nItem := 0

   n2 = aScan( acClsInfo, {|c| SubStr( c, 1, 1 ) == "_" } )

   if n2 > 0
      aClsData = array( len( acClsInfo ) - n2 + 1 )
   endif

   for n = 1 to n2 - 1

       if aScan( acClsInfo, { |c| Left( "_" + ;
                    acClsInfo[ n ], 10 ) == c }, n2 ) > 0

          aClsData[ ++nItem ] = acClsInfo[ n ]

       endif

   next

Return aClsData


//----------------------------------------------------------------------------//

function cValToChar( uValue )

    local cType   := ValType( uValue )
    local cResult := "NIL"

    do case
       case cType == "A"
            cResult = "Array[ " + str( len( uValue ), 4 ) + " ]"

       case cType == "C"
            cResult = '"' + uValue + '"'

       case cType == "D"
            cResult = DToC( uValue )

       case cType == "L"
            cResult = If( uValue, ".T.", ".F." )

       case cType == "N"
            cResult = LTrim( Str( uValue ) )

       case cType == "O"
            cResult = uValue:ClassName() + " Object"

       case cType == "B"
            cResult = "{ || ... }"
    endcase

return cResult

//----------------------------------------------------------------------------//

static function lExpCheck( cData )

   local lOk := .t.
   local cType := Type( cData )

   if cType = "U"  .or. cType == "UE"
      Alert( "Invalid Expression" )
      lOk = .f.
   else
      cData = &( AllTrim( cData ) )
   endif

return lOk

//----------------------------------------------------------------------------//
