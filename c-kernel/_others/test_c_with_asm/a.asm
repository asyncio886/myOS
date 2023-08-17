
a.out:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64 
  401004:	48 83 ec 08          	sub    $0x8,%rsp
  401008:	48 8b 05 e9 2f 00 00 	mov    0x2fe9(%rip),%rax        # 403ff8 <__gmon_start__>
  40100f:	48 85 c0             	test   %rax,%rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	callq  *%rax
  401016:	e8 e5 00 00 00       	callq  401100 <frame_dummy>
  40101b:	e8 10 02 00 00       	callq  401230 <__do_global_ctors_aux>
  401020:	48 83 c4 08          	add    $0x8,%rsp
  401024:	c3                   	retq   

Disassembly of section .plt:

0000000000401030 <.plt>:
  401030:	ff 35 d2 2f 00 00    	pushq  0x2fd2(%rip)        # 404008 <_GLOBAL_OFFSET_TABLE_+0x8>
  401036:	ff 25 d4 2f 00 00    	jmpq   *0x2fd4(%rip)        # 404010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40103c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401040 <printf@plt>:
  401040:	ff 25 d2 2f 00 00    	jmpq   *0x2fd2(%rip)        # 404018 <printf@GLIBC_2.2.5>
  401046:	68 00 00 00 00       	pushq  $0x0
  40104b:	e9 e0 ff ff ff       	jmpq   401030 <.plt>

Disassembly of section .text:

0000000000401050 <_start>:
  401050:	f3 0f 1e fa          	endbr64 
  401054:	31 ed                	xor    %ebp,%ebp
  401056:	49 89 d1             	mov    %rdx,%r9
  401059:	5e                   	pop    %rsi
  40105a:	48 89 e2             	mov    %rsp,%rdx
  40105d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401061:	50                   	push   %rax
  401062:	54                   	push   %rsp
  401063:	49 c7 c0 20 12 40 00 	mov    $0x401220,%r8
  40106a:	48 c7 c1 b0 11 40 00 	mov    $0x4011b0,%rcx
  401071:	48 c7 c7 22 11 40 00 	mov    $0x401122,%rdi
  401078:	ff 15 72 2f 00 00    	callq  *0x2f72(%rip)        # 403ff0 <__libc_start_main@GLIBC_2.2.5>
  40107e:	f4                   	hlt    
  40107f:	90                   	nop

0000000000401080 <_dl_relocate_static_pie>:
  401080:	f3 0f 1e fa          	endbr64 
  401084:	c3                   	retq   
  401085:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40108c:	00 00 00 
  40108f:	90                   	nop

0000000000401090 <__do_global_dtors_aux>:
  401090:	55                   	push   %rbp
  401091:	48 89 e5             	mov    %rsp,%rbp
  401094:	53                   	push   %rbx
  401095:	48 83 ec 08          	sub    $0x8,%rsp
  401099:	80 3d 98 2f 00 00 00 	cmpb   $0x0,0x2f98(%rip)        # 404038 <completed.7508>
  4010a0:	75 4b                	jne    4010ed <__do_global_dtors_aux+0x5d>
  4010a2:	bb 50 3e 40 00       	mov    $0x403e50,%ebx
  4010a7:	48 8b 05 92 2f 00 00 	mov    0x2f92(%rip),%rax        # 404040 <dtor_idx.7510>
  4010ae:	48 81 eb 48 3e 40 00 	sub    $0x403e48,%rbx
  4010b5:	48 c1 fb 03          	sar    $0x3,%rbx
  4010b9:	48 83 eb 01          	sub    $0x1,%rbx
  4010bd:	48 39 d8             	cmp    %rbx,%rax
  4010c0:	73 24                	jae    4010e6 <__do_global_dtors_aux+0x56>
  4010c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4010c8:	48 83 c0 01          	add    $0x1,%rax
  4010cc:	48 89 05 6d 2f 00 00 	mov    %rax,0x2f6d(%rip)        # 404040 <dtor_idx.7510>
  4010d3:	ff 14 c5 48 3e 40 00 	callq  *0x403e48(,%rax,8)
  4010da:	48 8b 05 5f 2f 00 00 	mov    0x2f5f(%rip),%rax        # 404040 <dtor_idx.7510>
  4010e1:	48 39 d8             	cmp    %rbx,%rax
  4010e4:	72 e2                	jb     4010c8 <__do_global_dtors_aux+0x38>
  4010e6:	c6 05 4b 2f 00 00 01 	movb   $0x1,0x2f4b(%rip)        # 404038 <completed.7508>
  4010ed:	48 83 c4 08          	add    $0x8,%rsp
  4010f1:	5b                   	pop    %rbx
  4010f2:	c9                   	leaveq 
  4010f3:	c3                   	retq   
  4010f4:	66 66 66 2e 0f 1f 84 	data16 data16 nopw %cs:0x0(%rax,%rax,1)
  4010fb:	00 00 00 00 00 

