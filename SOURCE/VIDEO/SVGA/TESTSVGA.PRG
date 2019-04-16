function Main()

   local n := 1

   SetSVGA()

   SET COLOR TO "W+/G"

   @ 10, 10 SAY "Hola amigos, que tal!" COLOR "W+/G"

   @ 12, 10 SAY Fore()
   @ 14, 10 SAY Back()

   InKey( 0 )

return
