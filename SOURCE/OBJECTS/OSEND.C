// Sending any message to an Object from Clipper

#include <ClipApi.h>

CLIPPER OSend()
{
   BYTE b;

   _PutSym( _Get_Sym( _parc( 2 ) ) );      // The message to send
   _xPushM( _lbase + 2 );                  // The Object placed at the Stack

   for( b = 0; b < PCOUNT() - 2; b++ )
      _xPushM( _lbase + 4 + b );           // Pushing the parameters

   _xSend( PCOUNT() - 2 );                 // Similar to xDo() and xEval()
}
