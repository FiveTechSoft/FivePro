#include <extend.h>

CLIPPER nChrCount()
{
   char * szChr  = _parc( 1 );
   char * szText = _parc( 2 );
   unsigned int uiResult = 0;

   while( * szText )
   {
      if( * szText == * szChr )
         uiResult++;
      szText++;
   }
   _retnl( uiResult );
}
