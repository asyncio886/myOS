#include "interrupt.h"
#ifdef __INCLUDE_INTERRUPT
#include "idt.h"
#include "type.h"
// 注意sti和cli两个指令，他们都是操作是否允许外部中断
// 内中断是无法关闭的，sti是允许外部中断，cli是禁止外部中断
/** 开中断并返回之前的状态 */
enum intr_status intr_enable() {
    enum intr_status old_status;
    if(INTR_ON == intr_get_status()) {
        old_status = INTR_ON;
        return old_status;
    }
    else {
        old_status = INTR_OFF;
        asm volatile("sti");
        return old_status;
    }
}

/** 关中断，并返回之前的状态 */
enum intr_status intr_disable() {
    enum intr_status old_status;
    if(INTR_ON == intr_get_status()) {
        old_status = INTR_ON;
        asm volatile("cli":::"memory");
        return old_status;
    }
    else {
        old_status = INTR_OFF;
        return old_status;
    }
}
/**设置中断接受状态并反之之前的状态*/
enum intr_status intr_set_status(enum intr_status status) {
    return status == INTR_ON ? intr_enable() : intr_disable();
}


enum intr_status intr_get_status(){
    uint32_t eflags = 0;
    GET_EFLAGS(eflags);
    return (EFLAGS_IF & eflags) ? INTR_ON : INTR_OFF;
}
#endif