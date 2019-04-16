/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ    ObjectsP.ch                                                บ
บ                                                               บ
บ Clipper 5.x header file for ObjectsP.lib  V 2.1 (Profesional) บ
บ Fecha: Septiembre 1993                                        บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

    ญ Dios libre al Sr. Usuario de cambiar una sola linea de
    este fichero sin haber hecho antes una copia de seguridad !

*/


#ifndef _OBJECTSP_CH
#define _OBJECTSP_CH

#define _FuncType_

#xcommand DEFAULT <Desc> [, <DescN> ]      => ;
                  __DFT__( <Desc> ) [ ; __DFT__( <DescN> ) ]

#xtranslate __DFT__( <Var> := <Dft> ) => ;
                     <Var> := if( <Var> == nil, <Dft>, <Var> )

#xtranslate __DFT__( <Var> = <Dft> )  => ;
            __DFT__( <Var> := <Dft> )

// Declaracion de clase
// =======================

// El "Ambito" (Scope) por defecto inicial es PUBLIC. Lo pone _NewClass()

#xcommand CLASS <ClsNam>   ;
                [ <from: INHERIT FROM, INHERIT, FROM, OF> <SupCls> ] ;
    => ;
          function <ClsNam>()      ;;
             static nClassH       ;;
             if nClassH == nil    ;;
                nClassH = _NewClass( #<ClsNam> [,<SupCls>() ] ) ;
                [ ; #define _sUPcLS_ <SupCls> ]

#xtranslate CREATE CLASS <*ClsHead*> =>  CLASS <ClsHead>



// traductores / pseudofunciones.

#xtranslate __TYPE__( <Typ> [, <TypN> ] ) => ;
            \{ upper( #<Typ> ) [, upper( #<TypN> ) ] \}

#xtranslate __SCOPE__                                => NIL
#xtranslate __SCOPE__ <scp: PUBLIC, EXPORT>          => 0
#xtranslate __SCOPE__ <scp: READONLY, PROTECTED>     => 1
#xtranslate __SCOPE__ <scp: LOCAL, HIDDEN>           => 2

// Declaraciones de Variables de Instancia y de Clase.
// ===================================================

#xcommand _GEN_DATA_ <cVar1> [,<cVarN> ] [ AS <Typ,...> ] ;
         [ <scp: PUBLIC, EXPORT, READONLY, PROTECTED, LOCAL, HIDDEN> ] =>  ;
         _AddInsVar( \{ #<cVar1> [, #<cVarN> ] \}, [ __TYPE__( <Typ> ) ], ;
                     __SCOPE__ [ <scp> ] )

#xcommand _GEN_CLSDATA_ <cVar1> [,<cVarN> ] [ AS <Typ,...> ]  ;
         [ <scp: PUBLIC, EXPORT, READONLY, PROTECTED, LOCAL, HIDDEN> ] =>  ;
         _AddClsVar( \{ #<cVar1> [, #<cVarN> ] \}, [ __TYPE__( <Typ> ) ] , ;
                      __SCOPE__ [ <scp> ] )

// Declaraciones de Variables de Instancia

#xcommand VAR     <*VLst*>   => _GEN_DATA_ <VLst>
#xcommand INSTVAR <*VLst*>   => _GEN_DATA_ <VLst>
#xcommand DATA    <*VLst*>   => _GEN_DATA_ <VLst>


// Declaraciones de Variables de Clase.

#xcommand CLASSVAR  <*VLst*>   => _GEN_CLSDATA_ <VLst>
#xcommand CLASSDATA <*VLst*>   => _GEN_CLSDATA_ <VLst>


// Declaraciones de Metodos.
// =========================

#xcommand __METHOD__ <Met> [, <MetN> ] [ <scp: PUBLIC, EXPORT, LOCAL, HIDDEN> ] [ <CONSTRUCTOR> ] => ;
   _AddMethod(\{_MetTrans_(<Met>) [,_MetTrans_(<MetN>)]\}, __SCOPE__ [ <scp> ], <.CONSTRUCTOR.> )

#xcommand _GEN_METHOD_ <Met> [,<MetN> ] [<*x*>] =>  ;
          __METHOD__  <Met> [,<MetN> ]  [<x>]

#xcommand _GEN_METHOD_ <Met> VIRTUAL [<*x*>] => __METHOD__ <Met>:_VIRTUAL_ [<x>]

// Una GENIAL idea de Antonio Linares: La declaraciขn "SetGet"
#xcommand _GEN_METHOD_ <Met> SETGET [<*x*>]  => __METHOD__ <Met>:_SETGET_ [<x>]

#xcommand _GEN_METHOD_ <Met> METHOD <udf> [, <MetN> METHOD <udfN> ] [<*x*>] => ;
          __METHOD__ <Met> = <udf> [ , <MetN> = <udfN> ] [<x>]

#xcommand _GEN_METHOD_ <Met> <o: BLOCK, INLINE> <code,...> [ <scp: PUBLIC, EXPORT, LOCAL, HIDDEN> ] => ;
          _AddMetBlk( _BlkTrans_( <Met> <o> <code> ), __SCOPE__ [<scp>] )


#xcommand METHOD  <*cMDesc*>   => _GEN_METHOD_ <cMDesc>
#xcommand MESSAGE <*cMDesc*>   => _GEN_METHOD_ <cMDesc>


// PreAmbitos
#xcommand  __ST__  <st: METHOD, MESSAGE, VAR, INSTVAR, DATA, CLASSVAR, CLASSDATA > <*x*> ;
                  => <st> <x>
#xcommand EXPORT  <*x*> => __ST__ <x> PUBLIC
#xcommand HIDE    <*x*> => __ST__ <x> HIDDEN
#xcommand PROTECT <*x*> => __ST__ <x> PROTECTED


// Declaraciones de Scoping por defecto.
// =======================================
#xcommand EXPORT:     =>   _DftScope( 0 )
#xcommand PUBLIC:     =>   EXPORT:
#xcommand PROTECTED:  =>   _DftScope( 1 )
#xcommand READONLY:   =>   PROTECTED:
#xcommand LOCAL:      =>   _DftScope( 2 )
#xcommand HIDDEN:     =>   LOCAL:


// Traductores de descripciones de mtodos.

#xtranslate _MetTrans_( <Met> ) => ;
            #<Met>, \{|| <Met>() \}

#xtranslate _MetTrans_( <Met>( [<prm,...>] ) ) => ;
            #<Met>, \{|| <Met>() \}

#xtranslate _MetTrans_( <Met> = <udf> ) => ;
            #<Met>, \{|| <udf>() \}

#xtranslate _MetTrans_( <Met>( [<prm,...>] ) = <udf> ) => ;
            #<Met>, \{|| <udf>() \}

#xtranslate _MetTrans_( <Met> = <udf>( [<prm,...>] ) ) => ;
            #<Met>, \{|| <udf>() \}

#xtranslate _MetTrans_( <Met>([<prm,...>]) = <udf>([<prm,...>]) ) =>;
            #<Met>, \{|| <udf>() \}

#xtranslate _MetTrans_( <Met>:_VIRTUAL_ ) => ;
            #<Met>, "_VIRTUAL_"

#xtranslate _MetTrans_( <Met>( [<prm,...>] ):_VIRTUAL_ ) => ;
            #<Met>, "_VIRTUAL_"

#xtranslate _MetTrans_( <Met>:_SETGET_ ) => ;
            #<Met>, \{|| <Met>() \}, "_" + #<Met>, \{|| <Met>() \}

#xtranslate _MetTrans_( <Met>( [<prm,...>] ):_SETGET_ ) => ;
            #<Met>, \{|| <Met>() \}, "_" + #<Met>, \{|| <Met>() \}

#xtranslate _BlkTrans_( <Met> INLINE <code,...> ) => ;
            #<Met>, \{ | Self | <code> \}

#xtranslate _BlkTrans_( <Met>( [<prm,...>] ) INLINE <code,...> ) => ;
            #<Met>, \{ | Self [, <prm> ] | <code> \}

#xtranslate _BlkTrans_( <Met> BLOCK <code,...> ) => ;
            #<Met>, <code>

#xtranslate _BlkTrans_( <Met>([<prm,...>] ) BLOCK <code,...> ) => ;
            #<Met>, <code>

#xtranslate :VIRTUAL => :_VIRTUAL_
#xtranslate :SETGET  => :_SETGET_


// Fin del cuerpo de declaraciขn de clase.
// =======================================

#xcommand ENDCLASS  =>      _ClsOptimize( nClassH )  ;;
                       end                                ;;
                       return __ClassIns( nClassH )  ;;
                       #include "opendcls.ch"

#xcommand END CLASS  => ENDCLASS



// Declaraciones para el cขdigo ( funciขn ข procedimiento ) de los mtodos.
// ==========================================================================

#xcommand _METHOD_ <Tp: FUNCTION, PROCEDURE> <Met> [ CLASS <ClassName> ] =>;
                  _FuncType_ <Tp> <Met>  ;;
                  local Self := QSelf()

#translate METHOD <Type: FUNCTION, PROCEDURE> <*Met*> => ;
                 _METHOD_ <Type> <Met>

#translate METHOD <ClassName>::<*Met*>        => ;
                 _METHOD_ FUNCTION <Met>

#translate METHOD <ClassName>.<*Met*>         => ;
                 _METHOD_ FUNCTION <Met>

//   Sixtaxis Parent / Super
//   =======================

#xtranslate :Parent( <SupCls> ):<*M*> => :<SupCls>:<M>

#xtranslate :Parent:<*M*>             => :_sUPcLS_:<M>

#xtranslate Super:<*M*>               => Self:_sUPcLS_:<M>

#xtranslate :Super  => :Parent

//   Self
//  ======
#xtranslate ::      =>    Self:

//---------------------------
#else

  // Redefine el comando METHOD para la declaraciขnes de mtodos
  // en el bloque de clase.
  // Fue redefinido por el ฃltimo "endclass" para declarar cขdigo de mtodos.

#xcommand METHOD <*MDesc*> =>  _GEN_METHOD_ <MDesc>

#ifdef _sUPcLS_
#undef _sUPcLS_
#endif

#endif  // _OBJECTSP_CH
