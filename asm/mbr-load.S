LOADER_START_SECTOR equ 2
LOADER_BASE_ADDR equ 0x900
; 读取硬盘上的扇区
SECTION code vstart=0x7c00
    ; 清空屏幕
    mov ah, 0x06
    mov al, 0x0
    mov bh, 0x07
    mov cx, 0
    mov dx, 0x184f
    int 0x10
    mov ah, 3
    mov bh, 0
    int 0x10

    ; 因为跳转是cs:ip，地址结构是0x0000:0x7c00，cs寄存器是0
    mov ax, cs
    mov dx, ax
    mov gs, ax
    ;使用寄存器传参数
    ;LBA地址
    mov eax, LOADER_START_SECTOR
    ;读入放到内存哪个位置
    mov bx, LOADER_BASE_ADDR
    ;读取的扇区数目
    ; 去读四个扇区
    mov cx, 4
    call rd_disk_m_16
    jmp LOADER_BASE_ADDR
    rd_disk_m_16:
        mov esi, eax
        mov di, cx
        ; 设置扇区数
        mov dx, 0x1f2
        mov al, cl
        out dx, al
        mov eax, esi
        ;下面写LBA扇区地址，(第几扇区)
        mov dx, 0x1f3
        out dx, al
        ; eax右移八位
        mov cl, 8
        shr eax, cl
        mov dx, 0x1f4
        out dx, al
        
        shr eax, cl
        mov dx, 0x1f5
        out dx, al
        
        shr eax, cl
        and al, 0x0f
        or al, 0xe0
        mov dx, 0x1f6
        out dx, al
        ; 设置读取命令
        mov dx, 0x1f7
        mov al, 0x20
        out dx, al
    .not_ready:
        nop
        in al, dx
        and al, 0x88
        cmp al, 0x08
        jnz .not_ready

        mov ax, di
        mov dx, 256
        mul dx
        mov cx, ax
        mov dx, 0x1f0
    .go_on_read:
        in ax, dx
        mov [bx], ax
        add bx, 2
        loop .go_on_read
        ret 

    times 510-($-$$) db 0x0
    db 0x55,0xaa
