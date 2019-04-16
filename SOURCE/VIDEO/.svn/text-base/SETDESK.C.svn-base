#include <ClipApi.h>

extern void SetVideo( WORD wMode );
extern void Pcx256( LPSTR szFileName, WORD wRow, WORD wCol );
extern void _InKey1( WORD wTime );
extern void SetText( void );

//----------------------------------------------------------------------------//

CLIPPER SetDeskWal() // lPaper()   cPcxFile
{
   SetVideo( 19 );
   Pcx256( _parc( 1 ), 0, 0 );
   _InKey1( 0 );
   SetText();
}

//----------------------------------------------------------------------------//
