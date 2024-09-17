[org 0x7c00]
[bits 16]

KERNEL_OFFSET equ 0x1000

boot_start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    mov [BOOT_DRIVE], dl

    mov si, MSG_REAL_MODE
    call print_string

    call load_kernel

    mov si, MSG_KERNEL_LOADED
    call print_string

    call switch_to_pm
    jmp $

[bits 16]
load_kernel:
    mov si, MSG_LOAD_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET
    mov dh, 30
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 16]
switch_to_pm:
    mov si, MSG_SWITCH_PM
    call print_string

    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call KERNEL_OFFSET

gdt_start:
    dq 0x0
gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

disk_load:
    pusha
    push dx

    mov ah, 0x02
    mov al, dh
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error
    popa
    ret

disk_error:
    mov si, DISK_ERROR
    call print_string
    jmp disk_loop

sectors_error:
    mov si, SECTORS_ERROR
    call print_string

disk_loop:
    jmp $

print_string:
    pusha
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    popa
    ret

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0
MSG_KERNEL_LOADED db "Kernel loaded successfully", 0
MSG_SWITCH_PM db "Switching to protected mode", 0
DISK_ERROR db "Disk read error", 0
SECTORS_ERROR db "Incorrect number of sectors read", 0

times 510-($-$$) db 0
dw 0xAA55
