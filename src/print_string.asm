; ==================================================
; Función: print_string
; Descripción: Imprime una cadena terminada en cero.
; Entrada: EAX = dirección de la cadena a imprimir.
; ==================================================

SECTION .text
global print_string

print_string:

    ; Prologo de funcion
    push ebp
    mov ebp, esp

    ; Se guardan los registros que se van a modificar
    push eax
    push ebx
    push ecx
    push edx

    ; El registro EAX trae la dirección de la cadena, la movemos a ECX de una vez 
    ; ya que sys_write la pedirá ahí.
    mov ecx, eax

    ; Usaremos EDX como nuestro contador de longitud.
    ; xor edx, edx es una forma rápida y óptima de poner EDX en 0.
    xor edx, edx

.calculando_longitud:
    ; Comparamos el byte actual con 0
    cmp byte [ecx + edx], 0
    je .imprimir                ; Si es 0 saltamos a imprimir
    inc edx                     ; Si no es 0 incrementamos el contador de longitud
    jmp .calculando_longitud    ; Repetimos el ciclo para revisar el siguiente byte

.imprimir:
    ; Si la longitud es 0 (la cadena estaba vacía), saltamos al final
    cmp edx, 0
    je .fin

    ; Llamada al sistema sys_write
    mov eax, 4
    mov ebx, 1
    ; ECX ya contiene la dirección de la cadena desde el inicio
    ; EDX ya contiene la longitud exacta por el ciclo
    int 0x80

.fin:
    ; Restauracion de los registros en orden inverso
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; Epílogo de función
    mov esp, ebp
    pop ebp
    ret
