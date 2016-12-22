
_test:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#define READ_END 0
#define WRITE_END 1

int 
main(int argc, char* argv[]) 
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
    int *a=(int*)sbrk(8192);
   9:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
  10:	e8 8c 03 00 00       	call   3a1 <sbrk>
  15:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 	a[150]=10;
  19:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1d:	05 58 02 00 00       	add    $0x258,%eax
  22:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
	printf(2,"%d\n",a[150]); 
  28:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2c:	05 58 02 00 00       	add    $0x258,%eax
  31:	8b 00                	mov    (%eax),%eax
  33:	89 44 24 08          	mov    %eax,0x8(%esp)
  37:	c7 44 24 04 56 08 00 	movl   $0x856,0x4(%esp)
  3e:	00 
  3f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  46:	e8 55 04 00 00       	call   4a0 <printf>
	sbrk(-4096);
  4b:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  52:	e8 4a 03 00 00       	call   3a1 <sbrk>
	a[10]=11;
  57:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5b:	83 c0 28             	add    $0x28,%eax
  5e:	c7 00 0b 00 00 00    	movl   $0xb,(%eax)
	printf(2,"%d\n",a[10]); 
  64:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  68:	83 c0 28             	add    $0x28,%eax
  6b:	8b 00                	mov    (%eax),%eax
  6d:	89 44 24 08          	mov    %eax,0x8(%esp)
  71:	c7 44 24 04 56 08 00 	movl   $0x856,0x4(%esp)
  78:	00 
  79:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  80:	e8 1b 04 00 00       	call   4a0 <printf>
    /*a[1030]=10;
	printf(2,"ASDASD\n"); */
	sbrk(4096);
  85:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  8c:	e8 10 03 00 00       	call   3a1 <sbrk>
	char* ls[1];
	ls[0]=argv[1];
  91:	8b 45 0c             	mov    0xc(%ebp),%eax
  94:	8b 40 04             	mov    0x4(%eax),%eax
  97:	89 44 24 18          	mov    %eax,0x18(%esp)
	if (fork()!=0)
  9b:	e8 71 02 00 00       	call   311 <fork>
  a0:	85 c0                	test   %eax,%eax
  a2:	74 14                	je     b8 <main+0xb8>
		exec(ls[0],ls);
  a4:	8b 44 24 18          	mov    0x18(%esp),%eax
  a8:	8d 54 24 18          	lea    0x18(%esp),%edx
  ac:	89 54 24 04          	mov    %edx,0x4(%esp)
  b0:	89 04 24             	mov    %eax,(%esp)
  b3:	e8 99 02 00 00       	call   351 <exec>
	wait();
  b8:	e8 64 02 00 00       	call   321 <wait>
	exit();
  bd:	e8 57 02 00 00       	call   319 <exit>

000000c2 <stosb>:
  c2:	55                   	push   %ebp
  c3:	89 e5                	mov    %esp,%ebp
  c5:	57                   	push   %edi
  c6:	53                   	push   %ebx
  c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ca:	8b 55 10             	mov    0x10(%ebp),%edx
  cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  d0:	89 cb                	mov    %ecx,%ebx
  d2:	89 df                	mov    %ebx,%edi
  d4:	89 d1                	mov    %edx,%ecx
  d6:	fc                   	cld    
  d7:	f3 aa                	rep stos %al,%es:(%edi)
  d9:	89 ca                	mov    %ecx,%edx
  db:	89 fb                	mov    %edi,%ebx
  dd:	89 5d 08             	mov    %ebx,0x8(%ebp)
  e0:	89 55 10             	mov    %edx,0x10(%ebp)
  e3:	90                   	nop
  e4:	5b                   	pop    %ebx
  e5:	5f                   	pop    %edi
  e6:	5d                   	pop    %ebp
  e7:	c3                   	ret    

