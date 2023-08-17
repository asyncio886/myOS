#ifndef __INCLUDE_PROCESS
#define __INCLUDE_PROCESS
// 构建用户上下文空间并运行
void start_process(void* filename_);
// 激活页表
void page_dir_activate(struct task_struct* p_thread);
#endif