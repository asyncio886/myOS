#ifndef __INCLUDE_BITMAP
#define __INCLUDE_BITMAP
#include "type.h"
struct bitmap {
    // 位图长度(单位是字节)
    uint32_t btmap_bytes_len;
    // 位图在什么地址
    uint8_t* bits;
};
void init_bitmap(struct bitmap* btmap);
int bitmap_scan_test(struct bitmap* btmap, uint32_t bit_idx);
int bitmap_scan(struct bitmap* btmap, uint32_t cnt);
void bitmap_set(struct bitmap* btmap, uint32_t bit_idx, uint8_t value);
#endif