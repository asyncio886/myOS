#ifndef __INCLUDE_MEMORY
#define __INCLUDE_MEMORY
#include "bitmap.h"
#include "type.h"
#include "sync.h"
// 页表项或者页目录项是否存在
#define PG_P_1 1
#define PG_P_0 0
// 页面是否可读与可写，页表项有，页目录项没有
#define PG_RW_R 0
#define PG_RW_W 2
// 系统级还是用户级内存，只有页表项存在
#define PG_US_S 0
#define PG_US_U 4
// 获得页目录项索引
#define PDE_IDX(addr) ((addr & 0xffc00000) >> 22)
// 获得页表项索引
#define PTE_IDX(addr) ((addr & 0x003ff000) >> 12) 
// 一个pde或者pte的大小都是32位，4字节
#define PDE_PTE_SIZE 4
// debug出来的地址，loader的代码不和书上一样
#define MAX_MEM_SIZE_PTR 0x0c16 
#define PG_SIZE 4096 
#define K_HEAP_START 0xc0100000
#define MEM_BITNAP_BASE 0xc009a000
struct virtual_addr {
    struct bitmap vaddr_bitmap; // 虚拟地址的位图
    uint32_t vaddr_start; // 虚拟地址起始位置
};
// 内存池结构，用来模拟记录真是物理内存的情况
struct pool
{
    struct bitmap pool_bitmap; // 本内存池的位图 
    uint32_t phy_addr_start; // 本内存池开始的物理地址，也不是真的物理地址，是在分页机制下的地址
    uint32_t pool_size; // 内存池的大小单位字节
    struct lock lock;
};
// 内存池的类型
enum pool_flags {
    PF_KERNEL = 1,
    PF_USER = 2
};
extern struct pool kernel_pool, user_pool;
void init_memory();
void* get_kernel_pages(uint32_t pg_cnt);
void *palloc(struct pool *m_pool);
void page_table_add(void *_vaddr, void *_page_phyaddr);
void *get_a_page(enum pool_flags pf, uint32_t vaddr);
uint32_t add_v2p(uint32_t vaddr);
#endif