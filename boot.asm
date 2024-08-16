[BITS 16]
[ORG 0x7C00]

mov ah, 0x0E      ; Teletype output
mov al, 'E'
int 0x10
mov al, 'r'
int 0x10
mov al, 'f'
int 0x10
mov al, 'a'
int 0x10
mov al, 'n'
int 0x10
mov al, 'O'
int 0x10
mov al, 'S'
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xAA55

