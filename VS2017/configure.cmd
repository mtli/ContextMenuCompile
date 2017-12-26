@echo off

rem Check VS installation
for /f "tokens=*" %%i in ('"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property installationPath') do set VSPATH=%%i
if "%VSPATH%"=="" (
echo Cannot find Visual Studio installation
goto error
)

rem Query registry to get VSCTYPE & VSCPPTYPE
for /f %%i in ('reg query HKCR\.c\OpenWithProgids ^| findstr VisualStudio.c') do set VSCTYPE=%%i
for /f %%i in ('reg query HKCR\.cpp\OpenWithProgids ^| findstr VisualStudio.cpp') do set VSCPPTYPE=%%i

rem Generate files from templates
call :replace_in_file "templates\compile.cmd", "compile.cmd", "#VSDIR#", "%VSPATH%"
set ESCAPECD=%CD:\=\\%
call :replace_in_file3 "templates\install.reg", "install.reg", "#VSCTYPE#", "%VSCTYPE%", "#VSCPPTYPE#", "%VSCPPTYPE%", "#CD#", "%ESCAPECD%"
call :replace_in_file2 "templates\uninstall.reg", "uninstall.reg", "#VSCTYPE#", "%VSCTYPE%", "#VSCPPTYPE#", "%VSCPPTYPE%"


echo Succesfully configured
echo Double click "install.reg" for installation and "uninstall.reg" for uninstallation.
echo Press any key to exit

pause > nul
exit /B 0

:error

pause > nul
exit /B 1


:replace_in_file
setlocal enabledelayedexpansion

set INFILE=%~1
set OUTFILE=%~2
set REPLACED=%~3
set REPLACING=%~4

set REPLACED=!REPLACED:^)=^^^)!
set REPLACING=!REPLACING:^)=^^^)!

if exist "%OUTFILE%" (del /f/q "%OUTFILE%")
for /f "usebackq tokens=*" %%i in ("%INFILE%") do (
          set line=%%i
          echo !line:%REPLACED%=%REPLACING%!>>"%OUTFILE%"
    )

exit /B 0

:replace_in_file2
setlocal enabledelayedexpansion

set INFILE=%~1
set OUTFILE=%~2
set REPLACED1=%~3
set REPLACING1=%~4
set REPLACED2=%~5
set REPLACING2=%~6

set REPLACED1=!REPLACED1:^)=^^^)!
set REPLACING1=!REPLACING1:^)=^^^)!
set REPLACED2=!REPLACED2:^)=^^^)!
set REPLACING2=!REPLACING2:^)=^^^)!

if exist "%OUTFILE%" (del /f/q "%OUTFILE%")
for /f "usebackq tokens=*" %%i in ("%INFILE%") do (
          set line=%%i
          set line=!line:%REPLACED1%=%REPLACING1%!
		  echo !line:%REPLACED2%=%REPLACING2%!>>%OUTFILE%
    )

exit /B 0

:replace_in_file3
setlocal enabledelayedexpansion

set INFILE=%~1
set OUTFILE=%~2
set REPLACED1=%~3
set REPLACING1=%~4
set REPLACED2=%~5
set REPLACING2=%~6
set REPLACED3=%~7
set REPLACING3=%~8

set REPLACED1=!REPLACED1:^)=^^^)!
set REPLACING1=!REPLACING1:^)=^^^)!
set REPLACED2=!REPLACED2:^)=^^^)!
set REPLACING2=!REPLACING2:^)=^^^)!
set REPLACED3=!REPLACED3:^)=^^^)!
set REPLACING3=!REPLACING3:^)=^^^)!

if exist "%OUTFILE%" (del /f/q "%OUTFILE%")
for /f "usebackq tokens=*" %%i in ("%INFILE%") do (
          set line=%%i
          set line=!line:%REPLACED1%=%REPLACING1%!
		  set line=!line:%REPLACED2%=%REPLACING2%!
		  echo !line:%REPLACED3%=%REPLACING3%!>>%OUTFILE%
    )

exit /B 0