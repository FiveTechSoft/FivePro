#include "Sde501.ch"

//----------------------------------------------------------------------------//

function nMsgBox( cText, cTitle, cOptions )

   local n, nCol, nLenOptions := 0, acTxtLines
   local acOptions
   local nWidth  := 15
   local nTop    := ( MaxRow() / 2 ) - 3
   local nLeft   := ( MaxCol() / 2 )
   local nBottom := nTop + 2
   local nRight  := nLeft + nWidth
   local GetList := {}
   local oWnd
   local nOption := 0
   local nCrsOld := SetCursor( 0 )

   DEFAULT cOptions := " &Aceptar "

   acOptions := aStr2Array( cOptions, ";" )

   acTxtLines = aStr2Array( cText, ";" )
   AEval( acTxtLines, { | cLine | nWidth := Max( nWidth, Len( cLine ) + 3 ) } )
   AEval( acOptions, { | cOption | nLenOptions += Len( cOption ) + 2 } )
   nLenOptions -= 2
   nWidth     = Max( nWidth, nLenOptions + 4 )
   nTop       = Min( nTop, ( MaxRow() / 2 ) - ( Len( acTxtLines ) / 2 ) - 3 )
   nBottom    = Max( nBottom, nTop + Len( acTxtLines ) + 5 )
   nLeft      = Min( nLeft, ( MaxCol() / 2 ) - ( nWidth / 2 ) )
   nRight     = Max( nRight, nLeft + nWidth )

   DEFINE WINDOW oWnd FROM nTop, nLeft TO nBottom, nRight ;
      TITLE cTitle COLOR "W+/B, N*/W"

   ACTIVATE WINDOW oWnd

   for n = 1 to Len( acTxtLines )
       @ nTop + n + 1, ( MaxCol() / 2 ) - ( Len( acTxtLines[ n ] ) / 2 ) + 0.5;
         SAY acTxtLines[ n ] COLOR cClrMensajes()
   next

   nCol = ( MaxCol() / 2 ) + 1 - ( nLenOptions / 2 )
   for n = 1 to Len( acOptions )
       @ -2 + oWnd:nBottom, nCol + 0 BUTTON acOptions[ n ] ;
         ACTION ( nOption := AScan( GetList, { | oGet | oGet:HasFocus } ),;
                  __KeyBoard( Chr( 27 ) ) )
       nCol += Len( acOptions[ n ] ) + 2
   next
   READ

   DEACTIVATE WINDOW oWnd

return nOption

//----------------------------------------------------------------------------//
