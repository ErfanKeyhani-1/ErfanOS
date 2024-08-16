[BITS 16]
global boot_start
extern main

boot_start:
    cli                    ; Disable interrupts
    xor ax, ax             ; Clear registers
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00         ; Set up stack

    ; Enable A20 line
.enable_a20:
    in al, 0x64
    test al, 2
    jnz .enable_a20
    mov al, 0xD1
    out 0x64, al
.wait1:
    in al, 0x64
    test al, 2
    jnz .wait1
    mov al, 0xDF
    out 0x60, al

    ; Load GDT
    lgdt [gdt_descriptor]

    ; Switch to protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump to clear the prefetch queue and enter 32-bit mode
    jmp dword 0x08:protected_mode

[BITS 32]
protected_mode:
    mov ax, 0x10            ; Data segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000        ; Set up stack pointer

      jmp 0x08:_kstart  ; Jump to kernel start

    ; Jump to C code
    call main

    ; Infinite loop to stop execution
.hang:
    hlt
    jmp .hang

gdt_start:
    ; Null descriptor
    dq 0x0000000000000000
    ; Code segment descriptor
    dq 0x00CF9A000000FFFF
    ; Data segment descriptor
    dq 0x00CF92000000FFFF

gdt_descriptor:
    dw gdt_descriptor - gdt_start - 1  ; Size of GDT
    dd gdt_start                       ; Start address of GDT

; Pad to 512 bytes for boot sector
times 510-($-$$) db 0
dw 0xAA55        ; Boot signature
