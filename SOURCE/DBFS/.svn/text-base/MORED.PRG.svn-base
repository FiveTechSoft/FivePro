

function lAbrir( cFile, lMode, nTime )

PARAMETERS FICHERO, MODO_USO, ESPERA
PRIVATE INSTANTE
INSTANTE = (ESPERA = 0)
DO WHILE (INSTANTE .OR. ESPERA > 0)
   IF MODO_USO
      USE &FICHERO EXCLUSIVE
   ELSE
      USE &FICHERO
   ENDIF
   IF .NOT. NETERR()
      RETURN (.T.)
   ENDIF
   INKEY(1)
   ESPERA = ESPERA - 1
ENDDO
RETURN (.F.)

*******************************************************************************
*********** BLOQUEO DE FICHEROS ******************
*******************************************************************************
FUNCTION F_LLAVE
PARAMETERS ESPERA
PRIVATE INSTANTE
IF FLOCK()
   RETURN (.T.)
ENDIF
INSTANTE = (ESPERA = 0)
DO WHILE (INSTANTE .OR. ESPERA > 0)
   INKEY(.5)
   ESPERA = ESPERA - .5
   IF FLOCK()
      RETURN (.T.)
   ENDIF
ENDDO
RETURN (.F.)

*******************************************************************************
*********** BLOQUEO DE REGISTROS **************
*******************************************************************************
FUNCTION R_LLAVE
PARAMETERS ESPERA
PRIVATE INSTANTE
IF RLOCK()
   RETURN (.T.)
ENDIF
INSTANTE = (ESPERA = 0)
DO WHILE (INSTANTE .OR. ESPERA > 0)
   INKEY(.5)
   ESPERA = ESPERA - .5
   IF RLOCK()
      RETURN (.T.)
   ENDIF
ENDDO
RETURN (.F.)

*******************************************************************************
************** A¥ADIR REGISTROS EN UN FICHERO *************
*******************************************************************************
FUNCTION INSERTAR
PARAMETERS ESPERA
PRIVATE INSTANTE
APPEND BLANK
IF .NOT. NETERR()
   RETURN (.T.)
ENDIF
INSTANTE = (ESPERA = 0)
DO WHILE (INSTANTE .OR. ESPERA > 0)
   APPEND BLANK
   IF .NOT. NETERR()
      RETURN (.T.)
   ENDIF
   INKEY(.5)
   ESPERA = ESPERA - .5
ENDDO
RETURN (.F.)


*******************************************************************************
**** GESTION FICHEROS EN FORMATO VERTICAL ****
*******************************************************************************
PROCEDURE LB1_WIN
PARAMETERS INI_FILA,INI_COL,FIN_FILA,FIN_COL,DATOS
PRIVATE    REGISTRO, P1, RES, FILA
GO TOP
FILA = INI_FILA
SET COLOR TO &NORMAL
@ 22, 1 SAY '     <A> A¤adir   <M> Modificar   <B> Borrar   <L> Localizar   <ESC> Salir    '
@ 23, 1 SAY ' Seleccionar con Teclas:   <>  <>     <INI>  <FIN>     <RE PAG>  <AV PAG>   '
SET COLOR TO &INTENSIDAD
IF DATOS # "D_INTSAL" .AND. DATOS # "D_BALA"
   @ 22, 7 SAY 'A'
   @ 22,36 SAY 'B'
ENDIF
IF DATOS = "D_CUENTA"
   SET COLOR TO &NORMAL
   @ 23, 1 SAY "     <D> Desgloses       "
   SET COLOR TO &INTENSIDAD
   @ 23, 7 SAY "D"
ENDIF
@ 22,20 SAY 'M'
@ 22,49 SAY 'L'
@ 22,65 SAY 'ESC'
@ 23,29 SAY ''
@ 23,34 SAY ''
@ 23,42 SAY 'INI'
@ 23,49 SAY 'FIN'
@ 23,59 SAY 'RE PAG'
@ 23,69 SAY 'AV PAG'
DO WHILE .NOT. EOF() .AND. FILA<FIN_FILA
   DO &DATOS WITH "S",FILA
   SKIP
   FILA = FILA + 1
