#include "Aspen.h"

//----------------------------------------------------------------------------//

TArray::TArray( USHORT uiSize )
{
   item = _itemArrayNew( uiSize );
}

//----------------------------------------------------------------------------//

TArrItem& TArray::operator[]( USHORT uiElem )
{
   TArrItem * pItem = new TArrItem( this, uiElem );

   return * pItem;
}

//----------------------------------------------------------------------------//

TArrItem::TArrItem( TArray * pArray, USHORT uiElem )
{
   item   = _itemArrayGet( pArray->item, uiElem );
   pOwner = pArray;
   uiPos  = uiElem;
}

//----------------------------------------------------------------------------//

void TArrItem::operator=( char * szText )
{
   _itemPutC( item, szText );
   _itemArrayPut( pOwner->item, uiPos, item );
}

//----------------------------------------------------------------------------//

void TArrItem::operator=( long lNum )
{
   _itemPutNL( item, lNum );
   _itemArrayPut( pOwner->item, uiPos, item );
}

//----------------------------------------------------------------------------//
