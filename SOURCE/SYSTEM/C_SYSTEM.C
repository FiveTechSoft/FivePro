// Modulo de FivePro 1.0 pasado a modo protegido

#include "c:\blinker\c\blx286.h"
#include <extend.h>

//----------------------------------------------------------------------------//

static REGS16 regs;

//----------------------------------------------------------------------------//

CLIPPER _Int()                           // Servicio de interrupciones //
{
  if( PCOUNT != 0 )
    DosRealIntr( _parni( 1 ), &regs, 0, 0 );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Ax()
{
  if( PCOUNT != 0 )
    regs.ax = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.ax );           // para evitar el problema del signo //
  _ret();                       // Clipper toma los UNSIGNED INT c¢mo SIGNED //
}

//----------------------------------------------------------------------------//

CLIPPER Set_Bx()
{
  if( PCOUNT != 0 )
    regs.bx = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.bx );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Cx()
{
  if( PCOUNT != 0 )
    regs.cx = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.cx );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Dx()
{
  if( PCOUNT != 0 )
    regs.dx = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.dx );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Bp()
{
  if( PCOUNT != 0 )
    regs.bp = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.bp );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Si()
{
  if( PCOUNT != 0 )
    regs.si = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.si );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Di()
{
  if( PCOUNT != 0 )
    regs.di = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.di );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Ds()
{
  if( PCOUNT != 0 )
    regs.ds = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.ds );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Es()
{
  if( PCOUNT != 0 )
    regs.es = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.es );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER Set_Flags()
{
  if( PCOUNT != 0 )
    regs.flags = ( unsigned int ) _parni( 1 );
  else
    _retnl( regs.flags );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER PeekByte()
{
   USHORT wSel;

   DosMapRealSeg( _parni( 1 ), 0xFFFF, &wSel );

   _retni( ( BYTE ) * ( ( PCHAR ) MK_FP( wSel, 0 ) + _parni( 2 ) ) );

   DosFreeSeg( wSel );
}

//----------------------------------------------------------------------------//

CLIPPER PeekWord()
{
   USHORT wSel;

   DosMapRealSeg( _parni( 1 ), 0xFFFF, &wSel );

   _retnl( * ( USHORT * ) MK_FP( wSel, _parni( 2 ) ) );

   DosFreeSeg( wSel );
}

//----------------------------------------------------------------------------//

CLIPPER PokeByte()
{
   USHORT wSel;

   DosMapRealSeg( _parni( 1 ), 0xFFFF, &wSel );

   ( BYTE ) * ( ( PCHAR ) MK_FP( wSel, 0 ) + _parni( 2 ) ) = _parni( 3 );

   DosFreeSeg( wSel );
}

//----------------------------------------------------------------------------//

CLIPPER PokeWord()
{
   USHORT wSel;
   USHORT * pWord;

   DosMapRealSeg( _parni( 1 ), 0xFFFF, &wSel );

   pWord = ( USHORT * ) ( ( PCHAR ) MK_FP( wSel, 0 ) + _parni( 2 ) );

   * pWord = _parni( 3 );

   DosFreeSeg( wSel );
}

//----------------------------------------------------------------------------//
