[bits 32]
%define ERROR_CODE nop
%define ZERO push 0
extern idt_table
section .data
intr_str db "interrput occur!", 0xa, 0
global intr_entry_table
intr_entry_table:
%macro VECTOR 2
section .text
intr_%1_entry:
    %2
    push ds
    push es
    push fs
    push gs
    pushad
    mov al, 0x20
    out 0xa0, al
    out 0x20, al
    push %1 ; 压入一个中断号先
    call [idt_table + 4 * %1]
    ; 退出中断
    jmp intr_exit
section .data
    dd intr_%1_entry
%endmacro

section .text
global intr_exit
intr_exit:
    add esp, 4
    popad
    pop gs
    pop fs
    pop es
    pop ds
    add esp, 4
    iretd
VECTOR 0x0 ,ZERO
VECTOR 0X1 ,ZERO
VECTOR 0X2 ,ZERO
VECTOR 0x3 ,ZERO
VECTOR 0X4 ,ZERO
VECTOR 0X5 ,ZERO
VECTOR 0x6 ,ZERO
VECTOR 0X7 ,ZERO
VECTOR 0X8 ,ERROR_CODE
VECTOR 0x9 ,ZERO
VECTOR 0XA ,ERROR_CODE
VECTOR 0XB ,ERROR_CODE
VECTOR 0XC ,ERROR_CODE
VECTOR 0XD ,ERROR_CODE
VECTOR 0XE ,ERROR_CODE
VECTOR 0XF ,ZERO
VECTOR 0X10 ,ZERO
VECTOR 0X11 ,ERROR_CODE
VECTOR 0x12 ,ZERO
VECTOR 0X13 ,ZERO
VECTOR 0X14 ,ZERO
VECTOR 0x15 ,ZERO
VECTOR 0X16 ,ZERO
VECTOR 0X17 ,ZERO
VECTOR 0X18 ,ZERO
VECTOR 0X19 ,ZERO
VECTOR 0X1A ,ZERO
VECTOR 0X1B ,ZERO
VECTOR 0X1C ,ZERO
VECTOR 0X1D ,ZERO
VECTOR 0X1E ,ERROR_CODE                               ;处理器自动推错误码
VECTOR 0X1F ,ZERO
VECTOR 0X20 ,ZERO
global switch_to
section .text  
    switch_to:
        ; 进入时栈内容从顶向底分别是 cur的ret_addr, cur, next

        ; 根据C语言的ebi规范，备份这四个寄存器，保证在运行其他函数后这些寄存器的值可以恢复
        ; 注意在这里是cur线程栈中
        ; 和thread_stack的顺序相比是倒着压栈
        push esi
        push edi
        push ebx
        push ebp
        ; 拿到cur的PCB起始地址
        mov eax, [esp + 20]
        ; 保存到self_kstack中，self_stack是指向thread_stack的指针，是PCB的一部分
        ; self_stack是PCB地址上最低32位的属性，直接mov就可
        ; struct task_struct {
        ;    uint32_t* self_kstack;
        ;    ...
        mov [eax], esp

        ; 上面的是cur线程
        ; --------------------
        ; 下面的是next线程
        ; 把next的pcb的低32位拿到eax中，也就是self_stack
        mov eax, [esp + 24]
        ; 正式切到next执行switch_to函数的时候的栈
        mov esp, [eax]
        ; 恢复现场
        ; 如果是第一次调度，则是读取PCB的thread_stack里面的内容，最后ret到的是函数起始位置
        pop ebp
        pop ebx
        pop edi
        pop esi
        ; 在esi后面就是eip指针，通过这个ret指令读取栈顶的这个eip去接着运行
        ; 这里的栈内容从顶向底是 next的ret_addr, 上次由next调用switch_to方法的cur(也就是next), 上次由next调用switch_to方法的next 
        ; 根据栈顶的地址返回到原来的中断程序中，在从中断程序中返回到next中运行

        ret


