#include "type.h"
#ifndef __INCLUDE_IO
#define __INCLUDE_IO
// 处理端口写入读取


// 向端口输出一个字节数据
inline void outb(uint16_t port, uint8_t data) {
    asm volatile("outb %b0, %w1": :"a"(data), "Nd"(port));
}
// 向端口写入word_cnt个字节
inline void outsw(uint16_t port, const void* addr, uint32_t word_cnt) {
    asm volatile("cld; rep outsw":"+S"(addr), "+c"(word_cnt):"d"(port));
}
// 读入一个字节数据
inline uint8_t inb(uint16_t port) {
    uint8_t res = 0;
    asm volatile("inb %w1, %b0":"=a"(res):"Nd"(port));
    return res;
}
// 从端口读入word_cnt个字节到数组
inline void insw(uint16_t port, const void* addr, uint32_t word_cnt) {
    asm volatile("cld; rep insw":"+D"(addr), "+c"(word_cnt):"d"(port):"memory");
}
#endif