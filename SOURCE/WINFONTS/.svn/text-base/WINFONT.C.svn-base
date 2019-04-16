#include <stdio.h>

typedef unsigned int  WORD;
typedef unsigned char BYTE;
typedef BYTE * LPSTR;

typedef struct
{
   WORD wWidth;
   WORD wOffset;
} CHARINFO;

typedef struct
{
   WORD wDummy[ 59 ];
   CHARINFO chars[ 100 ];
} FONT;

//----------------------------------------------------------------------------//

void main( WORD wArgs, LPSTR Arg[] )
{
   FILE * pFont;
   FONT font;

   if( wArgs > 1 )
   {
      pFont = fopen( Arg[ 1 ], "rb" );
      fread( &font, sizeof( FONT ), 1, pFont );

      printf( "Ancho %i\n", font.chars[ 0 ].wWidth );
      printf( "Ancho %i\n", font.chars[ 1 ].wWidth );
      printf( "Ancho %i\n", font.chars[ 2 ].wWidth );
      printf( "Ancho %i\n", font.chars[ 3 ].wWidth );
      printf( "Ancho %i\n", font.chars[ 4 ].wWidth );

      fclose( pFont );
   }
}

//----------------------------------------------------------------------------//
