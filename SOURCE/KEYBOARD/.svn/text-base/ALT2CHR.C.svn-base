#include <Extend.h>

#define DO_CASE       if(0){}
#define CASE(x)  else if(x)
#define ENDCASE       //

static unsigned char ucRow0[] = "1234567890";
static unsigned char ucRow1[] = "QWERTYUIOP";
static unsigned char ucRow2[] = "ASDFGHJKL¥";
static unsigned char ucRow3[] = "ZXCVBNM";

//----------------------------------------------------------------------------//

CLIPPER lAltChr()
{
   int iKey             = _parni( 1 );
   unsigned char ucChar = 0;
   unsigned char ucAlt  = 0;

   DO_CASE

      CASE( iKey >= 376 && iKey <= 385 )
      {
         ucChar = ucRow0[ iKey - 376 ];
         ucAlt  = 1;
      }

      CASE( iKey >= 272 && iKey <= 281 )
      {
         ucChar = ucRow1[ iKey - 272 ];
         ucAlt  = 1;
      }

      CASE( iKey >= 286 && iKey <= 294 )
      {
         ucChar = ucRow2[ iKey - 286 ];
         ucAlt  = 1;
      }

      CASE( iKey >= 300 && iKey <= 306 )
      {
         ucChar = ucRow3[ iKey - 300 ];
         ucAlt  = 1;
      }

   ENDCASE

   _storclen( &ucChar, ucChar != 0, 2 );
   _retl( ucAlt );
}

//----------------------------------------------------------------------------//

CLIPPER cAlt2Chr()
{
   int iKey             = _parni( 1 );
   unsigned char ucChar = 0;

   DO_CASE

      CASE( iKey >= 376 && iKey <= 385 )
         ucChar = ucRow0[ iKey - 376 ];

      CASE( iKey >= 272 && iKey <= 281 )
         ucChar = ucRow1[ iKey - 272 ];

      CASE( iKey >= 286 && iKey <= 294 )
         ucChar = ucRow2[ iKey - 286 ];

      CASE( iKey >= 300 && iKey <= 306 )
         ucChar = ucRow3[ iKey - 300 ];

   ENDCASE

   _retclen( &ucChar, 1 );
}

//----------------------------------------------------------------------------//
