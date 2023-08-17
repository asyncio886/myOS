
kernel.bin:     file format elf32-i386


Disassembly of section .text:

c0001500 <main>:
c0001500:	55                   	push   %ebp
c0001501:	89 e5                	mov    %esp,%ebp
c0001503:	83 e4 f0             	and    $0xfffffff0,%esp
c0001506:	83 ec 10             	sub    $0x10,%esp
c0001509:	e8 e8 00 00 00       	call   c00015f6 <clear_screen>
c000150e:	c7 04 24 00 40 00 c0 	movl   $0xc0004000,(%esp)
c0001515:	e8 a6 00 00 00       	call   c00015c0 <print_str>
c000151a:	c7 04 24 14 40 00 c0 	movl   $0xc0004014,(%esp)
c0001521:	e8 9a 00 00 00       	call   c00015c0 <print_str>
c0001526:	c7 04 24 28 40 00 c0 	movl   $0xc0004028,(%esp)
c000152d:	e8 8e 00 00 00       	call   c00015c0 <print_str>
c0001532:	e8 4a 00 00 00       	call   c0001581 <init_all>
c0001537:	c7 44 24 0c 2d 40 00 	movl   $0xc000402d,0xc(%esp)
c000153e:	c0 
c000153f:	c7 44 24 08 a7 15 00 	movl   $0xc00015a7,0x8(%esp)
c0001546:	c0 
c0001547:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
c000154e:	00 
c000154f:	c7 04 24 37 40 00 c0 	movl   $0xc0004037,(%esp)
c0001556:	e8 a5 17 00 00       	call   c0002d00 <thread_start>
c000155b:	c7 44 24 0c 3e 40 00 	movl   $0xc000403e,0xc(%esp)
c0001562:	c0 
c0001563:	c7 44 24 08 a7 15 00 	movl   $0xc00015a7,0x8(%esp)
c000156a:	c0 
c000156b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0001572:	00 
c0001573:	c7 04 24 50 40 00 c0 	movl   $0xc0004050,(%esp)
c000157a:	e8 81 17 00 00       	call   c0002d00 <thread_start>
c000157f:	eb fe                	jmp    c000157f <main+0x7f>

c0001581 <init_all>:
c0001581:	55                   	push   %ebp
c0001582:	89 e5                	mov    %esp,%ebp
c0001584:	83 ec 08             	sub    $0x8,%esp
c0001587:	e8 af 04 00 00       	call   c0001a3b <idt_init>
c000158c:	e8 1e 05 00 00       	call   c0001aaf <exception_init>
c0001591:	e8 93 12 00 00       	call   c0002829 <init_memory>
c0001596:	e8 f9 18 00 00       	call   c0002e94 <thread_init>
c000159b:	e8 45 08 00 00       	call   c0001de5 <timer_init>
c00015a0:	e8 a0 08 00 00       	call   c0001e45 <intr_enable>
c00015a5:	c9                   	leave  
c00015a6:	c3                   	ret    

c00015a7 <k_thread_a>:
c00015a7:	55                   	push   %ebp
c00015a8:	89 e5                	mov    %esp,%ebp
c00015aa:	83 ec 28             	sub    $0x28,%esp
c00015ad:	8b 45 08             	mov    0x8(%ebp),%eax
c00015b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00015b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00015b6:	89 04 24             	mov    %eax,(%esp)
c00015b9:	e8 02 00 00 00       	call   c00015c0 <print_str>
c00015be:	eb f3                	jmp    c00015b3 <k_thread_a+0xc>

c00015c0 <print_str>:
c00015c0:	55                   	push   %ebp
c00015c1:	89 e5                	mov    %esp,%ebp
c00015c3:	83 ec 28             	sub    $0x28,%esp
c00015c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c00015cd:	eb 18                	jmp    c00015e7 <print_str+0x27>
c00015cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00015d2:	03 45 08             	add    0x8(%ebp),%eax
c00015d5:	0f b6 00             	movzbl (%eax),%eax
c00015d8:	0f b6 c0             	movzbl %al,%eax
c00015db:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c00015df:	89 04 24             	mov    %eax,(%esp)
c00015e2:	e8 49 1b 00 00       	call   c0003130 <put_char>
c00015e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00015ea:	03 45 08             	add    0x8(%ebp),%eax
c00015ed:	0f b6 00             	movzbl (%eax),%eax
c00015f0:	84 c0                	test   %al,%al
c00015f2:	75 db                	jne    c00015cf <print_str+0xf>
c00015f4:	c9                   	leave  
c00015f5:	c3                   	ret    

c00015f6 <clear_screen>:
c00015f6:	55                   	push   %ebp
c00015f7:	89 e5                	mov    %esp,%ebp
c00015f9:	83 ec 28             	sub    $0x28,%esp
c00015fc:	e8 fc 1b 00 00       	call   c00031fd <to_top_left>
c0001601:	c7 45 f4 d0 07 00 00 	movl   $0x7d0,-0xc(%ebp)
c0001608:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c000160f:	eb 10                	jmp    c0001621 <clear_screen+0x2b>
c0001611:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0001618:	e8 13 1b 00 00       	call   c0003130 <put_char>
c000161d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
c0001621:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0001624:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0001627:	7c e8                	jl     c0001611 <clear_screen+0x1b>
c0001629:	e8 cf 1b 00 00       	call   c00031fd <to_top_left>
c000162e:	c9                   	leave  
c000162f:	c3                   	ret    

c0001630 <print_num>:
c0001630:	55                   	push   %ebp
c0001631:	89 e5                	mov    %esp,%ebp
c0001633:	83 ec 28             	sub    $0x28,%esp
c0001636:	c7 45 f0 00 00 00 f0 	movl   $0xf0000000,-0x10(%ebp)
c000163d:	c7 04 24 57 40 00 c0 	movl   $0xc0004057,(%esp)
c0001644:	e8 77 ff ff ff       	call   c00015c0 <print_str>
c0001649:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0001650:	eb 61                	jmp    c00016b3 <print_num+0x83>
c0001652:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0001655:	8b 55 08             	mov    0x8(%ebp),%edx
c0001658:	21 d0                	and    %edx,%eax
c000165a:	c1 e8 1c             	shr    $0x1c,%eax
c000165d:	88 45 f7             	mov    %al,-0x9(%ebp)
c0001660:	80 7d f7 09          	cmpb   $0x9,-0x9(%ebp)
c0001664:	77 14                	ja     c000167a <print_num+0x4a>
c0001666:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
c000166a:	83 c0 30             	add    $0x30,%eax
c000166d:	0f b6 c0             	movzbl %al,%eax
c0001670:	89 04 24             	mov    %eax,(%esp)
c0001673:	e8 b8 1a 00 00       	call   c0003130 <put_char>
c0001678:	eb 31                	jmp    c00016ab <print_num+0x7b>
c000167a:	0f b6 4d f7          	movzbl -0x9(%ebp),%ecx
c000167e:	ba cd ff ff ff       	mov    $0xffffffcd,%edx
c0001683:	89 c8                	mov    %ecx,%eax
c0001685:	f6 e2                	mul    %dl
c0001687:	66 c1 e8 08          	shr    $0x8,%ax
c000168b:	89 c2                	mov    %eax,%edx
c000168d:	c0 ea 03             	shr    $0x3,%dl
c0001690:	89 d0                	mov    %edx,%eax
c0001692:	c1 e0 02             	shl    $0x2,%eax
c0001695:	01 d0                	add    %edx,%eax
c0001697:	01 c0                	add    %eax,%eax
c0001699:	89 ca                	mov    %ecx,%edx
c000169b:	28 c2                	sub    %al,%dl
c000169d:	8d 42 61             	lea    0x61(%edx),%eax
c00016a0:	0f b6 c0             	movzbl %al,%eax
c00016a3:	89 04 24             	mov    %eax,(%esp)
c00016a6:	e8 85 1a 00 00       	call   c0003130 <put_char>
c00016ab:	c1 65 08 04          	shll   $0x4,0x8(%ebp)
c00016af:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c00016b3:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
c00016b7:	7e 99                	jle    c0001652 <print_num+0x22>
c00016b9:	c9                   	leave  
c00016ba:	c3                   	ret    

c00016bb <print_dec>:
c00016bb:	55                   	push   %ebp
c00016bc:	89 e5                	mov    %esp,%ebp
c00016be:	83 ec 38             	sub    $0x38,%esp
c00016c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c00016c5:	75 0c                	jne    c00016d3 <print_dec+0x18>
c00016c7:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
c00016ce:	e8 5d 1a 00 00       	call   c0003130 <put_char>
c00016d3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
c00016da:	81 7d 08 ff 93 35 77 	cmpl   $0x773593ff,0x8(%ebp)
c00016e1:	76 18                	jbe    c00016fb <print_dec+0x40>
c00016e3:	c7 45 f4 00 ca 9a 3b 	movl   $0x3b9aca00,-0xc(%ebp)
c00016ea:	eb 78                	jmp    c0001764 <print_dec+0xa9>
c00016ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
c00016ef:	89 d0                	mov    %edx,%eax
c00016f1:	c1 e0 02             	shl    $0x2,%eax
c00016f4:	01 d0                	add    %edx,%eax
c00016f6:	01 c0                	add    %eax,%eax
c00016f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00016fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00016fe:	3b 45 08             	cmp    0x8(%ebp),%eax
c0001701:	72 e9                	jb     c00016ec <print_dec+0x31>
c0001703:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001706:	3b 45 08             	cmp    0x8(%ebp),%eax
c0001709:	76 59                	jbe    c0001764 <print_dec+0xa9>
c000170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000170e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0001711:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
c0001716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0001719:	f7 e2                	mul    %edx
c000171b:	89 d0                	mov    %edx,%eax
c000171d:	c1 e8 03             	shr    $0x3,%eax
c0001720:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0001723:	eb 3f                	jmp    c0001764 <print_dec+0xa9>
c0001725:	8b 45 08             	mov    0x8(%ebp),%eax
c0001728:	ba 00 00 00 00       	mov    $0x0,%edx
c000172d:	f7 75 f4             	divl   -0xc(%ebp)
c0001730:	83 c0 30             	add    $0x30,%eax
c0001733:	0f b6 c0             	movzbl %al,%eax
c0001736:	89 04 24             	mov    %eax,(%esp)
c0001739:	e8 f2 19 00 00       	call   c0003130 <put_char>
c000173e:	8b 45 08             	mov    0x8(%ebp),%eax
c0001741:	ba 00 00 00 00       	mov    $0x0,%edx
c0001746:	f7 75 f4             	divl   -0xc(%ebp)
c0001749:	89 55 08             	mov    %edx,0x8(%ebp)
c000174c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000174f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0001752:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
c0001757:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c000175a:	f7 e2                	mul    %edx
c000175c:	89 d0                	mov    %edx,%eax
c000175e:	c1 e8 03             	shr    $0x3,%eax
c0001761:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0001764:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0001768:	75 bb                	jne    c0001725 <print_dec+0x6a>
c000176a:	c9                   	leave  
c000176b:	c3                   	ret    

c000176c <print_format>:
c000176c:	55                   	push   %ebp
c000176d:	89 e5                	mov    %esp,%ebp
c000176f:	83 ec 28             	sub    $0x28,%esp
c0001772:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0001779:	e9 8e 00 00 00       	jmp    c000180c <print_format+0xa0>
c000177e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001781:	03 45 08             	add    0x8(%ebp),%eax
c0001784:	0f b6 00             	movzbl (%eax),%eax
c0001787:	3c 25                	cmp    $0x25,%al
c0001789:	75 63                	jne    c00017ee <print_format+0x82>
c000178b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000178e:	83 c0 01             	add    $0x1,%eax
c0001791:	03 45 08             	add    0x8(%ebp),%eax
c0001794:	0f b6 00             	movzbl (%eax),%eax
c0001797:	84 c0                	test   %al,%al
c0001799:	74 22                	je     c00017bd <print_format+0x51>
c000179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000179e:	83 c0 01             	add    $0x1,%eax
c00017a1:	03 45 08             	add    0x8(%ebp),%eax
c00017a4:	0f b6 00             	movzbl (%eax),%eax
c00017a7:	3c 64                	cmp    $0x64,%al
c00017a9:	75 12                	jne    c00017bd <print_format+0x51>
c00017ab:	8b 45 0c             	mov    0xc(%ebp),%eax
c00017ae:	89 04 24             	mov    %eax,(%esp)
c00017b1:	e8 05 ff ff ff       	call   c00016bb <print_dec>
c00017b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c00017ba:	90                   	nop
c00017bb:	eb 4b                	jmp    c0001808 <print_format+0x9c>
c00017bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00017c0:	83 c0 01             	add    $0x1,%eax
c00017c3:	03 45 08             	add    0x8(%ebp),%eax
c00017c6:	0f b6 00             	movzbl (%eax),%eax
c00017c9:	84 c0                	test   %al,%al
c00017cb:	74 37                	je     c0001804 <print_format+0x98>
c00017cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00017d0:	83 c0 01             	add    $0x1,%eax
c00017d3:	03 45 08             	add    0x8(%ebp),%eax
c00017d6:	0f b6 00             	movzbl (%eax),%eax
c00017d9:	3c 78                	cmp    $0x78,%al
c00017db:	75 2a                	jne    c0001807 <print_format+0x9b>
c00017dd:	8b 45 0c             	mov    0xc(%ebp),%eax
c00017e0:	89 04 24             	mov    %eax,(%esp)
c00017e3:	e8 48 fe ff ff       	call   c0001630 <print_num>
c00017e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c00017ec:	eb 1a                	jmp    c0001808 <print_format+0x9c>
c00017ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00017f1:	03 45 08             	add    0x8(%ebp),%eax
c00017f4:	0f b6 00             	movzbl (%eax),%eax
c00017f7:	0f b6 c0             	movzbl %al,%eax
c00017fa:	89 04 24             	mov    %eax,(%esp)
c00017fd:	e8 2e 19 00 00       	call   c0003130 <put_char>
c0001802:	eb 04                	jmp    c0001808 <print_format+0x9c>
c0001804:	90                   	nop
c0001805:	eb 01                	jmp    c0001808 <print_format+0x9c>
c0001807:	90                   	nop
c0001808:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c000180c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000180f:	03 45 08             	add    0x8(%ebp),%eax
c0001812:	0f b6 00             	movzbl (%eax),%eax
c0001815:	84 c0                	test   %al,%al
c0001817:	0f 85 61 ff ff ff    	jne    c000177e <print_format+0x12>
c000181d:	c9                   	leave  
c000181e:	c3                   	ret    

c000181f <outb>:
c000181f:	55                   	push   %ebp
c0001820:	89 e5                	mov    %esp,%ebp
c0001822:	83 ec 08             	sub    $0x8,%esp
c0001825:	8b 55 08             	mov    0x8(%ebp),%edx
c0001828:	8b 45 0c             	mov    0xc(%ebp),%eax
c000182b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
c000182f:	88 45 f8             	mov    %al,-0x8(%ebp)
c0001832:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
c0001836:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
c000183a:	ee                   	out    %al,(%dx)
c000183b:	c9                   	leave  
c000183c:	c3                   	ret    

c000183d <outsw>:
c000183d:	55                   	push   %ebp
c000183e:	89 e5                	mov    %esp,%ebp
c0001840:	56                   	push   %esi
c0001841:	53                   	push   %ebx
c0001842:	83 ec 04             	sub    $0x4,%esp
c0001845:	8b 45 08             	mov    0x8(%ebp),%eax
c0001848:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
c000184c:	0f b7 55 f4          	movzwl -0xc(%ebp),%edx
c0001850:	8b 4d 0c             	mov    0xc(%ebp),%ecx
c0001853:	8b 45 10             	mov    0x10(%ebp),%eax
c0001856:	89 cb                	mov    %ecx,%ebx
c0001858:	89 de                	mov    %ebx,%esi
c000185a:	89 c1                	mov    %eax,%ecx
c000185c:	fc                   	cld    
c000185d:	66 f3 6f             	rep outsw %ds:(%esi),(%dx)
c0001860:	89 c8                	mov    %ecx,%eax
c0001862:	89 f3                	mov    %esi,%ebx
c0001864:	89 5d 0c             	mov    %ebx,0xc(%ebp)
c0001867:	89 45 10             	mov    %eax,0x10(%ebp)
c000186a:	83 c4 04             	add    $0x4,%esp
c000186d:	5b                   	pop    %ebx
c000186e:	5e                   	pop    %esi
c000186f:	5d                   	pop    %ebp
c0001870:	c3                   	ret    

c0001871 <inb>:
c0001871:	55                   	push   %ebp
c0001872:	89 e5                	mov    %esp,%ebp
c0001874:	83 ec 14             	sub    $0x14,%esp
c0001877:	8b 45 08             	mov    0x8(%ebp),%eax
c000187a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
c000187e:	c6 45 ff 00          	movb   $0x0,-0x1(%ebp)
c0001882:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c0001886:	89 c2                	mov    %eax,%edx
c0001888:	ec                   	in     (%dx),%al
c0001889:	88 45 ff             	mov    %al,-0x1(%ebp)
c000188c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
c0001890:	c9                   	leave  
c0001891:	c3                   	ret    

c0001892 <insw>:
c0001892:	55                   	push   %ebp
c0001893:	89 e5                	mov    %esp,%ebp
c0001895:	57                   	push   %edi
c0001896:	53                   	push   %ebx
c0001897:	83 ec 04             	sub    $0x4,%esp
c000189a:	8b 45 08             	mov    0x8(%ebp),%eax
c000189d:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
c00018a1:	0f b7 55 f4          	movzwl -0xc(%ebp),%edx
c00018a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
c00018a8:	8b 45 10             	mov    0x10(%ebp),%eax
c00018ab:	89 cb                	mov    %ecx,%ebx
c00018ad:	89 df                	mov    %ebx,%edi
c00018af:	89 c1                	mov    %eax,%ecx
c00018b1:	fc                   	cld    
c00018b2:	66 f3 6d             	rep insw (%dx),%es:(%edi)
c00018b5:	89 c8                	mov    %ecx,%eax
c00018b7:	89 fb                	mov    %edi,%ebx
c00018b9:	89 5d 0c             	mov    %ebx,0xc(%ebp)
c00018bc:	89 45 10             	mov    %eax,0x10(%ebp)
c00018bf:	83 c4 04             	add    $0x4,%esp
c00018c2:	5b                   	pop    %ebx
c00018c3:	5f                   	pop    %edi
c00018c4:	5d                   	pop    %ebp
c00018c5:	c3                   	ret    

c00018c6 <register_interrupt>:
c00018c6:	55                   	push   %ebp
c00018c7:	89 e5                	mov    %esp,%ebp
c00018c9:	8b 45 08             	mov    0x8(%ebp),%eax
c00018cc:	8b 55 0c             	mov    0xc(%ebp),%edx
c00018cf:	89 14 85 e0 59 00 c0 	mov    %edx,-0x3fffa620(,%eax,4)
c00018d6:	5d                   	pop    %ebp
c00018d7:	c3                   	ret    

