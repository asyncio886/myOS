#include "memory.h"
#ifdef __INCLUDE_MEMORY
// 一个内存页的大小
#include "print.h"
#include "global.h"
#define NDEBUG
#include "debug.h"
// 内核的虚拟地址状态
struct virtual_addr kernel_vaddr;
// 模拟物理地址
struct pool kernel_pool, user_pool;
// 这里就涉及到进程线程相关的内容
// 详细见书的384页
void init_memory_pool(uint32_t all_mem)
{
    print_str("memory init start");
    lock_init(&kernel_pool.lock);
    lock_init(&user_pool.lock);
    uint32_t page_table_szie = PG_SIZE * 256; // 目前内存页表的大小
    // (下面讨论都是物理地址)
    // 低地址(映射到虚拟地址是0x00000000-0x00100000和0xc0000000-0xc0100000
    //  )0x100000大小内存是放操作系统代码的地方，在0x100000后面有目前构建的页表，大小是page_table_szie
    //  ，不与其他任务使用
    uint32_t used_mem = page_table_szie + 0x100000;
    uint32_t free_mem = all_mem - used_mem;
    uint16_t all_free_pages = free_mem / PG_SIZE;
    uint16_t kernel_free_pages = all_free_pages / 2;
    uint16_t user_free_pages = all_free_pages - kernel_free_pages;
    // 计算需要的位图占用多少字节，扔掉了满足不来了一个的字节bitmap存储的内存
    uint32_t kbm_length = kernel_free_pages / 8;
    uint32_t ubm_length = user_free_pages / 8;
    // 内核和用户内存池的起始物理地址
    // 现在的内存结构如下图
    /*
        |------------------------------------------------------------------------------------
        |   os_code_info[0x0-0x100000) | page_table[0x100000, 0x100000 + (256 * 4096))| free_mem ....
        |--------------------------------------------------------------------------------------
    */
    // 物理内存从0记，所以这里直接从used_mem开始
    uint32_t kp_start = used_mem;
    uint32_t up_start = kp_start + kernel_free_pages * PG_SIZE;
    // 内核内存池的起始位置(物理)，起始位置之前就是操作系统内核
    kernel_pool.phy_addr_start = kp_start;
    // 用户内存池的起始位置(物理)，越过内核内存池就是用户内存池

    // 现在的内存结构如下图
    /*
        |---------------------------------------------------------------------------------------------------------------|
        |   os_code_info[0x0-0x100000) | page_table[0x100000, 0x100000 + (256 * 4096))| kernel_mem_pool  | user_mem_pool|
        |---------------------------------------------------------------------------------------------------------------|
    */
    user_pool.phy_addr_start = up_start;
    kernel_pool.pool_size = kernel_free_pages * PG_SIZE;
    user_pool.pool_size = kernel_free_pages * PG_SIZE;
    // 内核内存池的bitmap的起始位置
    kernel_pool.pool_bitmap.bits = (void *)MEM_BITNAP_BASE;
    // 紧接着后面就是用户内存池的bitmap
    user_pool.pool_bitmap.bits = (void *)(MEM_BITNAP_BASE + kbm_length);
    kernel_pool.pool_bitmap.btmap_bytes_len = kbm_length;
    user_pool.pool_bitmap.btmap_bytes_len = ubm_length;
    print_str("\nkernel_pool_bitmap_start at : ");
    print_num((uint32_t)kernel_pool.pool_bitmap.bits);
    print_str("\nuser_pool bitmap start at : ");
    print_num((uint32_t)user_pool.pool_bitmap.bits);
    print_str("\nkernel phy addr is : ");
    print_num((uint32_t)kernel_pool.phy_addr_start);
    print_str("\nuser phy addr is : ");
    print_num((uint32_t)user_pool.phy_addr_start);
    // 位图初始化为0
    init_bitmap(&kernel_pool.pool_bitmap);
    init_bitmap(&user_pool.pool_bitmap);

    // 初始化内核虚拟地址的位图，根据实际物理内存大小生程数组
    kernel_vaddr.vaddr_bitmap.btmap_bytes_len = kbm_length;
    kernel_vaddr.vaddr_bitmap.bits = (void *)(MEM_BITNAP_BASE + kbm_length + ubm_length);
    kernel_vaddr.vaddr_start = K_HEAP_START;
    init_bitmap(&kernel_vaddr.vaddr_bitmap);
    print_str("\nmem_pool init done\n");
}
void init_memory()
{
    // 在汇编中bios中断获取到了全部内存空间
    uint32_t mem_byte_total = (*((uint32_t *)MAX_MEM_SIZE_PTR));
    print_str("all memory size is ");
    print_num(mem_byte_total);
    print_str("\n");
    init_memory_pool(mem_byte_total);
    print_str("mem init done\n");
}
/*
    获得pg_cnt个指定类型的虚拟页
*/
static void *vaddr_get(enum pool_flags pf, uint32_t pg_cnt)
{
    // 初始化两个变量
    int vaddr_start = 0, bit_idx_start = -1;
    uint32_t cnt = 0;
    if (pf == PF_KERNEL)
    {
        bit_idx_start = bitmap_scan(&kernel_vaddr.vaddr_bitmap, pg_cnt);
        if (bit_idx_start == -1)
        {
            return NULL;
        }
        else
        {
            while (cnt < pg_cnt)
            {
                // 把这些内存块的bit位全部设置为1
                bitmap_set(&kernel_vaddr.vaddr_bitmap, bit_idx_start + cnt++, 1);
            }
            vaddr_start = kernel_vaddr.vaddr_start + PG_SIZE * bit_idx_start;
        }
    }
    else
    {
        // 用户进程
        struct task_struct *cur = running_thread();
        // 在进程的虚拟地址空间获得虚拟地址位
        bit_idx_start = bitmap_scan(&cur->userprog_vaddr.vaddr_bitmap, pg_cnt);
        if (bit_idx_start == -1)
        {
            return 0;
        }
        while (cnt < pg_cnt)
        {
            bitmap_set(&cur->userprog_vaddr.vaddr_bitmap, bit_idx_start + cnt++, 1);
        }
        vaddr_start = cur->userprog_vaddr.vaddr_start + bit_idx_start * PG_SIZE;

        ASSERT((uint32_t)vaddr_start < (0xc0000000 - PG_SIZE));
    }
    return (void *)vaddr_start;
}
// 找到虚拟地址所在页表项的指针
uint32_t *pte_ptr(uint32_t vaddr)
{
    uint32_t *pte = (uint32_t *)(0xffc00000 +
                                 ((vaddr & 0xffc00000) >> 10) +
                                 PTE_IDX(vaddr) * PDE_PTE_SIZE);
    return pte;
}
// 找到虚拟地址所在页目录项的指针，可以通过这个指针拿到对应页目录项的地址，对其进行修改
uint32_t *pde_ptr(uint32_t vaddr)
{
    uint32_t *pde = (uint32_t *)((0xfffff000) + PDE_IDX(vaddr) * PDE_PTE_SIZE);
    return pde;
}
/*
在m_pool中申请一个物理页
*/
void *palloc(struct pool *m_pool)
{
    int bit_idx = bitmap_scan(&m_pool->pool_bitmap, 1);
    if (bit_idx == -1)
    {
        return NULL;
    }
    bitmap_set(&m_pool->pool_bitmap, bit_idx, 1);
    uint32_t page_phyaddr = ((bit_idx * PG_SIZE) + m_pool->phy_addr_start);
    return (void *)page_phyaddr;
}
/*
    添加页表项和物理内存的映射
*/
void page_table_add(void *_vaddr, void *_page_phyaddr)
{

    uint32_t vaddr = (uint32_t)_vaddr;
    uint32_t page_phyaddr = (uint32_t)_page_phyaddr;

    // 拿到这个虚拟地址的页目录项和页表项
    uint32_t *pde = pde_ptr(vaddr);
    uint32_t *pte = pte_ptr(vaddr);
    // 先判断这个页目录项存不存在
    if (*pde & 0x00000001)
    {
        // 页目录项存在了，那么判断页表项存不存在

        // 既然是分配，那么必须不存在
        ASSERT(!(*pte & 0x00000001));

        if (!(*pte & 0x1))
        {
            *pte = (page_phyaddr | PG_RW_W | PG_US_U | PG_P_1);
        }
        else
        {
            PANIC("pte repeat");
            *pte = (page_phyaddr | PG_RW_W | PG_US_U | PG_P_1);
        }
    }
    else
    {
        // 页目录项不存在
        // 需要分配一块内存存放页表，之前有规定，页表在内核，所以要在内核分配
        uint32_t pde_phyaddr /*页表地址*/ = (uint32_t)palloc(&kernel_pool);
        // 赋值给页目录项
        *pde = (page_phyaddr | PG_RW_W | PG_US_U | PG_P_1);
        // 清理页表
        memset((void *)((uint32_t)pte & 0xfffff000), 0, PG_SIZE);
        ASSERT(!(*pte & 0x00000001));
        *pte = (page_phyaddr | PG_RW_W | PG_US_U | PG_P_1);
    }
}
/*
分配pg_cnt个空间并返回起始虚拟地址
*/
void *malloc_page(enum pool_flags pf, uint32_t pg_cnt)
{
    ASSERT(pg_cnt > 0 && pg_cnt < 3840);
    // 先vaddr_get 在虚拟内存中拿到可以分配足够大小的内存地址
    // 再palloc获取能分配的真实的一个或多个物理块
    // 最后向页表添加虚拟地址和物理地址的映射
    void *vaddr_start = vaddr_get(pf, pg_cnt);
    if (vaddr_start == NULL)
    {
        return NULL;
    }
    // 注意这里的内存块是可以不是连续的
    uint32_t vaddr = (uint32_t)vaddr_start, cnt = pg_cnt;
    struct pool *mem_pool = (pf & PF_USER ? &user_pool : &kernel_pool);
    while (cnt-- > 0)
    {
        void *page_pythaddr = palloc(mem_pool);
        if (page_pythaddr == NULL)
        {
            // TODO 这里可能是没分配完全，后面要进行回滚回复页面
            return NULL;
        }
        page_table_add((void *)vaddr, page_pythaddr);
        // 继续分配页面，这里虚拟地址连续，但是物理页可以离散
        vaddr += PG_SIZE;
    }
    return vaddr_start;
}

