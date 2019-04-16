// Ejemplo de salvado y restauraci¢n de Objetos desde disco

extern TBrowse, TbColumn, Get

//----------------------------------------------------------------------------//

function Main()

   local brw  := TBrowseNew( 3, 3, 20, 40 )
   local col1 := TbColumnNew( "First",  { || "One" } )
   local col2 := TbColumnNew( "Second", { || "Two" } )
   local col3 := TbColumnNew( "Third",  { || "Three" } )

   brw:ColorSpec = "W+/B, N/BG, W+/R, GR+/G"
   brw:HeadSep   = "Ä"
   brw:FootSep   = "*"
   brw:Cargo     = GetNew( 12, 50, { || "Un Get!" }, "" )  // Almacenamos otro
   col1:DefColor = { 1, 2 }                                // objeto en Cargo
   col2:DefColor = { 2, 3 }
   col3:DefColor = { 1, 3 }
   col1:Footing  = "Hello"
   col2:Footing  = "Bye"
   col3:Footing  = "Super!"

   brw:AddColumn( col1 )
   brw:AddColumn( col2 )
   brw:AddColumn( col3 )

   lOWrite( "brw", brw )
   CLS

   brw  = nil                       // destruimos el Objeto
   col2 = nil
   col2 = nil
   col3 = nil

   brw = oORead( "brw" )            // lo restauramos desde disco

   do while ! brw:Stabilize()
   enddo

   Alert( brw:Cargo:ClassName() )   // El Objeto situado en cargo
                                    // tambien ha sido restaurado

return

//----------------------------------------------------------------------------//
