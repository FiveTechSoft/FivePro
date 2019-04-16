#include <ClipApi.h>
#include <dos.h>

WORD wLabelLen( LPSTR );

//----------------------------------------------------------------------------//

void SayHot( LPBYTE pBuffer, LPSTR szText, WORD wClrNormal, WORD wClrHot )
{
   BYTE bChar;
   WORD w = 0;

   while( bChar = * szText++ )
   {
      pBuffer[ w + 1 ] = IF( bChar == '&', wClrHot, wClrNormal );
      if( bChar == '&' )
         bChar = * szText++;
      pBuffer[ w ] = bChar;
      w += 2;
   }
}

//----------------------------------------------------------------------------//

CLIPPER BtnDraw() // iTop, iLeft, iBottom, iRight, cText, wClrText, wClrHot, lPressed
{
   BOOL lPressed  = _parl( 8 );
   WORD wMaxRow   = _gtMaxRow();
   WORD wMaxCol   = _gtMaxCol();
   int  iTop      = _parni( 1 );
   int  iLeft     = _parni( 2 );
   int  iBottom   = _parni( 3 );
   int  iRight    = _parni( 4 );
   LPSTR szText   = _parc( 5 );
   WORD wClrText  = IF( _parni( 6 ), _parni( 6 ), 7 );
   WORD wClrHot   = IF( _parni( 7 ), _parni( 7 ), 112 );
   WORD wWidth    = MIN( iRight, wMaxCol ) - MAX( iLeft, 0 ) + 1;
   WORD wHeight   = MIN( iBottom, wMaxRow ) - MAX( iTop, 0 ) + 1;
   WORD wBufSize  = wWidth * wHeight * 2;
   LPBYTE pBuffer;
   WORD wOffset;
   WORD wRow, wCol;

   pBuffer = _xgrab( wBufSize + 1 );

   _gtSave( MAX( iTop, 0 ), MAX( iLeft, 0 ),
            MIN( iBottom, wMaxRow ), MIN( iRight, wMaxCol ), pBuffer );

   for( wRow = 0; wRow < wHeight - 1 && wRow <= wMaxRow ; wRow++ )
   {
      for( wCol = lPressed; wCol < wWidth - !lPressed && wCol <= wMaxCol; wCol++ )
      {
         wOffset = ( wRow * wWidth * 2 ) + ( wCol * 2 );
         pBuffer[ wOffset ]     = ' ';
         pBuffer[ wOffset + 1 ] = wClrText;
      }

      if( ! lPressed )
      {
         if( wRow == 0 )
         {
            pBuffer[ ( wRow * wWidth * 2 ) + ( wCol * 2 ) ]  = 'Ü';
            pBuffer[ ( wRow * wWidth * 2 ) + ( wCol * 2 ) + 1 ] &= 0xF0;
         }
         else
            pBuffer[ ( wRow * wWidth * 2 ) + ( wCol * 2 ) + 1 ] = 7;
      }
   }

   SayHot( pBuffer + 2 + IF( lPressed, 2, 0 ), szText, wClrText, wClrHot );

   if( ! lPressed )
   {
      for( wCol = 1; wCol <= wWidth && wCol <= wMaxCol; wCol++ )
      {
         pBuffer[ ( wRow * wWidth * 2 ) + ( wCol * 2 ) ] = 'ß';
         pBuffer[ ( wRow * wWidth * 2 ) + ( wCol * 2 ) + 1 ] &= 0xF0;
      }
   }

   _gtRest( MAX( 0, iTop ), MAX( 0, iLeft ),
            MIN( wMaxRow, iBottom ),
            MIN( wMaxCol, iRight ), pBuffer );

   _xfree( pBuffer );
}

//----------------------------------------------------------------------------//
