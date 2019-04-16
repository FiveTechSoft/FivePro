#include "ClipApi.h"

CLIPPER nOr()
{
   LONG lRet = 0;
   WORD i = 0;
   while( i < _pcount )
        lRet = lRet | _parnl( ++i );

   _retnl( lRet );
}

CLIPPER nAnd()
{
   LONG lRet = -1;
   WORD i = 0;
   while( i < _pcount )
        lRet = lRet & _parnl( ++i );

   _retnl( lRet );
}

CLIPPER lAnd()
{
   LONG lRet = -1;
   WORD i = 0;
   while( i < _pcount )
        lRet = lRet & _parnl( ++i );

   _retl( lRet );
}
