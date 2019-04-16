// DOC
// lIsShare()        Detecta si SHARE est  instalado
//
// ^BSintaxis:
//                   lIsShare()  --> lEstaInstalado
//
// ^BPar metros:^N       ninguno
//
// ^BDevuelve:^N         lEstaInstalado es un valor l¢gico, .t. ¢ .f. dependiendo
//                   de que SHARE.EXE haya sido instalado ¢ no.
//
// ^BEjemplos:
//                   ? lIsShare()       //   Devolver  .f.
//
// ENDDOC

#include <extend.h>

//----------------------------------------------------------------------------//

CLIPPER lIsShare()             // Detecta si SHARE est  instalado
{
   _AX = 0x1000;
   asm int 0x2F;
   _retl( _AL );
}

//----------------------------------------------------------------------------//
