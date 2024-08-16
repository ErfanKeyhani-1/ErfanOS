[BITS 32]
[GLOBAL _start]

section .multiboot
    align 4
<<<<<<< HEAD
    dd 0x1BADB002
    dd 0
    dd -(0x1BADB002 + 0)

section .text
_start:
    mov eax, 0xB8000
    mov ebx, 'E'
    mov word [eax], bx

    mov ebx, 'r'
    mov word [eax+2], bx

    mov ebx, 'f'
    mov word [eax+4], bx

    mov ebx, 'a'
    mov word [eax+6], bx

    mov ebx, 'n'
    mov word [eax+8], bx

    mov ebx, 'O'
    mov word [eax+10], bx

    mov ebx, 'S'
    mov word [eax+12], bx

    extern main
    call main

    cli
    hlt
=======
    dd 0x1BADB002              ; Magic number
    dd 0                       ; Flags
    dd -(0x1BADB002 + 0)       ; Checksum

section .text
_start:
    mov eax, 0xB8000           ; Video memory address
    mov ebx, 'E'               ; Character 'E'
    mov word [eax], bx         ; Write 'E' to video memory

    mov ebx, 'r'               ; Character 'r'
    mov word [eax+2], bx       ; Write 'r' to video memory

    mov ebx, 'f'               ; Character 'f'
    mov word [eax+4], bx       ; Write 'f' to video memory

    mov ebx, 'a'               ; Character 'a'
    mov word [eax+6], bx       ; Write 'a' to video memory

    mov ebx, 'n'               ; Character 'n'
    mov word [eax+8], bx       ; Write 'n' to video memory

    mov ebx, 'O'               ; Character 'O'
    mov word [eax+10], bx      ; Write 'O' to video memory

    mov ebx, 'S'               ; Character 'S'
    mov word [eax+12], bx      ; Write 'S' to video memory

    cli                        ; Disable interrupts
    hlt                        ; Halt the CPU

>>>>>>> 9a8724aa6f9c0d05dc3ef20a621d698edb02f2c8
