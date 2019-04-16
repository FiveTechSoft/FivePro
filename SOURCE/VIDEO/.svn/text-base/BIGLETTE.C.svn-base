// Devuelve un array de 16 cadenas con el contenido de una letra
// (c) Antonio Linares 1994
// Dedicado a mi amigo Jose M¦ Fuentes

#include <ClipApi.h>
#include <dos.h>

// ----------------------------------------------------------------------------

static void near FontBegin( void )  // Copia el font a RAM
{
   asm cli;
   outport( 0x3C4, 0x0402 );
   outport( 0x3C4, 0x0704 );
   outport( 0x3C4, 0x0300 );
   asm sti;

   outport( 0x3CE, 0x0204 );
   outport( 0x3CE, 0x0005 );
   outport( 0x3CE, 0x0006 );
}

// ----------------------------------------------------------------------------

static void near FontEnd( void )  // Copia el font a la tarjeta
{
   asm cli;
   outport( 0x3C4, 0x0302 );
   outport( 0x3C4, 0x0304 );
   outport( 0x3C4, 0x0300 );
   asm sti;

   outport( 0x3CE, 0x0004 );
   outport( 0x3CE, 0x1005 );
   outport( 0x3CE, 0x0E06 );
}

// ----------------------------------------------------------------------------

CLIPPER BigLetter()
{
   BYTE b;
   BYTE bByte;
   BYTE bLine[ 8 ];
   WORD wLetter = _parni( 1 );
   BYTE bBit;
   BYTE bPos = 1;

   FontBegin();
   _reta( 16 );

   for( b = 0; b < 16; b++ )
   {
      bByte = * ( ( char * ) 0xA0000000 + ( wLetter * 32 ) + b );
      bPos  = 128;
      for( bBit = 0; bBit < 8; bBit++ )
      {
         if( bByte & bPos )
            bLine[ bBit ] = '²';
         else
            bLine[ bBit ] = ' ';
         bPos >>= 1;
      }
      _storclen( bLine, 8, -1, b + 1 );
   }
   FontEnd();
}

// ----------------------------------------------------------------------------
