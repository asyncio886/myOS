%include "disk-register.inc"
READ_TO_POS equ 0x900
COLOR equ 0xA4
SECTION start_read vstart=0x7c00
    ; 读取两个扇区
    mov word si, 0x2
    mov word ax, si
    mov dx, SELECT_COUNT_REGISTER_PORT
    out dx, al

    ; 设置起始扇区位置，这里选择第二个扇区，因为本文件会被载入第一个扇区
    mov word ax, 0x2
    mov dx, LBA_LOW_REGISTER_PORT
    ; 写低8位
    out dx, al
    ; 剩下来都是0
    mov al, 0x0
    mov dx, LBA_MID_REGISTER_PORT
    ; 中8位
    out dx, al
    mov dx, LBA_HIGH_REGISTER_PORT
    ; 高8位
    out dx, al
    ; device端口的低四位，是LBA的第24位到27位最高的这四位
    ; device端口的高四位从低到高固定都是0111
    mov al, 0
    or al, 0xe0
    mov dx, DEVICE_REGISTER_PORT
    out dx, al
    ; 触发status寄存器改为read模式，即赋值为0x20
    mov al, 0x20
    mov dx, STATUS_COMMAND_REGISTER_PORT
    out dx, al
    ; 循环检测磁盘状态直到可读
    .check_is_ready:
        mov dx, STATUS_COMMAND_REGISTER_PORT
        in al, dx
        and al, 0x88
        cmp al, 0x8
        ; 没有准备好，继续循环
        jnz .check_is_ready
    ; 准备好了就开始读取并把代码放到0x900位置
    mov bx, READ_TO_POS
    ; 计算要循环读多少次才能读完，硬盘读取一次两个字节，一个扇区512个字节，
    ; 所以一个扇区读256次，需要乘以扇区数
    mov word ax, si 
    mov dx, 256
    ; mul后面的参数和ax寄存器相乘，结构放在ax
    mul dx
    ; 备份
    mov di, ax
    mov dx, DATA_16_BITS_REGISTER_PORT
    ; 计数读了多少次
    mov si, 0
    .go_to_read:
        in ax, dx
        mov word [bx], ax
        add bx, 2
        add si, 1
        cmp si, di
        jne .go_to_read
    jmp READ_TO_POS
    times 510-($-$$) db 0x0
    db 0x55, 0xaa
