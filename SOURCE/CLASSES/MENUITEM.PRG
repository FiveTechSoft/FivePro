#include "FivePro.ch"

// modificado por CGR 2:21:10   Wed 13/04/1994
// objetivo: la ventana hija ha de quedar un carctes mas a la izda. por
// cuestiones est‚ticas
// dar un caracter m s de ancho a los items, para que las flechita
// de submenu no desaparezca

#define CLR_NORMAL     1
#define CLR_HILITE     2
#define CLR_HOT        3
#define CLR_HOTHILITE  4
#define CLR_DISABLE    5
#define CLR_HILDISABLE 6
#define CLR_MESSAGE    7

// ----------------------------------------------------------------------------

CLASS TMenuItem

   DATA   aColors
   DATA   nRow, nCol, nShortCut
   DATA   cItem, cMsg, cHotKey
   DATA   xAction
   DATA   lActive, lChecked
   DATA   oMenu

   METHOD New( nRow, nCol, cItem, cMsg, xAction, lActive, lChecked,;
               nShortCut ) CONSTRUCTOR
   METHOD Display( lHilite )
   METHOD SetMenu( oMenu )
   METHOD ChangePos( nRow, nCol )
   METHOD lIsOver( nRow, nCol ) BLOCK ;
   { | Self, nRow, nCol | nRow == ::nRow .and. nCol >= ::nCol .and. ;
                          nCol <= ::nCol + nLabelLen( ::cItem ) }

   METHOD SetColor( aColors ) BLOCK { | Self, aColors | ::aColors := aColors }
   METHOD Disable() BLOCK { | Self | ::lActive := .f. }

   METHOD GenRC( nId )

ENDCLASS

// ----------------------------------------------------------------------------
 
METHOD New( nRow, nCol, cItem, cMsg, xAction, lActive, lChecked, ;
                 nShortCut ) CLASS TMenuItem

  DEFAULT cMsg := "", lActive := .t., lChecked := .f., nShortCut := 0,;
          xAction := { || nil }

  ::aColors   = { 31, 113, 28, 124, 23, 23, 31 }
  ::nRow      = nRow
  ::nCol      = nCol
  ::cItem     = cItem
  ::cMsg      = cMsg
  ::xAction   = xAction
  ::lActive   = lActive
  ::lChecked  = lChecked
  ::nShortCut = nShortCut
  ::cHotKey   = cGetHotKey( cItem )

return

// ----------------------------------------------------------------------------

METHOD Display( lHiLite ) CLASS TMenuItem

  local cItem   := ::cItem
  local aColors := ::aColors
  local oMenu   := ::oMenu

  DEFAULT lHiLite := .f.

  if ::lChecked
     cItem = "û" + SubStr( cItem, 2 )
  endif
  if oMenu != nil .and. ValType( ::xAction ) == "O"
     if oMenu:ClassName() != "TMENUBAR"
        cItem = SubStr( cItem, 1, Len( cItem ) - 2 ) + Chr( 16 )+' '
     endif
  endif

  if Empty( cItem )
    SepDisplay( ::nRow, oMenu:nLeft, oMenu:nRight )
  else
    if lHiLite
      SayHot( ::nRow, ::nCol, cItem,;
              If( ::lActive, aColors[ CLR_HILITE ], aColors[ CLR_HILDISABLE ] ),;
              If( ::lActive, aColors[ CLR_HOTHILITE ], aColors[ CLR_HILDISABLE ] ) )
      if Len( cItem ) > 4
         SayHot( ::nRow, ::nCol, "µ", 120 )
         SayHot( ::nRow, ::nCol + nLabelLen( cItem ) - 1, "Í", 121 )
      endif
    else
      SayHot( ::nRow, ::nCol, cItem,;
              If( ::lActive, aColors[ CLR_NORMAL ], aColors[ CLR_DISABLE ] ),;
              If( ::lActive, aColors[ CLR_HOT ], aColors[ CLR_DISABLE ] ) )
    end
  end

  if lHilite
     if oMenu != nil
        oMenu:SetMsg( ::cMsg )
     else
        SayHot( oMenu:nMsgRow(), 0,;
                PadC( ::cMsg, MaxCol() + 1 ), aColors[ CLR_MESSAGE ] )
     endif
  endif

return

// ----------------------------------------------------------------------------

METHOD SetMenu( oMenu ) CLASS TMenuItem

   if ::oMenu:ClassName() == "TMENUBAR"
      if oMenu:nRight - oMenu:nLeft < Len( ::cItem )
         oMenu:nRight = oMenu:nLeft + Len( ::cItem )
      endif
   endif

   ::xAction   = oMenu
   oMenu:oMenu = ::oMenu

   if ::oMenu != nil
      if ::oMenu:ClassName() == "TMENUBAR"
         oMenu:ChangePos( ::nRow + 1, ::nCol )
      else
         oMenu:ChangePos( ::nRow, ::oMenu:nRight - 1 )
      endif
   endif

return

// ----------------------------------------------------------------------------

METHOD ChangePos( nRow, nCol ) CLASS TMenuItem

   ::nRow = nRow
   ::nCol = nCol
   if ValType( ::xAction ) == "O"
      ::SetMenu( ::xAction )
   endif

return

//----------------------------------------------------------------------------//

METHOD GenRC( nId ) CLASS TMenuItem

   local cRC := ""

   if ValType( ::xAction ) == "O"
      cRC += '   POPUP "' + ::cItem + '"' + CRLF + "   BEGIN" + CRLF
      cRC += ::xAction:GenRC( nId )
      cRC += "   END" + CRLF + CRLF
   else
      cRC += "      MENUITEM " + ;
             If( ! Empty( ::cItem ), '"' + ::cItem + '"', "SEPARATOR" ) + ;
             ", " + Str( nId, 7 ) + CRLF
   endif

return cRC

//----------------------------------------------------------------------------//
