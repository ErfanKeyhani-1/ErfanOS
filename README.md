########### NOT WORKING, I HAVE BEEN LITERALLY DYING TO MAKE THE KEYBOARD DRIVER WORK IT DOES NOT WORK, WHAT?


# ErfanOS

ErfanOS is a custom operating system built from the ground up, aiming to provide users with full control and transparency.

## Project Overview

Currently, ErfanOS includes:
- A custom bootloader written in assembly
- A basic kernel combining C and assembly
- 32-bit protected mode operation
- Basic screen output with color support

This project serves as both a learning experience and a foundation for a more comprehensive OS.

ErfanOS was created So we can all stay away from evil corporations and governments that secretly control us.

## Getting Started

### Prerequisites
- NASM (Netwide Assembler)
- GCC (GNU Compiler Collection)
- QEMU (for emulation)

### Building and Running

1. Clone the repository:
   ```
   git clone https://github.com/erfankeyhani-1/erfanos.git
   cd erfanos
   ```

2. Build the OS:
   ```
   make
   ```

3. Run in QEMU:
   ```
   make run
   ```

## Current Features
- Bootloader that transitions to protected mode
- Basic kernel initialization
- Screen clearing and text display in color

## Future Development
- Implement keyboard input
- Develop a simple command line interface
- Add basic file system support
- Expand memory management capabilities

## Contributing

While ErfanOS is a personal project, It will be one of the most customisable and secure OS of all time, feedback and contributions are welcome. Please feel free to fork the repository and submit pull requests.

## License

ErfanOS is open-source software licensed under the "ErfanOS license".

---
"Rome wasn't built in a day, neither was ErfanOS."
