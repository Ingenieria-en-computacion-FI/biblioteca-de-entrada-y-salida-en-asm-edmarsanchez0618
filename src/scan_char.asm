; ==========================================================================
; Función: scan_char
; Descripción: Lee un carácter desde la entrada estándar y lo retorna en AL.
; ==========================================================================

SECTION .bss
char_buffer resb 1

SECTION .text
global scan_char

scan_char:
    ; Prologo de funcion
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push edx
    push eax    ; Guardamos EAX completo

    ; Llamos al sistema read
    mov eax, 3
    mov ebx,0
    mov ecx, char_buffer
    mov edx, 1
    int 0x80    ;Llamada al sistema

    ; Restaurando EAX original que fue modificado por sys_read
    pop eax

    ; Salida: Carga el caracter leido exclusivamente en AL
    mov al, byte [char_buffer]

    ; Restauramos los registros
    pop edx
    pop ecx
    pop ebx

    ; Epilogo de funcion
    mov esp, ebp
    pop ebp
    ret