000000e8 <strcpy>:
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	83 ec 10             	sub    $0x10,%esp
  ee:	8b 45 08             	mov    0x8(%ebp),%eax
  f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  f4:	90                   	nop
  f5:	8b 45 08             	mov    0x8(%ebp),%eax
  f8:	8d 50 01             	lea    0x1(%eax),%edx
  fb:	89 55 08             	mov    %edx,0x8(%ebp)
  fe:	8b 55 0c             	mov    0xc(%ebp),%edx
 101:	8d 4a 01             	lea    0x1(%edx),%ecx
 104:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 107:	0f b6 12             	movzbl (%edx),%edx
 10a:	88 10                	mov    %dl,(%eax)
 10c:	0f b6 00             	movzbl (%eax),%eax
 10f:	84 c0                	test   %al,%al
 111:	75 e2                	jne    f5 <strcpy+0xd>
 113:	8b 45 fc             	mov    -0x4(%ebp),%eax
 116:	c9                   	leave  
 117:	c3                   	ret    

00000118 <strcmp>:
 118:	55                   	push   %ebp
 119:	89 e5                	mov    %esp,%ebp
 11b:	eb 08                	jmp    125 <strcmp+0xd>
 11d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 121:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	0f b6 00             	movzbl (%eax),%eax
 12b:	84 c0                	test   %al,%al
 12d:	74 10                	je     13f <strcmp+0x27>
 12f:	8b 45 08             	mov    0x8(%ebp),%eax
 132:	0f b6 10             	movzbl (%eax),%edx
 135:	8b 45 0c             	mov    0xc(%ebp),%eax
 138:	0f b6 00             	movzbl (%eax),%eax
 13b:	38 c2                	cmp    %al,%dl
 13d:	74 de                	je     11d <strcmp+0x5>
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	0f b6 00             	movzbl (%eax),%eax
 145:	0f b6 d0             	movzbl %al,%edx
 148:	8b 45 0c             	mov    0xc(%ebp),%eax
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	0f b6 c0             	movzbl %al,%eax
 151:	29 c2                	sub    %eax,%edx
 153:	89 d0                	mov    %edx,%eax
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    

00000157 <strlen>:
 157:	55                   	push   %ebp
 158:	89 e5                	mov    %esp,%ebp
 15a:	83 ec 10             	sub    $0x10,%esp
 15d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 164:	eb 04                	jmp    16a <strlen+0x13>
 166:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 16a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	01 d0                	add    %edx,%eax
 172:	0f b6 00             	movzbl (%eax),%eax
 175:	84 c0                	test   %al,%al
 177:	75 ed                	jne    166 <strlen+0xf>
 179:	8b 45 fc             	mov    -0x4(%ebp),%eax
 17c:	c9                   	leave  
 17d:	c3                   	ret    

0000017e <memset>:
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	8b 45 10             	mov    0x10(%ebp),%eax
 184:	50                   	push   %eax
 185:	ff 75 0c             	pushl  0xc(%ebp)
 188:	ff 75 08             	pushl  0x8(%ebp)
 18b:	e8 32 ff ff ff       	call   c2 <stosb>
 190:	83 c4 0c             	add    $0xc,%esp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	c9                   	leave  
 197:	c3                   	ret    

00000198 <strchr>:
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a1:	88 45 fc             	mov    %al,-0x4(%ebp)
 1a4:	eb 14                	jmp    1ba <strchr+0x22>
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	0f b6 00             	movzbl (%eax),%eax
 1ac:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1af:	75 05                	jne    1b6 <strchr+0x1e>
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	eb 13                	jmp    1c9 <strchr+0x31>
 1b6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	0f b6 00             	movzbl (%eax),%eax
 1c0:	84 c0                	test   %al,%al
 1c2:	75 e2                	jne    1a6 <strchr+0xe>
 1c4:	b8 00 00 00 00       	mov    $0x0,%eax
 1c9:	c9                   	leave  
 1ca:	c3                   	ret    

