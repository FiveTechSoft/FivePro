#include "Objects.ch"

extern _METHOD1, _METHOD2

//----------------------------------------------------------------------------//

function Get()

   local  aMethods := {}
   static nHandle

   if nHandle == nil
      nHandle = GetNew():ClassH()

      if nHandle > Len( aGetClasses() )
         ASize( aGetClasses(), nHandle )
      endif
      aGetClasses()[ nHandle ] = { "GET",, { { "", 1 } }, aMethods }

      AAdd( aMethods, { "NEW",;
            { | Self, nRow, nCol, bBlock, cName, cPicture, cColor | ;
            New( Self, nRow, nCol, bBlock, cName, cPicture, cColor ) } } )
      AAdd( aMethods, { "CLASSNAME",;
            { | Self | __ClassNam( Self:ClassH() ) } } )

      AEval( __ClassSel( nHandle ),;
             { | cDataMethod | If( cDataMethod != "CLASSNAME",;
             AAdd( aMethods, { cDataMethod,;
             &( "{ | Self, u1, u2, u3 | Self[ 1 ]:" + cDataMethod + ;
             "( u1, u2, u3 ) }" ) } ), nil ) } )

      __ClassAdd( nHandle, "New", "_Method1" )
      __ClassAdd( nHandle, "ClassName", "_Method2" )

   endif

return __ClassIns( nHandle )

//----------------------------------------------------------------------------//

METHOD New( nRow, nCol, bBlock, cName, cPicture, cColor ) CLASS Get

   local oGet := GetNew( nRow, nCol, bBlock, cName, cPicture, cColor )

   if ::ClassName() != "GET"
      Self[ 1 ] = oGet
   else
      Self = oGet
   endif

return Self

//----------------------------------------------------------------------------//