c00018d8 <make_idt_desc>:
c00018d8:	55                   	push   %ebp
c00018d9:	89 e5                	mov    %esp,%ebp
c00018db:	83 ec 04             	sub    $0x4,%esp
c00018de:	8b 45 0c             	mov    0xc(%ebp),%eax
c00018e1:	88 45 fc             	mov    %al,-0x4(%ebp)
c00018e4:	8b 45 10             	mov    0x10(%ebp),%eax
c00018e7:	89 c2                	mov    %eax,%edx
c00018e9:	8b 45 08             	mov    0x8(%ebp),%eax
c00018ec:	66 89 10             	mov    %dx,(%eax)
c00018ef:	8b 45 10             	mov    0x10(%ebp),%eax
c00018f2:	c1 e8 10             	shr    $0x10,%eax
c00018f5:	89 c2                	mov    %eax,%edx
c00018f7:	8b 45 08             	mov    0x8(%ebp),%eax
c00018fa:	66 89 50 06          	mov    %dx,0x6(%eax)
c00018fe:	8b 45 08             	mov    0x8(%ebp),%eax
c0001901:	c6 40 04 00          	movb   $0x0,0x4(%eax)
c0001905:	8b 45 08             	mov    0x8(%ebp),%eax
c0001908:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
c000190c:	88 50 05             	mov    %dl,0x5(%eax)
c000190f:	8b 45 08             	mov    0x8(%ebp),%eax
c0001912:	66 c7 40 02 08 00    	movw   $0x8,0x2(%eax)
c0001918:	c9                   	leave  
c0001919:	c3                   	ret    

c000191a <idt_desc_init>:
c000191a:	55                   	push   %ebp
c000191b:	89 e5                	mov    %esp,%ebp
c000191d:	83 ec 1c             	sub    $0x1c,%esp
c0001920:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c0001927:	eb 2e                	jmp    c0001957 <idt_desc_init+0x3d>
c0001929:	8b 45 fc             	mov    -0x4(%ebp),%eax
c000192c:	8b 04 85 2a 57 00 c0 	mov    -0x3fffa8d6(,%eax,4),%eax
c0001933:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0001936:	c1 e2 03             	shl    $0x3,%edx
c0001939:	81 c2 c0 58 00 c0    	add    $0xc00058c0,%edx
c000193f:	89 44 24 08          	mov    %eax,0x8(%esp)
c0001943:	c7 44 24 04 8e 00 00 	movl   $0x8e,0x4(%esp)
c000194a:	00 
c000194b:	89 14 24             	mov    %edx,(%esp)
c000194e:	e8 85 ff ff ff       	call   c00018d8 <make_idt_desc>
c0001953:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0001957:	83 7d fc 20          	cmpl   $0x20,-0x4(%ebp)
c000195b:	7e cc                	jle    c0001929 <idt_desc_init+0xf>
c000195d:	c9                   	leave  
c000195e:	c3                   	ret    

c000195f <pic_init>:
c000195f:	55                   	push   %ebp
c0001960:	89 e5                	mov    %esp,%ebp
c0001962:	83 ec 18             	sub    $0x18,%esp
c0001965:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
c000196c:	00 
c000196d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0001974:	e8 a6 fe ff ff       	call   c000181f <outb>
c0001979:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
c0001980:	00 
c0001981:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
c0001988:	e8 92 fe ff ff       	call   c000181f <outb>
c000198d:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
c0001994:	00 
c0001995:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
c000199c:	e8 7e fe ff ff       	call   c000181f <outb>
c00019a1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c00019a8:	00 
c00019a9:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
c00019b0:	e8 6a fe ff ff       	call   c000181f <outb>
c00019b5:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
c00019bc:	00 
c00019bd:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
c00019c4:	e8 56 fe ff ff       	call   c000181f <outb>
c00019c9:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
c00019d0:	00 
c00019d1:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
c00019d8:	e8 42 fe ff ff       	call   c000181f <outb>
c00019dd:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
c00019e4:	00 
c00019e5:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
c00019ec:	e8 2e fe ff ff       	call   c000181f <outb>
c00019f1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c00019f8:	00 
c00019f9:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
c0001a00:	e8 1a fe ff ff       	call   c000181f <outb>
c0001a05:	c7 44 24 04 fe 00 00 	movl   $0xfe,0x4(%esp)
c0001a0c:	00 
c0001a0d:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
c0001a14:	e8 06 fe ff ff       	call   c000181f <outb>
c0001a19:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
c0001a20:	00 
c0001a21:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
c0001a28:	e8 f2 fd ff ff       	call   c000181f <outb>
c0001a2d:	c7 04 24 5a 40 00 c0 	movl   $0xc000405a,(%esp)
c0001a34:	e8 87 fb ff ff       	call   c00015c0 <print_str>
c0001a39:	c9                   	leave  
c0001a3a:	c3                   	ret    

c0001a3b <idt_init>:
c0001a3b:	55                   	push   %ebp
c0001a3c:	89 e5                	mov    %esp,%ebp
c0001a3e:	56                   	push   %esi
c0001a3f:	53                   	push   %ebx
c0001a40:	83 ec 20             	sub    $0x20,%esp
c0001a43:	c7 04 24 6a 40 00 c0 	movl   $0xc000406a,(%esp)
c0001a4a:	e8 71 fb ff ff       	call   c00015c0 <print_str>
c0001a4f:	e8 c6 fe ff ff       	call   c000191a <idt_desc_init>
c0001a54:	e8 06 ff ff ff       	call   c000195f <pic_init>
c0001a59:	b8 c0 58 00 c0       	mov    $0xc00058c0,%eax
c0001a5e:	ba 00 00 00 00       	mov    $0x0,%edx
c0001a63:	0f a4 c2 10          	shld   $0x10,%eax,%edx
c0001a67:	c1 e0 10             	shl    $0x10,%eax
c0001a6a:	89 c3                	mov    %eax,%ebx
c0001a6c:	81 cb 07 01 00 00    	or     $0x107,%ebx
c0001a72:	89 d6                	mov    %edx,%esi
c0001a74:	83 ce 00             	or     $0x0,%esi
c0001a77:	89 5d f0             	mov    %ebx,-0x10(%ebp)
c0001a7a:	89 75 f4             	mov    %esi,-0xc(%ebp)
c0001a7d:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0001a84:	e8 37 fb ff ff       	call   c00015c0 <print_str>
c0001a89:	0f 01 5d f0          	lidtl  -0x10(%ebp)
c0001a8d:	83 c4 20             	add    $0x20,%esp
c0001a90:	5b                   	pop    %ebx
c0001a91:	5e                   	pop    %esi
c0001a92:	5d                   	pop    %ebp
c0001a93:	c3                   	ret    

c0001a94 <general_intr_handler>:
c0001a94:	55                   	push   %ebp
c0001a95:	89 e5                	mov    %esp,%ebp
c0001a97:	83 ec 04             	sub    $0x4,%esp
c0001a9a:	8b 45 08             	mov    0x8(%ebp),%eax
c0001a9d:	88 45 fc             	mov    %al,-0x4(%ebp)
c0001aa0:	80 7d fc 27          	cmpb   $0x27,-0x4(%ebp)
c0001aa4:	74 06                	je     c0001aac <general_intr_handler+0x18>
c0001aa6:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
c0001aaa:	eb 01                	jmp    c0001aad <general_intr_handler+0x19>
c0001aac:	90                   	nop
c0001aad:	c9                   	leave  
c0001aae:	c3                   	ret    

c0001aaf <exception_init>:
c0001aaf:	55                   	push   %ebp
c0001ab0:	89 e5                	mov    %esp,%ebp
c0001ab2:	83 ec 10             	sub    $0x10,%esp
c0001ab5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c0001abc:	eb 20                	jmp    c0001ade <exception_init+0x2f>
c0001abe:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0001ac1:	c7 04 85 e0 59 00 c0 	movl   $0xc0001a94,-0x3fffa620(,%eax,4)
c0001ac8:	94 1a 00 c0 
c0001acc:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0001acf:	c7 04 85 20 58 00 c0 	movl   $0xc000407c,-0x3fffa7e0(,%eax,4)
c0001ad6:	7c 40 00 c0 
c0001ada:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0001ade:	83 7d fc 20          	cmpl   $0x20,-0x4(%ebp)
c0001ae2:	7e da                	jle    c0001abe <exception_init+0xf>
c0001ae4:	c7 05 20 58 00 c0 84 	movl   $0xc0004084,0xc0005820
c0001aeb:	40 00 c0 
c0001aee:	c7 05 24 58 00 c0 95 	movl   $0xc0004095,0xc0005824
c0001af5:	40 00 c0 
c0001af8:	c7 05 28 58 00 c0 a9 	movl   $0xc00040a9,0xc0005828
c0001aff:	40 00 c0 
c0001b02:	c7 05 2c 58 00 c0 b7 	movl   $0xc00040b7,0xc000582c
c0001b09:	40 00 c0 
c0001b0c:	c7 05 30 58 00 c0 d0 	movl   $0xc00040d0,0xc0005830
c0001b13:	40 00 c0 
c0001b16:	c7 05 34 58 00 c0 e8 	movl   $0xc00040e8,0xc0005834
c0001b1d:	40 00 c0 
c0001b20:	c7 05 38 58 00 c0 0b 	movl   $0xc000410b,0xc0005838
c0001b27:	41 00 c0 
c0001b2a:	c7 05 3c 58 00 c0 28 	movl   $0xc0004128,0xc000583c
c0001b31:	41 00 c0 
c0001b34:	c7 05 40 58 00 c0 4b 	movl   $0xc000414b,0xc0005840
c0001b3b:	41 00 c0 
c0001b3e:	c7 05 44 58 00 c0 66 	movl   $0xc0004166,0xc0005844
c0001b45:	41 00 c0 
c0001b48:	c7 05 48 58 00 c0 82 	movl   $0xc0004182,0xc0005848
c0001b4f:	41 00 c0 
c0001b52:	c7 05 4c 58 00 c0 9c 	movl   $0xc000419c,0xc000584c
c0001b59:	41 00 c0 
c0001b5c:	c7 05 50 58 00 c0 b4 	movl   $0xc00041b4,0xc0005850
c0001b63:	41 00 c0 
c0001b66:	c7 05 54 58 00 c0 d0 	movl   $0xc00041d0,0xc0005854
c0001b6d:	41 00 c0 
c0001b70:	c7 05 58 58 00 c0 f1 	movl   $0xc00041f1,0xc0005858
c0001b77:	41 00 c0 
c0001b7a:	c7 05 60 58 00 c0 0c 	movl   $0xc000420c,0xc0005860
c0001b81:	42 00 c0 
c0001b84:	c7 05 64 58 00 c0 2d 	movl   $0xc000422d,0xc0005864
c0001b8b:	42 00 c0 
c0001b8e:	c7 05 68 58 00 c0 4b 	movl   $0xc000424b,0xc0005868
c0001b95:	42 00 c0 
c0001b98:	c7 05 6c 58 00 c0 68 	movl   $0xc0004268,0xc000586c
c0001b9f:	42 00 c0 
c0001ba2:	c9                   	leave  
c0001ba3:	c3                   	ret    

c0001ba4 <frequency_set>:
c0001ba4:	55                   	push   %ebp
c0001ba5:	89 e5                	mov    %esp,%ebp
c0001ba7:	56                   	push   %esi
c0001ba8:	53                   	push   %ebx
c0001ba9:	83 ec 20             	sub    $0x20,%esp
c0001bac:	8b 75 08             	mov    0x8(%ebp),%esi
c0001baf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
c0001bb2:	8b 4d 10             	mov    0x10(%ebp),%ecx
c0001bb5:	8b 55 14             	mov    0x14(%ebp),%edx
c0001bb8:	8b 45 18             	mov    0x18(%ebp),%eax
c0001bbb:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0001bbe:	89 f0                	mov    %esi,%eax
c0001bc0:	88 45 f4             	mov    %al,-0xc(%ebp)
c0001bc3:	88 5d f0             	mov    %bl,-0x10(%ebp)
c0001bc6:	88 4d ec             	mov    %cl,-0x14(%ebp)
c0001bc9:	88 55 e8             	mov    %dl,-0x18(%ebp)
c0001bcc:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
c0001bd0:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
c0001bd4:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
c0001bd8:	c1 e0 06             	shl    $0x6,%eax
c0001bdb:	89 c2                	mov    %eax,%edx
c0001bdd:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
c0001be1:	c1 e0 04             	shl    $0x4,%eax
c0001be4:	09 c2                	or     %eax,%edx
c0001be6:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
c0001bea:	01 c0                	add    %eax,%eax
c0001bec:	09 d0                	or     %edx,%eax
c0001bee:	0f b6 c0             	movzbl %al,%eax
c0001bf1:	89 44 24 04          	mov    %eax,0x4(%esp)
c0001bf5:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
c0001bfc:	e8 1e fc ff ff       	call   c000181f <outb>
c0001c01:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
c0001c05:	0f b6 d0             	movzbl %al,%edx
c0001c08:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
c0001c0c:	89 54 24 04          	mov    %edx,0x4(%esp)
c0001c10:	89 04 24             	mov    %eax,(%esp)
c0001c13:	e8 07 fc ff ff       	call   c000181f <outb>
c0001c18:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
c0001c1c:	0f b6 c0             	movzbl %al,%eax
c0001c1f:	c1 f8 08             	sar    $0x8,%eax
c0001c22:	0f b6 d0             	movzbl %al,%edx
c0001c25:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
c0001c29:	89 54 24 04          	mov    %edx,0x4(%esp)
c0001c2d:	89 04 24             	mov    %eax,(%esp)
c0001c30:	e8 ea fb ff ff       	call   c000181f <outb>
c0001c35:	83 c4 20             	add    $0x20,%esp
c0001c38:	5b                   	pop    %ebx
c0001c39:	5e                   	pop    %esi
c0001c3a:	5d                   	pop    %ebp
c0001c3b:	c3                   	ret    

c0001c3c <intr_timer_handler>:
c0001c3c:	55                   	push   %ebp
c0001c3d:	89 e5                	mov    %esp,%ebp
c0001c3f:	83 ec 28             	sub    $0x28,%esp
c0001c42:	e8 b3 11 00 00       	call   c0002dfa <running_thread>
c0001c47:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0001c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001c4d:	8b 40 30             	mov    0x30(%eax),%eax
c0001c50:	3d 16 09 87 19       	cmp    $0x19870916,%eax
c0001c55:	74 24                	je     c0001c7b <intr_timer_handler+0x3f>
c0001c57:	c7 44 24 0c 8c 42 00 	movl   $0xc000428c,0xc(%esp)
c0001c5e:	c0 
c0001c5f:	c7 44 24 08 05 47 00 	movl   $0xc0004705,0x8(%esp)
c0001c66:	c0 
c0001c67:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
c0001c6e:	00 
c0001c6f:	c7 04 24 b4 42 00 c0 	movl   $0xc00042b4,(%esp)
c0001c76:	e8 57 02 00 00       	call   c0001ed2 <panic_spin>
c0001c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001c7e:	0f b6 40 1a          	movzbl 0x1a(%eax),%eax
c0001c82:	8d 50 01             	lea    0x1(%eax),%edx
c0001c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001c88:	88 50 1a             	mov    %dl,0x1a(%eax)
c0001c8b:	a1 c0 57 00 c0       	mov    0xc00057c0,%eax
c0001c90:	83 c0 01             	add    $0x1,%eax
c0001c93:	a3 c0 57 00 c0       	mov    %eax,0xc00057c0
c0001c98:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001c9b:	0f b6 40 19          	movzbl 0x19(%eax),%eax
c0001c9f:	84 c0                	test   %al,%al
c0001ca1:	75 07                	jne    c0001caa <intr_timer_handler+0x6e>
c0001ca3:	e8 14 00 00 00       	call   c0001cbc <schedule>
c0001ca8:	eb 10                	jmp    c0001cba <intr_timer_handler+0x7e>
c0001caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001cad:	0f b6 40 19          	movzbl 0x19(%eax),%eax
c0001cb1:	8d 50 ff             	lea    -0x1(%eax),%edx
c0001cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001cb7:	88 50 19             	mov    %dl,0x19(%eax)
c0001cba:	c9                   	leave  
c0001cbb:	c3                   	ret    

c0001cbc <schedule>:
c0001cbc:	55                   	push   %ebp
c0001cbd:	89 e5                	mov    %esp,%ebp
c0001cbf:	83 ec 28             	sub    $0x28,%esp
c0001cc2:	e8 e8 01 00 00       	call   c0001eaf <intr_get_status>
c0001cc7:	83 f8 01             	cmp    $0x1,%eax
c0001cca:	74 24                	je     c0001cf0 <schedule+0x34>
c0001ccc:	c7 44 24 0c be 42 00 	movl   $0xc00042be,0xc(%esp)
c0001cd3:	c0 
c0001cd4:	c7 44 24 08 fc 46 00 	movl   $0xc00046fc,0x8(%esp)
c0001cdb:	c0 
c0001cdc:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
c0001ce3:	00 
c0001ce4:	c7 04 24 b4 42 00 c0 	movl   $0xc00042b4,(%esp)
c0001ceb:	e8 e2 01 00 00       	call   c0001ed2 <panic_spin>
c0001cf0:	e8 05 11 00 00       	call   c0002dfa <running_thread>
c0001cf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0001cf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001cfb:	8b 40 04             	mov    0x4(%eax),%eax
c0001cfe:	85 c0                	test   %eax,%eax
c0001d00:	75 6b                	jne    c0001d6d <schedule+0xb1>
c0001d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001d05:	83 c0 1c             	add    $0x1c,%eax
c0001d08:	89 44 24 04          	mov    %eax,0x4(%esp)
c0001d0c:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0001d13:	e8 81 13 00 00       	call   c0003099 <elem_find>
c0001d18:	84 c0                	test   %al,%al
c0001d1a:	74 24                	je     c0001d40 <schedule+0x84>
c0001d1c:	c7 44 24 0c dc 42 00 	movl   $0xc00042dc,0xc(%esp)
c0001d23:	c0 
c0001d24:	c7 44 24 08 fc 46 00 	movl   $0xc00046fc,0x8(%esp)
c0001d2b:	c0 
c0001d2c:	c7 44 24 04 2d 00 00 	movl   $0x2d,0x4(%esp)
c0001d33:	00 
c0001d34:	c7 04 24 b4 42 00 c0 	movl   $0xc00042b4,(%esp)
c0001d3b:	e8 92 01 00 00       	call   c0001ed2 <panic_spin>
c0001d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001d43:	0f b6 50 18          	movzbl 0x18(%eax),%edx
c0001d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001d4a:	88 50 19             	mov    %dl,0x19(%eax)
c0001d4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001d50:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
c0001d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001d5a:	83 c0 1c             	add    $0x1c,%eax
c0001d5d:	89 44 24 04          	mov    %eax,0x4(%esp)
c0001d61:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0001d68:	e8 f8 11 00 00       	call   c0002f65 <list_append>
c0001d6d:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0001d74:	e8 5e 12 00 00       	call   c0002fd7 <list_empty>
c0001d79:	84 c0                	test   %al,%al
c0001d7b:	74 24                	je     c0001da1 <schedule+0xe5>
c0001d7d:	c7 44 24 0c 10 43 00 	movl   $0xc0004310,0xc(%esp)
c0001d84:	c0 
c0001d85:	c7 44 24 08 fc 46 00 	movl   $0xc00046fc,0x8(%esp)
c0001d8c:	c0 
c0001d8d:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
c0001d94:	00 
c0001d95:	c7 04 24 b4 42 00 c0 	movl   $0xc00042b4,(%esp)
c0001d9c:	e8 31 01 00 00       	call   c0001ed2 <panic_spin>
c0001da1:	c7 05 d8 59 00 c0 00 	movl   $0x0,0xc00059d8
c0001da8:	00 00 00 
c0001dab:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0001db2:	e8 01 12 00 00       	call   c0002fb8 <list_pop>
c0001db7:	a3 d8 59 00 c0       	mov    %eax,0xc00059d8
c0001dbc:	a1 d8 59 00 c0       	mov    0xc00059d8,%eax
c0001dc1:	83 e8 1c             	sub    $0x1c,%eax
c0001dc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0001dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0001dca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
c0001dd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0001dd4:	89 44 24 04          	mov    %eax,0x4(%esp)
c0001dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001ddb:	89 04 24             	mov    %eax,(%esp)
c0001dde:	e8 f3 17 00 00       	call   c00035d6 <switch_to>
c0001de3:	c9                   	leave  
c0001de4:	c3                   	ret    

