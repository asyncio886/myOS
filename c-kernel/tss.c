#include "tss.h"
#ifdef __INCLUDE_TSS
#include "print.h"
#include "memory.h"
#include "string.h"
struct tss tss;
// 更新tss中的esp0字段为指定线程的esp
void update_tss_esp(struct task_struct* pthread) {
    tss.esp0 = (uint32_t*)((uint32_t) pthread + PG_SIZE);
}
// 创建一个gdt
struct gdt_desc make_gdt_desc(uint32_t* desc_addr, uint32_t limit, uint8_t attr_low, uint8_t attr_high) {
    uint32_t desc_base = (uint32_t) desc_addr;
    print_format("pos is %x", desc_base);
    struct gdt_desc desc;
    desc.limit_low_word = limit & 0x0000ffff;
    desc.base_low_word = desc_base & 0x0000ffff;
    desc.base_mid_byte = ((desc_base & 0x00FF0000) >> 16);
    desc.attr_low_byte = (uint8_t)(attr_low);
    desc.limit_high_attr_high = (((limit & 0x000f0000) >> 16) + (uint8_t)(attr_high));
    desc.base_high_byte = desc_base >> 24;
    println("make one");
    return desc;
}
// 创建一个tss，放到gdt表中，并重新加载gdt
void tss_init() {
    println("tss init start");
    uint32_t tss_size = sizeof(struct tss);
    memset(&tss, 0, tss_size);
    tss.ss0 = SELECTOR_K_CODE;
    tss.io_base = tss_size;
    uint32_t gdt_entry_size = sizeof(struct gdt_desc);
    // gdt表的位置
    struct gdt_desc* gdt_ptr = (struct gdt_desc*) GDT_ADDR;
    // 已经有了四个段描述符，第0个是无效用，第一个是代码段，第二个是数据段，第三个是显存段，所以从第四个开始往里面加
    print_format("start make gdt %x", (uint32_t) (&gdt_ptr[4]));
    // 添加tss
    gdt_ptr[4] = make_gdt_desc((uint32_t*) &tss, tss_size - 1, TSS_ATTR_LOW, TSS_ATTR_HIGH);
    // 添加dpl为3的数据段和代码段
    print_format("start make gdt %x", (uint32_t) (&gdt_ptr[5]));
    gdt_ptr[5] = make_gdt_desc((uint32_t*) 0, 0xfffff, GDT_CODE_ATTR_LOW_DPL3, GDT_ATTR_HIGH);
    print_format("start make gdt %x", (uint32_t) (&gdt_ptr[6]));
    gdt_ptr[6] = make_gdt_desc((uint32_t*) 0, 0xfffff, GDT_DATA_ATTR_LOW_DPL3, GDT_ATTR_HIGH);
    println("start make successfully");
    uint64_t gdt_operand = ((8 * 7 - 1) | ((uint64_t) (uint32_t) GDT_ADDR << 16));
    asm volatile("lgdt %0"::"m"(gdt_operand));
    asm volatile("ltr %w0"::"r"(SELECTOR_TSS));
    println("tss init ok");
}
#endif