000001cb <gets>:
 1cb:	55                   	push   %ebp
 1cc:	89 e5                	mov    %esp,%ebp
 1ce:	83 ec 18             	sub    $0x18,%esp
 1d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d8:	eb 42                	jmp    21c <gets+0x51>
 1da:	83 ec 04             	sub    $0x4,%esp
 1dd:	6a 01                	push   $0x1
 1df:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e2:	50                   	push   %eax
 1e3:	6a 00                	push   $0x0
 1e5:	e8 47 01 00 00       	call   331 <read>
 1ea:	83 c4 10             	add    $0x10,%esp
 1ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1f4:	7e 33                	jle    229 <gets+0x5e>
 1f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f9:	8d 50 01             	lea    0x1(%eax),%edx
 1fc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1ff:	89 c2                	mov    %eax,%edx
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	01 c2                	add    %eax,%edx
 206:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20a:	88 02                	mov    %al,(%edx)
 20c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 210:	3c 0a                	cmp    $0xa,%al
 212:	74 16                	je     22a <gets+0x5f>
 214:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 218:	3c 0d                	cmp    $0xd,%al
 21a:	74 0e                	je     22a <gets+0x5f>
 21c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21f:	83 c0 01             	add    $0x1,%eax
 222:	3b 45 0c             	cmp    0xc(%ebp),%eax
 225:	7c b3                	jl     1da <gets+0xf>
 227:	eb 01                	jmp    22a <gets+0x5f>
 229:	90                   	nop
 22a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	01 d0                	add    %edx,%eax
 232:	c6 00 00             	movb   $0x0,(%eax)
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	c9                   	leave  
 239:	c3                   	ret    

0000023a <stat>:
 23a:	55                   	push   %ebp
 23b:	89 e5                	mov    %esp,%ebp
 23d:	83 ec 18             	sub    $0x18,%esp
 240:	83 ec 08             	sub    $0x8,%esp
 243:	6a 00                	push   $0x0
 245:	ff 75 08             	pushl  0x8(%ebp)
 248:	e8 0c 01 00 00       	call   359 <open>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	89 45 f4             	mov    %eax,-0xc(%ebp)
 253:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 257:	79 07                	jns    260 <stat+0x26>
 259:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 25e:	eb 25                	jmp    285 <stat+0x4b>
 260:	83 ec 08             	sub    $0x8,%esp
 263:	ff 75 0c             	pushl  0xc(%ebp)
 266:	ff 75 f4             	pushl  -0xc(%ebp)
 269:	e8 03 01 00 00       	call   371 <fstat>
 26e:	83 c4 10             	add    $0x10,%esp
 271:	89 45 f0             	mov    %eax,-0x10(%ebp)
 274:	83 ec 0c             	sub    $0xc,%esp
 277:	ff 75 f4             	pushl  -0xc(%ebp)
 27a:	e8 c2 00 00 00       	call   341 <close>
 27f:	83 c4 10             	add    $0x10,%esp
 282:	8b 45 f0             	mov    -0x10(%ebp),%eax
 285:	c9                   	leave  
 286:	c3                   	ret    

00000287 <atoi>:
 287:	55                   	push   %ebp
 288:	89 e5                	mov    %esp,%ebp
 28a:	83 ec 10             	sub    $0x10,%esp
 28d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 294:	eb 25                	jmp    2bb <atoi+0x34>
 296:	8b 55 fc             	mov    -0x4(%ebp),%edx
 299:	89 d0                	mov    %edx,%eax
 29b:	c1 e0 02             	shl    $0x2,%eax
 29e:	01 d0                	add    %edx,%eax
 2a0:	01 c0                	add    %eax,%eax
 2a2:	89 c1                	mov    %eax,%ecx
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	8d 50 01             	lea    0x1(%eax),%edx
 2aa:	89 55 08             	mov    %edx,0x8(%ebp)
 2ad:	0f b6 00             	movzbl (%eax),%eax
 2b0:	0f be c0             	movsbl %al,%eax
 2b3:	01 c8                	add    %ecx,%eax
 2b5:	83 e8 30             	sub    $0x30,%eax
 2b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	0f b6 00             	movzbl (%eax),%eax
 2c1:	3c 2f                	cmp    $0x2f,%al
 2c3:	7e 0a                	jle    2cf <atoi+0x48>
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
 2c8:	0f b6 00             	movzbl (%eax),%eax
 2cb:	3c 39                	cmp    $0x39,%al
 2cd:	7e c7                	jle    296 <atoi+0xf>
 2cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2d2:	c9                   	leave  
 2d3:	c3                   	ret    

