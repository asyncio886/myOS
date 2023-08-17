#ifndef __INCLUDE_STRING
#define __INCLUDE_STRING
#include "type.h"
void memset(void *dst, uint8_t value, uint32_t size);
void memcpy(void *dst, const void *src_, uint32_t size);
int memcmp(const void *a_, const void *b_, uint32_t size);
char *strcpy(char *dst, char *src);
uint32_t strlen(char *str);
uint8_t strcmp(char *a, char *b);
char *strchr(char *str, uint8_t ch);
char *strrchr(char *str, uint8_t ch);
char *strcat(char *dst, char *src);
uint32_t strchrs(char * str, uint8_t ch);
#endif