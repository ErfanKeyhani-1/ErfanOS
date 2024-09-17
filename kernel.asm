[bits 32]
[extern main]

global _start

section .text
_start:
    mov dword [0xb8000], 0x2F4B2F4F  ; Print 'OK' in green
    mov dword [0xb8004], 0x2F212F21  ; Print '!!' in green
    call main
    jmp $
