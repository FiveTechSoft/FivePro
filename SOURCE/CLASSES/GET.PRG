#include "Objects.ch"
#include "InKey.ch"
#include "Set.ch"

#define K_UNDO  K_CTRL_U

static bTrue := { || .t. }

//----------------------------------------------------------------------------//

CLASS TGet FROM TView

   DATA   oGet
   DATA   nCrsPos

   METHOD New( nRow, nCol, bSetGet, cColors, cLabel, cMessage, cPicture,;
               oWnd, bWhen, bValid ) CONSTRUCTOR

   METHOD Display() INLINE ::oGet:Reset(), ::oGet:Display()

   METHOD SetFocus( lOnOff )
   METHOD KeyPressed( nKey )
   METHOD Click( nRow, nCol )

   METHOD ChangePos( nRow, nCol ) BLOCK ;
          { | Self, nRow, nCol | Super:ChangePos( nRow, nCol ),;
                                 ::oGet:Row := nRow, ::oGet:Col := nCol }
   METHOD GenCode()

   METHOD Adjust() INLINE ::oGet:VarPut(space(::Right-::left+1))
   
  
ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, bSetGet, cColors, cLabel, cMessage, cPicture, oWnd,;
            bWhen, bValid ) CLASS TView
   local nLen
   local cTemp
   
	
   DEFAULT cColors := "N/BG, W+/BG", bWhen := bTrue, bValid := bTrue

   if cPicture!=nil
   		cTemp:=trans(eval(bSetGet),cPIcture)
   	else
	   cTemp:=cValtoChar(eval(bSetGet))
   end
   nLen:=len(cTemp) // longitud del get realmente
   
   Super:New( nRow + If( oWnd != nil, oWnd:nTop, 0 ),;
              nCol + If( oWnd != nil, oWnd:nLeft, 0 ),;
              nRow + If( oWnd != nil, oWnd:nTop, 0 ),;
              nCol + If( oWnd != nil, oWnd:nLeft, 0 ) + ;
              nLen - 1 )

   ::oGet = GetNew( nRow + If( oWnd != nil, oWnd:nTop, 0 ),;
                    nCol + If( oWnd != nil, oWnd:nLeft, 0 ), bSetGet )
   ::oGet:ColorSpec = cColors

   if cPicture != nil
      ::oGet:Picture = cPicture
   endif
   ::nCrsPos = 0
   ::oWnd    = oWnd
   ::bWhen   = bWhen
   ::bValid  = bValid

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

   // por defecto no se mueven los gets no???
   ::lDrag:=.f.
   
return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TGet


   MOff()
   if lOnOff
      ::oGet:SetFocus()
      SetGetPos( ::oGet, ::nCrsPos )
      SetPos( ::nTop, ::nLeft + ::nCrsPos )
      if ! ::lDrag
         SetCursor( 1 )
      endif
   else
      SetCursor( 0 )
      ::oGet:Assign()
      ::nCrsPos = ::oGet:Pos - 1
      ::oGet:KillFocus()
   endif

   Super:SetFocus( lOnOff )

   MOn()

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TGet

// si una tecla >255, probablemente es alt-tecla
// o si es -0 es una combinaci¢n de teclas de funcion
// en cualquier caso, no debe ir al get ?no??
if nKey>0.and.nKey<256
   do case
      case nKey == K_LEFT
           ::oGet:Left()
           return 0

      case nKey == K_RIGHT
           ::oGet:Right()
           return 0

      case nKey == K_HOME
           ::oGet:Home()
           return 0

      case nKey == K_END
           ::oGet:End()
           return 0

      case nKey == K_CTRL_LEFT
           ::oGet:WordLeft()
           return 0

      case nKey == K_CTRL_RIGHT
           ::oGet:WordRight()
           return 0

      case nKey == K_BS
           ::oGet:BackSpace()
           return 0

      case nKey == K_DEL
           ::oGet:Delete()
           return 0

      case nKey == K_CTRL_T
           ::oGet:DelWordRight()
           return 0

      case nKey == K_CTRL_Y
           ::oGet:DelEnd()
           return 0

      case nKey == K_CTRL_BS
           ::oGet:DelWordLeft()
           return 0

      case nKey == K_INS
           Set( _SET_INSERT, ! Set( _SET_INSERT ) )
           SetCursor( If( SetCursor() == 1, 2, 1 ) )
           return 0

      case nKey == K_UNDO
           ::oGet:UnDo()
           return 0

      case nKey == K_UP .or. nKey == K_DOWN .or. nKey == K_ENTER
           return nKey

      case ::oGet:Type == "N" .and. ;
           Chr( nKey ) == "." .OR. Chr( nKey ) == ","
           ::oGet:ToDecPos()
           return 0

      otherwise
           if Set( _SET_INSERT )
              ::oGet:Insert( Chr( nKey ) )
           else
              ::oGet:OverStrike( Chr( nKey ) )
           endif
           return 0
   endcase
 endif
return nKey

//----------------------------------------------------------------------------//

METHOD GenCode() CLASS TGet

   local cCode := ""

   cCode += "   @ "
   cCode += Transform( ::nTop - If( ::oWnd != nil, ::oWnd:nTop, 0 ), "99" )
   cCode += ", " + Transform( ::nLeft - If( ::oWnd != nil, ::oWnd:nLeft, 0 ), "99" )
   cCode += " GET uVar OF oWnd"

return cCode

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TGet

   if ::lDrag
      Super:Click( nRow, nCol )
   else
      if ::oGet:Pos != nCol - ::nLeft + 1
         SetGetPos( ::oGet, nCol - ::nLeft )
         SetPos( ::nTop, nCol )
      endif
	 endif

return

//----------------------------------------------------------------------------//

Method adjust() class tget


  ::oGet:VarPut( Space( ::nRight - ::nLeft + 1 ) )

