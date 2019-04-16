#include <ClipApi.h>

CLIPPER IcoDisplay()
{
   WORD  wTop    = _parni( 1 );
   WORD  wLeft   = _parni( 2 );
   LPSTR szName  = _parc( 3 );
   WORD  wHandle = 0;
   BYTE  bBuffer[ 1000 ];
   WORD  wRow, wCol, wPos = 126;
   BYTE  bColor;

   if( ! ( wHandle = _topen( szName, 0 ) ) )
      return;

   _tread( wHandle, bBuffer, sizeof( bBuffer ) );

   for( wRow = 32; wRow > 0; wRow-- )
   {
      for( wCol = 0; wCol < 16; wCol++ )
      {
         if( bColor = ( ( bBuffer[ wPos ] & 0xF0 ) >> 4 ) )
            SetPixel( wTop + wRow, wLeft + ( wCol * 2 ), bColor );

         if( bColor = ( bBuffer[ wPos ] & 0x0F ) )
            SetPixel( wTop + wRow, wLeft + ( wCol * 2 ) + 1, bColor );
         wPos++;
      }
   }
   _tclose( wHandle );
}
