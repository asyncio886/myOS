#include "console.h"
#ifdef __INCLUDE_CONSOLE
#include "sync.h"
#include "print.h"
static struct lock console_lock;
void console_init() {
    lock_init(&console_lock);
}
void console_aquire() {
    lock_aquire(&console_lock);
}
void console_release() {
    lock_release(&console_lock);
}
void console_log(char * str) {
    console_aquire();
    print_str(str);
    console_release();
}
void console_log_int(uint32_t num) {
    console_aquire();
    print_dec(num);
    console_release();    
}
#endif