org 0x8000
bits 16

_start2:
        cli
        mov ah, 0x0E
        mov al, 'B'
        int 0x10

.hang:
        jmp .hang