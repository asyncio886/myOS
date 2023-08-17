	.file	"c_inner_asm.c"
.globl value
	.data
	.align 4
	.type	value, @object
	.size	value, 4
value:
	.long	100
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"refrence_a = %d\n"
.LC2:
	.string	"lalala\n"
	.text
.globl main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movl	$0, -20(%rbp)
#APP
# 10 "c_inner_asm.c" 1
	movl $1, %eax;                     movl $2, %ebx 
# 0 "" 2
# 13 "c_inner_asm.c" 1
	movl value, %eax
# 0 "" 2
#NO_APP
	movl	$1, -24(%rbp)
	movl	$2, -28(%rbp)
	movl	-28(%rbp), %edx
	movl	-24(%rbp), %eax
	movl	%edx, %ebx
	.cfi_offset 3, -24
#APP
# 17 "c_inner_asm.c" 1
	movb %bl, %al
 
# 0 "" 2
# 20 "c_inner_asm.c" 1
	movb $10, %al

# 0 "" 2
#NO_APP
	movl	%eax, -20(%rbp)
	movl	$.LC0, %eax
	movl	-20(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movl	$10, -32(%rbp)
#APP
# 25 "c_inner_asm.c" 1
	movl $100, -32(%rbp) 
# 0 "" 2
#NO_APP
	movl	-32(%rbp), %edx
	movl	$.LC1, %eax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movq	$.LC2, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rbx
#APP
# 29 "c_inner_asm.c" 1
	pushq %rbx;                   call printf
# 0 "" 2
#NO_APP
	movl	$0, %eax
	addq	$56, %rsp
	popq	%rbx
	leave
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.4.7-8ubuntu1) 4.4.7"
	.section	.note.GNU-stack,"",@progbits
