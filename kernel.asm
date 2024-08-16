[BITS 32]
global _kstart  ; Change this from _start to kernel_start

extern main

section .multiboot
    align 4
    dd 0x1BADB002
    dd 0
    dd -(0x1BADB002 + 0)

section .text
_kstart:  ; Change this label from _start to kernel_start
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

    call main

    cli
    hlt
