
_date:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "types.h"
#include "user.h"
#include "date.h"
int
main(int argc , char *argv [])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 40             	sub    $0x40,%esp
	struct  rtcdate r;
	if (date(&r)) {
   9:	8d 44 24 28          	lea    0x28(%esp),%eax
   d:	89 04 24             	mov    %eax,(%esp)
  10:	e8 56 03 00 00       	call   36b <date>
  15:	85 c0                	test   %eax,%eax
  17:	74 19                	je     32 <main+0x32>
		printf(2, "date  failed\n");
  19:	c7 44 24 04 33 08 00 	movl   $0x833,0x4(%esp)
  20:	00 
  21:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  28:	e8 2e 04 00 00       	call   45b <printf>
		exit();
  2d:	e8 99 02 00 00       	call   2cb <exit>
	}
	printf(2, "Hora UTC: %d:%d:%d\n", r.hour,r.minute,r.second);
  32:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  36:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  3a:	8b 44 24 30          	mov    0x30(%esp),%eax
  3e:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  42:	89 54 24 0c          	mov    %edx,0xc(%esp)
  46:	89 44 24 08          	mov    %eax,0x8(%esp)
  4a:	c7 44 24 04 41 08 00 	movl   $0x841,0x4(%esp)
  51:	00 
  52:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  59:	e8 fd 03 00 00       	call   45b <printf>
	exit();
  5e:	e8 68 02 00 00       	call   2cb <exit>

00000063 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  63:	55                   	push   %ebp
  64:	89 e5                	mov    %esp,%ebp
  66:	57                   	push   %edi
  67:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6b:	8b 55 10             	mov    0x10(%ebp),%edx
  6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  71:	89 cb                	mov    %ecx,%ebx
  73:	89 df                	mov    %ebx,%edi
  75:	89 d1                	mov    %edx,%ecx
  77:	fc                   	cld    
  78:	f3 aa                	rep stos %al,%es:(%edi)
  7a:	89 ca                	mov    %ecx,%edx
  7c:	89 fb                	mov    %edi,%ebx
  7e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  81:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  84:	5b                   	pop    %ebx
  85:	5f                   	pop    %edi
  86:	5d                   	pop    %ebp
  87:	c3                   	ret    

00000088 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  88:	55                   	push   %ebp
  89:	89 e5                	mov    %esp,%ebp
  8b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  94:	90                   	nop
  95:	8b 45 08             	mov    0x8(%ebp),%eax
  98:	8d 50 01             	lea    0x1(%eax),%edx
  9b:	89 55 08             	mov    %edx,0x8(%ebp)
  9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  a4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  a7:	0f b6 12             	movzbl (%edx),%edx
  aa:	88 10                	mov    %dl,(%eax)
  ac:	0f b6 00             	movzbl (%eax),%eax
  af:	84 c0                	test   %al,%al
  b1:	75 e2                	jne    95 <strcpy+0xd>
    ;
  return os;
  b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b6:	c9                   	leave  
  b7:	c3                   	ret    

000000b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  bb:	eb 08                	jmp    c5 <strcmp+0xd>
    p++, q++;
  bd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c5:	8b 45 08             	mov    0x8(%ebp),%eax
  c8:	0f b6 00             	movzbl (%eax),%eax
  cb:	84 c0                	test   %al,%al
  cd:	74 10                	je     df <strcmp+0x27>
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	0f b6 10             	movzbl (%eax),%edx
  d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	38 c2                	cmp    %al,%dl
  dd:	74 de                	je     bd <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	0f b6 00             	movzbl (%eax),%eax
  e5:	0f b6 d0             	movzbl %al,%edx
  e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	0f b6 c0             	movzbl %al,%eax
  f1:	29 c2                	sub    %eax,%edx
  f3:	89 d0                	mov    %edx,%eax
}
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    

000000f7 <strlen>:

