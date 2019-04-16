// Salva Objetos y Arrays a disco, con control de referencias circulares

// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

function lOWrite( cFileName, oObject )

   cFileName = If( At( ".", cFileName ) == 0, cFileName += ".RES", cFileName )

return MemoWrit( cFileName, cOToChar( oObject, {}, {} ) )

//----------------------------------------------------------------------------//

function cOToChar( oObject, aArrays, aObjects )

   local cData, cObject
   local nAt

   if ( nAt := AScan( aObjects, { | oObj | oObj == oObject } ) ) != 0
      cObject = "O" + I2Bin( 15 ) + PadR( oObject:ClassName(), 10 ) + ;
                I2Bin( nAt )
   else
      AAdd( aObjects, oObject )
      cData   = cAToChar( oObject, aArrays, aObjects )
      cObject = "O" + I2Bin( Len( cData ) + 13 ) + ;
                PadR( oObject:ClassName(), 10 ) + cData
   endif

return cObject

//----------------------------------------------------------------------------//

function lAWrite( cFileName, aArray )

   cFileName = If( At( ".", cFileName ) == 0, cFileName += ".RES", cFileName )

return MemoWrit( cFileName, cAToChar( aArray ) )

//----------------------------------------------------------------------------//

function cAToChar( aArray, aArrays, aObjects )

   local cBuffer := ""
   local cType
   local n

   aArrays  = If( aArrays == nil, {}, aArrays )
   aObjects = If( aObjects == nil, {}, aObjects )

   if ( n := AScan( aArrays,;
                    { | aTemp | aTemp == aArray } ) ) != 0   // ya salvado
      return "A" + I2Bin( 7 ) + I2Bin( 65535 ) + I2Bin( n )
   else
      AAdd( aArrays, aArray )
      for n = 1 to Len( aArray )
          cType = ValType( aArray[ n ] )
          do case
             case cType == "A"
                  cBuffer += cAToChar( aArray[ n ], aArrays, aObjects )

             case cType == "B"
                  cBuffer += "B" + I2Bin( 10 ) + "{||nil}"

             case cType == "C"
                  cBuffer += "C" + I2Bin( Len( aArray[ n ] ) + 3 ) + aArray[ n ]

             case cType == "D"
                  cBuffer += "D" + I2Bin( 11 ) + DToC( aArray[ n ] )

             case cType == "L"
                  cBuffer += "L" + I2Bin( 3 ) + If( aArray[ n ], "T", "F" )

             case cType == "N"
                  cBuffer += "N" + I2Bin( 7 ) + L2Bin( aArray[ n ] )

             case cType == "O"
                  cBuffer += cOToChar( aArray[ n ], aArrays, aObjects )

             case cType == "U"
                  cBuffer += "U" + I2Bin( 3 )
          endcase
      next
   endif

return "A" + I2Bin( 5 + Len( cBuffer ) ) + I2Bin( Len( aArray ) ) + cBuffer

//----------------------------------------------------------------------------//
