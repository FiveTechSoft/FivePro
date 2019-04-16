// Herencias a partir de TbColumn

// (C) Antonio Linares, 1993

#include "Objects.ch"

//----------------------------------------------------------------------------//

function Main()

   local oCol := TMyColumn():New( "Hello", { || "Bye" } )

   Alert( oCol:ClassName() )

   oCol:DoSomething()

return

//----------------------------------------------------------------------------//

CLASS TMyColumn FROM TbColumn      // Heredando de la Clase TBColumn

   DATA   cAnother

   METHOD DoSomething()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD TMyColumn::DoSomething()    // Sintaxis al estilo C++

   Alert( "Objects 1.5" )

return

//----------------------------------------------------------------------------//