c0001de5 <timer_init>:
c0001de5:	55                   	push   %ebp
c0001de6:	89 e5                	mov    %esp,%ebp
c0001de8:	83 ec 28             	sub    $0x28,%esp
c0001deb:	c7 04 24 30 43 00 c0 	movl   $0xc0004330,(%esp)
c0001df2:	e8 c9 f7 ff ff       	call   c00015c0 <print_str>
c0001df7:	c7 44 24 10 9b 2e 00 	movl   $0x2e9b,0x10(%esp)
c0001dfe:	00 
c0001dff:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
c0001e06:	00 
c0001e07:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
c0001e0e:	00 
c0001e0f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0001e16:	00 
c0001e17:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
c0001e1e:	e8 81 fd ff ff       	call   c0001ba4 <frequency_set>
c0001e23:	c7 04 24 40 43 00 c0 	movl   $0xc0004340,(%esp)
c0001e2a:	e8 91 f7 ff ff       	call   c00015c0 <print_str>
c0001e2f:	c7 44 24 04 3c 1c 00 	movl   $0xc0001c3c,0x4(%esp)
c0001e36:	c0 
c0001e37:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0001e3e:	e8 83 fa ff ff       	call   c00018c6 <register_interrupt>
c0001e43:	c9                   	leave  
c0001e44:	c3                   	ret    

c0001e45 <intr_enable>:
c0001e45:	55                   	push   %ebp
c0001e46:	89 e5                	mov    %esp,%ebp
c0001e48:	83 ec 18             	sub    $0x18,%esp
c0001e4b:	e8 5f 00 00 00       	call   c0001eaf <intr_get_status>
c0001e50:	85 c0                	test   %eax,%eax
c0001e52:	75 0c                	jne    c0001e60 <intr_enable+0x1b>
c0001e54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0001e5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001e5e:	eb 0b                	jmp    c0001e6b <intr_enable+0x26>
c0001e60:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
c0001e67:	fb                   	sti    
c0001e68:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001e6b:	c9                   	leave  
c0001e6c:	c3                   	ret    

c0001e6d <intr_disable>:
c0001e6d:	55                   	push   %ebp
c0001e6e:	89 e5                	mov    %esp,%ebp
c0001e70:	83 ec 18             	sub    $0x18,%esp
c0001e73:	e8 37 00 00 00       	call   c0001eaf <intr_get_status>
c0001e78:	85 c0                	test   %eax,%eax
c0001e7a:	75 0d                	jne    c0001e89 <intr_disable+0x1c>
c0001e7c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0001e83:	fa                   	cli    
c0001e84:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001e87:	eb 0a                	jmp    c0001e93 <intr_disable+0x26>
c0001e89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
c0001e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001e93:	c9                   	leave  
c0001e94:	c3                   	ret    

c0001e95 <intr_set_status>:
c0001e95:	55                   	push   %ebp
c0001e96:	89 e5                	mov    %esp,%ebp
c0001e98:	83 ec 08             	sub    $0x8,%esp
c0001e9b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0001e9f:	75 07                	jne    c0001ea8 <intr_set_status+0x13>
c0001ea1:	e8 9f ff ff ff       	call   c0001e45 <intr_enable>
c0001ea6:	eb 05                	jmp    c0001ead <intr_set_status+0x18>
c0001ea8:	e8 c0 ff ff ff       	call   c0001e6d <intr_disable>
c0001ead:	c9                   	leave  
c0001eae:	c3                   	ret    

c0001eaf <intr_get_status>:
c0001eaf:	55                   	push   %ebp
c0001eb0:	89 e5                	mov    %esp,%ebp
c0001eb2:	83 ec 10             	sub    $0x10,%esp
c0001eb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c0001ebc:	9c                   	pushf  
c0001ebd:	8f 45 fc             	popl   -0x4(%ebp)
c0001ec0:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0001ec3:	25 00 02 00 00       	and    $0x200,%eax
c0001ec8:	85 c0                	test   %eax,%eax
c0001eca:	0f 94 c0             	sete   %al
c0001ecd:	0f b6 c0             	movzbl %al,%eax
c0001ed0:	c9                   	leave  
c0001ed1:	c3                   	ret    

c0001ed2 <panic_spin>:
c0001ed2:	55                   	push   %ebp
c0001ed3:	89 e5                	mov    %esp,%ebp
c0001ed5:	83 ec 18             	sub    $0x18,%esp
c0001ed8:	e8 90 ff ff ff       	call   c0001e6d <intr_disable>
c0001edd:	c7 04 24 4f 43 00 c0 	movl   $0xc000434f,(%esp)
c0001ee4:	e8 d7 f6 ff ff       	call   c00015c0 <print_str>
c0001ee9:	c7 04 24 58 43 00 c0 	movl   $0xc0004358,(%esp)
c0001ef0:	e8 cb f6 ff ff       	call   c00015c0 <print_str>
c0001ef5:	8b 45 08             	mov    0x8(%ebp),%eax
c0001ef8:	89 04 24             	mov    %eax,(%esp)
c0001efb:	e8 c0 f6 ff ff       	call   c00015c0 <print_str>
c0001f00:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0001f07:	e8 b4 f6 ff ff       	call   c00015c0 <print_str>
c0001f0c:	c7 04 24 64 43 00 c0 	movl   $0xc0004364,(%esp)
c0001f13:	e8 a8 f6 ff ff       	call   c00015c0 <print_str>
c0001f18:	8b 45 0c             	mov    0xc(%ebp),%eax
c0001f1b:	89 04 24             	mov    %eax,(%esp)
c0001f1e:	e8 98 f7 ff ff       	call   c00016bb <print_dec>
c0001f23:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0001f2a:	e8 91 f6 ff ff       	call   c00015c0 <print_str>
c0001f2f:	c7 04 24 6c 43 00 c0 	movl   $0xc000436c,(%esp)
c0001f36:	e8 85 f6 ff ff       	call   c00015c0 <print_str>
c0001f3b:	8b 45 10             	mov    0x10(%ebp),%eax
c0001f3e:	89 04 24             	mov    %eax,(%esp)
c0001f41:	e8 7a f6 ff ff       	call   c00015c0 <print_str>
c0001f46:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0001f4d:	e8 6e f6 ff ff       	call   c00015c0 <print_str>
c0001f52:	c7 04 24 78 43 00 c0 	movl   $0xc0004378,(%esp)
c0001f59:	e8 62 f6 ff ff       	call   c00015c0 <print_str>
c0001f5e:	8b 45 14             	mov    0x14(%ebp),%eax
c0001f61:	89 04 24             	mov    %eax,(%esp)
c0001f64:	e8 57 f6 ff ff       	call   c00015c0 <print_str>
c0001f69:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0001f70:	e8 4b f6 ff ff       	call   c00015c0 <print_str>
c0001f75:	c9                   	leave  
c0001f76:	c3                   	ret    

c0001f77 <memset>:
c0001f77:	55                   	push   %ebp
c0001f78:	89 e5                	mov    %esp,%ebp
c0001f7a:	83 ec 38             	sub    $0x38,%esp
c0001f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0001f80:	88 45 e4             	mov    %al,-0x1c(%ebp)
c0001f83:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0001f87:	75 24                	jne    c0001fad <memset+0x36>
c0001f89:	c7 44 24 0c 84 43 00 	movl   $0xc0004384,0xc(%esp)
c0001f90:	c0 
c0001f91:	c7 44 24 08 f5 46 00 	movl   $0xc00046f5,0x8(%esp)
c0001f98:	c0 
c0001f99:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
c0001fa0:	00 
c0001fa1:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c0001fa8:	e8 25 ff ff ff       	call   c0001ed2 <panic_spin>
c0001fad:	8b 45 08             	mov    0x8(%ebp),%eax
c0001fb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0001fb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0001fba:	eb 10                	jmp    c0001fcc <memset+0x55>
c0001fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001fbf:	03 45 f0             	add    -0x10(%ebp),%eax
c0001fc2:	0f b6 55 e4          	movzbl -0x1c(%ebp),%edx
c0001fc6:	88 10                	mov    %dl,(%eax)
c0001fc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0001fcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0001fcf:	3b 45 10             	cmp    0x10(%ebp),%eax
c0001fd2:	72 e8                	jb     c0001fbc <memset+0x45>
c0001fd4:	c9                   	leave  
c0001fd5:	c3                   	ret    

c0001fd6 <memcpy>:
c0001fd6:	55                   	push   %ebp
c0001fd7:	89 e5                	mov    %esp,%ebp
c0001fd9:	83 ec 28             	sub    $0x28,%esp
c0001fdc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0001fe0:	75 24                	jne    c0002006 <memcpy+0x30>
c0001fe2:	c7 44 24 0c 84 43 00 	movl   $0xc0004384,0xc(%esp)
c0001fe9:	c0 
c0001fea:	c7 44 24 08 ee 46 00 	movl   $0xc00046ee,0x8(%esp)
c0001ff1:	c0 
c0001ff2:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
c0001ff9:	00 
c0001ffa:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c0002001:	e8 cc fe ff ff       	call   c0001ed2 <panic_spin>
c0002006:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c000200a:	75 24                	jne    c0002030 <memcpy+0x5a>
c000200c:	c7 44 24 0c 9b 43 00 	movl   $0xc000439b,0xc(%esp)
c0002013:	c0 
c0002014:	c7 44 24 08 ee 46 00 	movl   $0xc00046ee,0x8(%esp)
c000201b:	c0 
c000201c:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
c0002023:	00 
c0002024:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c000202b:	e8 a2 fe ff ff       	call   c0001ed2 <panic_spin>
c0002030:	8b 45 08             	mov    0x8(%ebp),%eax
c0002033:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002036:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002039:	89 45 f0             	mov    %eax,-0x10(%ebp)
c000203c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0002043:	eb 15                	jmp    c000205a <memcpy+0x84>
c0002045:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0002048:	03 45 f4             	add    -0xc(%ebp),%eax
c000204b:	8b 55 ec             	mov    -0x14(%ebp),%edx
c000204e:	03 55 f0             	add    -0x10(%ebp),%edx
c0002051:	0f b6 12             	movzbl (%edx),%edx
c0002054:	88 10                	mov    %dl,(%eax)
c0002056:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c000205a:	8b 45 ec             	mov    -0x14(%ebp),%eax
c000205d:	3b 45 10             	cmp    0x10(%ebp),%eax
c0002060:	72 e3                	jb     c0002045 <memcpy+0x6f>
c0002062:	c9                   	leave  
c0002063:	c3                   	ret    

c0002064 <memcmp>:
c0002064:	55                   	push   %ebp
c0002065:	89 e5                	mov    %esp,%ebp
c0002067:	83 ec 28             	sub    $0x28,%esp
c000206a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c000206e:	75 24                	jne    c0002094 <memcmp+0x30>
c0002070:	c7 44 24 0c a7 43 00 	movl   $0xc00043a7,0xc(%esp)
c0002077:	c0 
c0002078:	c7 44 24 08 e7 46 00 	movl   $0xc00046e7,0x8(%esp)
c000207f:	c0 
c0002080:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
c0002087:	00 
c0002088:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c000208f:	e8 3e fe ff ff       	call   c0001ed2 <panic_spin>
c0002094:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0002098:	75 24                	jne    c00020be <memcmp+0x5a>
c000209a:	c7 44 24 0c b2 43 00 	movl   $0xc00043b2,0xc(%esp)
c00020a1:	c0 
c00020a2:	c7 44 24 08 e7 46 00 	movl   $0xc00046e7,0x8(%esp)
c00020a9:	c0 
c00020aa:	c7 44 24 04 21 00 00 	movl   $0x21,0x4(%esp)
c00020b1:	00 
c00020b2:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c00020b9:	e8 14 fe ff ff       	call   c0001ed2 <panic_spin>
c00020be:	8b 45 08             	mov    0x8(%ebp),%eax
c00020c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00020c4:	8b 45 0c             	mov    0xc(%ebp),%eax
c00020c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
c00020ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c00020d1:	eb 3e                	jmp    c0002111 <memcmp+0xad>
c00020d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00020d6:	03 45 f4             	add    -0xc(%ebp),%eax
c00020d9:	0f b6 10             	movzbl (%eax),%edx
c00020dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00020df:	03 45 f0             	add    -0x10(%ebp),%eax
c00020e2:	0f b6 00             	movzbl (%eax),%eax
c00020e5:	38 c2                	cmp    %al,%dl
c00020e7:	76 07                	jbe    c00020f0 <memcmp+0x8c>
c00020e9:	b8 01 00 00 00       	mov    $0x1,%eax
c00020ee:	eb 2e                	jmp    c000211e <memcmp+0xba>
c00020f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00020f3:	03 45 f4             	add    -0xc(%ebp),%eax
c00020f6:	0f b6 10             	movzbl (%eax),%edx
c00020f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00020fc:	03 45 f0             	add    -0x10(%ebp),%eax
c00020ff:	0f b6 00             	movzbl (%eax),%eax
c0002102:	38 c2                	cmp    %al,%dl
c0002104:	73 07                	jae    c000210d <memcmp+0xa9>
c0002106:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c000210b:	eb 11                	jmp    c000211e <memcmp+0xba>
c000210d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c0002111:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0002114:	3b 45 10             	cmp    0x10(%ebp),%eax
c0002117:	72 ba                	jb     c00020d3 <memcmp+0x6f>
c0002119:	b8 00 00 00 00       	mov    $0x0,%eax
c000211e:	c9                   	leave  
c000211f:	c3                   	ret    

c0002120 <strcpy>:
c0002120:	55                   	push   %ebp
c0002121:	89 e5                	mov    %esp,%ebp
c0002123:	83 ec 28             	sub    $0x28,%esp
c0002126:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c000212a:	74 06                	je     c0002132 <strcpy+0x12>
c000212c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0002130:	75 24                	jne    c0002156 <strcpy+0x36>
c0002132:	c7 44 24 0c bd 43 00 	movl   $0xc00043bd,0xc(%esp)
c0002139:	c0 
c000213a:	c7 44 24 08 e0 46 00 	movl   $0xc00046e0,0x8(%esp)
c0002141:	c0 
c0002142:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
c0002149:	00 
c000214a:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c0002151:	e8 7c fd ff ff       	call   c0001ed2 <panic_spin>
c0002156:	8b 45 08             	mov    0x8(%ebp),%eax
c0002159:	89 45 f4             	mov    %eax,-0xc(%ebp)
c000215c:	8b 45 0c             	mov    0xc(%ebp),%eax
c000215f:	0f b6 10             	movzbl (%eax),%edx
c0002162:	8b 45 08             	mov    0x8(%ebp),%eax
c0002165:	88 10                	mov    %dl,(%eax)
c0002167:	8b 45 08             	mov    0x8(%ebp),%eax
c000216a:	0f b6 00             	movzbl (%eax),%eax
c000216d:	84 c0                	test   %al,%al
c000216f:	0f 95 c0             	setne  %al
c0002172:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0002176:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
c000217a:	84 c0                	test   %al,%al
c000217c:	75 de                	jne    c000215c <strcpy+0x3c>
c000217e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002181:	c9                   	leave  
c0002182:	c3                   	ret    

c0002183 <strlen>:
c0002183:	55                   	push   %ebp
c0002184:	89 e5                	mov    %esp,%ebp
c0002186:	83 ec 28             	sub    $0x28,%esp
c0002189:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c000218d:	75 24                	jne    c00021b3 <strlen+0x30>
c000218f:	c7 44 24 0c d8 43 00 	movl   $0xc00043d8,0xc(%esp)
c0002196:	c0 
c0002197:	c7 44 24 08 d9 46 00 	movl   $0xc00046d9,0x8(%esp)
c000219e:	c0 
c000219f:	c7 44 24 04 3b 00 00 	movl   $0x3b,0x4(%esp)
c00021a6:	00 
c00021a7:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c00021ae:	e8 1f fd ff ff       	call   c0001ed2 <panic_spin>
c00021b3:	8b 45 08             	mov    0x8(%ebp),%eax
c00021b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00021b9:	8b 45 08             	mov    0x8(%ebp),%eax
c00021bc:	0f b6 00             	movzbl (%eax),%eax
c00021bf:	84 c0                	test   %al,%al
c00021c1:	0f 95 c0             	setne  %al
c00021c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c00021c8:	84 c0                	test   %al,%al
c00021ca:	75 ed                	jne    c00021b9 <strlen+0x36>
c00021cc:	8b 55 08             	mov    0x8(%ebp),%edx
c00021cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00021d2:	89 d1                	mov    %edx,%ecx
c00021d4:	29 c1                	sub    %eax,%ecx
c00021d6:	89 c8                	mov    %ecx,%eax
c00021d8:	83 e8 01             	sub    $0x1,%eax
c00021db:	c9                   	leave  
c00021dc:	c3                   	ret    

c00021dd <strcmp>:
c00021dd:	55                   	push   %ebp
c00021de:	89 e5                	mov    %esp,%ebp
c00021e0:	83 ec 18             	sub    $0x18,%esp
c00021e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c00021e7:	74 09                	je     c00021f2 <strcmp+0x15>
c00021e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c00021ed:	74 03                	je     c00021f2 <strcmp+0x15>
c00021ef:	90                   	nop
c00021f0:	eb 2e                	jmp    c0002220 <strcmp+0x43>
c00021f2:	c7 44 24 0c e4 43 00 	movl   $0xc00043e4,0xc(%esp)
c00021f9:	c0 
c00021fa:	c7 44 24 08 d2 46 00 	movl   $0xc00046d2,0x8(%esp)
c0002201:	c0 
c0002202:	c7 44 24 04 43 00 00 	movl   $0x43,0x4(%esp)
c0002209:	00 
c000220a:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c0002211:	e8 bc fc ff ff       	call   c0001ed2 <panic_spin>
c0002216:	eb 08                	jmp    c0002220 <strcmp+0x43>
c0002218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c000221c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
c0002220:	8b 45 08             	mov    0x8(%ebp),%eax
c0002223:	0f b6 00             	movzbl (%eax),%eax
c0002226:	84 c0                	test   %al,%al
c0002228:	74 10                	je     c000223a <strcmp+0x5d>
c000222a:	8b 45 08             	mov    0x8(%ebp),%eax
c000222d:	0f b6 10             	movzbl (%eax),%edx
c0002230:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002233:	0f b6 00             	movzbl (%eax),%eax
c0002236:	38 c2                	cmp    %al,%dl
c0002238:	74 de                	je     c0002218 <strcmp+0x3b>
c000223a:	8b 45 08             	mov    0x8(%ebp),%eax
c000223d:	0f b6 10             	movzbl (%eax),%edx
c0002240:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002243:	0f b6 00             	movzbl (%eax),%eax
c0002246:	38 c2                	cmp    %al,%dl
c0002248:	7d 07                	jge    c0002251 <strcmp+0x74>
c000224a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c000224f:	eb 05                	jmp    c0002256 <strcmp+0x79>
c0002251:	b8 00 00 00 00       	mov    $0x0,%eax
c0002256:	c9                   	leave  
c0002257:	c3                   	ret    

