
_cat:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   6:	eb 31                	jmp    39 <cat+0x39>
    if (write(1, buf, n) != n) {
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 a0 0b 00 00       	push   $0xba0
  13:	6a 01                	push   $0x1
  15:	e8 88 03 00 00       	call   3a2 <write>
  1a:	83 c4 10             	add    $0x10,%esp
  1d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  20:	74 17                	je     39 <cat+0x39>
      printf(1, "cat: write error\n");
  22:	83 ec 08             	sub    $0x8,%esp
  25:	68 b7 08 00 00       	push   $0x8b7
  2a:	6a 01                	push   $0x1
  2c:	e8 d0 04 00 00       	call   501 <printf>
  31:	83 c4 10             	add    $0x10,%esp
      exit();
  34:	e8 49 03 00 00       	call   382 <exit>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  39:	83 ec 04             	sub    $0x4,%esp
  3c:	68 00 02 00 00       	push   $0x200
  41:	68 a0 0b 00 00       	push   $0xba0
  46:	ff 75 08             	pushl  0x8(%ebp)
  49:	e8 4c 03 00 00       	call   39a <read>
  4e:	83 c4 10             	add    $0x10,%esp
  51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  58:	7f ae                	jg     8 <cat+0x8>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  if(n < 0){
  5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  5e:	79 17                	jns    77 <cat+0x77>
    printf(1, "cat: read error\n");
  60:	83 ec 08             	sub    $0x8,%esp
  63:	68 c9 08 00 00       	push   $0x8c9
  68:	6a 01                	push   $0x1
  6a:	e8 92 04 00 00       	call   501 <printf>
  6f:	83 c4 10             	add    $0x10,%esp
    exit();
  72:	e8 0b 03 00 00       	call   382 <exit>
  }
}
  77:	90                   	nop
  78:	c9                   	leave  
  79:	c3                   	ret    

0000007a <main>:

int
main(int argc, char *argv[])
{
  7a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  7e:	83 e4 f0             	and    $0xfffffff0,%esp
  81:	ff 71 fc             	pushl  -0x4(%ecx)
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	51                   	push   %ecx
  89:	83 ec 10             	sub    $0x10,%esp
  8c:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  8e:	83 3b 01             	cmpl   $0x1,(%ebx)
  91:	7f 12                	jg     a5 <main+0x2b>
    cat(0);
  93:	83 ec 0c             	sub    $0xc,%esp
  96:	6a 00                	push   $0x0
  98:	e8 63 ff ff ff       	call   0 <cat>
  9d:	83 c4 10             	add    $0x10,%esp
    exit();
  a0:	e8 dd 02 00 00       	call   382 <exit>
  }

  for(i = 1; i < argc; i++){
  a5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  ac:	eb 71                	jmp    11f <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
  ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  b8:	8b 43 04             	mov    0x4(%ebx),%eax
  bb:	01 d0                	add    %edx,%eax
  bd:	8b 00                	mov    (%eax),%eax
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	6a 00                	push   $0x0
  c4:	50                   	push   %eax
  c5:	e8 f8 02 00 00       	call   3c2 <open>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  d4:	79 29                	jns    ff <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  e0:	8b 43 04             	mov    0x4(%ebx),%eax
  e3:	01 d0                	add    %edx,%eax
  e5:	8b 00                	mov    (%eax),%eax
  e7:	83 ec 04             	sub    $0x4,%esp
  ea:	50                   	push   %eax
  eb:	68 da 08 00 00       	push   $0x8da
  f0:	6a 01                	push   $0x1
  f2:	e8 0a 04 00 00       	call   501 <printf>
  f7:	83 c4 10             	add    $0x10,%esp
      exit();
  fa:	e8 83 02 00 00       	call   382 <exit>
    }
    cat(fd);
  ff:	83 ec 0c             	sub    $0xc,%esp
 102:	ff 75 f0             	pushl  -0x10(%ebp)
 105:	e8 f6 fe ff ff       	call   0 <cat>
 10a:	83 c4 10             	add    $0x10,%esp
    close(fd);
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	ff 75 f0             	pushl  -0x10(%ebp)
 113:	e8 92 02 00 00       	call   3aa <close>
 118:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
 11b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 11f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 122:	3b 03                	cmp    (%ebx),%eax
 124:	7c 88                	jl     ae <main+0x34>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 126:	e8 57 02 00 00       	call   382 <exit>

