#include "FivePro.ch"

static aMenus := {}

//----------------------------------------------------------------------------//

function MenuBegin( nRow, nMsgRow, nMsgCol, aColors )

   local oLastMenu, oMenu

   DEFAULT nRow := 0, nMsgRow := MaxRow(), nMsgCol := 0

   if ( oLastMenu := ATail( aMenus ) ) == nil
      oMenu := TMenuBar():New( nRow, nMsgRow, nMsgCol, aColors )
   else
      if aColors == nil
         aColors = aMenus[ 1 ]:aClrItems
      end
      oMenu := TMenuBox():New( ,,,, aColors )
      ATail( oLastMenu:aItems ):SetMenu( oMenu )
   endif

   AAdd( aMenus, oMenu )

return oMenu

//----------------------------------------------------------------------------//

function MnuItem( nRow, nCol, cItem, cMsg, bAction, lDisable, lChecked,;
                  aColors, nShortCut )

   local oMenuItem

   DEFAULT cItem := "", cMsg := "", lDisable := .f., lChecked := .f.

   oMenuItem := TMenuItem():New( 0, 0, cItem, cMsg, bAction, ! lDisable,;
                                       lChecked, nShortCut )
   ATail( aMenus ):Add( oMenuItem )

   if nRow != nil
      oMenuItem:nRow = nRow
   endif
   if nCol != nil
      oMenuItem:nCol = nCol
   endif
   if aColors != nil
      oMenuItem:aColors = aColors
   endif

return oMenuItem

//----------------------------------------------------------------------------//

function MenuEnd()

   local aMenu := ATail( aMenus )

   if aMenu:ClassName() == "TMENUBOX"
      aMenu:Adjust()
   endif

   aMenus = ASize( aMenus, Len( aMenus ) - 1 )
   if Len( aMenus ) != 0
      ATail( ATail( aMenus ):aItems ):xAction = aMenu
   endif

return

//----------------------------------------------------------------------------//