c0002258 <strchr>:
c0002258:	55                   	push   %ebp
c0002259:	89 e5                	mov    %esp,%ebp
c000225b:	83 ec 28             	sub    $0x28,%esp
c000225e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002261:	88 45 f4             	mov    %al,-0xc(%ebp)
c0002264:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0002268:	75 3c                	jne    c00022a6 <strchr+0x4e>
c000226a:	c7 44 24 0c d8 43 00 	movl   $0xc00043d8,0xc(%esp)
c0002271:	c0 
c0002272:	c7 44 24 08 cb 46 00 	movl   $0xc00046cb,0x8(%esp)
c0002279:	c0 
c000227a:	c7 44 24 04 4e 00 00 	movl   $0x4e,0x4(%esp)
c0002281:	00 
c0002282:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c0002289:	e8 44 fc ff ff       	call   c0001ed2 <panic_spin>
c000228e:	eb 17                	jmp    c00022a7 <strchr+0x4f>
c0002290:	8b 45 08             	mov    0x8(%ebp),%eax
c0002293:	0f b6 00             	movzbl (%eax),%eax
c0002296:	0f be d0             	movsbl %al,%edx
c0002299:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
c000229d:	39 c2                	cmp    %eax,%edx
c000229f:	75 06                	jne    c00022a7 <strchr+0x4f>
c00022a1:	8b 45 08             	mov    0x8(%ebp),%eax
c00022a4:	eb 10                	jmp    c00022b6 <strchr+0x5e>
c00022a6:	90                   	nop
c00022a7:	8b 45 08             	mov    0x8(%ebp),%eax
c00022aa:	0f b6 00             	movzbl (%eax),%eax
c00022ad:	84 c0                	test   %al,%al
c00022af:	75 df                	jne    c0002290 <strchr+0x38>
c00022b1:	b8 00 00 00 00       	mov    $0x0,%eax
c00022b6:	c9                   	leave  
c00022b7:	c3                   	ret    

c00022b8 <strrchr>:
c00022b8:	55                   	push   %ebp
c00022b9:	89 e5                	mov    %esp,%ebp
c00022bb:	83 ec 38             	sub    $0x38,%esp
c00022be:	8b 45 0c             	mov    0xc(%ebp),%eax
c00022c1:	88 45 e4             	mov    %al,-0x1c(%ebp)
c00022c4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c00022c8:	75 24                	jne    c00022ee <strrchr+0x36>
c00022ca:	c7 44 24 0c d8 43 00 	movl   $0xc00043d8,0xc(%esp)
c00022d1:	c0 
c00022d2:	c7 44 24 08 c3 46 00 	movl   $0xc00046c3,0x8(%esp)
c00022d9:	c0 
c00022da:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
c00022e1:	00 
c00022e2:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c00022e9:	e8 e4 fb ff ff       	call   c0001ed2 <panic_spin>
c00022ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c00022f5:	eb 17                	jmp    c000230e <strrchr+0x56>
c00022f7:	8b 45 08             	mov    0x8(%ebp),%eax
c00022fa:	0f b6 00             	movzbl (%eax),%eax
c00022fd:	0f be d0             	movsbl %al,%edx
c0002300:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
c0002304:	39 c2                	cmp    %eax,%edx
c0002306:	75 06                	jne    c000230e <strrchr+0x56>
c0002308:	8b 45 08             	mov    0x8(%ebp),%eax
c000230b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c000230e:	8b 45 08             	mov    0x8(%ebp),%eax
c0002311:	0f b6 00             	movzbl (%eax),%eax
c0002314:	84 c0                	test   %al,%al
c0002316:	75 df                	jne    c00022f7 <strrchr+0x3f>
c0002318:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000231b:	c9                   	leave  
c000231c:	c3                   	ret    

c000231d <strcat>:
c000231d:	55                   	push   %ebp
c000231e:	89 e5                	mov    %esp,%ebp
c0002320:	83 ec 28             	sub    $0x28,%esp
c0002323:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0002327:	74 06                	je     c000232f <strcat+0x12>
c0002329:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c000232d:	75 24                	jne    c0002353 <strcat+0x36>
c000232f:	c7 44 24 0c bd 43 00 	movl   $0xc00043bd,0xc(%esp)
c0002336:	c0 
c0002337:	c7 44 24 08 bc 46 00 	movl   $0xc00046bc,0x8(%esp)
c000233e:	c0 
c000233f:	c7 44 24 04 67 00 00 	movl   $0x67,0x4(%esp)
c0002346:	00 
c0002347:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c000234e:	e8 7f fb ff ff       	call   c0001ed2 <panic_spin>
c0002353:	8b 45 08             	mov    0x8(%ebp),%eax
c0002356:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002359:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c000235d:	0f 95 c0             	setne  %al
c0002360:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0002364:	84 c0                	test   %al,%al
c0002366:	75 f1                	jne    c0002359 <strcat+0x3c>
c0002368:	83 6d 08 01          	subl   $0x1,0x8(%ebp)
c000236c:	8b 45 08             	mov    0x8(%ebp),%eax
c000236f:	0f b6 10             	movzbl (%eax),%edx
c0002372:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002375:	0f b6 00             	movzbl (%eax),%eax
c0002378:	38 c2                	cmp    %al,%dl
c000237a:	0f 95 c0             	setne  %al
c000237d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0002381:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
c0002385:	84 c0                	test   %al,%al
c0002387:	75 e3                	jne    c000236c <strcat+0x4f>
c0002389:	8b 45 08             	mov    0x8(%ebp),%eax
c000238c:	c9                   	leave  
c000238d:	c3                   	ret    

c000238e <strchrs>:
c000238e:	55                   	push   %ebp
c000238f:	89 e5                	mov    %esp,%ebp
c0002391:	83 ec 38             	sub    $0x38,%esp
c0002394:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002397:	88 45 e4             	mov    %al,-0x1c(%ebp)
c000239a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c000239e:	75 24                	jne    c00023c4 <strchrs+0x36>
c00023a0:	c7 44 24 0c d8 43 00 	movl   $0xc00043d8,0xc(%esp)
c00023a7:	c0 
c00023a8:	c7 44 24 08 b4 46 00 	movl   $0xc00046b4,0x8(%esp)
c00023af:	c0 
c00023b0:	c7 44 24 04 73 00 00 	movl   $0x73,0x4(%esp)
c00023b7:	00 
c00023b8:	c7 04 24 90 43 00 c0 	movl   $0xc0004390,(%esp)
c00023bf:	e8 0e fb ff ff       	call   c0001ed2 <panic_spin>
c00023c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c00023cb:	eb 19                	jmp    c00023e6 <strchrs+0x58>
c00023cd:	8b 45 08             	mov    0x8(%ebp),%eax
c00023d0:	0f b6 00             	movzbl (%eax),%eax
c00023d3:	0f be d0             	movsbl %al,%edx
c00023d6:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
c00023da:	39 c2                	cmp    %eax,%edx
c00023dc:	75 04                	jne    c00023e2 <strchrs+0x54>
c00023de:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c00023e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c00023e6:	8b 45 08             	mov    0x8(%ebp),%eax
c00023e9:	0f b6 00             	movzbl (%eax),%eax
c00023ec:	84 c0                	test   %al,%al
c00023ee:	75 dd                	jne    c00023cd <strchrs+0x3f>
c00023f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00023f3:	c9                   	leave  
c00023f4:	c3                   	ret    

c00023f5 <init_bitmap>:
c00023f5:	55                   	push   %ebp
c00023f6:	89 e5                	mov    %esp,%ebp
c00023f8:	83 ec 18             	sub    $0x18,%esp
c00023fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c00023ff:	75 24                	jne    c0002425 <init_bitmap+0x30>
c0002401:	c7 44 24 0c fb 43 00 	movl   $0xc00043fb,0xc(%esp)
c0002408:	c0 
c0002409:	c7 44 24 08 a8 46 00 	movl   $0xc00046a8,0x8(%esp)
c0002410:	c0 
c0002411:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
c0002418:	00 
c0002419:	c7 04 24 09 44 00 c0 	movl   $0xc0004409,(%esp)
c0002420:	e8 ad fa ff ff       	call   c0001ed2 <panic_spin>
c0002425:	8b 45 08             	mov    0x8(%ebp),%eax
c0002428:	8b 10                	mov    (%eax),%edx
c000242a:	8b 45 08             	mov    0x8(%ebp),%eax
c000242d:	8b 40 04             	mov    0x4(%eax),%eax
c0002430:	89 54 24 08          	mov    %edx,0x8(%esp)
c0002434:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c000243b:	00 
c000243c:	89 04 24             	mov    %eax,(%esp)
c000243f:	e8 33 fb ff ff       	call   c0001f77 <memset>
c0002444:	c9                   	leave  
c0002445:	c3                   	ret    

c0002446 <bitmap_scan_test>:
c0002446:	55                   	push   %ebp
c0002447:	89 e5                	mov    %esp,%ebp
c0002449:	56                   	push   %esi
c000244a:	53                   	push   %ebx
c000244b:	83 ec 10             	sub    $0x10,%esp
c000244e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002451:	c1 e8 03             	shr    $0x3,%eax
c0002454:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002457:	8b 45 0c             	mov    0xc(%ebp),%eax
c000245a:	83 e0 07             	and    $0x7,%eax
c000245d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0002460:	8b 45 08             	mov    0x8(%ebp),%eax
c0002463:	8b 40 04             	mov    0x4(%eax),%eax
c0002466:	03 45 f4             	add    -0xc(%ebp),%eax
c0002469:	0f b6 00             	movzbl (%eax),%eax
c000246c:	0f b6 d0             	movzbl %al,%edx
c000246f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002472:	bb 01 00 00 00       	mov    $0x1,%ebx
c0002477:	89 de                	mov    %ebx,%esi
c0002479:	89 c1                	mov    %eax,%ecx
c000247b:	d3 e6                	shl    %cl,%esi
c000247d:	89 f0                	mov    %esi,%eax
c000247f:	21 d0                	and    %edx,%eax
c0002481:	83 c4 10             	add    $0x10,%esp
c0002484:	5b                   	pop    %ebx
c0002485:	5e                   	pop    %esi
c0002486:	5d                   	pop    %ebp
c0002487:	c3                   	ret    

c0002488 <bitmap_scan>:
c0002488:	55                   	push   %ebp
c0002489:	89 e5                	mov    %esp,%ebp
c000248b:	53                   	push   %ebx
c000248c:	83 ec 34             	sub    $0x34,%esp
c000248f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0002496:	eb 04                	jmp    c000249c <bitmap_scan+0x14>
c0002498:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c000249c:	8b 45 08             	mov    0x8(%ebp),%eax
c000249f:	8b 40 04             	mov    0x4(%eax),%eax
c00024a2:	03 45 f4             	add    -0xc(%ebp),%eax
c00024a5:	0f b6 00             	movzbl (%eax),%eax
c00024a8:	3c ff                	cmp    $0xff,%al
c00024aa:	75 0a                	jne    c00024b6 <bitmap_scan+0x2e>
c00024ac:	8b 45 08             	mov    0x8(%ebp),%eax
c00024af:	8b 00                	mov    (%eax),%eax
c00024b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c00024b4:	77 e2                	ja     c0002498 <bitmap_scan+0x10>
c00024b6:	8b 45 08             	mov    0x8(%ebp),%eax
c00024b9:	8b 00                	mov    (%eax),%eax
c00024bb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c00024be:	77 24                	ja     c00024e4 <bitmap_scan+0x5c>
c00024c0:	c7 44 24 0c 14 44 00 	movl   $0xc0004414,0xc(%esp)
c00024c7:	c0 
c00024c8:	c7 44 24 08 9c 46 00 	movl   $0xc000469c,0x8(%esp)
c00024cf:	c0 
c00024d0:	c7 44 24 04 1c 00 00 	movl   $0x1c,0x4(%esp)
c00024d7:	00 
c00024d8:	c7 04 24 09 44 00 c0 	movl   $0xc0004409,(%esp)
c00024df:	e8 ee f9 ff ff       	call   c0001ed2 <panic_spin>
c00024e4:	8b 45 08             	mov    0x8(%ebp),%eax
c00024e7:	8b 00                	mov    (%eax),%eax
c00024e9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c00024ec:	75 0a                	jne    c00024f8 <bitmap_scan+0x70>
c00024ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c00024f3:	e9 d8 00 00 00       	jmp    c00025d0 <bitmap_scan+0x148>
c00024f8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c00024ff:	eb 04                	jmp    c0002505 <bitmap_scan+0x7d>
c0002501:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
c0002505:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002508:	ba 01 00 00 00       	mov    $0x1,%edx
c000250d:	89 d3                	mov    %edx,%ebx
c000250f:	89 c1                	mov    %eax,%ecx
c0002511:	d3 e3                	shl    %cl,%ebx
c0002513:	89 d8                	mov    %ebx,%eax
c0002515:	89 c2                	mov    %eax,%edx
c0002517:	8b 45 08             	mov    0x8(%ebp),%eax
c000251a:	8b 40 04             	mov    0x4(%eax),%eax
c000251d:	03 45 f4             	add    -0xc(%ebp),%eax
c0002520:	0f b6 00             	movzbl (%eax),%eax
c0002523:	21 d0                	and    %edx,%eax
c0002525:	84 c0                	test   %al,%al
c0002527:	75 d8                	jne    c0002501 <bitmap_scan+0x79>
c0002529:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000252c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
c0002533:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002536:	8d 04 02             	lea    (%edx,%eax,1),%eax
c0002539:	89 45 ec             	mov    %eax,-0x14(%ebp)
c000253c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c0002540:	75 08                	jne    c000254a <bitmap_scan+0xc2>
c0002542:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0002545:	e9 86 00 00 00       	jmp    c00025d0 <bitmap_scan+0x148>
c000254a:	8b 45 08             	mov    0x8(%ebp),%eax
c000254d:	8b 00                	mov    (%eax),%eax
c000254f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
c0002556:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0002559:	89 d1                	mov    %edx,%ecx
c000255b:	29 c1                	sub    %eax,%ecx
c000255d:	89 c8                	mov    %ecx,%eax
c000255f:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0002562:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0002565:	83 c0 01             	add    $0x1,%eax
c0002568:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c000256b:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
c0002572:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebp)
c0002579:	eb 43                	jmp    c00025be <bitmap_scan+0x136>
c000257b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c000257e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002582:	8b 45 08             	mov    0x8(%ebp),%eax
c0002585:	89 04 24             	mov    %eax,(%esp)
c0002588:	e8 b9 fe ff ff       	call   c0002446 <bitmap_scan_test>
c000258d:	85 c0                	test   %eax,%eax
c000258f:	75 06                	jne    c0002597 <bitmap_scan+0x10f>
c0002591:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
c0002595:	eb 07                	jmp    c000259e <bitmap_scan+0x116>
c0002597:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c000259e:	8b 45 e0             	mov    -0x20(%ebp),%eax
c00025a1:	3b 45 0c             	cmp    0xc(%ebp),%eax
c00025a4:	75 14                	jne    c00025ba <bitmap_scan+0x132>
c00025a6:	8b 45 0c             	mov    0xc(%ebp),%eax
c00025a9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c00025ac:	89 d3                	mov    %edx,%ebx
c00025ae:	29 c3                	sub    %eax,%ebx
c00025b0:	89 d8                	mov    %ebx,%eax
c00025b2:	83 c0 01             	add    $0x1,%eax
c00025b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
c00025b8:	eb 13                	jmp    c00025cd <bitmap_scan+0x145>
c00025ba:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
c00025be:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c00025c2:	0f 95 c0             	setne  %al
c00025c5:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c00025c9:	84 c0                	test   %al,%al
c00025cb:	75 ae                	jne    c000257b <bitmap_scan+0xf3>
c00025cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00025d0:	83 c4 34             	add    $0x34,%esp
c00025d3:	5b                   	pop    %ebx
c00025d4:	5d                   	pop    %ebp
c00025d5:	c3                   	ret    

c00025d6 <bitmap_set>:
c00025d6:	55                   	push   %ebp
c00025d7:	89 e5                	mov    %esp,%ebp
c00025d9:	57                   	push   %edi
c00025da:	56                   	push   %esi
c00025db:	53                   	push   %ebx
c00025dc:	83 ec 3c             	sub    $0x3c,%esp
c00025df:	8b 45 10             	mov    0x10(%ebp),%eax
c00025e2:	88 45 d4             	mov    %al,-0x2c(%ebp)
c00025e5:	80 7d d4 00          	cmpb   $0x0,-0x2c(%ebp)
c00025e9:	74 30                	je     c000261b <bitmap_set+0x45>
c00025eb:	80 7d d4 01          	cmpb   $0x1,-0x2c(%ebp)
c00025ef:	75 06                	jne    c00025f7 <bitmap_set+0x21>
c00025f1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c00025f5:	75 24                	jne    c000261b <bitmap_set+0x45>
c00025f7:	c7 44 24 0c 38 44 00 	movl   $0xc0004438,0xc(%esp)
c00025fe:	c0 
c00025ff:	c7 44 24 08 91 46 00 	movl   $0xc0004691,0x8(%esp)
c0002606:	c0 
c0002607:	c7 44 24 04 41 00 00 	movl   $0x41,0x4(%esp)
c000260e:	00 
c000260f:	c7 04 24 09 44 00 c0 	movl   $0xc0004409,(%esp)
c0002616:	e8 b7 f8 ff ff       	call   c0001ed2 <panic_spin>
c000261b:	8b 45 0c             	mov    0xc(%ebp),%eax
c000261e:	c1 e8 03             	shr    $0x3,%eax
c0002621:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0002624:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002627:	83 e0 07             	and    $0x7,%eax
c000262a:	89 45 e0             	mov    %eax,-0x20(%ebp)
c000262d:	80 7d d4 00          	cmpb   $0x0,-0x2c(%ebp)
c0002631:	74 2d                	je     c0002660 <bitmap_set+0x8a>
c0002633:	8b 45 08             	mov    0x8(%ebp),%eax
c0002636:	8b 40 04             	mov    0x4(%eax),%eax
c0002639:	03 45 e4             	add    -0x1c(%ebp),%eax
c000263c:	8b 55 08             	mov    0x8(%ebp),%edx
c000263f:	8b 52 04             	mov    0x4(%edx),%edx
c0002642:	03 55 e4             	add    -0x1c(%ebp),%edx
c0002645:	0f b6 12             	movzbl (%edx),%edx
c0002648:	89 d3                	mov    %edx,%ebx
c000264a:	8b 55 e0             	mov    -0x20(%ebp),%edx
c000264d:	be 01 00 00 00       	mov    $0x1,%esi
c0002652:	89 f7                	mov    %esi,%edi
c0002654:	89 d1                	mov    %edx,%ecx
c0002656:	d3 e7                	shl    %cl,%edi
c0002658:	89 fa                	mov    %edi,%edx
c000265a:	09 da                	or     %ebx,%edx
c000265c:	88 10                	mov    %dl,(%eax)
c000265e:	eb 2d                	jmp    c000268d <bitmap_set+0xb7>
c0002660:	8b 45 08             	mov    0x8(%ebp),%eax
c0002663:	8b 40 04             	mov    0x4(%eax),%eax
c0002666:	03 45 e4             	add    -0x1c(%ebp),%eax
c0002669:	8b 55 08             	mov    0x8(%ebp),%edx
c000266c:	8b 52 04             	mov    0x4(%edx),%edx
c000266f:	03 55 e4             	add    -0x1c(%ebp),%edx
c0002672:	0f b6 12             	movzbl (%edx),%edx
c0002675:	89 d3                	mov    %edx,%ebx
c0002677:	8b 55 e0             	mov    -0x20(%ebp),%edx
c000267a:	be 01 00 00 00       	mov    $0x1,%esi
c000267f:	89 f7                	mov    %esi,%edi
c0002681:	89 d1                	mov    %edx,%ecx
c0002683:	d3 e7                	shl    %cl,%edi
c0002685:	89 fa                	mov    %edi,%edx
c0002687:	f7 d2                	not    %edx
c0002689:	21 da                	and    %ebx,%edx
c000268b:	88 10                	mov    %dl,(%eax)
c000268d:	83 c4 3c             	add    $0x3c,%esp
c0002690:	5b                   	pop    %ebx
c0002691:	5e                   	pop    %esi
c0002692:	5f                   	pop    %edi
c0002693:	5d                   	pop    %ebp
c0002694:	c3                   	ret    

