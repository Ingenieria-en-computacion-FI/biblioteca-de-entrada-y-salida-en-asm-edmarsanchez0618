; ===================================================================
; Función: scan_string
; Descripción: Lee una cadena desde la entrada estándar (stdin).
; Entrada: 
;   EAX = dirección del buffer destino.
;   EBX = tamaño máximo del buffer.
; Salida: La cadena queda guardada en el buffer y terminada en cero.
; ==================================================================

SECTION .text
global scan_string

scan_string:

    ; Prólogo de la función
    push ebp
    mov ebp, esp

    ; Se guardan los registros que se van a modificar
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; EAX trae la dirección base del buffer y EBX el tamaño máximo.
    mov esi, eax        ; Usaremos ESI como nuestro puntero que avanzara por el buffer
    mov edi, eax
    add edi, ebx        ; EDI ahora apunta al final del buffer (dirección base + tamaño)
    dec edi             ; Restamos 1 a EDI para asegurar siempre el ultimo espacio para el cero (null)

.leer_caracter:
    ; Verificamos si llegamos al límite seguro del buffer
    cmp esi, edi
    je .fin_cadena      ; Si ESI alcanzó a EDI, ya no hay espacio, terminamos de leer

    ; Configuramos la llamada al sistema sys_read
    mov eax, 3          ; Número de syscall para read
    mov ebx, 0          ; File descriptor 0
    mov ecx, esi        ; ECX apunta a la posición actual en nuestro buffer
    mov edx, 1          ; Leemos de 1 en 1 byte
    int 0x80

    ; Verificar si hubo un error al leer (EAX <= 0)
    cmp eax, 0
    jle .fin_cadena

    ; Verificamos si el carácter que acabamos de leer es un salto de línea (Enter, ASCII 10)
    cmp byte [esi], 10
    je .fin_cadena      ; Si el usuario dio Enter, terminamos de leer la cadena

    ; Si no fue Enter y aún hay espacio, avanzamos nuestro puntero al siguiente byte
    inc esi
    jmp .leer_caracter  ; Repetimos el ciclo para el siguiente carácter

.fin_cadena:
    ; Aseguramos que la cadena quede terminada en cero, en este punto, ESI apunta al lugar donde
    ; iba el Enter o al último espacio disponible
    mov byte [esi], 0

    ; Restauramps los registros originales en orden inverso
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; Epílogo de la función
    mov esp, ebp
    pop ebp
    ret
