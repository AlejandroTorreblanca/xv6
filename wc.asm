
_wc:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <wc>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  20:	eb 69                	jmp    8b <wc+0x8b>
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 58                	jmp    83 <wc+0x83>
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 80 0c 00 00       	add    $0xc80,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 80 0c 00 00       	add    $0xc80,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	83 ec 08             	sub    $0x8,%esp
  53:	50                   	push   %eax
  54:	68 8d 09 00 00       	push   $0x98d
  59:	e8 3e 02 00 00       	call   29c <strchr>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	85 c0                	test   %eax,%eax
  63:	74 09                	je     6e <wc+0x6e>
  65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6c:	eb 11                	jmp    7f <wc+0x7f>
  6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  72:	75 0b                	jne    7f <wc+0x7f>
  74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  89:	7c a0                	jl     2b <wc+0x2b>
  8b:	83 ec 04             	sub    $0x4,%esp
  8e:	68 00 02 00 00       	push   $0x200
  93:	68 80 0c 00 00       	push   $0xc80
  98:	ff 75 08             	pushl  0x8(%ebp)
  9b:	e8 9d 03 00 00       	call   43d <read>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
  b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b4:	79 17                	jns    cd <wc+0xcd>
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 93 09 00 00       	push   $0x993
  be:	6a 01                	push   $0x1
  c0:	e8 f0 04 00 00       	call   5b5 <printf>
  c5:	83 c4 10             	add    $0x10,%esp
  c8:	e8 58 03 00 00       	call   425 <exit>
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	ff 75 0c             	pushl  0xc(%ebp)
  d3:	ff 75 e8             	pushl  -0x18(%ebp)
  d6:	ff 75 ec             	pushl  -0x14(%ebp)
  d9:	ff 75 f0             	pushl  -0x10(%ebp)
  dc:	68 a3 09 00 00       	push   $0x9a3
  e1:	6a 01                	push   $0x1
  e3:	e8 cd 04 00 00       	call   5b5 <printf>
  e8:	83 c4 20             	add    $0x20,%esp
  eb:	90                   	nop
  ec:	c9                   	leave  
  ed:	c3                   	ret    

000000ee <main>:
  ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f2:	83 e4 f0             	and    $0xfffffff0,%esp
  f5:	ff 71 fc             	pushl  -0x4(%ecx)
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	51                   	push   %ecx
  fd:	83 ec 10             	sub    $0x10,%esp
 100:	89 cb                	mov    %ecx,%ebx
 102:	83 3b 01             	cmpl   $0x1,(%ebx)
 105:	7f 17                	jg     11e <main+0x30>
 107:	83 ec 08             	sub    $0x8,%esp
 10a:	68 b0 09 00 00       	push   $0x9b0
 10f:	6a 00                	push   $0x0
 111:	e8 ea fe ff ff       	call   0 <wc>
 116:	83 c4 10             	add    $0x10,%esp
 119:	e8 07 03 00 00       	call   425 <exit>
 11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
 12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 134:	8b 43 04             	mov    0x4(%ebx),%eax
 137:	01 d0                	add    %edx,%eax
 139:	8b 00                	mov    (%eax),%eax
 13b:	83 ec 08             	sub    $0x8,%esp
 13e:	6a 00                	push   $0x0
 140:	50                   	push   %eax
 141:	e8 1f 03 00 00       	call   465 <open>
 146:	83 c4 10             	add    $0x10,%esp
 149:	89 45 f0             	mov    %eax,-0x10(%ebp)
 14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 150:	79 29                	jns    17b <main+0x8d>
 152:	8b 45 f4             	mov    -0xc(%ebp),%eax
 155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15c:	8b 43 04             	mov    0x4(%ebx),%eax
 15f:	01 d0                	add    %edx,%eax
 161:	8b 00                	mov    (%eax),%eax
 163:	83 ec 04             	sub    $0x4,%esp
 166:	50                   	push   %eax
 167:	68 b1 09 00 00       	push   $0x9b1
 16c:	6a 01                	push   $0x1
 16e:	e8 42 04 00 00       	call   5b5 <printf>
 173:	83 c4 10             	add    $0x10,%esp
 176:	e8 aa 02 00 00       	call   425 <exit>
 17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 185:	8b 43 04             	mov    0x4(%ebx),%eax
 188:	01 d0                	add    %edx,%eax
 18a:	8b 00                	mov    (%eax),%eax
 18c:	83 ec 08             	sub    $0x8,%esp
 18f:	50                   	push   %eax
 190:	ff 75 f0             	pushl  -0x10(%ebp)
 193:	e8 68 fe ff ff       	call   0 <wc>
 198:	83 c4 10             	add    $0x10,%esp
 19b:	83 ec 0c             	sub    $0xc,%esp
 19e:	ff 75 f0             	pushl  -0x10(%ebp)
 1a1:	e8 a7 02 00 00       	call   44d <close>
 1a6:	83 c4 10             	add    $0x10,%esp
 1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	3b 03                	cmp    (%ebx),%eax
 1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
 1b8:	e8 68 02 00 00       	call   425 <exit>