c0002695 <init_memory_pool>:
c0002695:	55                   	push   %ebp
c0002696:	89 e5                	mov    %esp,%ebp
c0002698:	83 ec 48             	sub    $0x48,%esp
c000269b:	c7 04 24 66 44 00 c0 	movl   $0xc0004466,(%esp)
c00026a2:	e8 19 ef ff ff       	call   c00015c0 <print_str>
c00026a7:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
c00026ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00026b1:	05 00 00 10 00       	add    $0x100000,%eax
c00026b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
c00026b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
c00026bc:	8b 55 08             	mov    0x8(%ebp),%edx
c00026bf:	89 d1                	mov    %edx,%ecx
c00026c1:	29 c1                	sub    %eax,%ecx
c00026c3:	89 c8                	mov    %ecx,%eax
c00026c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c00026c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c00026cb:	c1 e8 0c             	shr    $0xc,%eax
c00026ce:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
c00026d2:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c00026d6:	66 d1 e8             	shr    %ax
c00026d9:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
c00026dd:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c00026e1:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c00026e5:	89 d1                	mov    %edx,%ecx
c00026e7:	66 29 c1             	sub    %ax,%cx
c00026ea:	89 c8                	mov    %ecx,%eax
c00026ec:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
c00026f0:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c00026f4:	66 c1 e8 03          	shr    $0x3,%ax
c00026f8:	0f b7 c0             	movzwl %ax,%eax
c00026fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
c00026fe:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0002702:	66 c1 e8 03          	shr    $0x3,%ax
c0002706:	0f b7 c0             	movzwl %ax,%eax
c0002709:	89 45 dc             	mov    %eax,-0x24(%ebp)
c000270c:	8b 45 e8             	mov    -0x18(%ebp),%eax
c000270f:	89 45 d8             	mov    %eax,-0x28(%ebp)
c0002712:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c0002716:	c1 e0 0c             	shl    $0xc,%eax
c0002719:	03 45 d8             	add    -0x28(%ebp),%eax
c000271c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c000271f:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0002722:	a3 6c 5a 00 c0       	mov    %eax,0xc0005a6c
c0002727:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c000272a:	a3 08 58 00 c0       	mov    %eax,0xc0005808
c000272f:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c0002733:	c1 e0 0c             	shl    $0xc,%eax
c0002736:	a3 70 5a 00 c0       	mov    %eax,0xc0005a70
c000273b:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c000273f:	c1 e0 0c             	shl    $0xc,%eax
c0002742:	a3 0c 58 00 c0       	mov    %eax,0xc000580c
c0002747:	c7 05 68 5a 00 c0 00 	movl   $0xc009a000,0xc0005a68
c000274e:	a0 09 c0 
c0002751:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0002754:	2d 00 60 f6 3f       	sub    $0x3ff66000,%eax
c0002759:	a3 04 58 00 c0       	mov    %eax,0xc0005804
c000275e:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0002761:	a3 64 5a 00 c0       	mov    %eax,0xc0005a64
c0002766:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0002769:	a3 00 58 00 c0       	mov    %eax,0xc0005800
c000276e:	c7 04 24 78 44 00 c0 	movl   $0xc0004478,(%esp)
c0002775:	e8 46 ee ff ff       	call   c00015c0 <print_str>
c000277a:	a1 68 5a 00 c0       	mov    0xc0005a68,%eax
c000277f:	89 04 24             	mov    %eax,(%esp)
c0002782:	e8 a9 ee ff ff       	call   c0001630 <print_num>
c0002787:	c7 04 24 98 44 00 c0 	movl   $0xc0004498,(%esp)
c000278e:	e8 2d ee ff ff       	call   c00015c0 <print_str>
c0002793:	a1 04 58 00 c0       	mov    0xc0005804,%eax
c0002798:	89 04 24             	mov    %eax,(%esp)
c000279b:	e8 90 ee ff ff       	call   c0001630 <print_num>
c00027a0:	c7 04 24 b6 44 00 c0 	movl   $0xc00044b6,(%esp)
c00027a7:	e8 14 ee ff ff       	call   c00015c0 <print_str>
c00027ac:	a1 6c 5a 00 c0       	mov    0xc0005a6c,%eax
c00027b1:	89 04 24             	mov    %eax,(%esp)
c00027b4:	e8 77 ee ff ff       	call   c0001630 <print_num>
c00027b9:	c7 04 24 cd 44 00 c0 	movl   $0xc00044cd,(%esp)
c00027c0:	e8 fb ed ff ff       	call   c00015c0 <print_str>
c00027c5:	a1 08 58 00 c0       	mov    0xc0005808,%eax
c00027ca:	89 04 24             	mov    %eax,(%esp)
c00027cd:	e8 5e ee ff ff       	call   c0001630 <print_num>
c00027d2:	c7 04 24 64 5a 00 c0 	movl   $0xc0005a64,(%esp)
c00027d9:	e8 17 fc ff ff       	call   c00023f5 <init_bitmap>
c00027de:	c7 04 24 00 58 00 c0 	movl   $0xc0005800,(%esp)
c00027e5:	e8 0b fc ff ff       	call   c00023f5 <init_bitmap>
c00027ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
c00027ed:	a3 cc 59 00 c0       	mov    %eax,0xc00059cc
c00027f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
c00027f5:	8b 55 e0             	mov    -0x20(%ebp),%edx
c00027f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
c00027fb:	2d 00 60 f6 3f       	sub    $0x3ff66000,%eax
c0002800:	a3 d0 59 00 c0       	mov    %eax,0xc00059d0
c0002805:	c7 05 d4 59 00 c0 00 	movl   $0xc0100000,0xc00059d4
c000280c:	00 10 c0 
c000280f:	c7 04 24 cc 59 00 c0 	movl   $0xc00059cc,(%esp)
c0002816:	e8 da fb ff ff       	call   c00023f5 <init_bitmap>
c000281b:	c7 04 24 e2 44 00 c0 	movl   $0xc00044e2,(%esp)
c0002822:	e8 99 ed ff ff       	call   c00015c0 <print_str>
c0002827:	c9                   	leave  
c0002828:	c3                   	ret    

c0002829 <init_memory>:
c0002829:	55                   	push   %ebp
c000282a:	89 e5                	mov    %esp,%ebp
c000282c:	83 ec 28             	sub    $0x28,%esp
c000282f:	b8 16 0c 00 00       	mov    $0xc16,%eax
c0002834:	8b 00                	mov    (%eax),%eax
c0002836:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002839:	c7 04 24 f7 44 00 c0 	movl   $0xc00044f7,(%esp)
c0002840:	e8 7b ed ff ff       	call   c00015c0 <print_str>
c0002845:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002848:	89 04 24             	mov    %eax,(%esp)
c000284b:	e8 e0 ed ff ff       	call   c0001630 <print_num>
c0002850:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0002857:	e8 64 ed ff ff       	call   c00015c0 <print_str>
c000285c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000285f:	89 04 24             	mov    %eax,(%esp)
c0002862:	e8 2e fe ff ff       	call   c0002695 <init_memory_pool>
c0002867:	c7 04 24 0b 45 00 c0 	movl   $0xc000450b,(%esp)
c000286e:	e8 4d ed ff ff       	call   c00015c0 <print_str>
c0002873:	c9                   	leave  
c0002874:	c3                   	ret    

c0002875 <vaddr_get>:
c0002875:	55                   	push   %ebp
c0002876:	89 e5                	mov    %esp,%ebp
c0002878:	83 ec 28             	sub    $0x28,%esp
c000287b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0002882:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
c0002889:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0002890:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
c0002894:	75 5f                	jne    c00028f5 <vaddr_get+0x80>
c0002896:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002899:	89 44 24 04          	mov    %eax,0x4(%esp)
c000289d:	c7 04 24 cc 59 00 c0 	movl   $0xc00059cc,(%esp)
c00028a4:	e8 df fb ff ff       	call   c0002488 <bitmap_scan>
c00028a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
c00028ac:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
c00028b0:	75 29                	jne    c00028db <vaddr_get+0x66>
c00028b2:	b8 00 00 00 00       	mov    $0x0,%eax
c00028b7:	eb 3f                	jmp    c00028f8 <vaddr_get+0x83>
c00028b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c00028bc:	03 45 ec             	add    -0x14(%ebp),%eax
c00028bf:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c00028c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
c00028ca:	00 
c00028cb:	89 44 24 04          	mov    %eax,0x4(%esp)
c00028cf:	c7 04 24 cc 59 00 c0 	movl   $0xc00059cc,(%esp)
c00028d6:	e8 fb fc ff ff       	call   c00025d6 <bitmap_set>
c00028db:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00028de:	3b 45 0c             	cmp    0xc(%ebp),%eax
c00028e1:	72 d6                	jb     c00028b9 <vaddr_get+0x44>
c00028e3:	8b 15 d4 59 00 c0    	mov    0xc00059d4,%edx
c00028e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c00028ec:	c1 e0 0c             	shl    $0xc,%eax
c00028ef:	8d 04 02             	lea    (%edx,%eax,1),%eax
c00028f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00028f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00028f8:	c9                   	leave  
c00028f9:	c3                   	ret    

c00028fa <pte_ptr>:
c00028fa:	55                   	push   %ebp
c00028fb:	89 e5                	mov    %esp,%ebp
c00028fd:	83 ec 10             	sub    $0x10,%esp
c0002900:	8b 45 08             	mov    0x8(%ebp),%eax
c0002903:	25 00 00 c0 ff       	and    $0xffc00000,%eax
c0002908:	89 c2                	mov    %eax,%edx
c000290a:	c1 ea 0a             	shr    $0xa,%edx
c000290d:	8b 45 08             	mov    0x8(%ebp),%eax
c0002910:	25 00 f0 3f 00       	and    $0x3ff000,%eax
c0002915:	c1 e8 0c             	shr    $0xc,%eax
c0002918:	c1 e0 02             	shl    $0x2,%eax
c000291b:	8d 04 02             	lea    (%edx,%eax,1),%eax
c000291e:	2d 00 00 40 00       	sub    $0x400000,%eax
c0002923:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0002926:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002929:	c9                   	leave  
c000292a:	c3                   	ret    

c000292b <pde_ptr>:
c000292b:	55                   	push   %ebp
c000292c:	89 e5                	mov    %esp,%ebp
c000292e:	83 ec 10             	sub    $0x10,%esp
c0002931:	8b 45 08             	mov    0x8(%ebp),%eax
c0002934:	c1 e8 16             	shr    $0x16,%eax
c0002937:	05 00 fc ff 3f       	add    $0x3ffffc00,%eax
c000293c:	c1 e0 02             	shl    $0x2,%eax
c000293f:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0002942:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002945:	c9                   	leave  
c0002946:	c3                   	ret    

c0002947 <palloc>:
c0002947:	55                   	push   %ebp
c0002948:	89 e5                	mov    %esp,%ebp
c000294a:	83 ec 28             	sub    $0x28,%esp
c000294d:	8b 45 08             	mov    0x8(%ebp),%eax
c0002950:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0002957:	00 
c0002958:	89 04 24             	mov    %eax,(%esp)
c000295b:	e8 28 fb ff ff       	call   c0002488 <bitmap_scan>
c0002960:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002963:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
c0002967:	75 07                	jne    c0002970 <palloc+0x29>
c0002969:	b8 00 00 00 00       	mov    $0x0,%eax
c000296e:	eb 31                	jmp    c00029a1 <palloc+0x5a>
c0002970:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0002973:	8b 45 08             	mov    0x8(%ebp),%eax
c0002976:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
c000297d:	00 
c000297e:	89 54 24 04          	mov    %edx,0x4(%esp)
c0002982:	89 04 24             	mov    %eax,(%esp)
c0002985:	e8 4c fc ff ff       	call   c00025d6 <bitmap_set>
c000298a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000298d:	c1 e0 0c             	shl    $0xc,%eax
c0002990:	89 c2                	mov    %eax,%edx
c0002992:	8b 45 08             	mov    0x8(%ebp),%eax
c0002995:	8b 40 08             	mov    0x8(%eax),%eax
c0002998:	8d 04 02             	lea    (%edx,%eax,1),%eax
c000299b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c000299e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c00029a1:	c9                   	leave  
c00029a2:	c3                   	ret    

c00029a3 <page_table_add>:
c00029a3:	55                   	push   %ebp
c00029a4:	89 e5                	mov    %esp,%ebp
c00029a6:	83 ec 38             	sub    $0x38,%esp
c00029a9:	8b 45 08             	mov    0x8(%ebp),%eax
c00029ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00029af:	8b 45 0c             	mov    0xc(%ebp),%eax
c00029b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
c00029b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00029b8:	89 04 24             	mov    %eax,(%esp)
c00029bb:	e8 6b ff ff ff       	call   c000292b <pde_ptr>
c00029c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
c00029c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00029c6:	89 04 24             	mov    %eax,(%esp)
c00029c9:	e8 2c ff ff ff       	call   c00028fa <pte_ptr>
c00029ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
c00029d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
c00029d4:	8b 00                	mov    (%eax),%eax
c00029d6:	83 e0 01             	and    $0x1,%eax
c00029d9:	84 c0                	test   %al,%al
c00029db:	0f 84 81 00 00 00    	je     c0002a62 <page_table_add+0xbf>
c00029e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
c00029e4:	8b 00                	mov    (%eax),%eax
c00029e6:	83 e0 01             	and    $0x1,%eax
c00029e9:	85 c0                	test   %eax,%eax
c00029eb:	74 24                	je     c0002a11 <page_table_add+0x6e>
c00029ed:	c7 44 24 0c 1a 45 00 	movl   $0xc000451a,0xc(%esp)
c00029f4:	c0 
c00029f5:	c7 44 24 08 82 46 00 	movl   $0xc0004682,0x8(%esp)
c00029fc:	c0 
c00029fd:	c7 44 24 04 a3 00 00 	movl   $0xa3,0x4(%esp)
c0002a04:	00 
c0002a05:	c7 04 24 2f 45 00 c0 	movl   $0xc000452f,(%esp)
c0002a0c:	e8 c1 f4 ff ff       	call   c0001ed2 <panic_spin>
c0002a11:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002a14:	8b 00                	mov    (%eax),%eax
c0002a16:	83 e0 01             	and    $0x1,%eax
c0002a19:	85 c0                	test   %eax,%eax
c0002a1b:	75 12                	jne    c0002a2f <page_table_add+0x8c>
c0002a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002a20:	89 c2                	mov    %eax,%edx
c0002a22:	83 ca 07             	or     $0x7,%edx
c0002a25:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002a28:	89 10                	mov    %edx,(%eax)
c0002a2a:	e9 ac 00 00 00       	jmp    c0002adb <page_table_add+0x138>
c0002a2f:	c7 44 24 0c 3a 45 00 	movl   $0xc000453a,0xc(%esp)
c0002a36:	c0 
c0002a37:	c7 44 24 08 82 46 00 	movl   $0xc0004682,0x8(%esp)
c0002a3e:	c0 
c0002a3f:	c7 44 24 04 ab 00 00 	movl   $0xab,0x4(%esp)
c0002a46:	00 
c0002a47:	c7 04 24 2f 45 00 c0 	movl   $0xc000452f,(%esp)
c0002a4e:	e8 7f f4 ff ff       	call   c0001ed2 <panic_spin>
c0002a53:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002a56:	89 c2                	mov    %eax,%edx
c0002a58:	83 ca 07             	or     $0x7,%edx
c0002a5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002a5e:	89 10                	mov    %edx,(%eax)
c0002a60:	eb 79                	jmp    c0002adb <page_table_add+0x138>
c0002a62:	c7 04 24 64 5a 00 c0 	movl   $0xc0005a64,(%esp)
c0002a69:	e8 d9 fe ff ff       	call   c0002947 <palloc>
c0002a6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0002a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002a74:	89 c2                	mov    %eax,%edx
c0002a76:	83 ca 07             	or     $0x7,%edx
c0002a79:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0002a7c:	89 10                	mov    %edx,(%eax)
c0002a7e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002a81:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0002a86:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0002a8d:	00 
c0002a8e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0002a95:	00 
c0002a96:	89 04 24             	mov    %eax,(%esp)
c0002a99:	e8 d9 f4 ff ff       	call   c0001f77 <memset>
c0002a9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002aa1:	8b 00                	mov    (%eax),%eax
c0002aa3:	83 e0 01             	and    $0x1,%eax
c0002aa6:	85 c0                	test   %eax,%eax
c0002aa8:	74 24                	je     c0002ace <page_table_add+0x12b>
c0002aaa:	c7 44 24 0c 1a 45 00 	movl   $0xc000451a,0xc(%esp)
c0002ab1:	c0 
c0002ab2:	c7 44 24 08 82 46 00 	movl   $0xc0004682,0x8(%esp)
c0002ab9:	c0 
c0002aba:	c7 44 24 04 b8 00 00 	movl   $0xb8,0x4(%esp)
c0002ac1:	00 
c0002ac2:	c7 04 24 2f 45 00 c0 	movl   $0xc000452f,(%esp)
c0002ac9:	e8 04 f4 ff ff       	call   c0001ed2 <panic_spin>
c0002ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002ad1:	89 c2                	mov    %eax,%edx
c0002ad3:	83 ca 07             	or     $0x7,%edx
c0002ad6:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002ad9:	89 10                	mov    %edx,(%eax)
c0002adb:	c9                   	leave  
c0002adc:	c3                   	ret    

c0002add <malloc_page>:
c0002add:	55                   	push   %ebp
c0002ade:	89 e5                	mov    %esp,%ebp
c0002ae0:	83 ec 38             	sub    $0x38,%esp
c0002ae3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0002ae7:	74 09                	je     c0002af2 <malloc_page+0x15>
c0002ae9:	81 7d 0c ff 0e 00 00 	cmpl   $0xeff,0xc(%ebp)
c0002af0:	76 24                	jbe    c0002b16 <malloc_page+0x39>
c0002af2:	c7 44 24 0c 45 45 00 	movl   $0xc0004545,0xc(%esp)
c0002af9:	c0 
c0002afa:	c7 44 24 08 76 46 00 	movl   $0xc0004676,0x8(%esp)
c0002b01:	c0 
c0002b02:	c7 44 24 04 c1 00 00 	movl   $0xc1,0x4(%esp)
c0002b09:	00 
c0002b0a:	c7 04 24 2f 45 00 c0 	movl   $0xc000452f,(%esp)
c0002b11:	e8 bc f3 ff ff       	call   c0001ed2 <panic_spin>
c0002b16:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002b19:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002b1d:	8b 45 08             	mov    0x8(%ebp),%eax
c0002b20:	89 04 24             	mov    %eax,(%esp)
c0002b23:	e8 4d fd ff ff       	call   c0002875 <vaddr_get>
c0002b28:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002b2b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0002b2f:	75 07                	jne    c0002b38 <malloc_page+0x5b>
c0002b31:	b8 00 00 00 00       	mov    $0x0,%eax
c0002b36:	eb 6d                	jmp    c0002ba5 <malloc_page+0xc8>
c0002b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002b3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0002b3e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002b41:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0002b44:	8b 45 08             	mov    0x8(%ebp),%eax
c0002b47:	83 e0 02             	and    $0x2,%eax
c0002b4a:	85 c0                	test   %eax,%eax
c0002b4c:	74 07                	je     c0002b55 <malloc_page+0x78>
c0002b4e:	b8 00 58 00 c0       	mov    $0xc0005800,%eax
c0002b53:	eb 05                	jmp    c0002b5a <malloc_page+0x7d>
c0002b55:	b8 64 5a 00 c0       	mov    $0xc0005a64,%eax
c0002b5a:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0002b5d:	eb 34                	jmp    c0002b93 <malloc_page+0xb6>
c0002b5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0002b62:	89 04 24             	mov    %eax,(%esp)
c0002b65:	e8 dd fd ff ff       	call   c0002947 <palloc>
c0002b6a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0002b6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0002b71:	75 07                	jne    c0002b7a <malloc_page+0x9d>
c0002b73:	b8 00 00 00 00       	mov    $0x0,%eax
c0002b78:	eb 2b                	jmp    c0002ba5 <malloc_page+0xc8>
c0002b7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002b7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0002b80:	89 54 24 04          	mov    %edx,0x4(%esp)
c0002b84:	89 04 24             	mov    %eax,(%esp)
c0002b87:	e8 17 fe ff ff       	call   c00029a3 <page_table_add>
c0002b8c:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
c0002b93:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0002b97:	0f 95 c0             	setne  %al
c0002b9a:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
c0002b9e:	84 c0                	test   %al,%al
c0002ba0:	75 bd                	jne    c0002b5f <malloc_page+0x82>
c0002ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002ba5:	c9                   	leave  
c0002ba6:	c3                   	ret    