000002d4 <memmove>:
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	83 ec 10             	sub    $0x10,%esp
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2e6:	eb 17                	jmp    2ff <memmove+0x2b>
 2e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2eb:	8d 50 01             	lea    0x1(%eax),%edx
 2ee:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2f4:	8d 4a 01             	lea    0x1(%edx),%ecx
 2f7:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2fa:	0f b6 12             	movzbl (%edx),%edx
 2fd:	88 10                	mov    %dl,(%eax)
 2ff:	8b 45 10             	mov    0x10(%ebp),%eax
 302:	8d 50 ff             	lea    -0x1(%eax),%edx
 305:	89 55 10             	mov    %edx,0x10(%ebp)
 308:	85 c0                	test   %eax,%eax
 30a:	7f dc                	jg     2e8 <memmove+0x14>
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	c9                   	leave  
 310:	c3                   	ret    

00000311 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 311:	b8 01 00 00 00       	mov    $0x1,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <exit>:
SYSCALL(exit)
 319:	b8 02 00 00 00       	mov    $0x2,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <wait>:
SYSCALL(wait)
 321:	b8 03 00 00 00       	mov    $0x3,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <pipe>:
SYSCALL(pipe)
 329:	b8 04 00 00 00       	mov    $0x4,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <read>:
SYSCALL(read)
 331:	b8 05 00 00 00       	mov    $0x5,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <write>:
SYSCALL(write)
 339:	b8 10 00 00 00       	mov    $0x10,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <close>:
SYSCALL(close)
 341:	b8 15 00 00 00       	mov    $0x15,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <kill>:
SYSCALL(kill)
 349:	b8 06 00 00 00       	mov    $0x6,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <exec>:
SYSCALL(exec)
 351:	b8 07 00 00 00       	mov    $0x7,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <open>:
SYSCALL(open)
 359:	b8 0f 00 00 00       	mov    $0xf,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <mknod>:
SYSCALL(mknod)
 361:	b8 11 00 00 00       	mov    $0x11,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <unlink>:
SYSCALL(unlink)
 369:	b8 12 00 00 00       	mov    $0x12,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <fstat>:
SYSCALL(fstat)
 371:	b8 08 00 00 00       	mov    $0x8,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <link>:
SYSCALL(link)
 379:	b8 13 00 00 00       	mov    $0x13,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <mkdir>:
SYSCALL(mkdir)
 381:	b8 14 00 00 00       	mov    $0x14,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <chdir>:
SYSCALL(chdir)
 389:	b8 09 00 00 00       	mov    $0x9,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <dup>:
SYSCALL(dup)
 391:	b8 0a 00 00 00       	mov    $0xa,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <getpid>:
SYSCALL(getpid)
 399:	b8 0b 00 00 00       	mov    $0xb,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <sbrk>:
SYSCALL(sbrk)
 3a1:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <sleep>:
SYSCALL(sleep)
 3a9:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <uptime>:
SYSCALL(uptime)
 3b1:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <date>:
SYSCALL(date)
 3b9:	b8 16 00 00 00       	mov    $0x16,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <dup2>:
SYSCALL(dup2)
 3c1:	b8 17 00 00 00       	mov    $0x17,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <putc>:
 3c9:	55                   	push   %ebp
 3ca:	89 e5                	mov    %esp,%ebp
 3cc:	83 ec 18             	sub    $0x18,%esp
 3cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d2:	88 45 f4             	mov    %al,-0xc(%ebp)
 3d5:	83 ec 04             	sub    $0x4,%esp
 3d8:	6a 01                	push   $0x1
 3da:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3dd:	50                   	push   %eax
 3de:	ff 75 08             	pushl  0x8(%ebp)
 3e1:	e8 53 ff ff ff       	call   339 <write>
 3e6:	83 c4 10             	add    $0x10,%esp
 3e9:	90                   	nop
 3ea:	c9                   	leave  
 3eb:	c3                   	ret    

