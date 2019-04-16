// Pruebas de duplicado de Objetos

//----------------------------------------------------------------------------//

function Main()

   local brw1 := TBrowseNew( 10, 10, 20, 40 )
   local brw2

   brw2 = oOClone( brw1 )        // Duplica toda la informaci¢n de brw1

   brw1:nTop = 5

   ? brw1:nTop
   ? brw2:nTop

return

//----------------------------------------------------------------------------//
