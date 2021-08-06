@echo off & setlocal enableextensions

:: intkey.bat. Revised 5/9/2018. M.J. Dallwitz.

if "%1" equ "/?" (
   echo.
   echo Runs intkey5.exe.
   echo    Usage: INTKEY [/language] [initialization-file]
   echo For example, in a command window in the folder '\delta\sample\',
   echo 'intkey my.ink' opens the personalized initialization file 'my.ink'.
   echo The default initialization file is 'intkey.ink'.
   echo 'language' specifies a 2-letter language abbreviation, e.g. 'de'.
   echo The default is English.
   echo.
   echo For documentation of Intkey, see 'Help' within the program.
   exit /b 0
   )

set "pdir=%~dp0"

if "%1" neq "" goto params

:: No parameters. Run Intkey.
if exist intkey.ink (start "" "%pdir%intkey5.exe" intkey.ink) else (
   start "" "%pdir%intkey5.exe")
goto end

:: Parameters.
:params
set "p1=%1"
set lan=
if "%p1:~0,1%" neq "/" goto run
:: Language specified.
set "lan=intk%p1:~1%.hin"
set "lan=%pdir%%lan%
if not exist %lan% goto nolan
set "lan=-h=%lan%"
shift

:: Run Intkey. 
:run
if "%1" neq "" goto files
if exist intkey.ink (start "" "%pdir%intkey5.exe" %lan% intkey.ink) else (
   start "" "%pdir%intkey5.exe" %lan%)
goto end
:files
start "" "%pdir%intkey5.exe" %lan% %1 %2 %3 %4
goto end

:nolan
echo.
echo Intkey 'help' file '%lan%' does not exist.
exit /b 1

:end   
exit /b 0


