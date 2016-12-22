
_zombie:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	e8 76 02 00 00       	call   28c <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 00 03 00 00       	call   324 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  27:	e8 68 02 00 00       	call   294 <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	57                   	push   %edi
  30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  34:	8b 55 10             	mov    0x10(%ebp),%edx
  37:	8b 45 0c             	mov    0xc(%ebp),%eax
  3a:	89 cb                	mov    %ecx,%ebx
  3c:	89 df                	mov    %ebx,%edi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld    
  41:	f3 aa                	rep stos %al,%es:(%edi)
  43:	89 ca                	mov    %ecx,%edx
  45:	89 fb                	mov    %edi,%ebx
  47:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4d:	5b                   	pop    %ebx
  4e:	5f                   	pop    %edi
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    

00000051 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  51:	55                   	push   %ebp
  52:	89 e5                	mov    %esp,%ebp
  54:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  57:	8b 45 08             	mov    0x8(%ebp),%eax
  5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5d:	90                   	nop
  5e:	8b 45 08             	mov    0x8(%ebp),%eax
  61:	8d 50 01             	lea    0x1(%eax),%edx
  64:	89 55 08             	mov    %edx,0x8(%ebp)
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  6d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  70:	0f b6 12             	movzbl (%edx),%edx
  73:	88 10                	mov    %dl,(%eax)
  75:	0f b6 00             	movzbl (%eax),%eax
  78:	84 c0                	test   %al,%al
  7a:	75 e2                	jne    5e <strcpy+0xd>
    ;
  return os;
  7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7f:	c9                   	leave  
  80:	c3                   	ret    

00000081 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  81:	55                   	push   %ebp
  82:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  84:	eb 08                	jmp    8e <strcmp+0xd>
    p++, q++;
  86:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	0f b6 00             	movzbl (%eax),%eax
  94:	84 c0                	test   %al,%al
  96:	74 10                	je     a8 <strcmp+0x27>
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	0f b6 10             	movzbl (%eax),%edx
  9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  a1:	0f b6 00             	movzbl (%eax),%eax
  a4:	38 c2                	cmp    %al,%dl
  a6:	74 de                	je     86 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	0f b6 00             	movzbl (%eax),%eax
  ae:	0f b6 d0             	movzbl %al,%edx
  b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  b4:	0f b6 00             	movzbl (%eax),%eax
  b7:	0f b6 c0             	movzbl %al,%eax
  ba:	29 c2                	sub    %eax,%edx
  bc:	89 d0                	mov    %edx,%eax
}
  be:	5d                   	pop    %ebp
  bf:	c3                   	ret    

000000c0 <strlen>:

