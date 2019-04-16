#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER cN2Color()
{
   BYTE bColor[ 7 ];
   BYTE nColor = _parni( 1 );
   BYTE bPos = 0;

   if( nColor & 0x80 )
      bColor[ bPos++ ] = '*';

   if( nColor & 0x08 )
      bColor[ bPos++ ] = '+';

   switch( nColor & 0x07 )
   {
      case 0:
           bColor[ bPos++ ] = 'N';
           break;

      case 1:
           bColor[ bPos++ ] = 'B';
           break;

      case 2:
           bColor[ bPos++ ] = 'G';
           break;

      case 3:
           bColor[ bPos++ ] = 'B';
           bColor[ bPos++ ] = 'G';
           break;

      case 4:
           bColor[ bPos++ ] = 'R';
           break;

      case 5:
           bColor[ bPos++ ] = 'R';
           bColor[ bPos++ ] = 'B';
           break;

      case 6:
           bColor[ bPos++ ] = 'G';
           bColor[ bPos++ ] = 'R';
           break;

      case 7:
           bColor[ bPos++ ] = 'W';
           break;
   }

   bColor[ bPos++ ] = '/';

   switch( ( nColor & 0x70 ) >> 4 )
   {
      case 0:
           bColor[ bPos++ ] = 'N';
           break;

      case 1:
           bColor[ bPos++ ] = 'B';
           break;

      case 2:
           bColor[ bPos++ ] = 'G';
           break;

      case 3:
           bColor[ bPos++ ] = 'B';
           bColor[ bPos++ ] = 'G';
           break;

      case 4:
           bColor[ bPos++ ] = 'R';
           break;

      case 5:
           bColor[ bPos++ ] = 'R';
           bColor[ bPos++ ] = 'B';
           break;

      case 6:
           bColor[ bPos++ ] = 'G';
           bColor[ bPos++ ] = 'R';
           break;

      case 7:
           bColor[ bPos++ ] = 'W';
           break;
   }

   _retclen( bColor, bPos );
}

//----------------------------------------------------------------------------//
