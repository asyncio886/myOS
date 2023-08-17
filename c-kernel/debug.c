#include "debug.h"
#include "interrupt.h"
#include "print.h"
#ifdef __INCLUDE_DEBUG
void panic_spin(char* filename, int line, const char * func, char* condition) {
    intr_disable();
    print_str("ERROR : ");
    print_str("filename : ");print_str(filename);print_str("\n");
    print_str("line : ");print_dec((uint32_t) line);print_str("\n");
    print_str("function : ");print_str((char*) func);print_str("\n");
    print_str("condition: ");print_str((char*) condition);print_str("\n");
}
#endif