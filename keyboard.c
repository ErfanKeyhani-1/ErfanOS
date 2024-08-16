#include <stdint.h>

extern void irq1_handler();
extern void set_idt_gate(int n, uint32_t handler);
extern void outb(uint16_t port, uint8_t value);
extern uint8_t inb(uint16_t port);
extern void printk(const char* message);

void keyboard_handler_c() {
    uint8_t scan_code = inb(0x60);
    char ascii_char = ' ';
    if (scan_code == 0x1E) ascii_char = 'a';
    else if (scan_code == 0x30) ascii_char = 'b';
    char msg[2] = {ascii_char, 0};
    printk(msg);
}

void init_keyboard() {
    set_idt_gate(33, (uint32_t)irq1_handler);
    outb(0x21, inb(0x21) & ~0xFD); // Enable IRQ1 (keyboard)
}
