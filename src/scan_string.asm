; ==============================================================================
; Función: scan_string
; Descripción: Lee una cadena desde la entrada estándar (stdin).
; Entrada: 
;   EAX = dirección del buffer destino.
;   EBX = tamaño máximo del buffer.
; Salida: La cadena queda guardada en el buffer y terminada en cero.
; ==============================================================================





SECTION .text
global scan_string

scan_string:

    ; Prólogo de la función requerido
    push ebp
    mov ebp, esp

    ; Se guardan los registros que se van a modificar
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; TODO:
    ; 1. syscall read
    ; 2. guardar en buffer
    ; 3. agregar terminador 0

    mov esp, ebp
    pop ebp
    ret
