// Wed 04/05/1994  22:53:38  ya funciona en vertical


#include "Objects.ch"
#include "InKey.ch"

//----------------------------------------------------------------------------//

CLASS TScrollBar FROM TView

   DATA   bOnUp, bOnDown, bOnPgUp, bOnPgDown
   DATA   cString, nClrArrows, nClrBar, nClrThumb
   DATA   nLen, nRange, nValue, nThumbPos
   DATA   lHorizontal, nPgStep

   METHOD New() CONSTRUCTOR
   METHOD Display()
 //  METHOD ThmCheck()
   METHOD ThmCheck() inline ::Display()
   METHOD KeyPressed( nKey )
   METHOD Click( nMRow, nMCol )
   METHOD SetFocus( lOnOff )

   METHOD Up()
   METHOD Down()
//   METHOD PageUp()   BLOCK { | Self | If( ::bOnPgUp != nil, Eval( ::bOnPgUp ),) }
//   METHOD PageDown() BLOCK { | Self | If( ::bOnPgDown != nil, Eval( ::bOnPgDown ),) }
   METHOD PageUp()
   METHOD PageDown()
   METHOD GoTop()
   METHOD GoBottom()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nRange, nLen, cText, cMsg, lHorizontal, oWnd ;
		, bOnUp, bOnDown, bOnPgUp, bOnPgDown, nPgStep) CLASS TScrollBar

   DEFAULT nTop:= 0, nLeft:= 0, nRange := 0, nLen:= 10, lHorizontal:= .f., nPgStep:=Int(nLen/4)

   Super:New( nTop, nLeft, If( lHorizontal, nTop, nTop + nLen - 1 ),;
              If( lHorizontal, nLeft + nLen - 1, nLeft + 1 ), oWnd )

   ::nLen            = nLen
   ::cString         = If( lHorizontal,;
                           Chr( 17 ) + Chr( 176 ) + Chr( 16 ) + Chr( 254 ),;
                           Chr( 30 ) + Chr( 176 ) + Chr( 31 ) + Chr( 254 ) )
   ::lHorizontal     = lHorizontal
   ::nClrArrows      = 112
   ::nClrBar         = 31
   ::nClrFocus       = 127
   ::nClrThumb       = 112
   ::nRange          = nRange
   ::nValue          = 1
   ::nThumbPos       = 0
   ::cMsg            = cMsg
   ::bOnUp           = bOnUp
   ::bOnDown         = bOnDown
   ::nPgStep		 = nPgStep
   ::bOnPgUp         = bOnPgUp
   ::bOnPgDown       = bOnPgDown
   
   if oWnd != nil
      oWnd:AddControl( Self )
   endif

   if ! Empty( cText )
      ::oLabel = TLabel():New( If( ::lHorizontal, 0, -1 ),;
                 If( ::lHorizontal, -( nLabelLen( cText ) + 2 ), 0 ),;
                 cText, Self )
   endif
   ::lDrag:=.f.
return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TScrollBar
	
   if ::oLabel != nil
      ::oLabel:Show()
   endif

   MOff()
   DispBegin()
   SayHot( ::nTop(), ::nLeft(), Chr( 210 ) + Chr( 186 ), ::nClrArrows )
   if ::lHorizontal
	do case
		case ::nValue<=1
			::nThumbPos:=0
		case ::nThumbPos>=::nRange
			::nThumbPos:=::nLen-5
		Other
			::nThumbPos:=Int( ( ( ::nLen - 5 ) / (::nRange-1) ) *  (::nValue-1)   )
	endcase
       SayHot( ::nTop(), ::nLeft() + 1, Replicate( " ", ::nLen - 2 ), 128 )
      SayHot( ::nTop(), ::nLeft() + ::nLen - 1, Chr( 211 ) + Chr( 187 ),;
              ::nClrArrows )
      SayHot( ::nTop(), ::nLeft() + 2 + ::nThumbPos,;
              Chr( 214 ) + Chr( 190 ),;
              If( ::lFocused, ::nClrFocus, ::nClrThumb ) )
   else
      @ ::nTop() + 1, ::nLeft(),;
        ::nTop() + ::nLen - 2, ::nRight() BOX " " COLOR "N/N*"
	do case
		case ::nValue<=1
			::nThumbPos:=0
		case ::nThumbPos>=::nRange
			::nThumbPos:=::nLen-3
		Other
			::nThumbPos:=Int( ( ( ::nLen - 3 ) / (::nRange-1) ) *  (::nValue-1)   )
	endcase
      SayHot( ::nTop() + 1 + ::nThumbPos ,;
              ::nLeft(), Chr( 214 ) + Chr( 190 ),;
              If( ::lFocused, ::nClrFocus, ::nClrThumb ) )
      SayHot( ::nTop() + ::nLen - 1, ::nLeft(),;
              Chr( 211 ) + Chr( 187 ), ::nClrArrows )
   endif
   DispEnd()
   MOn()

