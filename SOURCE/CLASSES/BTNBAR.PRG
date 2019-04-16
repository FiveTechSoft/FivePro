#include "Objects.ch"

#define IDC_HAND 4

//----------------------------------------------------------------------------//

CLASS TBtnBar FROM TView

   METHOD New( oWnd ) CONSTRUCTOR
   METHOD Display()
   METHOD Click( nRow, nCol ) BLOCK { || MOff(), Alert( "Click" ), MOn() }
   METHOD MouseMove( nRow, nCol )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( oWnd ) CLASS TBtnBar

   Super:New( 0, -1, 0, oWnd:nRight - oWnd:nLeft - 1, oWnd )

   if oWnd != nil
      oWnd:oBar = Self
   endif

return nil

//----------------------------------------------------------------------------//

METHOD Display() CLASS TBtnBar

   @ ::nTop, ::nLeft SAY Space( ::nRight - ::nLeft + 1 ) COLOR "N/N*"
   @ ::nTop, ::nLeft SAY "µ" COLOR "W+*/N"
   @ ::nTop, ::nRight SAY "Í" COLOR "W+*/N"
   SayHot( ::nTop, 25, "³  ³  ³  ³  ³ & ³ ? ³",  112, 124 )

   @ ::nTop, 25 SAY "Ý" COLOR "N+*/W"
   @ ::nTop, 30 SAY "Ý" COLOR "N+*/W"
   @ ::nTop, 34 SAY "Ý" COLOR "N+*/W"
   @ ::nTop, 38 SAY "Ý" COLOR "N+*/W"
   @ ::nTop, 43 SAY "Ý" COLOR "N+*/W"
   @ ::nTop, 47 SAY "Ý" COLOR "N+*/W"
   @ ::nTop, 49 SAY "?" COLOR "GR+/W"
   @ ::nTop, 51 SAY "Ý" COLOR "N*/N"

   @ ::nTop, 60 SAY "Ý"   COLOR "N+*/W"
   @ ::nTop, 61 SAY " û " COLOR "G+/W"
   @ ::nTop, 64 SAY "Ý"   COLOR "N+*/W"
   @ ::nTop, 65 SAY " X " COLOR "R+/W"
   @ ::nTop, 68 SAY "Ý"   COLOR "N*/N"

return nil

//----------------------------------------------------------------------------//

METHOD MouseMove( nRow, nCol ) CLASS TBtnBar

   if nMCursor() != IDC_HAND
      MOff()
      MOn( IDC_HAND )
   endif

return nil

//----------------------------------------------------------------------------//
