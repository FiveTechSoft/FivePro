#include "extend.h"

void MemorySay( char * pcMemBuffer, int iRow, int iCol, char * szText );

CLIPPER MemSay()
{
   char * pcMemBuffer = _parc( 1 );
   int iRow           = _parni( 2 );
   int iCol           = _parni( 3 );
   char * szText      = _parc( 4 );

   MemorySay( pcMemBuffer, iRow, iCol, szText );
   _ret();
}
