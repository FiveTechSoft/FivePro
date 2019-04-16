#include <ClipApi.h>
#include <dos.h>

typedef struct
{
   WORD wLen;
   WORD wBindery;
   BYTE bConnNumber;
   BYTE bMsgLen;
   BYTE bMsg[ 45 ];
} NETREQUESTED;

typedef struct
{
   WORD wLen;
   BYTE bFiller[ 100 ];
} NETRECEIVED;

//----------------------------------------------------------------------------//

CLIPPER NetSendMsg()
{
   NETREQUESTED request;
   NETRECEIVED  received;

   request.bMsgLen     = _parclen( 1 );
   _bcopy( request.bMsg, _parc( 1 ), _parclen( 1 ) );
   request.wLen        = request.bMsgLen + 4;
   request.wBindery    = 0x0100;
   request.bConnNumber = 0;

   received.wLen = 100;

   _SI = FP_OFF( &request );
   _DI = FP_OFF( &received );
   _ES = FP_SEG( &received );
   asm push ds;
   _DS = FP_SEG( &request );
   _AH = 0xE1;
   asm int 0x21;
   asm pop ds;
}

//----------------------------------------------------------------------------//
