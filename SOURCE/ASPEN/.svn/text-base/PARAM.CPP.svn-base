#include "Aspen.h"

extern USHORT _pcount;

static USHORT paramPos;

//----------------------------------------------------------------------------//

param::param()
{
   if( ++paramPos > _pcount )
      paramPos = 1;

   item = _itemParam( paramPos );
}

//----------------------------------------------------------------------------//
