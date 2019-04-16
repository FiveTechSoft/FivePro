#include "Sde501.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

function cBlock( cText, cTitle )

   local GetList   := {}
   local nAction   := 1
   local wnd
   local cFileName := If( cText == nil, "Notas.txt", nil )

   local cClrOld := SetColor( "W+/BG" )
   local nCrsOld := SetCursor( 0 )

   DEFAULT cText  := If( File( cFileName ), MemoRead( cFileName ), "" )
   DEFAULT cTitle := "Block de Notas"

   DEFINE WINDOW Wnd CENTERED SIZE 10, 52 TITLE cTitle COLOR cClrVentanas()
   ACTIVATE WINDOW wnd

   KEYBOARD Chr( 27 )

   ScrollBar( wnd:nTop + 2, wnd:nLeft + 38, wnd:nTop + 9, wnd:nLeft + 38,;
              MLCount( cText ), 1, "BG+/B" )

   @ wnd:nTop + 2, wnd:nLeft + 41 BUTTON " &Aceptar " ACTION ( nAction := 1, __KeyBoard( Chr( 27 ) ) )
   @ wnd:nTop + 4, wnd:nLeft + 41 BUTTON " &Editar  " ACTION ( nAction := 2, __KeyBoard( Chr( 27 ) ) )

   cText = MemoEdit( cText, wnd:nTop + 2, wnd:nLeft + 2, wnd:nTop + 9,;
                     wnd:nLeft + 37 )

   READ

   do case
      case nAction == 2
           SET CURSOR ON
           SetKey( 27, { || __KeyBoard( Chr( 23 ) ) } )
           cText = MemoEdit( cText, wnd:nTop + 2, wnd:nLeft + 2, wnd:nTop + 9,;
                             wnd:nLeft + 37, .t. )
           SET CURSOR OFF
           SetKey( 27, nil )
           if cFileName != nil
              MemoWrit( cFileName, cText )
           endif

   endcase

   SetColor( cClrOld )
   SetCursor( nCrsOld )

   DEACTIVATE WINDOW wnd

return cText

//----------------------------------------------------------------------------//