uint
strlen(char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cd:	eb 04                	jmp    d3 <strlen+0x13>
  cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	01 d0                	add    %edx,%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	84 c0                	test   %al,%al
  e0:	75 ed                	jne    cf <strlen+0xf>
    ;
  return n;
  e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e5:	c9                   	leave  
  e6:	c3                   	ret    

000000e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e7:	55                   	push   %ebp
  e8:	89 e5                	mov    %esp,%ebp
  ea:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  ed:	8b 45 10             	mov    0x10(%ebp),%eax
  f0:	89 44 24 08          	mov    %eax,0x8(%esp)
  f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  fb:	8b 45 08             	mov    0x8(%ebp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 26 ff ff ff       	call   2c <stosb>
  return dst;
 106:	8b 45 08             	mov    0x8(%ebp),%eax
}
 109:	c9                   	leave  
 10a:	c3                   	ret    

0000010b <strchr>:

char*
strchr(const char *s, char c)
{
 10b:	55                   	push   %ebp
 10c:	89 e5                	mov    %esp,%ebp
 10e:	83 ec 04             	sub    $0x4,%esp
 111:	8b 45 0c             	mov    0xc(%ebp),%eax
 114:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 117:	eb 14                	jmp    12d <strchr+0x22>
    if(*s == c)
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 122:	75 05                	jne    129 <strchr+0x1e>
      return (char*)s;
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	eb 13                	jmp    13c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 129:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	0f b6 00             	movzbl (%eax),%eax
 133:	84 c0                	test   %al,%al
 135:	75 e2                	jne    119 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 137:	b8 00 00 00 00       	mov    $0x0,%eax
}
 13c:	c9                   	leave  
 13d:	c3                   	ret    

0000013e <gets>:

char*
gets(char *buf, int max)
{
 13e:	55                   	push   %ebp
 13f:	89 e5                	mov    %esp,%ebp
 141:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 14b:	eb 4c                	jmp    199 <gets+0x5b>
    cc = read(0, &c, 1);
 14d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 154:	00 
 155:	8d 45 ef             	lea    -0x11(%ebp),%eax
 158:	89 44 24 04          	mov    %eax,0x4(%esp)
 15c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 163:	e8 44 01 00 00       	call   2ac <read>
 168:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 16b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16f:	7f 02                	jg     173 <gets+0x35>
      break;
 171:	eb 31                	jmp    1a4 <gets+0x66>
    buf[i++] = c;
 173:	8b 45 f4             	mov    -0xc(%ebp),%eax
 176:	8d 50 01             	lea    0x1(%eax),%edx
 179:	89 55 f4             	mov    %edx,-0xc(%ebp)
 17c:	89 c2                	mov    %eax,%edx
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	01 c2                	add    %eax,%edx
 183:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 187:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18d:	3c 0a                	cmp    $0xa,%al
 18f:	74 13                	je     1a4 <gets+0x66>
 191:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 195:	3c 0d                	cmp    $0xd,%al
 197:	74 0b                	je     1a4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 199:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19c:	83 c0 01             	add    $0x1,%eax
 19f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1a2:	7c a9                	jl     14d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	01 d0                	add    %edx,%eax
 1ac:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1af:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1b2:	c9                   	leave  
 1b3:	c3                   	ret    

000001b4 <stat>:

int
stat(char *n, struct stat *st)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ba:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1c1:	00 
 1c2:	8b 45 08             	mov    0x8(%ebp),%eax
 1c5:	89 04 24             	mov    %eax,(%esp)
 1c8:	e8 07 01 00 00       	call   2d4 <open>
 1cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1d4:	79 07                	jns    1dd <stat+0x29>
    return -1;
 1d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1db:	eb 23                	jmp    200 <stat+0x4c>
  r = fstat(fd, st);
 1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e7:	89 04 24             	mov    %eax,(%esp)
 1ea:	e8 fd 00 00 00       	call   2ec <fstat>
 1ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f5:	89 04 24             	mov    %eax,(%esp)
 1f8:	e8 bf 00 00 00       	call   2bc <close>
  return r;
 1fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 200:	c9                   	leave  
 201:	c3                   	ret    

00000202 <atoi>:

int
atoi(const char *s)
{
 202:	55                   	push   %ebp
 203:	89 e5                	mov    %esp,%ebp
 205:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 208:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 20f:	eb 25                	jmp    236 <atoi+0x34>
    n = n*10 + *s++ - '0';
 211:	8b 55 fc             	mov    -0x4(%ebp),%edx
 214:	89 d0                	mov    %edx,%eax
 216:	c1 e0 02             	shl    $0x2,%eax
 219:	01 d0                	add    %edx,%eax
 21b:	01 c0                	add    %eax,%eax
 21d:	89 c1                	mov    %eax,%ecx
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
 222:	8d 50 01             	lea    0x1(%eax),%edx
 225:	89 55 08             	mov    %edx,0x8(%ebp)
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	0f be c0             	movsbl %al,%eax
 22e:	01 c8                	add    %ecx,%eax
 230:	83 e8 30             	sub    $0x30,%eax
 233:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	3c 2f                	cmp    $0x2f,%al
 23e:	7e 0a                	jle    24a <atoi+0x48>
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	0f b6 00             	movzbl (%eax),%eax
 246:	3c 39                	cmp    $0x39,%al
 248:	7e c7                	jle    211 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 24a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 24d:	c9                   	leave  
 24e:	c3                   	ret    

0000024f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 24f:	55                   	push   %ebp
 250:	89 e5                	mov    %esp,%ebp
 252:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 255:	8b 45 08             	mov    0x8(%ebp),%eax
 258:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 25b:	8b 45 0c             	mov    0xc(%ebp),%eax
 25e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 261:	eb 17                	jmp    27a <memmove+0x2b>
    *dst++ = *src++;
 263:	8b 45 fc             	mov    -0x4(%ebp),%eax
 266:	8d 50 01             	lea    0x1(%eax),%edx
 269:	89 55 fc             	mov    %edx,-0x4(%ebp)
 26c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 26f:	8d 4a 01             	lea    0x1(%edx),%ecx
 272:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 275:	0f b6 12             	movzbl (%edx),%edx
 278:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27a:	8b 45 10             	mov    0x10(%ebp),%eax
 27d:	8d 50 ff             	lea    -0x1(%eax),%edx
 280:	89 55 10             	mov    %edx,0x10(%ebp)
 283:	85 c0                	test   %eax,%eax
 285:	7f dc                	jg     263 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 287:	8b 45 08             	mov    0x8(%ebp),%eax
}
 28a:	c9                   	leave  
 28b:	c3                   	ret    

0000028c <fork>:
 28c:	b8 01 00 00 00       	mov    $0x1,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <exit>:
 294:	b8 02 00 00 00       	mov    $0x2,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <wait>:
 29c:	b8 03 00 00 00       	mov    $0x3,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <pipe>:
 2a4:	b8 04 00 00 00       	mov    $0x4,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <read>:
 2ac:	b8 05 00 00 00       	mov    $0x5,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <write>:
 2b4:	b8 10 00 00 00       	mov    $0x10,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <close>:
 2bc:	b8 15 00 00 00       	mov    $0x15,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <kill>:
 2c4:	b8 06 00 00 00       	mov    $0x6,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <exec>:
 2cc:	b8 07 00 00 00       	mov    $0x7,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <open>:
 2d4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <mknod>:
 2dc:	b8 11 00 00 00       	mov    $0x11,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <unlink>:
 2e4:	b8 12 00 00 00       	mov    $0x12,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <fstat>:
 2ec:	b8 08 00 00 00       	mov    $0x8,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <link>:
 2f4:	b8 13 00 00 00       	mov    $0x13,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <mkdir>:
 2fc:	b8 14 00 00 00       	mov    $0x14,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <chdir>:
 304:	b8 09 00 00 00       	mov    $0x9,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <dup>:
 30c:	b8 0a 00 00 00       	mov    $0xa,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <getpid>:
 314:	b8 0b 00 00 00       	mov    $0xb,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <sbrk>:
 31c:	b8 0c 00 00 00       	mov    $0xc,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <sleep>:
 324:	b8 0d 00 00 00       	mov    $0xd,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <uptime>:
 32c:	b8 0e 00 00 00       	mov    $0xe,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <date>:
 334:	b8 16 00 00 00       	mov    $0x16,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <dup2>:
 33c:	b8 17 00 00 00       	mov    $0x17,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	83 ec 18             	sub    $0x18,%esp
 34a:	8b 45 0c             	mov    0xc(%ebp),%eax
 34d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 350:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 357:	00 
 358:	8d 45 f4             	lea    -0xc(%ebp),%eax
 35b:	89 44 24 04          	mov    %eax,0x4(%esp)
 35f:	8b 45 08             	mov    0x8(%ebp),%eax
 362:	89 04 24             	mov    %eax,(%esp)
 365:	e8 4a ff ff ff       	call   2b4 <write>
}
 36a:	c9                   	leave  
 36b:	c3                   	ret    

0000036c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	56                   	push   %esi
 370:	53                   	push   %ebx
 371:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 374:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 37b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 37f:	74 17                	je     398 <printint+0x2c>
 381:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 385:	79 11                	jns    398 <printint+0x2c>
    neg = 1;
 387:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 38e:	8b 45 0c             	mov    0xc(%ebp),%eax
 391:	f7 d8                	neg    %eax
 393:	89 45 ec             	mov    %eax,-0x14(%ebp)
 396:	eb 06                	jmp    39e <printint+0x32>
  } else {
    x = xx;
 398:	8b 45 0c             	mov    0xc(%ebp),%eax
 39b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 39e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3a5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3a8:	8d 41 01             	lea    0x1(%ecx),%eax
 3ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3ae:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b4:	ba 00 00 00 00       	mov    $0x0,%edx
 3b9:	f7 f3                	div    %ebx
 3bb:	89 d0                	mov    %edx,%eax
 3bd:	0f b6 80 50 0a 00 00 	movzbl 0xa50(%eax),%eax
 3c4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3c8:	8b 75 10             	mov    0x10(%ebp),%esi
 3cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ce:	ba 00 00 00 00       	mov    $0x0,%edx
 3d3:	f7 f6                	div    %esi
 3d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3dc:	75 c7                	jne    3a5 <printint+0x39>
  if(neg)
 3de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e2:	74 10                	je     3f4 <printint+0x88>
    buf[i++] = '-';
 3e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e7:	8d 50 01             	lea    0x1(%eax),%edx
 3ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ed:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3f2:	eb 1f                	jmp    413 <printint+0xa7>
 3f4:	eb 1d                	jmp    413 <printint+0xa7>
    putc(fd, buf[i]);
 3f6:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3fc:	01 d0                	add    %edx,%eax
 3fe:	0f b6 00             	movzbl (%eax),%eax
 401:	0f be c0             	movsbl %al,%eax
 404:	89 44 24 04          	mov    %eax,0x4(%esp)
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	89 04 24             	mov    %eax,(%esp)
 40e:	e8 31 ff ff ff       	call   344 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 413:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 417:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41b:	79 d9                	jns    3f6 <printint+0x8a>
    putc(fd, buf[i]);
}
 41d:	83 c4 30             	add    $0x30,%esp
 420:	5b                   	pop    %ebx
 421:	5e                   	pop    %esi
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    