c0002ba7 <get_kernel_pages>:
c0002ba7:	55                   	push   %ebp
c0002ba8:	89 e5                	mov    %esp,%ebp
c0002baa:	83 ec 28             	sub    $0x28,%esp
c0002bad:	8b 45 08             	mov    0x8(%ebp),%eax
c0002bb0:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002bb4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0002bbb:	e8 1d ff ff ff       	call   c0002add <malloc_page>
c0002bc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002bc3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0002bc7:	74 1d                	je     c0002be6 <get_kernel_pages+0x3f>
c0002bc9:	8b 45 08             	mov    0x8(%ebp),%eax
c0002bcc:	c1 e0 0c             	shl    $0xc,%eax
c0002bcf:	89 44 24 08          	mov    %eax,0x8(%esp)
c0002bd3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0002bda:	00 
c0002bdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002bde:	89 04 24             	mov    %eax,(%esp)
c0002be1:	e8 91 f3 ff ff       	call   c0001f77 <memset>
c0002be6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002be9:	c9                   	leave  
c0002bea:	c3                   	ret    

c0002beb <kernel_thread>:
c0002beb:	55                   	push   %ebp
c0002bec:	89 e5                	mov    %esp,%ebp
c0002bee:	83 ec 18             	sub    $0x18,%esp
c0002bf1:	e8 4f f2 ff ff       	call   c0001e45 <intr_enable>
c0002bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002bf9:	89 04 24             	mov    %eax,(%esp)
c0002bfc:	8b 45 08             	mov    0x8(%ebp),%eax
c0002bff:	ff d0                	call   *%eax
c0002c01:	c9                   	leave  
c0002c02:	c3                   	ret    

c0002c03 <thread_create>:
c0002c03:	55                   	push   %ebp
c0002c04:	89 e5                	mov    %esp,%ebp
c0002c06:	83 ec 10             	sub    $0x10,%esp
c0002c09:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c0c:	8b 00                	mov    (%eax),%eax
c0002c0e:	8d 90 d0 fe ff ff    	lea    -0x130(%eax),%edx
c0002c14:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c17:	89 10                	mov    %edx,(%eax)
c0002c19:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c1c:	8b 00                	mov    (%eax),%eax
c0002c1e:	8d 50 80             	lea    -0x80(%eax),%edx
c0002c21:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c24:	89 10                	mov    %edx,(%eax)
c0002c26:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c29:	8b 00                	mov    (%eax),%eax
c0002c2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0002c2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c31:	c7 40 10 eb 2b 00 c0 	movl   $0xc0002beb,0x10(%eax)
c0002c38:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c3b:	8b 55 0c             	mov    0xc(%ebp),%edx
c0002c3e:	89 50 18             	mov    %edx,0x18(%eax)
c0002c41:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c44:	8b 55 10             	mov    0x10(%ebp),%edx
c0002c47:	89 50 1c             	mov    %edx,0x1c(%eax)
c0002c4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c4d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
c0002c54:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c57:	8b 50 08             	mov    0x8(%eax),%edx
c0002c5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c5d:	89 50 0c             	mov    %edx,0xc(%eax)
c0002c60:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c63:	8b 50 0c             	mov    0xc(%eax),%edx
c0002c66:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c69:	89 50 04             	mov    %edx,0x4(%eax)
c0002c6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c6f:	8b 50 04             	mov    0x4(%eax),%edx
c0002c72:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002c75:	89 10                	mov    %edx,(%eax)
c0002c77:	c9                   	leave  
c0002c78:	c3                   	ret    

c0002c79 <init_thread>:
c0002c79:	55                   	push   %ebp
c0002c7a:	89 e5                	mov    %esp,%ebp
c0002c7c:	83 ec 18             	sub    $0x18,%esp
c0002c7f:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
c0002c86:	00 
c0002c87:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0002c8e:	00 
c0002c8f:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c92:	89 04 24             	mov    %eax,(%esp)
c0002c95:	e8 dd f2 ff ff       	call   c0001f77 <memset>
c0002c9a:	8b 45 08             	mov    0x8(%ebp),%eax
c0002c9d:	8d 50 08             	lea    0x8(%eax),%edx
c0002ca0:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002ca3:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002ca7:	89 14 24             	mov    %edx,(%esp)
c0002caa:	e8 71 f4 ff ff       	call   c0002120 <strcpy>
c0002caf:	a1 c8 59 00 c0       	mov    0xc00059c8,%eax
c0002cb4:	39 45 08             	cmp    %eax,0x8(%ebp)
c0002cb7:	75 0c                	jne    c0002cc5 <init_thread+0x4c>
c0002cb9:	8b 45 08             	mov    0x8(%ebp),%eax
c0002cbc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
c0002cc3:	eb 0a                	jmp    c0002ccf <init_thread+0x56>
c0002cc5:	8b 45 08             	mov    0x8(%ebp),%eax
c0002cc8:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
c0002ccf:	8b 45 10             	mov    0x10(%ebp),%eax
c0002cd2:	89 c2                	mov    %eax,%edx
c0002cd4:	8b 45 08             	mov    0x8(%ebp),%eax
c0002cd7:	88 50 18             	mov    %dl,0x18(%eax)
c0002cda:	8b 45 08             	mov    0x8(%ebp),%eax
c0002cdd:	05 00 10 00 00       	add    $0x1000,%eax
c0002ce2:	89 c2                	mov    %eax,%edx
c0002ce4:	8b 45 08             	mov    0x8(%ebp),%eax
c0002ce7:	89 10                	mov    %edx,(%eax)
c0002ce9:	8b 45 08             	mov    0x8(%ebp),%eax
c0002cec:	c7 40 30 16 09 87 19 	movl   $0x19870916,0x30(%eax)
c0002cf3:	8b 45 10             	mov    0x10(%ebp),%eax
c0002cf6:	89 c2                	mov    %eax,%edx
c0002cf8:	8b 45 08             	mov    0x8(%ebp),%eax
c0002cfb:	88 50 19             	mov    %dl,0x19(%eax)
c0002cfe:	c9                   	leave  
c0002cff:	c3                   	ret    

c0002d00 <thread_start>:
c0002d00:	55                   	push   %ebp
c0002d01:	89 e5                	mov    %esp,%ebp
c0002d03:	83 ec 28             	sub    $0x28,%esp
c0002d06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0002d0d:	e8 95 fe ff ff       	call   c0002ba7 <get_kernel_pages>
c0002d12:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002d18:	8b 55 0c             	mov    0xc(%ebp),%edx
c0002d1b:	89 54 24 08          	mov    %edx,0x8(%esp)
c0002d1f:	8b 55 08             	mov    0x8(%ebp),%edx
c0002d22:	89 54 24 04          	mov    %edx,0x4(%esp)
c0002d26:	89 04 24             	mov    %eax,(%esp)
c0002d29:	e8 4b ff ff ff       	call   c0002c79 <init_thread>
c0002d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002d31:	8b 55 14             	mov    0x14(%ebp),%edx
c0002d34:	89 54 24 08          	mov    %edx,0x8(%esp)
c0002d38:	8b 55 10             	mov    0x10(%ebp),%edx
c0002d3b:	89 54 24 04          	mov    %edx,0x4(%esp)
c0002d3f:	89 04 24             	mov    %eax,(%esp)
c0002d42:	e8 bc fe ff ff       	call   c0002c03 <thread_create>
c0002d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002d4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0002d4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002d50:	83 c0 1c             	add    $0x1c,%eax
c0002d53:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002d57:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0002d5e:	e8 36 03 00 00       	call   c0003099 <elem_find>
c0002d63:	84 c0                	test   %al,%al
c0002d65:	74 24                	je     c0002d8b <thread_start+0x8b>
c0002d67:	c7 44 24 0c 64 45 00 	movl   $0xc0004564,0xc(%esp)
c0002d6e:	c0 
c0002d6f:	c7 44 24 08 69 46 00 	movl   $0xc0004669,0x8(%esp)
c0002d76:	c0 
c0002d77:	c7 44 24 04 52 00 00 	movl   $0x52,0x4(%esp)
c0002d7e:	00 
c0002d7f:	c7 04 24 9b 45 00 c0 	movl   $0xc000459b,(%esp)
c0002d86:	e8 47 f1 ff ff       	call   c0001ed2 <panic_spin>
c0002d8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002d8e:	83 c0 1c             	add    $0x1c,%eax
c0002d91:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002d95:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0002d9c:	e8 c4 01 00 00       	call   c0002f65 <list_append>
c0002da1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002da4:	83 c0 24             	add    $0x24,%eax
c0002da7:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002dab:	c7 04 24 f0 57 00 c0 	movl   $0xc00057f0,(%esp)
c0002db2:	e8 e2 02 00 00       	call   c0003099 <elem_find>
c0002db7:	84 c0                	test   %al,%al
c0002db9:	74 24                	je     c0002ddf <thread_start+0xdf>
c0002dbb:	c7 44 24 0c a8 45 00 	movl   $0xc00045a8,0xc(%esp)
c0002dc2:	c0 
c0002dc3:	c7 44 24 08 69 46 00 	movl   $0xc0004669,0x8(%esp)
c0002dca:	c0 
c0002dcb:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
c0002dd2:	00 
c0002dd3:	c7 04 24 9b 45 00 c0 	movl   $0xc000459b,(%esp)
c0002dda:	e8 f3 f0 ff ff       	call   c0001ed2 <panic_spin>
c0002ddf:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002de2:	83 c0 24             	add    $0x24,%eax
c0002de5:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002de9:	c7 04 24 f0 57 00 c0 	movl   $0xc00057f0,(%esp)
c0002df0:	e8 70 01 00 00       	call   c0002f65 <list_append>
c0002df5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002df8:	c9                   	leave  
c0002df9:	c3                   	ret    

c0002dfa <running_thread>:
c0002dfa:	55                   	push   %ebp
c0002dfb:	89 e5                	mov    %esp,%ebp
c0002dfd:	83 ec 10             	sub    $0x10,%esp
c0002e00:	89 65 fc             	mov    %esp,-0x4(%ebp)
c0002e03:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0002e06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0002e0b:	c9                   	leave  
c0002e0c:	c3                   	ret    

c0002e0d <make_main_thread>:
c0002e0d:	55                   	push   %ebp
c0002e0e:	89 e5                	mov    %esp,%ebp
c0002e10:	83 ec 18             	sub    $0x18,%esp
c0002e13:	e8 e2 ff ff ff       	call   c0002dfa <running_thread>
c0002e18:	a3 c8 59 00 c0       	mov    %eax,0xc00059c8
c0002e1d:	a1 c8 59 00 c0       	mov    0xc00059c8,%eax
c0002e22:	c7 44 24 08 1f 00 00 	movl   $0x1f,0x8(%esp)
c0002e29:	00 
c0002e2a:	c7 44 24 04 de 45 00 	movl   $0xc00045de,0x4(%esp)
c0002e31:	c0 
c0002e32:	89 04 24             	mov    %eax,(%esp)
c0002e35:	e8 3f fe ff ff       	call   c0002c79 <init_thread>
c0002e3a:	a1 c8 59 00 c0       	mov    0xc00059c8,%eax
c0002e3f:	83 c0 24             	add    $0x24,%eax
c0002e42:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002e46:	c7 04 24 f0 57 00 c0 	movl   $0xc00057f0,(%esp)
c0002e4d:	e8 47 02 00 00       	call   c0003099 <elem_find>
c0002e52:	84 c0                	test   %al,%al
c0002e54:	74 24                	je     c0002e7a <make_main_thread+0x6d>
c0002e56:	c7 44 24 0c ec 45 00 	movl   $0xc00045ec,0xc(%esp)
c0002e5d:	c0 
c0002e5e:	c7 44 24 08 58 46 00 	movl   $0xc0004658,0x8(%esp)
c0002e65:	c0 
c0002e66:	c7 44 24 04 76 00 00 	movl   $0x76,0x4(%esp)
c0002e6d:	00 
c0002e6e:	c7 04 24 9b 45 00 c0 	movl   $0xc000459b,(%esp)
c0002e75:	e8 58 f0 ff ff       	call   c0001ed2 <panic_spin>
c0002e7a:	a1 c8 59 00 c0       	mov    0xc00059c8,%eax
c0002e7f:	83 c0 24             	add    $0x24,%eax
c0002e82:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002e86:	c7 04 24 f0 57 00 c0 	movl   $0xc00057f0,(%esp)
c0002e8d:	e8 d3 00 00 00       	call   c0002f65 <list_append>
c0002e92:	c9                   	leave  
c0002e93:	c3                   	ret    

c0002e94 <thread_init>:
c0002e94:	55                   	push   %ebp
c0002e95:	89 e5                	mov    %esp,%ebp
c0002e97:	83 ec 18             	sub    $0x18,%esp
c0002e9a:	c7 04 24 27 46 00 c0 	movl   $0xc0004627,(%esp)
c0002ea1:	e8 1a e7 ff ff       	call   c00015c0 <print_str>
c0002ea6:	c7 04 24 e0 57 00 c0 	movl   $0xc00057e0,(%esp)
c0002ead:	e8 1f 00 00 00       	call   c0002ed1 <list_init>
c0002eb2:	c7 04 24 f0 57 00 c0 	movl   $0xc00057f0,(%esp)
c0002eb9:	e8 13 00 00 00       	call   c0002ed1 <list_init>
c0002ebe:	e8 4a ff ff ff       	call   c0002e0d <make_main_thread>
c0002ec3:	c7 04 24 3a 46 00 c0 	movl   $0xc000463a,(%esp)
c0002eca:	e8 f1 e6 ff ff       	call   c00015c0 <print_str>
c0002ecf:	c9                   	leave  
c0002ed0:	c3                   	ret    

c0002ed1 <list_init>:
c0002ed1:	55                   	push   %ebp
c0002ed2:	89 e5                	mov    %esp,%ebp
c0002ed4:	8b 45 08             	mov    0x8(%ebp),%eax
c0002ed7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
c0002edd:	8b 45 08             	mov    0x8(%ebp),%eax
c0002ee0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
c0002ee7:	8b 45 08             	mov    0x8(%ebp),%eax
c0002eea:	8d 50 08             	lea    0x8(%eax),%edx
c0002eed:	8b 45 08             	mov    0x8(%ebp),%eax
c0002ef0:	89 50 04             	mov    %edx,0x4(%eax)
c0002ef3:	8b 55 08             	mov    0x8(%ebp),%edx
c0002ef6:	8b 45 08             	mov    0x8(%ebp),%eax
c0002ef9:	89 50 08             	mov    %edx,0x8(%eax)
c0002efc:	5d                   	pop    %ebp
c0002efd:	c3                   	ret    

c0002efe <list_insert_before>:
c0002efe:	55                   	push   %ebp
c0002eff:	89 e5                	mov    %esp,%ebp
c0002f01:	83 ec 28             	sub    $0x28,%esp
c0002f04:	e8 64 ef ff ff       	call   c0001e6d <intr_disable>
c0002f09:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002f0c:	8b 45 08             	mov    0x8(%ebp),%eax
c0002f0f:	8b 00                	mov    (%eax),%eax
c0002f11:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0002f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0002f17:	8b 55 0c             	mov    0xc(%ebp),%edx
c0002f1a:	89 50 04             	mov    %edx,0x4(%eax)
c0002f1d:	8b 45 08             	mov    0x8(%ebp),%eax
c0002f20:	8b 55 0c             	mov    0xc(%ebp),%edx
c0002f23:	89 10                	mov    %edx,(%eax)
c0002f25:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002f28:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0002f2b:	89 10                	mov    %edx,(%eax)
c0002f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002f30:	8b 55 08             	mov    0x8(%ebp),%edx
c0002f33:	89 50 04             	mov    %edx,0x4(%eax)
c0002f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002f39:	89 04 24             	mov    %eax,(%esp)
c0002f3c:	e8 54 ef ff ff       	call   c0001e95 <intr_set_status>
c0002f41:	c9                   	leave  
c0002f42:	c3                   	ret    

c0002f43 <list_push>:
c0002f43:	55                   	push   %ebp
c0002f44:	89 e5                	mov    %esp,%ebp
c0002f46:	83 ec 18             	sub    $0x18,%esp
c0002f49:	8b 45 08             	mov    0x8(%ebp),%eax
c0002f4c:	8b 40 04             	mov    0x4(%eax),%eax
c0002f4f:	8b 55 0c             	mov    0xc(%ebp),%edx
c0002f52:	89 54 24 04          	mov    %edx,0x4(%esp)
c0002f56:	89 04 24             	mov    %eax,(%esp)
c0002f59:	e8 a0 ff ff ff       	call   c0002efe <list_insert_before>
c0002f5e:	c9                   	leave  
c0002f5f:	c3                   	ret    

c0002f60 <list_iterate>:
c0002f60:	55                   	push   %ebp
c0002f61:	89 e5                	mov    %esp,%ebp
c0002f63:	5d                   	pop    %ebp
c0002f64:	c3                   	ret    

c0002f65 <list_append>:
c0002f65:	55                   	push   %ebp
c0002f66:	89 e5                	mov    %esp,%ebp
c0002f68:	83 ec 18             	sub    $0x18,%esp
c0002f6b:	8b 45 08             	mov    0x8(%ebp),%eax
c0002f6e:	8d 50 08             	lea    0x8(%eax),%edx
c0002f71:	8b 45 0c             	mov    0xc(%ebp),%eax
c0002f74:	89 44 24 04          	mov    %eax,0x4(%esp)
c0002f78:	89 14 24             	mov    %edx,(%esp)
c0002f7b:	e8 7e ff ff ff       	call   c0002efe <list_insert_before>
c0002f80:	c9                   	leave  
c0002f81:	c3                   	ret    

c0002f82 <list_remove>:
c0002f82:	55                   	push   %ebp
c0002f83:	89 e5                	mov    %esp,%ebp
c0002f85:	83 ec 28             	sub    $0x28,%esp
c0002f88:	e8 e0 ee ff ff       	call   c0001e6d <intr_disable>
c0002f8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002f90:	8b 45 08             	mov    0x8(%ebp),%eax
c0002f93:	8b 00                	mov    (%eax),%eax
c0002f95:	8b 55 08             	mov    0x8(%ebp),%edx
c0002f98:	8b 52 04             	mov    0x4(%edx),%edx
c0002f9b:	89 50 04             	mov    %edx,0x4(%eax)
c0002f9e:	8b 45 08             	mov    0x8(%ebp),%eax
c0002fa1:	8b 40 04             	mov    0x4(%eax),%eax
c0002fa4:	8b 55 08             	mov    0x8(%ebp),%edx
c0002fa7:	8b 12                	mov    (%edx),%edx
c0002fa9:	89 10                	mov    %edx,(%eax)
c0002fab:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002fae:	89 04 24             	mov    %eax,(%esp)
c0002fb1:	e8 df ee ff ff       	call   c0001e95 <intr_set_status>
c0002fb6:	c9                   	leave  
c0002fb7:	c3                   	ret    

