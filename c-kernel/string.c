#define NDEBUG
#include "debug.h"
#include "string.h"
#include "global.h"
#ifdef __INCLUDE_STRING

void memset(void *dst, uint8_t value, uint32_t size)
{
    ASSERT(dst != NULL);
    int i;
    uint8_t *_dst = (uint8_t *)dst;
    for (i = 0; i < size; i++)
    {
        _dst[i] = value;
    }
}
void memcpy(void *dst, const void *src, uint32_t size)
{
    ASSERT(dst != NULL);
    ASSERT(src != NULL);
    uint8_t *_dst = (uint8_t *)dst;
    uint8_t *_src = (uint8_t *)src;
    int i;
    for (i = 0; i < size; i++)
    {
        _dst[i] = _src[i];
    }
}
// 比较一段内存是否相等
int memcmp(const void *a_, const void *b_, uint32_t size)
{
    ASSERT(a_ != NULL);
    ASSERT(b_ != NULL);
    uint8_t *a = (uint8_t *)a_;
    uint8_t *b = (uint8_t *)b_;
    int i;
    for (i = 0; i < size; i++)
    {
        if (a[i] > b[i])
        {
            return 1;
        }
        else if (a[i] < b[i])
        {
            return -1;
        }
    }
    return 0;
}
char *strcpy(char *dst, char *src)
{
    ASSERT(dst != NULL && src != NULL);
    char *res = dst;
    while ((*dst++ = *src++));
    return res;
}
uint32_t strlen(char *str)
{
    ASSERT(str != NULL);
    char *start = str;
    while (*str++)
        ;
    return (str - start - 1);
}
uint8_t strcmp(char *a, char *b)
{
    ASSERT(a != NULL && b != NULL);
    while (*a != '\0' && *a == *b)
    {
        a++;
        b++;
    }
    return *a < *b ? -1 : *b > *b;
}
// indexOf不过返回的是地址
char *strchr(char *str, uint8_t ch)
{
    ASSERT(str != NULL);
    while (*str != '\0')
    {
        if (*str == ch)
        {
            return str;
        }
    }
    return NULL;
}
char *strrchr(char *str, uint8_t ch)
{
    ASSERT(str != NULL);
    char *last_pos = NULL;
    while (*str != '\0')
    {
        if (*str == ch)
        {
            last_pos = str;
        }
    }
    return last_pos;
}
char *strcat(char *dst, char *src)
{
    ASSERT(dst != NULL && src != NULL);
    char *_dst = dst;
    while (dst++)
        ;
    --dst;
    while ((*dst++ != *src++))
        ;
    return dst;
}
// 查找字符出现的次数
uint32_t strchrs(char *str, uint8_t ch)
{
    ASSERT(str != NULL);
    int sum = 0;
    while (*str != '\0')
    {
        if (*str == ch)
        {
            sum++;
        }
        str++;
    }
    return sum;
}
#endif
