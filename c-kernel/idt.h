#ifndef __INCLUDE_IDT
#define __INCLUDE_IDT
#include "type.h"
#include "global.h"
#define IDT_DESC_CNT 0x21
#define ICW1 
static void register_interrupt(int idt_num, void (*handler)());
static void make_idt_desc(struct gate_desc* p_desc, uint8_t attr, intr_handler function);
static void idt_desc_init();
void idt_init();
static void pic_init();
// 这不分目前是在汇编里面进行global声明的
extern intr_handler intr_entry_table[IDT_DESC_CNT];
void exception_init();
#endif