return

//----------------------------------------------------------------------------//

METHOD Up() CLASS TScrollBar

   if ::nValue > 1
      ::nValue--
      ::Display()
      if ::bOnUp != nil
         Eval( ::bOnUp )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD Down() CLASS TScrollBar

   if ::nValue < ::nRange
      ::nValue++
      ::Display()
      if ::bOnDown != nil
         Eval( ::bOnDown )
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD SetFocus( lOnOff ) CLASS TScrollBar

   Super:SetFocus( lOnOff )
   ::Display()

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TScrollBar

   if ::lHorizontal
      do case
         case nKey == K_LEFT
              ::Up()
			  nKey:=0
         case nKey == K_RIGHT
              ::Down()
			  nKey:=0
      endcase
   else
      do case
         case nKey == K_UP
              ::Up()
			  nKey:=0

         case nKey == K_DOWN
              ::Down()
			  nKey:=0
      endcase
   endif

return nKey

//----------------------------------------------------------------------------//

METHOD Click( nMRow, nMCol ) CLASS TScrollBar

   do case
      case nMRow >=::nTop.and.nMCol>=::nLeft.and.;
      		nMCol<=::nLeft+1.and.nmRow<=::nTop+1
           ::Up()
           MUpdate()
           do while lMpressed()
              if nMRow >=::nTop.and.nMCol>=::nLeft.and.;
      		nMCol<=::nLeft+1.and.nmRow<=::nTop+1
                 ::Up()
              endif
              MUpdate()
              nMRow = nMRow()
              nMCol = nMCol()
           enddo

      case ! ::lHorizontal
           do case                                    // PgUp
              case (nMRow > ::nTop+1 .and. nMRow < ::nTop+1 + ::nThumbPos);
              		 .and.(nMCol= ::nLeft.or.nMcol=::nRight)
                   ::PageUp()
                   MUpdate()
                   do while lMPressed()
                      if (nMRow > ::nTop+1 .and. nMRow < ::nTop+1 + ::nThumbPos);
	              		 .and.(nMCol= ::nLeft.or.nMcol=::nRight)
                         ::PageUp()
                      endif
                      MUpdate()
                      nMRow = nMRow()
                      nMCol = nMCol()
                   enddo

              case (nMRow > ::nTop +1+ ::nThumbPos .and. ; // PgDn
                   nMRow < ::nBottom - 1) .and.  ;
	               (nMCol= ::nLeft.or.nMcol=::nRight)
                   ::PageDown()
                   MUpdate()
                   do while lMPressed()
                      if (nMRow > ::nTop() +1+ ::nThumbPos .and. ; // PgDn
	                   nMRow < ::nBottom() - 1) .and.  ;
		               (nMCol= ::nLeft.or.nMcol=::nRight)
                         ::PageDown()
                      endif
                      MUpdate()
                      nMRow = nMRow()
                      nMCol = nMCol()
                   enddo

              case (nMRow == ::nBottom.or.nMrow==::nBottom-1) .and. ;    // Down
                   (nMCol >= ::nLeft .and. nMCol() <= ::nRight)
                   ::Down()
                   MUpdate()
                   do while lMPressed()
                      if nMRow == ::nTop + ::nLen - 1 .and. ;
                         nMCol >= ::nLeft .and. nMCol <= ::nRight
                         ::Down()
                      endif
                      MUpdate()
                      nMRow = nMRow()
                      nMCol = nMCol()
                   enddo
           endcase

      case ::lHorizontal
           do case
              case (nMRow == ::nTop().or.nMRow=::nBottom) .and. ; // PgUp
                   (nMCol > ::nLeft()+1 .and. ;
                   nMCol < ::nLeft() + ::nThumbPos)
                   ::PageUp()
                   MUpdate()
                   do while lMPressed()
                      if (nMRow == ::nTop().or.nMRow=::nBottom) .and. ;
	                   (nMCol > ::nLeft()+1 .and. ;
    	               nMCol < ::nLeft() + ::nThumbPos)

                         ::PageUp()
                      endif
                      MUpdate()
                      nMRow = nMRow()
                      nMCol = nMCol()
                   enddo

              case (nMRow == ::nTop().or.nMRow=::nBottom) .and. ; // PgDn
                   (nMCol < ::nRight()-1 .and. ;
                   nMCol > ::nLeft() + ::nThumbPos)

                   ::PageDown()
                   MUpdate()
                   do while lMPressed()
                      if (nMRow == ::nTop().or.nMRow=::nBottom) .and. ; // PgDn
	                   (nMCol < ::nRight()-1 .and. ;
    	               nMCol > ::nLeft() + ::nThumbPos)

                         ::PageDown()
                      endif
                      MUpdate()
                      nMRow = nMRow()
                      nMCol = nMCol()
                   enddo

              case (nMRow =::nTop.or.nMRow=::nBottom()) ;                // Down
                   .and.( nMCol=::nLeft().or.nMcol= ::nLeft - 1)
                   ::Down()
                   MUpdate()
                   do while lMPressed()
                      if (nMRow =::nTop.or.nMRow=::nBottom()) ;                // Down
	                   .and.( nMCol=::nLeft().or. ::nLeft - 1)

                         ::Down()
                      endif
                      MUpdate()
                      nMRow = nMRow()
                      nMCol = nMCol()
                   enddo
           endcase
   endcase

