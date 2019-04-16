@ECHO OFF
CLS
SET INCLUDE=C:\COMPILAD\CLIPPER5\INCLUDE;C:\FIVEPRO.20\INCLUDE;
SET LIB=C:\CLIPPER5\LIB
SET TMP=D:

IF NOT EXIST D:CLIPPER.LIB  COPY C:\COMPILAD\CLIPPER5\LIB\CLIPPER.LIB  D:
IF NOT EXIST D:EXTEND.LIB   COPY C:\COMPILAD\CLIPPER5\LIB\EXTEND.LIB   D:
IF NOT EXIST D:TERMINAL.LIB COPY C:\COMPILAD\CLIPPER5\LIB\TERMINAL.LIB D:
IF NOT EXIST D:DBFNTX.LIB   COPY C:\COMPILAD\CLIPPER5\LIB\DBFNTX.LIB   D:

OPCION PRGÿ1.-EXEÿ2.-DEBUGÿ3.-PPOÿ4.-FiveProÿ5.-WINEXEÿ6.-OBJÿ7.-TDEBUGGER 1 2 3 4 5 6 7

IF ERRORLEVEL 7 GOTO TDEBUGGER
IF ERRORLEVEL 6 GOTO OBJ
IF ERRORLEVEL 5 GOTO WINEXE
IF ERRORLEVEL 4 GOTO FIVEPRO
IF ERRORLEVEL 3 GOTO PPO
IF ERRORLEVEL 2 GOTO DEBUG
IF ERRORLEVEL 1 GOTO EXE
ECHO NO SE ELIGIO NADA
GOTO END

:EXE
ECHO GENERANDO EXE...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\CLIPPER5\BIN\CLIPPER %1 /n
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\BLINKER FI %1 LIB Text
ECHO -------------------------------------------------------------------------------
MT FIN /N
DEL %1.OBJ
IF ERRORLEVEL 1 GOTO END
%1
SET OBJ=
GOTO END

:DEBUG
ECHO GENERANDO EXE PARA DEBUG...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /N/B
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\BLINKER FI %1 LIB Text
ECHO -------------------------------------------------------------------------------
MT FIN /N
DEL %1.OBJ
IF ERRORLEVEL 1 GOTO END
C:\COMPILAD\CLIPPER5\BIN\CLD %1
GOTO END

:PPO
ECHO GENERANDO PPO CON PREPROCESADOR...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /N/P
ECHO -------------------------------------------------------------------------------
MT FIN /N
IF ERRORLEVEL 1 GOTO END
GOTO END

:FIVEPRO
ECHO A¥ADIENDO MODULO A FivePro...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /n
ECHO -------------------------------------------------------------------------------
LIB C:\FivePro.20\lib\FivePro2 -+ %1.OBJ,,
MT FIN /N
DEL %1.OBJ
GOTO END

:WINEXE
ECHO PREPARANDO EXE PARA WINDOWS...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /N
ECHO -------------------------------------------------------------------------------
LINK /se:800 %1 ,,, clip4win /INFORMATION > info
ECHO -------------------------------------------------------------------------------
MT FIN /N
DEL %1.OBJ
IF ERRORLEVEL 1 GOTO END
GOTO END

:OBJ
ECHO PREPARANDO OBJ...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /N
ECHO -------------------------------------------------------------------------------
MT FIN /N
GOTO END

:TDEBUGGER
ECHO PREPARANDO EXE PARA WINDOWS...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /N
ECHO -------------------------------------------------------------------------------
c:\compilad\borlandc\bin\tlink %1 -v,,,d:clipper+d:extend+d:dbfntx+d:terminal+Text
ECHO -------------------------------------------------------------------------------
MT FIN /N
DEL %1.OBJ
IF ERRORLEVEL 1 GOTO END
c:\compilad\borlandc\td\td386 %1
GOTO END

:END
SET BIN=
SET INCLUDE=
SET LIB=
SET TMP=
