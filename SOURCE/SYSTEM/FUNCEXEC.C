#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER FuncExec()        // cNombreFuncion
{
   BYTE b;

   _PutSym( _Get_Sym( _parc( 1 ) ) );
   ( ++_tos )->wType = NIL;

   for( b = 0; b < PCOUNT() - 1; b++ )
      _xPushM( _lbase + 3 + b );

   _xDo( PCOUNT() - 1 );
}

//----------------------------------------------------------------------------//
