#include "Aspen.h"

//----------------------------------------------------------------------------//

CLIPPER TestString()
{
   TItem cName = "Aspen 1.0";                       // a Clipper char variable

   cName += ": C++ extensions for CA-Clipper";      // adding strings!

   cName.Return();
}

//----------------------------------------------------------------------------//

CLIPPER TestArray()
{
   TArray aTest( 3 );

   aTest[ 1 ] = "Hello world!";              // Clipper-alike array managing!
   aTest[ 2 ] = "from CA-Clipper & C++";
   aTest[ 3 ] = 123;

   aTest.Return();
}

//----------------------------------------------------------------------------//

CLIPPER TestEval()
{
   param bAction, cText;                // Getting parameters from Clipper

   bAction.Eval( cText );
}

//----------------------------------------------------------------------------//

CLIPPER TestFile()
{
   TFile file( "Aspen.txt" );

   file.Write( "Welcome to the power of C++ from CA-Clipper" );
}

//----------------------------------------------------------------------------//