c0002fb8 <list_pop>:
c0002fb8:	55                   	push   %ebp
c0002fb9:	89 e5                	mov    %esp,%ebp
c0002fbb:	83 ec 28             	sub    $0x28,%esp
c0002fbe:	8b 45 08             	mov    0x8(%ebp),%eax
c0002fc1:	8b 40 04             	mov    0x4(%eax),%eax
c0002fc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0002fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002fca:	89 04 24             	mov    %eax,(%esp)
c0002fcd:	e8 b0 ff ff ff       	call   c0002f82 <list_remove>
c0002fd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0002fd5:	c9                   	leave  
c0002fd6:	c3                   	ret    

c0002fd7 <list_empty>:
c0002fd7:	55                   	push   %ebp
c0002fd8:	89 e5                	mov    %esp,%ebp
c0002fda:	8b 45 08             	mov    0x8(%ebp),%eax
c0002fdd:	8b 40 04             	mov    0x4(%eax),%eax
c0002fe0:	8b 55 08             	mov    0x8(%ebp),%edx
c0002fe3:	83 c2 08             	add    $0x8,%edx
c0002fe6:	39 d0                	cmp    %edx,%eax
c0002fe8:	75 14                	jne    c0002ffe <list_empty+0x27>
c0002fea:	8b 45 08             	mov    0x8(%ebp),%eax
c0002fed:	8b 50 08             	mov    0x8(%eax),%edx
c0002ff0:	8b 45 08             	mov    0x8(%ebp),%eax
c0002ff3:	39 c2                	cmp    %eax,%edx
c0002ff5:	75 07                	jne    c0002ffe <list_empty+0x27>
c0002ff7:	b8 01 00 00 00       	mov    $0x1,%eax
c0002ffc:	eb 05                	jmp    c0003003 <list_empty+0x2c>
c0002ffe:	b8 00 00 00 00       	mov    $0x0,%eax
c0003003:	5d                   	pop    %ebp
c0003004:	c3                   	ret    

c0003005 <list_len>:
c0003005:	55                   	push   %ebp
c0003006:	89 e5                	mov    %esp,%ebp
c0003008:	83 ec 10             	sub    $0x10,%esp
c000300b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c0003012:	8b 45 08             	mov    0x8(%ebp),%eax
c0003015:	89 45 f8             	mov    %eax,-0x8(%ebp)
c0003018:	eb 0d                	jmp    c0003027 <list_len+0x22>
c000301a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c000301e:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0003021:	8b 40 04             	mov    0x4(%eax),%eax
c0003024:	89 45 f8             	mov    %eax,-0x8(%ebp)
c0003027:	8b 45 f8             	mov    -0x8(%ebp),%eax
c000302a:	8b 40 04             	mov    0x4(%eax),%eax
c000302d:	8b 55 08             	mov    0x8(%ebp),%edx
c0003030:	83 c2 08             	add    $0x8,%edx
c0003033:	39 d0                	cmp    %edx,%eax
c0003035:	75 e3                	jne    c000301a <list_len+0x15>
c0003037:	8b 45 fc             	mov    -0x4(%ebp),%eax
c000303a:	c9                   	leave  
c000303b:	c3                   	ret    

c000303c <list_traversal>:
c000303c:	55                   	push   %ebp
c000303d:	89 e5                	mov    %esp,%ebp
c000303f:	83 ec 28             	sub    $0x28,%esp
c0003042:	8b 45 08             	mov    0x8(%ebp),%eax
c0003045:	89 04 24             	mov    %eax,(%esp)
c0003048:	e8 8a ff ff ff       	call   c0002fd7 <list_empty>
c000304d:	84 c0                	test   %al,%al
c000304f:	74 07                	je     c0003058 <list_traversal+0x1c>
c0003051:	b8 00 00 00 00       	mov    $0x0,%eax
c0003056:	eb 3f                	jmp    c0003097 <list_traversal+0x5b>
c0003058:	8b 45 08             	mov    0x8(%ebp),%eax
c000305b:	8b 40 04             	mov    0x4(%eax),%eax
c000305e:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0003061:	eb 24                	jmp    c0003087 <list_traversal+0x4b>
c0003063:	8b 45 10             	mov    0x10(%ebp),%eax
c0003066:	89 44 24 04          	mov    %eax,0x4(%esp)
c000306a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000306d:	89 04 24             	mov    %eax,(%esp)
c0003070:	8b 45 0c             	mov    0xc(%ebp),%eax
c0003073:	ff d0                	call   *%eax
c0003075:	84 c0                	test   %al,%al
c0003077:	74 05                	je     c000307e <list_traversal+0x42>
c0003079:	8b 45 f4             	mov    -0xc(%ebp),%eax
c000307c:	eb 19                	jmp    c0003097 <list_traversal+0x5b>
c000307e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0003081:	8b 40 04             	mov    0x4(%eax),%eax
c0003084:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0003087:	8b 45 08             	mov    0x8(%ebp),%eax
c000308a:	83 c0 08             	add    $0x8,%eax
c000308d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0003090:	75 d1                	jne    c0003063 <list_traversal+0x27>
c0003092:	b8 00 00 00 00       	mov    $0x0,%eax
c0003097:	c9                   	leave  
c0003098:	c3                   	ret    

c0003099 <elem_find>:
c0003099:	55                   	push   %ebp
c000309a:	89 e5                	mov    %esp,%ebp
c000309c:	83 ec 10             	sub    $0x10,%esp
c000309f:	8b 45 08             	mov    0x8(%ebp),%eax
c00030a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
c00030a5:	eb 1b                	jmp    c00030c2 <elem_find+0x29>
c00030a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c00030aa:	8b 40 04             	mov    0x4(%eax),%eax
c00030ad:	3b 45 0c             	cmp    0xc(%ebp),%eax
c00030b0:	75 07                	jne    c00030b9 <elem_find+0x20>
c00030b2:	b8 01 00 00 00       	mov    $0x1,%eax
c00030b7:	eb 1e                	jmp    c00030d7 <elem_find+0x3e>
c00030b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
c00030bc:	8b 40 04             	mov    0x4(%eax),%eax
c00030bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
c00030c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
c00030c5:	8b 40 04             	mov    0x4(%eax),%eax
c00030c8:	8b 55 08             	mov    0x8(%ebp),%edx
c00030cb:	83 c2 08             	add    $0x8,%edx
c00030ce:	39 d0                	cmp    %edx,%eax
c00030d0:	75 d5                	jne    c00030a7 <elem_find+0xe>
c00030d2:	b8 00 00 00 00       	mov    $0x0,%eax
c00030d7:	c9                   	leave  
c00030d8:	c3                   	ret    

c00030d9 <debug_list>:
c00030d9:	55                   	push   %ebp
c00030da:	89 e5                	mov    %esp,%ebp
c00030dc:	83 ec 28             	sub    $0x28,%esp
c00030df:	8b 45 08             	mov    0x8(%ebp),%eax
c00030e2:	8b 40 04             	mov    0x4(%eax),%eax
c00030e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
c00030e8:	eb 2c                	jmp    c0003116 <debug_list+0x3d>
c00030ea:	c7 04 24 4a 46 00 c0 	movl   $0xc000464a,(%esp)
c00030f1:	e8 ca e4 ff ff       	call   c00015c0 <print_str>
c00030f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c00030f9:	89 04 24             	mov    %eax,(%esp)
c00030fc:	e8 2f e5 ff ff       	call   c0001630 <print_num>
c0003101:	c7 04 24 7a 40 00 c0 	movl   $0xc000407a,(%esp)
c0003108:	e8 b3 e4 ff ff       	call   c00015c0 <print_str>
c000310d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0003110:	8b 40 04             	mov    0x4(%eax),%eax
c0003113:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0003116:	8b 45 08             	mov    0x8(%ebp),%eax
c0003119:	83 c0 08             	add    $0x8,%eax
c000311c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c000311f:	75 c9                	jne    c00030ea <debug_list+0x11>
c0003121:	c9                   	leave  
c0003122:	c3                   	ret    
c0003123:	66 90                	xchg   %ax,%ax
c0003125:	66 90                	xchg   %ax,%ax
c0003127:	66 90                	xchg   %ax,%ax
c0003129:	66 90                	xchg   %ax,%ax
c000312b:	66 90                	xchg   %ax,%ax
c000312d:	66 90                	xchg   %ax,%ax
c000312f:	90                   	nop

c0003130 <put_char>:
c0003130:	60                   	pusha  
c0003131:	66 b8 18 00          	mov    $0x18,%ax
c0003135:	8e e8                	mov    %eax,%gs
c0003137:	66 ba d4 03          	mov    $0x3d4,%dx
c000313b:	b0 0e                	mov    $0xe,%al
c000313d:	ee                   	out    %al,(%dx)
c000313e:	66 ba d5 03          	mov    $0x3d5,%dx
c0003142:	ec                   	in     (%dx),%al
c0003143:	88 c4                	mov    %al,%ah
c0003145:	66 ba d4 03          	mov    $0x3d4,%dx
c0003149:	b0 0f                	mov    $0xf,%al
c000314b:	ee                   	out    %al,(%dx)
c000314c:	66 ba d5 03          	mov    $0x3d5,%dx
c0003150:	ec                   	in     (%dx),%al
c0003151:	66 89 c3             	mov    %ax,%bx
c0003154:	8b 4c 24 24          	mov    0x24(%esp),%ecx
c0003158:	80 f9 0d             	cmp    $0xd,%cl
c000315b:	74 3c                	je     c0003199 <put_char.is_carriage_return>
c000315d:	80 f9 0a             	cmp    $0xa,%cl
c0003160:	74 37                	je     c0003199 <put_char.is_carriage_return>
c0003162:	80 f9 08             	cmp    $0x8,%cl
c0003165:	74 02                	je     c0003169 <put_char.is_backspace>
c0003167:	eb 16                	jmp    c000317f <put_char.put_other>

c0003169 <put_char.is_backspace>:
c0003169:	66 4b                	dec    %bx
c000316b:	66 d1 e3             	shl    %bx
c000316e:	65 67 c6 07 20       	movb   $0x20,%gs:(%bx)
c0003173:	66 43                	inc    %bx
c0003175:	65 67 c6 07 07       	movb   $0x7,%gs:(%bx)
c000317a:	66 d1 eb             	shr    %bx
c000317d:	eb 60                	jmp    c00031df <put_char.set_cursor>

c000317f <put_char.put_other>:
c000317f:	66 d1 e3             	shl    %bx
c0003182:	65 67 88 0f          	mov    %cl,%gs:(%bx)
c0003186:	66 43                	inc    %bx
c0003188:	65 67 c6 07 07       	movb   $0x7,%gs:(%bx)
c000318d:	66 d1 eb             	shr    %bx
c0003190:	66 43                	inc    %bx
c0003192:	66 81 fb d0 07       	cmp    $0x7d0,%bx
c0003197:	eb 46                	jmp    c00031df <put_char.set_cursor>

c0003199 <put_char.is_carriage_return>:
c0003199:	66 31 d2             	xor    %dx,%dx
c000319c:	66 89 d8             	mov    %bx,%ax
c000319f:	66 be 50 00          	mov    $0x50,%si
c00031a3:	66 f7 f6             	div    %si
c00031a6:	66 29 d3             	sub    %dx,%bx

c00031a9 <put_char.is_carriage_return_end>:
c00031a9:	66 83 c3 50          	add    $0x50,%bx
c00031ad:	66 81 fb d0 07       	cmp    $0x7d0,%bx

c00031b2 <put_char.is_line_feed_end>:
c00031b2:	7c 2b                	jl     c00031df <put_char.set_cursor>

c00031b4 <put_char.roll_screen>:
c00031b4:	fc                   	cld    
c00031b5:	b9 c0 03 00 00       	mov    $0x3c0,%ecx
c00031ba:	be a0 80 0b c0       	mov    $0xc00b80a0,%esi
c00031bf:	bf 00 80 0b c0       	mov    $0xc00b8000,%edi
c00031c4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c00031c6:	bb 00 0f 00 00       	mov    $0xf00,%ebx
c00031cb:	b9 50 00 00 00       	mov    $0x50,%ecx

c00031d0 <put_char.cls>:
c00031d0:	65 66 c7 03 20 07    	movw   $0x720,%gs:(%ebx)
c00031d6:	83 c3 02             	add    $0x2,%ebx
c00031d9:	e2 f5                	loop   c00031d0 <put_char.cls>
c00031db:	66 bb 80 07          	mov    $0x780,%bx

c00031df <put_char.set_cursor>:
c00031df:	66 ba d4 03          	mov    $0x3d4,%dx
c00031e3:	b0 0e                	mov    $0xe,%al
c00031e5:	ee                   	out    %al,(%dx)
c00031e6:	66 ba d5 03          	mov    $0x3d5,%dx
c00031ea:	88 f8                	mov    %bh,%al
c00031ec:	ee                   	out    %al,(%dx)
c00031ed:	66 ba d4 03          	mov    $0x3d4,%dx
c00031f1:	b0 0f                	mov    $0xf,%al
c00031f3:	ee                   	out    %al,(%dx)
c00031f4:	66 ba d5 03          	mov    $0x3d5,%dx
c00031f8:	88 d8                	mov    %bl,%al
c00031fa:	ee                   	out    %al,(%dx)

c00031fb <put_char.put_char_done>:
c00031fb:	61                   	popa   
c00031fc:	c3                   	ret    

c00031fd <to_top_left>:
c00031fd:	60                   	pusha  
c00031fe:	66 ba d4 03          	mov    $0x3d4,%dx
c0003202:	b0 0e                	mov    $0xe,%al
c0003204:	ee                   	out    %al,(%dx)
c0003205:	66 ba d5 03          	mov    $0x3d5,%dx
c0003209:	b0 00                	mov    $0x0,%al
c000320b:	ee                   	out    %al,(%dx)
c000320c:	66 ba d4 03          	mov    $0x3d4,%dx
c0003210:	b0 0f                	mov    $0xf,%al
c0003212:	ee                   	out    %al,(%dx)
c0003213:	66 ba d5 03          	mov    $0x3d5,%dx
c0003217:	b0 00                	mov    $0x0,%al
c0003219:	ee                   	out    %al,(%dx)
c000321a:	61                   	popa   
c000321b:	c3                   	ret    

c000321c <put_str>:
c000321c:	53                   	push   %ebx
c000321d:	51                   	push   %ecx
c000321e:	31 db                	xor    %ebx,%ebx
c0003220:	8b 4c 24 0c          	mov    0xc(%esp),%ecx

c0003224 <put_str.continue_put_char>:
c0003224:	8a 19                	mov    (%ecx),%bl
c0003226:	80 fb 00             	cmp    $0x0,%bl
c0003229:	74 0c                	je     c0003237 <put_str.str_over>
c000322b:	53                   	push   %ebx
c000322c:	e8 ff fe ff ff       	call   c0003130 <put_char>
c0003231:	83 c4 04             	add    $0x4,%esp
c0003234:	41                   	inc    %ecx
c0003235:	eb ed                	jmp    c0003224 <put_str.continue_put_char>

c0003237 <put_str.str_over>:
c0003237:	59                   	pop    %ecx
c0003238:	5b                   	pop    %ebx
c0003239:	c3                   	ret    
c000323a:	66 90                	xchg   %ax,%ax
c000323c:	66 90                	xchg   %ax,%ax
c000323e:	66 90                	xchg   %ax,%ax

c0003240 <intr_exit>:
c0003240:	83 c4 04             	add    $0x4,%esp
c0003243:	61                   	popa   
c0003244:	0f a9                	pop    %gs
c0003246:	0f a1                	pop    %fs
c0003248:	07                   	pop    %es
c0003249:	1f                   	pop    %ds
c000324a:	83 c4 04             	add    $0x4,%esp
c000324d:	cf                   	iret   

c000324e <intr_0x0_entry>:
c000324e:	6a 00                	push   $0x0
c0003250:	1e                   	push   %ds
c0003251:	06                   	push   %es
c0003252:	0f a0                	push   %fs
c0003254:	0f a8                	push   %gs
c0003256:	60                   	pusha  
c0003257:	b0 20                	mov    $0x20,%al
c0003259:	e6 a0                	out    %al,$0xa0
c000325b:	e6 20                	out    %al,$0x20
c000325d:	6a 00                	push   $0x0
c000325f:	ff 15 e0 59 00 c0    	call   *0xc00059e0
c0003265:	eb d9                	jmp    c0003240 <intr_exit>

c0003267 <intr_0X1_entry>:
c0003267:	6a 00                	push   $0x0
c0003269:	1e                   	push   %ds
c000326a:	06                   	push   %es
c000326b:	0f a0                	push   %fs
c000326d:	0f a8                	push   %gs
c000326f:	60                   	pusha  
c0003270:	b0 20                	mov    $0x20,%al
c0003272:	e6 a0                	out    %al,$0xa0
c0003274:	e6 20                	out    %al,$0x20
c0003276:	6a 01                	push   $0x1
c0003278:	ff 15 e4 59 00 c0    	call   *0xc00059e4
c000327e:	eb c0                	jmp    c0003240 <intr_exit>

c0003280 <intr_0X2_entry>:
c0003280:	6a 00                	push   $0x0
c0003282:	1e                   	push   %ds
c0003283:	06                   	push   %es
c0003284:	0f a0                	push   %fs
c0003286:	0f a8                	push   %gs
c0003288:	60                   	pusha  
c0003289:	b0 20                	mov    $0x20,%al
c000328b:	e6 a0                	out    %al,$0xa0
c000328d:	e6 20                	out    %al,$0x20
c000328f:	6a 02                	push   $0x2
c0003291:	ff 15 e8 59 00 c0    	call   *0xc00059e8
c0003297:	eb a7                	jmp    c0003240 <intr_exit>

c0003299 <intr_0x3_entry>:
c0003299:	6a 00                	push   $0x0
c000329b:	1e                   	push   %ds
c000329c:	06                   	push   %es
c000329d:	0f a0                	push   %fs
c000329f:	0f a8                	push   %gs
c00032a1:	60                   	pusha  
c00032a2:	b0 20                	mov    $0x20,%al
c00032a4:	e6 a0                	out    %al,$0xa0
c00032a6:	e6 20                	out    %al,$0x20
c00032a8:	6a 03                	push   $0x3
c00032aa:	ff 15 ec 59 00 c0    	call   *0xc00059ec
c00032b0:	eb 8e                	jmp    c0003240 <intr_exit>

c00032b2 <intr_0X4_entry>:
c00032b2:	6a 00                	push   $0x0
c00032b4:	1e                   	push   %ds
c00032b5:	06                   	push   %es
c00032b6:	0f a0                	push   %fs
c00032b8:	0f a8                	push   %gs
c00032ba:	60                   	pusha  
c00032bb:	b0 20                	mov    $0x20,%al
c00032bd:	e6 a0                	out    %al,$0xa0
c00032bf:	e6 20                	out    %al,$0x20
c00032c1:	6a 04                	push   $0x4
c00032c3:	ff 15 f0 59 00 c0    	call   *0xc00059f0
c00032c9:	e9 72 ff ff ff       	jmp    c0003240 <intr_exit>