0000000000401100 <frame_dummy>:
  401100:	55                   	push   %rbp
  401101:	48 83 3d 4f 2d 00 00 	cmpq   $0x0,0x2d4f(%rip)        # 403e58 <__JCR_END__>
  401108:	00 
  401109:	48 89 e5             	mov    %rsp,%rbp
  40110c:	74 12                	je     401120 <frame_dummy+0x20>
  40110e:	b8 00 00 00 00       	mov    $0x0,%eax
  401113:	48 85 c0             	test   %rax,%rax
  401116:	74 08                	je     401120 <frame_dummy+0x20>
  401118:	bf 58 3e 40 00       	mov    $0x403e58,%edi
  40111d:	c9                   	leaveq 
  40111e:	ff e0                	jmpq   *%rax
  401120:	c9                   	leaveq 
  401121:	c3                   	retq   

0000000000401122 <main>:
  401122:	55                   	push   %rbp
  401123:	48 89 e5             	mov    %rsp,%rbp
  401126:	53                   	push   %rbx
  401127:	48 83 ec 28          	sub    $0x28,%rsp
  40112b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  40112e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  401132:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  401139:	b8 01 00 00 00       	mov    $0x1,%eax
  40113e:	bb 02 00 00 00       	mov    $0x2,%ebx
  401143:	8b 04 25 30 40 40 00 	mov    0x404030,%eax
  40114a:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%rbp)
  401151:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%rbp)
  401158:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  40115b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  40115e:	89 d3                	mov    %edx,%ebx
  401160:	88 d8                	mov    %bl,%al
  401162:	b0 0a                	mov    $0xa,%al
  401164:	89 45 ec             	mov    %eax,-0x14(%rbp)
  401167:	b8 04 20 40 00       	mov    $0x402004,%eax
  40116c:	8b 55 ec             	mov    -0x14(%rbp),%edx
  40116f:	89 d6                	mov    %edx,%esi
  401171:	48 89 c7             	mov    %rax,%rdi
  401174:	b8 00 00 00 00       	mov    $0x0,%eax
  401179:	e8 c2 fe ff ff       	callq  401040 <printf@plt>
  40117e:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
  401185:	c7 45 e0 64 00 00 00 	movl   $0x64,-0x20(%rbp)
  40118c:	8b 55 e0             	mov    -0x20(%rbp),%edx
  40118f:	b8 07 20 40 00       	mov    $0x402007,%eax
  401194:	89 d6                	mov    %edx,%esi
  401196:	48 89 c7             	mov    %rax,%rdi
  401199:	b8 00 00 00 00       	mov    $0x0,%eax
  40119e:	e8 9d fe ff ff       	callq  401040 <printf@plt>
  4011a3:	b8 00 00 00 00       	mov    $0x0,%eax
  4011a8:	48 83 c4 28          	add    $0x28,%rsp
  4011ac:	5b                   	pop    %rbx
  4011ad:	c9                   	leaveq 
  4011ae:	c3                   	retq   
  4011af:	90                   	nop

