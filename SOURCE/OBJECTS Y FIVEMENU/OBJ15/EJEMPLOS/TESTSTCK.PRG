// Probando la Clase TStack

//----------------------------------------------------------------------------//

function Main()

   local stk := TStack():New()       // Llamamos al m‚todo Constructor

   stk:Push( 12 )                    // Guardamos valores en el Stack
   stk:Push( "Hola" )
   stk:Push( Date() )

   ? stk:Len()

   ? stk:Pop()                       // Recuperamos valores del Stack
   ? stk:Pop()
   ? stk:Pop()

   ? stk:Len()

   stk:Push( "Adios" )
   ? stk:Pop()

return

//----------------------------------------------------------------------------//
