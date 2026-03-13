%include "../include/io.inc"

global _start

SECTION .text

_start:

    call scan_int
    call print_int

    call newline

    mov al, 'A'
    call print_char

    call newline

    mov eax, 1
    xor ebx, ebx
    int 0x80
