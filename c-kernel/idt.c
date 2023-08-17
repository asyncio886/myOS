#include "print.h"
#include "idt.h"
#include "type.h"
#include "io.h"
#include "memory.h"
#ifdef __INCLUDE_IDT
#define PAGEFAULT_INTR 14
#define TIMER_INTR 
#include "global.h"
struct gate_desc idt[IDT_DESC_CNT];
char *intr_name[IDT_DESC_CNT];
// 自己用C语言写的中断处理，给汇编去调用的
intr_handler idt_table[IDT_DESC_CNT];
static void register_interrupt(int idt_num, void (*handler)())
{
    idt_table[idt_num] = handler;
}
static void make_idt_desc(struct gate_desc *p_desc, uint8_t attr, intr_handler function)
{
    p_desc->func_offset_low_wrod = (uint32_t)function & 0x0000FFFF;
    p_desc->func_offset_high_word = ((uint32_t)function & 0xFFFF0000) >> 16;
    p_desc->dcount = 0;
    p_desc->attribute = attr;
    // 因为最终指向的是内核代码
    p_desc->selector = SELECTOR_K_CODE;
}
static void idt_desc_init()
{
    int i;
    for (i = 0; i < IDT_DESC_CNT; i++)
    {
        make_idt_desc(&idt[i], IDT_DESC_ATTR_DPL0, intr_entry_table[i] /* 这个数组里面存了中断处理函数的地址 */);
    }
}

#define PIC_M_CTRL 0x20
#define PIC_M_DATA 0x21
#define PIC_S_CTRL 0xa0
#define PIC_S_DATA 0xa1
static void pic_init()
{
    outb(PIC_M_CTRL, 0x11);
    outb(PIC_M_DATA, 0x20);
    outb(PIC_M_DATA, 0x04);
    outb(PIC_M_DATA, 0x01);

    outb(PIC_S_CTRL, 0x11);
    outb(PIC_S_DATA, 0x28);
    outb(PIC_S_DATA, 0x02);
    outb(PIC_S_DATA, 0x01);
    outb(PIC_M_DATA, 0xfe);
    outb(PIC_S_DATA, 0xff);
    print_str("\npic init done\n");
}
void idt_init()
{
    print_str("idt init start\n");
    idt_desc_init(); // 中断描述符初始化完成
    pic_init();      // 初始化pic芯片
    uint64_t idt_operand = ((sizeof(idt) - 1) | ((uint64_t)((uint32_t)idt) << 16));
    print_str("\n");
    asm volatile("lidt %0" ::"m"(idt_operand));
}
static void general_intr_handler(uint8_t vec_nr)
{
    if (vec_nr == 0x27 || vec_nr == 0x2f)
    {
        // 伪中断不处理
        return;
    }
    // print_format("intr %d", vec_nr);
    // println(intr_name[vec_nr]);
}
// 初始化中断，让可以在C语言中编写中断函数
void exception_init()
{
    int i;
    for (i = 0; i < IDT_DESC_CNT; i++)
    {
        idt_table[i] = general_intr_handler;
        intr_name[i] = "unknown";
    }
    intr_name[0] = "#DE Divide Error";
    intr_name[1] = "#DB Debug Exception";
    intr_name[2] = "NMI Interrupt";
    intr_name[3] = "#BP Breakpoint Exception";
    intr_name[4] = "#OF Overflow Exception";
    intr_name[5] = "#BR BOUND Range Exceeded Exception";
    intr_name[6] = "#UD Invalid Opcode Exception";
    intr_name[7] = "#NM Device Not Available Exception";
    intr_name[8] = "#DF Double Fault Exception";
    intr_name[9] = "Coprocessor Segment Overrun";
    intr_name[10] = "#TS Invalid TSS Exception";
    intr_name[11] = "#NP Segment Not Present";
    intr_name[12] = "#SS Stack Fault Exception";
    intr_name[13] = "#GP General Protection Exception";
    intr_name[14] = "#PF Page-Fault Exception";
    // intr_name[15] 第15项是intel保留项，未使用
    intr_name[16] = "#MF x87 FPU Floating-Point Error";
    intr_name[17] = "#AC Alignment Check Exception";
    intr_name[18] = "#MC Machine-Check Exception";
    intr_name[19] = "#XF SIMD Floating-Point Exception";
}
#endif