ENDDO
FILA = INI_FILA
GO TOP
DO WHILE .T.
   SET COLOR TO &INVERSO
   DO &DATOS WITH "S",FILA
   SET COLOR TO &INTENSIDAD
   SET CURSOR OFF
   A = 0
   DO WHILE A = 0
      A = INKEY()
   ENDDO
   IF (DATOS = "D_INTSAL" .OR. DATOS = "D_BALA") .AND. (A = 65 .OR. A = 97)
      LOOP
   ENDIF
   IF A = 65 .OR. A = 97
      CLEAR TYPE
      IF EOF()
	 KEYBOARD CHR(77)
      ELSE
	 KEYBOARD CHR(6) + CHR(24) + CHR(77)
      ENDIF
   ENDIF
   SET CURSOR ON
   DO CASE
      CASE A = 27
	   **** SALIR
	   SET COLOR TO &INTENSIDAD
	   DO &DATOS WITH "S", FILA
	   @ 23, 1 CLEAR TO 23, 78
	   EXIT
      CASE ( A = 66 .OR. A = 98 ) .AND. .NOT. EOF()
	   **** BORRA REGISTRO ACTUAL
	   RES = "N"
	   SET COLOR TO &INTENSIDAD
	   DO &DATOS WITH "D", FILA
	   IF RES $ "Ss"
	      R_LLAVE(0)
	      DELETE
	      UNLOCK
	      IF EOF() .AND. BOF()
		 @ FILA,INI_COL CLEAR TO FIN_FILA-1,FIN_COL
		 FILA = INI_FILA
		 GO TOP
	      ELSE
		 SKIP
		 IF EOF()
		    GO BOTTOM
		    SKIP - (FIN_FILA - 1 - INI_FILA)
		    @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
		    FILA = INI_FILA
		    DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA - 1
		    DO &DATOS WITH "S", FILA
		       SKIP
		       FILA = FILA + 1
		    ENDDO
		 ELSE
		    FILA_AUX = FILA
		    REGISTRO = RECNO()
		    DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		       DO &DATOS WITH "S",FILA
		       SKIP
		       FILA = FILA + 1
		    ENDDO
		    IF FILA - 1 # FIN_FILA
		       @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
		    ENDIF
		    FILA = FILA_AUX
		    GO REGISTRO
		 ENDIF
	      ENDIF
	   ENDIF
      CASE A = 77 .or. a = 109
	   **** MODIFICAR
	   DO &DATOS WITH "G",FILA
      CASE A = 5 .AND. .NOT. BOF()
	   **** ANTERIOR
	   SET COLOR TO &INTENSIDAD
	   DO &DATOS WITH "S", FILA
	   SKIP - 1
	   IF BOF()
	      GO TOP
	   ELSE
	      FILA = FILA - 1
	      IF FILA = INI_FILA - 1
		 SKIP - (FIN_FILA - 1 - INI_FILA)
		 @ FILA + 1, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA - 1
		    DO &DATOS WITH "S", FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
	      ENDIF
	   ENDIF
      CASE A = 24 .AND. .NOT. EOF()
	   **** SIGUIENTE
	   SET COLOR TO &INTENSIDAD
	   DO &DATOS WITH "S", FILA
	   SKIP
	   FILA = FILA + 1
	   IF FILA >= FIN_FILA
	      FILA = INI_FILA
	      @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	      DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		 DO &DATOS WITH "S",FILA
		 SKIP
		 FILA = FILA + 1
	      ENDDO
	      SKIP - (FILA - INI_FILA)
	      FILA = INI_FILA
	   ENDIF
      CASE A = 1
	   **** PRINCIPIO
	   GO TOP
	   @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	   FILA = INI_FILA
	   DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
	      DO &DATOS WITH "S", FILA
	      SKIP
	      FILA = FILA + 1
	   ENDDO
	   SKIP - (FILA - INI_FILA)
	   FILA = INI_FILA
      CASE A = 6
	   **** FIN
	   GO BOTTOM
	   SKIP - (FIN_FILA - 1 - INI_FILA)
	   @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	   FILA = INI_FILA
	   DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA - 1
	   DO &DATOS WITH "S", FILA
	      SKIP
	      FILA = FILA + 1
	   ENDDO
      CASE A = 76 .OR. A = 108
	   ******* LOCALIZAR
	   DO &DATOS WITH "S", FILA
	   DO &DATOS WITH "B", FILA
	   FILA = INI_FILA
	   @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	   REGISTRO = RECNO()
	   DO WHILE .NOT. EOF() .AND. FILA < FIN_FILA
	      DO &DATOS WITH "S", FILA
	      SKIP
	      FILA = FILA + 1
	   ENDDO
	   FILA = INI_FILA
	   GO REGISTRO
      CASE A = 3
	   ****** AVANZAR PAGINA
	IF  .NOT. EOF()
	   FIL_ACT = FILA
	   REG_PRI = RECNO()
	   SKIP + (FIN_FILA - INI_FILA)
	   IF .NOT. EOF()
	      REG_ACT = RECNO()
	      SKIP - (FIL_ACT - INI_FILA)
	      @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
	      FILA = INI_FILA
	      DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		 DO &DATOS WITH 'S' , FILA
		 SKIP
		 FILA = FILA + 1
	      ENDDO
	      GO REG_ACT
	      FILA = FIL_ACT
	   ELSE
	      GO REG_PRI
	      SKIP (FIN_FILA - FIL_ACT)
	      IF .NOT. EOF()
		 @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		    DO &DATOS WITH 'S' , FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
		 IF FILA > FIL_ACT
		    FILA = FIL_ACT
		 ELSE
		    FILA = FILA - 1
		 ENDIF
	      ELSE
	      GO REG_PRI
	      ENDIF
	   ENDIF
	ENDIF
      CASE A= 18
	   ****** RETROCEDER PAGINA
	   SET COLOR TO &INTENSIDAD
	   DO &DATOS WITH 'S', FILA
	   FIL_ACT = FILA
	   REG_ACT = RECNO()
	   SKIP - (FIN_FILA - INI_FILA)
	   IF .NOT. BOF()
	      REG_ACT = RECNO()
	      SKIP - (FIL_ACT - INI_FILA)
	      IF .NOT. BOF()
		 @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		    DO &DATOS WITH 'S' , FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
		 GO REG_ACT
		 FILA = FIL_ACT
	      ELSE
		 GO TOP
		 @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		    DO &DATOS WITH 'S' , FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
		 GO TOP
		 SKIP (FIL_ACT - INI_FILA)
		 FILA = FIL_ACT
	      ENDIF
	   ELSE
	      GO TOP
	      @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
	      FILA = INI_FILA
	      DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		 DO &DATOS WITH 'S' , FILA
		 SKIP
		 FILA = FILA + 1
	      ENDDO
	      GO TOP
	      SKIP (FIL_ACT - INI_FILA)
	      IF RECNO() = REG_ACT
		 GO REG_ACT
	      ENDIF
	      FILA = FIL_ACT
	   ENDIF
      CASE A = 68 .or. a = 100
	   **** DESGLOSES SOLO PARA EL MODULO DE CUENTAS
	   DO &DATOS WITH "X",FILA
   ENDCASE
