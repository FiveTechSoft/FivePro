@echo off

space

if errorlevel 1 goto NoEspacio
echo Ok. Vamos a instalar
goto fin

:NoEspacio
echo No hay espacio sufiente en disco para instalar

:fin
