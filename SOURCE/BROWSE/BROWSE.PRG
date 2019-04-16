#include "FivePro.ch"

static oBrowse

//----------------------------------------------------------------------------//

function oBrwBegin( nTop, nLeft, nBottom, nRight, cColors, cHeadSep,;
                    cSeparator, cField, uValue1, uValue2, bSelect )

   DEFAULT cHeadSep := "Ä"

   oBrowse = TBrowseDB( nTop, nLeft, nBottom, nRight )

   oBrowse:ColorSpec = cColors
   oBrowse:HeadSep   = cHeadSep

return oBrowse

//----------------------------------------------------------------------------//

function oBrwColumn( bData, cTitle, cFooter, aColors, bColorExpr, cFootSep,;
                     nWidth )

   local oCol := TbColumnNew( cTitle, bData )

   oCol:HeadSep = "Ä"

   if nWidth != nil
      oCol:nWidth = nWidth
   endif

   oBrowse:AddColumn( oCol )

return oCol

//----------------------------------------------------------------------------//

function BrwDisplay( oBrowse )

   local n

   MOff()
   oBrowse:DeHilite()
   oBrowse:ForceStable()

   oBrowse:ColPos = 1
   for n = 1 to oBrowse:ColCount
      oBrowse:ColPos = n
      oBrowse:Hilite()
   next

   MOn()
   oBrowse:ColPos = 1

return

//----------------------------------------------------------------------------//

function BrwHide( oBrowse )

   local n

   MOff()
   oBrowse:ColPos = 1
   for n = 1 to oBrowse:ColCount
      oBrowse:ColPos = n
      oBrowse:DeHilite()
   next
   MOn()

   oBrowse:ColPos = 1

return

//----------------------------------------------------------------------------//

function BrwClick( oBrowse, nRow, nCol, oScrBar )

   local nAt
   local nHead := If( oBrowse:HeadSep != nil, 1, 0 )

   DO
      nAt = nRow - oBrowse:nTop - nHead

      do case
         case nAt < 1
              if ! oBrowse:HitTop
                 BrwHide( oBrowse )
                 oBrowse:Up()
                 BrwDisplay( oBrowse )
                 if oScrBar:nValue > 1
                    oScrBar:nValue--
                    oScrBar:Display()
                 endif
              endif

         case nAt > oBrowse:nBottom - oBrowse:nTop - 1
              if ! oBrowse:HitBottom
                 BrwHide( oBrowse )
                 oBrowse:Down()
                 BrwDisplay( oBrowse )
                 if ! oBrowse:HitBottom
                    if oScrBar:nValue < oScrBar:nRange
                       oScrBar:nValue++
                       oScrBar:Display()
                    endif
								 endif
              endif

         otherwise
              if nAt != oBrowse:RowPos
                 if oScrBar:nValue + nAt - oBrowse:RowPos - 1 <= oScrBar:nRange
                    oScrBar:nValue = oScrBar:nValue + nAt - oBrowse:RowPos
                    oScrBar:Display()
                    BrwHide( oBrowse )
                    oBrowse:RowPos = nAt
                    BrwDisplay( oBrowse )
                 endif
              endif
      endcase

      MUpdate()
      nRow = nMRow()

   UNTIL ! lMPressed()

return

//----------------------------------------------------------------------------//

function lBrwIsOver( oBrowse, nRow, nCol )

return nRow >= oBrowse:nTop .and. nRow <= oBrowse:nBottom .and. ;
       nCol >= oBrowse:nLeft .and. nCol <= oBrowse:nRight

//----------------------------------------------------------------------------//
