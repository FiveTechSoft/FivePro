#include <ClipApi.h>
#include <dos.h>

void MouseUpdate( void );
BOOL bMousePressed( void );
BYTE bMouseRow( void );
BYTE bMouseCol( void );

void _Inkey0( void );

CLIPPER SetKey( void );

LONG lnTicks( void );
static LONG near lnInkey( void );

static PCLIPSYMBOL SetKeySym = 0;

static BOOL bIdle = FALSE;

//---------------------------------------------------------------------------//

static void near Link()
{
    SetKey();
}

//---------------------------------------------------------------------------//

LONG lnTicks()
{
   /* catpurar contador de ticts. ( BYTE bajo DX, alto en CX)
   */
   asm {
        mov ah, 00h
        int 1Ah
        mov ax, dx
        mov dx, cx
       }

   return (LONG) MK_FP( _DX, _AX );

}

//---------------------------------------------------------------------------//

/********
*
*   Lo equivalente a Inkey().   (  sin parametros ).
*/
static LONG near lnInkey()
{
   _Inkey0();
   return (LONG) ( _tos-- )->pPointer1;
}

//---------------------------------------------------------------------------//

CLIPPER nMKeyWait() // ( nSeconds, bAction )
{
   LONG   lStart    = lnTicks();
   LONG   lKeyCode  = 0;
   LONG   lTicks    = (LONG) ( ( _parni( 1 ) * 182 ) / 10 );
   BYTE   bMRow, bMCol;
   PCLIPVAR bAction = _param( 2, BLOCK );

   MouseUpdate();
   bMRow = bMouseRow();
   bMCol = bMouseCol();

   bIdle = TRUE;

   while( lKeyCode == 0 && !bMousePressed() && bIdle &&
          ( lTicks == 0 || ( lnTicks() - lStart ) < lTicks ) )
   {
      
      lKeyCode = lnInkey();

      MouseUpdate();

      if( !( bIdle = ( bMRow == bMouseRow() && bMCol == bMouseCol() ) ) )
      {
          bMRow      = bMouseRow();
          bMCol      = bMouseCol();
      }

      if( lKeyCode > 0 )
      {
          if( !SetKeySym )
          {
              SetKeySym = _Get_Sym( "SetKey" );

              // para forzar el lincado de setkey()
              if( !SetKeySym )
                   SetKey();
          }

          // SetKey( lKeyCode ) -> codeblock de setkey( lastKey() )
          _PutSym( SetKeySym );
          ( ++_tos )->wType = 0;
          _PutLN( lKeyCode );
          _xDo( 1 );

          if( _eval->wType & BLOCK ) // es un codeblock
          {
              lKeyCode = 0;
              _cEval0( _eval );
          }
      }

      if( bAction && lKeyCode == 0)
         _cEval0( bAction );

   }

   if( bAction && lKeyCode == 0 )
       _cEval0( bAction );

   _retnl( lKeyCode );

}

//---------------------------------------------------------------------------//

CLIPPER lIsIdle() { _retl( bIdle ); }

//---------------------------------------------------------------------------//
