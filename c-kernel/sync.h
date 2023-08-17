#ifndef __INCLUDE_SYNC
#define __INCLUDE_SYNC
#include "type.h"
#include "list.h"
struct semaphore {
    // 这个信号量数
    uint8_t value;
    // 等待队列
    struct list waiters;
};
struct lock {
    struct task_struct* holder; // 锁持有者
    struct semaphore semaphore; // 信号量，只有两个状态
    uint32_t holder_repeat_nr; // 锁重入次数
};
void sema_init(struct semaphore* sema, uint8_t value);
void lock_init(struct lock* plock);
void sema_down(struct semaphore* sema);
void sema_up(struct semaphore* sema);
void lock_aquire(struct lock* plock);
void lock_release(struct lock* plock);
#endif