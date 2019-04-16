#include <ClipApi.h>

CLIPPER Encript()
{
   unsigned char * szText = _parc( 1 );
   unsigned char ucByte;
   unsigned char ucCounter = 0;

   while( ucByte = * szText )
   {
      ucByte ^= 26;
      _AH = ucByte;
      _CL = ucCounter;
      asm rol ah, cl;
      * szText++ = _AH;
      ucCounter++;
   }
}

CLIPPER Decript()
{
   unsigned char * szText = _parc( 1 );
   unsigned char ucByte;
   unsigned char ucCounter = 0;

   while( ucByte = * szText )
   {
      _AH = ucByte;
      _CL = ucCounter;
      asm ror ah, cl;
      ucByte = _AH;
      ucByte ^= 26;
      * szText++ = ucByte;
      ucCounter++;
   }
}

