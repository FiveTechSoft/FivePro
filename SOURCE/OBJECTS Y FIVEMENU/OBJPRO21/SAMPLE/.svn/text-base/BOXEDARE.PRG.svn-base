/*
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ Mขdulo: BoxedAre.prg  -> Boxed ScreenArea                     บ
บ Lenguaje: Clipper 5.xx + ObjectsP                             บ
บ Fecha: Agosto  1993                                           บ
บ Compilar: Clipper BoxedAre /a /n /w                           บ
บ Desc.:Demo de Herencia de la clase ScreenArea                 บ
บ                                                               บ
บ (c) 1993 Francisco Pulpขn  y Antonio Linares                  บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

#include "ObjectsP.ch"

#define DEFAULT_BOX         "ฺฤฟณูฤภณ"

#ifdef   DEMO_BOX  // Enlazar conjuntamente con ScreenAr.prg
  
   Function BoxTest()
     local oBox 

     CLEAR SCREEN

     oBox = BoxedArea():New( 5, 10, 20, 72,, "w+/b", "w/b" )

     oBox:say( 2, 4, "Esto est  escrito en una 'BoxedArea' con el mtodo 'Say'" )
     oBox:Say( 4, 4, "La Caja tiene " + str( oBox:nHeight(), 3 ) + " lineas de alto." )
     oBox:Say( 6, 4, "La Caja tiene " + str( oBox:nWidth(), 3 ) + " columnas de ancho." )

     oBox:say( 10, 12, "Pulsa una tecla para ocultarla" )
     inkey(0)

     oBox:Hide()

     @ 12, 4 say "Pulsa un tecla para que la caja aparezca de nuevo aquก"
     inkey(0)

     oBox:Show()

     oBox:cTextClr = "w+/b*"
     oBox:say( 10, 10, "   Pulsa una tecla para moverla   " )
     inkey(0)

     oBox:Move( -2, 6 )
     inkey(0)

     oBox:Move( +6, -6 )
     inkey(0)
     
     oBox:Move( -8, -8 )
     oBox:say( 10, 10, "Pulsa una tecla para ocultarla y terminar." )
     inkey(0)
     oBox:Hide()

   Return nil

#endif



 /************
 */

 CLASS BoxedArea FROM ScreenArea

       EXPORT DATA   cBoxDef     ,;  // Tipo de caja.
                     cBorderClr  ,;  // Color de la caja
                     cTextClr    ;   // Color del texto.
              AS Char
    
    PROTECT CLASSVAR   nBoxes  AS Numeric // Numero de instancias creadas
                                          // por la clase.

    METHOD  New( nTop,nLeft,nBottom,nRight,cBoxDef,cBorderClr,cTextClr ) ,;
            Draw()                                                       ,;
            Clear()                                                      ,;
            Say( nRow, nCol, uText )

 ENDCLASS


METHOD BoxedArea::New( nTop, nLeft, nBottom, nRight, cBoxDef, cBorderClr, cTextClr )

    DEFAULT cBoxDef    = DEFAULT_BOX ,;
            cBorderClr = "w+/n"      ,;
            cTextClr   = "w/n"

    ::Super:New( nTop, nLeft, nBottom, nRight )

    ::cBoxDef    := cBoxDef
    ::cBorderClr := cBorderClr
    ::cTextClr   := cTextClr

    ::Draw()

    if ::nBoxes == NIL
       ::nBoxes = 1
    else
       ::nBoxes++
    endif

RETURN Self


METHOD BoxedArea::Draw()

    @ ::nTop, ::nLeft, ::nBottom, ::nRight BOX ::cBoxdef COLOR ::cBorderClr

    ::Clear()

RETURN nil


METHOD BoxedArea::Clear()

   @ ::nTop + 1, ::nLeft + 1 , ::nBottom - 1, ::nRight - 1 ;
     BOX space(9) COLOR ::cTextClr

Return Nil


METHOD BoxedArea::Say( nRow, nCol, uText )

   @ ::nTop + nRow, ::nLeft + nCol SAY uText COLOR ::cTextClr

Return nil
