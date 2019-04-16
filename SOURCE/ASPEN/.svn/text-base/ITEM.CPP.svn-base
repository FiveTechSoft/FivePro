#include "Aspen.h"

//----------------------------------------------------------------------------//

TItem::TItem()
{
   item = _itemNew( 0 );
}

//----------------------------------------------------------------------------//

TItem::TItem( char far * szText )
{
   item = _itemPutC( 0, szText );
}

//----------------------------------------------------------------------------//

TItem::~TItem()
{
   _itemRelease( item );
   item = 0;
}

//----------------------------------------------------------------------------//

USHORT TItem::Size()
{
   return _itemSize( item );
}

//----------------------------------------------------------------------------//

void TItem::Return()
{
   _itemReturn( item );
}

//----------------------------------------------------------------------------//

void TItem::operator=( char far * szText )
{
   item = _itemPutC( item, szText );
}

//----------------------------------------------------------------------------//

void TItem::operator=( long lNum )
{
   item = _itemPutNL( item, lNum );
}

//----------------------------------------------------------------------------//

void TItem::operator+=( LPSTR szText )
{
   LPSTR szBuffer = ( LPSTR ) _xgrab( Size() + strlen( szText ) + 1 );

   szBuffer[ 0 ] = 0;
   strcpy( szBuffer, _itemGetC( item ) );
   strcat( szBuffer, szText );

   item = _itemPutC( item, szBuffer );
   _xfree( szBuffer );
}

//----------------------------------------------------------------------------//

void TItem::Eval( TItem& itParam )
{
   EVALINFO info;

   _evalNew( &info, item );
   _evalPutParam( &info, itParam.item );
   _itemReturn( _evalLaunch( &info ) );
}

//----------------------------------------------------------------------------//
