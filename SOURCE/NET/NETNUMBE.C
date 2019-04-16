// DOC
//
// nNetNumber()       Devuelve el n£mero de estaci¢n, si tiene un sem foro
//
// Sintaxis
//
//           nNetNumber()  --> nEstaci¢n
//
// Par metros
//
//           Ninguno
//
// Devuelve
//
//           nEstaci¢n es su n£mero identificativo de estaci¢n
//
// Ejemplo
//
//           ? nNetNumber()
//
// ENDDOC

#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER nNetNumber()
{
   _AH = 0xDC;
   _AL = 0;
   asm int 0x21;
   _retni( _AL );
}

//----------------------------------------------------------------------------//
