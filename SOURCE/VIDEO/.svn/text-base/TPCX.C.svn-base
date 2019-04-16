#include <ClipApi.h>
#include <dos.h>

#define FS_BEGINNING 0
#define FS_RELATIVE  1
#define FS_END       2

enum{ SELF, aLINES, cFILENAME, cPALETTE, nHANDLE, nBYTESLINE,
      nTOP, nLEFT, nBOTTOM, nRIGHT, nROWPOS, nCOLPOS };

#define BUFSIZE 4000

#define WIDTH    320

#define SELDAC 0x3C8
#define IORGB  0x3C9

typedef struct
{
   BYTE bId;
   BYTE bVersion;
   BYTE bSystem;
   BYTE bBitsByPixels;
   WORD wLeft, wTop, wRight, wBottom;
   WORD wResHor, wResVert;
   BYTE bPalette[ 48 ];
   BYTE bReserved;
   BYTE bPlanes;
   WORD wBytesByLine;
} PCX;

typedef struct { BYTE Red, Green, Blue; } PCXRGB;

static PCX  pcx;
static BYTE bBuffer[ BUFSIZE ];
static WORD wBufferOffset;
static LONG lFileOffset;

//----------------------------------------------------------------------------//

static void SetGet( WORD wIndex )
{
   if( PCOUNT() )
   {
      _cAtPut( _lbase + 1, wIndex, _lbase + 2 );
      _bcopy( ( LPBYTE ) _eval, ( LPBYTE ) ( _lbase + 1 ), sizeof( CLIPVAR ) );
   }
   else
      _cAt( _lbase + 1, wIndex, 0xFFFF, _eval );
}

//----------------------------------------------------------------------------//

static CLIPPER LINES()     { SetGet( aLINES ); }

static CLIPPER FILENAME()  { SetGet( cFILENAME ); }
static CLIPPER PALETTE()   { SetGet( cPALETTE ); }

static CLIPPER HANDLE()    { SetGet( nHANDLE ); }
static CLIPPER BYTESLINE() { SetGet( nHANDLE ); }

static CLIPPER TOP()       { SetGet( nTOP ); }
static CLIPPER LEFT()      { SetGet( nLEFT ); }
static CLIPPER BOTTOM()    { SetGet( nBOTTOM ); }
static CLIPPER RIGHT()     { SetGet( nRIGHT ); }

static CLIPPER ROWPOS()    { SetGet( nROWPOS ); }
static CLIPPER COLPOS()    { SetGet( nCOLPOS ); }

//----------------------------------------------------------------------------//

static CLIPPER SETPALETTE()
{
   WORD w;
   PCXRGB * pRgb = ( PCXRGB * ) _parc( SELF, cPALETTE );

   for( w = 0; w < 256; w++ )
   {
      outportb( SELDAC, w );
      outportb( IORGB, pRgb[ w ].Red / 4 );
      outportb( IORGB, pRgb[ w ].Green / 4 );
      outportb( IORGB, pRgb[ w ].Blue / 4 );
   }
}

//----------------------------------------------------------------------------//

static BYTE GetByte( WORD wHandle )
{
   BYTE bByte = bBuffer[ wBufferOffset++ ];

   lFileOffset++;

   if( wBufferOffset == BUFSIZE )
   {
      wBufferOffset = 0;
      _tread( wHandle, bBuffer, BUFSIZE );
   }
   return bByte;
}

//----------------------------------------------------------------------------//

static void PcxProcess( WORD wHandle )
{
   WORD wRow, wCol;
   BYTE bByte;

   lFileOffset   = 128;
   wBufferOffset = 128;
   _tlseek( wHandle, 0, FS_BEGINNING );
   _tread( wHandle, bBuffer, BUFSIZE );

   for( wRow = 0; wRow < pcx.wBottom - pcx.wTop + 1; wRow++ )
   {
      _stornl( lFileOffset, -1, wRow + 1 );
      wCol = 0;
      while( wCol < pcx.wBytesByLine )
      {
         if( ( bByte = GetByte( wHandle ) ) > 0xC0 )
         {
            wCol += ( bByte - 0xC0 );
            GetByte( wHandle );
         }
         else
            wCol++;
      }
   }
}

//----------------------------------------------------------------------------//

