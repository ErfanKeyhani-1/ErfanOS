; boot.asm — stage-1 loader that prints A then C (or E on error)
; Comments: Chatgpt
; Code: Erfankeyhani-1, mr-3
org 0x7c00
bits 16
sectors_to_load  equ 1      ; how many sectors (after the MBR) to pull in
load_dest_offset equ 0x8000 ; offset within segment 0x0000 to load stage-2

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    call print_W ; just for funsies, not really needed
    call print_A

    ; Save boot drive (DL) for later
    mov [boot_drive], dl

    ; Ask BIOS for geometry (AH=08h)
    mov ah, 0x08
    mov dl, [boot_drive]
    int 0x13
    jc geometry_error

    ; Store heads (DH) and sectors-per-track (CL low 6 bits)
    mov [head_count], dh
    and cl, 0x3F
    mov [sptrk], cl

    call print_C

    ; — geometry succeeded, now try LBA →
    mov ah, 0x41            ; check for LBA extensions
    mov bx, 0x55AA          ; signature
    mov dl, [boot_drive]

    mov bx, load_dest_offset  ; =0x8000
    ; ES is already zero from your setup, so ES:BX → 0000:8000

    int 0x13
    jc .read_error
    jmp  .use_chs            ; CF=1 → no LBA support
    ;cmp bx, 0xAA55
    ;jne .use_chs            ; signature mismatch → no LBA

    ; — LBA is supported: issue EXT read of sectors_to_load → ES:BX via our DAP
    mov ah, 0x42            ; extended read
    mov dl, [boot_drive]
    xor si, si
    lea si, [dap16]         ; DS=0, SI → address of our DAP
    int 0x13
    jc  .read_error         ; on failure, die
    jmp .done_loading

.use_chs:
    ; — fallback to single-sector CHS read —
    mov ah, 0x02            ; read 1 sector
    mov al, 1
    mov ch, 0               ; track 0 (we’ll improve this later)
    mov dh, 0               ; head 0
    mov cl, 2               ; sector 2 (MBR is sector 1)
    mov dl, [boot_drive]

    mov bx, load_dest_offset  ; =0x8000
    ; ES = 0 already, so ES:BX → 0000:8000

    int 0x13
    jc .read_error

    jmp .done_loading

.done_loading:
    jmp 0x0000:load_dest_offset

.read_error:
    call print_E
    hlt

;— error path if geometry call fails ——
geometry_error:
    call print_E
    hlt

;— character-printing routines ——
print_A:
    mov ah, 0x0E
    mov al, 'A'
    int 0x10
    ret

print_C:
    mov ah, 0x0E
    mov al, 'C'
    int 0x10
    ret

print_W:
    mov ah, 0x0E
    mov al, 'W'
    int 0x10
    ret

print_E:
    mov ah, 0x0E
    mov al, 'E'
    int 0x10
    ret

;— data storage ——
boot_drive:  db 0     ; DL on entry
head_count:  db 0     ; DH from INT 13h/AH=08h
sptrk:       db 0     ; CL bits 0–5 from same call

;-- 16 byte DAP, Disk address packet for LBA ext reads
dap16:
    db 16
    db 0
    dw sectors_to_load
    dw load_dest_offset
    dw 0
    dq 1 ; low dword of 1 for 8-byte lba

;— pad and signature ——
times 510-($-$$) db 0
dw    0xAA55
