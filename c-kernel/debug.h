#ifndef __INCLUDE_DEBUG
#define __INCLUDE_DEBUG
void panic_spin(char* filename, int line, const char * func, char* condition);
// 定义宏命令调用函数
#define PANIC(...) panic_spin(__FILE__, __LINE__, __func__, __VA_ARGS__);
#ifndef NDEBUG
    #define ASSERT(CONDITION) ((void)0)
#else
#define ASSERT(CONDITION) \
    if(CONDITION) {}else { \
        PANIC(#CONDITION); \
    }
#endif
#endif