static void PcxLineDisplay( WORD wRow, WORD wCol, WORD wHandle, WORD wBytesLine )
{
   BYTE * pVideo = MK_FP( 0xA000, 0 );
   WORD w = 0, wCount;
   BYTE bByte;
   WORD wLine = 0;

   _tread( wHandle, bBuffer, wBytesLine * 2 );

   // while( ! ( inport( 0x3BA ) & 128 ) );

   while( w < wBytesLine )
   {
      if( ( bByte = bBuffer[ wLine++ ] ) > 0xC0 )
      {
         wCount = bByte - 0xC0;
         bByte  = bBuffer[ wLine++ ];
         while( wCount-- )
         {
            if( w >= wCol && w <= ( wCol + WIDTH ) )
               pVideo[ ( wRow * WIDTH ) + w - wCol ] = bByte;
            w++;
         }
      }
      else
      {
         if( w >= wCol && w <= ( wCol + WIDTH ) )
            pVideo[ ( wRow * WIDTH ) + w - wCol ] = bByte;
         w++;
      }
   }
}

//----------------------------------------------------------------------------//

static CLIPPER USE()
{
   WORD w;
   WORD wHandle;

   if( PCOUNT() )
   {
      if( wHandle = _topen( _parc( 1 ), 0 ) )
      {
         _storni( wHandle, SELF, nHANDLE );

         _tlseek( wHandle, -768, 2 );
         _tread( wHandle, bBuffer, 768 );
         _storclen( bBuffer, 768, SELF, cPALETTE );

         _tlseek( wHandle, 0, 0 );
         _tread( wHandle, &pcx, sizeof( PCX ) );

         _storc( _parc( 1 ),   SELF, cFILENAME );
         _storni( pcx.wTop,    SELF, nTOP );
         _storni( pcx.wLeft,   SELF, nLEFT );
         _storni( pcx.wBottom, SELF, nBOTTOM );
         _storni( pcx.wRight,  SELF, nRIGHT );
         _storni( 0,           SELF, nROWPOS );
         _storni( 0,           SELF, nCOLPOS );
         _storni( pcx.wBytesByLine, SELF, nBYTESLINE );

         _reta( pcx.wBottom - pcx.wTop + 1 );
         PcxProcess( wHandle );
         _cAtPut( _lbase + 1, aLINES, _eval );

      }
      _bcopy( _eval, _lbase + 1, sizeof( CLIPVAR ) );
   }
}

//----------------------------------------------------------------------------//

static CLIPPER DISPLAY( void )
{
   WORD w, wRow    = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );

   _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

   for( w = wRow; w < wRow + 200; w++ )
   {
      _tlseek( wHandle, _parnl( -1, w + 1 ), FS_BEGINNING );
      PcxLineDisplay( w, wCol, wHandle, wBytesLine );
   }
}

//----------------------------------------------------------------------------//

static CLIPPER GOUP()
{
   WORD wRow       = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );

   _bcopy( MK_FP( 0xA000, 320 ), MK_FP( 0xA000, 0 ), 320 * 199 );

   _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );
   PcxLineDisplay( 1, wCol, wHandle, wBytesLine );

   _storni( wRow - 1, SELF, nROWPOS );
   _ret();
}

//----------------------------------------------------------------------------//

static CLIPPER GODOWN()
{
   WORD wRow       = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );

   _bcopy( MK_FP( 0xA000, 0 ), MK_FP( 0xA000, 320 ), 320 * 199 );

   _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );
   _tlseek( wHandle, _parnl( -1, wRow + 200 ), FS_BEGINNING );
   PcxLineDisplay( 199, wCol, wHandle, wBytesLine );

   _storni( wRow + 1, SELF, nROWPOS );
   _ret();
}

//----------------------------------------------------------------------------//

static CLIPPER GOLEFT( void )
{
   WORD w, wRow    = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );

   if( wCol > 20 )
   {
      wCol -= 20;
      _storni( wCol, SELF, nCOLPOS );
      _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

      for( w = wRow; w < wRow + 200; w++ )
      {
         _tlseek( wHandle, _parnl( -1, w + 1 ), FS_BEGINNING );
         PcxLineDisplay( w, wCol, wHandle, wBytesLine );
      }
   }
}

//----------------------------------------------------------------------------//

static CLIPPER GORIGHT( void )
{
   WORD w, wRow    = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );

   if( wCol < wBytesLine - WIDTH )
   {
      wCol += 20;
      _storni( wCol, SELF, nCOLPOS );
      _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

      for( w = wRow; w < wRow + 200; w++ )
      {
         _tlseek( wHandle, _parnl( -1, w + 1 ), FS_BEGINNING );
         PcxLineDisplay( w, wCol, wHandle, wBytesLine );
      }
   }
}

//----------------------------------------------------------------------------//

static CLIPPER PAGEUP()
{
   int iRow        = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wBottom    = _parni( SELF, nBOTTOM );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );
   WORD w;

   iRow -= 200;
   if( iRow < 0 )
      iRow = 0;

   _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

   for( w = 0; w < 200; w++ )
   {
      _tlseek( wHandle, _parnl( -1, iRow + w + 1 ), FS_BEGINNING );
      PcxLineDisplay( w, wCol, wHandle, wBytesLine );
   }

   _storni( iRow, SELF, nROWPOS );
   _ret();
}

