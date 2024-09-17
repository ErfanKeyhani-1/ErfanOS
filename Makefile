# Compiler and linker settings
ASM=nasm
CC=gcc
LD=ld

# Flags
ASMFLAGS=-f elf32
CFLAGS=-m32 -c -ffreestanding -fno-pie -fno-pic -I$(SRC_DIR)
LDFLAGS=-m elf_i386 -T linker.ld --oformat binary

# Directories
SRC_DIR=src
BUILD_DIR=build

# Source files
BOOT_SRC=$(SRC_DIR)/boot.asm
KERNEL_ASM_SRC=$(SRC_DIR)/kernel.asm
KERNEL_C_SRC=$(SRC_DIR)/kernel.c
KEYBOARD_SRC=$(SRC_DIR)/keyboard.c
IO_SRC=$(SRC_DIR)/io.asm
IDT_ASM_SRC=$(SRC_DIR)/idt.asm
IDT_C_SRC=$(SRC_DIR)/idt.c

# Object files
BOOT_OBJ=$(BUILD_DIR)/boot.bin
KERNEL_ASM_OBJ=$(BUILD_DIR)/kernel_entry.o
KERNEL_C_OBJ=$(BUILD_DIR)/kernel.o
KEYBOARD_OBJ=$(BUILD_DIR)/keyboard.o
IO_OBJ=$(BUILD_DIR)/io.o
IDT_ASM_OBJ=$(BUILD_DIR)/idt_asm.o
IDT_C_OBJ=$(BUILD_DIR)/idt.o

# Output files
KERNEL_BIN=$(BUILD_DIR)/kernel.bin
OS_IMAGE=$(BUILD_DIR)/os-image.bin

# Default target
all: $(OS_IMAGE)

# Build the OS image
$(OS_IMAGE): $(BOOT_OBJ) $(KERNEL_BIN)
	cat $^ > $@

# Compile bootloader
$(BOOT_OBJ): $(BOOT_SRC)
	$(ASM) -f bin $< -o $@

# Compile kernel assembly
$(KERNEL_ASM_OBJ): $(KERNEL_ASM_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

# Compile kernel C code
$(KERNEL_C_OBJ): $(KERNEL_C_SRC)
	$(CC) $(CFLAGS) $< -o $@

# Compile keyboard driver
$(KEYBOARD_OBJ): $(KEYBOARD_SRC)
	$(CC) $(CFLAGS) $< -o $@

# Compile I/O assembly
$(IO_OBJ): $(IO_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

# Compile IDT assembly
$(IDT_ASM_OBJ): $(IDT_ASM_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

# Compile IDT C code
$(IDT_C_OBJ): $(IDT_C_SRC)
	$(CC) $(CFLAGS) $< -o $@

# Link kernel
$(KERNEL_BIN): $(KERNEL_ASM_OBJ) $(KERNEL_C_OBJ) $(KEYBOARD_OBJ) $(IO_OBJ) $(IDT_ASM_OBJ) $(IDT_C_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

# Run the OS in QEMU
run: $(OS_IMAGE)
	qemu-system-i386 -fda $(OS_IMAGE)

# Clean up
clean:
	rm -f $(BUILD_DIR)/*.bin $(BUILD_DIR)/*.o

.PHONY: all run clean
