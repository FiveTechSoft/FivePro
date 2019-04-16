#include "Aspen.h"

//----------------------------------------------------------------------------//

TBlock::TBlock( USHORT uiParam )
{
   _evalNew( &info, _itemParam( uiParam ) );
}

//----------------------------------------------------------------------------//

void TBlock::Eval( TItem& item )
{
   _evalPutParam( &info, item.item );
   _itemReturn( _evalLaunch( &info ) );
}

//----------------------------------------------------------------------------//
