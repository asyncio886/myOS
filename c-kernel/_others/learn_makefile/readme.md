## 编译过程
预处理(生成.i的全文本文件) -> 编译生成汇编文件 -> 汇编汇编转为可执行指令 -> 链接(重点)
### 链接做了什么？
把多个文件都链接成一个文件，比如在main.c中声明了add函数,sub函数，但是并没有实现，具体实现在add.h函数里面，使用`gcc -c` 编译sub.c和add.c之后得到sub.o和add.o文件，再将这两个文件`ar -r libop.a sub.o add.o`编译为静态库libop.a，然后使用`gcc main.c libop.a`链接为一个可执行文件
### 静态库动态库区别
静态库：在**编译阶段**就被编译进了可执行文件
动态库：一般由so结尾，程度在**运行时**会把动态库链接执行
**静态动态库都需要gcc -c编译成可重定向文件(.o文件)再链接**
### 静态与动态链接的区别
动态链接出现的原因就是为了解决静态链接中提到的两个问题，一方面是空间浪费，全部内容都被编译到了一个可执行文件，另外一方面是更新困难。
静态库适合写死了不允许更改的部分，动态库可以在需要的时候修改实现再让程序在运行时进行链接
动态链接可以节省内存空间，原本一个进程一段代码，100个进程就要有100个代码段，用动态链接只会有一个
### include和汇编的关系？
include做的事情在生成.i文件那一步，静态链接发生在链接的部分，两者类似的功能但是时间不同
### 编译静态库
```shell
gcc -c add.c -o ./out/add.o
gcc -c sub.c -o ./out/sub.o
ar -r ./lib/libop.a ./out/add.o ./out/sub.o
gcc main.c ./lib/libop.a -o exec
```
### 编译动态库
```shell
gcc -fPIC -shared add.c sub.c -o ./out/libsharedop.so
gcc main.c ./out/libsharedop.so -o exec
```
也可以先编译为.o文件，然后使用.o文件进行动态链接
```shell
gcc -c add.c -o add.o
gcc -c sub.c -o sub.o
gcc -shared -fpic add.o sub.o ./out/libsharedop.so
gcc main.c ./out/libsharedop.so -o exec
```