c00032ce <intr_0X5_entry>:
c00032ce:	6a 00                	push   $0x0
c00032d0:	1e                   	push   %ds
c00032d1:	06                   	push   %es
c00032d2:	0f a0                	push   %fs
c00032d4:	0f a8                	push   %gs
c00032d6:	60                   	pusha  
c00032d7:	b0 20                	mov    $0x20,%al
c00032d9:	e6 a0                	out    %al,$0xa0
c00032db:	e6 20                	out    %al,$0x20
c00032dd:	6a 05                	push   $0x5
c00032df:	ff 15 f4 59 00 c0    	call   *0xc00059f4
c00032e5:	e9 56 ff ff ff       	jmp    c0003240 <intr_exit>

c00032ea <intr_0x6_entry>:
c00032ea:	6a 00                	push   $0x0
c00032ec:	1e                   	push   %ds
c00032ed:	06                   	push   %es
c00032ee:	0f a0                	push   %fs
c00032f0:	0f a8                	push   %gs
c00032f2:	60                   	pusha  
c00032f3:	b0 20                	mov    $0x20,%al
c00032f5:	e6 a0                	out    %al,$0xa0
c00032f7:	e6 20                	out    %al,$0x20
c00032f9:	6a 06                	push   $0x6
c00032fb:	ff 15 f8 59 00 c0    	call   *0xc00059f8
c0003301:	e9 3a ff ff ff       	jmp    c0003240 <intr_exit>

c0003306 <intr_0X7_entry>:
c0003306:	6a 00                	push   $0x0
c0003308:	1e                   	push   %ds
c0003309:	06                   	push   %es
c000330a:	0f a0                	push   %fs
c000330c:	0f a8                	push   %gs
c000330e:	60                   	pusha  
c000330f:	b0 20                	mov    $0x20,%al
c0003311:	e6 a0                	out    %al,$0xa0
c0003313:	e6 20                	out    %al,$0x20
c0003315:	6a 07                	push   $0x7
c0003317:	ff 15 fc 59 00 c0    	call   *0xc00059fc
c000331d:	e9 1e ff ff ff       	jmp    c0003240 <intr_exit>

c0003322 <intr_0X8_entry>:
c0003322:	90                   	nop
c0003323:	1e                   	push   %ds
c0003324:	06                   	push   %es
c0003325:	0f a0                	push   %fs
c0003327:	0f a8                	push   %gs
c0003329:	60                   	pusha  
c000332a:	b0 20                	mov    $0x20,%al
c000332c:	e6 a0                	out    %al,$0xa0
c000332e:	e6 20                	out    %al,$0x20
c0003330:	6a 08                	push   $0x8
c0003332:	ff 15 00 5a 00 c0    	call   *0xc0005a00
c0003338:	e9 03 ff ff ff       	jmp    c0003240 <intr_exit>

c000333d <intr_0x9_entry>:
c000333d:	6a 00                	push   $0x0
c000333f:	1e                   	push   %ds
c0003340:	06                   	push   %es
c0003341:	0f a0                	push   %fs
c0003343:	0f a8                	push   %gs
c0003345:	60                   	pusha  
c0003346:	b0 20                	mov    $0x20,%al
c0003348:	e6 a0                	out    %al,$0xa0
c000334a:	e6 20                	out    %al,$0x20
c000334c:	6a 09                	push   $0x9
c000334e:	ff 15 04 5a 00 c0    	call   *0xc0005a04
c0003354:	e9 e7 fe ff ff       	jmp    c0003240 <intr_exit>

c0003359 <intr_0XA_entry>:
c0003359:	90                   	nop
c000335a:	1e                   	push   %ds
c000335b:	06                   	push   %es
c000335c:	0f a0                	push   %fs
c000335e:	0f a8                	push   %gs
c0003360:	60                   	pusha  
c0003361:	b0 20                	mov    $0x20,%al
c0003363:	e6 a0                	out    %al,$0xa0
c0003365:	e6 20                	out    %al,$0x20
c0003367:	6a 0a                	push   $0xa
c0003369:	ff 15 08 5a 00 c0    	call   *0xc0005a08
c000336f:	e9 cc fe ff ff       	jmp    c0003240 <intr_exit>

c0003374 <intr_0XB_entry>:
c0003374:	90                   	nop
c0003375:	1e                   	push   %ds
c0003376:	06                   	push   %es
c0003377:	0f a0                	push   %fs
c0003379:	0f a8                	push   %gs
c000337b:	60                   	pusha  
c000337c:	b0 20                	mov    $0x20,%al
c000337e:	e6 a0                	out    %al,$0xa0
c0003380:	e6 20                	out    %al,$0x20
c0003382:	6a 0b                	push   $0xb
c0003384:	ff 15 0c 5a 00 c0    	call   *0xc0005a0c
c000338a:	e9 b1 fe ff ff       	jmp    c0003240 <intr_exit>

c000338f <intr_0XC_entry>:
c000338f:	90                   	nop
c0003390:	1e                   	push   %ds
c0003391:	06                   	push   %es
c0003392:	0f a0                	push   %fs
c0003394:	0f a8                	push   %gs
c0003396:	60                   	pusha  
c0003397:	b0 20                	mov    $0x20,%al
c0003399:	e6 a0                	out    %al,$0xa0
c000339b:	e6 20                	out    %al,$0x20
c000339d:	6a 0c                	push   $0xc
c000339f:	ff 15 10 5a 00 c0    	call   *0xc0005a10
c00033a5:	e9 96 fe ff ff       	jmp    c0003240 <intr_exit>

c00033aa <intr_0XD_entry>:
c00033aa:	90                   	nop
c00033ab:	1e                   	push   %ds
c00033ac:	06                   	push   %es
c00033ad:	0f a0                	push   %fs
c00033af:	0f a8                	push   %gs
c00033b1:	60                   	pusha  
c00033b2:	b0 20                	mov    $0x20,%al
c00033b4:	e6 a0                	out    %al,$0xa0
c00033b6:	e6 20                	out    %al,$0x20
c00033b8:	6a 0d                	push   $0xd
c00033ba:	ff 15 14 5a 00 c0    	call   *0xc0005a14
c00033c0:	e9 7b fe ff ff       	jmp    c0003240 <intr_exit>

c00033c5 <intr_0XE_entry>:
c00033c5:	90                   	nop
c00033c6:	1e                   	push   %ds
c00033c7:	06                   	push   %es
c00033c8:	0f a0                	push   %fs
c00033ca:	0f a8                	push   %gs
c00033cc:	60                   	pusha  
c00033cd:	b0 20                	mov    $0x20,%al
c00033cf:	e6 a0                	out    %al,$0xa0
c00033d1:	e6 20                	out    %al,$0x20
c00033d3:	6a 0e                	push   $0xe
c00033d5:	ff 15 18 5a 00 c0    	call   *0xc0005a18
c00033db:	e9 60 fe ff ff       	jmp    c0003240 <intr_exit>

c00033e0 <intr_0XF_entry>:
c00033e0:	6a 00                	push   $0x0
c00033e2:	1e                   	push   %ds
c00033e3:	06                   	push   %es
c00033e4:	0f a0                	push   %fs
c00033e6:	0f a8                	push   %gs
c00033e8:	60                   	pusha  
c00033e9:	b0 20                	mov    $0x20,%al
c00033eb:	e6 a0                	out    %al,$0xa0
c00033ed:	e6 20                	out    %al,$0x20
c00033ef:	6a 0f                	push   $0xf
c00033f1:	ff 15 1c 5a 00 c0    	call   *0xc0005a1c
c00033f7:	e9 44 fe ff ff       	jmp    c0003240 <intr_exit>

c00033fc <intr_0X10_entry>:
c00033fc:	6a 00                	push   $0x0
c00033fe:	1e                   	push   %ds
c00033ff:	06                   	push   %es
c0003400:	0f a0                	push   %fs
c0003402:	0f a8                	push   %gs
c0003404:	60                   	pusha  
c0003405:	b0 20                	mov    $0x20,%al
c0003407:	e6 a0                	out    %al,$0xa0
c0003409:	e6 20                	out    %al,$0x20
c000340b:	6a 10                	push   $0x10
c000340d:	ff 15 20 5a 00 c0    	call   *0xc0005a20
c0003413:	e9 28 fe ff ff       	jmp    c0003240 <intr_exit>

c0003418 <intr_0X11_entry>:
c0003418:	90                   	nop
c0003419:	1e                   	push   %ds
c000341a:	06                   	push   %es
c000341b:	0f a0                	push   %fs
c000341d:	0f a8                	push   %gs
c000341f:	60                   	pusha  
c0003420:	b0 20                	mov    $0x20,%al
c0003422:	e6 a0                	out    %al,$0xa0
c0003424:	e6 20                	out    %al,$0x20
c0003426:	6a 11                	push   $0x11
c0003428:	ff 15 24 5a 00 c0    	call   *0xc0005a24
c000342e:	e9 0d fe ff ff       	jmp    c0003240 <intr_exit>

c0003433 <intr_0x12_entry>:
c0003433:	6a 00                	push   $0x0
c0003435:	1e                   	push   %ds
c0003436:	06                   	push   %es
c0003437:	0f a0                	push   %fs
c0003439:	0f a8                	push   %gs
c000343b:	60                   	pusha  
c000343c:	b0 20                	mov    $0x20,%al
c000343e:	e6 a0                	out    %al,$0xa0
c0003440:	e6 20                	out    %al,$0x20
c0003442:	6a 12                	push   $0x12
c0003444:	ff 15 28 5a 00 c0    	call   *0xc0005a28
c000344a:	e9 f1 fd ff ff       	jmp    c0003240 <intr_exit>

c000344f <intr_0X13_entry>:
c000344f:	6a 00                	push   $0x0
c0003451:	1e                   	push   %ds
c0003452:	06                   	push   %es
c0003453:	0f a0                	push   %fs
c0003455:	0f a8                	push   %gs
c0003457:	60                   	pusha  
c0003458:	b0 20                	mov    $0x20,%al
c000345a:	e6 a0                	out    %al,$0xa0
c000345c:	e6 20                	out    %al,$0x20
c000345e:	6a 13                	push   $0x13
c0003460:	ff 15 2c 5a 00 c0    	call   *0xc0005a2c
c0003466:	e9 d5 fd ff ff       	jmp    c0003240 <intr_exit>

c000346b <intr_0X14_entry>:
c000346b:	6a 00                	push   $0x0
c000346d:	1e                   	push   %ds
c000346e:	06                   	push   %es
c000346f:	0f a0                	push   %fs
c0003471:	0f a8                	push   %gs
c0003473:	60                   	pusha  
c0003474:	b0 20                	mov    $0x20,%al
c0003476:	e6 a0                	out    %al,$0xa0
c0003478:	e6 20                	out    %al,$0x20
c000347a:	6a 14                	push   $0x14
c000347c:	ff 15 30 5a 00 c0    	call   *0xc0005a30
c0003482:	e9 b9 fd ff ff       	jmp    c0003240 <intr_exit>

c0003487 <intr_0x15_entry>:
c0003487:	6a 00                	push   $0x0
c0003489:	1e                   	push   %ds
c000348a:	06                   	push   %es
c000348b:	0f a0                	push   %fs
c000348d:	0f a8                	push   %gs
c000348f:	60                   	pusha  
c0003490:	b0 20                	mov    $0x20,%al
c0003492:	e6 a0                	out    %al,$0xa0
c0003494:	e6 20                	out    %al,$0x20
c0003496:	6a 15                	push   $0x15
c0003498:	ff 15 34 5a 00 c0    	call   *0xc0005a34
c000349e:	e9 9d fd ff ff       	jmp    c0003240 <intr_exit>

c00034a3 <intr_0X16_entry>:
c00034a3:	6a 00                	push   $0x0
c00034a5:	1e                   	push   %ds
c00034a6:	06                   	push   %es
c00034a7:	0f a0                	push   %fs
c00034a9:	0f a8                	push   %gs
c00034ab:	60                   	pusha  
c00034ac:	b0 20                	mov    $0x20,%al
c00034ae:	e6 a0                	out    %al,$0xa0
c00034b0:	e6 20                	out    %al,$0x20
c00034b2:	6a 16                	push   $0x16
c00034b4:	ff 15 38 5a 00 c0    	call   *0xc0005a38
c00034ba:	e9 81 fd ff ff       	jmp    c0003240 <intr_exit>

c00034bf <intr_0X17_entry>:
c00034bf:	6a 00                	push   $0x0
c00034c1:	1e                   	push   %ds
c00034c2:	06                   	push   %es
c00034c3:	0f a0                	push   %fs
c00034c5:	0f a8                	push   %gs
c00034c7:	60                   	pusha  
c00034c8:	b0 20                	mov    $0x20,%al
c00034ca:	e6 a0                	out    %al,$0xa0
c00034cc:	e6 20                	out    %al,$0x20
c00034ce:	6a 17                	push   $0x17
c00034d0:	ff 15 3c 5a 00 c0    	call   *0xc0005a3c
c00034d6:	e9 65 fd ff ff       	jmp    c0003240 <intr_exit>

c00034db <intr_0X18_entry>:
c00034db:	6a 00                	push   $0x0
c00034dd:	1e                   	push   %ds
c00034de:	06                   	push   %es
c00034df:	0f a0                	push   %fs
c00034e1:	0f a8                	push   %gs
c00034e3:	60                   	pusha  
c00034e4:	b0 20                	mov    $0x20,%al
c00034e6:	e6 a0                	out    %al,$0xa0
c00034e8:	e6 20                	out    %al,$0x20
c00034ea:	6a 18                	push   $0x18
c00034ec:	ff 15 40 5a 00 c0    	call   *0xc0005a40
c00034f2:	e9 49 fd ff ff       	jmp    c0003240 <intr_exit>

c00034f7 <intr_0X19_entry>:
c00034f7:	6a 00                	push   $0x0
c00034f9:	1e                   	push   %ds
c00034fa:	06                   	push   %es
c00034fb:	0f a0                	push   %fs
c00034fd:	0f a8                	push   %gs
c00034ff:	60                   	pusha  
c0003500:	b0 20                	mov    $0x20,%al
c0003502:	e6 a0                	out    %al,$0xa0
c0003504:	e6 20                	out    %al,$0x20
c0003506:	6a 19                	push   $0x19
c0003508:	ff 15 44 5a 00 c0    	call   *0xc0005a44
c000350e:	e9 2d fd ff ff       	jmp    c0003240 <intr_exit>

c0003513 <intr_0X1A_entry>:
c0003513:	6a 00                	push   $0x0
c0003515:	1e                   	push   %ds
c0003516:	06                   	push   %es
c0003517:	0f a0                	push   %fs
c0003519:	0f a8                	push   %gs
c000351b:	60                   	pusha  
c000351c:	b0 20                	mov    $0x20,%al
c000351e:	e6 a0                	out    %al,$0xa0
c0003520:	e6 20                	out    %al,$0x20
c0003522:	6a 1a                	push   $0x1a
c0003524:	ff 15 48 5a 00 c0    	call   *0xc0005a48
c000352a:	e9 11 fd ff ff       	jmp    c0003240 <intr_exit>

c000352f <intr_0X1B_entry>:
c000352f:	6a 00                	push   $0x0
c0003531:	1e                   	push   %ds
c0003532:	06                   	push   %es
c0003533:	0f a0                	push   %fs
c0003535:	0f a8                	push   %gs
c0003537:	60                   	pusha  
c0003538:	b0 20                	mov    $0x20,%al
c000353a:	e6 a0                	out    %al,$0xa0
c000353c:	e6 20                	out    %al,$0x20
c000353e:	6a 1b                	push   $0x1b
c0003540:	ff 15 4c 5a 00 c0    	call   *0xc0005a4c
c0003546:	e9 f5 fc ff ff       	jmp    c0003240 <intr_exit>

c000354b <intr_0X1C_entry>:
c000354b:	6a 00                	push   $0x0
c000354d:	1e                   	push   %ds
c000354e:	06                   	push   %es
c000354f:	0f a0                	push   %fs
c0003551:	0f a8                	push   %gs
c0003553:	60                   	pusha  
c0003554:	b0 20                	mov    $0x20,%al
c0003556:	e6 a0                	out    %al,$0xa0
c0003558:	e6 20                	out    %al,$0x20
c000355a:	6a 1c                	push   $0x1c
c000355c:	ff 15 50 5a 00 c0    	call   *0xc0005a50
c0003562:	e9 d9 fc ff ff       	jmp    c0003240 <intr_exit>

c0003567 <intr_0X1D_entry>:
c0003567:	6a 00                	push   $0x0
c0003569:	1e                   	push   %ds
c000356a:	06                   	push   %es
c000356b:	0f a0                	push   %fs
c000356d:	0f a8                	push   %gs
c000356f:	60                   	pusha  
c0003570:	b0 20                	mov    $0x20,%al
c0003572:	e6 a0                	out    %al,$0xa0
c0003574:	e6 20                	out    %al,$0x20
c0003576:	6a 1d                	push   $0x1d
c0003578:	ff 15 54 5a 00 c0    	call   *0xc0005a54
c000357e:	e9 bd fc ff ff       	jmp    c0003240 <intr_exit>

c0003583 <intr_0X1E_entry>:
c0003583:	90                   	nop
c0003584:	1e                   	push   %ds
c0003585:	06                   	push   %es
c0003586:	0f a0                	push   %fs
c0003588:	0f a8                	push   %gs
c000358a:	60                   	pusha  
c000358b:	b0 20                	mov    $0x20,%al
c000358d:	e6 a0                	out    %al,$0xa0
c000358f:	e6 20                	out    %al,$0x20
c0003591:	6a 1e                	push   $0x1e
c0003593:	ff 15 58 5a 00 c0    	call   *0xc0005a58
c0003599:	e9 a2 fc ff ff       	jmp    c0003240 <intr_exit>

c000359e <intr_0X1F_entry>:
c000359e:	6a 00                	push   $0x0
c00035a0:	1e                   	push   %ds
c00035a1:	06                   	push   %es
c00035a2:	0f a0                	push   %fs
c00035a4:	0f a8                	push   %gs
c00035a6:	60                   	pusha  
c00035a7:	b0 20                	mov    $0x20,%al
c00035a9:	e6 a0                	out    %al,$0xa0
c00035ab:	e6 20                	out    %al,$0x20
c00035ad:	6a 1f                	push   $0x1f
c00035af:	ff 15 5c 5a 00 c0    	call   *0xc0005a5c
c00035b5:	e9 86 fc ff ff       	jmp    c0003240 <intr_exit>

c00035ba <intr_0X20_entry>:
c00035ba:	6a 00                	push   $0x0
c00035bc:	1e                   	push   %ds
c00035bd:	06                   	push   %es
c00035be:	0f a0                	push   %fs
c00035c0:	0f a8                	push   %gs
c00035c2:	60                   	pusha  
c00035c3:	b0 20                	mov    $0x20,%al
c00035c5:	e6 a0                	out    %al,$0xa0
c00035c7:	e6 20                	out    %al,$0x20
c00035c9:	6a 20                	push   $0x20
c00035cb:	ff 15 60 5a 00 c0    	call   *0xc0005a60
c00035d1:	e9 6a fc ff ff       	jmp    c0003240 <intr_exit>

c00035d6 <switch_to>:
c00035d6:	56                   	push   %esi
c00035d7:	57                   	push   %edi
c00035d8:	53                   	push   %ebx
c00035d9:	55                   	push   %ebp
c00035da:	8b 44 24 14          	mov    0x14(%esp),%eax
c00035de:	89 20                	mov    %esp,(%eax)
c00035e0:	8b 44 24 18          	mov    0x18(%esp),%eax
c00035e4:	8b 20                	mov    (%eax),%esp
c00035e6:	5d                   	pop    %ebp
c00035e7:	5b                   	pop    %ebx
c00035e8:	5f                   	pop    %edi
c00035e9:	5e                   	pop    %esi
c00035ea:	c3                   	ret    
