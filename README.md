
# ErfanOS

## Overview

ErfanOS is a simple operating system built from scratch, starting with a custom bootloader written in assembly and a kernel written in both assembly and C. This project is a journey into the world of OS development, focusing on the fundamentals of how an operating system boots, interacts with hardware, and handles basic output.

## Features

- **Custom Bootloader:** Initializes the system and loads the kernel into memory.
- **32-bit Protected Mode:** The OS operates in 32-bit protected mode, enabling more advanced features.
- **Basic Kernel:** Displays centered text at the top of the screen, showcasing the ability to handle output via video memory.
- **Custom `printk` Function:** A simple `printk` function handles basic text output, including centering text on the screen.
- **Clear Screen:** The kernel clears the screen before displaying messages, ensuring clean output.

## Getting Started

### Prerequisites

- **NASM**: For assembling the bootloader and kernel assembly code.
- **GCC**: To compile the kernel C code.
- **QEMU**: For testing the operating system in a virtualized environment.

### Building and Running

1. **Compile the Assembly Code:**
   ```bash
   nasm -f elf32 -o kernel_asm.o kernel.asm
   ```
2. **Compile the C Code:**
   ```bash
   gcc -m32 -ffreestanding -c kernel.c -o kernel_c.o
   ```
3. **Link the Kernel:**
   ```bash
   ld -m elf_i386 -T linker.ld -o kernel.bin kernel_asm.o kernel_c.o
   ```
4. **Create a Bootable Disk Image:**
   ```bash
   dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
   dd if=kernel.bin of=boot.img bs=512 seek=1 conv=notrunc
   ```
5. **Run the OS in QEMU:**
   ```bash
   qemu-system-i386 -drive file=boot.img,format=raw
   ```

## Status

ErfanOS is now in a stable state where the kernel successfully loads, prints centered text at the top of the screen, and the system operates in protected mode. While this is a basic setup, it forms the foundation for further development and more advanced features.

## Contributing

This project is a personal learning experience, but contributions, suggestions, and feedback are always welcome. Feel free to fork the repo, open issues, or submit pull requests.

## License

ErfanOS is an open-source project licensed under the MIT License.

---

"Rome wasn't built in a day, and neither was ErfanOS." But it's up and running, and there's a lot more to come!
