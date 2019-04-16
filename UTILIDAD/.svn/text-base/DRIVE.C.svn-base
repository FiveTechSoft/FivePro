// (c) Software de Espa¤a, 1993
// A.Linares, I+D

// Compilar con BCC -ml drive.c

#include <stdio.h>
#include <dos.h>
#include <process.h>

//----------------------------------------------------------------------------//

typedef unsigned int WORD;
typedef char * LPSTR;

void main( WORD wArgs, LPSTR pArg[] )
{
   if( wArgs > 1 )
   {
      asm push ds;

      _DS = FP_SEG( pArg[ 1 ] );
      _DX = FP_OFF( pArg[ 1 ] );
      _AH = 0x3B;
      asm int 0x21;

      asm pop ds;

      if( _AX == 3 )
         exit( 1 );
   }
}

//----------------------------------------------------------------------------//
