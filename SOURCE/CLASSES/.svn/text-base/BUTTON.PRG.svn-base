#include "FivePro.ch"

//----------------------------------------------------------------------------//

CLASS TButton FROM TView

   DATA   cText
   DATA   lDefault, lPressed
   DATA   bAction

   METHOD New( nRow, nCol, cText, cMessage, bAction, bWhen, bValid, oWnd,;
               nClrNormal, nClrFocus ) CONSTRUCTOR
   METHOD Display()
   METHOD KeyPressed( nKey )
   METHOD Click( nRow, nCol  )

   METHOD DblClick( nRow, nCol ) INLINE ::Click( nRow, nCol )

   METHOD lIsOver( nRow, nCol )

   METHOD GenRC( nId ) INLINE '   PUSHBUTTON "' + ::cText + '", ' + ;
                              Str( nId, 3 ) + "," + ;
                              Str( ::nLeft * 16, 3 ) + "," + ;
                              Str( ::nTop * 9, 3 ) + "," + ;
                              Str( ( ::nRight - ::nLeft + 1 ) * 9, 3 ) + "," + ;
                              Str( ( ::nBottom - ::nTop + 1 ) * 9, 3 ) + CRLF

   METHOD GoDown()

   METHOD cGetHotKey() INLINE cGetHotKey( ::cText )

   METHOD GenCode()
   METHOD Inspect()

   METHOD RClick( nRow, nCol ) INLINE If( ::lDrag, ::Inspect(),)

   METHOD Click( nRow, nCol )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, cText, cMessage, bAction, bWhen, bValid, oWnd,;
            nClrNormal, nClrFocus ) CLASS TButton

   DEFAULT cText:= "&TButton", cMessage:= "", bWhen := { || .t. },;
           bValid := { || .t. }, nClrNormal := 112, nClrFocus := 127

   Super:New( nRow, nCol, nRow + 1, nCol + nLabelLen( cText ), oWnd )

   ::cText        = AllTrim( cText )
   ::cMsg         = cMessage
   ::bAction      = bAction
   ::lPressed     = .f.
   ::lDefault     = .f.
   ::lDrag        = .f.
   ::bWhen        = bWhen
   ::bValid       = bValid
   ::nClrNormal   = nClrNormal
   ::nClrFocus    = nClrFocus

   if oWnd != nil
      oWnd:AddControl( Self )
   endif

return

//----------------------------------------------------------------------------//

METHOD Display() CLASS TButton
   local lDraw:=.t.
   		// est  dentro de la ventana ?
	if ::oWnd!=nil
		if ::oWnd:nTop>=::nTop.or.;
		   ::oWnd:nLeft>=::nLeft.or.;
		   ::oWnd:nBottom<=::nBottom.or.;
		   ::oWnd:nRight<=::nRight
		 lDraw:=.f.
		end
	end
   if lDraw
	   // quitar cuando la fucncion en c btndraw est‚ bien
	   if ::ntop>=0.and.::nBottom<=maxrow().and.::nLeft>=0.and.::nRight<=maxcol()
	   MOff()
	   BtnDraw( ::nTop, ::nLeft, ::nBottom, ::nRight, ::cText,;
            If( ::lFocused, ::nClrFocus,;
            If( ! ::lActive, 115,;
            If( ::lDefault, 126, ::nClrNormal ) ) ), 123, ::lPressed )
	   MOn()
       end
   end

return

//----------------------------------------------------------------------------//

METHOD KeyPressed( nKey ) CLASS TButton

   if ::lDrag
      return Super:KeyPressed( nKey )
   else
      do case
         case nKey == K_ESC
              if ::oWnd == nil
                 ::EndExec()
              endif
              return 0

         case nKey == K_SPACE .or. nKey == K_ENTER
              ::GoDown()
              if ::bAction != nil
                 Eval( ::bAction )
              endif
              return 0

         case lIsHotKey( nKey, ::cText )
              ::GoDown()
              if ::bAction != nil
                 Eval( ::bAction )
              endif
              return 0

      endcase
   endif

