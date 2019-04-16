// ----------------------------------------------------------------------------

#define AUTHOR  1
#define SINTAX  2
#define QUICK   3
#define PARAMS  4
#define RETURN  5
#define DESC    6
#define SEEALSO 7

#define MARGIN  5

// ----------------------------------------------------------------------------

function Main()

   CLS
   SET ALTERNATE TO TEST.NGT
   SET ALTERNATE ON
   SET CONSOLE OFF

   TxtEval( "Text.c", { | cLine, nLine | Process( cLine, nLine ) } )

   SET CONSOLE ON
   SET ALTERNATE OFF
   CLS

   RUN C:\UTIL\GUIAS\NGC  TEST.NGT
   RUN C:\UTIL\GUIAS\NGML TEST.MNU

return

// ----------------------------------------------------------------------------

function Process( cLine, nLine )

   local aSections := { "SINTAX$", "PARAMS$", "RETURN$", "EXAMPLE$", "SEEALSO$" }
   static aData    := { {}, {}, {}, {}, {} }
   static nSection := 0, n := 0

   @ 10, 20 SAY nLine PICTURE "Processing line: 9,999"

   if Left( LTrim( cLine ), 2 ) == "//"
      if ( n := AScan( aSections, { | cSection | At( cSection, cLine ) > 0 } ) ) != 0
         if n != nSection
            nSection = n
         endif
         AAdd( aData[ nSection ], SubStr( cLine, At( "$", cLine ) + 1 ) )
      endif
   else
      if nSection > 0
         BuildNg( aData )
         aData := { {}, {}, {}, {}, {} }
         nSection = 0
      end
   end

return

// ----------------------------------------------------------------------------

function BuildNg( aData )

   local aLiteral := { "   ^BSintax^N",;
                       "   ^BParameters^N",;
                       "TRES",;
                       "CUATRO",;
                       "!SeeAlso:" }

   for n = 1 to Len( aLiteral )
       if Len( aData[ n ] ) > 0
          ? aLiteral[ n ]
          ?
          AEval( aData[ n ],;
                 { | cText | QOut( Space( MARGIN ) + AllTrim( cText ) ) } )
       end
       ?
       ?
   end

return

// ----------------------------------------------------------------------------
