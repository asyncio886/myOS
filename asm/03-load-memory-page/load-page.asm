; 进入保护模式的流程是： 实模式下打开A20限制(打开寻址超过20根地址线，将端口0x92的第1位设置为1)，
;                      设置gdt，最后将cr0的第0位设置为1(cr0有31位)
%include "boot.inc"
LOADER_STACK_TOP equ LOADER_BASE_ADDR
SECTION to_protext_mode vstart=LOADER_BASE_ADDR
    jmp loader_start

    ; 0号段描述符，全是0
    GDT_BASE: dd 0x00000000
                dd 0x00000000
    ; 数据段
    CODEDESC: dd 0x0000FFFF
                dd DESC_CODE_HIGH4
    ; 栈段
    DATA_STACK_DESC: dd 0x0000FFFF
                        dd DESC_DATA_HIGH4
    ; 显存段
    VIDEO_DESC: dd 0x80000007 ;limit=(0xbffff - 0xb8000) / 4k = 0x7
                    dd DESC_VIDEO_HIGH4
    GDT_SIZE equ $ - GDT_BASE
    GDT_LIMIT equ GDT_SIZE - 1
    times 60 dq 0
    ; 三个描述符的选择子
    SELECTOR_CODE        equ (0X0001<<3) + TI_GDT + RPL0    ;16位寄存器 4位TI RPL状态 GDT剩下的选择子
    SELECTOR_DATA	  equ (0X0002<<3) + TI_GDT + RPL0
    SELECTOR_VIDEO       equ (0X0003<<3) + TI_GDT + RPL0

    ; gdt寄存器上的值
    gdt_ptr dw GDT_LIMIT 
            dd GDT_BASE


    loadermsg db   'welcome to loader zone!'    


    ards_buf times 244 db 0x0 ;
    ards_nr dw 0 ; 记录ards结构体数量
    total_mem_bytes dd 0
    loader_start:
        ; 进入保护模式前读取内存容量
        ; 通过0x15的bios中断
        
        ; 初始化环境
        xor ebx, ebx ; 清零
        mov edx, 0x534d4150 ;固定签名
        mov di, ards_buf ; 写入ards的目标内存地址
        ; 使用0xe280
    .get_mem_e280:
        mov eax, 0x0000e280 ; 功能号    
        mov ecx, 20 ; ards描述结构是20字节
        int 0x15; 调用15中断
        jc .get_mem_e280_error ; CF寄存器是1的时候代表出错了，跳转到错误处理
        add di, cx ; 代表获取到了一个ards描述符，ards描述符表指针向后移20字节
        inc word [ards_nr] ; ards描述符表+1
        cmp ebx, 0 ; 如果ebx是0，就代表没有ards描述符了
        jne .get_mem_e280 ; 不是1就继续循环
        ; 处理ards描述符组
        ; (base_addr_low + length_low)是上限，找到(base_addr_low + length_low)最大值作为内存容量
        mov cx, [ards_nr] ; ards描述符个数
        mov ebx, ards_buf ; ards描述符地址
        xor edx, edx ; edx清零
    .find_max_mem_area:
        ; 遍历描述符表
        mov eax, [ebx] ; base_addr_low
        add eax, [ebx + 8]; 加上length_low
        add ebx, 20 ; 网下一个ards描述符去
        cmp edx, eax ; 和之前ards描述符的上限比较，然后跳转
        jge .next_ards
        mov edx, eax
    .next_ards:
        loop .find_max_mem_area ;loop指令会使每循环一次，cx就对自身值减1操作，直到等于0为止，在此之前，一直重复执行标识符到loop间的代码
        jmp .mem_get_ok
    .get_mem_e280_error: ;0xe280获取失败使用e801
        mov ax, 0xe801 ; 改成0xe801功能的获取内存方案
        int 0x15; 再次调用0x15中断
        jc .e801_failed_so_try88 ;失败就使用0x88功能
        ;1 先算出来低15MB的内存  
        mov cx, 0x400
        mul cx
        shl edx, 16
        and eax, 0x0000FFFF
        or edx, eax
        add edx, 0x100000
        mov esi, edx
        ;2 接着算16MB以上的内存 字节为单位
        xor eax,eax
        mov ax,bx
        mov ecx,0x10000                                              ;0x10000为64KB  64*1024  
        mul ecx                                                      ;高32位为0 因为低32位即有4GB 故只用加eax
        mov edx,esi
        add edx,eax
        jmp .mem_get_ok
    .e801_failed_so_try88:
        mov ah,0x88
        int 0x15
        jc .error_hlt
        and eax,0x0000FFFF
        mov cx,0x400                                                 ;1024
        mul cx
        shl edx,16
        or edx,eax 
        add edx,0x100000
    .error_hlt:
        jmp $
    .mem_get_ok:
        mov [total_mem_bytes],edx
        ; 进入保护模式的代码
        mov sp,LOADER_BASE_ADDR					;这里疑惑了我许久 es我们没有初始化 值究竟是多 为什么等于cs
        mov bp,loadermsg                                          ;es:bp 字符串地址 ah 功能号 bh 页码 bl 属性 cx 字符串长度 
        mov cx,22     
        mov ax,cs                                                 ;于是我还是向把es给初始化了一下 保证心里面有底
        mov es,ax                                                 ;通过ax 赋值给es
        mov ax,0x1301                                             ;ah = 13 al = 0x1
        mov bx,0x001f                                             ;页码属性 可以不管
        mov dx,0x1800                                             ;dh = 0x18 == 24 意思是最后一行 0列开始
        int 0x10
        ; 打开A20限制
        mov dx, 0x92
        in al, dx
        or al, 0000_0010b
        out dx, al
        ; 准备gdt表
        
        lgdt [gdt_ptr]

        ; 设置cr0第0位是1
        mov eax, cr0
        or eax, 0x00000001
        mov cr0, eax
        ; 刷新流水线到32位
        jmp dword SELECTOR_CODE:p_mode_start
    [bits 32]
    p_mode_start: 
        mov ax,SELECTOR_DATA
        mov ds,ax
        mov es,ax
        mov ss,ax
        mov esp,LOADER_STACK_TOP
        mov ax,SELECTOR_VIDEO
        mov gs,ax
        mov byte [gs:160],'?'

        ; 读入的扇区数
        mov ecx, 200
        ; 起始扇区
        mov eax, KERNEL_STATE_SECTOR
        ; 内核虚拟地址位置
        mov ebx, KERNEL_BIN_BASE_ADDR
        ; 读取磁盘的操作系统内核到缓冲区，然后再把缓冲区的内容解析elf放到指定位置
        call rd_disk_m_32
        ; 为什么要在保护模式下建立页表？因为页表地址在0x100000往上，
        ; 而且如果满页表就以为止要4M + 4KB空间，loader部分肯定不够
        call .setup_page

        sgdt [gdt_ptr] ; 原来的gdt_ptr位置，这里还是存到gdt_ptr指向的内存，这里其实如果gdt_ptr位置的值没有变化是不用再次存储的

        mov edx, [gdt_ptr + 2] ; 拿到gdtr寄存器的高32位，也就是gdt表的起始位置
        ; 下面修改显存段的描述符，把显存段的描述符弄到高1G位置上去
        or dword [edx + 0x18 + 4], 0xc0000000
        ; 修改gdt表的地址
        add dword [gdt_ptr + 2], 0xc0000000
        ; 栈地址也移到高1G位置，后面由虚拟页表进行寻址
        add esp, 0xc0000000
        ; cr3赋予目录的地址
        mov eax, PAGE_TABLE_DIR_POS
        mov cr3, eax 
        ; 打开cr0的pg位，也就是最高位，正式开启分页
        mov eax, cr0
        or eax, 0x80000000
        mov cr0, eax
        ; 重新更新gdt描述符表
        lgdt [gdt_ptr]
        mov ax,SELECTOR_VIDEO
        mov gs,ax
        mov byte [gs:160],'V'
        jmp SELECTOR_CODE:enter_kernel
        ; 虚拟地址分页
        .setup_page:
            mov ecx, 4096
            mov esi, 0
            ; 先清空页目录项对应的地址
            .clear_page_dir:
                mov byte [PAGE_TABLE_DIR_POS + esi], 0
                inc esi
                cmp esi, ecx
                jne .clear_page_dir
            ; 建立页目录项
            .create_pde:
                mov eax, PAGE_TABLE_DIR_POS
                add eax, 0x1000 ; 页表第一项的位置
                mov ebx, eax ; 保存一下下一个的位置
                ; 低12位其实就三个重要的属性，其他不用处理，而且在此的数据后面12位都是0
                or eax, PG_RW_W | PG_US_U | PG_P
                ; 映射到高地址
                mov [PAGE_TABLE_DIR_POS + 0xc00], eax
                ; 映射到0开始的位置，实模式下使用这个来访存
                mov [PAGE_TABLE_DIR_POS + 0x00], eax
                sub eax, 0x1000
                mov [PAGE_TABLE_DIR_POS + 4092], eax
                
            ; 建立一张有256个页表项的页表
                mov ecx, 256
                mov esi, 0
                mov edx, PG_RW_W | PG_US_U | PG_P
            ; 这个页表代表的是从0开始到1M的低地址空间
            ; 目前就提供这一张页表给操作系统用，
            ; 上面通过把第768个页目录项指向本页表，达到了把第(3GB + 1)到(3GB + 1MB - 1)映射到了这张页表，
            ; 也就是(3GB + 1)到(3GB + 1MB - 1)其实是物理地址0-1M的地方
            .create_pte:
                mov [ebx + esi * 4], edx
                add edx, 4096
                inc esi
                loop .create_pte
                
                
                ; 建立其他更多空的页目录项
                mov eax, PAGE_TABLE_DIR_POS
                ; 从第二张页表开始把对应的页表地址放到页目录中
                add eax, 0x2000
                or eax, PG_RW_W | PG_US_U | PG_P
                mov ebx, PAGE_TABLE_DIR_POS
                mov ecx, 254
                ; 在高地址(1G)空间中添加
                mov esi, 769
            ; 把其他254个页目录项指向254个空的页表，这样内核的1G空间就准备好了
            ; 但是页目录项只有一个而且对应的页表也只有256个内存块，也就是此时可以使用的空间只有4KB * 256 = 1M 
            ; 对于本项目的内存其实已经够了
            .create_kernel_pde:
                mov [ebx + esi * 4], eax
                inc esi
                add eax, 0x1000
                loop .create_kernel_pde
                ret
            ; 32位下读取磁盘内核
            rd_disk_m_32:
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
                ; 注意在32位一个字是32位
                ; 在16位的系统中（比如8086微机） 1字 （word）= 2字节（byte）= 16（bit）
                ; 在32位的系统中（比如win32） 1字（word）= 4字节（byte）=32（bit）
                ; 在64位的系统中（比如win64）1字（word）= 8字节（byte）=64（bit）
                mov [ebx], ax
                add ebx, 2
                loop .go_on_read
                ret 
    enter_kernel:
        call kernel_init
        mov esp, 0xc009f000
        jmp KERNEL_ENTRY_POINT
        ; 根据ELF格式解析内核并放置到hiding的内存位置
        kernel_init:
            xor eax, eax
            xor ebx, ebx ; ebx读取程序头表
            xor ecx, ecx ; cx 记录程序头表中的program header的数量
            xor edx, edx ; dx记录用于放program header的内存尺寸， 即e_phentsize
            ; ELF头解析
            
            ; 拿到e_phentsize
            mov dx, [KERNEL_BIN_BASE_ADDR + 42]
            ; 第一个program header的偏移位置，这个偏移位置是相对于整个ELF文件的
            mov ebx, [KERNEL_BIN_BASE_ADDR + 28]
            add ebx, KERNEL_BIN_BASE_ADDR
            ; 有多少的program header
            mov cx, [KERNEL_BIN_BASE_ADDR + 44]
            .each_segment: ; 遍历每一个段
            cmp byte [ebx + 0], PT_NULL
            je .PTNULL
            ; 为函数memcpy压入参
            ; 压入p_filesz，本端在文件中的大小
            push dword [ebx + 16]
            ; 压入本段在内存的起始位置
            mov eax, [ebx + 4]
            add eax, KERNEL_BIN_BASE_ADDR
            push eax
            ; 压入p_vaddr, 本端在内存的虚拟地址
            push dword [ebx + 8]
            call mem_copy
            ; 还回来三个参数的栈空间
            add esp ,12
        .PTNULL:
            add ebx, edx
            loop .each_segment
            ret        
        mem_copy:
            cld                                                        ;向高地址自动加数字 cld std 向低地址自动移动
            push ebp                                                   ;保存ebp 因为访问的时候通过ebp 良好的编程习惯保存相关寄存器
            mov  ebp,esp 
            push ecx                                                   ;外层循环还要用 必须保存 外层eax存储着还有几个段
            
                                                                       ;分析一下为什么是 8 因为进入的时候又重新push了ebp 所以相对应的都需要+4
                                                                       ;并且进入函数时 还Push了函数返回地址 所以就那么多了
            mov edi,[ebp+8]                                            ;目的指针 edi存储的是目的位置 4+4
            mov esi,[ebp+12]                                           ;源指针   源位置             8+4
            mov ecx,[ebp+16]                                           ;与Movsb好兄弟 互相搭配      12+4
            
            
            rep movsb                                                  ;一个一个字节复制
            
            pop ecx 
            pop ebp
            ret