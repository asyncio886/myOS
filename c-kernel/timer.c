#include "print.h"
#include "io.h"
#include "timer.h"
#include "idt.h"
#include "thread.h"
#include "list.h"
#ifdef __INCLUDE_TIMER
static void frequency_set(uint8_t counter_port,
                          uint8_t counter_no,
                          uint8_t rwl,
                          uint8_t counter_mode,
                          uint16_t counter_value)
{
    outb(PIT_COUNTROL_PORT,
         (uint8_t)(counter_no << 6 | rwl << 4 | counter_mode << 1));
    outb(counter_port, (uint8_t)counter_value);
    outb(counter_port, (uint8_t)counter_value >> 8);
}
uint32_t ticks = 0; // 记录整个cpu运行时间的滴答数
static void intr_timer_handler()
{
    struct task_struct *current_pcb = running_thread();
    // 检测是否栈溢出
    ASSERT(current_pcb->stack_magic == STACK_MAGIC);
    current_pcb->elapsed_ticks++;
    ticks++;
    // 本次运行时间结束，进行跳读下一个线程
    if (current_pcb->ticks == 0)
    {
        schedule();
    }
    else
    {
        current_pcb->ticks--; // 时间片减少
    }
}
void timer_init()
{
    print_str("timer_init ...\n");
    frequency_set(COUNTER0_PORT, COUNTER0_NO, READ_WRITE_LATCH, COUNTER_MODE, COUNTER0_VALUE);
    print_str("timer init ok\n");
    register_interrupt(0x20, intr_timer_handler);
}
#endif