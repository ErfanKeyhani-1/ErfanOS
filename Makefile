all: os-image.bin

os-image.bin: boot.bin kernel.bin
	cat boot.bin kernel.bin > os-image.bin

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

kernel.bin: kernel.o
	ld -m elf_i386 -T linker.ld -o kernel.bin kernel.o

kernel.o: kernel.asm
	nasm -f elf32 kernel.asm -o kernel.o

clean:
	rm -f *.bin *.o

floppy.img: os-image.bin
	dd if=/dev/zero of=floppy.img bs=1024 count=1440
	dd if=os-image.bin of=floppy.img conv=notrunc

run: floppy.img
	qemu-system-i386 -fda floppy.img