ENDDO
@ 22, 1 CLEAR TO 23, 78
RETURN

*******************************************************************************
**** GESTION FICHEROS PARA VISUALIZACION Y AYUDAS ****
*******************************************************************************
PROCEDURE LB1_AYU
PARAMETERS INI_FILA,INI_COL,FIN_FILA,FIN_COL,DATOS
PRIVATE    REGISTRO, P1, RES, FILA
GO TOP
FILA = INI_FILA
SET COLOR TO &INVERSO
@ 17,32 SAY '<L>ocali.  <S>elec.  <O>rden.  <ESC>apar '
@ 18,32 SAY '<>  <>  <INI>  <FIN>  <RE PAG>  <AV PAG>'
DO WHILE .NOT. EOF() .AND. FILA<FIN_FILA
   DO &DATOS WITH "S",FILA
   SKIP
   FILA = FILA + 1
ENDDO
FILA = INI_FILA
GO TOP
DO WHILE .T.
   SET COLOR TO &NORMAL
   DO &DATOS WITH "S",FILA
   SET COLOR TO &INVERSO
   SET CURSOR OFF
   A = 0
   DO WHILE A = 0
      A = INKEY()
   ENDDO
   SET CURSOR ON
   DO CASE
      CASE A = 27
	   **** SALIR
	   SET COLOR TO &INVERSO
	   DO &DATOS WITH "S", FILA
	   EXIT
      CASE A = 5 .AND. .NOT. BOF()
	   **** ANTERIOR
	   SET COLOR TO &INVERSO
	   DO &DATOS WITH "S", FILA
	   SKIP - 1
	   IF BOF()
	      GO TOP
	   ELSE
	      FILA = FILA - 1
	      IF FILA = INI_FILA - 1
		 SKIP - (FIN_FILA - 1 - INI_FILA)
		 @ FILA + 1, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA - 1
		    DO &DATOS WITH "S", FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
	      ENDIF
	   ENDIF
      CASE A = 24 .AND. .NOT. EOF()
	   **** SIGUIENTE
	   SET COLOR TO &INVERSO
	   DO &DATOS WITH "S", FILA
	   SKIP
	   FILA = FILA + 1
	   IF FILA >= FIN_FILA
	      FILA = INI_FILA
	      @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	      DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		 DO &DATOS WITH "S",FILA
		 SKIP
		 FILA = FILA + 1
	      ENDDO
	      SKIP - (FILA - INI_FILA)
	      FILA = INI_FILA
	   ENDIF
      CASE A = 1
	   **** PRINCIPIO
	   GO TOP
	   @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	   FILA = INI_FILA
	   DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
	      DO &DATOS WITH "S", FILA
	      SKIP
	      FILA = FILA + 1
	   ENDDO
	   SKIP - (FILA - INI_FILA)
	   FILA = INI_FILA
      CASE A = 6
	   **** FIN
	   GO BOTTOM
	   SKIP - (FIN_FILA - 1 - INI_FILA)
	   @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	   FILA = INI_FILA
	   DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA - 1
	   DO &DATOS WITH "S", FILA
	      SKIP
	      FILA = FILA + 1
	   ENDDO
      CASE A = 79 .OR. A = 111
	   ******* ORDENAR
	   DO &DATOS WITH "O"
      CASE A = 83 .OR. A = 115
	   ******* SELECCIONAR
	   DO &DATOS WITH "X"
	   EXIT
      CASE A = 76 .OR. A = 108
	   ******* LOCALIZAR
	   DO &DATOS WITH "S", FILA
	   DO &DATOS WITH "B", FILA
	   FILA = INI_FILA
	   @ FILA, INI_COL CLEAR TO FIN_FILA - 1, FIN_COL
	   REGISTRO = RECNO()
	   DO WHILE .NOT. EOF() .AND. FILA < FIN_FILA
	      DO &DATOS WITH "S", FILA
	      SKIP
	      FILA = FILA + 1
	   ENDDO
	   FILA = INI_FILA
	   GO REGISTRO
      CASE A = 3
	   ****** AVANZAR PAGINA
	IF  .NOT. EOF()
	   FIL_ACT = FILA
	   REG_PRI = RECNO()
	   SKIP + (FIN_FILA - INI_FILA)
	   IF .NOT. EOF()
	      REG_ACT = RECNO()
	      SKIP - (FIL_ACT - INI_FILA)
	      @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
	      FILA = INI_FILA
	      DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		 DO &DATOS WITH 'S' , FILA
		 SKIP
		 FILA = FILA + 1
	      ENDDO
	      GO REG_ACT
	      FILA = FIL_ACT
	   ELSE
	      GO REG_PRI
	      SKIP (FIN_FILA - FIL_ACT)
	      IF .NOT. EOF()
		 @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		    DO &DATOS WITH 'S' , FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
		 IF FILA > FIL_ACT
		    FILA = FIL_ACT
		 ELSE
		    FILA = FILA - 1
		 ENDIF
	      ELSE
	      GO REG_PRI
	      ENDIF
	   ENDIF
	ENDIF
      CASE A= 18
	   ****** RETROCEDER PAGINA
	   SET COLOR TO &INVERSO
	   DO &DATOS WITH 'S', FILA
	   FIL_ACT = FILA
	   REG_ACT = RECNO()
	   SKIP - (FIN_FILA - INI_FILA)
	   IF .NOT. BOF()
	      REG_ACT = RECNO()
	      SKIP - (FIL_ACT - INI_FILA)
	      IF .NOT. BOF()
		 @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		    DO &DATOS WITH 'S' , FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
		 GO REG_ACT
		 FILA = FIL_ACT
	      ELSE
		 GO TOP
		 @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
		 FILA = INI_FILA
		 DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		    DO &DATOS WITH 'S' , FILA
		    SKIP
		    FILA = FILA + 1
		 ENDDO
		 GO TOP
		 SKIP (FIL_ACT - INI_FILA)
		 FILA = FIL_ACT
	      ENDIF
	   ELSE
	      GO TOP
	      @ INI_FILA,INI_COL CLEAR TO FIN_FILA-1, FIN_COL
	      FILA = INI_FILA
	      DO WHILE .NOT. EOF() .AND. FILA # FIN_FILA
		 DO &DATOS WITH 'S' , FILA
		 SKIP
		 FILA = FILA + 1
	      ENDDO
	      GO TOP
	      SKIP (FIL_ACT - INI_FILA)
	      IF RECNO() = REG_ACT
		 GO REG_ACT
	      ENDIF
	      FILA = FIL_ACT
	   ENDIF
   ENDCASE
