#include <ClipApi.h>

static PCLIPVAR aEvents;

static WORD awCount[ 20 ];

//----------------------------------------------------------------------------//

static WORD EvDo( PEVENT pEvent )
{
   BYTE bEvent  = 0;
   BYTE bEvents = _VARRAYLEN( aEvents );
   CLIPVAR aEvent, bAction;

   if( pEvent->wMessage == 0x5108 )                 // Teclado en espera
   {
      for( bEvent = 0; bEvent < bEvents; bEvent++ )
      {
         _cAt( aEvents, bEvent + 1, 0xFFFF, ( PCLIPVAR ) &aEvent );
         _cAt( ( PCLIPVAR ) &aEvent, 1, 0xFFFF, ( PCLIPVAR ) _eval );
         _cAt( ( PCLIPVAR ) &aEvent, 2, 0xFFFF, ( PCLIPVAR ) &bAction );

         if( ++awCount[ bEvent ] == _parni( -1 ) )
         {
            _PutSym( _SymEval );
            _bcopy( ( LPBYTE ) ( ++_tos ), ( LPBYTE ) &bAction, sizeof( CLIPVAR ) );
            _xEval( 0 );
            awCount[ bEvent ] = 0;
         }
      }
   }
   return 0;
}

//----------------------------------------------------------------------------//

CLIPPER Events()
{
   aEvents = _sbase;
   _retni( _evRegReceiverFunc( EvDo, 0xFFFF ) );
}

//----------------------------------------------------------------------------//

CLIPPER EventEnd()
{
   _Break_Cycle();
}

//----------------------------------------------------------------------------//

CLIPPER EventSend()
{
   _evSendId( _parni( 1 ), _parni( 2 ) );
}

CLIPPER EventDeReg()
{
   _evDeRegReceiver( _parni( 1 ) );
}

CLIPPER KeyWait()
{
   EVENT ev;
   WORD w = 0;

   ev.wId   = 4;
   ev.wId   = 0xC;

   while( ! w )
   {
      ev.wId = 0xC;
      w = _evModalRead( &ev );
   }

   _retni( w );
}