//----------------------------------------------------------------------------//

static CLIPPER PAGEDOWN()
{
   WORD wRow       = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wBottom    = _parni( SELF, nBOTTOM );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );
   WORD w;

   wRow += 200;
   if(  wBottom - wRow < 200 )
      wRow = wBottom - 200;

   _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

   for( w = 0; w < 200; w++ )
   {
      _tlseek( wHandle, _parnl( -1, wRow + w + 1 ), FS_BEGINNING );
      PcxLineDisplay( w, wCol, wHandle, wBytesLine );
   }

   _storni( wRow, SELF, nROWPOS );
   _ret();
}

//----------------------------------------------------------------------------//

static CLIPPER GOTOP()
{
   WORD wRow       = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );
   WORD w;

   if( wRow > 0 )
   {
      _storni( 1, SELF, nROWPOS );
      _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

      for( w = 0; w < 200; w++ )
      {
         _tlseek( wHandle, _parnl( -1, 1 + w ), FS_BEGINNING );
         PcxLineDisplay( w, wCol, wHandle, wBytesLine );
      }
      _ret();
   }
}

//----------------------------------------------------------------------------//

static CLIPPER GOBOTTOM()
{
   WORD wTop       = _parni( SELF, nTOP );
   WORD wBottom    = _parni( SELF, nBOTTOM );
   WORD wHeight    = wBottom - wTop + 1;
   WORD wRow       = _parni( SELF, nROWPOS );
   WORD wCol       = _parni( SELF, nCOLPOS );
   WORD wHandle    = _parni( SELF, nHANDLE );
   WORD wBytesLine = _parni( SELF, nBYTESLINE );
   WORD w;

   if( wRow < wBottom - 199 )
   {
      _storni( wRow = ( wBottom - 199 ), SELF, nROWPOS );
      _cAt( _lbase + 1, aLINES, 0xFFFF, _eval );

      for( w = 0; w < 200; w++ )
      {
         _tlseek( wHandle, _parnl( -1, wRow + w ), FS_BEGINNING );
         PcxLineDisplay( w, wCol, wHandle, wBytesLine );
      }
      _ret();
   }
}

//----------------------------------------------------------------------------//

static CLIPPER SETTEXT()
{
   _AH = 0;
   _AL = 3;
   asm int 0x10;
}

//----------------------------------------------------------------------------//

static CLIPPER SETVGA()
{
   _AH = 0;
   _AL = 0x13;
   asm int 0x10;
}

//----------------------------------------------------------------------------//

static CLIPPER MOUSEON()
{
   _AX = 1;
   asm int 0x33;
}

//----------------------------------------------------------------------------//

static CLIPPER MOUSEOFF()
{
   _AX = 2;
   asm int 0x33;
}

//----------------------------------------------------------------------------//

CLIPPER TPcxFile()
{
   static LONG lHandle;

   if( ! lHandle )
   {
      lHandle = _mdCreate( 37, _Get_Sym( "TPCXFILE" ) );
      INSTVAR( "aLines",     LINES );
      INSTVAR( "cFileName",  FILENAME );
      INSTVAR( "cPalette",   PALETTE );
      INSTVAR( "nHandle",    HANDLE );
      INSTVAR( "nBytesLine", BYTESLINE );
      INSTVAR( "nTop",       TOP );
      INSTVAR( "nLeft",      LEFT );
      INSTVAR( "nBottom",    BOTTOM );
      INSTVAR( "nRight",     RIGHT );
      INSTVAR( "nRowPos",    ROWPOS );
      INSTVAR( "nColPos",    COLPOS );

      METHOD( "Use",         USE );
      METHOD( "Display",     DISPLAY );
      METHOD( "SetPalette",  SETPALETTE );
      METHOD( "GoUp",        GOUP );
      METHOD( "GoDown",      GODOWN );
      METHOD( "GoLeft",      GOLEFT );
      METHOD( "GoRight",     GORIGHT );
      METHOD( "PageUp",      PAGEUP );
      METHOD( "PageDown",    PAGEDOWN );
      METHOD( "GoTop",       GOTOP );
      METHOD( "GoBottom",    GOBOTTOM );
      METHOD( "SetVGA",      SETVGA );
      METHOD( "SetText",     SETTEXT );
      METHOD( "MouseOn",     MOUSEON );
      METHOD( "MouseOff",    MOUSEOFF );
   }
   _reta( nCOLPOS );
   _VSetDict( _eval, lHandle );
}

//----------------------------------------------------------------------------//
