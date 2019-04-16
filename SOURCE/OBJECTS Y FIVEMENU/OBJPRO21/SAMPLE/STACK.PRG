/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: Stack.prg                                             บ
บ Lenguaje: Clipper 5.0x + ObjectsP                             บ
บ Fecha: Marzo  1993                                            บ
บ Compilar: Clipper Stack    /a /n /w                           บ
บ Desc.:Demo de clases: Stack Class                             บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

#include "ObjectsP.ch"


CLASS Stack

    HIDE DATA   aStack  AS  Array

    METHOD  New()         INLINE  ::aStack := {}, Self
    METHOD  Push( uVal )  INLINE  aadd( ::aStack, uVal ), uVal
    METHOD  Top()         INLINE  atail( ::aStack )
    METHOD  lEmpty()      INLINE  Empty( ::aStack )

    METHOD  Pull

ENDCLASS


METHOD Stack.Pull()

    local uRet, aStack := ::aStack

    if !Empty( aStack )

        uRet = aTail( aStack )
        aSize( aStack, len( aStack ) - 1 )

    endif

Return uRet
