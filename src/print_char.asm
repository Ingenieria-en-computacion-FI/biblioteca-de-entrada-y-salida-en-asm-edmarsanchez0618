; ==============================================================================
; Función: print_char
; Descripción: Imprime un solo carácter en la salida estándar.
; Entrada: AL = carácter a imprimir.
; ==============================================================================

SECTION .bss
char_buffer resb 1 ; Reserva 1 byte para el caracter

SECTION .text
global print_char

print_char:
    ; Prologo de funcion
    push ebp
    mov ebp, esp

    ; Se guardan los registros que se van a modificar
    push eax
    push ebx
    push ecx
    push edx

    mov [char_buffer], al ; Movemos el caracter AL a la variable global en memoria

    ; Configuramos la llamada al sistema sys_write
    mov eax, 4            ; Numero de syscall para sys_write
    mov ebx, 1            ; File descriptor 1 (stdout)
    mov ecx, char_buffer   ; Puntero a la variable global que contiene el caracter
    mov edx, 1            ; Longitud a imprimir 1 byte

    int 0x80 ; Llamada al sistema

    ; Restauracion de los registros en orden inverso
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; Epilogo de funcion
    mov esp, ebp
    pop ebp
    ret
