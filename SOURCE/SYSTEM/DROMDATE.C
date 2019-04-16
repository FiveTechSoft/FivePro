#include <dos.h>
#include <extend.h>

CLIPPER dRomDate()                             /* En Rom, ascii DD/MM/AA */
{
   char * pcRomString = MK_FP( 0xF000, 0xFFF5 );
   unsigned char szDate[ 9 ];

   szDate[ 0 ] = '1';
   szDate[ 1 ] = '9';
   szDate[ 2 ] = pcRomString[ 6 ];
   szDate[ 3 ] = pcRomString[ 7 ];
   szDate[ 4 ] = pcRomString[ 0 ];
   szDate[ 5 ] = pcRomString[ 1 ];
   szDate[ 6 ] = pcRomString[ 3 ];
   szDate[ 7 ] = pcRomString[ 4 ];
   szDate[ 8 ] = 0;

   _retds( szDate );
}
