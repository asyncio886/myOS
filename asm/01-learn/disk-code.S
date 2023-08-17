COLOR equ 0xA4
SECTION disk_code vstart=0x900 ; 第二个扇区的代码
    mov ax, 0xb800
    mov gs, ax
    mov byte [gs:0x00], '1'
    mov byte [gs:0x01], COLOR
    mov byte [gs:0x02], '2'
    mov byte [gs:0x03], COLOR
    mov byte [gs:0x04], '1'
    mov byte [gs:0x05], COLOR
    mov byte [gs:0x06], '2'
    mov byte [gs:0x07], COLOR
    jmp $