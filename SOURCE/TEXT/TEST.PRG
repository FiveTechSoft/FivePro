// TEXT Module - demo

// $AUTHOR$ A.Linares

//----------------------------------------------------------------------------//

function Main()

    local n
    local cLine   := ""
    local nOffset := 0

    CLS

    Alert( "TxtEval() works like AEval() but directly using Text Files" )
    Alert( "You should use Text Files no matter their sizes !!!" )
    Alert( "It is builted in 100% C, so it is incredibly fast" )
    Alert( "and you don't have to worry about low level files management..." )

    TxtEval( "test.prg",;
             { | cLine, nLine, nOffset | ;
             QOut( "Line n§: "  + AllTrim( Str( nLine ) ) ),;
             QQOut( " Offset: " + AllTrim( Str( nOffset ) ) ),;
             QQOut( " " + cLine ) } )
    ?
    ? "Press a key to continue demo..."
    InKey( 0 )
    CLS

    Alert( "nTxtScan() work like AScan() but directly using Text Files" )
    Alert( "You should use Text Files no matter their sizes !!!" )
    Alert( "It is builted in 100% C, so it is incredibly fast" )
    Alert( "and you don't have to worry about low level files management..." )

    ? "First ocurrence of word 'TxtScan' at Text File 'Test.prg'"
    ? "Found at line: "

    ?? nTxtScan( "test.prg", "387504", @cLine, @nOffset )

    ? "Line is: " + cLine
    ? "The Line Offset inside the file is: " + Str( nOffset )
    ?
    ? "Press a key to continue the demo..."
    InKey( 0 )

    CLS
    Alert( "Now lets count the number of lines of a Text Files" )
    ? "Test.prg has :"
    ?? nTxtLines( "zzz.txt" )
    ?? " Lines of Text"
    ? "Press a key to continue the demo..."
    InKey( 0 )

    CLS
    Alert( "Lets count the number of words inside a Text..." )
    ? "Number of words inside 'Test.prg': "
    ?? nTxtWords( "zzz.txt" )
    ?
    ? "Press a key to continue the demo"
    InKey( 0 )

return

//----------------------------------------------------------------------------//
