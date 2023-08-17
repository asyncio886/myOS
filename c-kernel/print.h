#ifndef __INCLUDE_PRINT
#define __INCLUDE_PRINT
#include "type.h"
void put_char(uint8_t char_asci);
void to_top_left();
void put_str(char * str);
void print_str(char *str);
void put_int(int i);
void clear_screen();
void print_num(uint32_t num);
void print_format(char * str, uint32_t num);
void print_dec(uint32_t num);
void println(char* str);
#endif