#include <ClipApi.h>
#include <dos.h>

WORD pascal DosMapRealSeg( WORD, LONG, WORD * );
WORD pascal DosFreeSeg( WORD );

/*----------------------------------------------------------------------------*/

CLIPPER nPeekByte()
{

   _retni( ( unsigned char )
         peekb( ( unsigned int ) _parni( 1 ), ( unsigned int ) _parni( 2 ) ) );
}

/*----------------------------------------------------------------------------*/

CLIPPER nPeekWord()
{
   WORD wSel;

   DosMapRealSeg( _parni( 1 ), 0xFFFF, &wSel );

   _retnl( ( WORD ) * ( ( LPBYTE ) MK_FP( wSel, 0 ) + _parni( 2 ) ) );

   DosFreeSeg( wSel );
}

/*----------------------------------------------------------------------------*/

CLIPPER PokeByte()
{
   pokeb( ( unsigned int ) _parni( 1 ), ( unsigned int ) _parni( 2 ),
          ( unsigned char ) _parni( 3 ) );
   _ret();
}

/*----------------------------------------------------------------------------*/

CLIPPER PokeWord()
{
   poke( ( unsigned int ) _parni( 1 ), ( unsigned int ) _parni( 2 ),
         ( unsigned int ) _parni( 3 ) );
   _ret();
}

/*----------------------------------------------------------------------------*/
