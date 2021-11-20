import sys
from pathlib import Path

school2sasm = {
    "%define OS, windows": "%define OS, unix",
    "main": "CMAIN",
    "call mio_readchar": "GET_CHAR al",
    "call mio_writechar": "PRINT_CHAR al",
    "call io_writeint": "PRINT_DEC 4, eax",
    "call mio_writestr": "PRINT_STRING [eax]",
    "call mio_writeln": "NEWLINE",
    '"mio.inc"': '"io.inc"',

    "'mio.inc'": '"io.inc"',
    "call\tmio_writestr": "PRINT_STRING [eax]",
    "call\tmio_writeln": "NEWLINE",
    "call\tio_writeint": "PRINT_DEC 4, eax",
    "call\tmio_readchar": "GET_CHAR al",
    "call\tmio_writechar": "PRINT_CHAR al",
}


# sasm2school = {}
# for key, value in school2sasm.items():
#     sasm2school[value] = key


def to_school(code):
    new_code = code
    for school, sasm in school2sasm.items():
        new_code = new_code.replace(sasm, school)
    return new_code


def to_sasm(code):
    new_code = code
    for school, sasm in school2sasm.items():
        new_code = new_code.replace(school, sasm)
    return new_code


def main():
    if len(sys.argv) == 3:
        input_path = Path(sys.argv[2])
        data = input_path.read_text(encoding='utf-8')
        if sys.argv[1] == "sasm":
            data = to_sasm(data)
        elif sys.argv[1] == "school":
            data = to_school(data)
        input_path.write_text(data, encoding='utf-8')
    else:
        print("ERROR: wrong number of arguments\n"
              "\tusage: asm_transform sasm|school file.asm")


main()
