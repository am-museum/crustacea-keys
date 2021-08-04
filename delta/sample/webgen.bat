@echo off & setlocal enableextensions & echo.

:: webgen.bat for DELTA sample data. Revised 19/7/2019. M.J. Dallwitz.
:: Prepares files for uploading a DELTA Web package.
:: Includes images and HTML descriptions with inline images.

if "%~1" equ "/?" (call :usage & exit /b)

:: Set folder and file names.
::    'dataname' = name of dataset.
::    'webdir' = URL of Web folder (used by webink_.bat).
::    'updir' = local folder from which the dataset will be uploaded.
if not exist webnam.bat goto no_webnam
call webnam || goto abort

if "%dataname%" equ "" goto no_dataname
if "%webdir%" equ "" goto no_webdir
call chkdiq_ %updir%
if errorlevel 2 goto abort
if errorlevel 1 md %updir%
call chkdir_ %updir% || goto abort

set "img=images"
set "inf=info"
set "www=www"
set "wwwi=wwwi"
call chkdir_ %inf% || goto abort
call chkdir_ %www% || goto abort
call chkdir_ %wwwi% || goto abort

set "zpd=%dataname%data.zip"
set "zpi=intkeyw.zip"
set "zpw=%cd%\%dataname%.zip"

call lcase

:: Set variable 'webdataexc' containing the name of the exclusion file
:: for generating the zipfile for the DELTA-format data files.
call webdataexc_ || goto abort

:: Check presence of Intkey files.
if exist addfil_.tmp del addfil_.tmp > nul
call webadd intkey || goto abort

:: Modify intkey.ink for Web.
call webink_ || goto abort

:: Zip Intkey files.
if exist %zpi% del %zpi% > nul
call zip -Doq %zpi% * -i@addfil_.tmp
if exist *.bak del *.bak > nul
echo    Intkey files processed.

:: Activate this statement if you don't want to put the DELTA-format data files on the Web.
:: goto skipped

:: Generate image-links file.
call chkdiq_ %img% || goto checkdata
if "%1" neq "" goto checkdata
call webimg_ || goto abort

:: Check presence of data files.
:checkdata
if exist addfil_.tmp del addfil_.tmp > nul
call webadd data || goto abort

:: Zip data files.
if exist %zpd% del %zpd% > nul
call zip -Doq %zpd% * %img%\* %inf%\* %www%\* %wwwi%\* -i@addfil_.tmp -x@%webdataexc%
echo    Data files processed.

:: Resume here if generation of a data zipfile has been skipped
:skipped

:: Check presence of Web files.
if exist addfil_.tmp del addfil_.tmp > nul
call webadd general || goto abort
call addfil_ %zpi% || goto abort
if exist %zpd% call addfil_ %zpd% || goto abort

call getiny_ "Add descriptions [y]?"
if errorlevel 1 goto no_desc
call addfil_ %inf%\* || goto abort
call addfil_ %www%\* || goto abort
call addfil_ %wwwi%\* || goto abort

:: Zip Web files.
if exist %zpw% del %zpw% > nul
call zip -Doq %zpw% * %inf%\* %www%\* %wwwi%\* -i@addfil_.tmp
echo.
echo    Web files (including descriptions) processed.
goto finish

:no_desc
if exist %zpw% del %zpw% > nul
call zip -Doq %zpw% * -i@addfil_.tmp
echo.
echo    Web files (without descriptions) processed.
goto finish

:no_webnam
echo    'webgen.bat' - 'webnam.bat' not found.
goto abort

:no_dataname
echo    'webgen.bat' - variable 'dataname' is undefined.
goto abort

:no_webdir
echo    'webgen.bat' - variable 'webdir' is undefined.

:abort
echo.
echo    ***** 'webgen.bat' failed.
exit /b 1

:finish
echo.
call showfilepathsize_ "%zpw%"
if exist addfil_.tmp del addfil_.tmp > nul
if exist %zpd% del %zpd% > nul
if exist %zpi% del %zpi% > nul
cd /d %updir% || exit /b 1
call unzip -ouq "%zpw%"
del "%zpw%"

exit /b 0

:: -------------------------------------------------------------------
:usage :: Subroutine
echo.
echo Prepares files for uploading a DELTA Web package.
echo Before running webgen.bat, run Confor and other DELTA programs as
echo necessary to update the relevant files - see runall.bat.
echo.
echo The dataset name and folder names are set in webnam.bat, which is
echo specific to each dataset. There is an example in the DELTA sample data.
echo Copy that example to your data folder, and edit the copy as necessary.
echo.
echo The names of files to be uploaded are set in webadd.bat. The general
echo version, which is in the main DELTA folder, will be suitable for many
echo datasets. If a dataset needs a special version, copy webadd.bat from
echo the DELTA folder to the data folder, and edit the copy as necessary.
echo.
exit /b 0