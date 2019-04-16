#include <ClipApi.h>

CLIPPER BlockEval()
{
   BYTE b;

   _PutSym( _SymEval );
   _xPushM( _lbase + 2 );

   for( b = 0; b < PCOUNT() - 1; b++ )
      _xPushM( _lbase + 3 + b );

   _xEval( PCOUNT() - 1 );
}
