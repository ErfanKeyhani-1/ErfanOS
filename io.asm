[BITS 32]
global inb
global outb

inb:
    push ebp
    mov ebp, esp
    xor eax, eax
    mov edx, [ebp + 8]  ; port
    in al, dx
    pop ebp
    ret

outb:
    push ebp
    mov ebp, esp
    mov edx, [ebp + 8]  ; port
    mov al, [ebp + 12]  ; value
    out dx, al
    pop ebp
    ret
