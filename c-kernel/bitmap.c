#include "bitmap.h"
#include "type.h"
#include "global.h"
#define NDEBUG
#include "debug.h"
#include "string.h"
#define BIT_MASK 1
#ifdef __INCLUDE_BITMAP
void init_bitmap(struct bitmap* btmap) {
    ASSERT(btmap != NULL);
    // 全部置为0
    memset(btmap->bits, 0, btmap->btmap_bytes_len);
}
// 判断某一位是否为1
int bitmap_scan_test(struct bitmap* btmap, uint32_t bit_idx) {
    uint32_t bytes_idx = bit_idx / 8;
    uint32_t bit_offset = bit_idx % 8;
    return btmap->bits[bytes_idx] & (BIT_MASK << bit_offset);
}
// 在位图中连续申请cnt个位，返回成功的第一个bit的位置，不成功返回-1
int bitmap_scan(struct bitmap* btmap, uint32_t cnt) {
    // 跳过全为1的字节    
    uint32_t idx_byte = 0;
    while ((0xff == btmap->bits[idx_byte]) && (idx_byte < btmap->btmap_bytes_len))
    {
        idx_byte++;
    }
    ASSERT(idx_byte < btmap->btmap_bytes_len);
    // 全满了，失败
    if(idx_byte == btmap->btmap_bytes_len) {
        return -1;
    }
    // 一个一个位找到空的位
    int idx_bit = 0;
    while ((uint8_t)(BIT_MASK << idx_bit) & btmap->bits[idx_byte])
    {
        idx_bit++;
    }
    int bit_idx_start = idx_byte * 8 + idx_bit;
    if(cnt == 1) {
        return bit_idx_start;
    }
    // 还可以用来搜索位的空间
    uint32_t bit_left = (btmap->btmap_bytes_len * 8 - bit_idx_start);
    uint32_t next_bit = bit_idx_start + 1;
    uint32_t count = 1; // 找到空闲位的个数
    bit_idx_start = -1; 
    while (bit_left-- > 0)
    {
        if(!bitmap_scan_test(btmap, next_bit)) {
            count++;
        }
        else {
            count = 0;
        }
        if(count == cnt) {
            bit_idx_start = next_bit - cnt + 1;
            break;
        }
        next_bit++;
    }
    return bit_idx_start;
}
void bitmap_set(struct bitmap* btmap, uint32_t bit_idx, uint8_t value) {
    ASSERT((value == 0) || (value == 1) && btmap != NULL);
    uint32_t byte_idx = bit_idx / 8;
    uint32_t _bit_idx = bit_idx % 8;
    if(value) {
        btmap->bits[byte_idx] |= (BIT_MASK << _bit_idx);
    }
    else {
        btmap->bits[byte_idx] &= ~(BIT_MASK << _bit_idx);
    }
}
#endif