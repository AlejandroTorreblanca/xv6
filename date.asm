
_date:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "types.h"
#include "user.h"
#include "date.h"
int
main(int argc , char *argv [])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 24             	sub    $0x24,%esp
	struct  rtcdate r;
	if (date(&r)) {
  11:	83 ec 0c             	sub    $0xc,%esp
  14:	8d 45 e0             	lea    -0x20(%ebp),%eax
  17:	50                   	push   %eax
  18:	e8 38 03 00 00       	call   355 <date>
  1d:	83 c4 10             	add    $0x10,%esp
  20:	85 c0                	test   %eax,%eax
  22:	74 17                	je     3b <main+0x3b>
		printf(2, "date  failed\n");
  24:	83 ec 08             	sub    $0x8,%esp
  27:	68 f2 07 00 00       	push   $0x7f2
  2c:	6a 02                	push   $0x2
  2e:	e8 09 04 00 00       	call   43c <printf>
  33:	83 c4 10             	add    $0x10,%esp
		exit();
  36:	e8 7a 02 00 00       	call   2b5 <exit>
	}
	printf(2, "Hora UTC: %d:%d:%d\n", r.hour,r.minute,r.second);
  3b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  3e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  41:	8b 45 e8             	mov    -0x18(%ebp),%eax
  44:	83 ec 0c             	sub    $0xc,%esp
  47:	51                   	push   %ecx
  48:	52                   	push   %edx
  49:	50                   	push   %eax
  4a:	68 00 08 00 00       	push   $0x800
  4f:	6a 02                	push   $0x2
  51:	e8 e6 03 00 00       	call   43c <printf>
  56:	83 c4 20             	add    $0x20,%esp
	exit();
  59:	e8 57 02 00 00       	call   2b5 <exit>

0000005e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  5e:	55                   	push   %ebp
  5f:	89 e5                	mov    %esp,%ebp
  61:	57                   	push   %edi
  62:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  66:	8b 55 10             	mov    0x10(%ebp),%edx
  69:	8b 45 0c             	mov    0xc(%ebp),%eax
  6c:	89 cb                	mov    %ecx,%ebx
  6e:	89 df                	mov    %ebx,%edi
  70:	89 d1                	mov    %edx,%ecx
  72:	fc                   	cld    
  73:	f3 aa                	rep stos %al,%es:(%edi)
  75:	89 ca                	mov    %ecx,%edx
  77:	89 fb                	mov    %edi,%ebx
  79:	89 5d 08             	mov    %ebx,0x8(%ebp)
  7c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  7f:	90                   	nop
  80:	5b                   	pop    %ebx
  81:	5f                   	pop    %edi
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    

00000084 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8a:	8b 45 08             	mov    0x8(%ebp),%eax
  8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  90:	90                   	nop
  91:	8b 45 08             	mov    0x8(%ebp),%eax
  94:	8d 50 01             	lea    0x1(%eax),%edx
  97:	89 55 08             	mov    %edx,0x8(%ebp)
  9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  9d:	8d 4a 01             	lea    0x1(%edx),%ecx
  a0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  a3:	0f b6 12             	movzbl (%edx),%edx
  a6:	88 10                	mov    %dl,(%eax)
  a8:	0f b6 00             	movzbl (%eax),%eax
  ab:	84 c0                	test   %al,%al
  ad:	75 e2                	jne    91 <strcpy+0xd>
    ;
  return os;
  af:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b2:	c9                   	leave  
  b3:	c3                   	ret    

