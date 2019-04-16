#include "FileIO.ch"
#include "InKey.ch"

#define nHANDLE   oBrw:Cargo[ 1 ]
#define nFSIZE    oBrw:Cargo[ 2 ]
#define cLINE     oBrw:Cargo[ 3 ]
#define nLINEPOS  oBrw:Cargo[ 4 ]
#define nFRecNo() FSeek(nHANDLE,0,FS_RELATIVE)

//----------------------------------------------------------------------------//

function TBrowseText( nTop, nLeft, nBottom, nRight, cFileName )

   local oBrw := TBrowseNew( nTop, nLeft, nBottom, nRight )

   oBrw:Cargo = Array( 4 )

   if ( nHANDLE := FOpen( cFileName ) ) != 0
      nFSIZE   = FSeek( nHANDLE, 0, FS_END )
      cLINE    = ""
      nLINEPOS = 1
      FSeek( nHANDLE, 0, FS_SET )
      oBrw:GoTopBlock    = { || FSeek( nHANDLE, 0, FS_SET ) }
      oBrw:GoBottomBlock = { || FSeek( nHANDLE, 0, FS_END ),;
                                nSkipLine( oBrw, -1 ) }
      oBrw:SkipBlock     = { | n | nSkipLine( oBrw, n ) }
      oBrw:AddColumn( TbColumnNew( , { || FReadLine( oBrw ),;
                                          SubStr( cLINE, nLINEPOS ) } ) )
      oBrw:GetColumn( 1 ):Width = nRight - nLeft + 1
   endif

return If( nHANDLE != 0, oBrw, nil )

//----------------------------------------------------------------------------//

static function nSkipLine( oBrw, n )

   local nRecNo, nRead, nEoL, nSkip := 0
   local cBuffer := Space( 250 )

   if n > 0
      do while nSkip < n .and. ( nFRecNo() + Len( cLINE ) + 3 ) < nFSIZE
         FSeek( nHANDLE, Len( cLINE ) + 2, FS_RELATIVE )
         FReadLine( oBrw )
         if nFRecNo() + 3 < nFSIZE
            nSkip++
         endif
      enddo

   else
      do while nSkip > n .and. nFRecNo() > 0
         FSeek( nHANDLE, -2, FS_RELATIVE )
         nRecNo = nFRecNo()
         FSeek( nHANDLE, -Min( Len( cBuffer ), nRecNo ), FS_RELATIVE )
         nRead = FRead( nHANDLE, @cBuffer, Min( Len( cBuffer ), nRecNo ) )
         FSeek( nHANDLE, ( nEoL := RAt( Chr( 13 ), SubStr( cBuffer, 1,;
                nRead ) ) ) + 1 - nRead, FS_RELATIVE )
         FSeek( nHANDLE, If( nFRecNo() == 1, -1, 0 ), FS_RELATIVE )
         nSkip--
      enddo
   endif

return nSkip

//----------------------------------------------------------------------------//

static function FReadLine( oBrw )

   local cBuffer := Space( 250 )
   local nRead   := FRead( nHANDLE, @cBuffer, 250 )

   FSeek( nHANDLE, -nRead, FS_RELATIVE )
   cLINE = SubStr( cBuffer, 1, At( Chr( 13 ), cBuffer ) - 1 )

return

//----------------------------------------------------------------------------//
