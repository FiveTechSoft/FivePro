#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER cGetHotKey()
{
   LPSTR szText  = _parc( 1 );
   BYTE  bHotKey = 0;
   BOOL  bFound  = FALSE;

   while( ( bHotKey = * szText++ ) && ! bFound )
   {
      if( bHotKey == '&' )
         bFound  = TRUE;
   }

   if( bHotKey >= 'a' )
      bHotKey -= ( 'a' - 'A' );

   _retclen( &bHotKey, ( BYTE ) bFound );
}

//----------------------------------------------------------------------------//

CLIPPER lIsHotKey()                 // nKey, cText
{
   LPSTR szText  = _parc( 2 );
   BYTE bKey     = _parni( 1 );
   BYTE  bHotKey = 0;
   BOOL  bFound  = FALSE;

   if( bKey >= 'a' )
       bKey -= ( 'a' - 'A' );

   while( ( bHotKey = * szText++ ) && ! bFound )
   {
      if( bHotKey == '&' )
         bFound  = TRUE;
   }

   if( bHotKey >= 'a' )
      bHotKey -= ( 'a' - 'A' );

   _retl( bFound && ( bHotKey == bKey ) );
}

//----------------------------------------------------------------------------//
