@echo off
set common_files=D:\...\helper_progs\common_files

mklink >nul %common_files%\%1.asm %cd%\%1.asm

mklink >nul 2>&1 %cd%\gfx.dll %common_files%\gfx.dll
mklink >nul 2>&1 %cd%\io.dll %common_files%\io.dll
mklink >nul 2>&1 %cd%\mio.dll %common_files%\mio.dll

pushd %cd% >NUL
cd %common_files% >NUL

call ..\assembler %1
del %common_files%\%1.asm >NUL

popd %cd% >NUL
cd %cd% >NUL

mkdir exe >nul 2>&1
xcopy %common_files%\exe\%1.exe %cd%\exe\%1.exe /Y >nul 2>&1