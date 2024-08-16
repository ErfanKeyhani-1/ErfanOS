[BITS 32]
global load_idt
global irq1_handler
extern keyboard_handler_c

section .data
align 8
idt:
    times 256 dq 0

section .text
load_idt:
    lidt [idt_descriptor]
    ret

irq1_handler:
    pushad
    ; Acknowledge the interrupt by sending EOI to the PIC
    mov al, 0x20
    out 0x20, al
    ; Call the C handler
    call keyboard_handler_c
    popad
    iret

section .data
align 4
idt_descriptor:
    dw 256 * 8 - 1  ; Limit (size of IDT - 1)
    dd idt          ; Base (address of IDT)
