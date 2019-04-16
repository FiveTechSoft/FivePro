// Restaura Objectos y Arrays desde disco, con control de referencias circulares

// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

function oORead( cFileName )

   cFileName = If( At( ".", cFileName ) == 0, cFileName += ".RES", cFileName )

return oCharToO( MemoRead( cFileName ), {}, {} )

//----------------------------------------------------------------------------//

function oCharToO( cObject, aArrays, aObjects )

   local cClassName := RTrim( SubStr( cObject, 4, 10 ) )
   local oObject
   local aData

   if SubStr( cObject, 14, 1 ) != "A"        // Es referencia circular
      oObject = aObjects[ Bin2I( SubStr( cObject, 14, 2 ) ) ]
   else
      oObject = oOCreate( cClassName )
      AAdd( aObjects, oObject )
      aData   = aCharToA( SubStr( cObject, 14 ), aArrays, aObjects )
      ASize( oObject, Len( aData ) )
      AEval( aData, { | uData, n | oObject[ n ] := uData } )
   endif

return oObject

//----------------------------------------------------------------------------//

function oOCreate( cClassName )

return Eval( &( "{||" + cClassName + "()}" ) )

//----------------------------------------------------------------------------//

function aARead( cFileName )

   cFileName = If( At( ".", cFileName ) == 0, cFileName += ".RES", cFileName )

return aCharToA( MemoRead( cFileName ) )

//----------------------------------------------------------------------------//

function aCharToA( cArray, aArrays, aObjects )

   local aArray
   local nLen    := Bin2I( SubStr( cArray, 4, 2 ) )
   local n, nPos := 6
   local cType, cValue

   aArrays  = If( aArrays  == nil, {}, aArrays )
   aObjects = If( aObjects == nil, {}, aObjects )

   if nLen == -1                     // Referencia circular
      aArray = aArrays[ Bin2I( SubStr( cArray, 6, 2 ) ) ]
   else
      aArray = Array( nLen )
      AAdd( aArrays, aArray )

      for n = 1 to Len( aArray )
          cType  = SubStr( cArray, nPos, 1 )
          nLen   = Bin2I( SubStr( cArray, nPos + 1, 2 ) )
          cValue = SubStr( cArray, nPos + 3, nLen - 3 )

          do case
             case cType == "A"
                  aArray[ n ] = aCharToA( "A" + I2Bin( nLen ) + cValue,;
                                          aArrays, aObjects )

             case cType == "B"
                  aArray[ n ] = &( cValue )

             case cType == "C"
                  aArray[ n ] = cValue

             case cType == "D"
                  aArray[ n ] = CToD( cValue )

             case cType == "L"
                  aArray[ n ] = ( cValue == "T" )

             case cType == "N"
                  aArray[ n ] = Bin2L( cValue )

             case cType == "O"
                  aArray[ n ] = oCharToO( "O" + I2Bin( nLen ) + cValue,;
                                          aArrays, aObjects )

             case cType == "U"
                  aArray[ n ] = nil
          endcase
          nPos += nLen
      next
   endif

return aArray

//----------------------------------------------------------------------------//