000001bd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	57                   	push   %edi
 1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c5:	8b 55 10             	mov    0x10(%ebp),%edx
 1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cb:	89 cb                	mov    %ecx,%ebx
 1cd:	89 df                	mov    %ebx,%edi
 1cf:	89 d1                	mov    %edx,%ecx
 1d1:	fc                   	cld    
 1d2:	f3 aa                	rep stos %al,%es:(%edi)
 1d4:	89 ca                	mov    %ecx,%edx
 1d6:	89 fb                	mov    %edi,%ebx
 1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1de:	5b                   	pop    %ebx
 1df:	5f                   	pop    %edi
 1e0:	5d                   	pop    %ebp
 1e1:	c3                   	ret    

000001e2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e2:	55                   	push   %ebp
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1ee:	90                   	nop
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	8d 50 01             	lea    0x1(%eax),%edx
 1f5:	89 55 08             	mov    %edx,0x8(%ebp)
 1f8:	8b 55 0c             	mov    0xc(%ebp),%edx
 1fb:	8d 4a 01             	lea    0x1(%edx),%ecx
 1fe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 201:	0f b6 12             	movzbl (%edx),%edx
 204:	88 10                	mov    %dl,(%eax)
 206:	0f b6 00             	movzbl (%eax),%eax
 209:	84 c0                	test   %al,%al
 20b:	75 e2                	jne    1ef <strcpy+0xd>
    ;
  return os;
 20d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 210:	c9                   	leave  
 211:	c3                   	ret    

00000212 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 212:	55                   	push   %ebp
 213:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 215:	eb 08                	jmp    21f <strcmp+0xd>
    p++, q++;
 217:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
 222:	0f b6 00             	movzbl (%eax),%eax
 225:	84 c0                	test   %al,%al
 227:	74 10                	je     239 <strcmp+0x27>
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	0f b6 10             	movzbl (%eax),%edx
 22f:	8b 45 0c             	mov    0xc(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	38 c2                	cmp    %al,%dl
 237:	74 de                	je     217 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 239:	8b 45 08             	mov    0x8(%ebp),%eax
 23c:	0f b6 00             	movzbl (%eax),%eax
 23f:	0f b6 d0             	movzbl %al,%edx
 242:	8b 45 0c             	mov    0xc(%ebp),%eax
 245:	0f b6 00             	movzbl (%eax),%eax
 248:	0f b6 c0             	movzbl %al,%eax
 24b:	29 c2                	sub    %eax,%edx
 24d:	89 d0                	mov    %edx,%eax
}
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret    

00000251 <strlen>:

uint
strlen(char *s)
{
 251:	55                   	push   %ebp
 252:	89 e5                	mov    %esp,%ebp
 254:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25e:	eb 04                	jmp    264 <strlen+0x13>
 260:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 264:	8b 55 fc             	mov    -0x4(%ebp),%edx
 267:	8b 45 08             	mov    0x8(%ebp),%eax
 26a:	01 d0                	add    %edx,%eax
 26c:	0f b6 00             	movzbl (%eax),%eax
 26f:	84 c0                	test   %al,%al
 271:	75 ed                	jne    260 <strlen+0xf>
    ;
  return n;
 273:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 276:	c9                   	leave  
 277:	c3                   	ret    

00000278 <memset>:

void*
memset(void *dst, int c, uint n)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 27e:	8b 45 10             	mov    0x10(%ebp),%eax
 281:	89 44 24 08          	mov    %eax,0x8(%esp)
 285:	8b 45 0c             	mov    0xc(%ebp),%eax
 288:	89 44 24 04          	mov    %eax,0x4(%esp)
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 04 24             	mov    %eax,(%esp)
 292:	e8 26 ff ff ff       	call   1bd <stosb>
  return dst;
 297:	8b 45 08             	mov    0x8(%ebp),%eax
}
 29a:	c9                   	leave  
 29b:	c3                   	ret    

