#include "Objects.ch"

extern _METHOD1, _METHOD2

//----------------------------------------------------------------------------//

function Error()

   local  aMethods := {}
   static nHandle

   if nHandle == nil
      nHandle = ErrorNew():ClassH()

      if nHandle > Len( aGetClasses() )
         ASize( aGetClasses(), nHandle )
      endif
      aGetClasses()[ nHandle ] = { "ERROR",, { { "", 1 } }, aMethods }

      AAdd( aMethods, { "NEW", { | Self, nTop, nLeft, nBottom, nRight | ;
            New( Self, nTop, nLeft, nBottom, nRight ) } } )
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

METHOD New( nTop, nLeft, nBottom, nRight ) CLASS Error

   if ::ClassName() != "ERROR"
      Self[ 1 ] = ErrorNew()
   else
      Self = ErrorNew()
   endif

return Self

//----------------------------------------------------------------------------//
