#include <ClipApi.h>
#include "dos.h"

//----------------------------------------------------------------------------//

static struct REGPACK reg = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

//----------------------------------------------------------------------------//

CLIPPER SysInt()                           // Servicio de interrupciones //
{
  if( PCOUNT() != 0 )
    intr( ( unsigned char ) _parni( 1 ), &reg );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegAx()
{
  if( PCOUNT() != 0 )
    reg.r_ax = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_ax );             // para evitar el problema del signo //
  _ret();                       // Clipper toma los UNSIGNED INT c¢mo SIGNED //
}

//----------------------------------------------------------------------------//

CLIPPER nRegBx()
{
  if( PCOUNT() != 0 )
    reg.r_bx = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_bx );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegCx()
{
  if( PCOUNT() != 0 )
    reg.r_cx = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_cx );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegDx()
{
  if( PCOUNT() != 0 )
    reg.r_dx = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_dx );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegBp()
{
  if( PCOUNT() != 0 )
    reg.r_bp = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_bp );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegSi()
{
  if( PCOUNT() != 0 )
    reg.r_si = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_si );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegDi()
{
  if( PCOUNT() != 0 )
    reg.r_di = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_di );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegDs()
{
  if( PCOUNT() != 0 )
    reg.r_ds = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_ds );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegEs()
{
  if( PCOUNT() != 0 )
    reg.r_es = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_es );
  _ret();
}

//----------------------------------------------------------------------------//

CLIPPER nRegFlags()
{
  if( PCOUNT() != 0 )
    reg.r_flags = ( unsigned int ) _parni( 1 );
  else
    _retnl( reg.r_flags );
  _ret();
}

//----------------------------------------------------------------------------//