000003ec <printint>:
 3ec:	55                   	push   %ebp
 3ed:	89 e5                	mov    %esp,%ebp
 3ef:	53                   	push   %ebx
 3f0:	83 ec 24             	sub    $0x24,%esp
 3f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3fa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fe:	74 17                	je     417 <printint+0x2b>
 400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 404:	79 11                	jns    417 <printint+0x2b>
 406:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 40d:	8b 45 0c             	mov    0xc(%ebp),%eax
 410:	f7 d8                	neg    %eax
 412:	89 45 ec             	mov    %eax,-0x14(%ebp)
 415:	eb 06                	jmp    41d <printint+0x31>
 417:	8b 45 0c             	mov    0xc(%ebp),%eax
 41a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 424:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 427:	8d 41 01             	lea    0x1(%ecx),%eax
 42a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 42d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 430:	8b 45 ec             	mov    -0x14(%ebp),%eax
 433:	ba 00 00 00 00       	mov    $0x0,%edx
 438:	f7 f3                	div    %ebx
 43a:	89 d0                	mov    %edx,%eax
 43c:	0f b6 80 a4 0a 00 00 	movzbl 0xaa4(%eax),%eax
 443:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 447:	8b 5d 10             	mov    0x10(%ebp),%ebx
 44a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44d:	ba 00 00 00 00       	mov    $0x0,%edx
 452:	f7 f3                	div    %ebx
 454:	89 45 ec             	mov    %eax,-0x14(%ebp)
 457:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45b:	75 c7                	jne    424 <printint+0x38>
 45d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 461:	74 2d                	je     490 <printint+0xa4>
 463:	8b 45 f4             	mov    -0xc(%ebp),%eax
 466:	8d 50 01             	lea    0x1(%eax),%edx
 469:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 471:	eb 1d                	jmp    490 <printint+0xa4>
 473:	8d 55 dc             	lea    -0x24(%ebp),%edx
 476:	8b 45 f4             	mov    -0xc(%ebp),%eax
 479:	01 d0                	add    %edx,%eax
 47b:	0f b6 00             	movzbl (%eax),%eax
 47e:	0f be c0             	movsbl %al,%eax
 481:	83 ec 08             	sub    $0x8,%esp
 484:	50                   	push   %eax
 485:	ff 75 08             	pushl  0x8(%ebp)
 488:	e8 3c ff ff ff       	call   3c9 <putc>
 48d:	83 c4 10             	add    $0x10,%esp
 490:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 494:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 498:	79 d9                	jns    473 <printint+0x87>
 49a:	90                   	nop
 49b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 49e:	c9                   	leave  
 49f:	c3                   	ret    

