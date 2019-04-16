#include "Aspen.h"

extern "C"
{
   USHORT _tcreat( LPSTR, USHORT );
   USHORT _twrite( USHORT, LPSTR, USHORT );
   USHORT strlen( LPSTR );
}

//----------------------------------------------------------------------------//

TFile::TFile()
{
   handle = 0;
}

//----------------------------------------------------------------------------//

TFile::TFile( LPSTR szFileName )
{
   handle = _tcreat( szFileName, 0 );
}

//----------------------------------------------------------------------------//

USHORT TFile::Write( LPSTR szText )
{
   return( _twrite( handle, szText, strlen( szText ) ) );
}

//----------------------------------------------------------------------------//
