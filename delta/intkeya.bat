@echo off & setlocal enableextensions

:: intkeya.bat. Revised 31/8/2020. M.J. Dallwitz.

set p="C:\Program Files (x86)\Open DELTA\intkey.exe"

if "%1" equ "/?" (
   echo.
   echo Runs ALA ^(Open DELTA^) Intkey.
   echo    Usage: INTKEYA intialization-file
   echo If an intialization file is not specified, it defaults to intkey.ink.
   echo.
   echo For documentation of Intkey, see delta-intkey.com/www/intkey-.htm.
   echo There is also a 'Help' menu in the program.
   if not exist %p% goto noprogram
   exit /b 0
   )

if not exist %p% goto noprogram
echo.
if "%1%"=="" (
call %p% intkey.ink) else (
call %p% "%~f1")

echo -------------------------------------------------------------------------------
call getiny_ "Continue [y]?"
if %errorlevel% equ 1 exit /b 1
exit /b 0

:noprogram
echo.
echo The ALA program %p%
echo does not exist. To install this and other ALA programs, run
echo 'open-delta-1.02-Installer-NOJRE.exe', which may be obtained from
echo 'https://downloads.ala.org.au/p/Open DELTA'.
exit /b 1
