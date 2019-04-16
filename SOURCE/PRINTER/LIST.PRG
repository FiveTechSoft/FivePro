#include "Sde501.ch"
#include "InKey.ch"

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

#define EN_IMPRESORA 1
#define EN_PANTALLA  2
#define EN_FICHERO   3

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

static lDirect       := .f.           // Antonio 18/03/93
static acHeader
static abHeader
static acFooter
static abFooter
static nLine
static nPage
static nLines	     := 66
static nLeftMargin	 := 0
static nBottomMargin := 0
static nTopMargin    := 0
static nRealFoot     := 0

static nTo           := 1
static nPrinter 	 := 1
static nCopies		 := 1
static cFileName     := ""
static lFirstLine    := TRUE

//----------------------------------------------------------------------------//

function SetPrnLines( nNewLines )

   nLines = nNewLines

return nLines

//----------------------------------------------------------------------------//

function SetListFooter( acNewFooter )

   acFooter  = acNewFooter
   nRealFoot = Len( acNewFooter )

return

//----------------------------------------------------------------------------//

function lPrintTo()

   local oWnd
   local nAction := 1

   DEFINE WINDOW oWnd CENTERED SIZE 12, 49 ;
      TITLE "Especificaciones de Impresi줻"
   ACTIVATE WINDOW oWnd

   if Empty( cFileName )
      cFileName = "Temp.lst          "
   endif

   @  2,  2 SAY "Impresora: " + cPrnPrinter() WINDOW oWnd

   @  4,  2 GET nTo ;
      RADIO { "Impresora", "Pantalla", "Fichero" } ;
      WINDOW oWnd ;
      LABEL "&Destino"
   @  4, 21 SAY "Fichero:" GET cFileName WINDOW oWnd WHEN nTo == 3
   @  6, 21 SAY "Copias: " GET nCopies WINDOW oWnd PICTURE "99" ;
      WHEN nTo == 1
   @  8, 21 GET lDirect CHECK "Impresi줻 Directa" ;
      WINDOW oWnd COLOR cClrVentanas() WHEN nTo == EN_IMPRESORA

   @ 10,   5 BUTTON OK              WINDOW oWnd
   @ 10,  18 BUTTON " &Cancelar "   WINDOW oWnd ACTION nAction := nBtnCancel()
   @ 10,  31 BUTTON " C&onfigurar " WINDOW oWnd ACTION ( GetPrn(),;
                            DevPos( oWnd:nTop + 2, oWnd:nLeft + 13 ),;
                            DevOut( cPrnPrinter() ),;
                            __KeyBoard( Chr( K_UP ) + Chr( K_UP ) ) )
   READ

   if LastKey() = K_ESC
      nAction = 0
   endif

   DEACTIVATE WINDOW oWnd

   cFileName = AllTrim( cFileName )

return nAction != 0

//----------------------------------------------------------------------------//

function lByPrinter()

return nTo == 1

//----------------------------------------------------------------------------//

function PrintDo()

   local n

   if ! lDirect
      do case
         case nTo == EN_IMPRESORA
          if ! lPrnLan() .and. lPrnSet()
             SetClock( 0 )
             SET CONSOLE OFF

             if lPrnLan()
                SET PRINTER TO LPT2
             else
                SET PRINTER TO LPT1
             endif

             for n = 1 to nCopies
                 TYPE ( cFileName ) TO PRINTER
             next
             SET CONSOLE ON
             SetClock( 1 )
          endif

         case nTo == EN_PANTALLA
          ListView( cFileName )

         case nTo == EN_FICHERO
      endcase
   endif

return

//----------------------------------------------------------------------------//

function ListBegin( acHead, acFoot, abHead, abFoot,;
                    nPrnLines, nPrnTop, nPrnBottom )

   DEFAULT acHead    := {}, acFoot   := {}
   DEFAULT nPrnLines := 66, nPrnTop  := 1, nPrnBottom := 3

   acHeader   = acHead
   acFooter   = acFoot
   abHeader   = abHead
   abFooter   = abFoot
   nLine      = 1
   nPage      = 1

   nRealFoot     = Len( acFoot )
   nLines        = nPrnLines
   nTopMargin    = nPrnTop
   nBottomMargin = nPrnBottom

   if ! lDirect
      SET CONSOLE OFF
      SET ALTERNATE TO ( cFileName )
      SET ALTERNATE ON
   else
      SET PRINTER ON
      SET CONSOLE OFF
   endif

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function listLine( cLine )

   local aHeadTemp := AClone( acHeader )
   local aFootTemp := AClone( acFooter )

   DEFAULT cLine := ""

   if nLine == 1
      ListHead( aHeadTemp )
      nPage++
   endif

   ? Space( nLeftMargin ) + cLine
   nLine++

   if nLine > nLines - nBottomMargin - nRealFoot
      ListFoot( aFootTemp )
      nLine = 1
   endif

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListEnd()

   acHeader = nil

   if ! lDirect
      SET ALTERNATE OFF
      SET ALTERNATE TO
      SET CONSOLE ON
   else
      SET PRINTER OFF
      SET CONSOLE ON
   endif

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListNextPage()

   local n
   local aFootTemp := AClone( acFooter )

   for n = 1 to nLines - nLine - nRealFoot - nBottomMargin + 1
      ?
   next
   ListFoot( aFootTemp )
   nLine = 1

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListHead( aHeadTemp )

   local nLenBlock
   local nBlock
   local n

   if nPage == 1
      nLine++
   endif

   for n = 1 to nTopMargin
      if lFirstLine
         ??
         lFirstLine = FALSE
      else
         ?
      endif
      nLine++
   next

   for n = 1 to Len( aHeadTemp )
	  do while At( "{", aHeadTemp[ n ] ) # 0

		 nLenBlock = At( "}", aHeadTemp[ n ] ) - ;
					 At( "{", aHeadTemp[ n ] ) - 1
		 nBlock = Val( SubStr( aHeadTemp[ n ], At( "{", aHeadTemp[ n ] ) + 1, ;
							   nLenBlock ) )
		 aHeadTemp[ n ] = StrTran( aHeadTemp[ n ], ;
						 "{" + Alltrim( Str( nBlock ) ) + "}",;
			 cValToChar( Eval( abHeader[ nBlock ] ) ) + ;
						 " " )
	  enddo
      if lFirstLine
         ?? Space( nLeftMargin ) + Trim( aHeadTemp[ n ] )
         lFirstLine = FALSE
      else
         ? Space( nLeftMargin ) + Trim( aHeadTemp[ n ] )
      endif
      nLine++
   next

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListFoot( aFootTemp )

   local nLenBlock
   local nBlock
   local n

   for n = 1 to Len( aFootTemp )
	  do while At( "{", aFootTemp[ n ] ) # 0

		 nLenBlock = At( "}", aFootTemp[ n ] ) - ;
					 At( "{", aFootTemp[ n ] ) - 1
		 nBlock = Val( SubStr( aFootTemp[ n ], At( "{", aFootTemp[ n ] ) + 1, ;
							   nLenBlock ) )
		 aFootTemp[ n ] = StrTran( aFootTemp[ n ], ;
						 "{" + Alltrim( Str( nBlock ) ) + "}",;
			 cValToChar( Eval( abFooter[ nBlock ] ) ) + ;
						 " " )
	  enddo
      ? Space( nLeftMargin ) + Trim ( aFootTemp[ n ] )

   next
   for n = 1 to nBottomMargin
	  ?
   next

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