00000000004011b0 <__libc_csu_init>:
  4011b0:	f3 0f 1e fa          	endbr64 
  4011b4:	41 57                	push   %r15
  4011b6:	4c 8d 3d 7b 2c 00 00 	lea    0x2c7b(%rip),%r15        # 403e38 <__CTOR_LIST__>
  4011bd:	41 56                	push   %r14
  4011bf:	49 89 d6             	mov    %rdx,%r14
  4011c2:	41 55                	push   %r13
  4011c4:	49 89 f5             	mov    %rsi,%r13
  4011c7:	41 54                	push   %r12
  4011c9:	41 89 fc             	mov    %edi,%r12d
  4011cc:	55                   	push   %rbp
  4011cd:	48 8d 2d 64 2c 00 00 	lea    0x2c64(%rip),%rbp        # 403e38 <__CTOR_LIST__>
  4011d4:	53                   	push   %rbx
  4011d5:	4c 29 fd             	sub    %r15,%rbp
  4011d8:	48 83 ec 08          	sub    $0x8,%rsp
  4011dc:	e8 1f fe ff ff       	callq  401000 <_init>
  4011e1:	48 c1 fd 03          	sar    $0x3,%rbp
  4011e5:	74 1f                	je     401206 <__libc_csu_init+0x56>
  4011e7:	31 db                	xor    %ebx,%ebx
  4011e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4011f0:	4c 89 f2             	mov    %r14,%rdx
  4011f3:	4c 89 ee             	mov    %r13,%rsi
  4011f6:	44 89 e7             	mov    %r12d,%edi
  4011f9:	41 ff 14 df          	callq  *(%r15,%rbx,8)
  4011fd:	48 83 c3 01          	add    $0x1,%rbx
  401201:	48 39 dd             	cmp    %rbx,%rbp
  401204:	75 ea                	jne    4011f0 <__libc_csu_init+0x40>
  401206:	48 83 c4 08          	add    $0x8,%rsp
  40120a:	5b                   	pop    %rbx
  40120b:	5d                   	pop    %rbp
  40120c:	41 5c                	pop    %r12
  40120e:	41 5d                	pop    %r13
  401210:	41 5e                	pop    %r14
  401212:	41 5f                	pop    %r15
  401214:	c3                   	retq   
  401215:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  40121c:	00 00 00 00 

0000000000401220 <__libc_csu_fini>:
  401220:	f3 0f 1e fa          	endbr64 
  401224:	c3                   	retq   
  401225:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40122c:	00 00 00 
  40122f:	90                   	nop

0000000000401230 <__do_global_ctors_aux>:
  401230:	55                   	push   %rbp
  401231:	48 89 e5             	mov    %rsp,%rbp
  401234:	53                   	push   %rbx
  401235:	48 83 ec 08          	sub    $0x8,%rsp
  401239:	48 8b 05 f8 2b 00 00 	mov    0x2bf8(%rip),%rax        # 403e38 <__CTOR_LIST__>
  401240:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  401244:	74 19                	je     40125f <__do_global_ctors_aux+0x2f>
  401246:	bb 38 3e 40 00       	mov    $0x403e38,%ebx
  40124b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401250:	48 83 eb 08          	sub    $0x8,%rbx
  401254:	ff d0                	callq  *%rax
  401256:	48 8b 03             	mov    (%rbx),%rax
  401259:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  40125d:	75 f1                	jne    401250 <__do_global_ctors_aux+0x20>
  40125f:	48 83 c4 08          	add    $0x8,%rsp
  401263:	5b                   	pop    %rbx
  401264:	c9                   	leaveq 
  401265:	c3                   	retq   

Disassembly of section .fini:

0000000000401268 <_fini>:
  401268:	f3 0f 1e fa          	endbr64 
  40126c:	48 83 ec 08          	sub    $0x8,%rsp
  401270:	e8 1b fe ff ff       	callq  401090 <__do_global_dtors_aux>
  401275:	48 83 c4 08          	add    $0x8,%rsp
  401279:	c3                   	retq   
