
_dup2:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:



int 
main(int argc, char* argv[]) 
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
    int fd = open("ls", O_RDWR);
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 e5 07 00 00       	push   $0x7e5
  1b:	e8 c8 02 00 00       	call   2e8 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int *buf=(int*)sbrk(8192);
  26:	83 ec 0c             	sub    $0xc,%esp
  29:	68 00 20 00 00       	push   $0x2000
  2e:	e8 fd 02 00 00       	call   330 <sbrk>
  33:	83 c4 10             	add    $0x10,%esp
  36:	89 45 f0             	mov    %eax,-0x10(%ebp)
    read(fd,buf,100);
  39:	83 ec 04             	sub    $0x4,%esp
  3c:	6a 64                	push   $0x64
  3e:	ff 75 f0             	pushl  -0x10(%ebp)
  41:	ff 75 f4             	pushl  -0xc(%ebp)
  44:	e8 77 02 00 00       	call   2c0 <read>
  49:	83 c4 10             	add    $0x10,%esp
    exit();
  4c:	e8 57 02 00 00       	call   2a8 <exit>

00000051 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  51:	55                   	push   %ebp
  52:	89 e5                	mov    %esp,%ebp
  54:	57                   	push   %edi
  55:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  56:	8b 4d 08             	mov    0x8(%ebp),%ecx
  59:	8b 55 10             	mov    0x10(%ebp),%edx
  5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  5f:	89 cb                	mov    %ecx,%ebx
  61:	89 df                	mov    %ebx,%edi
  63:	89 d1                	mov    %edx,%ecx
  65:	fc                   	cld    
  66:	f3 aa                	rep stos %al,%es:(%edi)
  68:	89 ca                	mov    %ecx,%edx
  6a:	89 fb                	mov    %edi,%ebx
  6c:	89 5d 08             	mov    %ebx,0x8(%ebp)
  6f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  72:	90                   	nop
  73:	5b                   	pop    %ebx
  74:	5f                   	pop    %edi
  75:	5d                   	pop    %ebp
  76:	c3                   	ret    

00000077 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  77:	55                   	push   %ebp
  78:	89 e5                	mov    %esp,%ebp
  7a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  7d:	8b 45 08             	mov    0x8(%ebp),%eax
  80:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  83:	90                   	nop
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8d 50 01             	lea    0x1(%eax),%edx
  8a:	89 55 08             	mov    %edx,0x8(%ebp)
  8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  90:	8d 4a 01             	lea    0x1(%edx),%ecx
  93:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  96:	0f b6 12             	movzbl (%edx),%edx
  99:	88 10                	mov    %dl,(%eax)
  9b:	0f b6 00             	movzbl (%eax),%eax
  9e:	84 c0                	test   %al,%al
  a0:	75 e2                	jne    84 <strcpy+0xd>
    ;
  return os;
  a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  a5:	c9                   	leave  
  a6:	c3                   	ret    

000000a7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a7:	55                   	push   %ebp
  a8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  aa:	eb 08                	jmp    b4 <strcmp+0xd>
    p++, q++;
  ac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b4:	8b 45 08             	mov    0x8(%ebp),%eax
  b7:	0f b6 00             	movzbl (%eax),%eax
  ba:	84 c0                	test   %al,%al
  bc:	74 10                	je     ce <strcmp+0x27>
  be:	8b 45 08             	mov    0x8(%ebp),%eax
  c1:	0f b6 10             	movzbl (%eax),%edx
  c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  c7:	0f b6 00             	movzbl (%eax),%eax
  ca:	38 c2                	cmp    %al,%dl
  cc:	74 de                	je     ac <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ce:	8b 45 08             	mov    0x8(%ebp),%eax
  d1:	0f b6 00             	movzbl (%eax),%eax
  d4:	0f b6 d0             	movzbl %al,%edx
  d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	0f b6 c0             	movzbl %al,%eax
  e0:	29 c2                	sub    %eax,%edx
  e2:	89 d0                	mov    %edx,%eax
}
  e4:	5d                   	pop    %ebp
  e5:	c3                   	ret    

000000e6 <strlen>:

