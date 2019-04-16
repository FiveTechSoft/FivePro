#include <extend.h>
#include <dos.h>

// (C) Antonio Linares, 1993

CLIPPER CD()
{
   char * szPath = _parc( 1 );

   asm push ds;

   _DX = FP_OFF( szPath );
   _DS = FP_SEG( szPath );
   _AH = 0x3B;
   asm int 0x21;

   asm pop ds;

   _retl( _AX != 3 );
}
