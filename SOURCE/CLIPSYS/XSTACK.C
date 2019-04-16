#pragma inline

#include <ClipApi.h>

void _xPushL( PCLIPVAR );
void _xRetL( PCLIPVAR  );
void _cPush0( PCLIPSYMBOL SymBol, PCLIPVAR Self );
void _cPush1( PCLIPSYMBOL Symbol, PCLIPVAR Self, PCLIPVAR Param );
void _cPush2( PCLIPSYMBOL Symbol, PCLIPVAR Self, PCLIPVAR Param, PCLIPVAR Param2 );
void _cSend0( PCLIPSYMBOL Message, PCLIPVAR Self );
void _cSend1( PCLIPSYMBOL Message, PCLIPVAR Self, PCLIPVAR Param );
void _cSend2( PCLIPSYMBOL Message, PCLIPVAR Self, PCLIPVAR Param, PCLIPVAR Param2 );
void _cDo0( PCLIPSYMBOL FuncSym );
void _cDo1( PCLIPSYMBOL FuncSym, PCLIPVAR Param );
void _cDo2( PCLIPSYMBOL FuncSym, PCLIPVAR Param, PCLIPVAR Param2 );

void _cEval2( PCLIPVAR Block, PCLIPVAR Param, PCLIPVAR Param2 );


//---------------------------------------------------------------------------//

void _xPushL( PCLIPVAR pItem )
{
     _DI = (WORD)(++_tos);
     _SI = (WORD)( pItem );
     _CX = 7;
     asm cld;
     asm push ds;
     asm pop  es;
     asm repnz movsw;
}

//---------------------------------------------------------------------------//

void _xRetL( PCLIPVAR pItem )
{
     _DI = (WORD)( _eval );
     _SI = (WORD)( pItem );
     _CX = 7;
     asm cld;
     asm push ds;
     asm pop  es;
     asm repnz movsw;
}

//---------------------------------------------------------------------------//

void _cPush0( PCLIPSYMBOL Symbol, PCLIPVAR Self )
{
     _PutSym( Symbol );
     if( Self )
        _xPushL( Self );
     else
        ( ++_tos )->wType = 0;
}

//---------------------------------------------------------------------------//

void _cPush1( PCLIPSYMBOL Symbol, PCLIPVAR Self, PCLIPVAR Param1 )
{
     _cPush0( Symbol, Self );
     _xPushL( Param1 );
}

//---------------------------------------------------------------------------//

void _cPush2( PCLIPSYMBOL Symbol, PCLIPVAR Self, PCLIPVAR Param1, PCLIPVAR Param2)
{
     _cPush0( Symbol, Self );
     _xPushL( Param1 );
     _xPushL( Param2 );
}

//---------------------------------------------------------------------------//

void _cSend0( PCLIPSYMBOL Message, PCLIPVAR Self )
{
    _cPush0( Message, Self );
    _xSend( 0 );
}

//---------------------------------------------------------------------------//

void _cSend1( PCLIPSYMBOL Message, PCLIPVAR Self, PCLIPVAR Param )
{
    _cPush1( Message, Self, Param );
    _xSend( 1 );
}

//---------------------------------------------------------------------------//

void _cSend2( PCLIPSYMBOL Message, PCLIPVAR Self, PCLIPVAR Param, PCLIPVAR Param2 )
{
    _cPush2( Message, Self, Param, Param2 );
    _xSend( 2 );
}

//---------------------------------------------------------------------------//

void _cDo0( PCLIPSYMBOL FuncSym )
{
    _cPush0( FuncSym, 0 );
    _xDo( 0 );
}

//---------------------------------------------------------------------------//

void _cDo1( PCLIPSYMBOL FuncSym, PCLIPVAR Param )
{
    _cPush1( FuncSym, 0, Param );
    _xDo( 1 );
}

//---------------------------------------------------------------------------//

void _cDo2( PCLIPSYMBOL FuncSym, PCLIPVAR Param, PCLIPVAR Param2 )
{
    _cPush2( FuncSym, 0, Param, Param2 );
    _xDo( 2 );
}

//---------------------------------------------------------------------------//

//       En el m¢dulo stack ya hay dos funciones de estas. Son :
//           _cEval0( PCLIPVAR Block );
//           _cEval1( PCLIPVAR Block, PCLIPVAR Param );
//           la que falta...

void _cEval2( PCLIPVAR Block, PCLIPVAR Param, PCLIPVAR Param2 )
{
    _cPush2( _SymEval, Block, Param, Param2 );
    _xEval( 2 );
}

//---------------------------------------------------------------------------//
