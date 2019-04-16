#include <ClipApi.h>

//----------------------------------------------------------------------------//

WORD wLabelLen( LPSTR szLabel )
{
   WORD wLen = 0;

   while( * szLabel )
   {
      if( * szLabel != '&' )
         wLen++;
      szLabel++;
   }
   return wLen;
}

//----------------------------------------------------------------------------//

CLIPPER nLabelLen() { _retni( wLabelLen( _parc( 1 ) ) ); }

//----------------------------------------------------------------------------//
