#define CYAN      3
#define RED       4
#define WHITE    15
#define DARKGRAY  8

function Main()

    local nRow := 10, nCol := 10
    local cNombre    := "Antonio Linares"
    local cDireccion := "Marbella - SPAIN"


    SetVga()
    SetColor( "W+/B, W+/R,,, N/W" )
    SetText()
    SetVga()
    SetDac( 56, 29, 29, 29 )

    CLS

    WndDisplay( 3,  3, 12, 35, 2, 3 )
    @ 3, 16 SAY "GT for Clipper"
    Button( 150, 150, 100, 25, 7, 15, 56 )

    @ 5, 5 SAY "Nombre...:" GET cNombre
    @ 7, 5 SAY "Apellidos:" GET cDireccion
    SetMouse( .t. )
    READ

    SetText()

return
