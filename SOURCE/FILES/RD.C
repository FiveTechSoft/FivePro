#include <dos.h>
#include <extend.h>

// (C) Antonio Linares, 1993

CLIPPER RD()
{
   char * szDirName = _parc( 1 );

   asm push ds;
   _AH = 0x3A;
   _DS = FP_SEG( szDirName );
   _DX = FP_OFF( szDirName );
   asm int 0x21;
   asm pop ds;

   _retl( !( _FLAGS & 1 ) );
}
