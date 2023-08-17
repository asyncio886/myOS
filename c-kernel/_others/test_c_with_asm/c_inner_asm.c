#include<stdio.h>
int value = 100;
// 演示内联汇编
int main(int argc, char const *argv[])
{
    // 内联汇编是AT&T语法
    // 内联汇编要有volatile修饰防止编译器重排序
    // 指令间用; 或者\n隔离
    int asm_res = 0;
    asm volatile("movl $1, %eax; \
                    movl $2, %ebx ");
    // 引用c程序的变量，这样可以直接引用全局变量
    asm volatile("movl value, %eax");
    // 更加灵活的替换
    int in_a = 1, in_b = 2;
    // asm("asm code":output:input)
    asm volatile("movb %b0, %b1\n ":: "b"(in_b),"a"(in_a) /* 使用寄存器a，b作为汇编参数，并把in_a,In_b传入寄存器，\
    并在汇编中使用这两个寄存器运算 */);
    // 拓展汇编中寄存器使用%%
    asm volatile("movb $10, %%al\n":"=a"(asm_res) /* 把寄存器a的值赋给asm_res */);
    printf("%d\n", asm_res);

    // 传入变量内存地址，这个数据会放在栈上
    int refrence_a = 10;
    asm volatile("movl $100, %0 "::"m"(refrence_a));
    printf("refrence_a = %d\n", refrence_a);
    // 调用函数
    char * str = "lalala\n";
    asm volatile("call printf"::"a"(str):"ax");
    return 0;
}
