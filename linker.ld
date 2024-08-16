ENTRY(_start)

SECTIONS
{
    . = 0x00100000;

    .text : {
        *(.text)
    }
<<<<<<< HEAD

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
=======
>>>>>>> 9a8724aa6f9c0d05dc3ef20a621d698edb02f2c8
}

