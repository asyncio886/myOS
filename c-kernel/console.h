#ifndef __INCLUDE_CONSOLE
#define __INCLUDE_CONSOLE
#include "type.h"
void console_init();
void console_aquire();
void console_release();
void console_log(char * str);
void console_log_int(uint32_t num);
#endif