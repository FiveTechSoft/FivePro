#include "Menus.ch"

//----------------------------------------------------------------------------//

function Main()

   local mnu

   DEFINE MENU mnu

   DEFINE PAD OF mnu AT 2, 2 PROMPT " &Uno  " MESSAGE "Primera opci¢n"
   DEFINE PAD OF mnu AT 4, 2 PROMPT " &Dos  " MESSAGE "Segunda opci¢n"
   DEFINE PAD OF mnu AT 6, 2 PROMPT " &Tres " MESSAGE "Tercera opci¢n"

   ACTIVATE MENU mnu

return

//----------------------------------------------------------------------------//
