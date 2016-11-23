
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
  27:	68 ea 07 00 00       	push   $0x7ea
  2c:	6a 02                	push   $0x2
  2e:	e8 01 04 00 00       	call   434 <printf>
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
  4a:	68 f8 07 00 00       	push   $0x7f8
  4f:	6a 02                	push   $0x2
  51:	e8 de 03 00 00       	call   434 <printf>
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

0000035d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 35d:	55                   	push   %ebp
 35e:	89 e5                	mov    %esp,%ebp
 360:	83 ec 18             	sub    $0x18,%esp
 363:	8b 45 0c             	mov    0xc(%ebp),%eax
 366:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 369:	83 ec 04             	sub    $0x4,%esp
 36c:	6a 01                	push   $0x1
 36e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 371:	50                   	push   %eax
 372:	ff 75 08             	pushl  0x8(%ebp)
 375:	e8 5b ff ff ff       	call   2d5 <write>
 37a:	83 c4 10             	add    $0x10,%esp
}
 37d:	90                   	nop
 37e:	c9                   	leave  
 37f:	c3                   	ret    

00000380 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	53                   	push   %ebx
 384:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 387:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 38e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 392:	74 17                	je     3ab <printint+0x2b>
 394:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 398:	79 11                	jns    3ab <printint+0x2b>
    neg = 1;
 39a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a4:	f7 d8                	neg    %eax
 3a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3a9:	eb 06                	jmp    3b1 <printint+0x31>
  } else {
    x = xx;
 3ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3b8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3bb:	8d 41 01             	lea    0x1(%ecx),%eax
 3be:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3c1:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c7:	ba 00 00 00 00       	mov    $0x0,%edx
 3cc:	f7 f3                	div    %ebx
 3ce:	89 d0                	mov    %edx,%eax
 3d0:	0f b6 80 5c 0a 00 00 	movzbl 0xa5c(%eax),%eax
 3d7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3db:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3de:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e1:	ba 00 00 00 00       	mov    $0x0,%edx
 3e6:	f7 f3                	div    %ebx
 3e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ef:	75 c7                	jne    3b8 <printint+0x38>
  if(neg)
 3f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f5:	74 2d                	je     424 <printint+0xa4>
    buf[i++] = '-';
 3f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3fa:	8d 50 01             	lea    0x1(%eax),%edx
 3fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 400:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 405:	eb 1d                	jmp    424 <printint+0xa4>
    putc(fd, buf[i]);
 407:	8d 55 dc             	lea    -0x24(%ebp),%edx
 40a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40d:	01 d0                	add    %edx,%eax
 40f:	0f b6 00             	movzbl (%eax),%eax
 412:	0f be c0             	movsbl %al,%eax
 415:	83 ec 08             	sub    $0x8,%esp
 418:	50                   	push   %eax
 419:	ff 75 08             	pushl  0x8(%ebp)
 41c:	e8 3c ff ff ff       	call   35d <putc>
 421:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 424:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 428:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 42c:	79 d9                	jns    407 <printint+0x87>
    putc(fd, buf[i]);
}
 42e:	90                   	nop
 42f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 43a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 441:	8d 45 0c             	lea    0xc(%ebp),%eax
 444:	83 c0 04             	add    $0x4,%eax
 447:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 44a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 451:	e9 59 01 00 00       	jmp    5af <printf+0x17b>
    c = fmt[i] & 0xff;
 456:	8b 55 0c             	mov    0xc(%ebp),%edx
 459:	8b 45 f0             	mov    -0x10(%ebp),%eax
 45c:	01 d0                	add    %edx,%eax
 45e:	0f b6 00             	movzbl (%eax),%eax
 461:	0f be c0             	movsbl %al,%eax
 464:	25 ff 00 00 00       	and    $0xff,%eax
 469:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 46c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 470:	75 2c                	jne    49e <printf+0x6a>
      if(c == '%'){
 472:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 476:	75 0c                	jne    484 <printf+0x50>
        state = '%';
 478:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 47f:	e9 27 01 00 00       	jmp    5ab <printf+0x177>
      } else {
        putc(fd, c);
 484:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 487:	0f be c0             	movsbl %al,%eax
 48a:	83 ec 08             	sub    $0x8,%esp
 48d:	50                   	push   %eax
 48e:	ff 75 08             	pushl  0x8(%ebp)
 491:	e8 c7 fe ff ff       	call   35d <putc>
 496:	83 c4 10             	add    $0x10,%esp
 499:	e9 0d 01 00 00       	jmp    5ab <printf+0x177>
      }
    } else if(state == '%'){
 49e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4a2:	0f 85 03 01 00 00    	jne    5ab <printf+0x177>
      if(c == 'd'){
 4a8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ac:	75 1e                	jne    4cc <printf+0x98>
        printint(fd, *ap, 10, 1);
 4ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b1:	8b 00                	mov    (%eax),%eax
 4b3:	6a 01                	push   $0x1
 4b5:	6a 0a                	push   $0xa
 4b7:	50                   	push   %eax
 4b8:	ff 75 08             	pushl  0x8(%ebp)
 4bb:	e8 c0 fe ff ff       	call   380 <printint>
 4c0:	83 c4 10             	add    $0x10,%esp
        ap++;
 4c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c7:	e9 d8 00 00 00       	jmp    5a4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4cc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4d0:	74 06                	je     4d8 <printf+0xa4>
 4d2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4d6:	75 1e                	jne    4f6 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4db:	8b 00                	mov    (%eax),%eax
 4dd:	6a 00                	push   $0x0
 4df:	6a 10                	push   $0x10
 4e1:	50                   	push   %eax
 4e2:	ff 75 08             	pushl  0x8(%ebp)
 4e5:	e8 96 fe ff ff       	call   380 <printint>
 4ea:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f1:	e9 ae 00 00 00       	jmp    5a4 <printf+0x170>
      } else if(c == 's'){
 4f6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4fa:	75 43                	jne    53f <printf+0x10b>
        s = (char*)*ap;
 4fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ff:	8b 00                	mov    (%eax),%eax
 501:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 504:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 508:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 50c:	75 25                	jne    533 <printf+0xff>
          s = "(null)";
 50e:	c7 45 f4 0c 08 00 00 	movl   $0x80c,-0xc(%ebp)
        while(*s != 0){
 515:	eb 1c                	jmp    533 <printf+0xff>
          putc(fd, *s);
 517:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51a:	0f b6 00             	movzbl (%eax),%eax
 51d:	0f be c0             	movsbl %al,%eax
 520:	83 ec 08             	sub    $0x8,%esp
 523:	50                   	push   %eax
 524:	ff 75 08             	pushl  0x8(%ebp)
 527:	e8 31 fe ff ff       	call   35d <putc>
 52c:	83 c4 10             	add    $0x10,%esp
          s++;
 52f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 533:	8b 45 f4             	mov    -0xc(%ebp),%eax
 536:	0f b6 00             	movzbl (%eax),%eax
 539:	84 c0                	test   %al,%al
 53b:	75 da                	jne    517 <printf+0xe3>
 53d:	eb 65                	jmp    5a4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 543:	75 1d                	jne    562 <printf+0x12e>
        putc(fd, *ap);
 545:	8b 45 e8             	mov    -0x18(%ebp),%eax
 548:	8b 00                	mov    (%eax),%eax
 54a:	0f be c0             	movsbl %al,%eax
 54d:	83 ec 08             	sub    $0x8,%esp
 550:	50                   	push   %eax
 551:	ff 75 08             	pushl  0x8(%ebp)
 554:	e8 04 fe ff ff       	call   35d <putc>
 559:	83 c4 10             	add    $0x10,%esp
        ap++;
 55c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 560:	eb 42                	jmp    5a4 <printf+0x170>
      } else if(c == '%'){
 562:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 566:	75 17                	jne    57f <printf+0x14b>
        putc(fd, c);
 568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56b:	0f be c0             	movsbl %al,%eax
 56e:	83 ec 08             	sub    $0x8,%esp
 571:	50                   	push   %eax
 572:	ff 75 08             	pushl  0x8(%ebp)
 575:	e8 e3 fd ff ff       	call   35d <putc>
 57a:	83 c4 10             	add    $0x10,%esp
 57d:	eb 25                	jmp    5a4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 57f:	83 ec 08             	sub    $0x8,%esp
 582:	6a 25                	push   $0x25
 584:	ff 75 08             	pushl  0x8(%ebp)
 587:	e8 d1 fd ff ff       	call   35d <putc>
 58c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 58f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 592:	0f be c0             	movsbl %al,%eax
 595:	83 ec 08             	sub    $0x8,%esp
 598:	50                   	push   %eax
 599:	ff 75 08             	pushl  0x8(%ebp)
 59c:	e8 bc fd ff ff       	call   35d <putc>
 5a1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5a4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ab:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5af:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b5:	01 d0                	add    %edx,%eax
 5b7:	0f b6 00             	movzbl (%eax),%eax
 5ba:	84 c0                	test   %al,%al
 5bc:	0f 85 94 fe ff ff    	jne    456 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c2:	90                   	nop
 5c3:	c9                   	leave  
 5c4:	c3                   	ret    

000005c5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c5:	55                   	push   %ebp
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5cb:	8b 45 08             	mov    0x8(%ebp),%eax
 5ce:	83 e8 08             	sub    $0x8,%eax
 5d1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d4:	a1 78 0a 00 00       	mov    0xa78,%eax
 5d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5dc:	eb 24                	jmp    602 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e1:	8b 00                	mov    (%eax),%eax
 5e3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e6:	77 12                	ja     5fa <free+0x35>
 5e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ee:	77 24                	ja     614 <free+0x4f>
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f8:	77 1a                	ja     614 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fd:	8b 00                	mov    (%eax),%eax
 5ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
 602:	8b 45 f8             	mov    -0x8(%ebp),%eax
 605:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 608:	76 d4                	jbe    5de <free+0x19>
 60a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60d:	8b 00                	mov    (%eax),%eax
 60f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 612:	76 ca                	jbe    5de <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 614:	8b 45 f8             	mov    -0x8(%ebp),%eax
 617:	8b 40 04             	mov    0x4(%eax),%eax
 61a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 621:	8b 45 f8             	mov    -0x8(%ebp),%eax
 624:	01 c2                	add    %eax,%edx
 626:	8b 45 fc             	mov    -0x4(%ebp),%eax
 629:	8b 00                	mov    (%eax),%eax
 62b:	39 c2                	cmp    %eax,%edx
 62d:	75 24                	jne    653 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 632:	8b 50 04             	mov    0x4(%eax),%edx
 635:	8b 45 fc             	mov    -0x4(%ebp),%eax
 638:	8b 00                	mov    (%eax),%eax
 63a:	8b 40 04             	mov    0x4(%eax),%eax
 63d:	01 c2                	add    %eax,%edx
 63f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 642:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 645:	8b 45 fc             	mov    -0x4(%ebp),%eax
 648:	8b 00                	mov    (%eax),%eax
 64a:	8b 10                	mov    (%eax),%edx
 64c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64f:	89 10                	mov    %edx,(%eax)
 651:	eb 0a                	jmp    65d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 10                	mov    (%eax),%edx
 658:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 40 04             	mov    0x4(%eax),%eax
 663:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	01 d0                	add    %edx,%eax
 66f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 672:	75 20                	jne    694 <free+0xcf>
    p->s.size += bp->s.size;
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 50 04             	mov    0x4(%eax),%edx
 67a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67d:	8b 40 04             	mov    0x4(%eax),%eax
 680:	01 c2                	add    %eax,%edx
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 688:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68b:	8b 10                	mov    (%eax),%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	89 10                	mov    %edx,(%eax)
 692:	eb 08                	jmp    69c <free+0xd7>
  } else
    p->s.ptr = bp;
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	8b 55 f8             	mov    -0x8(%ebp),%edx
 69a:	89 10                	mov    %edx,(%eax)
  freep = p;
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	a3 78 0a 00 00       	mov    %eax,0xa78
}
 6a4:	90                   	nop
 6a5:	c9                   	leave  
 6a6:	c3                   	ret    

000006a7 <morecore>:

static Header*
morecore(uint nu)
{
 6a7:	55                   	push   %ebp
 6a8:	89 e5                	mov    %esp,%ebp
 6aa:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6ad:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6b4:	77 07                	ja     6bd <morecore+0x16>
    nu = 4096;
 6b6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6bd:	8b 45 08             	mov    0x8(%ebp),%eax
 6c0:	c1 e0 03             	shl    $0x3,%eax
 6c3:	83 ec 0c             	sub    $0xc,%esp
 6c6:	50                   	push   %eax
 6c7:	e8 71 fc ff ff       	call   33d <sbrk>
 6cc:	83 c4 10             	add    $0x10,%esp
 6cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6d2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6d6:	75 07                	jne    6df <morecore+0x38>
    return 0;
 6d8:	b8 00 00 00 00       	mov    $0x0,%eax
 6dd:	eb 26                	jmp    705 <morecore+0x5e>
  hp = (Header*)p;
 6df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e8:	8b 55 08             	mov    0x8(%ebp),%edx
 6eb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f1:	83 c0 08             	add    $0x8,%eax
 6f4:	83 ec 0c             	sub    $0xc,%esp
 6f7:	50                   	push   %eax
 6f8:	e8 c8 fe ff ff       	call   5c5 <free>
 6fd:	83 c4 10             	add    $0x10,%esp
  return freep;
 700:	a1 78 0a 00 00       	mov    0xa78,%eax
}
 705:	c9                   	leave  
 706:	c3                   	ret    

00000707 <malloc>:

void*
malloc(uint nbytes)
{
 707:	55                   	push   %ebp
 708:	89 e5                	mov    %esp,%ebp
 70a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
 710:	83 c0 07             	add    $0x7,%eax
 713:	c1 e8 03             	shr    $0x3,%eax
 716:	83 c0 01             	add    $0x1,%eax
 719:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 71c:	a1 78 0a 00 00       	mov    0xa78,%eax
 721:	89 45 f0             	mov    %eax,-0x10(%ebp)
 724:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 728:	75 23                	jne    74d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 72a:	c7 45 f0 70 0a 00 00 	movl   $0xa70,-0x10(%ebp)
 731:	8b 45 f0             	mov    -0x10(%ebp),%eax
 734:	a3 78 0a 00 00       	mov    %eax,0xa78
 739:	a1 78 0a 00 00       	mov    0xa78,%eax
 73e:	a3 70 0a 00 00       	mov    %eax,0xa70
    base.s.size = 0;
 743:	c7 05 74 0a 00 00 00 	movl   $0x0,0xa74
 74a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 750:	8b 00                	mov    (%eax),%eax
 752:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8b 40 04             	mov    0x4(%eax),%eax
 75b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 75e:	72 4d                	jb     7ad <malloc+0xa6>
      if(p->s.size == nunits)
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	8b 40 04             	mov    0x4(%eax),%eax
 766:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 769:	75 0c                	jne    777 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 76b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76e:	8b 10                	mov    (%eax),%edx
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	89 10                	mov    %edx,(%eax)
 775:	eb 26                	jmp    79d <malloc+0x96>
      else {
        p->s.size -= nunits;
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	8b 40 04             	mov    0x4(%eax),%eax
 77d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 780:	89 c2                	mov    %eax,%edx
 782:	8b 45 f4             	mov    -0xc(%ebp),%eax
 785:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 788:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78b:	8b 40 04             	mov    0x4(%eax),%eax
 78e:	c1 e0 03             	shl    $0x3,%eax
 791:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 794:	8b 45 f4             	mov    -0xc(%ebp),%eax
 797:	8b 55 ec             	mov    -0x14(%ebp),%edx
 79a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	a3 78 0a 00 00       	mov    %eax,0xa78
      return (void*)(p + 1);
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	83 c0 08             	add    $0x8,%eax
 7ab:	eb 3b                	jmp    7e8 <malloc+0xe1>
    }
    if(p == freep)
 7ad:	a1 78 0a 00 00       	mov    0xa78,%eax
 7b2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7b5:	75 1e                	jne    7d5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7b7:	83 ec 0c             	sub    $0xc,%esp
 7ba:	ff 75 ec             	pushl  -0x14(%ebp)
 7bd:	e8 e5 fe ff ff       	call   6a7 <morecore>
 7c2:	83 c4 10             	add    $0x10,%esp
 7c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7cc:	75 07                	jne    7d5 <malloc+0xce>
        return 0;
 7ce:	b8 00 00 00 00       	mov    $0x0,%eax
 7d3:	eb 13                	jmp    7e8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	8b 00                	mov    (%eax),%eax
 7e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7e3:	e9 6d ff ff ff       	jmp    755 <malloc+0x4e>
}
 7e8:	c9                   	leave  
 7e9:	c3                   	ret    