000004a0 <printf>:
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	83 ec 28             	sub    $0x28,%esp
 4a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4ad:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b0:	83 c0 04             	add    $0x4,%eax
 4b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4bd:	e9 59 01 00 00       	jmp    61b <printf+0x17b>
 4c2:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c8:	01 d0                	add    %edx,%eax
 4ca:	0f b6 00             	movzbl (%eax),%eax
 4cd:	0f be c0             	movsbl %al,%eax
 4d0:	25 ff 00 00 00       	and    $0xff,%eax
 4d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4dc:	75 2c                	jne    50a <printf+0x6a>
 4de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e2:	75 0c                	jne    4f0 <printf+0x50>
 4e4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4eb:	e9 27 01 00 00       	jmp    617 <printf+0x177>
 4f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f3:	0f be c0             	movsbl %al,%eax
 4f6:	83 ec 08             	sub    $0x8,%esp
 4f9:	50                   	push   %eax
 4fa:	ff 75 08             	pushl  0x8(%ebp)
 4fd:	e8 c7 fe ff ff       	call   3c9 <putc>
 502:	83 c4 10             	add    $0x10,%esp
 505:	e9 0d 01 00 00       	jmp    617 <printf+0x177>
 50a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 50e:	0f 85 03 01 00 00    	jne    617 <printf+0x177>
 514:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 518:	75 1e                	jne    538 <printf+0x98>
 51a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51d:	8b 00                	mov    (%eax),%eax
 51f:	6a 01                	push   $0x1
 521:	6a 0a                	push   $0xa
 523:	50                   	push   %eax
 524:	ff 75 08             	pushl  0x8(%ebp)
 527:	e8 c0 fe ff ff       	call   3ec <printint>
 52c:	83 c4 10             	add    $0x10,%esp
 52f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 533:	e9 d8 00 00 00       	jmp    610 <printf+0x170>
 538:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 53c:	74 06                	je     544 <printf+0xa4>
 53e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 542:	75 1e                	jne    562 <printf+0xc2>
 544:	8b 45 e8             	mov    -0x18(%ebp),%eax
 547:	8b 00                	mov    (%eax),%eax
 549:	6a 00                	push   $0x0
 54b:	6a 10                	push   $0x10
 54d:	50                   	push   %eax
 54e:	ff 75 08             	pushl  0x8(%ebp)
 551:	e8 96 fe ff ff       	call   3ec <printint>
 556:	83 c4 10             	add    $0x10,%esp
 559:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55d:	e9 ae 00 00 00       	jmp    610 <printf+0x170>
 562:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 566:	75 43                	jne    5ab <printf+0x10b>
 568:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56b:	8b 00                	mov    (%eax),%eax
 56d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 570:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 574:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 578:	75 25                	jne    59f <printf+0xff>
 57a:	c7 45 f4 5a 08 00 00 	movl   $0x85a,-0xc(%ebp)
 581:	eb 1c                	jmp    59f <printf+0xff>
 583:	8b 45 f4             	mov    -0xc(%ebp),%eax
 586:	0f b6 00             	movzbl (%eax),%eax
 589:	0f be c0             	movsbl %al,%eax
 58c:	83 ec 08             	sub    $0x8,%esp
 58f:	50                   	push   %eax
 590:	ff 75 08             	pushl  0x8(%ebp)
 593:	e8 31 fe ff ff       	call   3c9 <putc>
 598:	83 c4 10             	add    $0x10,%esp
 59b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a2:	0f b6 00             	movzbl (%eax),%eax
 5a5:	84 c0                	test   %al,%al
 5a7:	75 da                	jne    583 <printf+0xe3>
 5a9:	eb 65                	jmp    610 <printf+0x170>
 5ab:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5af:	75 1d                	jne    5ce <printf+0x12e>
 5b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b4:	8b 00                	mov    (%eax),%eax
 5b6:	0f be c0             	movsbl %al,%eax
 5b9:	83 ec 08             	sub    $0x8,%esp
 5bc:	50                   	push   %eax
 5bd:	ff 75 08             	pushl  0x8(%ebp)
 5c0:	e8 04 fe ff ff       	call   3c9 <putc>
 5c5:	83 c4 10             	add    $0x10,%esp
 5c8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5cc:	eb 42                	jmp    610 <printf+0x170>
 5ce:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d2:	75 17                	jne    5eb <printf+0x14b>
 5d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d7:	0f be c0             	movsbl %al,%eax
 5da:	83 ec 08             	sub    $0x8,%esp
 5dd:	50                   	push   %eax
 5de:	ff 75 08             	pushl  0x8(%ebp)
 5e1:	e8 e3 fd ff ff       	call   3c9 <putc>
 5e6:	83 c4 10             	add    $0x10,%esp
 5e9:	eb 25                	jmp    610 <printf+0x170>
 5eb:	83 ec 08             	sub    $0x8,%esp
 5ee:	6a 25                	push   $0x25
 5f0:	ff 75 08             	pushl  0x8(%ebp)
 5f3:	e8 d1 fd ff ff       	call   3c9 <putc>
 5f8:	83 c4 10             	add    $0x10,%esp
 5fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fe:	0f be c0             	movsbl %al,%eax
 601:	83 ec 08             	sub    $0x8,%esp
 604:	50                   	push   %eax
 605:	ff 75 08             	pushl  0x8(%ebp)
 608:	e8 bc fd ff ff       	call   3c9 <putc>
 60d:	83 c4 10             	add    $0x10,%esp
 610:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 617:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 61b:	8b 55 0c             	mov    0xc(%ebp),%edx
 61e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 621:	01 d0                	add    %edx,%eax
 623:	0f b6 00             	movzbl (%eax),%eax
 626:	84 c0                	test   %al,%al
 628:	0f 85 94 fe ff ff    	jne    4c2 <printf+0x22>
 62e:	90                   	nop
 62f:	c9                   	leave  
 630:	c3                   	ret    

