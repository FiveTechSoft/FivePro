#include <ClipApi.h>

//----------------------------------------------------------------------------//

CLIPPER cScrSub()
{
  BYTE bTop      = _parni( 1 );
  BYTE bLeft     = _parni( 2 );
  BYTE bBottom   = _parni( 3 );
  BYTE bRight    = _parni( 4 );
  LPBYTE pScreen = _parc( 5 );
  WORD wScrWidth = _parni( 6 );
  WORD wHeight   = bBottom - bTop + 1;
  WORD wWidth    = bRight - bLeft + 1;
  LPBYTE pResult;
  WORD n1, n2, nByte, nPos;
  WORD nTab, nLen;

  if( bTop >= 0 && bTop < 25 &&
      bLeft >= 0 && bLeft < 80 &&
      bBottom >= 0 && bBottom < 25 &&
      bRight >= 0 && bRight < 80 )
  {
     pResult  = _xgrab( wHeight * wWidth * 2 );
     nTab = ( bLeft * 2 ) + 1;
     nLen = wWidth * 2;
     wScrWidth = wScrWidth * 2;

     nByte = 0;
     for( n1 = bTop; n1 <= bBottom; n1++ )
     {
        for( n2 = 0; n2 < nLen; n2++ )
        {
           nPos = ( n1 * wScrWidth ) + nTab;
           ( ( char far * ) pResult )[ nByte ] = pScreen[ nPos + n2 - 1 ];
           nByte++;
        }
     }
     _retclen( pResult, wHeight * wWidth * 2 );
     _xfree( pResult );
   }
   else
      _retc( "" );
}

//----------------------------------------------------------------------------//
