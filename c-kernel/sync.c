#include "sync.h"
#ifdef __INCLUDE_SYNC
#include "type.h"
#include "list.h"
#include "global.h"
#include "interrupt.h"
#define NDEBUG
#include "debug.h"
#include "thread.h"
// 初始化信号量
void sema_init(struct semaphore* sema, uint8_t value) {
    sema->value = value;
    list_init(&sema->waiters);
}

// 初始化锁
void lock_init(struct lock* plock) {
    plock->holder = NULL;
    plock->holder_repeat_nr = 0;
    // 只有一个信号量
    sema_init(&plock->semaphore, 1);
}
// 减少一个信号量，需要关中断
void sema_down(struct semaphore* sema) {
    enum intr_status old_intr_status = intr_disable();
    // 等于的时候需要阻塞本线程，即把本线程从read_list上面拿走
    // 等于零就要准备阻塞
    while (sema->value == 0)
    {
        ASSERT(!elem_find(&sema->waiters, &running_thread()->general_tag));
        list_append(&sema->waiters, &running_thread()->general_tag);
        // 转去运行其他线程
        thread_block(TASK_BLOCKD);
    }
    // 被其他线程操作sema导致重新加入ready_list
    sema->value--;
    intr_set_status(old_intr_status);
}

// 增加一个信号量，并唤醒其他线程
void sema_up(struct semaphore* sema) {
    enum intr_status old_intr_status = intr_disable();
    if(!list_empty(&sema->waiters)) {
        struct task_struct* next_pcb = elem2entry(struct task_struct, \
        general_tag, \
        list_pop(&sema->waiters));
        thread_unblock(next_pcb);
    }
    sema->value++;
    intr_set_status(old_intr_status);
}

void lock_aquire(struct lock* plock) {
    struct task_struct* cur_pcb = running_thread();
    if(plock->holder == cur_pcb) {
        // 增加一次重入次数
        plock->holder_repeat_nr++;
    }
    else {
        sema_down(&plock->semaphore);
        plock->holder = cur_pcb;
        plock->holder_repeat_nr = 1;
    }
}

void lock_release(struct lock* plock) {
    struct task_struct* cur_task = running_thread();
    if(plock->holder != cur_task) {
        ASSERT("cur thread not hold the lock");
        return;
    }
    if(plock->holder_repeat_nr > 1) {
        plock->holder_repeat_nr--;
        return;
    }
    plock->holder = NULL;
    plock->holder_repeat_nr = 0;
    sema_up(&plock->semaphore);
}

#endif