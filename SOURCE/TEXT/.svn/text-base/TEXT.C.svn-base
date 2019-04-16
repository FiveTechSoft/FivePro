#include <ClipApi.h>

//----------------------------------------------------------------------------//

WORD _TReadLn( WORD wHandle, LPBYTE pBuffer )
{
   BYTE b;
   LPBYTE pTemp = pBuffer;

   while( _tread( wHandle, &b, 1 ) && ( b != 10 ) )
      * pTemp++ = b;
   * pTemp++ = 0;                     // 0 --> only 1 byte

   return pTemp - pBuffer;
}

//----------------------------------------------------------------------------//

CLIPPER nTxtLines()
{
   WORD wHandle;
   BYTE bBuffer[ 500 ];
   LONG lLines = 0;

   if( wHandle = _topen( _parc( 1 ), 0 ) )
   {
      while( _TReadLn( wHandle, bBuffer ) )
         lLines++;
      _tclose( wHandle );
   }

   _retnl( lLines );
}

//----------------------------------------------------------------------------//

CLIPPER cFReadLine()
{
   BYTE bBuffer[ 500 ];
   WORD wLineLen;

   if( wLineLen = _TReadLn( _parni( 1 ), bBuffer ) )
      _retclen( bBuffer, wLineLen );
   else
      _retc( "" );
}

//----------------------------------------------------------------------------//

CLIPPER TxtEval()
{
   int  iHandle;
   WORD wLineLen, wLine = 1;
   BYTE bBuffer[ 500 ];
   LONG lOffset = 1;

   if( ( iHandle = _topen( _parc( 1 ), 0 ) ) != -1 )
   {
      if( PCOUNT() > 1 )
      {
         while( wLineLen = _TReadLn( iHandle, bBuffer ) )
         {
            _PutSym( _SymEval );
            _bcopy( ( LPBYTE ) ( ++_tos ), ( LPBYTE ) ( _lbase + 3 ), 14 );
            _PutCL( bBuffer, wLineLen - 2 );
            _PutQ( wLine++ );
            _PutLN( lOffset );
            _xEval( 3 );
            lOffset = _tlseek( iHandle, 0, 1 );
         }
      }
      _tclose( iHandle );
   }
}

//----------------------------------------------------------------------------//

CLIPPER nTxtScan()
{
   WORD iHandle;
   WORD wLineLen;
   BYTE bBuffer[ 500 ];
   LONG lOffset = 1, lLine = 1;
   BOOL bContinue = TRUE;
   LPSTR pText;

   if( iHandle = _topen( _parc( 1 ), 0 ) )
   {
      if( PCOUNT() > 1 )
      {
         if( ( _lbase + 3 )->wType == BLOCK )
         {
            while( bContinue && ( wLineLen = _TReadLn( iHandle, bBuffer ) ) )
            {
               _PutSym( _SymEval );
               ( ++_tos )->wType = NIL;
               _xPushM( _lbase + 3 );
               _PutCL( bBuffer, wLineLen );
               _PutLN( lLine++ );
               _PutLN( lOffset );
               _xEval( 3 );
               if( bContinue = ( ! _parl( -1 ) ) )
                  lOffset = _tlseek( iHandle, 0, 1 );
            }
         }
         else
         {
            pText = _parc( 2 );
            while( bContinue && ( wLineLen = _TReadLn( iHandle, bBuffer ) ) )
            {
               if( bContinue = ! _StrScan( bBuffer, pText ) )
                  lOffset = _tlseek( iHandle, 0, 1 );
               lLine++;
            }
         }
      }
      _tclose( iHandle );

      if( ! bContinue )
      {
         if( PCOUNT() > 2 )
            _storclen( bBuffer, wLineLen, 3 );
         if( PCOUNT() > 3 )
            _storni( lOffset, 4 );
         _retnl( --lLine );
      }
   }
   else
      _retnl( 0 );
}

//----------------------------------------------------------------------------//

CLIPPER nTxtWords()
{
   WORD iHandle;
   BYTE bLine[ 500 ];
   LONG lWords = 0;
   WORD wLineLen, w;
   BOOL bInWord = FALSE;

   if( iHandle = _topen( _parc( 1 ), 0 ) )
   {
      while( wLineLen = _TReadLn( iHandle, bLine ) )
      {
         for( w = 0; w < wLineLen; w++ )
         {
            if( bLine[ w ] != ' ' &&
                bLine[ w ] != 13  &&
                bLine[ w ] != 10  &&
                bLine[ w ] != '(' &&
                bLine[ w ] != ')' &&
                bLine[ w ] != '?' )
            {
               if( ! bInWord )
               {
                  lWords++;
                  bInWord = TRUE;
               }
            }
            else
            {
               if( bInWord )
                  bInWord = FALSE;
            }
         }
      }
      _tclose( iHandle );
      _retnl( lWords );
   }
   else
      _retnl( 0 );
}

//----------------------------------------------------------------------------//