uint
strlen(char *s)
{
  f7:	55                   	push   %ebp
  f8:	89 e5                	mov    %esp,%ebp
  fa:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 104:	eb 04                	jmp    10a <strlen+0x13>
 106:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 10d:	8b 45 08             	mov    0x8(%ebp),%eax
 110:	01 d0                	add    %edx,%eax
 112:	0f b6 00             	movzbl (%eax),%eax
 115:	84 c0                	test   %al,%al
 117:	75 ed                	jne    106 <strlen+0xf>
    ;
  return n;
 119:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11c:	c9                   	leave  
 11d:	c3                   	ret    

0000011e <memset>:

void*
memset(void *dst, int c, uint n)
{
 11e:	55                   	push   %ebp
 11f:	89 e5                	mov    %esp,%ebp
 121:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 124:	8b 45 10             	mov    0x10(%ebp),%eax
 127:	89 44 24 08          	mov    %eax,0x8(%esp)
 12b:	8b 45 0c             	mov    0xc(%ebp),%eax
 12e:	89 44 24 04          	mov    %eax,0x4(%esp)
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	89 04 24             	mov    %eax,(%esp)
 138:	e8 26 ff ff ff       	call   63 <stosb>
  return dst;
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 140:	c9                   	leave  
 141:	c3                   	ret    

00000142 <strchr>:

char*
strchr(const char *s, char c)
{
 142:	55                   	push   %ebp
 143:	89 e5                	mov    %esp,%ebp
 145:	83 ec 04             	sub    $0x4,%esp
 148:	8b 45 0c             	mov    0xc(%ebp),%eax
 14b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 14e:	eb 14                	jmp    164 <strchr+0x22>
    if(*s == c)
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	3a 45 fc             	cmp    -0x4(%ebp),%al
 159:	75 05                	jne    160 <strchr+0x1e>
      return (char*)s;
 15b:	8b 45 08             	mov    0x8(%ebp),%eax
 15e:	eb 13                	jmp    173 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 160:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	84 c0                	test   %al,%al
 16c:	75 e2                	jne    150 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 16e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 173:	c9                   	leave  
 174:	c3                   	ret    

00000175 <gets>:

char*
gets(char *buf, int max)
{
 175:	55                   	push   %ebp
 176:	89 e5                	mov    %esp,%ebp
 178:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 182:	eb 4c                	jmp    1d0 <gets+0x5b>
    cc = read(0, &c, 1);
 184:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 18b:	00 
 18c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 18f:	89 44 24 04          	mov    %eax,0x4(%esp)
 193:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19a:	e8 44 01 00 00       	call   2e3 <read>
 19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a6:	7f 02                	jg     1aa <gets+0x35>
      break;
 1a8:	eb 31                	jmp    1db <gets+0x66>
    buf[i++] = c;
 1aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ad:	8d 50 01             	lea    0x1(%eax),%edx
 1b0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b3:	89 c2                	mov    %eax,%edx
 1b5:	8b 45 08             	mov    0x8(%ebp),%eax
 1b8:	01 c2                	add    %eax,%edx
 1ba:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1be:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c4:	3c 0a                	cmp    $0xa,%al
 1c6:	74 13                	je     1db <gets+0x66>
 1c8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cc:	3c 0d                	cmp    $0xd,%al
 1ce:	74 0b                	je     1db <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d3:	83 c0 01             	add    $0x1,%eax
 1d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d9:	7c a9                	jl     184 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1db:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
 1e1:	01 d0                	add    %edx,%eax
 1e3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e9:	c9                   	leave  
 1ea:	c3                   	ret    

000001eb <stat>:

int
stat(char *n, struct stat *st)
{
 1eb:	55                   	push   %ebp
 1ec:	89 e5                	mov    %esp,%ebp
 1ee:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f8:	00 
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	89 04 24             	mov    %eax,(%esp)
 1ff:	e8 07 01 00 00       	call   30b <open>
 204:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 207:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20b:	79 07                	jns    214 <stat+0x29>
    return -1;
 20d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 212:	eb 23                	jmp    237 <stat+0x4c>
  r = fstat(fd, st);
 214:	8b 45 0c             	mov    0xc(%ebp),%eax
 217:	89 44 24 04          	mov    %eax,0x4(%esp)
 21b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21e:	89 04 24             	mov    %eax,(%esp)
 221:	e8 fd 00 00 00       	call   323 <fstat>
 226:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 229:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22c:	89 04 24             	mov    %eax,(%esp)
 22f:	e8 bf 00 00 00       	call   2f3 <close>
  return r;
 234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
 239:	55                   	push   %ebp
 23a:	89 e5                	mov    %esp,%ebp
 23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
 248:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24b:	89 d0                	mov    %edx,%eax
 24d:	c1 e0 02             	shl    $0x2,%eax
 250:	01 d0                	add    %edx,%eax
 252:	01 c0                	add    %eax,%eax
 254:	89 c1                	mov    %eax,%ecx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 08             	mov    %edx,0x8(%ebp)
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	0f be c0             	movsbl %al,%eax
 265:	01 c8                	add    %ecx,%eax
 267:	83 e8 30             	sub    $0x30,%eax
 26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x48>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c7                	jle    248 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 298:	eb 17                	jmp    2b1 <memmove+0x2b>
    *dst++ = *src++;
 29a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29d:	8d 50 01             	lea    0x1(%eax),%edx
 2a0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a6:	8d 4a 01             	lea    0x1(%edx),%ecx
 2a9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2ac:	0f b6 12             	movzbl (%edx),%edx
 2af:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b1:	8b 45 10             	mov    0x10(%ebp),%eax
 2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b7:	89 55 10             	mov    %edx,0x10(%ebp)
 2ba:	85 c0                	test   %eax,%eax
 2bc:	7f dc                	jg     29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c1:	c9                   	leave  
 2c2:	c3                   	ret    

000002c3 <fork>:
 2c3:	b8 01 00 00 00       	mov    $0x1,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <exit>:
 2cb:	b8 02 00 00 00       	mov    $0x2,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <wait>:
 2d3:	b8 03 00 00 00       	mov    $0x3,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <pipe>:
 2db:	b8 04 00 00 00       	mov    $0x4,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <read>:
 2e3:	b8 05 00 00 00       	mov    $0x5,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <write>:
 2eb:	b8 10 00 00 00       	mov    $0x10,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <close>:
 2f3:	b8 15 00 00 00       	mov    $0x15,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <kill>:
 2fb:	b8 06 00 00 00       	mov    $0x6,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <exec>:
 303:	b8 07 00 00 00       	mov    $0x7,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <open>:
 30b:	b8 0f 00 00 00       	mov    $0xf,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <mknod>:
 313:	b8 11 00 00 00       	mov    $0x11,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <unlink>:
 31b:	b8 12 00 00 00       	mov    $0x12,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <fstat>:
 323:	b8 08 00 00 00       	mov    $0x8,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <link>:
 32b:	b8 13 00 00 00       	mov    $0x13,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <mkdir>:
 333:	b8 14 00 00 00       	mov    $0x14,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <chdir>:
 33b:	b8 09 00 00 00       	mov    $0x9,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <dup>:
 343:	b8 0a 00 00 00       	mov    $0xa,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <getpid>:
 34b:	b8 0b 00 00 00       	mov    $0xb,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <sbrk>:
 353:	b8 0c 00 00 00       	mov    $0xc,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <sleep>:
 35b:	b8 0d 00 00 00       	mov    $0xd,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <uptime>:
 363:	b8 0e 00 00 00       	mov    $0xe,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <date>:
 36b:	b8 16 00 00 00       	mov    $0x16,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <dup2>:
 373:	b8 17 00 00 00       	mov    $0x17,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 37b:	55                   	push   %ebp
 37c:	89 e5                	mov    %esp,%ebp
 37e:	83 ec 18             	sub    $0x18,%esp
 381:	8b 45 0c             	mov    0xc(%ebp),%eax
 384:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 387:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 38e:	00 
 38f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 392:	89 44 24 04          	mov    %eax,0x4(%esp)
 396:	8b 45 08             	mov    0x8(%ebp),%eax
 399:	89 04 24             	mov    %eax,(%esp)
 39c:	e8 4a ff ff ff       	call   2eb <write>
}
 3a1:	c9                   	leave  
 3a2:	c3                   	ret    

000003a3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a3:	55                   	push   %ebp
 3a4:	89 e5                	mov    %esp,%ebp
 3a6:	56                   	push   %esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3b2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3b6:	74 17                	je     3cf <printint+0x2c>
 3b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3bc:	79 11                	jns    3cf <printint+0x2c>
    neg = 1;
 3be:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c8:	f7 d8                	neg    %eax
 3ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3cd:	eb 06                	jmp    3d5 <printint+0x32>
  } else {
    x = xx;
 3cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3dc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3df:	8d 41 01             	lea    0x1(%ecx),%eax
 3e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3e5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3eb:	ba 00 00 00 00       	mov    $0x0,%edx
 3f0:	f7 f3                	div    %ebx
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	0f b6 80 a0 0a 00 00 	movzbl 0xaa0(%eax),%eax
 3fb:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3ff:	8b 75 10             	mov    0x10(%ebp),%esi
 402:	8b 45 ec             	mov    -0x14(%ebp),%eax
 405:	ba 00 00 00 00       	mov    $0x0,%edx
 40a:	f7 f6                	div    %esi
 40c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 40f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 413:	75 c7                	jne    3dc <printint+0x39>
  if(neg)
 415:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 419:	74 10                	je     42b <printint+0x88>
    buf[i++] = '-';
 41b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41e:	8d 50 01             	lea    0x1(%eax),%edx
 421:	89 55 f4             	mov    %edx,-0xc(%ebp)
 424:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 429:	eb 1f                	jmp    44a <printint+0xa7>
 42b:	eb 1d                	jmp    44a <printint+0xa7>
    putc(fd, buf[i]);
 42d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 430:	8b 45 f4             	mov    -0xc(%ebp),%eax
 433:	01 d0                	add    %edx,%eax
 435:	0f b6 00             	movzbl (%eax),%eax
 438:	0f be c0             	movsbl %al,%eax
 43b:	89 44 24 04          	mov    %eax,0x4(%esp)
 43f:	8b 45 08             	mov    0x8(%ebp),%eax
 442:	89 04 24             	mov    %eax,(%esp)
 445:	e8 31 ff ff ff       	call   37b <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 44a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 44e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 452:	79 d9                	jns    42d <printint+0x8a>
    putc(fd, buf[i]);
}
 454:	83 c4 30             	add    $0x30,%esp
 457:	5b                   	pop    %ebx
 458:	5e                   	pop    %esi
 459:	5d                   	pop    %ebp
 45a:	c3                   	ret    

0000045b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 45b:	55                   	push   %ebp
 45c:	89 e5                	mov    %esp,%ebp
 45e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 461:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 468:	8d 45 0c             	lea    0xc(%ebp),%eax
 46b:	83 c0 04             	add    $0x4,%eax
 46e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 471:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 478:	e9 7c 01 00 00       	jmp    5f9 <printf+0x19e>
    c = fmt[i] & 0xff;
 47d:	8b 55 0c             	mov    0xc(%ebp),%edx
 480:	8b 45 f0             	mov    -0x10(%ebp),%eax
 483:	01 d0                	add    %edx,%eax
 485:	0f b6 00             	movzbl (%eax),%eax
 488:	0f be c0             	movsbl %al,%eax
 48b:	25 ff 00 00 00       	and    $0xff,%eax
 490:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 493:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 497:	75 2c                	jne    4c5 <printf+0x6a>
      if(c == '%'){
 499:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 49d:	75 0c                	jne    4ab <printf+0x50>
        state = '%';
 49f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4a6:	e9 4a 01 00 00       	jmp    5f5 <printf+0x19a>
      } else {
        putc(fd, c);
 4ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ae:	0f be c0             	movsbl %al,%eax
 4b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b5:	8b 45 08             	mov    0x8(%ebp),%eax
 4b8:	89 04 24             	mov    %eax,(%esp)
 4bb:	e8 bb fe ff ff       	call   37b <putc>
 4c0:	e9 30 01 00 00       	jmp    5f5 <printf+0x19a>
      }
    } else if(state == '%'){
 4c5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4c9:	0f 85 26 01 00 00    	jne    5f5 <printf+0x19a>
      if(c == 'd'){
 4cf:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4d3:	75 2d                	jne    502 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d8:	8b 00                	mov    (%eax),%eax
 4da:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4e1:	00 
 4e2:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4e9:	00 
 4ea:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ee:	8b 45 08             	mov    0x8(%ebp),%eax
 4f1:	89 04 24             	mov    %eax,(%esp)
 4f4:	e8 aa fe ff ff       	call   3a3 <printint>
        ap++;
 4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fd:	e9 ec 00 00 00       	jmp    5ee <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 502:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 506:	74 06                	je     50e <printf+0xb3>
 508:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50c:	75 2d                	jne    53b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 511:	8b 00                	mov    (%eax),%eax
 513:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 51a:	00 
 51b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 522:	00 
 523:	89 44 24 04          	mov    %eax,0x4(%esp)
 527:	8b 45 08             	mov    0x8(%ebp),%eax
 52a:	89 04 24             	mov    %eax,(%esp)
 52d:	e8 71 fe ff ff       	call   3a3 <printint>
        ap++;
 532:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 536:	e9 b3 00 00 00       	jmp    5ee <printf+0x193>
      } else if(c == 's'){
 53b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 53f:	75 45                	jne    586 <printf+0x12b>
        s = (char*)*ap;
 541:	8b 45 e8             	mov    -0x18(%ebp),%eax
 544:	8b 00                	mov    (%eax),%eax
 546:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 549:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 54d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 551:	75 09                	jne    55c <printf+0x101>
          s = "(null)";
 553:	c7 45 f4 55 08 00 00 	movl   $0x855,-0xc(%ebp)
        while(*s != 0){
 55a:	eb 1e                	jmp    57a <printf+0x11f>
 55c:	eb 1c                	jmp    57a <printf+0x11f>
          putc(fd, *s);
 55e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 561:	0f b6 00             	movzbl (%eax),%eax
 564:	0f be c0             	movsbl %al,%eax
 567:	89 44 24 04          	mov    %eax,0x4(%esp)
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	89 04 24             	mov    %eax,(%esp)
 571:	e8 05 fe ff ff       	call   37b <putc>
          s++;
 576:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 57a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57d:	0f b6 00             	movzbl (%eax),%eax
 580:	84 c0                	test   %al,%al
 582:	75 da                	jne    55e <printf+0x103>
 584:	eb 68                	jmp    5ee <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 586:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 58a:	75 1d                	jne    5a9 <printf+0x14e>
        putc(fd, *ap);
 58c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58f:	8b 00                	mov    (%eax),%eax
 591:	0f be c0             	movsbl %al,%eax
 594:	89 44 24 04          	mov    %eax,0x4(%esp)
 598:	8b 45 08             	mov    0x8(%ebp),%eax
 59b:	89 04 24             	mov    %eax,(%esp)
 59e:	e8 d8 fd ff ff       	call   37b <putc>
        ap++;
 5a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a7:	eb 45                	jmp    5ee <printf+0x193>
      } else if(c == '%'){
 5a9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ad:	75 17                	jne    5c6 <printf+0x16b>
        putc(fd, c);
 5af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b2:	0f be c0             	movsbl %al,%eax
 5b5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b9:	8b 45 08             	mov    0x8(%ebp),%eax
 5bc:	89 04 24             	mov    %eax,(%esp)
 5bf:	e8 b7 fd ff ff       	call   37b <putc>
 5c4:	eb 28                	jmp    5ee <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c6:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5cd:	00 
 5ce:	8b 45 08             	mov    0x8(%ebp),%eax
 5d1:	89 04 24             	mov    %eax,(%esp)
 5d4:	e8 a2 fd ff ff       	call   37b <putc>
        putc(fd, c);
 5d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5dc:	0f be c0             	movsbl %al,%eax
 5df:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	89 04 24             	mov    %eax,(%esp)
 5e9:	e8 8d fd ff ff       	call   37b <putc>
      }
      state = 0;
 5ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ff:	01 d0                	add    %edx,%eax
 601:	0f b6 00             	movzbl (%eax),%eax
 604:	84 c0                	test   %al,%al
 606:	0f 85 71 fe ff ff    	jne    47d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 60c:	c9                   	leave  
 60d:	c3                   	ret    

0000060e <free>:
 60e:	55                   	push   %ebp
 60f:	89 e5                	mov    %esp,%ebp
 611:	83 ec 10             	sub    $0x10,%esp
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	83 e8 08             	sub    $0x8,%eax
 61a:	89 45 f8             	mov    %eax,-0x8(%ebp)
 61d:	a1 bc 0a 00 00       	mov    0xabc,%eax
 622:	89 45 fc             	mov    %eax,-0x4(%ebp)
 625:	eb 24                	jmp    64b <free+0x3d>
 627:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62a:	8b 00                	mov    (%eax),%eax
 62c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 62f:	77 12                	ja     643 <free+0x35>
 631:	8b 45 f8             	mov    -0x8(%ebp),%eax
 634:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 637:	77 24                	ja     65d <free+0x4f>
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 641:	77 1a                	ja     65d <free+0x4f>
 643:	8b 45 fc             	mov    -0x4(%ebp),%eax
 646:	8b 00                	mov    (%eax),%eax
 648:	89 45 fc             	mov    %eax,-0x4(%ebp)
 64b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 651:	76 d4                	jbe    627 <free+0x19>
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 00                	mov    (%eax),%eax
 658:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 65b:	76 ca                	jbe    627 <free+0x19>
 65d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 660:	8b 40 04             	mov    0x4(%eax),%eax
 663:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	01 c2                	add    %eax,%edx
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	39 c2                	cmp    %eax,%edx
 676:	75 24                	jne    69c <free+0x8e>
 678:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67b:	8b 50 04             	mov    0x4(%eax),%edx
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 00                	mov    (%eax),%eax
 683:	8b 40 04             	mov    0x4(%eax),%eax
 686:	01 c2                	add    %eax,%edx
 688:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68b:	89 50 04             	mov    %edx,0x4(%eax)
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	8b 00                	mov    (%eax),%eax
 693:	8b 10                	mov    (%eax),%edx
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	89 10                	mov    %edx,(%eax)
 69a:	eb 0a                	jmp    6a6 <free+0x98>
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 10                	mov    (%eax),%edx
 6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a4:	89 10                	mov    %edx,(%eax)
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	8b 40 04             	mov    0x4(%eax),%eax
 6ac:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	01 d0                	add    %edx,%eax
 6b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6bb:	75 20                	jne    6dd <free+0xcf>
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 50 04             	mov    0x4(%eax),%edx
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	8b 40 04             	mov    0x4(%eax),%eax
 6c9:	01 c2                	add    %eax,%edx
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	89 50 04             	mov    %edx,0x4(%eax)
 6d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d4:	8b 10                	mov    (%eax),%edx
 6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d9:	89 10                	mov    %edx,(%eax)
 6db:	eb 08                	jmp    6e5 <free+0xd7>
 6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e3:	89 10                	mov    %edx,(%eax)
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	a3 bc 0a 00 00       	mov    %eax,0xabc
 6ed:	90                   	nop
 6ee:	c9                   	leave  
 6ef:	c3                   	ret    

000006f0 <morecore>:
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 18             	sub    $0x18,%esp
 6f6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6fd:	77 07                	ja     706 <morecore+0x16>
 6ff:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 706:	8b 45 08             	mov    0x8(%ebp),%eax
 709:	c1 e0 03             	shl    $0x3,%eax
 70c:	83 ec 0c             	sub    $0xc,%esp
 70f:	50                   	push   %eax
 710:	e8 3e fc ff ff       	call   353 <sbrk>
 715:	83 c4 10             	add    $0x10,%esp
 718:	89 45 f4             	mov    %eax,-0xc(%ebp)
 71b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 71f:	75 07                	jne    728 <morecore+0x38>
 721:	b8 00 00 00 00       	mov    $0x0,%eax
 726:	eb 26                	jmp    74e <morecore+0x5e>
 728:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 72e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 731:	8b 55 08             	mov    0x8(%ebp),%edx
 734:	89 50 04             	mov    %edx,0x4(%eax)
 737:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73a:	83 c0 08             	add    $0x8,%eax
 73d:	83 ec 0c             	sub    $0xc,%esp
 740:	50                   	push   %eax
 741:	e8 c8 fe ff ff       	call   60e <free>
 746:	83 c4 10             	add    $0x10,%esp
 749:	a1 bc 0a 00 00       	mov    0xabc,%eax
 74e:	c9                   	leave  
 74f:	c3                   	ret    

00000750 <malloc>:
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	83 ec 18             	sub    $0x18,%esp
 756:	8b 45 08             	mov    0x8(%ebp),%eax
 759:	83 c0 07             	add    $0x7,%eax
 75c:	c1 e8 03             	shr    $0x3,%eax
 75f:	83 c0 01             	add    $0x1,%eax
 762:	89 45 ec             	mov    %eax,-0x14(%ebp)
 765:	a1 bc 0a 00 00       	mov    0xabc,%eax
 76a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 76d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 771:	75 23                	jne    796 <malloc+0x46>
 773:	c7 45 f0 b4 0a 00 00 	movl   $0xab4,-0x10(%ebp)
 77a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77d:	a3 bc 0a 00 00       	mov    %eax,0xabc
 782:	a1 bc 0a 00 00       	mov    0xabc,%eax
 787:	a3 b4 0a 00 00       	mov    %eax,0xab4
 78c:	c7 05 b8 0a 00 00 00 	movl   $0x0,0xab8
 793:	00 00 00 
 796:	8b 45 f0             	mov    -0x10(%ebp),%eax
 799:	8b 00                	mov    (%eax),%eax
 79b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 79e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a1:	8b 40 04             	mov    0x4(%eax),%eax
 7a4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7a7:	72 4d                	jb     7f6 <malloc+0xa6>
 7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ac:	8b 40 04             	mov    0x4(%eax),%eax
 7af:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b2:	75 0c                	jne    7c0 <malloc+0x70>
 7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b7:	8b 10                	mov    (%eax),%edx
 7b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bc:	89 10                	mov    %edx,(%eax)
 7be:	eb 26                	jmp    7e6 <malloc+0x96>
 7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c3:	8b 40 04             	mov    0x4(%eax),%eax
 7c6:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7c9:	89 c2                	mov    %eax,%edx
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	89 50 04             	mov    %edx,0x4(%eax)
 7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d4:	8b 40 04             	mov    0x4(%eax),%eax
 7d7:	c1 e0 03             	shl    $0x3,%eax
 7da:	01 45 f4             	add    %eax,-0xc(%ebp)
 7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7e3:	89 50 04             	mov    %edx,0x4(%eax)
 7e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e9:	a3 bc 0a 00 00       	mov    %eax,0xabc
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	83 c0 08             	add    $0x8,%eax
 7f4:	eb 3b                	jmp    831 <malloc+0xe1>
 7f6:	a1 bc 0a 00 00       	mov    0xabc,%eax
 7fb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7fe:	75 1e                	jne    81e <malloc+0xce>
 800:	83 ec 0c             	sub    $0xc,%esp
 803:	ff 75 ec             	pushl  -0x14(%ebp)
 806:	e8 e5 fe ff ff       	call   6f0 <morecore>
 80b:	83 c4 10             	add    $0x10,%esp
 80e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 811:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 815:	75 07                	jne    81e <malloc+0xce>
 817:	b8 00 00 00 00       	mov    $0x0,%eax
 81c:	eb 13                	jmp    831 <malloc+0xe1>
 81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 821:	89 45 f0             	mov    %eax,-0x10(%ebp)
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	8b 00                	mov    (%eax),%eax
 829:	89 45 f4             	mov    %eax,-0xc(%ebp)
 82c:	e9 6d ff ff ff       	jmp    79e <malloc+0x4e>
 831:	c9                   	leave  
 832:	c3                   	ret    