00000631 <free>:
 631:	55                   	push   %ebp
 632:	89 e5                	mov    %esp,%ebp
 634:	83 ec 10             	sub    $0x10,%esp
 637:	8b 45 08             	mov    0x8(%ebp),%eax
 63a:	83 e8 08             	sub    $0x8,%eax
 63d:	89 45 f8             	mov    %eax,-0x8(%ebp)
 640:	a1 c0 0a 00 00       	mov    0xac0,%eax
 645:	89 45 fc             	mov    %eax,-0x4(%ebp)
 648:	eb 24                	jmp    66e <free+0x3d>
 64a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64d:	8b 00                	mov    (%eax),%eax
 64f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 652:	77 12                	ja     666 <free+0x35>
 654:	8b 45 f8             	mov    -0x8(%ebp),%eax
 657:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65a:	77 24                	ja     680 <free+0x4f>
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 664:	77 1a                	ja     680 <free+0x4f>
 666:	8b 45 fc             	mov    -0x4(%ebp),%eax
 669:	8b 00                	mov    (%eax),%eax
 66b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 674:	76 d4                	jbe    64a <free+0x19>
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	8b 00                	mov    (%eax),%eax
 67b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67e:	76 ca                	jbe    64a <free+0x19>
 680:	8b 45 f8             	mov    -0x8(%ebp),%eax
 683:	8b 40 04             	mov    0x4(%eax),%eax
 686:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	01 c2                	add    %eax,%edx
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	8b 00                	mov    (%eax),%eax
 697:	39 c2                	cmp    %eax,%edx
 699:	75 24                	jne    6bf <free+0x8e>
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	8b 50 04             	mov    0x4(%eax),%edx
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	01 c2                	add    %eax,%edx
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	89 50 04             	mov    %edx,0x4(%eax)
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 00                	mov    (%eax),%eax
 6b6:	8b 10                	mov    (%eax),%edx
 6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bb:	89 10                	mov    %edx,(%eax)
 6bd:	eb 0a                	jmp    6c9 <free+0x98>
 6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c2:	8b 10                	mov    (%eax),%edx
 6c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c7:	89 10                	mov    %edx,(%eax)
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 40 04             	mov    0x4(%eax),%eax
 6cf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d9:	01 d0                	add    %edx,%eax
 6db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6de:	75 20                	jne    700 <free+0xcf>
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	8b 50 04             	mov    0x4(%eax),%edx
 6e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e9:	8b 40 04             	mov    0x4(%eax),%eax
 6ec:	01 c2                	add    %eax,%edx
 6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f1:	89 50 04             	mov    %edx,0x4(%eax)
 6f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f7:	8b 10                	mov    (%eax),%edx
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	89 10                	mov    %edx,(%eax)
 6fe:	eb 08                	jmp    708 <free+0xd7>
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	8b 55 f8             	mov    -0x8(%ebp),%edx
 706:	89 10                	mov    %edx,(%eax)
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	a3 c0 0a 00 00       	mov    %eax,0xac0
 710:	90                   	nop
 711:	c9                   	leave  
 712:	c3                   	ret    

00000713 <morecore>:
 713:	55                   	push   %ebp
 714:	89 e5                	mov    %esp,%ebp
 716:	83 ec 18             	sub    $0x18,%esp
 719:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 720:	77 07                	ja     729 <morecore+0x16>
 722:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 729:	8b 45 08             	mov    0x8(%ebp),%eax
 72c:	c1 e0 03             	shl    $0x3,%eax
 72f:	83 ec 0c             	sub    $0xc,%esp
 732:	50                   	push   %eax
 733:	e8 69 fc ff ff       	call   3a1 <sbrk>
 738:	83 c4 10             	add    $0x10,%esp
 73b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 73e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 742:	75 07                	jne    74b <morecore+0x38>
 744:	b8 00 00 00 00       	mov    $0x0,%eax
 749:	eb 26                	jmp    771 <morecore+0x5e>
 74b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 751:	8b 45 f0             	mov    -0x10(%ebp),%eax
 754:	8b 55 08             	mov    0x8(%ebp),%edx
 757:	89 50 04             	mov    %edx,0x4(%eax)
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	83 c0 08             	add    $0x8,%eax
 760:	83 ec 0c             	sub    $0xc,%esp
 763:	50                   	push   %eax
 764:	e8 c8 fe ff ff       	call   631 <free>
 769:	83 c4 10             	add    $0x10,%esp
 76c:	a1 c0 0a 00 00       	mov    0xac0,%eax
 771:	c9                   	leave  
 772:	c3                   	ret    

