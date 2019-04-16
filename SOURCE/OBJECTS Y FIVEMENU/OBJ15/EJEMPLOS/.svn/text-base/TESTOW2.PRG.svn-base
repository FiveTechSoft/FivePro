// Dise¤o interactivo de Objetos con utilizaci¢n del Inpector de Objetos

#include "InKey.ch"

//----------------------------------------------------------------------------//

function Main()

   local brw  := TBrowseNew( 3, 5, 20, 75 )
   local lEnd := .f.
   local nKey

   CLS
   SET COLOR TO "W+/BG"
   @ MaxRow(), 0 SAY ;
     PadR( " F2 - Edit Browse    F3 - Edit Column ", MaxCol() + 1 )

   brw:ColorSpec = "W+/B, N/BG"
   brw:SkipBlock = { | n | n }
   brw:HeadSep   = "Ä"
   brw:AddColumn( TbColumnNew( "First",  { || "One" } ) )
   brw:AddColumn( TbColumnNew( "Second", { || "Two" } ) )
   brw:AddColumn( TbColumnNew( "Third",  { || "Three" } ) )

   do while ! lEnd

      do while ! brw:Stabilize()
      enddo

      nKey = InKey( 0 )

      do case
         case nKey == K_ESC .or. nKey == K_ENTER
              lEnd = .t.

         case nKey == K_LEFT
              brw:Left()

         case nKey == K_RIGHT
              brw:Right()

         case nKey == K_UP
              brw:Up()

         case nKey == K_DOWN
              brw:Down()

         case nKey == K_F2
              OInspect( brw )         // Inspector gen‚rico de Objetos
              brw:InvalidateAll()

         case nKey == K_F3
              OInspect( brw:GetColumn( brw:ColPos ) )
              brw:SetColumn( brw:ColPos, brw:GetColumn( brw:ColPos ) )
      endcase
   enddo

   brw:InvalidateAll()

   lOWrite( "brw", brw )              // Salvamos el Objeto a disco

return

//----------------------------------------------------------------------------//
