#include "thread.h"
#ifdef __INCLUDE_THREAD
#include "string.h"
#include "memory.h"
#include "debug.h"
#include "list.h"
#include "interrupt.h"
#define NDEBUG
#define PG_SZIE 4096
// 这些队列空间要求很小，就固化到了操作系统代码区
struct task_struct *main_thread;     // 主线程PCB
struct list thread_ready_list;       // 就绪队列，等待上本CPU的队列
struct list thread_all_list;         // 全部线程队列
struct list_elem *thread_tag; // 当前线程的list_elem
/* kernel_thread去执行function */
static void kernel_thread(thread_func* function, void* func_args) {
    // 执行前要开中断，后面接受时钟中断去调度
    intr_enable();
    function(func_args);
}
/*
    构建线程，初始化线程栈，参数等
*/
void thread_create(struct task_struct *pthread, thread_func function, void *func_args)
{
    // 线程调度用中断完成，先预留中断的栈
    pthread->self_kstack -= sizeof(struct intr_stack);
    // 预留线程空间
    pthread->self_kstack -= sizeof(struct thread_stack);

    // 拿到线程栈空间
    struct thread_stack *kthread_stack = (struct thread_stack *)(pthread->self_kstack);
    kthread_stack->eip = kernel_thread;
    kthread_stack->function = function;
    kthread_stack->func_arg = func_args;
    // 初始化所有保存的寄存器
    kthread_stack->ebp = kthread_stack->ebx =
        kthread_stack->esi = kthread_stack->edi = 0;
    /*
    PCB初始化为
    |-----------------------------------------------------------------------------------------------------
    |...name等属性|.......空.......|ebp|ebx|edi|esi|eip|unused_retaddr|function|func_args|...intr_stack...| 栈底
    |-----------------------------------------------------------------------------------------------------

    */
}

void init_thread(struct task_struct *pthread, char *name, int prio /* 优先级 */)
{
    memset(pthread, 0, sizeof(*pthread));
    strcpy(pthread->name, name);
    // 处理main函数，main函数从操作系统启动开始都是一直运行
    if(pthread == main_thread) {
        pthread->status = TASK_RUNNING;
    }
    else {
        pthread->status = TASK_READY;
    } 
    pthread->priority = prio;
    // pcb的最高地址为栈底
    pthread->self_kstack = (uint32_t *)((uint32_t)pthread + PG_SZIE);
    pthread->stack_magic = STACK_MAGIC;
    pthread->ticks = prio;
    // pcb结构
    // 下面是一页内存
    /*
                                                                             |<--一旦魔数变化了说明栈发生了溢出        |<-栈底指针指向的位置
    |---------------------------------------------------------------------------------------------------------------|
    |self_kstack(栈指针) | status（状态) | priority(优先级) | name(线程名标识) | 魔数 | ...........空(用于栈)..........|
    |---------------------------------------------------------------------------------------------------------------|
    */
}

struct task_struct *thread_start(char *name, int prio, thread_func function, void *func_arg)
{
    // 分配一个内核PCB空间
    // 内核和用户线程的PCB都在内核空间
    void *pcb = get_kernel_pages(1);
    init_thread((struct task_struct *)pcb, name, prio);
    thread_create((struct task_struct *)pcb, function, func_arg);
    struct task_struct *thread = (struct task_struct *)pcb;
    // 确保之前不在队列中
    ASSERT(!(elem_find(&thread_ready_list, &thread->general_tag)));
    list_append(&thread_ready_list, &thread->general_tag);
    /*
        ret是跳转扫eip指针的位置
    */
    // asm volatile("movl %0, %%esp; pop %%ebp; pop %%ebx; pop %%edi; pop %%esi; ret;" ::"g"(thread->self_kstack)
    //              : "memory");
    // 不能在队列中
    ASSERT(!(elem_find(&thread_all_list, &thread->all_list_tag)));
    list_append(&thread_all_list, &thread->all_list_tag);
    return thread;
}


// 获取当前线程PCB
struct task_struct *running_thread()
{
    uint32_t esp;
    asm volatile("mov %%esp, %0"
                 : "=g"(esp));
    // esp指针在页面最高位，也是PCB的最高位，一个页面一个PCB，而且一个页面1KB，所以取到前20位就是PCB起始地址
    return (struct task_struct*)(esp & 0xfffff000);
}



// 因为现在主线程也就是本线程还没有在现在的队列中记录，所以这里需要把现在的线程加入到队列中
static void make_main_thread() {
    // 进入内核的时候我们把esp进行了mov esp, 0xc009f000，
    // 所以现在的PCB起始因该在0xc009f000 - 0x1000 = 0xc009e000
    
    // 现在栈还是main线程中中，只要用running_thread就可以拿到现在的PCB的基地址 
    main_thread = running_thread();
    init_thread(main_thread, "main_thread", 31);
    // 必须不再所有队列中才能加入队列
    // 这里因为是主线程，必然是在运行的，不用加入ready_list
    ASSERT(!(elem_find(&thread_all_list, &main_thread->all_list_tag)));
    list_append(&thread_all_list, &main_thread->all_list_tag);
}
void thread_init() {
    print_str("thread_init start\n");
    list_init(&thread_ready_list);
    list_init(&thread_all_list);
    make_main_thread();
    print_str("thread init ok\n");
}

void schedule()
{
    // 必须在关中断下实现
    ASSERT(intr_get_status() == INTR_OFF);
    struct task_struct *cur = running_thread();
    if (cur->status == TASK_RUNNING)
    {
        // 必须不在预备队列里
        ASSERT(!elem_find(&thread_ready_list, &cur->general_tag));
        // 重置之后加入预备队列
        cur->ticks = cur->priority;
        cur->status = TASK_READY;
        // 加入预备队列末尾
        list_append(&thread_ready_list, &cur->general_tag);
    }
    else
    {
        /*TODO 其他状态 */
    }
    ASSERT(!list_empty(&thread_ready_list));
    thread_tag = NULL;
    // 取出队列第一个任务运行
    thread_tag = list_pop(&thread_ready_list);
    struct task_struct *next = elem2entry(struct task_struct,\
         general_tag,\
          thread_tag);
    next->status = TASK_RUNNING;
    switch_to(cur, next);
}
// 终止现在的线程
void thread_block(enum task_status stat) {
    ASSERT(stat == TASK_BLOCKD || stat == TASK_WAITING || stat == TASK_HANGING);
    // 关中断保证不会被终止执行流
    enum intr_status old_intr_status = intr_disable();
    struct task_struct* pcb = running_thread();
    // 这里需要提前把stat置为block或者其他状态，否则会装入ready_list
    pcb->status = stat;
    // 调度其他线程
    schedule();
    intr_set_status(old_intr_status);
}
// 解锁某个线程
void thread_unblock(struct task_struct* pthread) {
    // 关中断保证原子性
    enum intr_status old_intr_status = intr_disable();
    ASSERT(!(pthread->status == TASK_READY || pthread->status == TASK_RUNNING));
    if(pthread->status != TASK_READY) {
        // 不能是ready状态
        ASSERT(!(elem_find(&thread_ready_list, &pthread->general_tag)));
        // 加入就绪队列准备调用
        list_push(&thread_ready_list, &pthread->general_tag);
        pthread->status = TASK_READY;
    }
    intr_set_status(old_intr_status);
}
#endif