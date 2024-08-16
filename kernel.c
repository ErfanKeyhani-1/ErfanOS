int strlen(const char* str) {
    int len = 0;
    while (str[len] != 0) {
        len++;
    }
    return len;
}

void printk(const char* message) {
    char *video_memory = (char *) 0xB8000;
    int i = 0;
    int screen_width = 80;

    // Calculate the starting position for centered text
    int start_position = (screen_width - strlen(message)) / 2;

    // Print each character
    while (message[i] != 0) {
        video_memory[(start_position + i) * 2] = message[i];
        video_memory[(start_position + i) * 2 + 1] = 0x07; // Light gray on black
        i++;
    }
}

void main() {
    // Clear the screen by filling it with spaces
    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        char *video_memory = (char *) 0xB8000;
        video_memory[i] = ' ';
        video_memory[i + 1] = 0x07;
    }

    // Use printk to print messages
    printk("ErfanOS Running...");
    printk("\nWelcome to ErfanOS! Freedom awaits!");
}