0000029c <strchr>:

char*
strchr(const char *s, char c)
{
 29c:	55                   	push   %ebp
 29d:	89 e5                	mov    %esp,%ebp
 29f:	83 ec 04             	sub    $0x4,%esp
 2a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a5:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2a8:	eb 14                	jmp    2be <strchr+0x22>
    if(*s == c)
 2aa:	8b 45 08             	mov    0x8(%ebp),%eax
 2ad:	0f b6 00             	movzbl (%eax),%eax
 2b0:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2b3:	75 05                	jne    2ba <strchr+0x1e>
      return (char*)s;
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	eb 13                	jmp    2cd <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2ba:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
 2c1:	0f b6 00             	movzbl (%eax),%eax
 2c4:	84 c0                	test   %al,%al
 2c6:	75 e2                	jne    2aa <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2cd:	c9                   	leave  
 2ce:	c3                   	ret    

000002cf <gets>:

char*
gets(char *buf, int max)
{
 2cf:	55                   	push   %ebp
 2d0:	89 e5                	mov    %esp,%ebp
 2d2:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2dc:	eb 4c                	jmp    32a <gets+0x5b>
    cc = read(0, &c, 1);
 2de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e5:	00 
 2e6:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2f4:	e8 44 01 00 00       	call   43d <read>
 2f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 300:	7f 02                	jg     304 <gets+0x35>
      break;
 302:	eb 31                	jmp    335 <gets+0x66>
    buf[i++] = c;
 304:	8b 45 f4             	mov    -0xc(%ebp),%eax
 307:	8d 50 01             	lea    0x1(%eax),%edx
 30a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 30d:	89 c2                	mov    %eax,%edx
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	01 c2                	add    %eax,%edx
 314:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 318:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 31a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31e:	3c 0a                	cmp    $0xa,%al
 320:	74 13                	je     335 <gets+0x66>
 322:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 326:	3c 0d                	cmp    $0xd,%al
 328:	74 0b                	je     335 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 32a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 32d:	83 c0 01             	add    $0x1,%eax
 330:	3b 45 0c             	cmp    0xc(%ebp),%eax
 333:	7c a9                	jl     2de <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 335:	8b 55 f4             	mov    -0xc(%ebp),%edx
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	01 d0                	add    %edx,%eax
 33d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 340:	8b 45 08             	mov    0x8(%ebp),%eax
}
 343:	c9                   	leave  
 344:	c3                   	ret    

00000345 <stat>:

int
stat(char *n, struct stat *st)
{
 345:	55                   	push   %ebp
 346:	89 e5                	mov    %esp,%ebp
 348:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 34b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 352:	00 
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	89 04 24             	mov    %eax,(%esp)
 359:	e8 07 01 00 00       	call   465 <open>
 35e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 361:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 365:	79 07                	jns    36e <stat+0x29>
    return -1;
 367:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 36c:	eb 23                	jmp    391 <stat+0x4c>
  r = fstat(fd, st);
 36e:	8b 45 0c             	mov    0xc(%ebp),%eax
 371:	89 44 24 04          	mov    %eax,0x4(%esp)
 375:	8b 45 f4             	mov    -0xc(%ebp),%eax
 378:	89 04 24             	mov    %eax,(%esp)
 37b:	e8 fd 00 00 00       	call   47d <fstat>
 380:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 383:	8b 45 f4             	mov    -0xc(%ebp),%eax
 386:	89 04 24             	mov    %eax,(%esp)
 389:	e8 bf 00 00 00       	call   44d <close>
  return r;
 38e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 391:	c9                   	leave  
 392:	c3                   	ret    

00000393 <atoi>:

int
atoi(const char *s)
{
 393:	55                   	push   %ebp
 394:	89 e5                	mov    %esp,%ebp
 396:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 399:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3a0:	eb 25                	jmp    3c7 <atoi+0x34>
    n = n*10 + *s++ - '0';
 3a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a5:	89 d0                	mov    %edx,%eax
 3a7:	c1 e0 02             	shl    $0x2,%eax
 3aa:	01 d0                	add    %edx,%eax
 3ac:	01 c0                	add    %eax,%eax
 3ae:	89 c1                	mov    %eax,%ecx
 3b0:	8b 45 08             	mov    0x8(%ebp),%eax
 3b3:	8d 50 01             	lea    0x1(%eax),%edx
 3b6:	89 55 08             	mov    %edx,0x8(%ebp)
 3b9:	0f b6 00             	movzbl (%eax),%eax
 3bc:	0f be c0             	movsbl %al,%eax
 3bf:	01 c8                	add    %ecx,%eax
 3c1:	83 e8 30             	sub    $0x30,%eax
 3c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	3c 2f                	cmp    $0x2f,%al
 3cf:	7e 0a                	jle    3db <atoi+0x48>
 3d1:	8b 45 08             	mov    0x8(%ebp),%eax
 3d4:	0f b6 00             	movzbl (%eax),%eax
 3d7:	3c 39                	cmp    $0x39,%al
 3d9:	7e c7                	jle    3a2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3db:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3de:	c9                   	leave  
 3df:	c3                   	ret    

000003e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 3e6:	8b 45 08             	mov    0x8(%ebp),%eax
 3e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3f2:	eb 17                	jmp    40b <memmove+0x2b>
    *dst++ = *src++;
 3f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3f7:	8d 50 01             	lea    0x1(%eax),%edx
 3fa:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3fd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 400:	8d 4a 01             	lea    0x1(%edx),%ecx
 403:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 406:	0f b6 12             	movzbl (%edx),%edx
 409:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40b:	8b 45 10             	mov    0x10(%ebp),%eax
 40e:	8d 50 ff             	lea    -0x1(%eax),%edx
 411:	89 55 10             	mov    %edx,0x10(%ebp)
 414:	85 c0                	test   %eax,%eax
 416:	7f dc                	jg     3f4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 418:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41b:	c9                   	leave  
 41c:	c3                   	ret    

0000041d <fork>:
 41d:	b8 01 00 00 00       	mov    $0x1,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <exit>:
 425:	b8 02 00 00 00       	mov    $0x2,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <wait>:
 42d:	b8 03 00 00 00       	mov    $0x3,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <pipe>:
 435:	b8 04 00 00 00       	mov    $0x4,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <read>:
 43d:	b8 05 00 00 00       	mov    $0x5,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <write>:
 445:	b8 10 00 00 00       	mov    $0x10,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <close>:
 44d:	b8 15 00 00 00       	mov    $0x15,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <kill>:
 455:	b8 06 00 00 00       	mov    $0x6,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <exec>:
 45d:	b8 07 00 00 00       	mov    $0x7,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <open>:
 465:	b8 0f 00 00 00       	mov    $0xf,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <mknod>:
 46d:	b8 11 00 00 00       	mov    $0x11,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <unlink>:
 475:	b8 12 00 00 00       	mov    $0x12,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <fstat>:
 47d:	b8 08 00 00 00       	mov    $0x8,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <link>:
 485:	b8 13 00 00 00       	mov    $0x13,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <mkdir>:
 48d:	b8 14 00 00 00       	mov    $0x14,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <chdir>:
 495:	b8 09 00 00 00       	mov    $0x9,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <dup>:
 49d:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret    

000004a5 <getpid>:
 4a5:	b8 0b 00 00 00       	mov    $0xb,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <sbrk>:
 4ad:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <sleep>:
 4b5:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <uptime>:
 4bd:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret    

000004c5 <date>:
 4c5:	b8 16 00 00 00       	mov    $0x16,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret    

000004cd <dup2>:
 4cd:	b8 17 00 00 00       	mov    $0x17,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret    

000004d5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d5:	55                   	push   %ebp
 4d6:	89 e5                	mov    %esp,%ebp
 4d8:	83 ec 18             	sub    $0x18,%esp
 4db:	8b 45 0c             	mov    0xc(%ebp),%eax
 4de:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e8:	00 
 4e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f0:	8b 45 08             	mov    0x8(%ebp),%eax
 4f3:	89 04 24             	mov    %eax,(%esp)
 4f6:	e8 4a ff ff ff       	call   445 <write>
}
 4fb:	c9                   	leave  
 4fc:	c3                   	ret    

000004fd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fd:	55                   	push   %ebp
 4fe:	89 e5                	mov    %esp,%ebp
 500:	56                   	push   %esi
 501:	53                   	push   %ebx
 502:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 505:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 50c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 510:	74 17                	je     529 <printint+0x2c>
 512:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 516:	79 11                	jns    529 <printint+0x2c>
    neg = 1;
 518:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 51f:	8b 45 0c             	mov    0xc(%ebp),%eax
 522:	f7 d8                	neg    %eax
 524:	89 45 ec             	mov    %eax,-0x14(%ebp)
 527:	eb 06                	jmp    52f <printint+0x32>
  } else {
    x = xx;
 529:	8b 45 0c             	mov    0xc(%ebp),%eax
 52c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 52f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 536:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 539:	8d 41 01             	lea    0x1(%ecx),%eax
 53c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 53f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 542:	8b 45 ec             	mov    -0x14(%ebp),%eax
 545:	ba 00 00 00 00       	mov    $0x0,%edx
 54a:	f7 f3                	div    %ebx
 54c:	89 d0                	mov    %edx,%eax
 54e:	0f b6 80 3c 0c 00 00 	movzbl 0xc3c(%eax),%eax
 555:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 559:	8b 75 10             	mov    0x10(%ebp),%esi
 55c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 55f:	ba 00 00 00 00       	mov    $0x0,%edx
 564:	f7 f6                	div    %esi
 566:	89 45 ec             	mov    %eax,-0x14(%ebp)
 569:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 56d:	75 c7                	jne    536 <printint+0x39>
  if(neg)
 56f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 573:	74 10                	je     585 <printint+0x88>
    buf[i++] = '-';
 575:	8b 45 f4             	mov    -0xc(%ebp),%eax
 578:	8d 50 01             	lea    0x1(%eax),%edx
 57b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 57e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 583:	eb 1f                	jmp    5a4 <printint+0xa7>
 585:	eb 1d                	jmp    5a4 <printint+0xa7>
    putc(fd, buf[i]);
 587:	8d 55 dc             	lea    -0x24(%ebp),%edx
 58a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58d:	01 d0                	add    %edx,%eax
 58f:	0f b6 00             	movzbl (%eax),%eax
 592:	0f be c0             	movsbl %al,%eax
 595:	89 44 24 04          	mov    %eax,0x4(%esp)
 599:	8b 45 08             	mov    0x8(%ebp),%eax
 59c:	89 04 24             	mov    %eax,(%esp)
 59f:	e8 31 ff ff ff       	call   4d5 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5a4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ac:	79 d9                	jns    587 <printint+0x8a>
    putc(fd, buf[i]);
}
 5ae:	83 c4 30             	add    $0x30,%esp
 5b1:	5b                   	pop    %ebx
 5b2:	5e                   	pop    %esi
 5b3:	5d                   	pop    %ebp
 5b4:	c3                   	ret    

000005b5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5b5:	55                   	push   %ebp
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5c2:	8d 45 0c             	lea    0xc(%ebp),%eax
 5c5:	83 c0 04             	add    $0x4,%eax
 5c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5d2:	e9 7c 01 00 00       	jmp    753 <printf+0x19e>
    c = fmt[i] & 0xff;
 5d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5dd:	01 d0                	add    %edx,%eax
 5df:	0f b6 00             	movzbl (%eax),%eax
 5e2:	0f be c0             	movsbl %al,%eax
 5e5:	25 ff 00 00 00       	and    $0xff,%eax
 5ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5f1:	75 2c                	jne    61f <printf+0x6a>
      if(c == '%'){
 5f3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f7:	75 0c                	jne    605 <printf+0x50>
        state = '%';
 5f9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 600:	e9 4a 01 00 00       	jmp    74f <printf+0x19a>
      } else {
        putc(fd, c);
 605:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 608:	0f be c0             	movsbl %al,%eax
 60b:	89 44 24 04          	mov    %eax,0x4(%esp)
 60f:	8b 45 08             	mov    0x8(%ebp),%eax
 612:	89 04 24             	mov    %eax,(%esp)
 615:	e8 bb fe ff ff       	call   4d5 <putc>
 61a:	e9 30 01 00 00       	jmp    74f <printf+0x19a>
      }
    } else if(state == '%'){
 61f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 623:	0f 85 26 01 00 00    	jne    74f <printf+0x19a>
      if(c == 'd'){
 629:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 62d:	75 2d                	jne    65c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 62f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 632:	8b 00                	mov    (%eax),%eax
 634:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 63b:	00 
 63c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 643:	00 
 644:	89 44 24 04          	mov    %eax,0x4(%esp)
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	89 04 24             	mov    %eax,(%esp)
 64e:	e8 aa fe ff ff       	call   4fd <printint>
        ap++;
 653:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 657:	e9 ec 00 00 00       	jmp    748 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 65c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 660:	74 06                	je     668 <printf+0xb3>
 662:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 666:	75 2d                	jne    695 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 668:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 674:	00 
 675:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 67c:	00 
 67d:	89 44 24 04          	mov    %eax,0x4(%esp)
 681:	8b 45 08             	mov    0x8(%ebp),%eax
 684:	89 04 24             	mov    %eax,(%esp)
 687:	e8 71 fe ff ff       	call   4fd <printint>
        ap++;
 68c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 690:	e9 b3 00 00 00       	jmp    748 <printf+0x193>
      } else if(c == 's'){
 695:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 699:	75 45                	jne    6e0 <printf+0x12b>
        s = (char*)*ap;
 69b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6ab:	75 09                	jne    6b6 <printf+0x101>
          s = "(null)";
 6ad:	c7 45 f4 c5 09 00 00 	movl   $0x9c5,-0xc(%ebp)
        while(*s != 0){
 6b4:	eb 1e                	jmp    6d4 <printf+0x11f>
 6b6:	eb 1c                	jmp    6d4 <printf+0x11f>
          putc(fd, *s);
 6b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6bb:	0f b6 00             	movzbl (%eax),%eax
 6be:	0f be c0             	movsbl %al,%eax
 6c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c5:	8b 45 08             	mov    0x8(%ebp),%eax
 6c8:	89 04 24             	mov    %eax,(%esp)
 6cb:	e8 05 fe ff ff       	call   4d5 <putc>
          s++;
 6d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d7:	0f b6 00             	movzbl (%eax),%eax
 6da:	84 c0                	test   %al,%al
 6dc:	75 da                	jne    6b8 <printf+0x103>
 6de:	eb 68                	jmp    748 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6e4:	75 1d                	jne    703 <printf+0x14e>
        putc(fd, *ap);
 6e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e9:	8b 00                	mov    (%eax),%eax
 6eb:	0f be c0             	movsbl %al,%eax
 6ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f2:	8b 45 08             	mov    0x8(%ebp),%eax
 6f5:	89 04 24             	mov    %eax,(%esp)
 6f8:	e8 d8 fd ff ff       	call   4d5 <putc>
        ap++;
 6fd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 701:	eb 45                	jmp    748 <printf+0x193>
      } else if(c == '%'){
 703:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 707:	75 17                	jne    720 <printf+0x16b>
        putc(fd, c);
 709:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 70c:	0f be c0             	movsbl %al,%eax
 70f:	89 44 24 04          	mov    %eax,0x4(%esp)
 713:	8b 45 08             	mov    0x8(%ebp),%eax
 716:	89 04 24             	mov    %eax,(%esp)
 719:	e8 b7 fd ff ff       	call   4d5 <putc>
 71e:	eb 28                	jmp    748 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 720:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 727:	00 
 728:	8b 45 08             	mov    0x8(%ebp),%eax
 72b:	89 04 24             	mov    %eax,(%esp)
 72e:	e8 a2 fd ff ff       	call   4d5 <putc>
        putc(fd, c);
 733:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 736:	0f be c0             	movsbl %al,%eax
 739:	89 44 24 04          	mov    %eax,0x4(%esp)
 73d:	8b 45 08             	mov    0x8(%ebp),%eax
 740:	89 04 24             	mov    %eax,(%esp)
 743:	e8 8d fd ff ff       	call   4d5 <putc>
      }
      state = 0;
 748:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 74f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 753:	8b 55 0c             	mov    0xc(%ebp),%edx
 756:	8b 45 f0             	mov    -0x10(%ebp),%eax
 759:	01 d0                	add    %edx,%eax
 75b:	0f b6 00             	movzbl (%eax),%eax
 75e:	84 c0                	test   %al,%al
 760:	0f 85 71 fe ff ff    	jne    5d7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 766:	c9                   	leave  
 767:	c3                   	ret    

00000768 <free>:
 768:	55                   	push   %ebp
 769:	89 e5                	mov    %esp,%ebp
 76b:	83 ec 10             	sub    $0x10,%esp
 76e:	8b 45 08             	mov    0x8(%ebp),%eax
 771:	83 e8 08             	sub    $0x8,%eax
 774:	89 45 f8             	mov    %eax,-0x8(%ebp)
 777:	a1 68 0c 00 00       	mov    0xc68,%eax
 77c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 77f:	eb 24                	jmp    7a5 <free+0x3d>
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	8b 00                	mov    (%eax),%eax
 786:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 789:	77 12                	ja     79d <free+0x35>
 78b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 791:	77 24                	ja     7b7 <free+0x4f>
 793:	8b 45 fc             	mov    -0x4(%ebp),%eax
 796:	8b 00                	mov    (%eax),%eax
 798:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 79b:	77 1a                	ja     7b7 <free+0x4f>
 79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a0:	8b 00                	mov    (%eax),%eax
 7a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ab:	76 d4                	jbe    781 <free+0x19>
 7ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b0:	8b 00                	mov    (%eax),%eax
 7b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7b5:	76 ca                	jbe    781 <free+0x19>
 7b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ba:	8b 40 04             	mov    0x4(%eax),%eax
 7bd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c7:	01 c2                	add    %eax,%edx
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	8b 00                	mov    (%eax),%eax
 7ce:	39 c2                	cmp    %eax,%edx
 7d0:	75 24                	jne    7f6 <free+0x8e>
 7d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d5:	8b 50 04             	mov    0x4(%eax),%edx
 7d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7db:	8b 00                	mov    (%eax),%eax
 7dd:	8b 40 04             	mov    0x4(%eax),%eax
 7e0:	01 c2                	add    %eax,%edx
 7e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e5:	89 50 04             	mov    %edx,0x4(%eax)
 7e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7eb:	8b 00                	mov    (%eax),%eax
 7ed:	8b 10                	mov    (%eax),%edx
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	89 10                	mov    %edx,(%eax)
 7f4:	eb 0a                	jmp    800 <free+0x98>
 7f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f9:	8b 10                	mov    (%eax),%edx
 7fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fe:	89 10                	mov    %edx,(%eax)
 800:	8b 45 fc             	mov    -0x4(%ebp),%eax
 803:	8b 40 04             	mov    0x4(%eax),%eax
 806:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 810:	01 d0                	add    %edx,%eax
 812:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 815:	75 20                	jne    837 <free+0xcf>
 817:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81a:	8b 50 04             	mov    0x4(%eax),%edx
 81d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	01 c2                	add    %eax,%edx
 825:	8b 45 fc             	mov    -0x4(%ebp),%eax
 828:	89 50 04             	mov    %edx,0x4(%eax)
 82b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82e:	8b 10                	mov    (%eax),%edx
 830:	8b 45 fc             	mov    -0x4(%ebp),%eax
 833:	89 10                	mov    %edx,(%eax)
 835:	eb 08                	jmp    83f <free+0xd7>
 837:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 83d:	89 10                	mov    %edx,(%eax)
 83f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 842:	a3 68 0c 00 00       	mov    %eax,0xc68
 847:	90                   	nop
 848:	c9                   	leave  
 849:	c3                   	ret    

0000084a <morecore>:
 84a:	55                   	push   %ebp
 84b:	89 e5                	mov    %esp,%ebp
 84d:	83 ec 18             	sub    $0x18,%esp
 850:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 857:	77 07                	ja     860 <morecore+0x16>
 859:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 860:	8b 45 08             	mov    0x8(%ebp),%eax
 863:	c1 e0 03             	shl    $0x3,%eax
 866:	83 ec 0c             	sub    $0xc,%esp
 869:	50                   	push   %eax
 86a:	e8 3e fc ff ff       	call   4ad <sbrk>
 86f:	83 c4 10             	add    $0x10,%esp
 872:	89 45 f4             	mov    %eax,-0xc(%ebp)
 875:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 879:	75 07                	jne    882 <morecore+0x38>
 87b:	b8 00 00 00 00       	mov    $0x0,%eax
 880:	eb 26                	jmp    8a8 <morecore+0x5e>
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	89 45 f0             	mov    %eax,-0x10(%ebp)
 888:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88b:	8b 55 08             	mov    0x8(%ebp),%edx
 88e:	89 50 04             	mov    %edx,0x4(%eax)
 891:	8b 45 f0             	mov    -0x10(%ebp),%eax
 894:	83 c0 08             	add    $0x8,%eax
 897:	83 ec 0c             	sub    $0xc,%esp
 89a:	50                   	push   %eax
 89b:	e8 c8 fe ff ff       	call   768 <free>
 8a0:	83 c4 10             	add    $0x10,%esp
 8a3:	a1 68 0c 00 00       	mov    0xc68,%eax
 8a8:	c9                   	leave  
 8a9:	c3                   	ret    

000008aa <malloc>:
 8aa:	55                   	push   %ebp
 8ab:	89 e5                	mov    %esp,%ebp
 8ad:	83 ec 18             	sub    $0x18,%esp
 8b0:	8b 45 08             	mov    0x8(%ebp),%eax
 8b3:	83 c0 07             	add    $0x7,%eax
 8b6:	c1 e8 03             	shr    $0x3,%eax
 8b9:	83 c0 01             	add    $0x1,%eax
 8bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 8bf:	a1 68 0c 00 00       	mov    0xc68,%eax
 8c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8cb:	75 23                	jne    8f0 <malloc+0x46>
 8cd:	c7 45 f0 60 0c 00 00 	movl   $0xc60,-0x10(%ebp)
 8d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d7:	a3 68 0c 00 00       	mov    %eax,0xc68
 8dc:	a1 68 0c 00 00       	mov    0xc68,%eax
 8e1:	a3 60 0c 00 00       	mov    %eax,0xc60
 8e6:	c7 05 64 0c 00 00 00 	movl   $0x0,0xc64
 8ed:	00 00 00 
 8f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f3:	8b 00                	mov    (%eax),%eax
 8f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fb:	8b 40 04             	mov    0x4(%eax),%eax
 8fe:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 901:	72 4d                	jb     950 <malloc+0xa6>
 903:	8b 45 f4             	mov    -0xc(%ebp),%eax
 906:	8b 40 04             	mov    0x4(%eax),%eax
 909:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 90c:	75 0c                	jne    91a <malloc+0x70>
 90e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 911:	8b 10                	mov    (%eax),%edx
 913:	8b 45 f0             	mov    -0x10(%ebp),%eax
 916:	89 10                	mov    %edx,(%eax)
 918:	eb 26                	jmp    940 <malloc+0x96>
 91a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91d:	8b 40 04             	mov    0x4(%eax),%eax
 920:	2b 45 ec             	sub    -0x14(%ebp),%eax
 923:	89 c2                	mov    %eax,%edx
 925:	8b 45 f4             	mov    -0xc(%ebp),%eax
 928:	89 50 04             	mov    %edx,0x4(%eax)
 92b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92e:	8b 40 04             	mov    0x4(%eax),%eax
 931:	c1 e0 03             	shl    $0x3,%eax
 934:	01 45 f4             	add    %eax,-0xc(%ebp)
 937:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 93d:	89 50 04             	mov    %edx,0x4(%eax)
 940:	8b 45 f0             	mov    -0x10(%ebp),%eax
 943:	a3 68 0c 00 00       	mov    %eax,0xc68
 948:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94b:	83 c0 08             	add    $0x8,%eax
 94e:	eb 3b                	jmp    98b <malloc+0xe1>
 950:	a1 68 0c 00 00       	mov    0xc68,%eax
 955:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 958:	75 1e                	jne    978 <malloc+0xce>
 95a:	83 ec 0c             	sub    $0xc,%esp
 95d:	ff 75 ec             	pushl  -0x14(%ebp)
 960:	e8 e5 fe ff ff       	call   84a <morecore>
 965:	83 c4 10             	add    $0x10,%esp
 968:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 96f:	75 07                	jne    978 <malloc+0xce>
 971:	b8 00 00 00 00       	mov    $0x0,%eax
 976:	eb 13                	jmp    98b <malloc+0xe1>
 978:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 97e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 981:	8b 00                	mov    (%eax),%eax
 983:	89 45 f4             	mov    %eax,-0xc(%ebp)
 986:	e9 6d ff ff ff       	jmp    8f8 <malloc+0x4e>
 98b:	c9                   	leave  
 98c:	c3                   	ret    