uint
strlen(char *s)
{
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  e9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  f3:	eb 04                	jmp    f9 <strlen+0x13>
  f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	01 d0                	add    %edx,%eax
 101:	0f b6 00             	movzbl (%eax),%eax
 104:	84 c0                	test   %al,%al
 106:	75 ed                	jne    f5 <strlen+0xf>
    ;
  return n;
 108:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 10b:	c9                   	leave  
 10c:	c3                   	ret    

0000010d <memset>:

void*
memset(void *dst, int c, uint n)
{
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 110:	8b 45 10             	mov    0x10(%ebp),%eax
 113:	50                   	push   %eax
 114:	ff 75 0c             	pushl  0xc(%ebp)
 117:	ff 75 08             	pushl  0x8(%ebp)
 11a:	e8 32 ff ff ff       	call   51 <stosb>
 11f:	83 c4 0c             	add    $0xc,%esp
  return dst;
 122:	8b 45 08             	mov    0x8(%ebp),%eax
}
 125:	c9                   	leave  
 126:	c3                   	ret    

00000127 <strchr>:

char*
strchr(const char *s, char c)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 04             	sub    $0x4,%esp
 12d:	8b 45 0c             	mov    0xc(%ebp),%eax
 130:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 133:	eb 14                	jmp    149 <strchr+0x22>
    if(*s == c)
 135:	8b 45 08             	mov    0x8(%ebp),%eax
 138:	0f b6 00             	movzbl (%eax),%eax
 13b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 13e:	75 05                	jne    145 <strchr+0x1e>
      return (char*)s;
 140:	8b 45 08             	mov    0x8(%ebp),%eax
 143:	eb 13                	jmp    158 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 145:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	0f b6 00             	movzbl (%eax),%eax
 14f:	84 c0                	test   %al,%al
 151:	75 e2                	jne    135 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 153:	b8 00 00 00 00       	mov    $0x0,%eax
}
 158:	c9                   	leave  
 159:	c3                   	ret    

0000015a <gets>:

