extern print_char ; Le decimos al ensamblador que usaremos esta función externa
global newline

SECTION .text

newline:

    ; Prólogo de la función
    push ebp
    mov ebp, esp

    ; Guardamos EAX porque vamos a modificar su parte baja (AL)
    push eax

    ; El código ASCII para el salto de línea (\n) es el 10
    mov al, 10

    ; Reutilizamos la función print_char (que ya se sabe que debe imprimir lo que esté en AL)
    call print_char

    ; Restauramos EAX a su estado original
    pop eax
    ; Epílogo de la función
    mov esp, ebp
    pop ebp
    ret
