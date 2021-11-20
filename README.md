# assembly_helper_library
_Helper scripts for using assembly (created by an UBB info student)_


## Quick scripts
 IMPORTANT:
* After cloning add the root folder to the path!

* Change the folder path in `asm_compiler.bat` to your path:

```bat
:: asm_compiler.bat
...
set common_files=D:...\common_files
...
```

Debugger:

1. Install [Python](https://www.python.org/downloads/)!

2. Install [SASM](https://github.com/Dman95/SASM)!

3. To convert from SASM syntax to school nasm syntax, use `asm_transform school|sasm file.asm`

* _root directory needs to be added to the path!_

### Usage

* asm_compiler source (assembles a source file)
* asm_runner source (assembles, then runs a source file)
* asm_test source input.txt (assembles, then runs a source file stdin = input.txt
* asm_transform (explained before)
