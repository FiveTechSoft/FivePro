#include <dos.h>
#include <ClipApi.h>

//----------------------------------------------------------------------------//

static void KeyStuff( unsigned int uiKey )
{
   unsigned int uiTail        = peek( 0, 0x041C );
   unsigned int uiBufferStart = peek( 0, 0x0480 );
   unsigned int uiBufferEnd   = peek( 0, 0x0482 );

   poke( 0, 0x0400 + uiTail, uiKey );
   uiTail += 2;
   poke( 0, 0x041C, ( uiTail >= uiBufferEnd ) ? uiBufferStart: uiTail );
}

// ----------------------------------------------------------------------------

CLIPPER KEYSTUFF() { KeyStuff( _parni( 1 ) ); }

// ----------------------------------------------------------------------------
