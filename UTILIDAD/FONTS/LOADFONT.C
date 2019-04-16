// (c) Antonio Linares, 1993

#include <stdio.h>
#include <dos.h>

typedef unsigned char BYTE;
typedef unsigned int WORD;
typedef char far * LPSTR;

BYTE bFont[ 4096 ];

void main( WORD wArgs, LPSTR * pArgs )
{
   FILE * hFont;

   if( wArgs == 1 )
   {
      printf( "LoadFont 1.0 - (c) Antonio Linares 1993\n" );
      printf( "Cambia el font de video en curso.\n" );
      printf( "Sintaxis: LoadFont <font>\n" );
      printf( "          LoadFont -r\n" );
      return;
   }

   if( pArgs[ 1 ][ 0 ] == '-' && pArgs[ 1 ][ 1 ] == 'r' )
   {
      _AX = 0x1114;
      _BL = 0;
      asm int 0x10;
   }
   else
   {
      if( hFont = fopen( pArgs[ 1 ], "rb" ) )
      {
         if( fread( bFont, 4095, 1, hFont ) == 1 )
         {
            asm push bp;
            asm push es;

            _BH = 0x10;
            _BL = 0;
            _CX = 256;
            _DX = 0;
            _BP = FP_OFF( bFont );
            _ES = FP_SEG( bFont );
            _AX = 0x1100;
            asm int 0x10;

            asm pop es;
            asm pop bp;
         }
         fclose( hFont );
         printf( "Font instalado correctamente.\n" );
      }
   }
}