000000b4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  b7:	eb 08                	jmp    c1 <strcmp+0xd>
    p++, q++;
  b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  bd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	84 c0                	test   %al,%al
  c9:	74 10                	je     db <strcmp+0x27>
  cb:	8b 45 08             	mov    0x8(%ebp),%eax
  ce:	0f b6 10             	movzbl (%eax),%edx
  d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  d4:	0f b6 00             	movzbl (%eax),%eax
  d7:	38 c2                	cmp    %al,%dl
  d9:	74 de                	je     b9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	0f b6 00             	movzbl (%eax),%eax
  e1:	0f b6 d0             	movzbl %al,%edx
  e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	0f b6 c0             	movzbl %al,%eax
  ed:	29 c2                	sub    %eax,%edx
  ef:	89 d0                	mov    %edx,%eax
}
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    

000000f3 <strlen>:

uint
strlen(char *s)
{
  f3:	55                   	push   %ebp
  f4:	89 e5                	mov    %esp,%ebp
  f6:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 100:	eb 04                	jmp    106 <strlen+0x13>
 102:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 106:	8b 55 fc             	mov    -0x4(%ebp),%edx
 109:	8b 45 08             	mov    0x8(%ebp),%eax
 10c:	01 d0                	add    %edx,%eax
 10e:	0f b6 00             	movzbl (%eax),%eax
 111:	84 c0                	test   %al,%al
 113:	75 ed                	jne    102 <strlen+0xf>
    ;
  return n;
 115:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 118:	c9                   	leave  
 119:	c3                   	ret    

0000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	55                   	push   %ebp
 11b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 11d:	8b 45 10             	mov    0x10(%ebp),%eax
 120:	50                   	push   %eax
 121:	ff 75 0c             	pushl  0xc(%ebp)
 124:	ff 75 08             	pushl  0x8(%ebp)
 127:	e8 32 ff ff ff       	call   5e <stosb>
 12c:	83 c4 0c             	add    $0xc,%esp
  return dst;
 12f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 132:	c9                   	leave  
 133:	c3                   	ret    

00000134 <strchr>:

char*
strchr(const char *s, char c)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	83 ec 04             	sub    $0x4,%esp
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 140:	eb 14                	jmp    156 <strchr+0x22>
    if(*s == c)
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	0f b6 00             	movzbl (%eax),%eax
 148:	3a 45 fc             	cmp    -0x4(%ebp),%al
 14b:	75 05                	jne    152 <strchr+0x1e>
      return (char*)s;
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	eb 13                	jmp    165 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 152:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 156:	8b 45 08             	mov    0x8(%ebp),%eax
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	84 c0                	test   %al,%al
 15e:	75 e2                	jne    142 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 160:	b8 00 00 00 00       	mov    $0x0,%eax
}
 165:	c9                   	leave  
 166:	c3                   	ret    

00000167 <gets>:

