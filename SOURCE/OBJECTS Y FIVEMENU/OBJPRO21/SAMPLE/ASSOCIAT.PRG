/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: Associat.prg                                          บ
บ Lenguaje: Clipper 5.xx + ObjectsP                             บ
บ Fecha: Agosto  1993                                           บ
บ Compilar: Clipper Associat /a /n /w                           บ
บ Desc.:Demo/Test de la clase Association                       บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn y Antonio Linares                   บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

#include "ObjectsP.ch"

CLASS Association

     PROTECT INSTVAR cKey AS CHARACTER

     INSTVAR  uValue

     METHOD New( cKey, uVal ) INLINE  ::cKey := If( cKey == NIL, "", cKey ),;
                                ::uValue := If( uVal == NIL,  0, uVal ), Self

ENDCLASS
