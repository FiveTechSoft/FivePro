/*
   Yo uso el Borland C++ para compilar, por la comodidad de que incluye
   el TASM, por lo que produce el .OBJ directamente caso de usar ensam-
   blador 'inline'. Usad: BCC -c -ml -P- programa.c
*/

#include "extend.h"

unsigned char ucColor2N( char * );

/*
   La funci¢n nColor2N() permite obtener el valor num‚rico a partir de
   un color en modo texto al estilo Clipper.
   Ejemplo: ? nColor2N( "gr+/b" ) devolver  el valor 30
*/

CLIPPER nColorToN()        /* funci¢n interface entre Clipper y C */
{
   _retnl( ucColor2N( _parc( 1 ) ) );
}

/*
   La funci¢n ucColor2N() podr  ser llamada desde un programa en C,
   sin ning£n tipo de problemas !!!
*/

unsigned char ucColor2N( char * szColor )   /* funci¢n aut¢noma en C */
{
   unsigned char ucFlash     = 0;
   unsigned char ucIntensity = 0;
   unsigned char ucForeColor = 0;
   unsigned char ucBackColor = 0;
            char cFirstToken = 1;
            char c           = 0;

   while( szColor[ c ] )
   {
      if( szColor[ c ] == '+' )
           ucIntensity = 8;

      else if( szColor[ c ] == '*' )
           ucFlash = 128;

      else if( szColor[ c ] >= 'A' && szColor[ c ] <= 'Z' )
           if( cFirstToken )
               ucForeColor += szColor[ c ];
           else
               ucBackColor += szColor[ c ];

      else if( szColor[ c ] >= 'a' && szColor[ c ] <= 'z' )
           if( cFirstToken )
               ucForeColor += szColor[ c ] - 32;
           else
               ucBackColor += szColor[ c ] - 32;

      else if( szColor[ c ] == '/' )
           cFirstToken = 0;

      c++;
   }

   switch( ucForeColor )
   {
      case 'N':
           ucForeColor = 0; break;

      case 'B':
           ucForeColor = 1; break;

      case 'G':
           ucForeColor = 2; break;

      case 'B' + 'G':
           ucForeColor = 3; break;

      case 'R':
           ucForeColor = 4; break;

      case 'R' + 'B':
           ucForeColor = 5; break;

      case 'G' + 'R':
           ucForeColor = 6; break;

      case 'W':
           ucForeColor = 7; break;
   }

   switch( ucBackColor )
   {
      case 'N':
           ucBackColor = 0; break;

      case 'B':
           ucBackColor = 1; break;

      case 'G':
           ucBackColor = 2; break;

      case 'B' + 'G':
           ucBackColor = 3; break;

      case 'R':
           ucBackColor = 4; break;

      case 'R' + 'B':
           ucBackColor = 5; break;

      case 'G' + 'R':
           ucBackColor = 6; break;

      case 'W':
           ucBackColor = 7; break;
   }

   return ucFlash + ( ucBackColor * 16 ) + ucIntensity + ucForeColor;
}