ENDDO
RETURN
*******************************************************************************
**** PINTAR MENSAJES CENTRADOS ****
*******************************************************************************

FUNCTION LB1_MEM
PARAMETERS LINEA, MENSAJE, COLOR, MODO,DEFECTO
PRIVATE P_LB001, ANT_COL, COL, RES

BEEP	= "TONE (150, 8)"
SWAIT	= "INKEY(0)"

**** PARA CARGAR LAS FUNCIONES
IF .F.
   INKEY()
   READKEY()
   TONE(0,0)
ENDIF

   RES	   = DEFECTO
   ANT_COL = SETCOLOR()
   P_LB001 = SAVESCREEN(22, 1, 23, 78)
   @ LINEA, 1 CLEAR TO LINEA, 78
   COL	= (80 - LEN(MENSAJE)) / 2
   SET COLOR TO &COLOR
   @ LINEA, COL SAY SPACE(1) + MENSAJE
   DO CASE
      CASE MODO = 1
	   IF &BEEP
	   ENDIF
	   IF &SWAIT = 1
	   ENDIF
	   RESTSCREEN (22, 1, 23, 78, P_LB001)
      CASE MODO = 2
	   @ LINEA, COL + LEN(MENSAJE) + 1 GET RES
	   READ
	   RESTSCREEN (22, 1, 23, 78, P_LB001)
   ENDCASE
   SETCOLOR(ANT_COL)

RETURN (RES)

*******************************************************************************
**** BORRAR VENTANAS DE LA PANTALLA INICIAL ****
*******************************************************************************

FUNCTION LB1_BPP
PARAMETERS MODO
   IF "1" $ MODO
      @  4, 1 CLEAR TO 20, 78
   ENDIF
   IF "2" $ MODO
      @ 22, 1 CLEAR TO 22, 78
   ENDIF

RETURN(.T.)

*******************************************************************************
**** RELLENAR CON UN CARACTER CADENAS TIPO CHAR ****
*******************************************************************************

FUNCTION LB1_FIL
PARAMETERS VAR_RELL, LONGITUD, CARACTER, MODO
PRIVATE PP
IF MODO = 1
   PP = REPLICATE(CARACTER, LONGITUD - LEN(ALLTRIM(VAR_RELL))) ;
	+ ALLTRIM(VAR_RELL)
ELSE
   PP = ALLTRIM(VAR_RELL) ;
	+ REPLICATE(CARACTER, LONGITUD - LEN(ALLTRIM(VAR_RELL)))
ENDIF
RETURN (PP)
*****************************************************************************

