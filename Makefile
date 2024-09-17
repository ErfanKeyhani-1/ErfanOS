# Makefile for ErfanOS

# Compiler and linker settings
ASM=nasm
CC=gcc
LD=ld

# Flags
ASMFLAGS=-f bin
CFLAGS=-m32 -c -ffreestanding -fno-pie -fno-pic
LDFLAGS=-m elf_i386 -T linker.ld --oformat binary

# Source files
BOOT_SRC=boot.asm
KERNEL_ASM_SRC=kernel.asm
KERNEL_C_SRC=kernel.c

# Object files
KERNEL_ASM_OBJ=kernel_entry.o
KERNEL_C_OBJ=kernel.o

# Output files
BOOT_BIN=boot.bin
KERNEL_BIN=kernel.bin
OS_IMAGE=os-image.bin

# Default target
all: $(OS_IMAGE)

# Build the OS image
$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $^ > $@

# Compile bootloader
$(BOOT_BIN): $(BOOT_SRC)
	$(ASM) $(ASMFLAGS) $< -o $@

# Compile kernel assembly
$(KERNEL_ASM_OBJ): $(KERNEL_ASM_SRC)
	$(ASM) -f elf32 $< -o $@

# Compile kernel C code
$(KERNEL_C_OBJ): $(KERNEL_C_SRC)
	$(CC) $(CFLAGS) $< -o $@

# Link kernel
$(KERNEL_BIN): $(KERNEL_ASM_OBJ) $(KERNEL_C_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

# Run the OS in QEMU
run: $(OS_IMAGE)
	qemu-system-i386 -fda $(OS_IMAGE)

# Clean up
clean:
	rm -f *.bin *.o

.PHONY: all run clean
