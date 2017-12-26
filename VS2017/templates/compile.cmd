@echo off

set CURDIR=%CD% 
call "#VSDIR#\Common7\Tools\VsDevCmd.bat"

set FLAGS=/GS /W3 /Zc:wchar_t /Gm- /O2 /sdl /Zc:inline /fp:precise /WX- /Zc:forScope /Gd /Oy- /Oi /MD /EHsc /nologo

cd /d "%CURDIR%"

:: %1 contains quote already
cl %FLAGS% %1