// 分配随机内核内存页
void *get_kernel_pages(uint32_t pg_cnt)
{
    void *res = malloc_page(PF_KERNEL, pg_cnt);
    if (res != NULL)
    {
        memset(res, 0, PG_SIZE * pg_cnt);
    }
    return res;
}
void *get_user_pages(uint32_t pg_cnt)
{
    // 用户线程/进程有多个，核心线程/进程就一个，所以要互斥
    lock_aquire(&user_pool.lock);
    void *res = malloc_page(PF_USER, pg_cnt);
    memset(res, 1, pg_cnt * PG_SIZE);
    lock_release(&user_pool.lock);
    return res;
}
// 映射一页虚拟内存，根据PCB决定是在哪个特权级
void *get_a_page(enum pool_flags pf, uint32_t vaddr) {
    struct pool* mem_pool = pf & PF_KERNEL ? &kernel_pool : &user_pool;
    // 分配内存要锁住
    lock_aquire(&mem_pool->lock);
    struct task_struct* cur = running_thread();
    uint32_t bit_idx = -1;
    // 内核线程的pgdir是null，使用自己的内存页，所以pgdit != null 代表着是用户进程
    if(cur->pgdir != NULL && pf == PF_USER) {
        bit_idx = (vaddr - cur->userprog_vaddr.vaddr_start) / PG_SIZE;
        ASSERT((bit_idx > 0));
        bitmap_set(&cur->userprog_vaddr.vaddr_bitmap, bit_idx, 1);
    }
    // 内核线程只有一个，虚拟内存标记在内存中是kernel_vaddr
    else if (cur->pgdir == NULL && pf == PF_KERNEL)
    {   
        bit_idx = (vaddr - kernel_vaddr.vaddr_start) / PG_SIZE;
        ASSERT(bit_idx > 0);
        bitmap_set(&kernel_vaddr.vaddr_bitmap, bit_idx, 1);
    }
    else {
        PANIC("not allow page");
    }
    void* phy_addr = palloc(&user_pool);
    if(phy_addr == NULL) {
        return NULL;
    }
    page_table_add((void*) vaddr, phy_addr);
    lock_aquire(&mem_pool->lock);
    return (void*) vaddr;
}
// 拿到虚拟地址对应的物理地址
uint32_t add_v2p(uint32_t vaddr) {
    // 拿到页表位置
    uint32_t* pte = pte_ptr(vaddr);
    return ((*pte & 0xfffff000) + (vaddr & 0x00000fff));
}
#endif