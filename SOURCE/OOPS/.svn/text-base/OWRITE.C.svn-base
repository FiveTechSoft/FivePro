#include <ClipApi.h>

typedef struct
{
   BYTE  bType;
   BYTE  bClassName[ 10 ];
} OBJ;

CLIPPER __ClassNam();

CLIPPER lOWrite()
{
   WORD wFile = _tcreate( _parc( 1 ) );
   OBJ  Object;

   ClassName( _param( 2 ) );

   file.Write( "O" );
   file.Write( object.ClassName() );

   Object.bType = 'O';

   ClassName( _param( 2 ), Object.bClassName );
}

CLIPPER cToChar()
{
   switch( ValType( _param( 1 ) ) )
   {

