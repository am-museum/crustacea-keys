@echo off & setlocal enableextensions

:: natreord.bat for DELTA sample data. Revised 13/9/2016. M.J. Dallwitz.

if "%1" equ "/?" (
   echo.
   echo Generates descriptions with a different character order.
   echo The new character order is specified in a Delfor directives file 'natreord'.
   echo The reordered data and directives files are placed in a subfolder 'neworder'.
   exit /b 0
   )

echo.
call chkw32_ Delfor || goto abort

:: If necessary, create directory 'neworder' for reordered files.
if not exist neworder\ md neworder
set chkfil_=0
call checkfile1_ natreord || goto abort

echo Reordering files.
start /b /wait delfor natreord || goto abort

:: Move reordered files to 'neworder' directory.
set chkfil_=0
call chkfil_ specs.new
call chkfil_ chars.new
call chkfil_ items.new
call chkfil_ empchari.new
call chkfil_ empcharm.new
call chkfil_ layout.new
call chkfil_ newpar.new
if %chkfil_% neq 0 goto abort
move specs.new neworder\specs || goto abort
move chars.new neworder\chars || goto abort
move items.new neworder\items || goto abort
move empchari.new neworder\empchari || goto abort
move empcharm.new neworder\empcharm || goto abort
move layout.new neworder\layout || goto abort
move newpar.new neworder\newpar || goto abort

:: Copy other necessary files to 'neworder' directory.
set copfil_=0
call copfiq_ tonatr neworder
call copfiq_ markrtf neworder
if %copfil_% neq 0 goto abort

:: Move to 'neworder' directory and generate descriptions.
echo.
echo Generating descriptions.
cd neworder
call confor tonatr
if errorlevel 0 goto end

:abort
echo    Program aborted.
exit /b 1

:end
exit /b 0
