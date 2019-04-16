// Implementaci¢n de un Stack -una pila- orientada al Objeto

// Este es un ejemplo en el que vamos a codificar todos los M‚todos
// utilizando Bloques de C¢digo

// (C) Antonio Linares, 1993

#include "Objects.ch"

//----------------------------------------------------------------------------//

CLASS TStack

   DATA   aData

   METHOD New()         BLOCK { | Self | ::aData := {}, Self }
   METHOD Push( uData ) BLOCK { | Self, uData | AAdd( ::aData, uData ) }
   METHOD Pop()         BLOCK { | Self, u | u := ATail( ::aData ),;
                           ASize( ::aData, Max( Len( ::aData ) - 1, 0 ) ), u }
   METHOD Len()         BLOCK { | Self | Len( ::aData ) }

ENDCLASS

//----------------------------------------------------------------------------//
