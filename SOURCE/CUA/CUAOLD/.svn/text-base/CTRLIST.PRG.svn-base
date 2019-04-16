#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TCtrList FROM TControl

   DATA oBrowse
   DATA cLabel
   DATA lVisible
   DATA aArray
   DATA nLen

   METHOD New( nRow, nCol, acList, bSetGet, cLabel, nSize, bWhen,;
               bValid ) CONSTRUCTOR
   METHOD Display()
   METHOD KeyApply( nKey )
   METHOD SetFocus( lOnOff )
   METHOD SetList( acNewArray )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, acList, bSetGet, cLabel, nSize, bWhen,;
            bValid ) CLASS TCtrList

   local nMaxWidth := 0

   ::Parent:New()

   DEFAULT bWhen := { || .t. }, bValid := { || .t. }, cLabel := "",;
           nSize := Len( acList )

   AEval( acList, { | cList | nMaxWidth := Max( nMaxWidth, Len( cList ) ) } )

   ::oBrowse = TBrowseArray( nRow + 1, nCol + 1, nRow + nSize - 2, nCol + ;
                             nMaxWidth, acList )
   ::oBrowse:GetColumn( 1 ):Width = nMaxWidth

   ::bBlock     = bSetGet
   ::bPreBlock  = bWhen
   ::bPostBlock = bValid
   ::cLabel     = cLabel
   ::nLen       = Len( acList )
   ::lVisible   = .f.
   ::aArray     = acList

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TCtrList

   local cValue
   local nAt

   if ! ::lVisible
      ::lVisible = .t.
      @ ::oBrowse:nTop - 1, ::oBrowse:nLeft - 1 TO ;
        ::oBrowse:nBottom + 1, ::oBrowse:nRight + 1
      if ! Empty( ::cLabel )
         ScrSayHot( ::oBrowse:nTop - 1, ::oBrowse:nLeft,;
                    " " + ::cLabel + " ", "W+/B", "BG+/B" )
      endif
      cValue = AllTrim( Eval( ::bBlock ) )
      if ( nAt := AScan( ::aArray, { | cItem | AllTrim( cItem ) ;
           == cValue } ) ) != 0
         ::oBrowse:Cargo = nAt
      endif
   endif

   do while ! ::oBrowse:Stabilize()
   enddo
   ScrollBar( ::oBrowse:nTop, ::oBrowse:nRight + 1,;
              ::oBrowse:nBottom, ::oBrowse:nRight + 1, ::nLen, ::oBrowse:Cargo )

return

//----------------------------------------------------------------------------//

METHOD KeyApply( nKey ) CLASS TCtrList

   do case
      case nKey == K_UP
           ::oBrowse:Up()
           ::Display()

      case nKey == K_DOWN
           ::oBrowse:Down()
           ::Display()

      case nKey == K_PGUP
           ::oBrowse:PageUp()
           ::Display()

      case nKey == K_PGDN
           ::oBrowse:PageDown()
           ::Display()

      case nKey == K_HOME
           ::oBrowse:GoTop()
           ::Display()

      case nKey == K_END
           ::oBrowse:GoBottom()
           ::Display()

      otherwise
           ::Parent:KeyApply( nKey )
   endcase

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TCtrList

   local nAt
   local cValue

   ::Parent:SetFocus( lOnOff )
   if ! lOnOff
      Eval( ::bBlock, AllTrim( ::aArray[ ::oBrowse:Cargo ] ) )
      ::oBrowse:DeHilite()
   else
      cValue = Eval( ::bBlock )
      nAt = AScan( ::aArray, { | cItem | AllTrim( cItem ) == cValue } )
      ::oBrowse:Hilite()
      if nAt != 0 .and. nAt != ::oBrowse:Cargo
         ::oBrowse:Cargo = nAt
         ::oBrowse:RefreshAll()
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD SetList( acNewArray ) CLASS TCtrList

   ::aArray  = acNewArray
   ::nLen    = Len( acNewArray )
   ::oBrowse = TBrowseArray( ::oBrowse:nTop, ::oBrowse:nLeft,;
                          ::oBrowse:nBottom, ::oBrowse:nRight, acNewArray )
   ::oBrowse:RefreshAll()
   ::Display()

return

//----------------------------------------------------------------------------//
