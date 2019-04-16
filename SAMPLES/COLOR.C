#include <ClipApi.h>

void sParse( RGB, WORD wColor, LPBYTE pBuffer );

CLIPPER GetColor()
{
   BYTE bBuffer[ 10 ];
   COLOR Colors[ 5 ];

   _gtGetColor( Colors );

   sParse( Colors[ 0 ].Fore, 0, bBuffer );
   _retclen( bBuffer, 9 );
}
