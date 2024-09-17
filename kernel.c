#define VIDEO_MEMORY 0xB8000
#define COLS 80
#define ROWS 25

void clear_screen() {
    volatile unsigned short *video_memory = (volatile unsigned short *)VIDEO_MEMORY;
    for (int i = 0; i < COLS * ROWS; i++) {
        video_memory[i] = (unsigned short)' ' | (unsigned short)(0x0F << 8);
    }
}

void printk(const char* message, unsigned char color) {
    static int next_line = 0;
    volatile unsigned char* video_memory = (volatile unsigned char*)VIDEO_MEMORY;
    video_memory += next_line * COLS * 2;
    
    int i = 0;
    while (message[i] != 0) {
        *video_memory = message[i];
        video_memory++;
        *video_memory = color;
        video_memory++;
        i++;
    }
    next_line++;
}

void main() {
    clear_screen();
    printk("ErfanOS is running! We made it to C code!", 0x0F);
    printk("Welcome to ErfanOS - Your Journey to Freedom Begins Here", 0x0A);
    printk("Created by Erfan Keyhani", 0x0B);
    while(1) {} // Infinite loop to prevent the CPU from executing random memory
}