00000773 <malloc>:
 773:	55                   	push   %ebp
 774:	89 e5                	mov    %esp,%ebp
 776:	83 ec 18             	sub    $0x18,%esp
 779:	8b 45 08             	mov    0x8(%ebp),%eax
 77c:	83 c0 07             	add    $0x7,%eax
 77f:	c1 e8 03             	shr    $0x3,%eax
 782:	83 c0 01             	add    $0x1,%eax
 785:	89 45 ec             	mov    %eax,-0x14(%ebp)
 788:	a1 c0 0a 00 00       	mov    0xac0,%eax
 78d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 790:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 794:	75 23                	jne    7b9 <malloc+0x46>
 796:	c7 45 f0 b8 0a 00 00 	movl   $0xab8,-0x10(%ebp)
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	a3 c0 0a 00 00       	mov    %eax,0xac0
 7a5:	a1 c0 0a 00 00       	mov    0xac0,%eax
 7aa:	a3 b8 0a 00 00       	mov    %eax,0xab8
 7af:	c7 05 bc 0a 00 00 00 	movl   $0x0,0xabc
 7b6:	00 00 00 
 7b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bc:	8b 00                	mov    (%eax),%eax
 7be:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	8b 40 04             	mov    0x4(%eax),%eax
 7c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ca:	72 4d                	jb     819 <malloc+0xa6>
 7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cf:	8b 40 04             	mov    0x4(%eax),%eax
 7d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d5:	75 0c                	jne    7e3 <malloc+0x70>
 7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7da:	8b 10                	mov    (%eax),%edx
 7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7df:	89 10                	mov    %edx,(%eax)
 7e1:	eb 26                	jmp    809 <malloc+0x96>
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 40 04             	mov    0x4(%eax),%eax
 7e9:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ec:	89 c2                	mov    %eax,%edx
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	89 50 04             	mov    %edx,0x4(%eax)
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	c1 e0 03             	shl    $0x3,%eax
 7fd:	01 45 f4             	add    %eax,-0xc(%ebp)
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	8b 55 ec             	mov    -0x14(%ebp),%edx
 806:	89 50 04             	mov    %edx,0x4(%eax)
 809:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80c:	a3 c0 0a 00 00       	mov    %eax,0xac0
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	83 c0 08             	add    $0x8,%eax
 817:	eb 3b                	jmp    854 <malloc+0xe1>
 819:	a1 c0 0a 00 00       	mov    0xac0,%eax
 81e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 821:	75 1e                	jne    841 <malloc+0xce>
 823:	83 ec 0c             	sub    $0xc,%esp
 826:	ff 75 ec             	pushl  -0x14(%ebp)
 829:	e8 e5 fe ff ff       	call   713 <morecore>
 82e:	83 c4 10             	add    $0x10,%esp
 831:	89 45 f4             	mov    %eax,-0xc(%ebp)
 834:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 838:	75 07                	jne    841 <malloc+0xce>
 83a:	b8 00 00 00 00       	mov    $0x0,%eax
 83f:	eb 13                	jmp    854 <malloc+0xe1>
 841:	8b 45 f4             	mov    -0xc(%ebp),%eax
 844:	89 45 f0             	mov    %eax,-0x10(%ebp)
 847:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84a:	8b 00                	mov    (%eax),%eax
 84c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 84f:	e9 6d ff ff ff       	jmp    7c1 <malloc+0x4e>
 854:	c9                   	leave  
 855:	c3                   	ret    
