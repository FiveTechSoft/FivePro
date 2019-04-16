#define DBFNAME   1
#define ALIAS     2
#define INDICES   3
#define DBFMASTER 3
#define EXCLUSIVE 4

static aView
static lViewOk
static nTimeOut := 1

//----------------------------------------------------------------------------//

function ViewBegin()

   aView   = {}
   lViewOk = .t.

return

//----------------------------------------------------------------------------//

function ViewAdd( cDbf, cAlias, aIndexes, cExclusive )

   AAdd( aView, { cDbf, cAlias, aIndexes, cExclusive } )

return

//----------------------------------------------------------------------------//

function ViewAddTemp( cDbf, cAlias, cDbfMaster )

   AAdd( aView, { cDbf, cAlias, cDbfMaster } )

return

//----------------------------------------------------------------------------//

function lViewEnd()

   local n := 1
   local nArea
   local nFirstArea := 0
   local nOldArea   := Select()
   local lExclusive

   ViewSave()

   while n <= Len( aView ) .and. lViewOk

      if ValType( aView[ n ][ INDICES ] ) == "A"
         if ( nArea := Select( aView[ n ][ ALIAS ] ) ) != 0
            SELECT ( aView[ n ][ ALIAS ] )
            SET RELATION TO
         else
            SELECT 0
            if aView[ n ][ EXCLUSIVE ] != nil .and. Upper( aView[ n ][ EXCLUSIVE ] ) == "EXCLUSIVE"
               lExclusive = .t.
            else
               lExclusive = .f.
            endif
            if lNetUse( aView[ n ][ DBFNAME ], lExclusive, nTimeOut, aView[ n ][ ALIAS ] )
               if Len( aView[ n ][ INDICES ] ) > 0
                  AEval( aView[ n ][ INDICES ], { | cIndex | DbSetIndex( cIndex ) } )
               endif
            else
               lViewOk = .f.
            endif
         endif
      else                    // Es un fichero Temporal
         ( aView[ n ][ DBFMASTER ] )->( __DbCopyStruct( aView[ n ][ DBFNAME ], {} ) )
         SELECT 0
         lViewOk = lNetUse( aView[ n ][ DBFNAME ], .t., nTimeOut, aView[ n ][ ALIAS ] )
      endif

      if lViewOk .and. nFirstArea == 0
         nFirstArea = Select()
      endif
      n++

   enddo

   if lViewOk
      SELECT ( nFirstArea )
   else
      SELECT ( nOldArea )
   endif

   aView = {}

return lViewOk

//----------------------------------------------------------------------------//
