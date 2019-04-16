// Ejercicios con el Inspector de Objetos

// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

function Main()

   local brw := TBrowseNew( 5, 5, 20, 50 )

   brw:Cargo = GetNew()

   SET COLOR TO "W+/B, N/BG"
   OInspect( brw )

return

//----------------------------------------------------------------------------//
