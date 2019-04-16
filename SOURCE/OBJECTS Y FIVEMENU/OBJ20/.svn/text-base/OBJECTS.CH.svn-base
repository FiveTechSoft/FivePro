// Actualizaci¢n de Objects 1.5 a Objects 2.0 d

// Objects.ch ver 2.0 d                 for size and speed!
// (C) Antonio Linares, 1993

// Antonio Linares
// Avd. R. Soriano 68, 1-7
// 29600 Marbella - SPAIN

//----------------------------------------------------------------------------//

#ifndef _OBJECTS_CH
#define _OBJECTS_CH

#xcommand DEFAULT <uVar1> := <uVal1> ;
               [, <uVarN> := <uValN> ] => ;
                  <uVar1> := If( <uVar1> == nil, <uVal1>, <uVar1> ) ;;
                [ <uVarN> := If( <uVarN> == nil, <uValN>, <uVarN> ); ]

#xcommand CLASS <ClassName> ;
             [ <from: INHERIT FROM, FROM, OF> <Super> ] ;
          => ;
          [ static _nSuper := <(Super)>; ] ;
          function <ClassName>() ;;
             static nClassHandle ;;
                if nClassHandle == nil ;;
                   ClsNew( <"ClassName">, [ _nSuper := <Super>():ClassH ] ) ;;

#xcommand DATA <Data1> [,<DataN>] => ;
            ClsAddData( <"Data1"> ) [; ClsAddData( <"DataN"> ) ]

#xcommand VAR <Data1> [,<DataN>] => ;
            ClsAddData( <"Data1"> ) [; ClsAddData( <"DataN"> ) ]

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
                { | Self [,<uParms>] | <MethodName>( Self [,<uParms>] ) } ) ;;
            ClsAddMethod( "_" + <"MethodName">,;
                { | Self [,<uParms>] | <MethodName>( Self [,<uParms>] ) } )

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

// VO style
#xtranslate METHOD <MethodName>( [<uParms,...>] ) CLASS <ClassName> => ;
         static function <MethodName>( Self [, <uParms>] ) // CLASS <ClassName>

//---------------------------------

#xtranslate Super:<Method>( [<uParms,...>] ) => ;
            Super( _nSuper, Self ):<Method>( [<uParms>] )

#endif

//----------------------------------------------------------------------------//
