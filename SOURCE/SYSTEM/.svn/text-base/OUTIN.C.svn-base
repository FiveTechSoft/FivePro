#include <dos.h>
#include <extend.h>

/*----------------------------------------------------------------------------*/

CLIPPER nInByte()                         /* lee un valor de un puerto */
{
  _retni( inportb( _parni( 1 ) ) );
}

/*----------------------------------------------------------------------------*/

CLIPPER OutByte()                        /* manda un valor a un puerto */
{
   outportb( _parni( 1 ), _parni( 2 ) );
  _ret();
}

/*----------------------------------------------------------------------------*/

CLIPPER nInWord()                        /* lee un valor de un puerto */
{
  unsigned int puerto, resultado;

  puerto = _parni( 1 );
  _DX = puerto;
  asm in ax, dx;
  resultado = _AX;
  _retnl( resultado );                  /* para evitar el problema del signo  */
}                                       /* Clipper toma los UNSIGNED INT c¢mo */
                                        /* SIGNED */

/*----------------------------------------------------------------------------*/

CLIPPER OutWord()                        /* manda un valor a un puerto */
{
  unsigned int puerto, valor;

  puerto = _parni( 1 );
  valor = _parni( 2 );
  _DX = puerto;
  _AX = valor;
  asm out dx, ax;
  _ret();
}

/*----------------------------------------------------------------------------*/
