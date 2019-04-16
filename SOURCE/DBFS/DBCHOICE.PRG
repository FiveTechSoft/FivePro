#include "Sde501.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

function nDbChoice( cTitle, cLabel, bColumn )

   local oWnd    := TWindow():NewCentered( 14,;
                    Min( nValLen( Eval( bColumn ) ) + 16, MaxCol() - 5 ),;
                    cTitle, cClrVentanas() )
   local GetList := {}
   local nAction := 0
   local brwDbf  := TBrowseDb()
   local nCrsOld

   brwDbf:AddColumn( TbColumnNew( "", bColumn ) )
   brwDbf:ColorSpec = cClrVentanas()

   ACTIVATE WINDOW oWnd

   @ oWnd:nTop +  2, oWnd:nLeft + 2 BROWSE brwDbf SIZE 12, 31 LABEL cLabel
   @ oWnd:nTop +  3, oWnd:nRight - 13 BUTTON "    &Ok     " ACTION ( nAction := 1, __KeyBoard( Chr( K_ESC ) ) )
   @ oWnd:nTop +  5, oWnd:nRight - 13 BUTTON " &Cancelar  " ACTION ( nAction := 2, __KeyBoard( Chr( K_ESC ) ) )
   @ oWnd:nTop +  8, oWnd:nRight - 13 BUTTON "  &A¤adir   " ACTION ( nAction := 3, __KeyBoard( Chr( K_ESC ) ) )
   @ oWnd:nTop + 10, oWnd:nRight - 13 BUTTON " &Modificar " ACTION ( nAction := 4, __KeyBoard( Chr( K_ESC ) ) )
   @ oWnd:nTop + 12, oWnd:nRight - 13 BUTTON " &Eliminar  " ACTION ( nAction := 5, __KeyBoard( Chr( K_ESC ) ) )
   nCrsOld = SetCursor( 1 )
   READ
   SetCursor( nCrsOld )

   DEACTIVATE WINDOW oWnd

return nAction

//----------------------------------------------------------------------------//
