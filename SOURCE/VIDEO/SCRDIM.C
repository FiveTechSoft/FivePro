#include <ClipApi.h>

void ScrDim( WORD, WORD );

CLIPPER SCRDIM()
{
   ScrDim( _parni( 1 ), _parni( 2 ) );
}
