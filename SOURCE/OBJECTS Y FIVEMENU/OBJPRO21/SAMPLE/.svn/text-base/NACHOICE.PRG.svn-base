/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: nAchoice.prg                                          บ
บ Lenguaje: Clipper 5.0x + ObjectsP                             บ
บ Fecha: Marzo  1993                                            บ
บ Compilar: Clipper nAchoice /a /n /w                           บ
บ Desc.:Demo/Test de la clase TBArray                           บ
บ                                                               บ
บ   Como hacerse un achoice multiple en ญ solo 50 lineas !      บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

#include "inkey.ch"
#include "ObjectsP.ch"

// Hace un achoice de un array de arrays: Un array por columna.

Function anAchoice( aaToChoice, aHeadings, nRow, nCol )

   local lSel       := .f.
   local nCrsOld    := SetCursor( 0 )
   local nKey, cScrOld, oBrw

   DEFAULT    nRow = 5, nCol = 5

   cScrOld = SaveScreen( nRow, nCol, nRow + 15, nCol + 44 )
   oBrw    = TBArray():New( nRow + 1, nCol + 1, nRow + 14, nCol + 43 )

   for nKey = 1 to max( len( aaToChoice ), len( aHeadings ) )
       oBrw:AddColumn( aHeadings[ nKey ], aaToChoice[ nKey ] )
       oBrw:GetColumn( nKey ):width = len( aHeadings[ nKey ] )
   next

   @ nRow, nCol TO nRow + 15, nCol + 44

   while .T.

      oBrw:SetStable()

      nKey = InKey( 0 )

      if oBrw:lKeyEval( nKey )
         // n  de n 

      elseif nKey == K_ESC 
            EXIT

      elseif nKey == K_ENTER
            lSel = .t.
            EXIT
      endif
      

   end

   RestScreen( nRow, nCol, nRow + 15, nCol + 44, cScrOld )
   SetCursor( nCrsOld )

   nKey = oBrw:nIndex

Return { oBrw:colPos, if( lSel, if( nKey > len( aaToChoice[ oBrw:colPos ] ), 0, nKey ), 0 ) }
