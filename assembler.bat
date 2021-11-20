nasm -f win32 -o obj\%1.obj %1.asm 
nlink obj/%1.obj -lmio -lio -lgfx -o exe\%1.exe