
_dup2:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "types.h"
#include "user.h"


int 
main(int argc, char *argv[]){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
	int fd1,fd2;
	fd1=open("cat", 0);	
   9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10:	00 
  11:	c7 04 24 88 09 00 00 	movl   $0x988,(%esp)
  18:	e8 43 04 00 00       	call   460 <open>
  1d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(fd1<0){
  21:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  26:	79 19                	jns    41 <main+0x41>
		printf(2,"No se ha podido abrir\n");
  28:	c7 44 24 04 8c 09 00 	movl   $0x98c,0x4(%esp)
  2f:	00 
  30:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  37:	e8 74 05 00 00       	call   5b0 <printf>
		exit();
  3c:	e8 df 03 00 00       	call   420 <exit>
	}
	fd2=-1;
  41:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
  48:	ff 
	printf(2,"fd2=-1: %d\n",dup2(fd1,fd2));
  49:	8b 44 24 18          	mov    0x18(%esp),%eax
  4d:	89 44 24 04          	mov    %eax,0x4(%esp)
  51:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  55:	89 04 24             	mov    %eax,(%esp)
  58:	e8 6b 04 00 00       	call   4c8 <dup2>
  5d:	89 44 24 08          	mov    %eax,0x8(%esp)
  61:	c7 44 24 04 a3 09 00 	movl   $0x9a3,0x4(%esp)
  68:	00 
  69:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  70:	e8 3b 05 00 00       	call   5b0 <printf>
	fd2=1000;
  75:	c7 44 24 18 e8 03 00 	movl   $0x3e8,0x18(%esp)
  7c:	00 
	printf(2,"fd2=1000: %d\n",dup2(fd1,fd2));
  7d:	8b 44 24 18          	mov    0x18(%esp),%eax
  81:	89 44 24 04          	mov    %eax,0x4(%esp)
  85:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  89:	89 04 24             	mov    %eax,(%esp)
  8c:	e8 37 04 00 00       	call   4c8 <dup2>
  91:	89 44 24 08          	mov    %eax,0x8(%esp)
  95:	c7 44 24 04 af 09 00 	movl   $0x9af,0x4(%esp)
  9c:	00 
  9d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  a4:	e8 07 05 00 00       	call   5b0 <printf>
	fd2=fd1;
  a9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  ad:	89 44 24 18          	mov    %eax,0x18(%esp)
	printf(2,"fd2=fd1: %d %d\n",fd1,dup2(fd1,fd2));
  b1:	8b 44 24 18          	mov    0x18(%esp),%eax
  b5:	89 44 24 04          	mov    %eax,0x4(%esp)
  b9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  bd:	89 04 24             	mov    %eax,(%esp)
  c0:	e8 03 04 00 00       	call   4c8 <dup2>
  c5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  c9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  cd:	89 44 24 08          	mov    %eax,0x8(%esp)
  d1:	c7 44 24 04 bd 09 00 	movl   $0x9bd,0x4(%esp)
  d8:	00 
  d9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  e0:	e8 cb 04 00 00       	call   5b0 <printf>
	fd2=(fd1+5)%10;
  e5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  e9:	8d 48 05             	lea    0x5(%eax),%ecx
  ec:	ba 67 66 66 66       	mov    $0x66666667,%edx
  f1:	89 c8                	mov    %ecx,%eax
  f3:	f7 ea                	imul   %edx
  f5:	c1 fa 02             	sar    $0x2,%edx
  f8:	89 c8                	mov    %ecx,%eax
  fa:	c1 f8 1f             	sar    $0x1f,%eax
  fd:	29 c2                	sub    %eax,%edx
  ff:	89 d0                	mov    %edx,%eax
 101:	89 44 24 18          	mov    %eax,0x18(%esp)
 105:	8b 54 24 18          	mov    0x18(%esp),%edx
 109:	89 d0                	mov    %edx,%eax
 10b:	c1 e0 02             	shl    $0x2,%eax
 10e:	01 d0                	add    %edx,%eax
 110:	01 c0                	add    %eax,%eax
 112:	29 c1                	sub    %eax,%ecx
 114:	89 c8                	mov    %ecx,%eax
 116:	89 44 24 18          	mov    %eax,0x18(%esp)
	printf(2,"fd2!=fd1: %d\n",dup2(fd1,fd2));
 11a:	8b 44 24 18          	mov    0x18(%esp),%eax
 11e:	89 44 24 04          	mov    %eax,0x4(%esp)
 122:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 126:	89 04 24             	mov    %eax,(%esp)
 129:	e8 9a 03 00 00       	call   4c8 <dup2>
 12e:	89 44 24 08          	mov    %eax,0x8(%esp)
 132:	c7 44 24 04 cd 09 00 	movl   $0x9cd,0x4(%esp)
 139:	00 
 13a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 141:	e8 6a 04 00 00       	call   5b0 <printf>
	fd1=fd1+1;
 146:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
	printf(2,"fd1 no abierto: %d\n",dup2(fd1,fd2));
 14b:	8b 44 24 18          	mov    0x18(%esp),%eax
 14f:	89 44 24 04          	mov    %eax,0x4(%esp)
 153:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 157:	89 04 24             	mov    %eax,(%esp)
 15a:	e8 69 03 00 00       	call   4c8 <dup2>
 15f:	89 44 24 08          	mov    %eax,0x8(%esp)
 163:	c7 44 24 04 db 09 00 	movl   $0x9db,0x4(%esp)
 16a:	00 
 16b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 172:	e8 39 04 00 00       	call   5b0 <printf>
	fd1=-1;
 177:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
 17e:	ff 
	fd2=2;
 17f:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
 186:	00 
	printf(2,"fd1=-1: %d\n",dup2(fd1,fd2));	
 187:	8b 44 24 18          	mov    0x18(%esp),%eax
 18b:	89 44 24 04          	mov    %eax,0x4(%esp)
 18f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 193:	89 04 24             	mov    %eax,(%esp)
 196:	e8 2d 03 00 00       	call   4c8 <dup2>
 19b:	89 44 24 08          	mov    %eax,0x8(%esp)
 19f:	c7 44 24 04 ef 09 00 	movl   $0x9ef,0x4(%esp)
 1a6:	00 
 1a7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1ae:	e8 fd 03 00 00       	call   5b0 <printf>
	exit();
 1b3:	e8 68 02 00 00       	call   420 <exit>

000001b8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	57                   	push   %edi
 1bc:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c0:	8b 55 10             	mov    0x10(%ebp),%edx
 1c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c6:	89 cb                	mov    %ecx,%ebx
 1c8:	89 df                	mov    %ebx,%edi
 1ca:	89 d1                	mov    %edx,%ecx
 1cc:	fc                   	cld    
 1cd:	f3 aa                	rep stos %al,%es:(%edi)
 1cf:	89 ca                	mov    %ecx,%edx
 1d1:	89 fb                	mov    %edi,%ebx
 1d3:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d9:	5b                   	pop    %ebx
 1da:	5f                   	pop    %edi
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    

000001dd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
 1e0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e9:	90                   	nop
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
 1ed:	8d 50 01             	lea    0x1(%eax),%edx
 1f0:	89 55 08             	mov    %edx,0x8(%ebp)
 1f3:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f6:	8d 4a 01             	lea    0x1(%edx),%ecx
 1f9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1fc:	0f b6 12             	movzbl (%edx),%edx
 1ff:	88 10                	mov    %dl,(%eax)
 201:	0f b6 00             	movzbl (%eax),%eax
 204:	84 c0                	test   %al,%al
 206:	75 e2                	jne    1ea <strcpy+0xd>
    ;
  return os;
 208:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20b:	c9                   	leave  
 20c:	c3                   	ret    

0000020d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 210:	eb 08                	jmp    21a <strcmp+0xd>
    p++, q++;
 212:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 216:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	84 c0                	test   %al,%al
 222:	74 10                	je     234 <strcmp+0x27>
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	0f b6 10             	movzbl (%eax),%edx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	0f b6 00             	movzbl (%eax),%eax
 230:	38 c2                	cmp    %al,%dl
 232:	74 de                	je     212 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 00             	movzbl (%eax),%eax
 23a:	0f b6 d0             	movzbl %al,%edx
 23d:	8b 45 0c             	mov    0xc(%ebp),%eax
 240:	0f b6 00             	movzbl (%eax),%eax
 243:	0f b6 c0             	movzbl %al,%eax
 246:	29 c2                	sub    %eax,%edx
 248:	89 d0                	mov    %edx,%eax
}
 24a:	5d                   	pop    %ebp
 24b:	c3                   	ret    

