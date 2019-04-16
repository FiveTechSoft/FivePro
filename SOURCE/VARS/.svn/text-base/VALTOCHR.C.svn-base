#include <ClipApi.h>

extern CLIPPER __str1( void );
extern CLIPPER __ltrim( void );
extern CLIPPER __dtoc( void );

//----------------------------------------------------------------------------//

CLIPPER cValToChar()
{
   switch( ( _lbase + 2 )->wType )
   {
      case NUMERIC:
      case NUM_FLOAT:
           _bcopy( ( LPBYTE ) ( ++_tos ), ( LPBYTE ) ( _lbase + 2 ), 14 );
           __str1();
           __ltrim();
           break;

       case DATE:
           _bcopy( ( LPBYTE ) ( ++_tos ), ( LPBYTE ) ( _lbase + 2 ), 14 );
           __dtoc();
           break;

       case LOGICAL:
            _PutC( _parl( 1 ) ? ".T.": ".F." );
            break;

       case CHARACTER:
           _bcopy( ( LPBYTE ) ( ++_tos ), ( LPBYTE ) ( _lbase + 2 ), 14 );
           break;

       default:
           _PutC( "" );
   }

   _bcopy( ( LPBYTE ) ( _eval ), ( LPBYTE ) ( _tos-- ), 14 );
}

//----------------------------------------------------------------------------//
