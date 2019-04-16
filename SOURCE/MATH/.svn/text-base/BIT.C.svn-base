#include <stdio.h>
#include <extend.h>

/*----------------------------------------------------------------------------*/

CLIPPER lBitOn()
{
   unsigned int uiNumber   = _parni( 1 );
   unsigned char ucWichBit = _parni( 2 );
   unsigned int uiTwoPower = 1;
   unsigned char uc;

   for( uc = 1; uc <= ucWichBit; uc++ )
      uiTwoPower *= 2;
   _retl( uiNumber & uiTwoPower );
}

/*----------------------------------------------------------------------------*/

CLIPPER nBitSet()
{
   unsigned int uiNumber   = _parni( 1 );
   unsigned char ucWichBit = _parni( 2 );
   unsigned int uiTwoPower = 1;
   unsigned char uc;

   for( uc = 1; uc <= ucWichBit; uc++ )
      uiTwoPower *= 2;
   _retnl( uiNumber | uiTwoPower );
}

/*----------------------------------------------------------------------------*/

CLIPPER nBitAnd()
{
  _retnl( ( unsigned int ) _parni( 1 ) & ( unsigned int ) _parni( 2 ) );
}

/*----------------------------------------------------------------------------*/

CLIPPER nBitOr()
{
  _retnl( ( unsigned int ) _parni( 1 ) | ( unsigned int ) _parni( 2 ) );
}

/*----------------------------------------------------------------------------*/

CLIPPER nBitXor()
{
  _retnl( ( unsigned int ) _parni( 1 ) ^ ( unsigned int ) _parni( 2 ) );
}

/*----------------------------------------------------------------------------*/
