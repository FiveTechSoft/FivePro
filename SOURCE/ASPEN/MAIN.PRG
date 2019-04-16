// (c) Antonio Linares 1994

//----------------------------------------------------------------------------//

function Main()

   local aArray, bAction

   SET COLOR TO "W+/B"
   CLS

   ? " Testing Aspen.lib 1.0 : C++ extensions for CA-Clipper"
   ? "======================================================"

   Alert( "This is a char variable created from C++: ;" + TestString() )



   aArray = TestArray()

   Alert( "This is an array created from C++: ;" + ;
          "aArray[ 1 ]: " + aArray[ 1 ] + ";" + ;
          "aArray[ 2 ]: " + aArray[ 2 ] + ";" + ;
          "aArray[ 3 ]: " + Str( aArray[ 3 ], 3 ) )


   bAction = { | c | Alert( c ) }

   TestEval( bAction, "Evaluating a CodeBlock from C++" )
   TestEval( bAction, "C++ power" )

   TestFile()

return

//----------------------------------------------------------------------------//
