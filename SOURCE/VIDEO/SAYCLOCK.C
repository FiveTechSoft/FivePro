#include <ClipApi.h>
#include <dos.h>

WORD pascal DosMapRealSeg( WORD, LONG, WORD * );
WORD pascal DosFreeSeg( WORD );

static WORD wVideo;
static BYTE segs, chr = ':';

//----------------------------------------------------------------------------//

CLIPPER SayClock()
{
   char * pVideo;
   char * pTime  = _parc( 1 );

   /*
   if( ! wVideo )
      DosMapRealSeg( 0xB800, 0x8000, &wVideo );

   pVideo = MK_FP( wVideo, 0 );
   */

   pVideo = ( char * ) 0xB8000000;

   pVideo[ 148 ] = pTime[ 0 ];
   pVideo[ 150 ] = pTime[ 1 ];
   pVideo[ 152 ] = chr;
   pVideo[ 154 ] = pTime[ 3 ];
   pVideo[ 156 ] = pTime[ 4 ];

   if( pTime[ 7 ] != segs )
   {
      segs = pTime[ 7 ];
      chr  = ( chr == ' ' ) ? ':': ' ';
   }
}

//----------------------------------------------------------------------------//