0000024c <strlen>:

uint
strlen(char *s)
{
 24c:	55                   	push   %ebp
 24d:	89 e5                	mov    %esp,%ebp
 24f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 252:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 259:	eb 04                	jmp    25f <strlen+0x13>
 25b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 25f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	01 d0                	add    %edx,%eax
 267:	0f b6 00             	movzbl (%eax),%eax
 26a:	84 c0                	test   %al,%al
 26c:	75 ed                	jne    25b <strlen+0xf>
    ;
  return n;
 26e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 271:	c9                   	leave  
 272:	c3                   	ret    

00000273 <memset>:

void*
memset(void *dst, int c, uint n)
{
 273:	55                   	push   %ebp
 274:	89 e5                	mov    %esp,%ebp
 276:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 279:	8b 45 10             	mov    0x10(%ebp),%eax
 27c:	89 44 24 08          	mov    %eax,0x8(%esp)
 280:	8b 45 0c             	mov    0xc(%ebp),%eax
 283:	89 44 24 04          	mov    %eax,0x4(%esp)
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	89 04 24             	mov    %eax,(%esp)
 28d:	e8 26 ff ff ff       	call   1b8 <stosb>
  return dst;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <strchr>:

char*
strchr(const char *s, char c)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 04             	sub    $0x4,%esp
 29d:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2a3:	eb 14                	jmp    2b9 <strchr+0x22>
    if(*s == c)
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2ae:	75 05                	jne    2b5 <strchr+0x1e>
      return (char*)s;
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	eb 13                	jmp    2c8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 00             	movzbl (%eax),%eax
 2bf:	84 c0                	test   %al,%al
 2c1:	75 e2                	jne    2a5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c8:	c9                   	leave  
 2c9:	c3                   	ret    

000002ca <gets>:

char*
gets(char *buf, int max)
{
 2ca:	55                   	push   %ebp
 2cb:	89 e5                	mov    %esp,%ebp
 2cd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d7:	eb 4c                	jmp    325 <gets+0x5b>
    cc = read(0, &c, 1);
 2d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e0:	00 
 2e1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ef:	e8 44 01 00 00       	call   438 <read>
 2f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2fb:	7f 02                	jg     2ff <gets+0x35>
      break;
 2fd:	eb 31                	jmp    330 <gets+0x66>
    buf[i++] = c;
 2ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 302:	8d 50 01             	lea    0x1(%eax),%edx
 305:	89 55 f4             	mov    %edx,-0xc(%ebp)
 308:	89 c2                	mov    %eax,%edx
 30a:	8b 45 08             	mov    0x8(%ebp),%eax
 30d:	01 c2                	add    %eax,%edx
 30f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 313:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 315:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 319:	3c 0a                	cmp    $0xa,%al
 31b:	74 13                	je     330 <gets+0x66>
 31d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 321:	3c 0d                	cmp    $0xd,%al
 323:	74 0b                	je     330 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 325:	8b 45 f4             	mov    -0xc(%ebp),%eax
 328:	83 c0 01             	add    $0x1,%eax
 32b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 32e:	7c a9                	jl     2d9 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 330:	8b 55 f4             	mov    -0xc(%ebp),%edx
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	01 d0                	add    %edx,%eax
 338:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 33b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 33e:	c9                   	leave  
 33f:	c3                   	ret    

00000340 <stat>:

int
stat(char *n, struct stat *st)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 34d:	00 
 34e:	8b 45 08             	mov    0x8(%ebp),%eax
 351:	89 04 24             	mov    %eax,(%esp)
 354:	e8 07 01 00 00       	call   460 <open>
 359:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 35c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 360:	79 07                	jns    369 <stat+0x29>
    return -1;
 362:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 367:	eb 23                	jmp    38c <stat+0x4c>
  r = fstat(fd, st);
 369:	8b 45 0c             	mov    0xc(%ebp),%eax
 36c:	89 44 24 04          	mov    %eax,0x4(%esp)
 370:	8b 45 f4             	mov    -0xc(%ebp),%eax
 373:	89 04 24             	mov    %eax,(%esp)
 376:	e8 fd 00 00 00       	call   478 <fstat>
 37b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 37e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 381:	89 04 24             	mov    %eax,(%esp)
 384:	e8 bf 00 00 00       	call   448 <close>
  return r;
 389:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 38c:	c9                   	leave  
 38d:	c3                   	ret    

0000038e <atoi>:

int
atoi(const char *s)
{
 38e:	55                   	push   %ebp
 38f:	89 e5                	mov    %esp,%ebp
 391:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 394:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 39b:	eb 25                	jmp    3c2 <atoi+0x34>
    n = n*10 + *s++ - '0';
 39d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a0:	89 d0                	mov    %edx,%eax
 3a2:	c1 e0 02             	shl    $0x2,%eax
 3a5:	01 d0                	add    %edx,%eax
 3a7:	01 c0                	add    %eax,%eax
 3a9:	89 c1                	mov    %eax,%ecx
 3ab:	8b 45 08             	mov    0x8(%ebp),%eax
 3ae:	8d 50 01             	lea    0x1(%eax),%edx
 3b1:	89 55 08             	mov    %edx,0x8(%ebp)
 3b4:	0f b6 00             	movzbl (%eax),%eax
 3b7:	0f be c0             	movsbl %al,%eax
 3ba:	01 c8                	add    %ecx,%eax
 3bc:	83 e8 30             	sub    $0x30,%eax
 3bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c2:	8b 45 08             	mov    0x8(%ebp),%eax
 3c5:	0f b6 00             	movzbl (%eax),%eax
 3c8:	3c 2f                	cmp    $0x2f,%al
 3ca:	7e 0a                	jle    3d6 <atoi+0x48>
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	0f b6 00             	movzbl (%eax),%eax
 3d2:	3c 39                	cmp    $0x39,%al
 3d4:	7e c7                	jle    39d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d9:	c9                   	leave  
 3da:	c3                   	ret    

000003db <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3db:	55                   	push   %ebp
 3dc:	89 e5                	mov    %esp,%ebp
 3de:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 3e1:	8b 45 08             	mov    0x8(%ebp),%eax
 3e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3ed:	eb 17                	jmp    406 <memmove+0x2b>
    *dst++ = *src++;
 3ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3f2:	8d 50 01             	lea    0x1(%eax),%edx
 3f5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3f8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3fb:	8d 4a 01             	lea    0x1(%edx),%ecx
 3fe:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 401:	0f b6 12             	movzbl (%edx),%edx
 404:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 406:	8b 45 10             	mov    0x10(%ebp),%eax
 409:	8d 50 ff             	lea    -0x1(%eax),%edx
 40c:	89 55 10             	mov    %edx,0x10(%ebp)
 40f:	85 c0                	test   %eax,%eax
 411:	7f dc                	jg     3ef <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 413:	8b 45 08             	mov    0x8(%ebp),%eax
}
 416:	c9                   	leave  
 417:	c3                   	ret    

00000418 <fork>:
 418:	b8 01 00 00 00       	mov    $0x1,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <exit>:
 420:	b8 02 00 00 00       	mov    $0x2,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <wait>:
 428:	b8 03 00 00 00       	mov    $0x3,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <pipe>:
 430:	b8 04 00 00 00       	mov    $0x4,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <read>:
 438:	b8 05 00 00 00       	mov    $0x5,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <write>:
 440:	b8 10 00 00 00       	mov    $0x10,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <close>:
 448:	b8 15 00 00 00       	mov    $0x15,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <kill>:
 450:	b8 06 00 00 00       	mov    $0x6,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <exec>:
 458:	b8 07 00 00 00       	mov    $0x7,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <open>:
 460:	b8 0f 00 00 00       	mov    $0xf,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <mknod>:
 468:	b8 11 00 00 00       	mov    $0x11,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <unlink>:
 470:	b8 12 00 00 00       	mov    $0x12,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <fstat>:
 478:	b8 08 00 00 00       	mov    $0x8,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <link>:
 480:	b8 13 00 00 00       	mov    $0x13,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <mkdir>:
 488:	b8 14 00 00 00       	mov    $0x14,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <chdir>:
 490:	b8 09 00 00 00       	mov    $0x9,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <dup>:
 498:	b8 0a 00 00 00       	mov    $0xa,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <getpid>:
 4a0:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <sbrk>:
 4a8:	b8 0c 00 00 00       	mov    $0xc,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <sleep>:
 4b0:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <uptime>:
 4b8:	b8 0e 00 00 00       	mov    $0xe,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <date>:
 4c0:	b8 16 00 00 00       	mov    $0x16,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <dup2>:
 4c8:	b8 17 00 00 00       	mov    $0x17,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	83 ec 18             	sub    $0x18,%esp
 4d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4dc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e3:	00 
 4e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4eb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ee:	89 04 24             	mov    %eax,(%esp)
 4f1:	e8 4a ff ff ff       	call   440 <write>
}
 4f6:	c9                   	leave  
 4f7:	c3                   	ret    

000004f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f8:	55                   	push   %ebp
 4f9:	89 e5                	mov    %esp,%ebp
 4fb:	56                   	push   %esi
 4fc:	53                   	push   %ebx
 4fd:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 500:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 507:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 50b:	74 17                	je     524 <printint+0x2c>
 50d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 511:	79 11                	jns    524 <printint+0x2c>
    neg = 1;
 513:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 51a:	8b 45 0c             	mov    0xc(%ebp),%eax
 51d:	f7 d8                	neg    %eax
 51f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 522:	eb 06                	jmp    52a <printint+0x32>
  } else {
    x = xx;
 524:	8b 45 0c             	mov    0xc(%ebp),%eax
 527:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 52a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 531:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 534:	8d 41 01             	lea    0x1(%ecx),%eax
 537:	89 45 f4             	mov    %eax,-0xc(%ebp)
 53a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 53d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 540:	ba 00 00 00 00       	mov    $0x0,%edx
 545:	f7 f3                	div    %ebx
 547:	89 d0                	mov    %edx,%eax
 549:	0f b6 80 48 0c 00 00 	movzbl 0xc48(%eax),%eax
 550:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 554:	8b 75 10             	mov    0x10(%ebp),%esi
 557:	8b 45 ec             	mov    -0x14(%ebp),%eax
 55a:	ba 00 00 00 00       	mov    $0x0,%edx
 55f:	f7 f6                	div    %esi
 561:	89 45 ec             	mov    %eax,-0x14(%ebp)
 564:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 568:	75 c7                	jne    531 <printint+0x39>
  if(neg)
 56a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 56e:	74 10                	je     580 <printint+0x88>
    buf[i++] = '-';
 570:	8b 45 f4             	mov    -0xc(%ebp),%eax
 573:	8d 50 01             	lea    0x1(%eax),%edx
 576:	89 55 f4             	mov    %edx,-0xc(%ebp)
 579:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 57e:	eb 1f                	jmp    59f <printint+0xa7>
 580:	eb 1d                	jmp    59f <printint+0xa7>
    putc(fd, buf[i]);
 582:	8d 55 dc             	lea    -0x24(%ebp),%edx
 585:	8b 45 f4             	mov    -0xc(%ebp),%eax
 588:	01 d0                	add    %edx,%eax
 58a:	0f b6 00             	movzbl (%eax),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	89 44 24 04          	mov    %eax,0x4(%esp)
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	89 04 24             	mov    %eax,(%esp)
 59a:	e8 31 ff ff ff       	call   4d0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 59f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a7:	79 d9                	jns    582 <printint+0x8a>
    putc(fd, buf[i]);
}
 5a9:	83 c4 30             	add    $0x30,%esp
 5ac:	5b                   	pop    %ebx
 5ad:	5e                   	pop    %esi
 5ae:	5d                   	pop    %ebp
 5af:	c3                   	ret    

000005b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5bd:	8d 45 0c             	lea    0xc(%ebp),%eax
 5c0:	83 c0 04             	add    $0x4,%eax
 5c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5cd:	e9 7c 01 00 00       	jmp    74e <printf+0x19e>
    c = fmt[i] & 0xff;
 5d2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d8:	01 d0                	add    %edx,%eax
 5da:	0f b6 00             	movzbl (%eax),%eax
 5dd:	0f be c0             	movsbl %al,%eax
 5e0:	25 ff 00 00 00       	and    $0xff,%eax
 5e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5ec:	75 2c                	jne    61a <printf+0x6a>
      if(c == '%'){
 5ee:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f2:	75 0c                	jne    600 <printf+0x50>
        state = '%';
 5f4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5fb:	e9 4a 01 00 00       	jmp    74a <printf+0x19a>
      } else {
        putc(fd, c);
 600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 603:	0f be c0             	movsbl %al,%eax
 606:	89 44 24 04          	mov    %eax,0x4(%esp)
 60a:	8b 45 08             	mov    0x8(%ebp),%eax
 60d:	89 04 24             	mov    %eax,(%esp)
 610:	e8 bb fe ff ff       	call   4d0 <putc>
 615:	e9 30 01 00 00       	jmp    74a <printf+0x19a>
      }
    } else if(state == '%'){
 61a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 61e:	0f 85 26 01 00 00    	jne    74a <printf+0x19a>
      if(c == 'd'){
 624:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 628:	75 2d                	jne    657 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 62a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62d:	8b 00                	mov    (%eax),%eax
 62f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 636:	00 
 637:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 63e:	00 
 63f:	89 44 24 04          	mov    %eax,0x4(%esp)
 643:	8b 45 08             	mov    0x8(%ebp),%eax
 646:	89 04 24             	mov    %eax,(%esp)
 649:	e8 aa fe ff ff       	call   4f8 <printint>
        ap++;
 64e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 652:	e9 ec 00 00 00       	jmp    743 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 657:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 65b:	74 06                	je     663 <printf+0xb3>
 65d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 661:	75 2d                	jne    690 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 663:	8b 45 e8             	mov    -0x18(%ebp),%eax
 666:	8b 00                	mov    (%eax),%eax
 668:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 66f:	00 
 670:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 677:	00 
 678:	89 44 24 04          	mov    %eax,0x4(%esp)
 67c:	8b 45 08             	mov    0x8(%ebp),%eax
 67f:	89 04 24             	mov    %eax,(%esp)
 682:	e8 71 fe ff ff       	call   4f8 <printint>
        ap++;
 687:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68b:	e9 b3 00 00 00       	jmp    743 <printf+0x193>
      } else if(c == 's'){
 690:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 694:	75 45                	jne    6db <printf+0x12b>
        s = (char*)*ap;
 696:	8b 45 e8             	mov    -0x18(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 69e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a6:	75 09                	jne    6b1 <printf+0x101>
          s = "(null)";
 6a8:	c7 45 f4 fb 09 00 00 	movl   $0x9fb,-0xc(%ebp)
        while(*s != 0){
 6af:	eb 1e                	jmp    6cf <printf+0x11f>
 6b1:	eb 1c                	jmp    6cf <printf+0x11f>
          putc(fd, *s);
 6b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b6:	0f b6 00             	movzbl (%eax),%eax
 6b9:	0f be c0             	movsbl %al,%eax
 6bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
 6c3:	89 04 24             	mov    %eax,(%esp)
 6c6:	e8 05 fe ff ff       	call   4d0 <putc>
          s++;
 6cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d2:	0f b6 00             	movzbl (%eax),%eax
 6d5:	84 c0                	test   %al,%al
 6d7:	75 da                	jne    6b3 <printf+0x103>
 6d9:	eb 68                	jmp    743 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6db:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6df:	75 1d                	jne    6fe <printf+0x14e>
        putc(fd, *ap);
 6e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e4:	8b 00                	mov    (%eax),%eax
 6e6:	0f be c0             	movsbl %al,%eax
 6e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ed:	8b 45 08             	mov    0x8(%ebp),%eax
 6f0:	89 04 24             	mov    %eax,(%esp)
 6f3:	e8 d8 fd ff ff       	call   4d0 <putc>
        ap++;
 6f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6fc:	eb 45                	jmp    743 <printf+0x193>
      } else if(c == '%'){
 6fe:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 702:	75 17                	jne    71b <printf+0x16b>
        putc(fd, c);
 704:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 707:	0f be c0             	movsbl %al,%eax
 70a:	89 44 24 04          	mov    %eax,0x4(%esp)
 70e:	8b 45 08             	mov    0x8(%ebp),%eax
 711:	89 04 24             	mov    %eax,(%esp)
 714:	e8 b7 fd ff ff       	call   4d0 <putc>
 719:	eb 28                	jmp    743 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 71b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 722:	00 
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 a2 fd ff ff       	call   4d0 <putc>
        putc(fd, c);
 72e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 731:	0f be c0             	movsbl %al,%eax
 734:	89 44 24 04          	mov    %eax,0x4(%esp)
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	89 04 24             	mov    %eax,(%esp)
 73e:	e8 8d fd ff ff       	call   4d0 <putc>
      }
      state = 0;
 743:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 74a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 74e:	8b 55 0c             	mov    0xc(%ebp),%edx
 751:	8b 45 f0             	mov    -0x10(%ebp),%eax
 754:	01 d0                	add    %edx,%eax
 756:	0f b6 00             	movzbl (%eax),%eax
 759:	84 c0                	test   %al,%al
 75b:	0f 85 71 fe ff ff    	jne    5d2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 761:	c9                   	leave  
 762:	c3                   	ret    

00000763 <free>:
 763:	55                   	push   %ebp
 764:	89 e5                	mov    %esp,%ebp
 766:	83 ec 10             	sub    $0x10,%esp
 769:	8b 45 08             	mov    0x8(%ebp),%eax
 76c:	83 e8 08             	sub    $0x8,%eax
 76f:	89 45 f8             	mov    %eax,-0x8(%ebp)
 772:	a1 64 0c 00 00       	mov    0xc64,%eax
 777:	89 45 fc             	mov    %eax,-0x4(%ebp)
 77a:	eb 24                	jmp    7a0 <free+0x3d>
 77c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77f:	8b 00                	mov    (%eax),%eax
 781:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 784:	77 12                	ja     798 <free+0x35>
 786:	8b 45 f8             	mov    -0x8(%ebp),%eax
 789:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 78c:	77 24                	ja     7b2 <free+0x4f>
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	8b 00                	mov    (%eax),%eax
 793:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 796:	77 1a                	ja     7b2 <free+0x4f>
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 00                	mov    (%eax),%eax
 79d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a6:	76 d4                	jbe    77c <free+0x19>
 7a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ab:	8b 00                	mov    (%eax),%eax
 7ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7b0:	76 ca                	jbe    77c <free+0x19>
 7b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b5:	8b 40 04             	mov    0x4(%eax),%eax
 7b8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c2:	01 c2                	add    %eax,%edx
 7c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c7:	8b 00                	mov    (%eax),%eax
 7c9:	39 c2                	cmp    %eax,%edx
 7cb:	75 24                	jne    7f1 <free+0x8e>
 7cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d0:	8b 50 04             	mov    0x4(%eax),%edx
 7d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d6:	8b 00                	mov    (%eax),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	01 c2                	add    %eax,%edx
 7dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e0:	89 50 04             	mov    %edx,0x4(%eax)
 7e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e6:	8b 00                	mov    (%eax),%eax
 7e8:	8b 10                	mov    (%eax),%edx
 7ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ed:	89 10                	mov    %edx,(%eax)
 7ef:	eb 0a                	jmp    7fb <free+0x98>
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	8b 10                	mov    (%eax),%edx
 7f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f9:	89 10                	mov    %edx,(%eax)
 7fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fe:	8b 40 04             	mov    0x4(%eax),%eax
 801:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 808:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80b:	01 d0                	add    %edx,%eax
 80d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 810:	75 20                	jne    832 <free+0xcf>
 812:	8b 45 fc             	mov    -0x4(%ebp),%eax
 815:	8b 50 04             	mov    0x4(%eax),%edx
 818:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81b:	8b 40 04             	mov    0x4(%eax),%eax
 81e:	01 c2                	add    %eax,%edx
 820:	8b 45 fc             	mov    -0x4(%ebp),%eax
 823:	89 50 04             	mov    %edx,0x4(%eax)
 826:	8b 45 f8             	mov    -0x8(%ebp),%eax
 829:	8b 10                	mov    (%eax),%edx
 82b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82e:	89 10                	mov    %edx,(%eax)
 830:	eb 08                	jmp    83a <free+0xd7>
 832:	8b 45 fc             	mov    -0x4(%ebp),%eax
 835:	8b 55 f8             	mov    -0x8(%ebp),%edx
 838:	89 10                	mov    %edx,(%eax)
 83a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83d:	a3 64 0c 00 00       	mov    %eax,0xc64
 842:	90                   	nop
 843:	c9                   	leave  
 844:	c3                   	ret    

00000845 <morecore>:
 845:	55                   	push   %ebp
 846:	89 e5                	mov    %esp,%ebp
 848:	83 ec 18             	sub    $0x18,%esp
 84b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 852:	77 07                	ja     85b <morecore+0x16>
 854:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 85b:	8b 45 08             	mov    0x8(%ebp),%eax
 85e:	c1 e0 03             	shl    $0x3,%eax
 861:	83 ec 0c             	sub    $0xc,%esp
 864:	50                   	push   %eax
 865:	e8 3e fc ff ff       	call   4a8 <sbrk>
 86a:	83 c4 10             	add    $0x10,%esp
 86d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 870:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 874:	75 07                	jne    87d <morecore+0x38>
 876:	b8 00 00 00 00       	mov    $0x0,%eax
 87b:	eb 26                	jmp    8a3 <morecore+0x5e>
 87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 880:	89 45 f0             	mov    %eax,-0x10(%ebp)
 883:	8b 45 f0             	mov    -0x10(%ebp),%eax
 886:	8b 55 08             	mov    0x8(%ebp),%edx
 889:	89 50 04             	mov    %edx,0x4(%eax)
 88c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88f:	83 c0 08             	add    $0x8,%eax
 892:	83 ec 0c             	sub    $0xc,%esp
 895:	50                   	push   %eax
 896:	e8 c8 fe ff ff       	call   763 <free>
 89b:	83 c4 10             	add    $0x10,%esp
 89e:	a1 64 0c 00 00       	mov    0xc64,%eax
 8a3:	c9                   	leave  
 8a4:	c3                   	ret    

000008a5 <malloc>:
 8a5:	55                   	push   %ebp
 8a6:	89 e5                	mov    %esp,%ebp
 8a8:	83 ec 18             	sub    $0x18,%esp
 8ab:	8b 45 08             	mov    0x8(%ebp),%eax
 8ae:	83 c0 07             	add    $0x7,%eax
 8b1:	c1 e8 03             	shr    $0x3,%eax
 8b4:	83 c0 01             	add    $0x1,%eax
 8b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 8ba:	a1 64 0c 00 00       	mov    0xc64,%eax
 8bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8c6:	75 23                	jne    8eb <malloc+0x46>
 8c8:	c7 45 f0 5c 0c 00 00 	movl   $0xc5c,-0x10(%ebp)
 8cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d2:	a3 64 0c 00 00       	mov    %eax,0xc64
 8d7:	a1 64 0c 00 00       	mov    0xc64,%eax
 8dc:	a3 5c 0c 00 00       	mov    %eax,0xc5c
 8e1:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 8e8:	00 00 00 
 8eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ee:	8b 00                	mov    (%eax),%eax
 8f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f6:	8b 40 04             	mov    0x4(%eax),%eax
 8f9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8fc:	72 4d                	jb     94b <malloc+0xa6>
 8fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 901:	8b 40 04             	mov    0x4(%eax),%eax
 904:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 907:	75 0c                	jne    915 <malloc+0x70>
 909:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90c:	8b 10                	mov    (%eax),%edx
 90e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 911:	89 10                	mov    %edx,(%eax)
 913:	eb 26                	jmp    93b <malloc+0x96>
 915:	8b 45 f4             	mov    -0xc(%ebp),%eax
 918:	8b 40 04             	mov    0x4(%eax),%eax
 91b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 91e:	89 c2                	mov    %eax,%edx
 920:	8b 45 f4             	mov    -0xc(%ebp),%eax
 923:	89 50 04             	mov    %edx,0x4(%eax)
 926:	8b 45 f4             	mov    -0xc(%ebp),%eax
 929:	8b 40 04             	mov    0x4(%eax),%eax
 92c:	c1 e0 03             	shl    $0x3,%eax
 92f:	01 45 f4             	add    %eax,-0xc(%ebp)
 932:	8b 45 f4             	mov    -0xc(%ebp),%eax
 935:	8b 55 ec             	mov    -0x14(%ebp),%edx
 938:	89 50 04             	mov    %edx,0x4(%eax)
 93b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93e:	a3 64 0c 00 00       	mov    %eax,0xc64
 943:	8b 45 f4             	mov    -0xc(%ebp),%eax
 946:	83 c0 08             	add    $0x8,%eax
 949:	eb 3b                	jmp    986 <malloc+0xe1>
 94b:	a1 64 0c 00 00       	mov    0xc64,%eax
 950:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 953:	75 1e                	jne    973 <malloc+0xce>
 955:	83 ec 0c             	sub    $0xc,%esp
 958:	ff 75 ec             	pushl  -0x14(%ebp)
 95b:	e8 e5 fe ff ff       	call   845 <morecore>
 960:	83 c4 10             	add    $0x10,%esp
 963:	89 45 f4             	mov    %eax,-0xc(%ebp)
 966:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 96a:	75 07                	jne    973 <malloc+0xce>
 96c:	b8 00 00 00 00       	mov    $0x0,%eax
 971:	eb 13                	jmp    986 <malloc+0xe1>
 973:	8b 45 f4             	mov    -0xc(%ebp),%eax
 976:	89 45 f0             	mov    %eax,-0x10(%ebp)
 979:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97c:	8b 00                	mov    (%eax),%eax
 97e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 981:	e9 6d ff ff ff       	jmp    8f3 <malloc+0x4e>
 986:	c9                   	leave  
 987:	c3                   	ret    
