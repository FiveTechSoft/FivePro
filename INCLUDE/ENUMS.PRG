// Enumeraciones en Clipper

// (C) Antonio Linares, 1993

#xtranslate ENUM <nVar1> [,<nVarN>] ;
               [ BASE <nBase> ] ;
            => ;
               local nEnumBase := [ <nBase> - 1 + ] 1 ;;
               local <nVar1>   := nEnumBase++ ;
           [ ; local <nVarN>   := nEnumBase++ ]

//----------------------------------------------------------------------------//

function Main()

   ENUM Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo

   ? "Enumeraciones de C en Clipper"
   ? "(c) Antonio Linares, 1993"
   ?
   ? Lunes
   ? Martes
   ? Miercoles
   ? Jueves
   ? Viernes
   ? Sabado
   ? Domingo

   TestBase()

return

//----------------------------------------------------------------------------//

function TestBase()

   ENUM Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo BASE 5

   ?
   ? "Enumeraci¢n con Base 5"
   ? Lunes
   ? Martes
   ? Miercoles
   ? Jueves
   ? Viernes
   ? Sabado
   ? Domingo

return

//----------------------------------------------------------------------------//
