#include <ClipApi.h>

static unsigned char bOnOff      = 1;
static unsigned char bTrueShadow = 1;
static unsigned char bClrShadow  = 7;

static int Min( int i1, int i2 ) { return i1 < i2 ? i1: i2; }
static int Max( int i1, int i2 ) { return i1 > i2 ? i1: i2; }

//----------------------------------------------------------------------------//

void _gtShadow( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight )
{
   unsigned int uiSize;
   void * pBuffer;
   unsigned int ui;

   if( wTop > _gtMaxRow() )
      return;

   wTop    = Min( Max( 0, wTop ), _gtMaxRow() );
   wLeft   = Min( Max( 0, wLeft ), _gtMaxCol() + 1 );
   wBottom = Min( Max( 0, wBottom ), _gtMaxRow() );
   wRight  = Min( Max( 0, wRight ), _gtMaxCol() + 1 );

   if( bOnOff )
   {
      _gtRectSize( wTop, wLeft, wBottom, wRight, &uiSize );
      pBuffer = _xgrab( uiSize );
      _gtSave( wTop, wLeft, wBottom, wRight, pBuffer );

      if( bTrueShadow )
      {
         for( ui = 0; ui < uiSize; ui++ )
         {
            if( ( * ( ( unsigned char * ) pBuffer + ui + 1 ) & 0x80 ) )
                  * ( ( unsigned char * ) pBuffer + ui + 1 ) &= 0x77;
            else
            {
               if( ( * ( ( unsigned char * ) pBuffer + ui + 1 ) & 0x08 ) )
                  * ( ( unsigned char * ) pBuffer + ui + 1 ) &= 0x07;
               else
                  * ( ( unsigned char * ) pBuffer + ui + 1 ) = 7;
            }
            ui++;
         }
      }
      else
      {
         for( ui = 0; ui < uiSize; ui++ )
         {
            * ( ( unsigned char * ) pBuffer + ui + 1 ) = bClrShadow;
            ui++;
         }
      }

      _gtRest( wTop, wLeft, wBottom, wRight, pBuffer );
      _xfree( pBuffer );
   }
}

//----------------------------------------------------------------------------//

CLIPPER Shadow()
{
   _gtShadow( _parni( 1 ), _parni( 2 ), _parni( 3 ), _parni( 4 ) );
}

//----------------------------------------------------------------------------//

CLIPPER SetShadow()
{
  unsigned char bOldOnOff = bOnOff;

  bOnOff = _parl( 1 );
  _retl( bOldOnOff );
}

//----------------------------------------------------------------------------//

CLIPPER TrueShadow()
{
   unsigned char bOldTrueShadow = bTrueShadow;

   bTrueShadow = _parl( 1 );
   _retl( bOldTrueShadow );
}

//----------------------------------------------------------------------------//

CLIPPER ClrShadow()
{
   unsigned char bOldClrShadow = bClrShadow;

   bClrShadow = _parni( 1 );
   _retni( bOldClrShadow );
}

//----------------------------------------------------------------------------//
