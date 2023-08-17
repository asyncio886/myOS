#ifndef __INCLUDE_THREAD
#define __INCLUDE_THREAD
#include "type.h"
// 线程魔数
#define STACK_MAGIC 0x19870916
#include "list.h"
#include "global.h"
enum task_status
{
    TASK_RUNNING,
    TASK_READY,
    TASK_BLOCKD,
    TASK_WAITING,
    TASK_HANGING,
    TASK_DIED
};

typedef void thread_func(void *);

// 中断发生时的保护栈
struct intr_stack
{
    // 中断号
    uint32_t vec_no;
    
    uint32_t edi;
    uint32_t esi;
    uint32_t ebp;
    uint32_t esp_dump;
    uint32_t ebx;
    uint32_t edx;
    uint32_t ecx;
    uint32_t eax;
    uint32_t gs;
    uint32_t fs;
    uint32_t es;
    uint32_t ds;

    uint32_t err_code;
    // 指向原来执行的函数
    void (*eip)(void);
    uint32_t cs;
    uint32_t eflags;
    void *esp;
    uint32_t ss;
};

// 线程栈
struct thread_stack
{
    uint32_t ebp;
    uint32_t ebx;
    uint32_t edi;
    uint32_t esi;
    // ret调用跳转到这个地址
    void (*eip)(thread_func *func, void *func_arg);
    void(*unused_retaddr);
    // 传给 kernel_thread方法，然后调用function，只在第一次调用时有用
    thread_func *function;
    void *func_arg;
};

struct task_struct {
    uint32_t* self_kstack; // 保存栈指针
    enum task_status status;
    char name[16];
    uint8_t priority;
    uint8_t ticks; // 一次可以运行多少个时钟周期
    uint8_t elapsed_ticks; // 总共在运行过了几个时钟周期数
    struct list_elem general_tag; // 在一般队列中的节点 
    struct list_elem all_list_tag; // 在线程队列的节点
    uint32_t* pgdir; // 进程自己所在虚拟页表的地址，如果是线程，这里就是NULL
    struct virtual_addr userprog_vaddr; // 用户进程维护的虚拟地址
    uint32_t stack_magic; // 栈边界
};
extern struct task_struct *main_thread;     // 主线程PCB
extern struct list thread_ready_list;       // 就绪队列，等待上本CPU的队列
extern struct list thread_all_list;
extern struct list_elem *thread_tag; // 当前线程的list_elem
struct task_struct* thread_start(char* name, int prio, thread_func function, void* func_arg);
// 从cur切换到next
extern void switch_to(struct task_struct *cur, struct task_struct *next);
struct task_struct *running_thread();
/*
    初始化线程队列等
*/
void thread_init();
void schedule();
void thread_block(enum task_status stat);
// 解除pthread的非ready状态
void thread_unblock(struct task_struct* pthread);
#endif