#include "Objects.ch"

extern _METHOD1, _METHOD2

//----------------------------------------------------------------------------//

function TBrowse()

   local  aMethods := {}
   static nHandle

   if nHandle == nil
      nHandle = TBrowseNew():ClassH()

      if nHandle > Len( aGetClasses() )
         ASize( aGetClasses(), nHandle )
      endif
      aGetClasses()[ nHandle ] = { "TBROWSE",, { { "", 1 } }, aMethods }

      AAdd( aMethods, { "NEW", { | Self, nTop, nLeft, nBottom, nRight | ;
            New( Self, nTop, nLeft, nBottom, nRight ) } } )

      AAdd( aMethods, { "DB", { | Self, nTop, nLeft, nBottom, nRight | ;
            Db( Self, nTop, nLeft, nBottom, nRight ) } } )

      AAdd( aMethods, { "CLASSNAME",;
            { | Self | __ClassNam( Self:ClassH() ) } } )

      AEval( __ClassSel( nHandle ),;
             { | cDataMethod | If( cDataMethod != "CLASSNAME",;
             AAdd( aMethods, { cDataMethod,;
             &( "{ | Self, u1, u2, u3 | Self[ 1 ]:" + cDataMethod + ;
             "( u1, u2, u3 ) }" ) } ), nil ) } )

      __ClassAdd( nHandle, "New", "_Method1" )
      __ClassAdd( nHandle, "Db", "_Method2" )
      __ClassAdd( nHandle, "ClassName", "_Method3" )

   endif

return __ClassIns( nHandle )

//----------------------------------------------------------------------------//

METHOD New( nTop, nLeft, nBottom, nRight ) CLASS TBrowse

   if ::ClassName() != "TBROWSE"
      Self[ 1 ] = TBrowseNew( nTop, nLeft, nBottom, nRight )
   else
      Self = TBrowseNew( nTop, nLeft, nBottom, nRight )
   endif

return Self

//----------------------------------------------------------------------------//

METHOD Db( nTop, nLeft, nBottom, nRight ) CLASS TBrowse

   if ::ClassName() != "TBROWSE"
      Self[ 1 ] = TBrowseDb( nTop, nLeft, nBottom, nRight )
   else
      Self = TBrowseDb( nTop, nLeft, nBottom, nRight )
   endif

return Self

//----------------------------------------------------------------------------//
