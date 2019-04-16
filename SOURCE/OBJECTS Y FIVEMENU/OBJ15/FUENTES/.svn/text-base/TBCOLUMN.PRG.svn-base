#include "Objects.ch"

extern _METHOD1, _METHOD2

//----------------------------------------------------------------------------//

function TbColumn()

   local  aMethods := {}
   static nHandle

   if nHandle == nil
      nHandle = TbColumnNew():ClassH()

      if nHandle > Len( aGetClasses() )
         ASize( aGetClasses(), nHandle )
      endif
      aGetClasses()[ nHandle ] = { "TBCOLUMN",, { { "", 1 } }, aMethods }

      AAdd( aMethods, { "NEW", { | Self, cTitle, bBlock | ;
            New( Self, cTitle, bBlock ) } } )
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

METHOD New( cTitle, bBlock ) CLASS TbColumn

   if ::ClassName() != "TBCOLUMN"
      Self[ 1 ] = TbColumnNew( cTitle, bBlock )
   else
      Self = TbColumnNew( cTitle, bBlock )
   endif

return Self

//----------------------------------------------------------------------------//
