// Objects.ch ver 1.5

// (C) Antonio Linares, 1993

//----------------------------------------------------------------------------//

#ifndef _OBJECTS_CH
#define _OBJECTS_CH

#xcommand DEFAULT <uVar1> := <uVal1> ;
               [, <uVarN> := <uValN> ] => ;
                  <uVar1> := If( <uVar1> == nil, <uVal1>, <uVar1> ) ;;
                [ <uVarN> := If( <uVarN> == nil, <uValN>, <uVarN> ); ]

#xcommand CLASS <ClassName> ;
             [ <from: INHERIT FROM, FROM, OF> <Parent1> [ ,<ParentN> ] ] ;
          => ;
          function <ClassName>() ;;
             static nClassHandle, abParents ;;
                if nClassHandle == nil ;;
                   ClsNew( <"ClassName"> ,;
                   abParents := { [ { || <Parent1>() } ] ;
                                  [,{ || <ParentN>() } ] } ) ;;
                   #define _PARENT <"Parent1">

#xcommand DATA <Data1> [,<DataN>] => ;
            ClsAddData( <"Data1">, 0 ) [; ClsAddData( <"DataN">, 0 ) ]

#xcommand VAR <Data1> [,<DataN>] => ;
            ClsAddData( <"Data1">, 0 ) [; ClsAddData( <"DataN">, 0 ) ]

#xcommand DATA <Data> READONLY => ClsAddData( <"Data">, 1 )

#xcommand DATA <Data> HIDDEN => ClsAddData( <"Data">, 1 )

#xcommand METHOD <MethodName>( [<uParms,...>] ) CONSTRUCTOR => ;
            ClsAddMethod( <"MethodName">, ;
            { | Self [, <uParms> ] | <MethodName>( Self [, <uParms> ] ), Self } )

#xcommand METHOD <MethodName>( [<uParms,...>] ) => ;
            ClsAddMethod( <"MethodName">, ;
            { | Self [, <uParms> ] | <MethodName>( Self [, <uParms> ] ) } )

#xcommand METHOD <MethodName>( [<uParms,...>] ) VIRTUAL => ;
            ClsAddMethod( <"MethodName">, { || nil } )

#xcommand METHOD <MethodName>( [<uParms,...>] ) SETGET => ;
            ClsAddMethod( <"MethodName">,;
                { | Self, [<uParms>] | <MethodName>( Self, [<uParms>] ) } ) ;;
            ClsAddMethod( "_" + <"MethodName">,;
                { | Self, [<uParms>] | <MethodName>( Self, [<uParms>] ) } )

#xcommand METHOD <MethodName>( [<uParms,...>] ) ;
          <inline: BLOCK, INLINE> <bCodeBlock> => ;
          ClsAddMethod( <"MethodName">, <bCodeBlock> )

#xcommand ENDCLASS => ;
                nClassHandle = nClsMake() ;;
             end ;;
          return __ClassIns( nClassHandle )

#xtranslate :: => Self:


//------ METHODS Sintax -----------

// C++ style
#xtranslate METHOD <ClassName>::<MethodName>( [<uParms,...>] ) => ;
         static function <MethodName>( Self [, <uParms>] ) // CLASS <ClassName>

// ASPEN style
#xtranslate METHOD <MethodName>( [<uParms,...>] ) CLASS <ClassName> => ;
         static function <MethodName>( Self [, <uParms>] ) // CLASS <ClassName>

#xtranslate FUNCTION <ClassName>.<MethodName>( [<uParms,...>] ) => ;
         static function <MethodName>( Self [, <uParms>] ) // CLASS <ClassName>

//---------------------------------

#xtranslate Self:Parent:<Method>( [<uParms,...>] ) => ;
       Eval( bClsMethod( _PARENT, <"Method"> ), Self [,<uParms>] )

#xtranslate Self:Parent( <cParentName> ):<Method>( [<uParms,...>] ) => ;
       Eval( bClsMethod( <"cParentName">, <"Method"> ) ), Self [,<uParms>] )

#endif

//----------------------------------------------------------------------------//
