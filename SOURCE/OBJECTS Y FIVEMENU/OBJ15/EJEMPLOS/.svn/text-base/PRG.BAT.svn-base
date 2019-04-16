@ECHO OFF
CLS
SET INCLUDE=C:\COMPILAD\CLIPPER5\INCLUDE;
SET LIB=D:\;
SET TMP=D:

IF NOT EXIST D:CLIPPER.LIB  COPY C:\COMPILAD\CLIPPER5\LIB\CLIPPER.LIB  D:
IF NOT EXIST D:EXTEND.LIB   COPY C:\COMPILAD\CLIPPER5\LIB\EXTEND.LIB   D:
IF NOT EXIST D:TERMINAL.LIB COPY C:\COMPILAD\CLIPPER5\LIB\TERMINAL.LIB D:
IF NOT EXIST D:DBFNTX.LIB   COPY C:\COMPILAD\CLIPPER5\LIB\DBFNTX.LIB   D:
// IF NOT EXIST D:CLIP4WIN.LIB COPY C:\COMPILAD\CLIPPER5\LIB\CLIP4WIN.LIB D:
IF NOT EXIST D:SDE501.LIB   COPY F:\UTIL\SDE501\LIB\SDE501.LIB         D:
IF NOT EXIST D:SDE501.LIB   COPY C:\SDE501\LIB\SDE501.LIB              D:

OPCION PRGÿ1.-EXEÿ2.-DEBUGÿ3.-PPOÿ4.-SDE501ÿ5.-WINEXEÿ6.-OBJÿ7.-TDEBUGGER 1 2 3 4 5 6 7

IF ERRORLEVEL 7 GOTO TDEBUGGER
IF ERRORLEVEL 6 GOTO OBJ
IF ERRORLEVEL 5 GOTO WINEXE
IF ERRORLEVEL 4 GOTO SDE
IF ERRORLEVEL 3 GOTO PPO
IF ERRORLEVEL 2 GOTO DEBUG
IF ERRORLEVEL 1 GOTO EXE
ECHO NO SE ELIGIO NADA
GOTO END

:EXE
ECHO GENERANDO EXE...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /n
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\BLINKER FI %1 LIB ..\lib\objects, ..\lib\clases
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
C:\COMPILAD\CLIPPER5\BIN\BLINKER FI %1 LIB ..\lib\objects, ..\lib\clases
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

:SDE
ECHO A¥ADIENDO MODULO A SDE501...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /n
ECHO -------------------------------------------------------------------------------
LIB F:\UTIL\SDE501\LIB\SDE501 -+ %1.OBJ,,
COPY F:\UTIL\SDE501\LIB\SDE501.LIB D:
MT FIN /N
DEL %1.OBJ
GOTO END

:WINEXE
ECHO PREPARANDO EXE PARA WINDOWS...
MT INICIO /LOG
ECHO -------------------------------------------------------------------------------
C:\COMPILAD\CLIPPER5\BIN\CLIPPER %1 /N
ECHO -------------------------------------------------------------------------------
LINK /se:800 %1 ,,nul, BWCC + clip4win + ObjWin + Sde501 + mmsystem, ObjWin.def
ECHO -------------------------------------------------------------------------------
// c:\compilad\borlandc\bin\RC -K %1.rc %1.exe
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
c:\compilad\borlandc\bin\tlink %1 -v,,,d:clipper+d:extend+d:dbfntx+d:terminal+d:Sde501
ECHO -------------------------------------------------------------------------------
MT FIN /N
DEL %1.OBJ
IF ERRORLEVEL 1 GOTO END
c:\compilad\borlandc\td\td286 %1
GOTO END

:END
SET BIN=
SET INCLUDE=
SET LIB=
SET TMP=
