@echo off & echo.

:: webnam.bat for DELTA sample data. Revised 10/5/2019. M.J. Dallwitz.

if "%1" equ "/?" (
   echo    Sets dataset name and folder names for uploading a DELTA Web package.
   echo    The names of files to be uploaded should be in webadd.bat.
   echo    An environment variable 'up' must contain the base folder from which
   echo    datasets will be uploaded, e.g. 'D:\uploads'.
   exit /b 0
   )

:: Set an abbreviation for name of the dataset. Must not include blanks.
set dataname=sample
:: Set the URL of the Web folder.
set "webdir=http://www.delta-intkey.com/%dataname%/"
:: Set the local folder from which the dataset will be uploaded.
if "%up%" equ "" goto no_up
call chkdir_ %up% || goto abort
set "updir=%up%\%dataname%"
goto end

:no_up
echo.
echo    webnam.bat - environment variable 'up' is undefined.

:abort
echo.
echo    webnam.bat failed.
exit /b 1

:end
exit /b 0
