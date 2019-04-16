#include <ClipApi.h>

#define     M16 0xA001      /* crc-16 mask */

//----------------------------------------------------------------------------//

WORD wCrc( LPBYTE Buffer, WORD wLen )
{
    WORD wCrc = 0, index, i, c;

    for( index = 0; index < wLen; index++ )
    {
        c = (WORD) Buffer[ index ];
        c <<= 8;

        for( i = 0; i < 8; i++ )
        {
            if( ( wCrc ^ c ) & 0x8000)
               wCrc = ( wCrc << 1 ) ^ M16;
            else
               wCrc <<= 1;

            c <<= 1;
        }
    }
    return wCrc;
}

//----------------------------------------------------------------------------//

CLIPPER nCRC()
{
   _retni( wCrc( _parc( 1 ), _parni( 2 ) ) );
}

//----------------------------------------------------------------------------//