0000012b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 12b:	55                   	push   %ebp
 12c:	89 e5                	mov    %esp,%ebp
 12e:	57                   	push   %edi
 12f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 130:	8b 4d 08             	mov    0x8(%ebp),%ecx
 133:	8b 55 10             	mov    0x10(%ebp),%edx
 136:	8b 45 0c             	mov    0xc(%ebp),%eax
 139:	89 cb                	mov    %ecx,%ebx
 13b:	89 df                	mov    %ebx,%edi
 13d:	89 d1                	mov    %edx,%ecx
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
 142:	89 ca                	mov    %ecx,%edx
 144:	89 fb                	mov    %edi,%ebx
 146:	89 5d 08             	mov    %ebx,0x8(%ebp)
 149:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 14c:	90                   	nop
 14d:	5b                   	pop    %ebx
 14e:	5f                   	pop    %edi
 14f:	5d                   	pop    %ebp
 150:	c3                   	ret    

00000151 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 15d:	90                   	nop
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	8d 50 01             	lea    0x1(%eax),%edx
 164:	89 55 08             	mov    %edx,0x8(%ebp)
 167:	8b 55 0c             	mov    0xc(%ebp),%edx
 16a:	8d 4a 01             	lea    0x1(%edx),%ecx
 16d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 170:	0f b6 12             	movzbl (%edx),%edx
 173:	88 10                	mov    %dl,(%eax)
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	75 e2                	jne    15e <strcpy+0xd>
    ;
  return os;
 17c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 17f:	c9                   	leave  
 180:	c3                   	ret    

00000181 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 184:	eb 08                	jmp    18e <strcmp+0xd>
    p++, q++;
 186:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 18a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	0f b6 00             	movzbl (%eax),%eax
 194:	84 c0                	test   %al,%al
 196:	74 10                	je     1a8 <strcmp+0x27>
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	0f b6 10             	movzbl (%eax),%edx
 19e:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a1:	0f b6 00             	movzbl (%eax),%eax
 1a4:	38 c2                	cmp    %al,%dl
 1a6:	74 de                	je     186 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
 1ab:	0f b6 00             	movzbl (%eax),%eax
 1ae:	0f b6 d0             	movzbl %al,%edx
 1b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b4:	0f b6 00             	movzbl (%eax),%eax
 1b7:	0f b6 c0             	movzbl %al,%eax
 1ba:	29 c2                	sub    %eax,%edx
 1bc:	89 d0                	mov    %edx,%eax
}
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <strlen>:

