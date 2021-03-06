/*
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
� M�dulo: ScreenAr.prg                                          �
� Lenguaje: Clipper 5.xx + ObjectsP                             �
� Fecha: Agosto  1993                                           �
� Compilar: Clipper ScreenAr /a /n /w                           �
� Desc.:Demo de Clases                                          �
�                                                               �
� (c) 1993 Francisco Pulp�n y Antonio Linares                   �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
*/

  // El scoping de "Type" le proporcionar� un gran ahorro de c�digo
  // En este ejemplo de clase se podr�a haber hecho que las variables
  // "nTop, nLeft, nBottom, nRight" tuvieran Scope de acceso protegido
  // "PROTEDTED:" para impedir que se cambien sus valores desde fuera
  // de la clase y por tanto necesitar uno o varios metodos SET para
  // actualizar las variables con c�digo de comprobaci�n de tipo. La
  // implementaci�n de la Proteci�n de TYPE nos ahorra ese trabajo
  // y adem�s nos avisa en tiempo de ejecuci�n sobre el acceso
  // erroneo, siendo muy �til en la depuraci�n del c�digo.




#include "ObjectsP.ch"

 CLASS ScreenArea

       VAR      nTop   ,;
                nLeft  ,;
                nBottom,;
                nRight  ;
                           AS NUMERIC

       VAR      cImage, cBackImage ;
                                      AS CHAR, NIL  READONLY

                // Puedes definir metodos como prototipos de funciones.
                // No afecta la codificaci�n pero ayuda mucho a
                // documentar las clases.

        METHOD  New( nTop, nLeft, nBottom, nRight ) ,; // with "prototyping"
                Show    ,;
                Hide    ,;
                Move

        METHOD nWidth()  INLINE  ::nRight - ::nLeft + 1

        METHOD nHeight() INLINE  ::nBottom - ::nTop + 1

 ENDCLASS



METHOD ScreenArea::New( nTop, nLeft, nBottom, nRight )

    DEFAULT nTop = 0, nLeft = 0, nBottom = maxrow(), nRight = maxcol()

    ::nTop    = nTop
    ::nLeft   = nLeft
    ::nBottom = nBottom
    ::nRight  = nRight

    ::cBackImage = savescreen( nTop, nLeft, nBottom, nRight )

Return Self



METHOD ScreenArea::Show()


   if ::cImage != NIL

      ::cBackImage = savescreen( ::nTop, ::nLeft, ::nBottom, ::nRight )
      restscreen( ::nTop, ::nLeft, ::nBottom, ::nRight, :: cImage )
      ::cImage = NIL

   endif

Return nil



METHOD ScreenArea::Hide()
    ::cImage = savescreen( ::nTop, ::nLeft, ::nBottom, ::nRight )
    restscreen( ::nTop, ::nLeft, ::nBottom, ::nRight, :: cBackImage )
    ::cBackImage = NIL
Return nil



METHOD ScreenArea::Move( nRows, nCols )
   local lShowed := ::cImage == NIL

   DISPBEGIN()
   
     if lShowed
        ::Hide()
     endif
     
     ::nBottom  += nRows
     ::nRight   += nCols
     ::nTop     += nRows
     ::nLeft    += nCols

     if lShowed
        ::Show()
     endif

   DISPEND()

Return nil