00000424 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 42a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 431:	8d 45 0c             	lea    0xc(%ebp),%eax
 434:	83 c0 04             	add    $0x4,%eax
 437:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 43a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 441:	e9 7c 01 00 00       	jmp    5c2 <printf+0x19e>
    c = fmt[i] & 0xff;
 446:	8b 55 0c             	mov    0xc(%ebp),%edx
 449:	8b 45 f0             	mov    -0x10(%ebp),%eax
 44c:	01 d0                	add    %edx,%eax
 44e:	0f b6 00             	movzbl (%eax),%eax
 451:	0f be c0             	movsbl %al,%eax
 454:	25 ff 00 00 00       	and    $0xff,%eax
 459:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 45c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 460:	75 2c                	jne    48e <printf+0x6a>
      if(c == '%'){
 462:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 466:	75 0c                	jne    474 <printf+0x50>
        state = '%';
 468:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46f:	e9 4a 01 00 00       	jmp    5be <printf+0x19a>
      } else {
        putc(fd, c);
 474:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 477:	0f be c0             	movsbl %al,%eax
 47a:	89 44 24 04          	mov    %eax,0x4(%esp)
 47e:	8b 45 08             	mov    0x8(%ebp),%eax
 481:	89 04 24             	mov    %eax,(%esp)
 484:	e8 bb fe ff ff       	call   344 <putc>
 489:	e9 30 01 00 00       	jmp    5be <printf+0x19a>
      }
    } else if(state == '%'){
 48e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 492:	0f 85 26 01 00 00    	jne    5be <printf+0x19a>
      if(c == 'd'){
 498:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 49c:	75 2d                	jne    4cb <printf+0xa7>
        printint(fd, *ap, 10, 1);
 49e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a1:	8b 00                	mov    (%eax),%eax
 4a3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4aa:	00 
 4ab:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4b2:	00 
 4b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ba:	89 04 24             	mov    %eax,(%esp)
 4bd:	e8 aa fe ff ff       	call   36c <printint>
        ap++;
 4c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c6:	e9 ec 00 00 00       	jmp    5b7 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 4cb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4cf:	74 06                	je     4d7 <printf+0xb3>
 4d1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4d5:	75 2d                	jne    504 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4da:	8b 00                	mov    (%eax),%eax
 4dc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4e3:	00 
 4e4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4eb:	00 
 4ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f0:	8b 45 08             	mov    0x8(%ebp),%eax
 4f3:	89 04 24             	mov    %eax,(%esp)
 4f6:	e8 71 fe ff ff       	call   36c <printint>
        ap++;
 4fb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ff:	e9 b3 00 00 00       	jmp    5b7 <printf+0x193>
      } else if(c == 's'){
 504:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 508:	75 45                	jne    54f <printf+0x12b>
        s = (char*)*ap;
 50a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50d:	8b 00                	mov    (%eax),%eax
 50f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 512:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 516:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 51a:	75 09                	jne    525 <printf+0x101>
          s = "(null)";
 51c:	c7 45 f4 fc 07 00 00 	movl   $0x7fc,-0xc(%ebp)
        while(*s != 0){
 523:	eb 1e                	jmp    543 <printf+0x11f>
 525:	eb 1c                	jmp    543 <printf+0x11f>
          putc(fd, *s);
 527:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52a:	0f b6 00             	movzbl (%eax),%eax
 52d:	0f be c0             	movsbl %al,%eax
 530:	89 44 24 04          	mov    %eax,0x4(%esp)
 534:	8b 45 08             	mov    0x8(%ebp),%eax
 537:	89 04 24             	mov    %eax,(%esp)
 53a:	e8 05 fe ff ff       	call   344 <putc>
          s++;
 53f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 543:	8b 45 f4             	mov    -0xc(%ebp),%eax
 546:	0f b6 00             	movzbl (%eax),%eax
 549:	84 c0                	test   %al,%al
 54b:	75 da                	jne    527 <printf+0x103>
 54d:	eb 68                	jmp    5b7 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 553:	75 1d                	jne    572 <printf+0x14e>
        putc(fd, *ap);
 555:	8b 45 e8             	mov    -0x18(%ebp),%eax
 558:	8b 00                	mov    (%eax),%eax
 55a:	0f be c0             	movsbl %al,%eax
 55d:	89 44 24 04          	mov    %eax,0x4(%esp)
 561:	8b 45 08             	mov    0x8(%ebp),%eax
 564:	89 04 24             	mov    %eax,(%esp)
 567:	e8 d8 fd ff ff       	call   344 <putc>
        ap++;
 56c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 570:	eb 45                	jmp    5b7 <printf+0x193>
      } else if(c == '%'){
 572:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 576:	75 17                	jne    58f <printf+0x16b>
        putc(fd, c);
 578:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57b:	0f be c0             	movsbl %al,%eax
 57e:	89 44 24 04          	mov    %eax,0x4(%esp)
 582:	8b 45 08             	mov    0x8(%ebp),%eax
 585:	89 04 24             	mov    %eax,(%esp)
 588:	e8 b7 fd ff ff       	call   344 <putc>
 58d:	eb 28                	jmp    5b7 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 596:	00 
 597:	8b 45 08             	mov    0x8(%ebp),%eax
 59a:	89 04 24             	mov    %eax,(%esp)
 59d:	e8 a2 fd ff ff       	call   344 <putc>
        putc(fd, c);
 5a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a5:	0f be c0             	movsbl %al,%eax
 5a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ac:	8b 45 08             	mov    0x8(%ebp),%eax
 5af:	89 04 24             	mov    %eax,(%esp)
 5b2:	e8 8d fd ff ff       	call   344 <putc>
      }
      state = 0;
 5b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5be:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c8:	01 d0                	add    %edx,%eax
 5ca:	0f b6 00             	movzbl (%eax),%eax
 5cd:	84 c0                	test   %al,%al
 5cf:	0f 85 71 fe ff ff    	jne    446 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d5:	c9                   	leave  
 5d6:	c3                   	ret    

000005d7 <free>:
 5d7:	55                   	push   %ebp
 5d8:	89 e5                	mov    %esp,%ebp
 5da:	83 ec 10             	sub    $0x10,%esp
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	83 e8 08             	sub    $0x8,%eax
 5e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
 5e6:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 5eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ee:	eb 24                	jmp    614 <free+0x3d>
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f8:	77 12                	ja     60c <free+0x35>
 5fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 600:	77 24                	ja     626 <free+0x4f>
 602:	8b 45 fc             	mov    -0x4(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60a:	77 1a                	ja     626 <free+0x4f>
 60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60f:	8b 00                	mov    (%eax),%eax
 611:	89 45 fc             	mov    %eax,-0x4(%ebp)
 614:	8b 45 f8             	mov    -0x8(%ebp),%eax
 617:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61a:	76 d4                	jbe    5f0 <free+0x19>
 61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 624:	76 ca                	jbe    5f0 <free+0x19>
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	8b 40 04             	mov    0x4(%eax),%eax
 62c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 633:	8b 45 f8             	mov    -0x8(%ebp),%eax
 636:	01 c2                	add    %eax,%edx
 638:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63b:	8b 00                	mov    (%eax),%eax
 63d:	39 c2                	cmp    %eax,%edx
 63f:	75 24                	jne    665 <free+0x8e>
 641:	8b 45 f8             	mov    -0x8(%ebp),%eax
 644:	8b 50 04             	mov    0x4(%eax),%edx
 647:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64a:	8b 00                	mov    (%eax),%eax
 64c:	8b 40 04             	mov    0x4(%eax),%eax
 64f:	01 c2                	add    %eax,%edx
 651:	8b 45 f8             	mov    -0x8(%ebp),%eax
 654:	89 50 04             	mov    %edx,0x4(%eax)
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	8b 10                	mov    (%eax),%edx
 65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 661:	89 10                	mov    %edx,(%eax)
 663:	eb 0a                	jmp    66f <free+0x98>
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 10                	mov    (%eax),%edx
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	89 10                	mov    %edx,(%eax)
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 40 04             	mov    0x4(%eax),%eax
 675:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67f:	01 d0                	add    %edx,%eax
 681:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 684:	75 20                	jne    6a6 <free+0xcf>
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	8b 50 04             	mov    0x4(%eax),%edx
 68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68f:	8b 40 04             	mov    0x4(%eax),%eax
 692:	01 c2                	add    %eax,%edx
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	89 50 04             	mov    %edx,0x4(%eax)
 69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69d:	8b 10                	mov    (%eax),%edx
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	89 10                	mov    %edx,(%eax)
 6a4:	eb 08                	jmp    6ae <free+0xd7>
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ac:	89 10                	mov    %edx,(%eax)
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	a3 6c 0a 00 00       	mov    %eax,0xa6c
 6b6:	90                   	nop
 6b7:	c9                   	leave  
 6b8:	c3                   	ret    

000006b9 <morecore>:
 6b9:	55                   	push   %ebp
 6ba:	89 e5                	mov    %esp,%ebp
 6bc:	83 ec 18             	sub    $0x18,%esp
 6bf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6c6:	77 07                	ja     6cf <morecore+0x16>
 6c8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 6cf:	8b 45 08             	mov    0x8(%ebp),%eax
 6d2:	c1 e0 03             	shl    $0x3,%eax
 6d5:	83 ec 0c             	sub    $0xc,%esp
 6d8:	50                   	push   %eax
 6d9:	e8 3e fc ff ff       	call   31c <sbrk>
 6de:	83 c4 10             	add    $0x10,%esp
 6e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6e4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e8:	75 07                	jne    6f1 <morecore+0x38>
 6ea:	b8 00 00 00 00       	mov    $0x0,%eax
 6ef:	eb 26                	jmp    717 <morecore+0x5e>
 6f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fa:	8b 55 08             	mov    0x8(%ebp),%edx
 6fd:	89 50 04             	mov    %edx,0x4(%eax)
 700:	8b 45 f0             	mov    -0x10(%ebp),%eax
 703:	83 c0 08             	add    $0x8,%eax
 706:	83 ec 0c             	sub    $0xc,%esp
 709:	50                   	push   %eax
 70a:	e8 c8 fe ff ff       	call   5d7 <free>
 70f:	83 c4 10             	add    $0x10,%esp
 712:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 717:	c9                   	leave  
 718:	c3                   	ret    

00000719 <malloc>:
 719:	55                   	push   %ebp
 71a:	89 e5                	mov    %esp,%ebp
 71c:	83 ec 18             	sub    $0x18,%esp
 71f:	8b 45 08             	mov    0x8(%ebp),%eax
 722:	83 c0 07             	add    $0x7,%eax
 725:	c1 e8 03             	shr    $0x3,%eax
 728:	83 c0 01             	add    $0x1,%eax
 72b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 72e:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 733:	89 45 f0             	mov    %eax,-0x10(%ebp)
 736:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 73a:	75 23                	jne    75f <malloc+0x46>
 73c:	c7 45 f0 64 0a 00 00 	movl   $0xa64,-0x10(%ebp)
 743:	8b 45 f0             	mov    -0x10(%ebp),%eax
 746:	a3 6c 0a 00 00       	mov    %eax,0xa6c
 74b:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 750:	a3 64 0a 00 00       	mov    %eax,0xa64
 755:	c7 05 68 0a 00 00 00 	movl   $0x0,0xa68
 75c:	00 00 00 
 75f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	89 45 f4             	mov    %eax,-0xc(%ebp)
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	8b 40 04             	mov    0x4(%eax),%eax
 76d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 770:	72 4d                	jb     7bf <malloc+0xa6>
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	8b 40 04             	mov    0x4(%eax),%eax
 778:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 77b:	75 0c                	jne    789 <malloc+0x70>
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	8b 10                	mov    (%eax),%edx
 782:	8b 45 f0             	mov    -0x10(%ebp),%eax
 785:	89 10                	mov    %edx,(%eax)
 787:	eb 26                	jmp    7af <malloc+0x96>
 789:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78c:	8b 40 04             	mov    0x4(%eax),%eax
 78f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 792:	89 c2                	mov    %eax,%edx
 794:	8b 45 f4             	mov    -0xc(%ebp),%eax
 797:	89 50 04             	mov    %edx,0x4(%eax)
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	8b 40 04             	mov    0x4(%eax),%eax
 7a0:	c1 e0 03             	shl    $0x3,%eax
 7a3:	01 45 f4             	add    %eax,-0xc(%ebp)
 7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ac:	89 50 04             	mov    %edx,0x4(%eax)
 7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b2:	a3 6c 0a 00 00       	mov    %eax,0xa6c
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	83 c0 08             	add    $0x8,%eax
 7bd:	eb 3b                	jmp    7fa <malloc+0xe1>
 7bf:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 7c4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c7:	75 1e                	jne    7e7 <malloc+0xce>
 7c9:	83 ec 0c             	sub    $0xc,%esp
 7cc:	ff 75 ec             	pushl  -0x14(%ebp)
 7cf:	e8 e5 fe ff ff       	call   6b9 <morecore>
 7d4:	83 c4 10             	add    $0x10,%esp
 7d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7de:	75 07                	jne    7e7 <malloc+0xce>
 7e0:	b8 00 00 00 00       	mov    $0x0,%eax
 7e5:	eb 13                	jmp    7fa <malloc+0xe1>
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7f5:	e9 6d ff ff ff       	jmp    767 <malloc+0x4e>
 7fa:	c9                   	leave  
 7fb:	c3                   	ret    
