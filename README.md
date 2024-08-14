# ErfanOS
Small OS I am working on so I dont rely on the corrupt controlling government, and evil corporations.


now ya need these commands for it to work:
Install NASM (if not already installed)
  ```bash
 sudo apt-get install nasm
 ```
Assemble the bootloader to a binary file
  ```bash
 nasm -f bin -o boot.bin boot.asm
 ```
Create a bootable ISO using dd (if testing in QEMU or a VM)
  ```bash
 dd if=boot.bin of=boot.img bs=512 count=1
 ```
Install QEMU (if not already installed)
  ```bash
 sudo apt-get install qemu-system-x86
 qemu-system-x86_64 -drive file=boot.bin,format=raw

 ```
