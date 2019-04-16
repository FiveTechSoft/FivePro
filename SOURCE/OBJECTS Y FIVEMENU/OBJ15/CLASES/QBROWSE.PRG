// Clase Base TQBrowse derivada de TBrowse
// Agiliza el tratamiento de TBrowse

// (C) Antonio Linares, 1993

#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TQBrowse FROM TBrowse

   DATA   lEditable
   DATA   lEnd  READONLY
   DATA   lSound

   METHOD New( nTop, nLeft, nBottom, nRight ) CONSTRUCTOR
   METHOD Db( nTop, nLeft, nBottom, nRight )
   METHOD Display()
   METHOD Edit()
   METHOD KeyApply( nKey )
   METHOD LoadFields()
   METHOD Exec()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight ) CLASS TQBrowse

   ::Parent:New( nTop, nLeft, nBottom, nRight )

   ::HeadSep   = "ÄÂÄ"
   ::ColSep    = " ³ "
   ::lEditable = .t.
   ::lEnd      = .f.
   ::lSound    = .t.

return

//----------------------------------------------------------------------------//

METHOD Db( nTop, nLeft, nBottom, nRight ) CLASS TQBrowse

   DEFAULT nTop := 0, nLeft := 0, nBottom := MaxRow(), nRight := MaxCol()

   ::Parent:Db( nTop, nLeft, nBottom, nRight )

   ::HeadSep   = "ÄÂÄ"
   ::ColSep    = " ³ "
   ::lEditable = .t.
   ::lSound    = .t.

return Self

//----------------------------------------------------------------------------//

METHOD Display() CLASS TQBrowse

   DispBegin()
      do while ! ::Stabilize()
      enddo
   DispEnd()

return

//----------------------------------------------------------------------------//

METHOD Edit() CLASS TQBrowse

   local oGet := GetNew( Row(), Col(), ::GetColumn( ::ColPos ):Block, "" )

   if ::lEditable
      SET CURSOR ON
      ReadModal( { oGet } )
      SET CURSOR OFF
      ::RefreshCurrent()
   endif

return

//----------------------------------------------------------------------------//

METHOD KeyApply( nKey ) CLASS TQBrowse

   do case
      case nKey == K_ESC
           ::lEnd = .t.

      case nKey == K_ENTER
           ::Edit()

      case nKey == K_UP
           ::Up()

      case nKey == K_DOWN
           ::Down()

      case nKey == K_LEFT
           ::Left()

      case nKey == K_RIGHT
           ::Right()

      case nKey == K_PGUP
           ::PageUp()

      case nKey == K_PGUP
           ::PageUp()

      case nKey == K_PGDN
           ::PageDown()

      case nKey == K_CTRL_PGUP
           ::GoTop()

      case nKey == K_CTRL_PGDN
           ::GoBottom()

      case nKey == K_HOME
           ::Home()

      case nKey == K_END
           ::End()

   endcase

return

//----------------------------------------------------------------------------//

METHOD LoadFields() CLASS TQBrowse

   AEval( Array( FCount() ),;
          { | u, n | ::AddColumn( TbColumnNew( Field( n ),;
            FieldBlock( Field( n ) ) ) ) } )

return

//----------------------------------------------------------------------------//

METHOD Exec() CLASS TQBrowse

   local nCrsOld := SetCursor( 0 )

   ::lEnd = .f.

   do while ! ::lEnd
      ::Display()

      if ::lSound .and. ( ::HitTop() .or. ::HitBottom() )
         Tone( 100, 0.1 )
      endif

      ::KeyApply( InKey( 0 ) )
   enddo

   SetCursor( nCrsOld )

return

//----------------------------------------------------------------------------//
