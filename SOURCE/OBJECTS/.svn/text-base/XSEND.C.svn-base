// Sending Messages to an Object from C

// The missing xSend() !!!

#pragma option -zCPLANKTON_TEXT

#include "ClipApi.h"
#include <dos.h>

void near _0SEND( void );

void _xSend( WORD wNumberOfParams )
{
   _ES  = FP_SEG( &wNumberOfParams );
   _SI  = FP_OFF( &wNumberOfParams );
   _DI  = ( WORD ) _tos;
   _0SEND();
   _tos = ( PCLIPVAR ) _DI;
   _bcopy( ( LPBYTE ) _eval, ( LPBYTE ) _tos--, sizeof( CLIPVAR ) );
}
