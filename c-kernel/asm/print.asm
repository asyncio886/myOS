%include "boot.inc"
[bits 32]
section .text
; 功能：输出一个字符
global put_char
put_char:
    pushad ; 压入32位寄存器备份 eax, ecx, edx, ebx, esp, ebp, esi, edi
    ; 显存段
    mov ax, SELECTOR_VIDEO
    mov gs, ax
    ; 获取当前光标位置
    
    ; 获取高8位
    mov dx, 0x03d4
    mov al, 0x0e
    out dx, al
    mov dx, 0x03d5
    in al, dx
    mov ah, al

    ; 获取低八位
    mov dx, 0x03d4
    mov al, 0x0f
    out dx, al
    mov dx, 0x03d5
    in al, dx
    
    ; 光标值存入bx
    mov bx, ax

    ; 获得栈中保存的字符，就是那个输入的参数，要越过备份的寄存器和call压入的返回地址
    mov ecx, [esp + 36]
    ; 特殊字符，如\n
    cmp cl, 0xd 
    jz .is_carriage_return
    cmp cl, 0xa
    jz .is_line_feed
    cmp cl, 0x8
    jz .is_backspace

    ; 正常字符
    jmp .put_other
.is_backspace:
    dec bx
    shl bx, 1
    mov byte [gs:bx], 0x20
    inc bx
    mov byte [gs:bx], 0x7
    shr bx, 1
    jmp .set_cursor
.put_other:
    shl bx, 1
    mov [gs:bx], cl
    inc bx
    mov byte [gs:bx], 0x07
    shr bx, 1
    inc bx
    cmp bx, 2000
    jmp .set_cursor
.is_line_feed:
.is_carriage_return:
    xor dx, dx
    mov ax, bx
    mov si, 80
    div si
    sub bx, dx
.is_carriage_return_end:
    add bx, 80
    cmp bx, 2000
.is_line_feed_end:
    jl .set_cursor
.roll_screen:
    cld
    mov ecx, 960

    mov esi, 0xc00b80a0
    mov edi, 0xc00b8000
    rep movsd

    mov ebx, 3840
    mov ecx, 80
.cls:
    mov word [gs:ebx], 0x720
    add ebx, 2
    loop .cls
    mov bx, 1920
.set_cursor:
    mov dx, 0x03d4
    mov al, 0x0e
    out dx, al
    mov dx, 0x03d5
    mov al, bh
    out dx, al
    

    mov dx, 0x03d4
    mov al, 0x0f
    out dx, al
    mov dx, 0x03d5
    mov al, bl
    out dx, al
    .put_char_done:
    popad
    ret
; 光标到左上角
global to_top_left
to_top_left:
    pushad
    mov dx, INDEX_REGISTER_PORT
    mov al, OPT_SCREEN_INDEX_HIGH_8
    out dx, al
    mov dx, DATA_REGISTER_PORT
    mov al, 0
    ; 写入高位的0
    out dx, al
    mov dx, INDEX_REGISTER_PORT
    mov al, OPT_SCREEN_INDEX_LOW_8
    out dx, al
    mov dx, DATA_REGISTER_PORT
    mov al, 0
    ; 写入低位的0
    out dx, al
    popad
    ret
global put_str
put_str:
    push ebx
    push ecx   
    xor ebx, ebx
    ; 拿到入参，也就是字符指针
    mov ecx, [esp + 12]
    .continue_put_char:
        mov byte bl, [ecx]
        cmp bl, 0
        jz .str_over  
        push ebx
        call put_char
        add esp, 4
        inc ecx
        jmp .continue_put_char
.str_over:
    pop ecx
    pop ebx
    ret