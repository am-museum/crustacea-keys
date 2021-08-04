@echo off & setlocal enableextensions & echo.

if "%1" equ "/?" (
   echo runall.bat runs all action sets ^(directives files^) required for
   echo Web distribution of a dataset. If there is a parameter
   echo ^(e.g. 'runall x'^), the revision date is set to the current date.
   echo.
   echo If a dataset needs a special version of runall.bat, copy runall.bat
   echo from the DELTA folder to the data folder, and edit the copy as necessary.
   echo.
   echo This version of runall.bat is specific to the DELTA sample data:
   echo it runs 'confor tokey' and 'key key5h'.
exit /b 0
   )

if "%~1" neq "" call dataver || goto abort

call confor toint || goto abort
call confor tonatsr || goto abort
call confor printch || goto abort
call confor tonath || goto abort
call confor tokey || goto abort
call key key5h || goto abort

call finish && goto end

:abort
echo.
echo    ***** 'runall.bat' failed.
exit /b 1

:end
exit /b 0
