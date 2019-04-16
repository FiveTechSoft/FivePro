#include <extend.h>

//----------------------------------------------------------------------------//

CLIPPER cStrBtw()
{
   char * szText            = _parc( 1 );
   char * szSeparator       = _parc( 2 );
   unsigned int uiOcurrence = _parni( 3 );
   unsigned int uiStart     = 0;
   unsigned int uiEnd       = 0;
   unsigned int uiCounter   = 0;

   while( uiCounter < uiOcurrence - 1 )
   {
      while( szText[ uiStart ] && szText[ uiStart ] != szSeparator[ 0 ] )
      {
         uiStart++;
      }
      if( szText[ uiStart ] ) uiStart++;
      uiCounter++;
   }
   if( szText[ uiStart ] )
   {
      uiEnd = uiStart + 1;
      while( szText[ uiEnd ] && szText[ uiEnd ] != szSeparator[ 0 ] )
      {
         uiEnd++;
      }
  }
  else
  {
     uiEnd = uiStart;
  }
   _retclen( szText + uiStart, uiEnd - uiStart );
}

//----------------------------------------------------------------------------//
