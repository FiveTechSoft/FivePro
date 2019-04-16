@echo off
SET PATH=C:\Clip53\BIN;C:\Clip00\BIN;C:\Clip00\NG;%PATH%
SET INCLUDE=C:\FiveTech\FP\INCLUDE;C:\Clip53\INCLUDE;
SET LIB=C:\FiveTech\FP\LIB;C:\Clip53\LIB;c:\Clip00\lib;
SET OBJ=C:\FiveTech\FP\OBJ;C:\Clip53\OBJ;c:\Clip00\obj;
SET PLL=C:\Clip53\PLL
rem set clippercmd=
PROMPT Clip52 - FP $P$g
IF "%1==" GOTO DEFECTO
CD %1
GOTO FIN
:DEFECTO
cd c:\FiveTech\FP\lolo
:FIN
