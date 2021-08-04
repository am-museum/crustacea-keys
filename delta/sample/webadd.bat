@echo off & setlocal enableextensions & echo.

:: webadd.bat for DELTA sample data. Revised 6/5/2019. M.J. Dallwitz.
:: Checks the existence of files needed for Web distribution,
:: and adds their names to a list. Called by webgen.bat.

if "%~1" equ "/?" (call :usage & exit /b)

set addfil_=0

if "%1%" equ "" goto e-par
if "%1%" equ "intkey" goto intkey
if "%1%" equ "data" goto data
if "%1%" equ "general" goto general
goto e-par

:: Files to be included in the Intkey zipfile.
:intkey

call addfil_ ichars
call addfil_ iitems
call addfil_ *.bmp
call addfil_ intkey*.ink
call addfil_ *.inp

goto finish

:: Files to be include in the 'data' zipfile.
:data

call addfil_ *.
call addfil_ *.bat
call addfil_ *.bmp
call addfil_ *.css
call addfil_ *.dlt
call addfil_ *.doc*
call addfil_ *.gif
call addfil_ *.htm*
call addfil_ *.ink
call addfil_ *.inp
call addfil_ %img%\*.*
call addfil_ %inf%\*.*
call addfil_ %www%\*.*

goto finish

:: Files to be placed (unzipped) on the Web site.
:general

call addfil_ style.css
call addfil_ *.gif
call addfil_ *.htm*
call addfil_ webstart.ink

goto finish

:e-par
echo    Parameter error in call to 'webadd.bat'.
endlocal
exit /b 1

:finish
if %addfil_% neq 0 exit /b 1
exit /b 0

:: -------------------------------------------------------------------
:usage :: Subroutine
echo.
echo webadd.bat checks the existence of files needed for Web distribution,
echo and adds their names to a list. webadd.bat is called by webgen.bat.
echo.
echo If webgen.bat needs a special version of webadd.bat, copy webadd.bat
echo from the DELTA folder to the data folder, and edit the copy as necessary.
echo.
echo This version of webadd.bat is specific to the DELTA sample data:
echo the 'data' zipfile includes *.dlt and the character and taxon images,
echo and does not include *.txt.
echo.
echo    Usage: WEBADD fileset
echo.
echo 'fileset' receives 'intkey', 'data', or 'general'.
echo If a file does not exist, an error message is displayed
echo and ERRORLEVEL is set to 1.
echo If a file exists, its name is appended to addfil_.tmp.
echo.
exit /b 0