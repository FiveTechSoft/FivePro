#include <ClipApi.h>

/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Funciขn: RAscan()                                             บ
บ          Busca en un array desde el final hasta el principio. บ
บ Par metros: arrayToScan, ubCodeBlock [, nFirst, nCuantos ]    บ
บ                                                               บ
บ Mขdulo: RAscan.c                                              บ
บ Lenguaje: C para Clipper 5.xx                                 บ
บ Fecha: Enero  1993  Revisada Octubre 1993                     บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn & Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

extern void far _cEval1( PCLIPVAR, PCLIPVAR );

extern void far _xeq( void );

CLIPPER RAscan() // ( array, uVar [, nFirst, nCuantos ] )
{
   WORD     wFirst = 0;
   WORD     wTop;
   PCLIPVAR pArray = _param( 1, ARRAY );
   PCLIPVAR pBlock = _param( 2, BLOCK );
   WORD     wLen;
   BOOL     bFound = ( _pcount > 1 );

   if( bFound && pArray );
   {
       wLen = _VARRAYLEN( pArray );
       bFound = ( wLen > 0 );
   }

   if( pArray && bFound )
   {

      wFirst   = ( _param( 3, NUMERIC ) ? _parni( 3 ) : wLen );
      wFirst   = ( wFirst > wLen ? wLen : ( wFirst < 1 ? 1 : wFirst ) );

      wTop = wFirst - ( _param( 4, NUMERIC ) ? _parni( 4 ) : wFirst );
      wTop = ( wTop ? wTop : 0 );

      // hasta aquก bFound sirviข para certificar parametros obligatorios.
      bFound = FALSE;
      
      while( wFirst > wTop && !bFound )
      {  
         // ponemos el iTem en _eval.
         _cAt( pArray, wFirst--, 0xFFFF, _eval );
         
         // จ Es un codeBlock ?
         if( pBlock )
            _cEval1( pBlock, _eval );
         else
         {   
            // Pasamos el iTem a _xeq()
            _xPushM( _eval );

            // pasamos el valor a comparar a _xeq()
            _xPushM( _lbase + 3 );
   
            _xeq();
         }

         bFound = (BOOL) _eval->pPointer1;
      
      }
      
      if( bFound )
                ++wFirst;

   }

   _retni( wFirst );
}
