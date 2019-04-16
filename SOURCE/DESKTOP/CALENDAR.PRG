#include "FivePro.ch"

static cTxtFind

//----------------------------------------------------------------------------//

function Calendar( dDate )

   local dBoM, dStart
   local nWeek, nDay
   local oWnd

   DEFAULT cTxtFind := Space( 30 )
   DEFAULT dDate    := Date()

   dBoM   = dDate - Day( dDate ) + 1
   dStart = If( DoW( dBoM ) != 1, dBoM - DoW( dBoM ) + 2, dBoM - 6 )

   DEFINE WINDOW oWnd SIZE 60, 14 TITLE "Calendario / Agenda"

   @ 2, 2 SAY PadC( cMes( Month( Date() ) ) + ;
     " " + Str( Year( Date() ), 4 ), 27 ) COLOR "GR+/B" OF oWnd
   @ 4, 2 SAY "Lun Mar Mie Jue Vie Sab Dom" COLOR "GR+/B" OF oWnd

   @ 11,  2 BUTTON " Mes &- " OF oWnd
   @ 11, 12 BUTTON " Mes &+ " OF oWnd
   @ 11, 22 BUTTON " &Ir a  " OF oWnd ;
     ACTION If( lMsgGet( "Ir a", "Fecha:", @dDate ), 1, 0 )
   @ 11, 32 BUTTON " &Buscar " OF oWnd ;
     ACTION ( If( lMsgGet( "Buscar en Notas", "Texto:", @cTxtFind ), 1, 0 ),;
              cTxtFind := PadR( cTxtFind, 30 ) )
   @ 11, 43 BUTTON " &Anotaci¢n " OF oWnd

   ACTIVATE WINDOW oWnd

return

//----------------------------------------------------------------------------//

static function DispDays( oWnd )

   local nWeek, nDay

   for nWeek = 1 to 6
       for nDay = 1 to 7
           @ oWnd:nTop + 4 + nWeek,;
             oWnd:nLeft + ( ( nDay - 1 ) * 4 ) + 2 SAY Day( dStart ) ;
             COLOR If( Month( dStart ) == Month( dDate ),;
                   If( dStart == Date(), "R+/B", "W+/B" ), "BG/B" )
             dStart++
       next
   next

return

//----------------------------------------------------------------------------//

function cMes( nMes )

return { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",;
         "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" }[ nMes ]

//----------------------------------------------------------------------------//
