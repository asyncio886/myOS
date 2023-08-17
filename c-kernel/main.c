#include "type.h"
#include "print.h"
#include "idt.h"
#include "timer.h"
#include "interrupt.h"
#define NDEBUG
#include "string.h"
#include "debug.h"
#include "memory.h"
#include "thread.h"
#include "list.h"
#include "sync.h"
#include "console.h"
#include "tss.h"
void init_all();
void k_thread_a(void*);
int main(void)
{
    clear_screen();
    print_str("hello welcome myOS\n");
    print_str("now let's init IDT\n");
    print_str("...\n");
    init_all();
    while(1);
    return 0;
}
void init_all() {
    idt_init();
    exception_init();
    init_memory();
    // 线程需要先初始化，因为要初始化操作系统主线程到链表中
    thread_init();
    timer_init();
    intr_enable();
    console_init();
    tss_init();
}
void k_thread_a(void* args) {
    char* para = args;
    while (1)
    {
        console_log((char*) args);
    }
}
#include "print.c"
#include "idt.c"
#include "timer.c"
#include "interrupt.c"
#include "debug.c"
#include "string.c"
#include "bitmap.c"
#include "memory.c"
#include "thread.c"
#include "list.c"
#include "sync.c"
#include "console.c"
#include "tss.c"