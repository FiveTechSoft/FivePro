// Probando la Clase TWindow

// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

function Main()

   local wnd1 := TWindow():New( 3, 3, 10, 40, "Hola" )
   local wnd2 := TWindow():New( 10, 12, 16, 50, "Adios", "W+/R, G+/G" )

   SET COLOR TO N/BG
   SET CURSOR OFF
   CLS

   wnd1:Display()
   wnd1:Say( 2, 2, "Objects 1.5", "GR+/RB" )
   wnd1:Say( 4, 4, "hummm..." )
   InKey( 0 )

   wnd2:Display()
   wnd2:Say( 3, 2, "Object Oriented Engine", "G+/W" )
   wnd2:Say( 5, 4, "no est  mal..." )
   InKey( 0 )

   wnd2:Hide()
   InKey( 0 )
   wnd1:Hide()

return

//----------------------------------------------------------------------------//
