
# 下面代表make debug命令
# make不指定命令，默认执行第一个
demo : # 自定义命令
	@echo demo
debug : # 必须tab开头，@代表隐藏命令本身输出
	echo "hello make"
	@echo "hidden command" 
# 不能和文件名重名，如果本目录存在一个文件叫clean，这个命令就不会执行
# 需要让make认为这是一个命令而不是本目录的文件，需要加如下内容
.PHONY : clean
clean : 
	rm -rf ./objs
	rm -rf ./main.o
# makefile定义变量
main := main.c
debug_main : 
	gcc -c $(main)
# 指定命令依赖的文件
need := main.o
need1 := test.o
compile : $(need) $(need1)
	@echo "依赖存在"



# 引用赋值，可以根锁变量就行修改
TAG = test
tag = $(TAG)
TAG = ddd
test_tag :
	@echo $(tag)

# 连接字符串
str1 := gcc
str2 := -c
str3 := main.c
str1 += $(str2)
str1 += $(str3)
str1 := $(str1) $(str1) $(str3) # 空格不会被省去
test_concat : 
	@echo $(str1)

# makefile 调用bash并返回结果
shell_res := $(shell find ./ -name *.c)
test_shell : 
	@echo $(shell_res)



demo1:
	@echo demo1
demo2:
	@echo demo2
demo3:
	@echo demo3
# 执行多个命令，写在一行
all: demo1 demo2 demo3

# for_each的使用
