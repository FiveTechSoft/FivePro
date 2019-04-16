#define ALIAS     1
#define RECNO     2
#define INDEXORD  3

static aViews     := {}
static aProcNames := {}
static aSelect    := {}
static aRelations := {}

//----------------------------------------------------------------------------//

function ViewSave()

   local aAreas  := {}
   local n       := 1
   local nIndRel := 1

   AAdd( aProcNames, ProcName( 2 ) )
   AAdd( aSelect, Select() )

   do while ! Empty( Alias( n ) )
      AAdd( aAreas,;
            { ( Alias( n ) )->( Alias() ),;
              ( Alias( n ) )->( RecNo() ),;
              ( Alias( n ) )->( IndexOrd() ) } )

      // Guardamos las Relaciones si hubiera
      nIndRel = 1
      while Len( ( Alias( n ) )->( DbRelation( nIndRel ) ) ) # 0
         AAdd( aRelations,;
               { ( Alias( n ) )->( Alias() ),;
                 ( Alias( n ) )->( DbRelation( nIndRel ) ),;
                 ( Alias( n ) )->( DbRSelect( nIndRel ) ),;
                 ( ProcName ( 2 ) ) } )
         nIndRel++
      enddo

      n++
   enddo

   AAdd( aViews, aAreas )

return

//----------------------------------------------------------------------------//

function ViewRestore()

   local aAreas  := ATail( aViews )
   local n       := Len( aAreas ) + 1
   local Null
   local nIndRel := 1
   local nRegDel := 0
   local cAlias, cDerivada

   if ProcName( 1 ) != ATail( aProcNames )
      nMsgBox( "Uso indebido de RESTORE VIEWs", "Atenci¢n" )
      Cierre()
   endif

   do while ! Empty( Alias( n ) )
      Null = ( Alias( n ) )->( DbCloseArea() )
      n++
   enddo

   for n = 1 to Len( aAreas )
       if Alias( n ) != aAreas[ n ][ ALIAS ]
          nMsgBox( "Uso indebido de ficheros", "Atenci¢n" )
       else

          if ( Alias( n ) )->( IndexOrd() ) != aAreas[ n ][ INDEXORD ]
             Null = ( Alias( n ) )->( DbSetOrder( aAreas[ n ][ INDEXORD ] ) )
          endif

          // Restauramos las Relaciones si hubiera
          SELECT ( Alias( n ) )
          while ( nIndRel := AScan( aRelations, { | aSub | aSub[ 1 ] == Alias( n ) .and. aSub[ 4 ] == ATail( aProcNames ) }, , Len( aRelations ) - nRegDel ) ) > 0
             cAlias    = Alias( aRelations[ nIndRel ][ 3 ] )
             cDerivada = aRelations[ nIndRel ][ 2 ]

             SET RELATION TO &cDerivada INTO ( cAlias ) ADDITIVE

             ADel( aRelations, nIndRel )
             nRegDel++
          enddo

          Null = ( Alias( n ) )->( DbGoto( aAreas[ n ][ 2 ] ) )

       endif
   next

   if Select() != ATail( aSelect )
      SELECT  ( ATail( aSelect ) )
   endif

   ASize( aViews,     Len( aViews ) - 1 )
   ASize( aProcNames, Len( aProcNames ) - 1 )
   ASize( aSelect,    Len( aSelect ) - 1 )
   ASize( aRelations, Len( aRelations ) - nRegDel )

return

//----------------------------------------------------------------------------//