char*
gets(char *buf, int max)
{
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
 15d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 160:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 167:	eb 42                	jmp    1ab <gets+0x51>
    cc = read(0, &c, 1);
 169:	83 ec 04             	sub    $0x4,%esp
 16c:	6a 01                	push   $0x1
 16e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 171:	50                   	push   %eax
 172:	6a 00                	push   $0x0
 174:	e8 47 01 00 00       	call   2c0 <read>
 179:	83 c4 10             	add    $0x10,%esp
 17c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 17f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 183:	7e 33                	jle    1b8 <gets+0x5e>
      break;
    buf[i++] = c;
 185:	8b 45 f4             	mov    -0xc(%ebp),%eax
 188:	8d 50 01             	lea    0x1(%eax),%edx
 18b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 18e:	89 c2                	mov    %eax,%edx
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	01 c2                	add    %eax,%edx
 195:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 199:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 19b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 19f:	3c 0a                	cmp    $0xa,%al
 1a1:	74 16                	je     1b9 <gets+0x5f>
 1a3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a7:	3c 0d                	cmp    $0xd,%al
 1a9:	74 0e                	je     1b9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ae:	83 c0 01             	add    $0x1,%eax
 1b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1b4:	7c b3                	jl     169 <gets+0xf>
 1b6:	eb 01                	jmp    1b9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1b8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
 1bf:	01 d0                	add    %edx,%eax
 1c1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1c7:	c9                   	leave  
 1c8:	c3                   	ret    

000001c9 <stat>:

int
stat(char *n, struct stat *st)
{
 1c9:	55                   	push   %ebp
 1ca:	89 e5                	mov    %esp,%ebp
 1cc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1cf:	83 ec 08             	sub    $0x8,%esp
 1d2:	6a 00                	push   $0x0
 1d4:	ff 75 08             	pushl  0x8(%ebp)
 1d7:	e8 0c 01 00 00       	call   2e8 <open>
 1dc:	83 c4 10             	add    $0x10,%esp
 1df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1e6:	79 07                	jns    1ef <stat+0x26>
    return -1;
 1e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ed:	eb 25                	jmp    214 <stat+0x4b>
  r = fstat(fd, st);
 1ef:	83 ec 08             	sub    $0x8,%esp
 1f2:	ff 75 0c             	pushl  0xc(%ebp)
 1f5:	ff 75 f4             	pushl  -0xc(%ebp)
 1f8:	e8 03 01 00 00       	call   300 <fstat>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 203:	83 ec 0c             	sub    $0xc,%esp
 206:	ff 75 f4             	pushl  -0xc(%ebp)
 209:	e8 c2 00 00 00       	call   2d0 <close>
 20e:	83 c4 10             	add    $0x10,%esp
  return r;
 211:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 214:	c9                   	leave  
 215:	c3                   	ret    

00000216 <atoi>:

int
atoi(const char *s)
{
 216:	55                   	push   %ebp
 217:	89 e5                	mov    %esp,%ebp
 219:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 21c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 223:	eb 25                	jmp    24a <atoi+0x34>
    n = n*10 + *s++ - '0';
 225:	8b 55 fc             	mov    -0x4(%ebp),%edx
 228:	89 d0                	mov    %edx,%eax
 22a:	c1 e0 02             	shl    $0x2,%eax
 22d:	01 d0                	add    %edx,%eax
 22f:	01 c0                	add    %eax,%eax
 231:	89 c1                	mov    %eax,%ecx
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	8d 50 01             	lea    0x1(%eax),%edx
 239:	89 55 08             	mov    %edx,0x8(%ebp)
 23c:	0f b6 00             	movzbl (%eax),%eax
 23f:	0f be c0             	movsbl %al,%eax
 242:	01 c8                	add    %ecx,%eax
 244:	83 e8 30             	sub    $0x30,%eax
 247:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	3c 2f                	cmp    $0x2f,%al
 252:	7e 0a                	jle    25e <atoi+0x48>
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	0f b6 00             	movzbl (%eax),%eax
 25a:	3c 39                	cmp    $0x39,%al
 25c:	7e c7                	jle    225 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 25e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 261:	c9                   	leave  
 262:	c3                   	ret    

00000263 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 263:	55                   	push   %ebp
 264:	89 e5                	mov    %esp,%ebp
 266:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 26f:	8b 45 0c             	mov    0xc(%ebp),%eax
 272:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 275:	eb 17                	jmp    28e <memmove+0x2b>
    *dst++ = *src++;
 277:	8b 45 fc             	mov    -0x4(%ebp),%eax
 27a:	8d 50 01             	lea    0x1(%eax),%edx
 27d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 280:	8b 55 f8             	mov    -0x8(%ebp),%edx
 283:	8d 4a 01             	lea    0x1(%edx),%ecx
 286:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 289:	0f b6 12             	movzbl (%edx),%edx
 28c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	8b 45 10             	mov    0x10(%ebp),%eax
 291:	8d 50 ff             	lea    -0x1(%eax),%edx
 294:	89 55 10             	mov    %edx,0x10(%ebp)
 297:	85 c0                	test   %eax,%eax
 299:	7f dc                	jg     277 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 29e:	c9                   	leave  
 29f:	c3                   	ret    

000002a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a0:	b8 01 00 00 00       	mov    $0x1,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <exit>:
SYSCALL(exit)
 2a8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <wait>:
SYSCALL(wait)
 2b0:	b8 03 00 00 00       	mov    $0x3,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <pipe>:
SYSCALL(pipe)
 2b8:	b8 04 00 00 00       	mov    $0x4,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <read>:
SYSCALL(read)
 2c0:	b8 05 00 00 00       	mov    $0x5,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <write>:
SYSCALL(write)
 2c8:	b8 10 00 00 00       	mov    $0x10,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <close>:
SYSCALL(close)
 2d0:	b8 15 00 00 00       	mov    $0x15,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <kill>:
SYSCALL(kill)
 2d8:	b8 06 00 00 00       	mov    $0x6,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exec>:
SYSCALL(exec)
 2e0:	b8 07 00 00 00       	mov    $0x7,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <open>:
SYSCALL(open)
 2e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mknod>:
SYSCALL(mknod)
 2f0:	b8 11 00 00 00       	mov    $0x11,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <unlink>:
SYSCALL(unlink)
 2f8:	b8 12 00 00 00       	mov    $0x12,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <fstat>:
SYSCALL(fstat)
 300:	b8 08 00 00 00       	mov    $0x8,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <link>:
SYSCALL(link)
 308:	b8 13 00 00 00       	mov    $0x13,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mkdir>:
SYSCALL(mkdir)
 310:	b8 14 00 00 00       	mov    $0x14,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <chdir>:
SYSCALL(chdir)
 318:	b8 09 00 00 00       	mov    $0x9,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <dup>:
SYSCALL(dup)
 320:	b8 0a 00 00 00       	mov    $0xa,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <getpid>:
SYSCALL(getpid)
 328:	b8 0b 00 00 00       	mov    $0xb,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <sbrk>:
SYSCALL(sbrk)
 330:	b8 0c 00 00 00       	mov    $0xc,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <sleep>:
SYSCALL(sleep)
 338:	b8 0d 00 00 00       	mov    $0xd,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <uptime>:
SYSCALL(uptime)
 340:	b8 0e 00 00 00       	mov    $0xe,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <date>:
SYSCALL(date)
 348:	b8 16 00 00 00       	mov    $0x16,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <dup2>:
SYSCALL(dup2)
 350:	b8 17 00 00 00       	mov    $0x17,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 358:	55                   	push   %ebp
 359:	89 e5                	mov    %esp,%ebp
 35b:	83 ec 18             	sub    $0x18,%esp
 35e:	8b 45 0c             	mov    0xc(%ebp),%eax
 361:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 364:	83 ec 04             	sub    $0x4,%esp
 367:	6a 01                	push   $0x1
 369:	8d 45 f4             	lea    -0xc(%ebp),%eax
 36c:	50                   	push   %eax
 36d:	ff 75 08             	pushl  0x8(%ebp)
 370:	e8 53 ff ff ff       	call   2c8 <write>
 375:	83 c4 10             	add    $0x10,%esp
}
 378:	90                   	nop
 379:	c9                   	leave  
 37a:	c3                   	ret    

0000037b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 37b:	55                   	push   %ebp
 37c:	89 e5                	mov    %esp,%ebp
 37e:	53                   	push   %ebx
 37f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 382:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 389:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 38d:	74 17                	je     3a6 <printint+0x2b>
 38f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 393:	79 11                	jns    3a6 <printint+0x2b>
    neg = 1;
 395:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 39c:	8b 45 0c             	mov    0xc(%ebp),%eax
 39f:	f7 d8                	neg    %eax
 3a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3a4:	eb 06                	jmp    3ac <printint+0x31>
  } else {
    x = xx;
 3a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3b3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3b6:	8d 41 01             	lea    0x1(%ecx),%eax
 3b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c2:	ba 00 00 00 00       	mov    $0x0,%edx
 3c7:	f7 f3                	div    %ebx
 3c9:	89 d0                	mov    %edx,%eax
 3cb:	0f b6 80 38 0a 00 00 	movzbl 0xa38(%eax),%eax
 3d2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3dc:	ba 00 00 00 00       	mov    $0x0,%edx
 3e1:	f7 f3                	div    %ebx
 3e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ea:	75 c7                	jne    3b3 <printint+0x38>
  if(neg)
 3ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f0:	74 2d                	je     41f <printint+0xa4>
    buf[i++] = '-';
 3f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f5:	8d 50 01             	lea    0x1(%eax),%edx
 3f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3fb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 400:	eb 1d                	jmp    41f <printint+0xa4>
    putc(fd, buf[i]);
 402:	8d 55 dc             	lea    -0x24(%ebp),%edx
 405:	8b 45 f4             	mov    -0xc(%ebp),%eax
 408:	01 d0                	add    %edx,%eax
 40a:	0f b6 00             	movzbl (%eax),%eax
 40d:	0f be c0             	movsbl %al,%eax
 410:	83 ec 08             	sub    $0x8,%esp
 413:	50                   	push   %eax
 414:	ff 75 08             	pushl  0x8(%ebp)
 417:	e8 3c ff ff ff       	call   358 <putc>
 41c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 41f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 423:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 427:	79 d9                	jns    402 <printint+0x87>
    putc(fd, buf[i]);
}
 429:	90                   	nop
 42a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 42d:	c9                   	leave  
 42e:	c3                   	ret    

0000042f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 42f:	55                   	push   %ebp
 430:	89 e5                	mov    %esp,%ebp
 432:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 435:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 43c:	8d 45 0c             	lea    0xc(%ebp),%eax
 43f:	83 c0 04             	add    $0x4,%eax
 442:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 445:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 44c:	e9 59 01 00 00       	jmp    5aa <printf+0x17b>
    c = fmt[i] & 0xff;
 451:	8b 55 0c             	mov    0xc(%ebp),%edx
 454:	8b 45 f0             	mov    -0x10(%ebp),%eax
 457:	01 d0                	add    %edx,%eax
 459:	0f b6 00             	movzbl (%eax),%eax
 45c:	0f be c0             	movsbl %al,%eax
 45f:	25 ff 00 00 00       	and    $0xff,%eax
 464:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 467:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 46b:	75 2c                	jne    499 <printf+0x6a>
      if(c == '%'){
 46d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 471:	75 0c                	jne    47f <printf+0x50>
        state = '%';
 473:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 47a:	e9 27 01 00 00       	jmp    5a6 <printf+0x177>
      } else {
        putc(fd, c);
 47f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 482:	0f be c0             	movsbl %al,%eax
 485:	83 ec 08             	sub    $0x8,%esp
 488:	50                   	push   %eax
 489:	ff 75 08             	pushl  0x8(%ebp)
 48c:	e8 c7 fe ff ff       	call   358 <putc>
 491:	83 c4 10             	add    $0x10,%esp
 494:	e9 0d 01 00 00       	jmp    5a6 <printf+0x177>
      }
    } else if(state == '%'){
 499:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 49d:	0f 85 03 01 00 00    	jne    5a6 <printf+0x177>
      if(c == 'd'){
 4a3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4a7:	75 1e                	jne    4c7 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ac:	8b 00                	mov    (%eax),%eax
 4ae:	6a 01                	push   $0x1
 4b0:	6a 0a                	push   $0xa
 4b2:	50                   	push   %eax
 4b3:	ff 75 08             	pushl  0x8(%ebp)
 4b6:	e8 c0 fe ff ff       	call   37b <printint>
 4bb:	83 c4 10             	add    $0x10,%esp
        ap++;
 4be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c2:	e9 d8 00 00 00       	jmp    59f <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4c7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4cb:	74 06                	je     4d3 <printf+0xa4>
 4cd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4d1:	75 1e                	jne    4f1 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d6:	8b 00                	mov    (%eax),%eax
 4d8:	6a 00                	push   $0x0
 4da:	6a 10                	push   $0x10
 4dc:	50                   	push   %eax
 4dd:	ff 75 08             	pushl  0x8(%ebp)
 4e0:	e8 96 fe ff ff       	call   37b <printint>
 4e5:	83 c4 10             	add    $0x10,%esp
        ap++;
 4e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ec:	e9 ae 00 00 00       	jmp    59f <printf+0x170>
      } else if(c == 's'){
 4f1:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4f5:	75 43                	jne    53a <printf+0x10b>
        s = (char*)*ap;
 4f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4fa:	8b 00                	mov    (%eax),%eax
 4fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 503:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 507:	75 25                	jne    52e <printf+0xff>
          s = "(null)";
 509:	c7 45 f4 e8 07 00 00 	movl   $0x7e8,-0xc(%ebp)
        while(*s != 0){
 510:	eb 1c                	jmp    52e <printf+0xff>
          putc(fd, *s);
 512:	8b 45 f4             	mov    -0xc(%ebp),%eax
 515:	0f b6 00             	movzbl (%eax),%eax
 518:	0f be c0             	movsbl %al,%eax
 51b:	83 ec 08             	sub    $0x8,%esp
 51e:	50                   	push   %eax
 51f:	ff 75 08             	pushl  0x8(%ebp)
 522:	e8 31 fe ff ff       	call   358 <putc>
 527:	83 c4 10             	add    $0x10,%esp
          s++;
 52a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 52e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 531:	0f b6 00             	movzbl (%eax),%eax
 534:	84 c0                	test   %al,%al
 536:	75 da                	jne    512 <printf+0xe3>
 538:	eb 65                	jmp    59f <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 53e:	75 1d                	jne    55d <printf+0x12e>
        putc(fd, *ap);
 540:	8b 45 e8             	mov    -0x18(%ebp),%eax
 543:	8b 00                	mov    (%eax),%eax
 545:	0f be c0             	movsbl %al,%eax
 548:	83 ec 08             	sub    $0x8,%esp
 54b:	50                   	push   %eax
 54c:	ff 75 08             	pushl  0x8(%ebp)
 54f:	e8 04 fe ff ff       	call   358 <putc>
 554:	83 c4 10             	add    $0x10,%esp
        ap++;
 557:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55b:	eb 42                	jmp    59f <printf+0x170>
      } else if(c == '%'){
 55d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 561:	75 17                	jne    57a <printf+0x14b>
        putc(fd, c);
 563:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 566:	0f be c0             	movsbl %al,%eax
 569:	83 ec 08             	sub    $0x8,%esp
 56c:	50                   	push   %eax
 56d:	ff 75 08             	pushl  0x8(%ebp)
 570:	e8 e3 fd ff ff       	call   358 <putc>
 575:	83 c4 10             	add    $0x10,%esp
 578:	eb 25                	jmp    59f <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 57a:	83 ec 08             	sub    $0x8,%esp
 57d:	6a 25                	push   $0x25
 57f:	ff 75 08             	pushl  0x8(%ebp)
 582:	e8 d1 fd ff ff       	call   358 <putc>
 587:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 58a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	83 ec 08             	sub    $0x8,%esp
 593:	50                   	push   %eax
 594:	ff 75 08             	pushl  0x8(%ebp)
 597:	e8 bc fd ff ff       	call   358 <putc>
 59c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 59f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5aa:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b0:	01 d0                	add    %edx,%eax
 5b2:	0f b6 00             	movzbl (%eax),%eax
 5b5:	84 c0                	test   %al,%al
 5b7:	0f 85 94 fe ff ff    	jne    451 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5bd:	90                   	nop
 5be:	c9                   	leave  
 5bf:	c3                   	ret    

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
 5c9:	83 e8 08             	sub    $0x8,%eax
 5cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5cf:	a1 54 0a 00 00       	mov    0xa54,%eax
 5d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5d7:	eb 24                	jmp    5fd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e1:	77 12                	ja     5f5 <free+0x35>
 5e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e9:	77 24                	ja     60f <free+0x4f>
 5eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ee:	8b 00                	mov    (%eax),%eax
 5f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f3:	77 1a                	ja     60f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f8:	8b 00                	mov    (%eax),%eax
 5fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 600:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 603:	76 d4                	jbe    5d9 <free+0x19>
 605:	8b 45 fc             	mov    -0x4(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60d:	76 ca                	jbe    5d9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 612:	8b 40 04             	mov    0x4(%eax),%eax
 615:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 61c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61f:	01 c2                	add    %eax,%edx
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	39 c2                	cmp    %eax,%edx
 628:	75 24                	jne    64e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 62a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62d:	8b 50 04             	mov    0x4(%eax),%edx
 630:	8b 45 fc             	mov    -0x4(%ebp),%eax
 633:	8b 00                	mov    (%eax),%eax
 635:	8b 40 04             	mov    0x4(%eax),%eax
 638:	01 c2                	add    %eax,%edx
 63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	8b 00                	mov    (%eax),%eax
 645:	8b 10                	mov    (%eax),%edx
 647:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64a:	89 10                	mov    %edx,(%eax)
 64c:	eb 0a                	jmp    658 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 651:	8b 10                	mov    (%eax),%edx
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 40 04             	mov    0x4(%eax),%eax
 65e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	01 d0                	add    %edx,%eax
 66a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66d:	75 20                	jne    68f <free+0xcf>
    p->s.size += bp->s.size;
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 50 04             	mov    0x4(%eax),%edx
 675:	8b 45 f8             	mov    -0x8(%ebp),%eax
 678:	8b 40 04             	mov    0x4(%eax),%eax
 67b:	01 c2                	add    %eax,%edx
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 683:	8b 45 f8             	mov    -0x8(%ebp),%eax
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	89 10                	mov    %edx,(%eax)
 68d:	eb 08                	jmp    697 <free+0xd7>
  } else
    p->s.ptr = bp;
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	8b 55 f8             	mov    -0x8(%ebp),%edx
 695:	89 10                	mov    %edx,(%eax)
  freep = p;
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	a3 54 0a 00 00       	mov    %eax,0xa54
}
 69f:	90                   	nop
 6a0:	c9                   	leave  
 6a1:	c3                   	ret    

000006a2 <morecore>:

static Header*
morecore(uint nu)
{
 6a2:	55                   	push   %ebp
 6a3:	89 e5                	mov    %esp,%ebp
 6a5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6a8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6af:	77 07                	ja     6b8 <morecore+0x16>
    nu = 4096;
 6b1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6b8:	8b 45 08             	mov    0x8(%ebp),%eax
 6bb:	c1 e0 03             	shl    $0x3,%eax
 6be:	83 ec 0c             	sub    $0xc,%esp
 6c1:	50                   	push   %eax
 6c2:	e8 69 fc ff ff       	call   330 <sbrk>
 6c7:	83 c4 10             	add    $0x10,%esp
 6ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6cd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6d1:	75 07                	jne    6da <morecore+0x38>
    return 0;
 6d3:	b8 00 00 00 00       	mov    $0x0,%eax
 6d8:	eb 26                	jmp    700 <morecore+0x5e>
  hp = (Header*)p;
 6da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e3:	8b 55 08             	mov    0x8(%ebp),%edx
 6e6:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ec:	83 c0 08             	add    $0x8,%eax
 6ef:	83 ec 0c             	sub    $0xc,%esp
 6f2:	50                   	push   %eax
 6f3:	e8 c8 fe ff ff       	call   5c0 <free>
 6f8:	83 c4 10             	add    $0x10,%esp
  return freep;
 6fb:	a1 54 0a 00 00       	mov    0xa54,%eax
}
 700:	c9                   	leave  
 701:	c3                   	ret    

00000702 <malloc>:

void*
malloc(uint nbytes)
{
 702:	55                   	push   %ebp
 703:	89 e5                	mov    %esp,%ebp
 705:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	83 c0 07             	add    $0x7,%eax
 70e:	c1 e8 03             	shr    $0x3,%eax
 711:	83 c0 01             	add    $0x1,%eax
 714:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 717:	a1 54 0a 00 00       	mov    0xa54,%eax
 71c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 71f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 723:	75 23                	jne    748 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 725:	c7 45 f0 4c 0a 00 00 	movl   $0xa4c,-0x10(%ebp)
 72c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72f:	a3 54 0a 00 00       	mov    %eax,0xa54
 734:	a1 54 0a 00 00       	mov    0xa54,%eax
 739:	a3 4c 0a 00 00       	mov    %eax,0xa4c
    base.s.size = 0;
 73e:	c7 05 50 0a 00 00 00 	movl   $0x0,0xa50
 745:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 748:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74b:	8b 00                	mov    (%eax),%eax
 74d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 750:	8b 45 f4             	mov    -0xc(%ebp),%eax
 753:	8b 40 04             	mov    0x4(%eax),%eax
 756:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 759:	72 4d                	jb     7a8 <malloc+0xa6>
      if(p->s.size == nunits)
 75b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75e:	8b 40 04             	mov    0x4(%eax),%eax
 761:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 764:	75 0c                	jne    772 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 766:	8b 45 f4             	mov    -0xc(%ebp),%eax
 769:	8b 10                	mov    (%eax),%edx
 76b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76e:	89 10                	mov    %edx,(%eax)
 770:	eb 26                	jmp    798 <malloc+0x96>
      else {
        p->s.size -= nunits;
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	8b 40 04             	mov    0x4(%eax),%eax
 778:	2b 45 ec             	sub    -0x14(%ebp),%eax
 77b:	89 c2                	mov    %eax,%edx
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 783:	8b 45 f4             	mov    -0xc(%ebp),%eax
 786:	8b 40 04             	mov    0x4(%eax),%eax
 789:	c1 e0 03             	shl    $0x3,%eax
 78c:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 792:	8b 55 ec             	mov    -0x14(%ebp),%edx
 795:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 798:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79b:	a3 54 0a 00 00       	mov    %eax,0xa54
      return (void*)(p + 1);
 7a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a3:	83 c0 08             	add    $0x8,%eax
 7a6:	eb 3b                	jmp    7e3 <malloc+0xe1>
    }
    if(p == freep)
 7a8:	a1 54 0a 00 00       	mov    0xa54,%eax
 7ad:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7b0:	75 1e                	jne    7d0 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7b2:	83 ec 0c             	sub    $0xc,%esp
 7b5:	ff 75 ec             	pushl  -0x14(%ebp)
 7b8:	e8 e5 fe ff ff       	call   6a2 <morecore>
 7bd:	83 c4 10             	add    $0x10,%esp
 7c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7c7:	75 07                	jne    7d0 <malloc+0xce>
        return 0;
 7c9:	b8 00 00 00 00       	mov    $0x0,%eax
 7ce:	eb 13                	jmp    7e3 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	8b 00                	mov    (%eax),%eax
 7db:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7de:	e9 6d ff ff ff       	jmp    750 <malloc+0x4e>
}
 7e3:	c9                   	leave  
 7e4:	c3                   	ret    