return

//----------------------------------------------------------------------------//

METHOD ThmCheck() CLASS TScrollBar

   local nNewThumbPos := Int( ( ( ::nValue - 1 ) * ( ::nLen - 3 ) ) / ;
                              ( ::nRange - 1 ) ) + 1

   MOff()
   if ! ::lHorizontal
      if ::nThumbPos != nNewThumbPos
         ::nThumbPos = nNewThumbPos
         @ ::nTop() + 1,;
           ::nLeft(),;
           ::nTop() + ::nLen - 2,;
           ::nLeft() ;
           BOX SubStr( ::cString, 2, 1 ) COLOR "N/W"
         SayHot( ::nTop() + ::nThumbPos, ::nLeft(),;
                 SubStr( ::cString, 4, 1 ),;
                 If( ::lFocused, ::nClrFocus, ::nClrThumb ) )
      endif
   else
      if ::nThumbPos != nNewThumbPos
         ::nThumbPos = nNewThumbPos
         @ ::nTop(), ::nLeft() + 1 ;
           SAY Replicate( SubStr( ::cString, 2, 1 ), ::nLen - 2 ) ;
           COLOR ::cClrBar
         @ ::nTop(), ::nLeft() + ::nThumbPos ;
           SAY SubStr( ::cString, 4, 1 ) ;
           COLOR if( ::lFocused, ::cClrFocus, ::cClrThumb )
      endif
   endif
   MOn()

return

//----------------------------------------------------------------------------//

METHOD GoTop() CLASS TScrollBar

   if ::nValue > 1
      ::nValue = 1
      ::Display()
   endif

return

//----------------------------------------------------------------------------//

METHOD GoBottom() CLASS TScrollBar

   if ::nValue < ::nRange
      ::nValue = ::nRange
      ::Display()
   endif

return

//----------------------------------------------------------------------------//

METHOD PageDown() CLASS TScrollbar
	local n

	if ::bOnPgDown!=nil
		eval(::bOnPgDown)
	else
		for n:=1 to ::nPgStep
			::Down()
		next
	end
	return nil

//----------------------------------------------------------------------------//


METHOD PageUP() CLASS TScrollbar
	local n

	if ::bOnPgUP!=nil
		eval(::bOnPgUP)
	else
		for n:=1 to ::nPgStep
			::UP()
		next
	end
	return nil
		