return nKey

//----------------------------------------------------------------------------//

METHOD Click( nRow, nCol ) CLASS TButton

   if ::lDrag
      do case
         case nCol == ::nRight
              ::ReSize( 2, 2 )

         otherwise
              ::DragOver()
      endcase
   else
      if ::lActive
         ::GoDown()
      endif
   endif

return

//----------------------------------------------------------------------------//

METHOD lIsOver( nRow, nCol ) CLASS TButton

   if ::lDrag
      return Super:lIsOver( nRow, nCol )
   endif

return nRow >= ::nTop .and. nRow < ::nBottom .and. ;
       nCol >= ::nLeft .and. ;
       nCol <= ::nRight - 1 + If( ::lPressed, 1, 0 )

//----------------------------------------------------------------------------//

METHOD GoDown() CLASS TButton

   ::lPressed = .t.
   MOff()
   DispBegin()
   RestScreen( ::nTop, ::nLeft, ::nBottom, ::nRight, ::cBack )
   ::Display()
   DispEnd()
   MOn()
   if lMPressed()
      do while lMPressed()
         if ::lIsOver( nMRow(), nMCol() )
            if ! ::lPressed
               ::lPressed = .t.
               MOff()
               DispBegin()
               RestScreen( ::nTop, ::nLeft, ::nBottom, ::nRight, ::cBack )
               ::Display()
               DispEnd()
               MOn()
            endif
         else
            if ::lPressed
               ::lPressed = .f.
               MOff()
               DispBegin()
               RestScreen( ::nTop, ::nLeft, ::nBottom, ::nRight, ::cBack )
               ::Display()
               DispEnd()
               MOn()
            endif
         endif
         MUpdate()
      enddo
   else
      InKey( 0.2 )
   endif
   if ::lPressed
      MOff()
      ::lPressed = .f.
      DispBegin()
      RestScreen( ::nTop, ::nLeft, ::nBottom, ::nRight, ::cBack )
      ::Display()
      DispEnd()
      MOn()
   endif
   if ::lIsOver( nMRow(), nMCol() ) .and. ::bAction != nil
      Eval( ::bAction )
   endif

return

//----------------------------------------------------------------------------//

METHOD GenCode() CLASS TButton

   local cCode := ""

   cCode += "   @ "
   cCode += Transform( ::nTop - If( ::oWnd != nil, ::oWnd:nTop, 0 ), "99" ) + ", "
   cCode += Transform( ::nLeft - If( ::oWnd != nil, ::oWnd:nLeft, 0 ), "99" )
   cCode += ' BUTTON "' + ::cText + '"'
   cCode += If( ::nBottom > ::nTop + 1, " SIZE " + ;
            AllTrim( Str( ::nRight - ::nLeft + 1, 3 ) ) + ", " + ;
            AllTrim( Str( ::nBottom - ::nTop + 1, 3 ) ), "" )
   cCode  += " OF oWnd"

return cCode

//----------------------------------------------------------------------------//

METHOD Inspect() CLASS TButton

   local oWnd
   local cText := ::cText
   local lOk   := .f.

   DEFINE WINDOW oWnd FROM 4, 2 TO 12, 38 ;
      TITLE "Button properties" NOGROW NOZOOM

   @  2,  2 SAY "&Prompt:" OF oWnd
   @  2, 10 GET cText OF oWnd COLOR "N/BG, W+/R"

   @  2, 26 BUTTON "   &Ok   " OF oWnd ACTION ( lOk := .t., oWnd:End() )
   @  4, 26 BUTTON " &Cancel " OF oWnd ACTION oWnd:End()

   ACTIVATE WINDOW oWnd

   ::cText = cText
   ::Display()

return

//----------------------------------------------------------------------------//
