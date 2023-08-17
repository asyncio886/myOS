#include "process.h"
#ifdef __INCLUDE_PROCESS
#include "thread.h"
#include "memory.h"
#include "userprog.h"
#include "global.h"
#include "tss.h"
#include "debug.h"
// 构建上下文信息并启动
void start_process(void* filename_) {
    void* function = filename_;
    struct task_struct* cur = running_thread();
    // 加上正常压栈，这样sef_statck就指向了中断的时候的压栈，也就是intr_stack
    cur->self_kstack += sizeof(struct thread_stack);
    struct intr_stack* proc_stack = (struct intr_stack *) cur->self_kstack;
    proc_stack->edi = proc_stack->esi \
     = proc_stack->ebp = proc_stack->esp_dump = 0;
    proc_stack->ebx = proc_stack->edx = proc_stack->ecx = proc_stack->eax = 0;
    proc_stack->gs = 0;
    proc_stack->ds = proc_stack->es = proc_stack->fs = SELECTOR_U_DATA;
    proc_stack->eip = function;
    proc_stack->cs = SELECTOR_U_CODE;
    proc_stack->eflags = (EFLAGS_IOPL_0 | EFLAGS_MBS | EFLAGS_IF_1);
    // 分配一块PCB并把esp移到顶端，因为PCB在内核中，用户进程不能用内核栈
    proc_stack->esp = (void*) ((uint32_t)(get_a_page(PF_USER, USER_STACK3_VADDR) + PG_SIZE));
    proc_stack->ss = SELECTOR_U_DATA;
    asm volatile ("movl %0, %%esp; jmp intr_exit;"::"g"(proc_stack):"memory");
}
// 激活页表，就是把页表的保护模式下物理地址放到cr3寄存器中
void page_dir_activate(struct task_struct* p_thread) {
    uint32_t pagedir_phy_addr = PAGE_TABLE_POS;
    if(p_thread->pgdir != NULL) {
        pagedir_phy_addr = add_v2p((uint32_t) p_thread->pgdir);
    }
    // 更新cr3寄存器实现切换页表
    asm volatile("movl %0, %%cr3"::"r"(pagedir_phy_addr):"memory");
}
// 激活线程或者进程的页表，若是用户态，则要更新tss中的esp0为特权级0的栈
void process_activate(struct task_struct* pthread) {
    ASSERT(pthread != NULL);
    page_dir_activate(&pthread);
    if (pthread->pgdir != NULL)
    {
        update_tss_esp(pthread);
    }
}
#endif