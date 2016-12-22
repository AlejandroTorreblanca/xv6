
kernel:     formato del fichero elf32-i386


Desensamblado de la sección .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 50 d6 10 80       	mov    $0x8010d650,%esp
8010002d:	b8 ff 38 10 80       	mov    $0x801038ff,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 10 89 10 80       	push   $0x80108910
80100042:	68 60 d6 10 80       	push   $0x8010d660
80100047:	e8 64 50 00 00       	call   801050b0 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp
8010004f:	c7 05 ac 1d 11 80 5c 	movl   $0x80111d5c,0x80111dac
80100056:	1d 11 80 
80100059:	c7 05 b0 1d 11 80 5c 	movl   $0x80111d5c,0x80111db0
80100060:	1d 11 80 
80100063:	c7 45 f4 94 d6 10 80 	movl   $0x8010d694,-0xc(%ebp)
8010006a:	eb 47                	jmp    801000b3 <binit+0x7f>
8010006c:	8b 15 b0 1d 11 80    	mov    0x80111db0,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 54             	mov    %edx,0x54(%eax)
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 50 5c 1d 11 80 	movl   $0x80111d5c,0x50(%eax)
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	83 c0 0c             	add    $0xc,%eax
80100088:	83 ec 08             	sub    $0x8,%esp
8010008b:	68 17 89 10 80       	push   $0x80108917
80100090:	50                   	push   %eax
80100091:	e8 bc 4e 00 00       	call   80104f52 <initsleeplock>
80100096:	83 c4 10             	add    $0x10,%esp
80100099:	a1 b0 1d 11 80       	mov    0x80111db0,%eax
8010009e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000a1:	89 50 50             	mov    %edx,0x50(%eax)
801000a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a7:	a3 b0 1d 11 80       	mov    %eax,0x80111db0
801000ac:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b3:	b8 5c 1d 11 80       	mov    $0x80111d5c,%eax
801000b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000bb:	72 af                	jb     8010006c <binit+0x38>
801000bd:	90                   	nop
801000be:	c9                   	leave  
801000bf:	c3                   	ret    

801000c0 <bget>:
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	83 ec 18             	sub    $0x18,%esp
801000c6:	83 ec 0c             	sub    $0xc,%esp
801000c9:	68 60 d6 10 80       	push   $0x8010d660
801000ce:	e8 ff 4f 00 00       	call   801050d2 <acquire>
801000d3:	83 c4 10             	add    $0x10,%esp
801000d6:	a1 b0 1d 11 80       	mov    0x80111db0,%eax
801000db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000de:	eb 58                	jmp    80100138 <bget+0x78>
801000e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e3:	8b 40 04             	mov    0x4(%eax),%eax
801000e6:	3b 45 08             	cmp    0x8(%ebp),%eax
801000e9:	75 44                	jne    8010012f <bget+0x6f>
801000eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ee:	8b 40 08             	mov    0x8(%eax),%eax
801000f1:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000f4:	75 39                	jne    8010012f <bget+0x6f>
801000f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f9:	8b 40 4c             	mov    0x4c(%eax),%eax
801000fc:	8d 50 01             	lea    0x1(%eax),%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 50 4c             	mov    %edx,0x4c(%eax)
80100105:	83 ec 0c             	sub    $0xc,%esp
80100108:	68 60 d6 10 80       	push   $0x8010d660
8010010d:	e8 2c 50 00 00       	call   8010513e <release>
80100112:	83 c4 10             	add    $0x10,%esp
80100115:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100118:	83 c0 0c             	add    $0xc,%eax
8010011b:	83 ec 0c             	sub    $0xc,%esp
8010011e:	50                   	push   %eax
8010011f:	e8 6a 4e 00 00       	call   80104f8e <acquiresleep>
80100124:	83 c4 10             	add    $0x10,%esp
80100127:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012a:	e9 9d 00 00 00       	jmp    801001cc <bget+0x10c>
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 54             	mov    0x54(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 5c 1d 11 80 	cmpl   $0x80111d5c,-0xc(%ebp)
8010013f:	75 9f                	jne    801000e0 <bget+0x20>
80100141:	a1 ac 1d 11 80       	mov    0x80111dac,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 6b                	jmp    801001b6 <bget+0xf6>
8010014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014e:	8b 40 4c             	mov    0x4c(%eax),%eax
80100151:	85 c0                	test   %eax,%eax
80100153:	75 58                	jne    801001ad <bget+0xed>
80100155:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100158:	8b 00                	mov    (%eax),%eax
8010015a:	83 e0 04             	and    $0x4,%eax
8010015d:	85 c0                	test   %eax,%eax
8010015f:	75 4c                	jne    801001ad <bget+0xed>
80100161:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100164:	8b 55 08             	mov    0x8(%ebp),%edx
80100167:	89 50 04             	mov    %edx,0x4(%eax)
8010016a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016d:	8b 55 0c             	mov    0xc(%ebp),%edx
80100170:	89 50 08             	mov    %edx,0x8(%eax)
80100173:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100176:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010017c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017f:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
80100186:	83 ec 0c             	sub    $0xc,%esp
80100189:	68 60 d6 10 80       	push   $0x8010d660
8010018e:	e8 ab 4f 00 00       	call   8010513e <release>
80100193:	83 c4 10             	add    $0x10,%esp
80100196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100199:	83 c0 0c             	add    $0xc,%eax
8010019c:	83 ec 0c             	sub    $0xc,%esp
8010019f:	50                   	push   %eax
801001a0:	e8 e9 4d 00 00       	call   80104f8e <acquiresleep>
801001a5:	83 c4 10             	add    $0x10,%esp
801001a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ab:	eb 1f                	jmp    801001cc <bget+0x10c>
801001ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b0:	8b 40 50             	mov    0x50(%eax),%eax
801001b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001b6:	81 7d f4 5c 1d 11 80 	cmpl   $0x80111d5c,-0xc(%ebp)
801001bd:	75 8c                	jne    8010014b <bget+0x8b>
801001bf:	83 ec 0c             	sub    $0xc,%esp
801001c2:	68 1e 89 10 80       	push   $0x8010891e
801001c7:	e8 cc 03 00 00       	call   80100598 <panic>
801001cc:	c9                   	leave  
801001cd:	c3                   	ret    

801001ce <bread>:
801001ce:	55                   	push   %ebp
801001cf:	89 e5                	mov    %esp,%ebp
801001d1:	83 ec 18             	sub    $0x18,%esp
801001d4:	83 ec 08             	sub    $0x8,%esp
801001d7:	ff 75 0c             	pushl  0xc(%ebp)
801001da:	ff 75 08             	pushl  0x8(%ebp)
801001dd:	e8 de fe ff ff       	call   801000c0 <bget>
801001e2:	83 c4 10             	add    $0x10,%esp
801001e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001eb:	8b 00                	mov    (%eax),%eax
801001ed:	83 e0 02             	and    $0x2,%eax
801001f0:	85 c0                	test   %eax,%eax
801001f2:	75 0e                	jne    80100202 <bread+0x34>
801001f4:	83 ec 0c             	sub    $0xc,%esp
801001f7:	ff 75 f4             	pushl  -0xc(%ebp)
801001fa:	e8 0b 27 00 00       	call   8010290a <iderw>
801001ff:	83 c4 10             	add    $0x10,%esp
80100202:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100205:	c9                   	leave  
80100206:	c3                   	ret    

80100207 <bwrite>:
80100207:	55                   	push   %ebp
80100208:	89 e5                	mov    %esp,%ebp
8010020a:	83 ec 08             	sub    $0x8,%esp
8010020d:	8b 45 08             	mov    0x8(%ebp),%eax
80100210:	83 c0 0c             	add    $0xc,%eax
80100213:	83 ec 0c             	sub    $0xc,%esp
80100216:	50                   	push   %eax
80100217:	e8 25 4e 00 00       	call   80105041 <holdingsleep>
8010021c:	83 c4 10             	add    $0x10,%esp
8010021f:	85 c0                	test   %eax,%eax
80100221:	75 0d                	jne    80100230 <bwrite+0x29>
80100223:	83 ec 0c             	sub    $0xc,%esp
80100226:	68 2f 89 10 80       	push   $0x8010892f
8010022b:	e8 68 03 00 00       	call   80100598 <panic>
80100230:	8b 45 08             	mov    0x8(%ebp),%eax
80100233:	8b 00                	mov    (%eax),%eax
80100235:	83 c8 04             	or     $0x4,%eax
80100238:	89 c2                	mov    %eax,%edx
8010023a:	8b 45 08             	mov    0x8(%ebp),%eax
8010023d:	89 10                	mov    %edx,(%eax)
8010023f:	83 ec 0c             	sub    $0xc,%esp
80100242:	ff 75 08             	pushl  0x8(%ebp)
80100245:	e8 c0 26 00 00       	call   8010290a <iderw>
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	90                   	nop
8010024e:	c9                   	leave  
8010024f:	c3                   	ret    

80100250 <brelse>:
80100250:	55                   	push   %ebp
80100251:	89 e5                	mov    %esp,%ebp
80100253:	83 ec 08             	sub    $0x8,%esp
80100256:	8b 45 08             	mov    0x8(%ebp),%eax
80100259:	83 c0 0c             	add    $0xc,%eax
8010025c:	83 ec 0c             	sub    $0xc,%esp
8010025f:	50                   	push   %eax
80100260:	e8 dc 4d 00 00       	call   80105041 <holdingsleep>
80100265:	83 c4 10             	add    $0x10,%esp
80100268:	85 c0                	test   %eax,%eax
8010026a:	75 0d                	jne    80100279 <brelse+0x29>
8010026c:	83 ec 0c             	sub    $0xc,%esp
8010026f:	68 36 89 10 80       	push   $0x80108936
80100274:	e8 1f 03 00 00       	call   80100598 <panic>
80100279:	8b 45 08             	mov    0x8(%ebp),%eax
8010027c:	83 c0 0c             	add    $0xc,%eax
8010027f:	83 ec 0c             	sub    $0xc,%esp
80100282:	50                   	push   %eax
80100283:	e8 6b 4d 00 00       	call   80104ff3 <releasesleep>
80100288:	83 c4 10             	add    $0x10,%esp
8010028b:	83 ec 0c             	sub    $0xc,%esp
8010028e:	68 60 d6 10 80       	push   $0x8010d660
80100293:	e8 3a 4e 00 00       	call   801050d2 <acquire>
80100298:	83 c4 10             	add    $0x10,%esp
8010029b:	8b 45 08             	mov    0x8(%ebp),%eax
8010029e:	8b 40 4c             	mov    0x4c(%eax),%eax
801002a1:	8d 50 ff             	lea    -0x1(%eax),%edx
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	89 50 4c             	mov    %edx,0x4c(%eax)
801002aa:	8b 45 08             	mov    0x8(%ebp),%eax
801002ad:	8b 40 4c             	mov    0x4c(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 47                	jne    801002fb <brelse+0xab>
801002b4:	8b 45 08             	mov    0x8(%ebp),%eax
801002b7:	8b 40 54             	mov    0x54(%eax),%eax
801002ba:	8b 55 08             	mov    0x8(%ebp),%edx
801002bd:	8b 52 50             	mov    0x50(%edx),%edx
801002c0:	89 50 50             	mov    %edx,0x50(%eax)
801002c3:	8b 45 08             	mov    0x8(%ebp),%eax
801002c6:	8b 40 50             	mov    0x50(%eax),%eax
801002c9:	8b 55 08             	mov    0x8(%ebp),%edx
801002cc:	8b 52 54             	mov    0x54(%edx),%edx
801002cf:	89 50 54             	mov    %edx,0x54(%eax)
801002d2:	8b 15 b0 1d 11 80    	mov    0x80111db0,%edx
801002d8:	8b 45 08             	mov    0x8(%ebp),%eax
801002db:	89 50 54             	mov    %edx,0x54(%eax)
801002de:	8b 45 08             	mov    0x8(%ebp),%eax
801002e1:	c7 40 50 5c 1d 11 80 	movl   $0x80111d5c,0x50(%eax)
801002e8:	a1 b0 1d 11 80       	mov    0x80111db0,%eax
801002ed:	8b 55 08             	mov    0x8(%ebp),%edx
801002f0:	89 50 50             	mov    %edx,0x50(%eax)
801002f3:	8b 45 08             	mov    0x8(%ebp),%eax
801002f6:	a3 b0 1d 11 80       	mov    %eax,0x80111db0
801002fb:	83 ec 0c             	sub    $0xc,%esp
801002fe:	68 60 d6 10 80       	push   $0x8010d660
80100303:	e8 36 4e 00 00       	call   8010513e <release>
80100308:	83 c4 10             	add    $0x10,%esp
8010030b:	90                   	nop
8010030c:	c9                   	leave  
8010030d:	c3                   	ret    

8010030e <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010030e:	55                   	push   %ebp
8010030f:	89 e5                	mov    %esp,%ebp
80100311:	83 ec 14             	sub    $0x14,%esp
80100314:	8b 45 08             	mov    0x8(%ebp),%eax
80100317:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010031b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010031f:	89 c2                	mov    %eax,%edx
80100321:	ec                   	in     (%dx),%al
80100322:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80100325:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80100329:	c9                   	leave  
8010032a:	c3                   	ret    

8010032b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010032b:	55                   	push   %ebp
8010032c:	89 e5                	mov    %esp,%ebp
8010032e:	83 ec 08             	sub    $0x8,%esp
80100331:	8b 55 08             	mov    0x8(%ebp),%edx
80100334:	8b 45 0c             	mov    0xc(%ebp),%eax
80100337:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010033b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010033e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100342:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100346:	ee                   	out    %al,(%dx)
}
80100347:	c9                   	leave  
80100348:	c3                   	ret    

80100349 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100349:	55                   	push   %ebp
8010034a:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010034c:	fa                   	cli    
}
8010034d:	5d                   	pop    %ebp
8010034e:	c3                   	ret    

8010034f <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010034f:	55                   	push   %ebp
80100350:	89 e5                	mov    %esp,%ebp
80100352:	56                   	push   %esi
80100353:	53                   	push   %ebx
80100354:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100357:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010035b:	74 1c                	je     80100379 <printint+0x2a>
8010035d:	8b 45 08             	mov    0x8(%ebp),%eax
80100360:	c1 e8 1f             	shr    $0x1f,%eax
80100363:	0f b6 c0             	movzbl %al,%eax
80100366:	89 45 10             	mov    %eax,0x10(%ebp)
80100369:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010036d:	74 0a                	je     80100379 <printint+0x2a>
    x = -xx;
8010036f:	8b 45 08             	mov    0x8(%ebp),%eax
80100372:	f7 d8                	neg    %eax
80100374:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100377:	eb 06                	jmp    8010037f <printint+0x30>
  else
    x = xx;
80100379:	8b 45 08             	mov    0x8(%ebp),%eax
8010037c:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
8010037f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100386:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100389:	8d 41 01             	lea    0x1(%ecx),%eax
8010038c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010038f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100392:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100395:	ba 00 00 00 00       	mov    $0x0,%edx
8010039a:	f7 f3                	div    %ebx
8010039c:	89 d0                	mov    %edx,%eax
8010039e:	0f b6 80 04 a0 10 80 	movzbl -0x7fef5ffc(%eax),%eax
801003a5:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
801003a9:	8b 75 0c             	mov    0xc(%ebp),%esi
801003ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801003af:	ba 00 00 00 00       	mov    $0x0,%edx
801003b4:	f7 f6                	div    %esi
801003b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801003b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801003bd:	75 c7                	jne    80100386 <printint+0x37>

  if(sign)
801003bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003c3:	74 10                	je     801003d5 <printint+0x86>
    buf[i++] = '-';
801003c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003c8:	8d 50 01             	lea    0x1(%eax),%edx
801003cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003ce:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003d3:	eb 18                	jmp    801003ed <printint+0x9e>
801003d5:	eb 16                	jmp    801003ed <printint+0x9e>
    consputc(buf[i]);
801003d7:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003dd:	01 d0                	add    %edx,%eax
801003df:	0f b6 00             	movzbl (%eax),%eax
801003e2:	0f be c0             	movsbl %al,%eax
801003e5:	89 04 24             	mov    %eax,(%esp)
801003e8:	e8 dc 03 00 00       	call   801007c9 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003ed:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003f5:	79 e0                	jns    801003d7 <printint+0x88>
    consputc(buf[i]);
}
801003f7:	83 c4 30             	add    $0x30,%esp
801003fa:	5b                   	pop    %ebx
801003fb:	5e                   	pop    %esi
801003fc:	5d                   	pop    %ebp
801003fd:	c3                   	ret    

801003fe <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003fe:	55                   	push   %ebp
801003ff:	89 e5                	mov    %esp,%ebp
80100401:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100404:	a1 f4 c5 10 80       	mov    0x8010c5f4,%eax
80100409:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
8010040c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100410:	74 0c                	je     8010041e <cprintf+0x20>
    acquire(&cons.lock);
80100412:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100419:	e8 b4 4c 00 00       	call   801050d2 <acquire>

  if (fmt == 0)
8010041e:	8b 45 08             	mov    0x8(%ebp),%eax
80100421:	85 c0                	test   %eax,%eax
80100423:	75 0c                	jne    80100431 <cprintf+0x33>
    panic("null fmt");
80100425:	c7 04 24 3d 89 10 80 	movl   $0x8010893d,(%esp)
8010042c:	e8 67 01 00 00       	call   80100598 <panic>

  argp = (uint*)(void*)(&fmt + 1);
80100431:	8d 45 0c             	lea    0xc(%ebp),%eax
80100434:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100437:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010043e:	e9 21 01 00 00       	jmp    80100564 <cprintf+0x166>
    if(c != '%'){
80100443:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100447:	74 10                	je     80100459 <cprintf+0x5b>
      consputc(c);
80100449:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010044c:	89 04 24             	mov    %eax,(%esp)
8010044f:	e8 75 03 00 00       	call   801007c9 <consputc>
      continue;
80100454:	e9 07 01 00 00       	jmp    80100560 <cprintf+0x162>
    }
    c = fmt[++i] & 0xff;
80100459:	8b 55 08             	mov    0x8(%ebp),%edx
8010045c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100460:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100463:	01 d0                	add    %edx,%eax
80100465:	0f b6 00             	movzbl (%eax),%eax
80100468:	0f be c0             	movsbl %al,%eax
8010046b:	25 ff 00 00 00       	and    $0xff,%eax
80100470:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100473:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100477:	75 05                	jne    8010047e <cprintf+0x80>
      break;
80100479:	e9 06 01 00 00       	jmp    80100584 <cprintf+0x186>
    switch(c){
8010047e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100481:	83 f8 70             	cmp    $0x70,%eax
80100484:	74 4f                	je     801004d5 <cprintf+0xd7>
80100486:	83 f8 70             	cmp    $0x70,%eax
80100489:	7f 13                	jg     8010049e <cprintf+0xa0>
8010048b:	83 f8 25             	cmp    $0x25,%eax
8010048e:	0f 84 a6 00 00 00    	je     8010053a <cprintf+0x13c>
80100494:	83 f8 64             	cmp    $0x64,%eax
80100497:	74 14                	je     801004ad <cprintf+0xaf>
80100499:	e9 aa 00 00 00       	jmp    80100548 <cprintf+0x14a>
8010049e:	83 f8 73             	cmp    $0x73,%eax
801004a1:	74 57                	je     801004fa <cprintf+0xfc>
801004a3:	83 f8 78             	cmp    $0x78,%eax
801004a6:	74 2d                	je     801004d5 <cprintf+0xd7>
801004a8:	e9 9b 00 00 00       	jmp    80100548 <cprintf+0x14a>
    case 'd':
      printint(*argp++, 10, 1);
801004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b0:	8d 50 04             	lea    0x4(%eax),%edx
801004b3:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004b6:	8b 00                	mov    (%eax),%eax
801004b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
801004bf:	00 
801004c0:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
801004c7:	00 
801004c8:	89 04 24             	mov    %eax,(%esp)
801004cb:	e8 7f fe ff ff       	call   8010034f <printint>
      break;
801004d0:	e9 8b 00 00 00       	jmp    80100560 <cprintf+0x162>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004d8:	8d 50 04             	lea    0x4(%eax),%edx
801004db:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004de:	8b 00                	mov    (%eax),%eax
801004e0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801004e7:	00 
801004e8:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
801004ef:	00 
801004f0:	89 04 24             	mov    %eax,(%esp)
801004f3:	e8 57 fe ff ff       	call   8010034f <printint>
      break;
801004f8:	eb 66                	jmp    80100560 <cprintf+0x162>
    case 's':
      if((s = (char*)*argp++) == 0)
801004fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004fd:	8d 50 04             	lea    0x4(%eax),%edx
80100500:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100503:	8b 00                	mov    (%eax),%eax
80100505:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100508:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010050c:	75 09                	jne    80100517 <cprintf+0x119>
        s = "(null)";
8010050e:	c7 45 ec 46 89 10 80 	movl   $0x80108946,-0x14(%ebp)
      for(; *s; s++)
80100515:	eb 17                	jmp    8010052e <cprintf+0x130>
80100517:	eb 15                	jmp    8010052e <cprintf+0x130>
        consputc(*s);
80100519:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010051c:	0f b6 00             	movzbl (%eax),%eax
8010051f:	0f be c0             	movsbl %al,%eax
80100522:	89 04 24             	mov    %eax,(%esp)
80100525:	e8 9f 02 00 00       	call   801007c9 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
8010052a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010052e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100531:	0f b6 00             	movzbl (%eax),%eax
80100534:	84 c0                	test   %al,%al
80100536:	75 e1                	jne    80100519 <cprintf+0x11b>
        consputc(*s);
      break;
80100538:	eb 26                	jmp    80100560 <cprintf+0x162>
    case '%':
      consputc('%');
8010053a:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
80100541:	e8 83 02 00 00       	call   801007c9 <consputc>
      break;
80100546:	eb 18                	jmp    80100560 <cprintf+0x162>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100548:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
8010054f:	e8 75 02 00 00       	call   801007c9 <consputc>
      consputc(c);
80100554:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100557:	89 04 24             	mov    %eax,(%esp)
8010055a:	e8 6a 02 00 00       	call   801007c9 <consputc>
      break;
8010055f:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100560:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100564:	8b 55 08             	mov    0x8(%ebp),%edx
80100567:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010056a:	01 d0                	add    %edx,%eax
8010056c:	0f b6 00             	movzbl (%eax),%eax
8010056f:	0f be c0             	movsbl %al,%eax
80100572:	25 ff 00 00 00       	and    $0xff,%eax
80100577:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010057a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010057e:	0f 85 bf fe ff ff    	jne    80100443 <cprintf+0x45>
      consputc(c);
      break;
    }
  }

  if(locking)
80100584:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100588:	74 0c                	je     80100596 <cprintf+0x198>
    release(&cons.lock);
8010058a:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100591:	e8 a8 4b 00 00       	call   8010513e <release>
}
80100596:	c9                   	leave  
80100597:	c3                   	ret    

80100598 <panic>:

void
panic(char *s)
{
80100598:	55                   	push   %ebp
80100599:	89 e5                	mov    %esp,%ebp
8010059b:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];

  cli();
8010059e:	e8 a6 fd ff ff       	call   80100349 <cli>
  cons.locking = 0;
801005a3:	c7 05 f4 c5 10 80 00 	movl   $0x0,0x8010c5f4
801005aa:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801005ad:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801005b3:	0f b6 00             	movzbl (%eax),%eax
801005b6:	0f b6 c0             	movzbl %al,%eax
801005b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801005bd:	c7 04 24 4d 89 10 80 	movl   $0x8010894d,(%esp)
801005c4:	e8 35 fe ff ff       	call   801003fe <cprintf>
  cprintf(s);
801005c9:	8b 45 08             	mov    0x8(%ebp),%eax
801005cc:	89 04 24             	mov    %eax,(%esp)
801005cf:	e8 2a fe ff ff       	call   801003fe <cprintf>
  cprintf("\n");
801005d4:	c7 04 24 69 89 10 80 	movl   $0x80108969,(%esp)
801005db:	e8 1e fe ff ff       	call   801003fe <cprintf>
  getcallerpcs(&s, pcs);
801005e0:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801005e7:	8d 45 08             	lea    0x8(%ebp),%eax
801005ea:	89 04 24             	mov    %eax,(%esp)
801005ed:	e8 9e 4b 00 00       	call   80105190 <getcallerpcs>
  for(i=0; i<10; i++)
801005f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005f9:	eb 1b                	jmp    80100616 <panic+0x7e>
    cprintf(" %p", pcs[i]);
801005fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005fe:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100602:	89 44 24 04          	mov    %eax,0x4(%esp)
80100606:	c7 04 24 6b 89 10 80 	movl   $0x8010896b,(%esp)
8010060d:	e8 ec fd ff ff       	call   801003fe <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
80100612:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100616:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010061a:	7e df                	jle    801005fb <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
8010061c:	c7 05 a0 c5 10 80 01 	movl   $0x1,0x8010c5a0
80100623:	00 00 00 
  for(;;)
    ;
80100626:	eb fe                	jmp    80100626 <panic+0x8e>

80100628 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100628:	55                   	push   %ebp
80100629:	89 e5                	mov    %esp,%ebp
8010062b:	83 ec 28             	sub    $0x28,%esp
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
8010062e:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
80100635:	00 
80100636:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010063d:	e8 e9 fc ff ff       	call   8010032b <outb>
  pos = inb(CRTPORT+1) << 8;
80100642:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100649:	e8 c0 fc ff ff       	call   8010030e <inb>
8010064e:	0f b6 c0             	movzbl %al,%eax
80100651:	c1 e0 08             	shl    $0x8,%eax
80100654:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100657:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010065e:	00 
8010065f:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100666:	e8 c0 fc ff ff       	call   8010032b <outb>
  pos |= inb(CRTPORT+1);
8010066b:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100672:	e8 97 fc ff ff       	call   8010030e <inb>
80100677:	0f b6 c0             	movzbl %al,%eax
8010067a:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010067d:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100681:	75 30                	jne    801006b3 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100683:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100686:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010068b:	89 c8                	mov    %ecx,%eax
8010068d:	f7 ea                	imul   %edx
8010068f:	c1 fa 05             	sar    $0x5,%edx
80100692:	89 c8                	mov    %ecx,%eax
80100694:	c1 f8 1f             	sar    $0x1f,%eax
80100697:	29 c2                	sub    %eax,%edx
80100699:	89 d0                	mov    %edx,%eax
8010069b:	c1 e0 02             	shl    $0x2,%eax
8010069e:	01 d0                	add    %edx,%eax
801006a0:	c1 e0 04             	shl    $0x4,%eax
801006a3:	29 c1                	sub    %eax,%ecx
801006a5:	89 ca                	mov    %ecx,%edx
801006a7:	b8 50 00 00 00       	mov    $0x50,%eax
801006ac:	29 d0                	sub    %edx,%eax
801006ae:	01 45 f4             	add    %eax,-0xc(%ebp)
801006b1:	eb 35                	jmp    801006e8 <cgaputc+0xc0>
  else if(c == BACKSPACE){
801006b3:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801006ba:	75 0c                	jne    801006c8 <cgaputc+0xa0>
    if(pos > 0) --pos;
801006bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006c0:	7e 26                	jle    801006e8 <cgaputc+0xc0>
801006c2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801006c6:	eb 20                	jmp    801006e8 <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801006c8:	8b 0d 00 a0 10 80    	mov    0x8010a000,%ecx
801006ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006d1:	8d 50 01             	lea    0x1(%eax),%edx
801006d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006d7:	01 c0                	add    %eax,%eax
801006d9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
801006dc:	8b 45 08             	mov    0x8(%ebp),%eax
801006df:	0f b6 c0             	movzbl %al,%eax
801006e2:	80 cc 07             	or     $0x7,%ah
801006e5:	66 89 02             	mov    %ax,(%edx)

  if(pos < 0 || pos > 25*80)
801006e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006ec:	78 09                	js     801006f7 <cgaputc+0xcf>
801006ee:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801006f5:	7e 0c                	jle    80100703 <cgaputc+0xdb>
    panic("pos under/overflow");
801006f7:	c7 04 24 6f 89 10 80 	movl   $0x8010896f,(%esp)
801006fe:	e8 95 fe ff ff       	call   80100598 <panic>

  if((pos/80) >= 24){  // Scroll up.
80100703:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
8010070a:	7e 53                	jle    8010075f <cgaputc+0x137>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010070c:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100711:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100717:	a1 00 a0 10 80       	mov    0x8010a000,%eax
8010071c:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
80100723:	00 
80100724:	89 54 24 04          	mov    %edx,0x4(%esp)
80100728:	89 04 24             	mov    %eax,(%esp)
8010072b:	e8 db 4c 00 00       	call   8010540b <memmove>
    pos -= 80;
80100730:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100734:	b8 80 07 00 00       	mov    $0x780,%eax
80100739:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010073c:	8d 14 00             	lea    (%eax,%eax,1),%edx
8010073f:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100744:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100747:	01 c9                	add    %ecx,%ecx
80100749:	01 c8                	add    %ecx,%eax
8010074b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010074f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100756:	00 
80100757:	89 04 24             	mov    %eax,(%esp)
8010075a:	e8 ed 4b 00 00       	call   8010534c <memset>
  }

  outb(CRTPORT, 14);
8010075f:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
80100766:	00 
80100767:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010076e:	e8 b8 fb ff ff       	call   8010032b <outb>
  outb(CRTPORT+1, pos>>8);
80100773:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100776:	c1 f8 08             	sar    $0x8,%eax
80100779:	0f b6 c0             	movzbl %al,%eax
8010077c:	89 44 24 04          	mov    %eax,0x4(%esp)
80100780:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100787:	e8 9f fb ff ff       	call   8010032b <outb>
  outb(CRTPORT, 15);
8010078c:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100793:	00 
80100794:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010079b:	e8 8b fb ff ff       	call   8010032b <outb>
  outb(CRTPORT+1, pos);
801007a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007a3:	0f b6 c0             	movzbl %al,%eax
801007a6:	89 44 24 04          	mov    %eax,0x4(%esp)
801007aa:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801007b1:	e8 75 fb ff ff       	call   8010032b <outb>
  crt[pos] = ' ' | 0x0700;
801007b6:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801007bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801007be:	01 d2                	add    %edx,%edx
801007c0:	01 d0                	add    %edx,%eax
801007c2:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801007c7:	c9                   	leave  
801007c8:	c3                   	ret    

801007c9 <consputc>:

void
consputc(int c)
{
801007c9:	55                   	push   %ebp
801007ca:	89 e5                	mov    %esp,%ebp
801007cc:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
801007cf:	a1 a0 c5 10 80       	mov    0x8010c5a0,%eax
801007d4:	85 c0                	test   %eax,%eax
801007d6:	74 07                	je     801007df <consputc+0x16>
    cli();
801007d8:	e8 6c fb ff ff       	call   80100349 <cli>
    for(;;)
      ;
801007dd:	eb fe                	jmp    801007dd <consputc+0x14>
  }

  if(c == BACKSPACE){
801007df:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007e6:	75 26                	jne    8010080e <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007e8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007ef:	e8 10 68 00 00       	call   80107004 <uartputc>
801007f4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801007fb:	e8 04 68 00 00       	call   80107004 <uartputc>
80100800:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100807:	e8 f8 67 00 00       	call   80107004 <uartputc>
8010080c:	eb 0b                	jmp    80100819 <consputc+0x50>
  } else
    uartputc(c);
8010080e:	8b 45 08             	mov    0x8(%ebp),%eax
80100811:	89 04 24             	mov    %eax,(%esp)
80100814:	e8 eb 67 00 00       	call   80107004 <uartputc>
  cgaputc(c);
80100819:	8b 45 08             	mov    0x8(%ebp),%eax
8010081c:	89 04 24             	mov    %eax,(%esp)
8010081f:	e8 04 fe ff ff       	call   80100628 <cgaputc>
}
80100824:	c9                   	leave  
80100825:	c3                   	ret    

80100826 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100826:	55                   	push   %ebp
80100827:	89 e5                	mov    %esp,%ebp
80100829:	83 ec 28             	sub    $0x28,%esp
  int c, doprocdump = 0;
8010082c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
80100833:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010083a:	e8 93 48 00 00       	call   801050d2 <acquire>
  while((c = getc()) >= 0){
8010083f:	e9 39 01 00 00       	jmp    8010097d <consoleintr+0x157>
    switch(c){
80100844:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100847:	83 f8 10             	cmp    $0x10,%eax
8010084a:	74 1e                	je     8010086a <consoleintr+0x44>
8010084c:	83 f8 10             	cmp    $0x10,%eax
8010084f:	7f 0a                	jg     8010085b <consoleintr+0x35>
80100851:	83 f8 08             	cmp    $0x8,%eax
80100854:	74 66                	je     801008bc <consoleintr+0x96>
80100856:	e9 93 00 00 00       	jmp    801008ee <consoleintr+0xc8>
8010085b:	83 f8 15             	cmp    $0x15,%eax
8010085e:	74 31                	je     80100891 <consoleintr+0x6b>
80100860:	83 f8 7f             	cmp    $0x7f,%eax
80100863:	74 57                	je     801008bc <consoleintr+0x96>
80100865:	e9 84 00 00 00       	jmp    801008ee <consoleintr+0xc8>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
8010086a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
80100871:	e9 07 01 00 00       	jmp    8010097d <consoleintr+0x157>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100876:	a1 48 20 11 80       	mov    0x80112048,%eax
8010087b:	83 e8 01             	sub    $0x1,%eax
8010087e:	a3 48 20 11 80       	mov    %eax,0x80112048
        consputc(BACKSPACE);
80100883:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
8010088a:	e8 3a ff ff ff       	call   801007c9 <consputc>
8010088f:	eb 01                	jmp    80100892 <consoleintr+0x6c>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100891:	90                   	nop
80100892:	8b 15 48 20 11 80    	mov    0x80112048,%edx
80100898:	a1 44 20 11 80       	mov    0x80112044,%eax
8010089d:	39 c2                	cmp    %eax,%edx
8010089f:	74 16                	je     801008b7 <consoleintr+0x91>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008a1:	a1 48 20 11 80       	mov    0x80112048,%eax
801008a6:	83 e8 01             	sub    $0x1,%eax
801008a9:	83 e0 7f             	and    $0x7f,%eax
801008ac:	0f b6 80 c0 1f 11 80 	movzbl -0x7feee040(%eax),%eax
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008b3:	3c 0a                	cmp    $0xa,%al
801008b5:	75 bf                	jne    80100876 <consoleintr+0x50>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
801008b7:	e9 c1 00 00 00       	jmp    8010097d <consoleintr+0x157>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008bc:	8b 15 48 20 11 80    	mov    0x80112048,%edx
801008c2:	a1 44 20 11 80       	mov    0x80112044,%eax
801008c7:	39 c2                	cmp    %eax,%edx
801008c9:	74 1e                	je     801008e9 <consoleintr+0xc3>
        input.e--;
801008cb:	a1 48 20 11 80       	mov    0x80112048,%eax
801008d0:	83 e8 01             	sub    $0x1,%eax
801008d3:	a3 48 20 11 80       	mov    %eax,0x80112048
        consputc(BACKSPACE);
801008d8:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
801008df:	e8 e5 fe ff ff       	call   801007c9 <consputc>
      }
      break;
801008e4:	e9 94 00 00 00       	jmp    8010097d <consoleintr+0x157>
801008e9:	e9 8f 00 00 00       	jmp    8010097d <consoleintr+0x157>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801008f2:	0f 84 84 00 00 00    	je     8010097c <consoleintr+0x156>
801008f8:	8b 15 48 20 11 80    	mov    0x80112048,%edx
801008fe:	a1 40 20 11 80       	mov    0x80112040,%eax
80100903:	29 c2                	sub    %eax,%edx
80100905:	89 d0                	mov    %edx,%eax
80100907:	83 f8 7f             	cmp    $0x7f,%eax
8010090a:	77 70                	ja     8010097c <consoleintr+0x156>
        c = (c == '\r') ? '\n' : c;
8010090c:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80100910:	74 05                	je     80100917 <consoleintr+0xf1>
80100912:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100915:	eb 05                	jmp    8010091c <consoleintr+0xf6>
80100917:	b8 0a 00 00 00       	mov    $0xa,%eax
8010091c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
8010091f:	a1 48 20 11 80       	mov    0x80112048,%eax
80100924:	8d 50 01             	lea    0x1(%eax),%edx
80100927:	89 15 48 20 11 80    	mov    %edx,0x80112048
8010092d:	83 e0 7f             	and    $0x7f,%eax
80100930:	89 c2                	mov    %eax,%edx
80100932:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100935:	88 82 c0 1f 11 80    	mov    %al,-0x7feee040(%edx)
        consputc(c);
8010093b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010093e:	89 04 24             	mov    %eax,(%esp)
80100941:	e8 83 fe ff ff       	call   801007c9 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100946:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
8010094a:	74 18                	je     80100964 <consoleintr+0x13e>
8010094c:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100950:	74 12                	je     80100964 <consoleintr+0x13e>
80100952:	a1 48 20 11 80       	mov    0x80112048,%eax
80100957:	8b 15 40 20 11 80    	mov    0x80112040,%edx
8010095d:	83 ea 80             	sub    $0xffffff80,%edx
80100960:	39 d0                	cmp    %edx,%eax
80100962:	75 18                	jne    8010097c <consoleintr+0x156>
          input.w = input.e;
80100964:	a1 48 20 11 80       	mov    0x80112048,%eax
80100969:	a3 44 20 11 80       	mov    %eax,0x80112044
          wakeup(&input.r);
8010096e:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100975:	e8 24 44 00 00       	call   80104d9e <wakeup>
        }
      }
      break;
8010097a:	eb 00                	jmp    8010097c <consoleintr+0x156>
8010097c:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010097d:	8b 45 08             	mov    0x8(%ebp),%eax
80100980:	ff d0                	call   *%eax
80100982:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100985:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100989:	0f 89 b5 fe ff ff    	jns    80100844 <consoleintr+0x1e>
        }
      }
      break;
    }
  }
  release(&cons.lock);
8010098f:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100996:	e8 a3 47 00 00       	call   8010513e <release>
  if(doprocdump) {
8010099b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010099f:	74 05                	je     801009a6 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
801009a1:	e8 b3 44 00 00       	call   80104e59 <procdump>
  }
}
801009a6:	c9                   	leave  
801009a7:	c3                   	ret    

801009a8 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
801009a8:	55                   	push   %ebp
801009a9:	89 e5                	mov    %esp,%ebp
801009ab:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
801009ae:	8b 45 08             	mov    0x8(%ebp),%eax
801009b1:	89 04 24             	mov    %eax,(%esp)
801009b4:	e8 40 11 00 00       	call   80101af9 <iunlock>
  target = n;
801009b9:	8b 45 10             	mov    0x10(%ebp),%eax
801009bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
801009bf:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
801009c6:	e8 07 47 00 00       	call   801050d2 <acquire>
  while(n > 0){
801009cb:	e9 aa 00 00 00       	jmp    80100a7a <consoleread+0xd2>
    while(input.r == input.w){
801009d0:	eb 42                	jmp    80100a14 <consoleread+0x6c>
      if(proc->killed){
801009d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009d8:	8b 40 28             	mov    0x28(%eax),%eax
801009db:	85 c0                	test   %eax,%eax
801009dd:	74 21                	je     80100a00 <consoleread+0x58>
        release(&cons.lock);
801009df:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
801009e6:	e8 53 47 00 00       	call   8010513e <release>
        ilock(ip);
801009eb:	8b 45 08             	mov    0x8(%ebp),%eax
801009ee:	89 04 24             	mov    %eax,(%esp)
801009f1:	e8 ec 0f 00 00       	call   801019e2 <ilock>
        return -1;
801009f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009fb:	e9 a5 00 00 00       	jmp    80100aa5 <consoleread+0xfd>
      }
      sleep(&input.r, &cons.lock);
80100a00:	c7 44 24 04 c0 c5 10 	movl   $0x8010c5c0,0x4(%esp)
80100a07:	80 
80100a08:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100a0f:	e8 9f 42 00 00       	call   80104cb3 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100a14:	8b 15 40 20 11 80    	mov    0x80112040,%edx
80100a1a:	a1 44 20 11 80       	mov    0x80112044,%eax
80100a1f:	39 c2                	cmp    %eax,%edx
80100a21:	74 af                	je     801009d2 <consoleread+0x2a>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a23:	a1 40 20 11 80       	mov    0x80112040,%eax
80100a28:	8d 50 01             	lea    0x1(%eax),%edx
80100a2b:	89 15 40 20 11 80    	mov    %edx,0x80112040
80100a31:	83 e0 7f             	and    $0x7f,%eax
80100a34:	0f b6 80 c0 1f 11 80 	movzbl -0x7feee040(%eax),%eax
80100a3b:	0f be c0             	movsbl %al,%eax
80100a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a41:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a45:	75 19                	jne    80100a60 <consoleread+0xb8>
      if(n < target){
80100a47:	8b 45 10             	mov    0x10(%ebp),%eax
80100a4a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a4d:	73 0f                	jae    80100a5e <consoleread+0xb6>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a4f:	a1 40 20 11 80       	mov    0x80112040,%eax
80100a54:	83 e8 01             	sub    $0x1,%eax
80100a57:	a3 40 20 11 80       	mov    %eax,0x80112040
      }
      break;
80100a5c:	eb 26                	jmp    80100a84 <consoleread+0xdc>
80100a5e:	eb 24                	jmp    80100a84 <consoleread+0xdc>
    }
    *dst++ = c;
80100a60:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a63:	8d 50 01             	lea    0x1(%eax),%edx
80100a66:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a69:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a6c:	88 10                	mov    %dl,(%eax)
    --n;
80100a6e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a72:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a76:	75 02                	jne    80100a7a <consoleread+0xd2>
      break;
80100a78:	eb 0a                	jmp    80100a84 <consoleread+0xdc>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100a7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a7e:	0f 8f 4c ff ff ff    	jg     801009d0 <consoleread+0x28>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
80100a84:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100a8b:	e8 ae 46 00 00       	call   8010513e <release>
  ilock(ip);
80100a90:	8b 45 08             	mov    0x8(%ebp),%eax
80100a93:	89 04 24             	mov    %eax,(%esp)
80100a96:	e8 47 0f 00 00       	call   801019e2 <ilock>

  return target - n;
80100a9b:	8b 45 10             	mov    0x10(%ebp),%eax
80100a9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100aa1:	29 c2                	sub    %eax,%edx
80100aa3:	89 d0                	mov    %edx,%eax
}
80100aa5:	c9                   	leave  
80100aa6:	c3                   	ret    

80100aa7 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100aa7:	55                   	push   %ebp
80100aa8:	89 e5                	mov    %esp,%ebp
80100aaa:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100aad:	8b 45 08             	mov    0x8(%ebp),%eax
80100ab0:	89 04 24             	mov    %eax,(%esp)
80100ab3:	e8 41 10 00 00       	call   80101af9 <iunlock>
  acquire(&cons.lock);
80100ab8:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100abf:	e8 0e 46 00 00       	call   801050d2 <acquire>
  for(i = 0; i < n; i++)
80100ac4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100acb:	eb 1d                	jmp    80100aea <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100acd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ad3:	01 d0                	add    %edx,%eax
80100ad5:	0f b6 00             	movzbl (%eax),%eax
80100ad8:	0f be c0             	movsbl %al,%eax
80100adb:	0f b6 c0             	movzbl %al,%eax
80100ade:	89 04 24             	mov    %eax,(%esp)
80100ae1:	e8 e3 fc ff ff       	call   801007c9 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100ae6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100aed:	3b 45 10             	cmp    0x10(%ebp),%eax
80100af0:	7c db                	jl     80100acd <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100af2:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100af9:	e8 40 46 00 00       	call   8010513e <release>
  ilock(ip);
80100afe:	8b 45 08             	mov    0x8(%ebp),%eax
80100b01:	89 04 24             	mov    %eax,(%esp)
80100b04:	e8 d9 0e 00 00       	call   801019e2 <ilock>

  return n;
80100b09:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100b0c:	c9                   	leave  
80100b0d:	c3                   	ret    

80100b0e <consoleinit>:

void
consoleinit(void)
{
80100b0e:	55                   	push   %ebp
80100b0f:	89 e5                	mov    %esp,%ebp
80100b11:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100b14:	c7 44 24 04 82 89 10 	movl   $0x80108982,0x4(%esp)
80100b1b:	80 
80100b1c:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
80100b23:	e8 88 45 00 00       	call   801050b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100b28:	c7 05 0c 2a 11 80 a7 	movl   $0x80100aa7,0x80112a0c
80100b2f:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b32:	c7 05 08 2a 11 80 a8 	movl   $0x801009a8,0x80112a08
80100b39:	09 10 80 
  cons.locking = 1;
80100b3c:	c7 05 f4 c5 10 80 01 	movl   $0x1,0x8010c5f4
80100b43:	00 00 00 

  picenable(IRQ_KBD);
80100b46:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b4d:	e8 69 33 00 00       	call   80103ebb <picenable>
  ioapicenable(IRQ_KBD, 0);
80100b52:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100b59:	00 
80100b5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b61:	e8 6a 1f 00 00       	call   80102ad0 <ioapicenable>
}
80100b66:	c9                   	leave  
80100b67:	c3                   	ret    

80100b68 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b68:	55                   	push   %ebp
80100b69:	89 e5                	mov    %esp,%ebp
80100b6b:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b71:	e8 61 2a 00 00       	call   801035d7 <begin_op>

  if((ip = namei(path)) == 0){
80100b76:	8b 45 08             	mov    0x8(%ebp),%eax
80100b79:	89 04 24             	mov    %eax,(%esp)
80100b7c:	e8 89 19 00 00       	call   8010250a <namei>
80100b81:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b84:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b88:	75 0f                	jne    80100b99 <exec+0x31>
    end_op();
80100b8a:	e8 d4 2a 00 00       	call   80103663 <end_op>
    return -1;
80100b8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b94:	e9 2b 04 00 00       	jmp    80100fc4 <exec+0x45c>
  }
  ilock(ip);
80100b99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b9c:	89 04 24             	mov    %eax,(%esp)
80100b9f:	e8 3e 0e 00 00       	call   801019e2 <ilock>
  pgdir = 0;
80100ba4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100bab:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100bb2:	00 
80100bb3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100bba:	00 
80100bbb:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100bc1:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bc5:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100bc8:	89 04 24             	mov    %eax,(%esp)
80100bcb:	e8 9c 12 00 00       	call   80101e6c <readi>
80100bd0:	83 f8 33             	cmp    $0x33,%eax
80100bd3:	77 05                	ja     80100bda <exec+0x72>
    goto bad;
80100bd5:	e9 be 03 00 00       	jmp    80100f98 <exec+0x430>
  if(elf.magic != ELF_MAGIC)
80100bda:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100be0:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100be5:	74 05                	je     80100bec <exec+0x84>
    goto bad;
80100be7:	e9 ac 03 00 00       	jmp    80100f98 <exec+0x430>

  if((pgdir = setupkvm()) == 0)
80100bec:	e8 44 75 00 00       	call   80108135 <setupkvm>
80100bf1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bf4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bf8:	75 05                	jne    80100bff <exec+0x97>
    goto bad;
80100bfa:	e9 99 03 00 00       	jmp    80100f98 <exec+0x430>

  // Load program into memory.
  sz = 0;
80100bff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c06:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c0d:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100c13:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c16:	e9 fc 00 00 00       	jmp    80100d17 <exec+0x1af>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c1e:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100c25:	00 
80100c26:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c2a:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c30:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c34:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100c37:	89 04 24             	mov    %eax,(%esp)
80100c3a:	e8 2d 12 00 00       	call   80101e6c <readi>
80100c3f:	83 f8 20             	cmp    $0x20,%eax
80100c42:	74 05                	je     80100c49 <exec+0xe1>
      goto bad;
80100c44:	e9 4f 03 00 00       	jmp    80100f98 <exec+0x430>
    if(ph.type != ELF_PROG_LOAD)
80100c49:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c4f:	83 f8 01             	cmp    $0x1,%eax
80100c52:	74 05                	je     80100c59 <exec+0xf1>
      continue;
80100c54:	e9 b1 00 00 00       	jmp    80100d0a <exec+0x1a2>
    if(ph.memsz < ph.filesz)
80100c59:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c5f:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c65:	39 c2                	cmp    %eax,%edx
80100c67:	73 05                	jae    80100c6e <exec+0x106>
      goto bad;
80100c69:	e9 2a 03 00 00       	jmp    80100f98 <exec+0x430>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c6e:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c74:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c7a:	01 c2                	add    %eax,%edx
80100c7c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c82:	39 c2                	cmp    %eax,%edx
80100c84:	73 05                	jae    80100c8b <exec+0x123>
      goto bad;
80100c86:	e9 0d 03 00 00       	jmp    80100f98 <exec+0x430>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c8b:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c91:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c97:	01 d0                	add    %edx,%eax
80100c99:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c9d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ca4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ca7:	89 04 24             	mov    %eax,(%esp)
80100caa:	e8 f7 77 00 00       	call   801084a6 <allocuvm>
80100caf:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cb2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cb6:	75 05                	jne    80100cbd <exec+0x155>
      goto bad;
80100cb8:	e9 db 02 00 00       	jmp    80100f98 <exec+0x430>
    if(ph.vaddr % PGSIZE != 0)
80100cbd:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100cc3:	25 ff 0f 00 00       	and    $0xfff,%eax
80100cc8:	85 c0                	test   %eax,%eax
80100cca:	74 05                	je     80100cd1 <exec+0x169>
      goto bad;
80100ccc:	e9 c7 02 00 00       	jmp    80100f98 <exec+0x430>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cd1:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100cd7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100cdd:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100ce3:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100ce7:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100ceb:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100cee:	89 54 24 08          	mov    %edx,0x8(%esp)
80100cf2:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cf6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100cf9:	89 04 24             	mov    %eax,(%esp)
80100cfc:	e8 d8 76 00 00       	call   801083d9 <loaduvm>
80100d01:	85 c0                	test   %eax,%eax
80100d03:	79 05                	jns    80100d0a <exec+0x1a2>
      goto bad;
80100d05:	e9 8e 02 00 00       	jmp    80100f98 <exec+0x430>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d0a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100d0e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d11:	83 c0 20             	add    $0x20,%eax
80100d14:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100d17:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100d1e:	0f b7 c0             	movzwl %ax,%eax
80100d21:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100d24:	0f 8f f1 fe ff ff    	jg     80100c1b <exec+0xb3>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100d2a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100d2d:	89 04 24             	mov    %eax,(%esp)
80100d30:	e8 9c 0e 00 00       	call   80101bd1 <iunlockput>
  end_op();
80100d35:	e8 29 29 00 00       	call   80103663 <end_op>
  ip = 0;
80100d3a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d41:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d44:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d49:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d51:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d54:	05 00 20 00 00       	add    $0x2000,%eax
80100d59:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d60:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d64:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d67:	89 04 24             	mov    %eax,(%esp)
80100d6a:	e8 37 77 00 00       	call   801084a6 <allocuvm>
80100d6f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d72:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d76:	75 05                	jne    80100d7d <exec+0x215>
    goto bad;
80100d78:	e9 1b 02 00 00       	jmp    80100f98 <exec+0x430>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d80:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d85:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d89:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d8c:	89 04 24             	mov    %eax,(%esp)
80100d8f:	e8 4a 79 00 00       	call   801086de <clearpteu>
  sp = sz;
80100d94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d97:	89 45 dc             	mov    %eax,-0x24(%ebp)
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d9a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100da1:	e9 9a 00 00 00       	jmp    80100e40 <exec+0x2d8>
    if(argc >= MAXARG)
80100da6:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100daa:	76 05                	jbe    80100db1 <exec+0x249>
      goto bad;
80100dac:	e9 e7 01 00 00       	jmp    80100f98 <exec+0x430>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100db1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dbe:	01 d0                	add    %edx,%eax
80100dc0:	8b 00                	mov    (%eax),%eax
80100dc2:	89 04 24             	mov    %eax,(%esp)
80100dc5:	e8 cf 47 00 00       	call   80105599 <strlen>
80100dca:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100dcd:	29 c2                	sub    %eax,%edx
80100dcf:	89 d0                	mov    %edx,%eax
80100dd1:	83 e8 01             	sub    $0x1,%eax
80100dd4:	83 e0 fc             	and    $0xfffffffc,%eax
80100dd7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ddd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100de4:	8b 45 0c             	mov    0xc(%ebp),%eax
80100de7:	01 d0                	add    %edx,%eax
80100de9:	8b 00                	mov    (%eax),%eax
80100deb:	89 04 24             	mov    %eax,(%esp)
80100dee:	e8 a6 47 00 00       	call   80105599 <strlen>
80100df3:	83 c0 01             	add    $0x1,%eax
80100df6:	89 c2                	mov    %eax,%edx
80100df8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100e02:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e05:	01 c8                	add    %ecx,%eax
80100e07:	8b 00                	mov    (%eax),%eax
80100e09:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100e0d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e11:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e14:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e18:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100e1b:	89 04 24             	mov    %eax,(%esp)
80100e1e:	e8 4d 7a 00 00       	call   80108870 <copyout>
80100e23:	85 c0                	test   %eax,%eax
80100e25:	79 05                	jns    80100e2c <exec+0x2c4>
      goto bad;
80100e27:	e9 6c 01 00 00       	jmp    80100f98 <exec+0x430>
    ustack[3+argc] = sp;
80100e2c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e2f:	8d 50 03             	lea    0x3(%eax),%edx
80100e32:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e35:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e3c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100e40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e4d:	01 d0                	add    %edx,%eax
80100e4f:	8b 00                	mov    (%eax),%eax
80100e51:	85 c0                	test   %eax,%eax
80100e53:	0f 85 4d ff ff ff    	jne    80100da6 <exec+0x23e>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100e59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e5c:	83 c0 03             	add    $0x3,%eax
80100e5f:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100e66:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e6a:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100e71:	ff ff ff 
  ustack[1] = argc;
80100e74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e77:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e80:	83 c0 01             	add    $0x1,%eax
80100e83:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e8a:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e8d:	29 d0                	sub    %edx,%eax
80100e8f:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e98:	83 c0 04             	add    $0x4,%eax
80100e9b:	c1 e0 02             	shl    $0x2,%eax
80100e9e:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ea1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ea4:	83 c0 04             	add    $0x4,%eax
80100ea7:	c1 e0 02             	shl    $0x2,%eax
80100eaa:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100eae:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100eb4:	89 44 24 08          	mov    %eax,0x8(%esp)
80100eb8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ebb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ebf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ec2:	89 04 24             	mov    %eax,(%esp)
80100ec5:	e8 a6 79 00 00       	call   80108870 <copyout>
80100eca:	85 c0                	test   %eax,%eax
80100ecc:	79 05                	jns    80100ed3 <exec+0x36b>
    goto bad;
80100ece:	e9 c5 00 00 00       	jmp    80100f98 <exec+0x430>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ed3:	8b 45 08             	mov    0x8(%ebp),%eax
80100ed6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100edf:	eb 17                	jmp    80100ef8 <exec+0x390>
    if(*s == '/')
80100ee1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ee4:	0f b6 00             	movzbl (%eax),%eax
80100ee7:	3c 2f                	cmp    $0x2f,%al
80100ee9:	75 09                	jne    80100ef4 <exec+0x38c>
      last = s+1;
80100eeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eee:	83 c0 01             	add    $0x1,%eax
80100ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ef4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ef8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100efb:	0f b6 00             	movzbl (%eax),%eax
80100efe:	84 c0                	test   %al,%al
80100f00:	75 df                	jne    80100ee1 <exec+0x379>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100f02:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f08:	8d 50 70             	lea    0x70(%eax),%edx
80100f0b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100f12:	00 
80100f13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100f16:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f1a:	89 14 24             	mov    %edx,(%esp)
80100f1d:	e8 2d 46 00 00       	call   8010554f <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100f22:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f28:	8b 40 04             	mov    0x4(%eax),%eax
80100f2b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100f2e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f34:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100f37:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100f3a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f40:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f43:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100f45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f4b:	8b 40 1c             	mov    0x1c(%eax),%eax
80100f4e:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100f54:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100f57:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f5d:	8b 40 1c             	mov    0x1c(%eax),%eax
80100f60:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f63:	89 50 44             	mov    %edx,0x44(%eax)
  proc->ustack=sz-2*PGSIZE;		// Inicializar guarda
80100f66:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f6c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f6f:	81 ea 00 20 00 00    	sub    $0x2000,%edx
80100f75:	89 50 0c             	mov    %edx,0xc(%eax)
  switchuvm(proc);
80100f78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f7e:	89 04 24             	mov    %eax,(%esp)
80100f81:	e8 6b 72 00 00       	call   801081f1 <switchuvm>
  freevm(oldpgdir);
80100f86:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f89:	89 04 24             	mov    %eax,(%esp)
80100f8c:	e8 b4 76 00 00       	call   80108645 <freevm>
  return 0;
80100f91:	b8 00 00 00 00       	mov    $0x0,%eax
80100f96:	eb 2c                	jmp    80100fc4 <exec+0x45c>

 bad:
  if(pgdir)
80100f98:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f9c:	74 0b                	je     80100fa9 <exec+0x441>
    freevm(pgdir);
80100f9e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100fa1:	89 04 24             	mov    %eax,(%esp)
80100fa4:	e8 9c 76 00 00       	call   80108645 <freevm>
  if(ip){
80100fa9:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100fad:	74 10                	je     80100fbf <exec+0x457>
    iunlockput(ip);
80100faf:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100fb2:	89 04 24             	mov    %eax,(%esp)
80100fb5:	e8 17 0c 00 00       	call   80101bd1 <iunlockput>
    end_op();
80100fba:	e8 a4 26 00 00       	call   80103663 <end_op>
  }
  return -1;
80100fbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fc4:	c9                   	leave  
80100fc5:	c3                   	ret    

80100fc6 <fileinit>:
80100fc6:	55                   	push   %ebp
80100fc7:	89 e5                	mov    %esp,%ebp
80100fc9:	83 ec 08             	sub    $0x8,%esp
80100fcc:	83 ec 08             	sub    $0x8,%esp
80100fcf:	68 8a 89 10 80       	push   $0x8010898a
80100fd4:	68 60 20 11 80       	push   $0x80112060
80100fd9:	e8 d2 40 00 00       	call   801050b0 <initlock>
80100fde:	83 c4 10             	add    $0x10,%esp
80100fe1:	90                   	nop
80100fe2:	c9                   	leave  
80100fe3:	c3                   	ret    

80100fe4 <filealloc>:
80100fe4:	55                   	push   %ebp
80100fe5:	89 e5                	mov    %esp,%ebp
80100fe7:	83 ec 18             	sub    $0x18,%esp
80100fea:	83 ec 0c             	sub    $0xc,%esp
80100fed:	68 60 20 11 80       	push   $0x80112060
80100ff2:	e8 db 40 00 00       	call   801050d2 <acquire>
80100ff7:	83 c4 10             	add    $0x10,%esp
80100ffa:	c7 45 f4 94 20 11 80 	movl   $0x80112094,-0xc(%ebp)
80101001:	eb 2d                	jmp    80101030 <filealloc+0x4c>
80101003:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101006:	8b 40 04             	mov    0x4(%eax),%eax
80101009:	85 c0                	test   %eax,%eax
8010100b:	75 1f                	jne    8010102c <filealloc+0x48>
8010100d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101010:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
80101017:	83 ec 0c             	sub    $0xc,%esp
8010101a:	68 60 20 11 80       	push   $0x80112060
8010101f:	e8 1a 41 00 00       	call   8010513e <release>
80101024:	83 c4 10             	add    $0x10,%esp
80101027:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010102a:	eb 23                	jmp    8010104f <filealloc+0x6b>
8010102c:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101030:	b8 f4 29 11 80       	mov    $0x801129f4,%eax
80101035:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80101038:	72 c9                	jb     80101003 <filealloc+0x1f>
8010103a:	83 ec 0c             	sub    $0xc,%esp
8010103d:	68 60 20 11 80       	push   $0x80112060
80101042:	e8 f7 40 00 00       	call   8010513e <release>
80101047:	83 c4 10             	add    $0x10,%esp
8010104a:	b8 00 00 00 00       	mov    $0x0,%eax
8010104f:	c9                   	leave  
80101050:	c3                   	ret    

80101051 <filedup>:
80101051:	55                   	push   %ebp
80101052:	89 e5                	mov    %esp,%ebp
80101054:	83 ec 08             	sub    $0x8,%esp
80101057:	83 ec 0c             	sub    $0xc,%esp
8010105a:	68 60 20 11 80       	push   $0x80112060
8010105f:	e8 6e 40 00 00       	call   801050d2 <acquire>
80101064:	83 c4 10             	add    $0x10,%esp
80101067:	8b 45 08             	mov    0x8(%ebp),%eax
8010106a:	8b 40 04             	mov    0x4(%eax),%eax
8010106d:	85 c0                	test   %eax,%eax
8010106f:	7f 0d                	jg     8010107e <filedup+0x2d>
80101071:	83 ec 0c             	sub    $0xc,%esp
80101074:	68 91 89 10 80       	push   $0x80108991
80101079:	e8 1a f5 ff ff       	call   80100598 <panic>
8010107e:	8b 45 08             	mov    0x8(%ebp),%eax
80101081:	8b 40 04             	mov    0x4(%eax),%eax
80101084:	8d 50 01             	lea    0x1(%eax),%edx
80101087:	8b 45 08             	mov    0x8(%ebp),%eax
8010108a:	89 50 04             	mov    %edx,0x4(%eax)
8010108d:	83 ec 0c             	sub    $0xc,%esp
80101090:	68 60 20 11 80       	push   $0x80112060
80101095:	e8 a4 40 00 00       	call   8010513e <release>
8010109a:	83 c4 10             	add    $0x10,%esp
8010109d:	8b 45 08             	mov    0x8(%ebp),%eax
801010a0:	c9                   	leave  
801010a1:	c3                   	ret    

801010a2 <fileclose>:
801010a2:	55                   	push   %ebp
801010a3:	89 e5                	mov    %esp,%ebp
801010a5:	83 ec 28             	sub    $0x28,%esp
801010a8:	83 ec 0c             	sub    $0xc,%esp
801010ab:	68 60 20 11 80       	push   $0x80112060
801010b0:	e8 1d 40 00 00       	call   801050d2 <acquire>
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	8b 45 08             	mov    0x8(%ebp),%eax
801010bb:	8b 40 04             	mov    0x4(%eax),%eax
801010be:	85 c0                	test   %eax,%eax
801010c0:	7f 0d                	jg     801010cf <fileclose+0x2d>
801010c2:	83 ec 0c             	sub    $0xc,%esp
801010c5:	68 99 89 10 80       	push   $0x80108999
801010ca:	e8 c9 f4 ff ff       	call   80100598 <panic>
801010cf:	8b 45 08             	mov    0x8(%ebp),%eax
801010d2:	8b 40 04             	mov    0x4(%eax),%eax
801010d5:	8d 50 ff             	lea    -0x1(%eax),%edx
801010d8:	8b 45 08             	mov    0x8(%ebp),%eax
801010db:	89 50 04             	mov    %edx,0x4(%eax)
801010de:	8b 45 08             	mov    0x8(%ebp),%eax
801010e1:	8b 40 04             	mov    0x4(%eax),%eax
801010e4:	85 c0                	test   %eax,%eax
801010e6:	7e 15                	jle    801010fd <fileclose+0x5b>
801010e8:	83 ec 0c             	sub    $0xc,%esp
801010eb:	68 60 20 11 80       	push   $0x80112060
801010f0:	e8 49 40 00 00       	call   8010513e <release>
801010f5:	83 c4 10             	add    $0x10,%esp
801010f8:	e9 8b 00 00 00       	jmp    80101188 <fileclose+0xe6>
801010fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101100:	8b 10                	mov    (%eax),%edx
80101102:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101105:	8b 50 04             	mov    0x4(%eax),%edx
80101108:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010110b:	8b 50 08             	mov    0x8(%eax),%edx
8010110e:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101111:	8b 50 0c             	mov    0xc(%eax),%edx
80101114:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101117:	8b 50 10             	mov    0x10(%eax),%edx
8010111a:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010111d:	8b 40 14             	mov    0x14(%eax),%eax
80101120:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101123:	8b 45 08             	mov    0x8(%ebp),%eax
80101126:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
8010112d:	8b 45 08             	mov    0x8(%ebp),%eax
80101130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80101136:	83 ec 0c             	sub    $0xc,%esp
80101139:	68 60 20 11 80       	push   $0x80112060
8010113e:	e8 fb 3f 00 00       	call   8010513e <release>
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101149:	83 f8 01             	cmp    $0x1,%eax
8010114c:	75 19                	jne    80101167 <fileclose+0xc5>
8010114e:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101152:	0f be d0             	movsbl %al,%edx
80101155:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101158:	83 ec 08             	sub    $0x8,%esp
8010115b:	52                   	push   %edx
8010115c:	50                   	push   %eax
8010115d:	e8 c2 2f 00 00       	call   80104124 <pipeclose>
80101162:	83 c4 10             	add    $0x10,%esp
80101165:	eb 21                	jmp    80101188 <fileclose+0xe6>
80101167:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010116a:	83 f8 02             	cmp    $0x2,%eax
8010116d:	75 19                	jne    80101188 <fileclose+0xe6>
8010116f:	e8 63 24 00 00       	call   801035d7 <begin_op>
80101174:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101177:	83 ec 0c             	sub    $0xc,%esp
8010117a:	50                   	push   %eax
8010117b:	e8 bd 09 00 00       	call   80101b3d <iput>
80101180:	83 c4 10             	add    $0x10,%esp
80101183:	e8 db 24 00 00       	call   80103663 <end_op>
80101188:	c9                   	leave  
80101189:	c3                   	ret    

8010118a <filestat>:
8010118a:	55                   	push   %ebp
8010118b:	89 e5                	mov    %esp,%ebp
8010118d:	83 ec 08             	sub    $0x8,%esp
80101190:	8b 45 08             	mov    0x8(%ebp),%eax
80101193:	8b 00                	mov    (%eax),%eax
80101195:	83 f8 02             	cmp    $0x2,%eax
80101198:	75 40                	jne    801011da <filestat+0x50>
8010119a:	8b 45 08             	mov    0x8(%ebp),%eax
8010119d:	8b 40 10             	mov    0x10(%eax),%eax
801011a0:	83 ec 0c             	sub    $0xc,%esp
801011a3:	50                   	push   %eax
801011a4:	e8 39 08 00 00       	call   801019e2 <ilock>
801011a9:	83 c4 10             	add    $0x10,%esp
801011ac:	8b 45 08             	mov    0x8(%ebp),%eax
801011af:	8b 40 10             	mov    0x10(%eax),%eax
801011b2:	83 ec 08             	sub    $0x8,%esp
801011b5:	ff 75 0c             	pushl  0xc(%ebp)
801011b8:	50                   	push   %eax
801011b9:	e8 69 0c 00 00       	call   80101e27 <stati>
801011be:	83 c4 10             	add    $0x10,%esp
801011c1:	8b 45 08             	mov    0x8(%ebp),%eax
801011c4:	8b 40 10             	mov    0x10(%eax),%eax
801011c7:	83 ec 0c             	sub    $0xc,%esp
801011ca:	50                   	push   %eax
801011cb:	e8 29 09 00 00       	call   80101af9 <iunlock>
801011d0:	83 c4 10             	add    $0x10,%esp
801011d3:	b8 00 00 00 00       	mov    $0x0,%eax
801011d8:	eb 05                	jmp    801011df <filestat+0x55>
801011da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011df:	c9                   	leave  
801011e0:	c3                   	ret    

801011e1 <fileread>:
801011e1:	55                   	push   %ebp
801011e2:	89 e5                	mov    %esp,%ebp
801011e4:	83 ec 18             	sub    $0x18,%esp
801011e7:	8b 45 08             	mov    0x8(%ebp),%eax
801011ea:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801011ee:	84 c0                	test   %al,%al
801011f0:	75 0a                	jne    801011fc <fileread+0x1b>
801011f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011f7:	e9 9b 00 00 00       	jmp    80101297 <fileread+0xb6>
801011fc:	8b 45 08             	mov    0x8(%ebp),%eax
801011ff:	8b 00                	mov    (%eax),%eax
80101201:	83 f8 01             	cmp    $0x1,%eax
80101204:	75 1a                	jne    80101220 <fileread+0x3f>
80101206:	8b 45 08             	mov    0x8(%ebp),%eax
80101209:	8b 40 0c             	mov    0xc(%eax),%eax
8010120c:	83 ec 04             	sub    $0x4,%esp
8010120f:	ff 75 10             	pushl  0x10(%ebp)
80101212:	ff 75 0c             	pushl  0xc(%ebp)
80101215:	50                   	push   %eax
80101216:	e8 b1 30 00 00       	call   801042cc <piperead>
8010121b:	83 c4 10             	add    $0x10,%esp
8010121e:	eb 77                	jmp    80101297 <fileread+0xb6>
80101220:	8b 45 08             	mov    0x8(%ebp),%eax
80101223:	8b 00                	mov    (%eax),%eax
80101225:	83 f8 02             	cmp    $0x2,%eax
80101228:	75 60                	jne    8010128a <fileread+0xa9>
8010122a:	8b 45 08             	mov    0x8(%ebp),%eax
8010122d:	8b 40 10             	mov    0x10(%eax),%eax
80101230:	83 ec 0c             	sub    $0xc,%esp
80101233:	50                   	push   %eax
80101234:	e8 a9 07 00 00       	call   801019e2 <ilock>
80101239:	83 c4 10             	add    $0x10,%esp
8010123c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010123f:	8b 45 08             	mov    0x8(%ebp),%eax
80101242:	8b 50 14             	mov    0x14(%eax),%edx
80101245:	8b 45 08             	mov    0x8(%ebp),%eax
80101248:	8b 40 10             	mov    0x10(%eax),%eax
8010124b:	51                   	push   %ecx
8010124c:	52                   	push   %edx
8010124d:	ff 75 0c             	pushl  0xc(%ebp)
80101250:	50                   	push   %eax
80101251:	e8 16 0c 00 00       	call   80101e6c <readi>
80101256:	83 c4 10             	add    $0x10,%esp
80101259:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010125c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101260:	7e 11                	jle    80101273 <fileread+0x92>
80101262:	8b 45 08             	mov    0x8(%ebp),%eax
80101265:	8b 50 14             	mov    0x14(%eax),%edx
80101268:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010126b:	01 c2                	add    %eax,%edx
8010126d:	8b 45 08             	mov    0x8(%ebp),%eax
80101270:	89 50 14             	mov    %edx,0x14(%eax)
80101273:	8b 45 08             	mov    0x8(%ebp),%eax
80101276:	8b 40 10             	mov    0x10(%eax),%eax
80101279:	83 ec 0c             	sub    $0xc,%esp
8010127c:	50                   	push   %eax
8010127d:	e8 77 08 00 00       	call   80101af9 <iunlock>
80101282:	83 c4 10             	add    $0x10,%esp
80101285:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101288:	eb 0d                	jmp    80101297 <fileread+0xb6>
8010128a:	83 ec 0c             	sub    $0xc,%esp
8010128d:	68 a3 89 10 80       	push   $0x801089a3
80101292:	e8 01 f3 ff ff       	call   80100598 <panic>
80101297:	c9                   	leave  
80101298:	c3                   	ret    

80101299 <filewrite>:
80101299:	55                   	push   %ebp
8010129a:	89 e5                	mov    %esp,%ebp
8010129c:	53                   	push   %ebx
8010129d:	83 ec 14             	sub    $0x14,%esp
801012a0:	8b 45 08             	mov    0x8(%ebp),%eax
801012a3:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801012a7:	84 c0                	test   %al,%al
801012a9:	75 0a                	jne    801012b5 <filewrite+0x1c>
801012ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012b0:	e9 1b 01 00 00       	jmp    801013d0 <filewrite+0x137>
801012b5:	8b 45 08             	mov    0x8(%ebp),%eax
801012b8:	8b 00                	mov    (%eax),%eax
801012ba:	83 f8 01             	cmp    $0x1,%eax
801012bd:	75 1d                	jne    801012dc <filewrite+0x43>
801012bf:	8b 45 08             	mov    0x8(%ebp),%eax
801012c2:	8b 40 0c             	mov    0xc(%eax),%eax
801012c5:	83 ec 04             	sub    $0x4,%esp
801012c8:	ff 75 10             	pushl  0x10(%ebp)
801012cb:	ff 75 0c             	pushl  0xc(%ebp)
801012ce:	50                   	push   %eax
801012cf:	e8 fa 2e 00 00       	call   801041ce <pipewrite>
801012d4:	83 c4 10             	add    $0x10,%esp
801012d7:	e9 f4 00 00 00       	jmp    801013d0 <filewrite+0x137>
801012dc:	8b 45 08             	mov    0x8(%ebp),%eax
801012df:	8b 00                	mov    (%eax),%eax
801012e1:	83 f8 02             	cmp    $0x2,%eax
801012e4:	0f 85 d9 00 00 00    	jne    801013c3 <filewrite+0x12a>
801012ea:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
801012f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801012f8:	e9 a3 00 00 00       	jmp    801013a0 <filewrite+0x107>
801012fd:	8b 45 10             	mov    0x10(%ebp),%eax
80101300:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101303:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101306:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101309:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010130c:	7e 06                	jle    80101314 <filewrite+0x7b>
8010130e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101311:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101314:	e8 be 22 00 00       	call   801035d7 <begin_op>
80101319:	8b 45 08             	mov    0x8(%ebp),%eax
8010131c:	8b 40 10             	mov    0x10(%eax),%eax
8010131f:	83 ec 0c             	sub    $0xc,%esp
80101322:	50                   	push   %eax
80101323:	e8 ba 06 00 00       	call   801019e2 <ilock>
80101328:	83 c4 10             	add    $0x10,%esp
8010132b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010132e:	8b 45 08             	mov    0x8(%ebp),%eax
80101331:	8b 50 14             	mov    0x14(%eax),%edx
80101334:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101337:	8b 45 0c             	mov    0xc(%ebp),%eax
8010133a:	01 c3                	add    %eax,%ebx
8010133c:	8b 45 08             	mov    0x8(%ebp),%eax
8010133f:	8b 40 10             	mov    0x10(%eax),%eax
80101342:	51                   	push   %ecx
80101343:	52                   	push   %edx
80101344:	53                   	push   %ebx
80101345:	50                   	push   %eax
80101346:	e8 85 0c 00 00       	call   80101fd0 <writei>
8010134b:	83 c4 10             	add    $0x10,%esp
8010134e:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101351:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101355:	7e 11                	jle    80101368 <filewrite+0xcf>
80101357:	8b 45 08             	mov    0x8(%ebp),%eax
8010135a:	8b 50 14             	mov    0x14(%eax),%edx
8010135d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101360:	01 c2                	add    %eax,%edx
80101362:	8b 45 08             	mov    0x8(%ebp),%eax
80101365:	89 50 14             	mov    %edx,0x14(%eax)
80101368:	8b 45 08             	mov    0x8(%ebp),%eax
8010136b:	8b 40 10             	mov    0x10(%eax),%eax
8010136e:	83 ec 0c             	sub    $0xc,%esp
80101371:	50                   	push   %eax
80101372:	e8 82 07 00 00       	call   80101af9 <iunlock>
80101377:	83 c4 10             	add    $0x10,%esp
8010137a:	e8 e4 22 00 00       	call   80103663 <end_op>
8010137f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101383:	78 29                	js     801013ae <filewrite+0x115>
80101385:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101388:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010138b:	74 0d                	je     8010139a <filewrite+0x101>
8010138d:	83 ec 0c             	sub    $0xc,%esp
80101390:	68 ac 89 10 80       	push   $0x801089ac
80101395:	e8 fe f1 ff ff       	call   80100598 <panic>
8010139a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010139d:	01 45 f4             	add    %eax,-0xc(%ebp)
801013a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013a3:	3b 45 10             	cmp    0x10(%ebp),%eax
801013a6:	0f 8c 51 ff ff ff    	jl     801012fd <filewrite+0x64>
801013ac:	eb 01                	jmp    801013af <filewrite+0x116>
801013ae:	90                   	nop
801013af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b2:	3b 45 10             	cmp    0x10(%ebp),%eax
801013b5:	75 05                	jne    801013bc <filewrite+0x123>
801013b7:	8b 45 10             	mov    0x10(%ebp),%eax
801013ba:	eb 14                	jmp    801013d0 <filewrite+0x137>
801013bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013c1:	eb 0d                	jmp    801013d0 <filewrite+0x137>
801013c3:	83 ec 0c             	sub    $0xc,%esp
801013c6:	68 bc 89 10 80       	push   $0x801089bc
801013cb:	e8 c8 f1 ff ff       	call   80100598 <panic>
801013d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801013d3:	c9                   	leave  
801013d4:	c3                   	ret    

801013d5 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013d5:	55                   	push   %ebp
801013d6:	89 e5                	mov    %esp,%ebp
801013d8:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;

  bp = bread(dev, 1);
801013db:	8b 45 08             	mov    0x8(%ebp),%eax
801013de:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801013e5:	00 
801013e6:	89 04 24             	mov    %eax,(%esp)
801013e9:	e8 e0 ed ff ff       	call   801001ce <bread>
801013ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
801013f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013f4:	83 c0 5c             	add    $0x5c,%eax
801013f7:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
801013fe:	00 
801013ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80101403:	8b 45 0c             	mov    0xc(%ebp),%eax
80101406:	89 04 24             	mov    %eax,(%esp)
80101409:	e8 fd 3f 00 00       	call   8010540b <memmove>
  brelse(bp);
8010140e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101411:	89 04 24             	mov    %eax,(%esp)
80101414:	e8 37 ee ff ff       	call   80100250 <brelse>
}
80101419:	c9                   	leave  
8010141a:	c3                   	ret    

8010141b <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010141b:	55                   	push   %ebp
8010141c:	89 e5                	mov    %esp,%ebp
8010141e:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;

  bp = bread(dev, bno);
80101421:	8b 55 0c             	mov    0xc(%ebp),%edx
80101424:	8b 45 08             	mov    0x8(%ebp),%eax
80101427:	89 54 24 04          	mov    %edx,0x4(%esp)
8010142b:	89 04 24             	mov    %eax,(%esp)
8010142e:	e8 9b ed ff ff       	call   801001ce <bread>
80101433:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101436:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101439:	83 c0 5c             	add    $0x5c,%eax
8010143c:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101443:	00 
80101444:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010144b:	00 
8010144c:	89 04 24             	mov    %eax,(%esp)
8010144f:	e8 f8 3e 00 00       	call   8010534c <memset>
  log_write(bp);
80101454:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101457:	89 04 24             	mov    %eax,(%esp)
8010145a:	e8 b0 23 00 00       	call   8010380f <log_write>
  brelse(bp);
8010145f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101462:	89 04 24             	mov    %eax,(%esp)
80101465:	e8 e6 ed ff ff       	call   80100250 <brelse>
}
8010146a:	c9                   	leave  
8010146b:	c3                   	ret    

8010146c <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010146c:	55                   	push   %ebp
8010146d:	89 e5                	mov    %esp,%ebp
8010146f:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101472:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101479:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101480:	e9 07 01 00 00       	jmp    8010158c <balloc+0x120>
    bp = bread(dev, BBLOCK(b, sb));
80101485:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101488:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010148e:	85 c0                	test   %eax,%eax
80101490:	0f 48 c2             	cmovs  %edx,%eax
80101493:	c1 f8 0c             	sar    $0xc,%eax
80101496:	89 c2                	mov    %eax,%edx
80101498:	a1 78 2a 11 80       	mov    0x80112a78,%eax
8010149d:	01 d0                	add    %edx,%eax
8010149f:	89 44 24 04          	mov    %eax,0x4(%esp)
801014a3:	8b 45 08             	mov    0x8(%ebp),%eax
801014a6:	89 04 24             	mov    %eax,(%esp)
801014a9:	e8 20 ed ff ff       	call   801001ce <bread>
801014ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801014b8:	e9 9d 00 00 00       	jmp    8010155a <balloc+0xee>
      m = 1 << (bi % 8);
801014bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014c0:	99                   	cltd   
801014c1:	c1 ea 1d             	shr    $0x1d,%edx
801014c4:	01 d0                	add    %edx,%eax
801014c6:	83 e0 07             	and    $0x7,%eax
801014c9:	29 d0                	sub    %edx,%eax
801014cb:	ba 01 00 00 00       	mov    $0x1,%edx
801014d0:	89 c1                	mov    %eax,%ecx
801014d2:	d3 e2                	shl    %cl,%edx
801014d4:	89 d0                	mov    %edx,%eax
801014d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014dc:	8d 50 07             	lea    0x7(%eax),%edx
801014df:	85 c0                	test   %eax,%eax
801014e1:	0f 48 c2             	cmovs  %edx,%eax
801014e4:	c1 f8 03             	sar    $0x3,%eax
801014e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014ea:	0f b6 44 02 5c       	movzbl 0x5c(%edx,%eax,1),%eax
801014ef:	0f b6 c0             	movzbl %al,%eax
801014f2:	23 45 e8             	and    -0x18(%ebp),%eax
801014f5:	85 c0                	test   %eax,%eax
801014f7:	75 5d                	jne    80101556 <balloc+0xea>
        bp->data[bi/8] |= m;  // Mark block in use.
801014f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fc:	8d 50 07             	lea    0x7(%eax),%edx
801014ff:	85 c0                	test   %eax,%eax
80101501:	0f 48 c2             	cmovs  %edx,%eax
80101504:	c1 f8 03             	sar    $0x3,%eax
80101507:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010150a:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
8010150f:	89 d1                	mov    %edx,%ecx
80101511:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101514:	09 ca                	or     %ecx,%edx
80101516:	89 d1                	mov    %edx,%ecx
80101518:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010151b:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
8010151f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101522:	89 04 24             	mov    %eax,(%esp)
80101525:	e8 e5 22 00 00       	call   8010380f <log_write>
        brelse(bp);
8010152a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010152d:	89 04 24             	mov    %eax,(%esp)
80101530:	e8 1b ed ff ff       	call   80100250 <brelse>
        bzero(dev, b + bi);
80101535:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101538:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010153b:	01 c2                	add    %eax,%edx
8010153d:	8b 45 08             	mov    0x8(%ebp),%eax
80101540:	89 54 24 04          	mov    %edx,0x4(%esp)
80101544:	89 04 24             	mov    %eax,(%esp)
80101547:	e8 cf fe ff ff       	call   8010141b <bzero>
        return b + bi;
8010154c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010154f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101552:	01 d0                	add    %edx,%eax
80101554:	eb 52                	jmp    801015a8 <balloc+0x13c>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101556:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010155a:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101561:	7f 17                	jg     8010157a <balloc+0x10e>
80101563:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101566:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101569:	01 d0                	add    %edx,%eax
8010156b:	89 c2                	mov    %eax,%edx
8010156d:	a1 60 2a 11 80       	mov    0x80112a60,%eax
80101572:	39 c2                	cmp    %eax,%edx
80101574:	0f 82 43 ff ff ff    	jb     801014bd <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010157a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010157d:	89 04 24             	mov    %eax,(%esp)
80101580:	e8 cb ec ff ff       	call   80100250 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101585:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010158c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010158f:	a1 60 2a 11 80       	mov    0x80112a60,%eax
80101594:	39 c2                	cmp    %eax,%edx
80101596:	0f 82 e9 fe ff ff    	jb     80101485 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010159c:	c7 04 24 c8 89 10 80 	movl   $0x801089c8,(%esp)
801015a3:	e8 f0 ef ff ff       	call   80100598 <panic>
}
801015a8:	c9                   	leave  
801015a9:	c3                   	ret    

801015aa <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015aa:	55                   	push   %ebp
801015ab:	89 e5                	mov    %esp,%ebp
801015ad:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015b0:	c7 44 24 04 60 2a 11 	movl   $0x80112a60,0x4(%esp)
801015b7:	80 
801015b8:	8b 45 08             	mov    0x8(%ebp),%eax
801015bb:	89 04 24             	mov    %eax,(%esp)
801015be:	e8 12 fe ff ff       	call   801013d5 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801015c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801015c6:	c1 e8 0c             	shr    $0xc,%eax
801015c9:	89 c2                	mov    %eax,%edx
801015cb:	a1 78 2a 11 80       	mov    0x80112a78,%eax
801015d0:	01 c2                	add    %eax,%edx
801015d2:	8b 45 08             	mov    0x8(%ebp),%eax
801015d5:	89 54 24 04          	mov    %edx,0x4(%esp)
801015d9:	89 04 24             	mov    %eax,(%esp)
801015dc:	e8 ed eb ff ff       	call   801001ce <bread>
801015e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
801015e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801015e7:	25 ff 0f 00 00       	and    $0xfff,%eax
801015ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
801015ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015f2:	99                   	cltd   
801015f3:	c1 ea 1d             	shr    $0x1d,%edx
801015f6:	01 d0                	add    %edx,%eax
801015f8:	83 e0 07             	and    $0x7,%eax
801015fb:	29 d0                	sub    %edx,%eax
801015fd:	ba 01 00 00 00       	mov    $0x1,%edx
80101602:	89 c1                	mov    %eax,%ecx
80101604:	d3 e2                	shl    %cl,%edx
80101606:	89 d0                	mov    %edx,%eax
80101608:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010160b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010160e:	8d 50 07             	lea    0x7(%eax),%edx
80101611:	85 c0                	test   %eax,%eax
80101613:	0f 48 c2             	cmovs  %edx,%eax
80101616:	c1 f8 03             	sar    $0x3,%eax
80101619:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010161c:	0f b6 44 02 5c       	movzbl 0x5c(%edx,%eax,1),%eax
80101621:	0f b6 c0             	movzbl %al,%eax
80101624:	23 45 ec             	and    -0x14(%ebp),%eax
80101627:	85 c0                	test   %eax,%eax
80101629:	75 0c                	jne    80101637 <bfree+0x8d>
    panic("freeing free block");
8010162b:	c7 04 24 de 89 10 80 	movl   $0x801089de,(%esp)
80101632:	e8 61 ef ff ff       	call   80100598 <panic>
  bp->data[bi/8] &= ~m;
80101637:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010163a:	8d 50 07             	lea    0x7(%eax),%edx
8010163d:	85 c0                	test   %eax,%eax
8010163f:	0f 48 c2             	cmovs  %edx,%eax
80101642:	c1 f8 03             	sar    $0x3,%eax
80101645:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101648:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
8010164d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80101650:	f7 d1                	not    %ecx
80101652:	21 ca                	and    %ecx,%edx
80101654:	89 d1                	mov    %edx,%ecx
80101656:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101659:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
8010165d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101660:	89 04 24             	mov    %eax,(%esp)
80101663:	e8 a7 21 00 00       	call   8010380f <log_write>
  brelse(bp);
80101668:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010166b:	89 04 24             	mov    %eax,(%esp)
8010166e:	e8 dd eb ff ff       	call   80100250 <brelse>
}
80101673:	c9                   	leave  
80101674:	c3                   	ret    

80101675 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101675:	55                   	push   %ebp
80101676:	89 e5                	mov    %esp,%ebp
80101678:	57                   	push   %edi
80101679:	56                   	push   %esi
8010167a:	53                   	push   %ebx
8010167b:	83 ec 4c             	sub    $0x4c,%esp
  int i = 0;
8010167e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
80101685:	c7 44 24 04 f1 89 10 	movl   $0x801089f1,0x4(%esp)
8010168c:	80 
8010168d:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
80101694:	e8 17 3a 00 00       	call   801050b0 <initlock>
  for(i = 0; i < NINODE; i++) {
80101699:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801016a0:	eb 2c                	jmp    801016ce <iinit+0x59>
    initsleeplock(&icache.inode[i].lock, "inode");
801016a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016a5:	89 d0                	mov    %edx,%eax
801016a7:	c1 e0 03             	shl    $0x3,%eax
801016aa:	01 d0                	add    %edx,%eax
801016ac:	c1 e0 04             	shl    $0x4,%eax
801016af:	83 c0 30             	add    $0x30,%eax
801016b2:	05 80 2a 11 80       	add    $0x80112a80,%eax
801016b7:	83 c0 10             	add    $0x10,%eax
801016ba:	c7 44 24 04 f8 89 10 	movl   $0x801089f8,0x4(%esp)
801016c1:	80 
801016c2:	89 04 24             	mov    %eax,(%esp)
801016c5:	e8 88 38 00 00       	call   80104f52 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801016ca:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801016ce:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
801016d2:	7e ce                	jle    801016a2 <iinit+0x2d>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
801016d4:	c7 44 24 04 60 2a 11 	movl   $0x80112a60,0x4(%esp)
801016db:	80 
801016dc:	8b 45 08             	mov    0x8(%ebp),%eax
801016df:	89 04 24             	mov    %eax,(%esp)
801016e2:	e8 ee fc ff ff       	call   801013d5 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016e7:	a1 78 2a 11 80       	mov    0x80112a78,%eax
801016ec:	8b 3d 74 2a 11 80    	mov    0x80112a74,%edi
801016f2:	8b 35 70 2a 11 80    	mov    0x80112a70,%esi
801016f8:	8b 1d 6c 2a 11 80    	mov    0x80112a6c,%ebx
801016fe:	8b 0d 68 2a 11 80    	mov    0x80112a68,%ecx
80101704:	8b 15 64 2a 11 80    	mov    0x80112a64,%edx
8010170a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010170d:	8b 15 60 2a 11 80    	mov    0x80112a60,%edx
80101713:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101717:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010171b:	89 74 24 14          	mov    %esi,0x14(%esp)
8010171f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80101723:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101727:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010172a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010172e:	89 d0                	mov    %edx,%eax
80101730:	89 44 24 04          	mov    %eax,0x4(%esp)
80101734:	c7 04 24 00 8a 10 80 	movl   $0x80108a00,(%esp)
8010173b:	e8 be ec ff ff       	call   801003fe <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101740:	83 c4 4c             	add    $0x4c,%esp
80101743:	5b                   	pop    %ebx
80101744:	5e                   	pop    %esi
80101745:	5f                   	pop    %edi
80101746:	5d                   	pop    %ebp
80101747:	c3                   	ret    

80101748 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101748:	55                   	push   %ebp
80101749:	89 e5                	mov    %esp,%ebp
8010174b:	83 ec 28             	sub    $0x28,%esp
8010174e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101751:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101755:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
8010175c:	e9 9e 00 00 00       	jmp    801017ff <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
80101761:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101764:	c1 e8 03             	shr    $0x3,%eax
80101767:	89 c2                	mov    %eax,%edx
80101769:	a1 74 2a 11 80       	mov    0x80112a74,%eax
8010176e:	01 d0                	add    %edx,%eax
80101770:	89 44 24 04          	mov    %eax,0x4(%esp)
80101774:	8b 45 08             	mov    0x8(%ebp),%eax
80101777:	89 04 24             	mov    %eax,(%esp)
8010177a:	e8 4f ea ff ff       	call   801001ce <bread>
8010177f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101782:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101785:	8d 50 5c             	lea    0x5c(%eax),%edx
80101788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010178b:	83 e0 07             	and    $0x7,%eax
8010178e:	c1 e0 06             	shl    $0x6,%eax
80101791:	01 d0                	add    %edx,%eax
80101793:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101796:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101799:	0f b7 00             	movzwl (%eax),%eax
8010179c:	66 85 c0             	test   %ax,%ax
8010179f:	75 4f                	jne    801017f0 <ialloc+0xa8>
      memset(dip, 0, sizeof(*dip));
801017a1:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
801017a8:	00 
801017a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801017b0:	00 
801017b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017b4:	89 04 24             	mov    %eax,(%esp)
801017b7:	e8 90 3b 00 00       	call   8010534c <memset>
      dip->type = type;
801017bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017bf:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801017c3:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801017c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017c9:	89 04 24             	mov    %eax,(%esp)
801017cc:	e8 3e 20 00 00       	call   8010380f <log_write>
      brelse(bp);
801017d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017d4:	89 04 24             	mov    %eax,(%esp)
801017d7:	e8 74 ea ff ff       	call   80100250 <brelse>
      return iget(dev, inum);
801017dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017df:	89 44 24 04          	mov    %eax,0x4(%esp)
801017e3:	8b 45 08             	mov    0x8(%ebp),%eax
801017e6:	89 04 24             	mov    %eax,(%esp)
801017e9:	e8 ed 00 00 00       	call   801018db <iget>
801017ee:	eb 2b                	jmp    8010181b <ialloc+0xd3>
    }
    brelse(bp);
801017f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017f3:	89 04 24             	mov    %eax,(%esp)
801017f6:	e8 55 ea ff ff       	call   80100250 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801017fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801017ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101802:	a1 68 2a 11 80       	mov    0x80112a68,%eax
80101807:	39 c2                	cmp    %eax,%edx
80101809:	0f 82 52 ff ff ff    	jb     80101761 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010180f:	c7 04 24 53 8a 10 80 	movl   $0x80108a53,(%esp)
80101816:	e8 7d ed ff ff       	call   80100598 <panic>
}
8010181b:	c9                   	leave  
8010181c:	c3                   	ret    

8010181d <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
8010181d:	55                   	push   %ebp
8010181e:	89 e5                	mov    %esp,%ebp
80101820:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101823:	8b 45 08             	mov    0x8(%ebp),%eax
80101826:	8b 40 04             	mov    0x4(%eax),%eax
80101829:	c1 e8 03             	shr    $0x3,%eax
8010182c:	89 c2                	mov    %eax,%edx
8010182e:	a1 74 2a 11 80       	mov    0x80112a74,%eax
80101833:	01 c2                	add    %eax,%edx
80101835:	8b 45 08             	mov    0x8(%ebp),%eax
80101838:	8b 00                	mov    (%eax),%eax
8010183a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010183e:	89 04 24             	mov    %eax,(%esp)
80101841:	e8 88 e9 ff ff       	call   801001ce <bread>
80101846:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101849:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010184c:	8d 50 5c             	lea    0x5c(%eax),%edx
8010184f:	8b 45 08             	mov    0x8(%ebp),%eax
80101852:	8b 40 04             	mov    0x4(%eax),%eax
80101855:	83 e0 07             	and    $0x7,%eax
80101858:	c1 e0 06             	shl    $0x6,%eax
8010185b:	01 d0                	add    %edx,%eax
8010185d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101860:	8b 45 08             	mov    0x8(%ebp),%eax
80101863:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101867:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010186a:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010186d:	8b 45 08             	mov    0x8(%ebp),%eax
80101870:	0f b7 50 52          	movzwl 0x52(%eax),%edx
80101874:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101877:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010187b:	8b 45 08             	mov    0x8(%ebp),%eax
8010187e:	0f b7 50 54          	movzwl 0x54(%eax),%edx
80101882:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101885:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101889:	8b 45 08             	mov    0x8(%ebp),%eax
8010188c:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101890:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101893:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101897:	8b 45 08             	mov    0x8(%ebp),%eax
8010189a:	8b 50 58             	mov    0x58(%eax),%edx
8010189d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018a0:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018a3:	8b 45 08             	mov    0x8(%ebp),%eax
801018a6:	8d 50 5c             	lea    0x5c(%eax),%edx
801018a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018ac:	83 c0 0c             	add    $0xc,%eax
801018af:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801018b6:	00 
801018b7:	89 54 24 04          	mov    %edx,0x4(%esp)
801018bb:	89 04 24             	mov    %eax,(%esp)
801018be:	e8 48 3b 00 00       	call   8010540b <memmove>
  log_write(bp);
801018c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c6:	89 04 24             	mov    %eax,(%esp)
801018c9:	e8 41 1f 00 00       	call   8010380f <log_write>
  brelse(bp);
801018ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d1:	89 04 24             	mov    %eax,(%esp)
801018d4:	e8 77 e9 ff ff       	call   80100250 <brelse>
}
801018d9:	c9                   	leave  
801018da:	c3                   	ret    

801018db <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801018db:	55                   	push   %ebp
801018dc:	89 e5                	mov    %esp,%ebp
801018de:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801018e1:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
801018e8:	e8 e5 37 00 00       	call   801050d2 <acquire>

  // Is the inode already cached?
  empty = 0;
801018ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018f4:	c7 45 f4 b4 2a 11 80 	movl   $0x80112ab4,-0xc(%ebp)
801018fb:	eb 5c                	jmp    80101959 <iget+0x7e>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101900:	8b 40 08             	mov    0x8(%eax),%eax
80101903:	85 c0                	test   %eax,%eax
80101905:	7e 35                	jle    8010193c <iget+0x61>
80101907:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010190a:	8b 00                	mov    (%eax),%eax
8010190c:	3b 45 08             	cmp    0x8(%ebp),%eax
8010190f:	75 2b                	jne    8010193c <iget+0x61>
80101911:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101914:	8b 40 04             	mov    0x4(%eax),%eax
80101917:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010191a:	75 20                	jne    8010193c <iget+0x61>
      ip->ref++;
8010191c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010191f:	8b 40 08             	mov    0x8(%eax),%eax
80101922:	8d 50 01             	lea    0x1(%eax),%edx
80101925:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101928:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
8010192b:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
80101932:	e8 07 38 00 00       	call   8010513e <release>
      return ip;
80101937:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010193a:	eb 72                	jmp    801019ae <iget+0xd3>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010193c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101940:	75 10                	jne    80101952 <iget+0x77>
80101942:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101945:	8b 40 08             	mov    0x8(%eax),%eax
80101948:	85 c0                	test   %eax,%eax
8010194a:	75 06                	jne    80101952 <iget+0x77>
      empty = ip;
8010194c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010194f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101952:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80101959:	81 7d f4 d4 46 11 80 	cmpl   $0x801146d4,-0xc(%ebp)
80101960:	72 9b                	jb     801018fd <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101962:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101966:	75 0c                	jne    80101974 <iget+0x99>
    panic("iget: no inodes");
80101968:	c7 04 24 65 8a 10 80 	movl   $0x80108a65,(%esp)
8010196f:	e8 24 ec ff ff       	call   80100598 <panic>

  ip = empty;
80101974:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101977:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
8010197a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010197d:	8b 55 08             	mov    0x8(%ebp),%edx
80101980:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101982:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101985:	8b 55 0c             	mov    0xc(%ebp),%edx
80101988:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
8010198b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010198e:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101995:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101998:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
8010199f:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
801019a6:	e8 93 37 00 00       	call   8010513e <release>

  return ip;
801019ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801019ae:	c9                   	leave  
801019af:	c3                   	ret    

801019b0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
801019b6:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
801019bd:	e8 10 37 00 00       	call   801050d2 <acquire>
  ip->ref++;
801019c2:	8b 45 08             	mov    0x8(%ebp),%eax
801019c5:	8b 40 08             	mov    0x8(%eax),%eax
801019c8:	8d 50 01             	lea    0x1(%eax),%edx
801019cb:	8b 45 08             	mov    0x8(%ebp),%eax
801019ce:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801019d1:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
801019d8:	e8 61 37 00 00       	call   8010513e <release>
  return ip;
801019dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
801019e0:	c9                   	leave  
801019e1:	c3                   	ret    

801019e2 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801019e2:	55                   	push   %ebp
801019e3:	89 e5                	mov    %esp,%ebp
801019e5:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801019e8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801019ec:	74 0a                	je     801019f8 <ilock+0x16>
801019ee:	8b 45 08             	mov    0x8(%ebp),%eax
801019f1:	8b 40 08             	mov    0x8(%eax),%eax
801019f4:	85 c0                	test   %eax,%eax
801019f6:	7f 0c                	jg     80101a04 <ilock+0x22>
    panic("ilock");
801019f8:	c7 04 24 75 8a 10 80 	movl   $0x80108a75,(%esp)
801019ff:	e8 94 eb ff ff       	call   80100598 <panic>

  acquiresleep(&ip->lock);
80101a04:	8b 45 08             	mov    0x8(%ebp),%eax
80101a07:	83 c0 0c             	add    $0xc,%eax
80101a0a:	89 04 24             	mov    %eax,(%esp)
80101a0d:	e8 7c 35 00 00       	call   80104f8e <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101a12:	8b 45 08             	mov    0x8(%ebp),%eax
80101a15:	8b 40 4c             	mov    0x4c(%eax),%eax
80101a18:	83 e0 02             	and    $0x2,%eax
80101a1b:	85 c0                	test   %eax,%eax
80101a1d:	0f 85 d4 00 00 00    	jne    80101af7 <ilock+0x115>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a23:	8b 45 08             	mov    0x8(%ebp),%eax
80101a26:	8b 40 04             	mov    0x4(%eax),%eax
80101a29:	c1 e8 03             	shr    $0x3,%eax
80101a2c:	89 c2                	mov    %eax,%edx
80101a2e:	a1 74 2a 11 80       	mov    0x80112a74,%eax
80101a33:	01 c2                	add    %eax,%edx
80101a35:	8b 45 08             	mov    0x8(%ebp),%eax
80101a38:	8b 00                	mov    (%eax),%eax
80101a3a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101a3e:	89 04 24             	mov    %eax,(%esp)
80101a41:	e8 88 e7 ff ff       	call   801001ce <bread>
80101a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a4c:	8d 50 5c             	lea    0x5c(%eax),%edx
80101a4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a52:	8b 40 04             	mov    0x4(%eax),%eax
80101a55:	83 e0 07             	and    $0x7,%eax
80101a58:	c1 e0 06             	shl    $0x6,%eax
80101a5b:	01 d0                	add    %edx,%eax
80101a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a63:	0f b7 10             	movzwl (%eax),%edx
80101a66:	8b 45 08             	mov    0x8(%ebp),%eax
80101a69:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
80101a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a70:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a74:	8b 45 08             	mov    0x8(%ebp),%eax
80101a77:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a7e:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a82:	8b 45 08             	mov    0x8(%ebp),%eax
80101a85:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a8c:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a90:	8b 45 08             	mov    0x8(%ebp),%eax
80101a93:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101a97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a9a:	8b 50 08             	mov    0x8(%eax),%edx
80101a9d:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa0:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aa6:	8d 50 0c             	lea    0xc(%eax),%edx
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	83 c0 5c             	add    $0x5c,%eax
80101aaf:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101ab6:	00 
80101ab7:	89 54 24 04          	mov    %edx,0x4(%esp)
80101abb:	89 04 24             	mov    %eax,(%esp)
80101abe:	e8 48 39 00 00       	call   8010540b <memmove>
    brelse(bp);
80101ac3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ac6:	89 04 24             	mov    %eax,(%esp)
80101ac9:	e8 82 e7 ff ff       	call   80100250 <brelse>
    ip->flags |= I_VALID;
80101ace:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad1:	8b 40 4c             	mov    0x4c(%eax),%eax
80101ad4:	83 c8 02             	or     $0x2,%eax
80101ad7:	89 c2                	mov    %eax,%edx
80101ad9:	8b 45 08             	mov    0x8(%ebp),%eax
80101adc:	89 50 4c             	mov    %edx,0x4c(%eax)
    if(ip->type == 0)
80101adf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae2:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101ae6:	66 85 c0             	test   %ax,%ax
80101ae9:	75 0c                	jne    80101af7 <ilock+0x115>
      panic("ilock: no type");
80101aeb:	c7 04 24 7b 8a 10 80 	movl   $0x80108a7b,(%esp)
80101af2:	e8 a1 ea ff ff       	call   80100598 <panic>
  }
}
80101af7:	c9                   	leave  
80101af8:	c3                   	ret    

80101af9 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101af9:	55                   	push   %ebp
80101afa:	89 e5                	mov    %esp,%ebp
80101afc:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101aff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101b03:	74 1c                	je     80101b21 <iunlock+0x28>
80101b05:	8b 45 08             	mov    0x8(%ebp),%eax
80101b08:	83 c0 0c             	add    $0xc,%eax
80101b0b:	89 04 24             	mov    %eax,(%esp)
80101b0e:	e8 2e 35 00 00       	call   80105041 <holdingsleep>
80101b13:	85 c0                	test   %eax,%eax
80101b15:	74 0a                	je     80101b21 <iunlock+0x28>
80101b17:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1a:	8b 40 08             	mov    0x8(%eax),%eax
80101b1d:	85 c0                	test   %eax,%eax
80101b1f:	7f 0c                	jg     80101b2d <iunlock+0x34>
    panic("iunlock");
80101b21:	c7 04 24 8a 8a 10 80 	movl   $0x80108a8a,(%esp)
80101b28:	e8 6b ea ff ff       	call   80100598 <panic>

  releasesleep(&ip->lock);
80101b2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b30:	83 c0 0c             	add    $0xc,%eax
80101b33:	89 04 24             	mov    %eax,(%esp)
80101b36:	e8 b8 34 00 00       	call   80104ff3 <releasesleep>
}
80101b3b:	c9                   	leave  
80101b3c:	c3                   	ret    

80101b3d <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101b3d:	55                   	push   %ebp
80101b3e:	89 e5                	mov    %esp,%ebp
80101b40:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101b43:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
80101b4a:	e8 83 35 00 00       	call   801050d2 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101b4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b52:	8b 40 08             	mov    0x8(%eax),%eax
80101b55:	83 f8 01             	cmp    $0x1,%eax
80101b58:	75 5a                	jne    80101bb4 <iput+0x77>
80101b5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5d:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b60:	83 e0 02             	and    $0x2,%eax
80101b63:	85 c0                	test   %eax,%eax
80101b65:	74 4d                	je     80101bb4 <iput+0x77>
80101b67:	8b 45 08             	mov    0x8(%ebp),%eax
80101b6a:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101b6e:	66 85 c0             	test   %ax,%ax
80101b71:	75 41                	jne    80101bb4 <iput+0x77>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
80101b73:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
80101b7a:	e8 bf 35 00 00       	call   8010513e <release>
    itrunc(ip);
80101b7f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b82:	89 04 24             	mov    %eax,(%esp)
80101b85:	e8 78 01 00 00       	call   80101d02 <itrunc>
    ip->type = 0;
80101b8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b8d:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
    iupdate(ip);
80101b93:	8b 45 08             	mov    0x8(%ebp),%eax
80101b96:	89 04 24             	mov    %eax,(%esp)
80101b99:	e8 7f fc ff ff       	call   8010181d <iupdate>
    acquire(&icache.lock);
80101b9e:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
80101ba5:	e8 28 35 00 00       	call   801050d2 <acquire>
    ip->flags = 0;
80101baa:	8b 45 08             	mov    0x8(%ebp),%eax
80101bad:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }
  ip->ref--;
80101bb4:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb7:	8b 40 08             	mov    0x8(%eax),%eax
80101bba:	8d 50 ff             	lea    -0x1(%eax),%edx
80101bbd:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc0:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101bc3:	c7 04 24 80 2a 11 80 	movl   $0x80112a80,(%esp)
80101bca:	e8 6f 35 00 00       	call   8010513e <release>
}
80101bcf:	c9                   	leave  
80101bd0:	c3                   	ret    

80101bd1 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101bd1:	55                   	push   %ebp
80101bd2:	89 e5                	mov    %esp,%ebp
80101bd4:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101bd7:	8b 45 08             	mov    0x8(%ebp),%eax
80101bda:	89 04 24             	mov    %eax,(%esp)
80101bdd:	e8 17 ff ff ff       	call   80101af9 <iunlock>
  iput(ip);
80101be2:	8b 45 08             	mov    0x8(%ebp),%eax
80101be5:	89 04 24             	mov    %eax,(%esp)
80101be8:	e8 50 ff ff ff       	call   80101b3d <iput>
}
80101bed:	c9                   	leave  
80101bee:	c3                   	ret    

80101bef <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101bef:	55                   	push   %ebp
80101bf0:	89 e5                	mov    %esp,%ebp
80101bf2:	53                   	push   %ebx
80101bf3:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101bf6:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101bfa:	77 3e                	ja     80101c3a <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bff:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c02:	83 c2 14             	add    $0x14,%edx
80101c05:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c09:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c0c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c10:	75 20                	jne    80101c32 <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c12:	8b 45 08             	mov    0x8(%ebp),%eax
80101c15:	8b 00                	mov    (%eax),%eax
80101c17:	89 04 24             	mov    %eax,(%esp)
80101c1a:	e8 4d f8 ff ff       	call   8010146c <balloc>
80101c1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c22:	8b 45 08             	mov    0x8(%ebp),%eax
80101c25:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c28:	8d 4a 14             	lea    0x14(%edx),%ecx
80101c2b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c2e:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c35:	e9 c2 00 00 00       	jmp    80101cfc <bmap+0x10d>
  }
  bn -= NDIRECT;
80101c3a:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c3e:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c42:	0f 87 a8 00 00 00    	ja     80101cf0 <bmap+0x101>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c48:	8b 45 08             	mov    0x8(%ebp),%eax
80101c4b:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101c51:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c58:	75 1c                	jne    80101c76 <bmap+0x87>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5d:	8b 00                	mov    (%eax),%eax
80101c5f:	89 04 24             	mov    %eax,(%esp)
80101c62:	e8 05 f8 ff ff       	call   8010146c <balloc>
80101c67:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c6a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c70:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101c76:	8b 45 08             	mov    0x8(%ebp),%eax
80101c79:	8b 00                	mov    (%eax),%eax
80101c7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c7e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c82:	89 04 24             	mov    %eax,(%esp)
80101c85:	e8 44 e5 ff ff       	call   801001ce <bread>
80101c8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c90:	83 c0 5c             	add    $0x5c,%eax
80101c93:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c96:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c99:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ca0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ca3:	01 d0                	add    %edx,%eax
80101ca5:	8b 00                	mov    (%eax),%eax
80101ca7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101caa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cae:	75 30                	jne    80101ce0 <bmap+0xf1>
      a[bn] = addr = balloc(ip->dev);
80101cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cb3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cba:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cbd:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101cc0:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc3:	8b 00                	mov    (%eax),%eax
80101cc5:	89 04 24             	mov    %eax,(%esp)
80101cc8:	e8 9f f7 ff ff       	call   8010146c <balloc>
80101ccd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cd3:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101cd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cd8:	89 04 24             	mov    %eax,(%esp)
80101cdb:	e8 2f 1b 00 00       	call   8010380f <log_write>
    }
    brelse(bp);
80101ce0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ce3:	89 04 24             	mov    %eax,(%esp)
80101ce6:	e8 65 e5 ff ff       	call   80100250 <brelse>
    return addr;
80101ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cee:	eb 0c                	jmp    80101cfc <bmap+0x10d>
  }

  panic("bmap: out of range");
80101cf0:	c7 04 24 92 8a 10 80 	movl   $0x80108a92,(%esp)
80101cf7:	e8 9c e8 ff ff       	call   80100598 <panic>
}
80101cfc:	83 c4 24             	add    $0x24,%esp
80101cff:	5b                   	pop    %ebx
80101d00:	5d                   	pop    %ebp
80101d01:	c3                   	ret    

80101d02 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d02:	55                   	push   %ebp
80101d03:	89 e5                	mov    %esp,%ebp
80101d05:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d0f:	eb 44                	jmp    80101d55 <itrunc+0x53>
    if(ip->addrs[i]){
80101d11:	8b 45 08             	mov    0x8(%ebp),%eax
80101d14:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d17:	83 c2 14             	add    $0x14,%edx
80101d1a:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d1e:	85 c0                	test   %eax,%eax
80101d20:	74 2f                	je     80101d51 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101d22:	8b 45 08             	mov    0x8(%ebp),%eax
80101d25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d28:	83 c2 14             	add    $0x14,%edx
80101d2b:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101d2f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d32:	8b 00                	mov    (%eax),%eax
80101d34:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d38:	89 04 24             	mov    %eax,(%esp)
80101d3b:	e8 6a f8 ff ff       	call   801015aa <bfree>
      ip->addrs[i] = 0;
80101d40:	8b 45 08             	mov    0x8(%ebp),%eax
80101d43:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d46:	83 c2 14             	add    $0x14,%edx
80101d49:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d50:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d51:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d55:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d59:	7e b6                	jle    80101d11 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
80101d5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5e:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101d64:	85 c0                	test   %eax,%eax
80101d66:	0f 84 a4 00 00 00    	je     80101e10 <itrunc+0x10e>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d6c:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6f:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101d75:	8b 45 08             	mov    0x8(%ebp),%eax
80101d78:	8b 00                	mov    (%eax),%eax
80101d7a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d7e:	89 04 24             	mov    %eax,(%esp)
80101d81:	e8 48 e4 ff ff       	call   801001ce <bread>
80101d86:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d8c:	83 c0 5c             	add    $0x5c,%eax
80101d8f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d92:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d99:	eb 3b                	jmp    80101dd6 <itrunc+0xd4>
      if(a[j])
80101d9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d9e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101da5:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101da8:	01 d0                	add    %edx,%eax
80101daa:	8b 00                	mov    (%eax),%eax
80101dac:	85 c0                	test   %eax,%eax
80101dae:	74 22                	je     80101dd2 <itrunc+0xd0>
        bfree(ip->dev, a[j]);
80101db0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101db3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dba:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dbd:	01 d0                	add    %edx,%eax
80101dbf:	8b 10                	mov    (%eax),%edx
80101dc1:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc4:	8b 00                	mov    (%eax),%eax
80101dc6:	89 54 24 04          	mov    %edx,0x4(%esp)
80101dca:	89 04 24             	mov    %eax,(%esp)
80101dcd:	e8 d8 f7 ff ff       	call   801015aa <bfree>
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101dd2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dd9:	83 f8 7f             	cmp    $0x7f,%eax
80101ddc:	76 bd                	jbe    80101d9b <itrunc+0x99>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101dde:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101de1:	89 04 24             	mov    %eax,(%esp)
80101de4:	e8 67 e4 ff ff       	call   80100250 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101de9:	8b 45 08             	mov    0x8(%ebp),%eax
80101dec:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101df2:	8b 45 08             	mov    0x8(%ebp),%eax
80101df5:	8b 00                	mov    (%eax),%eax
80101df7:	89 54 24 04          	mov    %edx,0x4(%esp)
80101dfb:	89 04 24             	mov    %eax,(%esp)
80101dfe:	e8 a7 f7 ff ff       	call   801015aa <bfree>
    ip->addrs[NDIRECT] = 0;
80101e03:	8b 45 08             	mov    0x8(%ebp),%eax
80101e06:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101e0d:	00 00 00 
  }

  ip->size = 0;
80101e10:	8b 45 08             	mov    0x8(%ebp),%eax
80101e13:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101e1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1d:	89 04 24             	mov    %eax,(%esp)
80101e20:	e8 f8 f9 ff ff       	call   8010181d <iupdate>
}
80101e25:	c9                   	leave  
80101e26:	c3                   	ret    

80101e27 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e27:	55                   	push   %ebp
80101e28:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2d:	8b 00                	mov    (%eax),%eax
80101e2f:	89 c2                	mov    %eax,%edx
80101e31:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e34:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e37:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3a:	8b 50 04             	mov    0x4(%eax),%edx
80101e3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e40:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e43:	8b 45 08             	mov    0x8(%ebp),%eax
80101e46:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e4d:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e50:	8b 45 08             	mov    0x8(%ebp),%eax
80101e53:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101e57:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e5a:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101e5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e61:	8b 50 58             	mov    0x58(%eax),%edx
80101e64:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e67:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e6a:	5d                   	pop    %ebp
80101e6b:	c3                   	ret    

80101e6c <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e6c:	55                   	push   %ebp
80101e6d:	89 e5                	mov    %esp,%ebp
80101e6f:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e72:	8b 45 08             	mov    0x8(%ebp),%eax
80101e75:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101e79:	66 83 f8 03          	cmp    $0x3,%ax
80101e7d:	75 60                	jne    80101edf <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e7f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e82:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e86:	66 85 c0             	test   %ax,%ax
80101e89:	78 20                	js     80101eab <readi+0x3f>
80101e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e8e:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e92:	66 83 f8 09          	cmp    $0x9,%ax
80101e96:	7f 13                	jg     80101eab <readi+0x3f>
80101e98:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9b:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e9f:	98                   	cwtl   
80101ea0:	8b 04 c5 00 2a 11 80 	mov    -0x7feed600(,%eax,8),%eax
80101ea7:	85 c0                	test   %eax,%eax
80101ea9:	75 0a                	jne    80101eb5 <readi+0x49>
      return -1;
80101eab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb0:	e9 19 01 00 00       	jmp    80101fce <readi+0x162>
    return devsw[ip->major].read(ip, dst, n);
80101eb5:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb8:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101ebc:	98                   	cwtl   
80101ebd:	8b 04 c5 00 2a 11 80 	mov    -0x7feed600(,%eax,8),%eax
80101ec4:	8b 55 14             	mov    0x14(%ebp),%edx
80101ec7:	89 54 24 08          	mov    %edx,0x8(%esp)
80101ecb:	8b 55 0c             	mov    0xc(%ebp),%edx
80101ece:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ed2:	8b 55 08             	mov    0x8(%ebp),%edx
80101ed5:	89 14 24             	mov    %edx,(%esp)
80101ed8:	ff d0                	call   *%eax
80101eda:	e9 ef 00 00 00       	jmp    80101fce <readi+0x162>
  }

  if(off > ip->size || off + n < off)
80101edf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee2:	8b 40 58             	mov    0x58(%eax),%eax
80101ee5:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ee8:	72 0d                	jb     80101ef7 <readi+0x8b>
80101eea:	8b 45 14             	mov    0x14(%ebp),%eax
80101eed:	8b 55 10             	mov    0x10(%ebp),%edx
80101ef0:	01 d0                	add    %edx,%eax
80101ef2:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ef5:	73 0a                	jae    80101f01 <readi+0x95>
    return -1;
80101ef7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101efc:	e9 cd 00 00 00       	jmp    80101fce <readi+0x162>
  if(off + n > ip->size)
80101f01:	8b 45 14             	mov    0x14(%ebp),%eax
80101f04:	8b 55 10             	mov    0x10(%ebp),%edx
80101f07:	01 c2                	add    %eax,%edx
80101f09:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0c:	8b 40 58             	mov    0x58(%eax),%eax
80101f0f:	39 c2                	cmp    %eax,%edx
80101f11:	76 0c                	jbe    80101f1f <readi+0xb3>
    n = ip->size - off;
80101f13:	8b 45 08             	mov    0x8(%ebp),%eax
80101f16:	8b 40 58             	mov    0x58(%eax),%eax
80101f19:	2b 45 10             	sub    0x10(%ebp),%eax
80101f1c:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f1f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f26:	e9 94 00 00 00       	jmp    80101fbf <readi+0x153>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f2b:	8b 45 10             	mov    0x10(%ebp),%eax
80101f2e:	c1 e8 09             	shr    $0x9,%eax
80101f31:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f35:	8b 45 08             	mov    0x8(%ebp),%eax
80101f38:	89 04 24             	mov    %eax,(%esp)
80101f3b:	e8 af fc ff ff       	call   80101bef <bmap>
80101f40:	8b 55 08             	mov    0x8(%ebp),%edx
80101f43:	8b 12                	mov    (%edx),%edx
80101f45:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f49:	89 14 24             	mov    %edx,(%esp)
80101f4c:	e8 7d e2 ff ff       	call   801001ce <bread>
80101f51:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f54:	8b 45 10             	mov    0x10(%ebp),%eax
80101f57:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f5c:	89 c2                	mov    %eax,%edx
80101f5e:	b8 00 02 00 00       	mov    $0x200,%eax
80101f63:	29 d0                	sub    %edx,%eax
80101f65:	89 c2                	mov    %eax,%edx
80101f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f6a:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101f6d:	29 c1                	sub    %eax,%ecx
80101f6f:	89 c8                	mov    %ecx,%eax
80101f71:	39 c2                	cmp    %eax,%edx
80101f73:	0f 46 c2             	cmovbe %edx,%eax
80101f76:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101f79:	8b 45 10             	mov    0x10(%ebp),%eax
80101f7c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f81:	8d 50 50             	lea    0x50(%eax),%edx
80101f84:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f87:	01 d0                	add    %edx,%eax
80101f89:	8d 50 0c             	lea    0xc(%eax),%edx
80101f8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f8f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f93:	89 54 24 04          	mov    %edx,0x4(%esp)
80101f97:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f9a:	89 04 24             	mov    %eax,(%esp)
80101f9d:	e8 69 34 00 00       	call   8010540b <memmove>
    brelse(bp);
80101fa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fa5:	89 04 24             	mov    %eax,(%esp)
80101fa8:	e8 a3 e2 ff ff       	call   80100250 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fad:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fb0:	01 45 f4             	add    %eax,-0xc(%ebp)
80101fb3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fb6:	01 45 10             	add    %eax,0x10(%ebp)
80101fb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fbc:	01 45 0c             	add    %eax,0xc(%ebp)
80101fbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fc2:	3b 45 14             	cmp    0x14(%ebp),%eax
80101fc5:	0f 82 60 ff ff ff    	jb     80101f2b <readi+0xbf>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101fcb:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101fce:	c9                   	leave  
80101fcf:	c3                   	ret    

80101fd0 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fd6:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd9:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101fdd:	66 83 f8 03          	cmp    $0x3,%ax
80101fe1:	75 60                	jne    80102043 <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101fe3:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe6:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101fea:	66 85 c0             	test   %ax,%ax
80101fed:	78 20                	js     8010200f <writei+0x3f>
80101fef:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff2:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101ff6:	66 83 f8 09          	cmp    $0x9,%ax
80101ffa:	7f 13                	jg     8010200f <writei+0x3f>
80101ffc:	8b 45 08             	mov    0x8(%ebp),%eax
80101fff:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102003:	98                   	cwtl   
80102004:	8b 04 c5 04 2a 11 80 	mov    -0x7feed5fc(,%eax,8),%eax
8010200b:	85 c0                	test   %eax,%eax
8010200d:	75 0a                	jne    80102019 <writei+0x49>
      return -1;
8010200f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102014:	e9 44 01 00 00       	jmp    8010215d <writei+0x18d>
    return devsw[ip->major].write(ip, src, n);
80102019:	8b 45 08             	mov    0x8(%ebp),%eax
8010201c:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102020:	98                   	cwtl   
80102021:	8b 04 c5 04 2a 11 80 	mov    -0x7feed5fc(,%eax,8),%eax
80102028:	8b 55 14             	mov    0x14(%ebp),%edx
8010202b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010202f:	8b 55 0c             	mov    0xc(%ebp),%edx
80102032:	89 54 24 04          	mov    %edx,0x4(%esp)
80102036:	8b 55 08             	mov    0x8(%ebp),%edx
80102039:	89 14 24             	mov    %edx,(%esp)
8010203c:	ff d0                	call   *%eax
8010203e:	e9 1a 01 00 00       	jmp    8010215d <writei+0x18d>
  }

  if(off > ip->size || off + n < off)
80102043:	8b 45 08             	mov    0x8(%ebp),%eax
80102046:	8b 40 58             	mov    0x58(%eax),%eax
80102049:	3b 45 10             	cmp    0x10(%ebp),%eax
8010204c:	72 0d                	jb     8010205b <writei+0x8b>
8010204e:	8b 45 14             	mov    0x14(%ebp),%eax
80102051:	8b 55 10             	mov    0x10(%ebp),%edx
80102054:	01 d0                	add    %edx,%eax
80102056:	3b 45 10             	cmp    0x10(%ebp),%eax
80102059:	73 0a                	jae    80102065 <writei+0x95>
    return -1;
8010205b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102060:	e9 f8 00 00 00       	jmp    8010215d <writei+0x18d>
  if(off + n > MAXFILE*BSIZE)
80102065:	8b 45 14             	mov    0x14(%ebp),%eax
80102068:	8b 55 10             	mov    0x10(%ebp),%edx
8010206b:	01 d0                	add    %edx,%eax
8010206d:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102072:	76 0a                	jbe    8010207e <writei+0xae>
    return -1;
80102074:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102079:	e9 df 00 00 00       	jmp    8010215d <writei+0x18d>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010207e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102085:	e9 9f 00 00 00       	jmp    80102129 <writei+0x159>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010208a:	8b 45 10             	mov    0x10(%ebp),%eax
8010208d:	c1 e8 09             	shr    $0x9,%eax
80102090:	89 44 24 04          	mov    %eax,0x4(%esp)
80102094:	8b 45 08             	mov    0x8(%ebp),%eax
80102097:	89 04 24             	mov    %eax,(%esp)
8010209a:	e8 50 fb ff ff       	call   80101bef <bmap>
8010209f:	8b 55 08             	mov    0x8(%ebp),%edx
801020a2:	8b 12                	mov    (%edx),%edx
801020a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801020a8:	89 14 24             	mov    %edx,(%esp)
801020ab:	e8 1e e1 ff ff       	call   801001ce <bread>
801020b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801020b3:	8b 45 10             	mov    0x10(%ebp),%eax
801020b6:	25 ff 01 00 00       	and    $0x1ff,%eax
801020bb:	89 c2                	mov    %eax,%edx
801020bd:	b8 00 02 00 00       	mov    $0x200,%eax
801020c2:	29 d0                	sub    %edx,%eax
801020c4:	89 c2                	mov    %eax,%edx
801020c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020c9:	8b 4d 14             	mov    0x14(%ebp),%ecx
801020cc:	29 c1                	sub    %eax,%ecx
801020ce:	89 c8                	mov    %ecx,%eax
801020d0:	39 c2                	cmp    %eax,%edx
801020d2:	0f 46 c2             	cmovbe %edx,%eax
801020d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020d8:	8b 45 10             	mov    0x10(%ebp),%eax
801020db:	25 ff 01 00 00       	and    $0x1ff,%eax
801020e0:	8d 50 50             	lea    0x50(%eax),%edx
801020e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020e6:	01 d0                	add    %edx,%eax
801020e8:	8d 50 0c             	lea    0xc(%eax),%edx
801020eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020ee:	89 44 24 08          	mov    %eax,0x8(%esp)
801020f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801020f5:	89 44 24 04          	mov    %eax,0x4(%esp)
801020f9:	89 14 24             	mov    %edx,(%esp)
801020fc:	e8 0a 33 00 00       	call   8010540b <memmove>
    log_write(bp);
80102101:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102104:	89 04 24             	mov    %eax,(%esp)
80102107:	e8 03 17 00 00       	call   8010380f <log_write>
    brelse(bp);
8010210c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010210f:	89 04 24             	mov    %eax,(%esp)
80102112:	e8 39 e1 ff ff       	call   80100250 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102117:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010211a:	01 45 f4             	add    %eax,-0xc(%ebp)
8010211d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102120:	01 45 10             	add    %eax,0x10(%ebp)
80102123:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102126:	01 45 0c             	add    %eax,0xc(%ebp)
80102129:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010212c:	3b 45 14             	cmp    0x14(%ebp),%eax
8010212f:	0f 82 55 ff ff ff    	jb     8010208a <writei+0xba>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102135:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102139:	74 1f                	je     8010215a <writei+0x18a>
8010213b:	8b 45 08             	mov    0x8(%ebp),%eax
8010213e:	8b 40 58             	mov    0x58(%eax),%eax
80102141:	3b 45 10             	cmp    0x10(%ebp),%eax
80102144:	73 14                	jae    8010215a <writei+0x18a>
    ip->size = off;
80102146:	8b 45 08             	mov    0x8(%ebp),%eax
80102149:	8b 55 10             	mov    0x10(%ebp),%edx
8010214c:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
8010214f:	8b 45 08             	mov    0x8(%ebp),%eax
80102152:	89 04 24             	mov    %eax,(%esp)
80102155:	e8 c3 f6 ff ff       	call   8010181d <iupdate>
  }
  return n;
8010215a:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010215d:	c9                   	leave  
8010215e:	c3                   	ret    

8010215f <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010215f:	55                   	push   %ebp
80102160:	89 e5                	mov    %esp,%ebp
80102162:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80102165:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010216c:	00 
8010216d:	8b 45 0c             	mov    0xc(%ebp),%eax
80102170:	89 44 24 04          	mov    %eax,0x4(%esp)
80102174:	8b 45 08             	mov    0x8(%ebp),%eax
80102177:	89 04 24             	mov    %eax,(%esp)
8010217a:	e8 22 33 00 00       	call   801054a1 <strncmp>
}
8010217f:	c9                   	leave  
80102180:	c3                   	ret    

80102181 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102181:	55                   	push   %ebp
80102182:	89 e5                	mov    %esp,%ebp
80102184:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102187:	8b 45 08             	mov    0x8(%ebp),%eax
8010218a:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010218e:	66 83 f8 01          	cmp    $0x1,%ax
80102192:	74 0c                	je     801021a0 <dirlookup+0x1f>
    panic("dirlookup not DIR");
80102194:	c7 04 24 a5 8a 10 80 	movl   $0x80108aa5,(%esp)
8010219b:	e8 f8 e3 ff ff       	call   80100598 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801021a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021a7:	e9 88 00 00 00       	jmp    80102234 <dirlookup+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021ac:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801021b3:	00 
801021b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021b7:	89 44 24 08          	mov    %eax,0x8(%esp)
801021bb:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021be:	89 44 24 04          	mov    %eax,0x4(%esp)
801021c2:	8b 45 08             	mov    0x8(%ebp),%eax
801021c5:	89 04 24             	mov    %eax,(%esp)
801021c8:	e8 9f fc ff ff       	call   80101e6c <readi>
801021cd:	83 f8 10             	cmp    $0x10,%eax
801021d0:	74 0c                	je     801021de <dirlookup+0x5d>
      panic("dirlink read");
801021d2:	c7 04 24 b7 8a 10 80 	movl   $0x80108ab7,(%esp)
801021d9:	e8 ba e3 ff ff       	call   80100598 <panic>
    if(de.inum == 0)
801021de:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021e2:	66 85 c0             	test   %ax,%ax
801021e5:	75 02                	jne    801021e9 <dirlookup+0x68>
      continue;
801021e7:	eb 47                	jmp    80102230 <dirlookup+0xaf>
    if(namecmp(name, de.name) == 0){
801021e9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021ec:	83 c0 02             	add    $0x2,%eax
801021ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801021f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801021f6:	89 04 24             	mov    %eax,(%esp)
801021f9:	e8 61 ff ff ff       	call   8010215f <namecmp>
801021fe:	85 c0                	test   %eax,%eax
80102200:	75 2e                	jne    80102230 <dirlookup+0xaf>
      // entry matches path element
      if(poff)
80102202:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102206:	74 08                	je     80102210 <dirlookup+0x8f>
        *poff = off;
80102208:	8b 45 10             	mov    0x10(%ebp),%eax
8010220b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010220e:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102210:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102214:	0f b7 c0             	movzwl %ax,%eax
80102217:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010221a:	8b 45 08             	mov    0x8(%ebp),%eax
8010221d:	8b 00                	mov    (%eax),%eax
8010221f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102222:	89 54 24 04          	mov    %edx,0x4(%esp)
80102226:	89 04 24             	mov    %eax,(%esp)
80102229:	e8 ad f6 ff ff       	call   801018db <iget>
8010222e:	eb 18                	jmp    80102248 <dirlookup+0xc7>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102230:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102234:	8b 45 08             	mov    0x8(%ebp),%eax
80102237:	8b 40 58             	mov    0x58(%eax),%eax
8010223a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010223d:	0f 87 69 ff ff ff    	ja     801021ac <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102243:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102248:	c9                   	leave  
80102249:	c3                   	ret    

8010224a <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010224a:	55                   	push   %ebp
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102250:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102257:	00 
80102258:	8b 45 0c             	mov    0xc(%ebp),%eax
8010225b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010225f:	8b 45 08             	mov    0x8(%ebp),%eax
80102262:	89 04 24             	mov    %eax,(%esp)
80102265:	e8 17 ff ff ff       	call   80102181 <dirlookup>
8010226a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010226d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102271:	74 15                	je     80102288 <dirlink+0x3e>
    iput(ip);
80102273:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102276:	89 04 24             	mov    %eax,(%esp)
80102279:	e8 bf f8 ff ff       	call   80101b3d <iput>
    return -1;
8010227e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102283:	e9 b7 00 00 00       	jmp    8010233f <dirlink+0xf5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102288:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010228f:	eb 46                	jmp    801022d7 <dirlink+0x8d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102291:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102294:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010229b:	00 
8010229c:	89 44 24 08          	mov    %eax,0x8(%esp)
801022a0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801022a7:	8b 45 08             	mov    0x8(%ebp),%eax
801022aa:	89 04 24             	mov    %eax,(%esp)
801022ad:	e8 ba fb ff ff       	call   80101e6c <readi>
801022b2:	83 f8 10             	cmp    $0x10,%eax
801022b5:	74 0c                	je     801022c3 <dirlink+0x79>
      panic("dirlink read");
801022b7:	c7 04 24 b7 8a 10 80 	movl   $0x80108ab7,(%esp)
801022be:	e8 d5 e2 ff ff       	call   80100598 <panic>
    if(de.inum == 0)
801022c3:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801022c7:	66 85 c0             	test   %ax,%ax
801022ca:	75 02                	jne    801022ce <dirlink+0x84>
      break;
801022cc:	eb 16                	jmp    801022e4 <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d1:	83 c0 10             	add    $0x10,%eax
801022d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801022da:	8b 45 08             	mov    0x8(%ebp),%eax
801022dd:	8b 40 58             	mov    0x58(%eax),%eax
801022e0:	39 c2                	cmp    %eax,%edx
801022e2:	72 ad                	jb     80102291 <dirlink+0x47>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
801022e4:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801022eb:	00 
801022ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801022ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801022f3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022f6:	83 c0 02             	add    $0x2,%eax
801022f9:	89 04 24             	mov    %eax,(%esp)
801022fc:	e8 f6 31 00 00       	call   801054f7 <strncpy>
  de.inum = inum;
80102301:	8b 45 10             	mov    0x10(%ebp),%eax
80102304:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102308:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010230b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102312:	00 
80102313:	89 44 24 08          	mov    %eax,0x8(%esp)
80102317:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010231a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010231e:	8b 45 08             	mov    0x8(%ebp),%eax
80102321:	89 04 24             	mov    %eax,(%esp)
80102324:	e8 a7 fc ff ff       	call   80101fd0 <writei>
80102329:	83 f8 10             	cmp    $0x10,%eax
8010232c:	74 0c                	je     8010233a <dirlink+0xf0>
    panic("dirlink");
8010232e:	c7 04 24 c4 8a 10 80 	movl   $0x80108ac4,(%esp)
80102335:	e8 5e e2 ff ff       	call   80100598 <panic>

  return 0;
8010233a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010233f:	c9                   	leave  
80102340:	c3                   	ret    

80102341 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102341:	55                   	push   %ebp
80102342:	89 e5                	mov    %esp,%ebp
80102344:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
80102347:	eb 04                	jmp    8010234d <skipelem+0xc>
    path++;
80102349:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010234d:	8b 45 08             	mov    0x8(%ebp),%eax
80102350:	0f b6 00             	movzbl (%eax),%eax
80102353:	3c 2f                	cmp    $0x2f,%al
80102355:	74 f2                	je     80102349 <skipelem+0x8>
    path++;
  if(*path == 0)
80102357:	8b 45 08             	mov    0x8(%ebp),%eax
8010235a:	0f b6 00             	movzbl (%eax),%eax
8010235d:	84 c0                	test   %al,%al
8010235f:	75 0a                	jne    8010236b <skipelem+0x2a>
    return 0;
80102361:	b8 00 00 00 00       	mov    $0x0,%eax
80102366:	e9 86 00 00 00       	jmp    801023f1 <skipelem+0xb0>
  s = path;
8010236b:	8b 45 08             	mov    0x8(%ebp),%eax
8010236e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102371:	eb 04                	jmp    80102377 <skipelem+0x36>
    path++;
80102373:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102377:	8b 45 08             	mov    0x8(%ebp),%eax
8010237a:	0f b6 00             	movzbl (%eax),%eax
8010237d:	3c 2f                	cmp    $0x2f,%al
8010237f:	74 0a                	je     8010238b <skipelem+0x4a>
80102381:	8b 45 08             	mov    0x8(%ebp),%eax
80102384:	0f b6 00             	movzbl (%eax),%eax
80102387:	84 c0                	test   %al,%al
80102389:	75 e8                	jne    80102373 <skipelem+0x32>
    path++;
  len = path - s;
8010238b:	8b 55 08             	mov    0x8(%ebp),%edx
8010238e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102391:	29 c2                	sub    %eax,%edx
80102393:	89 d0                	mov    %edx,%eax
80102395:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102398:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010239c:	7e 1c                	jle    801023ba <skipelem+0x79>
    memmove(name, s, DIRSIZ);
8010239e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801023a5:	00 
801023a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801023ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801023b0:	89 04 24             	mov    %eax,(%esp)
801023b3:	e8 53 30 00 00       	call   8010540b <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801023b8:	eb 2a                	jmp    801023e4 <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
801023ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023bd:	89 44 24 08          	mov    %eax,0x8(%esp)
801023c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801023c8:	8b 45 0c             	mov    0xc(%ebp),%eax
801023cb:	89 04 24             	mov    %eax,(%esp)
801023ce:	e8 38 30 00 00       	call   8010540b <memmove>
    name[len] = 0;
801023d3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801023d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801023d9:	01 d0                	add    %edx,%eax
801023db:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801023de:	eb 04                	jmp    801023e4 <skipelem+0xa3>
    path++;
801023e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801023e4:	8b 45 08             	mov    0x8(%ebp),%eax
801023e7:	0f b6 00             	movzbl (%eax),%eax
801023ea:	3c 2f                	cmp    $0x2f,%al
801023ec:	74 f2                	je     801023e0 <skipelem+0x9f>
    path++;
  return path;
801023ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
801023f1:	c9                   	leave  
801023f2:	c3                   	ret    

801023f3 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801023f3:	55                   	push   %ebp
801023f4:	89 e5                	mov    %esp,%ebp
801023f6:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
801023f9:	8b 45 08             	mov    0x8(%ebp),%eax
801023fc:	0f b6 00             	movzbl (%eax),%eax
801023ff:	3c 2f                	cmp    $0x2f,%al
80102401:	75 1c                	jne    8010241f <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
80102403:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010240a:	00 
8010240b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102412:	e8 c4 f4 ff ff       	call   801018db <iget>
80102417:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010241a:	e9 af 00 00 00       	jmp    801024ce <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
8010241f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102425:	8b 40 6c             	mov    0x6c(%eax),%eax
80102428:	89 04 24             	mov    %eax,(%esp)
8010242b:	e8 80 f5 ff ff       	call   801019b0 <idup>
80102430:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102433:	e9 96 00 00 00       	jmp    801024ce <namex+0xdb>
    ilock(ip);
80102438:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010243b:	89 04 24             	mov    %eax,(%esp)
8010243e:	e8 9f f5 ff ff       	call   801019e2 <ilock>
    if(ip->type != T_DIR){
80102443:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102446:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010244a:	66 83 f8 01          	cmp    $0x1,%ax
8010244e:	74 15                	je     80102465 <namex+0x72>
      iunlockput(ip);
80102450:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102453:	89 04 24             	mov    %eax,(%esp)
80102456:	e8 76 f7 ff ff       	call   80101bd1 <iunlockput>
      return 0;
8010245b:	b8 00 00 00 00       	mov    $0x0,%eax
80102460:	e9 a3 00 00 00       	jmp    80102508 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
80102465:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102469:	74 1d                	je     80102488 <namex+0x95>
8010246b:	8b 45 08             	mov    0x8(%ebp),%eax
8010246e:	0f b6 00             	movzbl (%eax),%eax
80102471:	84 c0                	test   %al,%al
80102473:	75 13                	jne    80102488 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
80102475:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102478:	89 04 24             	mov    %eax,(%esp)
8010247b:	e8 79 f6 ff ff       	call   80101af9 <iunlock>
      return ip;
80102480:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102483:	e9 80 00 00 00       	jmp    80102508 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102488:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010248f:	00 
80102490:	8b 45 10             	mov    0x10(%ebp),%eax
80102493:	89 44 24 04          	mov    %eax,0x4(%esp)
80102497:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010249a:	89 04 24             	mov    %eax,(%esp)
8010249d:	e8 df fc ff ff       	call   80102181 <dirlookup>
801024a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801024a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801024a9:	75 12                	jne    801024bd <namex+0xca>
      iunlockput(ip);
801024ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024ae:	89 04 24             	mov    %eax,(%esp)
801024b1:	e8 1b f7 ff ff       	call   80101bd1 <iunlockput>
      return 0;
801024b6:	b8 00 00 00 00       	mov    $0x0,%eax
801024bb:	eb 4b                	jmp    80102508 <namex+0x115>
    }
    iunlockput(ip);
801024bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024c0:	89 04 24             	mov    %eax,(%esp)
801024c3:	e8 09 f7 ff ff       	call   80101bd1 <iunlockput>
    ip = next;
801024c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801024ce:	8b 45 10             	mov    0x10(%ebp),%eax
801024d1:	89 44 24 04          	mov    %eax,0x4(%esp)
801024d5:	8b 45 08             	mov    0x8(%ebp),%eax
801024d8:	89 04 24             	mov    %eax,(%esp)
801024db:	e8 61 fe ff ff       	call   80102341 <skipelem>
801024e0:	89 45 08             	mov    %eax,0x8(%ebp)
801024e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801024e7:	0f 85 4b ff ff ff    	jne    80102438 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801024ed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024f1:	74 12                	je     80102505 <namex+0x112>
    iput(ip);
801024f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024f6:	89 04 24             	mov    %eax,(%esp)
801024f9:	e8 3f f6 ff ff       	call   80101b3d <iput>
    return 0;
801024fe:	b8 00 00 00 00       	mov    $0x0,%eax
80102503:	eb 03                	jmp    80102508 <namex+0x115>
  }
  return ip;
80102505:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102508:	c9                   	leave  
80102509:	c3                   	ret    

8010250a <namei>:

struct inode*
namei(char *path)
{
8010250a:	55                   	push   %ebp
8010250b:	89 e5                	mov    %esp,%ebp
8010250d:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102510:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102513:	89 44 24 08          	mov    %eax,0x8(%esp)
80102517:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010251e:	00 
8010251f:	8b 45 08             	mov    0x8(%ebp),%eax
80102522:	89 04 24             	mov    %eax,(%esp)
80102525:	e8 c9 fe ff ff       	call   801023f3 <namex>
}
8010252a:	c9                   	leave  
8010252b:	c3                   	ret    

8010252c <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
8010252c:	55                   	push   %ebp
8010252d:	89 e5                	mov    %esp,%ebp
8010252f:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
80102532:	8b 45 0c             	mov    0xc(%ebp),%eax
80102535:	89 44 24 08          	mov    %eax,0x8(%esp)
80102539:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102540:	00 
80102541:	8b 45 08             	mov    0x8(%ebp),%eax
80102544:	89 04 24             	mov    %eax,(%esp)
80102547:	e8 a7 fe ff ff       	call   801023f3 <namex>
}
8010254c:	c9                   	leave  
8010254d:	c3                   	ret    

8010254e <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010254e:	55                   	push   %ebp
8010254f:	89 e5                	mov    %esp,%ebp
80102551:	83 ec 14             	sub    $0x14,%esp
80102554:	8b 45 08             	mov    0x8(%ebp),%eax
80102557:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010255b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010255f:	89 c2                	mov    %eax,%edx
80102561:	ec                   	in     (%dx),%al
80102562:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102565:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102569:	c9                   	leave  
8010256a:	c3                   	ret    

8010256b <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
8010256b:	55                   	push   %ebp
8010256c:	89 e5                	mov    %esp,%ebp
8010256e:	57                   	push   %edi
8010256f:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102570:	8b 55 08             	mov    0x8(%ebp),%edx
80102573:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102576:	8b 45 10             	mov    0x10(%ebp),%eax
80102579:	89 cb                	mov    %ecx,%ebx
8010257b:	89 df                	mov    %ebx,%edi
8010257d:	89 c1                	mov    %eax,%ecx
8010257f:	fc                   	cld    
80102580:	f3 6d                	rep insl (%dx),%es:(%edi)
80102582:	89 c8                	mov    %ecx,%eax
80102584:	89 fb                	mov    %edi,%ebx
80102586:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102589:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010258c:	5b                   	pop    %ebx
8010258d:	5f                   	pop    %edi
8010258e:	5d                   	pop    %ebp
8010258f:	c3                   	ret    

80102590 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	83 ec 08             	sub    $0x8,%esp
80102596:	8b 55 08             	mov    0x8(%ebp),%edx
80102599:	8b 45 0c             	mov    0xc(%ebp),%eax
8010259c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801025a0:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025a3:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801025a7:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801025ab:	ee                   	out    %al,(%dx)
}
801025ac:	c9                   	leave  
801025ad:	c3                   	ret    

801025ae <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801025ae:	55                   	push   %ebp
801025af:	89 e5                	mov    %esp,%ebp
801025b1:	56                   	push   %esi
801025b2:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025b3:	8b 55 08             	mov    0x8(%ebp),%edx
801025b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025b9:	8b 45 10             	mov    0x10(%ebp),%eax
801025bc:	89 cb                	mov    %ecx,%ebx
801025be:	89 de                	mov    %ebx,%esi
801025c0:	89 c1                	mov    %eax,%ecx
801025c2:	fc                   	cld    
801025c3:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025c5:	89 c8                	mov    %ecx,%eax
801025c7:	89 f3                	mov    %esi,%ebx
801025c9:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025cc:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801025cf:	5b                   	pop    %ebx
801025d0:	5e                   	pop    %esi
801025d1:	5d                   	pop    %ebp
801025d2:	c3                   	ret    

801025d3 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801025d3:	55                   	push   %ebp
801025d4:	89 e5                	mov    %esp,%ebp
801025d6:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025d9:	90                   	nop
801025da:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801025e1:	e8 68 ff ff ff       	call   8010254e <inb>
801025e6:	0f b6 c0             	movzbl %al,%eax
801025e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
801025ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025ef:	25 c0 00 00 00       	and    $0xc0,%eax
801025f4:	83 f8 40             	cmp    $0x40,%eax
801025f7:	75 e1                	jne    801025da <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801025f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025fd:	74 11                	je     80102610 <idewait+0x3d>
801025ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102602:	83 e0 21             	and    $0x21,%eax
80102605:	85 c0                	test   %eax,%eax
80102607:	74 07                	je     80102610 <idewait+0x3d>
    return -1;
80102609:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010260e:	eb 05                	jmp    80102615 <idewait+0x42>
  return 0;
80102610:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102615:	c9                   	leave  
80102616:	c3                   	ret    

80102617 <ideinit>:

void
ideinit(void)
{
80102617:	55                   	push   %ebp
80102618:	89 e5                	mov    %esp,%ebp
8010261a:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
8010261d:	c7 44 24 04 cc 8a 10 	movl   $0x80108acc,0x4(%esp)
80102624:	80 
80102625:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010262c:	e8 7f 2a 00 00       	call   801050b0 <initlock>
  picenable(IRQ_IDE);
80102631:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102638:	e8 7e 18 00 00       	call   80103ebb <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010263d:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80102642:	83 e8 01             	sub    $0x1,%eax
80102645:	89 44 24 04          	mov    %eax,0x4(%esp)
80102649:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102650:	e8 7b 04 00 00       	call   80102ad0 <ioapicenable>
  idewait(0);
80102655:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010265c:	e8 72 ff ff ff       	call   801025d3 <idewait>

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102661:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102668:	00 
80102669:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102670:	e8 1b ff ff ff       	call   80102590 <outb>
  for(i=0; i<1000; i++){
80102675:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010267c:	eb 20                	jmp    8010269e <ideinit+0x87>
    if(inb(0x1f7) != 0){
8010267e:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102685:	e8 c4 fe ff ff       	call   8010254e <inb>
8010268a:	84 c0                	test   %al,%al
8010268c:	74 0c                	je     8010269a <ideinit+0x83>
      havedisk1 = 1;
8010268e:	c7 05 38 c6 10 80 01 	movl   $0x1,0x8010c638
80102695:	00 00 00 
      break;
80102698:	eb 0d                	jmp    801026a7 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010269a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010269e:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801026a5:	7e d7                	jle    8010267e <ideinit+0x67>
      break;
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026a7:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
801026ae:	00 
801026af:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801026b6:	e8 d5 fe ff ff       	call   80102590 <outb>
}
801026bb:	c9                   	leave  
801026bc:	c3                   	ret    

801026bd <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026bd:	55                   	push   %ebp
801026be:	89 e5                	mov    %esp,%ebp
801026c0:	83 ec 28             	sub    $0x28,%esp
  if(b == 0)
801026c3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026c7:	75 0c                	jne    801026d5 <idestart+0x18>
    panic("idestart");
801026c9:	c7 04 24 d0 8a 10 80 	movl   $0x80108ad0,(%esp)
801026d0:	e8 c3 de ff ff       	call   80100598 <panic>
  if(b->blockno >= FSSIZE)
801026d5:	8b 45 08             	mov    0x8(%ebp),%eax
801026d8:	8b 40 08             	mov    0x8(%eax),%eax
801026db:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801026e0:	76 0c                	jbe    801026ee <idestart+0x31>
    panic("incorrect blockno");
801026e2:	c7 04 24 d9 8a 10 80 	movl   $0x80108ad9,(%esp)
801026e9:	e8 aa de ff ff       	call   80100598 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
801026ee:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
801026f5:	8b 45 08             	mov    0x8(%ebp),%eax
801026f8:	8b 50 08             	mov    0x8(%eax),%edx
801026fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026fe:	0f af c2             	imul   %edx,%eax
80102701:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80102704:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102708:	75 07                	jne    80102711 <idestart+0x54>
8010270a:	b8 20 00 00 00       	mov    $0x20,%eax
8010270f:	eb 05                	jmp    80102716 <idestart+0x59>
80102711:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102716:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
80102719:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
8010271d:	75 07                	jne    80102726 <idestart+0x69>
8010271f:	b8 30 00 00 00       	mov    $0x30,%eax
80102724:	eb 05                	jmp    8010272b <idestart+0x6e>
80102726:	b8 c5 00 00 00       	mov    $0xc5,%eax
8010272b:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
8010272e:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102732:	7e 0c                	jle    80102740 <idestart+0x83>
80102734:	c7 04 24 d0 8a 10 80 	movl   $0x80108ad0,(%esp)
8010273b:	e8 58 de ff ff       	call   80100598 <panic>

  idewait(0);
80102740:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102747:	e8 87 fe ff ff       	call   801025d3 <idewait>
  outb(0x3f6, 0);  // generate interrupt
8010274c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102753:	00 
80102754:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
8010275b:	e8 30 fe ff ff       	call   80102590 <outb>
  outb(0x1f2, sector_per_block);  // number of sectors
80102760:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102763:	0f b6 c0             	movzbl %al,%eax
80102766:	89 44 24 04          	mov    %eax,0x4(%esp)
8010276a:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
80102771:	e8 1a fe ff ff       	call   80102590 <outb>
  outb(0x1f3, sector & 0xff);
80102776:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102779:	0f b6 c0             	movzbl %al,%eax
8010277c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102780:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102787:	e8 04 fe ff ff       	call   80102590 <outb>
  outb(0x1f4, (sector >> 8) & 0xff);
8010278c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010278f:	c1 f8 08             	sar    $0x8,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	89 44 24 04          	mov    %eax,0x4(%esp)
80102799:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
801027a0:	e8 eb fd ff ff       	call   80102590 <outb>
  outb(0x1f5, (sector >> 16) & 0xff);
801027a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027a8:	c1 f8 10             	sar    $0x10,%eax
801027ab:	0f b6 c0             	movzbl %al,%eax
801027ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801027b2:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
801027b9:	e8 d2 fd ff ff       	call   80102590 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801027be:	8b 45 08             	mov    0x8(%ebp),%eax
801027c1:	8b 40 04             	mov    0x4(%eax),%eax
801027c4:	83 e0 01             	and    $0x1,%eax
801027c7:	c1 e0 04             	shl    $0x4,%eax
801027ca:	89 c2                	mov    %eax,%edx
801027cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027cf:	c1 f8 18             	sar    $0x18,%eax
801027d2:	83 e0 0f             	and    $0xf,%eax
801027d5:	09 d0                	or     %edx,%eax
801027d7:	83 c8 e0             	or     $0xffffffe0,%eax
801027da:	0f b6 c0             	movzbl %al,%eax
801027dd:	89 44 24 04          	mov    %eax,0x4(%esp)
801027e1:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801027e8:	e8 a3 fd ff ff       	call   80102590 <outb>
  if(b->flags & B_DIRTY){
801027ed:	8b 45 08             	mov    0x8(%ebp),%eax
801027f0:	8b 00                	mov    (%eax),%eax
801027f2:	83 e0 04             	and    $0x4,%eax
801027f5:	85 c0                	test   %eax,%eax
801027f7:	74 36                	je     8010282f <idestart+0x172>
    outb(0x1f7, write_cmd);
801027f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801027fc:	0f b6 c0             	movzbl %al,%eax
801027ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80102803:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
8010280a:	e8 81 fd ff ff       	call   80102590 <outb>
    outsl(0x1f0, b->data, BSIZE/4);
8010280f:	8b 45 08             	mov    0x8(%ebp),%eax
80102812:	83 c0 5c             	add    $0x5c,%eax
80102815:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
8010281c:	00 
8010281d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102821:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102828:	e8 81 fd ff ff       	call   801025ae <outsl>
8010282d:	eb 16                	jmp    80102845 <idestart+0x188>
  } else {
    outb(0x1f7, read_cmd);
8010282f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102832:	0f b6 c0             	movzbl %al,%eax
80102835:	89 44 24 04          	mov    %eax,0x4(%esp)
80102839:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102840:	e8 4b fd ff ff       	call   80102590 <outb>
  }
}
80102845:	c9                   	leave  
80102846:	c3                   	ret    

80102847 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102847:	55                   	push   %ebp
80102848:	89 e5                	mov    %esp,%ebp
8010284a:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010284d:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
80102854:	e8 79 28 00 00       	call   801050d2 <acquire>
  if((b = idequeue) == 0){
80102859:	a1 34 c6 10 80       	mov    0x8010c634,%eax
8010285e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102861:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102865:	75 11                	jne    80102878 <ideintr+0x31>
    release(&idelock);
80102867:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010286e:	e8 cb 28 00 00       	call   8010513e <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102873:	e9 90 00 00 00       	jmp    80102908 <ideintr+0xc1>
  }
  idequeue = b->qnext;
80102878:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010287b:	8b 40 58             	mov    0x58(%eax),%eax
8010287e:	a3 34 c6 10 80       	mov    %eax,0x8010c634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102883:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102886:	8b 00                	mov    (%eax),%eax
80102888:	83 e0 04             	and    $0x4,%eax
8010288b:	85 c0                	test   %eax,%eax
8010288d:	75 2e                	jne    801028bd <ideintr+0x76>
8010288f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102896:	e8 38 fd ff ff       	call   801025d3 <idewait>
8010289b:	85 c0                	test   %eax,%eax
8010289d:	78 1e                	js     801028bd <ideintr+0x76>
    insl(0x1f0, b->data, BSIZE/4);
8010289f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028a2:	83 c0 5c             	add    $0x5c,%eax
801028a5:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801028ac:	00 
801028ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801028b1:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801028b8:	e8 ae fc ff ff       	call   8010256b <insl>

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801028bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c0:	8b 00                	mov    (%eax),%eax
801028c2:	83 c8 02             	or     $0x2,%eax
801028c5:	89 c2                	mov    %eax,%edx
801028c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028ca:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801028cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028cf:	8b 00                	mov    (%eax),%eax
801028d1:	83 e0 fb             	and    $0xfffffffb,%eax
801028d4:	89 c2                	mov    %eax,%edx
801028d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028d9:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801028db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028de:	89 04 24             	mov    %eax,(%esp)
801028e1:	e8 b8 24 00 00       	call   80104d9e <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801028e6:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801028eb:	85 c0                	test   %eax,%eax
801028ed:	74 0d                	je     801028fc <ideintr+0xb5>
    idestart(idequeue);
801028ef:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801028f4:	89 04 24             	mov    %eax,(%esp)
801028f7:	e8 c1 fd ff ff       	call   801026bd <idestart>

  release(&idelock);
801028fc:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
80102903:	e8 36 28 00 00       	call   8010513e <release>
}
80102908:	c9                   	leave  
80102909:	c3                   	ret    

8010290a <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
8010290a:	55                   	push   %ebp
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102910:	8b 45 08             	mov    0x8(%ebp),%eax
80102913:	83 c0 0c             	add    $0xc,%eax
80102916:	89 04 24             	mov    %eax,(%esp)
80102919:	e8 23 27 00 00       	call   80105041 <holdingsleep>
8010291e:	85 c0                	test   %eax,%eax
80102920:	75 0c                	jne    8010292e <iderw+0x24>
    panic("iderw: buf not locked");
80102922:	c7 04 24 eb 8a 10 80 	movl   $0x80108aeb,(%esp)
80102929:	e8 6a dc ff ff       	call   80100598 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010292e:	8b 45 08             	mov    0x8(%ebp),%eax
80102931:	8b 00                	mov    (%eax),%eax
80102933:	83 e0 06             	and    $0x6,%eax
80102936:	83 f8 02             	cmp    $0x2,%eax
80102939:	75 0c                	jne    80102947 <iderw+0x3d>
    panic("iderw: nothing to do");
8010293b:	c7 04 24 01 8b 10 80 	movl   $0x80108b01,(%esp)
80102942:	e8 51 dc ff ff       	call   80100598 <panic>
  if(b->dev != 0 && !havedisk1)
80102947:	8b 45 08             	mov    0x8(%ebp),%eax
8010294a:	8b 40 04             	mov    0x4(%eax),%eax
8010294d:	85 c0                	test   %eax,%eax
8010294f:	74 15                	je     80102966 <iderw+0x5c>
80102951:	a1 38 c6 10 80       	mov    0x8010c638,%eax
80102956:	85 c0                	test   %eax,%eax
80102958:	75 0c                	jne    80102966 <iderw+0x5c>
    panic("iderw: ide disk 1 not present");
8010295a:	c7 04 24 16 8b 10 80 	movl   $0x80108b16,(%esp)
80102961:	e8 32 dc ff ff       	call   80100598 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102966:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010296d:	e8 60 27 00 00       	call   801050d2 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102972:	8b 45 08             	mov    0x8(%ebp),%eax
80102975:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010297c:	c7 45 f4 34 c6 10 80 	movl   $0x8010c634,-0xc(%ebp)
80102983:	eb 0b                	jmp    80102990 <iderw+0x86>
80102985:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102988:	8b 00                	mov    (%eax),%eax
8010298a:	83 c0 58             	add    $0x58,%eax
8010298d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102990:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102993:	8b 00                	mov    (%eax),%eax
80102995:	85 c0                	test   %eax,%eax
80102997:	75 ec                	jne    80102985 <iderw+0x7b>
    ;
  *pp = b;
80102999:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010299c:	8b 55 08             	mov    0x8(%ebp),%edx
8010299f:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801029a1:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801029a6:	3b 45 08             	cmp    0x8(%ebp),%eax
801029a9:	75 0d                	jne    801029b8 <iderw+0xae>
    idestart(b);
801029ab:	8b 45 08             	mov    0x8(%ebp),%eax
801029ae:	89 04 24             	mov    %eax,(%esp)
801029b1:	e8 07 fd ff ff       	call   801026bd <idestart>

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029b6:	eb 15                	jmp    801029cd <iderw+0xc3>
801029b8:	eb 13                	jmp    801029cd <iderw+0xc3>
    sleep(b, &idelock);
801029ba:	c7 44 24 04 00 c6 10 	movl   $0x8010c600,0x4(%esp)
801029c1:	80 
801029c2:	8b 45 08             	mov    0x8(%ebp),%eax
801029c5:	89 04 24             	mov    %eax,(%esp)
801029c8:	e8 e6 22 00 00       	call   80104cb3 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029cd:	8b 45 08             	mov    0x8(%ebp),%eax
801029d0:	8b 00                	mov    (%eax),%eax
801029d2:	83 e0 06             	and    $0x6,%eax
801029d5:	83 f8 02             	cmp    $0x2,%eax
801029d8:	75 e0                	jne    801029ba <iderw+0xb0>
    sleep(b, &idelock);
  }

  release(&idelock);
801029da:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
801029e1:	e8 58 27 00 00       	call   8010513e <release>
}
801029e6:	c9                   	leave  
801029e7:	c3                   	ret    

801029e8 <ioapicread>:
801029e8:	55                   	push   %ebp
801029e9:	89 e5                	mov    %esp,%ebp
801029eb:	a1 d4 46 11 80       	mov    0x801146d4,%eax
801029f0:	8b 55 08             	mov    0x8(%ebp),%edx
801029f3:	89 10                	mov    %edx,(%eax)
801029f5:	a1 d4 46 11 80       	mov    0x801146d4,%eax
801029fa:	8b 40 10             	mov    0x10(%eax),%eax
801029fd:	5d                   	pop    %ebp
801029fe:	c3                   	ret    

801029ff <ioapicwrite>:
801029ff:	55                   	push   %ebp
80102a00:	89 e5                	mov    %esp,%ebp
80102a02:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102a07:	8b 55 08             	mov    0x8(%ebp),%edx
80102a0a:	89 10                	mov    %edx,(%eax)
80102a0c:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102a11:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a14:	89 50 10             	mov    %edx,0x10(%eax)
80102a17:	90                   	nop
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    

80102a1a <ioapicinit>:
80102a1a:	55                   	push   %ebp
80102a1b:	89 e5                	mov    %esp,%ebp
80102a1d:	83 ec 18             	sub    $0x18,%esp
80102a20:	a1 04 48 11 80       	mov    0x80114804,%eax
80102a25:	85 c0                	test   %eax,%eax
80102a27:	0f 84 a0 00 00 00    	je     80102acd <ioapicinit+0xb3>
80102a2d:	c7 05 d4 46 11 80 00 	movl   $0xfec00000,0x801146d4
80102a34:	00 c0 fe 
80102a37:	6a 01                	push   $0x1
80102a39:	e8 aa ff ff ff       	call   801029e8 <ioapicread>
80102a3e:	83 c4 04             	add    $0x4,%esp
80102a41:	c1 e8 10             	shr    $0x10,%eax
80102a44:	25 ff 00 00 00       	and    $0xff,%eax
80102a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102a4c:	6a 00                	push   $0x0
80102a4e:	e8 95 ff ff ff       	call   801029e8 <ioapicread>
80102a53:	83 c4 04             	add    $0x4,%esp
80102a56:	c1 e8 18             	shr    $0x18,%eax
80102a59:	89 45 ec             	mov    %eax,-0x14(%ebp)
80102a5c:	0f b6 05 00 48 11 80 	movzbl 0x80114800,%eax
80102a63:	0f b6 c0             	movzbl %al,%eax
80102a66:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102a69:	74 10                	je     80102a7b <ioapicinit+0x61>
80102a6b:	83 ec 0c             	sub    $0xc,%esp
80102a6e:	68 34 8b 10 80       	push   $0x80108b34
80102a73:	e8 86 d9 ff ff       	call   801003fe <cprintf>
80102a78:	83 c4 10             	add    $0x10,%esp
80102a7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a82:	eb 3f                	jmp    80102ac3 <ioapicinit+0xa9>
80102a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a87:	83 c0 20             	add    $0x20,%eax
80102a8a:	0d 00 00 01 00       	or     $0x10000,%eax
80102a8f:	89 c2                	mov    %eax,%edx
80102a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a94:	83 c0 08             	add    $0x8,%eax
80102a97:	01 c0                	add    %eax,%eax
80102a99:	83 ec 08             	sub    $0x8,%esp
80102a9c:	52                   	push   %edx
80102a9d:	50                   	push   %eax
80102a9e:	e8 5c ff ff ff       	call   801029ff <ioapicwrite>
80102aa3:	83 c4 10             	add    $0x10,%esp
80102aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aa9:	83 c0 08             	add    $0x8,%eax
80102aac:	01 c0                	add    %eax,%eax
80102aae:	83 c0 01             	add    $0x1,%eax
80102ab1:	83 ec 08             	sub    $0x8,%esp
80102ab4:	6a 00                	push   $0x0
80102ab6:	50                   	push   %eax
80102ab7:	e8 43 ff ff ff       	call   801029ff <ioapicwrite>
80102abc:	83 c4 10             	add    $0x10,%esp
80102abf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102ac3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ac6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102ac9:	7e b9                	jle    80102a84 <ioapicinit+0x6a>
80102acb:	eb 01                	jmp    80102ace <ioapicinit+0xb4>
80102acd:	90                   	nop
80102ace:	c9                   	leave  
80102acf:	c3                   	ret    

80102ad0 <ioapicenable>:
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	a1 04 48 11 80       	mov    0x80114804,%eax
80102ad8:	85 c0                	test   %eax,%eax
80102ada:	74 39                	je     80102b15 <ioapicenable+0x45>
80102adc:	8b 45 08             	mov    0x8(%ebp),%eax
80102adf:	83 c0 20             	add    $0x20,%eax
80102ae2:	89 c2                	mov    %eax,%edx
80102ae4:	8b 45 08             	mov    0x8(%ebp),%eax
80102ae7:	83 c0 08             	add    $0x8,%eax
80102aea:	01 c0                	add    %eax,%eax
80102aec:	52                   	push   %edx
80102aed:	50                   	push   %eax
80102aee:	e8 0c ff ff ff       	call   801029ff <ioapicwrite>
80102af3:	83 c4 08             	add    $0x8,%esp
80102af6:	8b 45 0c             	mov    0xc(%ebp),%eax
80102af9:	c1 e0 18             	shl    $0x18,%eax
80102afc:	89 c2                	mov    %eax,%edx
80102afe:	8b 45 08             	mov    0x8(%ebp),%eax
80102b01:	83 c0 08             	add    $0x8,%eax
80102b04:	01 c0                	add    %eax,%eax
80102b06:	83 c0 01             	add    $0x1,%eax
80102b09:	52                   	push   %edx
80102b0a:	50                   	push   %eax
80102b0b:	e8 ef fe ff ff       	call   801029ff <ioapicwrite>
80102b10:	83 c4 08             	add    $0x8,%esp
80102b13:	eb 01                	jmp    80102b16 <ioapicenable+0x46>
80102b15:	90                   	nop
80102b16:	c9                   	leave  
80102b17:	c3                   	ret    

80102b18 <kinit1>:
80102b18:	55                   	push   %ebp
80102b19:	89 e5                	mov    %esp,%ebp
80102b1b:	83 ec 08             	sub    $0x8,%esp
80102b1e:	83 ec 08             	sub    $0x8,%esp
80102b21:	68 66 8b 10 80       	push   $0x80108b66
80102b26:	68 e0 46 11 80       	push   $0x801146e0
80102b2b:	e8 80 25 00 00       	call   801050b0 <initlock>
80102b30:	83 c4 10             	add    $0x10,%esp
80102b33:	c7 05 14 47 11 80 00 	movl   $0x0,0x80114714
80102b3a:	00 00 00 
80102b3d:	83 ec 08             	sub    $0x8,%esp
80102b40:	ff 75 0c             	pushl  0xc(%ebp)
80102b43:	ff 75 08             	pushl  0x8(%ebp)
80102b46:	e8 2a 00 00 00       	call   80102b75 <freerange>
80102b4b:	83 c4 10             	add    $0x10,%esp
80102b4e:	90                   	nop
80102b4f:	c9                   	leave  
80102b50:	c3                   	ret    

80102b51 <kinit2>:
80102b51:	55                   	push   %ebp
80102b52:	89 e5                	mov    %esp,%ebp
80102b54:	83 ec 08             	sub    $0x8,%esp
80102b57:	83 ec 08             	sub    $0x8,%esp
80102b5a:	ff 75 0c             	pushl  0xc(%ebp)
80102b5d:	ff 75 08             	pushl  0x8(%ebp)
80102b60:	e8 10 00 00 00       	call   80102b75 <freerange>
80102b65:	83 c4 10             	add    $0x10,%esp
80102b68:	c7 05 14 47 11 80 01 	movl   $0x1,0x80114714
80102b6f:	00 00 00 
80102b72:	90                   	nop
80102b73:	c9                   	leave  
80102b74:	c3                   	ret    

80102b75 <freerange>:
80102b75:	55                   	push   %ebp
80102b76:	89 e5                	mov    %esp,%ebp
80102b78:	83 ec 18             	sub    $0x18,%esp
80102b7b:	8b 45 08             	mov    0x8(%ebp),%eax
80102b7e:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b83:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b88:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b8b:	eb 15                	jmp    80102ba2 <freerange+0x2d>
80102b8d:	83 ec 0c             	sub    $0xc,%esp
80102b90:	ff 75 f4             	pushl  -0xc(%ebp)
80102b93:	e8 1a 00 00 00       	call   80102bb2 <kfree>
80102b98:	83 c4 10             	add    $0x10,%esp
80102b9b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ba5:	05 00 10 00 00       	add    $0x1000,%eax
80102baa:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102bad:	76 de                	jbe    80102b8d <freerange+0x18>
80102baf:	90                   	nop
80102bb0:	c9                   	leave  
80102bb1:	c3                   	ret    

80102bb2 <kfree>:
80102bb2:	55                   	push   %ebp
80102bb3:	89 e5                	mov    %esp,%ebp
80102bb5:	83 ec 18             	sub    $0x18,%esp
80102bb8:	8b 45 08             	mov    0x8(%ebp),%eax
80102bbb:	25 ff 0f 00 00       	and    $0xfff,%eax
80102bc0:	85 c0                	test   %eax,%eax
80102bc2:	75 18                	jne    80102bdc <kfree+0x2a>
80102bc4:	81 7d 08 a8 76 11 80 	cmpl   $0x801176a8,0x8(%ebp)
80102bcb:	72 0f                	jb     80102bdc <kfree+0x2a>
80102bcd:	8b 45 08             	mov    0x8(%ebp),%eax
80102bd0:	05 00 00 00 80       	add    $0x80000000,%eax
80102bd5:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102bda:	76 0d                	jbe    80102be9 <kfree+0x37>
80102bdc:	83 ec 0c             	sub    $0xc,%esp
80102bdf:	68 6b 8b 10 80       	push   $0x80108b6b
80102be4:	e8 af d9 ff ff       	call   80100598 <panic>
80102be9:	83 ec 04             	sub    $0x4,%esp
80102bec:	68 00 10 00 00       	push   $0x1000
80102bf1:	6a 01                	push   $0x1
80102bf3:	ff 75 08             	pushl  0x8(%ebp)
80102bf6:	e8 51 27 00 00       	call   8010534c <memset>
80102bfb:	83 c4 10             	add    $0x10,%esp
80102bfe:	a1 14 47 11 80       	mov    0x80114714,%eax
80102c03:	85 c0                	test   %eax,%eax
80102c05:	74 10                	je     80102c17 <kfree+0x65>
80102c07:	83 ec 0c             	sub    $0xc,%esp
80102c0a:	68 e0 46 11 80       	push   $0x801146e0
80102c0f:	e8 be 24 00 00       	call   801050d2 <acquire>
80102c14:	83 c4 10             	add    $0x10,%esp
80102c17:	8b 45 08             	mov    0x8(%ebp),%eax
80102c1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c1d:	8b 15 18 47 11 80    	mov    0x80114718,%edx
80102c23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c26:	89 10                	mov    %edx,(%eax)
80102c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c2b:	a3 18 47 11 80       	mov    %eax,0x80114718
80102c30:	a1 14 47 11 80       	mov    0x80114714,%eax
80102c35:	85 c0                	test   %eax,%eax
80102c37:	74 10                	je     80102c49 <kfree+0x97>
80102c39:	83 ec 0c             	sub    $0xc,%esp
80102c3c:	68 e0 46 11 80       	push   $0x801146e0
80102c41:	e8 f8 24 00 00       	call   8010513e <release>
80102c46:	83 c4 10             	add    $0x10,%esp
80102c49:	90                   	nop
80102c4a:	c9                   	leave  
80102c4b:	c3                   	ret    

80102c4c <kalloc>:
80102c4c:	55                   	push   %ebp
80102c4d:	89 e5                	mov    %esp,%ebp
80102c4f:	83 ec 18             	sub    $0x18,%esp
80102c52:	a1 14 47 11 80       	mov    0x80114714,%eax
80102c57:	85 c0                	test   %eax,%eax
80102c59:	74 10                	je     80102c6b <kalloc+0x1f>
80102c5b:	83 ec 0c             	sub    $0xc,%esp
80102c5e:	68 e0 46 11 80       	push   $0x801146e0
80102c63:	e8 6a 24 00 00       	call   801050d2 <acquire>
80102c68:	83 c4 10             	add    $0x10,%esp
80102c6b:	a1 18 47 11 80       	mov    0x80114718,%eax
80102c70:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c73:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c77:	74 0a                	je     80102c83 <kalloc+0x37>
80102c79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c7c:	8b 00                	mov    (%eax),%eax
80102c7e:	a3 18 47 11 80       	mov    %eax,0x80114718
80102c83:	a1 14 47 11 80       	mov    0x80114714,%eax
80102c88:	85 c0                	test   %eax,%eax
80102c8a:	74 10                	je     80102c9c <kalloc+0x50>
80102c8c:	83 ec 0c             	sub    $0xc,%esp
80102c8f:	68 e0 46 11 80       	push   $0x801146e0
80102c94:	e8 a5 24 00 00       	call   8010513e <release>
80102c99:	83 c4 10             	add    $0x10,%esp
80102c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c9f:	c9                   	leave  
80102ca0:	c3                   	ret    

80102ca1 <inb>:
80102ca1:	55                   	push   %ebp
80102ca2:	89 e5                	mov    %esp,%ebp
80102ca4:	83 ec 14             	sub    $0x14,%esp
80102ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80102caa:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102cae:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102cb2:	89 c2                	mov    %eax,%edx
80102cb4:	ec                   	in     (%dx),%al
80102cb5:	88 45 ff             	mov    %al,-0x1(%ebp)
80102cb8:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102cbc:	c9                   	leave  
80102cbd:	c3                   	ret    

80102cbe <kbdgetc>:
80102cbe:	55                   	push   %ebp
80102cbf:	89 e5                	mov    %esp,%ebp
80102cc1:	83 ec 10             	sub    $0x10,%esp
80102cc4:	6a 64                	push   $0x64
80102cc6:	e8 d6 ff ff ff       	call   80102ca1 <inb>
80102ccb:	83 c4 04             	add    $0x4,%esp
80102cce:	0f b6 c0             	movzbl %al,%eax
80102cd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102cd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cd7:	83 e0 01             	and    $0x1,%eax
80102cda:	85 c0                	test   %eax,%eax
80102cdc:	75 0a                	jne    80102ce8 <kbdgetc+0x2a>
80102cde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ce3:	e9 23 01 00 00       	jmp    80102e0b <kbdgetc+0x14d>
80102ce8:	6a 60                	push   $0x60
80102cea:	e8 b2 ff ff ff       	call   80102ca1 <inb>
80102cef:	83 c4 04             	add    $0x4,%esp
80102cf2:	0f b6 c0             	movzbl %al,%eax
80102cf5:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102cf8:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102cff:	75 17                	jne    80102d18 <kbdgetc+0x5a>
80102d01:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d06:	83 c8 40             	or     $0x40,%eax
80102d09:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102d0e:	b8 00 00 00 00       	mov    $0x0,%eax
80102d13:	e9 f3 00 00 00       	jmp    80102e0b <kbdgetc+0x14d>
80102d18:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d1b:	25 80 00 00 00       	and    $0x80,%eax
80102d20:	85 c0                	test   %eax,%eax
80102d22:	74 45                	je     80102d69 <kbdgetc+0xab>
80102d24:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d29:	83 e0 40             	and    $0x40,%eax
80102d2c:	85 c0                	test   %eax,%eax
80102d2e:	75 08                	jne    80102d38 <kbdgetc+0x7a>
80102d30:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d33:	83 e0 7f             	and    $0x7f,%eax
80102d36:	eb 03                	jmp    80102d3b <kbdgetc+0x7d>
80102d38:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102d3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d41:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102d46:	0f b6 00             	movzbl (%eax),%eax
80102d49:	83 c8 40             	or     $0x40,%eax
80102d4c:	0f b6 c0             	movzbl %al,%eax
80102d4f:	f7 d0                	not    %eax
80102d51:	89 c2                	mov    %eax,%edx
80102d53:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d58:	21 d0                	and    %edx,%eax
80102d5a:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102d5f:	b8 00 00 00 00       	mov    $0x0,%eax
80102d64:	e9 a2 00 00 00       	jmp    80102e0b <kbdgetc+0x14d>
80102d69:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d6e:	83 e0 40             	and    $0x40,%eax
80102d71:	85 c0                	test   %eax,%eax
80102d73:	74 14                	je     80102d89 <kbdgetc+0xcb>
80102d75:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
80102d7c:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d81:	83 e0 bf             	and    $0xffffffbf,%eax
80102d84:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102d89:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d8c:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102d91:	0f b6 00             	movzbl (%eax),%eax
80102d94:	0f b6 d0             	movzbl %al,%edx
80102d97:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d9c:	09 d0                	or     %edx,%eax
80102d9e:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102da3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102da6:	05 20 a1 10 80       	add    $0x8010a120,%eax
80102dab:	0f b6 00             	movzbl (%eax),%eax
80102dae:	0f b6 d0             	movzbl %al,%edx
80102db1:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102db6:	31 d0                	xor    %edx,%eax
80102db8:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
80102dbd:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102dc2:	83 e0 03             	and    $0x3,%eax
80102dc5:	8b 14 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%edx
80102dcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dcf:	01 d0                	add    %edx,%eax
80102dd1:	0f b6 00             	movzbl (%eax),%eax
80102dd4:	0f b6 c0             	movzbl %al,%eax
80102dd7:	89 45 f8             	mov    %eax,-0x8(%ebp)
80102dda:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102ddf:	83 e0 08             	and    $0x8,%eax
80102de2:	85 c0                	test   %eax,%eax
80102de4:	74 22                	je     80102e08 <kbdgetc+0x14a>
80102de6:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102dea:	76 0c                	jbe    80102df8 <kbdgetc+0x13a>
80102dec:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102df0:	77 06                	ja     80102df8 <kbdgetc+0x13a>
80102df2:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102df6:	eb 10                	jmp    80102e08 <kbdgetc+0x14a>
80102df8:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102dfc:	76 0a                	jbe    80102e08 <kbdgetc+0x14a>
80102dfe:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e02:	77 04                	ja     80102e08 <kbdgetc+0x14a>
80102e04:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
80102e08:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102e0b:	c9                   	leave  
80102e0c:	c3                   	ret    

80102e0d <kbdintr>:
80102e0d:	55                   	push   %ebp
80102e0e:	89 e5                	mov    %esp,%ebp
80102e10:	83 ec 08             	sub    $0x8,%esp
80102e13:	83 ec 0c             	sub    $0xc,%esp
80102e16:	68 be 2c 10 80       	push   $0x80102cbe
80102e1b:	e8 06 da ff ff       	call   80100826 <consoleintr>
80102e20:	83 c4 10             	add    $0x10,%esp
80102e23:	90                   	nop
80102e24:	c9                   	leave  
80102e25:	c3                   	ret    

80102e26 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102e26:	55                   	push   %ebp
80102e27:	89 e5                	mov    %esp,%ebp
80102e29:	83 ec 14             	sub    $0x14,%esp
80102e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80102e2f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e33:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102e37:	89 c2                	mov    %eax,%edx
80102e39:	ec                   	in     (%dx),%al
80102e3a:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102e3d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102e41:	c9                   	leave  
80102e42:	c3                   	ret    

80102e43 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102e43:	55                   	push   %ebp
80102e44:	89 e5                	mov    %esp,%ebp
80102e46:	83 ec 08             	sub    $0x8,%esp
80102e49:	8b 55 08             	mov    0x8(%ebp),%edx
80102e4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e4f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102e53:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e56:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e5a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e5e:	ee                   	out    %al,(%dx)
}
80102e5f:	c9                   	leave  
80102e60:	c3                   	ret    

80102e61 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102e61:	55                   	push   %ebp
80102e62:	89 e5                	mov    %esp,%ebp
80102e64:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102e67:	9c                   	pushf  
80102e68:	58                   	pop    %eax
80102e69:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102e6f:	c9                   	leave  
80102e70:	c3                   	ret    

80102e71 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102e71:	55                   	push   %ebp
80102e72:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102e74:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102e79:	8b 55 08             	mov    0x8(%ebp),%edx
80102e7c:	c1 e2 02             	shl    $0x2,%edx
80102e7f:	01 c2                	add    %eax,%edx
80102e81:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e84:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102e86:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102e8b:	83 c0 20             	add    $0x20,%eax
80102e8e:	8b 00                	mov    (%eax),%eax
}
80102e90:	5d                   	pop    %ebp
80102e91:	c3                   	ret    

80102e92 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102e92:	55                   	push   %ebp
80102e93:	89 e5                	mov    %esp,%ebp
80102e95:	83 ec 08             	sub    $0x8,%esp
  if(!lapic)
80102e98:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102e9d:	85 c0                	test   %eax,%eax
80102e9f:	75 05                	jne    80102ea6 <lapicinit+0x14>
    return;
80102ea1:	e9 43 01 00 00       	jmp    80102fe9 <lapicinit+0x157>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102ea6:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102ead:	00 
80102eae:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102eb5:	e8 b7 ff ff ff       	call   80102e71 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102eba:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102ec1:	00 
80102ec2:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102ec9:	e8 a3 ff ff ff       	call   80102e71 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102ece:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102ed5:	00 
80102ed6:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102edd:	e8 8f ff ff ff       	call   80102e71 <lapicw>
  lapicw(TICR, 10000000);
80102ee2:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102ee9:	00 
80102eea:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102ef1:	e8 7b ff ff ff       	call   80102e71 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102ef6:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102efd:	00 
80102efe:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102f05:	e8 67 ff ff ff       	call   80102e71 <lapicw>
  lapicw(LINT1, MASKED);
80102f0a:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102f11:	00 
80102f12:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102f19:	e8 53 ff ff ff       	call   80102e71 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f1e:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102f23:	83 c0 30             	add    $0x30,%eax
80102f26:	8b 00                	mov    (%eax),%eax
80102f28:	c1 e8 10             	shr    $0x10,%eax
80102f2b:	0f b6 c0             	movzbl %al,%eax
80102f2e:	83 f8 03             	cmp    $0x3,%eax
80102f31:	76 14                	jbe    80102f47 <lapicinit+0xb5>
    lapicw(PCINT, MASKED);
80102f33:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102f3a:	00 
80102f3b:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102f42:	e8 2a ff ff ff       	call   80102e71 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102f47:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102f4e:	00 
80102f4f:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102f56:	e8 16 ff ff ff       	call   80102e71 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102f5b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f62:	00 
80102f63:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102f6a:	e8 02 ff ff ff       	call   80102e71 <lapicw>
  lapicw(ESR, 0);
80102f6f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f76:	00 
80102f77:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102f7e:	e8 ee fe ff ff       	call   80102e71 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102f83:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f8a:	00 
80102f8b:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102f92:	e8 da fe ff ff       	call   80102e71 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102f97:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f9e:	00 
80102f9f:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102fa6:	e8 c6 fe ff ff       	call   80102e71 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102fab:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102fb2:	00 
80102fb3:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102fba:	e8 b2 fe ff ff       	call   80102e71 <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102fbf:	90                   	nop
80102fc0:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102fc5:	05 00 03 00 00       	add    $0x300,%eax
80102fca:	8b 00                	mov    (%eax),%eax
80102fcc:	25 00 10 00 00       	and    $0x1000,%eax
80102fd1:	85 c0                	test   %eax,%eax
80102fd3:	75 eb                	jne    80102fc0 <lapicinit+0x12e>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102fd5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102fdc:	00 
80102fdd:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102fe4:	e8 88 fe ff ff       	call   80102e71 <lapicw>
}
80102fe9:	c9                   	leave  
80102fea:	c3                   	ret    

80102feb <cpunum>:

int
cpunum(void)
{
80102feb:	55                   	push   %ebp
80102fec:	89 e5                	mov    %esp,%ebp
80102fee:	83 ec 28             	sub    $0x28,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102ff1:	e8 6b fe ff ff       	call   80102e61 <readeflags>
80102ff6:	25 00 02 00 00       	and    $0x200,%eax
80102ffb:	85 c0                	test   %eax,%eax
80102ffd:	74 25                	je     80103024 <cpunum+0x39>
    static int n;
    if(n++ == 0)
80102fff:	a1 40 c6 10 80       	mov    0x8010c640,%eax
80103004:	8d 50 01             	lea    0x1(%eax),%edx
80103007:	89 15 40 c6 10 80    	mov    %edx,0x8010c640
8010300d:	85 c0                	test   %eax,%eax
8010300f:	75 13                	jne    80103024 <cpunum+0x39>
      cprintf("cpu called from %x with interrupts enabled\n",
80103011:	8b 45 04             	mov    0x4(%ebp),%eax
80103014:	89 44 24 04          	mov    %eax,0x4(%esp)
80103018:	c7 04 24 74 8b 10 80 	movl   $0x80108b74,(%esp)
8010301f:	e8 da d3 ff ff       	call   801003fe <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
80103024:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80103029:	85 c0                	test   %eax,%eax
8010302b:	75 07                	jne    80103034 <cpunum+0x49>
    return 0;
8010302d:	b8 00 00 00 00       	mov    $0x0,%eax
80103032:	eb 51                	jmp    80103085 <cpunum+0x9a>

  apicid = lapic[ID] >> 24;
80103034:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80103039:	83 c0 20             	add    $0x20,%eax
8010303c:	8b 00                	mov    (%eax),%eax
8010303e:	c1 e8 18             	shr    $0x18,%eax
80103041:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < ncpu; ++i) {
80103044:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010304b:	eb 22                	jmp    8010306f <cpunum+0x84>
    if (cpus[i].apicid == apicid)
8010304d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103050:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103056:	05 20 48 11 80       	add    $0x80114820,%eax
8010305b:	0f b6 00             	movzbl (%eax),%eax
8010305e:	0f b6 c0             	movzbl %al,%eax
80103061:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80103064:	75 05                	jne    8010306b <cpunum+0x80>
      return i;
80103066:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103069:	eb 1a                	jmp    80103085 <cpunum+0x9a>

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
8010306b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010306f:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103074:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103077:	7c d4                	jl     8010304d <cpunum+0x62>
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80103079:	c7 04 24 a0 8b 10 80 	movl   $0x80108ba0,(%esp)
80103080:	e8 13 d5 ff ff       	call   80100598 <panic>
}
80103085:	c9                   	leave  
80103086:	c3                   	ret    

80103087 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103087:	55                   	push   %ebp
80103088:	89 e5                	mov    %esp,%ebp
8010308a:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
8010308d:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80103092:	85 c0                	test   %eax,%eax
80103094:	74 14                	je     801030aa <lapiceoi+0x23>
    lapicw(EOI, 0);
80103096:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010309d:	00 
8010309e:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
801030a5:	e8 c7 fd ff ff       	call   80102e71 <lapicw>
}
801030aa:	c9                   	leave  
801030ab:	c3                   	ret    

801030ac <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801030ac:	55                   	push   %ebp
801030ad:	89 e5                	mov    %esp,%ebp
}
801030af:	5d                   	pop    %ebp
801030b0:	c3                   	ret    

801030b1 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801030b1:	55                   	push   %ebp
801030b2:	89 e5                	mov    %esp,%ebp
801030b4:	83 ec 1c             	sub    $0x1c,%esp
801030b7:	8b 45 08             	mov    0x8(%ebp),%eax
801030ba:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
801030bd:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
801030c4:	00 
801030c5:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
801030cc:	e8 72 fd ff ff       	call   80102e43 <outb>
  outb(CMOS_PORT+1, 0x0A);
801030d1:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
801030d8:	00 
801030d9:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
801030e0:	e8 5e fd ff ff       	call   80102e43 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
801030e5:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
801030ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
801030ef:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
801030f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
801030f7:	8d 50 02             	lea    0x2(%eax),%edx
801030fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801030fd:	c1 e8 04             	shr    $0x4,%eax
80103100:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103103:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103107:	c1 e0 18             	shl    $0x18,%eax
8010310a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010310e:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80103115:	e8 57 fd ff ff       	call   80102e71 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
8010311a:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
80103121:	00 
80103122:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80103129:	e8 43 fd ff ff       	call   80102e71 <lapicw>
  microdelay(200);
8010312e:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80103135:	e8 72 ff ff ff       	call   801030ac <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
8010313a:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
80103141:	00 
80103142:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80103149:	e8 23 fd ff ff       	call   80102e71 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
8010314e:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80103155:	e8 52 ff ff ff       	call   801030ac <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010315a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103161:	eb 40                	jmp    801031a3 <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
80103163:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103167:	c1 e0 18             	shl    $0x18,%eax
8010316a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010316e:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80103175:	e8 f7 fc ff ff       	call   80102e71 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
8010317a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010317d:	c1 e8 0c             	shr    $0xc,%eax
80103180:	80 cc 06             	or     $0x6,%ah
80103183:	89 44 24 04          	mov    %eax,0x4(%esp)
80103187:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
8010318e:	e8 de fc ff ff       	call   80102e71 <lapicw>
    microdelay(200);
80103193:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
8010319a:	e8 0d ff ff ff       	call   801030ac <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010319f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801031a3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801031a7:	7e ba                	jle    80103163 <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801031a9:	c9                   	leave  
801031aa:	c3                   	ret    

801031ab <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
801031ab:	55                   	push   %ebp
801031ac:	89 e5                	mov    %esp,%ebp
801031ae:	83 ec 08             	sub    $0x8,%esp
  outb(CMOS_PORT,  reg);
801031b1:	8b 45 08             	mov    0x8(%ebp),%eax
801031b4:	0f b6 c0             	movzbl %al,%eax
801031b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801031bb:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
801031c2:	e8 7c fc ff ff       	call   80102e43 <outb>
  microdelay(200);
801031c7:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
801031ce:	e8 d9 fe ff ff       	call   801030ac <microdelay>

  return inb(CMOS_RETURN);
801031d3:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
801031da:	e8 47 fc ff ff       	call   80102e26 <inb>
801031df:	0f b6 c0             	movzbl %al,%eax
}
801031e2:	c9                   	leave  
801031e3:	c3                   	ret    

801031e4 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
801031e4:	55                   	push   %ebp
801031e5:	89 e5                	mov    %esp,%ebp
801031e7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
801031ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801031f1:	e8 b5 ff ff ff       	call   801031ab <cmos_read>
801031f6:	8b 55 08             	mov    0x8(%ebp),%edx
801031f9:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
801031fb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80103202:	e8 a4 ff ff ff       	call   801031ab <cmos_read>
80103207:	8b 55 08             	mov    0x8(%ebp),%edx
8010320a:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
8010320d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80103214:	e8 92 ff ff ff       	call   801031ab <cmos_read>
80103219:	8b 55 08             	mov    0x8(%ebp),%edx
8010321c:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
8010321f:	c7 04 24 07 00 00 00 	movl   $0x7,(%esp)
80103226:	e8 80 ff ff ff       	call   801031ab <cmos_read>
8010322b:	8b 55 08             	mov    0x8(%ebp),%edx
8010322e:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
80103231:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80103238:	e8 6e ff ff ff       	call   801031ab <cmos_read>
8010323d:	8b 55 08             	mov    0x8(%ebp),%edx
80103240:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
80103243:	c7 04 24 09 00 00 00 	movl   $0x9,(%esp)
8010324a:	e8 5c ff ff ff       	call   801031ab <cmos_read>
8010324f:	8b 55 08             	mov    0x8(%ebp),%edx
80103252:	89 42 14             	mov    %eax,0x14(%edx)
}
80103255:	c9                   	leave  
80103256:	c3                   	ret    

80103257 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80103257:	55                   	push   %ebp
80103258:	89 e5                	mov    %esp,%ebp
8010325a:	83 ec 58             	sub    $0x58,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
8010325d:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
80103264:	e8 42 ff ff ff       	call   801031ab <cmos_read>
80103269:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
8010326c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010326f:	83 e0 04             	and    $0x4,%eax
80103272:	85 c0                	test   %eax,%eax
80103274:	0f 94 c0             	sete   %al
80103277:	0f b6 c0             	movzbl %al,%eax
8010327a:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010327d:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103280:	89 04 24             	mov    %eax,(%esp)
80103283:	e8 5c ff ff ff       	call   801031e4 <fill_rtcdate>
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103288:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
8010328f:	e8 17 ff ff ff       	call   801031ab <cmos_read>
80103294:	25 80 00 00 00       	and    $0x80,%eax
80103299:	85 c0                	test   %eax,%eax
8010329b:	74 02                	je     8010329f <cmostime+0x48>
        continue;
8010329d:	eb 36                	jmp    801032d5 <cmostime+0x7e>
    fill_rtcdate(&t2);
8010329f:	8d 45 c0             	lea    -0x40(%ebp),%eax
801032a2:	89 04 24             	mov    %eax,(%esp)
801032a5:	e8 3a ff ff ff       	call   801031e4 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801032aa:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
801032b1:	00 
801032b2:	8d 45 c0             	lea    -0x40(%ebp),%eax
801032b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801032b9:	8d 45 d8             	lea    -0x28(%ebp),%eax
801032bc:	89 04 24             	mov    %eax,(%esp)
801032bf:	e8 ef 20 00 00       	call   801053b3 <memcmp>
801032c4:	85 c0                	test   %eax,%eax
801032c6:	75 0d                	jne    801032d5 <cmostime+0x7e>
      break;
801032c8:	90                   	nop
  }

  // convert
  if(bcd) {
801032c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801032cd:	0f 84 ac 00 00 00    	je     8010337f <cmostime+0x128>
801032d3:	eb 02                	jmp    801032d7 <cmostime+0x80>
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
801032d5:	eb a6                	jmp    8010327d <cmostime+0x26>

  // convert
  if(bcd) {
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801032d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
801032da:	c1 e8 04             	shr    $0x4,%eax
801032dd:	89 c2                	mov    %eax,%edx
801032df:	89 d0                	mov    %edx,%eax
801032e1:	c1 e0 02             	shl    $0x2,%eax
801032e4:	01 d0                	add    %edx,%eax
801032e6:	01 c0                	add    %eax,%eax
801032e8:	8b 55 d8             	mov    -0x28(%ebp),%edx
801032eb:	83 e2 0f             	and    $0xf,%edx
801032ee:	01 d0                	add    %edx,%eax
801032f0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
801032f3:	8b 45 dc             	mov    -0x24(%ebp),%eax
801032f6:	c1 e8 04             	shr    $0x4,%eax
801032f9:	89 c2                	mov    %eax,%edx
801032fb:	89 d0                	mov    %edx,%eax
801032fd:	c1 e0 02             	shl    $0x2,%eax
80103300:	01 d0                	add    %edx,%eax
80103302:	01 c0                	add    %eax,%eax
80103304:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103307:	83 e2 0f             	and    $0xf,%edx
8010330a:	01 d0                	add    %edx,%eax
8010330c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
8010330f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103312:	c1 e8 04             	shr    $0x4,%eax
80103315:	89 c2                	mov    %eax,%edx
80103317:	89 d0                	mov    %edx,%eax
80103319:	c1 e0 02             	shl    $0x2,%eax
8010331c:	01 d0                	add    %edx,%eax
8010331e:	01 c0                	add    %eax,%eax
80103320:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103323:	83 e2 0f             	and    $0xf,%edx
80103326:	01 d0                	add    %edx,%eax
80103328:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
8010332b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010332e:	c1 e8 04             	shr    $0x4,%eax
80103331:	89 c2                	mov    %eax,%edx
80103333:	89 d0                	mov    %edx,%eax
80103335:	c1 e0 02             	shl    $0x2,%eax
80103338:	01 d0                	add    %edx,%eax
8010333a:	01 c0                	add    %eax,%eax
8010333c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010333f:	83 e2 0f             	and    $0xf,%edx
80103342:	01 d0                	add    %edx,%eax
80103344:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
80103347:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010334a:	c1 e8 04             	shr    $0x4,%eax
8010334d:	89 c2                	mov    %eax,%edx
8010334f:	89 d0                	mov    %edx,%eax
80103351:	c1 e0 02             	shl    $0x2,%eax
80103354:	01 d0                	add    %edx,%eax
80103356:	01 c0                	add    %eax,%eax
80103358:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010335b:	83 e2 0f             	and    $0xf,%edx
8010335e:	01 d0                	add    %edx,%eax
80103360:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
80103363:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103366:	c1 e8 04             	shr    $0x4,%eax
80103369:	89 c2                	mov    %eax,%edx
8010336b:	89 d0                	mov    %edx,%eax
8010336d:	c1 e0 02             	shl    $0x2,%eax
80103370:	01 d0                	add    %edx,%eax
80103372:	01 c0                	add    %eax,%eax
80103374:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103377:	83 e2 0f             	and    $0xf,%edx
8010337a:	01 d0                	add    %edx,%eax
8010337c:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
8010337f:	8b 45 08             	mov    0x8(%ebp),%eax
80103382:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103385:	89 10                	mov    %edx,(%eax)
80103387:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010338a:	89 50 04             	mov    %edx,0x4(%eax)
8010338d:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103390:	89 50 08             	mov    %edx,0x8(%eax)
80103393:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103396:	89 50 0c             	mov    %edx,0xc(%eax)
80103399:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010339c:	89 50 10             	mov    %edx,0x10(%eax)
8010339f:	8b 55 ec             	mov    -0x14(%ebp),%edx
801033a2:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
801033a5:	8b 45 08             	mov    0x8(%ebp),%eax
801033a8:	8b 40 14             	mov    0x14(%eax),%eax
801033ab:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801033b1:	8b 45 08             	mov    0x8(%ebp),%eax
801033b4:	89 50 14             	mov    %edx,0x14(%eax)
}
801033b7:	c9                   	leave  
801033b8:	c3                   	ret    

801033b9 <initlog>:
801033b9:	55                   	push   %ebp
801033ba:	89 e5                	mov    %esp,%ebp
801033bc:	83 ec 28             	sub    $0x28,%esp
801033bf:	83 ec 08             	sub    $0x8,%esp
801033c2:	68 b0 8b 10 80       	push   $0x80108bb0
801033c7:	68 20 47 11 80       	push   $0x80114720
801033cc:	e8 df 1c 00 00       	call   801050b0 <initlock>
801033d1:	83 c4 10             	add    $0x10,%esp
801033d4:	83 ec 08             	sub    $0x8,%esp
801033d7:	8d 45 dc             	lea    -0x24(%ebp),%eax
801033da:	50                   	push   %eax
801033db:	ff 75 08             	pushl  0x8(%ebp)
801033de:	e8 f2 df ff ff       	call   801013d5 <readsb>
801033e3:	83 c4 10             	add    $0x10,%esp
801033e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033e9:	a3 54 47 11 80       	mov    %eax,0x80114754
801033ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
801033f1:	a3 58 47 11 80       	mov    %eax,0x80114758
801033f6:	8b 45 08             	mov    0x8(%ebp),%eax
801033f9:	a3 64 47 11 80       	mov    %eax,0x80114764
801033fe:	e8 b2 01 00 00       	call   801035b5 <recover_from_log>
80103403:	90                   	nop
80103404:	c9                   	leave  
80103405:	c3                   	ret    

80103406 <install_trans>:
80103406:	55                   	push   %ebp
80103407:	89 e5                	mov    %esp,%ebp
80103409:	83 ec 18             	sub    $0x18,%esp
8010340c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103413:	e9 95 00 00 00       	jmp    801034ad <install_trans+0xa7>
80103418:	8b 15 54 47 11 80    	mov    0x80114754,%edx
8010341e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103421:	01 d0                	add    %edx,%eax
80103423:	83 c0 01             	add    $0x1,%eax
80103426:	89 c2                	mov    %eax,%edx
80103428:	a1 64 47 11 80       	mov    0x80114764,%eax
8010342d:	83 ec 08             	sub    $0x8,%esp
80103430:	52                   	push   %edx
80103431:	50                   	push   %eax
80103432:	e8 97 cd ff ff       	call   801001ce <bread>
80103437:	83 c4 10             	add    $0x10,%esp
8010343a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010343d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103440:	83 c0 10             	add    $0x10,%eax
80103443:	8b 04 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%eax
8010344a:	89 c2                	mov    %eax,%edx
8010344c:	a1 64 47 11 80       	mov    0x80114764,%eax
80103451:	83 ec 08             	sub    $0x8,%esp
80103454:	52                   	push   %edx
80103455:	50                   	push   %eax
80103456:	e8 73 cd ff ff       	call   801001ce <bread>
8010345b:	83 c4 10             	add    $0x10,%esp
8010345e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103461:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103464:	8d 50 5c             	lea    0x5c(%eax),%edx
80103467:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010346a:	83 c0 5c             	add    $0x5c,%eax
8010346d:	83 ec 04             	sub    $0x4,%esp
80103470:	68 00 02 00 00       	push   $0x200
80103475:	52                   	push   %edx
80103476:	50                   	push   %eax
80103477:	e8 8f 1f 00 00       	call   8010540b <memmove>
8010347c:	83 c4 10             	add    $0x10,%esp
8010347f:	83 ec 0c             	sub    $0xc,%esp
80103482:	ff 75 ec             	pushl  -0x14(%ebp)
80103485:	e8 7d cd ff ff       	call   80100207 <bwrite>
8010348a:	83 c4 10             	add    $0x10,%esp
8010348d:	83 ec 0c             	sub    $0xc,%esp
80103490:	ff 75 f0             	pushl  -0x10(%ebp)
80103493:	e8 b8 cd ff ff       	call   80100250 <brelse>
80103498:	83 c4 10             	add    $0x10,%esp
8010349b:	83 ec 0c             	sub    $0xc,%esp
8010349e:	ff 75 ec             	pushl  -0x14(%ebp)
801034a1:	e8 aa cd ff ff       	call   80100250 <brelse>
801034a6:	83 c4 10             	add    $0x10,%esp
801034a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034ad:	a1 68 47 11 80       	mov    0x80114768,%eax
801034b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034b5:	0f 8f 5d ff ff ff    	jg     80103418 <install_trans+0x12>
801034bb:	90                   	nop
801034bc:	c9                   	leave  
801034bd:	c3                   	ret    

801034be <read_head>:
801034be:	55                   	push   %ebp
801034bf:	89 e5                	mov    %esp,%ebp
801034c1:	83 ec 18             	sub    $0x18,%esp
801034c4:	a1 54 47 11 80       	mov    0x80114754,%eax
801034c9:	89 c2                	mov    %eax,%edx
801034cb:	a1 64 47 11 80       	mov    0x80114764,%eax
801034d0:	83 ec 08             	sub    $0x8,%esp
801034d3:	52                   	push   %edx
801034d4:	50                   	push   %eax
801034d5:	e8 f4 cc ff ff       	call   801001ce <bread>
801034da:	83 c4 10             	add    $0x10,%esp
801034dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
801034e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034e3:	83 c0 5c             	add    $0x5c,%eax
801034e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
801034e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034ec:	8b 00                	mov    (%eax),%eax
801034ee:	a3 68 47 11 80       	mov    %eax,0x80114768
801034f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034fa:	eb 1b                	jmp    80103517 <read_head+0x59>
801034fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103502:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103506:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103509:	83 c2 10             	add    $0x10,%edx
8010350c:	89 04 95 2c 47 11 80 	mov    %eax,-0x7feeb8d4(,%edx,4)
80103513:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103517:	a1 68 47 11 80       	mov    0x80114768,%eax
8010351c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010351f:	7f db                	jg     801034fc <read_head+0x3e>
80103521:	83 ec 0c             	sub    $0xc,%esp
80103524:	ff 75 f0             	pushl  -0x10(%ebp)
80103527:	e8 24 cd ff ff       	call   80100250 <brelse>
8010352c:	83 c4 10             	add    $0x10,%esp
8010352f:	90                   	nop
80103530:	c9                   	leave  
80103531:	c3                   	ret    

80103532 <write_head>:
80103532:	55                   	push   %ebp
80103533:	89 e5                	mov    %esp,%ebp
80103535:	83 ec 18             	sub    $0x18,%esp
80103538:	a1 54 47 11 80       	mov    0x80114754,%eax
8010353d:	89 c2                	mov    %eax,%edx
8010353f:	a1 64 47 11 80       	mov    0x80114764,%eax
80103544:	83 ec 08             	sub    $0x8,%esp
80103547:	52                   	push   %edx
80103548:	50                   	push   %eax
80103549:	e8 80 cc ff ff       	call   801001ce <bread>
8010354e:	83 c4 10             	add    $0x10,%esp
80103551:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103554:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103557:	83 c0 5c             	add    $0x5c,%eax
8010355a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010355d:	8b 15 68 47 11 80    	mov    0x80114768,%edx
80103563:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103566:	89 10                	mov    %edx,(%eax)
80103568:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010356f:	eb 1b                	jmp    8010358c <write_head+0x5a>
80103571:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103574:	83 c0 10             	add    $0x10,%eax
80103577:	8b 0c 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%ecx
8010357e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103581:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103584:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
80103588:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010358c:	a1 68 47 11 80       	mov    0x80114768,%eax
80103591:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103594:	7f db                	jg     80103571 <write_head+0x3f>
80103596:	83 ec 0c             	sub    $0xc,%esp
80103599:	ff 75 f0             	pushl  -0x10(%ebp)
8010359c:	e8 66 cc ff ff       	call   80100207 <bwrite>
801035a1:	83 c4 10             	add    $0x10,%esp
801035a4:	83 ec 0c             	sub    $0xc,%esp
801035a7:	ff 75 f0             	pushl  -0x10(%ebp)
801035aa:	e8 a1 cc ff ff       	call   80100250 <brelse>
801035af:	83 c4 10             	add    $0x10,%esp
801035b2:	90                   	nop
801035b3:	c9                   	leave  
801035b4:	c3                   	ret    

801035b5 <recover_from_log>:
801035b5:	55                   	push   %ebp
801035b6:	89 e5                	mov    %esp,%ebp
801035b8:	83 ec 08             	sub    $0x8,%esp
801035bb:	e8 fe fe ff ff       	call   801034be <read_head>
801035c0:	e8 41 fe ff ff       	call   80103406 <install_trans>
801035c5:	c7 05 68 47 11 80 00 	movl   $0x0,0x80114768
801035cc:	00 00 00 
801035cf:	e8 5e ff ff ff       	call   80103532 <write_head>
801035d4:	90                   	nop
801035d5:	c9                   	leave  
801035d6:	c3                   	ret    

801035d7 <begin_op>:
801035d7:	55                   	push   %ebp
801035d8:	89 e5                	mov    %esp,%ebp
801035da:	83 ec 08             	sub    $0x8,%esp
801035dd:	83 ec 0c             	sub    $0xc,%esp
801035e0:	68 20 47 11 80       	push   $0x80114720
801035e5:	e8 e8 1a 00 00       	call   801050d2 <acquire>
801035ea:	83 c4 10             	add    $0x10,%esp
801035ed:	a1 60 47 11 80       	mov    0x80114760,%eax
801035f2:	85 c0                	test   %eax,%eax
801035f4:	74 17                	je     8010360d <begin_op+0x36>
801035f6:	83 ec 08             	sub    $0x8,%esp
801035f9:	68 20 47 11 80       	push   $0x80114720
801035fe:	68 20 47 11 80       	push   $0x80114720
80103603:	e8 ab 16 00 00       	call   80104cb3 <sleep>
80103608:	83 c4 10             	add    $0x10,%esp
8010360b:	eb e0                	jmp    801035ed <begin_op+0x16>
8010360d:	8b 0d 68 47 11 80    	mov    0x80114768,%ecx
80103613:	a1 5c 47 11 80       	mov    0x8011475c,%eax
80103618:	8d 50 01             	lea    0x1(%eax),%edx
8010361b:	89 d0                	mov    %edx,%eax
8010361d:	c1 e0 02             	shl    $0x2,%eax
80103620:	01 d0                	add    %edx,%eax
80103622:	01 c0                	add    %eax,%eax
80103624:	01 c8                	add    %ecx,%eax
80103626:	83 f8 1e             	cmp    $0x1e,%eax
80103629:	7e 17                	jle    80103642 <begin_op+0x6b>
8010362b:	83 ec 08             	sub    $0x8,%esp
8010362e:	68 20 47 11 80       	push   $0x80114720
80103633:	68 20 47 11 80       	push   $0x80114720
80103638:	e8 76 16 00 00       	call   80104cb3 <sleep>
8010363d:	83 c4 10             	add    $0x10,%esp
80103640:	eb ab                	jmp    801035ed <begin_op+0x16>
80103642:	a1 5c 47 11 80       	mov    0x8011475c,%eax
80103647:	83 c0 01             	add    $0x1,%eax
8010364a:	a3 5c 47 11 80       	mov    %eax,0x8011475c
8010364f:	83 ec 0c             	sub    $0xc,%esp
80103652:	68 20 47 11 80       	push   $0x80114720
80103657:	e8 e2 1a 00 00       	call   8010513e <release>
8010365c:	83 c4 10             	add    $0x10,%esp
8010365f:	90                   	nop
80103660:	90                   	nop
80103661:	c9                   	leave  
80103662:	c3                   	ret    

80103663 <end_op>:
80103663:	55                   	push   %ebp
80103664:	89 e5                	mov    %esp,%ebp
80103666:	83 ec 18             	sub    $0x18,%esp
80103669:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103670:	83 ec 0c             	sub    $0xc,%esp
80103673:	68 20 47 11 80       	push   $0x80114720
80103678:	e8 55 1a 00 00       	call   801050d2 <acquire>
8010367d:	83 c4 10             	add    $0x10,%esp
80103680:	a1 5c 47 11 80       	mov    0x8011475c,%eax
80103685:	83 e8 01             	sub    $0x1,%eax
80103688:	a3 5c 47 11 80       	mov    %eax,0x8011475c
8010368d:	a1 60 47 11 80       	mov    0x80114760,%eax
80103692:	85 c0                	test   %eax,%eax
80103694:	74 0d                	je     801036a3 <end_op+0x40>
80103696:	83 ec 0c             	sub    $0xc,%esp
80103699:	68 b4 8b 10 80       	push   $0x80108bb4
8010369e:	e8 f5 ce ff ff       	call   80100598 <panic>
801036a3:	a1 5c 47 11 80       	mov    0x8011475c,%eax
801036a8:	85 c0                	test   %eax,%eax
801036aa:	75 13                	jne    801036bf <end_op+0x5c>
801036ac:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801036b3:	c7 05 60 47 11 80 01 	movl   $0x1,0x80114760
801036ba:	00 00 00 
801036bd:	eb 10                	jmp    801036cf <end_op+0x6c>
801036bf:	83 ec 0c             	sub    $0xc,%esp
801036c2:	68 20 47 11 80       	push   $0x80114720
801036c7:	e8 d2 16 00 00       	call   80104d9e <wakeup>
801036cc:	83 c4 10             	add    $0x10,%esp
801036cf:	83 ec 0c             	sub    $0xc,%esp
801036d2:	68 20 47 11 80       	push   $0x80114720
801036d7:	e8 62 1a 00 00       	call   8010513e <release>
801036dc:	83 c4 10             	add    $0x10,%esp
801036df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801036e3:	74 3f                	je     80103724 <end_op+0xc1>
801036e5:	e8 f5 00 00 00       	call   801037df <commit>
801036ea:	83 ec 0c             	sub    $0xc,%esp
801036ed:	68 20 47 11 80       	push   $0x80114720
801036f2:	e8 db 19 00 00       	call   801050d2 <acquire>
801036f7:	83 c4 10             	add    $0x10,%esp
801036fa:	c7 05 60 47 11 80 00 	movl   $0x0,0x80114760
80103701:	00 00 00 
80103704:	83 ec 0c             	sub    $0xc,%esp
80103707:	68 20 47 11 80       	push   $0x80114720
8010370c:	e8 8d 16 00 00       	call   80104d9e <wakeup>
80103711:	83 c4 10             	add    $0x10,%esp
80103714:	83 ec 0c             	sub    $0xc,%esp
80103717:	68 20 47 11 80       	push   $0x80114720
8010371c:	e8 1d 1a 00 00       	call   8010513e <release>
80103721:	83 c4 10             	add    $0x10,%esp
80103724:	90                   	nop
80103725:	c9                   	leave  
80103726:	c3                   	ret    

80103727 <write_log>:
80103727:	55                   	push   %ebp
80103728:	89 e5                	mov    %esp,%ebp
8010372a:	83 ec 18             	sub    $0x18,%esp
8010372d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103734:	e9 95 00 00 00       	jmp    801037ce <write_log+0xa7>
80103739:	8b 15 54 47 11 80    	mov    0x80114754,%edx
8010373f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103742:	01 d0                	add    %edx,%eax
80103744:	83 c0 01             	add    $0x1,%eax
80103747:	89 c2                	mov    %eax,%edx
80103749:	a1 64 47 11 80       	mov    0x80114764,%eax
8010374e:	83 ec 08             	sub    $0x8,%esp
80103751:	52                   	push   %edx
80103752:	50                   	push   %eax
80103753:	e8 76 ca ff ff       	call   801001ce <bread>
80103758:	83 c4 10             	add    $0x10,%esp
8010375b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010375e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103761:	83 c0 10             	add    $0x10,%eax
80103764:	8b 04 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%eax
8010376b:	89 c2                	mov    %eax,%edx
8010376d:	a1 64 47 11 80       	mov    0x80114764,%eax
80103772:	83 ec 08             	sub    $0x8,%esp
80103775:	52                   	push   %edx
80103776:	50                   	push   %eax
80103777:	e8 52 ca ff ff       	call   801001ce <bread>
8010377c:	83 c4 10             	add    $0x10,%esp
8010377f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103782:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103785:	8d 50 5c             	lea    0x5c(%eax),%edx
80103788:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010378b:	83 c0 5c             	add    $0x5c,%eax
8010378e:	83 ec 04             	sub    $0x4,%esp
80103791:	68 00 02 00 00       	push   $0x200
80103796:	52                   	push   %edx
80103797:	50                   	push   %eax
80103798:	e8 6e 1c 00 00       	call   8010540b <memmove>
8010379d:	83 c4 10             	add    $0x10,%esp
801037a0:	83 ec 0c             	sub    $0xc,%esp
801037a3:	ff 75 f0             	pushl  -0x10(%ebp)
801037a6:	e8 5c ca ff ff       	call   80100207 <bwrite>
801037ab:	83 c4 10             	add    $0x10,%esp
801037ae:	83 ec 0c             	sub    $0xc,%esp
801037b1:	ff 75 ec             	pushl  -0x14(%ebp)
801037b4:	e8 97 ca ff ff       	call   80100250 <brelse>
801037b9:	83 c4 10             	add    $0x10,%esp
801037bc:	83 ec 0c             	sub    $0xc,%esp
801037bf:	ff 75 f0             	pushl  -0x10(%ebp)
801037c2:	e8 89 ca ff ff       	call   80100250 <brelse>
801037c7:	83 c4 10             	add    $0x10,%esp
801037ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037ce:	a1 68 47 11 80       	mov    0x80114768,%eax
801037d3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037d6:	0f 8f 5d ff ff ff    	jg     80103739 <write_log+0x12>
801037dc:	90                   	nop
801037dd:	c9                   	leave  
801037de:	c3                   	ret    

801037df <commit>:
801037df:	55                   	push   %ebp
801037e0:	89 e5                	mov    %esp,%ebp
801037e2:	83 ec 08             	sub    $0x8,%esp
801037e5:	a1 68 47 11 80       	mov    0x80114768,%eax
801037ea:	85 c0                	test   %eax,%eax
801037ec:	7e 1e                	jle    8010380c <commit+0x2d>
801037ee:	e8 34 ff ff ff       	call   80103727 <write_log>
801037f3:	e8 3a fd ff ff       	call   80103532 <write_head>
801037f8:	e8 09 fc ff ff       	call   80103406 <install_trans>
801037fd:	c7 05 68 47 11 80 00 	movl   $0x0,0x80114768
80103804:	00 00 00 
80103807:	e8 26 fd ff ff       	call   80103532 <write_head>
8010380c:	90                   	nop
8010380d:	c9                   	leave  
8010380e:	c3                   	ret    

8010380f <log_write>:
8010380f:	55                   	push   %ebp
80103810:	89 e5                	mov    %esp,%ebp
80103812:	83 ec 18             	sub    $0x18,%esp
80103815:	a1 68 47 11 80       	mov    0x80114768,%eax
8010381a:	83 f8 1d             	cmp    $0x1d,%eax
8010381d:	7f 12                	jg     80103831 <log_write+0x22>
8010381f:	a1 68 47 11 80       	mov    0x80114768,%eax
80103824:	8b 15 58 47 11 80    	mov    0x80114758,%edx
8010382a:	83 ea 01             	sub    $0x1,%edx
8010382d:	39 d0                	cmp    %edx,%eax
8010382f:	7c 0d                	jl     8010383e <log_write+0x2f>
80103831:	83 ec 0c             	sub    $0xc,%esp
80103834:	68 c3 8b 10 80       	push   $0x80108bc3
80103839:	e8 5a cd ff ff       	call   80100598 <panic>
8010383e:	a1 5c 47 11 80       	mov    0x8011475c,%eax
80103843:	85 c0                	test   %eax,%eax
80103845:	7f 0d                	jg     80103854 <log_write+0x45>
80103847:	83 ec 0c             	sub    $0xc,%esp
8010384a:	68 d9 8b 10 80       	push   $0x80108bd9
8010384f:	e8 44 cd ff ff       	call   80100598 <panic>
80103854:	83 ec 0c             	sub    $0xc,%esp
80103857:	68 20 47 11 80       	push   $0x80114720
8010385c:	e8 71 18 00 00       	call   801050d2 <acquire>
80103861:	83 c4 10             	add    $0x10,%esp
80103864:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010386b:	eb 1d                	jmp    8010388a <log_write+0x7b>
8010386d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103870:	83 c0 10             	add    $0x10,%eax
80103873:	8b 04 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%eax
8010387a:	89 c2                	mov    %eax,%edx
8010387c:	8b 45 08             	mov    0x8(%ebp),%eax
8010387f:	8b 40 08             	mov    0x8(%eax),%eax
80103882:	39 c2                	cmp    %eax,%edx
80103884:	74 10                	je     80103896 <log_write+0x87>
80103886:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010388a:	a1 68 47 11 80       	mov    0x80114768,%eax
8010388f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103892:	7f d9                	jg     8010386d <log_write+0x5e>
80103894:	eb 01                	jmp    80103897 <log_write+0x88>
80103896:	90                   	nop
80103897:	8b 45 08             	mov    0x8(%ebp),%eax
8010389a:	8b 40 08             	mov    0x8(%eax),%eax
8010389d:	89 c2                	mov    %eax,%edx
8010389f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038a2:	83 c0 10             	add    $0x10,%eax
801038a5:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
801038ac:	a1 68 47 11 80       	mov    0x80114768,%eax
801038b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038b4:	75 0d                	jne    801038c3 <log_write+0xb4>
801038b6:	a1 68 47 11 80       	mov    0x80114768,%eax
801038bb:	83 c0 01             	add    $0x1,%eax
801038be:	a3 68 47 11 80       	mov    %eax,0x80114768
801038c3:	8b 45 08             	mov    0x8(%ebp),%eax
801038c6:	8b 00                	mov    (%eax),%eax
801038c8:	83 c8 04             	or     $0x4,%eax
801038cb:	89 c2                	mov    %eax,%edx
801038cd:	8b 45 08             	mov    0x8(%ebp),%eax
801038d0:	89 10                	mov    %edx,(%eax)
801038d2:	83 ec 0c             	sub    $0xc,%esp
801038d5:	68 20 47 11 80       	push   $0x80114720
801038da:	e8 5f 18 00 00       	call   8010513e <release>
801038df:	83 c4 10             	add    $0x10,%esp
801038e2:	90                   	nop
801038e3:	c9                   	leave  
801038e4:	c3                   	ret    

801038e5 <xchg>:
801038e5:	55                   	push   %ebp
801038e6:	89 e5                	mov    %esp,%ebp
801038e8:	83 ec 10             	sub    $0x10,%esp
801038eb:	8b 55 08             	mov    0x8(%ebp),%edx
801038ee:	8b 45 0c             	mov    0xc(%ebp),%eax
801038f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
801038f4:	f0 87 02             	lock xchg %eax,(%edx)
801038f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
801038fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
801038fd:	c9                   	leave  
801038fe:	c3                   	ret    

801038ff <main>:
801038ff:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103903:	83 e4 f0             	and    $0xfffffff0,%esp
80103906:	ff 71 fc             	pushl  -0x4(%ecx)
80103909:	55                   	push   %ebp
8010390a:	89 e5                	mov    %esp,%ebp
8010390c:	51                   	push   %ecx
8010390d:	83 ec 04             	sub    $0x4,%esp
80103910:	83 ec 08             	sub    $0x8,%esp
80103913:	68 00 00 40 80       	push   $0x80400000
80103918:	68 a8 76 11 80       	push   $0x801176a8
8010391d:	e8 f6 f1 ff ff       	call   80102b18 <kinit1>
80103922:	83 c4 10             	add    $0x10,%esp
80103925:	e8 96 48 00 00       	call   801081c0 <kvmalloc>
8010392a:	e8 e4 03 00 00       	call   80103d13 <mpinit>
8010392f:	e8 5e f5 ff ff       	call   80102e92 <lapicinit>
80103934:	e8 61 42 00 00       	call   80107b9a <seginit>
80103939:	e8 ad f6 ff ff       	call   80102feb <cpunum>
8010393e:	83 ec 08             	sub    $0x8,%esp
80103941:	50                   	push   %eax
80103942:	68 f4 8b 10 80       	push   $0x80108bf4
80103947:	e8 b2 ca ff ff       	call   801003fe <cprintf>
8010394c:	83 c4 10             	add    $0x10,%esp
8010394f:	e8 94 05 00 00       	call   80103ee8 <picinit>
80103954:	e8 c1 f0 ff ff       	call   80102a1a <ioapicinit>
80103959:	e8 b0 d1 ff ff       	call   80100b0e <consoleinit>
8010395e:	e8 ad 35 00 00       	call   80106f10 <uartinit>
80103963:	e8 7d 0a 00 00       	call   801043e5 <pinit>
80103968:	e8 73 2f 00 00       	call   801068e0 <tvinit>
8010396d:	e8 c2 c6 ff ff       	call   80100034 <binit>
80103972:	e8 4f d6 ff ff       	call   80100fc6 <fileinit>
80103977:	e8 9b ec ff ff       	call   80102617 <ideinit>
8010397c:	a1 04 48 11 80       	mov    0x80114804,%eax
80103981:	85 c0                	test   %eax,%eax
80103983:	75 05                	jne    8010398a <main+0x8b>
80103985:	e8 b3 2e 00 00       	call   8010683d <timerinit>
8010398a:	e8 78 00 00 00       	call   80103a07 <startothers>
8010398f:	83 ec 08             	sub    $0x8,%esp
80103992:	68 00 00 00 8e       	push   $0x8e000000
80103997:	68 00 00 40 80       	push   $0x80400000
8010399c:	e8 b0 f1 ff ff       	call   80102b51 <kinit2>
801039a1:	83 c4 10             	add    $0x10,%esp
801039a4:	e8 60 0b 00 00       	call   80104509 <userinit>
801039a9:	e8 1a 00 00 00       	call   801039c8 <mpmain>

801039ae <mpenter>:
801039ae:	55                   	push   %ebp
801039af:	89 e5                	mov    %esp,%ebp
801039b1:	83 ec 08             	sub    $0x8,%esp
801039b4:	e8 1f 48 00 00       	call   801081d8 <switchkvm>
801039b9:	e8 dc 41 00 00       	call   80107b9a <seginit>
801039be:	e8 cf f4 ff ff       	call   80102e92 <lapicinit>
801039c3:	e8 00 00 00 00       	call   801039c8 <mpmain>

801039c8 <mpmain>:
801039c8:	55                   	push   %ebp
801039c9:	89 e5                	mov    %esp,%ebp
801039cb:	83 ec 08             	sub    $0x8,%esp
801039ce:	e8 18 f6 ff ff       	call   80102feb <cpunum>
801039d3:	83 ec 08             	sub    $0x8,%esp
801039d6:	50                   	push   %eax
801039d7:	68 0b 8c 10 80       	push   $0x80108c0b
801039dc:	e8 1d ca ff ff       	call   801003fe <cprintf>
801039e1:	83 c4 10             	add    $0x10,%esp
801039e4:	e8 6d 30 00 00       	call   80106a56 <idtinit>
801039e9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801039ef:	05 a8 00 00 00       	add    $0xa8,%eax
801039f4:	83 ec 08             	sub    $0x8,%esp
801039f7:	6a 01                	push   $0x1
801039f9:	50                   	push   %eax
801039fa:	e8 e6 fe ff ff       	call   801038e5 <xchg>
801039ff:	83 c4 10             	add    $0x10,%esp
80103a02:	e8 cd 10 00 00       	call   80104ad4 <scheduler>

80103a07 <startothers>:
80103a07:	55                   	push   %ebp
80103a08:	89 e5                	mov    %esp,%ebp
80103a0a:	83 ec 18             	sub    $0x18,%esp
80103a0d:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
80103a14:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103a19:	83 ec 04             	sub    $0x4,%esp
80103a1c:	50                   	push   %eax
80103a1d:	68 0c c5 10 80       	push   $0x8010c50c
80103a22:	ff 75 f0             	pushl  -0x10(%ebp)
80103a25:	e8 e1 19 00 00       	call   8010540b <memmove>
80103a2a:	83 c4 10             	add    $0x10,%esp
80103a2d:	c7 45 f4 20 48 11 80 	movl   $0x80114820,-0xc(%ebp)
80103a34:	e9 84 00 00 00       	jmp    80103abd <startothers+0xb6>
80103a39:	e8 ad f5 ff ff       	call   80102feb <cpunum>
80103a3e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a44:	05 20 48 11 80       	add    $0x80114820,%eax
80103a49:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a4c:	74 67                	je     80103ab5 <startothers+0xae>
80103a4e:	e8 f9 f1 ff ff       	call   80102c4c <kalloc>
80103a53:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103a56:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a59:	83 e8 04             	sub    $0x4,%eax
80103a5c:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a5f:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103a65:	89 10                	mov    %edx,(%eax)
80103a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a6a:	83 e8 08             	sub    $0x8,%eax
80103a6d:	c7 00 ae 39 10 80    	movl   $0x801039ae,(%eax)
80103a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a76:	83 e8 0c             	sub    $0xc,%eax
80103a79:	ba 00 b0 10 80       	mov    $0x8010b000,%edx
80103a7e:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80103a84:	89 10                	mov    %edx,(%eax)
80103a86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a89:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80103a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a92:	0f b6 00             	movzbl (%eax),%eax
80103a95:	0f b6 c0             	movzbl %al,%eax
80103a98:	83 ec 08             	sub    $0x8,%esp
80103a9b:	52                   	push   %edx
80103a9c:	50                   	push   %eax
80103a9d:	e8 0f f6 ff ff       	call   801030b1 <lapicstartap>
80103aa2:	83 c4 10             	add    $0x10,%esp
80103aa5:	90                   	nop
80103aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aa9:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103aaf:	85 c0                	test   %eax,%eax
80103ab1:	74 f3                	je     80103aa6 <startothers+0x9f>
80103ab3:	eb 01                	jmp    80103ab6 <startothers+0xaf>
80103ab5:	90                   	nop
80103ab6:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103abd:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103ac2:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103ac8:	05 20 48 11 80       	add    $0x80114820,%eax
80103acd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103ad0:	0f 87 63 ff ff ff    	ja     80103a39 <startothers+0x32>
80103ad6:	90                   	nop
80103ad7:	c9                   	leave  
80103ad8:	c3                   	ret    

80103ad9 <inb>:
80103ad9:	55                   	push   %ebp
80103ada:	89 e5                	mov    %esp,%ebp
80103adc:	83 ec 14             	sub    $0x14,%esp
80103adf:	8b 45 08             	mov    0x8(%ebp),%eax
80103ae2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80103ae6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103aea:	89 c2                	mov    %eax,%edx
80103aec:	ec                   	in     (%dx),%al
80103aed:	88 45 ff             	mov    %al,-0x1(%ebp)
80103af0:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80103af4:	c9                   	leave  
80103af5:	c3                   	ret    

80103af6 <outb>:
80103af6:	55                   	push   %ebp
80103af7:	89 e5                	mov    %esp,%ebp
80103af9:	83 ec 08             	sub    $0x8,%esp
80103afc:	8b 55 08             	mov    0x8(%ebp),%edx
80103aff:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b02:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103b06:	88 45 f8             	mov    %al,-0x8(%ebp)
80103b09:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103b0d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103b11:	ee                   	out    %al,(%dx)
80103b12:	90                   	nop
80103b13:	c9                   	leave  
80103b14:	c3                   	ret    

80103b15 <sum>:
80103b15:	55                   	push   %ebp
80103b16:	89 e5                	mov    %esp,%ebp
80103b18:	83 ec 10             	sub    $0x10,%esp
80103b1b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80103b22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103b29:	eb 15                	jmp    80103b40 <sum+0x2b>
80103b2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103b2e:	8b 45 08             	mov    0x8(%ebp),%eax
80103b31:	01 d0                	add    %edx,%eax
80103b33:	0f b6 00             	movzbl (%eax),%eax
80103b36:	0f b6 c0             	movzbl %al,%eax
80103b39:	01 45 f8             	add    %eax,-0x8(%ebp)
80103b3c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103b40:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b43:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103b46:	7c e3                	jl     80103b2b <sum+0x16>
80103b48:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103b4b:	c9                   	leave  
80103b4c:	c3                   	ret    

80103b4d <mpsearch1>:
80103b4d:	55                   	push   %ebp
80103b4e:	89 e5                	mov    %esp,%ebp
80103b50:	83 ec 18             	sub    $0x18,%esp
80103b53:	8b 45 08             	mov    0x8(%ebp),%eax
80103b56:	05 00 00 00 80       	add    $0x80000000,%eax
80103b5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b61:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b64:	01 d0                	add    %edx,%eax
80103b66:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b6f:	eb 36                	jmp    80103ba7 <mpsearch1+0x5a>
80103b71:	83 ec 04             	sub    $0x4,%esp
80103b74:	6a 04                	push   $0x4
80103b76:	68 1c 8c 10 80       	push   $0x80108c1c
80103b7b:	ff 75 f4             	pushl  -0xc(%ebp)
80103b7e:	e8 30 18 00 00       	call   801053b3 <memcmp>
80103b83:	83 c4 10             	add    $0x10,%esp
80103b86:	85 c0                	test   %eax,%eax
80103b88:	75 19                	jne    80103ba3 <mpsearch1+0x56>
80103b8a:	83 ec 08             	sub    $0x8,%esp
80103b8d:	6a 10                	push   $0x10
80103b8f:	ff 75 f4             	pushl  -0xc(%ebp)
80103b92:	e8 7e ff ff ff       	call   80103b15 <sum>
80103b97:	83 c4 10             	add    $0x10,%esp
80103b9a:	84 c0                	test   %al,%al
80103b9c:	75 05                	jne    80103ba3 <mpsearch1+0x56>
80103b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ba1:	eb 11                	jmp    80103bb4 <mpsearch1+0x67>
80103ba3:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103baa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103bad:	72 c2                	jb     80103b71 <mpsearch1+0x24>
80103baf:	b8 00 00 00 00       	mov    $0x0,%eax
80103bb4:	c9                   	leave  
80103bb5:	c3                   	ret    

80103bb6 <mpsearch>:
80103bb6:	55                   	push   %ebp
80103bb7:	89 e5                	mov    %esp,%ebp
80103bb9:	83 ec 18             	sub    $0x18,%esp
80103bbc:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
80103bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bc6:	83 c0 0f             	add    $0xf,%eax
80103bc9:	0f b6 00             	movzbl (%eax),%eax
80103bcc:	0f b6 c0             	movzbl %al,%eax
80103bcf:	c1 e0 08             	shl    $0x8,%eax
80103bd2:	89 c2                	mov    %eax,%edx
80103bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bd7:	83 c0 0e             	add    $0xe,%eax
80103bda:	0f b6 00             	movzbl (%eax),%eax
80103bdd:	0f b6 c0             	movzbl %al,%eax
80103be0:	09 d0                	or     %edx,%eax
80103be2:	c1 e0 04             	shl    $0x4,%eax
80103be5:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103be8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bec:	74 21                	je     80103c0f <mpsearch+0x59>
80103bee:	83 ec 08             	sub    $0x8,%esp
80103bf1:	68 00 04 00 00       	push   $0x400
80103bf6:	ff 75 f0             	pushl  -0x10(%ebp)
80103bf9:	e8 4f ff ff ff       	call   80103b4d <mpsearch1>
80103bfe:	83 c4 10             	add    $0x10,%esp
80103c01:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c04:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c08:	74 51                	je     80103c5b <mpsearch+0xa5>
80103c0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c0d:	eb 61                	jmp    80103c70 <mpsearch+0xba>
80103c0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c12:	83 c0 14             	add    $0x14,%eax
80103c15:	0f b6 00             	movzbl (%eax),%eax
80103c18:	0f b6 c0             	movzbl %al,%eax
80103c1b:	c1 e0 08             	shl    $0x8,%eax
80103c1e:	89 c2                	mov    %eax,%edx
80103c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c23:	83 c0 13             	add    $0x13,%eax
80103c26:	0f b6 00             	movzbl (%eax),%eax
80103c29:	0f b6 c0             	movzbl %al,%eax
80103c2c:	09 d0                	or     %edx,%eax
80103c2e:	c1 e0 0a             	shl    $0xa,%eax
80103c31:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c34:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c37:	2d 00 04 00 00       	sub    $0x400,%eax
80103c3c:	83 ec 08             	sub    $0x8,%esp
80103c3f:	68 00 04 00 00       	push   $0x400
80103c44:	50                   	push   %eax
80103c45:	e8 03 ff ff ff       	call   80103b4d <mpsearch1>
80103c4a:	83 c4 10             	add    $0x10,%esp
80103c4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c50:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c54:	74 05                	je     80103c5b <mpsearch+0xa5>
80103c56:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c59:	eb 15                	jmp    80103c70 <mpsearch+0xba>
80103c5b:	83 ec 08             	sub    $0x8,%esp
80103c5e:	68 00 00 01 00       	push   $0x10000
80103c63:	68 00 00 0f 00       	push   $0xf0000
80103c68:	e8 e0 fe ff ff       	call   80103b4d <mpsearch1>
80103c6d:	83 c4 10             	add    $0x10,%esp
80103c70:	c9                   	leave  
80103c71:	c3                   	ret    

80103c72 <mpconfig>:
80103c72:	55                   	push   %ebp
80103c73:	89 e5                	mov    %esp,%ebp
80103c75:	83 ec 18             	sub    $0x18,%esp
80103c78:	e8 39 ff ff ff       	call   80103bb6 <mpsearch>
80103c7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c80:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c84:	74 0a                	je     80103c90 <mpconfig+0x1e>
80103c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c89:	8b 40 04             	mov    0x4(%eax),%eax
80103c8c:	85 c0                	test   %eax,%eax
80103c8e:	75 07                	jne    80103c97 <mpconfig+0x25>
80103c90:	b8 00 00 00 00       	mov    $0x0,%eax
80103c95:	eb 7a                	jmp    80103d11 <mpconfig+0x9f>
80103c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c9a:	8b 40 04             	mov    0x4(%eax),%eax
80103c9d:	05 00 00 00 80       	add    $0x80000000,%eax
80103ca2:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103ca5:	83 ec 04             	sub    $0x4,%esp
80103ca8:	6a 04                	push   $0x4
80103caa:	68 21 8c 10 80       	push   $0x80108c21
80103caf:	ff 75 f0             	pushl  -0x10(%ebp)
80103cb2:	e8 fc 16 00 00       	call   801053b3 <memcmp>
80103cb7:	83 c4 10             	add    $0x10,%esp
80103cba:	85 c0                	test   %eax,%eax
80103cbc:	74 07                	je     80103cc5 <mpconfig+0x53>
80103cbe:	b8 00 00 00 00       	mov    $0x0,%eax
80103cc3:	eb 4c                	jmp    80103d11 <mpconfig+0x9f>
80103cc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cc8:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103ccc:	3c 01                	cmp    $0x1,%al
80103cce:	74 12                	je     80103ce2 <mpconfig+0x70>
80103cd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cd3:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cd7:	3c 04                	cmp    $0x4,%al
80103cd9:	74 07                	je     80103ce2 <mpconfig+0x70>
80103cdb:	b8 00 00 00 00       	mov    $0x0,%eax
80103ce0:	eb 2f                	jmp    80103d11 <mpconfig+0x9f>
80103ce2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ce5:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103ce9:	0f b7 c0             	movzwl %ax,%eax
80103cec:	83 ec 08             	sub    $0x8,%esp
80103cef:	50                   	push   %eax
80103cf0:	ff 75 f0             	pushl  -0x10(%ebp)
80103cf3:	e8 1d fe ff ff       	call   80103b15 <sum>
80103cf8:	83 c4 10             	add    $0x10,%esp
80103cfb:	84 c0                	test   %al,%al
80103cfd:	74 07                	je     80103d06 <mpconfig+0x94>
80103cff:	b8 00 00 00 00       	mov    $0x0,%eax
80103d04:	eb 0b                	jmp    80103d11 <mpconfig+0x9f>
80103d06:	8b 45 08             	mov    0x8(%ebp),%eax
80103d09:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d0c:	89 10                	mov    %edx,(%eax)
80103d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d11:	c9                   	leave  
80103d12:	c3                   	ret    

80103d13 <mpinit>:
80103d13:	55                   	push   %ebp
80103d14:	89 e5                	mov    %esp,%ebp
80103d16:	83 ec 28             	sub    $0x28,%esp
80103d19:	83 ec 0c             	sub    $0xc,%esp
80103d1c:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103d1f:	50                   	push   %eax
80103d20:	e8 4d ff ff ff       	call   80103c72 <mpconfig>
80103d25:	83 c4 10             	add    $0x10,%esp
80103d28:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103d2b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d2f:	0f 84 1f 01 00 00    	je     80103e54 <mpinit+0x141>
80103d35:	c7 05 04 48 11 80 01 	movl   $0x1,0x80114804
80103d3c:	00 00 00 
80103d3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d42:	8b 40 24             	mov    0x24(%eax),%eax
80103d45:	a3 1c 47 11 80       	mov    %eax,0x8011471c
80103d4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d4d:	83 c0 2c             	add    $0x2c,%eax
80103d50:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d53:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d56:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d5a:	0f b7 d0             	movzwl %ax,%edx
80103d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d60:	01 d0                	add    %edx,%eax
80103d62:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d65:	eb 7e                	jmp    80103de5 <mpinit+0xd2>
80103d67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d6a:	0f b6 00             	movzbl (%eax),%eax
80103d6d:	0f b6 c0             	movzbl %al,%eax
80103d70:	83 f8 04             	cmp    $0x4,%eax
80103d73:	77 65                	ja     80103dda <mpinit+0xc7>
80103d75:	8b 04 85 28 8c 10 80 	mov    -0x7fef73d8(,%eax,4),%eax
80103d7c:	ff e0                	jmp    *%eax
80103d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d81:	89 45 e8             	mov    %eax,-0x18(%ebp)
80103d84:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103d89:	83 f8 07             	cmp    $0x7,%eax
80103d8c:	7f 28                	jg     80103db6 <mpinit+0xa3>
80103d8e:	8b 15 00 4e 11 80    	mov    0x80114e00,%edx
80103d94:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d97:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d9b:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103da1:	81 c2 20 48 11 80    	add    $0x80114820,%edx
80103da7:	88 02                	mov    %al,(%edx)
80103da9:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103dae:	83 c0 01             	add    $0x1,%eax
80103db1:	a3 00 4e 11 80       	mov    %eax,0x80114e00
80103db6:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
80103dba:	eb 29                	jmp    80103de5 <mpinit+0xd2>
80103dbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dbf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103dc2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103dc5:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103dc9:	a2 00 48 11 80       	mov    %al,0x80114800
80103dce:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
80103dd2:	eb 11                	jmp    80103de5 <mpinit+0xd2>
80103dd4:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
80103dd8:	eb 0b                	jmp    80103de5 <mpinit+0xd2>
80103dda:	c7 05 04 48 11 80 00 	movl   $0x0,0x80114804
80103de1:	00 00 00 
80103de4:	90                   	nop
80103de5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103de8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103deb:	0f 82 76 ff ff ff    	jb     80103d67 <mpinit+0x54>
80103df1:	a1 04 48 11 80       	mov    0x80114804,%eax
80103df6:	85 c0                	test   %eax,%eax
80103df8:	75 1d                	jne    80103e17 <mpinit+0x104>
80103dfa:	c7 05 00 4e 11 80 01 	movl   $0x1,0x80114e00
80103e01:	00 00 00 
80103e04:	c7 05 1c 47 11 80 00 	movl   $0x0,0x8011471c
80103e0b:	00 00 00 
80103e0e:	c6 05 00 48 11 80 00 	movb   $0x0,0x80114800
80103e15:	eb 3e                	jmp    80103e55 <mpinit+0x142>
80103e17:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e1a:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e1e:	84 c0                	test   %al,%al
80103e20:	74 33                	je     80103e55 <mpinit+0x142>
80103e22:	83 ec 08             	sub    $0x8,%esp
80103e25:	6a 70                	push   $0x70
80103e27:	6a 22                	push   $0x22
80103e29:	e8 c8 fc ff ff       	call   80103af6 <outb>
80103e2e:	83 c4 10             	add    $0x10,%esp
80103e31:	83 ec 0c             	sub    $0xc,%esp
80103e34:	6a 23                	push   $0x23
80103e36:	e8 9e fc ff ff       	call   80103ad9 <inb>
80103e3b:	83 c4 10             	add    $0x10,%esp
80103e3e:	83 c8 01             	or     $0x1,%eax
80103e41:	0f b6 c0             	movzbl %al,%eax
80103e44:	83 ec 08             	sub    $0x8,%esp
80103e47:	50                   	push   %eax
80103e48:	6a 23                	push   $0x23
80103e4a:	e8 a7 fc ff ff       	call   80103af6 <outb>
80103e4f:	83 c4 10             	add    $0x10,%esp
80103e52:	eb 01                	jmp    80103e55 <mpinit+0x142>
80103e54:	90                   	nop
80103e55:	c9                   	leave  
80103e56:	c3                   	ret    

80103e57 <outb>:
80103e57:	55                   	push   %ebp
80103e58:	89 e5                	mov    %esp,%ebp
80103e5a:	83 ec 08             	sub    $0x8,%esp
80103e5d:	8b 55 08             	mov    0x8(%ebp),%edx
80103e60:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e63:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e67:	88 45 f8             	mov    %al,-0x8(%ebp)
80103e6a:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e6e:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e72:	ee                   	out    %al,(%dx)
80103e73:	90                   	nop
80103e74:	c9                   	leave  
80103e75:	c3                   	ret    

80103e76 <picsetmask>:
80103e76:	55                   	push   %ebp
80103e77:	89 e5                	mov    %esp,%ebp
80103e79:	83 ec 04             	sub    $0x4,%esp
80103e7c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e7f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103e83:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e87:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
80103e8d:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e91:	0f b6 c0             	movzbl %al,%eax
80103e94:	50                   	push   %eax
80103e95:	6a 21                	push   $0x21
80103e97:	e8 bb ff ff ff       	call   80103e57 <outb>
80103e9c:	83 c4 08             	add    $0x8,%esp
80103e9f:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ea3:	66 c1 e8 08          	shr    $0x8,%ax
80103ea7:	0f b6 c0             	movzbl %al,%eax
80103eaa:	50                   	push   %eax
80103eab:	68 a1 00 00 00       	push   $0xa1
80103eb0:	e8 a2 ff ff ff       	call   80103e57 <outb>
80103eb5:	83 c4 08             	add    $0x8,%esp
80103eb8:	90                   	nop
80103eb9:	c9                   	leave  
80103eba:	c3                   	ret    

80103ebb <picenable>:
80103ebb:	55                   	push   %ebp
80103ebc:	89 e5                	mov    %esp,%ebp
80103ebe:	8b 45 08             	mov    0x8(%ebp),%eax
80103ec1:	ba 01 00 00 00       	mov    $0x1,%edx
80103ec6:	89 c1                	mov    %eax,%ecx
80103ec8:	d3 e2                	shl    %cl,%edx
80103eca:	89 d0                	mov    %edx,%eax
80103ecc:	f7 d0                	not    %eax
80103ece:	89 c2                	mov    %eax,%edx
80103ed0:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103ed7:	21 d0                	and    %edx,%eax
80103ed9:	0f b7 c0             	movzwl %ax,%eax
80103edc:	50                   	push   %eax
80103edd:	e8 94 ff ff ff       	call   80103e76 <picsetmask>
80103ee2:	83 c4 04             	add    $0x4,%esp
80103ee5:	90                   	nop
80103ee6:	c9                   	leave  
80103ee7:	c3                   	ret    

80103ee8 <picinit>:
80103ee8:	55                   	push   %ebp
80103ee9:	89 e5                	mov    %esp,%ebp
80103eeb:	68 ff 00 00 00       	push   $0xff
80103ef0:	6a 21                	push   $0x21
80103ef2:	e8 60 ff ff ff       	call   80103e57 <outb>
80103ef7:	83 c4 08             	add    $0x8,%esp
80103efa:	68 ff 00 00 00       	push   $0xff
80103eff:	68 a1 00 00 00       	push   $0xa1
80103f04:	e8 4e ff ff ff       	call   80103e57 <outb>
80103f09:	83 c4 08             	add    $0x8,%esp
80103f0c:	6a 11                	push   $0x11
80103f0e:	6a 20                	push   $0x20
80103f10:	e8 42 ff ff ff       	call   80103e57 <outb>
80103f15:	83 c4 08             	add    $0x8,%esp
80103f18:	6a 20                	push   $0x20
80103f1a:	6a 21                	push   $0x21
80103f1c:	e8 36 ff ff ff       	call   80103e57 <outb>
80103f21:	83 c4 08             	add    $0x8,%esp
80103f24:	6a 04                	push   $0x4
80103f26:	6a 21                	push   $0x21
80103f28:	e8 2a ff ff ff       	call   80103e57 <outb>
80103f2d:	83 c4 08             	add    $0x8,%esp
80103f30:	6a 03                	push   $0x3
80103f32:	6a 21                	push   $0x21
80103f34:	e8 1e ff ff ff       	call   80103e57 <outb>
80103f39:	83 c4 08             	add    $0x8,%esp
80103f3c:	6a 11                	push   $0x11
80103f3e:	68 a0 00 00 00       	push   $0xa0
80103f43:	e8 0f ff ff ff       	call   80103e57 <outb>
80103f48:	83 c4 08             	add    $0x8,%esp
80103f4b:	6a 28                	push   $0x28
80103f4d:	68 a1 00 00 00       	push   $0xa1
80103f52:	e8 00 ff ff ff       	call   80103e57 <outb>
80103f57:	83 c4 08             	add    $0x8,%esp
80103f5a:	6a 02                	push   $0x2
80103f5c:	68 a1 00 00 00       	push   $0xa1
80103f61:	e8 f1 fe ff ff       	call   80103e57 <outb>
80103f66:	83 c4 08             	add    $0x8,%esp
80103f69:	6a 03                	push   $0x3
80103f6b:	68 a1 00 00 00       	push   $0xa1
80103f70:	e8 e2 fe ff ff       	call   80103e57 <outb>
80103f75:	83 c4 08             	add    $0x8,%esp
80103f78:	6a 68                	push   $0x68
80103f7a:	6a 20                	push   $0x20
80103f7c:	e8 d6 fe ff ff       	call   80103e57 <outb>
80103f81:	83 c4 08             	add    $0x8,%esp
80103f84:	6a 0a                	push   $0xa
80103f86:	6a 20                	push   $0x20
80103f88:	e8 ca fe ff ff       	call   80103e57 <outb>
80103f8d:	83 c4 08             	add    $0x8,%esp
80103f90:	6a 68                	push   $0x68
80103f92:	68 a0 00 00 00       	push   $0xa0
80103f97:	e8 bb fe ff ff       	call   80103e57 <outb>
80103f9c:	83 c4 08             	add    $0x8,%esp
80103f9f:	6a 0a                	push   $0xa
80103fa1:	68 a0 00 00 00       	push   $0xa0
80103fa6:	e8 ac fe ff ff       	call   80103e57 <outb>
80103fab:	83 c4 08             	add    $0x8,%esp
80103fae:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103fb5:	66 83 f8 ff          	cmp    $0xffff,%ax
80103fb9:	74 13                	je     80103fce <picinit+0xe6>
80103fbb:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103fc2:	0f b7 c0             	movzwl %ax,%eax
80103fc5:	50                   	push   %eax
80103fc6:	e8 ab fe ff ff       	call   80103e76 <picsetmask>
80103fcb:	83 c4 04             	add    $0x4,%esp
80103fce:	90                   	nop
80103fcf:	c9                   	leave  
80103fd0:	c3                   	ret    

80103fd1 <pipealloc>:
80103fd1:	55                   	push   %ebp
80103fd2:	89 e5                	mov    %esp,%ebp
80103fd4:	83 ec 18             	sub    $0x18,%esp
80103fd7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103fde:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fe1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103fe7:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fea:	8b 10                	mov    (%eax),%edx
80103fec:	8b 45 08             	mov    0x8(%ebp),%eax
80103fef:	89 10                	mov    %edx,(%eax)
80103ff1:	e8 ee cf ff ff       	call   80100fe4 <filealloc>
80103ff6:	89 c2                	mov    %eax,%edx
80103ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80103ffb:	89 10                	mov    %edx,(%eax)
80103ffd:	8b 45 08             	mov    0x8(%ebp),%eax
80104000:	8b 00                	mov    (%eax),%eax
80104002:	85 c0                	test   %eax,%eax
80104004:	0f 84 cb 00 00 00    	je     801040d5 <pipealloc+0x104>
8010400a:	e8 d5 cf ff ff       	call   80100fe4 <filealloc>
8010400f:	89 c2                	mov    %eax,%edx
80104011:	8b 45 0c             	mov    0xc(%ebp),%eax
80104014:	89 10                	mov    %edx,(%eax)
80104016:	8b 45 0c             	mov    0xc(%ebp),%eax
80104019:	8b 00                	mov    (%eax),%eax
8010401b:	85 c0                	test   %eax,%eax
8010401d:	0f 84 b2 00 00 00    	je     801040d5 <pipealloc+0x104>
80104023:	e8 24 ec ff ff       	call   80102c4c <kalloc>
80104028:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010402b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010402f:	0f 84 9f 00 00 00    	je     801040d4 <pipealloc+0x103>
80104035:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104038:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010403f:	00 00 00 
80104042:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104045:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010404c:	00 00 00 
8010404f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104052:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104059:	00 00 00 
8010405c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010405f:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104066:	00 00 00 
80104069:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010406c:	83 ec 08             	sub    $0x8,%esp
8010406f:	68 3c 8c 10 80       	push   $0x80108c3c
80104074:	50                   	push   %eax
80104075:	e8 36 10 00 00       	call   801050b0 <initlock>
8010407a:	83 c4 10             	add    $0x10,%esp
8010407d:	8b 45 08             	mov    0x8(%ebp),%eax
80104080:	8b 00                	mov    (%eax),%eax
80104082:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80104088:	8b 45 08             	mov    0x8(%ebp),%eax
8010408b:	8b 00                	mov    (%eax),%eax
8010408d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80104091:	8b 45 08             	mov    0x8(%ebp),%eax
80104094:	8b 00                	mov    (%eax),%eax
80104096:	c6 40 09 00          	movb   $0x0,0x9(%eax)
8010409a:	8b 45 08             	mov    0x8(%ebp),%eax
8010409d:	8b 00                	mov    (%eax),%eax
8010409f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040a2:	89 50 0c             	mov    %edx,0xc(%eax)
801040a5:	8b 45 0c             	mov    0xc(%ebp),%eax
801040a8:	8b 00                	mov    (%eax),%eax
801040aa:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801040b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801040b3:	8b 00                	mov    (%eax),%eax
801040b5:	c6 40 08 00          	movb   $0x0,0x8(%eax)
801040b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801040bc:	8b 00                	mov    (%eax),%eax
801040be:	c6 40 09 01          	movb   $0x1,0x9(%eax)
801040c2:	8b 45 0c             	mov    0xc(%ebp),%eax
801040c5:	8b 00                	mov    (%eax),%eax
801040c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040ca:	89 50 0c             	mov    %edx,0xc(%eax)
801040cd:	b8 00 00 00 00       	mov    $0x0,%eax
801040d2:	eb 4e                	jmp    80104122 <pipealloc+0x151>
801040d4:	90                   	nop
801040d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040d9:	74 0e                	je     801040e9 <pipealloc+0x118>
801040db:	83 ec 0c             	sub    $0xc,%esp
801040de:	ff 75 f4             	pushl  -0xc(%ebp)
801040e1:	e8 cc ea ff ff       	call   80102bb2 <kfree>
801040e6:	83 c4 10             	add    $0x10,%esp
801040e9:	8b 45 08             	mov    0x8(%ebp),%eax
801040ec:	8b 00                	mov    (%eax),%eax
801040ee:	85 c0                	test   %eax,%eax
801040f0:	74 11                	je     80104103 <pipealloc+0x132>
801040f2:	8b 45 08             	mov    0x8(%ebp),%eax
801040f5:	8b 00                	mov    (%eax),%eax
801040f7:	83 ec 0c             	sub    $0xc,%esp
801040fa:	50                   	push   %eax
801040fb:	e8 a2 cf ff ff       	call   801010a2 <fileclose>
80104100:	83 c4 10             	add    $0x10,%esp
80104103:	8b 45 0c             	mov    0xc(%ebp),%eax
80104106:	8b 00                	mov    (%eax),%eax
80104108:	85 c0                	test   %eax,%eax
8010410a:	74 11                	je     8010411d <pipealloc+0x14c>
8010410c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010410f:	8b 00                	mov    (%eax),%eax
80104111:	83 ec 0c             	sub    $0xc,%esp
80104114:	50                   	push   %eax
80104115:	e8 88 cf ff ff       	call   801010a2 <fileclose>
8010411a:	83 c4 10             	add    $0x10,%esp
8010411d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104122:	c9                   	leave  
80104123:	c3                   	ret    

80104124 <pipeclose>:
80104124:	55                   	push   %ebp
80104125:	89 e5                	mov    %esp,%ebp
80104127:	83 ec 08             	sub    $0x8,%esp
8010412a:	8b 45 08             	mov    0x8(%ebp),%eax
8010412d:	83 ec 0c             	sub    $0xc,%esp
80104130:	50                   	push   %eax
80104131:	e8 9c 0f 00 00       	call   801050d2 <acquire>
80104136:	83 c4 10             	add    $0x10,%esp
80104139:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010413d:	74 23                	je     80104162 <pipeclose+0x3e>
8010413f:	8b 45 08             	mov    0x8(%ebp),%eax
80104142:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104149:	00 00 00 
8010414c:	8b 45 08             	mov    0x8(%ebp),%eax
8010414f:	05 34 02 00 00       	add    $0x234,%eax
80104154:	83 ec 0c             	sub    $0xc,%esp
80104157:	50                   	push   %eax
80104158:	e8 41 0c 00 00       	call   80104d9e <wakeup>
8010415d:	83 c4 10             	add    $0x10,%esp
80104160:	eb 21                	jmp    80104183 <pipeclose+0x5f>
80104162:	8b 45 08             	mov    0x8(%ebp),%eax
80104165:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010416c:	00 00 00 
8010416f:	8b 45 08             	mov    0x8(%ebp),%eax
80104172:	05 38 02 00 00       	add    $0x238,%eax
80104177:	83 ec 0c             	sub    $0xc,%esp
8010417a:	50                   	push   %eax
8010417b:	e8 1e 0c 00 00       	call   80104d9e <wakeup>
80104180:	83 c4 10             	add    $0x10,%esp
80104183:	8b 45 08             	mov    0x8(%ebp),%eax
80104186:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010418c:	85 c0                	test   %eax,%eax
8010418e:	75 2c                	jne    801041bc <pipeclose+0x98>
80104190:	8b 45 08             	mov    0x8(%ebp),%eax
80104193:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104199:	85 c0                	test   %eax,%eax
8010419b:	75 1f                	jne    801041bc <pipeclose+0x98>
8010419d:	8b 45 08             	mov    0x8(%ebp),%eax
801041a0:	83 ec 0c             	sub    $0xc,%esp
801041a3:	50                   	push   %eax
801041a4:	e8 95 0f 00 00       	call   8010513e <release>
801041a9:	83 c4 10             	add    $0x10,%esp
801041ac:	83 ec 0c             	sub    $0xc,%esp
801041af:	ff 75 08             	pushl  0x8(%ebp)
801041b2:	e8 fb e9 ff ff       	call   80102bb2 <kfree>
801041b7:	83 c4 10             	add    $0x10,%esp
801041ba:	eb 0f                	jmp    801041cb <pipeclose+0xa7>
801041bc:	8b 45 08             	mov    0x8(%ebp),%eax
801041bf:	83 ec 0c             	sub    $0xc,%esp
801041c2:	50                   	push   %eax
801041c3:	e8 76 0f 00 00       	call   8010513e <release>
801041c8:	83 c4 10             	add    $0x10,%esp
801041cb:	90                   	nop
801041cc:	c9                   	leave  
801041cd:	c3                   	ret    

801041ce <pipewrite>:
801041ce:	55                   	push   %ebp
801041cf:	89 e5                	mov    %esp,%ebp
801041d1:	83 ec 18             	sub    $0x18,%esp
801041d4:	8b 45 08             	mov    0x8(%ebp),%eax
801041d7:	83 ec 0c             	sub    $0xc,%esp
801041da:	50                   	push   %eax
801041db:	e8 f2 0e 00 00       	call   801050d2 <acquire>
801041e0:	83 c4 10             	add    $0x10,%esp
801041e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801041ea:	e9 ad 00 00 00       	jmp    8010429c <pipewrite+0xce>
801041ef:	8b 45 08             	mov    0x8(%ebp),%eax
801041f2:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801041f8:	85 c0                	test   %eax,%eax
801041fa:	74 0d                	je     80104209 <pipewrite+0x3b>
801041fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104202:	8b 40 28             	mov    0x28(%eax),%eax
80104205:	85 c0                	test   %eax,%eax
80104207:	74 19                	je     80104222 <pipewrite+0x54>
80104209:	8b 45 08             	mov    0x8(%ebp),%eax
8010420c:	83 ec 0c             	sub    $0xc,%esp
8010420f:	50                   	push   %eax
80104210:	e8 29 0f 00 00       	call   8010513e <release>
80104215:	83 c4 10             	add    $0x10,%esp
80104218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010421d:	e9 a8 00 00 00       	jmp    801042ca <pipewrite+0xfc>
80104222:	8b 45 08             	mov    0x8(%ebp),%eax
80104225:	05 34 02 00 00       	add    $0x234,%eax
8010422a:	83 ec 0c             	sub    $0xc,%esp
8010422d:	50                   	push   %eax
8010422e:	e8 6b 0b 00 00       	call   80104d9e <wakeup>
80104233:	83 c4 10             	add    $0x10,%esp
80104236:	8b 45 08             	mov    0x8(%ebp),%eax
80104239:	8b 55 08             	mov    0x8(%ebp),%edx
8010423c:	81 c2 38 02 00 00    	add    $0x238,%edx
80104242:	83 ec 08             	sub    $0x8,%esp
80104245:	50                   	push   %eax
80104246:	52                   	push   %edx
80104247:	e8 67 0a 00 00       	call   80104cb3 <sleep>
8010424c:	83 c4 10             	add    $0x10,%esp
8010424f:	8b 45 08             	mov    0x8(%ebp),%eax
80104252:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104258:	8b 45 08             	mov    0x8(%ebp),%eax
8010425b:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104261:	05 00 02 00 00       	add    $0x200,%eax
80104266:	39 c2                	cmp    %eax,%edx
80104268:	74 85                	je     801041ef <pipewrite+0x21>
8010426a:	8b 45 08             	mov    0x8(%ebp),%eax
8010426d:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104273:	8d 48 01             	lea    0x1(%eax),%ecx
80104276:	8b 55 08             	mov    0x8(%ebp),%edx
80104279:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010427f:	25 ff 01 00 00       	and    $0x1ff,%eax
80104284:	89 c1                	mov    %eax,%ecx
80104286:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104289:	8b 45 0c             	mov    0xc(%ebp),%eax
8010428c:	01 d0                	add    %edx,%eax
8010428e:	0f b6 10             	movzbl (%eax),%edx
80104291:	8b 45 08             	mov    0x8(%ebp),%eax
80104294:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
80104298:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010429c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010429f:	3b 45 10             	cmp    0x10(%ebp),%eax
801042a2:	7c ab                	jl     8010424f <pipewrite+0x81>
801042a4:	8b 45 08             	mov    0x8(%ebp),%eax
801042a7:	05 34 02 00 00       	add    $0x234,%eax
801042ac:	83 ec 0c             	sub    $0xc,%esp
801042af:	50                   	push   %eax
801042b0:	e8 e9 0a 00 00       	call   80104d9e <wakeup>
801042b5:	83 c4 10             	add    $0x10,%esp
801042b8:	8b 45 08             	mov    0x8(%ebp),%eax
801042bb:	83 ec 0c             	sub    $0xc,%esp
801042be:	50                   	push   %eax
801042bf:	e8 7a 0e 00 00       	call   8010513e <release>
801042c4:	83 c4 10             	add    $0x10,%esp
801042c7:	8b 45 10             	mov    0x10(%ebp),%eax
801042ca:	c9                   	leave  
801042cb:	c3                   	ret    

801042cc <piperead>:
801042cc:	55                   	push   %ebp
801042cd:	89 e5                	mov    %esp,%ebp
801042cf:	53                   	push   %ebx
801042d0:	83 ec 14             	sub    $0x14,%esp
801042d3:	8b 45 08             	mov    0x8(%ebp),%eax
801042d6:	83 ec 0c             	sub    $0xc,%esp
801042d9:	50                   	push   %eax
801042da:	e8 f3 0d 00 00       	call   801050d2 <acquire>
801042df:	83 c4 10             	add    $0x10,%esp
801042e2:	eb 3f                	jmp    80104323 <piperead+0x57>
801042e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042ea:	8b 40 28             	mov    0x28(%eax),%eax
801042ed:	85 c0                	test   %eax,%eax
801042ef:	74 19                	je     8010430a <piperead+0x3e>
801042f1:	8b 45 08             	mov    0x8(%ebp),%eax
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	50                   	push   %eax
801042f8:	e8 41 0e 00 00       	call   8010513e <release>
801042fd:	83 c4 10             	add    $0x10,%esp
80104300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104305:	e9 bf 00 00 00       	jmp    801043c9 <piperead+0xfd>
8010430a:	8b 45 08             	mov    0x8(%ebp),%eax
8010430d:	8b 55 08             	mov    0x8(%ebp),%edx
80104310:	81 c2 34 02 00 00    	add    $0x234,%edx
80104316:	83 ec 08             	sub    $0x8,%esp
80104319:	50                   	push   %eax
8010431a:	52                   	push   %edx
8010431b:	e8 93 09 00 00       	call   80104cb3 <sleep>
80104320:	83 c4 10             	add    $0x10,%esp
80104323:	8b 45 08             	mov    0x8(%ebp),%eax
80104326:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010432c:	8b 45 08             	mov    0x8(%ebp),%eax
8010432f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104335:	39 c2                	cmp    %eax,%edx
80104337:	75 0d                	jne    80104346 <piperead+0x7a>
80104339:	8b 45 08             	mov    0x8(%ebp),%eax
8010433c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104342:	85 c0                	test   %eax,%eax
80104344:	75 9e                	jne    801042e4 <piperead+0x18>
80104346:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010434d:	eb 49                	jmp    80104398 <piperead+0xcc>
8010434f:	8b 45 08             	mov    0x8(%ebp),%eax
80104352:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104358:	8b 45 08             	mov    0x8(%ebp),%eax
8010435b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104361:	39 c2                	cmp    %eax,%edx
80104363:	74 3d                	je     801043a2 <piperead+0xd6>
80104365:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104368:	8b 45 0c             	mov    0xc(%ebp),%eax
8010436b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010436e:	8b 45 08             	mov    0x8(%ebp),%eax
80104371:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104377:	8d 48 01             	lea    0x1(%eax),%ecx
8010437a:	8b 55 08             	mov    0x8(%ebp),%edx
8010437d:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104383:	25 ff 01 00 00       	and    $0x1ff,%eax
80104388:	89 c2                	mov    %eax,%edx
8010438a:	8b 45 08             	mov    0x8(%ebp),%eax
8010438d:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
80104392:	88 03                	mov    %al,(%ebx)
80104394:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104398:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010439b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010439e:	7c af                	jl     8010434f <piperead+0x83>
801043a0:	eb 01                	jmp    801043a3 <piperead+0xd7>
801043a2:	90                   	nop
801043a3:	8b 45 08             	mov    0x8(%ebp),%eax
801043a6:	05 38 02 00 00       	add    $0x238,%eax
801043ab:	83 ec 0c             	sub    $0xc,%esp
801043ae:	50                   	push   %eax
801043af:	e8 ea 09 00 00       	call   80104d9e <wakeup>
801043b4:	83 c4 10             	add    $0x10,%esp
801043b7:	8b 45 08             	mov    0x8(%ebp),%eax
801043ba:	83 ec 0c             	sub    $0xc,%esp
801043bd:	50                   	push   %eax
801043be:	e8 7b 0d 00 00       	call   8010513e <release>
801043c3:	83 c4 10             	add    $0x10,%esp
801043c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043cc:	c9                   	leave  
801043cd:	c3                   	ret    

801043ce <readeflags>:
801043ce:	55                   	push   %ebp
801043cf:	89 e5                	mov    %esp,%ebp
801043d1:	83 ec 10             	sub    $0x10,%esp
801043d4:	9c                   	pushf  
801043d5:	58                   	pop    %eax
801043d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
801043d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801043dc:	c9                   	leave  
801043dd:	c3                   	ret    

801043de <sti>:
801043de:	55                   	push   %ebp
801043df:	89 e5                	mov    %esp,%ebp
801043e1:	fb                   	sti    
801043e2:	90                   	nop
801043e3:	5d                   	pop    %ebp
801043e4:	c3                   	ret    

801043e5 <pinit>:
801043e5:	55                   	push   %ebp
801043e6:	89 e5                	mov    %esp,%ebp
801043e8:	83 ec 08             	sub    $0x8,%esp
801043eb:	83 ec 08             	sub    $0x8,%esp
801043ee:	68 41 8c 10 80       	push   $0x80108c41
801043f3:	68 20 4e 11 80       	push   $0x80114e20
801043f8:	e8 b3 0c 00 00       	call   801050b0 <initlock>
801043fd:	83 c4 10             	add    $0x10,%esp
80104400:	90                   	nop
80104401:	c9                   	leave  
80104402:	c3                   	ret    

80104403 <allocproc>:
80104403:	55                   	push   %ebp
80104404:	89 e5                	mov    %esp,%ebp
80104406:	83 ec 18             	sub    $0x18,%esp
80104409:	83 ec 0c             	sub    $0xc,%esp
8010440c:	68 20 4e 11 80       	push   $0x80114e20
80104411:	e8 bc 0c 00 00       	call   801050d2 <acquire>
80104416:	83 c4 10             	add    $0x10,%esp
80104419:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
80104420:	eb 0e                	jmp    80104430 <allocproc+0x2d>
80104422:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104425:	8b 40 10             	mov    0x10(%eax),%eax
80104428:	85 c0                	test   %eax,%eax
8010442a:	74 27                	je     80104453 <allocproc+0x50>
8010442c:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104430:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104437:	72 e9                	jb     80104422 <allocproc+0x1f>
80104439:	83 ec 0c             	sub    $0xc,%esp
8010443c:	68 20 4e 11 80       	push   $0x80114e20
80104441:	e8 f8 0c 00 00       	call   8010513e <release>
80104446:	83 c4 10             	add    $0x10,%esp
80104449:	b8 00 00 00 00       	mov    $0x0,%eax
8010444e:	e9 b4 00 00 00       	jmp    80104507 <allocproc+0x104>
80104453:	90                   	nop
80104454:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104457:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
8010445e:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104463:	8d 50 01             	lea    0x1(%eax),%edx
80104466:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
8010446c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010446f:	89 42 14             	mov    %eax,0x14(%edx)
80104472:	83 ec 0c             	sub    $0xc,%esp
80104475:	68 20 4e 11 80       	push   $0x80114e20
8010447a:	e8 bf 0c 00 00       	call   8010513e <release>
8010447f:	83 c4 10             	add    $0x10,%esp
80104482:	e8 c5 e7 ff ff       	call   80102c4c <kalloc>
80104487:	89 c2                	mov    %eax,%edx
80104489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010448c:	89 50 08             	mov    %edx,0x8(%eax)
8010448f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104492:	8b 40 08             	mov    0x8(%eax),%eax
80104495:	85 c0                	test   %eax,%eax
80104497:	75 11                	jne    801044aa <allocproc+0xa7>
80104499:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
801044a3:	b8 00 00 00 00       	mov    $0x0,%eax
801044a8:	eb 5d                	jmp    80104507 <allocproc+0x104>
801044aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ad:	8b 40 08             	mov    0x8(%eax),%eax
801044b0:	05 00 10 00 00       	add    $0x1000,%eax
801044b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
801044b8:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
801044bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044bf:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044c2:	89 50 1c             	mov    %edx,0x1c(%eax)
801044c5:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
801044c9:	ba 9a 68 10 80       	mov    $0x8010689a,%edx
801044ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801044d1:	89 10                	mov    %edx,(%eax)
801044d3:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
801044d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044da:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044dd:	89 50 20             	mov    %edx,0x20(%eax)
801044e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e3:	8b 40 20             	mov    0x20(%eax),%eax
801044e6:	83 ec 04             	sub    $0x4,%esp
801044e9:	6a 14                	push   $0x14
801044eb:	6a 00                	push   $0x0
801044ed:	50                   	push   %eax
801044ee:	e8 59 0e 00 00       	call   8010534c <memset>
801044f3:	83 c4 10             	add    $0x10,%esp
801044f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f9:	8b 40 20             	mov    0x20(%eax),%eax
801044fc:	ba 6d 4c 10 80       	mov    $0x80104c6d,%edx
80104501:	89 50 10             	mov    %edx,0x10(%eax)
80104504:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104507:	c9                   	leave  
80104508:	c3                   	ret    

80104509 <userinit>:
80104509:	55                   	push   %ebp
8010450a:	89 e5                	mov    %esp,%ebp
8010450c:	83 ec 18             	sub    $0x18,%esp
8010450f:	e8 ef fe ff ff       	call   80104403 <allocproc>
80104514:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104517:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010451a:	a3 44 c6 10 80       	mov    %eax,0x8010c644
8010451f:	e8 11 3c 00 00       	call   80108135 <setupkvm>
80104524:	89 c2                	mov    %eax,%edx
80104526:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104529:	89 50 04             	mov    %edx,0x4(%eax)
8010452c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452f:	8b 40 04             	mov    0x4(%eax),%eax
80104532:	85 c0                	test   %eax,%eax
80104534:	75 0d                	jne    80104543 <userinit+0x3a>
80104536:	83 ec 0c             	sub    $0xc,%esp
80104539:	68 48 8c 10 80       	push   $0x80108c48
8010453e:	e8 55 c0 ff ff       	call   80100598 <panic>
80104543:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104548:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010454b:	8b 40 04             	mov    0x4(%eax),%eax
8010454e:	83 ec 04             	sub    $0x4,%esp
80104551:	52                   	push   %edx
80104552:	68 e0 c4 10 80       	push   $0x8010c4e0
80104557:	50                   	push   %eax
80104558:	e8 0c 3e 00 00       	call   80108369 <inituvm>
8010455d:	83 c4 10             	add    $0x10,%esp
80104560:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104563:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
80104569:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010456c:	8b 40 1c             	mov    0x1c(%eax),%eax
8010456f:	83 ec 04             	sub    $0x4,%esp
80104572:	6a 4c                	push   $0x4c
80104574:	6a 00                	push   $0x0
80104576:	50                   	push   %eax
80104577:	e8 d0 0d 00 00       	call   8010534c <memset>
8010457c:	83 c4 10             	add    $0x10,%esp
8010457f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104582:	8b 40 1c             	mov    0x1c(%eax),%eax
80104585:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
8010458b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104591:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
80104597:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010459a:	8b 40 1c             	mov    0x1c(%eax),%eax
8010459d:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045a0:	8b 52 1c             	mov    0x1c(%edx),%edx
801045a3:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045a7:	66 89 50 28          	mov    %dx,0x28(%eax)
801045ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ae:	8b 40 1c             	mov    0x1c(%eax),%eax
801045b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045b4:	8b 52 1c             	mov    0x1c(%edx),%edx
801045b7:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045bb:	66 89 50 48          	mov    %dx,0x48(%eax)
801045bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045c2:	8b 40 1c             	mov    0x1c(%eax),%eax
801045c5:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
801045cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045cf:	8b 40 1c             	mov    0x1c(%eax),%eax
801045d2:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
801045d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045dc:	8b 40 1c             	mov    0x1c(%eax),%eax
801045df:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
801045e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e9:	83 c0 70             	add    $0x70,%eax
801045ec:	83 ec 04             	sub    $0x4,%esp
801045ef:	6a 10                	push   $0x10
801045f1:	68 61 8c 10 80       	push   $0x80108c61
801045f6:	50                   	push   %eax
801045f7:	e8 53 0f 00 00       	call   8010554f <safestrcpy>
801045fc:	83 c4 10             	add    $0x10,%esp
801045ff:	83 ec 0c             	sub    $0xc,%esp
80104602:	68 6a 8c 10 80       	push   $0x80108c6a
80104607:	e8 fe de ff ff       	call   8010250a <namei>
8010460c:	83 c4 10             	add    $0x10,%esp
8010460f:	89 c2                	mov    %eax,%edx
80104611:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104614:	89 50 6c             	mov    %edx,0x6c(%eax)
80104617:	83 ec 0c             	sub    $0xc,%esp
8010461a:	68 20 4e 11 80       	push   $0x80114e20
8010461f:	e8 ae 0a 00 00       	call   801050d2 <acquire>
80104624:	83 c4 10             	add    $0x10,%esp
80104627:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010462a:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
80104631:	83 ec 0c             	sub    $0xc,%esp
80104634:	68 20 4e 11 80       	push   $0x80114e20
80104639:	e8 00 0b 00 00       	call   8010513e <release>
8010463e:	83 c4 10             	add    $0x10,%esp
80104641:	90                   	nop
80104642:	c9                   	leave  
80104643:	c3                   	ret    

80104644 <growproc>:
80104644:	55                   	push   %ebp
80104645:	89 e5                	mov    %esp,%ebp
80104647:	83 ec 18             	sub    $0x18,%esp
8010464a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104650:	8b 00                	mov    (%eax),%eax
80104652:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104655:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104659:	7e 31                	jle    8010468c <growproc+0x48>
8010465b:	8b 55 08             	mov    0x8(%ebp),%edx
8010465e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104661:	01 c2                	add    %eax,%edx
80104663:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104669:	8b 40 04             	mov    0x4(%eax),%eax
8010466c:	83 ec 04             	sub    $0x4,%esp
8010466f:	52                   	push   %edx
80104670:	ff 75 f4             	pushl  -0xc(%ebp)
80104673:	50                   	push   %eax
80104674:	e8 2d 3e 00 00       	call   801084a6 <allocuvm>
80104679:	83 c4 10             	add    $0x10,%esp
8010467c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010467f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104683:	75 3e                	jne    801046c3 <growproc+0x7f>
80104685:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010468a:	eb 59                	jmp    801046e5 <growproc+0xa1>
8010468c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104690:	79 31                	jns    801046c3 <growproc+0x7f>
80104692:	8b 55 08             	mov    0x8(%ebp),%edx
80104695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104698:	01 c2                	add    %eax,%edx
8010469a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046a0:	8b 40 04             	mov    0x4(%eax),%eax
801046a3:	83 ec 04             	sub    $0x4,%esp
801046a6:	52                   	push   %edx
801046a7:	ff 75 f4             	pushl  -0xc(%ebp)
801046aa:	50                   	push   %eax
801046ab:	e8 fb 3e 00 00       	call   801085ab <deallocuvm>
801046b0:	83 c4 10             	add    $0x10,%esp
801046b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801046b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801046ba:	75 07                	jne    801046c3 <growproc+0x7f>
801046bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046c1:	eb 22                	jmp    801046e5 <growproc+0xa1>
801046c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046cc:	89 10                	mov    %edx,(%eax)
801046ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046d4:	83 ec 0c             	sub    $0xc,%esp
801046d7:	50                   	push   %eax
801046d8:	e8 14 3b 00 00       	call   801081f1 <switchuvm>
801046dd:	83 c4 10             	add    $0x10,%esp
801046e0:	b8 00 00 00 00       	mov    $0x0,%eax
801046e5:	c9                   	leave  
801046e6:	c3                   	ret    

801046e7 <fork>:
801046e7:	55                   	push   %ebp
801046e8:	89 e5                	mov    %esp,%ebp
801046ea:	57                   	push   %edi
801046eb:	56                   	push   %esi
801046ec:	53                   	push   %ebx
801046ed:	83 ec 1c             	sub    $0x1c,%esp
801046f0:	e8 0e fd ff ff       	call   80104403 <allocproc>
801046f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801046f8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801046fc:	75 0a                	jne    80104708 <fork+0x21>
801046fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104703:	e9 68 01 00 00       	jmp    80104870 <fork+0x189>
80104708:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010470e:	8b 10                	mov    (%eax),%edx
80104710:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104716:	8b 40 04             	mov    0x4(%eax),%eax
80104719:	83 ec 08             	sub    $0x8,%esp
8010471c:	52                   	push   %edx
8010471d:	50                   	push   %eax
8010471e:	e8 fc 3f 00 00       	call   8010871f <copyuvm>
80104723:	83 c4 10             	add    $0x10,%esp
80104726:	89 c2                	mov    %eax,%edx
80104728:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010472b:	89 50 04             	mov    %edx,0x4(%eax)
8010472e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104731:	8b 40 04             	mov    0x4(%eax),%eax
80104734:	85 c0                	test   %eax,%eax
80104736:	75 30                	jne    80104768 <fork+0x81>
80104738:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010473b:	8b 40 08             	mov    0x8(%eax),%eax
8010473e:	83 ec 0c             	sub    $0xc,%esp
80104741:	50                   	push   %eax
80104742:	e8 6b e4 ff ff       	call   80102bb2 <kfree>
80104747:	83 c4 10             	add    $0x10,%esp
8010474a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010474d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104754:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104757:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
8010475e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104763:	e9 08 01 00 00       	jmp    80104870 <fork+0x189>
80104768:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010476e:	8b 10                	mov    (%eax),%edx
80104770:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104773:	89 10                	mov    %edx,(%eax)
80104775:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010477c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010477f:	89 50 18             	mov    %edx,0x18(%eax)
80104782:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104785:	8b 50 1c             	mov    0x1c(%eax),%edx
80104788:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104791:	89 c3                	mov    %eax,%ebx
80104793:	b8 13 00 00 00       	mov    $0x13,%eax
80104798:	89 d7                	mov    %edx,%edi
8010479a:	89 de                	mov    %ebx,%esi
8010479c:	89 c1                	mov    %eax,%ecx
8010479e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
801047a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047a3:	8b 40 1c             	mov    0x1c(%eax),%eax
801047a6:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801047ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801047b4:	eb 43                	jmp    801047f9 <fork+0x112>
801047b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047bf:	83 c2 08             	add    $0x8,%edx
801047c2:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801047c6:	85 c0                	test   %eax,%eax
801047c8:	74 2b                	je     801047f5 <fork+0x10e>
801047ca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047d3:	83 c2 08             	add    $0x8,%edx
801047d6:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801047da:	83 ec 0c             	sub    $0xc,%esp
801047dd:	50                   	push   %eax
801047de:	e8 6e c8 ff ff       	call   80101051 <filedup>
801047e3:	83 c4 10             	add    $0x10,%esp
801047e6:	89 c1                	mov    %eax,%ecx
801047e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047ee:	83 c2 08             	add    $0x8,%edx
801047f1:	89 4c 90 0c          	mov    %ecx,0xc(%eax,%edx,4)
801047f5:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801047f9:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801047fd:	7e b7                	jle    801047b6 <fork+0xcf>
801047ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104805:	8b 40 6c             	mov    0x6c(%eax),%eax
80104808:	83 ec 0c             	sub    $0xc,%esp
8010480b:	50                   	push   %eax
8010480c:	e8 9f d1 ff ff       	call   801019b0 <idup>
80104811:	83 c4 10             	add    $0x10,%esp
80104814:	89 c2                	mov    %eax,%edx
80104816:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104819:	89 50 6c             	mov    %edx,0x6c(%eax)
8010481c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104822:	8d 50 70             	lea    0x70(%eax),%edx
80104825:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104828:	83 c0 70             	add    $0x70,%eax
8010482b:	83 ec 04             	sub    $0x4,%esp
8010482e:	6a 10                	push   $0x10
80104830:	52                   	push   %edx
80104831:	50                   	push   %eax
80104832:	e8 18 0d 00 00       	call   8010554f <safestrcpy>
80104837:	83 c4 10             	add    $0x10,%esp
8010483a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010483d:	8b 40 14             	mov    0x14(%eax),%eax
80104840:	89 45 dc             	mov    %eax,-0x24(%ebp)
80104843:	83 ec 0c             	sub    $0xc,%esp
80104846:	68 20 4e 11 80       	push   $0x80114e20
8010484b:	e8 82 08 00 00       	call   801050d2 <acquire>
80104850:	83 c4 10             	add    $0x10,%esp
80104853:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104856:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
8010485d:	83 ec 0c             	sub    $0xc,%esp
80104860:	68 20 4e 11 80       	push   $0x80114e20
80104865:	e8 d4 08 00 00       	call   8010513e <release>
8010486a:	83 c4 10             	add    $0x10,%esp
8010486d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104870:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104873:	5b                   	pop    %ebx
80104874:	5e                   	pop    %esi
80104875:	5f                   	pop    %edi
80104876:	5d                   	pop    %ebp
80104877:	c3                   	ret    

80104878 <exit>:
80104878:	55                   	push   %ebp
80104879:	89 e5                	mov    %esp,%ebp
8010487b:	83 ec 18             	sub    $0x18,%esp
8010487e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104885:	a1 44 c6 10 80       	mov    0x8010c644,%eax
8010488a:	39 c2                	cmp    %eax,%edx
8010488c:	75 0d                	jne    8010489b <exit+0x23>
8010488e:	83 ec 0c             	sub    $0xc,%esp
80104891:	68 6c 8c 10 80       	push   $0x80108c6c
80104896:	e8 fd bc ff ff       	call   80100598 <panic>
8010489b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801048a2:	eb 48                	jmp    801048ec <exit+0x74>
801048a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048ad:	83 c2 08             	add    $0x8,%edx
801048b0:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801048b4:	85 c0                	test   %eax,%eax
801048b6:	74 30                	je     801048e8 <exit+0x70>
801048b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048be:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048c1:	83 c2 08             	add    $0x8,%edx
801048c4:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801048c8:	83 ec 0c             	sub    $0xc,%esp
801048cb:	50                   	push   %eax
801048cc:	e8 d1 c7 ff ff       	call   801010a2 <fileclose>
801048d1:	83 c4 10             	add    $0x10,%esp
801048d4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048da:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048dd:	83 c2 08             	add    $0x8,%edx
801048e0:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801048e7:	00 
801048e8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801048ec:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801048f0:	7e b2                	jle    801048a4 <exit+0x2c>
801048f2:	e8 e0 ec ff ff       	call   801035d7 <begin_op>
801048f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048fd:	8b 40 6c             	mov    0x6c(%eax),%eax
80104900:	83 ec 0c             	sub    $0xc,%esp
80104903:	50                   	push   %eax
80104904:	e8 34 d2 ff ff       	call   80101b3d <iput>
80104909:	83 c4 10             	add    $0x10,%esp
8010490c:	e8 52 ed ff ff       	call   80103663 <end_op>
80104911:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104917:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
8010491e:	83 ec 0c             	sub    $0xc,%esp
80104921:	68 20 4e 11 80       	push   $0x80114e20
80104926:	e8 a7 07 00 00       	call   801050d2 <acquire>
8010492b:	83 c4 10             	add    $0x10,%esp
8010492e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104934:	8b 40 18             	mov    0x18(%eax),%eax
80104937:	83 ec 0c             	sub    $0xc,%esp
8010493a:	50                   	push   %eax
8010493b:	e8 1f 04 00 00       	call   80104d5f <wakeup1>
80104940:	83 c4 10             	add    $0x10,%esp
80104943:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
8010494a:	eb 3c                	jmp    80104988 <exit+0x110>
8010494c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010494f:	8b 50 18             	mov    0x18(%eax),%edx
80104952:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104958:	39 c2                	cmp    %eax,%edx
8010495a:	75 28                	jne    80104984 <exit+0x10c>
8010495c:	8b 15 44 c6 10 80    	mov    0x8010c644,%edx
80104962:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104965:	89 50 18             	mov    %edx,0x18(%eax)
80104968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496b:	8b 40 10             	mov    0x10(%eax),%eax
8010496e:	83 f8 05             	cmp    $0x5,%eax
80104971:	75 11                	jne    80104984 <exit+0x10c>
80104973:	a1 44 c6 10 80       	mov    0x8010c644,%eax
80104978:	83 ec 0c             	sub    $0xc,%esp
8010497b:	50                   	push   %eax
8010497c:	e8 de 03 00 00       	call   80104d5f <wakeup1>
80104981:	83 c4 10             	add    $0x10,%esp
80104984:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104988:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
8010498f:	72 bb                	jb     8010494c <exit+0xd4>
80104991:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104997:	c7 40 10 05 00 00 00 	movl   $0x5,0x10(%eax)
8010499e:	e8 d3 01 00 00       	call   80104b76 <sched>
801049a3:	83 ec 0c             	sub    $0xc,%esp
801049a6:	68 79 8c 10 80       	push   $0x80108c79
801049ab:	e8 e8 bb ff ff       	call   80100598 <panic>

801049b0 <wait>:
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	83 ec 18             	sub    $0x18,%esp
801049b6:	83 ec 0c             	sub    $0xc,%esp
801049b9:	68 20 4e 11 80       	push   $0x80114e20
801049be:	e8 0f 07 00 00       	call   801050d2 <acquire>
801049c3:	83 c4 10             	add    $0x10,%esp
801049c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801049cd:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
801049d4:	e9 a6 00 00 00       	jmp    80104a7f <wait+0xcf>
801049d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049dc:	8b 50 18             	mov    0x18(%eax),%edx
801049df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049e5:	39 c2                	cmp    %eax,%edx
801049e7:	0f 85 8d 00 00 00    	jne    80104a7a <wait+0xca>
801049ed:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
801049f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f7:	8b 40 10             	mov    0x10(%eax),%eax
801049fa:	83 f8 05             	cmp    $0x5,%eax
801049fd:	75 7c                	jne    80104a7b <wait+0xcb>
801049ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a02:	8b 40 14             	mov    0x14(%eax),%eax
80104a05:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a0b:	8b 40 08             	mov    0x8(%eax),%eax
80104a0e:	83 ec 0c             	sub    $0xc,%esp
80104a11:	50                   	push   %eax
80104a12:	e8 9b e1 ff ff       	call   80102bb2 <kfree>
80104a17:	83 c4 10             	add    $0x10,%esp
80104a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a1d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a27:	8b 40 04             	mov    0x4(%eax),%eax
80104a2a:	83 ec 0c             	sub    $0xc,%esp
80104a2d:	50                   	push   %eax
80104a2e:	e8 12 3c 00 00       	call   80108645 <freevm>
80104a33:	83 c4 10             	add    $0x10,%esp
80104a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a39:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a43:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a4d:	c6 40 70 00          	movb   $0x0,0x70(%eax)
80104a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a54:	c7 40 28 00 00 00 00 	movl   $0x0,0x28(%eax)
80104a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a5e:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
80104a65:	83 ec 0c             	sub    $0xc,%esp
80104a68:	68 20 4e 11 80       	push   $0x80114e20
80104a6d:	e8 cc 06 00 00       	call   8010513e <release>
80104a72:	83 c4 10             	add    $0x10,%esp
80104a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a78:	eb 58                	jmp    80104ad2 <wait+0x122>
80104a7a:	90                   	nop
80104a7b:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104a7f:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104a86:	0f 82 4d ff ff ff    	jb     801049d9 <wait+0x29>
80104a8c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104a90:	74 0d                	je     80104a9f <wait+0xef>
80104a92:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a98:	8b 40 28             	mov    0x28(%eax),%eax
80104a9b:	85 c0                	test   %eax,%eax
80104a9d:	74 17                	je     80104ab6 <wait+0x106>
80104a9f:	83 ec 0c             	sub    $0xc,%esp
80104aa2:	68 20 4e 11 80       	push   $0x80114e20
80104aa7:	e8 92 06 00 00       	call   8010513e <release>
80104aac:	83 c4 10             	add    $0x10,%esp
80104aaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ab4:	eb 1c                	jmp    80104ad2 <wait+0x122>
80104ab6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104abc:	83 ec 08             	sub    $0x8,%esp
80104abf:	68 20 4e 11 80       	push   $0x80114e20
80104ac4:	50                   	push   %eax
80104ac5:	e8 e9 01 00 00       	call   80104cb3 <sleep>
80104aca:	83 c4 10             	add    $0x10,%esp
80104acd:	e9 f4 fe ff ff       	jmp    801049c6 <wait+0x16>
80104ad2:	c9                   	leave  
80104ad3:	c3                   	ret    

80104ad4 <scheduler>:
80104ad4:	55                   	push   %ebp
80104ad5:	89 e5                	mov    %esp,%ebp
80104ad7:	83 ec 18             	sub    $0x18,%esp
80104ada:	e8 ff f8 ff ff       	call   801043de <sti>
80104adf:	83 ec 0c             	sub    $0xc,%esp
80104ae2:	68 20 4e 11 80       	push   $0x80114e20
80104ae7:	e8 e6 05 00 00       	call   801050d2 <acquire>
80104aec:	83 c4 10             	add    $0x10,%esp
80104aef:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
80104af6:	eb 60                	jmp    80104b58 <scheduler+0x84>
80104af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104afb:	8b 40 10             	mov    0x10(%eax),%eax
80104afe:	83 f8 03             	cmp    $0x3,%eax
80104b01:	75 50                	jne    80104b53 <scheduler+0x7f>
80104b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b06:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
80104b0c:	83 ec 0c             	sub    $0xc,%esp
80104b0f:	ff 75 f4             	pushl  -0xc(%ebp)
80104b12:	e8 da 36 00 00       	call   801081f1 <switchuvm>
80104b17:	83 c4 10             	add    $0x10,%esp
80104b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b1d:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
80104b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b27:	8b 40 20             	mov    0x20(%eax),%eax
80104b2a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104b31:	83 c2 04             	add    $0x4,%edx
80104b34:	83 ec 08             	sub    $0x8,%esp
80104b37:	50                   	push   %eax
80104b38:	52                   	push   %edx
80104b39:	e8 82 0a 00 00       	call   801055c0 <swtch>
80104b3e:	83 c4 10             	add    $0x10,%esp
80104b41:	e8 92 36 00 00       	call   801081d8 <switchkvm>
80104b46:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104b4d:	00 00 00 00 
80104b51:	eb 01                	jmp    80104b54 <scheduler+0x80>
80104b53:	90                   	nop
80104b54:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104b58:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104b5f:	72 97                	jb     80104af8 <scheduler+0x24>
80104b61:	83 ec 0c             	sub    $0xc,%esp
80104b64:	68 20 4e 11 80       	push   $0x80114e20
80104b69:	e8 d0 05 00 00       	call   8010513e <release>
80104b6e:	83 c4 10             	add    $0x10,%esp
80104b71:	e9 64 ff ff ff       	jmp    80104ada <scheduler+0x6>

80104b76 <sched>:
80104b76:	55                   	push   %ebp
80104b77:	89 e5                	mov    %esp,%ebp
80104b79:	83 ec 18             	sub    $0x18,%esp
80104b7c:	83 ec 0c             	sub    $0xc,%esp
80104b7f:	68 20 4e 11 80       	push   $0x80114e20
80104b84:	e8 81 06 00 00       	call   8010520a <holding>
80104b89:	83 c4 10             	add    $0x10,%esp
80104b8c:	85 c0                	test   %eax,%eax
80104b8e:	75 0d                	jne    80104b9d <sched+0x27>
80104b90:	83 ec 0c             	sub    $0xc,%esp
80104b93:	68 85 8c 10 80       	push   $0x80108c85
80104b98:	e8 fb b9 ff ff       	call   80100598 <panic>
80104b9d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ba3:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104ba9:	83 f8 01             	cmp    $0x1,%eax
80104bac:	74 0d                	je     80104bbb <sched+0x45>
80104bae:	83 ec 0c             	sub    $0xc,%esp
80104bb1:	68 97 8c 10 80       	push   $0x80108c97
80104bb6:	e8 dd b9 ff ff       	call   80100598 <panic>
80104bbb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bc1:	8b 40 10             	mov    0x10(%eax),%eax
80104bc4:	83 f8 04             	cmp    $0x4,%eax
80104bc7:	75 0d                	jne    80104bd6 <sched+0x60>
80104bc9:	83 ec 0c             	sub    $0xc,%esp
80104bcc:	68 a3 8c 10 80       	push   $0x80108ca3
80104bd1:	e8 c2 b9 ff ff       	call   80100598 <panic>
80104bd6:	e8 f3 f7 ff ff       	call   801043ce <readeflags>
80104bdb:	25 00 02 00 00       	and    $0x200,%eax
80104be0:	85 c0                	test   %eax,%eax
80104be2:	74 0d                	je     80104bf1 <sched+0x7b>
80104be4:	83 ec 0c             	sub    $0xc,%esp
80104be7:	68 b1 8c 10 80       	push   $0x80108cb1
80104bec:	e8 a7 b9 ff ff       	call   80100598 <panic>
80104bf1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bf7:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104bfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104c00:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c06:	8b 40 04             	mov    0x4(%eax),%eax
80104c09:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c10:	83 c2 20             	add    $0x20,%edx
80104c13:	83 ec 08             	sub    $0x8,%esp
80104c16:	50                   	push   %eax
80104c17:	52                   	push   %edx
80104c18:	e8 a3 09 00 00       	call   801055c0 <swtch>
80104c1d:	83 c4 10             	add    $0x10,%esp
80104c20:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c26:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c29:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
80104c2f:	90                   	nop
80104c30:	c9                   	leave  
80104c31:	c3                   	ret    

80104c32 <yield>:
80104c32:	55                   	push   %ebp
80104c33:	89 e5                	mov    %esp,%ebp
80104c35:	83 ec 08             	sub    $0x8,%esp
80104c38:	83 ec 0c             	sub    $0xc,%esp
80104c3b:	68 20 4e 11 80       	push   $0x80114e20
80104c40:	e8 8d 04 00 00       	call   801050d2 <acquire>
80104c45:	83 c4 10             	add    $0x10,%esp
80104c48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c4e:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
80104c55:	e8 1c ff ff ff       	call   80104b76 <sched>
80104c5a:	83 ec 0c             	sub    $0xc,%esp
80104c5d:	68 20 4e 11 80       	push   $0x80114e20
80104c62:	e8 d7 04 00 00       	call   8010513e <release>
80104c67:	83 c4 10             	add    $0x10,%esp
80104c6a:	90                   	nop
80104c6b:	c9                   	leave  
80104c6c:	c3                   	ret    

80104c6d <forkret>:
80104c6d:	55                   	push   %ebp
80104c6e:	89 e5                	mov    %esp,%ebp
80104c70:	83 ec 08             	sub    $0x8,%esp
80104c73:	83 ec 0c             	sub    $0xc,%esp
80104c76:	68 20 4e 11 80       	push   $0x80114e20
80104c7b:	e8 be 04 00 00       	call   8010513e <release>
80104c80:	83 c4 10             	add    $0x10,%esp
80104c83:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104c88:	85 c0                	test   %eax,%eax
80104c8a:	74 24                	je     80104cb0 <forkret+0x43>
80104c8c:	c7 05 08 c0 10 80 00 	movl   $0x0,0x8010c008
80104c93:	00 00 00 
80104c96:	83 ec 0c             	sub    $0xc,%esp
80104c99:	6a 01                	push   $0x1
80104c9b:	e8 d5 c9 ff ff       	call   80101675 <iinit>
80104ca0:	83 c4 10             	add    $0x10,%esp
80104ca3:	83 ec 0c             	sub    $0xc,%esp
80104ca6:	6a 01                	push   $0x1
80104ca8:	e8 0c e7 ff ff       	call   801033b9 <initlog>
80104cad:	83 c4 10             	add    $0x10,%esp
80104cb0:	90                   	nop
80104cb1:	c9                   	leave  
80104cb2:	c3                   	ret    

80104cb3 <sleep>:
80104cb3:	55                   	push   %ebp
80104cb4:	89 e5                	mov    %esp,%ebp
80104cb6:	83 ec 08             	sub    $0x8,%esp
80104cb9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cbf:	85 c0                	test   %eax,%eax
80104cc1:	75 0d                	jne    80104cd0 <sleep+0x1d>
80104cc3:	83 ec 0c             	sub    $0xc,%esp
80104cc6:	68 c5 8c 10 80       	push   $0x80108cc5
80104ccb:	e8 c8 b8 ff ff       	call   80100598 <panic>
80104cd0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104cd4:	75 0d                	jne    80104ce3 <sleep+0x30>
80104cd6:	83 ec 0c             	sub    $0xc,%esp
80104cd9:	68 cb 8c 10 80       	push   $0x80108ccb
80104cde:	e8 b5 b8 ff ff       	call   80100598 <panic>
80104ce3:	81 7d 0c 20 4e 11 80 	cmpl   $0x80114e20,0xc(%ebp)
80104cea:	74 1e                	je     80104d0a <sleep+0x57>
80104cec:	83 ec 0c             	sub    $0xc,%esp
80104cef:	68 20 4e 11 80       	push   $0x80114e20
80104cf4:	e8 d9 03 00 00       	call   801050d2 <acquire>
80104cf9:	83 c4 10             	add    $0x10,%esp
80104cfc:	83 ec 0c             	sub    $0xc,%esp
80104cff:	ff 75 0c             	pushl  0xc(%ebp)
80104d02:	e8 37 04 00 00       	call   8010513e <release>
80104d07:	83 c4 10             	add    $0x10,%esp
80104d0a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d10:	8b 55 08             	mov    0x8(%ebp),%edx
80104d13:	89 50 24             	mov    %edx,0x24(%eax)
80104d16:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d1c:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
80104d23:	e8 4e fe ff ff       	call   80104b76 <sched>
80104d28:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d2e:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
80104d35:	81 7d 0c 20 4e 11 80 	cmpl   $0x80114e20,0xc(%ebp)
80104d3c:	74 1e                	je     80104d5c <sleep+0xa9>
80104d3e:	83 ec 0c             	sub    $0xc,%esp
80104d41:	68 20 4e 11 80       	push   $0x80114e20
80104d46:	e8 f3 03 00 00       	call   8010513e <release>
80104d4b:	83 c4 10             	add    $0x10,%esp
80104d4e:	83 ec 0c             	sub    $0xc,%esp
80104d51:	ff 75 0c             	pushl  0xc(%ebp)
80104d54:	e8 79 03 00 00       	call   801050d2 <acquire>
80104d59:	83 c4 10             	add    $0x10,%esp
80104d5c:	90                   	nop
80104d5d:	c9                   	leave  
80104d5e:	c3                   	ret    

80104d5f <wakeup1>:
80104d5f:	55                   	push   %ebp
80104d60:	89 e5                	mov    %esp,%ebp
80104d62:	83 ec 10             	sub    $0x10,%esp
80104d65:	c7 45 fc 54 4e 11 80 	movl   $0x80114e54,-0x4(%ebp)
80104d6c:	eb 24                	jmp    80104d92 <wakeup1+0x33>
80104d6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d71:	8b 40 10             	mov    0x10(%eax),%eax
80104d74:	83 f8 02             	cmp    $0x2,%eax
80104d77:	75 15                	jne    80104d8e <wakeup1+0x2f>
80104d79:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d7c:	8b 40 24             	mov    0x24(%eax),%eax
80104d7f:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d82:	75 0a                	jne    80104d8e <wakeup1+0x2f>
80104d84:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d87:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
80104d8e:	83 6d fc 80          	subl   $0xffffff80,-0x4(%ebp)
80104d92:	81 7d fc 54 6e 11 80 	cmpl   $0x80116e54,-0x4(%ebp)
80104d99:	72 d3                	jb     80104d6e <wakeup1+0xf>
80104d9b:	90                   	nop
80104d9c:	c9                   	leave  
80104d9d:	c3                   	ret    

80104d9e <wakeup>:
80104d9e:	55                   	push   %ebp
80104d9f:	89 e5                	mov    %esp,%ebp
80104da1:	83 ec 08             	sub    $0x8,%esp
80104da4:	83 ec 0c             	sub    $0xc,%esp
80104da7:	68 20 4e 11 80       	push   $0x80114e20
80104dac:	e8 21 03 00 00       	call   801050d2 <acquire>
80104db1:	83 c4 10             	add    $0x10,%esp
80104db4:	83 ec 0c             	sub    $0xc,%esp
80104db7:	ff 75 08             	pushl  0x8(%ebp)
80104dba:	e8 a0 ff ff ff       	call   80104d5f <wakeup1>
80104dbf:	83 c4 10             	add    $0x10,%esp
80104dc2:	83 ec 0c             	sub    $0xc,%esp
80104dc5:	68 20 4e 11 80       	push   $0x80114e20
80104dca:	e8 6f 03 00 00       	call   8010513e <release>
80104dcf:	83 c4 10             	add    $0x10,%esp
80104dd2:	90                   	nop
80104dd3:	c9                   	leave  
80104dd4:	c3                   	ret    

80104dd5 <kill>:
80104dd5:	55                   	push   %ebp
80104dd6:	89 e5                	mov    %esp,%ebp
80104dd8:	83 ec 18             	sub    $0x18,%esp
80104ddb:	83 ec 0c             	sub    $0xc,%esp
80104dde:	68 20 4e 11 80       	push   $0x80114e20
80104de3:	e8 ea 02 00 00       	call   801050d2 <acquire>
80104de8:	83 c4 10             	add    $0x10,%esp
80104deb:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
80104df2:	eb 45                	jmp    80104e39 <kill+0x64>
80104df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104df7:	8b 40 14             	mov    0x14(%eax),%eax
80104dfa:	3b 45 08             	cmp    0x8(%ebp),%eax
80104dfd:	75 36                	jne    80104e35 <kill+0x60>
80104dff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e02:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80104e09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e0c:	8b 40 10             	mov    0x10(%eax),%eax
80104e0f:	83 f8 02             	cmp    $0x2,%eax
80104e12:	75 0a                	jne    80104e1e <kill+0x49>
80104e14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e17:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
80104e1e:	83 ec 0c             	sub    $0xc,%esp
80104e21:	68 20 4e 11 80       	push   $0x80114e20
80104e26:	e8 13 03 00 00       	call   8010513e <release>
80104e2b:	83 c4 10             	add    $0x10,%esp
80104e2e:	b8 00 00 00 00       	mov    $0x0,%eax
80104e33:	eb 22                	jmp    80104e57 <kill+0x82>
80104e35:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104e39:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104e40:	72 b2                	jb     80104df4 <kill+0x1f>
80104e42:	83 ec 0c             	sub    $0xc,%esp
80104e45:	68 20 4e 11 80       	push   $0x80114e20
80104e4a:	e8 ef 02 00 00       	call   8010513e <release>
80104e4f:	83 c4 10             	add    $0x10,%esp
80104e52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e57:	c9                   	leave  
80104e58:	c3                   	ret    

80104e59 <procdump>:
80104e59:	55                   	push   %ebp
80104e5a:	89 e5                	mov    %esp,%ebp
80104e5c:	83 ec 48             	sub    $0x48,%esp
80104e5f:	c7 45 f0 54 4e 11 80 	movl   $0x80114e54,-0x10(%ebp)
80104e66:	e9 d7 00 00 00       	jmp    80104f42 <procdump+0xe9>
80104e6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e6e:	8b 40 10             	mov    0x10(%eax),%eax
80104e71:	85 c0                	test   %eax,%eax
80104e73:	0f 84 c4 00 00 00    	je     80104f3d <procdump+0xe4>
80104e79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e7c:	8b 40 10             	mov    0x10(%eax),%eax
80104e7f:	83 f8 05             	cmp    $0x5,%eax
80104e82:	77 23                	ja     80104ea7 <procdump+0x4e>
80104e84:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e87:	8b 40 10             	mov    0x10(%eax),%eax
80104e8a:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
80104e91:	85 c0                	test   %eax,%eax
80104e93:	74 12                	je     80104ea7 <procdump+0x4e>
80104e95:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e98:	8b 40 10             	mov    0x10(%eax),%eax
80104e9b:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
80104ea2:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104ea5:	eb 07                	jmp    80104eae <procdump+0x55>
80104ea7:	c7 45 ec dc 8c 10 80 	movl   $0x80108cdc,-0x14(%ebp)
80104eae:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eb1:	8d 50 70             	lea    0x70(%eax),%edx
80104eb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eb7:	8b 40 14             	mov    0x14(%eax),%eax
80104eba:	52                   	push   %edx
80104ebb:	ff 75 ec             	pushl  -0x14(%ebp)
80104ebe:	50                   	push   %eax
80104ebf:	68 e0 8c 10 80       	push   $0x80108ce0
80104ec4:	e8 35 b5 ff ff       	call   801003fe <cprintf>
80104ec9:	83 c4 10             	add    $0x10,%esp
80104ecc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ecf:	8b 40 10             	mov    0x10(%eax),%eax
80104ed2:	83 f8 02             	cmp    $0x2,%eax
80104ed5:	75 54                	jne    80104f2b <procdump+0xd2>
80104ed7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eda:	8b 40 20             	mov    0x20(%eax),%eax
80104edd:	8b 40 0c             	mov    0xc(%eax),%eax
80104ee0:	83 c0 08             	add    $0x8,%eax
80104ee3:	89 c2                	mov    %eax,%edx
80104ee5:	83 ec 08             	sub    $0x8,%esp
80104ee8:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104eeb:	50                   	push   %eax
80104eec:	52                   	push   %edx
80104eed:	e8 9e 02 00 00       	call   80105190 <getcallerpcs>
80104ef2:	83 c4 10             	add    $0x10,%esp
80104ef5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104efc:	eb 1c                	jmp    80104f1a <procdump+0xc1>
80104efe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f01:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f05:	83 ec 08             	sub    $0x8,%esp
80104f08:	50                   	push   %eax
80104f09:	68 e9 8c 10 80       	push   $0x80108ce9
80104f0e:	e8 eb b4 ff ff       	call   801003fe <cprintf>
80104f13:	83 c4 10             	add    $0x10,%esp
80104f16:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104f1a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104f1e:	7f 0b                	jg     80104f2b <procdump+0xd2>
80104f20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f23:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f27:	85 c0                	test   %eax,%eax
80104f29:	75 d3                	jne    80104efe <procdump+0xa5>
80104f2b:	83 ec 0c             	sub    $0xc,%esp
80104f2e:	68 ed 8c 10 80       	push   $0x80108ced
80104f33:	e8 c6 b4 ff ff       	call   801003fe <cprintf>
80104f38:	83 c4 10             	add    $0x10,%esp
80104f3b:	eb 01                	jmp    80104f3e <procdump+0xe5>
80104f3d:	90                   	nop
80104f3e:	83 6d f0 80          	subl   $0xffffff80,-0x10(%ebp)
80104f42:	81 7d f0 54 6e 11 80 	cmpl   $0x80116e54,-0x10(%ebp)
80104f49:	0f 82 1c ff ff ff    	jb     80104e6b <procdump+0x12>
80104f4f:	90                   	nop
80104f50:	c9                   	leave  
80104f51:	c3                   	ret    

80104f52 <initsleeplock>:
80104f52:	55                   	push   %ebp
80104f53:	89 e5                	mov    %esp,%ebp
80104f55:	83 ec 08             	sub    $0x8,%esp
80104f58:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5b:	83 c0 04             	add    $0x4,%eax
80104f5e:	83 ec 08             	sub    $0x8,%esp
80104f61:	68 19 8d 10 80       	push   $0x80108d19
80104f66:	50                   	push   %eax
80104f67:	e8 44 01 00 00       	call   801050b0 <initlock>
80104f6c:	83 c4 10             	add    $0x10,%esp
80104f6f:	8b 45 08             	mov    0x8(%ebp),%eax
80104f72:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f75:	89 50 38             	mov    %edx,0x38(%eax)
80104f78:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104f81:	8b 45 08             	mov    0x8(%ebp),%eax
80104f84:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
80104f8b:	90                   	nop
80104f8c:	c9                   	leave  
80104f8d:	c3                   	ret    

80104f8e <acquiresleep>:
80104f8e:	55                   	push   %ebp
80104f8f:	89 e5                	mov    %esp,%ebp
80104f91:	83 ec 08             	sub    $0x8,%esp
80104f94:	8b 45 08             	mov    0x8(%ebp),%eax
80104f97:	83 c0 04             	add    $0x4,%eax
80104f9a:	83 ec 0c             	sub    $0xc,%esp
80104f9d:	50                   	push   %eax
80104f9e:	e8 2f 01 00 00       	call   801050d2 <acquire>
80104fa3:	83 c4 10             	add    $0x10,%esp
80104fa6:	eb 15                	jmp    80104fbd <acquiresleep+0x2f>
80104fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80104fab:	83 c0 04             	add    $0x4,%eax
80104fae:	83 ec 08             	sub    $0x8,%esp
80104fb1:	50                   	push   %eax
80104fb2:	ff 75 08             	pushl  0x8(%ebp)
80104fb5:	e8 f9 fc ff ff       	call   80104cb3 <sleep>
80104fba:	83 c4 10             	add    $0x10,%esp
80104fbd:	8b 45 08             	mov    0x8(%ebp),%eax
80104fc0:	8b 00                	mov    (%eax),%eax
80104fc2:	85 c0                	test   %eax,%eax
80104fc4:	75 e2                	jne    80104fa8 <acquiresleep+0x1a>
80104fc6:	8b 45 08             	mov    0x8(%ebp),%eax
80104fc9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80104fcf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fd5:	8b 50 14             	mov    0x14(%eax),%edx
80104fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80104fdb:	89 50 3c             	mov    %edx,0x3c(%eax)
80104fde:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe1:	83 c0 04             	add    $0x4,%eax
80104fe4:	83 ec 0c             	sub    $0xc,%esp
80104fe7:	50                   	push   %eax
80104fe8:	e8 51 01 00 00       	call   8010513e <release>
80104fed:	83 c4 10             	add    $0x10,%esp
80104ff0:	90                   	nop
80104ff1:	c9                   	leave  
80104ff2:	c3                   	ret    

80104ff3 <releasesleep>:
80104ff3:	55                   	push   %ebp
80104ff4:	89 e5                	mov    %esp,%ebp
80104ff6:	83 ec 08             	sub    $0x8,%esp
80104ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80104ffc:	83 c0 04             	add    $0x4,%eax
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	50                   	push   %eax
80105003:	e8 ca 00 00 00       	call   801050d2 <acquire>
80105008:	83 c4 10             	add    $0x10,%esp
8010500b:	8b 45 08             	mov    0x8(%ebp),%eax
8010500e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105014:	8b 45 08             	mov    0x8(%ebp),%eax
80105017:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
8010501e:	83 ec 0c             	sub    $0xc,%esp
80105021:	ff 75 08             	pushl  0x8(%ebp)
80105024:	e8 75 fd ff ff       	call   80104d9e <wakeup>
80105029:	83 c4 10             	add    $0x10,%esp
8010502c:	8b 45 08             	mov    0x8(%ebp),%eax
8010502f:	83 c0 04             	add    $0x4,%eax
80105032:	83 ec 0c             	sub    $0xc,%esp
80105035:	50                   	push   %eax
80105036:	e8 03 01 00 00       	call   8010513e <release>
8010503b:	83 c4 10             	add    $0x10,%esp
8010503e:	90                   	nop
8010503f:	c9                   	leave  
80105040:	c3                   	ret    

80105041 <holdingsleep>:
80105041:	55                   	push   %ebp
80105042:	89 e5                	mov    %esp,%ebp
80105044:	83 ec 18             	sub    $0x18,%esp
80105047:	8b 45 08             	mov    0x8(%ebp),%eax
8010504a:	83 c0 04             	add    $0x4,%eax
8010504d:	83 ec 0c             	sub    $0xc,%esp
80105050:	50                   	push   %eax
80105051:	e8 7c 00 00 00       	call   801050d2 <acquire>
80105056:	83 c4 10             	add    $0x10,%esp
80105059:	8b 45 08             	mov    0x8(%ebp),%eax
8010505c:	8b 00                	mov    (%eax),%eax
8010505e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105061:	8b 45 08             	mov    0x8(%ebp),%eax
80105064:	83 c0 04             	add    $0x4,%eax
80105067:	83 ec 0c             	sub    $0xc,%esp
8010506a:	50                   	push   %eax
8010506b:	e8 ce 00 00 00       	call   8010513e <release>
80105070:	83 c4 10             	add    $0x10,%esp
80105073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105076:	c9                   	leave  
80105077:	c3                   	ret    

80105078 <readeflags>:
80105078:	55                   	push   %ebp
80105079:	89 e5                	mov    %esp,%ebp
8010507b:	83 ec 10             	sub    $0x10,%esp
8010507e:	9c                   	pushf  
8010507f:	58                   	pop    %eax
80105080:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105083:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105086:	c9                   	leave  
80105087:	c3                   	ret    

80105088 <cli>:
80105088:	55                   	push   %ebp
80105089:	89 e5                	mov    %esp,%ebp
8010508b:	fa                   	cli    
8010508c:	90                   	nop
8010508d:	5d                   	pop    %ebp
8010508e:	c3                   	ret    

8010508f <sti>:
8010508f:	55                   	push   %ebp
80105090:	89 e5                	mov    %esp,%ebp
80105092:	fb                   	sti    
80105093:	90                   	nop
80105094:	5d                   	pop    %ebp
80105095:	c3                   	ret    

80105096 <xchg>:
80105096:	55                   	push   %ebp
80105097:	89 e5                	mov    %esp,%ebp
80105099:	83 ec 10             	sub    $0x10,%esp
8010509c:	8b 55 08             	mov    0x8(%ebp),%edx
8010509f:	8b 45 0c             	mov    0xc(%ebp),%eax
801050a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050a5:	f0 87 02             	lock xchg %eax,(%edx)
801050a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801050ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050ae:	c9                   	leave  
801050af:	c3                   	ret    

801050b0 <initlock>:
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	8b 45 08             	mov    0x8(%ebp),%eax
801050b6:	8b 55 0c             	mov    0xc(%ebp),%edx
801050b9:	89 50 04             	mov    %edx,0x4(%eax)
801050bc:	8b 45 08             	mov    0x8(%ebp),%eax
801050bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801050c5:	8b 45 08             	mov    0x8(%ebp),%eax
801050c8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
801050cf:	90                   	nop
801050d0:	5d                   	pop    %ebp
801050d1:	c3                   	ret    

801050d2 <acquire>:
801050d2:	55                   	push   %ebp
801050d3:	89 e5                	mov    %esp,%ebp
801050d5:	83 ec 08             	sub    $0x8,%esp
801050d8:	e8 57 01 00 00       	call   80105234 <pushcli>
801050dd:	8b 45 08             	mov    0x8(%ebp),%eax
801050e0:	83 ec 0c             	sub    $0xc,%esp
801050e3:	50                   	push   %eax
801050e4:	e8 21 01 00 00       	call   8010520a <holding>
801050e9:	83 c4 10             	add    $0x10,%esp
801050ec:	85 c0                	test   %eax,%eax
801050ee:	74 0d                	je     801050fd <acquire+0x2b>
801050f0:	83 ec 0c             	sub    $0xc,%esp
801050f3:	68 24 8d 10 80       	push   $0x80108d24
801050f8:	e8 9b b4 ff ff       	call   80100598 <panic>
801050fd:	90                   	nop
801050fe:	8b 45 08             	mov    0x8(%ebp),%eax
80105101:	83 ec 08             	sub    $0x8,%esp
80105104:	6a 01                	push   $0x1
80105106:	50                   	push   %eax
80105107:	e8 8a ff ff ff       	call   80105096 <xchg>
8010510c:	83 c4 10             	add    $0x10,%esp
8010510f:	85 c0                	test   %eax,%eax
80105111:	75 eb                	jne    801050fe <acquire+0x2c>
80105113:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80105118:	8b 45 08             	mov    0x8(%ebp),%eax
8010511b:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105122:	89 50 08             	mov    %edx,0x8(%eax)
80105125:	8b 45 08             	mov    0x8(%ebp),%eax
80105128:	83 c0 0c             	add    $0xc,%eax
8010512b:	83 ec 08             	sub    $0x8,%esp
8010512e:	50                   	push   %eax
8010512f:	8d 45 08             	lea    0x8(%ebp),%eax
80105132:	50                   	push   %eax
80105133:	e8 58 00 00 00       	call   80105190 <getcallerpcs>
80105138:	83 c4 10             	add    $0x10,%esp
8010513b:	90                   	nop
8010513c:	c9                   	leave  
8010513d:	c3                   	ret    

8010513e <release>:
8010513e:	55                   	push   %ebp
8010513f:	89 e5                	mov    %esp,%ebp
80105141:	83 ec 08             	sub    $0x8,%esp
80105144:	83 ec 0c             	sub    $0xc,%esp
80105147:	ff 75 08             	pushl  0x8(%ebp)
8010514a:	e8 bb 00 00 00       	call   8010520a <holding>
8010514f:	83 c4 10             	add    $0x10,%esp
80105152:	85 c0                	test   %eax,%eax
80105154:	75 0d                	jne    80105163 <release+0x25>
80105156:	83 ec 0c             	sub    $0xc,%esp
80105159:	68 2c 8d 10 80       	push   $0x80108d2c
8010515e:	e8 35 b4 ff ff       	call   80100598 <panic>
80105163:	8b 45 08             	mov    0x8(%ebp),%eax
80105166:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
8010516d:	8b 45 08             	mov    0x8(%ebp),%eax
80105170:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80105177:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
8010517c:	8b 45 08             	mov    0x8(%ebp),%eax
8010517f:	8b 55 08             	mov    0x8(%ebp),%edx
80105182:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105188:	e8 fe 00 00 00       	call   8010528b <popcli>
8010518d:	90                   	nop
8010518e:	c9                   	leave  
8010518f:	c3                   	ret    

80105190 <getcallerpcs>:
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	83 ec 10             	sub    $0x10,%esp
80105196:	8b 45 08             	mov    0x8(%ebp),%eax
80105199:	83 e8 08             	sub    $0x8,%eax
8010519c:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010519f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801051a6:	eb 38                	jmp    801051e0 <getcallerpcs+0x50>
801051a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801051ac:	74 53                	je     80105201 <getcallerpcs+0x71>
801051ae:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801051b5:	76 4a                	jbe    80105201 <getcallerpcs+0x71>
801051b7:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801051bb:	74 44                	je     80105201 <getcallerpcs+0x71>
801051bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801051c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ca:	01 c2                	add    %eax,%edx
801051cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051cf:	8b 40 04             	mov    0x4(%eax),%eax
801051d2:	89 02                	mov    %eax,(%edx)
801051d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051d7:	8b 00                	mov    (%eax),%eax
801051d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
801051dc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801051e0:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801051e4:	7e c2                	jle    801051a8 <getcallerpcs+0x18>
801051e6:	eb 19                	jmp    80105201 <getcallerpcs+0x71>
801051e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801051f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801051f5:	01 d0                	add    %edx,%eax
801051f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801051fd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105201:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105205:	7e e1                	jle    801051e8 <getcallerpcs+0x58>
80105207:	90                   	nop
80105208:	c9                   	leave  
80105209:	c3                   	ret    

8010520a <holding>:
8010520a:	55                   	push   %ebp
8010520b:	89 e5                	mov    %esp,%ebp
8010520d:	8b 45 08             	mov    0x8(%ebp),%eax
80105210:	8b 00                	mov    (%eax),%eax
80105212:	85 c0                	test   %eax,%eax
80105214:	74 17                	je     8010522d <holding+0x23>
80105216:	8b 45 08             	mov    0x8(%ebp),%eax
80105219:	8b 50 08             	mov    0x8(%eax),%edx
8010521c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105222:	39 c2                	cmp    %eax,%edx
80105224:	75 07                	jne    8010522d <holding+0x23>
80105226:	b8 01 00 00 00       	mov    $0x1,%eax
8010522b:	eb 05                	jmp    80105232 <holding+0x28>
8010522d:	b8 00 00 00 00       	mov    $0x0,%eax
80105232:	5d                   	pop    %ebp
80105233:	c3                   	ret    

80105234 <pushcli>:
80105234:	55                   	push   %ebp
80105235:	89 e5                	mov    %esp,%ebp
80105237:	83 ec 10             	sub    $0x10,%esp
8010523a:	e8 39 fe ff ff       	call   80105078 <readeflags>
8010523f:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105242:	e8 41 fe ff ff       	call   80105088 <cli>
80105247:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010524d:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105253:	85 c0                	test   %eax,%eax
80105255:	75 15                	jne    8010526c <pushcli+0x38>
80105257:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010525d:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105260:	81 e2 00 02 00 00    	and    $0x200,%edx
80105266:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
8010526c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105272:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105279:	8b 92 ac 00 00 00    	mov    0xac(%edx),%edx
8010527f:	83 c2 01             	add    $0x1,%edx
80105282:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105288:	90                   	nop
80105289:	c9                   	leave  
8010528a:	c3                   	ret    

8010528b <popcli>:
8010528b:	55                   	push   %ebp
8010528c:	89 e5                	mov    %esp,%ebp
8010528e:	83 ec 08             	sub    $0x8,%esp
80105291:	e8 e2 fd ff ff       	call   80105078 <readeflags>
80105296:	25 00 02 00 00       	and    $0x200,%eax
8010529b:	85 c0                	test   %eax,%eax
8010529d:	74 0d                	je     801052ac <popcli+0x21>
8010529f:	83 ec 0c             	sub    $0xc,%esp
801052a2:	68 34 8d 10 80       	push   $0x80108d34
801052a7:	e8 ec b2 ff ff       	call   80100598 <panic>
801052ac:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052b2:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801052b8:	83 ea 01             	sub    $0x1,%edx
801052bb:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801052c1:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801052c7:	85 c0                	test   %eax,%eax
801052c9:	79 0d                	jns    801052d8 <popcli+0x4d>
801052cb:	83 ec 0c             	sub    $0xc,%esp
801052ce:	68 4b 8d 10 80       	push   $0x80108d4b
801052d3:	e8 c0 b2 ff ff       	call   80100598 <panic>
801052d8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052de:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801052e4:	85 c0                	test   %eax,%eax
801052e6:	75 15                	jne    801052fd <popcli+0x72>
801052e8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052ee:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801052f4:	85 c0                	test   %eax,%eax
801052f6:	74 05                	je     801052fd <popcli+0x72>
801052f8:	e8 92 fd ff ff       	call   8010508f <sti>
801052fd:	90                   	nop
801052fe:	c9                   	leave  
801052ff:	c3                   	ret    

80105300 <stosb>:
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	53                   	push   %ebx
80105305:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105308:	8b 55 10             	mov    0x10(%ebp),%edx
8010530b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010530e:	89 cb                	mov    %ecx,%ebx
80105310:	89 df                	mov    %ebx,%edi
80105312:	89 d1                	mov    %edx,%ecx
80105314:	fc                   	cld    
80105315:	f3 aa                	rep stos %al,%es:(%edi)
80105317:	89 ca                	mov    %ecx,%edx
80105319:	89 fb                	mov    %edi,%ebx
8010531b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010531e:	89 55 10             	mov    %edx,0x10(%ebp)
80105321:	90                   	nop
80105322:	5b                   	pop    %ebx
80105323:	5f                   	pop    %edi
80105324:	5d                   	pop    %ebp
80105325:	c3                   	ret    

80105326 <stosl>:
80105326:	55                   	push   %ebp
80105327:	89 e5                	mov    %esp,%ebp
80105329:	57                   	push   %edi
8010532a:	53                   	push   %ebx
8010532b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010532e:	8b 55 10             	mov    0x10(%ebp),%edx
80105331:	8b 45 0c             	mov    0xc(%ebp),%eax
80105334:	89 cb                	mov    %ecx,%ebx
80105336:	89 df                	mov    %ebx,%edi
80105338:	89 d1                	mov    %edx,%ecx
8010533a:	fc                   	cld    
8010533b:	f3 ab                	rep stos %eax,%es:(%edi)
8010533d:	89 ca                	mov    %ecx,%edx
8010533f:	89 fb                	mov    %edi,%ebx
80105341:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105344:	89 55 10             	mov    %edx,0x10(%ebp)
80105347:	90                   	nop
80105348:	5b                   	pop    %ebx
80105349:	5f                   	pop    %edi
8010534a:	5d                   	pop    %ebp
8010534b:	c3                   	ret    

8010534c <memset>:
8010534c:	55                   	push   %ebp
8010534d:	89 e5                	mov    %esp,%ebp
8010534f:	8b 45 08             	mov    0x8(%ebp),%eax
80105352:	83 e0 03             	and    $0x3,%eax
80105355:	85 c0                	test   %eax,%eax
80105357:	75 43                	jne    8010539c <memset+0x50>
80105359:	8b 45 10             	mov    0x10(%ebp),%eax
8010535c:	83 e0 03             	and    $0x3,%eax
8010535f:	85 c0                	test   %eax,%eax
80105361:	75 39                	jne    8010539c <memset+0x50>
80105363:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
8010536a:	8b 45 10             	mov    0x10(%ebp),%eax
8010536d:	c1 e8 02             	shr    $0x2,%eax
80105370:	89 c1                	mov    %eax,%ecx
80105372:	8b 45 0c             	mov    0xc(%ebp),%eax
80105375:	c1 e0 18             	shl    $0x18,%eax
80105378:	89 c2                	mov    %eax,%edx
8010537a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010537d:	c1 e0 10             	shl    $0x10,%eax
80105380:	09 c2                	or     %eax,%edx
80105382:	8b 45 0c             	mov    0xc(%ebp),%eax
80105385:	c1 e0 08             	shl    $0x8,%eax
80105388:	09 d0                	or     %edx,%eax
8010538a:	0b 45 0c             	or     0xc(%ebp),%eax
8010538d:	51                   	push   %ecx
8010538e:	50                   	push   %eax
8010538f:	ff 75 08             	pushl  0x8(%ebp)
80105392:	e8 8f ff ff ff       	call   80105326 <stosl>
80105397:	83 c4 0c             	add    $0xc,%esp
8010539a:	eb 12                	jmp    801053ae <memset+0x62>
8010539c:	8b 45 10             	mov    0x10(%ebp),%eax
8010539f:	50                   	push   %eax
801053a0:	ff 75 0c             	pushl  0xc(%ebp)
801053a3:	ff 75 08             	pushl  0x8(%ebp)
801053a6:	e8 55 ff ff ff       	call   80105300 <stosb>
801053ab:	83 c4 0c             	add    $0xc,%esp
801053ae:	8b 45 08             	mov    0x8(%ebp),%eax
801053b1:	c9                   	leave  
801053b2:	c3                   	ret    

801053b3 <memcmp>:
801053b3:	55                   	push   %ebp
801053b4:	89 e5                	mov    %esp,%ebp
801053b6:	83 ec 10             	sub    $0x10,%esp
801053b9:	8b 45 08             	mov    0x8(%ebp),%eax
801053bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
801053bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801053c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
801053c5:	eb 30                	jmp    801053f7 <memcmp+0x44>
801053c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053ca:	0f b6 10             	movzbl (%eax),%edx
801053cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053d0:	0f b6 00             	movzbl (%eax),%eax
801053d3:	38 c2                	cmp    %al,%dl
801053d5:	74 18                	je     801053ef <memcmp+0x3c>
801053d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053da:	0f b6 00             	movzbl (%eax),%eax
801053dd:	0f b6 d0             	movzbl %al,%edx
801053e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053e3:	0f b6 00             	movzbl (%eax),%eax
801053e6:	0f b6 c0             	movzbl %al,%eax
801053e9:	29 c2                	sub    %eax,%edx
801053eb:	89 d0                	mov    %edx,%eax
801053ed:	eb 1a                	jmp    80105409 <memcmp+0x56>
801053ef:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801053f3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801053f7:	8b 45 10             	mov    0x10(%ebp),%eax
801053fa:	8d 50 ff             	lea    -0x1(%eax),%edx
801053fd:	89 55 10             	mov    %edx,0x10(%ebp)
80105400:	85 c0                	test   %eax,%eax
80105402:	75 c3                	jne    801053c7 <memcmp+0x14>
80105404:	b8 00 00 00 00       	mov    $0x0,%eax
80105409:	c9                   	leave  
8010540a:	c3                   	ret    

8010540b <memmove>:
8010540b:	55                   	push   %ebp
8010540c:	89 e5                	mov    %esp,%ebp
8010540e:	83 ec 10             	sub    $0x10,%esp
80105411:	8b 45 0c             	mov    0xc(%ebp),%eax
80105414:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105417:	8b 45 08             	mov    0x8(%ebp),%eax
8010541a:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010541d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105420:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105423:	73 54                	jae    80105479 <memmove+0x6e>
80105425:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105428:	8b 45 10             	mov    0x10(%ebp),%eax
8010542b:	01 d0                	add    %edx,%eax
8010542d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105430:	76 47                	jbe    80105479 <memmove+0x6e>
80105432:	8b 45 10             	mov    0x10(%ebp),%eax
80105435:	01 45 fc             	add    %eax,-0x4(%ebp)
80105438:	8b 45 10             	mov    0x10(%ebp),%eax
8010543b:	01 45 f8             	add    %eax,-0x8(%ebp)
8010543e:	eb 13                	jmp    80105453 <memmove+0x48>
80105440:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105444:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105448:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010544b:	0f b6 10             	movzbl (%eax),%edx
8010544e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105451:	88 10                	mov    %dl,(%eax)
80105453:	8b 45 10             	mov    0x10(%ebp),%eax
80105456:	8d 50 ff             	lea    -0x1(%eax),%edx
80105459:	89 55 10             	mov    %edx,0x10(%ebp)
8010545c:	85 c0                	test   %eax,%eax
8010545e:	75 e0                	jne    80105440 <memmove+0x35>
80105460:	eb 24                	jmp    80105486 <memmove+0x7b>
80105462:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105465:	8d 50 01             	lea    0x1(%eax),%edx
80105468:	89 55 f8             	mov    %edx,-0x8(%ebp)
8010546b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010546e:	8d 4a 01             	lea    0x1(%edx),%ecx
80105471:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80105474:	0f b6 12             	movzbl (%edx),%edx
80105477:	88 10                	mov    %dl,(%eax)
80105479:	8b 45 10             	mov    0x10(%ebp),%eax
8010547c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010547f:	89 55 10             	mov    %edx,0x10(%ebp)
80105482:	85 c0                	test   %eax,%eax
80105484:	75 dc                	jne    80105462 <memmove+0x57>
80105486:	8b 45 08             	mov    0x8(%ebp),%eax
80105489:	c9                   	leave  
8010548a:	c3                   	ret    

8010548b <memcpy>:
8010548b:	55                   	push   %ebp
8010548c:	89 e5                	mov    %esp,%ebp
8010548e:	ff 75 10             	pushl  0x10(%ebp)
80105491:	ff 75 0c             	pushl  0xc(%ebp)
80105494:	ff 75 08             	pushl  0x8(%ebp)
80105497:	e8 6f ff ff ff       	call   8010540b <memmove>
8010549c:	83 c4 0c             	add    $0xc,%esp
8010549f:	c9                   	leave  
801054a0:	c3                   	ret    

801054a1 <strncmp>:
801054a1:	55                   	push   %ebp
801054a2:	89 e5                	mov    %esp,%ebp
801054a4:	eb 0c                	jmp    801054b2 <strncmp+0x11>
801054a6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801054aa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801054ae:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801054b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054b6:	74 1a                	je     801054d2 <strncmp+0x31>
801054b8:	8b 45 08             	mov    0x8(%ebp),%eax
801054bb:	0f b6 00             	movzbl (%eax),%eax
801054be:	84 c0                	test   %al,%al
801054c0:	74 10                	je     801054d2 <strncmp+0x31>
801054c2:	8b 45 08             	mov    0x8(%ebp),%eax
801054c5:	0f b6 10             	movzbl (%eax),%edx
801054c8:	8b 45 0c             	mov    0xc(%ebp),%eax
801054cb:	0f b6 00             	movzbl (%eax),%eax
801054ce:	38 c2                	cmp    %al,%dl
801054d0:	74 d4                	je     801054a6 <strncmp+0x5>
801054d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054d6:	75 07                	jne    801054df <strncmp+0x3e>
801054d8:	b8 00 00 00 00       	mov    $0x0,%eax
801054dd:	eb 16                	jmp    801054f5 <strncmp+0x54>
801054df:	8b 45 08             	mov    0x8(%ebp),%eax
801054e2:	0f b6 00             	movzbl (%eax),%eax
801054e5:	0f b6 d0             	movzbl %al,%edx
801054e8:	8b 45 0c             	mov    0xc(%ebp),%eax
801054eb:	0f b6 00             	movzbl (%eax),%eax
801054ee:	0f b6 c0             	movzbl %al,%eax
801054f1:	29 c2                	sub    %eax,%edx
801054f3:	89 d0                	mov    %edx,%eax
801054f5:	5d                   	pop    %ebp
801054f6:	c3                   	ret    

801054f7 <strncpy>:
801054f7:	55                   	push   %ebp
801054f8:	89 e5                	mov    %esp,%ebp
801054fa:	83 ec 10             	sub    $0x10,%esp
801054fd:	8b 45 08             	mov    0x8(%ebp),%eax
80105500:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105503:	90                   	nop
80105504:	8b 45 10             	mov    0x10(%ebp),%eax
80105507:	8d 50 ff             	lea    -0x1(%eax),%edx
8010550a:	89 55 10             	mov    %edx,0x10(%ebp)
8010550d:	85 c0                	test   %eax,%eax
8010550f:	7e 2c                	jle    8010553d <strncpy+0x46>
80105511:	8b 45 08             	mov    0x8(%ebp),%eax
80105514:	8d 50 01             	lea    0x1(%eax),%edx
80105517:	89 55 08             	mov    %edx,0x8(%ebp)
8010551a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010551d:	8d 4a 01             	lea    0x1(%edx),%ecx
80105520:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105523:	0f b6 12             	movzbl (%edx),%edx
80105526:	88 10                	mov    %dl,(%eax)
80105528:	0f b6 00             	movzbl (%eax),%eax
8010552b:	84 c0                	test   %al,%al
8010552d:	75 d5                	jne    80105504 <strncpy+0xd>
8010552f:	eb 0c                	jmp    8010553d <strncpy+0x46>
80105531:	8b 45 08             	mov    0x8(%ebp),%eax
80105534:	8d 50 01             	lea    0x1(%eax),%edx
80105537:	89 55 08             	mov    %edx,0x8(%ebp)
8010553a:	c6 00 00             	movb   $0x0,(%eax)
8010553d:	8b 45 10             	mov    0x10(%ebp),%eax
80105540:	8d 50 ff             	lea    -0x1(%eax),%edx
80105543:	89 55 10             	mov    %edx,0x10(%ebp)
80105546:	85 c0                	test   %eax,%eax
80105548:	7f e7                	jg     80105531 <strncpy+0x3a>
8010554a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010554d:	c9                   	leave  
8010554e:	c3                   	ret    

8010554f <safestrcpy>:
8010554f:	55                   	push   %ebp
80105550:	89 e5                	mov    %esp,%ebp
80105552:	83 ec 10             	sub    $0x10,%esp
80105555:	8b 45 08             	mov    0x8(%ebp),%eax
80105558:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010555b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010555f:	7f 05                	jg     80105566 <safestrcpy+0x17>
80105561:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105564:	eb 31                	jmp    80105597 <safestrcpy+0x48>
80105566:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010556a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010556e:	7e 1e                	jle    8010558e <safestrcpy+0x3f>
80105570:	8b 45 08             	mov    0x8(%ebp),%eax
80105573:	8d 50 01             	lea    0x1(%eax),%edx
80105576:	89 55 08             	mov    %edx,0x8(%ebp)
80105579:	8b 55 0c             	mov    0xc(%ebp),%edx
8010557c:	8d 4a 01             	lea    0x1(%edx),%ecx
8010557f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105582:	0f b6 12             	movzbl (%edx),%edx
80105585:	88 10                	mov    %dl,(%eax)
80105587:	0f b6 00             	movzbl (%eax),%eax
8010558a:	84 c0                	test   %al,%al
8010558c:	75 d8                	jne    80105566 <safestrcpy+0x17>
8010558e:	8b 45 08             	mov    0x8(%ebp),%eax
80105591:	c6 00 00             	movb   $0x0,(%eax)
80105594:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105597:	c9                   	leave  
80105598:	c3                   	ret    

80105599 <strlen>:
80105599:	55                   	push   %ebp
8010559a:	89 e5                	mov    %esp,%ebp
8010559c:	83 ec 10             	sub    $0x10,%esp
8010559f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055a6:	eb 04                	jmp    801055ac <strlen+0x13>
801055a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055af:	8b 45 08             	mov    0x8(%ebp),%eax
801055b2:	01 d0                	add    %edx,%eax
801055b4:	0f b6 00             	movzbl (%eax),%eax
801055b7:	84 c0                	test   %al,%al
801055b9:	75 ed                	jne    801055a8 <strlen+0xf>
801055bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055be:	c9                   	leave  
801055bf:	c3                   	ret    

801055c0 <swtch>:
801055c0:	8b 44 24 04          	mov    0x4(%esp),%eax
801055c4:	8b 54 24 08          	mov    0x8(%esp),%edx
801055c8:	55                   	push   %ebp
801055c9:	53                   	push   %ebx
801055ca:	56                   	push   %esi
801055cb:	57                   	push   %edi
801055cc:	89 20                	mov    %esp,(%eax)
801055ce:	89 d4                	mov    %edx,%esp
801055d0:	5f                   	pop    %edi
801055d1:	5e                   	pop    %esi
801055d2:	5b                   	pop    %ebx
801055d3:	5d                   	pop    %ebp
801055d4:	c3                   	ret    

801055d5 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801055d5:	55                   	push   %ebp
801055d6:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801055d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055de:	8b 00                	mov    (%eax),%eax
801055e0:	3b 45 08             	cmp    0x8(%ebp),%eax
801055e3:	76 12                	jbe    801055f7 <fetchint+0x22>
801055e5:	8b 45 08             	mov    0x8(%ebp),%eax
801055e8:	8d 50 04             	lea    0x4(%eax),%edx
801055eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055f1:	8b 00                	mov    (%eax),%eax
801055f3:	39 c2                	cmp    %eax,%edx
801055f5:	76 07                	jbe    801055fe <fetchint+0x29>
    return -1;
801055f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055fc:	eb 0f                	jmp    8010560d <fetchint+0x38>
  *ip = *(int*)(addr);
801055fe:	8b 45 08             	mov    0x8(%ebp),%eax
80105601:	8b 10                	mov    (%eax),%edx
80105603:	8b 45 0c             	mov    0xc(%ebp),%eax
80105606:	89 10                	mov    %edx,(%eax)
  return 0;
80105608:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010560d:	5d                   	pop    %ebp
8010560e:	c3                   	ret    

8010560f <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010560f:	55                   	push   %ebp
80105610:	89 e5                	mov    %esp,%ebp
80105612:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105615:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010561b:	8b 00                	mov    (%eax),%eax
8010561d:	3b 45 08             	cmp    0x8(%ebp),%eax
80105620:	77 07                	ja     80105629 <fetchstr+0x1a>
    return -1;
80105622:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105627:	eb 46                	jmp    8010566f <fetchstr+0x60>
  *pp = (char*)addr;
80105629:	8b 55 08             	mov    0x8(%ebp),%edx
8010562c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010562f:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105631:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105637:	8b 00                	mov    (%eax),%eax
80105639:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
8010563c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010563f:	8b 00                	mov    (%eax),%eax
80105641:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105644:	eb 1c                	jmp    80105662 <fetchstr+0x53>
    if(*s == 0)
80105646:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105649:	0f b6 00             	movzbl (%eax),%eax
8010564c:	84 c0                	test   %al,%al
8010564e:	75 0e                	jne    8010565e <fetchstr+0x4f>
      return s - *pp;
80105650:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105653:	8b 45 0c             	mov    0xc(%ebp),%eax
80105656:	8b 00                	mov    (%eax),%eax
80105658:	29 c2                	sub    %eax,%edx
8010565a:	89 d0                	mov    %edx,%eax
8010565c:	eb 11                	jmp    8010566f <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010565e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105662:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105665:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105668:	72 dc                	jb     80105646 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
8010566a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010566f:	c9                   	leave  
80105670:	c3                   	ret    

80105671 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105671:	55                   	push   %ebp
80105672:	89 e5                	mov    %esp,%ebp
80105674:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105677:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010567d:	8b 40 1c             	mov    0x1c(%eax),%eax
80105680:	8b 50 44             	mov    0x44(%eax),%edx
80105683:	8b 45 08             	mov    0x8(%ebp),%eax
80105686:	c1 e0 02             	shl    $0x2,%eax
80105689:	01 d0                	add    %edx,%eax
8010568b:	8d 50 04             	lea    0x4(%eax),%edx
8010568e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105691:	89 44 24 04          	mov    %eax,0x4(%esp)
80105695:	89 14 24             	mov    %edx,(%esp)
80105698:	e8 38 ff ff ff       	call   801055d5 <fetchint>
}
8010569d:	c9                   	leave  
8010569e:	c3                   	ret    

8010569f <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
8010569f:	55                   	push   %ebp
801056a0:	89 e5                	mov    %esp,%ebp
801056a2:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(argint(n, &i) < 0)
801056a5:	8d 45 fc             	lea    -0x4(%ebp),%eax
801056a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801056ac:	8b 45 08             	mov    0x8(%ebp),%eax
801056af:	89 04 24             	mov    %eax,(%esp)
801056b2:	e8 ba ff ff ff       	call   80105671 <argint>
801056b7:	85 c0                	test   %eax,%eax
801056b9:	79 07                	jns    801056c2 <argptr+0x23>
    return -1;
801056bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056c0:	eb 3d                	jmp    801056ff <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801056c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056c5:	89 c2                	mov    %eax,%edx
801056c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056cd:	8b 00                	mov    (%eax),%eax
801056cf:	39 c2                	cmp    %eax,%edx
801056d1:	73 16                	jae    801056e9 <argptr+0x4a>
801056d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056d6:	89 c2                	mov    %eax,%edx
801056d8:	8b 45 10             	mov    0x10(%ebp),%eax
801056db:	01 c2                	add    %eax,%edx
801056dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056e3:	8b 00                	mov    (%eax),%eax
801056e5:	39 c2                	cmp    %eax,%edx
801056e7:	76 07                	jbe    801056f0 <argptr+0x51>
    return -1;
801056e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ee:	eb 0f                	jmp    801056ff <argptr+0x60>
  *pp = (char*)i;
801056f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056f3:	89 c2                	mov    %eax,%edx
801056f5:	8b 45 0c             	mov    0xc(%ebp),%eax
801056f8:	89 10                	mov    %edx,(%eax)
  return 0;
801056fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056ff:	c9                   	leave  
80105700:	c3                   	ret    

80105701 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105701:	55                   	push   %ebp
80105702:	89 e5                	mov    %esp,%ebp
80105704:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105707:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010570a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010570e:	8b 45 08             	mov    0x8(%ebp),%eax
80105711:	89 04 24             	mov    %eax,(%esp)
80105714:	e8 58 ff ff ff       	call   80105671 <argint>
80105719:	85 c0                	test   %eax,%eax
8010571b:	79 07                	jns    80105724 <argstr+0x23>
    return -1;
8010571d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105722:	eb 12                	jmp    80105736 <argstr+0x35>
  return fetchstr(addr, pp);
80105724:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105727:	8b 55 0c             	mov    0xc(%ebp),%edx
8010572a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010572e:	89 04 24             	mov    %eax,(%esp)
80105731:	e8 d9 fe ff ff       	call   8010560f <fetchstr>
}
80105736:	c9                   	leave  
80105737:	c3                   	ret    

80105738 <syscall>:
[SYS_dup2]    sys_dup2,
};

void
syscall(void)
{
80105738:	55                   	push   %ebp
80105739:	89 e5                	mov    %esp,%ebp
8010573b:	53                   	push   %ebx
8010573c:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
8010573f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105745:	8b 40 1c             	mov    0x1c(%eax),%eax
80105748:	8b 40 1c             	mov    0x1c(%eax),%eax
8010574b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010574e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105752:	7e 30                	jle    80105784 <syscall+0x4c>
80105754:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105757:	83 f8 17             	cmp    $0x17,%eax
8010575a:	77 28                	ja     80105784 <syscall+0x4c>
8010575c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010575f:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105766:	85 c0                	test   %eax,%eax
80105768:	74 1a                	je     80105784 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
8010576a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105770:	8b 58 1c             	mov    0x1c(%eax),%ebx
80105773:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105776:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
8010577d:	ff d0                	call   *%eax
8010577f:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105782:	eb 3d                	jmp    801057c1 <syscall+0x89>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105784:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010578a:	8d 48 70             	lea    0x70(%eax),%ecx
8010578d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105793:	8b 40 14             	mov    0x14(%eax),%eax
80105796:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105799:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010579d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801057a1:	89 44 24 04          	mov    %eax,0x4(%esp)
801057a5:	c7 04 24 52 8d 10 80 	movl   $0x80108d52,(%esp)
801057ac:	e8 4d ac ff ff       	call   801003fe <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801057b1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057b7:	8b 40 1c             	mov    0x1c(%eax),%eax
801057ba:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801057c1:	83 c4 24             	add    $0x24,%esp
801057c4:	5b                   	pop    %ebx
801057c5:	5d                   	pop    %ebp
801057c6:	c3                   	ret    

801057c7 <argfd>:
801057c7:	55                   	push   %ebp
801057c8:	89 e5                	mov    %esp,%ebp
801057ca:	83 ec 18             	sub    $0x18,%esp
801057cd:	83 ec 08             	sub    $0x8,%esp
801057d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057d3:	50                   	push   %eax
801057d4:	ff 75 08             	pushl  0x8(%ebp)
801057d7:	e8 95 fe ff ff       	call   80105671 <argint>
801057dc:	83 c4 10             	add    $0x10,%esp
801057df:	85 c0                	test   %eax,%eax
801057e1:	79 07                	jns    801057ea <argfd+0x23>
801057e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e8:	eb 50                	jmp    8010583a <argfd+0x73>
801057ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057ed:	85 c0                	test   %eax,%eax
801057ef:	78 21                	js     80105812 <argfd+0x4b>
801057f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057f4:	83 f8 0f             	cmp    $0xf,%eax
801057f7:	7f 19                	jg     80105812 <argfd+0x4b>
801057f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105802:	83 c2 08             	add    $0x8,%edx
80105805:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80105809:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010580c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105810:	75 07                	jne    80105819 <argfd+0x52>
80105812:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105817:	eb 21                	jmp    8010583a <argfd+0x73>
80105819:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010581d:	74 08                	je     80105827 <argfd+0x60>
8010581f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105822:	8b 45 0c             	mov    0xc(%ebp),%eax
80105825:	89 10                	mov    %edx,(%eax)
80105827:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010582b:	74 08                	je     80105835 <argfd+0x6e>
8010582d:	8b 45 10             	mov    0x10(%ebp),%eax
80105830:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105833:	89 10                	mov    %edx,(%eax)
80105835:	b8 00 00 00 00       	mov    $0x0,%eax
8010583a:	c9                   	leave  
8010583b:	c3                   	ret    

8010583c <fdalloc>:
8010583c:	55                   	push   %ebp
8010583d:	89 e5                	mov    %esp,%ebp
8010583f:	83 ec 10             	sub    $0x10,%esp
80105842:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105849:	eb 30                	jmp    8010587b <fdalloc+0x3f>
8010584b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105851:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105854:	83 c2 08             	add    $0x8,%edx
80105857:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010585b:	85 c0                	test   %eax,%eax
8010585d:	75 18                	jne    80105877 <fdalloc+0x3b>
8010585f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105865:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105868:	8d 4a 08             	lea    0x8(%edx),%ecx
8010586b:	8b 55 08             	mov    0x8(%ebp),%edx
8010586e:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
80105872:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105875:	eb 0f                	jmp    80105886 <fdalloc+0x4a>
80105877:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010587b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
8010587f:	7e ca                	jle    8010584b <fdalloc+0xf>
80105881:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105886:	c9                   	leave  
80105887:	c3                   	ret    

80105888 <sys_dup>:
80105888:	55                   	push   %ebp
80105889:	89 e5                	mov    %esp,%ebp
8010588b:	83 ec 18             	sub    $0x18,%esp
8010588e:	83 ec 04             	sub    $0x4,%esp
80105891:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105894:	50                   	push   %eax
80105895:	6a 00                	push   $0x0
80105897:	6a 00                	push   $0x0
80105899:	e8 29 ff ff ff       	call   801057c7 <argfd>
8010589e:	83 c4 10             	add    $0x10,%esp
801058a1:	85 c0                	test   %eax,%eax
801058a3:	79 07                	jns    801058ac <sys_dup+0x24>
801058a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058aa:	eb 31                	jmp    801058dd <sys_dup+0x55>
801058ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058af:	83 ec 0c             	sub    $0xc,%esp
801058b2:	50                   	push   %eax
801058b3:	e8 84 ff ff ff       	call   8010583c <fdalloc>
801058b8:	83 c4 10             	add    $0x10,%esp
801058bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058c2:	79 07                	jns    801058cb <sys_dup+0x43>
801058c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c9:	eb 12                	jmp    801058dd <sys_dup+0x55>
801058cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058ce:	83 ec 0c             	sub    $0xc,%esp
801058d1:	50                   	push   %eax
801058d2:	e8 7a b7 ff ff       	call   80101051 <filedup>
801058d7:	83 c4 10             	add    $0x10,%esp
801058da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058dd:	c9                   	leave  
801058de:	c3                   	ret    

801058df <sys_read>:
801058df:	55                   	push   %ebp
801058e0:	89 e5                	mov    %esp,%ebp
801058e2:	83 ec 18             	sub    $0x18,%esp
801058e5:	83 ec 04             	sub    $0x4,%esp
801058e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058eb:	50                   	push   %eax
801058ec:	6a 00                	push   $0x0
801058ee:	6a 00                	push   $0x0
801058f0:	e8 d2 fe ff ff       	call   801057c7 <argfd>
801058f5:	83 c4 10             	add    $0x10,%esp
801058f8:	85 c0                	test   %eax,%eax
801058fa:	78 2e                	js     8010592a <sys_read+0x4b>
801058fc:	83 ec 08             	sub    $0x8,%esp
801058ff:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105902:	50                   	push   %eax
80105903:	6a 02                	push   $0x2
80105905:	e8 67 fd ff ff       	call   80105671 <argint>
8010590a:	83 c4 10             	add    $0x10,%esp
8010590d:	85 c0                	test   %eax,%eax
8010590f:	78 19                	js     8010592a <sys_read+0x4b>
80105911:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105914:	83 ec 04             	sub    $0x4,%esp
80105917:	50                   	push   %eax
80105918:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010591b:	50                   	push   %eax
8010591c:	6a 01                	push   $0x1
8010591e:	e8 7c fd ff ff       	call   8010569f <argptr>
80105923:	83 c4 10             	add    $0x10,%esp
80105926:	85 c0                	test   %eax,%eax
80105928:	79 07                	jns    80105931 <sys_read+0x52>
8010592a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010592f:	eb 17                	jmp    80105948 <sys_read+0x69>
80105931:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105934:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105937:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010593a:	83 ec 04             	sub    $0x4,%esp
8010593d:	51                   	push   %ecx
8010593e:	52                   	push   %edx
8010593f:	50                   	push   %eax
80105940:	e8 9c b8 ff ff       	call   801011e1 <fileread>
80105945:	83 c4 10             	add    $0x10,%esp
80105948:	c9                   	leave  
80105949:	c3                   	ret    

8010594a <sys_write>:
8010594a:	55                   	push   %ebp
8010594b:	89 e5                	mov    %esp,%ebp
8010594d:	83 ec 18             	sub    $0x18,%esp
80105950:	83 ec 04             	sub    $0x4,%esp
80105953:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105956:	50                   	push   %eax
80105957:	6a 00                	push   $0x0
80105959:	6a 00                	push   $0x0
8010595b:	e8 67 fe ff ff       	call   801057c7 <argfd>
80105960:	83 c4 10             	add    $0x10,%esp
80105963:	85 c0                	test   %eax,%eax
80105965:	78 2e                	js     80105995 <sys_write+0x4b>
80105967:	83 ec 08             	sub    $0x8,%esp
8010596a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010596d:	50                   	push   %eax
8010596e:	6a 02                	push   $0x2
80105970:	e8 fc fc ff ff       	call   80105671 <argint>
80105975:	83 c4 10             	add    $0x10,%esp
80105978:	85 c0                	test   %eax,%eax
8010597a:	78 19                	js     80105995 <sys_write+0x4b>
8010597c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010597f:	83 ec 04             	sub    $0x4,%esp
80105982:	50                   	push   %eax
80105983:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105986:	50                   	push   %eax
80105987:	6a 01                	push   $0x1
80105989:	e8 11 fd ff ff       	call   8010569f <argptr>
8010598e:	83 c4 10             	add    $0x10,%esp
80105991:	85 c0                	test   %eax,%eax
80105993:	79 07                	jns    8010599c <sys_write+0x52>
80105995:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010599a:	eb 17                	jmp    801059b3 <sys_write+0x69>
8010599c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010599f:	8b 55 ec             	mov    -0x14(%ebp),%edx
801059a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059a5:	83 ec 04             	sub    $0x4,%esp
801059a8:	51                   	push   %ecx
801059a9:	52                   	push   %edx
801059aa:	50                   	push   %eax
801059ab:	e8 e9 b8 ff ff       	call   80101299 <filewrite>
801059b0:	83 c4 10             	add    $0x10,%esp
801059b3:	c9                   	leave  
801059b4:	c3                   	ret    

801059b5 <sys_close>:
801059b5:	55                   	push   %ebp
801059b6:	89 e5                	mov    %esp,%ebp
801059b8:	83 ec 18             	sub    $0x18,%esp
801059bb:	83 ec 04             	sub    $0x4,%esp
801059be:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c1:	50                   	push   %eax
801059c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059c5:	50                   	push   %eax
801059c6:	6a 00                	push   $0x0
801059c8:	e8 fa fd ff ff       	call   801057c7 <argfd>
801059cd:	83 c4 10             	add    $0x10,%esp
801059d0:	85 c0                	test   %eax,%eax
801059d2:	79 07                	jns    801059db <sys_close+0x26>
801059d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d9:	eb 28                	jmp    80105a03 <sys_close+0x4e>
801059db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059e4:	83 c2 08             	add    $0x8,%edx
801059e7:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801059ee:	00 
801059ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059f2:	83 ec 0c             	sub    $0xc,%esp
801059f5:	50                   	push   %eax
801059f6:	e8 a7 b6 ff ff       	call   801010a2 <fileclose>
801059fb:	83 c4 10             	add    $0x10,%esp
801059fe:	b8 00 00 00 00       	mov    $0x0,%eax
80105a03:	c9                   	leave  
80105a04:	c3                   	ret    

80105a05 <sys_fstat>:
80105a05:	55                   	push   %ebp
80105a06:	89 e5                	mov    %esp,%ebp
80105a08:	83 ec 18             	sub    $0x18,%esp
80105a0b:	83 ec 04             	sub    $0x4,%esp
80105a0e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a11:	50                   	push   %eax
80105a12:	6a 00                	push   $0x0
80105a14:	6a 00                	push   $0x0
80105a16:	e8 ac fd ff ff       	call   801057c7 <argfd>
80105a1b:	83 c4 10             	add    $0x10,%esp
80105a1e:	85 c0                	test   %eax,%eax
80105a20:	78 17                	js     80105a39 <sys_fstat+0x34>
80105a22:	83 ec 04             	sub    $0x4,%esp
80105a25:	6a 14                	push   $0x14
80105a27:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a2a:	50                   	push   %eax
80105a2b:	6a 01                	push   $0x1
80105a2d:	e8 6d fc ff ff       	call   8010569f <argptr>
80105a32:	83 c4 10             	add    $0x10,%esp
80105a35:	85 c0                	test   %eax,%eax
80105a37:	79 07                	jns    80105a40 <sys_fstat+0x3b>
80105a39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a3e:	eb 13                	jmp    80105a53 <sys_fstat+0x4e>
80105a40:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a46:	83 ec 08             	sub    $0x8,%esp
80105a49:	52                   	push   %edx
80105a4a:	50                   	push   %eax
80105a4b:	e8 3a b7 ff ff       	call   8010118a <filestat>
80105a50:	83 c4 10             	add    $0x10,%esp
80105a53:	c9                   	leave  
80105a54:	c3                   	ret    

80105a55 <sys_link>:
80105a55:	55                   	push   %ebp
80105a56:	89 e5                	mov    %esp,%ebp
80105a58:	83 ec 28             	sub    $0x28,%esp
80105a5b:	83 ec 08             	sub    $0x8,%esp
80105a5e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a61:	50                   	push   %eax
80105a62:	6a 00                	push   $0x0
80105a64:	e8 98 fc ff ff       	call   80105701 <argstr>
80105a69:	83 c4 10             	add    $0x10,%esp
80105a6c:	85 c0                	test   %eax,%eax
80105a6e:	78 15                	js     80105a85 <sys_link+0x30>
80105a70:	83 ec 08             	sub    $0x8,%esp
80105a73:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105a76:	50                   	push   %eax
80105a77:	6a 01                	push   $0x1
80105a79:	e8 83 fc ff ff       	call   80105701 <argstr>
80105a7e:	83 c4 10             	add    $0x10,%esp
80105a81:	85 c0                	test   %eax,%eax
80105a83:	79 0a                	jns    80105a8f <sys_link+0x3a>
80105a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a8a:	e9 68 01 00 00       	jmp    80105bf7 <sys_link+0x1a2>
80105a8f:	e8 43 db ff ff       	call   801035d7 <begin_op>
80105a94:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105a97:	83 ec 0c             	sub    $0xc,%esp
80105a9a:	50                   	push   %eax
80105a9b:	e8 6a ca ff ff       	call   8010250a <namei>
80105aa0:	83 c4 10             	add    $0x10,%esp
80105aa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105aa6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105aaa:	75 0f                	jne    80105abb <sys_link+0x66>
80105aac:	e8 b2 db ff ff       	call   80103663 <end_op>
80105ab1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ab6:	e9 3c 01 00 00       	jmp    80105bf7 <sys_link+0x1a2>
80105abb:	83 ec 0c             	sub    $0xc,%esp
80105abe:	ff 75 f4             	pushl  -0xc(%ebp)
80105ac1:	e8 1c bf ff ff       	call   801019e2 <ilock>
80105ac6:	83 c4 10             	add    $0x10,%esp
80105ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105acc:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105ad0:	66 83 f8 01          	cmp    $0x1,%ax
80105ad4:	75 1d                	jne    80105af3 <sys_link+0x9e>
80105ad6:	83 ec 0c             	sub    $0xc,%esp
80105ad9:	ff 75 f4             	pushl  -0xc(%ebp)
80105adc:	e8 f0 c0 ff ff       	call   80101bd1 <iunlockput>
80105ae1:	83 c4 10             	add    $0x10,%esp
80105ae4:	e8 7a db ff ff       	call   80103663 <end_op>
80105ae9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aee:	e9 04 01 00 00       	jmp    80105bf7 <sys_link+0x1a2>
80105af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105af6:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105afa:	83 c0 01             	add    $0x1,%eax
80105afd:	89 c2                	mov    %eax,%edx
80105aff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b02:	66 89 50 56          	mov    %dx,0x56(%eax)
80105b06:	83 ec 0c             	sub    $0xc,%esp
80105b09:	ff 75 f4             	pushl  -0xc(%ebp)
80105b0c:	e8 0c bd ff ff       	call   8010181d <iupdate>
80105b11:	83 c4 10             	add    $0x10,%esp
80105b14:	83 ec 0c             	sub    $0xc,%esp
80105b17:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1a:	e8 da bf ff ff       	call   80101af9 <iunlock>
80105b1f:	83 c4 10             	add    $0x10,%esp
80105b22:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b25:	83 ec 08             	sub    $0x8,%esp
80105b28:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105b2b:	52                   	push   %edx
80105b2c:	50                   	push   %eax
80105b2d:	e8 fa c9 ff ff       	call   8010252c <nameiparent>
80105b32:	83 c4 10             	add    $0x10,%esp
80105b35:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b38:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b3c:	74 71                	je     80105baf <sys_link+0x15a>
80105b3e:	83 ec 0c             	sub    $0xc,%esp
80105b41:	ff 75 f0             	pushl  -0x10(%ebp)
80105b44:	e8 99 be ff ff       	call   801019e2 <ilock>
80105b49:	83 c4 10             	add    $0x10,%esp
80105b4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b4f:	8b 10                	mov    (%eax),%edx
80105b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b54:	8b 00                	mov    (%eax),%eax
80105b56:	39 c2                	cmp    %eax,%edx
80105b58:	75 1d                	jne    80105b77 <sys_link+0x122>
80105b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b5d:	8b 40 04             	mov    0x4(%eax),%eax
80105b60:	83 ec 04             	sub    $0x4,%esp
80105b63:	50                   	push   %eax
80105b64:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105b67:	50                   	push   %eax
80105b68:	ff 75 f0             	pushl  -0x10(%ebp)
80105b6b:	e8 da c6 ff ff       	call   8010224a <dirlink>
80105b70:	83 c4 10             	add    $0x10,%esp
80105b73:	85 c0                	test   %eax,%eax
80105b75:	79 10                	jns    80105b87 <sys_link+0x132>
80105b77:	83 ec 0c             	sub    $0xc,%esp
80105b7a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b7d:	e8 4f c0 ff ff       	call   80101bd1 <iunlockput>
80105b82:	83 c4 10             	add    $0x10,%esp
80105b85:	eb 29                	jmp    80105bb0 <sys_link+0x15b>
80105b87:	83 ec 0c             	sub    $0xc,%esp
80105b8a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b8d:	e8 3f c0 ff ff       	call   80101bd1 <iunlockput>
80105b92:	83 c4 10             	add    $0x10,%esp
80105b95:	83 ec 0c             	sub    $0xc,%esp
80105b98:	ff 75 f4             	pushl  -0xc(%ebp)
80105b9b:	e8 9d bf ff ff       	call   80101b3d <iput>
80105ba0:	83 c4 10             	add    $0x10,%esp
80105ba3:	e8 bb da ff ff       	call   80103663 <end_op>
80105ba8:	b8 00 00 00 00       	mov    $0x0,%eax
80105bad:	eb 48                	jmp    80105bf7 <sys_link+0x1a2>
80105baf:	90                   	nop
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	ff 75 f4             	pushl  -0xc(%ebp)
80105bb6:	e8 27 be ff ff       	call   801019e2 <ilock>
80105bbb:	83 c4 10             	add    $0x10,%esp
80105bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc1:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105bc5:	83 e8 01             	sub    $0x1,%eax
80105bc8:	89 c2                	mov    %eax,%edx
80105bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bcd:	66 89 50 56          	mov    %dx,0x56(%eax)
80105bd1:	83 ec 0c             	sub    $0xc,%esp
80105bd4:	ff 75 f4             	pushl  -0xc(%ebp)
80105bd7:	e8 41 bc ff ff       	call   8010181d <iupdate>
80105bdc:	83 c4 10             	add    $0x10,%esp
80105bdf:	83 ec 0c             	sub    $0xc,%esp
80105be2:	ff 75 f4             	pushl  -0xc(%ebp)
80105be5:	e8 e7 bf ff ff       	call   80101bd1 <iunlockput>
80105bea:	83 c4 10             	add    $0x10,%esp
80105bed:	e8 71 da ff ff       	call   80103663 <end_op>
80105bf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf7:	c9                   	leave  
80105bf8:	c3                   	ret    

80105bf9 <isdirempty>:
80105bf9:	55                   	push   %ebp
80105bfa:	89 e5                	mov    %esp,%ebp
80105bfc:	83 ec 28             	sub    $0x28,%esp
80105bff:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105c06:	eb 40                	jmp    80105c48 <isdirempty+0x4f>
80105c08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c0b:	6a 10                	push   $0x10
80105c0d:	50                   	push   %eax
80105c0e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c11:	50                   	push   %eax
80105c12:	ff 75 08             	pushl  0x8(%ebp)
80105c15:	e8 52 c2 ff ff       	call   80101e6c <readi>
80105c1a:	83 c4 10             	add    $0x10,%esp
80105c1d:	83 f8 10             	cmp    $0x10,%eax
80105c20:	74 0d                	je     80105c2f <isdirempty+0x36>
80105c22:	83 ec 0c             	sub    $0xc,%esp
80105c25:	68 6e 8d 10 80       	push   $0x80108d6e
80105c2a:	e8 69 a9 ff ff       	call   80100598 <panic>
80105c2f:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105c33:	66 85 c0             	test   %ax,%ax
80105c36:	74 07                	je     80105c3f <isdirempty+0x46>
80105c38:	b8 00 00 00 00       	mov    $0x0,%eax
80105c3d:	eb 1b                	jmp    80105c5a <isdirempty+0x61>
80105c3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c42:	83 c0 10             	add    $0x10,%eax
80105c45:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c48:	8b 45 08             	mov    0x8(%ebp),%eax
80105c4b:	8b 50 58             	mov    0x58(%eax),%edx
80105c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c51:	39 c2                	cmp    %eax,%edx
80105c53:	77 b3                	ja     80105c08 <isdirempty+0xf>
80105c55:	b8 01 00 00 00       	mov    $0x1,%eax
80105c5a:	c9                   	leave  
80105c5b:	c3                   	ret    

80105c5c <sys_unlink>:
80105c5c:	55                   	push   %ebp
80105c5d:	89 e5                	mov    %esp,%ebp
80105c5f:	83 ec 38             	sub    $0x38,%esp
80105c62:	83 ec 08             	sub    $0x8,%esp
80105c65:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105c68:	50                   	push   %eax
80105c69:	6a 00                	push   $0x0
80105c6b:	e8 91 fa ff ff       	call   80105701 <argstr>
80105c70:	83 c4 10             	add    $0x10,%esp
80105c73:	85 c0                	test   %eax,%eax
80105c75:	79 0a                	jns    80105c81 <sys_unlink+0x25>
80105c77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c7c:	e9 bc 01 00 00       	jmp    80105e3d <sys_unlink+0x1e1>
80105c81:	e8 51 d9 ff ff       	call   801035d7 <begin_op>
80105c86:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105c89:	83 ec 08             	sub    $0x8,%esp
80105c8c:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105c8f:	52                   	push   %edx
80105c90:	50                   	push   %eax
80105c91:	e8 96 c8 ff ff       	call   8010252c <nameiparent>
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ca0:	75 0f                	jne    80105cb1 <sys_unlink+0x55>
80105ca2:	e8 bc d9 ff ff       	call   80103663 <end_op>
80105ca7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cac:	e9 8c 01 00 00       	jmp    80105e3d <sys_unlink+0x1e1>
80105cb1:	83 ec 0c             	sub    $0xc,%esp
80105cb4:	ff 75 f4             	pushl  -0xc(%ebp)
80105cb7:	e8 26 bd ff ff       	call   801019e2 <ilock>
80105cbc:	83 c4 10             	add    $0x10,%esp
80105cbf:	83 ec 08             	sub    $0x8,%esp
80105cc2:	68 80 8d 10 80       	push   $0x80108d80
80105cc7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cca:	50                   	push   %eax
80105ccb:	e8 8f c4 ff ff       	call   8010215f <namecmp>
80105cd0:	83 c4 10             	add    $0x10,%esp
80105cd3:	85 c0                	test   %eax,%eax
80105cd5:	0f 84 4a 01 00 00    	je     80105e25 <sys_unlink+0x1c9>
80105cdb:	83 ec 08             	sub    $0x8,%esp
80105cde:	68 82 8d 10 80       	push   $0x80108d82
80105ce3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105ce6:	50                   	push   %eax
80105ce7:	e8 73 c4 ff ff       	call   8010215f <namecmp>
80105cec:	83 c4 10             	add    $0x10,%esp
80105cef:	85 c0                	test   %eax,%eax
80105cf1:	0f 84 2e 01 00 00    	je     80105e25 <sys_unlink+0x1c9>
80105cf7:	83 ec 04             	sub    $0x4,%esp
80105cfa:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105cfd:	50                   	push   %eax
80105cfe:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105d01:	50                   	push   %eax
80105d02:	ff 75 f4             	pushl  -0xc(%ebp)
80105d05:	e8 77 c4 ff ff       	call   80102181 <dirlookup>
80105d0a:	83 c4 10             	add    $0x10,%esp
80105d0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d10:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d14:	0f 84 0a 01 00 00    	je     80105e24 <sys_unlink+0x1c8>
80105d1a:	83 ec 0c             	sub    $0xc,%esp
80105d1d:	ff 75 f0             	pushl  -0x10(%ebp)
80105d20:	e8 bd bc ff ff       	call   801019e2 <ilock>
80105d25:	83 c4 10             	add    $0x10,%esp
80105d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d2b:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105d2f:	66 85 c0             	test   %ax,%ax
80105d32:	7f 0d                	jg     80105d41 <sys_unlink+0xe5>
80105d34:	83 ec 0c             	sub    $0xc,%esp
80105d37:	68 85 8d 10 80       	push   $0x80108d85
80105d3c:	e8 57 a8 ff ff       	call   80100598 <panic>
80105d41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d44:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105d48:	66 83 f8 01          	cmp    $0x1,%ax
80105d4c:	75 25                	jne    80105d73 <sys_unlink+0x117>
80105d4e:	83 ec 0c             	sub    $0xc,%esp
80105d51:	ff 75 f0             	pushl  -0x10(%ebp)
80105d54:	e8 a0 fe ff ff       	call   80105bf9 <isdirempty>
80105d59:	83 c4 10             	add    $0x10,%esp
80105d5c:	85 c0                	test   %eax,%eax
80105d5e:	75 13                	jne    80105d73 <sys_unlink+0x117>
80105d60:	83 ec 0c             	sub    $0xc,%esp
80105d63:	ff 75 f0             	pushl  -0x10(%ebp)
80105d66:	e8 66 be ff ff       	call   80101bd1 <iunlockput>
80105d6b:	83 c4 10             	add    $0x10,%esp
80105d6e:	e9 b2 00 00 00       	jmp    80105e25 <sys_unlink+0x1c9>
80105d73:	83 ec 04             	sub    $0x4,%esp
80105d76:	6a 10                	push   $0x10
80105d78:	6a 00                	push   $0x0
80105d7a:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d7d:	50                   	push   %eax
80105d7e:	e8 c9 f5 ff ff       	call   8010534c <memset>
80105d83:	83 c4 10             	add    $0x10,%esp
80105d86:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105d89:	6a 10                	push   $0x10
80105d8b:	50                   	push   %eax
80105d8c:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d8f:	50                   	push   %eax
80105d90:	ff 75 f4             	pushl  -0xc(%ebp)
80105d93:	e8 38 c2 ff ff       	call   80101fd0 <writei>
80105d98:	83 c4 10             	add    $0x10,%esp
80105d9b:	83 f8 10             	cmp    $0x10,%eax
80105d9e:	74 0d                	je     80105dad <sys_unlink+0x151>
80105da0:	83 ec 0c             	sub    $0xc,%esp
80105da3:	68 97 8d 10 80       	push   $0x80108d97
80105da8:	e8 eb a7 ff ff       	call   80100598 <panic>
80105dad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105db0:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105db4:	66 83 f8 01          	cmp    $0x1,%ax
80105db8:	75 21                	jne    80105ddb <sys_unlink+0x17f>
80105dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dbd:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105dc1:	83 e8 01             	sub    $0x1,%eax
80105dc4:	89 c2                	mov    %eax,%edx
80105dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dc9:	66 89 50 56          	mov    %dx,0x56(%eax)
80105dcd:	83 ec 0c             	sub    $0xc,%esp
80105dd0:	ff 75 f4             	pushl  -0xc(%ebp)
80105dd3:	e8 45 ba ff ff       	call   8010181d <iupdate>
80105dd8:	83 c4 10             	add    $0x10,%esp
80105ddb:	83 ec 0c             	sub    $0xc,%esp
80105dde:	ff 75 f4             	pushl  -0xc(%ebp)
80105de1:	e8 eb bd ff ff       	call   80101bd1 <iunlockput>
80105de6:	83 c4 10             	add    $0x10,%esp
80105de9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dec:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105df0:	83 e8 01             	sub    $0x1,%eax
80105df3:	89 c2                	mov    %eax,%edx
80105df5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105df8:	66 89 50 56          	mov    %dx,0x56(%eax)
80105dfc:	83 ec 0c             	sub    $0xc,%esp
80105dff:	ff 75 f0             	pushl  -0x10(%ebp)
80105e02:	e8 16 ba ff ff       	call   8010181d <iupdate>
80105e07:	83 c4 10             	add    $0x10,%esp
80105e0a:	83 ec 0c             	sub    $0xc,%esp
80105e0d:	ff 75 f0             	pushl  -0x10(%ebp)
80105e10:	e8 bc bd ff ff       	call   80101bd1 <iunlockput>
80105e15:	83 c4 10             	add    $0x10,%esp
80105e18:	e8 46 d8 ff ff       	call   80103663 <end_op>
80105e1d:	b8 00 00 00 00       	mov    $0x0,%eax
80105e22:	eb 19                	jmp    80105e3d <sys_unlink+0x1e1>
80105e24:	90                   	nop
80105e25:	83 ec 0c             	sub    $0xc,%esp
80105e28:	ff 75 f4             	pushl  -0xc(%ebp)
80105e2b:	e8 a1 bd ff ff       	call   80101bd1 <iunlockput>
80105e30:	83 c4 10             	add    $0x10,%esp
80105e33:	e8 2b d8 ff ff       	call   80103663 <end_op>
80105e38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e3d:	c9                   	leave  
80105e3e:	c3                   	ret    

80105e3f <create>:
80105e3f:	55                   	push   %ebp
80105e40:	89 e5                	mov    %esp,%ebp
80105e42:	83 ec 38             	sub    $0x38,%esp
80105e45:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105e48:	8b 55 10             	mov    0x10(%ebp),%edx
80105e4b:	8b 45 14             	mov    0x14(%ebp),%eax
80105e4e:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105e52:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105e56:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
80105e5a:	83 ec 08             	sub    $0x8,%esp
80105e5d:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e60:	50                   	push   %eax
80105e61:	ff 75 08             	pushl  0x8(%ebp)
80105e64:	e8 c3 c6 ff ff       	call   8010252c <nameiparent>
80105e69:	83 c4 10             	add    $0x10,%esp
80105e6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e73:	75 0a                	jne    80105e7f <create+0x40>
80105e75:	b8 00 00 00 00       	mov    $0x0,%eax
80105e7a:	e9 90 01 00 00       	jmp    8010600f <create+0x1d0>
80105e7f:	83 ec 0c             	sub    $0xc,%esp
80105e82:	ff 75 f4             	pushl  -0xc(%ebp)
80105e85:	e8 58 bb ff ff       	call   801019e2 <ilock>
80105e8a:	83 c4 10             	add    $0x10,%esp
80105e8d:	83 ec 04             	sub    $0x4,%esp
80105e90:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e93:	50                   	push   %eax
80105e94:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e97:	50                   	push   %eax
80105e98:	ff 75 f4             	pushl  -0xc(%ebp)
80105e9b:	e8 e1 c2 ff ff       	call   80102181 <dirlookup>
80105ea0:	83 c4 10             	add    $0x10,%esp
80105ea3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ea6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105eaa:	74 50                	je     80105efc <create+0xbd>
80105eac:	83 ec 0c             	sub    $0xc,%esp
80105eaf:	ff 75 f4             	pushl  -0xc(%ebp)
80105eb2:	e8 1a bd ff ff       	call   80101bd1 <iunlockput>
80105eb7:	83 c4 10             	add    $0x10,%esp
80105eba:	83 ec 0c             	sub    $0xc,%esp
80105ebd:	ff 75 f0             	pushl  -0x10(%ebp)
80105ec0:	e8 1d bb ff ff       	call   801019e2 <ilock>
80105ec5:	83 c4 10             	add    $0x10,%esp
80105ec8:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105ecd:	75 15                	jne    80105ee4 <create+0xa5>
80105ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ed2:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105ed6:	66 83 f8 02          	cmp    $0x2,%ax
80105eda:	75 08                	jne    80105ee4 <create+0xa5>
80105edc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105edf:	e9 2b 01 00 00       	jmp    8010600f <create+0x1d0>
80105ee4:	83 ec 0c             	sub    $0xc,%esp
80105ee7:	ff 75 f0             	pushl  -0x10(%ebp)
80105eea:	e8 e2 bc ff ff       	call   80101bd1 <iunlockput>
80105eef:	83 c4 10             	add    $0x10,%esp
80105ef2:	b8 00 00 00 00       	mov    $0x0,%eax
80105ef7:	e9 13 01 00 00       	jmp    8010600f <create+0x1d0>
80105efc:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105f00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f03:	8b 00                	mov    (%eax),%eax
80105f05:	83 ec 08             	sub    $0x8,%esp
80105f08:	52                   	push   %edx
80105f09:	50                   	push   %eax
80105f0a:	e8 39 b8 ff ff       	call   80101748 <ialloc>
80105f0f:	83 c4 10             	add    $0x10,%esp
80105f12:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f19:	75 0d                	jne    80105f28 <create+0xe9>
80105f1b:	83 ec 0c             	sub    $0xc,%esp
80105f1e:	68 a6 8d 10 80       	push   $0x80108da6
80105f23:	e8 70 a6 ff ff       	call   80100598 <panic>
80105f28:	83 ec 0c             	sub    $0xc,%esp
80105f2b:	ff 75 f0             	pushl  -0x10(%ebp)
80105f2e:	e8 af ba ff ff       	call   801019e2 <ilock>
80105f33:	83 c4 10             	add    $0x10,%esp
80105f36:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f39:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105f3d:	66 89 50 52          	mov    %dx,0x52(%eax)
80105f41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f44:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105f48:	66 89 50 54          	mov    %dx,0x54(%eax)
80105f4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f4f:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
80105f55:	83 ec 0c             	sub    $0xc,%esp
80105f58:	ff 75 f0             	pushl  -0x10(%ebp)
80105f5b:	e8 bd b8 ff ff       	call   8010181d <iupdate>
80105f60:	83 c4 10             	add    $0x10,%esp
80105f63:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105f68:	75 6a                	jne    80105fd4 <create+0x195>
80105f6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f6d:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105f71:	83 c0 01             	add    $0x1,%eax
80105f74:	89 c2                	mov    %eax,%edx
80105f76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f79:	66 89 50 56          	mov    %dx,0x56(%eax)
80105f7d:	83 ec 0c             	sub    $0xc,%esp
80105f80:	ff 75 f4             	pushl  -0xc(%ebp)
80105f83:	e8 95 b8 ff ff       	call   8010181d <iupdate>
80105f88:	83 c4 10             	add    $0x10,%esp
80105f8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f8e:	8b 40 04             	mov    0x4(%eax),%eax
80105f91:	83 ec 04             	sub    $0x4,%esp
80105f94:	50                   	push   %eax
80105f95:	68 80 8d 10 80       	push   $0x80108d80
80105f9a:	ff 75 f0             	pushl  -0x10(%ebp)
80105f9d:	e8 a8 c2 ff ff       	call   8010224a <dirlink>
80105fa2:	83 c4 10             	add    $0x10,%esp
80105fa5:	85 c0                	test   %eax,%eax
80105fa7:	78 1e                	js     80105fc7 <create+0x188>
80105fa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fac:	8b 40 04             	mov    0x4(%eax),%eax
80105faf:	83 ec 04             	sub    $0x4,%esp
80105fb2:	50                   	push   %eax
80105fb3:	68 82 8d 10 80       	push   $0x80108d82
80105fb8:	ff 75 f0             	pushl  -0x10(%ebp)
80105fbb:	e8 8a c2 ff ff       	call   8010224a <dirlink>
80105fc0:	83 c4 10             	add    $0x10,%esp
80105fc3:	85 c0                	test   %eax,%eax
80105fc5:	79 0d                	jns    80105fd4 <create+0x195>
80105fc7:	83 ec 0c             	sub    $0xc,%esp
80105fca:	68 b5 8d 10 80       	push   $0x80108db5
80105fcf:	e8 c4 a5 ff ff       	call   80100598 <panic>
80105fd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fd7:	8b 40 04             	mov    0x4(%eax),%eax
80105fda:	83 ec 04             	sub    $0x4,%esp
80105fdd:	50                   	push   %eax
80105fde:	8d 45 de             	lea    -0x22(%ebp),%eax
80105fe1:	50                   	push   %eax
80105fe2:	ff 75 f4             	pushl  -0xc(%ebp)
80105fe5:	e8 60 c2 ff ff       	call   8010224a <dirlink>
80105fea:	83 c4 10             	add    $0x10,%esp
80105fed:	85 c0                	test   %eax,%eax
80105fef:	79 0d                	jns    80105ffe <create+0x1bf>
80105ff1:	83 ec 0c             	sub    $0xc,%esp
80105ff4:	68 c1 8d 10 80       	push   $0x80108dc1
80105ff9:	e8 9a a5 ff ff       	call   80100598 <panic>
80105ffe:	83 ec 0c             	sub    $0xc,%esp
80106001:	ff 75 f4             	pushl  -0xc(%ebp)
80106004:	e8 c8 bb ff ff       	call   80101bd1 <iunlockput>
80106009:	83 c4 10             	add    $0x10,%esp
8010600c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010600f:	c9                   	leave  
80106010:	c3                   	ret    

80106011 <sys_open>:
80106011:	55                   	push   %ebp
80106012:	89 e5                	mov    %esp,%ebp
80106014:	83 ec 28             	sub    $0x28,%esp
80106017:	83 ec 08             	sub    $0x8,%esp
8010601a:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010601d:	50                   	push   %eax
8010601e:	6a 00                	push   $0x0
80106020:	e8 dc f6 ff ff       	call   80105701 <argstr>
80106025:	83 c4 10             	add    $0x10,%esp
80106028:	85 c0                	test   %eax,%eax
8010602a:	78 15                	js     80106041 <sys_open+0x30>
8010602c:	83 ec 08             	sub    $0x8,%esp
8010602f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106032:	50                   	push   %eax
80106033:	6a 01                	push   $0x1
80106035:	e8 37 f6 ff ff       	call   80105671 <argint>
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	85 c0                	test   %eax,%eax
8010603f:	79 0a                	jns    8010604b <sys_open+0x3a>
80106041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106046:	e9 61 01 00 00       	jmp    801061ac <sys_open+0x19b>
8010604b:	e8 87 d5 ff ff       	call   801035d7 <begin_op>
80106050:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106053:	25 00 02 00 00       	and    $0x200,%eax
80106058:	85 c0                	test   %eax,%eax
8010605a:	74 2a                	je     80106086 <sys_open+0x75>
8010605c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010605f:	6a 00                	push   $0x0
80106061:	6a 00                	push   $0x0
80106063:	6a 02                	push   $0x2
80106065:	50                   	push   %eax
80106066:	e8 d4 fd ff ff       	call   80105e3f <create>
8010606b:	83 c4 10             	add    $0x10,%esp
8010606e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106071:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106075:	75 75                	jne    801060ec <sys_open+0xdb>
80106077:	e8 e7 d5 ff ff       	call   80103663 <end_op>
8010607c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106081:	e9 26 01 00 00       	jmp    801061ac <sys_open+0x19b>
80106086:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106089:	83 ec 0c             	sub    $0xc,%esp
8010608c:	50                   	push   %eax
8010608d:	e8 78 c4 ff ff       	call   8010250a <namei>
80106092:	83 c4 10             	add    $0x10,%esp
80106095:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106098:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010609c:	75 0f                	jne    801060ad <sys_open+0x9c>
8010609e:	e8 c0 d5 ff ff       	call   80103663 <end_op>
801060a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060a8:	e9 ff 00 00 00       	jmp    801061ac <sys_open+0x19b>
801060ad:	83 ec 0c             	sub    $0xc,%esp
801060b0:	ff 75 f4             	pushl  -0xc(%ebp)
801060b3:	e8 2a b9 ff ff       	call   801019e2 <ilock>
801060b8:	83 c4 10             	add    $0x10,%esp
801060bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060be:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801060c2:	66 83 f8 01          	cmp    $0x1,%ax
801060c6:	75 24                	jne    801060ec <sys_open+0xdb>
801060c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060cb:	85 c0                	test   %eax,%eax
801060cd:	74 1d                	je     801060ec <sys_open+0xdb>
801060cf:	83 ec 0c             	sub    $0xc,%esp
801060d2:	ff 75 f4             	pushl  -0xc(%ebp)
801060d5:	e8 f7 ba ff ff       	call   80101bd1 <iunlockput>
801060da:	83 c4 10             	add    $0x10,%esp
801060dd:	e8 81 d5 ff ff       	call   80103663 <end_op>
801060e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060e7:	e9 c0 00 00 00       	jmp    801061ac <sys_open+0x19b>
801060ec:	e8 f3 ae ff ff       	call   80100fe4 <filealloc>
801060f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801060f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801060f8:	74 17                	je     80106111 <sys_open+0x100>
801060fa:	83 ec 0c             	sub    $0xc,%esp
801060fd:	ff 75 f0             	pushl  -0x10(%ebp)
80106100:	e8 37 f7 ff ff       	call   8010583c <fdalloc>
80106105:	83 c4 10             	add    $0x10,%esp
80106108:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010610b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010610f:	79 2e                	jns    8010613f <sys_open+0x12e>
80106111:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106115:	74 0e                	je     80106125 <sys_open+0x114>
80106117:	83 ec 0c             	sub    $0xc,%esp
8010611a:	ff 75 f0             	pushl  -0x10(%ebp)
8010611d:	e8 80 af ff ff       	call   801010a2 <fileclose>
80106122:	83 c4 10             	add    $0x10,%esp
80106125:	83 ec 0c             	sub    $0xc,%esp
80106128:	ff 75 f4             	pushl  -0xc(%ebp)
8010612b:	e8 a1 ba ff ff       	call   80101bd1 <iunlockput>
80106130:	83 c4 10             	add    $0x10,%esp
80106133:	e8 2b d5 ff ff       	call   80103663 <end_op>
80106138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010613d:	eb 6d                	jmp    801061ac <sys_open+0x19b>
8010613f:	83 ec 0c             	sub    $0xc,%esp
80106142:	ff 75 f4             	pushl  -0xc(%ebp)
80106145:	e8 af b9 ff ff       	call   80101af9 <iunlock>
8010614a:	83 c4 10             	add    $0x10,%esp
8010614d:	e8 11 d5 ff ff       	call   80103663 <end_op>
80106152:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106155:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
8010615b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010615e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106161:	89 50 10             	mov    %edx,0x10(%eax)
80106164:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106167:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
8010616e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106171:	83 e0 01             	and    $0x1,%eax
80106174:	85 c0                	test   %eax,%eax
80106176:	0f 94 c0             	sete   %al
80106179:	89 c2                	mov    %eax,%edx
8010617b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010617e:	88 50 08             	mov    %dl,0x8(%eax)
80106181:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106184:	83 e0 01             	and    $0x1,%eax
80106187:	85 c0                	test   %eax,%eax
80106189:	75 0a                	jne    80106195 <sys_open+0x184>
8010618b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010618e:	83 e0 02             	and    $0x2,%eax
80106191:	85 c0                	test   %eax,%eax
80106193:	74 07                	je     8010619c <sys_open+0x18b>
80106195:	b8 01 00 00 00       	mov    $0x1,%eax
8010619a:	eb 05                	jmp    801061a1 <sys_open+0x190>
8010619c:	b8 00 00 00 00       	mov    $0x0,%eax
801061a1:	89 c2                	mov    %eax,%edx
801061a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061a6:	88 50 09             	mov    %dl,0x9(%eax)
801061a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061ac:	c9                   	leave  
801061ad:	c3                   	ret    

801061ae <sys_mkdir>:
801061ae:	55                   	push   %ebp
801061af:	89 e5                	mov    %esp,%ebp
801061b1:	83 ec 18             	sub    $0x18,%esp
801061b4:	e8 1e d4 ff ff       	call   801035d7 <begin_op>
801061b9:	83 ec 08             	sub    $0x8,%esp
801061bc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061bf:	50                   	push   %eax
801061c0:	6a 00                	push   $0x0
801061c2:	e8 3a f5 ff ff       	call   80105701 <argstr>
801061c7:	83 c4 10             	add    $0x10,%esp
801061ca:	85 c0                	test   %eax,%eax
801061cc:	78 1b                	js     801061e9 <sys_mkdir+0x3b>
801061ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061d1:	6a 00                	push   $0x0
801061d3:	6a 00                	push   $0x0
801061d5:	6a 01                	push   $0x1
801061d7:	50                   	push   %eax
801061d8:	e8 62 fc ff ff       	call   80105e3f <create>
801061dd:	83 c4 10             	add    $0x10,%esp
801061e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061e7:	75 0c                	jne    801061f5 <sys_mkdir+0x47>
801061e9:	e8 75 d4 ff ff       	call   80103663 <end_op>
801061ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061f3:	eb 18                	jmp    8010620d <sys_mkdir+0x5f>
801061f5:	83 ec 0c             	sub    $0xc,%esp
801061f8:	ff 75 f4             	pushl  -0xc(%ebp)
801061fb:	e8 d1 b9 ff ff       	call   80101bd1 <iunlockput>
80106200:	83 c4 10             	add    $0x10,%esp
80106203:	e8 5b d4 ff ff       	call   80103663 <end_op>
80106208:	b8 00 00 00 00       	mov    $0x0,%eax
8010620d:	c9                   	leave  
8010620e:	c3                   	ret    

8010620f <sys_mknod>:
8010620f:	55                   	push   %ebp
80106210:	89 e5                	mov    %esp,%ebp
80106212:	83 ec 18             	sub    $0x18,%esp
80106215:	e8 bd d3 ff ff       	call   801035d7 <begin_op>
8010621a:	83 ec 08             	sub    $0x8,%esp
8010621d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106220:	50                   	push   %eax
80106221:	6a 00                	push   $0x0
80106223:	e8 d9 f4 ff ff       	call   80105701 <argstr>
80106228:	83 c4 10             	add    $0x10,%esp
8010622b:	85 c0                	test   %eax,%eax
8010622d:	78 4f                	js     8010627e <sys_mknod+0x6f>
8010622f:	83 ec 08             	sub    $0x8,%esp
80106232:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106235:	50                   	push   %eax
80106236:	6a 01                	push   $0x1
80106238:	e8 34 f4 ff ff       	call   80105671 <argint>
8010623d:	83 c4 10             	add    $0x10,%esp
80106240:	85 c0                	test   %eax,%eax
80106242:	78 3a                	js     8010627e <sys_mknod+0x6f>
80106244:	83 ec 08             	sub    $0x8,%esp
80106247:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010624a:	50                   	push   %eax
8010624b:	6a 02                	push   $0x2
8010624d:	e8 1f f4 ff ff       	call   80105671 <argint>
80106252:	83 c4 10             	add    $0x10,%esp
80106255:	85 c0                	test   %eax,%eax
80106257:	78 25                	js     8010627e <sys_mknod+0x6f>
80106259:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010625c:	0f bf c8             	movswl %ax,%ecx
8010625f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106262:	0f bf d0             	movswl %ax,%edx
80106265:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106268:	51                   	push   %ecx
80106269:	52                   	push   %edx
8010626a:	6a 03                	push   $0x3
8010626c:	50                   	push   %eax
8010626d:	e8 cd fb ff ff       	call   80105e3f <create>
80106272:	83 c4 10             	add    $0x10,%esp
80106275:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106278:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010627c:	75 0c                	jne    8010628a <sys_mknod+0x7b>
8010627e:	e8 e0 d3 ff ff       	call   80103663 <end_op>
80106283:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106288:	eb 18                	jmp    801062a2 <sys_mknod+0x93>
8010628a:	83 ec 0c             	sub    $0xc,%esp
8010628d:	ff 75 f4             	pushl  -0xc(%ebp)
80106290:	e8 3c b9 ff ff       	call   80101bd1 <iunlockput>
80106295:	83 c4 10             	add    $0x10,%esp
80106298:	e8 c6 d3 ff ff       	call   80103663 <end_op>
8010629d:	b8 00 00 00 00       	mov    $0x0,%eax
801062a2:	c9                   	leave  
801062a3:	c3                   	ret    

801062a4 <sys_chdir>:
801062a4:	55                   	push   %ebp
801062a5:	89 e5                	mov    %esp,%ebp
801062a7:	83 ec 18             	sub    $0x18,%esp
801062aa:	e8 28 d3 ff ff       	call   801035d7 <begin_op>
801062af:	83 ec 08             	sub    $0x8,%esp
801062b2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062b5:	50                   	push   %eax
801062b6:	6a 00                	push   $0x0
801062b8:	e8 44 f4 ff ff       	call   80105701 <argstr>
801062bd:	83 c4 10             	add    $0x10,%esp
801062c0:	85 c0                	test   %eax,%eax
801062c2:	78 18                	js     801062dc <sys_chdir+0x38>
801062c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062c7:	83 ec 0c             	sub    $0xc,%esp
801062ca:	50                   	push   %eax
801062cb:	e8 3a c2 ff ff       	call   8010250a <namei>
801062d0:	83 c4 10             	add    $0x10,%esp
801062d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062da:	75 0c                	jne    801062e8 <sys_chdir+0x44>
801062dc:	e8 82 d3 ff ff       	call   80103663 <end_op>
801062e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062e6:	eb 6e                	jmp    80106356 <sys_chdir+0xb2>
801062e8:	83 ec 0c             	sub    $0xc,%esp
801062eb:	ff 75 f4             	pushl  -0xc(%ebp)
801062ee:	e8 ef b6 ff ff       	call   801019e2 <ilock>
801062f3:	83 c4 10             	add    $0x10,%esp
801062f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062f9:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801062fd:	66 83 f8 01          	cmp    $0x1,%ax
80106301:	74 1a                	je     8010631d <sys_chdir+0x79>
80106303:	83 ec 0c             	sub    $0xc,%esp
80106306:	ff 75 f4             	pushl  -0xc(%ebp)
80106309:	e8 c3 b8 ff ff       	call   80101bd1 <iunlockput>
8010630e:	83 c4 10             	add    $0x10,%esp
80106311:	e8 4d d3 ff ff       	call   80103663 <end_op>
80106316:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631b:	eb 39                	jmp    80106356 <sys_chdir+0xb2>
8010631d:	83 ec 0c             	sub    $0xc,%esp
80106320:	ff 75 f4             	pushl  -0xc(%ebp)
80106323:	e8 d1 b7 ff ff       	call   80101af9 <iunlock>
80106328:	83 c4 10             	add    $0x10,%esp
8010632b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106331:	8b 40 6c             	mov    0x6c(%eax),%eax
80106334:	83 ec 0c             	sub    $0xc,%esp
80106337:	50                   	push   %eax
80106338:	e8 00 b8 ff ff       	call   80101b3d <iput>
8010633d:	83 c4 10             	add    $0x10,%esp
80106340:	e8 1e d3 ff ff       	call   80103663 <end_op>
80106345:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010634b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010634e:	89 50 6c             	mov    %edx,0x6c(%eax)
80106351:	b8 00 00 00 00       	mov    $0x0,%eax
80106356:	c9                   	leave  
80106357:	c3                   	ret    

80106358 <sys_exec>:
80106358:	55                   	push   %ebp
80106359:	89 e5                	mov    %esp,%ebp
8010635b:	81 ec 98 00 00 00    	sub    $0x98,%esp
80106361:	83 ec 08             	sub    $0x8,%esp
80106364:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106367:	50                   	push   %eax
80106368:	6a 00                	push   $0x0
8010636a:	e8 92 f3 ff ff       	call   80105701 <argstr>
8010636f:	83 c4 10             	add    $0x10,%esp
80106372:	85 c0                	test   %eax,%eax
80106374:	78 18                	js     8010638e <sys_exec+0x36>
80106376:	83 ec 08             	sub    $0x8,%esp
80106379:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010637f:	50                   	push   %eax
80106380:	6a 01                	push   $0x1
80106382:	e8 ea f2 ff ff       	call   80105671 <argint>
80106387:	83 c4 10             	add    $0x10,%esp
8010638a:	85 c0                	test   %eax,%eax
8010638c:	79 0a                	jns    80106398 <sys_exec+0x40>
8010638e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106393:	e9 c6 00 00 00       	jmp    8010645e <sys_exec+0x106>
80106398:	83 ec 04             	sub    $0x4,%esp
8010639b:	68 80 00 00 00       	push   $0x80
801063a0:	6a 00                	push   $0x0
801063a2:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801063a8:	50                   	push   %eax
801063a9:	e8 9e ef ff ff       	call   8010534c <memset>
801063ae:	83 c4 10             	add    $0x10,%esp
801063b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801063b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063bb:	83 f8 1f             	cmp    $0x1f,%eax
801063be:	76 0a                	jbe    801063ca <sys_exec+0x72>
801063c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063c5:	e9 94 00 00 00       	jmp    8010645e <sys_exec+0x106>
801063ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063cd:	c1 e0 02             	shl    $0x2,%eax
801063d0:	89 c2                	mov    %eax,%edx
801063d2:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801063d8:	01 c2                	add    %eax,%edx
801063da:	83 ec 08             	sub    $0x8,%esp
801063dd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801063e3:	50                   	push   %eax
801063e4:	52                   	push   %edx
801063e5:	e8 eb f1 ff ff       	call   801055d5 <fetchint>
801063ea:	83 c4 10             	add    $0x10,%esp
801063ed:	85 c0                	test   %eax,%eax
801063ef:	79 07                	jns    801063f8 <sys_exec+0xa0>
801063f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063f6:	eb 66                	jmp    8010645e <sys_exec+0x106>
801063f8:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801063fe:	85 c0                	test   %eax,%eax
80106400:	75 27                	jne    80106429 <sys_exec+0xd1>
80106402:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106405:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010640c:	00 00 00 00 
80106410:	90                   	nop
80106411:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106414:	83 ec 08             	sub    $0x8,%esp
80106417:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010641d:	52                   	push   %edx
8010641e:	50                   	push   %eax
8010641f:	e8 44 a7 ff ff       	call   80100b68 <exec>
80106424:	83 c4 10             	add    $0x10,%esp
80106427:	eb 35                	jmp    8010645e <sys_exec+0x106>
80106429:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010642f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106432:	c1 e2 02             	shl    $0x2,%edx
80106435:	01 c2                	add    %eax,%edx
80106437:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010643d:	83 ec 08             	sub    $0x8,%esp
80106440:	52                   	push   %edx
80106441:	50                   	push   %eax
80106442:	e8 c8 f1 ff ff       	call   8010560f <fetchstr>
80106447:	83 c4 10             	add    $0x10,%esp
8010644a:	85 c0                	test   %eax,%eax
8010644c:	79 07                	jns    80106455 <sys_exec+0xfd>
8010644e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106453:	eb 09                	jmp    8010645e <sys_exec+0x106>
80106455:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106459:	e9 5a ff ff ff       	jmp    801063b8 <sys_exec+0x60>
8010645e:	c9                   	leave  
8010645f:	c3                   	ret    

80106460 <sys_pipe>:
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	83 ec 28             	sub    $0x28,%esp
80106466:	83 ec 04             	sub    $0x4,%esp
80106469:	6a 08                	push   $0x8
8010646b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010646e:	50                   	push   %eax
8010646f:	6a 00                	push   $0x0
80106471:	e8 29 f2 ff ff       	call   8010569f <argptr>
80106476:	83 c4 10             	add    $0x10,%esp
80106479:	85 c0                	test   %eax,%eax
8010647b:	79 0a                	jns    80106487 <sys_pipe+0x27>
8010647d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106482:	e9 af 00 00 00       	jmp    80106536 <sys_pipe+0xd6>
80106487:	83 ec 08             	sub    $0x8,%esp
8010648a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010648d:	50                   	push   %eax
8010648e:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106491:	50                   	push   %eax
80106492:	e8 3a db ff ff       	call   80103fd1 <pipealloc>
80106497:	83 c4 10             	add    $0x10,%esp
8010649a:	85 c0                	test   %eax,%eax
8010649c:	79 0a                	jns    801064a8 <sys_pipe+0x48>
8010649e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064a3:	e9 8e 00 00 00       	jmp    80106536 <sys_pipe+0xd6>
801064a8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
801064af:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064b2:	83 ec 0c             	sub    $0xc,%esp
801064b5:	50                   	push   %eax
801064b6:	e8 81 f3 ff ff       	call   8010583c <fdalloc>
801064bb:	83 c4 10             	add    $0x10,%esp
801064be:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064c5:	78 18                	js     801064df <sys_pipe+0x7f>
801064c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064ca:	83 ec 0c             	sub    $0xc,%esp
801064cd:	50                   	push   %eax
801064ce:	e8 69 f3 ff ff       	call   8010583c <fdalloc>
801064d3:	83 c4 10             	add    $0x10,%esp
801064d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801064d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801064dd:	79 3f                	jns    8010651e <sys_pipe+0xbe>
801064df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064e3:	78 14                	js     801064f9 <sys_pipe+0x99>
801064e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064ee:	83 c2 08             	add    $0x8,%edx
801064f1:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801064f8:	00 
801064f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064fc:	83 ec 0c             	sub    $0xc,%esp
801064ff:	50                   	push   %eax
80106500:	e8 9d ab ff ff       	call   801010a2 <fileclose>
80106505:	83 c4 10             	add    $0x10,%esp
80106508:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010650b:	83 ec 0c             	sub    $0xc,%esp
8010650e:	50                   	push   %eax
8010650f:	e8 8e ab ff ff       	call   801010a2 <fileclose>
80106514:	83 c4 10             	add    $0x10,%esp
80106517:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010651c:	eb 18                	jmp    80106536 <sys_pipe+0xd6>
8010651e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106521:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106524:	89 10                	mov    %edx,(%eax)
80106526:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106529:	8d 50 04             	lea    0x4(%eax),%edx
8010652c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010652f:	89 02                	mov    %eax,(%edx)
80106531:	b8 00 00 00 00       	mov    $0x0,%eax
80106536:	c9                   	leave  
80106537:	c3                   	ret    

80106538 <sys_dup2>:
80106538:	55                   	push   %ebp
80106539:	89 e5                	mov    %esp,%ebp
8010653b:	53                   	push   %ebx
8010653c:	83 ec 14             	sub    $0x14,%esp
8010653f:	83 ec 04             	sub    $0x4,%esp
80106542:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106545:	50                   	push   %eax
80106546:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106549:	50                   	push   %eax
8010654a:	6a 00                	push   $0x0
8010654c:	e8 76 f2 ff ff       	call   801057c7 <argfd>
80106551:	83 c4 10             	add    $0x10,%esp
80106554:	85 c0                	test   %eax,%eax
80106556:	79 0a                	jns    80106562 <sys_dup2+0x2a>
80106558:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010655d:	e9 a7 00 00 00       	jmp    80106609 <sys_dup2+0xd1>
80106562:	83 ec 08             	sub    $0x8,%esp
80106565:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106568:	50                   	push   %eax
80106569:	6a 01                	push   $0x1
8010656b:	e8 01 f1 ff ff       	call   80105671 <argint>
80106570:	83 c4 10             	add    $0x10,%esp
80106573:	85 c0                	test   %eax,%eax
80106575:	79 0a                	jns    80106581 <sys_dup2+0x49>
80106577:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010657c:	e9 88 00 00 00       	jmp    80106609 <sys_dup2+0xd1>
80106581:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106584:	85 c0                	test   %eax,%eax
80106586:	78 08                	js     80106590 <sys_dup2+0x58>
80106588:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010658b:	83 f8 0f             	cmp    $0xf,%eax
8010658e:	7e 07                	jle    80106597 <sys_dup2+0x5f>
80106590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106595:	eb 72                	jmp    80106609 <sys_dup2+0xd1>
80106597:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010659a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010659d:	39 c2                	cmp    %eax,%edx
8010659f:	75 05                	jne    801065a6 <sys_dup2+0x6e>
801065a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801065a4:	eb 63                	jmp    80106609 <sys_dup2+0xd1>
801065a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065ac:	8b 55 ec             	mov    -0x14(%ebp),%edx
801065af:	83 c2 08             	add    $0x8,%edx
801065b2:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801065b6:	85 c0                	test   %eax,%eax
801065b8:	74 1c                	je     801065d6 <sys_dup2+0x9e>
801065ba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065c0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801065c3:	83 c2 08             	add    $0x8,%edx
801065c6:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801065ca:	83 ec 0c             	sub    $0xc,%esp
801065cd:	50                   	push   %eax
801065ce:	e8 cf aa ff ff       	call   801010a2 <fileclose>
801065d3:	83 c4 10             	add    $0x10,%esp
801065d6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065dc:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801065df:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801065e6:	8b 5d f0             	mov    -0x10(%ebp),%ebx
801065e9:	83 c3 08             	add    $0x8,%ebx
801065ec:	8b 54 9a 0c          	mov    0xc(%edx,%ebx,4),%edx
801065f0:	83 c1 08             	add    $0x8,%ecx
801065f3:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
801065f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065fa:	83 ec 0c             	sub    $0xc,%esp
801065fd:	50                   	push   %eax
801065fe:	e8 4e aa ff ff       	call   80101051 <filedup>
80106603:	83 c4 10             	add    $0x10,%esp
80106606:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106609:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010660c:	c9                   	leave  
8010660d:	c3                   	ret    

8010660e <sys_fork>:
8010660e:	55                   	push   %ebp
8010660f:	89 e5                	mov    %esp,%ebp
80106611:	83 ec 08             	sub    $0x8,%esp
80106614:	e8 ce e0 ff ff       	call   801046e7 <fork>
80106619:	c9                   	leave  
8010661a:	c3                   	ret    

8010661b <sys_exit>:
8010661b:	55                   	push   %ebp
8010661c:	89 e5                	mov    %esp,%ebp
8010661e:	83 ec 08             	sub    $0x8,%esp
80106621:	e8 52 e2 ff ff       	call   80104878 <exit>
80106626:	b8 00 00 00 00       	mov    $0x0,%eax
8010662b:	c9                   	leave  
8010662c:	c3                   	ret    

8010662d <sys_wait>:
8010662d:	55                   	push   %ebp
8010662e:	89 e5                	mov    %esp,%ebp
80106630:	83 ec 08             	sub    $0x8,%esp
80106633:	e8 78 e3 ff ff       	call   801049b0 <wait>
80106638:	c9                   	leave  
80106639:	c3                   	ret    

8010663a <sys_kill>:
8010663a:	55                   	push   %ebp
8010663b:	89 e5                	mov    %esp,%ebp
8010663d:	83 ec 18             	sub    $0x18,%esp
80106640:	83 ec 08             	sub    $0x8,%esp
80106643:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106646:	50                   	push   %eax
80106647:	6a 00                	push   $0x0
80106649:	e8 23 f0 ff ff       	call   80105671 <argint>
8010664e:	83 c4 10             	add    $0x10,%esp
80106651:	85 c0                	test   %eax,%eax
80106653:	79 07                	jns    8010665c <sys_kill+0x22>
80106655:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010665a:	eb 0f                	jmp    8010666b <sys_kill+0x31>
8010665c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010665f:	83 ec 0c             	sub    $0xc,%esp
80106662:	50                   	push   %eax
80106663:	e8 6d e7 ff ff       	call   80104dd5 <kill>
80106668:	83 c4 10             	add    $0x10,%esp
8010666b:	c9                   	leave  
8010666c:	c3                   	ret    

8010666d <sys_getpid>:
8010666d:	55                   	push   %ebp
8010666e:	89 e5                	mov    %esp,%ebp
80106670:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106676:	8b 40 14             	mov    0x14(%eax),%eax
80106679:	5d                   	pop    %ebp
8010667a:	c3                   	ret    

8010667b <sys_sbrk>:
8010667b:	55                   	push   %ebp
8010667c:	89 e5                	mov    %esp,%ebp
8010667e:	83 ec 18             	sub    $0x18,%esp
80106681:	83 ec 08             	sub    $0x8,%esp
80106684:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106687:	50                   	push   %eax
80106688:	6a 00                	push   $0x0
8010668a:	e8 e2 ef ff ff       	call   80105671 <argint>
8010668f:	83 c4 10             	add    $0x10,%esp
80106692:	85 c0                	test   %eax,%eax
80106694:	79 07                	jns    8010669d <sys_sbrk+0x22>
80106696:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010669b:	eb 77                	jmp    80106714 <sys_sbrk+0x99>
8010669d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066a3:	8b 00                	mov    (%eax),%eax
801066a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801066a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066ae:	8b 00                	mov    (%eax),%eax
801066b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801066b3:	01 d0                	add    %edx,%eax
801066b5:	85 c0                	test   %eax,%eax
801066b7:	79 17                	jns    801066d0 <sys_sbrk+0x55>
801066b9:	83 ec 0c             	sub    $0xc,%esp
801066bc:	68 d1 8d 10 80       	push   $0x80108dd1
801066c1:	e8 38 9d ff ff       	call   801003fe <cprintf>
801066c6:	83 c4 10             	add    $0x10,%esp
801066c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066ce:	eb 44                	jmp    80106714 <sys_sbrk+0x99>
801066d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066d3:	85 c0                	test   %eax,%eax
801066d5:	79 24                	jns    801066fb <sys_sbrk+0x80>
801066d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801066da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066dd:	01 d0                	add    %edx,%eax
801066df:	89 c1                	mov    %eax,%ecx
801066e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801066e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066ea:	8b 40 04             	mov    0x4(%eax),%eax
801066ed:	83 ec 04             	sub    $0x4,%esp
801066f0:	51                   	push   %ecx
801066f1:	52                   	push   %edx
801066f2:	50                   	push   %eax
801066f3:	e8 b3 1e 00 00       	call   801085ab <deallocuvm>
801066f8:	83 c4 10             	add    $0x10,%esp
801066fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106701:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80106708:	8b 12                	mov    (%edx),%edx
8010670a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010670d:	01 ca                	add    %ecx,%edx
8010670f:	89 10                	mov    %edx,(%eax)
80106711:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106714:	c9                   	leave  
80106715:	c3                   	ret    

80106716 <sys_sleep>:
80106716:	55                   	push   %ebp
80106717:	89 e5                	mov    %esp,%ebp
80106719:	83 ec 18             	sub    $0x18,%esp
8010671c:	83 ec 08             	sub    $0x8,%esp
8010671f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106722:	50                   	push   %eax
80106723:	6a 00                	push   $0x0
80106725:	e8 47 ef ff ff       	call   80105671 <argint>
8010672a:	83 c4 10             	add    $0x10,%esp
8010672d:	85 c0                	test   %eax,%eax
8010672f:	79 07                	jns    80106738 <sys_sleep+0x22>
80106731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106736:	eb 77                	jmp    801067af <sys_sleep+0x99>
80106738:	83 ec 0c             	sub    $0xc,%esp
8010673b:	68 60 6e 11 80       	push   $0x80116e60
80106740:	e8 8d e9 ff ff       	call   801050d2 <acquire>
80106745:	83 c4 10             	add    $0x10,%esp
80106748:	a1 a0 76 11 80       	mov    0x801176a0,%eax
8010674d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106750:	eb 39                	jmp    8010678b <sys_sleep+0x75>
80106752:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106758:	8b 40 28             	mov    0x28(%eax),%eax
8010675b:	85 c0                	test   %eax,%eax
8010675d:	74 17                	je     80106776 <sys_sleep+0x60>
8010675f:	83 ec 0c             	sub    $0xc,%esp
80106762:	68 60 6e 11 80       	push   $0x80116e60
80106767:	e8 d2 e9 ff ff       	call   8010513e <release>
8010676c:	83 c4 10             	add    $0x10,%esp
8010676f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106774:	eb 39                	jmp    801067af <sys_sleep+0x99>
80106776:	83 ec 08             	sub    $0x8,%esp
80106779:	68 60 6e 11 80       	push   $0x80116e60
8010677e:	68 a0 76 11 80       	push   $0x801176a0
80106783:	e8 2b e5 ff ff       	call   80104cb3 <sleep>
80106788:	83 c4 10             	add    $0x10,%esp
8010678b:	a1 a0 76 11 80       	mov    0x801176a0,%eax
80106790:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106793:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106796:	39 d0                	cmp    %edx,%eax
80106798:	72 b8                	jb     80106752 <sys_sleep+0x3c>
8010679a:	83 ec 0c             	sub    $0xc,%esp
8010679d:	68 60 6e 11 80       	push   $0x80116e60
801067a2:	e8 97 e9 ff ff       	call   8010513e <release>
801067a7:	83 c4 10             	add    $0x10,%esp
801067aa:	b8 00 00 00 00       	mov    $0x0,%eax
801067af:	c9                   	leave  
801067b0:	c3                   	ret    

801067b1 <sys_uptime>:
801067b1:	55                   	push   %ebp
801067b2:	89 e5                	mov    %esp,%ebp
801067b4:	83 ec 18             	sub    $0x18,%esp
801067b7:	83 ec 0c             	sub    $0xc,%esp
801067ba:	68 60 6e 11 80       	push   $0x80116e60
801067bf:	e8 0e e9 ff ff       	call   801050d2 <acquire>
801067c4:	83 c4 10             	add    $0x10,%esp
801067c7:	a1 a0 76 11 80       	mov    0x801176a0,%eax
801067cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801067cf:	83 ec 0c             	sub    $0xc,%esp
801067d2:	68 60 6e 11 80       	push   $0x80116e60
801067d7:	e8 62 e9 ff ff       	call   8010513e <release>
801067dc:	83 c4 10             	add    $0x10,%esp
801067df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067e2:	c9                   	leave  
801067e3:	c3                   	ret    

801067e4 <sys_date>:
801067e4:	55                   	push   %ebp
801067e5:	89 e5                	mov    %esp,%ebp
801067e7:	83 ec 18             	sub    $0x18,%esp
801067ea:	83 ec 04             	sub    $0x4,%esp
801067ed:	6a 04                	push   $0x4
801067ef:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067f2:	50                   	push   %eax
801067f3:	6a 00                	push   $0x0
801067f5:	e8 a5 ee ff ff       	call   8010569f <argptr>
801067fa:	83 c4 10             	add    $0x10,%esp
801067fd:	85 c0                	test   %eax,%eax
801067ff:	79 07                	jns    80106808 <sys_date+0x24>
80106801:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106806:	eb 14                	jmp    8010681c <sys_date+0x38>
80106808:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010680b:	83 ec 0c             	sub    $0xc,%esp
8010680e:	50                   	push   %eax
8010680f:	e8 43 ca ff ff       	call   80103257 <cmostime>
80106814:	83 c4 10             	add    $0x10,%esp
80106817:	b8 00 00 00 00       	mov    $0x0,%eax
8010681c:	c9                   	leave  
8010681d:	c3                   	ret    

8010681e <outb>:
8010681e:	55                   	push   %ebp
8010681f:	89 e5                	mov    %esp,%ebp
80106821:	83 ec 08             	sub    $0x8,%esp
80106824:	8b 55 08             	mov    0x8(%ebp),%edx
80106827:	8b 45 0c             	mov    0xc(%ebp),%eax
8010682a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010682e:	88 45 f8             	mov    %al,-0x8(%ebp)
80106831:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106835:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106839:	ee                   	out    %al,(%dx)
8010683a:	90                   	nop
8010683b:	c9                   	leave  
8010683c:	c3                   	ret    

8010683d <timerinit>:
8010683d:	55                   	push   %ebp
8010683e:	89 e5                	mov    %esp,%ebp
80106840:	83 ec 08             	sub    $0x8,%esp
80106843:	6a 34                	push   $0x34
80106845:	6a 43                	push   $0x43
80106847:	e8 d2 ff ff ff       	call   8010681e <outb>
8010684c:	83 c4 08             	add    $0x8,%esp
8010684f:	68 9c 00 00 00       	push   $0x9c
80106854:	6a 40                	push   $0x40
80106856:	e8 c3 ff ff ff       	call   8010681e <outb>
8010685b:	83 c4 08             	add    $0x8,%esp
8010685e:	6a 2e                	push   $0x2e
80106860:	6a 40                	push   $0x40
80106862:	e8 b7 ff ff ff       	call   8010681e <outb>
80106867:	83 c4 08             	add    $0x8,%esp
8010686a:	83 ec 0c             	sub    $0xc,%esp
8010686d:	6a 00                	push   $0x0
8010686f:	e8 47 d6 ff ff       	call   80103ebb <picenable>
80106874:	83 c4 10             	add    $0x10,%esp
80106877:	90                   	nop
80106878:	c9                   	leave  
80106879:	c3                   	ret    

8010687a <alltraps>:
8010687a:	1e                   	push   %ds
8010687b:	06                   	push   %es
8010687c:	0f a0                	push   %fs
8010687e:	0f a8                	push   %gs
80106880:	60                   	pusha  
80106881:	66 b8 10 00          	mov    $0x10,%ax
80106885:	8e d8                	mov    %eax,%ds
80106887:	8e c0                	mov    %eax,%es
80106889:	66 b8 18 00          	mov    $0x18,%ax
8010688d:	8e e0                	mov    %eax,%fs
8010688f:	8e e8                	mov    %eax,%gs
80106891:	54                   	push   %esp
80106892:	e8 d7 01 00 00       	call   80106a6e <trap>
80106897:	83 c4 04             	add    $0x4,%esp

8010689a <trapret>:
8010689a:	61                   	popa   
8010689b:	0f a9                	pop    %gs
8010689d:	0f a1                	pop    %fs
8010689f:	07                   	pop    %es
801068a0:	1f                   	pop    %ds
801068a1:	83 c4 08             	add    $0x8,%esp
801068a4:	cf                   	iret   

801068a5 <lidt>:
801068a5:	55                   	push   %ebp
801068a6:	89 e5                	mov    %esp,%ebp
801068a8:	83 ec 10             	sub    $0x10,%esp
801068ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801068ae:	83 e8 01             	sub    $0x1,%eax
801068b1:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
801068b5:	8b 45 08             	mov    0x8(%ebp),%eax
801068b8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801068bc:	8b 45 08             	mov    0x8(%ebp),%eax
801068bf:	c1 e8 10             	shr    $0x10,%eax
801068c2:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
801068c6:	8d 45 fa             	lea    -0x6(%ebp),%eax
801068c9:	0f 01 18             	lidtl  (%eax)
801068cc:	90                   	nop
801068cd:	c9                   	leave  
801068ce:	c3                   	ret    

801068cf <rcr2>:
801068cf:	55                   	push   %ebp
801068d0:	89 e5                	mov    %esp,%ebp
801068d2:	83 ec 10             	sub    $0x10,%esp
801068d5:	0f 20 d0             	mov    %cr2,%eax
801068d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801068db:	8b 45 fc             	mov    -0x4(%ebp),%eax
801068de:	c9                   	leave  
801068df:	c3                   	ret    

801068e0 <tvinit>:
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	83 ec 18             	sub    $0x18,%esp
801068e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801068ed:	e9 c3 00 00 00       	jmp    801069b5 <tvinit+0xd5>
801068f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068f5:	8b 04 85 a0 c0 10 80 	mov    -0x7fef3f60(,%eax,4),%eax
801068fc:	89 c2                	mov    %eax,%edx
801068fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106901:	66 89 14 c5 a0 6e 11 	mov    %dx,-0x7fee9160(,%eax,8)
80106908:	80 
80106909:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010690c:	66 c7 04 c5 a2 6e 11 	movw   $0x8,-0x7fee915e(,%eax,8)
80106913:	80 08 00 
80106916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106919:	0f b6 14 c5 a4 6e 11 	movzbl -0x7fee915c(,%eax,8),%edx
80106920:	80 
80106921:	83 e2 e0             	and    $0xffffffe0,%edx
80106924:	88 14 c5 a4 6e 11 80 	mov    %dl,-0x7fee915c(,%eax,8)
8010692b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010692e:	0f b6 14 c5 a4 6e 11 	movzbl -0x7fee915c(,%eax,8),%edx
80106935:	80 
80106936:	83 e2 1f             	and    $0x1f,%edx
80106939:	88 14 c5 a4 6e 11 80 	mov    %dl,-0x7fee915c(,%eax,8)
80106940:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106943:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
8010694a:	80 
8010694b:	83 e2 f0             	and    $0xfffffff0,%edx
8010694e:	83 ca 0e             	or     $0xe,%edx
80106951:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
80106958:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010695b:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
80106962:	80 
80106963:	83 e2 ef             	and    $0xffffffef,%edx
80106966:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
8010696d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106970:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
80106977:	80 
80106978:	83 e2 9f             	and    $0xffffff9f,%edx
8010697b:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
80106982:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106985:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
8010698c:	80 
8010698d:	83 ca 80             	or     $0xffffff80,%edx
80106990:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
80106997:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010699a:	8b 04 85 a0 c0 10 80 	mov    -0x7fef3f60(,%eax,4),%eax
801069a1:	c1 e8 10             	shr    $0x10,%eax
801069a4:	89 c2                	mov    %eax,%edx
801069a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069a9:	66 89 14 c5 a6 6e 11 	mov    %dx,-0x7fee915a(,%eax,8)
801069b0:	80 
801069b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069b5:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801069bc:	0f 8e 30 ff ff ff    	jle    801068f2 <tvinit+0x12>
801069c2:	a1 a0 c1 10 80       	mov    0x8010c1a0,%eax
801069c7:	66 a3 a0 70 11 80    	mov    %ax,0x801170a0
801069cd:	66 c7 05 a2 70 11 80 	movw   $0x8,0x801170a2
801069d4:	08 00 
801069d6:	0f b6 05 a4 70 11 80 	movzbl 0x801170a4,%eax
801069dd:	83 e0 e0             	and    $0xffffffe0,%eax
801069e0:	a2 a4 70 11 80       	mov    %al,0x801170a4
801069e5:	0f b6 05 a4 70 11 80 	movzbl 0x801170a4,%eax
801069ec:	83 e0 1f             	and    $0x1f,%eax
801069ef:	a2 a4 70 11 80       	mov    %al,0x801170a4
801069f4:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
801069fb:	83 c8 0f             	or     $0xf,%eax
801069fe:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a03:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
80106a0a:	83 e0 ef             	and    $0xffffffef,%eax
80106a0d:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a12:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
80106a19:	83 c8 60             	or     $0x60,%eax
80106a1c:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a21:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
80106a28:	83 c8 80             	or     $0xffffff80,%eax
80106a2b:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a30:	a1 a0 c1 10 80       	mov    0x8010c1a0,%eax
80106a35:	c1 e8 10             	shr    $0x10,%eax
80106a38:	66 a3 a6 70 11 80    	mov    %ax,0x801170a6
80106a3e:	83 ec 08             	sub    $0x8,%esp
80106a41:	68 e8 8d 10 80       	push   $0x80108de8
80106a46:	68 60 6e 11 80       	push   $0x80116e60
80106a4b:	e8 60 e6 ff ff       	call   801050b0 <initlock>
80106a50:	83 c4 10             	add    $0x10,%esp
80106a53:	90                   	nop
80106a54:	c9                   	leave  
80106a55:	c3                   	ret    

80106a56 <idtinit>:
80106a56:	55                   	push   %ebp
80106a57:	89 e5                	mov    %esp,%ebp
80106a59:	68 00 08 00 00       	push   $0x800
80106a5e:	68 a0 6e 11 80       	push   $0x80116ea0
80106a63:	e8 3d fe ff ff       	call   801068a5 <lidt>
80106a68:	83 c4 08             	add    $0x8,%esp
80106a6b:	90                   	nop
80106a6c:	c9                   	leave  
80106a6d:	c3                   	ret    

80106a6e <trap>:
80106a6e:	55                   	push   %ebp
80106a6f:	89 e5                	mov    %esp,%ebp
80106a71:	57                   	push   %edi
80106a72:	56                   	push   %esi
80106a73:	53                   	push   %ebx
80106a74:	83 ec 2c             	sub    $0x2c,%esp
80106a77:	8b 45 08             	mov    0x8(%ebp),%eax
80106a7a:	8b 40 30             	mov    0x30(%eax),%eax
80106a7d:	83 f8 40             	cmp    $0x40,%eax
80106a80:	75 3e                	jne    80106ac0 <trap+0x52>
80106a82:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a88:	8b 40 28             	mov    0x28(%eax),%eax
80106a8b:	85 c0                	test   %eax,%eax
80106a8d:	74 05                	je     80106a94 <trap+0x26>
80106a8f:	e8 e4 dd ff ff       	call   80104878 <exit>
80106a94:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a9a:	8b 55 08             	mov    0x8(%ebp),%edx
80106a9d:	89 50 1c             	mov    %edx,0x1c(%eax)
80106aa0:	e8 93 ec ff ff       	call   80105738 <syscall>
80106aa5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aab:	8b 40 28             	mov    0x28(%eax),%eax
80106aae:	85 c0                	test   %eax,%eax
80106ab0:	0f 84 15 04 00 00    	je     80106ecb <trap+0x45d>
80106ab6:	e8 bd dd ff ff       	call   80104878 <exit>
80106abb:	e9 0b 04 00 00       	jmp    80106ecb <trap+0x45d>
80106ac0:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac3:	8b 40 30             	mov    0x30(%eax),%eax
80106ac6:	83 e8 0e             	sub    $0xe,%eax
80106ac9:	83 f8 31             	cmp    $0x31,%eax
80106acc:	0f 87 c4 02 00 00    	ja     80106d96 <trap+0x328>
80106ad2:	8b 04 85 a8 8f 10 80 	mov    -0x7fef7058(,%eax,4),%eax
80106ad9:	ff e0                	jmp    *%eax
80106adb:	e8 0b c5 ff ff       	call   80102feb <cpunum>
80106ae0:	85 c0                	test   %eax,%eax
80106ae2:	75 3d                	jne    80106b21 <trap+0xb3>
80106ae4:	83 ec 0c             	sub    $0xc,%esp
80106ae7:	68 60 6e 11 80       	push   $0x80116e60
80106aec:	e8 e1 e5 ff ff       	call   801050d2 <acquire>
80106af1:	83 c4 10             	add    $0x10,%esp
80106af4:	a1 a0 76 11 80       	mov    0x801176a0,%eax
80106af9:	83 c0 01             	add    $0x1,%eax
80106afc:	a3 a0 76 11 80       	mov    %eax,0x801176a0
80106b01:	83 ec 0c             	sub    $0xc,%esp
80106b04:	68 a0 76 11 80       	push   $0x801176a0
80106b09:	e8 90 e2 ff ff       	call   80104d9e <wakeup>
80106b0e:	83 c4 10             	add    $0x10,%esp
80106b11:	83 ec 0c             	sub    $0xc,%esp
80106b14:	68 60 6e 11 80       	push   $0x80116e60
80106b19:	e8 20 e6 ff ff       	call   8010513e <release>
80106b1e:	83 c4 10             	add    $0x10,%esp
80106b21:	e8 61 c5 ff ff       	call   80103087 <lapiceoi>
80106b26:	e9 1a 03 00 00       	jmp    80106e45 <trap+0x3d7>
80106b2b:	e8 17 bd ff ff       	call   80102847 <ideintr>
80106b30:	e8 52 c5 ff ff       	call   80103087 <lapiceoi>
80106b35:	e9 0b 03 00 00       	jmp    80106e45 <trap+0x3d7>
80106b3a:	e8 ce c2 ff ff       	call   80102e0d <kbdintr>
80106b3f:	e8 43 c5 ff ff       	call   80103087 <lapiceoi>
80106b44:	e9 fc 02 00 00       	jmp    80106e45 <trap+0x3d7>
80106b49:	e8 5e 05 00 00       	call   801070ac <uartintr>
80106b4e:	e8 34 c5 ff ff       	call   80103087 <lapiceoi>
80106b53:	e9 ed 02 00 00       	jmp    80106e45 <trap+0x3d7>
80106b58:	8b 45 08             	mov    0x8(%ebp),%eax
80106b5b:	8b 70 38             	mov    0x38(%eax),%esi
80106b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b61:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b65:	0f b7 d8             	movzwl %ax,%ebx
80106b68:	e8 7e c4 ff ff       	call   80102feb <cpunum>
80106b6d:	56                   	push   %esi
80106b6e:	53                   	push   %ebx
80106b6f:	50                   	push   %eax
80106b70:	68 f0 8d 10 80       	push   $0x80108df0
80106b75:	e8 84 98 ff ff       	call   801003fe <cprintf>
80106b7a:	83 c4 10             	add    $0x10,%esp
80106b7d:	e8 05 c5 ff ff       	call   80103087 <lapiceoi>
80106b82:	e9 be 02 00 00       	jmp    80106e45 <trap+0x3d7>
80106b87:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b8d:	85 c0                	test   %eax,%eax
80106b8f:	74 1d                	je     80106bae <trap+0x140>
80106b91:	8b 45 08             	mov    0x8(%ebp),%eax
80106b94:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b98:	0f b7 c0             	movzwl %ax,%eax
80106b9b:	83 e0 03             	and    $0x3,%eax
80106b9e:	85 c0                	test   %eax,%eax
80106ba0:	75 47                	jne    80106be9 <trap+0x17b>
80106ba2:	e8 28 fd ff ff       	call   801068cf <rcr2>
80106ba7:	3d 00 00 00 80       	cmp    $0x80000000,%eax
80106bac:	76 3b                	jbe    80106be9 <trap+0x17b>
80106bae:	e8 1c fd ff ff       	call   801068cf <rcr2>
80106bb3:	89 c6                	mov    %eax,%esi
80106bb5:	8b 45 08             	mov    0x8(%ebp),%eax
80106bb8:	8b 58 38             	mov    0x38(%eax),%ebx
80106bbb:	e8 2b c4 ff ff       	call   80102feb <cpunum>
80106bc0:	89 c2                	mov    %eax,%edx
80106bc2:	8b 45 08             	mov    0x8(%ebp),%eax
80106bc5:	8b 40 30             	mov    0x30(%eax),%eax
80106bc8:	83 ec 0c             	sub    $0xc,%esp
80106bcb:	56                   	push   %esi
80106bcc:	53                   	push   %ebx
80106bcd:	52                   	push   %edx
80106bce:	50                   	push   %eax
80106bcf:	68 14 8e 10 80       	push   $0x80108e14
80106bd4:	e8 25 98 ff ff       	call   801003fe <cprintf>
80106bd9:	83 c4 20             	add    $0x20,%esp
80106bdc:	83 ec 0c             	sub    $0xc,%esp
80106bdf:	68 49 8e 10 80       	push   $0x80108e49
80106be4:	e8 af 99 ff ff       	call   80100598 <panic>
80106be9:	e8 5e c0 ff ff       	call   80102c4c <kalloc>
80106bee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bf1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80106bf5:	75 22                	jne    80106c19 <trap+0x1ab>
80106bf7:	83 ec 0c             	sub    $0xc,%esp
80106bfa:	68 62 8e 10 80       	push   $0x80108e62
80106bff:	e8 fa 97 ff ff       	call   801003fe <cprintf>
80106c04:	83 c4 10             	add    $0x10,%esp
80106c07:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c0d:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80106c14:	e9 2c 02 00 00       	jmp    80106e45 <trap+0x3d7>
80106c19:	e8 b1 fc ff ff       	call   801068cf <rcr2>
80106c1e:	89 c2                	mov    %eax,%edx
80106c20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c26:	8b 00                	mov    (%eax),%eax
80106c28:	39 c2                	cmp    %eax,%edx
80106c2a:	76 43                	jbe    80106c6f <trap+0x201>
80106c2c:	e8 9e fc ff ff       	call   801068cf <rcr2>
80106c31:	89 c2                	mov    %eax,%edx
80106c33:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c39:	8b 00                	mov    (%eax),%eax
80106c3b:	83 ec 04             	sub    $0x4,%esp
80106c3e:	52                   	push   %edx
80106c3f:	50                   	push   %eax
80106c40:	68 7a 8e 10 80       	push   $0x80108e7a
80106c45:	e8 b4 97 ff ff       	call   801003fe <cprintf>
80106c4a:	83 c4 10             	add    $0x10,%esp
80106c4d:	83 ec 0c             	sub    $0xc,%esp
80106c50:	68 88 8e 10 80       	push   $0x80108e88
80106c55:	e8 a4 97 ff ff       	call   801003fe <cprintf>
80106c5a:	83 c4 10             	add    $0x10,%esp
80106c5d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c63:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80106c6a:	e9 d6 01 00 00       	jmp    80106e45 <trap+0x3d7>
80106c6f:	e8 5b fc ff ff       	call   801068cf <rcr2>
80106c74:	89 c2                	mov    %eax,%edx
80106c76:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c7c:	8b 40 0c             	mov    0xc(%eax),%eax
80106c7f:	39 c2                	cmp    %eax,%edx
80106c81:	76 3b                	jbe    80106cbe <trap+0x250>
80106c83:	e8 47 fc ff ff       	call   801068cf <rcr2>
80106c88:	89 c2                	mov    %eax,%edx
80106c8a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c90:	8b 40 0c             	mov    0xc(%eax),%eax
80106c93:	05 00 10 00 00       	add    $0x1000,%eax
80106c98:	39 c2                	cmp    %eax,%edx
80106c9a:	73 22                	jae    80106cbe <trap+0x250>
80106c9c:	83 ec 0c             	sub    $0xc,%esp
80106c9f:	68 a4 8e 10 80       	push   $0x80108ea4
80106ca4:	e8 55 97 ff ff       	call   801003fe <cprintf>
80106ca9:	83 c4 10             	add    $0x10,%esp
80106cac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cb2:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80106cb9:	e9 87 01 00 00       	jmp    80106e45 <trap+0x3d7>
80106cbe:	83 ec 04             	sub    $0x4,%esp
80106cc1:	68 00 10 00 00       	push   $0x1000
80106cc6:	6a 00                	push   $0x0
80106cc8:	ff 75 e4             	pushl  -0x1c(%ebp)
80106ccb:	e8 7c e6 ff ff       	call   8010534c <memset>
80106cd0:	83 c4 10             	add    $0x10,%esp
80106cd3:	e8 f7 fb ff ff       	call   801068cf <rcr2>
80106cd8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cdd:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ce0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ce3:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80106ce9:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106cec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cf2:	8b 40 04             	mov    0x4(%eax),%eax
80106cf5:	83 ec 0c             	sub    $0xc,%esp
80106cf8:	6a 06                	push   $0x6
80106cfa:	51                   	push   %ecx
80106cfb:	68 00 10 00 00       	push   $0x1000
80106d00:	52                   	push   %edx
80106d01:	50                   	push   %eax
80106d02:	e8 9e 13 00 00       	call   801080a5 <mappages>
80106d07:	83 c4 20             	add    $0x20,%esp
80106d0a:	85 c0                	test   %eax,%eax
80106d0c:	79 4f                	jns    80106d5d <trap+0x2ef>
80106d0e:	e8 bc fb ff ff       	call   801068cf <rcr2>
80106d13:	89 c3                	mov    %eax,%ebx
80106d15:	e8 d1 c2 ff ff       	call   80102feb <cpunum>
80106d1a:	89 c1                	mov    %eax,%ecx
80106d1c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d22:	8d 50 70             	lea    0x70(%eax),%edx
80106d25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d2b:	8b 40 14             	mov    0x14(%eax),%eax
80106d2e:	83 ec 0c             	sub    $0xc,%esp
80106d31:	53                   	push   %ebx
80106d32:	51                   	push   %ecx
80106d33:	52                   	push   %edx
80106d34:	50                   	push   %eax
80106d35:	68 b4 8e 10 80       	push   $0x80108eb4
80106d3a:	e8 bf 96 ff ff       	call   801003fe <cprintf>
80106d3f:	83 c4 20             	add    $0x20,%esp
80106d42:	83 ec 0c             	sub    $0xc,%esp
80106d45:	ff 75 e4             	pushl  -0x1c(%ebp)
80106d48:	e8 65 be ff ff       	call   80102bb2 <kfree>
80106d4d:	83 c4 10             	add    $0x10,%esp
80106d50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d56:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80106d5d:	e8 6d fb ff ff       	call   801068cf <rcr2>
80106d62:	89 c3                	mov    %eax,%ebx
80106d64:	e8 82 c2 ff ff       	call   80102feb <cpunum>
80106d69:	89 c1                	mov    %eax,%ecx
80106d6b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d71:	8d 50 70             	lea    0x70(%eax),%edx
80106d74:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d7a:	8b 40 14             	mov    0x14(%eax),%eax
80106d7d:	83 ec 0c             	sub    $0xc,%esp
80106d80:	53                   	push   %ebx
80106d81:	51                   	push   %ecx
80106d82:	52                   	push   %edx
80106d83:	50                   	push   %eax
80106d84:	68 f0 8e 10 80       	push   $0x80108ef0
80106d89:	e8 70 96 ff ff       	call   801003fe <cprintf>
80106d8e:	83 c4 20             	add    $0x20,%esp
80106d91:	e9 af 00 00 00       	jmp    80106e45 <trap+0x3d7>
80106d96:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d9c:	85 c0                	test   %eax,%eax
80106d9e:	74 11                	je     80106db1 <trap+0x343>
80106da0:	8b 45 08             	mov    0x8(%ebp),%eax
80106da3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106da7:	0f b7 c0             	movzwl %ax,%eax
80106daa:	83 e0 03             	and    $0x3,%eax
80106dad:	85 c0                	test   %eax,%eax
80106daf:	75 3b                	jne    80106dec <trap+0x37e>
80106db1:	e8 19 fb ff ff       	call   801068cf <rcr2>
80106db6:	89 c6                	mov    %eax,%esi
80106db8:	8b 45 08             	mov    0x8(%ebp),%eax
80106dbb:	8b 58 38             	mov    0x38(%eax),%ebx
80106dbe:	e8 28 c2 ff ff       	call   80102feb <cpunum>
80106dc3:	89 c2                	mov    %eax,%edx
80106dc5:	8b 45 08             	mov    0x8(%ebp),%eax
80106dc8:	8b 40 30             	mov    0x30(%eax),%eax
80106dcb:	83 ec 0c             	sub    $0xc,%esp
80106dce:	56                   	push   %esi
80106dcf:	53                   	push   %ebx
80106dd0:	52                   	push   %edx
80106dd1:	50                   	push   %eax
80106dd2:	68 2c 8f 10 80       	push   $0x80108f2c
80106dd7:	e8 22 96 ff ff       	call   801003fe <cprintf>
80106ddc:	83 c4 20             	add    $0x20,%esp
80106ddf:	83 ec 0c             	sub    $0xc,%esp
80106de2:	68 5e 8f 10 80       	push   $0x80108f5e
80106de7:	e8 ac 97 ff ff       	call   80100598 <panic>
80106dec:	e8 de fa ff ff       	call   801068cf <rcr2>
80106df1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80106df4:	8b 45 08             	mov    0x8(%ebp),%eax
80106df7:	8b 58 38             	mov    0x38(%eax),%ebx
80106dfa:	e8 ec c1 ff ff       	call   80102feb <cpunum>
80106dff:	89 c7                	mov    %eax,%edi
80106e01:	8b 45 08             	mov    0x8(%ebp),%eax
80106e04:	8b 48 34             	mov    0x34(%eax),%ecx
80106e07:	8b 45 08             	mov    0x8(%ebp),%eax
80106e0a:	8b 50 30             	mov    0x30(%eax),%edx
80106e0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e13:	8d 70 70             	lea    0x70(%eax),%esi
80106e16:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e1c:	8b 40 14             	mov    0x14(%eax),%eax
80106e1f:	ff 75 d4             	pushl  -0x2c(%ebp)
80106e22:	53                   	push   %ebx
80106e23:	57                   	push   %edi
80106e24:	51                   	push   %ecx
80106e25:	52                   	push   %edx
80106e26:	56                   	push   %esi
80106e27:	50                   	push   %eax
80106e28:	68 64 8f 10 80       	push   $0x80108f64
80106e2d:	e8 cc 95 ff ff       	call   801003fe <cprintf>
80106e32:	83 c4 20             	add    $0x20,%esp
80106e35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e3b:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80106e42:	eb 01                	jmp    80106e45 <trap+0x3d7>
80106e44:	90                   	nop
80106e45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e4b:	85 c0                	test   %eax,%eax
80106e4d:	74 24                	je     80106e73 <trap+0x405>
80106e4f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e55:	8b 40 28             	mov    0x28(%eax),%eax
80106e58:	85 c0                	test   %eax,%eax
80106e5a:	74 17                	je     80106e73 <trap+0x405>
80106e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e5f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106e63:	0f b7 c0             	movzwl %ax,%eax
80106e66:	83 e0 03             	and    $0x3,%eax
80106e69:	83 f8 03             	cmp    $0x3,%eax
80106e6c:	75 05                	jne    80106e73 <trap+0x405>
80106e6e:	e8 05 da ff ff       	call   80104878 <exit>
80106e73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e79:	85 c0                	test   %eax,%eax
80106e7b:	74 1e                	je     80106e9b <trap+0x42d>
80106e7d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e83:	8b 40 10             	mov    0x10(%eax),%eax
80106e86:	83 f8 04             	cmp    $0x4,%eax
80106e89:	75 10                	jne    80106e9b <trap+0x42d>
80106e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e8e:	8b 40 30             	mov    0x30(%eax),%eax
80106e91:	83 f8 20             	cmp    $0x20,%eax
80106e94:	75 05                	jne    80106e9b <trap+0x42d>
80106e96:	e8 97 dd ff ff       	call   80104c32 <yield>
80106e9b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ea1:	85 c0                	test   %eax,%eax
80106ea3:	74 27                	je     80106ecc <trap+0x45e>
80106ea5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106eab:	8b 40 28             	mov    0x28(%eax),%eax
80106eae:	85 c0                	test   %eax,%eax
80106eb0:	74 1a                	je     80106ecc <trap+0x45e>
80106eb2:	8b 45 08             	mov    0x8(%ebp),%eax
80106eb5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106eb9:	0f b7 c0             	movzwl %ax,%eax
80106ebc:	83 e0 03             	and    $0x3,%eax
80106ebf:	83 f8 03             	cmp    $0x3,%eax
80106ec2:	75 08                	jne    80106ecc <trap+0x45e>
80106ec4:	e8 af d9 ff ff       	call   80104878 <exit>
80106ec9:	eb 01                	jmp    80106ecc <trap+0x45e>
80106ecb:	90                   	nop
80106ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ecf:	5b                   	pop    %ebx
80106ed0:	5e                   	pop    %esi
80106ed1:	5f                   	pop    %edi
80106ed2:	5d                   	pop    %ebp
80106ed3:	c3                   	ret    

80106ed4 <inb>:
80106ed4:	55                   	push   %ebp
80106ed5:	89 e5                	mov    %esp,%ebp
80106ed7:	83 ec 14             	sub    $0x14,%esp
80106eda:	8b 45 08             	mov    0x8(%ebp),%eax
80106edd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80106ee1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106ee5:	89 c2                	mov    %eax,%edx
80106ee7:	ec                   	in     (%dx),%al
80106ee8:	88 45 ff             	mov    %al,-0x1(%ebp)
80106eeb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80106eef:	c9                   	leave  
80106ef0:	c3                   	ret    

80106ef1 <outb>:
80106ef1:	55                   	push   %ebp
80106ef2:	89 e5                	mov    %esp,%ebp
80106ef4:	83 ec 08             	sub    $0x8,%esp
80106ef7:	8b 55 08             	mov    0x8(%ebp),%edx
80106efa:	8b 45 0c             	mov    0xc(%ebp),%eax
80106efd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106f01:	88 45 f8             	mov    %al,-0x8(%ebp)
80106f04:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106f08:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106f0c:	ee                   	out    %al,(%dx)
80106f0d:	90                   	nop
80106f0e:	c9                   	leave  
80106f0f:	c3                   	ret    

80106f10 <uartinit>:
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	83 ec 18             	sub    $0x18,%esp
80106f16:	6a 00                	push   $0x0
80106f18:	68 fa 03 00 00       	push   $0x3fa
80106f1d:	e8 cf ff ff ff       	call   80106ef1 <outb>
80106f22:	83 c4 08             	add    $0x8,%esp
80106f25:	68 80 00 00 00       	push   $0x80
80106f2a:	68 fb 03 00 00       	push   $0x3fb
80106f2f:	e8 bd ff ff ff       	call   80106ef1 <outb>
80106f34:	83 c4 08             	add    $0x8,%esp
80106f37:	6a 0c                	push   $0xc
80106f39:	68 f8 03 00 00       	push   $0x3f8
80106f3e:	e8 ae ff ff ff       	call   80106ef1 <outb>
80106f43:	83 c4 08             	add    $0x8,%esp
80106f46:	6a 00                	push   $0x0
80106f48:	68 f9 03 00 00       	push   $0x3f9
80106f4d:	e8 9f ff ff ff       	call   80106ef1 <outb>
80106f52:	83 c4 08             	add    $0x8,%esp
80106f55:	6a 03                	push   $0x3
80106f57:	68 fb 03 00 00       	push   $0x3fb
80106f5c:	e8 90 ff ff ff       	call   80106ef1 <outb>
80106f61:	83 c4 08             	add    $0x8,%esp
80106f64:	6a 00                	push   $0x0
80106f66:	68 fc 03 00 00       	push   $0x3fc
80106f6b:	e8 81 ff ff ff       	call   80106ef1 <outb>
80106f70:	83 c4 08             	add    $0x8,%esp
80106f73:	6a 01                	push   $0x1
80106f75:	68 f9 03 00 00       	push   $0x3f9
80106f7a:	e8 72 ff ff ff       	call   80106ef1 <outb>
80106f7f:	83 c4 08             	add    $0x8,%esp
80106f82:	68 fd 03 00 00       	push   $0x3fd
80106f87:	e8 48 ff ff ff       	call   80106ed4 <inb>
80106f8c:	83 c4 04             	add    $0x4,%esp
80106f8f:	3c ff                	cmp    $0xff,%al
80106f91:	74 6e                	je     80107001 <uartinit+0xf1>
80106f93:	c7 05 48 c6 10 80 01 	movl   $0x1,0x8010c648
80106f9a:	00 00 00 
80106f9d:	68 fa 03 00 00       	push   $0x3fa
80106fa2:	e8 2d ff ff ff       	call   80106ed4 <inb>
80106fa7:	83 c4 04             	add    $0x4,%esp
80106faa:	68 f8 03 00 00       	push   $0x3f8
80106faf:	e8 20 ff ff ff       	call   80106ed4 <inb>
80106fb4:	83 c4 04             	add    $0x4,%esp
80106fb7:	83 ec 0c             	sub    $0xc,%esp
80106fba:	6a 04                	push   $0x4
80106fbc:	e8 fa ce ff ff       	call   80103ebb <picenable>
80106fc1:	83 c4 10             	add    $0x10,%esp
80106fc4:	83 ec 08             	sub    $0x8,%esp
80106fc7:	6a 00                	push   $0x0
80106fc9:	6a 04                	push   $0x4
80106fcb:	e8 00 bb ff ff       	call   80102ad0 <ioapicenable>
80106fd0:	83 c4 10             	add    $0x10,%esp
80106fd3:	c7 45 f4 70 90 10 80 	movl   $0x80109070,-0xc(%ebp)
80106fda:	eb 19                	jmp    80106ff5 <uartinit+0xe5>
80106fdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fdf:	0f b6 00             	movzbl (%eax),%eax
80106fe2:	0f be c0             	movsbl %al,%eax
80106fe5:	83 ec 0c             	sub    $0xc,%esp
80106fe8:	50                   	push   %eax
80106fe9:	e8 16 00 00 00       	call   80107004 <uartputc>
80106fee:	83 c4 10             	add    $0x10,%esp
80106ff1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106ff5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ff8:	0f b6 00             	movzbl (%eax),%eax
80106ffb:	84 c0                	test   %al,%al
80106ffd:	75 dd                	jne    80106fdc <uartinit+0xcc>
80106fff:	eb 01                	jmp    80107002 <uartinit+0xf2>
80107001:	90                   	nop
80107002:	c9                   	leave  
80107003:	c3                   	ret    

80107004 <uartputc>:
80107004:	55                   	push   %ebp
80107005:	89 e5                	mov    %esp,%ebp
80107007:	83 ec 18             	sub    $0x18,%esp
8010700a:	a1 48 c6 10 80       	mov    0x8010c648,%eax
8010700f:	85 c0                	test   %eax,%eax
80107011:	74 53                	je     80107066 <uartputc+0x62>
80107013:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010701a:	eb 11                	jmp    8010702d <uartputc+0x29>
8010701c:	83 ec 0c             	sub    $0xc,%esp
8010701f:	6a 0a                	push   $0xa
80107021:	e8 86 c0 ff ff       	call   801030ac <microdelay>
80107026:	83 c4 10             	add    $0x10,%esp
80107029:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010702d:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107031:	7f 1a                	jg     8010704d <uartputc+0x49>
80107033:	83 ec 0c             	sub    $0xc,%esp
80107036:	68 fd 03 00 00       	push   $0x3fd
8010703b:	e8 94 fe ff ff       	call   80106ed4 <inb>
80107040:	83 c4 10             	add    $0x10,%esp
80107043:	0f b6 c0             	movzbl %al,%eax
80107046:	83 e0 20             	and    $0x20,%eax
80107049:	85 c0                	test   %eax,%eax
8010704b:	74 cf                	je     8010701c <uartputc+0x18>
8010704d:	8b 45 08             	mov    0x8(%ebp),%eax
80107050:	0f b6 c0             	movzbl %al,%eax
80107053:	83 ec 08             	sub    $0x8,%esp
80107056:	50                   	push   %eax
80107057:	68 f8 03 00 00       	push   $0x3f8
8010705c:	e8 90 fe ff ff       	call   80106ef1 <outb>
80107061:	83 c4 10             	add    $0x10,%esp
80107064:	eb 01                	jmp    80107067 <uartputc+0x63>
80107066:	90                   	nop
80107067:	c9                   	leave  
80107068:	c3                   	ret    

80107069 <uartgetc>:
80107069:	55                   	push   %ebp
8010706a:	89 e5                	mov    %esp,%ebp
8010706c:	a1 48 c6 10 80       	mov    0x8010c648,%eax
80107071:	85 c0                	test   %eax,%eax
80107073:	75 07                	jne    8010707c <uartgetc+0x13>
80107075:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010707a:	eb 2e                	jmp    801070aa <uartgetc+0x41>
8010707c:	68 fd 03 00 00       	push   $0x3fd
80107081:	e8 4e fe ff ff       	call   80106ed4 <inb>
80107086:	83 c4 04             	add    $0x4,%esp
80107089:	0f b6 c0             	movzbl %al,%eax
8010708c:	83 e0 01             	and    $0x1,%eax
8010708f:	85 c0                	test   %eax,%eax
80107091:	75 07                	jne    8010709a <uartgetc+0x31>
80107093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107098:	eb 10                	jmp    801070aa <uartgetc+0x41>
8010709a:	68 f8 03 00 00       	push   $0x3f8
8010709f:	e8 30 fe ff ff       	call   80106ed4 <inb>
801070a4:	83 c4 04             	add    $0x4,%esp
801070a7:	0f b6 c0             	movzbl %al,%eax
801070aa:	c9                   	leave  
801070ab:	c3                   	ret    

801070ac <uartintr>:
801070ac:	55                   	push   %ebp
801070ad:	89 e5                	mov    %esp,%ebp
801070af:	83 ec 08             	sub    $0x8,%esp
801070b2:	83 ec 0c             	sub    $0xc,%esp
801070b5:	68 69 70 10 80       	push   $0x80107069
801070ba:	e8 67 97 ff ff       	call   80100826 <consoleintr>
801070bf:	83 c4 10             	add    $0x10,%esp
801070c2:	90                   	nop
801070c3:	c9                   	leave  
801070c4:	c3                   	ret    

801070c5 <vector0>:
801070c5:	6a 00                	push   $0x0
801070c7:	6a 00                	push   $0x0
801070c9:	e9 ac f7 ff ff       	jmp    8010687a <alltraps>

801070ce <vector1>:
801070ce:	6a 00                	push   $0x0
801070d0:	6a 01                	push   $0x1
801070d2:	e9 a3 f7 ff ff       	jmp    8010687a <alltraps>

801070d7 <vector2>:
801070d7:	6a 00                	push   $0x0
801070d9:	6a 02                	push   $0x2
801070db:	e9 9a f7 ff ff       	jmp    8010687a <alltraps>

801070e0 <vector3>:
801070e0:	6a 00                	push   $0x0
801070e2:	6a 03                	push   $0x3
801070e4:	e9 91 f7 ff ff       	jmp    8010687a <alltraps>

801070e9 <vector4>:
801070e9:	6a 00                	push   $0x0
801070eb:	6a 04                	push   $0x4
801070ed:	e9 88 f7 ff ff       	jmp    8010687a <alltraps>

801070f2 <vector5>:
801070f2:	6a 00                	push   $0x0
801070f4:	6a 05                	push   $0x5
801070f6:	e9 7f f7 ff ff       	jmp    8010687a <alltraps>

801070fb <vector6>:
801070fb:	6a 00                	push   $0x0
801070fd:	6a 06                	push   $0x6
801070ff:	e9 76 f7 ff ff       	jmp    8010687a <alltraps>

80107104 <vector7>:
80107104:	6a 00                	push   $0x0
80107106:	6a 07                	push   $0x7
80107108:	e9 6d f7 ff ff       	jmp    8010687a <alltraps>

8010710d <vector8>:
8010710d:	6a 08                	push   $0x8
8010710f:	e9 66 f7 ff ff       	jmp    8010687a <alltraps>

80107114 <vector9>:
80107114:	6a 00                	push   $0x0
80107116:	6a 09                	push   $0x9
80107118:	e9 5d f7 ff ff       	jmp    8010687a <alltraps>

8010711d <vector10>:
8010711d:	6a 0a                	push   $0xa
8010711f:	e9 56 f7 ff ff       	jmp    8010687a <alltraps>

80107124 <vector11>:
80107124:	6a 0b                	push   $0xb
80107126:	e9 4f f7 ff ff       	jmp    8010687a <alltraps>

8010712b <vector12>:
8010712b:	6a 0c                	push   $0xc
8010712d:	e9 48 f7 ff ff       	jmp    8010687a <alltraps>

80107132 <vector13>:
80107132:	6a 0d                	push   $0xd
80107134:	e9 41 f7 ff ff       	jmp    8010687a <alltraps>

80107139 <vector14>:
80107139:	6a 0e                	push   $0xe
8010713b:	e9 3a f7 ff ff       	jmp    8010687a <alltraps>

80107140 <vector15>:
80107140:	6a 00                	push   $0x0
80107142:	6a 0f                	push   $0xf
80107144:	e9 31 f7 ff ff       	jmp    8010687a <alltraps>

80107149 <vector16>:
80107149:	6a 00                	push   $0x0
8010714b:	6a 10                	push   $0x10
8010714d:	e9 28 f7 ff ff       	jmp    8010687a <alltraps>

80107152 <vector17>:
80107152:	6a 11                	push   $0x11
80107154:	e9 21 f7 ff ff       	jmp    8010687a <alltraps>

80107159 <vector18>:
80107159:	6a 00                	push   $0x0
8010715b:	6a 12                	push   $0x12
8010715d:	e9 18 f7 ff ff       	jmp    8010687a <alltraps>

80107162 <vector19>:
80107162:	6a 00                	push   $0x0
80107164:	6a 13                	push   $0x13
80107166:	e9 0f f7 ff ff       	jmp    8010687a <alltraps>

8010716b <vector20>:
8010716b:	6a 00                	push   $0x0
8010716d:	6a 14                	push   $0x14
8010716f:	e9 06 f7 ff ff       	jmp    8010687a <alltraps>

80107174 <vector21>:
80107174:	6a 00                	push   $0x0
80107176:	6a 15                	push   $0x15
80107178:	e9 fd f6 ff ff       	jmp    8010687a <alltraps>

8010717d <vector22>:
8010717d:	6a 00                	push   $0x0
8010717f:	6a 16                	push   $0x16
80107181:	e9 f4 f6 ff ff       	jmp    8010687a <alltraps>

80107186 <vector23>:
80107186:	6a 00                	push   $0x0
80107188:	6a 17                	push   $0x17
8010718a:	e9 eb f6 ff ff       	jmp    8010687a <alltraps>

8010718f <vector24>:
8010718f:	6a 00                	push   $0x0
80107191:	6a 18                	push   $0x18
80107193:	e9 e2 f6 ff ff       	jmp    8010687a <alltraps>

80107198 <vector25>:
80107198:	6a 00                	push   $0x0
8010719a:	6a 19                	push   $0x19
8010719c:	e9 d9 f6 ff ff       	jmp    8010687a <alltraps>

801071a1 <vector26>:
801071a1:	6a 00                	push   $0x0
801071a3:	6a 1a                	push   $0x1a
801071a5:	e9 d0 f6 ff ff       	jmp    8010687a <alltraps>

801071aa <vector27>:
801071aa:	6a 00                	push   $0x0
801071ac:	6a 1b                	push   $0x1b
801071ae:	e9 c7 f6 ff ff       	jmp    8010687a <alltraps>

801071b3 <vector28>:
801071b3:	6a 00                	push   $0x0
801071b5:	6a 1c                	push   $0x1c
801071b7:	e9 be f6 ff ff       	jmp    8010687a <alltraps>

801071bc <vector29>:
801071bc:	6a 00                	push   $0x0
801071be:	6a 1d                	push   $0x1d
801071c0:	e9 b5 f6 ff ff       	jmp    8010687a <alltraps>

801071c5 <vector30>:
801071c5:	6a 00                	push   $0x0
801071c7:	6a 1e                	push   $0x1e
801071c9:	e9 ac f6 ff ff       	jmp    8010687a <alltraps>

801071ce <vector31>:
801071ce:	6a 00                	push   $0x0
801071d0:	6a 1f                	push   $0x1f
801071d2:	e9 a3 f6 ff ff       	jmp    8010687a <alltraps>

801071d7 <vector32>:
801071d7:	6a 00                	push   $0x0
801071d9:	6a 20                	push   $0x20
801071db:	e9 9a f6 ff ff       	jmp    8010687a <alltraps>

801071e0 <vector33>:
801071e0:	6a 00                	push   $0x0
801071e2:	6a 21                	push   $0x21
801071e4:	e9 91 f6 ff ff       	jmp    8010687a <alltraps>

801071e9 <vector34>:
801071e9:	6a 00                	push   $0x0
801071eb:	6a 22                	push   $0x22
801071ed:	e9 88 f6 ff ff       	jmp    8010687a <alltraps>

801071f2 <vector35>:
801071f2:	6a 00                	push   $0x0
801071f4:	6a 23                	push   $0x23
801071f6:	e9 7f f6 ff ff       	jmp    8010687a <alltraps>

801071fb <vector36>:
801071fb:	6a 00                	push   $0x0
801071fd:	6a 24                	push   $0x24
801071ff:	e9 76 f6 ff ff       	jmp    8010687a <alltraps>

80107204 <vector37>:
80107204:	6a 00                	push   $0x0
80107206:	6a 25                	push   $0x25
80107208:	e9 6d f6 ff ff       	jmp    8010687a <alltraps>

8010720d <vector38>:
8010720d:	6a 00                	push   $0x0
8010720f:	6a 26                	push   $0x26
80107211:	e9 64 f6 ff ff       	jmp    8010687a <alltraps>

80107216 <vector39>:
80107216:	6a 00                	push   $0x0
80107218:	6a 27                	push   $0x27
8010721a:	e9 5b f6 ff ff       	jmp    8010687a <alltraps>

8010721f <vector40>:
8010721f:	6a 00                	push   $0x0
80107221:	6a 28                	push   $0x28
80107223:	e9 52 f6 ff ff       	jmp    8010687a <alltraps>

80107228 <vector41>:
80107228:	6a 00                	push   $0x0
8010722a:	6a 29                	push   $0x29
8010722c:	e9 49 f6 ff ff       	jmp    8010687a <alltraps>

80107231 <vector42>:
80107231:	6a 00                	push   $0x0
80107233:	6a 2a                	push   $0x2a
80107235:	e9 40 f6 ff ff       	jmp    8010687a <alltraps>

8010723a <vector43>:
8010723a:	6a 00                	push   $0x0
8010723c:	6a 2b                	push   $0x2b
8010723e:	e9 37 f6 ff ff       	jmp    8010687a <alltraps>

80107243 <vector44>:
80107243:	6a 00                	push   $0x0
80107245:	6a 2c                	push   $0x2c
80107247:	e9 2e f6 ff ff       	jmp    8010687a <alltraps>

8010724c <vector45>:
8010724c:	6a 00                	push   $0x0
8010724e:	6a 2d                	push   $0x2d
80107250:	e9 25 f6 ff ff       	jmp    8010687a <alltraps>

80107255 <vector46>:
80107255:	6a 00                	push   $0x0
80107257:	6a 2e                	push   $0x2e
80107259:	e9 1c f6 ff ff       	jmp    8010687a <alltraps>

8010725e <vector47>:
8010725e:	6a 00                	push   $0x0
80107260:	6a 2f                	push   $0x2f
80107262:	e9 13 f6 ff ff       	jmp    8010687a <alltraps>

80107267 <vector48>:
80107267:	6a 00                	push   $0x0
80107269:	6a 30                	push   $0x30
8010726b:	e9 0a f6 ff ff       	jmp    8010687a <alltraps>

80107270 <vector49>:
80107270:	6a 00                	push   $0x0
80107272:	6a 31                	push   $0x31
80107274:	e9 01 f6 ff ff       	jmp    8010687a <alltraps>

80107279 <vector50>:
80107279:	6a 00                	push   $0x0
8010727b:	6a 32                	push   $0x32
8010727d:	e9 f8 f5 ff ff       	jmp    8010687a <alltraps>

80107282 <vector51>:
80107282:	6a 00                	push   $0x0
80107284:	6a 33                	push   $0x33
80107286:	e9 ef f5 ff ff       	jmp    8010687a <alltraps>

8010728b <vector52>:
8010728b:	6a 00                	push   $0x0
8010728d:	6a 34                	push   $0x34
8010728f:	e9 e6 f5 ff ff       	jmp    8010687a <alltraps>

80107294 <vector53>:
80107294:	6a 00                	push   $0x0
80107296:	6a 35                	push   $0x35
80107298:	e9 dd f5 ff ff       	jmp    8010687a <alltraps>

8010729d <vector54>:
8010729d:	6a 00                	push   $0x0
8010729f:	6a 36                	push   $0x36
801072a1:	e9 d4 f5 ff ff       	jmp    8010687a <alltraps>

801072a6 <vector55>:
801072a6:	6a 00                	push   $0x0
801072a8:	6a 37                	push   $0x37
801072aa:	e9 cb f5 ff ff       	jmp    8010687a <alltraps>

801072af <vector56>:
801072af:	6a 00                	push   $0x0
801072b1:	6a 38                	push   $0x38
801072b3:	e9 c2 f5 ff ff       	jmp    8010687a <alltraps>

801072b8 <vector57>:
801072b8:	6a 00                	push   $0x0
801072ba:	6a 39                	push   $0x39
801072bc:	e9 b9 f5 ff ff       	jmp    8010687a <alltraps>

801072c1 <vector58>:
801072c1:	6a 00                	push   $0x0
801072c3:	6a 3a                	push   $0x3a
801072c5:	e9 b0 f5 ff ff       	jmp    8010687a <alltraps>

801072ca <vector59>:
801072ca:	6a 00                	push   $0x0
801072cc:	6a 3b                	push   $0x3b
801072ce:	e9 a7 f5 ff ff       	jmp    8010687a <alltraps>

801072d3 <vector60>:
801072d3:	6a 00                	push   $0x0
801072d5:	6a 3c                	push   $0x3c
801072d7:	e9 9e f5 ff ff       	jmp    8010687a <alltraps>

801072dc <vector61>:
801072dc:	6a 00                	push   $0x0
801072de:	6a 3d                	push   $0x3d
801072e0:	e9 95 f5 ff ff       	jmp    8010687a <alltraps>

801072e5 <vector62>:
801072e5:	6a 00                	push   $0x0
801072e7:	6a 3e                	push   $0x3e
801072e9:	e9 8c f5 ff ff       	jmp    8010687a <alltraps>

801072ee <vector63>:
801072ee:	6a 00                	push   $0x0
801072f0:	6a 3f                	push   $0x3f
801072f2:	e9 83 f5 ff ff       	jmp    8010687a <alltraps>

801072f7 <vector64>:
801072f7:	6a 00                	push   $0x0
801072f9:	6a 40                	push   $0x40
801072fb:	e9 7a f5 ff ff       	jmp    8010687a <alltraps>

80107300 <vector65>:
80107300:	6a 00                	push   $0x0
80107302:	6a 41                	push   $0x41
80107304:	e9 71 f5 ff ff       	jmp    8010687a <alltraps>

80107309 <vector66>:
80107309:	6a 00                	push   $0x0
8010730b:	6a 42                	push   $0x42
8010730d:	e9 68 f5 ff ff       	jmp    8010687a <alltraps>

80107312 <vector67>:
80107312:	6a 00                	push   $0x0
80107314:	6a 43                	push   $0x43
80107316:	e9 5f f5 ff ff       	jmp    8010687a <alltraps>

8010731b <vector68>:
8010731b:	6a 00                	push   $0x0
8010731d:	6a 44                	push   $0x44
8010731f:	e9 56 f5 ff ff       	jmp    8010687a <alltraps>

80107324 <vector69>:
80107324:	6a 00                	push   $0x0
80107326:	6a 45                	push   $0x45
80107328:	e9 4d f5 ff ff       	jmp    8010687a <alltraps>

8010732d <vector70>:
8010732d:	6a 00                	push   $0x0
8010732f:	6a 46                	push   $0x46
80107331:	e9 44 f5 ff ff       	jmp    8010687a <alltraps>

80107336 <vector71>:
80107336:	6a 00                	push   $0x0
80107338:	6a 47                	push   $0x47
8010733a:	e9 3b f5 ff ff       	jmp    8010687a <alltraps>

8010733f <vector72>:
8010733f:	6a 00                	push   $0x0
80107341:	6a 48                	push   $0x48
80107343:	e9 32 f5 ff ff       	jmp    8010687a <alltraps>

80107348 <vector73>:
80107348:	6a 00                	push   $0x0
8010734a:	6a 49                	push   $0x49
8010734c:	e9 29 f5 ff ff       	jmp    8010687a <alltraps>

80107351 <vector74>:
80107351:	6a 00                	push   $0x0
80107353:	6a 4a                	push   $0x4a
80107355:	e9 20 f5 ff ff       	jmp    8010687a <alltraps>

8010735a <vector75>:
8010735a:	6a 00                	push   $0x0
8010735c:	6a 4b                	push   $0x4b
8010735e:	e9 17 f5 ff ff       	jmp    8010687a <alltraps>

80107363 <vector76>:
80107363:	6a 00                	push   $0x0
80107365:	6a 4c                	push   $0x4c
80107367:	e9 0e f5 ff ff       	jmp    8010687a <alltraps>

8010736c <vector77>:
8010736c:	6a 00                	push   $0x0
8010736e:	6a 4d                	push   $0x4d
80107370:	e9 05 f5 ff ff       	jmp    8010687a <alltraps>

80107375 <vector78>:
80107375:	6a 00                	push   $0x0
80107377:	6a 4e                	push   $0x4e
80107379:	e9 fc f4 ff ff       	jmp    8010687a <alltraps>

8010737e <vector79>:
8010737e:	6a 00                	push   $0x0
80107380:	6a 4f                	push   $0x4f
80107382:	e9 f3 f4 ff ff       	jmp    8010687a <alltraps>

80107387 <vector80>:
80107387:	6a 00                	push   $0x0
80107389:	6a 50                	push   $0x50
8010738b:	e9 ea f4 ff ff       	jmp    8010687a <alltraps>

80107390 <vector81>:
80107390:	6a 00                	push   $0x0
80107392:	6a 51                	push   $0x51
80107394:	e9 e1 f4 ff ff       	jmp    8010687a <alltraps>

80107399 <vector82>:
80107399:	6a 00                	push   $0x0
8010739b:	6a 52                	push   $0x52
8010739d:	e9 d8 f4 ff ff       	jmp    8010687a <alltraps>

801073a2 <vector83>:
801073a2:	6a 00                	push   $0x0
801073a4:	6a 53                	push   $0x53
801073a6:	e9 cf f4 ff ff       	jmp    8010687a <alltraps>

801073ab <vector84>:
801073ab:	6a 00                	push   $0x0
801073ad:	6a 54                	push   $0x54
801073af:	e9 c6 f4 ff ff       	jmp    8010687a <alltraps>

801073b4 <vector85>:
801073b4:	6a 00                	push   $0x0
801073b6:	6a 55                	push   $0x55
801073b8:	e9 bd f4 ff ff       	jmp    8010687a <alltraps>

801073bd <vector86>:
801073bd:	6a 00                	push   $0x0
801073bf:	6a 56                	push   $0x56
801073c1:	e9 b4 f4 ff ff       	jmp    8010687a <alltraps>

801073c6 <vector87>:
801073c6:	6a 00                	push   $0x0
801073c8:	6a 57                	push   $0x57
801073ca:	e9 ab f4 ff ff       	jmp    8010687a <alltraps>

801073cf <vector88>:
801073cf:	6a 00                	push   $0x0
801073d1:	6a 58                	push   $0x58
801073d3:	e9 a2 f4 ff ff       	jmp    8010687a <alltraps>

801073d8 <vector89>:
801073d8:	6a 00                	push   $0x0
801073da:	6a 59                	push   $0x59
801073dc:	e9 99 f4 ff ff       	jmp    8010687a <alltraps>

801073e1 <vector90>:
801073e1:	6a 00                	push   $0x0
801073e3:	6a 5a                	push   $0x5a
801073e5:	e9 90 f4 ff ff       	jmp    8010687a <alltraps>

801073ea <vector91>:
801073ea:	6a 00                	push   $0x0
801073ec:	6a 5b                	push   $0x5b
801073ee:	e9 87 f4 ff ff       	jmp    8010687a <alltraps>

801073f3 <vector92>:
801073f3:	6a 00                	push   $0x0
801073f5:	6a 5c                	push   $0x5c
801073f7:	e9 7e f4 ff ff       	jmp    8010687a <alltraps>

801073fc <vector93>:
801073fc:	6a 00                	push   $0x0
801073fe:	6a 5d                	push   $0x5d
80107400:	e9 75 f4 ff ff       	jmp    8010687a <alltraps>

80107405 <vector94>:
80107405:	6a 00                	push   $0x0
80107407:	6a 5e                	push   $0x5e
80107409:	e9 6c f4 ff ff       	jmp    8010687a <alltraps>

8010740e <vector95>:
8010740e:	6a 00                	push   $0x0
80107410:	6a 5f                	push   $0x5f
80107412:	e9 63 f4 ff ff       	jmp    8010687a <alltraps>

80107417 <vector96>:
80107417:	6a 00                	push   $0x0
80107419:	6a 60                	push   $0x60
8010741b:	e9 5a f4 ff ff       	jmp    8010687a <alltraps>

80107420 <vector97>:
80107420:	6a 00                	push   $0x0
80107422:	6a 61                	push   $0x61
80107424:	e9 51 f4 ff ff       	jmp    8010687a <alltraps>

80107429 <vector98>:
80107429:	6a 00                	push   $0x0
8010742b:	6a 62                	push   $0x62
8010742d:	e9 48 f4 ff ff       	jmp    8010687a <alltraps>

80107432 <vector99>:
80107432:	6a 00                	push   $0x0
80107434:	6a 63                	push   $0x63
80107436:	e9 3f f4 ff ff       	jmp    8010687a <alltraps>

8010743b <vector100>:
8010743b:	6a 00                	push   $0x0
8010743d:	6a 64                	push   $0x64
8010743f:	e9 36 f4 ff ff       	jmp    8010687a <alltraps>

80107444 <vector101>:
80107444:	6a 00                	push   $0x0
80107446:	6a 65                	push   $0x65
80107448:	e9 2d f4 ff ff       	jmp    8010687a <alltraps>

8010744d <vector102>:
8010744d:	6a 00                	push   $0x0
8010744f:	6a 66                	push   $0x66
80107451:	e9 24 f4 ff ff       	jmp    8010687a <alltraps>

80107456 <vector103>:
80107456:	6a 00                	push   $0x0
80107458:	6a 67                	push   $0x67
8010745a:	e9 1b f4 ff ff       	jmp    8010687a <alltraps>

8010745f <vector104>:
8010745f:	6a 00                	push   $0x0
80107461:	6a 68                	push   $0x68
80107463:	e9 12 f4 ff ff       	jmp    8010687a <alltraps>

80107468 <vector105>:
80107468:	6a 00                	push   $0x0
8010746a:	6a 69                	push   $0x69
8010746c:	e9 09 f4 ff ff       	jmp    8010687a <alltraps>

80107471 <vector106>:
80107471:	6a 00                	push   $0x0
80107473:	6a 6a                	push   $0x6a
80107475:	e9 00 f4 ff ff       	jmp    8010687a <alltraps>

8010747a <vector107>:
8010747a:	6a 00                	push   $0x0
8010747c:	6a 6b                	push   $0x6b
8010747e:	e9 f7 f3 ff ff       	jmp    8010687a <alltraps>

80107483 <vector108>:
80107483:	6a 00                	push   $0x0
80107485:	6a 6c                	push   $0x6c
80107487:	e9 ee f3 ff ff       	jmp    8010687a <alltraps>

8010748c <vector109>:
8010748c:	6a 00                	push   $0x0
8010748e:	6a 6d                	push   $0x6d
80107490:	e9 e5 f3 ff ff       	jmp    8010687a <alltraps>

80107495 <vector110>:
80107495:	6a 00                	push   $0x0
80107497:	6a 6e                	push   $0x6e
80107499:	e9 dc f3 ff ff       	jmp    8010687a <alltraps>

8010749e <vector111>:
8010749e:	6a 00                	push   $0x0
801074a0:	6a 6f                	push   $0x6f
801074a2:	e9 d3 f3 ff ff       	jmp    8010687a <alltraps>

801074a7 <vector112>:
801074a7:	6a 00                	push   $0x0
801074a9:	6a 70                	push   $0x70
801074ab:	e9 ca f3 ff ff       	jmp    8010687a <alltraps>

801074b0 <vector113>:
801074b0:	6a 00                	push   $0x0
801074b2:	6a 71                	push   $0x71
801074b4:	e9 c1 f3 ff ff       	jmp    8010687a <alltraps>

801074b9 <vector114>:
801074b9:	6a 00                	push   $0x0
801074bb:	6a 72                	push   $0x72
801074bd:	e9 b8 f3 ff ff       	jmp    8010687a <alltraps>

801074c2 <vector115>:
801074c2:	6a 00                	push   $0x0
801074c4:	6a 73                	push   $0x73
801074c6:	e9 af f3 ff ff       	jmp    8010687a <alltraps>

801074cb <vector116>:
801074cb:	6a 00                	push   $0x0
801074cd:	6a 74                	push   $0x74
801074cf:	e9 a6 f3 ff ff       	jmp    8010687a <alltraps>

801074d4 <vector117>:
801074d4:	6a 00                	push   $0x0
801074d6:	6a 75                	push   $0x75
801074d8:	e9 9d f3 ff ff       	jmp    8010687a <alltraps>

801074dd <vector118>:
801074dd:	6a 00                	push   $0x0
801074df:	6a 76                	push   $0x76
801074e1:	e9 94 f3 ff ff       	jmp    8010687a <alltraps>

801074e6 <vector119>:
801074e6:	6a 00                	push   $0x0
801074e8:	6a 77                	push   $0x77
801074ea:	e9 8b f3 ff ff       	jmp    8010687a <alltraps>

801074ef <vector120>:
801074ef:	6a 00                	push   $0x0
801074f1:	6a 78                	push   $0x78
801074f3:	e9 82 f3 ff ff       	jmp    8010687a <alltraps>

801074f8 <vector121>:
801074f8:	6a 00                	push   $0x0
801074fa:	6a 79                	push   $0x79
801074fc:	e9 79 f3 ff ff       	jmp    8010687a <alltraps>

80107501 <vector122>:
80107501:	6a 00                	push   $0x0
80107503:	6a 7a                	push   $0x7a
80107505:	e9 70 f3 ff ff       	jmp    8010687a <alltraps>

8010750a <vector123>:
8010750a:	6a 00                	push   $0x0
8010750c:	6a 7b                	push   $0x7b
8010750e:	e9 67 f3 ff ff       	jmp    8010687a <alltraps>

80107513 <vector124>:
80107513:	6a 00                	push   $0x0
80107515:	6a 7c                	push   $0x7c
80107517:	e9 5e f3 ff ff       	jmp    8010687a <alltraps>

8010751c <vector125>:
8010751c:	6a 00                	push   $0x0
8010751e:	6a 7d                	push   $0x7d
80107520:	e9 55 f3 ff ff       	jmp    8010687a <alltraps>

80107525 <vector126>:
80107525:	6a 00                	push   $0x0
80107527:	6a 7e                	push   $0x7e
80107529:	e9 4c f3 ff ff       	jmp    8010687a <alltraps>

8010752e <vector127>:
8010752e:	6a 00                	push   $0x0
80107530:	6a 7f                	push   $0x7f
80107532:	e9 43 f3 ff ff       	jmp    8010687a <alltraps>

80107537 <vector128>:
80107537:	6a 00                	push   $0x0
80107539:	68 80 00 00 00       	push   $0x80
8010753e:	e9 37 f3 ff ff       	jmp    8010687a <alltraps>

80107543 <vector129>:
80107543:	6a 00                	push   $0x0
80107545:	68 81 00 00 00       	push   $0x81
8010754a:	e9 2b f3 ff ff       	jmp    8010687a <alltraps>

8010754f <vector130>:
8010754f:	6a 00                	push   $0x0
80107551:	68 82 00 00 00       	push   $0x82
80107556:	e9 1f f3 ff ff       	jmp    8010687a <alltraps>

8010755b <vector131>:
8010755b:	6a 00                	push   $0x0
8010755d:	68 83 00 00 00       	push   $0x83
80107562:	e9 13 f3 ff ff       	jmp    8010687a <alltraps>

80107567 <vector132>:
80107567:	6a 00                	push   $0x0
80107569:	68 84 00 00 00       	push   $0x84
8010756e:	e9 07 f3 ff ff       	jmp    8010687a <alltraps>

80107573 <vector133>:
80107573:	6a 00                	push   $0x0
80107575:	68 85 00 00 00       	push   $0x85
8010757a:	e9 fb f2 ff ff       	jmp    8010687a <alltraps>

8010757f <vector134>:
8010757f:	6a 00                	push   $0x0
80107581:	68 86 00 00 00       	push   $0x86
80107586:	e9 ef f2 ff ff       	jmp    8010687a <alltraps>

8010758b <vector135>:
8010758b:	6a 00                	push   $0x0
8010758d:	68 87 00 00 00       	push   $0x87
80107592:	e9 e3 f2 ff ff       	jmp    8010687a <alltraps>

80107597 <vector136>:
80107597:	6a 00                	push   $0x0
80107599:	68 88 00 00 00       	push   $0x88
8010759e:	e9 d7 f2 ff ff       	jmp    8010687a <alltraps>

801075a3 <vector137>:
801075a3:	6a 00                	push   $0x0
801075a5:	68 89 00 00 00       	push   $0x89
801075aa:	e9 cb f2 ff ff       	jmp    8010687a <alltraps>

801075af <vector138>:
801075af:	6a 00                	push   $0x0
801075b1:	68 8a 00 00 00       	push   $0x8a
801075b6:	e9 bf f2 ff ff       	jmp    8010687a <alltraps>

801075bb <vector139>:
801075bb:	6a 00                	push   $0x0
801075bd:	68 8b 00 00 00       	push   $0x8b
801075c2:	e9 b3 f2 ff ff       	jmp    8010687a <alltraps>

801075c7 <vector140>:
801075c7:	6a 00                	push   $0x0
801075c9:	68 8c 00 00 00       	push   $0x8c
801075ce:	e9 a7 f2 ff ff       	jmp    8010687a <alltraps>

801075d3 <vector141>:
801075d3:	6a 00                	push   $0x0
801075d5:	68 8d 00 00 00       	push   $0x8d
801075da:	e9 9b f2 ff ff       	jmp    8010687a <alltraps>

801075df <vector142>:
801075df:	6a 00                	push   $0x0
801075e1:	68 8e 00 00 00       	push   $0x8e
801075e6:	e9 8f f2 ff ff       	jmp    8010687a <alltraps>

801075eb <vector143>:
801075eb:	6a 00                	push   $0x0
801075ed:	68 8f 00 00 00       	push   $0x8f
801075f2:	e9 83 f2 ff ff       	jmp    8010687a <alltraps>

801075f7 <vector144>:
801075f7:	6a 00                	push   $0x0
801075f9:	68 90 00 00 00       	push   $0x90
801075fe:	e9 77 f2 ff ff       	jmp    8010687a <alltraps>

80107603 <vector145>:
80107603:	6a 00                	push   $0x0
80107605:	68 91 00 00 00       	push   $0x91
8010760a:	e9 6b f2 ff ff       	jmp    8010687a <alltraps>

8010760f <vector146>:
8010760f:	6a 00                	push   $0x0
80107611:	68 92 00 00 00       	push   $0x92
80107616:	e9 5f f2 ff ff       	jmp    8010687a <alltraps>

8010761b <vector147>:
8010761b:	6a 00                	push   $0x0
8010761d:	68 93 00 00 00       	push   $0x93
80107622:	e9 53 f2 ff ff       	jmp    8010687a <alltraps>

80107627 <vector148>:
80107627:	6a 00                	push   $0x0
80107629:	68 94 00 00 00       	push   $0x94
8010762e:	e9 47 f2 ff ff       	jmp    8010687a <alltraps>

80107633 <vector149>:
80107633:	6a 00                	push   $0x0
80107635:	68 95 00 00 00       	push   $0x95
8010763a:	e9 3b f2 ff ff       	jmp    8010687a <alltraps>

8010763f <vector150>:
8010763f:	6a 00                	push   $0x0
80107641:	68 96 00 00 00       	push   $0x96
80107646:	e9 2f f2 ff ff       	jmp    8010687a <alltraps>

8010764b <vector151>:
8010764b:	6a 00                	push   $0x0
8010764d:	68 97 00 00 00       	push   $0x97
80107652:	e9 23 f2 ff ff       	jmp    8010687a <alltraps>

80107657 <vector152>:
80107657:	6a 00                	push   $0x0
80107659:	68 98 00 00 00       	push   $0x98
8010765e:	e9 17 f2 ff ff       	jmp    8010687a <alltraps>

80107663 <vector153>:
80107663:	6a 00                	push   $0x0
80107665:	68 99 00 00 00       	push   $0x99
8010766a:	e9 0b f2 ff ff       	jmp    8010687a <alltraps>

8010766f <vector154>:
8010766f:	6a 00                	push   $0x0
80107671:	68 9a 00 00 00       	push   $0x9a
80107676:	e9 ff f1 ff ff       	jmp    8010687a <alltraps>

8010767b <vector155>:
8010767b:	6a 00                	push   $0x0
8010767d:	68 9b 00 00 00       	push   $0x9b
80107682:	e9 f3 f1 ff ff       	jmp    8010687a <alltraps>

80107687 <vector156>:
80107687:	6a 00                	push   $0x0
80107689:	68 9c 00 00 00       	push   $0x9c
8010768e:	e9 e7 f1 ff ff       	jmp    8010687a <alltraps>

80107693 <vector157>:
80107693:	6a 00                	push   $0x0
80107695:	68 9d 00 00 00       	push   $0x9d
8010769a:	e9 db f1 ff ff       	jmp    8010687a <alltraps>

8010769f <vector158>:
8010769f:	6a 00                	push   $0x0
801076a1:	68 9e 00 00 00       	push   $0x9e
801076a6:	e9 cf f1 ff ff       	jmp    8010687a <alltraps>

801076ab <vector159>:
801076ab:	6a 00                	push   $0x0
801076ad:	68 9f 00 00 00       	push   $0x9f
801076b2:	e9 c3 f1 ff ff       	jmp    8010687a <alltraps>

801076b7 <vector160>:
801076b7:	6a 00                	push   $0x0
801076b9:	68 a0 00 00 00       	push   $0xa0
801076be:	e9 b7 f1 ff ff       	jmp    8010687a <alltraps>

801076c3 <vector161>:
801076c3:	6a 00                	push   $0x0
801076c5:	68 a1 00 00 00       	push   $0xa1
801076ca:	e9 ab f1 ff ff       	jmp    8010687a <alltraps>

801076cf <vector162>:
801076cf:	6a 00                	push   $0x0
801076d1:	68 a2 00 00 00       	push   $0xa2
801076d6:	e9 9f f1 ff ff       	jmp    8010687a <alltraps>

801076db <vector163>:
801076db:	6a 00                	push   $0x0
801076dd:	68 a3 00 00 00       	push   $0xa3
801076e2:	e9 93 f1 ff ff       	jmp    8010687a <alltraps>

801076e7 <vector164>:
801076e7:	6a 00                	push   $0x0
801076e9:	68 a4 00 00 00       	push   $0xa4
801076ee:	e9 87 f1 ff ff       	jmp    8010687a <alltraps>

801076f3 <vector165>:
801076f3:	6a 00                	push   $0x0
801076f5:	68 a5 00 00 00       	push   $0xa5
801076fa:	e9 7b f1 ff ff       	jmp    8010687a <alltraps>

801076ff <vector166>:
801076ff:	6a 00                	push   $0x0
80107701:	68 a6 00 00 00       	push   $0xa6
80107706:	e9 6f f1 ff ff       	jmp    8010687a <alltraps>

8010770b <vector167>:
8010770b:	6a 00                	push   $0x0
8010770d:	68 a7 00 00 00       	push   $0xa7
80107712:	e9 63 f1 ff ff       	jmp    8010687a <alltraps>

80107717 <vector168>:
80107717:	6a 00                	push   $0x0
80107719:	68 a8 00 00 00       	push   $0xa8
8010771e:	e9 57 f1 ff ff       	jmp    8010687a <alltraps>

80107723 <vector169>:
80107723:	6a 00                	push   $0x0
80107725:	68 a9 00 00 00       	push   $0xa9
8010772a:	e9 4b f1 ff ff       	jmp    8010687a <alltraps>

8010772f <vector170>:
8010772f:	6a 00                	push   $0x0
80107731:	68 aa 00 00 00       	push   $0xaa
80107736:	e9 3f f1 ff ff       	jmp    8010687a <alltraps>

8010773b <vector171>:
8010773b:	6a 00                	push   $0x0
8010773d:	68 ab 00 00 00       	push   $0xab
80107742:	e9 33 f1 ff ff       	jmp    8010687a <alltraps>

80107747 <vector172>:
80107747:	6a 00                	push   $0x0
80107749:	68 ac 00 00 00       	push   $0xac
8010774e:	e9 27 f1 ff ff       	jmp    8010687a <alltraps>

80107753 <vector173>:
80107753:	6a 00                	push   $0x0
80107755:	68 ad 00 00 00       	push   $0xad
8010775a:	e9 1b f1 ff ff       	jmp    8010687a <alltraps>

8010775f <vector174>:
8010775f:	6a 00                	push   $0x0
80107761:	68 ae 00 00 00       	push   $0xae
80107766:	e9 0f f1 ff ff       	jmp    8010687a <alltraps>

8010776b <vector175>:
8010776b:	6a 00                	push   $0x0
8010776d:	68 af 00 00 00       	push   $0xaf
80107772:	e9 03 f1 ff ff       	jmp    8010687a <alltraps>

80107777 <vector176>:
80107777:	6a 00                	push   $0x0
80107779:	68 b0 00 00 00       	push   $0xb0
8010777e:	e9 f7 f0 ff ff       	jmp    8010687a <alltraps>

80107783 <vector177>:
80107783:	6a 00                	push   $0x0
80107785:	68 b1 00 00 00       	push   $0xb1
8010778a:	e9 eb f0 ff ff       	jmp    8010687a <alltraps>

8010778f <vector178>:
8010778f:	6a 00                	push   $0x0
80107791:	68 b2 00 00 00       	push   $0xb2
80107796:	e9 df f0 ff ff       	jmp    8010687a <alltraps>

8010779b <vector179>:
8010779b:	6a 00                	push   $0x0
8010779d:	68 b3 00 00 00       	push   $0xb3
801077a2:	e9 d3 f0 ff ff       	jmp    8010687a <alltraps>

801077a7 <vector180>:
801077a7:	6a 00                	push   $0x0
801077a9:	68 b4 00 00 00       	push   $0xb4
801077ae:	e9 c7 f0 ff ff       	jmp    8010687a <alltraps>

801077b3 <vector181>:
801077b3:	6a 00                	push   $0x0
801077b5:	68 b5 00 00 00       	push   $0xb5
801077ba:	e9 bb f0 ff ff       	jmp    8010687a <alltraps>

801077bf <vector182>:
801077bf:	6a 00                	push   $0x0
801077c1:	68 b6 00 00 00       	push   $0xb6
801077c6:	e9 af f0 ff ff       	jmp    8010687a <alltraps>

801077cb <vector183>:
801077cb:	6a 00                	push   $0x0
801077cd:	68 b7 00 00 00       	push   $0xb7
801077d2:	e9 a3 f0 ff ff       	jmp    8010687a <alltraps>

801077d7 <vector184>:
801077d7:	6a 00                	push   $0x0
801077d9:	68 b8 00 00 00       	push   $0xb8
801077de:	e9 97 f0 ff ff       	jmp    8010687a <alltraps>

801077e3 <vector185>:
801077e3:	6a 00                	push   $0x0
801077e5:	68 b9 00 00 00       	push   $0xb9
801077ea:	e9 8b f0 ff ff       	jmp    8010687a <alltraps>

801077ef <vector186>:
801077ef:	6a 00                	push   $0x0
801077f1:	68 ba 00 00 00       	push   $0xba
801077f6:	e9 7f f0 ff ff       	jmp    8010687a <alltraps>

801077fb <vector187>:
801077fb:	6a 00                	push   $0x0
801077fd:	68 bb 00 00 00       	push   $0xbb
80107802:	e9 73 f0 ff ff       	jmp    8010687a <alltraps>

80107807 <vector188>:
80107807:	6a 00                	push   $0x0
80107809:	68 bc 00 00 00       	push   $0xbc
8010780e:	e9 67 f0 ff ff       	jmp    8010687a <alltraps>

80107813 <vector189>:
80107813:	6a 00                	push   $0x0
80107815:	68 bd 00 00 00       	push   $0xbd
8010781a:	e9 5b f0 ff ff       	jmp    8010687a <alltraps>

8010781f <vector190>:
8010781f:	6a 00                	push   $0x0
80107821:	68 be 00 00 00       	push   $0xbe
80107826:	e9 4f f0 ff ff       	jmp    8010687a <alltraps>

8010782b <vector191>:
8010782b:	6a 00                	push   $0x0
8010782d:	68 bf 00 00 00       	push   $0xbf
80107832:	e9 43 f0 ff ff       	jmp    8010687a <alltraps>

80107837 <vector192>:
80107837:	6a 00                	push   $0x0
80107839:	68 c0 00 00 00       	push   $0xc0
8010783e:	e9 37 f0 ff ff       	jmp    8010687a <alltraps>

80107843 <vector193>:
80107843:	6a 00                	push   $0x0
80107845:	68 c1 00 00 00       	push   $0xc1
8010784a:	e9 2b f0 ff ff       	jmp    8010687a <alltraps>

8010784f <vector194>:
8010784f:	6a 00                	push   $0x0
80107851:	68 c2 00 00 00       	push   $0xc2
80107856:	e9 1f f0 ff ff       	jmp    8010687a <alltraps>

8010785b <vector195>:
8010785b:	6a 00                	push   $0x0
8010785d:	68 c3 00 00 00       	push   $0xc3
80107862:	e9 13 f0 ff ff       	jmp    8010687a <alltraps>

80107867 <vector196>:
80107867:	6a 00                	push   $0x0
80107869:	68 c4 00 00 00       	push   $0xc4
8010786e:	e9 07 f0 ff ff       	jmp    8010687a <alltraps>

80107873 <vector197>:
80107873:	6a 00                	push   $0x0
80107875:	68 c5 00 00 00       	push   $0xc5
8010787a:	e9 fb ef ff ff       	jmp    8010687a <alltraps>

8010787f <vector198>:
8010787f:	6a 00                	push   $0x0
80107881:	68 c6 00 00 00       	push   $0xc6
80107886:	e9 ef ef ff ff       	jmp    8010687a <alltraps>

8010788b <vector199>:
8010788b:	6a 00                	push   $0x0
8010788d:	68 c7 00 00 00       	push   $0xc7
80107892:	e9 e3 ef ff ff       	jmp    8010687a <alltraps>

80107897 <vector200>:
80107897:	6a 00                	push   $0x0
80107899:	68 c8 00 00 00       	push   $0xc8
8010789e:	e9 d7 ef ff ff       	jmp    8010687a <alltraps>

801078a3 <vector201>:
801078a3:	6a 00                	push   $0x0
801078a5:	68 c9 00 00 00       	push   $0xc9
801078aa:	e9 cb ef ff ff       	jmp    8010687a <alltraps>

801078af <vector202>:
801078af:	6a 00                	push   $0x0
801078b1:	68 ca 00 00 00       	push   $0xca
801078b6:	e9 bf ef ff ff       	jmp    8010687a <alltraps>

801078bb <vector203>:
801078bb:	6a 00                	push   $0x0
801078bd:	68 cb 00 00 00       	push   $0xcb
801078c2:	e9 b3 ef ff ff       	jmp    8010687a <alltraps>

801078c7 <vector204>:
801078c7:	6a 00                	push   $0x0
801078c9:	68 cc 00 00 00       	push   $0xcc
801078ce:	e9 a7 ef ff ff       	jmp    8010687a <alltraps>

801078d3 <vector205>:
801078d3:	6a 00                	push   $0x0
801078d5:	68 cd 00 00 00       	push   $0xcd
801078da:	e9 9b ef ff ff       	jmp    8010687a <alltraps>

801078df <vector206>:
801078df:	6a 00                	push   $0x0
801078e1:	68 ce 00 00 00       	push   $0xce
801078e6:	e9 8f ef ff ff       	jmp    8010687a <alltraps>

801078eb <vector207>:
801078eb:	6a 00                	push   $0x0
801078ed:	68 cf 00 00 00       	push   $0xcf
801078f2:	e9 83 ef ff ff       	jmp    8010687a <alltraps>

801078f7 <vector208>:
801078f7:	6a 00                	push   $0x0
801078f9:	68 d0 00 00 00       	push   $0xd0
801078fe:	e9 77 ef ff ff       	jmp    8010687a <alltraps>

80107903 <vector209>:
80107903:	6a 00                	push   $0x0
80107905:	68 d1 00 00 00       	push   $0xd1
8010790a:	e9 6b ef ff ff       	jmp    8010687a <alltraps>

8010790f <vector210>:
8010790f:	6a 00                	push   $0x0
80107911:	68 d2 00 00 00       	push   $0xd2
80107916:	e9 5f ef ff ff       	jmp    8010687a <alltraps>

8010791b <vector211>:
8010791b:	6a 00                	push   $0x0
8010791d:	68 d3 00 00 00       	push   $0xd3
80107922:	e9 53 ef ff ff       	jmp    8010687a <alltraps>

80107927 <vector212>:
80107927:	6a 00                	push   $0x0
80107929:	68 d4 00 00 00       	push   $0xd4
8010792e:	e9 47 ef ff ff       	jmp    8010687a <alltraps>

80107933 <vector213>:
80107933:	6a 00                	push   $0x0
80107935:	68 d5 00 00 00       	push   $0xd5
8010793a:	e9 3b ef ff ff       	jmp    8010687a <alltraps>

8010793f <vector214>:
8010793f:	6a 00                	push   $0x0
80107941:	68 d6 00 00 00       	push   $0xd6
80107946:	e9 2f ef ff ff       	jmp    8010687a <alltraps>

8010794b <vector215>:
8010794b:	6a 00                	push   $0x0
8010794d:	68 d7 00 00 00       	push   $0xd7
80107952:	e9 23 ef ff ff       	jmp    8010687a <alltraps>

80107957 <vector216>:
80107957:	6a 00                	push   $0x0
80107959:	68 d8 00 00 00       	push   $0xd8
8010795e:	e9 17 ef ff ff       	jmp    8010687a <alltraps>

80107963 <vector217>:
80107963:	6a 00                	push   $0x0
80107965:	68 d9 00 00 00       	push   $0xd9
8010796a:	e9 0b ef ff ff       	jmp    8010687a <alltraps>

8010796f <vector218>:
8010796f:	6a 00                	push   $0x0
80107971:	68 da 00 00 00       	push   $0xda
80107976:	e9 ff ee ff ff       	jmp    8010687a <alltraps>

8010797b <vector219>:
8010797b:	6a 00                	push   $0x0
8010797d:	68 db 00 00 00       	push   $0xdb
80107982:	e9 f3 ee ff ff       	jmp    8010687a <alltraps>

80107987 <vector220>:
80107987:	6a 00                	push   $0x0
80107989:	68 dc 00 00 00       	push   $0xdc
8010798e:	e9 e7 ee ff ff       	jmp    8010687a <alltraps>

80107993 <vector221>:
80107993:	6a 00                	push   $0x0
80107995:	68 dd 00 00 00       	push   $0xdd
8010799a:	e9 db ee ff ff       	jmp    8010687a <alltraps>

8010799f <vector222>:
8010799f:	6a 00                	push   $0x0
801079a1:	68 de 00 00 00       	push   $0xde
801079a6:	e9 cf ee ff ff       	jmp    8010687a <alltraps>

801079ab <vector223>:
801079ab:	6a 00                	push   $0x0
801079ad:	68 df 00 00 00       	push   $0xdf
801079b2:	e9 c3 ee ff ff       	jmp    8010687a <alltraps>

801079b7 <vector224>:
801079b7:	6a 00                	push   $0x0
801079b9:	68 e0 00 00 00       	push   $0xe0
801079be:	e9 b7 ee ff ff       	jmp    8010687a <alltraps>

801079c3 <vector225>:
801079c3:	6a 00                	push   $0x0
801079c5:	68 e1 00 00 00       	push   $0xe1
801079ca:	e9 ab ee ff ff       	jmp    8010687a <alltraps>

801079cf <vector226>:
801079cf:	6a 00                	push   $0x0
801079d1:	68 e2 00 00 00       	push   $0xe2
801079d6:	e9 9f ee ff ff       	jmp    8010687a <alltraps>

801079db <vector227>:
801079db:	6a 00                	push   $0x0
801079dd:	68 e3 00 00 00       	push   $0xe3
801079e2:	e9 93 ee ff ff       	jmp    8010687a <alltraps>

801079e7 <vector228>:
801079e7:	6a 00                	push   $0x0
801079e9:	68 e4 00 00 00       	push   $0xe4
801079ee:	e9 87 ee ff ff       	jmp    8010687a <alltraps>

801079f3 <vector229>:
801079f3:	6a 00                	push   $0x0
801079f5:	68 e5 00 00 00       	push   $0xe5
801079fa:	e9 7b ee ff ff       	jmp    8010687a <alltraps>

801079ff <vector230>:
801079ff:	6a 00                	push   $0x0
80107a01:	68 e6 00 00 00       	push   $0xe6
80107a06:	e9 6f ee ff ff       	jmp    8010687a <alltraps>

80107a0b <vector231>:
80107a0b:	6a 00                	push   $0x0
80107a0d:	68 e7 00 00 00       	push   $0xe7
80107a12:	e9 63 ee ff ff       	jmp    8010687a <alltraps>

80107a17 <vector232>:
80107a17:	6a 00                	push   $0x0
80107a19:	68 e8 00 00 00       	push   $0xe8
80107a1e:	e9 57 ee ff ff       	jmp    8010687a <alltraps>

80107a23 <vector233>:
80107a23:	6a 00                	push   $0x0
80107a25:	68 e9 00 00 00       	push   $0xe9
80107a2a:	e9 4b ee ff ff       	jmp    8010687a <alltraps>

80107a2f <vector234>:
80107a2f:	6a 00                	push   $0x0
80107a31:	68 ea 00 00 00       	push   $0xea
80107a36:	e9 3f ee ff ff       	jmp    8010687a <alltraps>

80107a3b <vector235>:
80107a3b:	6a 00                	push   $0x0
80107a3d:	68 eb 00 00 00       	push   $0xeb
80107a42:	e9 33 ee ff ff       	jmp    8010687a <alltraps>

80107a47 <vector236>:
80107a47:	6a 00                	push   $0x0
80107a49:	68 ec 00 00 00       	push   $0xec
80107a4e:	e9 27 ee ff ff       	jmp    8010687a <alltraps>

80107a53 <vector237>:
80107a53:	6a 00                	push   $0x0
80107a55:	68 ed 00 00 00       	push   $0xed
80107a5a:	e9 1b ee ff ff       	jmp    8010687a <alltraps>

80107a5f <vector238>:
80107a5f:	6a 00                	push   $0x0
80107a61:	68 ee 00 00 00       	push   $0xee
80107a66:	e9 0f ee ff ff       	jmp    8010687a <alltraps>

80107a6b <vector239>:
80107a6b:	6a 00                	push   $0x0
80107a6d:	68 ef 00 00 00       	push   $0xef
80107a72:	e9 03 ee ff ff       	jmp    8010687a <alltraps>

80107a77 <vector240>:
80107a77:	6a 00                	push   $0x0
80107a79:	68 f0 00 00 00       	push   $0xf0
80107a7e:	e9 f7 ed ff ff       	jmp    8010687a <alltraps>

80107a83 <vector241>:
80107a83:	6a 00                	push   $0x0
80107a85:	68 f1 00 00 00       	push   $0xf1
80107a8a:	e9 eb ed ff ff       	jmp    8010687a <alltraps>

80107a8f <vector242>:
80107a8f:	6a 00                	push   $0x0
80107a91:	68 f2 00 00 00       	push   $0xf2
80107a96:	e9 df ed ff ff       	jmp    8010687a <alltraps>

80107a9b <vector243>:
80107a9b:	6a 00                	push   $0x0
80107a9d:	68 f3 00 00 00       	push   $0xf3
80107aa2:	e9 d3 ed ff ff       	jmp    8010687a <alltraps>

80107aa7 <vector244>:
80107aa7:	6a 00                	push   $0x0
80107aa9:	68 f4 00 00 00       	push   $0xf4
80107aae:	e9 c7 ed ff ff       	jmp    8010687a <alltraps>

80107ab3 <vector245>:
80107ab3:	6a 00                	push   $0x0
80107ab5:	68 f5 00 00 00       	push   $0xf5
80107aba:	e9 bb ed ff ff       	jmp    8010687a <alltraps>

80107abf <vector246>:
80107abf:	6a 00                	push   $0x0
80107ac1:	68 f6 00 00 00       	push   $0xf6
80107ac6:	e9 af ed ff ff       	jmp    8010687a <alltraps>

80107acb <vector247>:
80107acb:	6a 00                	push   $0x0
80107acd:	68 f7 00 00 00       	push   $0xf7
80107ad2:	e9 a3 ed ff ff       	jmp    8010687a <alltraps>

80107ad7 <vector248>:
80107ad7:	6a 00                	push   $0x0
80107ad9:	68 f8 00 00 00       	push   $0xf8
80107ade:	e9 97 ed ff ff       	jmp    8010687a <alltraps>

80107ae3 <vector249>:
80107ae3:	6a 00                	push   $0x0
80107ae5:	68 f9 00 00 00       	push   $0xf9
80107aea:	e9 8b ed ff ff       	jmp    8010687a <alltraps>

80107aef <vector250>:
80107aef:	6a 00                	push   $0x0
80107af1:	68 fa 00 00 00       	push   $0xfa
80107af6:	e9 7f ed ff ff       	jmp    8010687a <alltraps>

80107afb <vector251>:
80107afb:	6a 00                	push   $0x0
80107afd:	68 fb 00 00 00       	push   $0xfb
80107b02:	e9 73 ed ff ff       	jmp    8010687a <alltraps>

80107b07 <vector252>:
80107b07:	6a 00                	push   $0x0
80107b09:	68 fc 00 00 00       	push   $0xfc
80107b0e:	e9 67 ed ff ff       	jmp    8010687a <alltraps>

80107b13 <vector253>:
80107b13:	6a 00                	push   $0x0
80107b15:	68 fd 00 00 00       	push   $0xfd
80107b1a:	e9 5b ed ff ff       	jmp    8010687a <alltraps>

80107b1f <vector254>:
80107b1f:	6a 00                	push   $0x0
80107b21:	68 fe 00 00 00       	push   $0xfe
80107b26:	e9 4f ed ff ff       	jmp    8010687a <alltraps>

80107b2b <vector255>:
80107b2b:	6a 00                	push   $0x0
80107b2d:	68 ff 00 00 00       	push   $0xff
80107b32:	e9 43 ed ff ff       	jmp    8010687a <alltraps>

80107b37 <lgdt>:
80107b37:	55                   	push   %ebp
80107b38:	89 e5                	mov    %esp,%ebp
80107b3a:	83 ec 10             	sub    $0x10,%esp
80107b3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b40:	83 e8 01             	sub    $0x1,%eax
80107b43:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80107b47:	8b 45 08             	mov    0x8(%ebp),%eax
80107b4a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107b4e:	8b 45 08             	mov    0x8(%ebp),%eax
80107b51:	c1 e8 10             	shr    $0x10,%eax
80107b54:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80107b58:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107b5b:	0f 01 10             	lgdtl  (%eax)
80107b5e:	90                   	nop
80107b5f:	c9                   	leave  
80107b60:	c3                   	ret    

80107b61 <ltr>:
80107b61:	55                   	push   %ebp
80107b62:	89 e5                	mov    %esp,%ebp
80107b64:	83 ec 04             	sub    $0x4,%esp
80107b67:	8b 45 08             	mov    0x8(%ebp),%eax
80107b6a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107b6e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107b72:	0f 00 d8             	ltr    %ax
80107b75:	90                   	nop
80107b76:	c9                   	leave  
80107b77:	c3                   	ret    

80107b78 <loadgs>:
80107b78:	55                   	push   %ebp
80107b79:	89 e5                	mov    %esp,%ebp
80107b7b:	83 ec 04             	sub    $0x4,%esp
80107b7e:	8b 45 08             	mov    0x8(%ebp),%eax
80107b81:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107b85:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107b89:	8e e8                	mov    %eax,%gs
80107b8b:	90                   	nop
80107b8c:	c9                   	leave  
80107b8d:	c3                   	ret    

80107b8e <lcr3>:
80107b8e:	55                   	push   %ebp
80107b8f:	89 e5                	mov    %esp,%ebp
80107b91:	8b 45 08             	mov    0x8(%ebp),%eax
80107b94:	0f 22 d8             	mov    %eax,%cr3
80107b97:	90                   	nop
80107b98:	5d                   	pop    %ebp
80107b99:	c3                   	ret    

80107b9a <seginit>:
80107b9a:	55                   	push   %ebp
80107b9b:	89 e5                	mov    %esp,%ebp
80107b9d:	53                   	push   %ebx
80107b9e:	83 ec 14             	sub    $0x14,%esp
80107ba1:	e8 45 b4 ff ff       	call   80102feb <cpunum>
80107ba6:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107bac:	05 20 48 11 80       	add    $0x80114820,%eax
80107bb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb7:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc0:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc9:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107bd4:	83 e2 f0             	and    $0xfffffff0,%edx
80107bd7:	83 ca 0a             	or     $0xa,%edx
80107bda:	88 50 7d             	mov    %dl,0x7d(%eax)
80107bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107be4:	83 ca 10             	or     $0x10,%edx
80107be7:	88 50 7d             	mov    %dl,0x7d(%eax)
80107bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bed:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107bf1:	83 e2 9f             	and    $0xffffff9f,%edx
80107bf4:	88 50 7d             	mov    %dl,0x7d(%eax)
80107bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bfa:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107bfe:	83 ca 80             	or     $0xffffff80,%edx
80107c01:	88 50 7d             	mov    %dl,0x7d(%eax)
80107c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c07:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c0b:	83 ca 0f             	or     $0xf,%edx
80107c0e:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c14:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c18:	83 e2 ef             	and    $0xffffffef,%edx
80107c1b:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c21:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c25:	83 e2 df             	and    $0xffffffdf,%edx
80107c28:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c2e:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c32:	83 ca 40             	or     $0x40,%edx
80107c35:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c3b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c3f:	83 ca 80             	or     $0xffffff80,%edx
80107c42:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c48:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
80107c4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4f:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107c56:	ff ff 
80107c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c5b:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107c62:	00 00 
80107c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c67:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c71:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107c78:	83 e2 f0             	and    $0xfffffff0,%edx
80107c7b:	83 ca 02             	or     $0x2,%edx
80107c7e:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107c84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c87:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107c8e:	83 ca 10             	or     $0x10,%edx
80107c91:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c9a:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107ca1:	83 e2 9f             	and    $0xffffff9f,%edx
80107ca4:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cad:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107cb4:	83 ca 80             	or     $0xffffff80,%edx
80107cb7:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc0:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107cc7:	83 ca 0f             	or     $0xf,%edx
80107cca:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cd3:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107cda:	83 e2 ef             	and    $0xffffffef,%edx
80107cdd:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ce6:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107ced:	83 e2 df             	and    $0xffffffdf,%edx
80107cf0:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107cf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cf9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d00:	83 ca 40             	or     $0x40,%edx
80107d03:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d0c:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d13:	83 ca 80             	or     $0xffffff80,%edx
80107d16:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d1f:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
80107d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d29:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107d30:	ff ff 
80107d32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d35:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107d3c:	00 00 
80107d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d41:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d4b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d52:	83 e2 f0             	and    $0xfffffff0,%edx
80107d55:	83 ca 0a             	or     $0xa,%edx
80107d58:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d61:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d68:	83 ca 10             	or     $0x10,%edx
80107d6b:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d74:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d7b:	83 ca 60             	or     $0x60,%edx
80107d7e:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d87:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d8e:	83 ca 80             	or     $0xffffff80,%edx
80107d91:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107da1:	83 ca 0f             	or     $0xf,%edx
80107da4:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dad:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107db4:	83 e2 ef             	and    $0xffffffef,%edx
80107db7:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107dbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc0:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107dc7:	83 e2 df             	and    $0xffffffdf,%edx
80107dca:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107dd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd3:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107dda:	83 ca 40             	or     $0x40,%edx
80107ddd:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107de3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107de6:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ded:	83 ca 80             	or     $0xffffff80,%edx
80107df0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107df9:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
80107e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e03:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107e0a:	ff ff 
80107e0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e0f:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107e16:	00 00 
80107e18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e1b:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107e22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e25:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e2c:	83 e2 f0             	and    $0xfffffff0,%edx
80107e2f:	83 ca 02             	or     $0x2,%edx
80107e32:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3b:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e42:	83 ca 10             	or     $0x10,%edx
80107e45:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e4e:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e55:	83 ca 60             	or     $0x60,%edx
80107e58:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e61:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e68:	83 ca 80             	or     $0xffffff80,%edx
80107e6b:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e74:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107e7b:	83 ca 0f             	or     $0xf,%edx
80107e7e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107e84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e87:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107e8e:	83 e2 ef             	and    $0xffffffef,%edx
80107e91:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107e97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e9a:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ea1:	83 e2 df             	and    $0xffffffdf,%edx
80107ea4:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ead:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107eb4:	83 ca 40             	or     $0x40,%edx
80107eb7:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec0:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ec7:	83 ca 80             	or     $0xffffff80,%edx
80107eca:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ed0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed3:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
80107eda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107edd:	05 b4 00 00 00       	add    $0xb4,%eax
80107ee2:	89 c3                	mov    %eax,%ebx
80107ee4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ee7:	05 b4 00 00 00       	add    $0xb4,%eax
80107eec:	c1 e8 10             	shr    $0x10,%eax
80107eef:	89 c2                	mov    %eax,%edx
80107ef1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef4:	05 b4 00 00 00       	add    $0xb4,%eax
80107ef9:	c1 e8 18             	shr    $0x18,%eax
80107efc:	89 c1                	mov    %eax,%ecx
80107efe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f01:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107f08:	00 00 
80107f0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f0d:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107f14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f17:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107f1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f20:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f27:	83 e2 f0             	and    $0xfffffff0,%edx
80107f2a:	83 ca 02             	or     $0x2,%edx
80107f2d:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f36:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f3d:	83 ca 10             	or     $0x10,%edx
80107f40:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f49:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f50:	83 e2 9f             	and    $0xffffff9f,%edx
80107f53:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f5c:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f63:	83 ca 80             	or     $0xffffff80,%edx
80107f66:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f6f:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107f76:	83 e2 f0             	and    $0xfffffff0,%edx
80107f79:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107f7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f82:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107f89:	83 e2 ef             	and    $0xffffffef,%edx
80107f8c:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107f92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f95:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107f9c:	83 e2 df             	and    $0xffffffdf,%edx
80107f9f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fa8:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107faf:	83 ca 40             	or     $0x40,%edx
80107fb2:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fbb:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107fc2:	83 ca 80             	or     $0xffffff80,%edx
80107fc5:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fce:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
80107fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd7:	83 c0 70             	add    $0x70,%eax
80107fda:	83 ec 08             	sub    $0x8,%esp
80107fdd:	6a 38                	push   $0x38
80107fdf:	50                   	push   %eax
80107fe0:	e8 52 fb ff ff       	call   80107b37 <lgdt>
80107fe5:	83 c4 10             	add    $0x10,%esp
80107fe8:	83 ec 0c             	sub    $0xc,%esp
80107feb:	6a 18                	push   $0x18
80107fed:	e8 86 fb ff ff       	call   80107b78 <loadgs>
80107ff2:	83 c4 10             	add    $0x10,%esp
80107ff5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ff8:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
80107ffe:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80108005:	00 00 00 00 
80108009:	90                   	nop
8010800a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010800d:	c9                   	leave  
8010800e:	c3                   	ret    

8010800f <walkpgdir>:
8010800f:	55                   	push   %ebp
80108010:	89 e5                	mov    %esp,%ebp
80108012:	83 ec 18             	sub    $0x18,%esp
80108015:	8b 45 0c             	mov    0xc(%ebp),%eax
80108018:	c1 e8 16             	shr    $0x16,%eax
8010801b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108022:	8b 45 08             	mov    0x8(%ebp),%eax
80108025:	01 d0                	add    %edx,%eax
80108027:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010802a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010802d:	8b 00                	mov    (%eax),%eax
8010802f:	83 e0 01             	and    $0x1,%eax
80108032:	85 c0                	test   %eax,%eax
80108034:	74 14                	je     8010804a <walkpgdir+0x3b>
80108036:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108039:	8b 00                	mov    (%eax),%eax
8010803b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108040:	05 00 00 00 80       	add    $0x80000000,%eax
80108045:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108048:	eb 42                	jmp    8010808c <walkpgdir+0x7d>
8010804a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010804e:	74 0e                	je     8010805e <walkpgdir+0x4f>
80108050:	e8 f7 ab ff ff       	call   80102c4c <kalloc>
80108055:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108058:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010805c:	75 07                	jne    80108065 <walkpgdir+0x56>
8010805e:	b8 00 00 00 00       	mov    $0x0,%eax
80108063:	eb 3e                	jmp    801080a3 <walkpgdir+0x94>
80108065:	83 ec 04             	sub    $0x4,%esp
80108068:	68 00 10 00 00       	push   $0x1000
8010806d:	6a 00                	push   $0x0
8010806f:	ff 75 f4             	pushl  -0xc(%ebp)
80108072:	e8 d5 d2 ff ff       	call   8010534c <memset>
80108077:	83 c4 10             	add    $0x10,%esp
8010807a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010807d:	05 00 00 00 80       	add    $0x80000000,%eax
80108082:	83 c8 07             	or     $0x7,%eax
80108085:	89 c2                	mov    %eax,%edx
80108087:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010808a:	89 10                	mov    %edx,(%eax)
8010808c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010808f:	c1 e8 0c             	shr    $0xc,%eax
80108092:	25 ff 03 00 00       	and    $0x3ff,%eax
80108097:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010809e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a1:	01 d0                	add    %edx,%eax
801080a3:	c9                   	leave  
801080a4:	c3                   	ret    

801080a5 <mappages>:
801080a5:	55                   	push   %ebp
801080a6:	89 e5                	mov    %esp,%ebp
801080a8:	83 ec 18             	sub    $0x18,%esp
801080ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801080ae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801080b6:	8b 55 0c             	mov    0xc(%ebp),%edx
801080b9:	8b 45 10             	mov    0x10(%ebp),%eax
801080bc:	01 d0                	add    %edx,%eax
801080be:	83 e8 01             	sub    $0x1,%eax
801080c1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801080c9:	83 ec 04             	sub    $0x4,%esp
801080cc:	6a 01                	push   $0x1
801080ce:	ff 75 f4             	pushl  -0xc(%ebp)
801080d1:	ff 75 08             	pushl  0x8(%ebp)
801080d4:	e8 36 ff ff ff       	call   8010800f <walkpgdir>
801080d9:	83 c4 10             	add    $0x10,%esp
801080dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
801080df:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080e3:	75 07                	jne    801080ec <mappages+0x47>
801080e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801080ea:	eb 47                	jmp    80108133 <mappages+0x8e>
801080ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080ef:	8b 00                	mov    (%eax),%eax
801080f1:	83 e0 01             	and    $0x1,%eax
801080f4:	85 c0                	test   %eax,%eax
801080f6:	74 0d                	je     80108105 <mappages+0x60>
801080f8:	83 ec 0c             	sub    $0xc,%esp
801080fb:	68 78 90 10 80       	push   $0x80109078
80108100:	e8 93 84 ff ff       	call   80100598 <panic>
80108105:	8b 45 18             	mov    0x18(%ebp),%eax
80108108:	0b 45 14             	or     0x14(%ebp),%eax
8010810b:	83 c8 01             	or     $0x1,%eax
8010810e:	89 c2                	mov    %eax,%edx
80108110:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108113:	89 10                	mov    %edx,(%eax)
80108115:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108118:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010811b:	74 10                	je     8010812d <mappages+0x88>
8010811d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108124:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
8010812b:	eb 9c                	jmp    801080c9 <mappages+0x24>
8010812d:	90                   	nop
8010812e:	b8 00 00 00 00       	mov    $0x0,%eax
80108133:	c9                   	leave  
80108134:	c3                   	ret    

80108135 <setupkvm>:
80108135:	55                   	push   %ebp
80108136:	89 e5                	mov    %esp,%ebp
80108138:	53                   	push   %ebx
80108139:	83 ec 14             	sub    $0x14,%esp
8010813c:	e8 0b ab ff ff       	call   80102c4c <kalloc>
80108141:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108144:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108148:	75 07                	jne    80108151 <setupkvm+0x1c>
8010814a:	b8 00 00 00 00       	mov    $0x0,%eax
8010814f:	eb 6a                	jmp    801081bb <setupkvm+0x86>
80108151:	83 ec 04             	sub    $0x4,%esp
80108154:	68 00 10 00 00       	push   $0x1000
80108159:	6a 00                	push   $0x0
8010815b:	ff 75 f0             	pushl  -0x10(%ebp)
8010815e:	e8 e9 d1 ff ff       	call   8010534c <memset>
80108163:	83 c4 10             	add    $0x10,%esp
80108166:	c7 45 f4 a0 c4 10 80 	movl   $0x8010c4a0,-0xc(%ebp)
8010816d:	eb 40                	jmp    801081af <setupkvm+0x7a>
8010816f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108172:	8b 48 0c             	mov    0xc(%eax),%ecx
80108175:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108178:	8b 50 04             	mov    0x4(%eax),%edx
8010817b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010817e:	8b 58 08             	mov    0x8(%eax),%ebx
80108181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108184:	8b 40 04             	mov    0x4(%eax),%eax
80108187:	29 c3                	sub    %eax,%ebx
80108189:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010818c:	8b 00                	mov    (%eax),%eax
8010818e:	83 ec 0c             	sub    $0xc,%esp
80108191:	51                   	push   %ecx
80108192:	52                   	push   %edx
80108193:	53                   	push   %ebx
80108194:	50                   	push   %eax
80108195:	ff 75 f0             	pushl  -0x10(%ebp)
80108198:	e8 08 ff ff ff       	call   801080a5 <mappages>
8010819d:	83 c4 20             	add    $0x20,%esp
801081a0:	85 c0                	test   %eax,%eax
801081a2:	79 07                	jns    801081ab <setupkvm+0x76>
801081a4:	b8 00 00 00 00       	mov    $0x0,%eax
801081a9:	eb 10                	jmp    801081bb <setupkvm+0x86>
801081ab:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801081af:	81 7d f4 e0 c4 10 80 	cmpl   $0x8010c4e0,-0xc(%ebp)
801081b6:	72 b7                	jb     8010816f <setupkvm+0x3a>
801081b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801081be:	c9                   	leave  
801081bf:	c3                   	ret    

801081c0 <kvmalloc>:
801081c0:	55                   	push   %ebp
801081c1:	89 e5                	mov    %esp,%ebp
801081c3:	83 ec 08             	sub    $0x8,%esp
801081c6:	e8 6a ff ff ff       	call   80108135 <setupkvm>
801081cb:	a3 a4 76 11 80       	mov    %eax,0x801176a4
801081d0:	e8 03 00 00 00       	call   801081d8 <switchkvm>
801081d5:	90                   	nop
801081d6:	c9                   	leave  
801081d7:	c3                   	ret    

801081d8 <switchkvm>:
801081d8:	55                   	push   %ebp
801081d9:	89 e5                	mov    %esp,%ebp
801081db:	a1 a4 76 11 80       	mov    0x801176a4,%eax
801081e0:	05 00 00 00 80       	add    $0x80000000,%eax
801081e5:	50                   	push   %eax
801081e6:	e8 a3 f9 ff ff       	call   80107b8e <lcr3>
801081eb:	83 c4 04             	add    $0x4,%esp
801081ee:	90                   	nop
801081ef:	c9                   	leave  
801081f0:	c3                   	ret    

801081f1 <switchuvm>:
801081f1:	55                   	push   %ebp
801081f2:	89 e5                	mov    %esp,%ebp
801081f4:	56                   	push   %esi
801081f5:	53                   	push   %ebx
801081f6:	e8 39 d0 ff ff       	call   80105234 <pushcli>
801081fb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108201:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108208:	83 c2 08             	add    $0x8,%edx
8010820b:	89 d6                	mov    %edx,%esi
8010820d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108214:	83 c2 08             	add    $0x8,%edx
80108217:	c1 ea 10             	shr    $0x10,%edx
8010821a:	89 d3                	mov    %edx,%ebx
8010821c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108223:	83 c2 08             	add    $0x8,%edx
80108226:	c1 ea 18             	shr    $0x18,%edx
80108229:	89 d1                	mov    %edx,%ecx
8010822b:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108232:	67 00 
80108234:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
8010823b:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80108241:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80108248:	83 e2 f0             	and    $0xfffffff0,%edx
8010824b:	83 ca 09             	or     $0x9,%edx
8010824e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108254:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010825b:	83 ca 10             	or     $0x10,%edx
8010825e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108264:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010826b:	83 e2 9f             	and    $0xffffff9f,%edx
8010826e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108274:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010827b:	83 ca 80             	or     $0xffffff80,%edx
8010827e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108284:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010828b:	83 e2 f0             	and    $0xfffffff0,%edx
8010828e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108294:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010829b:	83 e2 ef             	and    $0xffffffef,%edx
8010829e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082a4:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801082ab:	83 e2 df             	and    $0xffffffdf,%edx
801082ae:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082b4:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801082bb:	83 ca 40             	or     $0x40,%edx
801082be:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082c4:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801082cb:	83 e2 7f             	and    $0x7f,%edx
801082ce:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082d4:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
801082da:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801082e0:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801082e7:	83 e2 ef             	and    $0xffffffef,%edx
801082ea:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801082f0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801082f6:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
801082fc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108302:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80108309:	8b 52 08             	mov    0x8(%edx),%edx
8010830c:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108312:	89 50 0c             	mov    %edx,0xc(%eax)
80108315:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010831b:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
80108321:	83 ec 0c             	sub    $0xc,%esp
80108324:	6a 30                	push   $0x30
80108326:	e8 36 f8 ff ff       	call   80107b61 <ltr>
8010832b:	83 c4 10             	add    $0x10,%esp
8010832e:	8b 45 08             	mov    0x8(%ebp),%eax
80108331:	8b 40 04             	mov    0x4(%eax),%eax
80108334:	85 c0                	test   %eax,%eax
80108336:	75 0d                	jne    80108345 <switchuvm+0x154>
80108338:	83 ec 0c             	sub    $0xc,%esp
8010833b:	68 7e 90 10 80       	push   $0x8010907e
80108340:	e8 53 82 ff ff       	call   80100598 <panic>
80108345:	8b 45 08             	mov    0x8(%ebp),%eax
80108348:	8b 40 04             	mov    0x4(%eax),%eax
8010834b:	05 00 00 00 80       	add    $0x80000000,%eax
80108350:	83 ec 0c             	sub    $0xc,%esp
80108353:	50                   	push   %eax
80108354:	e8 35 f8 ff ff       	call   80107b8e <lcr3>
80108359:	83 c4 10             	add    $0x10,%esp
8010835c:	e8 2a cf ff ff       	call   8010528b <popcli>
80108361:	90                   	nop
80108362:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108365:	5b                   	pop    %ebx
80108366:	5e                   	pop    %esi
80108367:	5d                   	pop    %ebp
80108368:	c3                   	ret    

80108369 <inituvm>:
80108369:	55                   	push   %ebp
8010836a:	89 e5                	mov    %esp,%ebp
8010836c:	83 ec 18             	sub    $0x18,%esp
8010836f:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108376:	76 0d                	jbe    80108385 <inituvm+0x1c>
80108378:	83 ec 0c             	sub    $0xc,%esp
8010837b:	68 92 90 10 80       	push   $0x80109092
80108380:	e8 13 82 ff ff       	call   80100598 <panic>
80108385:	e8 c2 a8 ff ff       	call   80102c4c <kalloc>
8010838a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010838d:	83 ec 04             	sub    $0x4,%esp
80108390:	68 00 10 00 00       	push   $0x1000
80108395:	6a 00                	push   $0x0
80108397:	ff 75 f4             	pushl  -0xc(%ebp)
8010839a:	e8 ad cf ff ff       	call   8010534c <memset>
8010839f:	83 c4 10             	add    $0x10,%esp
801083a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083a5:	05 00 00 00 80       	add    $0x80000000,%eax
801083aa:	83 ec 0c             	sub    $0xc,%esp
801083ad:	6a 06                	push   $0x6
801083af:	50                   	push   %eax
801083b0:	68 00 10 00 00       	push   $0x1000
801083b5:	6a 00                	push   $0x0
801083b7:	ff 75 08             	pushl  0x8(%ebp)
801083ba:	e8 e6 fc ff ff       	call   801080a5 <mappages>
801083bf:	83 c4 20             	add    $0x20,%esp
801083c2:	83 ec 04             	sub    $0x4,%esp
801083c5:	ff 75 10             	pushl  0x10(%ebp)
801083c8:	ff 75 0c             	pushl  0xc(%ebp)
801083cb:	ff 75 f4             	pushl  -0xc(%ebp)
801083ce:	e8 38 d0 ff ff       	call   8010540b <memmove>
801083d3:	83 c4 10             	add    $0x10,%esp
801083d6:	90                   	nop
801083d7:	c9                   	leave  
801083d8:	c3                   	ret    

801083d9 <loaduvm>:
801083d9:	55                   	push   %ebp
801083da:	89 e5                	mov    %esp,%ebp
801083dc:	83 ec 18             	sub    $0x18,%esp
801083df:	8b 45 0c             	mov    0xc(%ebp),%eax
801083e2:	25 ff 0f 00 00       	and    $0xfff,%eax
801083e7:	85 c0                	test   %eax,%eax
801083e9:	74 0d                	je     801083f8 <loaduvm+0x1f>
801083eb:	83 ec 0c             	sub    $0xc,%esp
801083ee:	68 ac 90 10 80       	push   $0x801090ac
801083f3:	e8 a0 81 ff ff       	call   80100598 <panic>
801083f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801083ff:	e9 8f 00 00 00       	jmp    80108493 <loaduvm+0xba>
80108404:	8b 55 0c             	mov    0xc(%ebp),%edx
80108407:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010840a:	01 d0                	add    %edx,%eax
8010840c:	83 ec 04             	sub    $0x4,%esp
8010840f:	6a 00                	push   $0x0
80108411:	50                   	push   %eax
80108412:	ff 75 08             	pushl  0x8(%ebp)
80108415:	e8 f5 fb ff ff       	call   8010800f <walkpgdir>
8010841a:	83 c4 10             	add    $0x10,%esp
8010841d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108420:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108424:	75 0d                	jne    80108433 <loaduvm+0x5a>
80108426:	83 ec 0c             	sub    $0xc,%esp
80108429:	68 cf 90 10 80       	push   $0x801090cf
8010842e:	e8 65 81 ff ff       	call   80100598 <panic>
80108433:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108436:	8b 00                	mov    (%eax),%eax
80108438:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010843d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108440:	8b 45 18             	mov    0x18(%ebp),%eax
80108443:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108446:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010844b:	77 0b                	ja     80108458 <loaduvm+0x7f>
8010844d:	8b 45 18             	mov    0x18(%ebp),%eax
80108450:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108453:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108456:	eb 07                	jmp    8010845f <loaduvm+0x86>
80108458:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
8010845f:	8b 55 14             	mov    0x14(%ebp),%edx
80108462:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108465:	01 d0                	add    %edx,%eax
80108467:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010846a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80108470:	ff 75 f0             	pushl  -0x10(%ebp)
80108473:	50                   	push   %eax
80108474:	52                   	push   %edx
80108475:	ff 75 10             	pushl  0x10(%ebp)
80108478:	e8 ef 99 ff ff       	call   80101e6c <readi>
8010847d:	83 c4 10             	add    $0x10,%esp
80108480:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108483:	74 07                	je     8010848c <loaduvm+0xb3>
80108485:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010848a:	eb 18                	jmp    801084a4 <loaduvm+0xcb>
8010848c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108493:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108496:	3b 45 18             	cmp    0x18(%ebp),%eax
80108499:	0f 82 65 ff ff ff    	jb     80108404 <loaduvm+0x2b>
8010849f:	b8 00 00 00 00       	mov    $0x0,%eax
801084a4:	c9                   	leave  
801084a5:	c3                   	ret    

801084a6 <allocuvm>:
801084a6:	55                   	push   %ebp
801084a7:	89 e5                	mov    %esp,%ebp
801084a9:	83 ec 18             	sub    $0x18,%esp
801084ac:	8b 45 10             	mov    0x10(%ebp),%eax
801084af:	85 c0                	test   %eax,%eax
801084b1:	79 0a                	jns    801084bd <allocuvm+0x17>
801084b3:	b8 00 00 00 00       	mov    $0x0,%eax
801084b8:	e9 ec 00 00 00       	jmp    801085a9 <allocuvm+0x103>
801084bd:	8b 45 10             	mov    0x10(%ebp),%eax
801084c0:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084c3:	73 08                	jae    801084cd <allocuvm+0x27>
801084c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801084c8:	e9 dc 00 00 00       	jmp    801085a9 <allocuvm+0x103>
801084cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801084d0:	05 ff 0f 00 00       	add    $0xfff,%eax
801084d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084da:	89 45 f4             	mov    %eax,-0xc(%ebp)
801084dd:	e9 b8 00 00 00       	jmp    8010859a <allocuvm+0xf4>
801084e2:	e8 65 a7 ff ff       	call   80102c4c <kalloc>
801084e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801084ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801084ee:	75 2e                	jne    8010851e <allocuvm+0x78>
801084f0:	83 ec 0c             	sub    $0xc,%esp
801084f3:	68 ed 90 10 80       	push   $0x801090ed
801084f8:	e8 01 7f ff ff       	call   801003fe <cprintf>
801084fd:	83 c4 10             	add    $0x10,%esp
80108500:	83 ec 04             	sub    $0x4,%esp
80108503:	ff 75 0c             	pushl  0xc(%ebp)
80108506:	ff 75 10             	pushl  0x10(%ebp)
80108509:	ff 75 08             	pushl  0x8(%ebp)
8010850c:	e8 9a 00 00 00       	call   801085ab <deallocuvm>
80108511:	83 c4 10             	add    $0x10,%esp
80108514:	b8 00 00 00 00       	mov    $0x0,%eax
80108519:	e9 8b 00 00 00       	jmp    801085a9 <allocuvm+0x103>
8010851e:	83 ec 04             	sub    $0x4,%esp
80108521:	68 00 10 00 00       	push   $0x1000
80108526:	6a 00                	push   $0x0
80108528:	ff 75 f0             	pushl  -0x10(%ebp)
8010852b:	e8 1c ce ff ff       	call   8010534c <memset>
80108530:	83 c4 10             	add    $0x10,%esp
80108533:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108536:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
8010853c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010853f:	83 ec 0c             	sub    $0xc,%esp
80108542:	6a 06                	push   $0x6
80108544:	52                   	push   %edx
80108545:	68 00 10 00 00       	push   $0x1000
8010854a:	50                   	push   %eax
8010854b:	ff 75 08             	pushl  0x8(%ebp)
8010854e:	e8 52 fb ff ff       	call   801080a5 <mappages>
80108553:	83 c4 20             	add    $0x20,%esp
80108556:	85 c0                	test   %eax,%eax
80108558:	79 39                	jns    80108593 <allocuvm+0xed>
8010855a:	83 ec 0c             	sub    $0xc,%esp
8010855d:	68 05 91 10 80       	push   $0x80109105
80108562:	e8 97 7e ff ff       	call   801003fe <cprintf>
80108567:	83 c4 10             	add    $0x10,%esp
8010856a:	83 ec 04             	sub    $0x4,%esp
8010856d:	ff 75 0c             	pushl  0xc(%ebp)
80108570:	ff 75 10             	pushl  0x10(%ebp)
80108573:	ff 75 08             	pushl  0x8(%ebp)
80108576:	e8 30 00 00 00       	call   801085ab <deallocuvm>
8010857b:	83 c4 10             	add    $0x10,%esp
8010857e:	83 ec 0c             	sub    $0xc,%esp
80108581:	ff 75 f0             	pushl  -0x10(%ebp)
80108584:	e8 29 a6 ff ff       	call   80102bb2 <kfree>
80108589:	83 c4 10             	add    $0x10,%esp
8010858c:	b8 00 00 00 00       	mov    $0x0,%eax
80108591:	eb 16                	jmp    801085a9 <allocuvm+0x103>
80108593:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010859a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010859d:	3b 45 10             	cmp    0x10(%ebp),%eax
801085a0:	0f 82 3c ff ff ff    	jb     801084e2 <allocuvm+0x3c>
801085a6:	8b 45 10             	mov    0x10(%ebp),%eax
801085a9:	c9                   	leave  
801085aa:	c3                   	ret    

801085ab <deallocuvm>:
801085ab:	55                   	push   %ebp
801085ac:	89 e5                	mov    %esp,%ebp
801085ae:	83 ec 18             	sub    $0x18,%esp
801085b1:	8b 45 10             	mov    0x10(%ebp),%eax
801085b4:	3b 45 0c             	cmp    0xc(%ebp),%eax
801085b7:	72 08                	jb     801085c1 <deallocuvm+0x16>
801085b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801085bc:	e9 82 00 00 00       	jmp    80108643 <deallocuvm+0x98>
801085c1:	8b 45 10             	mov    0x10(%ebp),%eax
801085c4:	05 ff 0f 00 00       	add    $0xfff,%eax
801085c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801085d1:	eb 65                	jmp    80108638 <deallocuvm+0x8d>
801085d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d6:	83 ec 04             	sub    $0x4,%esp
801085d9:	6a 00                	push   $0x0
801085db:	50                   	push   %eax
801085dc:	ff 75 08             	pushl  0x8(%ebp)
801085df:	e8 2b fa ff ff       	call   8010800f <walkpgdir>
801085e4:	83 c4 10             	add    $0x10,%esp
801085e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801085ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801085ee:	74 41                	je     80108631 <deallocuvm+0x86>
801085f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085f3:	8b 00                	mov    (%eax),%eax
801085f5:	83 e0 01             	and    $0x1,%eax
801085f8:	85 c0                	test   %eax,%eax
801085fa:	74 35                	je     80108631 <deallocuvm+0x86>
801085fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085ff:	8b 00                	mov    (%eax),%eax
80108601:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108606:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108609:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010860d:	74 22                	je     80108631 <deallocuvm+0x86>
8010860f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108612:	05 00 00 00 80       	add    $0x80000000,%eax
80108617:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010861a:	83 ec 0c             	sub    $0xc,%esp
8010861d:	ff 75 e8             	pushl  -0x18(%ebp)
80108620:	e8 8d a5 ff ff       	call   80102bb2 <kfree>
80108625:	83 c4 10             	add    $0x10,%esp
80108628:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010862b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80108631:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108638:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010863b:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010863e:	72 93                	jb     801085d3 <deallocuvm+0x28>
80108640:	8b 45 10             	mov    0x10(%ebp),%eax
80108643:	c9                   	leave  
80108644:	c3                   	ret    

80108645 <freevm>:
80108645:	55                   	push   %ebp
80108646:	89 e5                	mov    %esp,%ebp
80108648:	83 ec 18             	sub    $0x18,%esp
8010864b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010864f:	75 0d                	jne    8010865e <freevm+0x19>
80108651:	83 ec 0c             	sub    $0xc,%esp
80108654:	68 21 91 10 80       	push   $0x80109121
80108659:	e8 3a 7f ff ff       	call   80100598 <panic>
8010865e:	83 ec 04             	sub    $0x4,%esp
80108661:	6a 00                	push   $0x0
80108663:	68 00 00 00 80       	push   $0x80000000
80108668:	ff 75 08             	pushl  0x8(%ebp)
8010866b:	e8 3b ff ff ff       	call   801085ab <deallocuvm>
80108670:	83 c4 10             	add    $0x10,%esp
80108673:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010867a:	eb 48                	jmp    801086c4 <freevm+0x7f>
8010867c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010867f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108686:	8b 45 08             	mov    0x8(%ebp),%eax
80108689:	01 d0                	add    %edx,%eax
8010868b:	8b 00                	mov    (%eax),%eax
8010868d:	83 e0 01             	and    $0x1,%eax
80108690:	85 c0                	test   %eax,%eax
80108692:	74 2c                	je     801086c0 <freevm+0x7b>
80108694:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108697:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010869e:	8b 45 08             	mov    0x8(%ebp),%eax
801086a1:	01 d0                	add    %edx,%eax
801086a3:	8b 00                	mov    (%eax),%eax
801086a5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086aa:	05 00 00 00 80       	add    $0x80000000,%eax
801086af:	89 45 f0             	mov    %eax,-0x10(%ebp)
801086b2:	83 ec 0c             	sub    $0xc,%esp
801086b5:	ff 75 f0             	pushl  -0x10(%ebp)
801086b8:	e8 f5 a4 ff ff       	call   80102bb2 <kfree>
801086bd:	83 c4 10             	add    $0x10,%esp
801086c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801086c4:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801086cb:	76 af                	jbe    8010867c <freevm+0x37>
801086cd:	83 ec 0c             	sub    $0xc,%esp
801086d0:	ff 75 08             	pushl  0x8(%ebp)
801086d3:	e8 da a4 ff ff       	call   80102bb2 <kfree>
801086d8:	83 c4 10             	add    $0x10,%esp
801086db:	90                   	nop
801086dc:	c9                   	leave  
801086dd:	c3                   	ret    

801086de <clearpteu>:
801086de:	55                   	push   %ebp
801086df:	89 e5                	mov    %esp,%ebp
801086e1:	83 ec 18             	sub    $0x18,%esp
801086e4:	83 ec 04             	sub    $0x4,%esp
801086e7:	6a 00                	push   $0x0
801086e9:	ff 75 0c             	pushl  0xc(%ebp)
801086ec:	ff 75 08             	pushl  0x8(%ebp)
801086ef:	e8 1b f9 ff ff       	call   8010800f <walkpgdir>
801086f4:	83 c4 10             	add    $0x10,%esp
801086f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801086fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801086fe:	75 0d                	jne    8010870d <clearpteu+0x2f>
80108700:	83 ec 0c             	sub    $0xc,%esp
80108703:	68 32 91 10 80       	push   $0x80109132
80108708:	e8 8b 7e ff ff       	call   80100598 <panic>
8010870d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108710:	8b 00                	mov    (%eax),%eax
80108712:	83 e0 fb             	and    $0xfffffffb,%eax
80108715:	89 c2                	mov    %eax,%edx
80108717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010871a:	89 10                	mov    %edx,(%eax)
8010871c:	90                   	nop
8010871d:	c9                   	leave  
8010871e:	c3                   	ret    

8010871f <copyuvm>:
8010871f:	55                   	push   %ebp
80108720:	89 e5                	mov    %esp,%ebp
80108722:	83 ec 28             	sub    $0x28,%esp
80108725:	e8 0b fa ff ff       	call   80108135 <setupkvm>
8010872a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010872d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108731:	75 0a                	jne    8010873d <copyuvm+0x1e>
80108733:	b8 00 00 00 00       	mov    $0x0,%eax
80108738:	e9 de 00 00 00       	jmp    8010881b <copyuvm+0xfc>
8010873d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108744:	e9 aa 00 00 00       	jmp    801087f3 <copyuvm+0xd4>
80108749:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010874c:	83 ec 04             	sub    $0x4,%esp
8010874f:	6a 00                	push   $0x0
80108751:	50                   	push   %eax
80108752:	ff 75 08             	pushl  0x8(%ebp)
80108755:	e8 b5 f8 ff ff       	call   8010800f <walkpgdir>
8010875a:	83 c4 10             	add    $0x10,%esp
8010875d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108760:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108764:	75 0d                	jne    80108773 <copyuvm+0x54>
80108766:	83 ec 0c             	sub    $0xc,%esp
80108769:	68 3c 91 10 80       	push   $0x8010913c
8010876e:	e8 25 7e ff ff       	call   80100598 <panic>
80108773:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108776:	8b 00                	mov    (%eax),%eax
80108778:	83 e0 01             	and    $0x1,%eax
8010877b:	85 c0                	test   %eax,%eax
8010877d:	74 6d                	je     801087ec <copyuvm+0xcd>
8010877f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108782:	8b 00                	mov    (%eax),%eax
80108784:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108789:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010878c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010878f:	8b 00                	mov    (%eax),%eax
80108791:	25 ff 0f 00 00       	and    $0xfff,%eax
80108796:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108799:	e8 ae a4 ff ff       	call   80102c4c <kalloc>
8010879e:	89 45 e0             	mov    %eax,-0x20(%ebp)
801087a1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801087a5:	74 5d                	je     80108804 <copyuvm+0xe5>
801087a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801087aa:	05 00 00 00 80       	add    $0x80000000,%eax
801087af:	83 ec 04             	sub    $0x4,%esp
801087b2:	68 00 10 00 00       	push   $0x1000
801087b7:	50                   	push   %eax
801087b8:	ff 75 e0             	pushl  -0x20(%ebp)
801087bb:	e8 4b cc ff ff       	call   8010540b <memmove>
801087c0:	83 c4 10             	add    $0x10,%esp
801087c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801087c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801087c9:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801087cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087d2:	83 ec 0c             	sub    $0xc,%esp
801087d5:	52                   	push   %edx
801087d6:	51                   	push   %ecx
801087d7:	68 00 10 00 00       	push   $0x1000
801087dc:	50                   	push   %eax
801087dd:	ff 75 f0             	pushl  -0x10(%ebp)
801087e0:	e8 c0 f8 ff ff       	call   801080a5 <mappages>
801087e5:	83 c4 20             	add    $0x20,%esp
801087e8:	85 c0                	test   %eax,%eax
801087ea:	78 1b                	js     80108807 <copyuvm+0xe8>
801087ec:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801087f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087f6:	3b 45 0c             	cmp    0xc(%ebp),%eax
801087f9:	0f 82 4a ff ff ff    	jb     80108749 <copyuvm+0x2a>
801087ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108802:	eb 17                	jmp    8010881b <copyuvm+0xfc>
80108804:	90                   	nop
80108805:	eb 01                	jmp    80108808 <copyuvm+0xe9>
80108807:	90                   	nop
80108808:	83 ec 0c             	sub    $0xc,%esp
8010880b:	ff 75 f0             	pushl  -0x10(%ebp)
8010880e:	e8 32 fe ff ff       	call   80108645 <freevm>
80108813:	83 c4 10             	add    $0x10,%esp
80108816:	b8 00 00 00 00       	mov    $0x0,%eax
8010881b:	c9                   	leave  
8010881c:	c3                   	ret    

8010881d <uva2ka>:
8010881d:	55                   	push   %ebp
8010881e:	89 e5                	mov    %esp,%ebp
80108820:	83 ec 18             	sub    $0x18,%esp
80108823:	83 ec 04             	sub    $0x4,%esp
80108826:	6a 00                	push   $0x0
80108828:	ff 75 0c             	pushl  0xc(%ebp)
8010882b:	ff 75 08             	pushl  0x8(%ebp)
8010882e:	e8 dc f7 ff ff       	call   8010800f <walkpgdir>
80108833:	83 c4 10             	add    $0x10,%esp
80108836:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108839:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010883c:	8b 00                	mov    (%eax),%eax
8010883e:	83 e0 01             	and    $0x1,%eax
80108841:	85 c0                	test   %eax,%eax
80108843:	75 07                	jne    8010884c <uva2ka+0x2f>
80108845:	b8 00 00 00 00       	mov    $0x0,%eax
8010884a:	eb 22                	jmp    8010886e <uva2ka+0x51>
8010884c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010884f:	8b 00                	mov    (%eax),%eax
80108851:	83 e0 04             	and    $0x4,%eax
80108854:	85 c0                	test   %eax,%eax
80108856:	75 07                	jne    8010885f <uva2ka+0x42>
80108858:	b8 00 00 00 00       	mov    $0x0,%eax
8010885d:	eb 0f                	jmp    8010886e <uva2ka+0x51>
8010885f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108862:	8b 00                	mov    (%eax),%eax
80108864:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108869:	05 00 00 00 80       	add    $0x80000000,%eax
8010886e:	c9                   	leave  
8010886f:	c3                   	ret    

80108870 <copyout>:
80108870:	55                   	push   %ebp
80108871:	89 e5                	mov    %esp,%ebp
80108873:	83 ec 18             	sub    $0x18,%esp
80108876:	8b 45 10             	mov    0x10(%ebp),%eax
80108879:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010887c:	eb 7f                	jmp    801088fd <copyout+0x8d>
8010887e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108881:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108886:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108889:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010888c:	83 ec 08             	sub    $0x8,%esp
8010888f:	50                   	push   %eax
80108890:	ff 75 08             	pushl  0x8(%ebp)
80108893:	e8 85 ff ff ff       	call   8010881d <uva2ka>
80108898:	83 c4 10             	add    $0x10,%esp
8010889b:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010889e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801088a2:	75 07                	jne    801088ab <copyout+0x3b>
801088a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801088a9:	eb 61                	jmp    8010890c <copyout+0x9c>
801088ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801088ae:	2b 45 0c             	sub    0xc(%ebp),%eax
801088b1:	05 00 10 00 00       	add    $0x1000,%eax
801088b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801088b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088bc:	3b 45 14             	cmp    0x14(%ebp),%eax
801088bf:	76 06                	jbe    801088c7 <copyout+0x57>
801088c1:	8b 45 14             	mov    0x14(%ebp),%eax
801088c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801088c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801088ca:	2b 45 ec             	sub    -0x14(%ebp),%eax
801088cd:	89 c2                	mov    %eax,%edx
801088cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801088d2:	01 d0                	add    %edx,%eax
801088d4:	83 ec 04             	sub    $0x4,%esp
801088d7:	ff 75 f0             	pushl  -0x10(%ebp)
801088da:	ff 75 f4             	pushl  -0xc(%ebp)
801088dd:	50                   	push   %eax
801088de:	e8 28 cb ff ff       	call   8010540b <memmove>
801088e3:	83 c4 10             	add    $0x10,%esp
801088e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088e9:	29 45 14             	sub    %eax,0x14(%ebp)
801088ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088ef:	01 45 f4             	add    %eax,-0xc(%ebp)
801088f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801088f5:	05 00 10 00 00       	add    $0x1000,%eax
801088fa:	89 45 0c             	mov    %eax,0xc(%ebp)
801088fd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108901:	0f 85 77 ff ff ff    	jne    8010887e <copyout+0xe>
80108907:	b8 00 00 00 00       	mov    $0x0,%eax
8010890c:	c9                   	leave  
8010890d:	c3                   	ret    
