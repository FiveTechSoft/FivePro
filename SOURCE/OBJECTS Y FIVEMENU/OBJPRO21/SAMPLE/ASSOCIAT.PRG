/*
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
� M�dulo: Associat.prg                                          �
� Lenguaje: Clipper 5.xx + ObjectsP                             �
� Fecha: Agosto  1993                                           �
� Compilar: Clipper Associat /a /n /w                           �
� Desc.:Demo/Test de la clase Association                       �
�                                                               �
� (c) 1993 Francisco Pulp�n y Antonio Linares                   �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
*/

#include "ObjectsP.ch"

CLASS Association

     PROTECT INSTVAR cKey AS CHARACTER

     INSTVAR  uValue

     METHOD New( cKey, uVal ) INLINE  ::cKey := If( cKey == NIL, "", cKey ),;
                                ::uValue := If( uVal == NIL,  0, uVal ), Self

ENDCLASS
