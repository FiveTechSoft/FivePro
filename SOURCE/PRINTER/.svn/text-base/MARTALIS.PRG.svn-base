#include "Sde501.ch"

static nLine
static nLines   := 72
static acHeader
static acFooter
static abHeader
static nPage
static nFooter
static nHeader
static lPage
static lDate


//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function SetListLines( nNewLines )

   nLines = nNewLines

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListBegin( acHead, acFoot, abHead, lDates, lPages )

   acHeader   = acHead
   acFooter   = acFoot
   abHeader   = abHead
   nLine      = 1
   nPage      = 1
   lPage      = lPages
   lDate      = lDates

   DEFAULT acHeader := {}, acFooter := {}, lPage := .f., lDate := .f.

   SET ALTERNATE TO ( cPrnFile() )
   SET ALTERNATE ON
   SET CONSOLE OFF

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListLine( cLine )

   local n
   local nWidth := 0
   local nFoot  := 4
   local nHead  := 3
   local cPage  := "P쟥: " + AllTrim( Str( nPage ) )
   local cDate  := "Fecha: " + DtoC( Date() )
   local nBlock
   local nLenBlock
   local aTemp  := AClone( acHeader )

   nFooter = nFoot
   nHeader = nHead

   DEFAULT cLine := ""

   if nLine == 1

      for n = 1 to nHeader - If( nPage == 1, 1, 0 )
         if n = 2  .and. lPage
            ? PadL( cPage, 132 )
         else
            ?
         endif
         nLine++
      next

      if nPage == 1
         nLine++
      endif


      for n = 1 to Len( aTemp )

         do while At( "{", aTemp[ n ] ) # 0

            nLenBlock = At( "}", aTemp[ n ] ) - ;
                        At( "{", aTemp[ n ] ) - 1
            nBlock = Val( SubStr( aTemp[ n ], At( "{", aTemp[ n ] ) + 1, ;
                                  nLenBlock ) )
            aTemp[ n ] = StrTran( aTemp[ n ], ;
                            "{" + Alltrim( Str( nBlock ) ) + "}",;
                            cValToChar( Eval( abHeader[ nBlock ] ) )  + ;
                            " " )
         enddo

         if Len( aTemp[ n ] ) > nWidth
            nWidth = Len( aTemp[ n ] )
         endif
         ? aTemp[ n ]
         nLine++

      next

      ? Replicate( "=", nWidth )
      nLine++

      ?
      nLine++
      nPage++

   endif

   ? cLine
   nLine++

   if nLine > nLines - nFooter - Len( acFooter )

      for  n = 1 to Len( acFooter )
         ? acFooter[ n ]
      next
      for n = 1 to nFooter
         ?
      next
      nLine = 1

   endif

return


//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListEnd()

   acHeader = nil
   SET ALTERNATE OFF
   SET ALTERNATE TO
   SET CONSOLE ON

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//

function ListNextPage()

   local n 

   for n = 1 to nLines - nLine - Len( acFooter ) - nFooter
      ?
   next
   for  n = 1 to Len( acFooter )
      ? acFooter[ n ]
      nLine++
   next
   for n = 1 to nFooter
      ?
   next
   nLine = 1

return

//컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴//