uint
strlen(char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1cd:	eb 04                	jmp    1d3 <strlen+0x13>
 1cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
 1d9:	01 d0                	add    %edx,%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	84 c0                	test   %al,%al
 1e0:	75 ed                	jne    1cf <strlen+0xf>
    ;
  return n;
 1e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1e5:	c9                   	leave  
 1e6:	c3                   	ret    

000001e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1ea:	8b 45 10             	mov    0x10(%ebp),%eax
 1ed:	50                   	push   %eax
 1ee:	ff 75 0c             	pushl  0xc(%ebp)
 1f1:	ff 75 08             	pushl  0x8(%ebp)
 1f4:	e8 32 ff ff ff       	call   12b <stosb>
 1f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <strchr>:

char*
strchr(const char *s, char c)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 04             	sub    $0x4,%esp
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20d:	eb 14                	jmp    223 <strchr+0x22>
    if(*s == c)
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	3a 45 fc             	cmp    -0x4(%ebp),%al
 218:	75 05                	jne    21f <strchr+0x1e>
      return (char*)s;
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	eb 13                	jmp    232 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 21f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	84 c0                	test   %al,%al
 22b:	75 e2                	jne    20f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 22d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 232:	c9                   	leave  
 233:	c3                   	ret    

00000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 241:	eb 42                	jmp    285 <gets+0x51>
    cc = read(0, &c, 1);
 243:	83 ec 04             	sub    $0x4,%esp
 246:	6a 01                	push   $0x1
 248:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24b:	50                   	push   %eax
 24c:	6a 00                	push   $0x0
 24e:	e8 47 01 00 00       	call   39a <read>
 253:	83 c4 10             	add    $0x10,%esp
 256:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 259:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 25d:	7e 33                	jle    292 <gets+0x5e>
      break;
    buf[i++] = c;
 25f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 262:	8d 50 01             	lea    0x1(%eax),%edx
 265:	89 55 f4             	mov    %edx,-0xc(%ebp)
 268:	89 c2                	mov    %eax,%edx
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	01 c2                	add    %eax,%edx
 26f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 273:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 279:	3c 0a                	cmp    $0xa,%al
 27b:	74 16                	je     293 <gets+0x5f>
 27d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 281:	3c 0d                	cmp    $0xd,%al
 283:	74 0e                	je     293 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 285:	8b 45 f4             	mov    -0xc(%ebp),%eax
 288:	83 c0 01             	add    $0x1,%eax
 28b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 28e:	7c b3                	jl     243 <gets+0xf>
 290:	eb 01                	jmp    293 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 292:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 293:	8b 55 f4             	mov    -0xc(%ebp),%edx
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	01 d0                	add    %edx,%eax
 29b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a1:	c9                   	leave  
 2a2:	c3                   	ret    

000002a3 <stat>:

int
stat(char *n, struct stat *st)
{
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	6a 00                	push   $0x0
 2ae:	ff 75 08             	pushl  0x8(%ebp)
 2b1:	e8 0c 01 00 00       	call   3c2 <open>
 2b6:	83 c4 10             	add    $0x10,%esp
 2b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c0:	79 07                	jns    2c9 <stat+0x26>
    return -1;
 2c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c7:	eb 25                	jmp    2ee <stat+0x4b>
  r = fstat(fd, st);
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	pushl  0xc(%ebp)
 2cf:	ff 75 f4             	pushl  -0xc(%ebp)
 2d2:	e8 03 01 00 00       	call   3da <fstat>
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2dd:	83 ec 0c             	sub    $0xc,%esp
 2e0:	ff 75 f4             	pushl  -0xc(%ebp)
 2e3:	e8 c2 00 00 00       	call   3aa <close>
 2e8:	83 c4 10             	add    $0x10,%esp
  return r;
 2eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ee:	c9                   	leave  
 2ef:	c3                   	ret    

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fd:	eb 25                	jmp    324 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 302:	89 d0                	mov    %edx,%eax
 304:	c1 e0 02             	shl    $0x2,%eax
 307:	01 d0                	add    %edx,%eax
 309:	01 c0                	add    %eax,%eax
 30b:	89 c1                	mov    %eax,%ecx
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
 310:	8d 50 01             	lea    0x1(%eax),%edx
 313:	89 55 08             	mov    %edx,0x8(%ebp)
 316:	0f b6 00             	movzbl (%eax),%eax
 319:	0f be c0             	movsbl %al,%eax
 31c:	01 c8                	add    %ecx,%eax
 31e:	83 e8 30             	sub    $0x30,%eax
 321:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	0f b6 00             	movzbl (%eax),%eax
 32a:	3c 2f                	cmp    $0x2f,%al
 32c:	7e 0a                	jle    338 <atoi+0x48>
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	0f b6 00             	movzbl (%eax),%eax
 334:	3c 39                	cmp    $0x39,%al
 336:	7e c7                	jle    2ff <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 338:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 33b:	c9                   	leave  
 33c:	c3                   	ret    

0000033d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 33d:	55                   	push   %ebp
 33e:	89 e5                	mov    %esp,%ebp
 340:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 349:	8b 45 0c             	mov    0xc(%ebp),%eax
 34c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 34f:	eb 17                	jmp    368 <memmove+0x2b>
    *dst++ = *src++;
 351:	8b 45 fc             	mov    -0x4(%ebp),%eax
 354:	8d 50 01             	lea    0x1(%eax),%edx
 357:	89 55 fc             	mov    %edx,-0x4(%ebp)
 35a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 35d:	8d 4a 01             	lea    0x1(%edx),%ecx
 360:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 363:	0f b6 12             	movzbl (%edx),%edx
 366:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 368:	8b 45 10             	mov    0x10(%ebp),%eax
 36b:	8d 50 ff             	lea    -0x1(%eax),%edx
 36e:	89 55 10             	mov    %edx,0x10(%ebp)
 371:	85 c0                	test   %eax,%eax
 373:	7f dc                	jg     351 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 375:	8b 45 08             	mov    0x8(%ebp),%eax
}
 378:	c9                   	leave  
 379:	c3                   	ret    

0000037a <fork>:
 37a:	b8 01 00 00 00       	mov    $0x1,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <exit>:
 382:	b8 02 00 00 00       	mov    $0x2,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <wait>:
 38a:	b8 03 00 00 00       	mov    $0x3,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <pipe>:
 392:	b8 04 00 00 00       	mov    $0x4,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <read>:
 39a:	b8 05 00 00 00       	mov    $0x5,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <write>:
 3a2:	b8 10 00 00 00       	mov    $0x10,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <close>:
 3aa:	b8 15 00 00 00       	mov    $0x15,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <kill>:
 3b2:	b8 06 00 00 00       	mov    $0x6,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <exec>:
 3ba:	b8 07 00 00 00       	mov    $0x7,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <open>:
 3c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mknod>:
 3ca:	b8 11 00 00 00       	mov    $0x11,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <unlink>:
 3d2:	b8 12 00 00 00       	mov    $0x12,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <fstat>:
 3da:	b8 08 00 00 00       	mov    $0x8,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <link>:
 3e2:	b8 13 00 00 00       	mov    $0x13,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <mkdir>:
 3ea:	b8 14 00 00 00       	mov    $0x14,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <chdir>:
 3f2:	b8 09 00 00 00       	mov    $0x9,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <dup>:
 3fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <getpid>:
 402:	b8 0b 00 00 00       	mov    $0xb,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <sbrk>:
 40a:	b8 0c 00 00 00       	mov    $0xc,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <sleep>:
 412:	b8 0d 00 00 00       	mov    $0xd,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <uptime>:
 41a:	b8 0e 00 00 00       	mov    $0xe,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <date>:
 422:	b8 16 00 00 00       	mov    $0x16,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <putc>:
 42a:	55                   	push   %ebp
 42b:	89 e5                	mov    %esp,%ebp
 42d:	83 ec 18             	sub    $0x18,%esp
 430:	8b 45 0c             	mov    0xc(%ebp),%eax
 433:	88 45 f4             	mov    %al,-0xc(%ebp)
 436:	83 ec 04             	sub    $0x4,%esp
 439:	6a 01                	push   $0x1
 43b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 43e:	50                   	push   %eax
 43f:	ff 75 08             	pushl  0x8(%ebp)
 442:	e8 5b ff ff ff       	call   3a2 <write>
 447:	83 c4 10             	add    $0x10,%esp
 44a:	90                   	nop
 44b:	c9                   	leave  
 44c:	c3                   	ret    

0000044d <printint>:
 44d:	55                   	push   %ebp
 44e:	89 e5                	mov    %esp,%ebp
 450:	53                   	push   %ebx
 451:	83 ec 24             	sub    $0x24,%esp
 454:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 45b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 45f:	74 17                	je     478 <printint+0x2b>
 461:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 465:	79 11                	jns    478 <printint+0x2b>
 467:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 46e:	8b 45 0c             	mov    0xc(%ebp),%eax
 471:	f7 d8                	neg    %eax
 473:	89 45 ec             	mov    %eax,-0x14(%ebp)
 476:	eb 06                	jmp    47e <printint+0x31>
 478:	8b 45 0c             	mov    0xc(%ebp),%eax
 47b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 485:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 488:	8d 41 01             	lea    0x1(%ecx),%eax
 48b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 48e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 491:	8b 45 ec             	mov    -0x14(%ebp),%eax
 494:	ba 00 00 00 00       	mov    $0x0,%edx
 499:	f7 f3                	div    %ebx
 49b:	89 d0                	mov    %edx,%eax
 49d:	0f b6 80 64 0b 00 00 	movzbl 0xb64(%eax),%eax
 4a4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 4a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4ae:	ba 00 00 00 00       	mov    $0x0,%edx
 4b3:	f7 f3                	div    %ebx
 4b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4bc:	75 c7                	jne    485 <printint+0x38>
 4be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4c2:	74 2d                	je     4f1 <printint+0xa4>
 4c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c7:	8d 50 01             	lea    0x1(%eax),%edx
 4ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4cd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 4d2:	eb 1d                	jmp    4f1 <printint+0xa4>
 4d4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4da:	01 d0                	add    %edx,%eax
 4dc:	0f b6 00             	movzbl (%eax),%eax
 4df:	0f be c0             	movsbl %al,%eax
 4e2:	83 ec 08             	sub    $0x8,%esp
 4e5:	50                   	push   %eax
 4e6:	ff 75 08             	pushl  0x8(%ebp)
 4e9:	e8 3c ff ff ff       	call   42a <putc>
 4ee:	83 c4 10             	add    $0x10,%esp
 4f1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f9:	79 d9                	jns    4d4 <printint+0x87>
 4fb:	90                   	nop
 4fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4ff:	c9                   	leave  
 500:	c3                   	ret    

00000501 <printf>:
 501:	55                   	push   %ebp
 502:	89 e5                	mov    %esp,%ebp
 504:	83 ec 28             	sub    $0x28,%esp
 507:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 50e:	8d 45 0c             	lea    0xc(%ebp),%eax
 511:	83 c0 04             	add    $0x4,%eax
 514:	89 45 e8             	mov    %eax,-0x18(%ebp)
 517:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 51e:	e9 59 01 00 00       	jmp    67c <printf+0x17b>
 523:	8b 55 0c             	mov    0xc(%ebp),%edx
 526:	8b 45 f0             	mov    -0x10(%ebp),%eax
 529:	01 d0                	add    %edx,%eax
 52b:	0f b6 00             	movzbl (%eax),%eax
 52e:	0f be c0             	movsbl %al,%eax
 531:	25 ff 00 00 00       	and    $0xff,%eax
 536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 539:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 53d:	75 2c                	jne    56b <printf+0x6a>
 53f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 543:	75 0c                	jne    551 <printf+0x50>
 545:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 54c:	e9 27 01 00 00       	jmp    678 <printf+0x177>
 551:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 554:	0f be c0             	movsbl %al,%eax
 557:	83 ec 08             	sub    $0x8,%esp
 55a:	50                   	push   %eax
 55b:	ff 75 08             	pushl  0x8(%ebp)
 55e:	e8 c7 fe ff ff       	call   42a <putc>
 563:	83 c4 10             	add    $0x10,%esp
 566:	e9 0d 01 00 00       	jmp    678 <printf+0x177>
 56b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 56f:	0f 85 03 01 00 00    	jne    678 <printf+0x177>
 575:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 579:	75 1e                	jne    599 <printf+0x98>
 57b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57e:	8b 00                	mov    (%eax),%eax
 580:	6a 01                	push   $0x1
 582:	6a 0a                	push   $0xa
 584:	50                   	push   %eax
 585:	ff 75 08             	pushl  0x8(%ebp)
 588:	e8 c0 fe ff ff       	call   44d <printint>
 58d:	83 c4 10             	add    $0x10,%esp
 590:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 594:	e9 d8 00 00 00       	jmp    671 <printf+0x170>
 599:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 59d:	74 06                	je     5a5 <printf+0xa4>
 59f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5a3:	75 1e                	jne    5c3 <printf+0xc2>
 5a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a8:	8b 00                	mov    (%eax),%eax
 5aa:	6a 00                	push   $0x0
 5ac:	6a 10                	push   $0x10
 5ae:	50                   	push   %eax
 5af:	ff 75 08             	pushl  0x8(%ebp)
 5b2:	e8 96 fe ff ff       	call   44d <printint>
 5b7:	83 c4 10             	add    $0x10,%esp
 5ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5be:	e9 ae 00 00 00       	jmp    671 <printf+0x170>
 5c3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5c7:	75 43                	jne    60c <printf+0x10b>
 5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d9:	75 25                	jne    600 <printf+0xff>
 5db:	c7 45 f4 ef 08 00 00 	movl   $0x8ef,-0xc(%ebp)
 5e2:	eb 1c                	jmp    600 <printf+0xff>
 5e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e7:	0f b6 00             	movzbl (%eax),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	83 ec 08             	sub    $0x8,%esp
 5f0:	50                   	push   %eax
 5f1:	ff 75 08             	pushl  0x8(%ebp)
 5f4:	e8 31 fe ff ff       	call   42a <putc>
 5f9:	83 c4 10             	add    $0x10,%esp
 5fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 600:	8b 45 f4             	mov    -0xc(%ebp),%eax
 603:	0f b6 00             	movzbl (%eax),%eax
 606:	84 c0                	test   %al,%al
 608:	75 da                	jne    5e4 <printf+0xe3>
 60a:	eb 65                	jmp    671 <printf+0x170>
 60c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 610:	75 1d                	jne    62f <printf+0x12e>
 612:	8b 45 e8             	mov    -0x18(%ebp),%eax
 615:	8b 00                	mov    (%eax),%eax
 617:	0f be c0             	movsbl %al,%eax
 61a:	83 ec 08             	sub    $0x8,%esp
 61d:	50                   	push   %eax
 61e:	ff 75 08             	pushl  0x8(%ebp)
 621:	e8 04 fe ff ff       	call   42a <putc>
 626:	83 c4 10             	add    $0x10,%esp
 629:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62d:	eb 42                	jmp    671 <printf+0x170>
 62f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 633:	75 17                	jne    64c <printf+0x14b>
 635:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 638:	0f be c0             	movsbl %al,%eax
 63b:	83 ec 08             	sub    $0x8,%esp
 63e:	50                   	push   %eax
 63f:	ff 75 08             	pushl  0x8(%ebp)
 642:	e8 e3 fd ff ff       	call   42a <putc>
 647:	83 c4 10             	add    $0x10,%esp
 64a:	eb 25                	jmp    671 <printf+0x170>
 64c:	83 ec 08             	sub    $0x8,%esp
 64f:	6a 25                	push   $0x25
 651:	ff 75 08             	pushl  0x8(%ebp)
 654:	e8 d1 fd ff ff       	call   42a <putc>
 659:	83 c4 10             	add    $0x10,%esp
 65c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 65f:	0f be c0             	movsbl %al,%eax
 662:	83 ec 08             	sub    $0x8,%esp
 665:	50                   	push   %eax
 666:	ff 75 08             	pushl  0x8(%ebp)
 669:	e8 bc fd ff ff       	call   42a <putc>
 66e:	83 c4 10             	add    $0x10,%esp
 671:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 678:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 67c:	8b 55 0c             	mov    0xc(%ebp),%edx
 67f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 682:	01 d0                	add    %edx,%eax
 684:	0f b6 00             	movzbl (%eax),%eax
 687:	84 c0                	test   %al,%al
 689:	0f 85 94 fe ff ff    	jne    523 <printf+0x22>
 68f:	90                   	nop
 690:	c9                   	leave  
 691:	c3                   	ret    

00000692 <free>:
 692:	55                   	push   %ebp
 693:	89 e5                	mov    %esp,%ebp
 695:	83 ec 10             	sub    $0x10,%esp
 698:	8b 45 08             	mov    0x8(%ebp),%eax
 69b:	83 e8 08             	sub    $0x8,%eax
 69e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 6a1:	a1 88 0b 00 00       	mov    0xb88,%eax
 6a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a9:	eb 24                	jmp    6cf <free+0x3d>
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 00                	mov    (%eax),%eax
 6b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b3:	77 12                	ja     6c7 <free+0x35>
 6b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6bb:	77 24                	ja     6e1 <free+0x4f>
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 00                	mov    (%eax),%eax
 6c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c5:	77 1a                	ja     6e1 <free+0x4f>
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 00                	mov    (%eax),%eax
 6cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6d5:	76 d4                	jbe    6ab <free+0x19>
 6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6df:	76 ca                	jbe    6ab <free+0x19>
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	8b 40 04             	mov    0x4(%eax),%eax
 6e7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	01 c2                	add    %eax,%edx
 6f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f6:	8b 00                	mov    (%eax),%eax
 6f8:	39 c2                	cmp    %eax,%edx
 6fa:	75 24                	jne    720 <free+0x8e>
 6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ff:	8b 50 04             	mov    0x4(%eax),%edx
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	8b 40 04             	mov    0x4(%eax),%eax
 70a:	01 c2                	add    %eax,%edx
 70c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70f:	89 50 04             	mov    %edx,0x4(%eax)
 712:	8b 45 fc             	mov    -0x4(%ebp),%eax
 715:	8b 00                	mov    (%eax),%eax
 717:	8b 10                	mov    (%eax),%edx
 719:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71c:	89 10                	mov    %edx,(%eax)
 71e:	eb 0a                	jmp    72a <free+0x98>
 720:	8b 45 fc             	mov    -0x4(%ebp),%eax
 723:	8b 10                	mov    (%eax),%edx
 725:	8b 45 f8             	mov    -0x8(%ebp),%eax
 728:	89 10                	mov    %edx,(%eax)
 72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72d:	8b 40 04             	mov    0x4(%eax),%eax
 730:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 737:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73a:	01 d0                	add    %edx,%eax
 73c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73f:	75 20                	jne    761 <free+0xcf>
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	8b 50 04             	mov    0x4(%eax),%edx
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	8b 40 04             	mov    0x4(%eax),%eax
 74d:	01 c2                	add    %eax,%edx
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	89 50 04             	mov    %edx,0x4(%eax)
 755:	8b 45 f8             	mov    -0x8(%ebp),%eax
 758:	8b 10                	mov    (%eax),%edx
 75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75d:	89 10                	mov    %edx,(%eax)
 75f:	eb 08                	jmp    769 <free+0xd7>
 761:	8b 45 fc             	mov    -0x4(%ebp),%eax
 764:	8b 55 f8             	mov    -0x8(%ebp),%edx
 767:	89 10                	mov    %edx,(%eax)
 769:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76c:	a3 88 0b 00 00       	mov    %eax,0xb88
 771:	90                   	nop
 772:	c9                   	leave  
 773:	c3                   	ret    

00000774 <morecore>:
 774:	55                   	push   %ebp
 775:	89 e5                	mov    %esp,%ebp
 777:	83 ec 18             	sub    $0x18,%esp
 77a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 781:	77 07                	ja     78a <morecore+0x16>
 783:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 78a:	8b 45 08             	mov    0x8(%ebp),%eax
 78d:	c1 e0 03             	shl    $0x3,%eax
 790:	83 ec 0c             	sub    $0xc,%esp
 793:	50                   	push   %eax
 794:	e8 71 fc ff ff       	call   40a <sbrk>
 799:	83 c4 10             	add    $0x10,%esp
 79c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 79f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7a3:	75 07                	jne    7ac <morecore+0x38>
 7a5:	b8 00 00 00 00       	mov    $0x0,%eax
 7aa:	eb 26                	jmp    7d2 <morecore+0x5e>
 7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7af:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b5:	8b 55 08             	mov    0x8(%ebp),%edx
 7b8:	89 50 04             	mov    %edx,0x4(%eax)
 7bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7be:	83 c0 08             	add    $0x8,%eax
 7c1:	83 ec 0c             	sub    $0xc,%esp
 7c4:	50                   	push   %eax
 7c5:	e8 c8 fe ff ff       	call   692 <free>
 7ca:	83 c4 10             	add    $0x10,%esp
 7cd:	a1 88 0b 00 00       	mov    0xb88,%eax
 7d2:	c9                   	leave  
 7d3:	c3                   	ret    

000007d4 <malloc>:
 7d4:	55                   	push   %ebp
 7d5:	89 e5                	mov    %esp,%ebp
 7d7:	83 ec 18             	sub    $0x18,%esp
 7da:	8b 45 08             	mov    0x8(%ebp),%eax
 7dd:	83 c0 07             	add    $0x7,%eax
 7e0:	c1 e8 03             	shr    $0x3,%eax
 7e3:	83 c0 01             	add    $0x1,%eax
 7e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7e9:	a1 88 0b 00 00       	mov    0xb88,%eax
 7ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7f5:	75 23                	jne    81a <malloc+0x46>
 7f7:	c7 45 f0 80 0b 00 00 	movl   $0xb80,-0x10(%ebp)
 7fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 801:	a3 88 0b 00 00       	mov    %eax,0xb88
 806:	a1 88 0b 00 00       	mov    0xb88,%eax
 80b:	a3 80 0b 00 00       	mov    %eax,0xb80
 810:	c7 05 84 0b 00 00 00 	movl   $0x0,0xb84
 817:	00 00 00 
 81a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81d:	8b 00                	mov    (%eax),%eax
 81f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 822:	8b 45 f4             	mov    -0xc(%ebp),%eax
 825:	8b 40 04             	mov    0x4(%eax),%eax
 828:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 82b:	72 4d                	jb     87a <malloc+0xa6>
 82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 830:	8b 40 04             	mov    0x4(%eax),%eax
 833:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 836:	75 0c                	jne    844 <malloc+0x70>
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	8b 10                	mov    (%eax),%edx
 83d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 840:	89 10                	mov    %edx,(%eax)
 842:	eb 26                	jmp    86a <malloc+0x96>
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	8b 40 04             	mov    0x4(%eax),%eax
 84a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 84d:	89 c2                	mov    %eax,%edx
 84f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 852:	89 50 04             	mov    %edx,0x4(%eax)
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	8b 40 04             	mov    0x4(%eax),%eax
 85b:	c1 e0 03             	shl    $0x3,%eax
 85e:	01 45 f4             	add    %eax,-0xc(%ebp)
 861:	8b 45 f4             	mov    -0xc(%ebp),%eax
 864:	8b 55 ec             	mov    -0x14(%ebp),%edx
 867:	89 50 04             	mov    %edx,0x4(%eax)
 86a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86d:	a3 88 0b 00 00       	mov    %eax,0xb88
 872:	8b 45 f4             	mov    -0xc(%ebp),%eax
 875:	83 c0 08             	add    $0x8,%eax
 878:	eb 3b                	jmp    8b5 <malloc+0xe1>
 87a:	a1 88 0b 00 00       	mov    0xb88,%eax
 87f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 882:	75 1e                	jne    8a2 <malloc+0xce>
 884:	83 ec 0c             	sub    $0xc,%esp
 887:	ff 75 ec             	pushl  -0x14(%ebp)
 88a:	e8 e5 fe ff ff       	call   774 <morecore>
 88f:	83 c4 10             	add    $0x10,%esp
 892:	89 45 f4             	mov    %eax,-0xc(%ebp)
 895:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 899:	75 07                	jne    8a2 <malloc+0xce>
 89b:	b8 00 00 00 00       	mov    $0x0,%eax
 8a0:	eb 13                	jmp    8b5 <malloc+0xe1>
 8a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ab:	8b 00                	mov    (%eax),%eax
 8ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8b0:	e9 6d ff ff ff       	jmp    822 <malloc+0x4e>
 8b5:	c9                   	leave  
 8b6:	c3                   	ret    
