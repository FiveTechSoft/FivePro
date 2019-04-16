// Ejercicios con la Clase TABrowse

#include "InKey.ch"

//----------------------------------------------------------------------------//

function Main()

   local acDias  := { "Lunes    ", "Martes", "Mi‚rcoles", "Jueves", "Viernes",;
                      "S bado", "Domingo" }
   local abrTest := TABrowse():New( 10, 10, 20, 40, acDias,;
                                    "Dias de la Semana" )

   abrTest:ColorSpec = "B/BG, W+/R"
   abrTest:Exec()

   abrTest:aArray = {}           // Prueba de violaci¢n de scoping

return

//----------------------------------------------------------------------------//