char*
gets(char *buf, int max)
{
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 174:	eb 42                	jmp    1b8 <gets+0x51>
    cc = read(0, &c, 1);
 176:	83 ec 04             	sub    $0x4,%esp
 179:	6a 01                	push   $0x1
 17b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 17e:	50                   	push   %eax
 17f:	6a 00                	push   $0x0
 181:	e8 47 01 00 00       	call   2cd <read>
 186:	83 c4 10             	add    $0x10,%esp
 189:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 18c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 190:	7e 33                	jle    1c5 <gets+0x5e>
      break;
    buf[i++] = c;
 192:	8b 45 f4             	mov    -0xc(%ebp),%eax
 195:	8d 50 01             	lea    0x1(%eax),%edx
 198:	89 55 f4             	mov    %edx,-0xc(%ebp)
 19b:	89 c2                	mov    %eax,%edx
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
 1a0:	01 c2                	add    %eax,%edx
 1a2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1a8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ac:	3c 0a                	cmp    $0xa,%al
 1ae:	74 16                	je     1c6 <gets+0x5f>
 1b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b4:	3c 0d                	cmp    $0xd,%al
 1b6:	74 0e                	je     1c6 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1bb:	83 c0 01             	add    $0x1,%eax
 1be:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c1:	7c b3                	jl     176 <gets+0xf>
 1c3:	eb 01                	jmp    1c6 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1c5:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c9:	8b 45 08             	mov    0x8(%ebp),%eax
 1cc:	01 d0                	add    %edx,%eax
 1ce:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d4:	c9                   	leave  
 1d5:	c3                   	ret    

000001d6 <stat>:

int
stat(char *n, struct stat *st)
{
 1d6:	55                   	push   %ebp
 1d7:	89 e5                	mov    %esp,%ebp
 1d9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1dc:	83 ec 08             	sub    $0x8,%esp
 1df:	6a 00                	push   $0x0
 1e1:	ff 75 08             	pushl  0x8(%ebp)
 1e4:	e8 0c 01 00 00       	call   2f5 <open>
 1e9:	83 c4 10             	add    $0x10,%esp
 1ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f3:	79 07                	jns    1fc <stat+0x26>
    return -1;
 1f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1fa:	eb 25                	jmp    221 <stat+0x4b>
  r = fstat(fd, st);
 1fc:	83 ec 08             	sub    $0x8,%esp
 1ff:	ff 75 0c             	pushl  0xc(%ebp)
 202:	ff 75 f4             	pushl  -0xc(%ebp)
 205:	e8 03 01 00 00       	call   30d <fstat>
 20a:	83 c4 10             	add    $0x10,%esp
 20d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 210:	83 ec 0c             	sub    $0xc,%esp
 213:	ff 75 f4             	pushl  -0xc(%ebp)
 216:	e8 c2 00 00 00       	call   2dd <close>
 21b:	83 c4 10             	add    $0x10,%esp
  return r;
 21e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 221:	c9                   	leave  
 222:	c3                   	ret    

00000223 <atoi>:

int
atoi(const char *s)
{
 223:	55                   	push   %ebp
 224:	89 e5                	mov    %esp,%ebp
 226:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 229:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 230:	eb 25                	jmp    257 <atoi+0x34>
    n = n*10 + *s++ - '0';
 232:	8b 55 fc             	mov    -0x4(%ebp),%edx
 235:	89 d0                	mov    %edx,%eax
 237:	c1 e0 02             	shl    $0x2,%eax
 23a:	01 d0                	add    %edx,%eax
 23c:	01 c0                	add    %eax,%eax
 23e:	89 c1                	mov    %eax,%ecx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	8d 50 01             	lea    0x1(%eax),%edx
 246:	89 55 08             	mov    %edx,0x8(%ebp)
 249:	0f b6 00             	movzbl (%eax),%eax
 24c:	0f be c0             	movsbl %al,%eax
 24f:	01 c8                	add    %ecx,%eax
 251:	83 e8 30             	sub    $0x30,%eax
 254:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	0f b6 00             	movzbl (%eax),%eax
 25d:	3c 2f                	cmp    $0x2f,%al
 25f:	7e 0a                	jle    26b <atoi+0x48>
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	3c 39                	cmp    $0x39,%al
 269:	7e c7                	jle    232 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 26b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26e:	c9                   	leave  
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 27c:	8b 45 0c             	mov    0xc(%ebp),%eax
 27f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 282:	eb 17                	jmp    29b <memmove+0x2b>
    *dst++ = *src++;
 284:	8b 45 fc             	mov    -0x4(%ebp),%eax
 287:	8d 50 01             	lea    0x1(%eax),%edx
 28a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 28d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 290:	8d 4a 01             	lea    0x1(%edx),%ecx
 293:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 296:	0f b6 12             	movzbl (%edx),%edx
 299:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29b:	8b 45 10             	mov    0x10(%ebp),%eax
 29e:	8d 50 ff             	lea    -0x1(%eax),%edx
 2a1:	89 55 10             	mov    %edx,0x10(%ebp)
 2a4:	85 c0                	test   %eax,%eax
 2a6:	7f dc                	jg     284 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ab:	c9                   	leave  
 2ac:	c3                   	ret    

000002ad <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ad:	b8 01 00 00 00       	mov    $0x1,%eax
 2b2:	cd 40                	int    $0x40
 2b4:	c3                   	ret    

000002b5 <exit>:
SYSCALL(exit)
 2b5:	b8 02 00 00 00       	mov    $0x2,%eax
 2ba:	cd 40                	int    $0x40
 2bc:	c3                   	ret    

000002bd <wait>:
SYSCALL(wait)
 2bd:	b8 03 00 00 00       	mov    $0x3,%eax
 2c2:	cd 40                	int    $0x40
 2c4:	c3                   	ret    

000002c5 <pipe>:
SYSCALL(pipe)
 2c5:	b8 04 00 00 00       	mov    $0x4,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <read>:
SYSCALL(read)
 2cd:	b8 05 00 00 00       	mov    $0x5,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <write>:
SYSCALL(write)
 2d5:	b8 10 00 00 00       	mov    $0x10,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <close>:
SYSCALL(close)
 2dd:	b8 15 00 00 00       	mov    $0x15,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <kill>:
SYSCALL(kill)
 2e5:	b8 06 00 00 00       	mov    $0x6,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <exec>:
SYSCALL(exec)
 2ed:	b8 07 00 00 00       	mov    $0x7,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <open>:
SYSCALL(open)
 2f5:	b8 0f 00 00 00       	mov    $0xf,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <mknod>:
SYSCALL(mknod)
 2fd:	b8 11 00 00 00       	mov    $0x11,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <unlink>:
SYSCALL(unlink)
 305:	b8 12 00 00 00       	mov    $0x12,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <fstat>:
SYSCALL(fstat)
 30d:	b8 08 00 00 00       	mov    $0x8,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <link>:
SYSCALL(link)
 315:	b8 13 00 00 00       	mov    $0x13,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <mkdir>:
SYSCALL(mkdir)
 31d:	b8 14 00 00 00       	mov    $0x14,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <chdir>:
SYSCALL(chdir)
 325:	b8 09 00 00 00       	mov    $0x9,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <dup>:
SYSCALL(dup)
 32d:	b8 0a 00 00 00       	mov    $0xa,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <getpid>:
SYSCALL(getpid)
 335:	b8 0b 00 00 00       	mov    $0xb,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <sbrk>:
SYSCALL(sbrk)
 33d:	b8 0c 00 00 00       	mov    $0xc,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <sleep>:
SYSCALL(sleep)
 345:	b8 0d 00 00 00       	mov    $0xd,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <uptime>:
SYSCALL(uptime)
 34d:	b8 0e 00 00 00       	mov    $0xe,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <date>:
SYSCALL(date)
 355:	b8 16 00 00 00       	mov    $0x16,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <dup2>:
SYSCALL(dup2)
 35d:	b8 17 00 00 00       	mov    $0x17,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 365:	55                   	push   %ebp
 366:	89 e5                	mov    %esp,%ebp
 368:	83 ec 18             	sub    $0x18,%esp
 36b:	8b 45 0c             	mov    0xc(%ebp),%eax
 36e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 371:	83 ec 04             	sub    $0x4,%esp
 374:	6a 01                	push   $0x1
 376:	8d 45 f4             	lea    -0xc(%ebp),%eax
 379:	50                   	push   %eax
 37a:	ff 75 08             	pushl  0x8(%ebp)
 37d:	e8 53 ff ff ff       	call   2d5 <write>
 382:	83 c4 10             	add    $0x10,%esp
}
 385:	90                   	nop
 386:	c9                   	leave  
 387:	c3                   	ret    

00000388 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	53                   	push   %ebx
 38c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 38f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 396:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 39a:	74 17                	je     3b3 <printint+0x2b>
 39c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a0:	79 11                	jns    3b3 <printint+0x2b>
    neg = 1;
 3a2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ac:	f7 d8                	neg    %eax
 3ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b1:	eb 06                	jmp    3b9 <printint+0x31>
  } else {
    x = xx;
 3b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3c0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3c3:	8d 41 01             	lea    0x1(%ecx),%eax
 3c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3c9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3cf:	ba 00 00 00 00       	mov    $0x0,%edx
 3d4:	f7 f3                	div    %ebx
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	0f b6 80 64 0a 00 00 	movzbl 0xa64(%eax),%eax
 3df:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3e3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e9:	ba 00 00 00 00       	mov    $0x0,%edx
 3ee:	f7 f3                	div    %ebx
 3f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3f7:	75 c7                	jne    3c0 <printint+0x38>
  if(neg)
 3f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3fd:	74 2d                	je     42c <printint+0xa4>
    buf[i++] = '-';
 3ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 402:	8d 50 01             	lea    0x1(%eax),%edx
 405:	89 55 f4             	mov    %edx,-0xc(%ebp)
 408:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 40d:	eb 1d                	jmp    42c <printint+0xa4>
    putc(fd, buf[i]);
 40f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 412:	8b 45 f4             	mov    -0xc(%ebp),%eax
 415:	01 d0                	add    %edx,%eax
 417:	0f b6 00             	movzbl (%eax),%eax
 41a:	0f be c0             	movsbl %al,%eax
 41d:	83 ec 08             	sub    $0x8,%esp
 420:	50                   	push   %eax
 421:	ff 75 08             	pushl  0x8(%ebp)
 424:	e8 3c ff ff ff       	call   365 <putc>
 429:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 42c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 430:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 434:	79 d9                	jns    40f <printint+0x87>
    putc(fd, buf[i]);
}
 436:	90                   	nop
 437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43a:	c9                   	leave  
 43b:	c3                   	ret    

0000043c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 43c:	55                   	push   %ebp
 43d:	89 e5                	mov    %esp,%ebp
 43f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 442:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 449:	8d 45 0c             	lea    0xc(%ebp),%eax
 44c:	83 c0 04             	add    $0x4,%eax
 44f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 452:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 459:	e9 59 01 00 00       	jmp    5b7 <printf+0x17b>
    c = fmt[i] & 0xff;
 45e:	8b 55 0c             	mov    0xc(%ebp),%edx
 461:	8b 45 f0             	mov    -0x10(%ebp),%eax
 464:	01 d0                	add    %edx,%eax
 466:	0f b6 00             	movzbl (%eax),%eax
 469:	0f be c0             	movsbl %al,%eax
 46c:	25 ff 00 00 00       	and    $0xff,%eax
 471:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 474:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 478:	75 2c                	jne    4a6 <printf+0x6a>
      if(c == '%'){
 47a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 47e:	75 0c                	jne    48c <printf+0x50>
        state = '%';
 480:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 487:	e9 27 01 00 00       	jmp    5b3 <printf+0x177>
      } else {
        putc(fd, c);
 48c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 48f:	0f be c0             	movsbl %al,%eax
 492:	83 ec 08             	sub    $0x8,%esp
 495:	50                   	push   %eax
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 c7 fe ff ff       	call   365 <putc>
 49e:	83 c4 10             	add    $0x10,%esp
 4a1:	e9 0d 01 00 00       	jmp    5b3 <printf+0x177>
      }
    } else if(state == '%'){
 4a6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4aa:	0f 85 03 01 00 00    	jne    5b3 <printf+0x177>
      if(c == 'd'){
 4b0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b4:	75 1e                	jne    4d4 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b9:	8b 00                	mov    (%eax),%eax
 4bb:	6a 01                	push   $0x1
 4bd:	6a 0a                	push   $0xa
 4bf:	50                   	push   %eax
 4c0:	ff 75 08             	pushl  0x8(%ebp)
 4c3:	e8 c0 fe ff ff       	call   388 <printint>
 4c8:	83 c4 10             	add    $0x10,%esp
        ap++;
 4cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4cf:	e9 d8 00 00 00       	jmp    5ac <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4d4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4d8:	74 06                	je     4e0 <printf+0xa4>
 4da:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4de:	75 1e                	jne    4fe <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e3:	8b 00                	mov    (%eax),%eax
 4e5:	6a 00                	push   $0x0
 4e7:	6a 10                	push   $0x10
 4e9:	50                   	push   %eax
 4ea:	ff 75 08             	pushl  0x8(%ebp)
 4ed:	e8 96 fe ff ff       	call   388 <printint>
 4f2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f9:	e9 ae 00 00 00       	jmp    5ac <printf+0x170>
      } else if(c == 's'){
 4fe:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 502:	75 43                	jne    547 <printf+0x10b>
        s = (char*)*ap;
 504:	8b 45 e8             	mov    -0x18(%ebp),%eax
 507:	8b 00                	mov    (%eax),%eax
 509:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 50c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 510:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 514:	75 25                	jne    53b <printf+0xff>
          s = "(null)";
 516:	c7 45 f4 14 08 00 00 	movl   $0x814,-0xc(%ebp)
        while(*s != 0){
 51d:	eb 1c                	jmp    53b <printf+0xff>
          putc(fd, *s);
 51f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 522:	0f b6 00             	movzbl (%eax),%eax
 525:	0f be c0             	movsbl %al,%eax
 528:	83 ec 08             	sub    $0x8,%esp
 52b:	50                   	push   %eax
 52c:	ff 75 08             	pushl  0x8(%ebp)
 52f:	e8 31 fe ff ff       	call   365 <putc>
 534:	83 c4 10             	add    $0x10,%esp
          s++;
 537:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53e:	0f b6 00             	movzbl (%eax),%eax
 541:	84 c0                	test   %al,%al
 543:	75 da                	jne    51f <printf+0xe3>
 545:	eb 65                	jmp    5ac <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 547:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54b:	75 1d                	jne    56a <printf+0x12e>
        putc(fd, *ap);
 54d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 550:	8b 00                	mov    (%eax),%eax
 552:	0f be c0             	movsbl %al,%eax
 555:	83 ec 08             	sub    $0x8,%esp
 558:	50                   	push   %eax
 559:	ff 75 08             	pushl  0x8(%ebp)
 55c:	e8 04 fe ff ff       	call   365 <putc>
 561:	83 c4 10             	add    $0x10,%esp
        ap++;
 564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 568:	eb 42                	jmp    5ac <printf+0x170>
      } else if(c == '%'){
 56a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 56e:	75 17                	jne    587 <printf+0x14b>
        putc(fd, c);
 570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 573:	0f be c0             	movsbl %al,%eax
 576:	83 ec 08             	sub    $0x8,%esp
 579:	50                   	push   %eax
 57a:	ff 75 08             	pushl  0x8(%ebp)
 57d:	e8 e3 fd ff ff       	call   365 <putc>
 582:	83 c4 10             	add    $0x10,%esp
 585:	eb 25                	jmp    5ac <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 587:	83 ec 08             	sub    $0x8,%esp
 58a:	6a 25                	push   $0x25
 58c:	ff 75 08             	pushl  0x8(%ebp)
 58f:	e8 d1 fd ff ff       	call   365 <putc>
 594:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 597:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59a:	0f be c0             	movsbl %al,%eax
 59d:	83 ec 08             	sub    $0x8,%esp
 5a0:	50                   	push   %eax
 5a1:	ff 75 08             	pushl  0x8(%ebp)
 5a4:	e8 bc fd ff ff       	call   365 <putc>
 5a9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bd:	01 d0                	add    %edx,%eax
 5bf:	0f b6 00             	movzbl (%eax),%eax
 5c2:	84 c0                	test   %al,%al
 5c4:	0f 85 94 fe ff ff    	jne    45e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ca:	90                   	nop
 5cb:	c9                   	leave  
 5cc:	c3                   	ret    

000005cd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5cd:	55                   	push   %ebp
 5ce:	89 e5                	mov    %esp,%ebp
 5d0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d3:	8b 45 08             	mov    0x8(%ebp),%eax
 5d6:	83 e8 08             	sub    $0x8,%eax
 5d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5dc:	a1 80 0a 00 00       	mov    0xa80,%eax
 5e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e4:	eb 24                	jmp    60a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e9:	8b 00                	mov    (%eax),%eax
 5eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ee:	77 12                	ja     602 <free+0x35>
 5f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f6:	77 24                	ja     61c <free+0x4f>
 5f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fb:	8b 00                	mov    (%eax),%eax
 5fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 600:	77 1a                	ja     61c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 602:	8b 45 fc             	mov    -0x4(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 610:	76 d4                	jbe    5e6 <free+0x19>
 612:	8b 45 fc             	mov    -0x4(%ebp),%eax
 615:	8b 00                	mov    (%eax),%eax
 617:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 61a:	76 ca                	jbe    5e6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 61c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61f:	8b 40 04             	mov    0x4(%eax),%eax
 622:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 629:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62c:	01 c2                	add    %eax,%edx
 62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 631:	8b 00                	mov    (%eax),%eax
 633:	39 c2                	cmp    %eax,%edx
 635:	75 24                	jne    65b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	8b 50 04             	mov    0x4(%eax),%edx
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	8b 40 04             	mov    0x4(%eax),%eax
 645:	01 c2                	add    %eax,%edx
 647:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 64d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 650:	8b 00                	mov    (%eax),%eax
 652:	8b 10                	mov    (%eax),%edx
 654:	8b 45 f8             	mov    -0x8(%ebp),%eax
 657:	89 10                	mov    %edx,(%eax)
 659:	eb 0a                	jmp    665 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 10                	mov    (%eax),%edx
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 40 04             	mov    0x4(%eax),%eax
 66b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 672:	8b 45 fc             	mov    -0x4(%ebp),%eax
 675:	01 d0                	add    %edx,%eax
 677:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67a:	75 20                	jne    69c <free+0xcf>
    p->s.size += bp->s.size;
 67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67f:	8b 50 04             	mov    0x4(%eax),%edx
 682:	8b 45 f8             	mov    -0x8(%ebp),%eax
 685:	8b 40 04             	mov    0x4(%eax),%eax
 688:	01 c2                	add    %eax,%edx
 68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 690:	8b 45 f8             	mov    -0x8(%ebp),%eax
 693:	8b 10                	mov    (%eax),%edx
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	89 10                	mov    %edx,(%eax)
 69a:	eb 08                	jmp    6a4 <free+0xd7>
  } else
    p->s.ptr = bp;
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a2:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a7:	a3 80 0a 00 00       	mov    %eax,0xa80
}
 6ac:	90                   	nop
 6ad:	c9                   	leave  
 6ae:	c3                   	ret    

000006af <morecore>:

static Header*
morecore(uint nu)
{
 6af:	55                   	push   %ebp
 6b0:	89 e5                	mov    %esp,%ebp
 6b2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6bc:	77 07                	ja     6c5 <morecore+0x16>
    nu = 4096;
 6be:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c5:	8b 45 08             	mov    0x8(%ebp),%eax
 6c8:	c1 e0 03             	shl    $0x3,%eax
 6cb:	83 ec 0c             	sub    $0xc,%esp
 6ce:	50                   	push   %eax
 6cf:	e8 69 fc ff ff       	call   33d <sbrk>
 6d4:	83 c4 10             	add    $0x10,%esp
 6d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6da:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6de:	75 07                	jne    6e7 <morecore+0x38>
    return 0;
 6e0:	b8 00 00 00 00       	mov    $0x0,%eax
 6e5:	eb 26                	jmp    70d <morecore+0x5e>
  hp = (Header*)p;
 6e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f0:	8b 55 08             	mov    0x8(%ebp),%edx
 6f3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f9:	83 c0 08             	add    $0x8,%eax
 6fc:	83 ec 0c             	sub    $0xc,%esp
 6ff:	50                   	push   %eax
 700:	e8 c8 fe ff ff       	call   5cd <free>
 705:	83 c4 10             	add    $0x10,%esp
  return freep;
 708:	a1 80 0a 00 00       	mov    0xa80,%eax
}
 70d:	c9                   	leave  
 70e:	c3                   	ret    

0000070f <malloc>:

void*
malloc(uint nbytes)
{
 70f:	55                   	push   %ebp
 710:	89 e5                	mov    %esp,%ebp
 712:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 715:	8b 45 08             	mov    0x8(%ebp),%eax
 718:	83 c0 07             	add    $0x7,%eax
 71b:	c1 e8 03             	shr    $0x3,%eax
 71e:	83 c0 01             	add    $0x1,%eax
 721:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 724:	a1 80 0a 00 00       	mov    0xa80,%eax
 729:	89 45 f0             	mov    %eax,-0x10(%ebp)
 72c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 730:	75 23                	jne    755 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 732:	c7 45 f0 78 0a 00 00 	movl   $0xa78,-0x10(%ebp)
 739:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73c:	a3 80 0a 00 00       	mov    %eax,0xa80
 741:	a1 80 0a 00 00       	mov    0xa80,%eax
 746:	a3 78 0a 00 00       	mov    %eax,0xa78
    base.s.size = 0;
 74b:	c7 05 7c 0a 00 00 00 	movl   $0x0,0xa7c
 752:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 755:	8b 45 f0             	mov    -0x10(%ebp),%eax
 758:	8b 00                	mov    (%eax),%eax
 75a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 75d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 760:	8b 40 04             	mov    0x4(%eax),%eax
 763:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 766:	72 4d                	jb     7b5 <malloc+0xa6>
      if(p->s.size == nunits)
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	8b 40 04             	mov    0x4(%eax),%eax
 76e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 771:	75 0c                	jne    77f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	8b 10                	mov    (%eax),%edx
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	89 10                	mov    %edx,(%eax)
 77d:	eb 26                	jmp    7a5 <malloc+0x96>
      else {
        p->s.size -= nunits;
 77f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 782:	8b 40 04             	mov    0x4(%eax),%eax
 785:	2b 45 ec             	sub    -0x14(%ebp),%eax
 788:	89 c2                	mov    %eax,%edx
 78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 790:	8b 45 f4             	mov    -0xc(%ebp),%eax
 793:	8b 40 04             	mov    0x4(%eax),%eax
 796:	c1 e0 03             	shl    $0x3,%eax
 799:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	a3 80 0a 00 00       	mov    %eax,0xa80
      return (void*)(p + 1);
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	83 c0 08             	add    $0x8,%eax
 7b3:	eb 3b                	jmp    7f0 <malloc+0xe1>
    }
    if(p == freep)
 7b5:	a1 80 0a 00 00       	mov    0xa80,%eax
 7ba:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7bd:	75 1e                	jne    7dd <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7bf:	83 ec 0c             	sub    $0xc,%esp
 7c2:	ff 75 ec             	pushl  -0x14(%ebp)
 7c5:	e8 e5 fe ff ff       	call   6af <morecore>
 7ca:	83 c4 10             	add    $0x10,%esp
 7cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d4:	75 07                	jne    7dd <malloc+0xce>
        return 0;
 7d6:	b8 00 00 00 00       	mov    $0x0,%eax
 7db:	eb 13                	jmp    7f0 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 00                	mov    (%eax),%eax
 7e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7eb:	e9 6d ff ff ff       	jmp    75d <malloc+0x4e>
}
 7f0:	c9                   	leave  
 7f1:	c3                   	ret    
