#ifndef __INCLUDE_INTERRUPT
#define __INCLUDE_INTERRUPT
#define EFLAGS_IF 0x00000200
#define GET_EFLAGS(EFLAG_VAR) asm volatile("pushfl; popl %0":"=g"(EFLAG_VAR))
// 用于标识中断的状态
enum intr_status {
    INTR_ON,
    INTR_OFF
};

enum intr_status intr_get_status();
enum intr_status intr_set_status(enum intr_status);
enum intr_status intr_enable();
enum intr_status intr_disable();
#endif