
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp
8010002d:	b8 26 38 10 80       	mov    $0x80103826,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 8c 85 10 	movl   $0x8010858c,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100049:	e8 e1 4e 00 00       	call   80104f2f <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 ac 0d 11 80 5c 	movl   $0x80110d5c,0x80110dac
80100055:	0d 11 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 b0 0d 11 80 5c 	movl   $0x80110d5c,0x80110db0
8010005f:	0d 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
80100069:	eb 46                	jmp    801000b1 <binit+0x7d>
    b->next = bcache.head.next;
8010006b:	8b 15 b0 0d 11 80    	mov    0x80110db0,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 50 5c 0d 11 80 	movl   $0x80110d5c,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	83 c0 0c             	add    $0xc,%eax
80100087:	c7 44 24 04 93 85 10 	movl   $0x80108593,0x4(%esp)
8010008e:	80 
8010008f:	89 04 24             	mov    %eax,(%esp)
80100092:	e8 5b 4d 00 00       	call   80104df2 <initsleeplock>
    bcache.head.next->prev = b;
80100097:	a1 b0 0d 11 80       	mov    0x80110db0,%eax
8010009c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010009f:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a5:	a3 b0 0d 11 80       	mov    %eax,0x80110db0

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b1:	81 7d f4 5c 0d 11 80 	cmpl   $0x80110d5c,-0xc(%ebp)
801000b8:	72 b1                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ba:	c9                   	leave  
801000bb:	c3                   	ret    

801000bc <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000bc:	55                   	push   %ebp
801000bd:	89 e5                	mov    %esp,%ebp
801000bf:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000c2:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801000c9:	e8 82 4e 00 00       	call   80104f50 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ce:	a1 b0 0d 11 80       	mov    0x80110db0,%eax
801000d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000d6:	eb 50                	jmp    80100128 <bget+0x6c>
    if(b->dev == dev && b->blockno == blockno){
801000d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000db:	8b 40 04             	mov    0x4(%eax),%eax
801000de:	3b 45 08             	cmp    0x8(%ebp),%eax
801000e1:	75 3c                	jne    8010011f <bget+0x63>
801000e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e6:	8b 40 08             	mov    0x8(%eax),%eax
801000e9:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000ec:	75 31                	jne    8010011f <bget+0x63>
      b->refcnt++;
801000ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f1:	8b 40 4c             	mov    0x4c(%eax),%eax
801000f4:	8d 50 01             	lea    0x1(%eax),%edx
801000f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fa:	89 50 4c             	mov    %edx,0x4c(%eax)
      release(&bcache.lock);
801000fd:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100104:	e8 ae 4e 00 00       	call   80104fb7 <release>
      acquiresleep(&b->lock);
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	83 c0 0c             	add    $0xc,%eax
8010010f:	89 04 24             	mov    %eax,(%esp)
80100112:	e8 15 4d 00 00       	call   80104e2c <acquiresleep>
      return b;
80100117:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011a:	e9 94 00 00 00       	jmp    801001b3 <bget+0xf7>
  struct buf *b;

  acquire(&bcache.lock);

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010011f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100122:	8b 40 54             	mov    0x54(%eax),%eax
80100125:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100128:	81 7d f4 5c 0d 11 80 	cmpl   $0x80110d5c,-0xc(%ebp)
8010012f:	75 a7                	jne    801000d8 <bget+0x1c>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100131:	a1 ac 0d 11 80       	mov    0x80110dac,%eax
80100136:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100139:	eb 63                	jmp    8010019e <bget+0xe2>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010013e:	8b 40 4c             	mov    0x4c(%eax),%eax
80100141:	85 c0                	test   %eax,%eax
80100143:	75 50                	jne    80100195 <bget+0xd9>
80100145:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100148:	8b 00                	mov    (%eax),%eax
8010014a:	83 e0 04             	and    $0x4,%eax
8010014d:	85 c0                	test   %eax,%eax
8010014f:	75 44                	jne    80100195 <bget+0xd9>
      b->dev = dev;
80100151:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100154:	8b 55 08             	mov    0x8(%ebp),%edx
80100157:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	8b 55 0c             	mov    0xc(%ebp),%edx
80100160:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      release(&bcache.lock);
80100176:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010017d:	e8 35 4e 00 00       	call   80104fb7 <release>
      acquiresleep(&b->lock);
80100182:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100185:	83 c0 0c             	add    $0xc,%eax
80100188:	89 04 24             	mov    %eax,(%esp)
8010018b:	e8 9c 4c 00 00       	call   80104e2c <acquiresleep>
      return b;
80100190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100193:	eb 1e                	jmp    801001b3 <bget+0xf7>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100198:	8b 40 50             	mov    0x50(%eax),%eax
8010019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019e:	81 7d f4 5c 0d 11 80 	cmpl   $0x80110d5c,-0xc(%ebp)
801001a5:	75 94                	jne    8010013b <bget+0x7f>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a7:	c7 04 24 9a 85 10 80 	movl   $0x8010859a,(%esp)
801001ae:	e8 af 03 00 00       	call   80100562 <panic>
}
801001b3:	c9                   	leave  
801001b4:	c3                   	ret    

801001b5 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001b5:	55                   	push   %ebp
801001b6:	89 e5                	mov    %esp,%ebp
801001b8:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801001be:	89 44 24 04          	mov    %eax,0x4(%esp)
801001c2:	8b 45 08             	mov    0x8(%ebp),%eax
801001c5:	89 04 24             	mov    %eax,(%esp)
801001c8:	e8 ef fe ff ff       	call   801000bc <bget>
801001cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d3:	8b 00                	mov    (%eax),%eax
801001d5:	83 e0 02             	and    $0x2,%eax
801001d8:	85 c0                	test   %eax,%eax
801001da:	75 0b                	jne    801001e7 <bread+0x32>
    iderw(b);
801001dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001df:	89 04 24             	mov    %eax,(%esp)
801001e2:	e8 b3 26 00 00       	call   8010289a <iderw>
  }
  return b;
801001e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001ea:	c9                   	leave  
801001eb:	c3                   	ret    

801001ec <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001ec:	55                   	push   %ebp
801001ed:	89 e5                	mov    %esp,%ebp
801001ef:	83 ec 18             	sub    $0x18,%esp
  if(!holdingsleep(&b->lock))
801001f2:	8b 45 08             	mov    0x8(%ebp),%eax
801001f5:	83 c0 0c             	add    $0xc,%eax
801001f8:	89 04 24             	mov    %eax,(%esp)
801001fb:	e8 ca 4c 00 00       	call   80104eca <holdingsleep>
80100200:	85 c0                	test   %eax,%eax
80100202:	75 0c                	jne    80100210 <bwrite+0x24>
    panic("bwrite");
80100204:	c7 04 24 ab 85 10 80 	movl   $0x801085ab,(%esp)
8010020b:	e8 52 03 00 00       	call   80100562 <panic>
  b->flags |= B_DIRTY;
80100210:	8b 45 08             	mov    0x8(%ebp),%eax
80100213:	8b 00                	mov    (%eax),%eax
80100215:	83 c8 04             	or     $0x4,%eax
80100218:	89 c2                	mov    %eax,%edx
8010021a:	8b 45 08             	mov    0x8(%ebp),%eax
8010021d:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021f:	8b 45 08             	mov    0x8(%ebp),%eax
80100222:	89 04 24             	mov    %eax,(%esp)
80100225:	e8 70 26 00 00       	call   8010289a <iderw>
}
8010022a:	c9                   	leave  
8010022b:	c3                   	ret    

8010022c <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022c:	55                   	push   %ebp
8010022d:	89 e5                	mov    %esp,%ebp
8010022f:	83 ec 18             	sub    $0x18,%esp
  if(!holdingsleep(&b->lock))
80100232:	8b 45 08             	mov    0x8(%ebp),%eax
80100235:	83 c0 0c             	add    $0xc,%eax
80100238:	89 04 24             	mov    %eax,(%esp)
8010023b:	e8 8a 4c 00 00       	call   80104eca <holdingsleep>
80100240:	85 c0                	test   %eax,%eax
80100242:	75 0c                	jne    80100250 <brelse+0x24>
    panic("brelse");
80100244:	c7 04 24 b2 85 10 80 	movl   $0x801085b2,(%esp)
8010024b:	e8 12 03 00 00       	call   80100562 <panic>

  releasesleep(&b->lock);
80100250:	8b 45 08             	mov    0x8(%ebp),%eax
80100253:	83 c0 0c             	add    $0xc,%eax
80100256:	89 04 24             	mov    %eax,(%esp)
80100259:	e8 2a 4c 00 00       	call   80104e88 <releasesleep>

  acquire(&bcache.lock);
8010025e:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100265:	e8 e6 4c 00 00       	call   80104f50 <acquire>
  b->refcnt--;
8010026a:	8b 45 08             	mov    0x8(%ebp),%eax
8010026d:	8b 40 4c             	mov    0x4c(%eax),%eax
80100270:	8d 50 ff             	lea    -0x1(%eax),%edx
80100273:	8b 45 08             	mov    0x8(%ebp),%eax
80100276:	89 50 4c             	mov    %edx,0x4c(%eax)
  if (b->refcnt == 0) {
80100279:	8b 45 08             	mov    0x8(%ebp),%eax
8010027c:	8b 40 4c             	mov    0x4c(%eax),%eax
8010027f:	85 c0                	test   %eax,%eax
80100281:	75 47                	jne    801002ca <brelse+0x9e>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100283:	8b 45 08             	mov    0x8(%ebp),%eax
80100286:	8b 40 54             	mov    0x54(%eax),%eax
80100289:	8b 55 08             	mov    0x8(%ebp),%edx
8010028c:	8b 52 50             	mov    0x50(%edx),%edx
8010028f:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100292:	8b 45 08             	mov    0x8(%ebp),%eax
80100295:	8b 40 50             	mov    0x50(%eax),%eax
80100298:	8b 55 08             	mov    0x8(%ebp),%edx
8010029b:	8b 52 54             	mov    0x54(%edx),%edx
8010029e:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
801002a1:	8b 15 b0 0d 11 80    	mov    0x80110db0,%edx
801002a7:	8b 45 08             	mov    0x8(%ebp),%eax
801002aa:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801002ad:	8b 45 08             	mov    0x8(%ebp),%eax
801002b0:	c7 40 50 5c 0d 11 80 	movl   $0x80110d5c,0x50(%eax)
    bcache.head.next->prev = b;
801002b7:	a1 b0 0d 11 80       	mov    0x80110db0,%eax
801002bc:	8b 55 08             	mov    0x8(%ebp),%edx
801002bf:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801002c2:	8b 45 08             	mov    0x8(%ebp),%eax
801002c5:	a3 b0 0d 11 80       	mov    %eax,0x80110db0
  }
  
  release(&bcache.lock);
801002ca:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801002d1:	e8 e1 4c 00 00       	call   80104fb7 <release>
}
801002d6:	c9                   	leave  
801002d7:	c3                   	ret    

801002d8 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d8:	55                   	push   %ebp
801002d9:	89 e5                	mov    %esp,%ebp
801002db:	83 ec 14             	sub    $0x14,%esp
801002de:	8b 45 08             	mov    0x8(%ebp),%eax
801002e1:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002e5:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e9:	89 c2                	mov    %eax,%edx
801002eb:	ec                   	in     (%dx),%al
801002ec:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002ef:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002f3:	c9                   	leave  
801002f4:	c3                   	ret    

801002f5 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002f5:	55                   	push   %ebp
801002f6:	89 e5                	mov    %esp,%ebp
801002f8:	83 ec 08             	sub    $0x8,%esp
801002fb:	8b 55 08             	mov    0x8(%ebp),%edx
801002fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80100301:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80100305:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100308:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010030c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100310:	ee                   	out    %al,(%dx)
}
80100311:	c9                   	leave  
80100312:	c3                   	ret    

80100313 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100313:	55                   	push   %ebp
80100314:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100316:	fa                   	cli    
}
80100317:	5d                   	pop    %ebp
80100318:	c3                   	ret    

80100319 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100319:	55                   	push   %ebp
8010031a:	89 e5                	mov    %esp,%ebp
8010031c:	56                   	push   %esi
8010031d:	53                   	push   %ebx
8010031e:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100321:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100325:	74 1c                	je     80100343 <printint+0x2a>
80100327:	8b 45 08             	mov    0x8(%ebp),%eax
8010032a:	c1 e8 1f             	shr    $0x1f,%eax
8010032d:	0f b6 c0             	movzbl %al,%eax
80100330:	89 45 10             	mov    %eax,0x10(%ebp)
80100333:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100337:	74 0a                	je     80100343 <printint+0x2a>
    x = -xx;
80100339:	8b 45 08             	mov    0x8(%ebp),%eax
8010033c:	f7 d8                	neg    %eax
8010033e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100341:	eb 06                	jmp    80100349 <printint+0x30>
  else
    x = xx;
80100343:	8b 45 08             	mov    0x8(%ebp),%eax
80100346:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100349:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100350:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100353:	8d 41 01             	lea    0x1(%ecx),%eax
80100356:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100359:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010035c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010035f:	ba 00 00 00 00       	mov    $0x0,%edx
80100364:	f7 f3                	div    %ebx
80100366:	89 d0                	mov    %edx,%eax
80100368:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
8010036f:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
80100373:	8b 75 0c             	mov    0xc(%ebp),%esi
80100376:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100379:	ba 00 00 00 00       	mov    $0x0,%edx
8010037e:	f7 f6                	div    %esi
80100380:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100383:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100387:	75 c7                	jne    80100350 <printint+0x37>

  if(sign)
80100389:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010038d:	74 10                	je     8010039f <printint+0x86>
    buf[i++] = '-';
8010038f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100392:	8d 50 01             	lea    0x1(%eax),%edx
80100395:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100398:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010039d:	eb 18                	jmp    801003b7 <printint+0x9e>
8010039f:	eb 16                	jmp    801003b7 <printint+0x9e>
    consputc(buf[i]);
801003a1:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a7:	01 d0                	add    %edx,%eax
801003a9:	0f b6 00             	movzbl (%eax),%eax
801003ac:	0f be c0             	movsbl %al,%eax
801003af:	89 04 24             	mov    %eax,(%esp)
801003b2:	e8 dc 03 00 00       	call   80100793 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003bf:	79 e0                	jns    801003a1 <printint+0x88>
    consputc(buf[i]);
}
801003c1:	83 c4 30             	add    $0x30,%esp
801003c4:	5b                   	pop    %ebx
801003c5:	5e                   	pop    %esi
801003c6:	5d                   	pop    %ebp
801003c7:	c3                   	ret    

801003c8 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003c8:	55                   	push   %ebp
801003c9:	89 e5                	mov    %esp,%ebp
801003cb:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003ce:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003da:	74 0c                	je     801003e8 <cprintf+0x20>
    acquire(&cons.lock);
801003dc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801003e3:	e8 68 4b 00 00       	call   80104f50 <acquire>

  if (fmt == 0)
801003e8:	8b 45 08             	mov    0x8(%ebp),%eax
801003eb:	85 c0                	test   %eax,%eax
801003ed:	75 0c                	jne    801003fb <cprintf+0x33>
    panic("null fmt");
801003ef:	c7 04 24 b9 85 10 80 	movl   $0x801085b9,(%esp)
801003f6:	e8 67 01 00 00       	call   80100562 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003fb:	8d 45 0c             	lea    0xc(%ebp),%eax
801003fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100401:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100408:	e9 21 01 00 00       	jmp    8010052e <cprintf+0x166>
    if(c != '%'){
8010040d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100411:	74 10                	je     80100423 <cprintf+0x5b>
      consputc(c);
80100413:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100416:	89 04 24             	mov    %eax,(%esp)
80100419:	e8 75 03 00 00       	call   80100793 <consputc>
      continue;
8010041e:	e9 07 01 00 00       	jmp    8010052a <cprintf+0x162>
    }
    c = fmt[++i] & 0xff;
80100423:	8b 55 08             	mov    0x8(%ebp),%edx
80100426:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010042a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010042d:	01 d0                	add    %edx,%eax
8010042f:	0f b6 00             	movzbl (%eax),%eax
80100432:	0f be c0             	movsbl %al,%eax
80100435:	25 ff 00 00 00       	and    $0xff,%eax
8010043a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010043d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100441:	75 05                	jne    80100448 <cprintf+0x80>
      break;
80100443:	e9 06 01 00 00       	jmp    8010054e <cprintf+0x186>
    switch(c){
80100448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010044b:	83 f8 70             	cmp    $0x70,%eax
8010044e:	74 4f                	je     8010049f <cprintf+0xd7>
80100450:	83 f8 70             	cmp    $0x70,%eax
80100453:	7f 13                	jg     80100468 <cprintf+0xa0>
80100455:	83 f8 25             	cmp    $0x25,%eax
80100458:	0f 84 a6 00 00 00    	je     80100504 <cprintf+0x13c>
8010045e:	83 f8 64             	cmp    $0x64,%eax
80100461:	74 14                	je     80100477 <cprintf+0xaf>
80100463:	e9 aa 00 00 00       	jmp    80100512 <cprintf+0x14a>
80100468:	83 f8 73             	cmp    $0x73,%eax
8010046b:	74 57                	je     801004c4 <cprintf+0xfc>
8010046d:	83 f8 78             	cmp    $0x78,%eax
80100470:	74 2d                	je     8010049f <cprintf+0xd7>
80100472:	e9 9b 00 00 00       	jmp    80100512 <cprintf+0x14a>
    case 'd':
      printint(*argp++, 10, 1);
80100477:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047a:	8d 50 04             	lea    0x4(%eax),%edx
8010047d:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100480:	8b 00                	mov    (%eax),%eax
80100482:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80100489:	00 
8010048a:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100491:	00 
80100492:	89 04 24             	mov    %eax,(%esp)
80100495:	e8 7f fe ff ff       	call   80100319 <printint>
      break;
8010049a:	e9 8b 00 00 00       	jmp    8010052a <cprintf+0x162>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010049f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004a2:	8d 50 04             	lea    0x4(%eax),%edx
801004a5:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a8:	8b 00                	mov    (%eax),%eax
801004aa:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801004b1:	00 
801004b2:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
801004b9:	00 
801004ba:	89 04 24             	mov    %eax,(%esp)
801004bd:	e8 57 fe ff ff       	call   80100319 <printint>
      break;
801004c2:	eb 66                	jmp    8010052a <cprintf+0x162>
    case 's':
      if((s = (char*)*argp++) == 0)
801004c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004c7:	8d 50 04             	lea    0x4(%eax),%edx
801004ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004cd:	8b 00                	mov    (%eax),%eax
801004cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004d6:	75 09                	jne    801004e1 <cprintf+0x119>
        s = "(null)";
801004d8:	c7 45 ec c2 85 10 80 	movl   $0x801085c2,-0x14(%ebp)
      for(; *s; s++)
801004df:	eb 17                	jmp    801004f8 <cprintf+0x130>
801004e1:	eb 15                	jmp    801004f8 <cprintf+0x130>
        consputc(*s);
801004e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004e6:	0f b6 00             	movzbl (%eax),%eax
801004e9:	0f be c0             	movsbl %al,%eax
801004ec:	89 04 24             	mov    %eax,(%esp)
801004ef:	e8 9f 02 00 00       	call   80100793 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004f4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004fb:	0f b6 00             	movzbl (%eax),%eax
801004fe:	84 c0                	test   %al,%al
80100500:	75 e1                	jne    801004e3 <cprintf+0x11b>
        consputc(*s);
      break;
80100502:	eb 26                	jmp    8010052a <cprintf+0x162>
    case '%':
      consputc('%');
80100504:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
8010050b:	e8 83 02 00 00       	call   80100793 <consputc>
      break;
80100510:	eb 18                	jmp    8010052a <cprintf+0x162>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100512:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
80100519:	e8 75 02 00 00       	call   80100793 <consputc>
      consputc(c);
8010051e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100521:	89 04 24             	mov    %eax,(%esp)
80100524:	e8 6a 02 00 00       	call   80100793 <consputc>
      break;
80100529:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010052a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010052e:	8b 55 08             	mov    0x8(%ebp),%edx
80100531:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100534:	01 d0                	add    %edx,%eax
80100536:	0f b6 00             	movzbl (%eax),%eax
80100539:	0f be c0             	movsbl %al,%eax
8010053c:	25 ff 00 00 00       	and    $0xff,%eax
80100541:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100544:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100548:	0f 85 bf fe ff ff    	jne    8010040d <cprintf+0x45>
      consputc(c);
      break;
    }
  }

  if(locking)
8010054e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100552:	74 0c                	je     80100560 <cprintf+0x198>
    release(&cons.lock);
80100554:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010055b:	e8 57 4a 00 00       	call   80104fb7 <release>
}
80100560:	c9                   	leave  
80100561:	c3                   	ret    

80100562 <panic>:

void
panic(char *s)
{
80100562:	55                   	push   %ebp
80100563:	89 e5                	mov    %esp,%ebp
80100565:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];

  cli();
80100568:	e8 a6 fd ff ff       	call   80100313 <cli>
  cons.locking = 0;
8010056d:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
80100574:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100577:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010057d:	0f b6 00             	movzbl (%eax),%eax
80100580:	0f b6 c0             	movzbl %al,%eax
80100583:	89 44 24 04          	mov    %eax,0x4(%esp)
80100587:	c7 04 24 c9 85 10 80 	movl   $0x801085c9,(%esp)
8010058e:	e8 35 fe ff ff       	call   801003c8 <cprintf>
  cprintf(s);
80100593:	8b 45 08             	mov    0x8(%ebp),%eax
80100596:	89 04 24             	mov    %eax,(%esp)
80100599:	e8 2a fe ff ff       	call   801003c8 <cprintf>
  cprintf("\n");
8010059e:	c7 04 24 e5 85 10 80 	movl   $0x801085e5,(%esp)
801005a5:	e8 1e fe ff ff       	call   801003c8 <cprintf>
  getcallerpcs(&s, pcs);
801005aa:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801005b1:	8d 45 08             	lea    0x8(%ebp),%eax
801005b4:	89 04 24             	mov    %eax,(%esp)
801005b7:	e8 48 4a 00 00       	call   80105004 <getcallerpcs>
  for(i=0; i<10; i++)
801005bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005c3:	eb 1b                	jmp    801005e0 <panic+0x7e>
    cprintf(" %p", pcs[i]);
801005c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005c8:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801005d0:	c7 04 24 e7 85 10 80 	movl   $0x801085e7,(%esp)
801005d7:	e8 ec fd ff ff       	call   801003c8 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005e0:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005e4:	7e df                	jle    801005c5 <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005e6:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005ed:	00 00 00 
  for(;;)
    ;
801005f0:	eb fe                	jmp    801005f0 <panic+0x8e>

801005f2 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005f2:	55                   	push   %ebp
801005f3:	89 e5                	mov    %esp,%ebp
801005f5:	83 ec 28             	sub    $0x28,%esp
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005f8:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005ff:	00 
80100600:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100607:	e8 e9 fc ff ff       	call   801002f5 <outb>
  pos = inb(CRTPORT+1) << 8;
8010060c:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100613:	e8 c0 fc ff ff       	call   801002d8 <inb>
80100618:	0f b6 c0             	movzbl %al,%eax
8010061b:	c1 e0 08             	shl    $0x8,%eax
8010061e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100621:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100628:	00 
80100629:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100630:	e8 c0 fc ff ff       	call   801002f5 <outb>
  pos |= inb(CRTPORT+1);
80100635:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010063c:	e8 97 fc ff ff       	call   801002d8 <inb>
80100641:	0f b6 c0             	movzbl %al,%eax
80100644:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100647:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010064b:	75 30                	jne    8010067d <cgaputc+0x8b>
    pos += 80 - pos%80;
8010064d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100650:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100655:	89 c8                	mov    %ecx,%eax
80100657:	f7 ea                	imul   %edx
80100659:	c1 fa 05             	sar    $0x5,%edx
8010065c:	89 c8                	mov    %ecx,%eax
8010065e:	c1 f8 1f             	sar    $0x1f,%eax
80100661:	29 c2                	sub    %eax,%edx
80100663:	89 d0                	mov    %edx,%eax
80100665:	c1 e0 02             	shl    $0x2,%eax
80100668:	01 d0                	add    %edx,%eax
8010066a:	c1 e0 04             	shl    $0x4,%eax
8010066d:	29 c1                	sub    %eax,%ecx
8010066f:	89 ca                	mov    %ecx,%edx
80100671:	b8 50 00 00 00       	mov    $0x50,%eax
80100676:	29 d0                	sub    %edx,%eax
80100678:	01 45 f4             	add    %eax,-0xc(%ebp)
8010067b:	eb 35                	jmp    801006b2 <cgaputc+0xc0>
  else if(c == BACKSPACE){
8010067d:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100684:	75 0c                	jne    80100692 <cgaputc+0xa0>
    if(pos > 0) --pos;
80100686:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010068a:	7e 26                	jle    801006b2 <cgaputc+0xc0>
8010068c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100690:	eb 20                	jmp    801006b2 <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100692:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100698:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010069b:	8d 50 01             	lea    0x1(%eax),%edx
8010069e:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006a1:	01 c0                	add    %eax,%eax
801006a3:	8d 14 01             	lea    (%ecx,%eax,1),%edx
801006a6:	8b 45 08             	mov    0x8(%ebp),%eax
801006a9:	0f b6 c0             	movzbl %al,%eax
801006ac:	80 cc 07             	or     $0x7,%ah
801006af:	66 89 02             	mov    %ax,(%edx)

  if(pos < 0 || pos > 25*80)
801006b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006b6:	78 09                	js     801006c1 <cgaputc+0xcf>
801006b8:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801006bf:	7e 0c                	jle    801006cd <cgaputc+0xdb>
    panic("pos under/overflow");
801006c1:	c7 04 24 eb 85 10 80 	movl   $0x801085eb,(%esp)
801006c8:	e8 95 fe ff ff       	call   80100562 <panic>

  if((pos/80) >= 24){  // Scroll up.
801006cd:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006d4:	7e 53                	jle    80100729 <cgaputc+0x137>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006d6:	a1 00 90 10 80       	mov    0x80109000,%eax
801006db:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006e1:	a1 00 90 10 80       	mov    0x80109000,%eax
801006e6:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006ed:	00 
801006ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801006f2:	89 04 24             	mov    %eax,(%esp)
801006f5:	e8 8e 4b 00 00       	call   80105288 <memmove>
    pos -= 80;
801006fa:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006fe:	b8 80 07 00 00       	mov    $0x780,%eax
80100703:	2b 45 f4             	sub    -0xc(%ebp),%eax
80100706:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100709:	a1 00 90 10 80       	mov    0x80109000,%eax
8010070e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100711:	01 c9                	add    %ecx,%ecx
80100713:	01 c8                	add    %ecx,%eax
80100715:	89 54 24 08          	mov    %edx,0x8(%esp)
80100719:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100720:	00 
80100721:	89 04 24             	mov    %eax,(%esp)
80100724:	e8 90 4a 00 00       	call   801051b9 <memset>
  }

  outb(CRTPORT, 14);
80100729:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
80100730:	00 
80100731:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100738:	e8 b8 fb ff ff       	call   801002f5 <outb>
  outb(CRTPORT+1, pos>>8);
8010073d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100740:	c1 f8 08             	sar    $0x8,%eax
80100743:	0f b6 c0             	movzbl %al,%eax
80100746:	89 44 24 04          	mov    %eax,0x4(%esp)
8010074a:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100751:	e8 9f fb ff ff       	call   801002f5 <outb>
  outb(CRTPORT, 15);
80100756:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010075d:	00 
8010075e:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100765:	e8 8b fb ff ff       	call   801002f5 <outb>
  outb(CRTPORT+1, pos);
8010076a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010076d:	0f b6 c0             	movzbl %al,%eax
80100770:	89 44 24 04          	mov    %eax,0x4(%esp)
80100774:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010077b:	e8 75 fb ff ff       	call   801002f5 <outb>
  crt[pos] = ' ' | 0x0700;
80100780:	a1 00 90 10 80       	mov    0x80109000,%eax
80100785:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100788:	01 d2                	add    %edx,%edx
8010078a:	01 d0                	add    %edx,%eax
8010078c:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100791:	c9                   	leave  
80100792:	c3                   	ret    

80100793 <consputc>:

void
consputc(int c)
{
80100793:	55                   	push   %ebp
80100794:	89 e5                	mov    %esp,%ebp
80100796:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
80100799:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
8010079e:	85 c0                	test   %eax,%eax
801007a0:	74 07                	je     801007a9 <consputc+0x16>
    cli();
801007a2:	e8 6c fb ff ff       	call   80100313 <cli>
    for(;;)
      ;
801007a7:	eb fe                	jmp    801007a7 <consputc+0x14>
  }

  if(c == BACKSPACE){
801007a9:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007b0:	75 26                	jne    801007d8 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007b2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007b9:	e8 a5 64 00 00       	call   80106c63 <uartputc>
801007be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801007c5:	e8 99 64 00 00       	call   80106c63 <uartputc>
801007ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007d1:	e8 8d 64 00 00       	call   80106c63 <uartputc>
801007d6:	eb 0b                	jmp    801007e3 <consputc+0x50>
  } else
    uartputc(c);
801007d8:	8b 45 08             	mov    0x8(%ebp),%eax
801007db:	89 04 24             	mov    %eax,(%esp)
801007de:	e8 80 64 00 00       	call   80106c63 <uartputc>
  cgaputc(c);
801007e3:	8b 45 08             	mov    0x8(%ebp),%eax
801007e6:	89 04 24             	mov    %eax,(%esp)
801007e9:	e8 04 fe ff ff       	call   801005f2 <cgaputc>
}
801007ee:	c9                   	leave  
801007ef:	c3                   	ret    

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	83 ec 28             	sub    $0x28,%esp
  int c, doprocdump = 0;
801007f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
801007fd:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100804:	e8 47 47 00 00       	call   80104f50 <acquire>
  while((c = getc()) >= 0){
80100809:	e9 39 01 00 00       	jmp    80100947 <consoleintr+0x157>
    switch(c){
8010080e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100811:	83 f8 10             	cmp    $0x10,%eax
80100814:	74 1e                	je     80100834 <consoleintr+0x44>
80100816:	83 f8 10             	cmp    $0x10,%eax
80100819:	7f 0a                	jg     80100825 <consoleintr+0x35>
8010081b:	83 f8 08             	cmp    $0x8,%eax
8010081e:	74 66                	je     80100886 <consoleintr+0x96>
80100820:	e9 93 00 00 00       	jmp    801008b8 <consoleintr+0xc8>
80100825:	83 f8 15             	cmp    $0x15,%eax
80100828:	74 31                	je     8010085b <consoleintr+0x6b>
8010082a:	83 f8 7f             	cmp    $0x7f,%eax
8010082d:	74 57                	je     80100886 <consoleintr+0x96>
8010082f:	e9 84 00 00 00       	jmp    801008b8 <consoleintr+0xc8>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100834:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
8010083b:	e9 07 01 00 00       	jmp    80100947 <consoleintr+0x157>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100840:	a1 48 10 11 80       	mov    0x80111048,%eax
80100845:	83 e8 01             	sub    $0x1,%eax
80100848:	a3 48 10 11 80       	mov    %eax,0x80111048
        consputc(BACKSPACE);
8010084d:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100854:	e8 3a ff ff ff       	call   80100793 <consputc>
80100859:	eb 01                	jmp    8010085c <consoleintr+0x6c>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010085b:	90                   	nop
8010085c:	8b 15 48 10 11 80    	mov    0x80111048,%edx
80100862:	a1 44 10 11 80       	mov    0x80111044,%eax
80100867:	39 c2                	cmp    %eax,%edx
80100869:	74 16                	je     80100881 <consoleintr+0x91>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010086b:	a1 48 10 11 80       	mov    0x80111048,%eax
80100870:	83 e8 01             	sub    $0x1,%eax
80100873:	83 e0 7f             	and    $0x7f,%eax
80100876:	0f b6 80 c0 0f 11 80 	movzbl -0x7feef040(%eax),%eax
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010087d:	3c 0a                	cmp    $0xa,%al
8010087f:	75 bf                	jne    80100840 <consoleintr+0x50>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100881:	e9 c1 00 00 00       	jmp    80100947 <consoleintr+0x157>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100886:	8b 15 48 10 11 80    	mov    0x80111048,%edx
8010088c:	a1 44 10 11 80       	mov    0x80111044,%eax
80100891:	39 c2                	cmp    %eax,%edx
80100893:	74 1e                	je     801008b3 <consoleintr+0xc3>
        input.e--;
80100895:	a1 48 10 11 80       	mov    0x80111048,%eax
8010089a:	83 e8 01             	sub    $0x1,%eax
8010089d:	a3 48 10 11 80       	mov    %eax,0x80111048
        consputc(BACKSPACE);
801008a2:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
801008a9:	e8 e5 fe ff ff       	call   80100793 <consputc>
      }
      break;
801008ae:	e9 94 00 00 00       	jmp    80100947 <consoleintr+0x157>
801008b3:	e9 8f 00 00 00       	jmp    80100947 <consoleintr+0x157>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801008bc:	0f 84 84 00 00 00    	je     80100946 <consoleintr+0x156>
801008c2:	8b 15 48 10 11 80    	mov    0x80111048,%edx
801008c8:	a1 40 10 11 80       	mov    0x80111040,%eax
801008cd:	29 c2                	sub    %eax,%edx
801008cf:	89 d0                	mov    %edx,%eax
801008d1:	83 f8 7f             	cmp    $0x7f,%eax
801008d4:	77 70                	ja     80100946 <consoleintr+0x156>
        c = (c == '\r') ? '\n' : c;
801008d6:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008da:	74 05                	je     801008e1 <consoleintr+0xf1>
801008dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008df:	eb 05                	jmp    801008e6 <consoleintr+0xf6>
801008e1:	b8 0a 00 00 00       	mov    $0xa,%eax
801008e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008e9:	a1 48 10 11 80       	mov    0x80111048,%eax
801008ee:	8d 50 01             	lea    0x1(%eax),%edx
801008f1:	89 15 48 10 11 80    	mov    %edx,0x80111048
801008f7:	83 e0 7f             	and    $0x7f,%eax
801008fa:	89 c2                	mov    %eax,%edx
801008fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008ff:	88 82 c0 0f 11 80    	mov    %al,-0x7feef040(%edx)
        consputc(c);
80100905:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100908:	89 04 24             	mov    %eax,(%esp)
8010090b:	e8 83 fe ff ff       	call   80100793 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100910:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100914:	74 18                	je     8010092e <consoleintr+0x13e>
80100916:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
8010091a:	74 12                	je     8010092e <consoleintr+0x13e>
8010091c:	a1 48 10 11 80       	mov    0x80111048,%eax
80100921:	8b 15 40 10 11 80    	mov    0x80111040,%edx
80100927:	83 ea 80             	sub    $0xffffff80,%edx
8010092a:	39 d0                	cmp    %edx,%eax
8010092c:	75 18                	jne    80100946 <consoleintr+0x156>
          input.w = input.e;
8010092e:	a1 48 10 11 80       	mov    0x80111048,%eax
80100933:	a3 44 10 11 80       	mov    %eax,0x80111044
          wakeup(&input.r);
80100938:	c7 04 24 40 10 11 80 	movl   $0x80111040,(%esp)
8010093f:	e8 14 43 00 00       	call   80104c58 <wakeup>
        }
      }
      break;
80100944:	eb 00                	jmp    80100946 <consoleintr+0x156>
80100946:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100947:	8b 45 08             	mov    0x8(%ebp),%eax
8010094a:	ff d0                	call   *%eax
8010094c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010094f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100953:	0f 89 b5 fe ff ff    	jns    8010080e <consoleintr+0x1e>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100959:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100960:	e8 52 46 00 00       	call   80104fb7 <release>
  if(doprocdump) {
80100965:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100969:	74 05                	je     80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
8010096b:	e8 8b 43 00 00       	call   80104cfb <procdump>
  }
}
80100970:	c9                   	leave  
80100971:	c3                   	ret    

80100972 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100972:	55                   	push   %ebp
80100973:	89 e5                	mov    %esp,%ebp
80100975:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100978:	8b 45 08             	mov    0x8(%ebp),%eax
8010097b:	89 04 24             	mov    %eax,(%esp)
8010097e:	e8 06 11 00 00       	call   80101a89 <iunlock>
  target = n;
80100983:	8b 45 10             	mov    0x10(%ebp),%eax
80100986:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100989:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100990:	e8 bb 45 00 00       	call   80104f50 <acquire>
  while(n > 0){
80100995:	e9 aa 00 00 00       	jmp    80100a44 <consoleread+0xd2>
    while(input.r == input.w){
8010099a:	eb 42                	jmp    801009de <consoleread+0x6c>
      if(proc->killed){
8010099c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009a2:	8b 40 24             	mov    0x24(%eax),%eax
801009a5:	85 c0                	test   %eax,%eax
801009a7:	74 21                	je     801009ca <consoleread+0x58>
        release(&cons.lock);
801009a9:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801009b0:	e8 02 46 00 00       	call   80104fb7 <release>
        ilock(ip);
801009b5:	8b 45 08             	mov    0x8(%ebp),%eax
801009b8:	89 04 24             	mov    %eax,(%esp)
801009bb:	e8 b2 0f 00 00       	call   80101972 <ilock>
        return -1;
801009c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009c5:	e9 a5 00 00 00       	jmp    80100a6f <consoleread+0xfd>
      }
      sleep(&input.r, &cons.lock);
801009ca:	c7 44 24 04 c0 b5 10 	movl   $0x8010b5c0,0x4(%esp)
801009d1:	80 
801009d2:	c7 04 24 40 10 11 80 	movl   $0x80111040,(%esp)
801009d9:	e8 a1 41 00 00       	call   80104b7f <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801009de:	8b 15 40 10 11 80    	mov    0x80111040,%edx
801009e4:	a1 44 10 11 80       	mov    0x80111044,%eax
801009e9:	39 c2                	cmp    %eax,%edx
801009eb:	74 af                	je     8010099c <consoleread+0x2a>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009ed:	a1 40 10 11 80       	mov    0x80111040,%eax
801009f2:	8d 50 01             	lea    0x1(%eax),%edx
801009f5:	89 15 40 10 11 80    	mov    %edx,0x80111040
801009fb:	83 e0 7f             	and    $0x7f,%eax
801009fe:	0f b6 80 c0 0f 11 80 	movzbl -0x7feef040(%eax),%eax
80100a05:	0f be c0             	movsbl %al,%eax
80100a08:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a0b:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a0f:	75 19                	jne    80100a2a <consoleread+0xb8>
      if(n < target){
80100a11:	8b 45 10             	mov    0x10(%ebp),%eax
80100a14:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a17:	73 0f                	jae    80100a28 <consoleread+0xb6>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a19:	a1 40 10 11 80       	mov    0x80111040,%eax
80100a1e:	83 e8 01             	sub    $0x1,%eax
80100a21:	a3 40 10 11 80       	mov    %eax,0x80111040
      }
      break;
80100a26:	eb 26                	jmp    80100a4e <consoleread+0xdc>
80100a28:	eb 24                	jmp    80100a4e <consoleread+0xdc>
    }
    *dst++ = c;
80100a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a2d:	8d 50 01             	lea    0x1(%eax),%edx
80100a30:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a33:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a36:	88 10                	mov    %dl,(%eax)
    --n;
80100a38:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a3c:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a40:	75 02                	jne    80100a44 <consoleread+0xd2>
      break;
80100a42:	eb 0a                	jmp    80100a4e <consoleread+0xdc>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100a44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a48:	0f 8f 4c ff ff ff    	jg     8010099a <consoleread+0x28>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
80100a4e:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a55:	e8 5d 45 00 00       	call   80104fb7 <release>
  ilock(ip);
80100a5a:	8b 45 08             	mov    0x8(%ebp),%eax
80100a5d:	89 04 24             	mov    %eax,(%esp)
80100a60:	e8 0d 0f 00 00       	call   80101972 <ilock>

  return target - n;
80100a65:	8b 45 10             	mov    0x10(%ebp),%eax
80100a68:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a6b:	29 c2                	sub    %eax,%edx
80100a6d:	89 d0                	mov    %edx,%eax
}
80100a6f:	c9                   	leave  
80100a70:	c3                   	ret    

80100a71 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a71:	55                   	push   %ebp
80100a72:	89 e5                	mov    %esp,%ebp
80100a74:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a77:	8b 45 08             	mov    0x8(%ebp),%eax
80100a7a:	89 04 24             	mov    %eax,(%esp)
80100a7d:	e8 07 10 00 00       	call   80101a89 <iunlock>
  acquire(&cons.lock);
80100a82:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a89:	e8 c2 44 00 00       	call   80104f50 <acquire>
  for(i = 0; i < n; i++)
80100a8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a95:	eb 1d                	jmp    80100ab4 <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100a97:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a9d:	01 d0                	add    %edx,%eax
80100a9f:	0f b6 00             	movzbl (%eax),%eax
80100aa2:	0f be c0             	movsbl %al,%eax
80100aa5:	0f b6 c0             	movzbl %al,%eax
80100aa8:	89 04 24             	mov    %eax,(%esp)
80100aab:	e8 e3 fc ff ff       	call   80100793 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100ab0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ab7:	3b 45 10             	cmp    0x10(%ebp),%eax
80100aba:	7c db                	jl     80100a97 <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100abc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100ac3:	e8 ef 44 00 00       	call   80104fb7 <release>
  ilock(ip);
80100ac8:	8b 45 08             	mov    0x8(%ebp),%eax
80100acb:	89 04 24             	mov    %eax,(%esp)
80100ace:	e8 9f 0e 00 00       	call   80101972 <ilock>

  return n;
80100ad3:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ad6:	c9                   	leave  
80100ad7:	c3                   	ret    

80100ad8 <consoleinit>:

void
consoleinit(void)
{
80100ad8:	55                   	push   %ebp
80100ad9:	89 e5                	mov    %esp,%ebp
80100adb:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100ade:	c7 44 24 04 fe 85 10 	movl   $0x801085fe,0x4(%esp)
80100ae5:	80 
80100ae6:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100aed:	e8 3d 44 00 00       	call   80104f2f <initlock>

  devsw[CONSOLE].write = consolewrite;
80100af2:	c7 05 0c 1a 11 80 71 	movl   $0x80100a71,0x80111a0c
80100af9:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100afc:	c7 05 08 1a 11 80 72 	movl   $0x80100972,0x80111a08
80100b03:	09 10 80 
  cons.locking = 1;
80100b06:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100b0d:	00 00 00 

  picenable(IRQ_KBD);
80100b10:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b17:	e8 cf 32 00 00       	call   80103deb <picenable>
  ioapicenable(IRQ_KBD, 0);
80100b1c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100b23:	00 
80100b24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b2b:	e8 2c 1f 00 00       	call   80102a5c <ioapicenable>
}
80100b30:	c9                   	leave  
80100b31:	c3                   	ret    

80100b32 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b32:	55                   	push   %ebp
80100b33:	89 e5                	mov    %esp,%ebp
80100b35:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b3b:	e8 f9 29 00 00       	call   80103539 <begin_op>

  if((ip = namei(path)) == 0){
80100b40:	8b 45 08             	mov    0x8(%ebp),%eax
80100b43:	89 04 24             	mov    %eax,(%esp)
80100b46:	e8 4f 19 00 00       	call   8010249a <namei>
80100b4b:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b4e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b52:	75 0f                	jne    80100b63 <exec+0x31>
    end_op();
80100b54:	e8 64 2a 00 00       	call   801035bd <end_op>
    return -1;
80100b59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b5e:	e9 19 04 00 00       	jmp    80100f7c <exec+0x44a>
  }
  ilock(ip);
80100b63:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b66:	89 04 24             	mov    %eax,(%esp)
80100b69:	e8 04 0e 00 00       	call   80101972 <ilock>
  pgdir = 0;
80100b6e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b75:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b7c:	00 
80100b7d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b84:	00 
80100b85:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b8b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b8f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b92:	89 04 24             	mov    %eax,(%esp)
80100b95:	e8 62 12 00 00       	call   80101dfc <readi>
80100b9a:	83 f8 33             	cmp    $0x33,%eax
80100b9d:	77 05                	ja     80100ba4 <exec+0x72>
    goto bad;
80100b9f:	e9 ac 03 00 00       	jmp    80100f50 <exec+0x41e>
  if(elf.magic != ELF_MAGIC)
80100ba4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100baa:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100baf:	74 05                	je     80100bb6 <exec+0x84>
    goto bad;
80100bb1:	e9 9a 03 00 00       	jmp    80100f50 <exec+0x41e>

  if((pgdir = setupkvm()) == 0)
80100bb6:	e8 ce 71 00 00       	call   80107d89 <setupkvm>
80100bbb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bbe:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bc2:	75 05                	jne    80100bc9 <exec+0x97>
    goto bad;
80100bc4:	e9 87 03 00 00       	jmp    80100f50 <exec+0x41e>

  // Load program into memory.
  sz = 0;
80100bc9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bd0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100bd7:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100bdd:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100be0:	e9 fc 00 00 00       	jmp    80100ce1 <exec+0x1af>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100be5:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100be8:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100bef:	00 
80100bf0:	89 44 24 08          	mov    %eax,0x8(%esp)
80100bf4:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bfa:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bfe:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100c01:	89 04 24             	mov    %eax,(%esp)
80100c04:	e8 f3 11 00 00       	call   80101dfc <readi>
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	74 05                	je     80100c13 <exec+0xe1>
      goto bad;
80100c0e:	e9 3d 03 00 00       	jmp    80100f50 <exec+0x41e>
    if(ph.type != ELF_PROG_LOAD)
80100c13:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c19:	83 f8 01             	cmp    $0x1,%eax
80100c1c:	74 05                	je     80100c23 <exec+0xf1>
      continue;
80100c1e:	e9 b1 00 00 00       	jmp    80100cd4 <exec+0x1a2>
    if(ph.memsz < ph.filesz)
80100c23:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c29:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c2f:	39 c2                	cmp    %eax,%edx
80100c31:	73 05                	jae    80100c38 <exec+0x106>
      goto bad;
80100c33:	e9 18 03 00 00       	jmp    80100f50 <exec+0x41e>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c38:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c3e:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c44:	01 c2                	add    %eax,%edx
80100c46:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c4c:	39 c2                	cmp    %eax,%edx
80100c4e:	73 05                	jae    80100c55 <exec+0x123>
      goto bad;
80100c50:	e9 fb 02 00 00       	jmp    80100f50 <exec+0x41e>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c55:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c5b:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c61:	01 d0                	add    %edx,%eax
80100c63:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c6e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c71:	89 04 24             	mov    %eax,(%esp)
80100c74:	e8 81 74 00 00       	call   801080fa <allocuvm>
80100c79:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c80:	75 05                	jne    80100c87 <exec+0x155>
      goto bad;
80100c82:	e9 c9 02 00 00       	jmp    80100f50 <exec+0x41e>
    if(ph.vaddr % PGSIZE != 0)
80100c87:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c8d:	25 ff 0f 00 00       	and    $0xfff,%eax
80100c92:	85 c0                	test   %eax,%eax
80100c94:	74 05                	je     80100c9b <exec+0x169>
      goto bad;
80100c96:	e9 b5 02 00 00       	jmp    80100f50 <exec+0x41e>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c9b:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100ca1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100ca7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100cad:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100cb1:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100cb5:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100cb8:	89 54 24 08          	mov    %edx,0x8(%esp)
80100cbc:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cc0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100cc3:	89 04 24             	mov    %eax,(%esp)
80100cc6:	e8 62 73 00 00       	call   8010802d <loaduvm>
80100ccb:	85 c0                	test   %eax,%eax
80100ccd:	79 05                	jns    80100cd4 <exec+0x1a2>
      goto bad;
80100ccf:	e9 7c 02 00 00       	jmp    80100f50 <exec+0x41e>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cd4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100cd8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100cdb:	83 c0 20             	add    $0x20,%eax
80100cde:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ce1:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100ce8:	0f b7 c0             	movzwl %ax,%eax
80100ceb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cee:	0f 8f f1 fe ff ff    	jg     80100be5 <exec+0xb3>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cf4:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100cf7:	89 04 24             	mov    %eax,(%esp)
80100cfa:	e8 62 0e 00 00       	call   80101b61 <iunlockput>
  end_op();
80100cff:	e8 b9 28 00 00       	call   801035bd <end_op>
  ip = 0;
80100d04:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d0e:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d13:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d18:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d1e:	05 00 20 00 00       	add    $0x2000,%eax
80100d23:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d27:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d2a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d2e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d31:	89 04 24             	mov    %eax,(%esp)
80100d34:	e8 c1 73 00 00       	call   801080fa <allocuvm>
80100d39:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d3c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d40:	75 05                	jne    80100d47 <exec+0x215>
    goto bad;
80100d42:	e9 09 02 00 00       	jmp    80100f50 <exec+0x41e>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d47:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d4a:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d53:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d56:	89 04 24             	mov    %eax,(%esp)
80100d59:	e8 ee 75 00 00       	call   8010834c <clearpteu>
  sp = sz;
80100d5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d61:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d6b:	e9 9a 00 00 00       	jmp    80100e0a <exec+0x2d8>
    if(argc >= MAXARG)
80100d70:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d74:	76 05                	jbe    80100d7b <exec+0x249>
      goto bad;
80100d76:	e9 d5 01 00 00       	jmp    80100f50 <exec+0x41e>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d7e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d85:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d88:	01 d0                	add    %edx,%eax
80100d8a:	8b 00                	mov    (%eax),%eax
80100d8c:	89 04 24             	mov    %eax,(%esp)
80100d8f:	e8 8f 46 00 00       	call   80105423 <strlen>
80100d94:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100d97:	29 c2                	sub    %eax,%edx
80100d99:	89 d0                	mov    %edx,%eax
80100d9b:	83 e8 01             	sub    $0x1,%eax
80100d9e:	83 e0 fc             	and    $0xfffffffc,%eax
80100da1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100da4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100da7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dae:	8b 45 0c             	mov    0xc(%ebp),%eax
80100db1:	01 d0                	add    %edx,%eax
80100db3:	8b 00                	mov    (%eax),%eax
80100db5:	89 04 24             	mov    %eax,(%esp)
80100db8:	e8 66 46 00 00       	call   80105423 <strlen>
80100dbd:	83 c0 01             	add    $0x1,%eax
80100dc0:	89 c2                	mov    %eax,%edx
80100dc2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dc5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100dcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dcf:	01 c8                	add    %ecx,%eax
80100dd1:	8b 00                	mov    (%eax),%eax
80100dd3:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100dd7:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ddb:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dde:	89 44 24 04          	mov    %eax,0x4(%esp)
80100de2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100de5:	89 04 24             	mov    %eax,(%esp)
80100de8:	e8 fe 76 00 00       	call   801084eb <copyout>
80100ded:	85 c0                	test   %eax,%eax
80100def:	79 05                	jns    80100df6 <exec+0x2c4>
      goto bad;
80100df1:	e9 5a 01 00 00       	jmp    80100f50 <exec+0x41e>
    ustack[3+argc] = sp;
80100df6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df9:	8d 50 03             	lea    0x3(%eax),%edx
80100dfc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dff:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e06:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100e0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e0d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e14:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e17:	01 d0                	add    %edx,%eax
80100e19:	8b 00                	mov    (%eax),%eax
80100e1b:	85 c0                	test   %eax,%eax
80100e1d:	0f 85 4d ff ff ff    	jne    80100d70 <exec+0x23e>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100e23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e26:	83 c0 03             	add    $0x3,%eax
80100e29:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100e30:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e34:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100e3b:	ff ff ff 
  ustack[1] = argc;
80100e3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e41:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e4a:	83 c0 01             	add    $0x1,%eax
80100e4d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e54:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e57:	29 d0                	sub    %edx,%eax
80100e59:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e62:	83 c0 04             	add    $0x4,%eax
80100e65:	c1 e0 02             	shl    $0x2,%eax
80100e68:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e6e:	83 c0 04             	add    $0x4,%eax
80100e71:	c1 e0 02             	shl    $0x2,%eax
80100e74:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100e78:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e7e:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e82:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e85:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e89:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100e8c:	89 04 24             	mov    %eax,(%esp)
80100e8f:	e8 57 76 00 00       	call   801084eb <copyout>
80100e94:	85 c0                	test   %eax,%eax
80100e96:	79 05                	jns    80100e9d <exec+0x36b>
    goto bad;
80100e98:	e9 b3 00 00 00       	jmp    80100f50 <exec+0x41e>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80100ea0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ea6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100ea9:	eb 17                	jmp    80100ec2 <exec+0x390>
    if(*s == '/')
80100eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eae:	0f b6 00             	movzbl (%eax),%eax
80100eb1:	3c 2f                	cmp    $0x2f,%al
80100eb3:	75 09                	jne    80100ebe <exec+0x38c>
      last = s+1;
80100eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eb8:	83 c0 01             	add    $0x1,%eax
80100ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ebe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ec5:	0f b6 00             	movzbl (%eax),%eax
80100ec8:	84 c0                	test   %al,%al
80100eca:	75 df                	jne    80100eab <exec+0x379>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100ecc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed2:	8d 50 6c             	lea    0x6c(%eax),%edx
80100ed5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100edc:	00 
80100edd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100ee0:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ee4:	89 14 24             	mov    %edx,(%esp)
80100ee7:	e8 ed 44 00 00       	call   801053d9 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100eec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ef2:	8b 40 04             	mov    0x4(%eax),%eax
80100ef5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100ef8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100efe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100f01:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100f04:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f0a:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f0d:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100f0f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f15:	8b 40 18             	mov    0x18(%eax),%eax
80100f18:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100f1e:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100f21:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f27:	8b 40 18             	mov    0x18(%eax),%eax
80100f2a:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f2d:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100f30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f36:	89 04 24             	mov    %eax,(%esp)
80100f39:	e8 07 6f 00 00       	call   80107e45 <switchuvm>
  freevm(oldpgdir);
80100f3e:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f41:	89 04 24             	mov    %eax,(%esp)
80100f44:	e8 6a 73 00 00       	call   801082b3 <freevm>
  return 0;
80100f49:	b8 00 00 00 00       	mov    $0x0,%eax
80100f4e:	eb 2c                	jmp    80100f7c <exec+0x44a>

 bad:
  if(pgdir)
80100f50:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f54:	74 0b                	je     80100f61 <exec+0x42f>
    freevm(pgdir);
80100f56:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100f59:	89 04 24             	mov    %eax,(%esp)
80100f5c:	e8 52 73 00 00       	call   801082b3 <freevm>
  if(ip){
80100f61:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f65:	74 10                	je     80100f77 <exec+0x445>
    iunlockput(ip);
80100f67:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100f6a:	89 04 24             	mov    %eax,(%esp)
80100f6d:	e8 ef 0b 00 00       	call   80101b61 <iunlockput>
    end_op();
80100f72:	e8 46 26 00 00       	call   801035bd <end_op>
  }
  return -1;
80100f77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f7c:	c9                   	leave  
80100f7d:	c3                   	ret    

80100f7e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f7e:	55                   	push   %ebp
80100f7f:	89 e5                	mov    %esp,%ebp
80100f81:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100f84:	c7 44 24 04 06 86 10 	movl   $0x80108606,0x4(%esp)
80100f8b:	80 
80100f8c:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
80100f93:	e8 97 3f 00 00       	call   80104f2f <initlock>
}
80100f98:	c9                   	leave  
80100f99:	c3                   	ret    

80100f9a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f9a:	55                   	push   %ebp
80100f9b:	89 e5                	mov    %esp,%ebp
80100f9d:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80100fa0:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
80100fa7:	e8 a4 3f 00 00       	call   80104f50 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fac:	c7 45 f4 94 10 11 80 	movl   $0x80111094,-0xc(%ebp)
80100fb3:	eb 29                	jmp    80100fde <filealloc+0x44>
    if(f->ref == 0){
80100fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fb8:	8b 40 04             	mov    0x4(%eax),%eax
80100fbb:	85 c0                	test   %eax,%eax
80100fbd:	75 1b                	jne    80100fda <filealloc+0x40>
      f->ref = 1;
80100fbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fc2:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100fc9:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
80100fd0:	e8 e2 3f 00 00       	call   80104fb7 <release>
      return f;
80100fd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fd8:	eb 1e                	jmp    80100ff8 <filealloc+0x5e>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fda:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fde:	81 7d f4 f4 19 11 80 	cmpl   $0x801119f4,-0xc(%ebp)
80100fe5:	72 ce                	jb     80100fb5 <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fe7:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
80100fee:	e8 c4 3f 00 00       	call   80104fb7 <release>
  return 0;
80100ff3:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100ff8:	c9                   	leave  
80100ff9:	c3                   	ret    

80100ffa <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ffa:	55                   	push   %ebp
80100ffb:	89 e5                	mov    %esp,%ebp
80100ffd:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
80101000:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
80101007:	e8 44 3f 00 00       	call   80104f50 <acquire>
  if(f->ref < 1)
8010100c:	8b 45 08             	mov    0x8(%ebp),%eax
8010100f:	8b 40 04             	mov    0x4(%eax),%eax
80101012:	85 c0                	test   %eax,%eax
80101014:	7f 0c                	jg     80101022 <filedup+0x28>
    panic("filedup");
80101016:	c7 04 24 0d 86 10 80 	movl   $0x8010860d,(%esp)
8010101d:	e8 40 f5 ff ff       	call   80100562 <panic>
  f->ref++;
80101022:	8b 45 08             	mov    0x8(%ebp),%eax
80101025:	8b 40 04             	mov    0x4(%eax),%eax
80101028:	8d 50 01             	lea    0x1(%eax),%edx
8010102b:	8b 45 08             	mov    0x8(%ebp),%eax
8010102e:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101031:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
80101038:	e8 7a 3f 00 00       	call   80104fb7 <release>
  return f;
8010103d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101040:	c9                   	leave  
80101041:	c3                   	ret    

80101042 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101042:	55                   	push   %ebp
80101043:	89 e5                	mov    %esp,%ebp
80101045:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
80101048:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
8010104f:	e8 fc 3e 00 00       	call   80104f50 <acquire>
  if(f->ref < 1)
80101054:	8b 45 08             	mov    0x8(%ebp),%eax
80101057:	8b 40 04             	mov    0x4(%eax),%eax
8010105a:	85 c0                	test   %eax,%eax
8010105c:	7f 0c                	jg     8010106a <fileclose+0x28>
    panic("fileclose");
8010105e:	c7 04 24 15 86 10 80 	movl   $0x80108615,(%esp)
80101065:	e8 f8 f4 ff ff       	call   80100562 <panic>
  if(--f->ref > 0){
8010106a:	8b 45 08             	mov    0x8(%ebp),%eax
8010106d:	8b 40 04             	mov    0x4(%eax),%eax
80101070:	8d 50 ff             	lea    -0x1(%eax),%edx
80101073:	8b 45 08             	mov    0x8(%ebp),%eax
80101076:	89 50 04             	mov    %edx,0x4(%eax)
80101079:	8b 45 08             	mov    0x8(%ebp),%eax
8010107c:	8b 40 04             	mov    0x4(%eax),%eax
8010107f:	85 c0                	test   %eax,%eax
80101081:	7e 11                	jle    80101094 <fileclose+0x52>
    release(&ftable.lock);
80101083:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
8010108a:	e8 28 3f 00 00       	call   80104fb7 <release>
8010108f:	e9 82 00 00 00       	jmp    80101116 <fileclose+0xd4>
    return;
  }
  ff = *f;
80101094:	8b 45 08             	mov    0x8(%ebp),%eax
80101097:	8b 10                	mov    (%eax),%edx
80101099:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010109c:	8b 50 04             	mov    0x4(%eax),%edx
8010109f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010a2:	8b 50 08             	mov    0x8(%eax),%edx
801010a5:	89 55 e8             	mov    %edx,-0x18(%ebp)
801010a8:	8b 50 0c             	mov    0xc(%eax),%edx
801010ab:	89 55 ec             	mov    %edx,-0x14(%ebp)
801010ae:	8b 50 10             	mov    0x10(%eax),%edx
801010b1:	89 55 f0             	mov    %edx,-0x10(%ebp)
801010b4:	8b 40 14             	mov    0x14(%eax),%eax
801010b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801010ba:	8b 45 08             	mov    0x8(%ebp),%eax
801010bd:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010c4:	8b 45 08             	mov    0x8(%ebp),%eax
801010c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010cd:	c7 04 24 60 10 11 80 	movl   $0x80111060,(%esp)
801010d4:	e8 de 3e 00 00       	call   80104fb7 <release>

  if(ff.type == FD_PIPE)
801010d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010dc:	83 f8 01             	cmp    $0x1,%eax
801010df:	75 18                	jne    801010f9 <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
801010e1:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010e5:	0f be d0             	movsbl %al,%edx
801010e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801010ef:	89 04 24             	mov    %eax,(%esp)
801010f2:	e8 a4 2f 00 00       	call   8010409b <pipeclose>
801010f7:	eb 1d                	jmp    80101116 <fileclose+0xd4>
  else if(ff.type == FD_INODE){
801010f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010fc:	83 f8 02             	cmp    $0x2,%eax
801010ff:	75 15                	jne    80101116 <fileclose+0xd4>
    begin_op();
80101101:	e8 33 24 00 00       	call   80103539 <begin_op>
    iput(ff.ip);
80101106:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101109:	89 04 24             	mov    %eax,(%esp)
8010110c:	e8 bc 09 00 00       	call   80101acd <iput>
    end_op();
80101111:	e8 a7 24 00 00       	call   801035bd <end_op>
  }
}
80101116:	c9                   	leave  
80101117:	c3                   	ret    

80101118 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101118:	55                   	push   %ebp
80101119:	89 e5                	mov    %esp,%ebp
8010111b:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
8010111e:	8b 45 08             	mov    0x8(%ebp),%eax
80101121:	8b 00                	mov    (%eax),%eax
80101123:	83 f8 02             	cmp    $0x2,%eax
80101126:	75 38                	jne    80101160 <filestat+0x48>
    ilock(f->ip);
80101128:	8b 45 08             	mov    0x8(%ebp),%eax
8010112b:	8b 40 10             	mov    0x10(%eax),%eax
8010112e:	89 04 24             	mov    %eax,(%esp)
80101131:	e8 3c 08 00 00       	call   80101972 <ilock>
    stati(f->ip, st);
80101136:	8b 45 08             	mov    0x8(%ebp),%eax
80101139:	8b 40 10             	mov    0x10(%eax),%eax
8010113c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010113f:	89 54 24 04          	mov    %edx,0x4(%esp)
80101143:	89 04 24             	mov    %eax,(%esp)
80101146:	e8 6c 0c 00 00       	call   80101db7 <stati>
    iunlock(f->ip);
8010114b:	8b 45 08             	mov    0x8(%ebp),%eax
8010114e:	8b 40 10             	mov    0x10(%eax),%eax
80101151:	89 04 24             	mov    %eax,(%esp)
80101154:	e8 30 09 00 00       	call   80101a89 <iunlock>
    return 0;
80101159:	b8 00 00 00 00       	mov    $0x0,%eax
8010115e:	eb 05                	jmp    80101165 <filestat+0x4d>
  }
  return -1;
80101160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101165:	c9                   	leave  
80101166:	c3                   	ret    

80101167 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101167:	55                   	push   %ebp
80101168:	89 e5                	mov    %esp,%ebp
8010116a:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
8010116d:	8b 45 08             	mov    0x8(%ebp),%eax
80101170:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101174:	84 c0                	test   %al,%al
80101176:	75 0a                	jne    80101182 <fileread+0x1b>
    return -1;
80101178:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010117d:	e9 9f 00 00 00       	jmp    80101221 <fileread+0xba>
  if(f->type == FD_PIPE)
80101182:	8b 45 08             	mov    0x8(%ebp),%eax
80101185:	8b 00                	mov    (%eax),%eax
80101187:	83 f8 01             	cmp    $0x1,%eax
8010118a:	75 1e                	jne    801011aa <fileread+0x43>
    return piperead(f->pipe, addr, n);
8010118c:	8b 45 08             	mov    0x8(%ebp),%eax
8010118f:	8b 40 0c             	mov    0xc(%eax),%eax
80101192:	8b 55 10             	mov    0x10(%ebp),%edx
80101195:	89 54 24 08          	mov    %edx,0x8(%esp)
80101199:	8b 55 0c             	mov    0xc(%ebp),%edx
8010119c:	89 54 24 04          	mov    %edx,0x4(%esp)
801011a0:	89 04 24             	mov    %eax,(%esp)
801011a3:	e8 74 30 00 00       	call   8010421c <piperead>
801011a8:	eb 77                	jmp    80101221 <fileread+0xba>
  if(f->type == FD_INODE){
801011aa:	8b 45 08             	mov    0x8(%ebp),%eax
801011ad:	8b 00                	mov    (%eax),%eax
801011af:	83 f8 02             	cmp    $0x2,%eax
801011b2:	75 61                	jne    80101215 <fileread+0xae>
    ilock(f->ip);
801011b4:	8b 45 08             	mov    0x8(%ebp),%eax
801011b7:	8b 40 10             	mov    0x10(%eax),%eax
801011ba:	89 04 24             	mov    %eax,(%esp)
801011bd:	e8 b0 07 00 00       	call   80101972 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011c5:	8b 45 08             	mov    0x8(%ebp),%eax
801011c8:	8b 50 14             	mov    0x14(%eax),%edx
801011cb:	8b 45 08             	mov    0x8(%ebp),%eax
801011ce:	8b 40 10             	mov    0x10(%eax),%eax
801011d1:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801011d5:	89 54 24 08          	mov    %edx,0x8(%esp)
801011d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801011dc:	89 54 24 04          	mov    %edx,0x4(%esp)
801011e0:	89 04 24             	mov    %eax,(%esp)
801011e3:	e8 14 0c 00 00       	call   80101dfc <readi>
801011e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011ef:	7e 11                	jle    80101202 <fileread+0x9b>
      f->off += r;
801011f1:	8b 45 08             	mov    0x8(%ebp),%eax
801011f4:	8b 50 14             	mov    0x14(%eax),%edx
801011f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011fa:	01 c2                	add    %eax,%edx
801011fc:	8b 45 08             	mov    0x8(%ebp),%eax
801011ff:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101202:	8b 45 08             	mov    0x8(%ebp),%eax
80101205:	8b 40 10             	mov    0x10(%eax),%eax
80101208:	89 04 24             	mov    %eax,(%esp)
8010120b:	e8 79 08 00 00       	call   80101a89 <iunlock>
    return r;
80101210:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101213:	eb 0c                	jmp    80101221 <fileread+0xba>
  }
  panic("fileread");
80101215:	c7 04 24 1f 86 10 80 	movl   $0x8010861f,(%esp)
8010121c:	e8 41 f3 ff ff       	call   80100562 <panic>
}
80101221:	c9                   	leave  
80101222:	c3                   	ret    

80101223 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101223:	55                   	push   %ebp
80101224:	89 e5                	mov    %esp,%ebp
80101226:	53                   	push   %ebx
80101227:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
8010122a:	8b 45 08             	mov    0x8(%ebp),%eax
8010122d:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101231:	84 c0                	test   %al,%al
80101233:	75 0a                	jne    8010123f <filewrite+0x1c>
    return -1;
80101235:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010123a:	e9 20 01 00 00       	jmp    8010135f <filewrite+0x13c>
  if(f->type == FD_PIPE)
8010123f:	8b 45 08             	mov    0x8(%ebp),%eax
80101242:	8b 00                	mov    (%eax),%eax
80101244:	83 f8 01             	cmp    $0x1,%eax
80101247:	75 21                	jne    8010126a <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
80101249:	8b 45 08             	mov    0x8(%ebp),%eax
8010124c:	8b 40 0c             	mov    0xc(%eax),%eax
8010124f:	8b 55 10             	mov    0x10(%ebp),%edx
80101252:	89 54 24 08          	mov    %edx,0x8(%esp)
80101256:	8b 55 0c             	mov    0xc(%ebp),%edx
80101259:	89 54 24 04          	mov    %edx,0x4(%esp)
8010125d:	89 04 24             	mov    %eax,(%esp)
80101260:	e8 c8 2e 00 00       	call   8010412d <pipewrite>
80101265:	e9 f5 00 00 00       	jmp    8010135f <filewrite+0x13c>
  if(f->type == FD_INODE){
8010126a:	8b 45 08             	mov    0x8(%ebp),%eax
8010126d:	8b 00                	mov    (%eax),%eax
8010126f:	83 f8 02             	cmp    $0x2,%eax
80101272:	0f 85 db 00 00 00    	jne    80101353 <filewrite+0x130>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101278:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
8010127f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101286:	e9 a8 00 00 00       	jmp    80101333 <filewrite+0x110>
      int n1 = n - i;
8010128b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010128e:	8b 55 10             	mov    0x10(%ebp),%edx
80101291:	29 c2                	sub    %eax,%edx
80101293:	89 d0                	mov    %edx,%eax
80101295:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101298:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010129b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010129e:	7e 06                	jle    801012a6 <filewrite+0x83>
        n1 = max;
801012a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801012a3:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
801012a6:	e8 8e 22 00 00       	call   80103539 <begin_op>
      ilock(f->ip);
801012ab:	8b 45 08             	mov    0x8(%ebp),%eax
801012ae:	8b 40 10             	mov    0x10(%eax),%eax
801012b1:	89 04 24             	mov    %eax,(%esp)
801012b4:	e8 b9 06 00 00       	call   80101972 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012b9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012bc:	8b 45 08             	mov    0x8(%ebp),%eax
801012bf:	8b 50 14             	mov    0x14(%eax),%edx
801012c2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801012c8:	01 c3                	add    %eax,%ebx
801012ca:	8b 45 08             	mov    0x8(%ebp),%eax
801012cd:	8b 40 10             	mov    0x10(%eax),%eax
801012d0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801012d4:	89 54 24 08          	mov    %edx,0x8(%esp)
801012d8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801012dc:	89 04 24             	mov    %eax,(%esp)
801012df:	e8 7c 0c 00 00       	call   80101f60 <writei>
801012e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012e7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012eb:	7e 11                	jle    801012fe <filewrite+0xdb>
        f->off += r;
801012ed:	8b 45 08             	mov    0x8(%ebp),%eax
801012f0:	8b 50 14             	mov    0x14(%eax),%edx
801012f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012f6:	01 c2                	add    %eax,%edx
801012f8:	8b 45 08             	mov    0x8(%ebp),%eax
801012fb:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101301:	8b 40 10             	mov    0x10(%eax),%eax
80101304:	89 04 24             	mov    %eax,(%esp)
80101307:	e8 7d 07 00 00       	call   80101a89 <iunlock>
      end_op();
8010130c:	e8 ac 22 00 00       	call   801035bd <end_op>

      if(r < 0)
80101311:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101315:	79 02                	jns    80101319 <filewrite+0xf6>
        break;
80101317:	eb 26                	jmp    8010133f <filewrite+0x11c>
      if(r != n1)
80101319:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010131c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010131f:	74 0c                	je     8010132d <filewrite+0x10a>
        panic("short filewrite");
80101321:	c7 04 24 28 86 10 80 	movl   $0x80108628,(%esp)
80101328:	e8 35 f2 ff ff       	call   80100562 <panic>
      i += r;
8010132d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101330:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101333:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101336:	3b 45 10             	cmp    0x10(%ebp),%eax
80101339:	0f 8c 4c ff ff ff    	jl     8010128b <filewrite+0x68>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010133f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101342:	3b 45 10             	cmp    0x10(%ebp),%eax
80101345:	75 05                	jne    8010134c <filewrite+0x129>
80101347:	8b 45 10             	mov    0x10(%ebp),%eax
8010134a:	eb 05                	jmp    80101351 <filewrite+0x12e>
8010134c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101351:	eb 0c                	jmp    8010135f <filewrite+0x13c>
  }
  panic("filewrite");
80101353:	c7 04 24 38 86 10 80 	movl   $0x80108638,(%esp)
8010135a:	e8 03 f2 ff ff       	call   80100562 <panic>
}
8010135f:	83 c4 24             	add    $0x24,%esp
80101362:	5b                   	pop    %ebx
80101363:	5d                   	pop    %ebp
80101364:	c3                   	ret    

80101365 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101365:	55                   	push   %ebp
80101366:	89 e5                	mov    %esp,%ebp
80101368:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;

  bp = bread(dev, 1);
8010136b:	8b 45 08             	mov    0x8(%ebp),%eax
8010136e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101375:	00 
80101376:	89 04 24             	mov    %eax,(%esp)
80101379:	e8 37 ee ff ff       	call   801001b5 <bread>
8010137e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101381:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101384:	83 c0 5c             	add    $0x5c,%eax
80101387:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
8010138e:	00 
8010138f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101393:	8b 45 0c             	mov    0xc(%ebp),%eax
80101396:	89 04 24             	mov    %eax,(%esp)
80101399:	e8 ea 3e 00 00       	call   80105288 <memmove>
  brelse(bp);
8010139e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013a1:	89 04 24             	mov    %eax,(%esp)
801013a4:	e8 83 ee ff ff       	call   8010022c <brelse>
}
801013a9:	c9                   	leave  
801013aa:	c3                   	ret    

801013ab <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801013ab:	55                   	push   %ebp
801013ac:	89 e5                	mov    %esp,%ebp
801013ae:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;

  bp = bread(dev, bno);
801013b1:	8b 55 0c             	mov    0xc(%ebp),%edx
801013b4:	8b 45 08             	mov    0x8(%ebp),%eax
801013b7:	89 54 24 04          	mov    %edx,0x4(%esp)
801013bb:	89 04 24             	mov    %eax,(%esp)
801013be:	e8 f2 ed ff ff       	call   801001b5 <bread>
801013c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013c9:	83 c0 5c             	add    $0x5c,%eax
801013cc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801013d3:	00 
801013d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801013db:	00 
801013dc:	89 04 24             	mov    %eax,(%esp)
801013df:	e8 d5 3d 00 00       	call   801051b9 <memset>
  log_write(bp);
801013e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013e7:	89 04 24             	mov    %eax,(%esp)
801013ea:	e8 55 23 00 00       	call   80103744 <log_write>
  brelse(bp);
801013ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013f2:	89 04 24             	mov    %eax,(%esp)
801013f5:	e8 32 ee ff ff       	call   8010022c <brelse>
}
801013fa:	c9                   	leave  
801013fb:	c3                   	ret    

801013fc <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013fc:	55                   	push   %ebp
801013fd:	89 e5                	mov    %esp,%ebp
801013ff:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101402:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101409:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101410:	e9 07 01 00 00       	jmp    8010151c <balloc+0x120>
    bp = bread(dev, BBLOCK(b, sb));
80101415:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101418:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010141e:	85 c0                	test   %eax,%eax
80101420:	0f 48 c2             	cmovs  %edx,%eax
80101423:	c1 f8 0c             	sar    $0xc,%eax
80101426:	89 c2                	mov    %eax,%edx
80101428:	a1 78 1a 11 80       	mov    0x80111a78,%eax
8010142d:	01 d0                	add    %edx,%eax
8010142f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101433:	8b 45 08             	mov    0x8(%ebp),%eax
80101436:	89 04 24             	mov    %eax,(%esp)
80101439:	e8 77 ed ff ff       	call   801001b5 <bread>
8010143e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101441:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101448:	e9 9d 00 00 00       	jmp    801014ea <balloc+0xee>
      m = 1 << (bi % 8);
8010144d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101450:	99                   	cltd   
80101451:	c1 ea 1d             	shr    $0x1d,%edx
80101454:	01 d0                	add    %edx,%eax
80101456:	83 e0 07             	and    $0x7,%eax
80101459:	29 d0                	sub    %edx,%eax
8010145b:	ba 01 00 00 00       	mov    $0x1,%edx
80101460:	89 c1                	mov    %eax,%ecx
80101462:	d3 e2                	shl    %cl,%edx
80101464:	89 d0                	mov    %edx,%eax
80101466:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101469:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010146c:	8d 50 07             	lea    0x7(%eax),%edx
8010146f:	85 c0                	test   %eax,%eax
80101471:	0f 48 c2             	cmovs  %edx,%eax
80101474:	c1 f8 03             	sar    $0x3,%eax
80101477:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010147a:	0f b6 44 02 5c       	movzbl 0x5c(%edx,%eax,1),%eax
8010147f:	0f b6 c0             	movzbl %al,%eax
80101482:	23 45 e8             	and    -0x18(%ebp),%eax
80101485:	85 c0                	test   %eax,%eax
80101487:	75 5d                	jne    801014e6 <balloc+0xea>
        bp->data[bi/8] |= m;  // Mark block in use.
80101489:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010148c:	8d 50 07             	lea    0x7(%eax),%edx
8010148f:	85 c0                	test   %eax,%eax
80101491:	0f 48 c2             	cmovs  %edx,%eax
80101494:	c1 f8 03             	sar    $0x3,%eax
80101497:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010149a:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
8010149f:	89 d1                	mov    %edx,%ecx
801014a1:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014a4:	09 ca                	or     %ecx,%edx
801014a6:	89 d1                	mov    %edx,%ecx
801014a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014ab:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
801014af:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014b2:	89 04 24             	mov    %eax,(%esp)
801014b5:	e8 8a 22 00 00       	call   80103744 <log_write>
        brelse(bp);
801014ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014bd:	89 04 24             	mov    %eax,(%esp)
801014c0:	e8 67 ed ff ff       	call   8010022c <brelse>
        bzero(dev, b + bi);
801014c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014cb:	01 c2                	add    %eax,%edx
801014cd:	8b 45 08             	mov    0x8(%ebp),%eax
801014d0:	89 54 24 04          	mov    %edx,0x4(%esp)
801014d4:	89 04 24             	mov    %eax,(%esp)
801014d7:	e8 cf fe ff ff       	call   801013ab <bzero>
        return b + bi;
801014dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014df:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014e2:	01 d0                	add    %edx,%eax
801014e4:	eb 52                	jmp    80101538 <balloc+0x13c>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014e6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014ea:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014f1:	7f 17                	jg     8010150a <balloc+0x10e>
801014f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014f9:	01 d0                	add    %edx,%eax
801014fb:	89 c2                	mov    %eax,%edx
801014fd:	a1 60 1a 11 80       	mov    0x80111a60,%eax
80101502:	39 c2                	cmp    %eax,%edx
80101504:	0f 82 43 ff ff ff    	jb     8010144d <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010150a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010150d:	89 04 24             	mov    %eax,(%esp)
80101510:	e8 17 ed ff ff       	call   8010022c <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101515:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010151c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010151f:	a1 60 1a 11 80       	mov    0x80111a60,%eax
80101524:	39 c2                	cmp    %eax,%edx
80101526:	0f 82 e9 fe ff ff    	jb     80101415 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010152c:	c7 04 24 44 86 10 80 	movl   $0x80108644,(%esp)
80101533:	e8 2a f0 ff ff       	call   80100562 <panic>
}
80101538:	c9                   	leave  
80101539:	c3                   	ret    

8010153a <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010153a:	55                   	push   %ebp
8010153b:	89 e5                	mov    %esp,%ebp
8010153d:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101540:	c7 44 24 04 60 1a 11 	movl   $0x80111a60,0x4(%esp)
80101547:	80 
80101548:	8b 45 08             	mov    0x8(%ebp),%eax
8010154b:	89 04 24             	mov    %eax,(%esp)
8010154e:	e8 12 fe ff ff       	call   80101365 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101553:	8b 45 0c             	mov    0xc(%ebp),%eax
80101556:	c1 e8 0c             	shr    $0xc,%eax
80101559:	89 c2                	mov    %eax,%edx
8010155b:	a1 78 1a 11 80       	mov    0x80111a78,%eax
80101560:	01 c2                	add    %eax,%edx
80101562:	8b 45 08             	mov    0x8(%ebp),%eax
80101565:	89 54 24 04          	mov    %edx,0x4(%esp)
80101569:	89 04 24             	mov    %eax,(%esp)
8010156c:	e8 44 ec ff ff       	call   801001b5 <bread>
80101571:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101574:	8b 45 0c             	mov    0xc(%ebp),%eax
80101577:	25 ff 0f 00 00       	and    $0xfff,%eax
8010157c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010157f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101582:	99                   	cltd   
80101583:	c1 ea 1d             	shr    $0x1d,%edx
80101586:	01 d0                	add    %edx,%eax
80101588:	83 e0 07             	and    $0x7,%eax
8010158b:	29 d0                	sub    %edx,%eax
8010158d:	ba 01 00 00 00       	mov    $0x1,%edx
80101592:	89 c1                	mov    %eax,%ecx
80101594:	d3 e2                	shl    %cl,%edx
80101596:	89 d0                	mov    %edx,%eax
80101598:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010159b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010159e:	8d 50 07             	lea    0x7(%eax),%edx
801015a1:	85 c0                	test   %eax,%eax
801015a3:	0f 48 c2             	cmovs  %edx,%eax
801015a6:	c1 f8 03             	sar    $0x3,%eax
801015a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015ac:	0f b6 44 02 5c       	movzbl 0x5c(%edx,%eax,1),%eax
801015b1:	0f b6 c0             	movzbl %al,%eax
801015b4:	23 45 ec             	and    -0x14(%ebp),%eax
801015b7:	85 c0                	test   %eax,%eax
801015b9:	75 0c                	jne    801015c7 <bfree+0x8d>
    panic("freeing free block");
801015bb:	c7 04 24 5a 86 10 80 	movl   $0x8010865a,(%esp)
801015c2:	e8 9b ef ff ff       	call   80100562 <panic>
  bp->data[bi/8] &= ~m;
801015c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015ca:	8d 50 07             	lea    0x7(%eax),%edx
801015cd:	85 c0                	test   %eax,%eax
801015cf:	0f 48 c2             	cmovs  %edx,%eax
801015d2:	c1 f8 03             	sar    $0x3,%eax
801015d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015d8:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
801015dd:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801015e0:	f7 d1                	not    %ecx
801015e2:	21 ca                	and    %ecx,%edx
801015e4:	89 d1                	mov    %edx,%ecx
801015e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015e9:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
801015ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015f0:	89 04 24             	mov    %eax,(%esp)
801015f3:	e8 4c 21 00 00       	call   80103744 <log_write>
  brelse(bp);
801015f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015fb:	89 04 24             	mov    %eax,(%esp)
801015fe:	e8 29 ec ff ff       	call   8010022c <brelse>
}
80101603:	c9                   	leave  
80101604:	c3                   	ret    

80101605 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101605:	55                   	push   %ebp
80101606:	89 e5                	mov    %esp,%ebp
80101608:	57                   	push   %edi
80101609:	56                   	push   %esi
8010160a:	53                   	push   %ebx
8010160b:	83 ec 4c             	sub    $0x4c,%esp
  int i = 0;
8010160e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
80101615:	c7 44 24 04 6d 86 10 	movl   $0x8010866d,0x4(%esp)
8010161c:	80 
8010161d:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101624:	e8 06 39 00 00       	call   80104f2f <initlock>
  for(i = 0; i < NINODE; i++) {
80101629:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101630:	eb 2c                	jmp    8010165e <iinit+0x59>
    initsleeplock(&icache.inode[i].lock, "inode");
80101632:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101635:	89 d0                	mov    %edx,%eax
80101637:	c1 e0 03             	shl    $0x3,%eax
8010163a:	01 d0                	add    %edx,%eax
8010163c:	c1 e0 04             	shl    $0x4,%eax
8010163f:	83 c0 30             	add    $0x30,%eax
80101642:	05 80 1a 11 80       	add    $0x80111a80,%eax
80101647:	83 c0 10             	add    $0x10,%eax
8010164a:	c7 44 24 04 74 86 10 	movl   $0x80108674,0x4(%esp)
80101651:	80 
80101652:	89 04 24             	mov    %eax,(%esp)
80101655:	e8 98 37 00 00       	call   80104df2 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
8010165a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010165e:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101662:	7e ce                	jle    80101632 <iinit+0x2d>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
80101664:	c7 44 24 04 60 1a 11 	movl   $0x80111a60,0x4(%esp)
8010166b:	80 
8010166c:	8b 45 08             	mov    0x8(%ebp),%eax
8010166f:	89 04 24             	mov    %eax,(%esp)
80101672:	e8 ee fc ff ff       	call   80101365 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101677:	a1 78 1a 11 80       	mov    0x80111a78,%eax
8010167c:	8b 3d 74 1a 11 80    	mov    0x80111a74,%edi
80101682:	8b 35 70 1a 11 80    	mov    0x80111a70,%esi
80101688:	8b 1d 6c 1a 11 80    	mov    0x80111a6c,%ebx
8010168e:	8b 0d 68 1a 11 80    	mov    0x80111a68,%ecx
80101694:	8b 15 64 1a 11 80    	mov    0x80111a64,%edx
8010169a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010169d:	8b 15 60 1a 11 80    	mov    0x80111a60,%edx
801016a3:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801016a7:	89 7c 24 18          	mov    %edi,0x18(%esp)
801016ab:	89 74 24 14          	mov    %esi,0x14(%esp)
801016af:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801016b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801016b7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801016ba:	89 44 24 08          	mov    %eax,0x8(%esp)
801016be:	89 d0                	mov    %edx,%eax
801016c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801016c4:	c7 04 24 7c 86 10 80 	movl   $0x8010867c,(%esp)
801016cb:	e8 f8 ec ff ff       	call   801003c8 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801016d0:	83 c4 4c             	add    $0x4c,%esp
801016d3:	5b                   	pop    %ebx
801016d4:	5e                   	pop    %esi
801016d5:	5f                   	pop    %edi
801016d6:	5d                   	pop    %ebp
801016d7:	c3                   	ret    

801016d8 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801016d8:	55                   	push   %ebp
801016d9:	89 e5                	mov    %esp,%ebp
801016db:	83 ec 28             	sub    $0x28,%esp
801016de:	8b 45 0c             	mov    0xc(%ebp),%eax
801016e1:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016e5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801016ec:	e9 9e 00 00 00       	jmp    8010178f <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
801016f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016f4:	c1 e8 03             	shr    $0x3,%eax
801016f7:	89 c2                	mov    %eax,%edx
801016f9:	a1 74 1a 11 80       	mov    0x80111a74,%eax
801016fe:	01 d0                	add    %edx,%eax
80101700:	89 44 24 04          	mov    %eax,0x4(%esp)
80101704:	8b 45 08             	mov    0x8(%ebp),%eax
80101707:	89 04 24             	mov    %eax,(%esp)
8010170a:	e8 a6 ea ff ff       	call   801001b5 <bread>
8010170f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101712:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101715:	8d 50 5c             	lea    0x5c(%eax),%edx
80101718:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010171b:	83 e0 07             	and    $0x7,%eax
8010171e:	c1 e0 06             	shl    $0x6,%eax
80101721:	01 d0                	add    %edx,%eax
80101723:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101726:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101729:	0f b7 00             	movzwl (%eax),%eax
8010172c:	66 85 c0             	test   %ax,%ax
8010172f:	75 4f                	jne    80101780 <ialloc+0xa8>
      memset(dip, 0, sizeof(*dip));
80101731:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101738:	00 
80101739:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101740:	00 
80101741:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101744:	89 04 24             	mov    %eax,(%esp)
80101747:	e8 6d 3a 00 00       	call   801051b9 <memset>
      dip->type = type;
8010174c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010174f:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
80101753:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101756:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101759:	89 04 24             	mov    %eax,(%esp)
8010175c:	e8 e3 1f 00 00       	call   80103744 <log_write>
      brelse(bp);
80101761:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101764:	89 04 24             	mov    %eax,(%esp)
80101767:	e8 c0 ea ff ff       	call   8010022c <brelse>
      return iget(dev, inum);
8010176c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010176f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101773:	8b 45 08             	mov    0x8(%ebp),%eax
80101776:	89 04 24             	mov    %eax,(%esp)
80101779:	e8 ed 00 00 00       	call   8010186b <iget>
8010177e:	eb 2b                	jmp    801017ab <ialloc+0xd3>
    }
    brelse(bp);
80101780:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101783:	89 04 24             	mov    %eax,(%esp)
80101786:	e8 a1 ea ff ff       	call   8010022c <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010178b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010178f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101792:	a1 68 1a 11 80       	mov    0x80111a68,%eax
80101797:	39 c2                	cmp    %eax,%edx
80101799:	0f 82 52 ff ff ff    	jb     801016f1 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010179f:	c7 04 24 cf 86 10 80 	movl   $0x801086cf,(%esp)
801017a6:	e8 b7 ed ff ff       	call   80100562 <panic>
}
801017ab:	c9                   	leave  
801017ac:	c3                   	ret    

801017ad <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801017ad:	55                   	push   %ebp
801017ae:	89 e5                	mov    %esp,%ebp
801017b0:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017b3:	8b 45 08             	mov    0x8(%ebp),%eax
801017b6:	8b 40 04             	mov    0x4(%eax),%eax
801017b9:	c1 e8 03             	shr    $0x3,%eax
801017bc:	89 c2                	mov    %eax,%edx
801017be:	a1 74 1a 11 80       	mov    0x80111a74,%eax
801017c3:	01 c2                	add    %eax,%edx
801017c5:	8b 45 08             	mov    0x8(%ebp),%eax
801017c8:	8b 00                	mov    (%eax),%eax
801017ca:	89 54 24 04          	mov    %edx,0x4(%esp)
801017ce:	89 04 24             	mov    %eax,(%esp)
801017d1:	e8 df e9 ff ff       	call   801001b5 <bread>
801017d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017dc:	8d 50 5c             	lea    0x5c(%eax),%edx
801017df:	8b 45 08             	mov    0x8(%ebp),%eax
801017e2:	8b 40 04             	mov    0x4(%eax),%eax
801017e5:	83 e0 07             	and    $0x7,%eax
801017e8:	c1 e0 06             	shl    $0x6,%eax
801017eb:	01 d0                	add    %edx,%eax
801017ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017f0:	8b 45 08             	mov    0x8(%ebp),%eax
801017f3:	0f b7 50 50          	movzwl 0x50(%eax),%edx
801017f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017fa:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101800:	0f b7 50 52          	movzwl 0x52(%eax),%edx
80101804:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101807:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010180b:	8b 45 08             	mov    0x8(%ebp),%eax
8010180e:	0f b7 50 54          	movzwl 0x54(%eax),%edx
80101812:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101815:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101819:	8b 45 08             	mov    0x8(%ebp),%eax
8010181c:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101820:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101823:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101827:	8b 45 08             	mov    0x8(%ebp),%eax
8010182a:	8b 50 58             	mov    0x58(%eax),%edx
8010182d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101830:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101833:	8b 45 08             	mov    0x8(%ebp),%eax
80101836:	8d 50 5c             	lea    0x5c(%eax),%edx
80101839:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010183c:	83 c0 0c             	add    $0xc,%eax
8010183f:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101846:	00 
80101847:	89 54 24 04          	mov    %edx,0x4(%esp)
8010184b:	89 04 24             	mov    %eax,(%esp)
8010184e:	e8 35 3a 00 00       	call   80105288 <memmove>
  log_write(bp);
80101853:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101856:	89 04 24             	mov    %eax,(%esp)
80101859:	e8 e6 1e 00 00       	call   80103744 <log_write>
  brelse(bp);
8010185e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101861:	89 04 24             	mov    %eax,(%esp)
80101864:	e8 c3 e9 ff ff       	call   8010022c <brelse>
}
80101869:	c9                   	leave  
8010186a:	c3                   	ret    

8010186b <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010186b:	55                   	push   %ebp
8010186c:	89 e5                	mov    %esp,%ebp
8010186e:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101871:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101878:	e8 d3 36 00 00       	call   80104f50 <acquire>

  // Is the inode already cached?
  empty = 0;
8010187d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101884:	c7 45 f4 b4 1a 11 80 	movl   $0x80111ab4,-0xc(%ebp)
8010188b:	eb 5c                	jmp    801018e9 <iget+0x7e>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010188d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101890:	8b 40 08             	mov    0x8(%eax),%eax
80101893:	85 c0                	test   %eax,%eax
80101895:	7e 35                	jle    801018cc <iget+0x61>
80101897:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010189a:	8b 00                	mov    (%eax),%eax
8010189c:	3b 45 08             	cmp    0x8(%ebp),%eax
8010189f:	75 2b                	jne    801018cc <iget+0x61>
801018a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a4:	8b 40 04             	mov    0x4(%eax),%eax
801018a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
801018aa:	75 20                	jne    801018cc <iget+0x61>
      ip->ref++;
801018ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018af:	8b 40 08             	mov    0x8(%eax),%eax
801018b2:	8d 50 01             	lea    0x1(%eax),%edx
801018b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018b8:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801018bb:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
801018c2:	e8 f0 36 00 00       	call   80104fb7 <release>
      return ip;
801018c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ca:	eb 72                	jmp    8010193e <iget+0xd3>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018d0:	75 10                	jne    801018e2 <iget+0x77>
801018d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d5:	8b 40 08             	mov    0x8(%eax),%eax
801018d8:	85 c0                	test   %eax,%eax
801018da:	75 06                	jne    801018e2 <iget+0x77>
      empty = ip;
801018dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018df:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018e2:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
801018e9:	81 7d f4 d4 36 11 80 	cmpl   $0x801136d4,-0xc(%ebp)
801018f0:	72 9b                	jb     8010188d <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801018f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018f6:	75 0c                	jne    80101904 <iget+0x99>
    panic("iget: no inodes");
801018f8:	c7 04 24 e1 86 10 80 	movl   $0x801086e1,(%esp)
801018ff:	e8 5e ec ff ff       	call   80100562 <panic>

  ip = empty;
80101904:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101907:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
8010190a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010190d:	8b 55 08             	mov    0x8(%ebp),%edx
80101910:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101912:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101915:	8b 55 0c             	mov    0xc(%ebp),%edx
80101918:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
8010191b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010191e:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101925:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101928:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
8010192f:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101936:	e8 7c 36 00 00       	call   80104fb7 <release>

  return ip;
8010193b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010193e:	c9                   	leave  
8010193f:	c3                   	ret    

80101940 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101946:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
8010194d:	e8 fe 35 00 00       	call   80104f50 <acquire>
  ip->ref++;
80101952:	8b 45 08             	mov    0x8(%ebp),%eax
80101955:	8b 40 08             	mov    0x8(%eax),%eax
80101958:	8d 50 01             	lea    0x1(%eax),%edx
8010195b:	8b 45 08             	mov    0x8(%ebp),%eax
8010195e:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101961:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101968:	e8 4a 36 00 00       	call   80104fb7 <release>
  return ip;
8010196d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101970:	c9                   	leave  
80101971:	c3                   	ret    

80101972 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101972:	55                   	push   %ebp
80101973:	89 e5                	mov    %esp,%ebp
80101975:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101978:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010197c:	74 0a                	je     80101988 <ilock+0x16>
8010197e:	8b 45 08             	mov    0x8(%ebp),%eax
80101981:	8b 40 08             	mov    0x8(%eax),%eax
80101984:	85 c0                	test   %eax,%eax
80101986:	7f 0c                	jg     80101994 <ilock+0x22>
    panic("ilock");
80101988:	c7 04 24 f1 86 10 80 	movl   $0x801086f1,(%esp)
8010198f:	e8 ce eb ff ff       	call   80100562 <panic>

  acquiresleep(&ip->lock);
80101994:	8b 45 08             	mov    0x8(%ebp),%eax
80101997:	83 c0 0c             	add    $0xc,%eax
8010199a:	89 04 24             	mov    %eax,(%esp)
8010199d:	e8 8a 34 00 00       	call   80104e2c <acquiresleep>

  if(!(ip->flags & I_VALID)){
801019a2:	8b 45 08             	mov    0x8(%ebp),%eax
801019a5:	8b 40 4c             	mov    0x4c(%eax),%eax
801019a8:	83 e0 02             	and    $0x2,%eax
801019ab:	85 c0                	test   %eax,%eax
801019ad:	0f 85 d4 00 00 00    	jne    80101a87 <ilock+0x115>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019b3:	8b 45 08             	mov    0x8(%ebp),%eax
801019b6:	8b 40 04             	mov    0x4(%eax),%eax
801019b9:	c1 e8 03             	shr    $0x3,%eax
801019bc:	89 c2                	mov    %eax,%edx
801019be:	a1 74 1a 11 80       	mov    0x80111a74,%eax
801019c3:	01 c2                	add    %eax,%edx
801019c5:	8b 45 08             	mov    0x8(%ebp),%eax
801019c8:	8b 00                	mov    (%eax),%eax
801019ca:	89 54 24 04          	mov    %edx,0x4(%esp)
801019ce:	89 04 24             	mov    %eax,(%esp)
801019d1:	e8 df e7 ff ff       	call   801001b5 <bread>
801019d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019dc:	8d 50 5c             	lea    0x5c(%eax),%edx
801019df:	8b 45 08             	mov    0x8(%ebp),%eax
801019e2:	8b 40 04             	mov    0x4(%eax),%eax
801019e5:	83 e0 07             	and    $0x7,%eax
801019e8:	c1 e0 06             	shl    $0x6,%eax
801019eb:	01 d0                	add    %edx,%eax
801019ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f3:	0f b7 10             	movzwl (%eax),%edx
801019f6:	8b 45 08             	mov    0x8(%ebp),%eax
801019f9:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
801019fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a00:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a04:	8b 45 08             	mov    0x8(%ebp),%eax
80101a07:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a0e:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a12:	8b 45 08             	mov    0x8(%ebp),%eax
80101a15:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a1c:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a20:	8b 45 08             	mov    0x8(%ebp),%eax
80101a23:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a2a:	8b 50 08             	mov    0x8(%eax),%edx
80101a2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a30:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a33:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a36:	8d 50 0c             	lea    0xc(%eax),%edx
80101a39:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3c:	83 c0 5c             	add    $0x5c,%eax
80101a3f:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101a46:	00 
80101a47:	89 54 24 04          	mov    %edx,0x4(%esp)
80101a4b:	89 04 24             	mov    %eax,(%esp)
80101a4e:	e8 35 38 00 00       	call   80105288 <memmove>
    brelse(bp);
80101a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a56:	89 04 24             	mov    %eax,(%esp)
80101a59:	e8 ce e7 ff ff       	call   8010022c <brelse>
    ip->flags |= I_VALID;
80101a5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a61:	8b 40 4c             	mov    0x4c(%eax),%eax
80101a64:	83 c8 02             	or     $0x2,%eax
80101a67:	89 c2                	mov    %eax,%edx
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	89 50 4c             	mov    %edx,0x4c(%eax)
    if(ip->type == 0)
80101a6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a72:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101a76:	66 85 c0             	test   %ax,%ax
80101a79:	75 0c                	jne    80101a87 <ilock+0x115>
      panic("ilock: no type");
80101a7b:	c7 04 24 f7 86 10 80 	movl   $0x801086f7,(%esp)
80101a82:	e8 db ea ff ff       	call   80100562 <panic>
  }
}
80101a87:	c9                   	leave  
80101a88:	c3                   	ret    

80101a89 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a89:	55                   	push   %ebp
80101a8a:	89 e5                	mov    %esp,%ebp
80101a8c:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a8f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a93:	74 1c                	je     80101ab1 <iunlock+0x28>
80101a95:	8b 45 08             	mov    0x8(%ebp),%eax
80101a98:	83 c0 0c             	add    $0xc,%eax
80101a9b:	89 04 24             	mov    %eax,(%esp)
80101a9e:	e8 27 34 00 00       	call   80104eca <holdingsleep>
80101aa3:	85 c0                	test   %eax,%eax
80101aa5:	74 0a                	je     80101ab1 <iunlock+0x28>
80101aa7:	8b 45 08             	mov    0x8(%ebp),%eax
80101aaa:	8b 40 08             	mov    0x8(%eax),%eax
80101aad:	85 c0                	test   %eax,%eax
80101aaf:	7f 0c                	jg     80101abd <iunlock+0x34>
    panic("iunlock");
80101ab1:	c7 04 24 06 87 10 80 	movl   $0x80108706,(%esp)
80101ab8:	e8 a5 ea ff ff       	call   80100562 <panic>

  releasesleep(&ip->lock);
80101abd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac0:	83 c0 0c             	add    $0xc,%eax
80101ac3:	89 04 24             	mov    %eax,(%esp)
80101ac6:	e8 bd 33 00 00       	call   80104e88 <releasesleep>
}
80101acb:	c9                   	leave  
80101acc:	c3                   	ret    

80101acd <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101acd:	55                   	push   %ebp
80101ace:	89 e5                	mov    %esp,%ebp
80101ad0:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101ad3:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101ada:	e8 71 34 00 00       	call   80104f50 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101adf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae2:	8b 40 08             	mov    0x8(%eax),%eax
80101ae5:	83 f8 01             	cmp    $0x1,%eax
80101ae8:	75 5a                	jne    80101b44 <iput+0x77>
80101aea:	8b 45 08             	mov    0x8(%ebp),%eax
80101aed:	8b 40 4c             	mov    0x4c(%eax),%eax
80101af0:	83 e0 02             	and    $0x2,%eax
80101af3:	85 c0                	test   %eax,%eax
80101af5:	74 4d                	je     80101b44 <iput+0x77>
80101af7:	8b 45 08             	mov    0x8(%ebp),%eax
80101afa:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101afe:	66 85 c0             	test   %ax,%ax
80101b01:	75 41                	jne    80101b44 <iput+0x77>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
80101b03:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101b0a:	e8 a8 34 00 00       	call   80104fb7 <release>
    itrunc(ip);
80101b0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b12:	89 04 24             	mov    %eax,(%esp)
80101b15:	e8 78 01 00 00       	call   80101c92 <itrunc>
    ip->type = 0;
80101b1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1d:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
    iupdate(ip);
80101b23:	8b 45 08             	mov    0x8(%ebp),%eax
80101b26:	89 04 24             	mov    %eax,(%esp)
80101b29:	e8 7f fc ff ff       	call   801017ad <iupdate>
    acquire(&icache.lock);
80101b2e:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101b35:	e8 16 34 00 00       	call   80104f50 <acquire>
    ip->flags = 0;
80101b3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3d:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }
  ip->ref--;
80101b44:	8b 45 08             	mov    0x8(%ebp),%eax
80101b47:	8b 40 08             	mov    0x8(%eax),%eax
80101b4a:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b50:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101b53:	c7 04 24 80 1a 11 80 	movl   $0x80111a80,(%esp)
80101b5a:	e8 58 34 00 00       	call   80104fb7 <release>
}
80101b5f:	c9                   	leave  
80101b60:	c3                   	ret    

80101b61 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b61:	55                   	push   %ebp
80101b62:	89 e5                	mov    %esp,%ebp
80101b64:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101b67:	8b 45 08             	mov    0x8(%ebp),%eax
80101b6a:	89 04 24             	mov    %eax,(%esp)
80101b6d:	e8 17 ff ff ff       	call   80101a89 <iunlock>
  iput(ip);
80101b72:	8b 45 08             	mov    0x8(%ebp),%eax
80101b75:	89 04 24             	mov    %eax,(%esp)
80101b78:	e8 50 ff ff ff       	call   80101acd <iput>
}
80101b7d:	c9                   	leave  
80101b7e:	c3                   	ret    

80101b7f <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101b7f:	55                   	push   %ebp
80101b80:	89 e5                	mov    %esp,%ebp
80101b82:	53                   	push   %ebx
80101b83:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101b86:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101b8a:	77 3e                	ja     80101bca <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101b8c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b92:	83 c2 14             	add    $0x14,%edx
80101b95:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101b99:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ba0:	75 20                	jne    80101bc2 <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101ba2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba5:	8b 00                	mov    (%eax),%eax
80101ba7:	89 04 24             	mov    %eax,(%esp)
80101baa:	e8 4d f8 ff ff       	call   801013fc <balloc>
80101baf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bb2:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb5:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bb8:	8d 4a 14             	lea    0x14(%edx),%ecx
80101bbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101bbe:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bc5:	e9 c2 00 00 00       	jmp    80101c8c <bmap+0x10d>
  }
  bn -= NDIRECT;
80101bca:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101bce:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101bd2:	0f 87 a8 00 00 00    	ja     80101c80 <bmap+0x101>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101bd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdb:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101be1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101be4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101be8:	75 1c                	jne    80101c06 <bmap+0x87>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101bea:	8b 45 08             	mov    0x8(%ebp),%eax
80101bed:	8b 00                	mov    (%eax),%eax
80101bef:	89 04 24             	mov    %eax,(%esp)
80101bf2:	e8 05 f8 ff ff       	call   801013fc <balloc>
80101bf7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bfa:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c00:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101c06:	8b 45 08             	mov    0x8(%ebp),%eax
80101c09:	8b 00                	mov    (%eax),%eax
80101c0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c0e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c12:	89 04 24             	mov    %eax,(%esp)
80101c15:	e8 9b e5 ff ff       	call   801001b5 <bread>
80101c1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c20:	83 c0 5c             	add    $0x5c,%eax
80101c23:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c26:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c29:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c30:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c33:	01 d0                	add    %edx,%eax
80101c35:	8b 00                	mov    (%eax),%eax
80101c37:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c3a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c3e:	75 30                	jne    80101c70 <bmap+0xf1>
      a[bn] = addr = balloc(ip->dev);
80101c40:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c4d:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101c50:	8b 45 08             	mov    0x8(%ebp),%eax
80101c53:	8b 00                	mov    (%eax),%eax
80101c55:	89 04 24             	mov    %eax,(%esp)
80101c58:	e8 9f f7 ff ff       	call   801013fc <balloc>
80101c5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c63:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c68:	89 04 24             	mov    %eax,(%esp)
80101c6b:	e8 d4 1a 00 00       	call   80103744 <log_write>
    }
    brelse(bp);
80101c70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c73:	89 04 24             	mov    %eax,(%esp)
80101c76:	e8 b1 e5 ff ff       	call   8010022c <brelse>
    return addr;
80101c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c7e:	eb 0c                	jmp    80101c8c <bmap+0x10d>
  }

  panic("bmap: out of range");
80101c80:	c7 04 24 0e 87 10 80 	movl   $0x8010870e,(%esp)
80101c87:	e8 d6 e8 ff ff       	call   80100562 <panic>
}
80101c8c:	83 c4 24             	add    $0x24,%esp
80101c8f:	5b                   	pop    %ebx
80101c90:	5d                   	pop    %ebp
80101c91:	c3                   	ret    

80101c92 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101c92:	55                   	push   %ebp
80101c93:	89 e5                	mov    %esp,%ebp
80101c95:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101c9f:	eb 44                	jmp    80101ce5 <itrunc+0x53>
    if(ip->addrs[i]){
80101ca1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ca4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ca7:	83 c2 14             	add    $0x14,%edx
80101caa:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101cae:	85 c0                	test   %eax,%eax
80101cb0:	74 2f                	je     80101ce1 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101cb2:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cb8:	83 c2 14             	add    $0x14,%edx
80101cbb:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101cbf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc2:	8b 00                	mov    (%eax),%eax
80101cc4:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cc8:	89 04 24             	mov    %eax,(%esp)
80101ccb:	e8 6a f8 ff ff       	call   8010153a <bfree>
      ip->addrs[i] = 0;
80101cd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cd6:	83 c2 14             	add    $0x14,%edx
80101cd9:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101ce0:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101ce1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101ce5:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101ce9:	7e b6                	jle    80101ca1 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
80101ceb:	8b 45 08             	mov    0x8(%ebp),%eax
80101cee:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101cf4:	85 c0                	test   %eax,%eax
80101cf6:	0f 84 a4 00 00 00    	je     80101da0 <itrunc+0x10e>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101cfc:	8b 45 08             	mov    0x8(%ebp),%eax
80101cff:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101d05:	8b 45 08             	mov    0x8(%ebp),%eax
80101d08:	8b 00                	mov    (%eax),%eax
80101d0a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d0e:	89 04 24             	mov    %eax,(%esp)
80101d11:	e8 9f e4 ff ff       	call   801001b5 <bread>
80101d16:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d19:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d1c:	83 c0 5c             	add    $0x5c,%eax
80101d1f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d29:	eb 3b                	jmp    80101d66 <itrunc+0xd4>
      if(a[j])
80101d2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d35:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d38:	01 d0                	add    %edx,%eax
80101d3a:	8b 00                	mov    (%eax),%eax
80101d3c:	85 c0                	test   %eax,%eax
80101d3e:	74 22                	je     80101d62 <itrunc+0xd0>
        bfree(ip->dev, a[j]);
80101d40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d4d:	01 d0                	add    %edx,%eax
80101d4f:	8b 10                	mov    (%eax),%edx
80101d51:	8b 45 08             	mov    0x8(%ebp),%eax
80101d54:	8b 00                	mov    (%eax),%eax
80101d56:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d5a:	89 04 24             	mov    %eax,(%esp)
80101d5d:	e8 d8 f7 ff ff       	call   8010153a <bfree>
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101d62:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d69:	83 f8 7f             	cmp    $0x7f,%eax
80101d6c:	76 bd                	jbe    80101d2b <itrunc+0x99>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101d6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d71:	89 04 24             	mov    %eax,(%esp)
80101d74:	e8 b3 e4 ff ff       	call   8010022c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101d79:	8b 45 08             	mov    0x8(%ebp),%eax
80101d7c:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101d82:	8b 45 08             	mov    0x8(%ebp),%eax
80101d85:	8b 00                	mov    (%eax),%eax
80101d87:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d8b:	89 04 24             	mov    %eax,(%esp)
80101d8e:	e8 a7 f7 ff ff       	call   8010153a <bfree>
    ip->addrs[NDIRECT] = 0;
80101d93:	8b 45 08             	mov    0x8(%ebp),%eax
80101d96:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101d9d:	00 00 00 
  }

  ip->size = 0;
80101da0:	8b 45 08             	mov    0x8(%ebp),%eax
80101da3:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101daa:	8b 45 08             	mov    0x8(%ebp),%eax
80101dad:	89 04 24             	mov    %eax,(%esp)
80101db0:	e8 f8 f9 ff ff       	call   801017ad <iupdate>
}
80101db5:	c9                   	leave  
80101db6:	c3                   	ret    

80101db7 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101db7:	55                   	push   %ebp
80101db8:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101dba:	8b 45 08             	mov    0x8(%ebp),%eax
80101dbd:	8b 00                	mov    (%eax),%eax
80101dbf:	89 c2                	mov    %eax,%edx
80101dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dc4:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101dc7:	8b 45 08             	mov    0x8(%ebp),%eax
80101dca:	8b 50 04             	mov    0x4(%eax),%edx
80101dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dd0:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101dd3:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd6:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101dda:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ddd:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101de0:	8b 45 08             	mov    0x8(%ebp),%eax
80101de3:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101de7:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dea:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101dee:	8b 45 08             	mov    0x8(%ebp),%eax
80101df1:	8b 50 58             	mov    0x58(%eax),%edx
80101df4:	8b 45 0c             	mov    0xc(%ebp),%eax
80101df7:	89 50 10             	mov    %edx,0x10(%eax)
}
80101dfa:	5d                   	pop    %ebp
80101dfb:	c3                   	ret    

80101dfc <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101dfc:	55                   	push   %ebp
80101dfd:	89 e5                	mov    %esp,%ebp
80101dff:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e02:	8b 45 08             	mov    0x8(%ebp),%eax
80101e05:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101e09:	66 83 f8 03          	cmp    $0x3,%ax
80101e0d:	75 60                	jne    80101e6f <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e12:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e16:	66 85 c0             	test   %ax,%ax
80101e19:	78 20                	js     80101e3b <readi+0x3f>
80101e1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1e:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e22:	66 83 f8 09          	cmp    $0x9,%ax
80101e26:	7f 13                	jg     80101e3b <readi+0x3f>
80101e28:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2b:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e2f:	98                   	cwtl   
80101e30:	8b 04 c5 00 1a 11 80 	mov    -0x7feee600(,%eax,8),%eax
80101e37:	85 c0                	test   %eax,%eax
80101e39:	75 0a                	jne    80101e45 <readi+0x49>
      return -1;
80101e3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e40:	e9 19 01 00 00       	jmp    80101f5e <readi+0x162>
    return devsw[ip->major].read(ip, dst, n);
80101e45:	8b 45 08             	mov    0x8(%ebp),%eax
80101e48:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101e4c:	98                   	cwtl   
80101e4d:	8b 04 c5 00 1a 11 80 	mov    -0x7feee600(,%eax,8),%eax
80101e54:	8b 55 14             	mov    0x14(%ebp),%edx
80101e57:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e5e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e62:	8b 55 08             	mov    0x8(%ebp),%edx
80101e65:	89 14 24             	mov    %edx,(%esp)
80101e68:	ff d0                	call   *%eax
80101e6a:	e9 ef 00 00 00       	jmp    80101f5e <readi+0x162>
  }

  if(off > ip->size || off + n < off)
80101e6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e72:	8b 40 58             	mov    0x58(%eax),%eax
80101e75:	3b 45 10             	cmp    0x10(%ebp),%eax
80101e78:	72 0d                	jb     80101e87 <readi+0x8b>
80101e7a:	8b 45 14             	mov    0x14(%ebp),%eax
80101e7d:	8b 55 10             	mov    0x10(%ebp),%edx
80101e80:	01 d0                	add    %edx,%eax
80101e82:	3b 45 10             	cmp    0x10(%ebp),%eax
80101e85:	73 0a                	jae    80101e91 <readi+0x95>
    return -1;
80101e87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e8c:	e9 cd 00 00 00       	jmp    80101f5e <readi+0x162>
  if(off + n > ip->size)
80101e91:	8b 45 14             	mov    0x14(%ebp),%eax
80101e94:	8b 55 10             	mov    0x10(%ebp),%edx
80101e97:	01 c2                	add    %eax,%edx
80101e99:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9c:	8b 40 58             	mov    0x58(%eax),%eax
80101e9f:	39 c2                	cmp    %eax,%edx
80101ea1:	76 0c                	jbe    80101eaf <readi+0xb3>
    n = ip->size - off;
80101ea3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea6:	8b 40 58             	mov    0x58(%eax),%eax
80101ea9:	2b 45 10             	sub    0x10(%ebp),%eax
80101eac:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eaf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101eb6:	e9 94 00 00 00       	jmp    80101f4f <readi+0x153>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ebb:	8b 45 10             	mov    0x10(%ebp),%eax
80101ebe:	c1 e8 09             	shr    $0x9,%eax
80101ec1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ec5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec8:	89 04 24             	mov    %eax,(%esp)
80101ecb:	e8 af fc ff ff       	call   80101b7f <bmap>
80101ed0:	8b 55 08             	mov    0x8(%ebp),%edx
80101ed3:	8b 12                	mov    (%edx),%edx
80101ed5:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ed9:	89 14 24             	mov    %edx,(%esp)
80101edc:	e8 d4 e2 ff ff       	call   801001b5 <bread>
80101ee1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ee4:	8b 45 10             	mov    0x10(%ebp),%eax
80101ee7:	25 ff 01 00 00       	and    $0x1ff,%eax
80101eec:	89 c2                	mov    %eax,%edx
80101eee:	b8 00 02 00 00       	mov    $0x200,%eax
80101ef3:	29 d0                	sub    %edx,%eax
80101ef5:	89 c2                	mov    %eax,%edx
80101ef7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101efa:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101efd:	29 c1                	sub    %eax,%ecx
80101eff:	89 c8                	mov    %ecx,%eax
80101f01:	39 c2                	cmp    %eax,%edx
80101f03:	0f 46 c2             	cmovbe %edx,%eax
80101f06:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101f09:	8b 45 10             	mov    0x10(%ebp),%eax
80101f0c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f11:	8d 50 50             	lea    0x50(%eax),%edx
80101f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f17:	01 d0                	add    %edx,%eax
80101f19:	8d 50 0c             	lea    0xc(%eax),%edx
80101f1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f1f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f23:	89 54 24 04          	mov    %edx,0x4(%esp)
80101f27:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f2a:	89 04 24             	mov    %eax,(%esp)
80101f2d:	e8 56 33 00 00       	call   80105288 <memmove>
    brelse(bp);
80101f32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f35:	89 04 24             	mov    %eax,(%esp)
80101f38:	e8 ef e2 ff ff       	call   8010022c <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f40:	01 45 f4             	add    %eax,-0xc(%ebp)
80101f43:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f46:	01 45 10             	add    %eax,0x10(%ebp)
80101f49:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f4c:	01 45 0c             	add    %eax,0xc(%ebp)
80101f4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f52:	3b 45 14             	cmp    0x14(%ebp),%eax
80101f55:	0f 82 60 ff ff ff    	jb     80101ebb <readi+0xbf>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101f5b:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101f5e:	c9                   	leave  
80101f5f:	c3                   	ret    

80101f60 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f66:	8b 45 08             	mov    0x8(%ebp),%eax
80101f69:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101f6d:	66 83 f8 03          	cmp    $0x3,%ax
80101f71:	75 60                	jne    80101fd3 <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101f73:	8b 45 08             	mov    0x8(%ebp),%eax
80101f76:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f7a:	66 85 c0             	test   %ax,%ax
80101f7d:	78 20                	js     80101f9f <writei+0x3f>
80101f7f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f82:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f86:	66 83 f8 09          	cmp    $0x9,%ax
80101f8a:	7f 13                	jg     80101f9f <writei+0x3f>
80101f8c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f8f:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f93:	98                   	cwtl   
80101f94:	8b 04 c5 04 1a 11 80 	mov    -0x7feee5fc(,%eax,8),%eax
80101f9b:	85 c0                	test   %eax,%eax
80101f9d:	75 0a                	jne    80101fa9 <writei+0x49>
      return -1;
80101f9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fa4:	e9 44 01 00 00       	jmp    801020ed <writei+0x18d>
    return devsw[ip->major].write(ip, src, n);
80101fa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101fac:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101fb0:	98                   	cwtl   
80101fb1:	8b 04 c5 04 1a 11 80 	mov    -0x7feee5fc(,%eax,8),%eax
80101fb8:	8b 55 14             	mov    0x14(%ebp),%edx
80101fbb:	89 54 24 08          	mov    %edx,0x8(%esp)
80101fbf:	8b 55 0c             	mov    0xc(%ebp),%edx
80101fc2:	89 54 24 04          	mov    %edx,0x4(%esp)
80101fc6:	8b 55 08             	mov    0x8(%ebp),%edx
80101fc9:	89 14 24             	mov    %edx,(%esp)
80101fcc:	ff d0                	call   *%eax
80101fce:	e9 1a 01 00 00       	jmp    801020ed <writei+0x18d>
  }

  if(off > ip->size || off + n < off)
80101fd3:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd6:	8b 40 58             	mov    0x58(%eax),%eax
80101fd9:	3b 45 10             	cmp    0x10(%ebp),%eax
80101fdc:	72 0d                	jb     80101feb <writei+0x8b>
80101fde:	8b 45 14             	mov    0x14(%ebp),%eax
80101fe1:	8b 55 10             	mov    0x10(%ebp),%edx
80101fe4:	01 d0                	add    %edx,%eax
80101fe6:	3b 45 10             	cmp    0x10(%ebp),%eax
80101fe9:	73 0a                	jae    80101ff5 <writei+0x95>
    return -1;
80101feb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ff0:	e9 f8 00 00 00       	jmp    801020ed <writei+0x18d>
  if(off + n > MAXFILE*BSIZE)
80101ff5:	8b 45 14             	mov    0x14(%ebp),%eax
80101ff8:	8b 55 10             	mov    0x10(%ebp),%edx
80101ffb:	01 d0                	add    %edx,%eax
80101ffd:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102002:	76 0a                	jbe    8010200e <writei+0xae>
    return -1;
80102004:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102009:	e9 df 00 00 00       	jmp    801020ed <writei+0x18d>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010200e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102015:	e9 9f 00 00 00       	jmp    801020b9 <writei+0x159>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010201a:	8b 45 10             	mov    0x10(%ebp),%eax
8010201d:	c1 e8 09             	shr    $0x9,%eax
80102020:	89 44 24 04          	mov    %eax,0x4(%esp)
80102024:	8b 45 08             	mov    0x8(%ebp),%eax
80102027:	89 04 24             	mov    %eax,(%esp)
8010202a:	e8 50 fb ff ff       	call   80101b7f <bmap>
8010202f:	8b 55 08             	mov    0x8(%ebp),%edx
80102032:	8b 12                	mov    (%edx),%edx
80102034:	89 44 24 04          	mov    %eax,0x4(%esp)
80102038:	89 14 24             	mov    %edx,(%esp)
8010203b:	e8 75 e1 ff ff       	call   801001b5 <bread>
80102040:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102043:	8b 45 10             	mov    0x10(%ebp),%eax
80102046:	25 ff 01 00 00       	and    $0x1ff,%eax
8010204b:	89 c2                	mov    %eax,%edx
8010204d:	b8 00 02 00 00       	mov    $0x200,%eax
80102052:	29 d0                	sub    %edx,%eax
80102054:	89 c2                	mov    %eax,%edx
80102056:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102059:	8b 4d 14             	mov    0x14(%ebp),%ecx
8010205c:	29 c1                	sub    %eax,%ecx
8010205e:	89 c8                	mov    %ecx,%eax
80102060:	39 c2                	cmp    %eax,%edx
80102062:	0f 46 c2             	cmovbe %edx,%eax
80102065:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102068:	8b 45 10             	mov    0x10(%ebp),%eax
8010206b:	25 ff 01 00 00       	and    $0x1ff,%eax
80102070:	8d 50 50             	lea    0x50(%eax),%edx
80102073:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102076:	01 d0                	add    %edx,%eax
80102078:	8d 50 0c             	lea    0xc(%eax),%edx
8010207b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010207e:	89 44 24 08          	mov    %eax,0x8(%esp)
80102082:	8b 45 0c             	mov    0xc(%ebp),%eax
80102085:	89 44 24 04          	mov    %eax,0x4(%esp)
80102089:	89 14 24             	mov    %edx,(%esp)
8010208c:	e8 f7 31 00 00       	call   80105288 <memmove>
    log_write(bp);
80102091:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102094:	89 04 24             	mov    %eax,(%esp)
80102097:	e8 a8 16 00 00       	call   80103744 <log_write>
    brelse(bp);
8010209c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010209f:	89 04 24             	mov    %eax,(%esp)
801020a2:	e8 85 e1 ff ff       	call   8010022c <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020aa:	01 45 f4             	add    %eax,-0xc(%ebp)
801020ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020b0:	01 45 10             	add    %eax,0x10(%ebp)
801020b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020b6:	01 45 0c             	add    %eax,0xc(%ebp)
801020b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020bc:	3b 45 14             	cmp    0x14(%ebp),%eax
801020bf:	0f 82 55 ff ff ff    	jb     8010201a <writei+0xba>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
801020c5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801020c9:	74 1f                	je     801020ea <writei+0x18a>
801020cb:	8b 45 08             	mov    0x8(%ebp),%eax
801020ce:	8b 40 58             	mov    0x58(%eax),%eax
801020d1:	3b 45 10             	cmp    0x10(%ebp),%eax
801020d4:	73 14                	jae    801020ea <writei+0x18a>
    ip->size = off;
801020d6:	8b 45 08             	mov    0x8(%ebp),%eax
801020d9:	8b 55 10             	mov    0x10(%ebp),%edx
801020dc:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
801020df:	8b 45 08             	mov    0x8(%ebp),%eax
801020e2:	89 04 24             	mov    %eax,(%esp)
801020e5:	e8 c3 f6 ff ff       	call   801017ad <iupdate>
  }
  return n;
801020ea:	8b 45 14             	mov    0x14(%ebp),%eax
}
801020ed:	c9                   	leave  
801020ee:	c3                   	ret    

801020ef <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801020ef:	55                   	push   %ebp
801020f0:	89 e5                	mov    %esp,%ebp
801020f2:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
801020f5:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801020fc:	00 
801020fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102100:	89 44 24 04          	mov    %eax,0x4(%esp)
80102104:	8b 45 08             	mov    0x8(%ebp),%eax
80102107:	89 04 24             	mov    %eax,(%esp)
8010210a:	e8 1c 32 00 00       	call   8010532b <strncmp>
}
8010210f:	c9                   	leave  
80102110:	c3                   	ret    

80102111 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102111:	55                   	push   %ebp
80102112:	89 e5                	mov    %esp,%ebp
80102114:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102117:	8b 45 08             	mov    0x8(%ebp),%eax
8010211a:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010211e:	66 83 f8 01          	cmp    $0x1,%ax
80102122:	74 0c                	je     80102130 <dirlookup+0x1f>
    panic("dirlookup not DIR");
80102124:	c7 04 24 21 87 10 80 	movl   $0x80108721,(%esp)
8010212b:	e8 32 e4 ff ff       	call   80100562 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102130:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102137:	e9 88 00 00 00       	jmp    801021c4 <dirlookup+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010213c:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102143:	00 
80102144:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102147:	89 44 24 08          	mov    %eax,0x8(%esp)
8010214b:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010214e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102152:	8b 45 08             	mov    0x8(%ebp),%eax
80102155:	89 04 24             	mov    %eax,(%esp)
80102158:	e8 9f fc ff ff       	call   80101dfc <readi>
8010215d:	83 f8 10             	cmp    $0x10,%eax
80102160:	74 0c                	je     8010216e <dirlookup+0x5d>
      panic("dirlink read");
80102162:	c7 04 24 33 87 10 80 	movl   $0x80108733,(%esp)
80102169:	e8 f4 e3 ff ff       	call   80100562 <panic>
    if(de.inum == 0)
8010216e:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102172:	66 85 c0             	test   %ax,%ax
80102175:	75 02                	jne    80102179 <dirlookup+0x68>
      continue;
80102177:	eb 47                	jmp    801021c0 <dirlookup+0xaf>
    if(namecmp(name, de.name) == 0){
80102179:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010217c:	83 c0 02             	add    $0x2,%eax
8010217f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102183:	8b 45 0c             	mov    0xc(%ebp),%eax
80102186:	89 04 24             	mov    %eax,(%esp)
80102189:	e8 61 ff ff ff       	call   801020ef <namecmp>
8010218e:	85 c0                	test   %eax,%eax
80102190:	75 2e                	jne    801021c0 <dirlookup+0xaf>
      // entry matches path element
      if(poff)
80102192:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102196:	74 08                	je     801021a0 <dirlookup+0x8f>
        *poff = off;
80102198:	8b 45 10             	mov    0x10(%ebp),%eax
8010219b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010219e:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021a0:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021a4:	0f b7 c0             	movzwl %ax,%eax
801021a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021aa:	8b 45 08             	mov    0x8(%ebp),%eax
801021ad:	8b 00                	mov    (%eax),%eax
801021af:	8b 55 f0             	mov    -0x10(%ebp),%edx
801021b2:	89 54 24 04          	mov    %edx,0x4(%esp)
801021b6:	89 04 24             	mov    %eax,(%esp)
801021b9:	e8 ad f6 ff ff       	call   8010186b <iget>
801021be:	eb 18                	jmp    801021d8 <dirlookup+0xc7>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021c0:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801021c4:	8b 45 08             	mov    0x8(%ebp),%eax
801021c7:	8b 40 58             	mov    0x58(%eax),%eax
801021ca:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801021cd:	0f 87 69 ff ff ff    	ja     8010213c <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
801021d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801021d8:	c9                   	leave  
801021d9:	c3                   	ret    

801021da <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801021da:	55                   	push   %ebp
801021db:	89 e5                	mov    %esp,%ebp
801021dd:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801021e0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801021e7:	00 
801021e8:	8b 45 0c             	mov    0xc(%ebp),%eax
801021eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801021ef:	8b 45 08             	mov    0x8(%ebp),%eax
801021f2:	89 04 24             	mov    %eax,(%esp)
801021f5:	e8 17 ff ff ff       	call   80102111 <dirlookup>
801021fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
801021fd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102201:	74 15                	je     80102218 <dirlink+0x3e>
    iput(ip);
80102203:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102206:	89 04 24             	mov    %eax,(%esp)
80102209:	e8 bf f8 ff ff       	call   80101acd <iput>
    return -1;
8010220e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102213:	e9 b7 00 00 00       	jmp    801022cf <dirlink+0xf5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102218:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010221f:	eb 46                	jmp    80102267 <dirlink+0x8d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102221:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102224:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010222b:	00 
8010222c:	89 44 24 08          	mov    %eax,0x8(%esp)
80102230:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102233:	89 44 24 04          	mov    %eax,0x4(%esp)
80102237:	8b 45 08             	mov    0x8(%ebp),%eax
8010223a:	89 04 24             	mov    %eax,(%esp)
8010223d:	e8 ba fb ff ff       	call   80101dfc <readi>
80102242:	83 f8 10             	cmp    $0x10,%eax
80102245:	74 0c                	je     80102253 <dirlink+0x79>
      panic("dirlink read");
80102247:	c7 04 24 33 87 10 80 	movl   $0x80108733,(%esp)
8010224e:	e8 0f e3 ff ff       	call   80100562 <panic>
    if(de.inum == 0)
80102253:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102257:	66 85 c0             	test   %ax,%ax
8010225a:	75 02                	jne    8010225e <dirlink+0x84>
      break;
8010225c:	eb 16                	jmp    80102274 <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010225e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102261:	83 c0 10             	add    $0x10,%eax
80102264:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102267:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010226a:	8b 45 08             	mov    0x8(%ebp),%eax
8010226d:	8b 40 58             	mov    0x58(%eax),%eax
80102270:	39 c2                	cmp    %eax,%edx
80102272:	72 ad                	jb     80102221 <dirlink+0x47>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102274:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010227b:	00 
8010227c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010227f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102283:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102286:	83 c0 02             	add    $0x2,%eax
80102289:	89 04 24             	mov    %eax,(%esp)
8010228c:	e8 f0 30 00 00       	call   80105381 <strncpy>
  de.inum = inum;
80102291:	8b 45 10             	mov    0x10(%ebp),%eax
80102294:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102298:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010229b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801022a2:	00 
801022a3:	89 44 24 08          	mov    %eax,0x8(%esp)
801022a7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801022ae:	8b 45 08             	mov    0x8(%ebp),%eax
801022b1:	89 04 24             	mov    %eax,(%esp)
801022b4:	e8 a7 fc ff ff       	call   80101f60 <writei>
801022b9:	83 f8 10             	cmp    $0x10,%eax
801022bc:	74 0c                	je     801022ca <dirlink+0xf0>
    panic("dirlink");
801022be:	c7 04 24 40 87 10 80 	movl   $0x80108740,(%esp)
801022c5:	e8 98 e2 ff ff       	call   80100562 <panic>

  return 0;
801022ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022cf:	c9                   	leave  
801022d0:	c3                   	ret    

801022d1 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801022d1:	55                   	push   %ebp
801022d2:	89 e5                	mov    %esp,%ebp
801022d4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
801022d7:	eb 04                	jmp    801022dd <skipelem+0xc>
    path++;
801022d9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801022dd:	8b 45 08             	mov    0x8(%ebp),%eax
801022e0:	0f b6 00             	movzbl (%eax),%eax
801022e3:	3c 2f                	cmp    $0x2f,%al
801022e5:	74 f2                	je     801022d9 <skipelem+0x8>
    path++;
  if(*path == 0)
801022e7:	8b 45 08             	mov    0x8(%ebp),%eax
801022ea:	0f b6 00             	movzbl (%eax),%eax
801022ed:	84 c0                	test   %al,%al
801022ef:	75 0a                	jne    801022fb <skipelem+0x2a>
    return 0;
801022f1:	b8 00 00 00 00       	mov    $0x0,%eax
801022f6:	e9 86 00 00 00       	jmp    80102381 <skipelem+0xb0>
  s = path;
801022fb:	8b 45 08             	mov    0x8(%ebp),%eax
801022fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102301:	eb 04                	jmp    80102307 <skipelem+0x36>
    path++;
80102303:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102307:	8b 45 08             	mov    0x8(%ebp),%eax
8010230a:	0f b6 00             	movzbl (%eax),%eax
8010230d:	3c 2f                	cmp    $0x2f,%al
8010230f:	74 0a                	je     8010231b <skipelem+0x4a>
80102311:	8b 45 08             	mov    0x8(%ebp),%eax
80102314:	0f b6 00             	movzbl (%eax),%eax
80102317:	84 c0                	test   %al,%al
80102319:	75 e8                	jne    80102303 <skipelem+0x32>
    path++;
  len = path - s;
8010231b:	8b 55 08             	mov    0x8(%ebp),%edx
8010231e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102321:	29 c2                	sub    %eax,%edx
80102323:	89 d0                	mov    %edx,%eax
80102325:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102328:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010232c:	7e 1c                	jle    8010234a <skipelem+0x79>
    memmove(name, s, DIRSIZ);
8010232e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102335:	00 
80102336:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102339:	89 44 24 04          	mov    %eax,0x4(%esp)
8010233d:	8b 45 0c             	mov    0xc(%ebp),%eax
80102340:	89 04 24             	mov    %eax,(%esp)
80102343:	e8 40 2f 00 00       	call   80105288 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102348:	eb 2a                	jmp    80102374 <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
8010234a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010234d:	89 44 24 08          	mov    %eax,0x8(%esp)
80102351:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102354:	89 44 24 04          	mov    %eax,0x4(%esp)
80102358:	8b 45 0c             	mov    0xc(%ebp),%eax
8010235b:	89 04 24             	mov    %eax,(%esp)
8010235e:	e8 25 2f 00 00       	call   80105288 <memmove>
    name[len] = 0;
80102363:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102366:	8b 45 0c             	mov    0xc(%ebp),%eax
80102369:	01 d0                	add    %edx,%eax
8010236b:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
8010236e:	eb 04                	jmp    80102374 <skipelem+0xa3>
    path++;
80102370:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102374:	8b 45 08             	mov    0x8(%ebp),%eax
80102377:	0f b6 00             	movzbl (%eax),%eax
8010237a:	3c 2f                	cmp    $0x2f,%al
8010237c:	74 f2                	je     80102370 <skipelem+0x9f>
    path++;
  return path;
8010237e:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102381:	c9                   	leave  
80102382:	c3                   	ret    

80102383 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102383:	55                   	push   %ebp
80102384:	89 e5                	mov    %esp,%ebp
80102386:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102389:	8b 45 08             	mov    0x8(%ebp),%eax
8010238c:	0f b6 00             	movzbl (%eax),%eax
8010238f:	3c 2f                	cmp    $0x2f,%al
80102391:	75 1c                	jne    801023af <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
80102393:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010239a:	00 
8010239b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801023a2:	e8 c4 f4 ff ff       	call   8010186b <iget>
801023a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801023aa:	e9 af 00 00 00       	jmp    8010245e <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
801023af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801023b5:	8b 40 68             	mov    0x68(%eax),%eax
801023b8:	89 04 24             	mov    %eax,(%esp)
801023bb:	e8 80 f5 ff ff       	call   80101940 <idup>
801023c0:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801023c3:	e9 96 00 00 00       	jmp    8010245e <namex+0xdb>
    ilock(ip);
801023c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023cb:	89 04 24             	mov    %eax,(%esp)
801023ce:	e8 9f f5 ff ff       	call   80101972 <ilock>
    if(ip->type != T_DIR){
801023d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023d6:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801023da:	66 83 f8 01          	cmp    $0x1,%ax
801023de:	74 15                	je     801023f5 <namex+0x72>
      iunlockput(ip);
801023e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023e3:	89 04 24             	mov    %eax,(%esp)
801023e6:	e8 76 f7 ff ff       	call   80101b61 <iunlockput>
      return 0;
801023eb:	b8 00 00 00 00       	mov    $0x0,%eax
801023f0:	e9 a3 00 00 00       	jmp    80102498 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
801023f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801023f9:	74 1d                	je     80102418 <namex+0x95>
801023fb:	8b 45 08             	mov    0x8(%ebp),%eax
801023fe:	0f b6 00             	movzbl (%eax),%eax
80102401:	84 c0                	test   %al,%al
80102403:	75 13                	jne    80102418 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
80102405:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102408:	89 04 24             	mov    %eax,(%esp)
8010240b:	e8 79 f6 ff ff       	call   80101a89 <iunlock>
      return ip;
80102410:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102413:	e9 80 00 00 00       	jmp    80102498 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102418:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010241f:	00 
80102420:	8b 45 10             	mov    0x10(%ebp),%eax
80102423:	89 44 24 04          	mov    %eax,0x4(%esp)
80102427:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010242a:	89 04 24             	mov    %eax,(%esp)
8010242d:	e8 df fc ff ff       	call   80102111 <dirlookup>
80102432:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102435:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102439:	75 12                	jne    8010244d <namex+0xca>
      iunlockput(ip);
8010243b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010243e:	89 04 24             	mov    %eax,(%esp)
80102441:	e8 1b f7 ff ff       	call   80101b61 <iunlockput>
      return 0;
80102446:	b8 00 00 00 00       	mov    $0x0,%eax
8010244b:	eb 4b                	jmp    80102498 <namex+0x115>
    }
    iunlockput(ip);
8010244d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102450:	89 04 24             	mov    %eax,(%esp)
80102453:	e8 09 f7 ff ff       	call   80101b61 <iunlockput>
    ip = next;
80102458:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010245b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010245e:	8b 45 10             	mov    0x10(%ebp),%eax
80102461:	89 44 24 04          	mov    %eax,0x4(%esp)
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
80102468:	89 04 24             	mov    %eax,(%esp)
8010246b:	e8 61 fe ff ff       	call   801022d1 <skipelem>
80102470:	89 45 08             	mov    %eax,0x8(%ebp)
80102473:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102477:	0f 85 4b ff ff ff    	jne    801023c8 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
8010247d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102481:	74 12                	je     80102495 <namex+0x112>
    iput(ip);
80102483:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102486:	89 04 24             	mov    %eax,(%esp)
80102489:	e8 3f f6 ff ff       	call   80101acd <iput>
    return 0;
8010248e:	b8 00 00 00 00       	mov    $0x0,%eax
80102493:	eb 03                	jmp    80102498 <namex+0x115>
  }
  return ip;
80102495:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102498:	c9                   	leave  
80102499:	c3                   	ret    

8010249a <namei>:

struct inode*
namei(char *path)
{
8010249a:	55                   	push   %ebp
8010249b:	89 e5                	mov    %esp,%ebp
8010249d:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024a0:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024a3:	89 44 24 08          	mov    %eax,0x8(%esp)
801024a7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801024ae:	00 
801024af:	8b 45 08             	mov    0x8(%ebp),%eax
801024b2:	89 04 24             	mov    %eax,(%esp)
801024b5:	e8 c9 fe ff ff       	call   80102383 <namex>
}
801024ba:	c9                   	leave  
801024bb:	c3                   	ret    

801024bc <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024bc:	55                   	push   %ebp
801024bd:	89 e5                	mov    %esp,%ebp
801024bf:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
801024c2:	8b 45 0c             	mov    0xc(%ebp),%eax
801024c5:	89 44 24 08          	mov    %eax,0x8(%esp)
801024c9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801024d0:	00 
801024d1:	8b 45 08             	mov    0x8(%ebp),%eax
801024d4:	89 04 24             	mov    %eax,(%esp)
801024d7:	e8 a7 fe ff ff       	call   80102383 <namex>
}
801024dc:	c9                   	leave  
801024dd:	c3                   	ret    

801024de <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801024de:	55                   	push   %ebp
801024df:	89 e5                	mov    %esp,%ebp
801024e1:	83 ec 14             	sub    $0x14,%esp
801024e4:	8b 45 08             	mov    0x8(%ebp),%eax
801024e7:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024eb:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801024ef:	89 c2                	mov    %eax,%edx
801024f1:	ec                   	in     (%dx),%al
801024f2:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801024f5:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801024f9:	c9                   	leave  
801024fa:	c3                   	ret    

801024fb <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
801024fb:	55                   	push   %ebp
801024fc:	89 e5                	mov    %esp,%ebp
801024fe:	57                   	push   %edi
801024ff:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102500:	8b 55 08             	mov    0x8(%ebp),%edx
80102503:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102506:	8b 45 10             	mov    0x10(%ebp),%eax
80102509:	89 cb                	mov    %ecx,%ebx
8010250b:	89 df                	mov    %ebx,%edi
8010250d:	89 c1                	mov    %eax,%ecx
8010250f:	fc                   	cld    
80102510:	f3 6d                	rep insl (%dx),%es:(%edi)
80102512:	89 c8                	mov    %ecx,%eax
80102514:	89 fb                	mov    %edi,%ebx
80102516:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102519:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010251c:	5b                   	pop    %ebx
8010251d:	5f                   	pop    %edi
8010251e:	5d                   	pop    %ebp
8010251f:	c3                   	ret    

80102520 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	83 ec 08             	sub    $0x8,%esp
80102526:	8b 55 08             	mov    0x8(%ebp),%edx
80102529:	8b 45 0c             	mov    0xc(%ebp),%eax
8010252c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102530:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102533:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102537:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010253b:	ee                   	out    %al,(%dx)
}
8010253c:	c9                   	leave  
8010253d:	c3                   	ret    

8010253e <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
8010253e:	55                   	push   %ebp
8010253f:	89 e5                	mov    %esp,%ebp
80102541:	56                   	push   %esi
80102542:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102543:	8b 55 08             	mov    0x8(%ebp),%edx
80102546:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102549:	8b 45 10             	mov    0x10(%ebp),%eax
8010254c:	89 cb                	mov    %ecx,%ebx
8010254e:	89 de                	mov    %ebx,%esi
80102550:	89 c1                	mov    %eax,%ecx
80102552:	fc                   	cld    
80102553:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102555:	89 c8                	mov    %ecx,%eax
80102557:	89 f3                	mov    %esi,%ebx
80102559:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010255c:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
8010255f:	5b                   	pop    %ebx
80102560:	5e                   	pop    %esi
80102561:	5d                   	pop    %ebp
80102562:	c3                   	ret    

80102563 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102563:	55                   	push   %ebp
80102564:	89 e5                	mov    %esp,%ebp
80102566:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102569:	90                   	nop
8010256a:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102571:	e8 68 ff ff ff       	call   801024de <inb>
80102576:	0f b6 c0             	movzbl %al,%eax
80102579:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010257c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010257f:	25 c0 00 00 00       	and    $0xc0,%eax
80102584:	83 f8 40             	cmp    $0x40,%eax
80102587:	75 e1                	jne    8010256a <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102589:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010258d:	74 11                	je     801025a0 <idewait+0x3d>
8010258f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102592:	83 e0 21             	and    $0x21,%eax
80102595:	85 c0                	test   %eax,%eax
80102597:	74 07                	je     801025a0 <idewait+0x3d>
    return -1;
80102599:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010259e:	eb 05                	jmp    801025a5 <idewait+0x42>
  return 0;
801025a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801025a5:	c9                   	leave  
801025a6:	c3                   	ret    

801025a7 <ideinit>:

void
ideinit(void)
{
801025a7:	55                   	push   %ebp
801025a8:	89 e5                	mov    %esp,%ebp
801025aa:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
801025ad:	c7 44 24 04 48 87 10 	movl   $0x80108748,0x4(%esp)
801025b4:	80 
801025b5:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801025bc:	e8 6e 29 00 00       	call   80104f2f <initlock>
  picenable(IRQ_IDE);
801025c1:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801025c8:	e8 1e 18 00 00       	call   80103deb <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
801025cd:	a1 00 3e 11 80       	mov    0x80113e00,%eax
801025d2:	83 e8 01             	sub    $0x1,%eax
801025d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801025d9:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801025e0:	e8 77 04 00 00       	call   80102a5c <ioapicenable>
  idewait(0);
801025e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801025ec:	e8 72 ff ff ff       	call   80102563 <idewait>

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801025f1:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
801025f8:	00 
801025f9:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102600:	e8 1b ff ff ff       	call   80102520 <outb>
  for(i=0; i<1000; i++){
80102605:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010260c:	eb 20                	jmp    8010262e <ideinit+0x87>
    if(inb(0x1f7) != 0){
8010260e:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102615:	e8 c4 fe ff ff       	call   801024de <inb>
8010261a:	84 c0                	test   %al,%al
8010261c:	74 0c                	je     8010262a <ideinit+0x83>
      havedisk1 = 1;
8010261e:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
80102625:	00 00 00 
      break;
80102628:	eb 0d                	jmp    80102637 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010262a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010262e:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102635:	7e d7                	jle    8010260e <ideinit+0x67>
      break;
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102637:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
8010263e:	00 
8010263f:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102646:	e8 d5 fe ff ff       	call   80102520 <outb>
}
8010264b:	c9                   	leave  
8010264c:	c3                   	ret    

8010264d <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
8010264d:	55                   	push   %ebp
8010264e:	89 e5                	mov    %esp,%ebp
80102650:	83 ec 28             	sub    $0x28,%esp
  if(b == 0)
80102653:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102657:	75 0c                	jne    80102665 <idestart+0x18>
    panic("idestart");
80102659:	c7 04 24 4c 87 10 80 	movl   $0x8010874c,(%esp)
80102660:	e8 fd de ff ff       	call   80100562 <panic>
  if(b->blockno >= FSSIZE)
80102665:	8b 45 08             	mov    0x8(%ebp),%eax
80102668:	8b 40 08             	mov    0x8(%eax),%eax
8010266b:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102670:	76 0c                	jbe    8010267e <idestart+0x31>
    panic("incorrect blockno");
80102672:	c7 04 24 55 87 10 80 	movl   $0x80108755,(%esp)
80102679:	e8 e4 de ff ff       	call   80100562 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
8010267e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102685:	8b 45 08             	mov    0x8(%ebp),%eax
80102688:	8b 50 08             	mov    0x8(%eax),%edx
8010268b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010268e:	0f af c2             	imul   %edx,%eax
80102691:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80102694:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102698:	75 07                	jne    801026a1 <idestart+0x54>
8010269a:	b8 20 00 00 00       	mov    $0x20,%eax
8010269f:	eb 05                	jmp    801026a6 <idestart+0x59>
801026a1:	b8 c4 00 00 00       	mov    $0xc4,%eax
801026a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
801026a9:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
801026ad:	75 07                	jne    801026b6 <idestart+0x69>
801026af:	b8 30 00 00 00       	mov    $0x30,%eax
801026b4:	eb 05                	jmp    801026bb <idestart+0x6e>
801026b6:	b8 c5 00 00 00       	mov    $0xc5,%eax
801026bb:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
801026be:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
801026c2:	7e 0c                	jle    801026d0 <idestart+0x83>
801026c4:	c7 04 24 4c 87 10 80 	movl   $0x8010874c,(%esp)
801026cb:	e8 92 de ff ff       	call   80100562 <panic>

  idewait(0);
801026d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801026d7:	e8 87 fe ff ff       	call   80102563 <idewait>
  outb(0x3f6, 0);  // generate interrupt
801026dc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801026e3:	00 
801026e4:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
801026eb:	e8 30 fe ff ff       	call   80102520 <outb>
  outb(0x1f2, sector_per_block);  // number of sectors
801026f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026f3:	0f b6 c0             	movzbl %al,%eax
801026f6:	89 44 24 04          	mov    %eax,0x4(%esp)
801026fa:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
80102701:	e8 1a fe ff ff       	call   80102520 <outb>
  outb(0x1f3, sector & 0xff);
80102706:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102709:	0f b6 c0             	movzbl %al,%eax
8010270c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102710:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102717:	e8 04 fe ff ff       	call   80102520 <outb>
  outb(0x1f4, (sector >> 8) & 0xff);
8010271c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010271f:	c1 f8 08             	sar    $0x8,%eax
80102722:	0f b6 c0             	movzbl %al,%eax
80102725:	89 44 24 04          	mov    %eax,0x4(%esp)
80102729:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102730:	e8 eb fd ff ff       	call   80102520 <outb>
  outb(0x1f5, (sector >> 16) & 0xff);
80102735:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102738:	c1 f8 10             	sar    $0x10,%eax
8010273b:	0f b6 c0             	movzbl %al,%eax
8010273e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102742:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
80102749:	e8 d2 fd ff ff       	call   80102520 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010274e:	8b 45 08             	mov    0x8(%ebp),%eax
80102751:	8b 40 04             	mov    0x4(%eax),%eax
80102754:	83 e0 01             	and    $0x1,%eax
80102757:	c1 e0 04             	shl    $0x4,%eax
8010275a:	89 c2                	mov    %eax,%edx
8010275c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010275f:	c1 f8 18             	sar    $0x18,%eax
80102762:	83 e0 0f             	and    $0xf,%eax
80102765:	09 d0                	or     %edx,%eax
80102767:	83 c8 e0             	or     $0xffffffe0,%eax
8010276a:	0f b6 c0             	movzbl %al,%eax
8010276d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102771:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102778:	e8 a3 fd ff ff       	call   80102520 <outb>
  if(b->flags & B_DIRTY){
8010277d:	8b 45 08             	mov    0x8(%ebp),%eax
80102780:	8b 00                	mov    (%eax),%eax
80102782:	83 e0 04             	and    $0x4,%eax
80102785:	85 c0                	test   %eax,%eax
80102787:	74 36                	je     801027bf <idestart+0x172>
    outb(0x1f7, write_cmd);
80102789:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010278c:	0f b6 c0             	movzbl %al,%eax
8010278f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102793:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
8010279a:	e8 81 fd ff ff       	call   80102520 <outb>
    outsl(0x1f0, b->data, BSIZE/4);
8010279f:	8b 45 08             	mov    0x8(%ebp),%eax
801027a2:	83 c0 5c             	add    $0x5c,%eax
801027a5:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801027ac:	00 
801027ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801027b1:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801027b8:	e8 81 fd ff ff       	call   8010253e <outsl>
801027bd:	eb 16                	jmp    801027d5 <idestart+0x188>
  } else {
    outb(0x1f7, read_cmd);
801027bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801027c2:	0f b6 c0             	movzbl %al,%eax
801027c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801027c9:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801027d0:	e8 4b fd ff ff       	call   80102520 <outb>
  }
}
801027d5:	c9                   	leave  
801027d6:	c3                   	ret    

801027d7 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801027d7:	55                   	push   %ebp
801027d8:	89 e5                	mov    %esp,%ebp
801027da:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801027dd:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801027e4:	e8 67 27 00 00       	call   80104f50 <acquire>
  if((b = idequeue) == 0){
801027e9:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801027ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801027f5:	75 11                	jne    80102808 <ideintr+0x31>
    release(&idelock);
801027f7:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801027fe:	e8 b4 27 00 00       	call   80104fb7 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102803:	e9 90 00 00 00       	jmp    80102898 <ideintr+0xc1>
  }
  idequeue = b->qnext;
80102808:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010280b:	8b 40 58             	mov    0x58(%eax),%eax
8010280e:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102813:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102816:	8b 00                	mov    (%eax),%eax
80102818:	83 e0 04             	and    $0x4,%eax
8010281b:	85 c0                	test   %eax,%eax
8010281d:	75 2e                	jne    8010284d <ideintr+0x76>
8010281f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102826:	e8 38 fd ff ff       	call   80102563 <idewait>
8010282b:	85 c0                	test   %eax,%eax
8010282d:	78 1e                	js     8010284d <ideintr+0x76>
    insl(0x1f0, b->data, BSIZE/4);
8010282f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102832:	83 c0 5c             	add    $0x5c,%eax
80102835:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
8010283c:	00 
8010283d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102841:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102848:	e8 ae fc ff ff       	call   801024fb <insl>

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010284d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102850:	8b 00                	mov    (%eax),%eax
80102852:	83 c8 02             	or     $0x2,%eax
80102855:	89 c2                	mov    %eax,%edx
80102857:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010285a:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010285c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010285f:	8b 00                	mov    (%eax),%eax
80102861:	83 e0 fb             	and    $0xfffffffb,%eax
80102864:	89 c2                	mov    %eax,%edx
80102866:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102869:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010286b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010286e:	89 04 24             	mov    %eax,(%esp)
80102871:	e8 e2 23 00 00       	call   80104c58 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102876:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010287b:	85 c0                	test   %eax,%eax
8010287d:	74 0d                	je     8010288c <ideintr+0xb5>
    idestart(idequeue);
8010287f:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102884:	89 04 24             	mov    %eax,(%esp)
80102887:	e8 c1 fd ff ff       	call   8010264d <idestart>

  release(&idelock);
8010288c:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102893:	e8 1f 27 00 00       	call   80104fb7 <release>
}
80102898:	c9                   	leave  
80102899:	c3                   	ret    

8010289a <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
8010289a:	55                   	push   %ebp
8010289b:	89 e5                	mov    %esp,%ebp
8010289d:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801028a0:	8b 45 08             	mov    0x8(%ebp),%eax
801028a3:	83 c0 0c             	add    $0xc,%eax
801028a6:	89 04 24             	mov    %eax,(%esp)
801028a9:	e8 1c 26 00 00       	call   80104eca <holdingsleep>
801028ae:	85 c0                	test   %eax,%eax
801028b0:	75 0c                	jne    801028be <iderw+0x24>
    panic("iderw: buf not locked");
801028b2:	c7 04 24 67 87 10 80 	movl   $0x80108767,(%esp)
801028b9:	e8 a4 dc ff ff       	call   80100562 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801028be:	8b 45 08             	mov    0x8(%ebp),%eax
801028c1:	8b 00                	mov    (%eax),%eax
801028c3:	83 e0 06             	and    $0x6,%eax
801028c6:	83 f8 02             	cmp    $0x2,%eax
801028c9:	75 0c                	jne    801028d7 <iderw+0x3d>
    panic("iderw: nothing to do");
801028cb:	c7 04 24 7d 87 10 80 	movl   $0x8010877d,(%esp)
801028d2:	e8 8b dc ff ff       	call   80100562 <panic>
  if(b->dev != 0 && !havedisk1)
801028d7:	8b 45 08             	mov    0x8(%ebp),%eax
801028da:	8b 40 04             	mov    0x4(%eax),%eax
801028dd:	85 c0                	test   %eax,%eax
801028df:	74 15                	je     801028f6 <iderw+0x5c>
801028e1:	a1 38 b6 10 80       	mov    0x8010b638,%eax
801028e6:	85 c0                	test   %eax,%eax
801028e8:	75 0c                	jne    801028f6 <iderw+0x5c>
    panic("iderw: ide disk 1 not present");
801028ea:	c7 04 24 92 87 10 80 	movl   $0x80108792,(%esp)
801028f1:	e8 6c dc ff ff       	call   80100562 <panic>

  acquire(&idelock);  //DOC:acquire-lock
801028f6:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801028fd:	e8 4e 26 00 00       	call   80104f50 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102902:	8b 45 08             	mov    0x8(%ebp),%eax
80102905:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010290c:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
80102913:	eb 0b                	jmp    80102920 <iderw+0x86>
80102915:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102918:	8b 00                	mov    (%eax),%eax
8010291a:	83 c0 58             	add    $0x58,%eax
8010291d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102920:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102923:	8b 00                	mov    (%eax),%eax
80102925:	85 c0                	test   %eax,%eax
80102927:	75 ec                	jne    80102915 <iderw+0x7b>
    ;
  *pp = b;
80102929:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010292c:	8b 55 08             	mov    0x8(%ebp),%edx
8010292f:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80102931:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102936:	3b 45 08             	cmp    0x8(%ebp),%eax
80102939:	75 0d                	jne    80102948 <iderw+0xae>
    idestart(b);
8010293b:	8b 45 08             	mov    0x8(%ebp),%eax
8010293e:	89 04 24             	mov    %eax,(%esp)
80102941:	e8 07 fd ff ff       	call   8010264d <idestart>

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102946:	eb 15                	jmp    8010295d <iderw+0xc3>
80102948:	eb 13                	jmp    8010295d <iderw+0xc3>
    sleep(b, &idelock);
8010294a:	c7 44 24 04 00 b6 10 	movl   $0x8010b600,0x4(%esp)
80102951:	80 
80102952:	8b 45 08             	mov    0x8(%ebp),%eax
80102955:	89 04 24             	mov    %eax,(%esp)
80102958:	e8 22 22 00 00       	call   80104b7f <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010295d:	8b 45 08             	mov    0x8(%ebp),%eax
80102960:	8b 00                	mov    (%eax),%eax
80102962:	83 e0 06             	and    $0x6,%eax
80102965:	83 f8 02             	cmp    $0x2,%eax
80102968:	75 e0                	jne    8010294a <iderw+0xb0>
    sleep(b, &idelock);
  }

  release(&idelock);
8010296a:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102971:	e8 41 26 00 00       	call   80104fb7 <release>
}
80102976:	c9                   	leave  
80102977:	c3                   	ret    

80102978 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102978:	55                   	push   %ebp
80102979:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010297b:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102980:	8b 55 08             	mov    0x8(%ebp),%edx
80102983:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102985:	a1 d4 36 11 80       	mov    0x801136d4,%eax
8010298a:	8b 40 10             	mov    0x10(%eax),%eax
}
8010298d:	5d                   	pop    %ebp
8010298e:	c3                   	ret    

8010298f <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
8010298f:	55                   	push   %ebp
80102990:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102992:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102997:	8b 55 08             	mov    0x8(%ebp),%edx
8010299a:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
8010299c:	a1 d4 36 11 80       	mov    0x801136d4,%eax
801029a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801029a4:	89 50 10             	mov    %edx,0x10(%eax)
}
801029a7:	5d                   	pop    %ebp
801029a8:	c3                   	ret    

801029a9 <ioapicinit>:

void
ioapicinit(void)
{
801029a9:	55                   	push   %ebp
801029aa:	89 e5                	mov    %esp,%ebp
801029ac:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
801029af:	a1 04 38 11 80       	mov    0x80113804,%eax
801029b4:	85 c0                	test   %eax,%eax
801029b6:	75 05                	jne    801029bd <ioapicinit+0x14>
    return;
801029b8:	e9 9d 00 00 00       	jmp    80102a5a <ioapicinit+0xb1>

  ioapic = (volatile struct ioapic*)IOAPIC;
801029bd:	c7 05 d4 36 11 80 00 	movl   $0xfec00000,0x801136d4
801029c4:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801029c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801029ce:	e8 a5 ff ff ff       	call   80102978 <ioapicread>
801029d3:	c1 e8 10             	shr    $0x10,%eax
801029d6:	25 ff 00 00 00       	and    $0xff,%eax
801029db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
801029de:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801029e5:	e8 8e ff ff ff       	call   80102978 <ioapicread>
801029ea:	c1 e8 18             	shr    $0x18,%eax
801029ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
801029f0:	0f b6 05 00 38 11 80 	movzbl 0x80113800,%eax
801029f7:	0f b6 c0             	movzbl %al,%eax
801029fa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801029fd:	74 0c                	je     80102a0b <ioapicinit+0x62>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801029ff:	c7 04 24 b0 87 10 80 	movl   $0x801087b0,(%esp)
80102a06:	e8 bd d9 ff ff       	call   801003c8 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a12:	eb 3e                	jmp    80102a52 <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a17:	83 c0 20             	add    $0x20,%eax
80102a1a:	0d 00 00 01 00       	or     $0x10000,%eax
80102a1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102a22:	83 c2 08             	add    $0x8,%edx
80102a25:	01 d2                	add    %edx,%edx
80102a27:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a2b:	89 14 24             	mov    %edx,(%esp)
80102a2e:	e8 5c ff ff ff       	call   8010298f <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a36:	83 c0 08             	add    $0x8,%eax
80102a39:	01 c0                	add    %eax,%eax
80102a3b:	83 c0 01             	add    $0x1,%eax
80102a3e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102a45:	00 
80102a46:	89 04 24             	mov    %eax,(%esp)
80102a49:	e8 41 ff ff ff       	call   8010298f <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a4e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a55:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a58:	7e ba                	jle    80102a14 <ioapicinit+0x6b>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a5a:	c9                   	leave  
80102a5b:	c3                   	ret    

80102a5c <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a5c:	55                   	push   %ebp
80102a5d:	89 e5                	mov    %esp,%ebp
80102a5f:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
80102a62:	a1 04 38 11 80       	mov    0x80113804,%eax
80102a67:	85 c0                	test   %eax,%eax
80102a69:	75 02                	jne    80102a6d <ioapicenable+0x11>
    return;
80102a6b:	eb 37                	jmp    80102aa4 <ioapicenable+0x48>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a6d:	8b 45 08             	mov    0x8(%ebp),%eax
80102a70:	83 c0 20             	add    $0x20,%eax
80102a73:	8b 55 08             	mov    0x8(%ebp),%edx
80102a76:	83 c2 08             	add    $0x8,%edx
80102a79:	01 d2                	add    %edx,%edx
80102a7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a7f:	89 14 24             	mov    %edx,(%esp)
80102a82:	e8 08 ff ff ff       	call   8010298f <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a87:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a8a:	c1 e0 18             	shl    $0x18,%eax
80102a8d:	8b 55 08             	mov    0x8(%ebp),%edx
80102a90:	83 c2 08             	add    $0x8,%edx
80102a93:	01 d2                	add    %edx,%edx
80102a95:	83 c2 01             	add    $0x1,%edx
80102a98:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a9c:	89 14 24             	mov    %edx,(%esp)
80102a9f:	e8 eb fe ff ff       	call   8010298f <ioapicwrite>
}
80102aa4:	c9                   	leave  
80102aa5:	c3                   	ret    

80102aa6 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102aa6:	55                   	push   %ebp
80102aa7:	89 e5                	mov    %esp,%ebp
80102aa9:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
80102aac:	c7 44 24 04 e2 87 10 	movl   $0x801087e2,0x4(%esp)
80102ab3:	80 
80102ab4:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102abb:	e8 6f 24 00 00       	call   80104f2f <initlock>
  kmem.use_lock = 0;
80102ac0:	c7 05 14 37 11 80 00 	movl   $0x0,0x80113714
80102ac7:	00 00 00 
  freerange(vstart, vend);
80102aca:	8b 45 0c             	mov    0xc(%ebp),%eax
80102acd:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ad1:	8b 45 08             	mov    0x8(%ebp),%eax
80102ad4:	89 04 24             	mov    %eax,(%esp)
80102ad7:	e8 26 00 00 00       	call   80102b02 <freerange>
}
80102adc:	c9                   	leave  
80102add:	c3                   	ret    

80102ade <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102ae4:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ae7:	89 44 24 04          	mov    %eax,0x4(%esp)
80102aeb:	8b 45 08             	mov    0x8(%ebp),%eax
80102aee:	89 04 24             	mov    %eax,(%esp)
80102af1:	e8 0c 00 00 00       	call   80102b02 <freerange>
  kmem.use_lock = 1;
80102af6:	c7 05 14 37 11 80 01 	movl   $0x1,0x80113714
80102afd:	00 00 00 
}
80102b00:	c9                   	leave  
80102b01:	c3                   	ret    

80102b02 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102b02:	55                   	push   %ebp
80102b03:	89 e5                	mov    %esp,%ebp
80102b05:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102b08:	8b 45 08             	mov    0x8(%ebp),%eax
80102b0b:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b10:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b15:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b18:	eb 12                	jmp    80102b2c <freerange+0x2a>
    kfree(p);
80102b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b1d:	89 04 24             	mov    %eax,(%esp)
80102b20:	e8 16 00 00 00       	call   80102b3b <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b25:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b2f:	05 00 10 00 00       	add    $0x1000,%eax
80102b34:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b37:	76 e1                	jbe    80102b1a <freerange+0x18>
    kfree(p);
}
80102b39:	c9                   	leave  
80102b3a:	c3                   	ret    

80102b3b <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b3b:	55                   	push   %ebp
80102b3c:	89 e5                	mov    %esp,%ebp
80102b3e:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102b41:	8b 45 08             	mov    0x8(%ebp),%eax
80102b44:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b49:	85 c0                	test   %eax,%eax
80102b4b:	75 18                	jne    80102b65 <kfree+0x2a>
80102b4d:	81 7d 08 a8 65 11 80 	cmpl   $0x801165a8,0x8(%ebp)
80102b54:	72 0f                	jb     80102b65 <kfree+0x2a>
80102b56:	8b 45 08             	mov    0x8(%ebp),%eax
80102b59:	05 00 00 00 80       	add    $0x80000000,%eax
80102b5e:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b63:	76 0c                	jbe    80102b71 <kfree+0x36>
    panic("kfree");
80102b65:	c7 04 24 e7 87 10 80 	movl   $0x801087e7,(%esp)
80102b6c:	e8 f1 d9 ff ff       	call   80100562 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102b71:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102b78:	00 
80102b79:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102b80:	00 
80102b81:	8b 45 08             	mov    0x8(%ebp),%eax
80102b84:	89 04 24             	mov    %eax,(%esp)
80102b87:	e8 2d 26 00 00       	call   801051b9 <memset>

  if(kmem.use_lock)
80102b8c:	a1 14 37 11 80       	mov    0x80113714,%eax
80102b91:	85 c0                	test   %eax,%eax
80102b93:	74 0c                	je     80102ba1 <kfree+0x66>
    acquire(&kmem.lock);
80102b95:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102b9c:	e8 af 23 00 00       	call   80104f50 <acquire>
  r = (struct run*)v;
80102ba1:	8b 45 08             	mov    0x8(%ebp),%eax
80102ba4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102ba7:	8b 15 18 37 11 80    	mov    0x80113718,%edx
80102bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bb0:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bb5:	a3 18 37 11 80       	mov    %eax,0x80113718
  if(kmem.use_lock)
80102bba:	a1 14 37 11 80       	mov    0x80113714,%eax
80102bbf:	85 c0                	test   %eax,%eax
80102bc1:	74 0c                	je     80102bcf <kfree+0x94>
    release(&kmem.lock);
80102bc3:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102bca:	e8 e8 23 00 00       	call   80104fb7 <release>
}
80102bcf:	c9                   	leave  
80102bd0:	c3                   	ret    

80102bd1 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102bd1:	55                   	push   %ebp
80102bd2:	89 e5                	mov    %esp,%ebp
80102bd4:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102bd7:	a1 14 37 11 80       	mov    0x80113714,%eax
80102bdc:	85 c0                	test   %eax,%eax
80102bde:	74 0c                	je     80102bec <kalloc+0x1b>
    acquire(&kmem.lock);
80102be0:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102be7:	e8 64 23 00 00       	call   80104f50 <acquire>
  r = kmem.freelist;
80102bec:	a1 18 37 11 80       	mov    0x80113718,%eax
80102bf1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102bf4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102bf8:	74 0a                	je     80102c04 <kalloc+0x33>
    kmem.freelist = r->next;
80102bfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bfd:	8b 00                	mov    (%eax),%eax
80102bff:	a3 18 37 11 80       	mov    %eax,0x80113718
  if(kmem.use_lock)
80102c04:	a1 14 37 11 80       	mov    0x80113714,%eax
80102c09:	85 c0                	test   %eax,%eax
80102c0b:	74 0c                	je     80102c19 <kalloc+0x48>
    release(&kmem.lock);
80102c0d:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102c14:	e8 9e 23 00 00       	call   80104fb7 <release>
  return (char*)r;
80102c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102c1c:	c9                   	leave  
80102c1d:	c3                   	ret    

80102c1e <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102c1e:	55                   	push   %ebp
80102c1f:	89 e5                	mov    %esp,%ebp
80102c21:	83 ec 14             	sub    $0x14,%esp
80102c24:	8b 45 08             	mov    0x8(%ebp),%eax
80102c27:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c2b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102c2f:	89 c2                	mov    %eax,%edx
80102c31:	ec                   	in     (%dx),%al
80102c32:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102c35:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102c39:	c9                   	leave  
80102c3a:	c3                   	ret    

80102c3b <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c3b:	55                   	push   %ebp
80102c3c:	89 e5                	mov    %esp,%ebp
80102c3e:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102c41:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102c48:	e8 d1 ff ff ff       	call   80102c1e <inb>
80102c4d:	0f b6 c0             	movzbl %al,%eax
80102c50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c56:	83 e0 01             	and    $0x1,%eax
80102c59:	85 c0                	test   %eax,%eax
80102c5b:	75 0a                	jne    80102c67 <kbdgetc+0x2c>
    return -1;
80102c5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c62:	e9 25 01 00 00       	jmp    80102d8c <kbdgetc+0x151>
  data = inb(KBDATAP);
80102c67:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
80102c6e:	e8 ab ff ff ff       	call   80102c1e <inb>
80102c73:	0f b6 c0             	movzbl %al,%eax
80102c76:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102c79:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102c80:	75 17                	jne    80102c99 <kbdgetc+0x5e>
    shift |= E0ESC;
80102c82:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c87:	83 c8 40             	or     $0x40,%eax
80102c8a:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102c8f:	b8 00 00 00 00       	mov    $0x0,%eax
80102c94:	e9 f3 00 00 00       	jmp    80102d8c <kbdgetc+0x151>
  } else if(data & 0x80){
80102c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c9c:	25 80 00 00 00       	and    $0x80,%eax
80102ca1:	85 c0                	test   %eax,%eax
80102ca3:	74 45                	je     80102cea <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102ca5:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102caa:	83 e0 40             	and    $0x40,%eax
80102cad:	85 c0                	test   %eax,%eax
80102caf:	75 08                	jne    80102cb9 <kbdgetc+0x7e>
80102cb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cb4:	83 e0 7f             	and    $0x7f,%eax
80102cb7:	eb 03                	jmp    80102cbc <kbdgetc+0x81>
80102cb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102cbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cc2:	05 20 90 10 80       	add    $0x80109020,%eax
80102cc7:	0f b6 00             	movzbl (%eax),%eax
80102cca:	83 c8 40             	or     $0x40,%eax
80102ccd:	0f b6 c0             	movzbl %al,%eax
80102cd0:	f7 d0                	not    %eax
80102cd2:	89 c2                	mov    %eax,%edx
80102cd4:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cd9:	21 d0                	and    %edx,%eax
80102cdb:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102ce0:	b8 00 00 00 00       	mov    $0x0,%eax
80102ce5:	e9 a2 00 00 00       	jmp    80102d8c <kbdgetc+0x151>
  } else if(shift & E0ESC){
80102cea:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cef:	83 e0 40             	and    $0x40,%eax
80102cf2:	85 c0                	test   %eax,%eax
80102cf4:	74 14                	je     80102d0a <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102cf6:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102cfd:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d02:	83 e0 bf             	and    $0xffffffbf,%eax
80102d05:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102d0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d0d:	05 20 90 10 80       	add    $0x80109020,%eax
80102d12:	0f b6 00             	movzbl (%eax),%eax
80102d15:	0f b6 d0             	movzbl %al,%edx
80102d18:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d1d:	09 d0                	or     %edx,%eax
80102d1f:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102d24:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d27:	05 20 91 10 80       	add    $0x80109120,%eax
80102d2c:	0f b6 00             	movzbl (%eax),%eax
80102d2f:	0f b6 d0             	movzbl %al,%edx
80102d32:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d37:	31 d0                	xor    %edx,%eax
80102d39:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102d3e:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d43:	83 e0 03             	and    $0x3,%eax
80102d46:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102d4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d50:	01 d0                	add    %edx,%eax
80102d52:	0f b6 00             	movzbl (%eax),%eax
80102d55:	0f b6 c0             	movzbl %al,%eax
80102d58:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102d5b:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d60:	83 e0 08             	and    $0x8,%eax
80102d63:	85 c0                	test   %eax,%eax
80102d65:	74 22                	je     80102d89 <kbdgetc+0x14e>
    if('a' <= c && c <= 'z')
80102d67:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102d6b:	76 0c                	jbe    80102d79 <kbdgetc+0x13e>
80102d6d:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102d71:	77 06                	ja     80102d79 <kbdgetc+0x13e>
      c += 'A' - 'a';
80102d73:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102d77:	eb 10                	jmp    80102d89 <kbdgetc+0x14e>
    else if('A' <= c && c <= 'Z')
80102d79:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102d7d:	76 0a                	jbe    80102d89 <kbdgetc+0x14e>
80102d7f:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102d83:	77 04                	ja     80102d89 <kbdgetc+0x14e>
      c += 'a' - 'A';
80102d85:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102d89:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102d8c:	c9                   	leave  
80102d8d:	c3                   	ret    

80102d8e <kbdintr>:

void
kbdintr(void)
{
80102d8e:	55                   	push   %ebp
80102d8f:	89 e5                	mov    %esp,%ebp
80102d91:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102d94:	c7 04 24 3b 2c 10 80 	movl   $0x80102c3b,(%esp)
80102d9b:	e8 50 da ff ff       	call   801007f0 <consoleintr>
}
80102da0:	c9                   	leave  
80102da1:	c3                   	ret    

80102da2 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102da2:	55                   	push   %ebp
80102da3:	89 e5                	mov    %esp,%ebp
80102da5:	83 ec 14             	sub    $0x14,%esp
80102da8:	8b 45 08             	mov    0x8(%ebp),%eax
80102dab:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102daf:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102db3:	89 c2                	mov    %eax,%edx
80102db5:	ec                   	in     (%dx),%al
80102db6:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102db9:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102dbd:	c9                   	leave  
80102dbe:	c3                   	ret    

80102dbf <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102dbf:	55                   	push   %ebp
80102dc0:	89 e5                	mov    %esp,%ebp
80102dc2:	83 ec 08             	sub    $0x8,%esp
80102dc5:	8b 55 08             	mov    0x8(%ebp),%edx
80102dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80102dcb:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102dcf:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dd2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102dd6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102dda:	ee                   	out    %al,(%dx)
}
80102ddb:	c9                   	leave  
80102ddc:	c3                   	ret    

80102ddd <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102ddd:	55                   	push   %ebp
80102dde:	89 e5                	mov    %esp,%ebp
80102de0:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102de3:	9c                   	pushf  
80102de4:	58                   	pop    %eax
80102de5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102de8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102deb:	c9                   	leave  
80102dec:	c3                   	ret    

80102ded <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102ded:	55                   	push   %ebp
80102dee:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102df0:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102df5:	8b 55 08             	mov    0x8(%ebp),%edx
80102df8:	c1 e2 02             	shl    $0x2,%edx
80102dfb:	01 c2                	add    %eax,%edx
80102dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e00:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102e02:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102e07:	83 c0 20             	add    $0x20,%eax
80102e0a:	8b 00                	mov    (%eax),%eax
}
80102e0c:	5d                   	pop    %ebp
80102e0d:	c3                   	ret    

80102e0e <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102e0e:	55                   	push   %ebp
80102e0f:	89 e5                	mov    %esp,%ebp
80102e11:	83 ec 08             	sub    $0x8,%esp
  if(!lapic)
80102e14:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102e19:	85 c0                	test   %eax,%eax
80102e1b:	75 05                	jne    80102e22 <lapicinit+0x14>
    return;
80102e1d:	e9 43 01 00 00       	jmp    80102f65 <lapicinit+0x157>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102e22:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102e29:	00 
80102e2a:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102e31:	e8 b7 ff ff ff       	call   80102ded <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102e36:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102e3d:	00 
80102e3e:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102e45:	e8 a3 ff ff ff       	call   80102ded <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102e4a:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102e51:	00 
80102e52:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102e59:	e8 8f ff ff ff       	call   80102ded <lapicw>
  lapicw(TICR, 10000000);
80102e5e:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102e65:	00 
80102e66:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102e6d:	e8 7b ff ff ff       	call   80102ded <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102e72:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102e79:	00 
80102e7a:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102e81:	e8 67 ff ff ff       	call   80102ded <lapicw>
  lapicw(LINT1, MASKED);
80102e86:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102e8d:	00 
80102e8e:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102e95:	e8 53 ff ff ff       	call   80102ded <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e9a:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102e9f:	83 c0 30             	add    $0x30,%eax
80102ea2:	8b 00                	mov    (%eax),%eax
80102ea4:	c1 e8 10             	shr    $0x10,%eax
80102ea7:	0f b6 c0             	movzbl %al,%eax
80102eaa:	83 f8 03             	cmp    $0x3,%eax
80102ead:	76 14                	jbe    80102ec3 <lapicinit+0xb5>
    lapicw(PCINT, MASKED);
80102eaf:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102eb6:	00 
80102eb7:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102ebe:	e8 2a ff ff ff       	call   80102ded <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102ec3:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102eca:	00 
80102ecb:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102ed2:	e8 16 ff ff ff       	call   80102ded <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102ed7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102ede:	00 
80102edf:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102ee6:	e8 02 ff ff ff       	call   80102ded <lapicw>
  lapicw(ESR, 0);
80102eeb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102ef2:	00 
80102ef3:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102efa:	e8 ee fe ff ff       	call   80102ded <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102eff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f06:	00 
80102f07:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102f0e:	e8 da fe ff ff       	call   80102ded <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102f13:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f1a:	00 
80102f1b:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102f22:	e8 c6 fe ff ff       	call   80102ded <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102f27:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102f2e:	00 
80102f2f:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f36:	e8 b2 fe ff ff       	call   80102ded <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102f3b:	90                   	nop
80102f3c:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102f41:	05 00 03 00 00       	add    $0x300,%eax
80102f46:	8b 00                	mov    (%eax),%eax
80102f48:	25 00 10 00 00       	and    $0x1000,%eax
80102f4d:	85 c0                	test   %eax,%eax
80102f4f:	75 eb                	jne    80102f3c <lapicinit+0x12e>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102f51:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f58:	00 
80102f59:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102f60:	e8 88 fe ff ff       	call   80102ded <lapicw>
}
80102f65:	c9                   	leave  
80102f66:	c3                   	ret    

80102f67 <cpunum>:

int
cpunum(void)
{
80102f67:	55                   	push   %ebp
80102f68:	89 e5                	mov    %esp,%ebp
80102f6a:	83 ec 28             	sub    $0x28,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102f6d:	e8 6b fe ff ff       	call   80102ddd <readeflags>
80102f72:	25 00 02 00 00       	and    $0x200,%eax
80102f77:	85 c0                	test   %eax,%eax
80102f79:	74 25                	je     80102fa0 <cpunum+0x39>
    static int n;
    if(n++ == 0)
80102f7b:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102f80:	8d 50 01             	lea    0x1(%eax),%edx
80102f83:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
80102f89:	85 c0                	test   %eax,%eax
80102f8b:	75 13                	jne    80102fa0 <cpunum+0x39>
      cprintf("cpu called from %x with interrupts enabled\n",
80102f8d:	8b 45 04             	mov    0x4(%ebp),%eax
80102f90:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f94:	c7 04 24 f0 87 10 80 	movl   $0x801087f0,(%esp)
80102f9b:	e8 28 d4 ff ff       	call   801003c8 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
80102fa0:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102fa5:	85 c0                	test   %eax,%eax
80102fa7:	75 07                	jne    80102fb0 <cpunum+0x49>
    return 0;
80102fa9:	b8 00 00 00 00       	mov    $0x0,%eax
80102fae:	eb 51                	jmp    80103001 <cpunum+0x9a>

  apicid = lapic[ID] >> 24;
80102fb0:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102fb5:	83 c0 20             	add    $0x20,%eax
80102fb8:	8b 00                	mov    (%eax),%eax
80102fba:	c1 e8 18             	shr    $0x18,%eax
80102fbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < ncpu; ++i) {
80102fc0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102fc7:	eb 22                	jmp    80102feb <cpunum+0x84>
    if (cpus[i].apicid == apicid)
80102fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102fcc:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102fd2:	05 20 38 11 80       	add    $0x80113820,%eax
80102fd7:	0f b6 00             	movzbl (%eax),%eax
80102fda:	0f b6 c0             	movzbl %al,%eax
80102fdd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102fe0:	75 05                	jne    80102fe7 <cpunum+0x80>
      return i;
80102fe2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102fe5:	eb 1a                	jmp    80103001 <cpunum+0x9a>

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
80102fe7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102feb:	a1 00 3e 11 80       	mov    0x80113e00,%eax
80102ff0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102ff3:	7c d4                	jl     80102fc9 <cpunum+0x62>
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102ff5:	c7 04 24 1c 88 10 80 	movl   $0x8010881c,(%esp)
80102ffc:	e8 61 d5 ff ff       	call   80100562 <panic>
}
80103001:	c9                   	leave  
80103002:	c3                   	ret    

80103003 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103003:	55                   	push   %ebp
80103004:	89 e5                	mov    %esp,%ebp
80103006:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80103009:	a1 1c 37 11 80       	mov    0x8011371c,%eax
8010300e:	85 c0                	test   %eax,%eax
80103010:	74 14                	je     80103026 <lapiceoi+0x23>
    lapicw(EOI, 0);
80103012:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103019:	00 
8010301a:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80103021:	e8 c7 fd ff ff       	call   80102ded <lapicw>
}
80103026:	c9                   	leave  
80103027:	c3                   	ret    

80103028 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103028:	55                   	push   %ebp
80103029:	89 e5                	mov    %esp,%ebp
}
8010302b:	5d                   	pop    %ebp
8010302c:	c3                   	ret    

8010302d <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
8010302d:	55                   	push   %ebp
8010302e:	89 e5                	mov    %esp,%ebp
80103030:	83 ec 1c             	sub    $0x1c,%esp
80103033:	8b 45 08             	mov    0x8(%ebp),%eax
80103036:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80103039:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80103040:	00 
80103041:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80103048:	e8 72 fd ff ff       	call   80102dbf <outb>
  outb(CMOS_PORT+1, 0x0A);
8010304d:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103054:	00 
80103055:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
8010305c:	e8 5e fd ff ff       	call   80102dbf <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103061:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103068:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010306b:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103070:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103073:	8d 50 02             	lea    0x2(%eax),%edx
80103076:	8b 45 0c             	mov    0xc(%ebp),%eax
80103079:	c1 e8 04             	shr    $0x4,%eax
8010307c:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010307f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103083:	c1 e0 18             	shl    $0x18,%eax
80103086:	89 44 24 04          	mov    %eax,0x4(%esp)
8010308a:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80103091:	e8 57 fd ff ff       	call   80102ded <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103096:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
8010309d:	00 
8010309e:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801030a5:	e8 43 fd ff ff       	call   80102ded <lapicw>
  microdelay(200);
801030aa:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
801030b1:	e8 72 ff ff ff       	call   80103028 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
801030b6:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
801030bd:	00 
801030be:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801030c5:	e8 23 fd ff ff       	call   80102ded <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
801030ca:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
801030d1:	e8 52 ff ff ff       	call   80103028 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801030d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801030dd:	eb 40                	jmp    8010311f <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
801030df:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030e3:	c1 e0 18             	shl    $0x18,%eax
801030e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801030ea:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
801030f1:	e8 f7 fc ff ff       	call   80102ded <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
801030f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801030f9:	c1 e8 0c             	shr    $0xc,%eax
801030fc:	80 cc 06             	or     $0x6,%ah
801030ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103103:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
8010310a:	e8 de fc ff ff       	call   80102ded <lapicw>
    microdelay(200);
8010310f:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80103116:	e8 0d ff ff ff       	call   80103028 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010311b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010311f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103123:	7e ba                	jle    801030df <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103125:	c9                   	leave  
80103126:	c3                   	ret    

80103127 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
80103127:	55                   	push   %ebp
80103128:	89 e5                	mov    %esp,%ebp
8010312a:	83 ec 08             	sub    $0x8,%esp
  outb(CMOS_PORT,  reg);
8010312d:	8b 45 08             	mov    0x8(%ebp),%eax
80103130:	0f b6 c0             	movzbl %al,%eax
80103133:	89 44 24 04          	mov    %eax,0x4(%esp)
80103137:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
8010313e:	e8 7c fc ff ff       	call   80102dbf <outb>
  microdelay(200);
80103143:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
8010314a:	e8 d9 fe ff ff       	call   80103028 <microdelay>

  return inb(CMOS_RETURN);
8010314f:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80103156:	e8 47 fc ff ff       	call   80102da2 <inb>
8010315b:	0f b6 c0             	movzbl %al,%eax
}
8010315e:	c9                   	leave  
8010315f:	c3                   	ret    

80103160 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
80103166:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010316d:	e8 b5 ff ff ff       	call   80103127 <cmos_read>
80103172:	8b 55 08             	mov    0x8(%ebp),%edx
80103175:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
80103177:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010317e:	e8 a4 ff ff ff       	call   80103127 <cmos_read>
80103183:	8b 55 08             	mov    0x8(%ebp),%edx
80103186:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
80103189:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80103190:	e8 92 ff ff ff       	call   80103127 <cmos_read>
80103195:	8b 55 08             	mov    0x8(%ebp),%edx
80103198:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
8010319b:	c7 04 24 07 00 00 00 	movl   $0x7,(%esp)
801031a2:	e8 80 ff ff ff       	call   80103127 <cmos_read>
801031a7:	8b 55 08             	mov    0x8(%ebp),%edx
801031aa:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
801031ad:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801031b4:	e8 6e ff ff ff       	call   80103127 <cmos_read>
801031b9:	8b 55 08             	mov    0x8(%ebp),%edx
801031bc:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
801031bf:	c7 04 24 09 00 00 00 	movl   $0x9,(%esp)
801031c6:	e8 5c ff ff ff       	call   80103127 <cmos_read>
801031cb:	8b 55 08             	mov    0x8(%ebp),%edx
801031ce:	89 42 14             	mov    %eax,0x14(%edx)
}
801031d1:	c9                   	leave  
801031d2:	c3                   	ret    

801031d3 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801031d3:	55                   	push   %ebp
801031d4:	89 e5                	mov    %esp,%ebp
801031d6:	83 ec 58             	sub    $0x58,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801031d9:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
801031e0:	e8 42 ff ff ff       	call   80103127 <cmos_read>
801031e5:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
801031e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031eb:	83 e0 04             	and    $0x4,%eax
801031ee:	85 c0                	test   %eax,%eax
801031f0:	0f 94 c0             	sete   %al
801031f3:	0f b6 c0             	movzbl %al,%eax
801031f6:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
801031f9:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031fc:	89 04 24             	mov    %eax,(%esp)
801031ff:	e8 5c ff ff ff       	call   80103160 <fill_rtcdate>
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103204:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
8010320b:	e8 17 ff ff ff       	call   80103127 <cmos_read>
80103210:	25 80 00 00 00       	and    $0x80,%eax
80103215:	85 c0                	test   %eax,%eax
80103217:	74 02                	je     8010321b <cmostime+0x48>
        continue;
80103219:	eb 36                	jmp    80103251 <cmostime+0x7e>
    fill_rtcdate(&t2);
8010321b:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010321e:	89 04 24             	mov    %eax,(%esp)
80103221:	e8 3a ff ff ff       	call   80103160 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103226:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
8010322d:	00 
8010322e:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103231:	89 44 24 04          	mov    %eax,0x4(%esp)
80103235:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103238:	89 04 24             	mov    %eax,(%esp)
8010323b:	e8 f0 1f 00 00       	call   80105230 <memcmp>
80103240:	85 c0                	test   %eax,%eax
80103242:	75 0d                	jne    80103251 <cmostime+0x7e>
      break;
80103244:	90                   	nop
  }

  // convert
  if(bcd) {
80103245:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103249:	0f 84 ac 00 00 00    	je     801032fb <cmostime+0x128>
8010324f:	eb 02                	jmp    80103253 <cmostime+0x80>
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
80103251:	eb a6                	jmp    801031f9 <cmostime+0x26>

  // convert
  if(bcd) {
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103253:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103256:	c1 e8 04             	shr    $0x4,%eax
80103259:	89 c2                	mov    %eax,%edx
8010325b:	89 d0                	mov    %edx,%eax
8010325d:	c1 e0 02             	shl    $0x2,%eax
80103260:	01 d0                	add    %edx,%eax
80103262:	01 c0                	add    %eax,%eax
80103264:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103267:	83 e2 0f             	and    $0xf,%edx
8010326a:	01 d0                	add    %edx,%eax
8010326c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
8010326f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103272:	c1 e8 04             	shr    $0x4,%eax
80103275:	89 c2                	mov    %eax,%edx
80103277:	89 d0                	mov    %edx,%eax
80103279:	c1 e0 02             	shl    $0x2,%eax
8010327c:	01 d0                	add    %edx,%eax
8010327e:	01 c0                	add    %eax,%eax
80103280:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103283:	83 e2 0f             	and    $0xf,%edx
80103286:	01 d0                	add    %edx,%eax
80103288:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
8010328b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010328e:	c1 e8 04             	shr    $0x4,%eax
80103291:	89 c2                	mov    %eax,%edx
80103293:	89 d0                	mov    %edx,%eax
80103295:	c1 e0 02             	shl    $0x2,%eax
80103298:	01 d0                	add    %edx,%eax
8010329a:	01 c0                	add    %eax,%eax
8010329c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010329f:	83 e2 0f             	and    $0xf,%edx
801032a2:	01 d0                	add    %edx,%eax
801032a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
801032a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032aa:	c1 e8 04             	shr    $0x4,%eax
801032ad:	89 c2                	mov    %eax,%edx
801032af:	89 d0                	mov    %edx,%eax
801032b1:	c1 e0 02             	shl    $0x2,%eax
801032b4:	01 d0                	add    %edx,%eax
801032b6:	01 c0                	add    %eax,%eax
801032b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032bb:	83 e2 0f             	and    $0xf,%edx
801032be:	01 d0                	add    %edx,%eax
801032c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
801032c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032c6:	c1 e8 04             	shr    $0x4,%eax
801032c9:	89 c2                	mov    %eax,%edx
801032cb:	89 d0                	mov    %edx,%eax
801032cd:	c1 e0 02             	shl    $0x2,%eax
801032d0:	01 d0                	add    %edx,%eax
801032d2:	01 c0                	add    %eax,%eax
801032d4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032d7:	83 e2 0f             	and    $0xf,%edx
801032da:	01 d0                	add    %edx,%eax
801032dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
801032df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032e2:	c1 e8 04             	shr    $0x4,%eax
801032e5:	89 c2                	mov    %eax,%edx
801032e7:	89 d0                	mov    %edx,%eax
801032e9:	c1 e0 02             	shl    $0x2,%eax
801032ec:	01 d0                	add    %edx,%eax
801032ee:	01 c0                	add    %eax,%eax
801032f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801032f3:	83 e2 0f             	and    $0xf,%edx
801032f6:	01 d0                	add    %edx,%eax
801032f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
801032fb:	8b 45 08             	mov    0x8(%ebp),%eax
801032fe:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103301:	89 10                	mov    %edx,(%eax)
80103303:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103306:	89 50 04             	mov    %edx,0x4(%eax)
80103309:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010330c:	89 50 08             	mov    %edx,0x8(%eax)
8010330f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103312:	89 50 0c             	mov    %edx,0xc(%eax)
80103315:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103318:	89 50 10             	mov    %edx,0x10(%eax)
8010331b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010331e:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
80103321:	8b 45 08             	mov    0x8(%ebp),%eax
80103324:	8b 40 14             	mov    0x14(%eax),%eax
80103327:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
8010332d:	8b 45 08             	mov    0x8(%ebp),%eax
80103330:	89 50 14             	mov    %edx,0x14(%eax)
}
80103333:	c9                   	leave  
80103334:	c3                   	ret    

80103335 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103335:	55                   	push   %ebp
80103336:	89 e5                	mov    %esp,%ebp
80103338:	83 ec 38             	sub    $0x38,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010333b:	c7 44 24 04 2c 88 10 	movl   $0x8010882c,0x4(%esp)
80103342:	80 
80103343:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
8010334a:	e8 e0 1b 00 00       	call   80104f2f <initlock>
  readsb(dev, &sb);
8010334f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103352:	89 44 24 04          	mov    %eax,0x4(%esp)
80103356:	8b 45 08             	mov    0x8(%ebp),%eax
80103359:	89 04 24             	mov    %eax,(%esp)
8010335c:	e8 04 e0 ff ff       	call   80101365 <readsb>
  log.start = sb.logstart;
80103361:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103364:	a3 54 37 11 80       	mov    %eax,0x80113754
  log.size = sb.nlog;
80103369:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010336c:	a3 58 37 11 80       	mov    %eax,0x80113758
  log.dev = dev;
80103371:	8b 45 08             	mov    0x8(%ebp),%eax
80103374:	a3 64 37 11 80       	mov    %eax,0x80113764
  recover_from_log();
80103379:	e8 9a 01 00 00       	call   80103518 <recover_from_log>
}
8010337e:	c9                   	leave  
8010337f:	c3                   	ret    

80103380 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103386:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010338d:	e9 8c 00 00 00       	jmp    8010341e <install_trans+0x9e>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103392:	8b 15 54 37 11 80    	mov    0x80113754,%edx
80103398:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010339b:	01 d0                	add    %edx,%eax
8010339d:	83 c0 01             	add    $0x1,%eax
801033a0:	89 c2                	mov    %eax,%edx
801033a2:	a1 64 37 11 80       	mov    0x80113764,%eax
801033a7:	89 54 24 04          	mov    %edx,0x4(%esp)
801033ab:	89 04 24             	mov    %eax,(%esp)
801033ae:	e8 02 ce ff ff       	call   801001b5 <bread>
801033b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801033b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033b9:	83 c0 10             	add    $0x10,%eax
801033bc:	8b 04 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%eax
801033c3:	89 c2                	mov    %eax,%edx
801033c5:	a1 64 37 11 80       	mov    0x80113764,%eax
801033ca:	89 54 24 04          	mov    %edx,0x4(%esp)
801033ce:	89 04 24             	mov    %eax,(%esp)
801033d1:	e8 df cd ff ff       	call   801001b5 <bread>
801033d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801033d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033dc:	8d 50 5c             	lea    0x5c(%eax),%edx
801033df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033e2:	83 c0 5c             	add    $0x5c,%eax
801033e5:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801033ec:	00 
801033ed:	89 54 24 04          	mov    %edx,0x4(%esp)
801033f1:	89 04 24             	mov    %eax,(%esp)
801033f4:	e8 8f 1e 00 00       	call   80105288 <memmove>
    bwrite(dbuf);  // write dst to disk
801033f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033fc:	89 04 24             	mov    %eax,(%esp)
801033ff:	e8 e8 cd ff ff       	call   801001ec <bwrite>
    brelse(lbuf);
80103404:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103407:	89 04 24             	mov    %eax,(%esp)
8010340a:	e8 1d ce ff ff       	call   8010022c <brelse>
    brelse(dbuf);
8010340f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103412:	89 04 24             	mov    %eax,(%esp)
80103415:	e8 12 ce ff ff       	call   8010022c <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010341a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010341e:	a1 68 37 11 80       	mov    0x80113768,%eax
80103423:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103426:	0f 8f 66 ff ff ff    	jg     80103392 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
8010342c:	c9                   	leave  
8010342d:	c3                   	ret    

8010342e <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
8010342e:	55                   	push   %ebp
8010342f:	89 e5                	mov    %esp,%ebp
80103431:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103434:	a1 54 37 11 80       	mov    0x80113754,%eax
80103439:	89 c2                	mov    %eax,%edx
8010343b:	a1 64 37 11 80       	mov    0x80113764,%eax
80103440:	89 54 24 04          	mov    %edx,0x4(%esp)
80103444:	89 04 24             	mov    %eax,(%esp)
80103447:	e8 69 cd ff ff       	call   801001b5 <bread>
8010344c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010344f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103452:	83 c0 5c             	add    $0x5c,%eax
80103455:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103458:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010345b:	8b 00                	mov    (%eax),%eax
8010345d:	a3 68 37 11 80       	mov    %eax,0x80113768
  for (i = 0; i < log.lh.n; i++) {
80103462:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103469:	eb 1b                	jmp    80103486 <read_head+0x58>
    log.lh.block[i] = lh->block[i];
8010346b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010346e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103471:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103475:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103478:	83 c2 10             	add    $0x10,%edx
8010347b:	89 04 95 2c 37 11 80 	mov    %eax,-0x7feec8d4(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103482:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103486:	a1 68 37 11 80       	mov    0x80113768,%eax
8010348b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010348e:	7f db                	jg     8010346b <read_head+0x3d>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80103490:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103493:	89 04 24             	mov    %eax,(%esp)
80103496:	e8 91 cd ff ff       	call   8010022c <brelse>
}
8010349b:	c9                   	leave  
8010349c:	c3                   	ret    

8010349d <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010349d:	55                   	push   %ebp
8010349e:	89 e5                	mov    %esp,%ebp
801034a0:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
801034a3:	a1 54 37 11 80       	mov    0x80113754,%eax
801034a8:	89 c2                	mov    %eax,%edx
801034aa:	a1 64 37 11 80       	mov    0x80113764,%eax
801034af:	89 54 24 04          	mov    %edx,0x4(%esp)
801034b3:	89 04 24             	mov    %eax,(%esp)
801034b6:	e8 fa cc ff ff       	call   801001b5 <bread>
801034bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801034be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034c1:	83 c0 5c             	add    $0x5c,%eax
801034c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801034c7:	8b 15 68 37 11 80    	mov    0x80113768,%edx
801034cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034d0:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034d9:	eb 1b                	jmp    801034f6 <write_head+0x59>
    hb->block[i] = log.lh.block[i];
801034db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034de:	83 c0 10             	add    $0x10,%eax
801034e1:	8b 0c 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%ecx
801034e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034ee:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801034f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034f6:	a1 68 37 11 80       	mov    0x80113768,%eax
801034fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034fe:	7f db                	jg     801034db <write_head+0x3e>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80103500:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103503:	89 04 24             	mov    %eax,(%esp)
80103506:	e8 e1 cc ff ff       	call   801001ec <bwrite>
  brelse(buf);
8010350b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010350e:	89 04 24             	mov    %eax,(%esp)
80103511:	e8 16 cd ff ff       	call   8010022c <brelse>
}
80103516:	c9                   	leave  
80103517:	c3                   	ret    

80103518 <recover_from_log>:

static void
recover_from_log(void)
{
80103518:	55                   	push   %ebp
80103519:	89 e5                	mov    %esp,%ebp
8010351b:	83 ec 08             	sub    $0x8,%esp
  read_head();
8010351e:	e8 0b ff ff ff       	call   8010342e <read_head>
  install_trans(); // if committed, copy from log to disk
80103523:	e8 58 fe ff ff       	call   80103380 <install_trans>
  log.lh.n = 0;
80103528:	c7 05 68 37 11 80 00 	movl   $0x0,0x80113768
8010352f:	00 00 00 
  write_head(); // clear the log
80103532:	e8 66 ff ff ff       	call   8010349d <write_head>
}
80103537:	c9                   	leave  
80103538:	c3                   	ret    

80103539 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103539:	55                   	push   %ebp
8010353a:	89 e5                	mov    %esp,%ebp
8010353c:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
8010353f:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103546:	e8 05 1a 00 00       	call   80104f50 <acquire>
  while(1){
    if(log.committing){
8010354b:	a1 60 37 11 80       	mov    0x80113760,%eax
80103550:	85 c0                	test   %eax,%eax
80103552:	74 16                	je     8010356a <begin_op+0x31>
      sleep(&log, &log.lock);
80103554:	c7 44 24 04 20 37 11 	movl   $0x80113720,0x4(%esp)
8010355b:	80 
8010355c:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103563:	e8 17 16 00 00       	call   80104b7f <sleep>
80103568:	eb 4f                	jmp    801035b9 <begin_op+0x80>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010356a:	8b 0d 68 37 11 80    	mov    0x80113768,%ecx
80103570:	a1 5c 37 11 80       	mov    0x8011375c,%eax
80103575:	8d 50 01             	lea    0x1(%eax),%edx
80103578:	89 d0                	mov    %edx,%eax
8010357a:	c1 e0 02             	shl    $0x2,%eax
8010357d:	01 d0                	add    %edx,%eax
8010357f:	01 c0                	add    %eax,%eax
80103581:	01 c8                	add    %ecx,%eax
80103583:	83 f8 1e             	cmp    $0x1e,%eax
80103586:	7e 16                	jle    8010359e <begin_op+0x65>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103588:	c7 44 24 04 20 37 11 	movl   $0x80113720,0x4(%esp)
8010358f:	80 
80103590:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103597:	e8 e3 15 00 00       	call   80104b7f <sleep>
8010359c:	eb 1b                	jmp    801035b9 <begin_op+0x80>
    } else {
      log.outstanding += 1;
8010359e:	a1 5c 37 11 80       	mov    0x8011375c,%eax
801035a3:	83 c0 01             	add    $0x1,%eax
801035a6:	a3 5c 37 11 80       	mov    %eax,0x8011375c
      release(&log.lock);
801035ab:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
801035b2:	e8 00 1a 00 00       	call   80104fb7 <release>
      break;
801035b7:	eb 02                	jmp    801035bb <begin_op+0x82>
    }
  }
801035b9:	eb 90                	jmp    8010354b <begin_op+0x12>
}
801035bb:	c9                   	leave  
801035bc:	c3                   	ret    

801035bd <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801035bd:	55                   	push   %ebp
801035be:	89 e5                	mov    %esp,%ebp
801035c0:	83 ec 28             	sub    $0x28,%esp
  int do_commit = 0;
801035c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
801035ca:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
801035d1:	e8 7a 19 00 00       	call   80104f50 <acquire>
  log.outstanding -= 1;
801035d6:	a1 5c 37 11 80       	mov    0x8011375c,%eax
801035db:	83 e8 01             	sub    $0x1,%eax
801035de:	a3 5c 37 11 80       	mov    %eax,0x8011375c
  if(log.committing)
801035e3:	a1 60 37 11 80       	mov    0x80113760,%eax
801035e8:	85 c0                	test   %eax,%eax
801035ea:	74 0c                	je     801035f8 <end_op+0x3b>
    panic("log.committing");
801035ec:	c7 04 24 30 88 10 80 	movl   $0x80108830,(%esp)
801035f3:	e8 6a cf ff ff       	call   80100562 <panic>
  if(log.outstanding == 0){
801035f8:	a1 5c 37 11 80       	mov    0x8011375c,%eax
801035fd:	85 c0                	test   %eax,%eax
801035ff:	75 13                	jne    80103614 <end_op+0x57>
    do_commit = 1;
80103601:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103608:	c7 05 60 37 11 80 01 	movl   $0x1,0x80113760
8010360f:	00 00 00 
80103612:	eb 0c                	jmp    80103620 <end_op+0x63>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80103614:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
8010361b:	e8 38 16 00 00       	call   80104c58 <wakeup>
  }
  release(&log.lock);
80103620:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103627:	e8 8b 19 00 00       	call   80104fb7 <release>

  if(do_commit){
8010362c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103630:	74 33                	je     80103665 <end_op+0xa8>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103632:	e8 de 00 00 00       	call   80103715 <commit>
    acquire(&log.lock);
80103637:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
8010363e:	e8 0d 19 00 00       	call   80104f50 <acquire>
    log.committing = 0;
80103643:	c7 05 60 37 11 80 00 	movl   $0x0,0x80113760
8010364a:	00 00 00 
    wakeup(&log);
8010364d:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103654:	e8 ff 15 00 00       	call   80104c58 <wakeup>
    release(&log.lock);
80103659:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103660:	e8 52 19 00 00       	call   80104fb7 <release>
  }
}
80103665:	c9                   	leave  
80103666:	c3                   	ret    

80103667 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80103667:	55                   	push   %ebp
80103668:	89 e5                	mov    %esp,%ebp
8010366a:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010366d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103674:	e9 8c 00 00 00       	jmp    80103705 <write_log+0x9e>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103679:	8b 15 54 37 11 80    	mov    0x80113754,%edx
8010367f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103682:	01 d0                	add    %edx,%eax
80103684:	83 c0 01             	add    $0x1,%eax
80103687:	89 c2                	mov    %eax,%edx
80103689:	a1 64 37 11 80       	mov    0x80113764,%eax
8010368e:	89 54 24 04          	mov    %edx,0x4(%esp)
80103692:	89 04 24             	mov    %eax,(%esp)
80103695:	e8 1b cb ff ff       	call   801001b5 <bread>
8010369a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010369d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036a0:	83 c0 10             	add    $0x10,%eax
801036a3:	8b 04 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%eax
801036aa:	89 c2                	mov    %eax,%edx
801036ac:	a1 64 37 11 80       	mov    0x80113764,%eax
801036b1:	89 54 24 04          	mov    %edx,0x4(%esp)
801036b5:	89 04 24             	mov    %eax,(%esp)
801036b8:	e8 f8 ca ff ff       	call   801001b5 <bread>
801036bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
801036c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036c3:	8d 50 5c             	lea    0x5c(%eax),%edx
801036c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036c9:	83 c0 5c             	add    $0x5c,%eax
801036cc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801036d3:	00 
801036d4:	89 54 24 04          	mov    %edx,0x4(%esp)
801036d8:	89 04 24             	mov    %eax,(%esp)
801036db:	e8 a8 1b 00 00       	call   80105288 <memmove>
    bwrite(to);  // write the log
801036e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036e3:	89 04 24             	mov    %eax,(%esp)
801036e6:	e8 01 cb ff ff       	call   801001ec <bwrite>
    brelse(from);
801036eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036ee:	89 04 24             	mov    %eax,(%esp)
801036f1:	e8 36 cb ff ff       	call   8010022c <brelse>
    brelse(to);
801036f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036f9:	89 04 24             	mov    %eax,(%esp)
801036fc:	e8 2b cb ff ff       	call   8010022c <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103701:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103705:	a1 68 37 11 80       	mov    0x80113768,%eax
8010370a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010370d:	0f 8f 66 ff ff ff    	jg     80103679 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from);
    brelse(to);
  }
}
80103713:	c9                   	leave  
80103714:	c3                   	ret    

80103715 <commit>:

static void
commit()
{
80103715:	55                   	push   %ebp
80103716:	89 e5                	mov    %esp,%ebp
80103718:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
8010371b:	a1 68 37 11 80       	mov    0x80113768,%eax
80103720:	85 c0                	test   %eax,%eax
80103722:	7e 1e                	jle    80103742 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
80103724:	e8 3e ff ff ff       	call   80103667 <write_log>
    write_head();    // Write header to disk -- the real commit
80103729:	e8 6f fd ff ff       	call   8010349d <write_head>
    install_trans(); // Now install writes to home locations
8010372e:	e8 4d fc ff ff       	call   80103380 <install_trans>
    log.lh.n = 0;
80103733:	c7 05 68 37 11 80 00 	movl   $0x0,0x80113768
8010373a:	00 00 00 
    write_head();    // Erase the transaction from the log
8010373d:	e8 5b fd ff ff       	call   8010349d <write_head>
  }
}
80103742:	c9                   	leave  
80103743:	c3                   	ret    

80103744 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103744:	55                   	push   %ebp
80103745:	89 e5                	mov    %esp,%ebp
80103747:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010374a:	a1 68 37 11 80       	mov    0x80113768,%eax
8010374f:	83 f8 1d             	cmp    $0x1d,%eax
80103752:	7f 12                	jg     80103766 <log_write+0x22>
80103754:	a1 68 37 11 80       	mov    0x80113768,%eax
80103759:	8b 15 58 37 11 80    	mov    0x80113758,%edx
8010375f:	83 ea 01             	sub    $0x1,%edx
80103762:	39 d0                	cmp    %edx,%eax
80103764:	7c 0c                	jl     80103772 <log_write+0x2e>
    panic("too big a transaction");
80103766:	c7 04 24 3f 88 10 80 	movl   $0x8010883f,(%esp)
8010376d:	e8 f0 cd ff ff       	call   80100562 <panic>
  if (log.outstanding < 1)
80103772:	a1 5c 37 11 80       	mov    0x8011375c,%eax
80103777:	85 c0                	test   %eax,%eax
80103779:	7f 0c                	jg     80103787 <log_write+0x43>
    panic("log_write outside of trans");
8010377b:	c7 04 24 55 88 10 80 	movl   $0x80108855,(%esp)
80103782:	e8 db cd ff ff       	call   80100562 <panic>

  acquire(&log.lock);
80103787:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
8010378e:	e8 bd 17 00 00       	call   80104f50 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103793:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010379a:	eb 1f                	jmp    801037bb <log_write+0x77>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
8010379c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010379f:	83 c0 10             	add    $0x10,%eax
801037a2:	8b 04 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%eax
801037a9:	89 c2                	mov    %eax,%edx
801037ab:	8b 45 08             	mov    0x8(%ebp),%eax
801037ae:	8b 40 08             	mov    0x8(%eax),%eax
801037b1:	39 c2                	cmp    %eax,%edx
801037b3:	75 02                	jne    801037b7 <log_write+0x73>
      break;
801037b5:	eb 0e                	jmp    801037c5 <log_write+0x81>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801037b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037bb:	a1 68 37 11 80       	mov    0x80113768,%eax
801037c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037c3:	7f d7                	jg     8010379c <log_write+0x58>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801037c5:	8b 45 08             	mov    0x8(%ebp),%eax
801037c8:	8b 40 08             	mov    0x8(%eax),%eax
801037cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801037ce:	83 c2 10             	add    $0x10,%edx
801037d1:	89 04 95 2c 37 11 80 	mov    %eax,-0x7feec8d4(,%edx,4)
  if (i == log.lh.n)
801037d8:	a1 68 37 11 80       	mov    0x80113768,%eax
801037dd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037e0:	75 0d                	jne    801037ef <log_write+0xab>
    log.lh.n++;
801037e2:	a1 68 37 11 80       	mov    0x80113768,%eax
801037e7:	83 c0 01             	add    $0x1,%eax
801037ea:	a3 68 37 11 80       	mov    %eax,0x80113768
  b->flags |= B_DIRTY; // prevent eviction
801037ef:	8b 45 08             	mov    0x8(%ebp),%eax
801037f2:	8b 00                	mov    (%eax),%eax
801037f4:	83 c8 04             	or     $0x4,%eax
801037f7:	89 c2                	mov    %eax,%edx
801037f9:	8b 45 08             	mov    0x8(%ebp),%eax
801037fc:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
801037fe:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80103805:	e8 ad 17 00 00       	call   80104fb7 <release>
}
8010380a:	c9                   	leave  
8010380b:	c3                   	ret    

8010380c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010380c:	55                   	push   %ebp
8010380d:	89 e5                	mov    %esp,%ebp
8010380f:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103812:	8b 55 08             	mov    0x8(%ebp),%edx
80103815:	8b 45 0c             	mov    0xc(%ebp),%eax
80103818:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010381b:	f0 87 02             	lock xchg %eax,(%edx)
8010381e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103821:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103824:	c9                   	leave  
80103825:	c3                   	ret    

80103826 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103826:	55                   	push   %ebp
80103827:	89 e5                	mov    %esp,%ebp
80103829:	83 e4 f0             	and    $0xfffffff0,%esp
8010382c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010382f:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80103836:	80 
80103837:	c7 04 24 a8 65 11 80 	movl   $0x801165a8,(%esp)
8010383e:	e8 63 f2 ff ff       	call   80102aa6 <kinit1>
  kvmalloc();      // kernel page table
80103843:	e8 cc 45 00 00       	call   80107e14 <kvmalloc>
  mpinit();        // detect other processors
80103848:	e8 f1 03 00 00       	call   80103c3e <mpinit>
  lapicinit();     // interrupt controller
8010384d:	e8 bc f5 ff ff       	call   80102e0e <lapicinit>
  seginit();       // segment descriptors
80103852:	e8 97 3f 00 00       	call   801077ee <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80103857:	e8 0b f7 ff ff       	call   80102f67 <cpunum>
8010385c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103860:	c7 04 24 70 88 10 80 	movl   $0x80108870,(%esp)
80103867:	e8 5c cb ff ff       	call   801003c8 <cprintf>
  picinit();       // another interrupt controller
8010386c:	e8 a8 05 00 00       	call   80103e19 <picinit>
  ioapicinit();    // another interrupt controller
80103871:	e8 33 f1 ff ff       	call   801029a9 <ioapicinit>
  consoleinit();   // console hardware
80103876:	e8 5d d2 ff ff       	call   80100ad8 <consoleinit>
  uartinit();      // serial port
8010387b:	e8 d3 32 00 00       	call   80106b53 <uartinit>
  pinit();         // process table
80103880:	e8 9e 0a 00 00       	call   80104323 <pinit>
  tvinit();        // trap vectors
80103885:	e8 91 2e 00 00       	call   8010671b <tvinit>
  binit();         // buffer cache
8010388a:	e8 a5 c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010388f:	e8 ea d6 ff ff       	call   80100f7e <fileinit>
  ideinit();       // disk
80103894:	e8 0e ed ff ff       	call   801025a7 <ideinit>
  if(!ismp)
80103899:	a1 04 38 11 80       	mov    0x80113804,%eax
8010389e:	85 c0                	test   %eax,%eax
801038a0:	75 05                	jne    801038a7 <main+0x81>
    timerinit();   // uniprocessor timer
801038a2:	e8 bf 2d 00 00       	call   80106666 <timerinit>
  startothers();   // start other processors
801038a7:	e8 78 00 00 00       	call   80103924 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801038ac:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
801038b3:	8e 
801038b4:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801038bb:	e8 1e f2 ff ff       	call   80102ade <kinit2>
  userinit();      // first user process
801038c0:	e8 79 0b 00 00       	call   8010443e <userinit>
  mpmain();        // finish this processor's setup
801038c5:	e8 1a 00 00 00       	call   801038e4 <mpmain>

801038ca <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801038ca:	55                   	push   %ebp
801038cb:	89 e5                	mov    %esp,%ebp
801038cd:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801038d0:	e8 57 45 00 00       	call   80107e2c <switchkvm>
  seginit();
801038d5:	e8 14 3f 00 00       	call   801077ee <seginit>
  lapicinit();
801038da:	e8 2f f5 ff ff       	call   80102e0e <lapicinit>
  mpmain();
801038df:	e8 00 00 00 00       	call   801038e4 <mpmain>

801038e4 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801038e4:	55                   	push   %ebp
801038e5:	89 e5                	mov    %esp,%ebp
801038e7:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpunum());
801038ea:	e8 78 f6 ff ff       	call   80102f67 <cpunum>
801038ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801038f3:	c7 04 24 87 88 10 80 	movl   $0x80108887,(%esp)
801038fa:	e8 c9 ca ff ff       	call   801003c8 <cprintf>
  idtinit();       // load idt register
801038ff:	e8 8b 2f 00 00       	call   8010688f <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103904:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010390a:	05 a8 00 00 00       	add    $0xa8,%eax
8010390f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80103916:	00 
80103917:	89 04 24             	mov    %eax,(%esp)
8010391a:	e8 ed fe ff ff       	call   8010380c <xchg>
  scheduler();     // start running processes
8010391f:	e8 a3 10 00 00       	call   801049c7 <scheduler>

80103924 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103924:	55                   	push   %ebp
80103925:	89 e5                	mov    %esp,%ebp
80103927:	83 ec 28             	sub    $0x28,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
8010392a:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103931:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103936:	89 44 24 08          	mov    %eax,0x8(%esp)
8010393a:	c7 44 24 04 0c b5 10 	movl   $0x8010b50c,0x4(%esp)
80103941:	80 
80103942:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103945:	89 04 24             	mov    %eax,(%esp)
80103948:	e8 3b 19 00 00       	call   80105288 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010394d:	c7 45 f4 20 38 11 80 	movl   $0x80113820,-0xc(%ebp)
80103954:	e9 81 00 00 00       	jmp    801039da <startothers+0xb6>
    if(c == cpus+cpunum())  // We've started already.
80103959:	e8 09 f6 ff ff       	call   80102f67 <cpunum>
8010395e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103964:	05 20 38 11 80       	add    $0x80113820,%eax
80103969:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010396c:	75 02                	jne    80103970 <startothers+0x4c>
      continue;
8010396e:	eb 63                	jmp    801039d3 <startothers+0xaf>

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103970:	e8 5c f2 ff ff       	call   80102bd1 <kalloc>
80103975:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103978:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010397b:	83 e8 04             	sub    $0x4,%eax
8010397e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103981:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103987:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103989:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010398c:	83 e8 08             	sub    $0x8,%eax
8010398f:	c7 00 ca 38 10 80    	movl   $0x801038ca,(%eax)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103995:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103998:	8d 50 f4             	lea    -0xc(%eax),%edx
8010399b:	b8 00 a0 10 80       	mov    $0x8010a000,%eax
801039a0:	05 00 00 00 80       	add    $0x80000000,%eax
801039a5:	89 02                	mov    %eax,(%edx)

    lapicstartap(c->apicid, V2P(code));
801039a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039aa:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801039b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039b3:	0f b6 00             	movzbl (%eax),%eax
801039b6:	0f b6 c0             	movzbl %al,%eax
801039b9:	89 54 24 04          	mov    %edx,0x4(%esp)
801039bd:	89 04 24             	mov    %eax,(%esp)
801039c0:	e8 68 f6 ff ff       	call   8010302d <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801039c5:	90                   	nop
801039c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039c9:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801039cf:	85 c0                	test   %eax,%eax
801039d1:	74 f3                	je     801039c6 <startothers+0xa2>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801039d3:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
801039da:	a1 00 3e 11 80       	mov    0x80113e00,%eax
801039df:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039e5:	05 20 38 11 80       	add    $0x80113820,%eax
801039ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801039ed:	0f 87 66 ff ff ff    	ja     80103959 <startothers+0x35>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
801039f3:	c9                   	leave  
801039f4:	c3                   	ret    

801039f5 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801039f5:	55                   	push   %ebp
801039f6:	89 e5                	mov    %esp,%ebp
801039f8:	83 ec 14             	sub    $0x14,%esp
801039fb:	8b 45 08             	mov    0x8(%ebp),%eax
801039fe:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a02:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103a06:	89 c2                	mov    %eax,%edx
80103a08:	ec                   	in     (%dx),%al
80103a09:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103a0c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103a10:	c9                   	leave  
80103a11:	c3                   	ret    

80103a12 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a12:	55                   	push   %ebp
80103a13:	89 e5                	mov    %esp,%ebp
80103a15:	83 ec 08             	sub    $0x8,%esp
80103a18:	8b 55 08             	mov    0x8(%ebp),%edx
80103a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a1e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a22:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a25:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a29:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a2d:	ee                   	out    %al,(%dx)
}
80103a2e:	c9                   	leave  
80103a2f:	c3                   	ret    

80103a30 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	83 ec 10             	sub    $0x10,%esp
  int i, sum;

  sum = 0;
80103a36:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103a44:	eb 15                	jmp    80103a5b <sum+0x2b>
    sum += addr[i];
80103a46:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103a49:	8b 45 08             	mov    0x8(%ebp),%eax
80103a4c:	01 d0                	add    %edx,%eax
80103a4e:	0f b6 00             	movzbl (%eax),%eax
80103a51:	0f b6 c0             	movzbl %al,%eax
80103a54:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103a57:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103a5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103a5e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103a61:	7c e3                	jl     80103a46 <sum+0x16>
    sum += addr[i];
  return sum;
80103a63:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103a66:	c9                   	leave  
80103a67:	c3                   	ret    

80103a68 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103a68:	55                   	push   %ebp
80103a69:	89 e5                	mov    %esp,%ebp
80103a6b:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80103a6e:	8b 45 08             	mov    0x8(%ebp),%eax
80103a71:	05 00 00 00 80       	add    $0x80000000,%eax
80103a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103a79:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a7f:	01 d0                	add    %edx,%eax
80103a81:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103a84:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a87:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103a8a:	eb 3f                	jmp    80103acb <mpsearch1+0x63>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a8c:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103a93:	00 
80103a94:	c7 44 24 04 98 88 10 	movl   $0x80108898,0x4(%esp)
80103a9b:	80 
80103a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a9f:	89 04 24             	mov    %eax,(%esp)
80103aa2:	e8 89 17 00 00       	call   80105230 <memcmp>
80103aa7:	85 c0                	test   %eax,%eax
80103aa9:	75 1c                	jne    80103ac7 <mpsearch1+0x5f>
80103aab:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80103ab2:	00 
80103ab3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ab6:	89 04 24             	mov    %eax,(%esp)
80103ab9:	e8 72 ff ff ff       	call   80103a30 <sum>
80103abe:	84 c0                	test   %al,%al
80103ac0:	75 05                	jne    80103ac7 <mpsearch1+0x5f>
      return (struct mp*)p;
80103ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ac5:	eb 11                	jmp    80103ad8 <mpsearch1+0x70>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103ac7:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ace:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103ad1:	72 b9                	jb     80103a8c <mpsearch1+0x24>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103ad3:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103ad8:	c9                   	leave  
80103ad9:	c3                   	ret    

80103ada <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103ada:	55                   	push   %ebp
80103adb:	89 e5                	mov    %esp,%ebp
80103add:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103ae0:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aea:	83 c0 0f             	add    $0xf,%eax
80103aed:	0f b6 00             	movzbl (%eax),%eax
80103af0:	0f b6 c0             	movzbl %al,%eax
80103af3:	c1 e0 08             	shl    $0x8,%eax
80103af6:	89 c2                	mov    %eax,%edx
80103af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103afb:	83 c0 0e             	add    $0xe,%eax
80103afe:	0f b6 00             	movzbl (%eax),%eax
80103b01:	0f b6 c0             	movzbl %al,%eax
80103b04:	09 d0                	or     %edx,%eax
80103b06:	c1 e0 04             	shl    $0x4,%eax
80103b09:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b0c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b10:	74 21                	je     80103b33 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103b12:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103b19:	00 
80103b1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b1d:	89 04 24             	mov    %eax,(%esp)
80103b20:	e8 43 ff ff ff       	call   80103a68 <mpsearch1>
80103b25:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b28:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b2c:	74 50                	je     80103b7e <mpsearch+0xa4>
      return mp;
80103b2e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b31:	eb 5f                	jmp    80103b92 <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b36:	83 c0 14             	add    $0x14,%eax
80103b39:	0f b6 00             	movzbl (%eax),%eax
80103b3c:	0f b6 c0             	movzbl %al,%eax
80103b3f:	c1 e0 08             	shl    $0x8,%eax
80103b42:	89 c2                	mov    %eax,%edx
80103b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b47:	83 c0 13             	add    $0x13,%eax
80103b4a:	0f b6 00             	movzbl (%eax),%eax
80103b4d:	0f b6 c0             	movzbl %al,%eax
80103b50:	09 d0                	or     %edx,%eax
80103b52:	c1 e0 0a             	shl    $0xa,%eax
80103b55:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103b58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b5b:	2d 00 04 00 00       	sub    $0x400,%eax
80103b60:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103b67:	00 
80103b68:	89 04 24             	mov    %eax,(%esp)
80103b6b:	e8 f8 fe ff ff       	call   80103a68 <mpsearch1>
80103b70:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b73:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b77:	74 05                	je     80103b7e <mpsearch+0xa4>
      return mp;
80103b79:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b7c:	eb 14                	jmp    80103b92 <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
80103b7e:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80103b85:	00 
80103b86:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
80103b8d:	e8 d6 fe ff ff       	call   80103a68 <mpsearch1>
}
80103b92:	c9                   	leave  
80103b93:	c3                   	ret    

80103b94 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103b94:	55                   	push   %ebp
80103b95:	89 e5                	mov    %esp,%ebp
80103b97:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103b9a:	e8 3b ff ff ff       	call   80103ada <mpsearch>
80103b9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ba2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ba6:	74 0a                	je     80103bb2 <mpconfig+0x1e>
80103ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bab:	8b 40 04             	mov    0x4(%eax),%eax
80103bae:	85 c0                	test   %eax,%eax
80103bb0:	75 0a                	jne    80103bbc <mpconfig+0x28>
    return 0;
80103bb2:	b8 00 00 00 00       	mov    $0x0,%eax
80103bb7:	e9 80 00 00 00       	jmp    80103c3c <mpconfig+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103bbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbf:	8b 40 04             	mov    0x4(%eax),%eax
80103bc2:	05 00 00 00 80       	add    $0x80000000,%eax
80103bc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103bca:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103bd1:	00 
80103bd2:	c7 44 24 04 9d 88 10 	movl   $0x8010889d,0x4(%esp)
80103bd9:	80 
80103bda:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bdd:	89 04 24             	mov    %eax,(%esp)
80103be0:	e8 4b 16 00 00       	call   80105230 <memcmp>
80103be5:	85 c0                	test   %eax,%eax
80103be7:	74 07                	je     80103bf0 <mpconfig+0x5c>
    return 0;
80103be9:	b8 00 00 00 00       	mov    $0x0,%eax
80103bee:	eb 4c                	jmp    80103c3c <mpconfig+0xa8>
  if(conf->version != 1 && conf->version != 4)
80103bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bf3:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103bf7:	3c 01                	cmp    $0x1,%al
80103bf9:	74 12                	je     80103c0d <mpconfig+0x79>
80103bfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bfe:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c02:	3c 04                	cmp    $0x4,%al
80103c04:	74 07                	je     80103c0d <mpconfig+0x79>
    return 0;
80103c06:	b8 00 00 00 00       	mov    $0x0,%eax
80103c0b:	eb 2f                	jmp    80103c3c <mpconfig+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103c0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c10:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c14:	0f b7 c0             	movzwl %ax,%eax
80103c17:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c1e:	89 04 24             	mov    %eax,(%esp)
80103c21:	e8 0a fe ff ff       	call   80103a30 <sum>
80103c26:	84 c0                	test   %al,%al
80103c28:	74 07                	je     80103c31 <mpconfig+0x9d>
    return 0;
80103c2a:	b8 00 00 00 00       	mov    $0x0,%eax
80103c2f:	eb 0b                	jmp    80103c3c <mpconfig+0xa8>
  *pmp = mp;
80103c31:	8b 45 08             	mov    0x8(%ebp),%eax
80103c34:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c37:	89 10                	mov    %edx,(%eax)
  return conf;
80103c39:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103c3c:	c9                   	leave  
80103c3d:	c3                   	ret    

80103c3e <mpinit>:

void
mpinit(void)
{
80103c3e:	55                   	push   %ebp
80103c3f:	89 e5                	mov    %esp,%ebp
80103c41:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103c44:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103c47:	89 04 24             	mov    %eax,(%esp)
80103c4a:	e8 45 ff ff ff       	call   80103b94 <mpconfig>
80103c4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c56:	75 05                	jne    80103c5d <mpinit+0x1f>
    return;
80103c58:	e9 23 01 00 00       	jmp    80103d80 <mpinit+0x142>
  ismp = 1;
80103c5d:	c7 05 04 38 11 80 01 	movl   $0x1,0x80113804
80103c64:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103c67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c6a:	8b 40 24             	mov    0x24(%eax),%eax
80103c6d:	a3 1c 37 11 80       	mov    %eax,0x8011371c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103c72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c75:	83 c0 2c             	add    $0x2c,%eax
80103c78:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c7e:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c82:	0f b7 d0             	movzwl %ax,%edx
80103c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c88:	01 d0                	add    %edx,%eax
80103c8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c8d:	eb 7e                	jmp    80103d0d <mpinit+0xcf>
    switch(*p){
80103c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c92:	0f b6 00             	movzbl (%eax),%eax
80103c95:	0f b6 c0             	movzbl %al,%eax
80103c98:	83 f8 04             	cmp    $0x4,%eax
80103c9b:	77 65                	ja     80103d02 <mpinit+0xc4>
80103c9d:	8b 04 85 a4 88 10 80 	mov    -0x7fef775c(,%eax,4),%eax
80103ca4:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca9:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu < NCPU) {
80103cac:	a1 00 3e 11 80       	mov    0x80113e00,%eax
80103cb1:	83 f8 07             	cmp    $0x7,%eax
80103cb4:	7f 28                	jg     80103cde <mpinit+0xa0>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103cb6:	8b 15 00 3e 11 80    	mov    0x80113e00,%edx
80103cbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103cbf:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cc3:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103cc9:	81 c2 20 38 11 80    	add    $0x80113820,%edx
80103ccf:	88 02                	mov    %al,(%edx)
        ncpu++;
80103cd1:	a1 00 3e 11 80       	mov    0x80113e00,%eax
80103cd6:	83 c0 01             	add    $0x1,%eax
80103cd9:	a3 00 3e 11 80       	mov    %eax,0x80113e00
      }
      p += sizeof(struct mpproc);
80103cde:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103ce2:	eb 29                	jmp    80103d0d <mpinit+0xcf>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103ce4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ce7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103cea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103ced:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cf1:	a2 00 38 11 80       	mov    %al,0x80113800
      p += sizeof(struct mpioapic);
80103cf6:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103cfa:	eb 11                	jmp    80103d0d <mpinit+0xcf>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103cfc:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d00:	eb 0b                	jmp    80103d0d <mpinit+0xcf>
    default:
      ismp = 0;
80103d02:	c7 05 04 38 11 80 00 	movl   $0x0,0x80113804
80103d09:	00 00 00 
      break;
80103d0c:	90                   	nop

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d10:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103d13:	0f 82 76 ff ff ff    	jb     80103c8f <mpinit+0x51>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
80103d19:	a1 04 38 11 80       	mov    0x80113804,%eax
80103d1e:	85 c0                	test   %eax,%eax
80103d20:	75 1d                	jne    80103d3f <mpinit+0x101>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103d22:	c7 05 00 3e 11 80 01 	movl   $0x1,0x80113e00
80103d29:	00 00 00 
    lapic = 0;
80103d2c:	c7 05 1c 37 11 80 00 	movl   $0x0,0x8011371c
80103d33:	00 00 00 
    ioapicid = 0;
80103d36:	c6 05 00 38 11 80 00 	movb   $0x0,0x80113800
    return;
80103d3d:	eb 41                	jmp    80103d80 <mpinit+0x142>
  }

  if(mp->imcrp){
80103d3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d42:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d46:	84 c0                	test   %al,%al
80103d48:	74 36                	je     80103d80 <mpinit+0x142>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d4a:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
80103d51:	00 
80103d52:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
80103d59:	e8 b4 fc ff ff       	call   80103a12 <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d5e:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103d65:	e8 8b fc ff ff       	call   801039f5 <inb>
80103d6a:	83 c8 01             	or     $0x1,%eax
80103d6d:	0f b6 c0             	movzbl %al,%eax
80103d70:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d74:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103d7b:	e8 92 fc ff ff       	call   80103a12 <outb>
  }
}
80103d80:	c9                   	leave  
80103d81:	c3                   	ret    

80103d82 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103d82:	55                   	push   %ebp
80103d83:	89 e5                	mov    %esp,%ebp
80103d85:	83 ec 08             	sub    $0x8,%esp
80103d88:	8b 55 08             	mov    0x8(%ebp),%edx
80103d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d8e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103d92:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d95:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103d99:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103d9d:	ee                   	out    %al,(%dx)
}
80103d9e:	c9                   	leave  
80103d9f:	c3                   	ret    

80103da0 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	83 ec 0c             	sub    $0xc,%esp
80103da6:	8b 45 08             	mov    0x8(%ebp),%eax
80103da9:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103dad:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103db1:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103db7:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103dbb:	0f b6 c0             	movzbl %al,%eax
80103dbe:	89 44 24 04          	mov    %eax,0x4(%esp)
80103dc2:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103dc9:	e8 b4 ff ff ff       	call   80103d82 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103dce:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103dd2:	66 c1 e8 08          	shr    $0x8,%ax
80103dd6:	0f b6 c0             	movzbl %al,%eax
80103dd9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ddd:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103de4:	e8 99 ff ff ff       	call   80103d82 <outb>
}
80103de9:	c9                   	leave  
80103dea:	c3                   	ret    

80103deb <picenable>:

void
picenable(int irq)
{
80103deb:	55                   	push   %ebp
80103dec:	89 e5                	mov    %esp,%ebp
80103dee:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103df1:	8b 45 08             	mov    0x8(%ebp),%eax
80103df4:	ba 01 00 00 00       	mov    $0x1,%edx
80103df9:	89 c1                	mov    %eax,%ecx
80103dfb:	d3 e2                	shl    %cl,%edx
80103dfd:	89 d0                	mov    %edx,%eax
80103dff:	f7 d0                	not    %eax
80103e01:	89 c2                	mov    %eax,%edx
80103e03:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103e0a:	21 d0                	and    %edx,%eax
80103e0c:	0f b7 c0             	movzwl %ax,%eax
80103e0f:	89 04 24             	mov    %eax,(%esp)
80103e12:	e8 89 ff ff ff       	call   80103da0 <picsetmask>
}
80103e17:	c9                   	leave  
80103e18:	c3                   	ret    

80103e19 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103e19:	55                   	push   %ebp
80103e1a:	89 e5                	mov    %esp,%ebp
80103e1c:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103e1f:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103e26:	00 
80103e27:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103e2e:	e8 4f ff ff ff       	call   80103d82 <outb>
  outb(IO_PIC2+1, 0xFF);
80103e33:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103e3a:	00 
80103e3b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103e42:	e8 3b ff ff ff       	call   80103d82 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103e47:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103e4e:	00 
80103e4f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103e56:	e8 27 ff ff ff       	call   80103d82 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103e5b:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80103e62:	00 
80103e63:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103e6a:	e8 13 ff ff ff       	call   80103d82 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103e6f:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
80103e76:	00 
80103e77:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103e7e:	e8 ff fe ff ff       	call   80103d82 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103e83:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103e8a:	00 
80103e8b:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103e92:	e8 eb fe ff ff       	call   80103d82 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103e97:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103e9e:	00 
80103e9f:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103ea6:	e8 d7 fe ff ff       	call   80103d82 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103eab:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80103eb2:	00 
80103eb3:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103eba:	e8 c3 fe ff ff       	call   80103d82 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103ebf:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80103ec6:	00 
80103ec7:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103ece:	e8 af fe ff ff       	call   80103d82 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103ed3:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103eda:	00 
80103edb:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103ee2:	e8 9b fe ff ff       	call   80103d82 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103ee7:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103eee:	00 
80103eef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103ef6:	e8 87 fe ff ff       	call   80103d82 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103efb:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103f02:	00 
80103f03:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103f0a:	e8 73 fe ff ff       	call   80103d82 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
80103f0f:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103f16:	00 
80103f17:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103f1e:	e8 5f fe ff ff       	call   80103d82 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80103f23:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103f2a:	00 
80103f2b:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103f32:	e8 4b fe ff ff       	call   80103d82 <outb>

  if(irqmask != 0xFFFF)
80103f37:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f3e:	66 83 f8 ff          	cmp    $0xffff,%ax
80103f42:	74 12                	je     80103f56 <picinit+0x13d>
    picsetmask(irqmask);
80103f44:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f4b:	0f b7 c0             	movzwl %ax,%eax
80103f4e:	89 04 24             	mov    %eax,(%esp)
80103f51:	e8 4a fe ff ff       	call   80103da0 <picsetmask>
}
80103f56:	c9                   	leave  
80103f57:	c3                   	ret    

80103f58 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103f58:	55                   	push   %ebp
80103f59:	89 e5                	mov    %esp,%ebp
80103f5b:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80103f5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103f65:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f68:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f71:	8b 10                	mov    (%eax),%edx
80103f73:	8b 45 08             	mov    0x8(%ebp),%eax
80103f76:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f78:	e8 1d d0 ff ff       	call   80100f9a <filealloc>
80103f7d:	8b 55 08             	mov    0x8(%ebp),%edx
80103f80:	89 02                	mov    %eax,(%edx)
80103f82:	8b 45 08             	mov    0x8(%ebp),%eax
80103f85:	8b 00                	mov    (%eax),%eax
80103f87:	85 c0                	test   %eax,%eax
80103f89:	0f 84 c8 00 00 00    	je     80104057 <pipealloc+0xff>
80103f8f:	e8 06 d0 ff ff       	call   80100f9a <filealloc>
80103f94:	8b 55 0c             	mov    0xc(%ebp),%edx
80103f97:	89 02                	mov    %eax,(%edx)
80103f99:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f9c:	8b 00                	mov    (%eax),%eax
80103f9e:	85 c0                	test   %eax,%eax
80103fa0:	0f 84 b1 00 00 00    	je     80104057 <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103fa6:	e8 26 ec ff ff       	call   80102bd1 <kalloc>
80103fab:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103fae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fb2:	75 05                	jne    80103fb9 <pipealloc+0x61>
    goto bad;
80103fb4:	e9 9e 00 00 00       	jmp    80104057 <pipealloc+0xff>
  p->readopen = 1;
80103fb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fbc:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103fc3:	00 00 00 
  p->writeopen = 1;
80103fc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fc9:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103fd0:	00 00 00 
  p->nwrite = 0;
80103fd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fd6:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103fdd:	00 00 00 
  p->nread = 0;
80103fe0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fe3:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103fea:	00 00 00 
  initlock(&p->lock, "pipe");
80103fed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ff0:	c7 44 24 04 b8 88 10 	movl   $0x801088b8,0x4(%esp)
80103ff7:	80 
80103ff8:	89 04 24             	mov    %eax,(%esp)
80103ffb:	e8 2f 0f 00 00       	call   80104f2f <initlock>
  (*f0)->type = FD_PIPE;
80104000:	8b 45 08             	mov    0x8(%ebp),%eax
80104003:	8b 00                	mov    (%eax),%eax
80104005:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010400b:	8b 45 08             	mov    0x8(%ebp),%eax
8010400e:	8b 00                	mov    (%eax),%eax
80104010:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104014:	8b 45 08             	mov    0x8(%ebp),%eax
80104017:	8b 00                	mov    (%eax),%eax
80104019:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010401d:	8b 45 08             	mov    0x8(%ebp),%eax
80104020:	8b 00                	mov    (%eax),%eax
80104022:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104025:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80104028:	8b 45 0c             	mov    0xc(%ebp),%eax
8010402b:	8b 00                	mov    (%eax),%eax
8010402d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104033:	8b 45 0c             	mov    0xc(%ebp),%eax
80104036:	8b 00                	mov    (%eax),%eax
80104038:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010403c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010403f:	8b 00                	mov    (%eax),%eax
80104041:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104045:	8b 45 0c             	mov    0xc(%ebp),%eax
80104048:	8b 00                	mov    (%eax),%eax
8010404a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010404d:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104050:	b8 00 00 00 00       	mov    $0x0,%eax
80104055:	eb 42                	jmp    80104099 <pipealloc+0x141>

//PAGEBREAK: 20
 bad:
  if(p)
80104057:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010405b:	74 0b                	je     80104068 <pipealloc+0x110>
    kfree((char*)p);
8010405d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104060:	89 04 24             	mov    %eax,(%esp)
80104063:	e8 d3 ea ff ff       	call   80102b3b <kfree>
  if(*f0)
80104068:	8b 45 08             	mov    0x8(%ebp),%eax
8010406b:	8b 00                	mov    (%eax),%eax
8010406d:	85 c0                	test   %eax,%eax
8010406f:	74 0d                	je     8010407e <pipealloc+0x126>
    fileclose(*f0);
80104071:	8b 45 08             	mov    0x8(%ebp),%eax
80104074:	8b 00                	mov    (%eax),%eax
80104076:	89 04 24             	mov    %eax,(%esp)
80104079:	e8 c4 cf ff ff       	call   80101042 <fileclose>
  if(*f1)
8010407e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104081:	8b 00                	mov    (%eax),%eax
80104083:	85 c0                	test   %eax,%eax
80104085:	74 0d                	je     80104094 <pipealloc+0x13c>
    fileclose(*f1);
80104087:	8b 45 0c             	mov    0xc(%ebp),%eax
8010408a:	8b 00                	mov    (%eax),%eax
8010408c:	89 04 24             	mov    %eax,(%esp)
8010408f:	e8 ae cf ff ff       	call   80101042 <fileclose>
  return -1;
80104094:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104099:	c9                   	leave  
8010409a:	c3                   	ret    

8010409b <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
8010409b:	55                   	push   %ebp
8010409c:	89 e5                	mov    %esp,%ebp
8010409e:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
801040a1:	8b 45 08             	mov    0x8(%ebp),%eax
801040a4:	89 04 24             	mov    %eax,(%esp)
801040a7:	e8 a4 0e 00 00       	call   80104f50 <acquire>
  if(writable){
801040ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801040b0:	74 1f                	je     801040d1 <pipeclose+0x36>
    p->writeopen = 0;
801040b2:	8b 45 08             	mov    0x8(%ebp),%eax
801040b5:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801040bc:	00 00 00 
    wakeup(&p->nread);
801040bf:	8b 45 08             	mov    0x8(%ebp),%eax
801040c2:	05 34 02 00 00       	add    $0x234,%eax
801040c7:	89 04 24             	mov    %eax,(%esp)
801040ca:	e8 89 0b 00 00       	call   80104c58 <wakeup>
801040cf:	eb 1d                	jmp    801040ee <pipeclose+0x53>
  } else {
    p->readopen = 0;
801040d1:	8b 45 08             	mov    0x8(%ebp),%eax
801040d4:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801040db:	00 00 00 
    wakeup(&p->nwrite);
801040de:	8b 45 08             	mov    0x8(%ebp),%eax
801040e1:	05 38 02 00 00       	add    $0x238,%eax
801040e6:	89 04 24             	mov    %eax,(%esp)
801040e9:	e8 6a 0b 00 00       	call   80104c58 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
801040ee:	8b 45 08             	mov    0x8(%ebp),%eax
801040f1:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801040f7:	85 c0                	test   %eax,%eax
801040f9:	75 25                	jne    80104120 <pipeclose+0x85>
801040fb:	8b 45 08             	mov    0x8(%ebp),%eax
801040fe:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104104:	85 c0                	test   %eax,%eax
80104106:	75 18                	jne    80104120 <pipeclose+0x85>
    release(&p->lock);
80104108:	8b 45 08             	mov    0x8(%ebp),%eax
8010410b:	89 04 24             	mov    %eax,(%esp)
8010410e:	e8 a4 0e 00 00       	call   80104fb7 <release>
    kfree((char*)p);
80104113:	8b 45 08             	mov    0x8(%ebp),%eax
80104116:	89 04 24             	mov    %eax,(%esp)
80104119:	e8 1d ea ff ff       	call   80102b3b <kfree>
8010411e:	eb 0b                	jmp    8010412b <pipeclose+0x90>
  } else
    release(&p->lock);
80104120:	8b 45 08             	mov    0x8(%ebp),%eax
80104123:	89 04 24             	mov    %eax,(%esp)
80104126:	e8 8c 0e 00 00       	call   80104fb7 <release>
}
8010412b:	c9                   	leave  
8010412c:	c3                   	ret    

8010412d <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010412d:	55                   	push   %ebp
8010412e:	89 e5                	mov    %esp,%ebp
80104130:	83 ec 28             	sub    $0x28,%esp
  int i;

  acquire(&p->lock);
80104133:	8b 45 08             	mov    0x8(%ebp),%eax
80104136:	89 04 24             	mov    %eax,(%esp)
80104139:	e8 12 0e 00 00       	call   80104f50 <acquire>
  for(i = 0; i < n; i++){
8010413e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104145:	e9 a6 00 00 00       	jmp    801041f0 <pipewrite+0xc3>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010414a:	eb 57                	jmp    801041a3 <pipewrite+0x76>
      if(p->readopen == 0 || proc->killed){
8010414c:	8b 45 08             	mov    0x8(%ebp),%eax
8010414f:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104155:	85 c0                	test   %eax,%eax
80104157:	74 0d                	je     80104166 <pipewrite+0x39>
80104159:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010415f:	8b 40 24             	mov    0x24(%eax),%eax
80104162:	85 c0                	test   %eax,%eax
80104164:	74 15                	je     8010417b <pipewrite+0x4e>
        release(&p->lock);
80104166:	8b 45 08             	mov    0x8(%ebp),%eax
80104169:	89 04 24             	mov    %eax,(%esp)
8010416c:	e8 46 0e 00 00       	call   80104fb7 <release>
        return -1;
80104171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104176:	e9 9f 00 00 00       	jmp    8010421a <pipewrite+0xed>
      }
      wakeup(&p->nread);
8010417b:	8b 45 08             	mov    0x8(%ebp),%eax
8010417e:	05 34 02 00 00       	add    $0x234,%eax
80104183:	89 04 24             	mov    %eax,(%esp)
80104186:	e8 cd 0a 00 00       	call   80104c58 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010418b:	8b 45 08             	mov    0x8(%ebp),%eax
8010418e:	8b 55 08             	mov    0x8(%ebp),%edx
80104191:	81 c2 38 02 00 00    	add    $0x238,%edx
80104197:	89 44 24 04          	mov    %eax,0x4(%esp)
8010419b:	89 14 24             	mov    %edx,(%esp)
8010419e:	e8 dc 09 00 00       	call   80104b7f <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041a3:	8b 45 08             	mov    0x8(%ebp),%eax
801041a6:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801041ac:	8b 45 08             	mov    0x8(%ebp),%eax
801041af:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801041b5:	05 00 02 00 00       	add    $0x200,%eax
801041ba:	39 c2                	cmp    %eax,%edx
801041bc:	74 8e                	je     8010414c <pipewrite+0x1f>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801041be:	8b 45 08             	mov    0x8(%ebp),%eax
801041c1:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801041c7:	8d 48 01             	lea    0x1(%eax),%ecx
801041ca:	8b 55 08             	mov    0x8(%ebp),%edx
801041cd:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
801041d3:	25 ff 01 00 00       	and    $0x1ff,%eax
801041d8:	89 c1                	mov    %eax,%ecx
801041da:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801041e0:	01 d0                	add    %edx,%eax
801041e2:	0f b6 10             	movzbl (%eax),%edx
801041e5:	8b 45 08             	mov    0x8(%ebp),%eax
801041e8:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801041ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801041f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f3:	3b 45 10             	cmp    0x10(%ebp),%eax
801041f6:	0f 8c 4e ff ff ff    	jl     8010414a <pipewrite+0x1d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801041fc:	8b 45 08             	mov    0x8(%ebp),%eax
801041ff:	05 34 02 00 00       	add    $0x234,%eax
80104204:	89 04 24             	mov    %eax,(%esp)
80104207:	e8 4c 0a 00 00       	call   80104c58 <wakeup>
  release(&p->lock);
8010420c:	8b 45 08             	mov    0x8(%ebp),%eax
8010420f:	89 04 24             	mov    %eax,(%esp)
80104212:	e8 a0 0d 00 00       	call   80104fb7 <release>
  return n;
80104217:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010421a:	c9                   	leave  
8010421b:	c3                   	ret    

8010421c <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010421c:	55                   	push   %ebp
8010421d:	89 e5                	mov    %esp,%ebp
8010421f:	53                   	push   %ebx
80104220:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80104223:	8b 45 08             	mov    0x8(%ebp),%eax
80104226:	89 04 24             	mov    %eax,(%esp)
80104229:	e8 22 0d 00 00       	call   80104f50 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010422e:	eb 3a                	jmp    8010426a <piperead+0x4e>
    if(proc->killed){
80104230:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104236:	8b 40 24             	mov    0x24(%eax),%eax
80104239:	85 c0                	test   %eax,%eax
8010423b:	74 15                	je     80104252 <piperead+0x36>
      release(&p->lock);
8010423d:	8b 45 08             	mov    0x8(%ebp),%eax
80104240:	89 04 24             	mov    %eax,(%esp)
80104243:	e8 6f 0d 00 00       	call   80104fb7 <release>
      return -1;
80104248:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010424d:	e9 b5 00 00 00       	jmp    80104307 <piperead+0xeb>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104252:	8b 45 08             	mov    0x8(%ebp),%eax
80104255:	8b 55 08             	mov    0x8(%ebp),%edx
80104258:	81 c2 34 02 00 00    	add    $0x234,%edx
8010425e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104262:	89 14 24             	mov    %edx,(%esp)
80104265:	e8 15 09 00 00       	call   80104b7f <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010426a:	8b 45 08             	mov    0x8(%ebp),%eax
8010426d:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104273:	8b 45 08             	mov    0x8(%ebp),%eax
80104276:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010427c:	39 c2                	cmp    %eax,%edx
8010427e:	75 0d                	jne    8010428d <piperead+0x71>
80104280:	8b 45 08             	mov    0x8(%ebp),%eax
80104283:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104289:	85 c0                	test   %eax,%eax
8010428b:	75 a3                	jne    80104230 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010428d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104294:	eb 4b                	jmp    801042e1 <piperead+0xc5>
    if(p->nread == p->nwrite)
80104296:	8b 45 08             	mov    0x8(%ebp),%eax
80104299:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010429f:	8b 45 08             	mov    0x8(%ebp),%eax
801042a2:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042a8:	39 c2                	cmp    %eax,%edx
801042aa:	75 02                	jne    801042ae <piperead+0x92>
      break;
801042ac:	eb 3b                	jmp    801042e9 <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801042ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801042b4:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801042b7:	8b 45 08             	mov    0x8(%ebp),%eax
801042ba:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801042c0:	8d 48 01             	lea    0x1(%eax),%ecx
801042c3:	8b 55 08             	mov    0x8(%ebp),%edx
801042c6:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801042cc:	25 ff 01 00 00       	and    $0x1ff,%eax
801042d1:	89 c2                	mov    %eax,%edx
801042d3:	8b 45 08             	mov    0x8(%ebp),%eax
801042d6:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
801042db:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042e4:	3b 45 10             	cmp    0x10(%ebp),%eax
801042e7:	7c ad                	jl     80104296 <piperead+0x7a>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801042e9:	8b 45 08             	mov    0x8(%ebp),%eax
801042ec:	05 38 02 00 00       	add    $0x238,%eax
801042f1:	89 04 24             	mov    %eax,(%esp)
801042f4:	e8 5f 09 00 00       	call   80104c58 <wakeup>
  release(&p->lock);
801042f9:	8b 45 08             	mov    0x8(%ebp),%eax
801042fc:	89 04 24             	mov    %eax,(%esp)
801042ff:	e8 b3 0c 00 00       	call   80104fb7 <release>
  return i;
80104304:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104307:	83 c4 24             	add    $0x24,%esp
8010430a:	5b                   	pop    %ebx
8010430b:	5d                   	pop    %ebp
8010430c:	c3                   	ret    

8010430d <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
8010430d:	55                   	push   %ebp
8010430e:	89 e5                	mov    %esp,%ebp
80104310:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104313:	9c                   	pushf  
80104314:	58                   	pop    %eax
80104315:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104318:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010431b:	c9                   	leave  
8010431c:	c3                   	ret    

8010431d <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
8010431d:	55                   	push   %ebp
8010431e:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104320:	fb                   	sti    
}
80104321:	5d                   	pop    %ebp
80104322:	c3                   	ret    

80104323 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104323:	55                   	push   %ebp
80104324:	89 e5                	mov    %esp,%ebp
80104326:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80104329:	c7 44 24 04 bd 88 10 	movl   $0x801088bd,0x4(%esp)
80104330:	80 
80104331:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104338:	e8 f2 0b 00 00       	call   80104f2f <initlock>
}
8010433d:	c9                   	leave  
8010433e:	c3                   	ret    

8010433f <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010433f:	55                   	push   %ebp
80104340:	89 e5                	mov    %esp,%ebp
80104342:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104345:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
8010434c:	e8 ff 0b 00 00       	call   80104f50 <acquire>

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104351:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
80104358:	eb 50                	jmp    801043aa <allocproc+0x6b>
    if(p->state == UNUSED)
8010435a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010435d:	8b 40 0c             	mov    0xc(%eax),%eax
80104360:	85 c0                	test   %eax,%eax
80104362:	75 42                	jne    801043a6 <allocproc+0x67>
      goto found;
80104364:	90                   	nop

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104365:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104368:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010436f:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104374:	8d 50 01             	lea    0x1(%eax),%edx
80104377:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
8010437d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104380:	89 42 10             	mov    %eax,0x10(%edx)

  release(&ptable.lock);
80104383:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
8010438a:	e8 28 0c 00 00       	call   80104fb7 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010438f:	e8 3d e8 ff ff       	call   80102bd1 <kalloc>
80104394:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104397:	89 42 08             	mov    %eax,0x8(%edx)
8010439a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010439d:	8b 40 08             	mov    0x8(%eax),%eax
801043a0:	85 c0                	test   %eax,%eax
801043a2:	75 33                	jne    801043d7 <allocproc+0x98>
801043a4:	eb 20                	jmp    801043c6 <allocproc+0x87>
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043a6:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801043aa:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
801043b1:	72 a7                	jb     8010435a <allocproc+0x1b>
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801043b3:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
801043ba:	e8 f8 0b 00 00       	call   80104fb7 <release>
  return 0;
801043bf:	b8 00 00 00 00       	mov    $0x0,%eax
801043c4:	eb 76                	jmp    8010443c <allocproc+0xfd>

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801043c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801043d0:	b8 00 00 00 00       	mov    $0x0,%eax
801043d5:	eb 65                	jmp    8010443c <allocproc+0xfd>
  }
  sp = p->kstack + KSTACKSIZE;
801043d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043da:	8b 40 08             	mov    0x8(%eax),%eax
801043dd:	05 00 10 00 00       	add    $0x1000,%eax
801043e2:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043e5:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801043e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043ef:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801043f2:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801043f6:	ba d6 66 10 80       	mov    $0x801066d6,%edx
801043fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801043fe:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104400:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104404:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104407:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010440a:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
8010440d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104410:	8b 40 1c             	mov    0x1c(%eax),%eax
80104413:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010441a:	00 
8010441b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104422:	00 
80104423:	89 04 24             	mov    %eax,(%esp)
80104426:	e8 8e 0d 00 00       	call   801051b9 <memset>
  p->context->eip = (uint)forkret;
8010442b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010442e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104431:	ba 40 4b 10 80       	mov    $0x80104b40,%edx
80104436:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104439:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010443c:	c9                   	leave  
8010443d:	c3                   	ret    

8010443e <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010443e:	55                   	push   %ebp
8010443f:	89 e5                	mov    %esp,%ebp
80104441:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80104444:	e8 f6 fe ff ff       	call   8010433f <allocproc>
80104449:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  initproc = p;
8010444c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010444f:	a3 44 b6 10 80       	mov    %eax,0x8010b644
  if((p->pgdir = setupkvm()) == 0)
80104454:	e8 30 39 00 00       	call   80107d89 <setupkvm>
80104459:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010445c:	89 42 04             	mov    %eax,0x4(%edx)
8010445f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104462:	8b 40 04             	mov    0x4(%eax),%eax
80104465:	85 c0                	test   %eax,%eax
80104467:	75 0c                	jne    80104475 <userinit+0x37>
    panic("userinit: out of memory?");
80104469:	c7 04 24 c4 88 10 80 	movl   $0x801088c4,(%esp)
80104470:	e8 ed c0 ff ff       	call   80100562 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104475:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010447a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010447d:	8b 40 04             	mov    0x4(%eax),%eax
80104480:	89 54 24 08          	mov    %edx,0x8(%esp)
80104484:	c7 44 24 04 e0 b4 10 	movl   $0x8010b4e0,0x4(%esp)
8010448b:	80 
8010448c:	89 04 24             	mov    %eax,(%esp)
8010448f:	e8 29 3b 00 00       	call   80107fbd <inituvm>
  p->sz = PGSIZE;
80104494:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104497:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010449d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a0:	8b 40 18             	mov    0x18(%eax),%eax
801044a3:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801044aa:	00 
801044ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801044b2:	00 
801044b3:	89 04 24             	mov    %eax,(%esp)
801044b6:	e8 fe 0c 00 00       	call   801051b9 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801044bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044be:	8b 40 18             	mov    0x18(%eax),%eax
801044c1:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ca:	8b 40 18             	mov    0x18(%eax),%eax
801044cd:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801044d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d6:	8b 40 18             	mov    0x18(%eax),%eax
801044d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044dc:	8b 52 18             	mov    0x18(%edx),%edx
801044df:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044e3:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801044e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ea:	8b 40 18             	mov    0x18(%eax),%eax
801044ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044f0:	8b 52 18             	mov    0x18(%edx),%edx
801044f3:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801044f7:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801044fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044fe:	8b 40 18             	mov    0x18(%eax),%eax
80104501:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104508:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450b:	8b 40 18             	mov    0x18(%eax),%eax
8010450e:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104515:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104518:	8b 40 18             	mov    0x18(%eax),%eax
8010451b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104522:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104525:	83 c0 6c             	add    $0x6c,%eax
80104528:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010452f:	00 
80104530:	c7 44 24 04 dd 88 10 	movl   $0x801088dd,0x4(%esp)
80104537:	80 
80104538:	89 04 24             	mov    %eax,(%esp)
8010453b:	e8 99 0e 00 00       	call   801053d9 <safestrcpy>
  p->cwd = namei("/");
80104540:	c7 04 24 e6 88 10 80 	movl   $0x801088e6,(%esp)
80104547:	e8 4e df ff ff       	call   8010249a <namei>
8010454c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010454f:	89 42 68             	mov    %eax,0x68(%edx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104552:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104559:	e8 f2 09 00 00       	call   80104f50 <acquire>

  p->state = RUNNABLE;
8010455e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104561:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80104568:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
8010456f:	e8 43 0a 00 00       	call   80104fb7 <release>
}
80104574:	c9                   	leave  
80104575:	c3                   	ret    

80104576 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104576:	55                   	push   %ebp
80104577:	89 e5                	mov    %esp,%ebp
80104579:	83 ec 28             	sub    $0x28,%esp
  uint sz;

  sz = proc->sz;
8010457c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104582:	8b 00                	mov    (%eax),%eax
80104584:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104587:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010458b:	7e 34                	jle    801045c1 <growproc+0x4b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010458d:	8b 55 08             	mov    0x8(%ebp),%edx
80104590:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104593:	01 c2                	add    %eax,%edx
80104595:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010459b:	8b 40 04             	mov    0x4(%eax),%eax
8010459e:	89 54 24 08          	mov    %edx,0x8(%esp)
801045a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045a5:	89 54 24 04          	mov    %edx,0x4(%esp)
801045a9:	89 04 24             	mov    %eax,(%esp)
801045ac:	e8 49 3b 00 00       	call   801080fa <allocuvm>
801045b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801045b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801045b8:	75 41                	jne    801045fb <growproc+0x85>
      return -1;
801045ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045bf:	eb 58                	jmp    80104619 <growproc+0xa3>
  } else if(n < 0){
801045c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801045c5:	79 34                	jns    801045fb <growproc+0x85>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801045c7:	8b 55 08             	mov    0x8(%ebp),%edx
801045ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045cd:	01 c2                	add    %eax,%edx
801045cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045d5:	8b 40 04             	mov    0x4(%eax),%eax
801045d8:	89 54 24 08          	mov    %edx,0x8(%esp)
801045dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045df:	89 54 24 04          	mov    %edx,0x4(%esp)
801045e3:	89 04 24             	mov    %eax,(%esp)
801045e6:	e8 14 3c 00 00       	call   801081ff <deallocuvm>
801045eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801045ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801045f2:	75 07                	jne    801045fb <growproc+0x85>
      return -1;
801045f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045f9:	eb 1e                	jmp    80104619 <growproc+0xa3>
  }
  proc->sz = sz;
801045fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104601:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104604:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104606:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010460c:	89 04 24             	mov    %eax,(%esp)
8010460f:	e8 31 38 00 00       	call   80107e45 <switchuvm>
  return 0;
80104614:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104619:	c9                   	leave  
8010461a:	c3                   	ret    

8010461b <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
8010461b:	55                   	push   %ebp
8010461c:	89 e5                	mov    %esp,%ebp
8010461e:	57                   	push   %edi
8010461f:	56                   	push   %esi
80104620:	53                   	push   %ebx
80104621:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
80104624:	e8 16 fd ff ff       	call   8010433f <allocproc>
80104629:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010462c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104630:	75 0a                	jne    8010463c <fork+0x21>
    return -1;
80104632:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104637:	e9 52 01 00 00       	jmp    8010478e <fork+0x173>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010463c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104642:	8b 10                	mov    (%eax),%edx
80104644:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010464a:	8b 40 04             	mov    0x4(%eax),%eax
8010464d:	89 54 24 04          	mov    %edx,0x4(%esp)
80104651:	89 04 24             	mov    %eax,(%esp)
80104654:	e8 34 3d 00 00       	call   8010838d <copyuvm>
80104659:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010465c:	89 42 04             	mov    %eax,0x4(%edx)
8010465f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104662:	8b 40 04             	mov    0x4(%eax),%eax
80104665:	85 c0                	test   %eax,%eax
80104667:	75 2c                	jne    80104695 <fork+0x7a>
    kfree(np->kstack);
80104669:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010466c:	8b 40 08             	mov    0x8(%eax),%eax
8010466f:	89 04 24             	mov    %eax,(%esp)
80104672:	e8 c4 e4 ff ff       	call   80102b3b <kfree>
    np->kstack = 0;
80104677:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010467a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104681:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104684:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
8010468b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104690:	e9 f9 00 00 00       	jmp    8010478e <fork+0x173>
  }
  np->sz = proc->sz;
80104695:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010469b:	8b 10                	mov    (%eax),%edx
8010469d:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046a0:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
801046a2:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046ac:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
801046af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046b2:	8b 50 18             	mov    0x18(%eax),%edx
801046b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046bb:	8b 40 18             	mov    0x18(%eax),%eax
801046be:	89 c3                	mov    %eax,%ebx
801046c0:	b8 13 00 00 00       	mov    $0x13,%eax
801046c5:	89 d7                	mov    %edx,%edi
801046c7:	89 de                	mov    %ebx,%esi
801046c9:	89 c1                	mov    %eax,%ecx
801046cb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801046cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046d0:	8b 40 18             	mov    0x18(%eax),%eax
801046d3:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801046da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801046e1:	eb 3d                	jmp    80104720 <fork+0x105>
    if(proc->ofile[i])
801046e3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046e9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046ec:	83 c2 08             	add    $0x8,%edx
801046ef:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046f3:	85 c0                	test   %eax,%eax
801046f5:	74 25                	je     8010471c <fork+0x101>
      np->ofile[i] = filedup(proc->ofile[i]);
801046f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046fd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104700:	83 c2 08             	add    $0x8,%edx
80104703:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104707:	89 04 24             	mov    %eax,(%esp)
8010470a:	e8 eb c8 ff ff       	call   80100ffa <filedup>
8010470f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104712:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104715:	83 c1 08             	add    $0x8,%ecx
80104718:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010471c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104720:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104724:	7e bd                	jle    801046e3 <fork+0xc8>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104726:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472c:	8b 40 68             	mov    0x68(%eax),%eax
8010472f:	89 04 24             	mov    %eax,(%esp)
80104732:	e8 09 d2 ff ff       	call   80101940 <idup>
80104737:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010473a:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
8010473d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104743:	8d 50 6c             	lea    0x6c(%eax),%edx
80104746:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104749:	83 c0 6c             	add    $0x6c,%eax
8010474c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104753:	00 
80104754:	89 54 24 04          	mov    %edx,0x4(%esp)
80104758:	89 04 24             	mov    %eax,(%esp)
8010475b:	e8 79 0c 00 00       	call   801053d9 <safestrcpy>

  pid = np->pid;
80104760:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104763:	8b 40 10             	mov    0x10(%eax),%eax
80104766:	89 45 dc             	mov    %eax,-0x24(%ebp)

  acquire(&ptable.lock);
80104769:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104770:	e8 db 07 00 00       	call   80104f50 <acquire>

  np->state = RUNNABLE;
80104775:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104778:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
8010477f:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104786:	e8 2c 08 00 00       	call   80104fb7 <release>

  return pid;
8010478b:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
8010478e:	83 c4 2c             	add    $0x2c,%esp
80104791:	5b                   	pop    %ebx
80104792:	5e                   	pop    %esi
80104793:	5f                   	pop    %edi
80104794:	5d                   	pop    %ebp
80104795:	c3                   	ret    

80104796 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104796:	55                   	push   %ebp
80104797:	89 e5                	mov    %esp,%ebp
80104799:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010479c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047a3:	a1 44 b6 10 80       	mov    0x8010b644,%eax
801047a8:	39 c2                	cmp    %eax,%edx
801047aa:	75 0c                	jne    801047b8 <exit+0x22>
    panic("init exiting");
801047ac:	c7 04 24 e8 88 10 80 	movl   $0x801088e8,(%esp)
801047b3:	e8 aa bd ff ff       	call   80100562 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801047b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801047bf:	eb 44                	jmp    80104805 <exit+0x6f>
    if(proc->ofile[fd]){
801047c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047c7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047ca:	83 c2 08             	add    $0x8,%edx
801047cd:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047d1:	85 c0                	test   %eax,%eax
801047d3:	74 2c                	je     80104801 <exit+0x6b>
      fileclose(proc->ofile[fd]);
801047d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047db:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047de:	83 c2 08             	add    $0x8,%edx
801047e1:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047e5:	89 04 24             	mov    %eax,(%esp)
801047e8:	e8 55 c8 ff ff       	call   80101042 <fileclose>
      proc->ofile[fd] = 0;
801047ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047f3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801047f6:	83 c2 08             	add    $0x8,%edx
801047f9:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104800:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104801:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104805:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104809:	7e b6                	jle    801047c1 <exit+0x2b>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
8010480b:	e8 29 ed ff ff       	call   80103539 <begin_op>
  iput(proc->cwd);
80104810:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104816:	8b 40 68             	mov    0x68(%eax),%eax
80104819:	89 04 24             	mov    %eax,(%esp)
8010481c:	e8 ac d2 ff ff       	call   80101acd <iput>
  end_op();
80104821:	e8 97 ed ff ff       	call   801035bd <end_op>
  proc->cwd = 0;
80104826:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010482c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104833:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
8010483a:	e8 11 07 00 00       	call   80104f50 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
8010483f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104845:	8b 40 14             	mov    0x14(%eax),%eax
80104848:	89 04 24             	mov    %eax,(%esp)
8010484b:	e8 ca 03 00 00       	call   80104c1a <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104850:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
80104857:	eb 38                	jmp    80104891 <exit+0xfb>
    if(p->parent == proc){
80104859:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010485c:	8b 50 14             	mov    0x14(%eax),%edx
8010485f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104865:	39 c2                	cmp    %eax,%edx
80104867:	75 24                	jne    8010488d <exit+0xf7>
      p->parent = initproc;
80104869:	8b 15 44 b6 10 80    	mov    0x8010b644,%edx
8010486f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104872:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104875:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104878:	8b 40 0c             	mov    0xc(%eax),%eax
8010487b:	83 f8 05             	cmp    $0x5,%eax
8010487e:	75 0d                	jne    8010488d <exit+0xf7>
        wakeup1(initproc);
80104880:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80104885:	89 04 24             	mov    %eax,(%esp)
80104888:	e8 8d 03 00 00       	call   80104c1a <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010488d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104891:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104898:	72 bf                	jb     80104859 <exit+0xc3>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
8010489a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a0:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
801048a7:	e8 b0 01 00 00       	call   80104a5c <sched>
  panic("zombie exit");
801048ac:	c7 04 24 f5 88 10 80 	movl   $0x801088f5,(%esp)
801048b3:	e8 aa bc ff ff       	call   80100562 <panic>

801048b8 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801048b8:	55                   	push   %ebp
801048b9:	89 e5                	mov    %esp,%ebp
801048bb:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801048be:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
801048c5:	e8 86 06 00 00       	call   80104f50 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801048ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048d1:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
801048d8:	e9 9a 00 00 00       	jmp    80104977 <wait+0xbf>
      if(p->parent != proc)
801048dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e0:	8b 50 14             	mov    0x14(%eax),%edx
801048e3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e9:	39 c2                	cmp    %eax,%edx
801048eb:	74 05                	je     801048f2 <wait+0x3a>
        continue;
801048ed:	e9 81 00 00 00       	jmp    80104973 <wait+0xbb>
      havekids = 1;
801048f2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801048f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048fc:	8b 40 0c             	mov    0xc(%eax),%eax
801048ff:	83 f8 05             	cmp    $0x5,%eax
80104902:	75 6f                	jne    80104973 <wait+0xbb>
        // Found one.
        pid = p->pid;
80104904:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104907:	8b 40 10             	mov    0x10(%eax),%eax
8010490a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
8010490d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104910:	8b 40 08             	mov    0x8(%eax),%eax
80104913:	89 04 24             	mov    %eax,(%esp)
80104916:	e8 20 e2 ff ff       	call   80102b3b <kfree>
        p->kstack = 0;
8010491b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010491e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104925:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104928:	8b 40 04             	mov    0x4(%eax),%eax
8010492b:	89 04 24             	mov    %eax,(%esp)
8010492e:	e8 80 39 00 00       	call   801082b3 <freevm>
        p->pid = 0;
80104933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104936:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
8010493d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104940:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104947:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010494a:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
8010494e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104951:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
80104958:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010495b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80104962:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104969:	e8 49 06 00 00       	call   80104fb7 <release>
        return pid;
8010496e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104971:	eb 52                	jmp    801049c5 <wait+0x10d>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104973:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104977:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
8010497e:	0f 82 59 ff ff ff    	jb     801048dd <wait+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104984:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104988:	74 0d                	je     80104997 <wait+0xdf>
8010498a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104990:	8b 40 24             	mov    0x24(%eax),%eax
80104993:	85 c0                	test   %eax,%eax
80104995:	74 13                	je     801049aa <wait+0xf2>
      release(&ptable.lock);
80104997:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
8010499e:	e8 14 06 00 00       	call   80104fb7 <release>
      return -1;
801049a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049a8:	eb 1b                	jmp    801049c5 <wait+0x10d>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801049aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049b0:	c7 44 24 04 20 3e 11 	movl   $0x80113e20,0x4(%esp)
801049b7:	80 
801049b8:	89 04 24             	mov    %eax,(%esp)
801049bb:	e8 bf 01 00 00       	call   80104b7f <sleep>
  }
801049c0:	e9 05 ff ff ff       	jmp    801048ca <wait+0x12>
}
801049c5:	c9                   	leave  
801049c6:	c3                   	ret    

801049c7 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801049c7:	55                   	push   %ebp
801049c8:	89 e5                	mov    %esp,%ebp
801049ca:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801049cd:	e8 4b f9 ff ff       	call   8010431d <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801049d2:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
801049d9:	e8 72 05 00 00       	call   80104f50 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049de:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
801049e5:	eb 5b                	jmp    80104a42 <scheduler+0x7b>
      if(p->state != RUNNABLE)
801049e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049ea:	8b 40 0c             	mov    0xc(%eax),%eax
801049ed:	83 f8 03             	cmp    $0x3,%eax
801049f0:	74 02                	je     801049f4 <scheduler+0x2d>
        continue;
801049f2:	eb 4a                	jmp    80104a3e <scheduler+0x77>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801049f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f7:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801049fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a00:	89 04 24             	mov    %eax,(%esp)
80104a03:	e8 3d 34 00 00       	call   80107e45 <switchuvm>
      p->state = RUNNING;
80104a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a0b:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, p->context);
80104a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a15:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a18:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a1f:	83 c2 04             	add    $0x4,%edx
80104a22:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a26:	89 14 24             	mov    %edx,(%esp)
80104a29:	e8 1c 0a 00 00       	call   8010544a <swtch>
      switchkvm();
80104a2e:	e8 f9 33 00 00       	call   80107e2c <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104a33:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a3a:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a3e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a42:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104a49:	72 9c                	jb     801049e7 <scheduler+0x20>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104a4b:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104a52:	e8 60 05 00 00       	call   80104fb7 <release>

  }
80104a57:	e9 71 ff ff ff       	jmp    801049cd <scheduler+0x6>

80104a5c <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104a5c:	55                   	push   %ebp
80104a5d:	89 e5                	mov    %esp,%ebp
80104a5f:	83 ec 28             	sub    $0x28,%esp
  int intena;

  if(!holding(&ptable.lock))
80104a62:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104a69:	e8 0f 06 00 00       	call   8010507d <holding>
80104a6e:	85 c0                	test   %eax,%eax
80104a70:	75 0c                	jne    80104a7e <sched+0x22>
    panic("sched ptable.lock");
80104a72:	c7 04 24 01 89 10 80 	movl   $0x80108901,(%esp)
80104a79:	e8 e4 ba ff ff       	call   80100562 <panic>
  if(cpu->ncli != 1)
80104a7e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a84:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104a8a:	83 f8 01             	cmp    $0x1,%eax
80104a8d:	74 0c                	je     80104a9b <sched+0x3f>
    panic("sched locks");
80104a8f:	c7 04 24 13 89 10 80 	movl   $0x80108913,(%esp)
80104a96:	e8 c7 ba ff ff       	call   80100562 <panic>
  if(proc->state == RUNNING)
80104a9b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aa1:	8b 40 0c             	mov    0xc(%eax),%eax
80104aa4:	83 f8 04             	cmp    $0x4,%eax
80104aa7:	75 0c                	jne    80104ab5 <sched+0x59>
    panic("sched running");
80104aa9:	c7 04 24 1f 89 10 80 	movl   $0x8010891f,(%esp)
80104ab0:	e8 ad ba ff ff       	call   80100562 <panic>
  if(readeflags()&FL_IF)
80104ab5:	e8 53 f8 ff ff       	call   8010430d <readeflags>
80104aba:	25 00 02 00 00       	and    $0x200,%eax
80104abf:	85 c0                	test   %eax,%eax
80104ac1:	74 0c                	je     80104acf <sched+0x73>
    panic("sched interruptible");
80104ac3:	c7 04 24 2d 89 10 80 	movl   $0x8010892d,(%esp)
80104aca:	e8 93 ba ff ff       	call   80100562 <panic>
  intena = cpu->intena;
80104acf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ad5:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104adb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104ade:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ae4:	8b 40 04             	mov    0x4(%eax),%eax
80104ae7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104aee:	83 c2 1c             	add    $0x1c,%edx
80104af1:	89 44 24 04          	mov    %eax,0x4(%esp)
80104af5:	89 14 24             	mov    %edx,(%esp)
80104af8:	e8 4d 09 00 00       	call   8010544a <swtch>
  cpu->intena = intena;
80104afd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b03:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b06:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104b0c:	c9                   	leave  
80104b0d:	c3                   	ret    

80104b0e <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104b0e:	55                   	push   %ebp
80104b0f:	89 e5                	mov    %esp,%ebp
80104b11:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104b14:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104b1b:	e8 30 04 00 00       	call   80104f50 <acquire>
  proc->state = RUNNABLE;
80104b20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b26:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104b2d:	e8 2a ff ff ff       	call   80104a5c <sched>
  release(&ptable.lock);
80104b32:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104b39:	e8 79 04 00 00       	call   80104fb7 <release>
}
80104b3e:	c9                   	leave  
80104b3f:	c3                   	ret    

80104b40 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104b46:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104b4d:	e8 65 04 00 00       	call   80104fb7 <release>

  if (first) {
80104b52:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104b57:	85 c0                	test   %eax,%eax
80104b59:	74 22                	je     80104b7d <forkret+0x3d>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80104b5b:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104b62:	00 00 00 
    iinit(ROOTDEV);
80104b65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b6c:	e8 94 ca ff ff       	call   80101605 <iinit>
    initlog(ROOTDEV);
80104b71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b78:	e8 b8 e7 ff ff       	call   80103335 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104b7d:	c9                   	leave  
80104b7e:	c3                   	ret    

80104b7f <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104b7f:	55                   	push   %ebp
80104b80:	89 e5                	mov    %esp,%ebp
80104b82:	83 ec 18             	sub    $0x18,%esp
  if(proc == 0)
80104b85:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b8b:	85 c0                	test   %eax,%eax
80104b8d:	75 0c                	jne    80104b9b <sleep+0x1c>
    panic("sleep");
80104b8f:	c7 04 24 41 89 10 80 	movl   $0x80108941,(%esp)
80104b96:	e8 c7 b9 ff ff       	call   80100562 <panic>

  if(lk == 0)
80104b9b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104b9f:	75 0c                	jne    80104bad <sleep+0x2e>
    panic("sleep without lk");
80104ba1:	c7 04 24 47 89 10 80 	movl   $0x80108947,(%esp)
80104ba8:	e8 b5 b9 ff ff       	call   80100562 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104bad:	81 7d 0c 20 3e 11 80 	cmpl   $0x80113e20,0xc(%ebp)
80104bb4:	74 17                	je     80104bcd <sleep+0x4e>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104bb6:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104bbd:	e8 8e 03 00 00       	call   80104f50 <acquire>
    release(lk);
80104bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bc5:	89 04 24             	mov    %eax,(%esp)
80104bc8:	e8 ea 03 00 00       	call   80104fb7 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80104bcd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bd3:	8b 55 08             	mov    0x8(%ebp),%edx
80104bd6:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104bd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bdf:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104be6:	e8 71 fe ff ff       	call   80104a5c <sched>

  // Tidy up.
  proc->chan = 0;
80104beb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bf1:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104bf8:	81 7d 0c 20 3e 11 80 	cmpl   $0x80113e20,0xc(%ebp)
80104bff:	74 17                	je     80104c18 <sleep+0x99>
    release(&ptable.lock);
80104c01:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104c08:	e8 aa 03 00 00       	call   80104fb7 <release>
    acquire(lk);
80104c0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c10:	89 04 24             	mov    %eax,(%esp)
80104c13:	e8 38 03 00 00       	call   80104f50 <acquire>
  }
}
80104c18:	c9                   	leave  
80104c19:	c3                   	ret    

80104c1a <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104c1a:	55                   	push   %ebp
80104c1b:	89 e5                	mov    %esp,%ebp
80104c1d:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c20:	c7 45 fc 54 3e 11 80 	movl   $0x80113e54,-0x4(%ebp)
80104c27:	eb 24                	jmp    80104c4d <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104c29:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c2c:	8b 40 0c             	mov    0xc(%eax),%eax
80104c2f:	83 f8 02             	cmp    $0x2,%eax
80104c32:	75 15                	jne    80104c49 <wakeup1+0x2f>
80104c34:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c37:	8b 40 20             	mov    0x20(%eax),%eax
80104c3a:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c3d:	75 0a                	jne    80104c49 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104c3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c42:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c49:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104c4d:	81 7d fc 54 5d 11 80 	cmpl   $0x80115d54,-0x4(%ebp)
80104c54:	72 d3                	jb     80104c29 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104c56:	c9                   	leave  
80104c57:	c3                   	ret    

80104c58 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104c58:	55                   	push   %ebp
80104c59:	89 e5                	mov    %esp,%ebp
80104c5b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80104c5e:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104c65:	e8 e6 02 00 00       	call   80104f50 <acquire>
  wakeup1(chan);
80104c6a:	8b 45 08             	mov    0x8(%ebp),%eax
80104c6d:	89 04 24             	mov    %eax,(%esp)
80104c70:	e8 a5 ff ff ff       	call   80104c1a <wakeup1>
  release(&ptable.lock);
80104c75:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104c7c:	e8 36 03 00 00       	call   80104fb7 <release>
}
80104c81:	c9                   	leave  
80104c82:	c3                   	ret    

80104c83 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c83:	55                   	push   %ebp
80104c84:	89 e5                	mov    %esp,%ebp
80104c86:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104c89:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104c90:	e8 bb 02 00 00       	call   80104f50 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c95:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
80104c9c:	eb 41                	jmp    80104cdf <kill+0x5c>
    if(p->pid == pid){
80104c9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ca1:	8b 40 10             	mov    0x10(%eax),%eax
80104ca4:	3b 45 08             	cmp    0x8(%ebp),%eax
80104ca7:	75 32                	jne    80104cdb <kill+0x58>
      p->killed = 1;
80104ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cac:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cb6:	8b 40 0c             	mov    0xc(%eax),%eax
80104cb9:	83 f8 02             	cmp    $0x2,%eax
80104cbc:	75 0a                	jne    80104cc8 <kill+0x45>
        p->state = RUNNABLE;
80104cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc1:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104cc8:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104ccf:	e8 e3 02 00 00       	call   80104fb7 <release>
      return 0;
80104cd4:	b8 00 00 00 00       	mov    $0x0,%eax
80104cd9:	eb 1e                	jmp    80104cf9 <kill+0x76>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cdb:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104cdf:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104ce6:	72 b6                	jb     80104c9e <kill+0x1b>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104ce8:	c7 04 24 20 3e 11 80 	movl   $0x80113e20,(%esp)
80104cef:	e8 c3 02 00 00       	call   80104fb7 <release>
  return -1;
80104cf4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cf9:	c9                   	leave  
80104cfa:	c3                   	ret    

80104cfb <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104cfb:	55                   	push   %ebp
80104cfc:	89 e5                	mov    %esp,%ebp
80104cfe:	83 ec 58             	sub    $0x58,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d01:	c7 45 f0 54 3e 11 80 	movl   $0x80113e54,-0x10(%ebp)
80104d08:	e9 d6 00 00 00       	jmp    80104de3 <procdump+0xe8>
    if(p->state == UNUSED)
80104d0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d10:	8b 40 0c             	mov    0xc(%eax),%eax
80104d13:	85 c0                	test   %eax,%eax
80104d15:	75 05                	jne    80104d1c <procdump+0x21>
      continue;
80104d17:	e9 c3 00 00 00       	jmp    80104ddf <procdump+0xe4>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d1f:	8b 40 0c             	mov    0xc(%eax),%eax
80104d22:	83 f8 05             	cmp    $0x5,%eax
80104d25:	77 23                	ja     80104d4a <procdump+0x4f>
80104d27:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d2a:	8b 40 0c             	mov    0xc(%eax),%eax
80104d2d:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104d34:	85 c0                	test   %eax,%eax
80104d36:	74 12                	je     80104d4a <procdump+0x4f>
      state = states[p->state];
80104d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d3b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d3e:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104d45:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104d48:	eb 07                	jmp    80104d51 <procdump+0x56>
    else
      state = "???";
80104d4a:	c7 45 ec 58 89 10 80 	movl   $0x80108958,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104d51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d54:	8d 50 6c             	lea    0x6c(%eax),%edx
80104d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d5a:	8b 40 10             	mov    0x10(%eax),%eax
80104d5d:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104d61:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104d64:	89 54 24 08          	mov    %edx,0x8(%esp)
80104d68:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d6c:	c7 04 24 5c 89 10 80 	movl   $0x8010895c,(%esp)
80104d73:	e8 50 b6 ff ff       	call   801003c8 <cprintf>
    if(p->state == SLEEPING){
80104d78:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d7b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d7e:	83 f8 02             	cmp    $0x2,%eax
80104d81:	75 50                	jne    80104dd3 <procdump+0xd8>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d83:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d86:	8b 40 1c             	mov    0x1c(%eax),%eax
80104d89:	8b 40 0c             	mov    0xc(%eax),%eax
80104d8c:	83 c0 08             	add    $0x8,%eax
80104d8f:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104d92:	89 54 24 04          	mov    %edx,0x4(%esp)
80104d96:	89 04 24             	mov    %eax,(%esp)
80104d99:	e8 66 02 00 00       	call   80105004 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104d9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104da5:	eb 1b                	jmp    80104dc2 <procdump+0xc7>
        cprintf(" %p", pc[i]);
80104da7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104daa:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104dae:	89 44 24 04          	mov    %eax,0x4(%esp)
80104db2:	c7 04 24 65 89 10 80 	movl   $0x80108965,(%esp)
80104db9:	e8 0a b6 ff ff       	call   801003c8 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104dbe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104dc2:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104dc6:	7f 0b                	jg     80104dd3 <procdump+0xd8>
80104dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dcb:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104dcf:	85 c0                	test   %eax,%eax
80104dd1:	75 d4                	jne    80104da7 <procdump+0xac>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104dd3:	c7 04 24 69 89 10 80 	movl   $0x80108969,(%esp)
80104dda:	e8 e9 b5 ff ff       	call   801003c8 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ddf:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104de3:	81 7d f0 54 5d 11 80 	cmpl   $0x80115d54,-0x10(%ebp)
80104dea:	0f 82 1d ff ff ff    	jb     80104d0d <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104df0:	c9                   	leave  
80104df1:	c3                   	ret    

80104df2 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104df2:	55                   	push   %ebp
80104df3:	89 e5                	mov    %esp,%ebp
80104df5:	83 ec 18             	sub    $0x18,%esp
  initlock(&lk->lk, "sleep lock");
80104df8:	8b 45 08             	mov    0x8(%ebp),%eax
80104dfb:	83 c0 04             	add    $0x4,%eax
80104dfe:	c7 44 24 04 95 89 10 	movl   $0x80108995,0x4(%esp)
80104e05:	80 
80104e06:	89 04 24             	mov    %eax,(%esp)
80104e09:	e8 21 01 00 00       	call   80104f2f <initlock>
  lk->name = name;
80104e0e:	8b 45 08             	mov    0x8(%ebp),%eax
80104e11:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e14:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
80104e17:	8b 45 08             	mov    0x8(%ebp),%eax
80104e1a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80104e20:	8b 45 08             	mov    0x8(%ebp),%eax
80104e23:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80104e2a:	c9                   	leave  
80104e2b:	c3                   	ret    

80104e2c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e2c:	55                   	push   %ebp
80104e2d:	89 e5                	mov    %esp,%ebp
80104e2f:	83 ec 18             	sub    $0x18,%esp
  acquire(&lk->lk);
80104e32:	8b 45 08             	mov    0x8(%ebp),%eax
80104e35:	83 c0 04             	add    $0x4,%eax
80104e38:	89 04 24             	mov    %eax,(%esp)
80104e3b:	e8 10 01 00 00       	call   80104f50 <acquire>
  while (lk->locked) {
80104e40:	eb 15                	jmp    80104e57 <acquiresleep+0x2b>
    sleep(lk, &lk->lk);
80104e42:	8b 45 08             	mov    0x8(%ebp),%eax
80104e45:	83 c0 04             	add    $0x4,%eax
80104e48:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80104e4f:	89 04 24             	mov    %eax,(%esp)
80104e52:	e8 28 fd ff ff       	call   80104b7f <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80104e57:	8b 45 08             	mov    0x8(%ebp),%eax
80104e5a:	8b 00                	mov    (%eax),%eax
80104e5c:	85 c0                	test   %eax,%eax
80104e5e:	75 e2                	jne    80104e42 <acquiresleep+0x16>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104e60:	8b 45 08             	mov    0x8(%ebp),%eax
80104e63:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = proc->pid;
80104e69:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e6f:	8b 50 10             	mov    0x10(%eax),%edx
80104e72:	8b 45 08             	mov    0x8(%ebp),%eax
80104e75:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80104e78:	8b 45 08             	mov    0x8(%ebp),%eax
80104e7b:	83 c0 04             	add    $0x4,%eax
80104e7e:	89 04 24             	mov    %eax,(%esp)
80104e81:	e8 31 01 00 00       	call   80104fb7 <release>
}
80104e86:	c9                   	leave  
80104e87:	c3                   	ret    

80104e88 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104e88:	55                   	push   %ebp
80104e89:	89 e5                	mov    %esp,%ebp
80104e8b:	83 ec 18             	sub    $0x18,%esp
  acquire(&lk->lk);
80104e8e:	8b 45 08             	mov    0x8(%ebp),%eax
80104e91:	83 c0 04             	add    $0x4,%eax
80104e94:	89 04 24             	mov    %eax,(%esp)
80104e97:	e8 b4 00 00 00       	call   80104f50 <acquire>
  lk->locked = 0;
80104e9c:	8b 45 08             	mov    0x8(%ebp),%eax
80104e9f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80104ea5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ea8:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
80104eaf:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb2:	89 04 24             	mov    %eax,(%esp)
80104eb5:	e8 9e fd ff ff       	call   80104c58 <wakeup>
  release(&lk->lk);
80104eba:	8b 45 08             	mov    0x8(%ebp),%eax
80104ebd:	83 c0 04             	add    $0x4,%eax
80104ec0:	89 04 24             	mov    %eax,(%esp)
80104ec3:	e8 ef 00 00 00       	call   80104fb7 <release>
}
80104ec8:	c9                   	leave  
80104ec9:	c3                   	ret    

80104eca <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104eca:	55                   	push   %ebp
80104ecb:	89 e5                	mov    %esp,%ebp
80104ecd:	83 ec 28             	sub    $0x28,%esp
  int r;
  
  acquire(&lk->lk);
80104ed0:	8b 45 08             	mov    0x8(%ebp),%eax
80104ed3:	83 c0 04             	add    $0x4,%eax
80104ed6:	89 04 24             	mov    %eax,(%esp)
80104ed9:	e8 72 00 00 00       	call   80104f50 <acquire>
  r = lk->locked;
80104ede:	8b 45 08             	mov    0x8(%ebp),%eax
80104ee1:	8b 00                	mov    (%eax),%eax
80104ee3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80104ee6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ee9:	83 c0 04             	add    $0x4,%eax
80104eec:	89 04 24             	mov    %eax,(%esp)
80104eef:	e8 c3 00 00 00       	call   80104fb7 <release>
  return r;
80104ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104ef7:	c9                   	leave  
80104ef8:	c3                   	ret    

80104ef9 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104ef9:	55                   	push   %ebp
80104efa:	89 e5                	mov    %esp,%ebp
80104efc:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104eff:	9c                   	pushf  
80104f00:	58                   	pop    %eax
80104f01:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104f04:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104f07:	c9                   	leave  
80104f08:	c3                   	ret    

80104f09 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104f09:	55                   	push   %ebp
80104f0a:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104f0c:	fa                   	cli    
}
80104f0d:	5d                   	pop    %ebp
80104f0e:	c3                   	ret    

80104f0f <sti>:

static inline void
sti(void)
{
80104f0f:	55                   	push   %ebp
80104f10:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104f12:	fb                   	sti    
}
80104f13:	5d                   	pop    %ebp
80104f14:	c3                   	ret    

80104f15 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104f15:	55                   	push   %ebp
80104f16:	89 e5                	mov    %esp,%ebp
80104f18:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104f1b:	8b 55 08             	mov    0x8(%ebp),%edx
80104f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f21:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f24:	f0 87 02             	lock xchg %eax,(%edx)
80104f27:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104f2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104f2d:	c9                   	leave  
80104f2e:	c3                   	ret    

80104f2f <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f2f:	55                   	push   %ebp
80104f30:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104f32:	8b 45 08             	mov    0x8(%ebp),%eax
80104f35:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f38:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104f3b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f3e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104f44:	8b 45 08             	mov    0x8(%ebp),%eax
80104f47:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f4e:	5d                   	pop    %ebp
80104f4f:	c3                   	ret    

80104f50 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104f56:	e8 4c 01 00 00       	call   801050a7 <pushcli>
  if(holding(lk))
80104f5b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5e:	89 04 24             	mov    %eax,(%esp)
80104f61:	e8 17 01 00 00       	call   8010507d <holding>
80104f66:	85 c0                	test   %eax,%eax
80104f68:	74 0c                	je     80104f76 <acquire+0x26>
    panic("acquire");
80104f6a:	c7 04 24 a0 89 10 80 	movl   $0x801089a0,(%esp)
80104f71:	e8 ec b5 ff ff       	call   80100562 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104f76:	90                   	nop
80104f77:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80104f81:	00 
80104f82:	89 04 24             	mov    %eax,(%esp)
80104f85:	e8 8b ff ff ff       	call   80104f15 <xchg>
80104f8a:	85 c0                	test   %eax,%eax
80104f8c:	75 e9                	jne    80104f77 <acquire+0x27>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80104f8e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104f93:	8b 45 08             	mov    0x8(%ebp),%eax
80104f96:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104f9d:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104fa0:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa3:	83 c0 0c             	add    $0xc,%eax
80104fa6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104faa:	8d 45 08             	lea    0x8(%ebp),%eax
80104fad:	89 04 24             	mov    %eax,(%esp)
80104fb0:	e8 4f 00 00 00       	call   80105004 <getcallerpcs>
}
80104fb5:	c9                   	leave  
80104fb6:	c3                   	ret    

80104fb7 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104fb7:	55                   	push   %ebp
80104fb8:	89 e5                	mov    %esp,%ebp
80104fba:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80104fbd:	8b 45 08             	mov    0x8(%ebp),%eax
80104fc0:	89 04 24             	mov    %eax,(%esp)
80104fc3:	e8 b5 00 00 00       	call   8010507d <holding>
80104fc8:	85 c0                	test   %eax,%eax
80104fca:	75 0c                	jne    80104fd8 <release+0x21>
    panic("release");
80104fcc:	c7 04 24 a8 89 10 80 	movl   $0x801089a8,(%esp)
80104fd3:	e8 8a b5 ff ff       	call   80100562 <panic>

  lk->pcs[0] = 0;
80104fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80104fdb:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104fec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104ff1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ff4:	8b 55 08             	mov    0x8(%ebp),%edx
80104ff7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
80104ffd:	e8 fb 00 00 00       	call   801050fd <popcli>
}
80105002:	c9                   	leave  
80105003:	c3                   	ret    

80105004 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105004:	55                   	push   %ebp
80105005:	89 e5                	mov    %esp,%ebp
80105007:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010500a:	8b 45 08             	mov    0x8(%ebp),%eax
8010500d:	83 e8 08             	sub    $0x8,%eax
80105010:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105013:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010501a:	eb 38                	jmp    80105054 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010501c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80105020:	74 38                	je     8010505a <getcallerpcs+0x56>
80105022:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105029:	76 2f                	jbe    8010505a <getcallerpcs+0x56>
8010502b:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
8010502f:	74 29                	je     8010505a <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105031:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105034:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010503b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010503e:	01 c2                	add    %eax,%edx
80105040:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105043:	8b 40 04             	mov    0x4(%eax),%eax
80105046:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105048:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010504b:	8b 00                	mov    (%eax),%eax
8010504d:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105050:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105054:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105058:	7e c2                	jle    8010501c <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010505a:	eb 19                	jmp    80105075 <getcallerpcs+0x71>
    pcs[i] = 0;
8010505c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010505f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105066:	8b 45 0c             	mov    0xc(%ebp),%eax
80105069:	01 d0                	add    %edx,%eax
8010506b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105071:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105075:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105079:	7e e1                	jle    8010505c <getcallerpcs+0x58>
    pcs[i] = 0;
}
8010507b:	c9                   	leave  
8010507c:	c3                   	ret    

8010507d <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
8010507d:	55                   	push   %ebp
8010507e:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105080:	8b 45 08             	mov    0x8(%ebp),%eax
80105083:	8b 00                	mov    (%eax),%eax
80105085:	85 c0                	test   %eax,%eax
80105087:	74 17                	je     801050a0 <holding+0x23>
80105089:	8b 45 08             	mov    0x8(%ebp),%eax
8010508c:	8b 50 08             	mov    0x8(%eax),%edx
8010508f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105095:	39 c2                	cmp    %eax,%edx
80105097:	75 07                	jne    801050a0 <holding+0x23>
80105099:	b8 01 00 00 00       	mov    $0x1,%eax
8010509e:	eb 05                	jmp    801050a5 <holding+0x28>
801050a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801050a5:	5d                   	pop    %ebp
801050a6:	c3                   	ret    

801050a7 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801050a7:	55                   	push   %ebp
801050a8:	89 e5                	mov    %esp,%ebp
801050aa:	83 ec 10             	sub    $0x10,%esp
  int eflags;

  eflags = readeflags();
801050ad:	e8 47 fe ff ff       	call   80104ef9 <readeflags>
801050b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801050b5:	e8 4f fe ff ff       	call   80104f09 <cli>
  if(cpu->ncli == 0)
801050ba:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050c0:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801050c6:	85 c0                	test   %eax,%eax
801050c8:	75 15                	jne    801050df <pushcli+0x38>
    cpu->intena = eflags & FL_IF;
801050ca:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
801050d3:	81 e2 00 02 00 00    	and    $0x200,%edx
801050d9:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  cpu->ncli += 1;
801050df:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050e5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801050ec:	8b 92 ac 00 00 00    	mov    0xac(%edx),%edx
801050f2:	83 c2 01             	add    $0x1,%edx
801050f5:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
801050fb:	c9                   	leave  
801050fc:	c3                   	ret    

801050fd <popcli>:

void
popcli(void)
{
801050fd:	55                   	push   %ebp
801050fe:	89 e5                	mov    %esp,%ebp
80105100:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
80105103:	e8 f1 fd ff ff       	call   80104ef9 <readeflags>
80105108:	25 00 02 00 00       	and    $0x200,%eax
8010510d:	85 c0                	test   %eax,%eax
8010510f:	74 0c                	je     8010511d <popcli+0x20>
    panic("popcli - interruptible");
80105111:	c7 04 24 b0 89 10 80 	movl   $0x801089b0,(%esp)
80105118:	e8 45 b4 ff ff       	call   80100562 <panic>
  if(--cpu->ncli < 0)
8010511d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105123:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105129:	83 ea 01             	sub    $0x1,%edx
8010512c:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105132:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105138:	85 c0                	test   %eax,%eax
8010513a:	79 0c                	jns    80105148 <popcli+0x4b>
    panic("popcli");
8010513c:	c7 04 24 c7 89 10 80 	movl   $0x801089c7,(%esp)
80105143:	e8 1a b4 ff ff       	call   80100562 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105148:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010514e:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105154:	85 c0                	test   %eax,%eax
80105156:	75 15                	jne    8010516d <popcli+0x70>
80105158:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010515e:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105164:	85 c0                	test   %eax,%eax
80105166:	74 05                	je     8010516d <popcli+0x70>
    sti();
80105168:	e8 a2 fd ff ff       	call   80104f0f <sti>
}
8010516d:	c9                   	leave  
8010516e:	c3                   	ret    

8010516f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010516f:	55                   	push   %ebp
80105170:	89 e5                	mov    %esp,%ebp
80105172:	57                   	push   %edi
80105173:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105174:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105177:	8b 55 10             	mov    0x10(%ebp),%edx
8010517a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010517d:	89 cb                	mov    %ecx,%ebx
8010517f:	89 df                	mov    %ebx,%edi
80105181:	89 d1                	mov    %edx,%ecx
80105183:	fc                   	cld    
80105184:	f3 aa                	rep stos %al,%es:(%edi)
80105186:	89 ca                	mov    %ecx,%edx
80105188:	89 fb                	mov    %edi,%ebx
8010518a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010518d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105190:	5b                   	pop    %ebx
80105191:	5f                   	pop    %edi
80105192:	5d                   	pop    %ebp
80105193:	c3                   	ret    

80105194 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105194:	55                   	push   %ebp
80105195:	89 e5                	mov    %esp,%ebp
80105197:	57                   	push   %edi
80105198:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105199:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010519c:	8b 55 10             	mov    0x10(%ebp),%edx
8010519f:	8b 45 0c             	mov    0xc(%ebp),%eax
801051a2:	89 cb                	mov    %ecx,%ebx
801051a4:	89 df                	mov    %ebx,%edi
801051a6:	89 d1                	mov    %edx,%ecx
801051a8:	fc                   	cld    
801051a9:	f3 ab                	rep stos %eax,%es:(%edi)
801051ab:	89 ca                	mov    %ecx,%edx
801051ad:	89 fb                	mov    %edi,%ebx
801051af:	89 5d 08             	mov    %ebx,0x8(%ebp)
801051b2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
801051b5:	5b                   	pop    %ebx
801051b6:	5f                   	pop    %edi
801051b7:	5d                   	pop    %ebp
801051b8:	c3                   	ret    

801051b9 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801051b9:	55                   	push   %ebp
801051ba:	89 e5                	mov    %esp,%ebp
801051bc:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
801051bf:	8b 45 08             	mov    0x8(%ebp),%eax
801051c2:	83 e0 03             	and    $0x3,%eax
801051c5:	85 c0                	test   %eax,%eax
801051c7:	75 49                	jne    80105212 <memset+0x59>
801051c9:	8b 45 10             	mov    0x10(%ebp),%eax
801051cc:	83 e0 03             	and    $0x3,%eax
801051cf:	85 c0                	test   %eax,%eax
801051d1:	75 3f                	jne    80105212 <memset+0x59>
    c &= 0xFF;
801051d3:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801051da:	8b 45 10             	mov    0x10(%ebp),%eax
801051dd:	c1 e8 02             	shr    $0x2,%eax
801051e0:	89 c2                	mov    %eax,%edx
801051e2:	8b 45 0c             	mov    0xc(%ebp),%eax
801051e5:	c1 e0 18             	shl    $0x18,%eax
801051e8:	89 c1                	mov    %eax,%ecx
801051ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ed:	c1 e0 10             	shl    $0x10,%eax
801051f0:	09 c1                	or     %eax,%ecx
801051f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801051f5:	c1 e0 08             	shl    $0x8,%eax
801051f8:	09 c8                	or     %ecx,%eax
801051fa:	0b 45 0c             	or     0xc(%ebp),%eax
801051fd:	89 54 24 08          	mov    %edx,0x8(%esp)
80105201:	89 44 24 04          	mov    %eax,0x4(%esp)
80105205:	8b 45 08             	mov    0x8(%ebp),%eax
80105208:	89 04 24             	mov    %eax,(%esp)
8010520b:	e8 84 ff ff ff       	call   80105194 <stosl>
80105210:	eb 19                	jmp    8010522b <memset+0x72>
  } else
    stosb(dst, c, n);
80105212:	8b 45 10             	mov    0x10(%ebp),%eax
80105215:	89 44 24 08          	mov    %eax,0x8(%esp)
80105219:	8b 45 0c             	mov    0xc(%ebp),%eax
8010521c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105220:	8b 45 08             	mov    0x8(%ebp),%eax
80105223:	89 04 24             	mov    %eax,(%esp)
80105226:	e8 44 ff ff ff       	call   8010516f <stosb>
  return dst;
8010522b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010522e:	c9                   	leave  
8010522f:	c3                   	ret    

80105230 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
80105236:	8b 45 08             	mov    0x8(%ebp),%eax
80105239:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
8010523c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010523f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105242:	eb 30                	jmp    80105274 <memcmp+0x44>
    if(*s1 != *s2)
80105244:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105247:	0f b6 10             	movzbl (%eax),%edx
8010524a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010524d:	0f b6 00             	movzbl (%eax),%eax
80105250:	38 c2                	cmp    %al,%dl
80105252:	74 18                	je     8010526c <memcmp+0x3c>
      return *s1 - *s2;
80105254:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105257:	0f b6 00             	movzbl (%eax),%eax
8010525a:	0f b6 d0             	movzbl %al,%edx
8010525d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105260:	0f b6 00             	movzbl (%eax),%eax
80105263:	0f b6 c0             	movzbl %al,%eax
80105266:	29 c2                	sub    %eax,%edx
80105268:	89 d0                	mov    %edx,%eax
8010526a:	eb 1a                	jmp    80105286 <memcmp+0x56>
    s1++, s2++;
8010526c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105270:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105274:	8b 45 10             	mov    0x10(%ebp),%eax
80105277:	8d 50 ff             	lea    -0x1(%eax),%edx
8010527a:	89 55 10             	mov    %edx,0x10(%ebp)
8010527d:	85 c0                	test   %eax,%eax
8010527f:	75 c3                	jne    80105244 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105281:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105286:	c9                   	leave  
80105287:	c3                   	ret    

80105288 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105288:	55                   	push   %ebp
80105289:	89 e5                	mov    %esp,%ebp
8010528b:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010528e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105291:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105294:	8b 45 08             	mov    0x8(%ebp),%eax
80105297:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
8010529a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010529d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801052a0:	73 3d                	jae    801052df <memmove+0x57>
801052a2:	8b 45 10             	mov    0x10(%ebp),%eax
801052a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052a8:	01 d0                	add    %edx,%eax
801052aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801052ad:	76 30                	jbe    801052df <memmove+0x57>
    s += n;
801052af:	8b 45 10             	mov    0x10(%ebp),%eax
801052b2:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801052b5:	8b 45 10             	mov    0x10(%ebp),%eax
801052b8:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801052bb:	eb 13                	jmp    801052d0 <memmove+0x48>
      *--d = *--s;
801052bd:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801052c1:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801052c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052c8:	0f b6 10             	movzbl (%eax),%edx
801052cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052ce:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801052d0:	8b 45 10             	mov    0x10(%ebp),%eax
801052d3:	8d 50 ff             	lea    -0x1(%eax),%edx
801052d6:	89 55 10             	mov    %edx,0x10(%ebp)
801052d9:	85 c0                	test   %eax,%eax
801052db:	75 e0                	jne    801052bd <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801052dd:	eb 26                	jmp    80105305 <memmove+0x7d>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052df:	eb 17                	jmp    801052f8 <memmove+0x70>
      *d++ = *s++;
801052e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052e4:	8d 50 01             	lea    0x1(%eax),%edx
801052e7:	89 55 f8             	mov    %edx,-0x8(%ebp)
801052ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052ed:	8d 4a 01             	lea    0x1(%edx),%ecx
801052f0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801052f3:	0f b6 12             	movzbl (%edx),%edx
801052f6:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052f8:	8b 45 10             	mov    0x10(%ebp),%eax
801052fb:	8d 50 ff             	lea    -0x1(%eax),%edx
801052fe:	89 55 10             	mov    %edx,0x10(%ebp)
80105301:	85 c0                	test   %eax,%eax
80105303:	75 dc                	jne    801052e1 <memmove+0x59>
      *d++ = *s++;

  return dst;
80105305:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105308:	c9                   	leave  
80105309:	c3                   	ret    

8010530a <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
8010530a:	55                   	push   %ebp
8010530b:	89 e5                	mov    %esp,%ebp
8010530d:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80105310:	8b 45 10             	mov    0x10(%ebp),%eax
80105313:	89 44 24 08          	mov    %eax,0x8(%esp)
80105317:	8b 45 0c             	mov    0xc(%ebp),%eax
8010531a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010531e:	8b 45 08             	mov    0x8(%ebp),%eax
80105321:	89 04 24             	mov    %eax,(%esp)
80105324:	e8 5f ff ff ff       	call   80105288 <memmove>
}
80105329:	c9                   	leave  
8010532a:	c3                   	ret    

8010532b <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
8010532b:	55                   	push   %ebp
8010532c:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010532e:	eb 0c                	jmp    8010533c <strncmp+0x11>
    n--, p++, q++;
80105330:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105334:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105338:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010533c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105340:	74 1a                	je     8010535c <strncmp+0x31>
80105342:	8b 45 08             	mov    0x8(%ebp),%eax
80105345:	0f b6 00             	movzbl (%eax),%eax
80105348:	84 c0                	test   %al,%al
8010534a:	74 10                	je     8010535c <strncmp+0x31>
8010534c:	8b 45 08             	mov    0x8(%ebp),%eax
8010534f:	0f b6 10             	movzbl (%eax),%edx
80105352:	8b 45 0c             	mov    0xc(%ebp),%eax
80105355:	0f b6 00             	movzbl (%eax),%eax
80105358:	38 c2                	cmp    %al,%dl
8010535a:	74 d4                	je     80105330 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
8010535c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105360:	75 07                	jne    80105369 <strncmp+0x3e>
    return 0;
80105362:	b8 00 00 00 00       	mov    $0x0,%eax
80105367:	eb 16                	jmp    8010537f <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80105369:	8b 45 08             	mov    0x8(%ebp),%eax
8010536c:	0f b6 00             	movzbl (%eax),%eax
8010536f:	0f b6 d0             	movzbl %al,%edx
80105372:	8b 45 0c             	mov    0xc(%ebp),%eax
80105375:	0f b6 00             	movzbl (%eax),%eax
80105378:	0f b6 c0             	movzbl %al,%eax
8010537b:	29 c2                	sub    %eax,%edx
8010537d:	89 d0                	mov    %edx,%eax
}
8010537f:	5d                   	pop    %ebp
80105380:	c3                   	ret    

80105381 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105381:	55                   	push   %ebp
80105382:	89 e5                	mov    %esp,%ebp
80105384:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80105387:	8b 45 08             	mov    0x8(%ebp),%eax
8010538a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010538d:	90                   	nop
8010538e:	8b 45 10             	mov    0x10(%ebp),%eax
80105391:	8d 50 ff             	lea    -0x1(%eax),%edx
80105394:	89 55 10             	mov    %edx,0x10(%ebp)
80105397:	85 c0                	test   %eax,%eax
80105399:	7e 1e                	jle    801053b9 <strncpy+0x38>
8010539b:	8b 45 08             	mov    0x8(%ebp),%eax
8010539e:	8d 50 01             	lea    0x1(%eax),%edx
801053a1:	89 55 08             	mov    %edx,0x8(%ebp)
801053a4:	8b 55 0c             	mov    0xc(%ebp),%edx
801053a7:	8d 4a 01             	lea    0x1(%edx),%ecx
801053aa:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801053ad:	0f b6 12             	movzbl (%edx),%edx
801053b0:	88 10                	mov    %dl,(%eax)
801053b2:	0f b6 00             	movzbl (%eax),%eax
801053b5:	84 c0                	test   %al,%al
801053b7:	75 d5                	jne    8010538e <strncpy+0xd>
    ;
  while(n-- > 0)
801053b9:	eb 0c                	jmp    801053c7 <strncpy+0x46>
    *s++ = 0;
801053bb:	8b 45 08             	mov    0x8(%ebp),%eax
801053be:	8d 50 01             	lea    0x1(%eax),%edx
801053c1:	89 55 08             	mov    %edx,0x8(%ebp)
801053c4:	c6 00 00             	movb   $0x0,(%eax)
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801053c7:	8b 45 10             	mov    0x10(%ebp),%eax
801053ca:	8d 50 ff             	lea    -0x1(%eax),%edx
801053cd:	89 55 10             	mov    %edx,0x10(%ebp)
801053d0:	85 c0                	test   %eax,%eax
801053d2:	7f e7                	jg     801053bb <strncpy+0x3a>
    *s++ = 0;
  return os;
801053d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801053d7:	c9                   	leave  
801053d8:	c3                   	ret    

801053d9 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801053d9:	55                   	push   %ebp
801053da:	89 e5                	mov    %esp,%ebp
801053dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
801053df:	8b 45 08             	mov    0x8(%ebp),%eax
801053e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801053e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053e9:	7f 05                	jg     801053f0 <safestrcpy+0x17>
    return os;
801053eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053ee:	eb 31                	jmp    80105421 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
801053f0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801053f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053f8:	7e 1e                	jle    80105418 <safestrcpy+0x3f>
801053fa:	8b 45 08             	mov    0x8(%ebp),%eax
801053fd:	8d 50 01             	lea    0x1(%eax),%edx
80105400:	89 55 08             	mov    %edx,0x8(%ebp)
80105403:	8b 55 0c             	mov    0xc(%ebp),%edx
80105406:	8d 4a 01             	lea    0x1(%edx),%ecx
80105409:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010540c:	0f b6 12             	movzbl (%edx),%edx
8010540f:	88 10                	mov    %dl,(%eax)
80105411:	0f b6 00             	movzbl (%eax),%eax
80105414:	84 c0                	test   %al,%al
80105416:	75 d8                	jne    801053f0 <safestrcpy+0x17>
    ;
  *s = 0;
80105418:	8b 45 08             	mov    0x8(%ebp),%eax
8010541b:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010541e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105421:	c9                   	leave  
80105422:	c3                   	ret    

80105423 <strlen>:

int
strlen(const char *s)
{
80105423:	55                   	push   %ebp
80105424:	89 e5                	mov    %esp,%ebp
80105426:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105429:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105430:	eb 04                	jmp    80105436 <strlen+0x13>
80105432:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105436:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105439:	8b 45 08             	mov    0x8(%ebp),%eax
8010543c:	01 d0                	add    %edx,%eax
8010543e:	0f b6 00             	movzbl (%eax),%eax
80105441:	84 c0                	test   %al,%al
80105443:	75 ed                	jne    80105432 <strlen+0xf>
    ;
  return n;
80105445:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105448:	c9                   	leave  
80105449:	c3                   	ret    

8010544a <swtch>:
8010544a:	8b 44 24 04          	mov    0x4(%esp),%eax
8010544e:	8b 54 24 08          	mov    0x8(%esp),%edx
80105452:	55                   	push   %ebp
80105453:	53                   	push   %ebx
80105454:	56                   	push   %esi
80105455:	57                   	push   %edi
80105456:	89 20                	mov    %esp,(%eax)
80105458:	89 d4                	mov    %edx,%esp
8010545a:	5f                   	pop    %edi
8010545b:	5e                   	pop    %esi
8010545c:	5b                   	pop    %ebx
8010545d:	5d                   	pop    %ebp
8010545e:	c3                   	ret    

8010545f <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
8010545f:	55                   	push   %ebp
80105460:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105462:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105468:	8b 00                	mov    (%eax),%eax
8010546a:	3b 45 08             	cmp    0x8(%ebp),%eax
8010546d:	76 12                	jbe    80105481 <fetchint+0x22>
8010546f:	8b 45 08             	mov    0x8(%ebp),%eax
80105472:	8d 50 04             	lea    0x4(%eax),%edx
80105475:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010547b:	8b 00                	mov    (%eax),%eax
8010547d:	39 c2                	cmp    %eax,%edx
8010547f:	76 07                	jbe    80105488 <fetchint+0x29>
    return -1;
80105481:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105486:	eb 0f                	jmp    80105497 <fetchint+0x38>
  *ip = *(int*)(addr);
80105488:	8b 45 08             	mov    0x8(%ebp),%eax
8010548b:	8b 10                	mov    (%eax),%edx
8010548d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105490:	89 10                	mov    %edx,(%eax)
  return 0;
80105492:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105497:	5d                   	pop    %ebp
80105498:	c3                   	ret    

80105499 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105499:	55                   	push   %ebp
8010549a:	89 e5                	mov    %esp,%ebp
8010549c:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
8010549f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054a5:	8b 00                	mov    (%eax),%eax
801054a7:	3b 45 08             	cmp    0x8(%ebp),%eax
801054aa:	77 07                	ja     801054b3 <fetchstr+0x1a>
    return -1;
801054ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054b1:	eb 46                	jmp    801054f9 <fetchstr+0x60>
  *pp = (char*)addr;
801054b3:	8b 55 08             	mov    0x8(%ebp),%edx
801054b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801054b9:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801054bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054c1:	8b 00                	mov    (%eax),%eax
801054c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801054c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801054c9:	8b 00                	mov    (%eax),%eax
801054cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
801054ce:	eb 1c                	jmp    801054ec <fetchstr+0x53>
    if(*s == 0)
801054d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054d3:	0f b6 00             	movzbl (%eax),%eax
801054d6:	84 c0                	test   %al,%al
801054d8:	75 0e                	jne    801054e8 <fetchstr+0x4f>
      return s - *pp;
801054da:	8b 55 fc             	mov    -0x4(%ebp),%edx
801054dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801054e0:	8b 00                	mov    (%eax),%eax
801054e2:	29 c2                	sub    %eax,%edx
801054e4:	89 d0                	mov    %edx,%eax
801054e6:	eb 11                	jmp    801054f9 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801054e8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801054ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054ef:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801054f2:	72 dc                	jb     801054d0 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801054f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f9:	c9                   	leave  
801054fa:	c3                   	ret    

801054fb <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801054fb:	55                   	push   %ebp
801054fc:	89 e5                	mov    %esp,%ebp
801054fe:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105501:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105507:	8b 40 18             	mov    0x18(%eax),%eax
8010550a:	8b 50 44             	mov    0x44(%eax),%edx
8010550d:	8b 45 08             	mov    0x8(%ebp),%eax
80105510:	c1 e0 02             	shl    $0x2,%eax
80105513:	01 d0                	add    %edx,%eax
80105515:	8d 50 04             	lea    0x4(%eax),%edx
80105518:	8b 45 0c             	mov    0xc(%ebp),%eax
8010551b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010551f:	89 14 24             	mov    %edx,(%esp)
80105522:	e8 38 ff ff ff       	call   8010545f <fetchint>
}
80105527:	c9                   	leave  
80105528:	c3                   	ret    

80105529 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105529:	55                   	push   %ebp
8010552a:	89 e5                	mov    %esp,%ebp
8010552c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(argint(n, &i) < 0)
8010552f:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105532:	89 44 24 04          	mov    %eax,0x4(%esp)
80105536:	8b 45 08             	mov    0x8(%ebp),%eax
80105539:	89 04 24             	mov    %eax,(%esp)
8010553c:	e8 ba ff ff ff       	call   801054fb <argint>
80105541:	85 c0                	test   %eax,%eax
80105543:	79 07                	jns    8010554c <argptr+0x23>
    return -1;
80105545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554a:	eb 3d                	jmp    80105589 <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010554c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010554f:	89 c2                	mov    %eax,%edx
80105551:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105557:	8b 00                	mov    (%eax),%eax
80105559:	39 c2                	cmp    %eax,%edx
8010555b:	73 16                	jae    80105573 <argptr+0x4a>
8010555d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105560:	89 c2                	mov    %eax,%edx
80105562:	8b 45 10             	mov    0x10(%ebp),%eax
80105565:	01 c2                	add    %eax,%edx
80105567:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010556d:	8b 00                	mov    (%eax),%eax
8010556f:	39 c2                	cmp    %eax,%edx
80105571:	76 07                	jbe    8010557a <argptr+0x51>
    return -1;
80105573:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105578:	eb 0f                	jmp    80105589 <argptr+0x60>
  *pp = (char*)i;
8010557a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010557d:	89 c2                	mov    %eax,%edx
8010557f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105582:	89 10                	mov    %edx,(%eax)
  return 0;
80105584:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105589:	c9                   	leave  
8010558a:	c3                   	ret    

8010558b <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010558b:	55                   	push   %ebp
8010558c:	89 e5                	mov    %esp,%ebp
8010558e:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105591:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105594:	89 44 24 04          	mov    %eax,0x4(%esp)
80105598:	8b 45 08             	mov    0x8(%ebp),%eax
8010559b:	89 04 24             	mov    %eax,(%esp)
8010559e:	e8 58 ff ff ff       	call   801054fb <argint>
801055a3:	85 c0                	test   %eax,%eax
801055a5:	79 07                	jns    801055ae <argstr+0x23>
    return -1;
801055a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ac:	eb 12                	jmp    801055c0 <argstr+0x35>
  return fetchstr(addr, pp);
801055ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055b1:	8b 55 0c             	mov    0xc(%ebp),%edx
801055b4:	89 54 24 04          	mov    %edx,0x4(%esp)
801055b8:	89 04 24             	mov    %eax,(%esp)
801055bb:	e8 d9 fe ff ff       	call   80105499 <fetchstr>
}
801055c0:	c9                   	leave  
801055c1:	c3                   	ret    

801055c2 <syscall>:
[SYS_dup2]    sys_dup2,
};

void
syscall(void)
{
801055c2:	55                   	push   %ebp
801055c3:	89 e5                	mov    %esp,%ebp
801055c5:	53                   	push   %ebx
801055c6:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
801055c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055cf:	8b 40 18             	mov    0x18(%eax),%eax
801055d2:	8b 40 1c             	mov    0x1c(%eax),%eax
801055d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801055d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055dc:	7e 30                	jle    8010560e <syscall+0x4c>
801055de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e1:	83 f8 17             	cmp    $0x17,%eax
801055e4:	77 28                	ja     8010560e <syscall+0x4c>
801055e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e9:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801055f0:	85 c0                	test   %eax,%eax
801055f2:	74 1a                	je     8010560e <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801055f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055fa:	8b 58 18             	mov    0x18(%eax),%ebx
801055fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105600:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105607:	ff d0                	call   *%eax
80105609:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010560c:	eb 3d                	jmp    8010564b <syscall+0x89>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010560e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105614:	8d 48 6c             	lea    0x6c(%eax),%ecx
80105617:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010561d:	8b 40 10             	mov    0x10(%eax),%eax
80105620:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105623:	89 54 24 0c          	mov    %edx,0xc(%esp)
80105627:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010562b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010562f:	c7 04 24 ce 89 10 80 	movl   $0x801089ce,(%esp)
80105636:	e8 8d ad ff ff       	call   801003c8 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
8010563b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105641:	8b 40 18             	mov    0x18(%eax),%eax
80105644:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010564b:	83 c4 24             	add    $0x24,%esp
8010564e:	5b                   	pop    %ebx
8010564f:	5d                   	pop    %ebp
80105650:	c3                   	ret    

80105651 <argfd>:
80105651:	55                   	push   %ebp
80105652:	89 e5                	mov    %esp,%ebp
80105654:	83 ec 18             	sub    $0x18,%esp
80105657:	83 ec 08             	sub    $0x8,%esp
8010565a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010565d:	50                   	push   %eax
8010565e:	ff 75 08             	pushl  0x8(%ebp)
80105661:	e8 95 fe ff ff       	call   801054fb <argint>
80105666:	83 c4 10             	add    $0x10,%esp
80105669:	85 c0                	test   %eax,%eax
8010566b:	79 07                	jns    80105674 <argfd+0x23>
8010566d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105672:	eb 50                	jmp    801056c4 <argfd+0x73>
80105674:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105677:	85 c0                	test   %eax,%eax
80105679:	78 21                	js     8010569c <argfd+0x4b>
8010567b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010567e:	83 f8 0f             	cmp    $0xf,%eax
80105681:	7f 19                	jg     8010569c <argfd+0x4b>
80105683:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105689:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010568c:	83 c2 08             	add    $0x8,%edx
8010568f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105693:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105696:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010569a:	75 07                	jne    801056a3 <argfd+0x52>
8010569c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a1:	eb 21                	jmp    801056c4 <argfd+0x73>
801056a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801056a7:	74 08                	je     801056b1 <argfd+0x60>
801056a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801056ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801056af:	89 10                	mov    %edx,(%eax)
801056b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056b5:	74 08                	je     801056bf <argfd+0x6e>
801056b7:	8b 45 10             	mov    0x10(%ebp),%eax
801056ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056bd:	89 10                	mov    %edx,(%eax)
801056bf:	b8 00 00 00 00       	mov    $0x0,%eax
801056c4:	c9                   	leave  
801056c5:	c3                   	ret    

801056c6 <fdalloc>:
801056c6:	55                   	push   %ebp
801056c7:	89 e5                	mov    %esp,%ebp
801056c9:	83 ec 10             	sub    $0x10,%esp
801056cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801056d3:	eb 30                	jmp    80105705 <fdalloc+0x3f>
801056d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056db:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056de:	83 c2 08             	add    $0x8,%edx
801056e1:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801056e5:	85 c0                	test   %eax,%eax
801056e7:	75 18                	jne    80105701 <fdalloc+0x3b>
801056e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056f2:	8d 4a 08             	lea    0x8(%edx),%ecx
801056f5:	8b 55 08             	mov    0x8(%ebp),%edx
801056f8:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
801056fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056ff:	eb 0f                	jmp    80105710 <fdalloc+0x4a>
80105701:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105705:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105709:	7e ca                	jle    801056d5 <fdalloc+0xf>
8010570b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105710:	c9                   	leave  
80105711:	c3                   	ret    

80105712 <sys_dup>:
80105712:	55                   	push   %ebp
80105713:	89 e5                	mov    %esp,%ebp
80105715:	83 ec 18             	sub    $0x18,%esp
80105718:	83 ec 04             	sub    $0x4,%esp
8010571b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010571e:	50                   	push   %eax
8010571f:	6a 00                	push   $0x0
80105721:	6a 00                	push   $0x0
80105723:	e8 29 ff ff ff       	call   80105651 <argfd>
80105728:	83 c4 10             	add    $0x10,%esp
8010572b:	85 c0                	test   %eax,%eax
8010572d:	79 07                	jns    80105736 <sys_dup+0x24>
8010572f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105734:	eb 31                	jmp    80105767 <sys_dup+0x55>
80105736:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105739:	83 ec 0c             	sub    $0xc,%esp
8010573c:	50                   	push   %eax
8010573d:	e8 84 ff ff ff       	call   801056c6 <fdalloc>
80105742:	83 c4 10             	add    $0x10,%esp
80105745:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105748:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010574c:	79 07                	jns    80105755 <sys_dup+0x43>
8010574e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105753:	eb 12                	jmp    80105767 <sys_dup+0x55>
80105755:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105758:	83 ec 0c             	sub    $0xc,%esp
8010575b:	50                   	push   %eax
8010575c:	e8 99 b8 ff ff       	call   80100ffa <filedup>
80105761:	83 c4 10             	add    $0x10,%esp
80105764:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105767:	c9                   	leave  
80105768:	c3                   	ret    

80105769 <sys_read>:
80105769:	55                   	push   %ebp
8010576a:	89 e5                	mov    %esp,%ebp
8010576c:	83 ec 18             	sub    $0x18,%esp
8010576f:	83 ec 04             	sub    $0x4,%esp
80105772:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105775:	50                   	push   %eax
80105776:	6a 00                	push   $0x0
80105778:	6a 00                	push   $0x0
8010577a:	e8 d2 fe ff ff       	call   80105651 <argfd>
8010577f:	83 c4 10             	add    $0x10,%esp
80105782:	85 c0                	test   %eax,%eax
80105784:	78 2e                	js     801057b4 <sys_read+0x4b>
80105786:	83 ec 08             	sub    $0x8,%esp
80105789:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010578c:	50                   	push   %eax
8010578d:	6a 02                	push   $0x2
8010578f:	e8 67 fd ff ff       	call   801054fb <argint>
80105794:	83 c4 10             	add    $0x10,%esp
80105797:	85 c0                	test   %eax,%eax
80105799:	78 19                	js     801057b4 <sys_read+0x4b>
8010579b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010579e:	83 ec 04             	sub    $0x4,%esp
801057a1:	50                   	push   %eax
801057a2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057a5:	50                   	push   %eax
801057a6:	6a 01                	push   $0x1
801057a8:	e8 7c fd ff ff       	call   80105529 <argptr>
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	85 c0                	test   %eax,%eax
801057b2:	79 07                	jns    801057bb <sys_read+0x52>
801057b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057b9:	eb 17                	jmp    801057d2 <sys_read+0x69>
801057bb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801057be:	8b 55 ec             	mov    -0x14(%ebp),%edx
801057c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057c4:	83 ec 04             	sub    $0x4,%esp
801057c7:	51                   	push   %ecx
801057c8:	52                   	push   %edx
801057c9:	50                   	push   %eax
801057ca:	e8 98 b9 ff ff       	call   80101167 <fileread>
801057cf:	83 c4 10             	add    $0x10,%esp
801057d2:	c9                   	leave  
801057d3:	c3                   	ret    

801057d4 <sys_write>:
801057d4:	55                   	push   %ebp
801057d5:	89 e5                	mov    %esp,%ebp
801057d7:	83 ec 18             	sub    $0x18,%esp
801057da:	83 ec 04             	sub    $0x4,%esp
801057dd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057e0:	50                   	push   %eax
801057e1:	6a 00                	push   $0x0
801057e3:	6a 00                	push   $0x0
801057e5:	e8 67 fe ff ff       	call   80105651 <argfd>
801057ea:	83 c4 10             	add    $0x10,%esp
801057ed:	85 c0                	test   %eax,%eax
801057ef:	78 2e                	js     8010581f <sys_write+0x4b>
801057f1:	83 ec 08             	sub    $0x8,%esp
801057f4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057f7:	50                   	push   %eax
801057f8:	6a 02                	push   $0x2
801057fa:	e8 fc fc ff ff       	call   801054fb <argint>
801057ff:	83 c4 10             	add    $0x10,%esp
80105802:	85 c0                	test   %eax,%eax
80105804:	78 19                	js     8010581f <sys_write+0x4b>
80105806:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105809:	83 ec 04             	sub    $0x4,%esp
8010580c:	50                   	push   %eax
8010580d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105810:	50                   	push   %eax
80105811:	6a 01                	push   $0x1
80105813:	e8 11 fd ff ff       	call   80105529 <argptr>
80105818:	83 c4 10             	add    $0x10,%esp
8010581b:	85 c0                	test   %eax,%eax
8010581d:	79 07                	jns    80105826 <sys_write+0x52>
8010581f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105824:	eb 17                	jmp    8010583d <sys_write+0x69>
80105826:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105829:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010582c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010582f:	83 ec 04             	sub    $0x4,%esp
80105832:	51                   	push   %ecx
80105833:	52                   	push   %edx
80105834:	50                   	push   %eax
80105835:	e8 e9 b9 ff ff       	call   80101223 <filewrite>
8010583a:	83 c4 10             	add    $0x10,%esp
8010583d:	c9                   	leave  
8010583e:	c3                   	ret    

8010583f <sys_close>:
8010583f:	55                   	push   %ebp
80105840:	89 e5                	mov    %esp,%ebp
80105842:	83 ec 18             	sub    $0x18,%esp
80105845:	83 ec 04             	sub    $0x4,%esp
80105848:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010584b:	50                   	push   %eax
8010584c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010584f:	50                   	push   %eax
80105850:	6a 00                	push   $0x0
80105852:	e8 fa fd ff ff       	call   80105651 <argfd>
80105857:	83 c4 10             	add    $0x10,%esp
8010585a:	85 c0                	test   %eax,%eax
8010585c:	79 07                	jns    80105865 <sys_close+0x26>
8010585e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105863:	eb 28                	jmp    8010588d <sys_close+0x4e>
80105865:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010586b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010586e:	83 c2 08             	add    $0x8,%edx
80105871:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105878:	00 
80105879:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010587c:	83 ec 0c             	sub    $0xc,%esp
8010587f:	50                   	push   %eax
80105880:	e8 bd b7 ff ff       	call   80101042 <fileclose>
80105885:	83 c4 10             	add    $0x10,%esp
80105888:	b8 00 00 00 00       	mov    $0x0,%eax
8010588d:	c9                   	leave  
8010588e:	c3                   	ret    

8010588f <sys_fstat>:
8010588f:	55                   	push   %ebp
80105890:	89 e5                	mov    %esp,%ebp
80105892:	83 ec 18             	sub    $0x18,%esp
80105895:	83 ec 04             	sub    $0x4,%esp
80105898:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010589b:	50                   	push   %eax
8010589c:	6a 00                	push   $0x0
8010589e:	6a 00                	push   $0x0
801058a0:	e8 ac fd ff ff       	call   80105651 <argfd>
801058a5:	83 c4 10             	add    $0x10,%esp
801058a8:	85 c0                	test   %eax,%eax
801058aa:	78 17                	js     801058c3 <sys_fstat+0x34>
801058ac:	83 ec 04             	sub    $0x4,%esp
801058af:	6a 14                	push   $0x14
801058b1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058b4:	50                   	push   %eax
801058b5:	6a 01                	push   $0x1
801058b7:	e8 6d fc ff ff       	call   80105529 <argptr>
801058bc:	83 c4 10             	add    $0x10,%esp
801058bf:	85 c0                	test   %eax,%eax
801058c1:	79 07                	jns    801058ca <sys_fstat+0x3b>
801058c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c8:	eb 13                	jmp    801058dd <sys_fstat+0x4e>
801058ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
801058cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058d0:	83 ec 08             	sub    $0x8,%esp
801058d3:	52                   	push   %edx
801058d4:	50                   	push   %eax
801058d5:	e8 3e b8 ff ff       	call   80101118 <filestat>
801058da:	83 c4 10             	add    $0x10,%esp
801058dd:	c9                   	leave  
801058de:	c3                   	ret    

801058df <sys_link>:
801058df:	55                   	push   %ebp
801058e0:	89 e5                	mov    %esp,%ebp
801058e2:	83 ec 28             	sub    $0x28,%esp
801058e5:	83 ec 08             	sub    $0x8,%esp
801058e8:	8d 45 d8             	lea    -0x28(%ebp),%eax
801058eb:	50                   	push   %eax
801058ec:	6a 00                	push   $0x0
801058ee:	e8 98 fc ff ff       	call   8010558b <argstr>
801058f3:	83 c4 10             	add    $0x10,%esp
801058f6:	85 c0                	test   %eax,%eax
801058f8:	78 15                	js     8010590f <sys_link+0x30>
801058fa:	83 ec 08             	sub    $0x8,%esp
801058fd:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105900:	50                   	push   %eax
80105901:	6a 01                	push   $0x1
80105903:	e8 83 fc ff ff       	call   8010558b <argstr>
80105908:	83 c4 10             	add    $0x10,%esp
8010590b:	85 c0                	test   %eax,%eax
8010590d:	79 0a                	jns    80105919 <sys_link+0x3a>
8010590f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105914:	e9 68 01 00 00       	jmp    80105a81 <sys_link+0x1a2>
80105919:	e8 1b dc ff ff       	call   80103539 <begin_op>
8010591e:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105921:	83 ec 0c             	sub    $0xc,%esp
80105924:	50                   	push   %eax
80105925:	e8 70 cb ff ff       	call   8010249a <namei>
8010592a:	83 c4 10             	add    $0x10,%esp
8010592d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105930:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105934:	75 0f                	jne    80105945 <sys_link+0x66>
80105936:	e8 82 dc ff ff       	call   801035bd <end_op>
8010593b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105940:	e9 3c 01 00 00       	jmp    80105a81 <sys_link+0x1a2>
80105945:	83 ec 0c             	sub    $0xc,%esp
80105948:	ff 75 f4             	pushl  -0xc(%ebp)
8010594b:	e8 22 c0 ff ff       	call   80101972 <ilock>
80105950:	83 c4 10             	add    $0x10,%esp
80105953:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105956:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010595a:	66 83 f8 01          	cmp    $0x1,%ax
8010595e:	75 1d                	jne    8010597d <sys_link+0x9e>
80105960:	83 ec 0c             	sub    $0xc,%esp
80105963:	ff 75 f4             	pushl  -0xc(%ebp)
80105966:	e8 f6 c1 ff ff       	call   80101b61 <iunlockput>
8010596b:	83 c4 10             	add    $0x10,%esp
8010596e:	e8 4a dc ff ff       	call   801035bd <end_op>
80105973:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105978:	e9 04 01 00 00       	jmp    80105a81 <sys_link+0x1a2>
8010597d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105980:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105984:	83 c0 01             	add    $0x1,%eax
80105987:	89 c2                	mov    %eax,%edx
80105989:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010598c:	66 89 50 56          	mov    %dx,0x56(%eax)
80105990:	83 ec 0c             	sub    $0xc,%esp
80105993:	ff 75 f4             	pushl  -0xc(%ebp)
80105996:	e8 12 be ff ff       	call   801017ad <iupdate>
8010599b:	83 c4 10             	add    $0x10,%esp
8010599e:	83 ec 0c             	sub    $0xc,%esp
801059a1:	ff 75 f4             	pushl  -0xc(%ebp)
801059a4:	e8 e0 c0 ff ff       	call   80101a89 <iunlock>
801059a9:	83 c4 10             	add    $0x10,%esp
801059ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059af:	83 ec 08             	sub    $0x8,%esp
801059b2:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801059b5:	52                   	push   %edx
801059b6:	50                   	push   %eax
801059b7:	e8 00 cb ff ff       	call   801024bc <nameiparent>
801059bc:	83 c4 10             	add    $0x10,%esp
801059bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
801059c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059c6:	74 71                	je     80105a39 <sys_link+0x15a>
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	ff 75 f0             	pushl  -0x10(%ebp)
801059ce:	e8 9f bf ff ff       	call   80101972 <ilock>
801059d3:	83 c4 10             	add    $0x10,%esp
801059d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059d9:	8b 10                	mov    (%eax),%edx
801059db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059de:	8b 00                	mov    (%eax),%eax
801059e0:	39 c2                	cmp    %eax,%edx
801059e2:	75 1d                	jne    80105a01 <sys_link+0x122>
801059e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e7:	8b 40 04             	mov    0x4(%eax),%eax
801059ea:	83 ec 04             	sub    $0x4,%esp
801059ed:	50                   	push   %eax
801059ee:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801059f1:	50                   	push   %eax
801059f2:	ff 75 f0             	pushl  -0x10(%ebp)
801059f5:	e8 e0 c7 ff ff       	call   801021da <dirlink>
801059fa:	83 c4 10             	add    $0x10,%esp
801059fd:	85 c0                	test   %eax,%eax
801059ff:	79 10                	jns    80105a11 <sys_link+0x132>
80105a01:	83 ec 0c             	sub    $0xc,%esp
80105a04:	ff 75 f0             	pushl  -0x10(%ebp)
80105a07:	e8 55 c1 ff ff       	call   80101b61 <iunlockput>
80105a0c:	83 c4 10             	add    $0x10,%esp
80105a0f:	eb 29                	jmp    80105a3a <sys_link+0x15b>
80105a11:	83 ec 0c             	sub    $0xc,%esp
80105a14:	ff 75 f0             	pushl  -0x10(%ebp)
80105a17:	e8 45 c1 ff ff       	call   80101b61 <iunlockput>
80105a1c:	83 c4 10             	add    $0x10,%esp
80105a1f:	83 ec 0c             	sub    $0xc,%esp
80105a22:	ff 75 f4             	pushl  -0xc(%ebp)
80105a25:	e8 a3 c0 ff ff       	call   80101acd <iput>
80105a2a:	83 c4 10             	add    $0x10,%esp
80105a2d:	e8 8b db ff ff       	call   801035bd <end_op>
80105a32:	b8 00 00 00 00       	mov    $0x0,%eax
80105a37:	eb 48                	jmp    80105a81 <sys_link+0x1a2>
80105a39:	90                   	nop
80105a3a:	83 ec 0c             	sub    $0xc,%esp
80105a3d:	ff 75 f4             	pushl  -0xc(%ebp)
80105a40:	e8 2d bf ff ff       	call   80101972 <ilock>
80105a45:	83 c4 10             	add    $0x10,%esp
80105a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a4b:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105a4f:	83 e8 01             	sub    $0x1,%eax
80105a52:	89 c2                	mov    %eax,%edx
80105a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a57:	66 89 50 56          	mov    %dx,0x56(%eax)
80105a5b:	83 ec 0c             	sub    $0xc,%esp
80105a5e:	ff 75 f4             	pushl  -0xc(%ebp)
80105a61:	e8 47 bd ff ff       	call   801017ad <iupdate>
80105a66:	83 c4 10             	add    $0x10,%esp
80105a69:	83 ec 0c             	sub    $0xc,%esp
80105a6c:	ff 75 f4             	pushl  -0xc(%ebp)
80105a6f:	e8 ed c0 ff ff       	call   80101b61 <iunlockput>
80105a74:	83 c4 10             	add    $0x10,%esp
80105a77:	e8 41 db ff ff       	call   801035bd <end_op>
80105a7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a81:	c9                   	leave  
80105a82:	c3                   	ret    

80105a83 <isdirempty>:
80105a83:	55                   	push   %ebp
80105a84:	89 e5                	mov    %esp,%ebp
80105a86:	83 ec 28             	sub    $0x28,%esp
80105a89:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105a90:	eb 40                	jmp    80105ad2 <isdirempty+0x4f>
80105a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a95:	6a 10                	push   $0x10
80105a97:	50                   	push   %eax
80105a98:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a9b:	50                   	push   %eax
80105a9c:	ff 75 08             	pushl  0x8(%ebp)
80105a9f:	e8 58 c3 ff ff       	call   80101dfc <readi>
80105aa4:	83 c4 10             	add    $0x10,%esp
80105aa7:	83 f8 10             	cmp    $0x10,%eax
80105aaa:	74 0d                	je     80105ab9 <isdirempty+0x36>
80105aac:	83 ec 0c             	sub    $0xc,%esp
80105aaf:	68 ea 89 10 80       	push   $0x801089ea
80105ab4:	e8 a9 aa ff ff       	call   80100562 <panic>
80105ab9:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105abd:	66 85 c0             	test   %ax,%ax
80105ac0:	74 07                	je     80105ac9 <isdirempty+0x46>
80105ac2:	b8 00 00 00 00       	mov    $0x0,%eax
80105ac7:	eb 1b                	jmp    80105ae4 <isdirempty+0x61>
80105ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105acc:	83 c0 10             	add    $0x10,%eax
80105acf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ad2:	8b 45 08             	mov    0x8(%ebp),%eax
80105ad5:	8b 50 58             	mov    0x58(%eax),%edx
80105ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105adb:	39 c2                	cmp    %eax,%edx
80105add:	77 b3                	ja     80105a92 <isdirempty+0xf>
80105adf:	b8 01 00 00 00       	mov    $0x1,%eax
80105ae4:	c9                   	leave  
80105ae5:	c3                   	ret    

80105ae6 <sys_unlink>:
80105ae6:	55                   	push   %ebp
80105ae7:	89 e5                	mov    %esp,%ebp
80105ae9:	83 ec 38             	sub    $0x38,%esp
80105aec:	83 ec 08             	sub    $0x8,%esp
80105aef:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105af2:	50                   	push   %eax
80105af3:	6a 00                	push   $0x0
80105af5:	e8 91 fa ff ff       	call   8010558b <argstr>
80105afa:	83 c4 10             	add    $0x10,%esp
80105afd:	85 c0                	test   %eax,%eax
80105aff:	79 0a                	jns    80105b0b <sys_unlink+0x25>
80105b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b06:	e9 bc 01 00 00       	jmp    80105cc7 <sys_unlink+0x1e1>
80105b0b:	e8 29 da ff ff       	call   80103539 <begin_op>
80105b10:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105b13:	83 ec 08             	sub    $0x8,%esp
80105b16:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105b19:	52                   	push   %edx
80105b1a:	50                   	push   %eax
80105b1b:	e8 9c c9 ff ff       	call   801024bc <nameiparent>
80105b20:	83 c4 10             	add    $0x10,%esp
80105b23:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b2a:	75 0f                	jne    80105b3b <sys_unlink+0x55>
80105b2c:	e8 8c da ff ff       	call   801035bd <end_op>
80105b31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b36:	e9 8c 01 00 00       	jmp    80105cc7 <sys_unlink+0x1e1>
80105b3b:	83 ec 0c             	sub    $0xc,%esp
80105b3e:	ff 75 f4             	pushl  -0xc(%ebp)
80105b41:	e8 2c be ff ff       	call   80101972 <ilock>
80105b46:	83 c4 10             	add    $0x10,%esp
80105b49:	83 ec 08             	sub    $0x8,%esp
80105b4c:	68 fc 89 10 80       	push   $0x801089fc
80105b51:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b54:	50                   	push   %eax
80105b55:	e8 95 c5 ff ff       	call   801020ef <namecmp>
80105b5a:	83 c4 10             	add    $0x10,%esp
80105b5d:	85 c0                	test   %eax,%eax
80105b5f:	0f 84 4a 01 00 00    	je     80105caf <sys_unlink+0x1c9>
80105b65:	83 ec 08             	sub    $0x8,%esp
80105b68:	68 fe 89 10 80       	push   $0x801089fe
80105b6d:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b70:	50                   	push   %eax
80105b71:	e8 79 c5 ff ff       	call   801020ef <namecmp>
80105b76:	83 c4 10             	add    $0x10,%esp
80105b79:	85 c0                	test   %eax,%eax
80105b7b:	0f 84 2e 01 00 00    	je     80105caf <sys_unlink+0x1c9>
80105b81:	83 ec 04             	sub    $0x4,%esp
80105b84:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105b87:	50                   	push   %eax
80105b88:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b8b:	50                   	push   %eax
80105b8c:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8f:	e8 7d c5 ff ff       	call   80102111 <dirlookup>
80105b94:	83 c4 10             	add    $0x10,%esp
80105b97:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b9a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b9e:	0f 84 0a 01 00 00    	je     80105cae <sys_unlink+0x1c8>
80105ba4:	83 ec 0c             	sub    $0xc,%esp
80105ba7:	ff 75 f0             	pushl  -0x10(%ebp)
80105baa:	e8 c3 bd ff ff       	call   80101972 <ilock>
80105baf:	83 c4 10             	add    $0x10,%esp
80105bb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bb5:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105bb9:	66 85 c0             	test   %ax,%ax
80105bbc:	7f 0d                	jg     80105bcb <sys_unlink+0xe5>
80105bbe:	83 ec 0c             	sub    $0xc,%esp
80105bc1:	68 01 8a 10 80       	push   $0x80108a01
80105bc6:	e8 97 a9 ff ff       	call   80100562 <panic>
80105bcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bce:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105bd2:	66 83 f8 01          	cmp    $0x1,%ax
80105bd6:	75 25                	jne    80105bfd <sys_unlink+0x117>
80105bd8:	83 ec 0c             	sub    $0xc,%esp
80105bdb:	ff 75 f0             	pushl  -0x10(%ebp)
80105bde:	e8 a0 fe ff ff       	call   80105a83 <isdirempty>
80105be3:	83 c4 10             	add    $0x10,%esp
80105be6:	85 c0                	test   %eax,%eax
80105be8:	75 13                	jne    80105bfd <sys_unlink+0x117>
80105bea:	83 ec 0c             	sub    $0xc,%esp
80105bed:	ff 75 f0             	pushl  -0x10(%ebp)
80105bf0:	e8 6c bf ff ff       	call   80101b61 <iunlockput>
80105bf5:	83 c4 10             	add    $0x10,%esp
80105bf8:	e9 b2 00 00 00       	jmp    80105caf <sys_unlink+0x1c9>
80105bfd:	83 ec 04             	sub    $0x4,%esp
80105c00:	6a 10                	push   $0x10
80105c02:	6a 00                	push   $0x0
80105c04:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c07:	50                   	push   %eax
80105c08:	e8 ac f5 ff ff       	call   801051b9 <memset>
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105c13:	6a 10                	push   $0x10
80105c15:	50                   	push   %eax
80105c16:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c19:	50                   	push   %eax
80105c1a:	ff 75 f4             	pushl  -0xc(%ebp)
80105c1d:	e8 3e c3 ff ff       	call   80101f60 <writei>
80105c22:	83 c4 10             	add    $0x10,%esp
80105c25:	83 f8 10             	cmp    $0x10,%eax
80105c28:	74 0d                	je     80105c37 <sys_unlink+0x151>
80105c2a:	83 ec 0c             	sub    $0xc,%esp
80105c2d:	68 13 8a 10 80       	push   $0x80108a13
80105c32:	e8 2b a9 ff ff       	call   80100562 <panic>
80105c37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c3a:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105c3e:	66 83 f8 01          	cmp    $0x1,%ax
80105c42:	75 21                	jne    80105c65 <sys_unlink+0x17f>
80105c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c47:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105c4b:	83 e8 01             	sub    $0x1,%eax
80105c4e:	89 c2                	mov    %eax,%edx
80105c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c53:	66 89 50 56          	mov    %dx,0x56(%eax)
80105c57:	83 ec 0c             	sub    $0xc,%esp
80105c5a:	ff 75 f4             	pushl  -0xc(%ebp)
80105c5d:	e8 4b bb ff ff       	call   801017ad <iupdate>
80105c62:	83 c4 10             	add    $0x10,%esp
80105c65:	83 ec 0c             	sub    $0xc,%esp
80105c68:	ff 75 f4             	pushl  -0xc(%ebp)
80105c6b:	e8 f1 be ff ff       	call   80101b61 <iunlockput>
80105c70:	83 c4 10             	add    $0x10,%esp
80105c73:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c76:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105c7a:	83 e8 01             	sub    $0x1,%eax
80105c7d:	89 c2                	mov    %eax,%edx
80105c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c82:	66 89 50 56          	mov    %dx,0x56(%eax)
80105c86:	83 ec 0c             	sub    $0xc,%esp
80105c89:	ff 75 f0             	pushl  -0x10(%ebp)
80105c8c:	e8 1c bb ff ff       	call   801017ad <iupdate>
80105c91:	83 c4 10             	add    $0x10,%esp
80105c94:	83 ec 0c             	sub    $0xc,%esp
80105c97:	ff 75 f0             	pushl  -0x10(%ebp)
80105c9a:	e8 c2 be ff ff       	call   80101b61 <iunlockput>
80105c9f:	83 c4 10             	add    $0x10,%esp
80105ca2:	e8 16 d9 ff ff       	call   801035bd <end_op>
80105ca7:	b8 00 00 00 00       	mov    $0x0,%eax
80105cac:	eb 19                	jmp    80105cc7 <sys_unlink+0x1e1>
80105cae:	90                   	nop
80105caf:	83 ec 0c             	sub    $0xc,%esp
80105cb2:	ff 75 f4             	pushl  -0xc(%ebp)
80105cb5:	e8 a7 be ff ff       	call   80101b61 <iunlockput>
80105cba:	83 c4 10             	add    $0x10,%esp
80105cbd:	e8 fb d8 ff ff       	call   801035bd <end_op>
80105cc2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cc7:	c9                   	leave  
80105cc8:	c3                   	ret    

80105cc9 <create>:
80105cc9:	55                   	push   %ebp
80105cca:	89 e5                	mov    %esp,%ebp
80105ccc:	83 ec 38             	sub    $0x38,%esp
80105ccf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105cd2:	8b 55 10             	mov    0x10(%ebp),%edx
80105cd5:	8b 45 14             	mov    0x14(%ebp),%eax
80105cd8:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105cdc:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105ce0:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
80105ce4:	83 ec 08             	sub    $0x8,%esp
80105ce7:	8d 45 de             	lea    -0x22(%ebp),%eax
80105cea:	50                   	push   %eax
80105ceb:	ff 75 08             	pushl  0x8(%ebp)
80105cee:	e8 c9 c7 ff ff       	call   801024bc <nameiparent>
80105cf3:	83 c4 10             	add    $0x10,%esp
80105cf6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105cf9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105cfd:	75 0a                	jne    80105d09 <create+0x40>
80105cff:	b8 00 00 00 00       	mov    $0x0,%eax
80105d04:	e9 90 01 00 00       	jmp    80105e99 <create+0x1d0>
80105d09:	83 ec 0c             	sub    $0xc,%esp
80105d0c:	ff 75 f4             	pushl  -0xc(%ebp)
80105d0f:	e8 5e bc ff ff       	call   80101972 <ilock>
80105d14:	83 c4 10             	add    $0x10,%esp
80105d17:	83 ec 04             	sub    $0x4,%esp
80105d1a:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d1d:	50                   	push   %eax
80105d1e:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d21:	50                   	push   %eax
80105d22:	ff 75 f4             	pushl  -0xc(%ebp)
80105d25:	e8 e7 c3 ff ff       	call   80102111 <dirlookup>
80105d2a:	83 c4 10             	add    $0x10,%esp
80105d2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d30:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d34:	74 50                	je     80105d86 <create+0xbd>
80105d36:	83 ec 0c             	sub    $0xc,%esp
80105d39:	ff 75 f4             	pushl  -0xc(%ebp)
80105d3c:	e8 20 be ff ff       	call   80101b61 <iunlockput>
80105d41:	83 c4 10             	add    $0x10,%esp
80105d44:	83 ec 0c             	sub    $0xc,%esp
80105d47:	ff 75 f0             	pushl  -0x10(%ebp)
80105d4a:	e8 23 bc ff ff       	call   80101972 <ilock>
80105d4f:	83 c4 10             	add    $0x10,%esp
80105d52:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105d57:	75 15                	jne    80105d6e <create+0xa5>
80105d59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d5c:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105d60:	66 83 f8 02          	cmp    $0x2,%ax
80105d64:	75 08                	jne    80105d6e <create+0xa5>
80105d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d69:	e9 2b 01 00 00       	jmp    80105e99 <create+0x1d0>
80105d6e:	83 ec 0c             	sub    $0xc,%esp
80105d71:	ff 75 f0             	pushl  -0x10(%ebp)
80105d74:	e8 e8 bd ff ff       	call   80101b61 <iunlockput>
80105d79:	83 c4 10             	add    $0x10,%esp
80105d7c:	b8 00 00 00 00       	mov    $0x0,%eax
80105d81:	e9 13 01 00 00       	jmp    80105e99 <create+0x1d0>
80105d86:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d8d:	8b 00                	mov    (%eax),%eax
80105d8f:	83 ec 08             	sub    $0x8,%esp
80105d92:	52                   	push   %edx
80105d93:	50                   	push   %eax
80105d94:	e8 3f b9 ff ff       	call   801016d8 <ialloc>
80105d99:	83 c4 10             	add    $0x10,%esp
80105d9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d9f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105da3:	75 0d                	jne    80105db2 <create+0xe9>
80105da5:	83 ec 0c             	sub    $0xc,%esp
80105da8:	68 22 8a 10 80       	push   $0x80108a22
80105dad:	e8 b0 a7 ff ff       	call   80100562 <panic>
80105db2:	83 ec 0c             	sub    $0xc,%esp
80105db5:	ff 75 f0             	pushl  -0x10(%ebp)
80105db8:	e8 b5 bb ff ff       	call   80101972 <ilock>
80105dbd:	83 c4 10             	add    $0x10,%esp
80105dc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dc3:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105dc7:	66 89 50 52          	mov    %dx,0x52(%eax)
80105dcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dce:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105dd2:	66 89 50 54          	mov    %dx,0x54(%eax)
80105dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dd9:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
80105ddf:	83 ec 0c             	sub    $0xc,%esp
80105de2:	ff 75 f0             	pushl  -0x10(%ebp)
80105de5:	e8 c3 b9 ff ff       	call   801017ad <iupdate>
80105dea:	83 c4 10             	add    $0x10,%esp
80105ded:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105df2:	75 6a                	jne    80105e5e <create+0x195>
80105df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df7:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105dfb:	83 c0 01             	add    $0x1,%eax
80105dfe:	89 c2                	mov    %eax,%edx
80105e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e03:	66 89 50 56          	mov    %dx,0x56(%eax)
80105e07:	83 ec 0c             	sub    $0xc,%esp
80105e0a:	ff 75 f4             	pushl  -0xc(%ebp)
80105e0d:	e8 9b b9 ff ff       	call   801017ad <iupdate>
80105e12:	83 c4 10             	add    $0x10,%esp
80105e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e18:	8b 40 04             	mov    0x4(%eax),%eax
80105e1b:	83 ec 04             	sub    $0x4,%esp
80105e1e:	50                   	push   %eax
80105e1f:	68 fc 89 10 80       	push   $0x801089fc
80105e24:	ff 75 f0             	pushl  -0x10(%ebp)
80105e27:	e8 ae c3 ff ff       	call   801021da <dirlink>
80105e2c:	83 c4 10             	add    $0x10,%esp
80105e2f:	85 c0                	test   %eax,%eax
80105e31:	78 1e                	js     80105e51 <create+0x188>
80105e33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e36:	8b 40 04             	mov    0x4(%eax),%eax
80105e39:	83 ec 04             	sub    $0x4,%esp
80105e3c:	50                   	push   %eax
80105e3d:	68 fe 89 10 80       	push   $0x801089fe
80105e42:	ff 75 f0             	pushl  -0x10(%ebp)
80105e45:	e8 90 c3 ff ff       	call   801021da <dirlink>
80105e4a:	83 c4 10             	add    $0x10,%esp
80105e4d:	85 c0                	test   %eax,%eax
80105e4f:	79 0d                	jns    80105e5e <create+0x195>
80105e51:	83 ec 0c             	sub    $0xc,%esp
80105e54:	68 31 8a 10 80       	push   $0x80108a31
80105e59:	e8 04 a7 ff ff       	call   80100562 <panic>
80105e5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e61:	8b 40 04             	mov    0x4(%eax),%eax
80105e64:	83 ec 04             	sub    $0x4,%esp
80105e67:	50                   	push   %eax
80105e68:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e6b:	50                   	push   %eax
80105e6c:	ff 75 f4             	pushl  -0xc(%ebp)
80105e6f:	e8 66 c3 ff ff       	call   801021da <dirlink>
80105e74:	83 c4 10             	add    $0x10,%esp
80105e77:	85 c0                	test   %eax,%eax
80105e79:	79 0d                	jns    80105e88 <create+0x1bf>
80105e7b:	83 ec 0c             	sub    $0xc,%esp
80105e7e:	68 3d 8a 10 80       	push   $0x80108a3d
80105e83:	e8 da a6 ff ff       	call   80100562 <panic>
80105e88:	83 ec 0c             	sub    $0xc,%esp
80105e8b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e8e:	e8 ce bc ff ff       	call   80101b61 <iunlockput>
80105e93:	83 c4 10             	add    $0x10,%esp
80105e96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e99:	c9                   	leave  
80105e9a:	c3                   	ret    

80105e9b <sys_open>:
80105e9b:	55                   	push   %ebp
80105e9c:	89 e5                	mov    %esp,%ebp
80105e9e:	83 ec 28             	sub    $0x28,%esp
80105ea1:	83 ec 08             	sub    $0x8,%esp
80105ea4:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105ea7:	50                   	push   %eax
80105ea8:	6a 00                	push   $0x0
80105eaa:	e8 dc f6 ff ff       	call   8010558b <argstr>
80105eaf:	83 c4 10             	add    $0x10,%esp
80105eb2:	85 c0                	test   %eax,%eax
80105eb4:	78 15                	js     80105ecb <sys_open+0x30>
80105eb6:	83 ec 08             	sub    $0x8,%esp
80105eb9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ebc:	50                   	push   %eax
80105ebd:	6a 01                	push   $0x1
80105ebf:	e8 37 f6 ff ff       	call   801054fb <argint>
80105ec4:	83 c4 10             	add    $0x10,%esp
80105ec7:	85 c0                	test   %eax,%eax
80105ec9:	79 0a                	jns    80105ed5 <sys_open+0x3a>
80105ecb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ed0:	e9 61 01 00 00       	jmp    80106036 <sys_open+0x19b>
80105ed5:	e8 5f d6 ff ff       	call   80103539 <begin_op>
80105eda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105edd:	25 00 02 00 00       	and    $0x200,%eax
80105ee2:	85 c0                	test   %eax,%eax
80105ee4:	74 2a                	je     80105f10 <sys_open+0x75>
80105ee6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ee9:	6a 00                	push   $0x0
80105eeb:	6a 00                	push   $0x0
80105eed:	6a 02                	push   $0x2
80105eef:	50                   	push   %eax
80105ef0:	e8 d4 fd ff ff       	call   80105cc9 <create>
80105ef5:	83 c4 10             	add    $0x10,%esp
80105ef8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105efb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105eff:	75 75                	jne    80105f76 <sys_open+0xdb>
80105f01:	e8 b7 d6 ff ff       	call   801035bd <end_op>
80105f06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f0b:	e9 26 01 00 00       	jmp    80106036 <sys_open+0x19b>
80105f10:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f13:	83 ec 0c             	sub    $0xc,%esp
80105f16:	50                   	push   %eax
80105f17:	e8 7e c5 ff ff       	call   8010249a <namei>
80105f1c:	83 c4 10             	add    $0x10,%esp
80105f1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f26:	75 0f                	jne    80105f37 <sys_open+0x9c>
80105f28:	e8 90 d6 ff ff       	call   801035bd <end_op>
80105f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f32:	e9 ff 00 00 00       	jmp    80106036 <sys_open+0x19b>
80105f37:	83 ec 0c             	sub    $0xc,%esp
80105f3a:	ff 75 f4             	pushl  -0xc(%ebp)
80105f3d:	e8 30 ba ff ff       	call   80101972 <ilock>
80105f42:	83 c4 10             	add    $0x10,%esp
80105f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f48:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105f4c:	66 83 f8 01          	cmp    $0x1,%ax
80105f50:	75 24                	jne    80105f76 <sys_open+0xdb>
80105f52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f55:	85 c0                	test   %eax,%eax
80105f57:	74 1d                	je     80105f76 <sys_open+0xdb>
80105f59:	83 ec 0c             	sub    $0xc,%esp
80105f5c:	ff 75 f4             	pushl  -0xc(%ebp)
80105f5f:	e8 fd bb ff ff       	call   80101b61 <iunlockput>
80105f64:	83 c4 10             	add    $0x10,%esp
80105f67:	e8 51 d6 ff ff       	call   801035bd <end_op>
80105f6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f71:	e9 c0 00 00 00       	jmp    80106036 <sys_open+0x19b>
80105f76:	e8 1f b0 ff ff       	call   80100f9a <filealloc>
80105f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f7e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f82:	74 17                	je     80105f9b <sys_open+0x100>
80105f84:	83 ec 0c             	sub    $0xc,%esp
80105f87:	ff 75 f0             	pushl  -0x10(%ebp)
80105f8a:	e8 37 f7 ff ff       	call   801056c6 <fdalloc>
80105f8f:	83 c4 10             	add    $0x10,%esp
80105f92:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105f95:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105f99:	79 2e                	jns    80105fc9 <sys_open+0x12e>
80105f9b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f9f:	74 0e                	je     80105faf <sys_open+0x114>
80105fa1:	83 ec 0c             	sub    $0xc,%esp
80105fa4:	ff 75 f0             	pushl  -0x10(%ebp)
80105fa7:	e8 96 b0 ff ff       	call   80101042 <fileclose>
80105fac:	83 c4 10             	add    $0x10,%esp
80105faf:	83 ec 0c             	sub    $0xc,%esp
80105fb2:	ff 75 f4             	pushl  -0xc(%ebp)
80105fb5:	e8 a7 bb ff ff       	call   80101b61 <iunlockput>
80105fba:	83 c4 10             	add    $0x10,%esp
80105fbd:	e8 fb d5 ff ff       	call   801035bd <end_op>
80105fc2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fc7:	eb 6d                	jmp    80106036 <sys_open+0x19b>
80105fc9:	83 ec 0c             	sub    $0xc,%esp
80105fcc:	ff 75 f4             	pushl  -0xc(%ebp)
80105fcf:	e8 b5 ba ff ff       	call   80101a89 <iunlock>
80105fd4:	83 c4 10             	add    $0x10,%esp
80105fd7:	e8 e1 d5 ff ff       	call   801035bd <end_op>
80105fdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fdf:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
80105fe5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105feb:	89 50 10             	mov    %edx,0x10(%eax)
80105fee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ff1:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80105ff8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ffb:	83 e0 01             	and    $0x1,%eax
80105ffe:	85 c0                	test   %eax,%eax
80106000:	0f 94 c0             	sete   %al
80106003:	89 c2                	mov    %eax,%edx
80106005:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106008:	88 50 08             	mov    %dl,0x8(%eax)
8010600b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010600e:	83 e0 01             	and    $0x1,%eax
80106011:	85 c0                	test   %eax,%eax
80106013:	75 0a                	jne    8010601f <sys_open+0x184>
80106015:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106018:	83 e0 02             	and    $0x2,%eax
8010601b:	85 c0                	test   %eax,%eax
8010601d:	74 07                	je     80106026 <sys_open+0x18b>
8010601f:	b8 01 00 00 00       	mov    $0x1,%eax
80106024:	eb 05                	jmp    8010602b <sys_open+0x190>
80106026:	b8 00 00 00 00       	mov    $0x0,%eax
8010602b:	89 c2                	mov    %eax,%edx
8010602d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106030:	88 50 09             	mov    %dl,0x9(%eax)
80106033:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106036:	c9                   	leave  
80106037:	c3                   	ret    

80106038 <sys_mkdir>:
80106038:	55                   	push   %ebp
80106039:	89 e5                	mov    %esp,%ebp
8010603b:	83 ec 18             	sub    $0x18,%esp
8010603e:	e8 f6 d4 ff ff       	call   80103539 <begin_op>
80106043:	83 ec 08             	sub    $0x8,%esp
80106046:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106049:	50                   	push   %eax
8010604a:	6a 00                	push   $0x0
8010604c:	e8 3a f5 ff ff       	call   8010558b <argstr>
80106051:	83 c4 10             	add    $0x10,%esp
80106054:	85 c0                	test   %eax,%eax
80106056:	78 1b                	js     80106073 <sys_mkdir+0x3b>
80106058:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010605b:	6a 00                	push   $0x0
8010605d:	6a 00                	push   $0x0
8010605f:	6a 01                	push   $0x1
80106061:	50                   	push   %eax
80106062:	e8 62 fc ff ff       	call   80105cc9 <create>
80106067:	83 c4 10             	add    $0x10,%esp
8010606a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010606d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106071:	75 0c                	jne    8010607f <sys_mkdir+0x47>
80106073:	e8 45 d5 ff ff       	call   801035bd <end_op>
80106078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010607d:	eb 18                	jmp    80106097 <sys_mkdir+0x5f>
8010607f:	83 ec 0c             	sub    $0xc,%esp
80106082:	ff 75 f4             	pushl  -0xc(%ebp)
80106085:	e8 d7 ba ff ff       	call   80101b61 <iunlockput>
8010608a:	83 c4 10             	add    $0x10,%esp
8010608d:	e8 2b d5 ff ff       	call   801035bd <end_op>
80106092:	b8 00 00 00 00       	mov    $0x0,%eax
80106097:	c9                   	leave  
80106098:	c3                   	ret    

80106099 <sys_mknod>:
80106099:	55                   	push   %ebp
8010609a:	89 e5                	mov    %esp,%ebp
8010609c:	83 ec 18             	sub    $0x18,%esp
8010609f:	e8 95 d4 ff ff       	call   80103539 <begin_op>
801060a4:	83 ec 08             	sub    $0x8,%esp
801060a7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060aa:	50                   	push   %eax
801060ab:	6a 00                	push   $0x0
801060ad:	e8 d9 f4 ff ff       	call   8010558b <argstr>
801060b2:	83 c4 10             	add    $0x10,%esp
801060b5:	85 c0                	test   %eax,%eax
801060b7:	78 4f                	js     80106108 <sys_mknod+0x6f>
801060b9:	83 ec 08             	sub    $0x8,%esp
801060bc:	8d 45 ec             	lea    -0x14(%ebp),%eax
801060bf:	50                   	push   %eax
801060c0:	6a 01                	push   $0x1
801060c2:	e8 34 f4 ff ff       	call   801054fb <argint>
801060c7:	83 c4 10             	add    $0x10,%esp
801060ca:	85 c0                	test   %eax,%eax
801060cc:	78 3a                	js     80106108 <sys_mknod+0x6f>
801060ce:	83 ec 08             	sub    $0x8,%esp
801060d1:	8d 45 e8             	lea    -0x18(%ebp),%eax
801060d4:	50                   	push   %eax
801060d5:	6a 02                	push   $0x2
801060d7:	e8 1f f4 ff ff       	call   801054fb <argint>
801060dc:	83 c4 10             	add    $0x10,%esp
801060df:	85 c0                	test   %eax,%eax
801060e1:	78 25                	js     80106108 <sys_mknod+0x6f>
801060e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801060e6:	0f bf c8             	movswl %ax,%ecx
801060e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801060ec:	0f bf d0             	movswl %ax,%edx
801060ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060f2:	51                   	push   %ecx
801060f3:	52                   	push   %edx
801060f4:	6a 03                	push   $0x3
801060f6:	50                   	push   %eax
801060f7:	e8 cd fb ff ff       	call   80105cc9 <create>
801060fc:	83 c4 10             	add    $0x10,%esp
801060ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106102:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106106:	75 0c                	jne    80106114 <sys_mknod+0x7b>
80106108:	e8 b0 d4 ff ff       	call   801035bd <end_op>
8010610d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106112:	eb 18                	jmp    8010612c <sys_mknod+0x93>
80106114:	83 ec 0c             	sub    $0xc,%esp
80106117:	ff 75 f4             	pushl  -0xc(%ebp)
8010611a:	e8 42 ba ff ff       	call   80101b61 <iunlockput>
8010611f:	83 c4 10             	add    $0x10,%esp
80106122:	e8 96 d4 ff ff       	call   801035bd <end_op>
80106127:	b8 00 00 00 00       	mov    $0x0,%eax
8010612c:	c9                   	leave  
8010612d:	c3                   	ret    

8010612e <sys_chdir>:
8010612e:	55                   	push   %ebp
8010612f:	89 e5                	mov    %esp,%ebp
80106131:	83 ec 18             	sub    $0x18,%esp
80106134:	e8 00 d4 ff ff       	call   80103539 <begin_op>
80106139:	83 ec 08             	sub    $0x8,%esp
8010613c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010613f:	50                   	push   %eax
80106140:	6a 00                	push   $0x0
80106142:	e8 44 f4 ff ff       	call   8010558b <argstr>
80106147:	83 c4 10             	add    $0x10,%esp
8010614a:	85 c0                	test   %eax,%eax
8010614c:	78 18                	js     80106166 <sys_chdir+0x38>
8010614e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106151:	83 ec 0c             	sub    $0xc,%esp
80106154:	50                   	push   %eax
80106155:	e8 40 c3 ff ff       	call   8010249a <namei>
8010615a:	83 c4 10             	add    $0x10,%esp
8010615d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106160:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106164:	75 0c                	jne    80106172 <sys_chdir+0x44>
80106166:	e8 52 d4 ff ff       	call   801035bd <end_op>
8010616b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106170:	eb 6e                	jmp    801061e0 <sys_chdir+0xb2>
80106172:	83 ec 0c             	sub    $0xc,%esp
80106175:	ff 75 f4             	pushl  -0xc(%ebp)
80106178:	e8 f5 b7 ff ff       	call   80101972 <ilock>
8010617d:	83 c4 10             	add    $0x10,%esp
80106180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106183:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106187:	66 83 f8 01          	cmp    $0x1,%ax
8010618b:	74 1a                	je     801061a7 <sys_chdir+0x79>
8010618d:	83 ec 0c             	sub    $0xc,%esp
80106190:	ff 75 f4             	pushl  -0xc(%ebp)
80106193:	e8 c9 b9 ff ff       	call   80101b61 <iunlockput>
80106198:	83 c4 10             	add    $0x10,%esp
8010619b:	e8 1d d4 ff ff       	call   801035bd <end_op>
801061a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061a5:	eb 39                	jmp    801061e0 <sys_chdir+0xb2>
801061a7:	83 ec 0c             	sub    $0xc,%esp
801061aa:	ff 75 f4             	pushl  -0xc(%ebp)
801061ad:	e8 d7 b8 ff ff       	call   80101a89 <iunlock>
801061b2:	83 c4 10             	add    $0x10,%esp
801061b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061bb:	8b 40 68             	mov    0x68(%eax),%eax
801061be:	83 ec 0c             	sub    $0xc,%esp
801061c1:	50                   	push   %eax
801061c2:	e8 06 b9 ff ff       	call   80101acd <iput>
801061c7:	83 c4 10             	add    $0x10,%esp
801061ca:	e8 ee d3 ff ff       	call   801035bd <end_op>
801061cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061d8:	89 50 68             	mov    %edx,0x68(%eax)
801061db:	b8 00 00 00 00       	mov    $0x0,%eax
801061e0:	c9                   	leave  
801061e1:	c3                   	ret    

801061e2 <sys_exec>:
801061e2:	55                   	push   %ebp
801061e3:	89 e5                	mov    %esp,%ebp
801061e5:	81 ec 98 00 00 00    	sub    $0x98,%esp
801061eb:	83 ec 08             	sub    $0x8,%esp
801061ee:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061f1:	50                   	push   %eax
801061f2:	6a 00                	push   $0x0
801061f4:	e8 92 f3 ff ff       	call   8010558b <argstr>
801061f9:	83 c4 10             	add    $0x10,%esp
801061fc:	85 c0                	test   %eax,%eax
801061fe:	78 18                	js     80106218 <sys_exec+0x36>
80106200:	83 ec 08             	sub    $0x8,%esp
80106203:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106209:	50                   	push   %eax
8010620a:	6a 01                	push   $0x1
8010620c:	e8 ea f2 ff ff       	call   801054fb <argint>
80106211:	83 c4 10             	add    $0x10,%esp
80106214:	85 c0                	test   %eax,%eax
80106216:	79 0a                	jns    80106222 <sys_exec+0x40>
80106218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010621d:	e9 c6 00 00 00       	jmp    801062e8 <sys_exec+0x106>
80106222:	83 ec 04             	sub    $0x4,%esp
80106225:	68 80 00 00 00       	push   $0x80
8010622a:	6a 00                	push   $0x0
8010622c:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106232:	50                   	push   %eax
80106233:	e8 81 ef ff ff       	call   801051b9 <memset>
80106238:	83 c4 10             	add    $0x10,%esp
8010623b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106242:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106245:	83 f8 1f             	cmp    $0x1f,%eax
80106248:	76 0a                	jbe    80106254 <sys_exec+0x72>
8010624a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010624f:	e9 94 00 00 00       	jmp    801062e8 <sys_exec+0x106>
80106254:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106257:	c1 e0 02             	shl    $0x2,%eax
8010625a:	89 c2                	mov    %eax,%edx
8010625c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106262:	01 c2                	add    %eax,%edx
80106264:	83 ec 08             	sub    $0x8,%esp
80106267:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010626d:	50                   	push   %eax
8010626e:	52                   	push   %edx
8010626f:	e8 eb f1 ff ff       	call   8010545f <fetchint>
80106274:	83 c4 10             	add    $0x10,%esp
80106277:	85 c0                	test   %eax,%eax
80106279:	79 07                	jns    80106282 <sys_exec+0xa0>
8010627b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106280:	eb 66                	jmp    801062e8 <sys_exec+0x106>
80106282:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106288:	85 c0                	test   %eax,%eax
8010628a:	75 27                	jne    801062b3 <sys_exec+0xd1>
8010628c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010628f:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106296:	00 00 00 00 
8010629a:	90                   	nop
8010629b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010629e:	83 ec 08             	sub    $0x8,%esp
801062a1:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801062a7:	52                   	push   %edx
801062a8:	50                   	push   %eax
801062a9:	e8 84 a8 ff ff       	call   80100b32 <exec>
801062ae:	83 c4 10             	add    $0x10,%esp
801062b1:	eb 35                	jmp    801062e8 <sys_exec+0x106>
801062b3:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801062b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062bc:	c1 e2 02             	shl    $0x2,%edx
801062bf:	01 c2                	add    %eax,%edx
801062c1:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801062c7:	83 ec 08             	sub    $0x8,%esp
801062ca:	52                   	push   %edx
801062cb:	50                   	push   %eax
801062cc:	e8 c8 f1 ff ff       	call   80105499 <fetchstr>
801062d1:	83 c4 10             	add    $0x10,%esp
801062d4:	85 c0                	test   %eax,%eax
801062d6:	79 07                	jns    801062df <sys_exec+0xfd>
801062d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062dd:	eb 09                	jmp    801062e8 <sys_exec+0x106>
801062df:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801062e3:	e9 5a ff ff ff       	jmp    80106242 <sys_exec+0x60>
801062e8:	c9                   	leave  
801062e9:	c3                   	ret    

801062ea <sys_pipe>:
801062ea:	55                   	push   %ebp
801062eb:	89 e5                	mov    %esp,%ebp
801062ed:	83 ec 28             	sub    $0x28,%esp
801062f0:	83 ec 04             	sub    $0x4,%esp
801062f3:	6a 08                	push   $0x8
801062f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
801062f8:	50                   	push   %eax
801062f9:	6a 00                	push   $0x0
801062fb:	e8 29 f2 ff ff       	call   80105529 <argptr>
80106300:	83 c4 10             	add    $0x10,%esp
80106303:	85 c0                	test   %eax,%eax
80106305:	79 0a                	jns    80106311 <sys_pipe+0x27>
80106307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010630c:	e9 af 00 00 00       	jmp    801063c0 <sys_pipe+0xd6>
80106311:	83 ec 08             	sub    $0x8,%esp
80106314:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106317:	50                   	push   %eax
80106318:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010631b:	50                   	push   %eax
8010631c:	e8 37 dc ff ff       	call   80103f58 <pipealloc>
80106321:	83 c4 10             	add    $0x10,%esp
80106324:	85 c0                	test   %eax,%eax
80106326:	79 0a                	jns    80106332 <sys_pipe+0x48>
80106328:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010632d:	e9 8e 00 00 00       	jmp    801063c0 <sys_pipe+0xd6>
80106332:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
80106339:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010633c:	83 ec 0c             	sub    $0xc,%esp
8010633f:	50                   	push   %eax
80106340:	e8 81 f3 ff ff       	call   801056c6 <fdalloc>
80106345:	83 c4 10             	add    $0x10,%esp
80106348:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010634b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010634f:	78 18                	js     80106369 <sys_pipe+0x7f>
80106351:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106354:	83 ec 0c             	sub    $0xc,%esp
80106357:	50                   	push   %eax
80106358:	e8 69 f3 ff ff       	call   801056c6 <fdalloc>
8010635d:	83 c4 10             	add    $0x10,%esp
80106360:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106363:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106367:	79 3f                	jns    801063a8 <sys_pipe+0xbe>
80106369:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010636d:	78 14                	js     80106383 <sys_pipe+0x99>
8010636f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106375:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106378:	83 c2 08             	add    $0x8,%edx
8010637b:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106382:	00 
80106383:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106386:	83 ec 0c             	sub    $0xc,%esp
80106389:	50                   	push   %eax
8010638a:	e8 b3 ac ff ff       	call   80101042 <fileclose>
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106395:	83 ec 0c             	sub    $0xc,%esp
80106398:	50                   	push   %eax
80106399:	e8 a4 ac ff ff       	call   80101042 <fileclose>
8010639e:	83 c4 10             	add    $0x10,%esp
801063a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063a6:	eb 18                	jmp    801063c0 <sys_pipe+0xd6>
801063a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063ae:	89 10                	mov    %edx,(%eax)
801063b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063b3:	8d 50 04             	lea    0x4(%eax),%edx
801063b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063b9:	89 02                	mov    %eax,(%edx)
801063bb:	b8 00 00 00 00       	mov    $0x0,%eax
801063c0:	c9                   	leave  
801063c1:	c3                   	ret    

801063c2 <sys_dup2>:
801063c2:	55                   	push   %ebp
801063c3:	89 e5                	mov    %esp,%ebp
801063c5:	53                   	push   %ebx
801063c6:	83 ec 14             	sub    $0x14,%esp
801063c9:	83 ec 04             	sub    $0x4,%esp
801063cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063cf:	50                   	push   %eax
801063d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063d3:	50                   	push   %eax
801063d4:	6a 00                	push   $0x0
801063d6:	e8 76 f2 ff ff       	call   80105651 <argfd>
801063db:	83 c4 10             	add    $0x10,%esp
801063de:	85 c0                	test   %eax,%eax
801063e0:	79 0a                	jns    801063ec <sys_dup2+0x2a>
801063e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063e7:	e9 a7 00 00 00       	jmp    80106493 <sys_dup2+0xd1>
801063ec:	83 ec 08             	sub    $0x8,%esp
801063ef:	8d 45 ec             	lea    -0x14(%ebp),%eax
801063f2:	50                   	push   %eax
801063f3:	6a 01                	push   $0x1
801063f5:	e8 01 f1 ff ff       	call   801054fb <argint>
801063fa:	83 c4 10             	add    $0x10,%esp
801063fd:	85 c0                	test   %eax,%eax
801063ff:	79 0a                	jns    8010640b <sys_dup2+0x49>
80106401:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106406:	e9 88 00 00 00       	jmp    80106493 <sys_dup2+0xd1>
8010640b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010640e:	85 c0                	test   %eax,%eax
80106410:	78 08                	js     8010641a <sys_dup2+0x58>
80106412:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106415:	83 f8 0f             	cmp    $0xf,%eax
80106418:	7e 07                	jle    80106421 <sys_dup2+0x5f>
8010641a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010641f:	eb 72                	jmp    80106493 <sys_dup2+0xd1>
80106421:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106424:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106427:	39 c2                	cmp    %eax,%edx
80106429:	75 05                	jne    80106430 <sys_dup2+0x6e>
8010642b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010642e:	eb 63                	jmp    80106493 <sys_dup2+0xd1>
80106430:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106436:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106439:	83 c2 08             	add    $0x8,%edx
8010643c:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106440:	85 c0                	test   %eax,%eax
80106442:	74 1c                	je     80106460 <sys_dup2+0x9e>
80106444:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010644a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010644d:	83 c2 08             	add    $0x8,%edx
80106450:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106454:	83 ec 0c             	sub    $0xc,%esp
80106457:	50                   	push   %eax
80106458:	e8 e5 ab ff ff       	call   80101042 <fileclose>
8010645d:	83 c4 10             	add    $0x10,%esp
80106460:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106466:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80106469:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80106470:	8b 5d f0             	mov    -0x10(%ebp),%ebx
80106473:	83 c3 08             	add    $0x8,%ebx
80106476:	8b 54 9a 08          	mov    0x8(%edx,%ebx,4),%edx
8010647a:	83 c1 08             	add    $0x8,%ecx
8010647d:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
80106481:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106484:	83 ec 0c             	sub    $0xc,%esp
80106487:	50                   	push   %eax
80106488:	e8 6d ab ff ff       	call   80100ffa <filedup>
8010648d:	83 c4 10             	add    $0x10,%esp
80106490:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106493:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106496:	c9                   	leave  
80106497:	c3                   	ret    

80106498 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106498:	55                   	push   %ebp
80106499:	89 e5                	mov    %esp,%ebp
8010649b:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010649e:	e8 78 e1 ff ff       	call   8010461b <fork>
}
801064a3:	c9                   	leave  
801064a4:	c3                   	ret    

801064a5 <sys_exit>:

int
sys_exit(void)
{
801064a5:	55                   	push   %ebp
801064a6:	89 e5                	mov    %esp,%ebp
801064a8:	83 ec 08             	sub    $0x8,%esp
  exit();
801064ab:	e8 e6 e2 ff ff       	call   80104796 <exit>
  return 0;  // not reached
801064b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801064b5:	c9                   	leave  
801064b6:	c3                   	ret    

801064b7 <sys_wait>:

int
sys_wait(void)
{
801064b7:	55                   	push   %ebp
801064b8:	89 e5                	mov    %esp,%ebp
801064ba:	83 ec 08             	sub    $0x8,%esp
  return wait();
801064bd:	e8 f6 e3 ff ff       	call   801048b8 <wait>
}
801064c2:	c9                   	leave  
801064c3:	c3                   	ret    

801064c4 <sys_kill>:

int
sys_kill(void)
{
801064c4:	55                   	push   %ebp
801064c5:	89 e5                	mov    %esp,%ebp
801064c7:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801064ca:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064cd:	89 44 24 04          	mov    %eax,0x4(%esp)
801064d1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064d8:	e8 1e f0 ff ff       	call   801054fb <argint>
801064dd:	85 c0                	test   %eax,%eax
801064df:	79 07                	jns    801064e8 <sys_kill+0x24>
    return -1;
801064e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064e6:	eb 0b                	jmp    801064f3 <sys_kill+0x2f>
  return kill(pid);
801064e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064eb:	89 04 24             	mov    %eax,(%esp)
801064ee:	e8 90 e7 ff ff       	call   80104c83 <kill>
}
801064f3:	c9                   	leave  
801064f4:	c3                   	ret    

801064f5 <sys_getpid>:

int
sys_getpid(void)
{
801064f5:	55                   	push   %ebp
801064f6:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801064f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064fe:	8b 40 10             	mov    0x10(%eax),%eax
}
80106501:	5d                   	pop    %ebp
80106502:	c3                   	ret    

80106503 <sys_sbrk>:

int
sys_sbrk(void)
{
80106503:	55                   	push   %ebp
80106504:	89 e5                	mov    %esp,%ebp
80106506:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106509:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010650c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106510:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106517:	e8 df ef ff ff       	call   801054fb <argint>
8010651c:	85 c0                	test   %eax,%eax
8010651e:	79 07                	jns    80106527 <sys_sbrk+0x24>
    return -1;
80106520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106525:	eb 24                	jmp    8010654b <sys_sbrk+0x48>
  addr = proc->sz;
80106527:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010652d:	8b 00                	mov    (%eax),%eax
8010652f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106532:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106535:	89 04 24             	mov    %eax,(%esp)
80106538:	e8 39 e0 ff ff       	call   80104576 <growproc>
8010653d:	85 c0                	test   %eax,%eax
8010653f:	79 07                	jns    80106548 <sys_sbrk+0x45>
    return -1;
80106541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106546:	eb 03                	jmp    8010654b <sys_sbrk+0x48>
  return addr;
80106548:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010654b:	c9                   	leave  
8010654c:	c3                   	ret    

8010654d <sys_sleep>:

int
sys_sleep(void)
{
8010654d:	55                   	push   %ebp
8010654e:	89 e5                	mov    %esp,%ebp
80106550:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106553:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106556:	89 44 24 04          	mov    %eax,0x4(%esp)
8010655a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106561:	e8 95 ef ff ff       	call   801054fb <argint>
80106566:	85 c0                	test   %eax,%eax
80106568:	79 07                	jns    80106571 <sys_sleep+0x24>
    return -1;
8010656a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010656f:	eb 6c                	jmp    801065dd <sys_sleep+0x90>
  acquire(&tickslock);
80106571:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80106578:	e8 d3 e9 ff ff       	call   80104f50 <acquire>
  ticks0 = ticks;
8010657d:	a1 a0 65 11 80       	mov    0x801165a0,%eax
80106582:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106585:	eb 34                	jmp    801065bb <sys_sleep+0x6e>
    if(proc->killed){
80106587:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010658d:	8b 40 24             	mov    0x24(%eax),%eax
80106590:	85 c0                	test   %eax,%eax
80106592:	74 13                	je     801065a7 <sys_sleep+0x5a>
      release(&tickslock);
80106594:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
8010659b:	e8 17 ea ff ff       	call   80104fb7 <release>
      return -1;
801065a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a5:	eb 36                	jmp    801065dd <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
801065a7:	c7 44 24 04 60 5d 11 	movl   $0x80115d60,0x4(%esp)
801065ae:	80 
801065af:	c7 04 24 a0 65 11 80 	movl   $0x801165a0,(%esp)
801065b6:	e8 c4 e5 ff ff       	call   80104b7f <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801065bb:	a1 a0 65 11 80       	mov    0x801165a0,%eax
801065c0:	2b 45 f4             	sub    -0xc(%ebp),%eax
801065c3:	89 c2                	mov    %eax,%edx
801065c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065c8:	39 c2                	cmp    %eax,%edx
801065ca:	72 bb                	jb     80106587 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801065cc:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
801065d3:	e8 df e9 ff ff       	call   80104fb7 <release>
  return 0;
801065d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065dd:	c9                   	leave  
801065de:	c3                   	ret    

801065df <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801065df:	55                   	push   %ebp
801065e0:	89 e5                	mov    %esp,%ebp
801065e2:	83 ec 28             	sub    $0x28,%esp
  uint xticks;

  acquire(&tickslock);
801065e5:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
801065ec:	e8 5f e9 ff ff       	call   80104f50 <acquire>
  xticks = ticks;
801065f1:	a1 a0 65 11 80       	mov    0x801165a0,%eax
801065f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801065f9:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80106600:	e8 b2 e9 ff ff       	call   80104fb7 <release>
  return xticks;
80106605:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106608:	c9                   	leave  
80106609:	c3                   	ret    

8010660a <sys_date>:

// Return current UTC time
int
sys_date(void)
{
8010660a:	55                   	push   %ebp
8010660b:	89 e5                	mov    %esp,%ebp
8010660d:	83 ec 28             	sub    $0x28,%esp
  struct rtcdate *date;
  if(argptr(0,(void *)&date,sizeof(struct rtcdat *))<0)
80106610:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80106617:	00 
80106618:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010661b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010661f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106626:	e8 fe ee ff ff       	call   80105529 <argptr>
8010662b:	85 c0                	test   %eax,%eax
8010662d:	79 07                	jns    80106636 <sys_date+0x2c>
  {
	return -1;
8010662f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106634:	eb 10                	jmp    80106646 <sys_date+0x3c>
  }
  cmostime(date);
80106636:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106639:	89 04 24             	mov    %eax,(%esp)
8010663c:	e8 92 cb ff ff       	call   801031d3 <cmostime>
  return 0;
80106641:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106646:	c9                   	leave  
80106647:	c3                   	ret    

80106648 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106648:	55                   	push   %ebp
80106649:	89 e5                	mov    %esp,%ebp
8010664b:	83 ec 08             	sub    $0x8,%esp
8010664e:	8b 55 08             	mov    0x8(%ebp),%edx
80106651:	8b 45 0c             	mov    0xc(%ebp),%eax
80106654:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106658:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010665b:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010665f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106663:	ee                   	out    %al,(%dx)
}
80106664:	c9                   	leave  
80106665:	c3                   	ret    

80106666 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106666:	55                   	push   %ebp
80106667:	89 e5                	mov    %esp,%ebp
80106669:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
8010666c:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
80106673:	00 
80106674:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
8010667b:	e8 c8 ff ff ff       	call   80106648 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106680:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
80106687:	00 
80106688:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
8010668f:	e8 b4 ff ff ff       	call   80106648 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106694:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
8010669b:	00 
8010669c:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801066a3:	e8 a0 ff ff ff       	call   80106648 <outb>
  picenable(IRQ_TIMER);
801066a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066af:	e8 37 d7 ff ff       	call   80103deb <picenable>
}
801066b4:	c9                   	leave  
801066b5:	c3                   	ret    

801066b6 <alltraps>:
801066b6:	1e                   	push   %ds
801066b7:	06                   	push   %es
801066b8:	0f a0                	push   %fs
801066ba:	0f a8                	push   %gs
801066bc:	60                   	pusha  
801066bd:	66 b8 10 00          	mov    $0x10,%ax
801066c1:	8e d8                	mov    %eax,%ds
801066c3:	8e c0                	mov    %eax,%es
801066c5:	66 b8 18 00          	mov    $0x18,%ax
801066c9:	8e e0                	mov    %eax,%fs
801066cb:	8e e8                	mov    %eax,%gs
801066cd:	54                   	push   %esp
801066ce:	e8 d8 01 00 00       	call   801068ab <trap>
801066d3:	83 c4 04             	add    $0x4,%esp

801066d6 <trapret>:
801066d6:	61                   	popa   
801066d7:	0f a9                	pop    %gs
801066d9:	0f a1                	pop    %fs
801066db:	07                   	pop    %es
801066dc:	1f                   	pop    %ds
801066dd:	83 c4 08             	add    $0x8,%esp
801066e0:	cf                   	iret   

801066e1 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801066e1:	55                   	push   %ebp
801066e2:	89 e5                	mov    %esp,%ebp
801066e4:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801066e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801066ea:	83 e8 01             	sub    $0x1,%eax
801066ed:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801066f1:	8b 45 08             	mov    0x8(%ebp),%eax
801066f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801066f8:	8b 45 08             	mov    0x8(%ebp),%eax
801066fb:	c1 e8 10             	shr    $0x10,%eax
801066fe:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106702:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106705:	0f 01 18             	lidtl  (%eax)
}
80106708:	c9                   	leave  
80106709:	c3                   	ret    

8010670a <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
8010670a:	55                   	push   %ebp
8010670b:	89 e5                	mov    %esp,%ebp
8010670d:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106710:	0f 20 d0             	mov    %cr2,%eax
80106713:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106716:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106719:	c9                   	leave  
8010671a:	c3                   	ret    

8010671b <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010671b:	55                   	push   %ebp
8010671c:	89 e5                	mov    %esp,%ebp
8010671e:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
80106721:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106728:	e9 c3 00 00 00       	jmp    801067f0 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010672d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106730:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
80106737:	89 c2                	mov    %eax,%edx
80106739:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010673c:	66 89 14 c5 a0 5d 11 	mov    %dx,-0x7feea260(,%eax,8)
80106743:	80 
80106744:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106747:	66 c7 04 c5 a2 5d 11 	movw   $0x8,-0x7feea25e(,%eax,8)
8010674e:	80 08 00 
80106751:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106754:	0f b6 14 c5 a4 5d 11 	movzbl -0x7feea25c(,%eax,8),%edx
8010675b:	80 
8010675c:	83 e2 e0             	and    $0xffffffe0,%edx
8010675f:	88 14 c5 a4 5d 11 80 	mov    %dl,-0x7feea25c(,%eax,8)
80106766:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106769:	0f b6 14 c5 a4 5d 11 	movzbl -0x7feea25c(,%eax,8),%edx
80106770:	80 
80106771:	83 e2 1f             	and    $0x1f,%edx
80106774:	88 14 c5 a4 5d 11 80 	mov    %dl,-0x7feea25c(,%eax,8)
8010677b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010677e:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
80106785:	80 
80106786:	83 e2 f0             	and    $0xfffffff0,%edx
80106789:	83 ca 0e             	or     $0xe,%edx
8010678c:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
80106793:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106796:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
8010679d:	80 
8010679e:	83 e2 ef             	and    $0xffffffef,%edx
801067a1:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
801067a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067ab:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
801067b2:	80 
801067b3:	83 e2 9f             	and    $0xffffff9f,%edx
801067b6:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
801067bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067c0:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
801067c7:	80 
801067c8:	83 ca 80             	or     $0xffffff80,%edx
801067cb:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
801067d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067d5:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
801067dc:	c1 e8 10             	shr    $0x10,%eax
801067df:	89 c2                	mov    %eax,%edx
801067e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067e4:	66 89 14 c5 a6 5d 11 	mov    %dx,-0x7feea25a(,%eax,8)
801067eb:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801067ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801067f0:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801067f7:	0f 8e 30 ff ff ff    	jle    8010672d <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801067fd:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
80106802:	66 a3 a0 5f 11 80    	mov    %ax,0x80115fa0
80106808:	66 c7 05 a2 5f 11 80 	movw   $0x8,0x80115fa2
8010680f:	08 00 
80106811:	0f b6 05 a4 5f 11 80 	movzbl 0x80115fa4,%eax
80106818:	83 e0 e0             	and    $0xffffffe0,%eax
8010681b:	a2 a4 5f 11 80       	mov    %al,0x80115fa4
80106820:	0f b6 05 a4 5f 11 80 	movzbl 0x80115fa4,%eax
80106827:	83 e0 1f             	and    $0x1f,%eax
8010682a:	a2 a4 5f 11 80       	mov    %al,0x80115fa4
8010682f:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
80106836:	83 c8 0f             	or     $0xf,%eax
80106839:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
8010683e:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
80106845:	83 e0 ef             	and    $0xffffffef,%eax
80106848:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
8010684d:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
80106854:	83 c8 60             	or     $0x60,%eax
80106857:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
8010685c:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
80106863:	83 c8 80             	or     $0xffffff80,%eax
80106866:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
8010686b:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
80106870:	c1 e8 10             	shr    $0x10,%eax
80106873:	66 a3 a6 5f 11 80    	mov    %ax,0x80115fa6

  initlock(&tickslock, "time");
80106879:	c7 44 24 04 50 8a 10 	movl   $0x80108a50,0x4(%esp)
80106880:	80 
80106881:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80106888:	e8 a2 e6 ff ff       	call   80104f2f <initlock>
}
8010688d:	c9                   	leave  
8010688e:	c3                   	ret    

8010688f <idtinit>:

void
idtinit(void)
{
8010688f:	55                   	push   %ebp
80106890:	89 e5                	mov    %esp,%ebp
80106892:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
80106895:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
8010689c:	00 
8010689d:	c7 04 24 a0 5d 11 80 	movl   $0x80115da0,(%esp)
801068a4:	e8 38 fe ff ff       	call   801066e1 <lidt>
}
801068a9:	c9                   	leave  
801068aa:	c3                   	ret    

801068ab <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801068ab:	55                   	push   %ebp
801068ac:	89 e5                	mov    %esp,%ebp
801068ae:	57                   	push   %edi
801068af:	56                   	push   %esi
801068b0:	53                   	push   %ebx
801068b1:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
801068b4:	8b 45 08             	mov    0x8(%ebp),%eax
801068b7:	8b 40 30             	mov    0x30(%eax),%eax
801068ba:	83 f8 40             	cmp    $0x40,%eax
801068bd:	75 3f                	jne    801068fe <trap+0x53>
    if(proc->killed)
801068bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068c5:	8b 40 24             	mov    0x24(%eax),%eax
801068c8:	85 c0                	test   %eax,%eax
801068ca:	74 05                	je     801068d1 <trap+0x26>
      exit();
801068cc:	e8 c5 de ff ff       	call   80104796 <exit>
    proc->tf = tf;
801068d1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068d7:	8b 55 08             	mov    0x8(%ebp),%edx
801068da:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801068dd:	e8 e0 ec ff ff       	call   801055c2 <syscall>
    if(proc->killed)
801068e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068e8:	8b 40 24             	mov    0x24(%eax),%eax
801068eb:	85 c0                	test   %eax,%eax
801068ed:	74 0a                	je     801068f9 <trap+0x4e>
      exit();
801068ef:	e8 a2 de ff ff       	call   80104796 <exit>
    return;
801068f4:	e9 17 02 00 00       	jmp    80106b10 <trap+0x265>
801068f9:	e9 12 02 00 00       	jmp    80106b10 <trap+0x265>
  }

  switch(tf->trapno){
801068fe:	8b 45 08             	mov    0x8(%ebp),%eax
80106901:	8b 40 30             	mov    0x30(%eax),%eax
80106904:	83 e8 20             	sub    $0x20,%eax
80106907:	83 f8 1f             	cmp    $0x1f,%eax
8010690a:	0f 87 b1 00 00 00    	ja     801069c1 <trap+0x116>
80106910:	8b 04 85 f8 8a 10 80 	mov    -0x7fef7508(,%eax,4),%eax
80106917:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80106919:	e8 49 c6 ff ff       	call   80102f67 <cpunum>
8010691e:	85 c0                	test   %eax,%eax
80106920:	75 31                	jne    80106953 <trap+0xa8>
      acquire(&tickslock);
80106922:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80106929:	e8 22 e6 ff ff       	call   80104f50 <acquire>
      ticks++;
8010692e:	a1 a0 65 11 80       	mov    0x801165a0,%eax
80106933:	83 c0 01             	add    $0x1,%eax
80106936:	a3 a0 65 11 80       	mov    %eax,0x801165a0
      wakeup(&ticks);
8010693b:	c7 04 24 a0 65 11 80 	movl   $0x801165a0,(%esp)
80106942:	e8 11 e3 ff ff       	call   80104c58 <wakeup>
      release(&tickslock);
80106947:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
8010694e:	e8 64 e6 ff ff       	call   80104fb7 <release>
    }
    lapiceoi();
80106953:	e8 ab c6 ff ff       	call   80103003 <lapiceoi>
    break;
80106958:	e9 2f 01 00 00       	jmp    80106a8c <trap+0x1e1>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
8010695d:	e8 75 be ff ff       	call   801027d7 <ideintr>
    lapiceoi();
80106962:	e8 9c c6 ff ff       	call   80103003 <lapiceoi>
    break;
80106967:	e9 20 01 00 00       	jmp    80106a8c <trap+0x1e1>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
8010696c:	e8 1d c4 ff ff       	call   80102d8e <kbdintr>
    lapiceoi();
80106971:	e8 8d c6 ff ff       	call   80103003 <lapiceoi>
    break;
80106976:	e9 11 01 00 00       	jmp    80106a8c <trap+0x1e1>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
8010697b:	e8 85 03 00 00       	call   80106d05 <uartintr>
    lapiceoi();
80106980:	e8 7e c6 ff ff       	call   80103003 <lapiceoi>
    break;
80106985:	e9 02 01 00 00       	jmp    80106a8c <trap+0x1e1>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010698a:	8b 45 08             	mov    0x8(%ebp),%eax
8010698d:	8b 70 38             	mov    0x38(%eax),%esi
            cpunum(), tf->cs, tf->eip);
80106990:	8b 45 08             	mov    0x8(%ebp),%eax
80106993:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106997:	0f b7 d8             	movzwl %ax,%ebx
8010699a:	e8 c8 c5 ff ff       	call   80102f67 <cpunum>
8010699f:	89 74 24 0c          	mov    %esi,0xc(%esp)
801069a3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801069a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801069ab:	c7 04 24 58 8a 10 80 	movl   $0x80108a58,(%esp)
801069b2:	e8 11 9a ff ff       	call   801003c8 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
801069b7:	e8 47 c6 ff ff       	call   80103003 <lapiceoi>
    break;
801069bc:	e9 cb 00 00 00       	jmp    80106a8c <trap+0x1e1>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801069c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069c7:	85 c0                	test   %eax,%eax
801069c9:	74 11                	je     801069dc <trap+0x131>
801069cb:	8b 45 08             	mov    0x8(%ebp),%eax
801069ce:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801069d2:	0f b7 c0             	movzwl %ax,%eax
801069d5:	83 e0 03             	and    $0x3,%eax
801069d8:	85 c0                	test   %eax,%eax
801069da:	75 40                	jne    80106a1c <trap+0x171>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801069dc:	e8 29 fd ff ff       	call   8010670a <rcr2>
801069e1:	89 c3                	mov    %eax,%ebx
801069e3:	8b 45 08             	mov    0x8(%ebp),%eax
801069e6:	8b 70 38             	mov    0x38(%eax),%esi
801069e9:	e8 79 c5 ff ff       	call   80102f67 <cpunum>
801069ee:	8b 55 08             	mov    0x8(%ebp),%edx
801069f1:	8b 52 30             	mov    0x30(%edx),%edx
801069f4:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801069f8:	89 74 24 0c          	mov    %esi,0xc(%esp)
801069fc:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a00:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a04:	c7 04 24 7c 8a 10 80 	movl   $0x80108a7c,(%esp)
80106a0b:	e8 b8 99 ff ff       	call   801003c8 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80106a10:	c7 04 24 ae 8a 10 80 	movl   $0x80108aae,(%esp)
80106a17:	e8 46 9b ff ff       	call   80100562 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a1c:	e8 e9 fc ff ff       	call   8010670a <rcr2>
80106a21:	89 c3                	mov    %eax,%ebx
80106a23:	8b 45 08             	mov    0x8(%ebp),%eax
80106a26:	8b 78 38             	mov    0x38(%eax),%edi
80106a29:	e8 39 c5 ff ff       	call   80102f67 <cpunum>
80106a2e:	89 c2                	mov    %eax,%edx
80106a30:	8b 45 08             	mov    0x8(%ebp),%eax
80106a33:	8b 70 34             	mov    0x34(%eax),%esi
80106a36:	8b 45 08             	mov    0x8(%ebp),%eax
80106a39:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80106a3c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a42:	83 c0 6c             	add    $0x6c,%eax
80106a45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a4e:	8b 40 10             	mov    0x10(%eax),%eax
80106a51:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
80106a55:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106a59:	89 54 24 14          	mov    %edx,0x14(%esp)
80106a5d:	89 74 24 10          	mov    %esi,0x10(%esp)
80106a61:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106a65:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a68:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106a6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a70:	c7 04 24 b4 8a 10 80 	movl   $0x80108ab4,(%esp)
80106a77:	e8 4c 99 ff ff       	call   801003c8 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80106a7c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a82:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106a89:	eb 01                	jmp    80106a8c <trap+0x1e1>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106a8b:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106a8c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a92:	85 c0                	test   %eax,%eax
80106a94:	74 24                	je     80106aba <trap+0x20f>
80106a96:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a9c:	8b 40 24             	mov    0x24(%eax),%eax
80106a9f:	85 c0                	test   %eax,%eax
80106aa1:	74 17                	je     80106aba <trap+0x20f>
80106aa3:	8b 45 08             	mov    0x8(%ebp),%eax
80106aa6:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106aaa:	0f b7 c0             	movzwl %ax,%eax
80106aad:	83 e0 03             	and    $0x3,%eax
80106ab0:	83 f8 03             	cmp    $0x3,%eax
80106ab3:	75 05                	jne    80106aba <trap+0x20f>
    exit();
80106ab5:	e8 dc dc ff ff       	call   80104796 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106aba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ac0:	85 c0                	test   %eax,%eax
80106ac2:	74 1e                	je     80106ae2 <trap+0x237>
80106ac4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aca:	8b 40 0c             	mov    0xc(%eax),%eax
80106acd:	83 f8 04             	cmp    $0x4,%eax
80106ad0:	75 10                	jne    80106ae2 <trap+0x237>
80106ad2:	8b 45 08             	mov    0x8(%ebp),%eax
80106ad5:	8b 40 30             	mov    0x30(%eax),%eax
80106ad8:	83 f8 20             	cmp    $0x20,%eax
80106adb:	75 05                	jne    80106ae2 <trap+0x237>
    yield();
80106add:	e8 2c e0 ff ff       	call   80104b0e <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106ae2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ae8:	85 c0                	test   %eax,%eax
80106aea:	74 24                	je     80106b10 <trap+0x265>
80106aec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106af2:	8b 40 24             	mov    0x24(%eax),%eax
80106af5:	85 c0                	test   %eax,%eax
80106af7:	74 17                	je     80106b10 <trap+0x265>
80106af9:	8b 45 08             	mov    0x8(%ebp),%eax
80106afc:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b00:	0f b7 c0             	movzwl %ax,%eax
80106b03:	83 e0 03             	and    $0x3,%eax
80106b06:	83 f8 03             	cmp    $0x3,%eax
80106b09:	75 05                	jne    80106b10 <trap+0x265>
    exit();
80106b0b:	e8 86 dc ff ff       	call   80104796 <exit>
}
80106b10:	83 c4 3c             	add    $0x3c,%esp
80106b13:	5b                   	pop    %ebx
80106b14:	5e                   	pop    %esi
80106b15:	5f                   	pop    %edi
80106b16:	5d                   	pop    %ebp
80106b17:	c3                   	ret    

80106b18 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106b18:	55                   	push   %ebp
80106b19:	89 e5                	mov    %esp,%ebp
80106b1b:	83 ec 14             	sub    $0x14,%esp
80106b1e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b21:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b25:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106b29:	89 c2                	mov    %eax,%edx
80106b2b:	ec                   	in     (%dx),%al
80106b2c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106b2f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106b33:	c9                   	leave  
80106b34:	c3                   	ret    

80106b35 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106b35:	55                   	push   %ebp
80106b36:	89 e5                	mov    %esp,%ebp
80106b38:	83 ec 08             	sub    $0x8,%esp
80106b3b:	8b 55 08             	mov    0x8(%ebp),%edx
80106b3e:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b41:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106b45:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b48:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106b4c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106b50:	ee                   	out    %al,(%dx)
}
80106b51:	c9                   	leave  
80106b52:	c3                   	ret    

80106b53 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106b53:	55                   	push   %ebp
80106b54:	89 e5                	mov    %esp,%ebp
80106b56:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106b59:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b60:	00 
80106b61:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106b68:	e8 c8 ff ff ff       	call   80106b35 <outb>

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106b6d:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
80106b74:	00 
80106b75:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106b7c:	e8 b4 ff ff ff       	call   80106b35 <outb>
  outb(COM1+0, 115200/9600);
80106b81:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80106b88:	00 
80106b89:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106b90:	e8 a0 ff ff ff       	call   80106b35 <outb>
  outb(COM1+1, 0);
80106b95:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b9c:	00 
80106b9d:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106ba4:	e8 8c ff ff ff       	call   80106b35 <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106ba9:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106bb0:	00 
80106bb1:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106bb8:	e8 78 ff ff ff       	call   80106b35 <outb>
  outb(COM1+4, 0);
80106bbd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106bc4:	00 
80106bc5:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106bcc:	e8 64 ff ff ff       	call   80106b35 <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106bd1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106bd8:	00 
80106bd9:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106be0:	e8 50 ff ff ff       	call   80106b35 <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106be5:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106bec:	e8 27 ff ff ff       	call   80106b18 <inb>
80106bf1:	3c ff                	cmp    $0xff,%al
80106bf3:	75 02                	jne    80106bf7 <uartinit+0xa4>
    return;
80106bf5:	eb 6a                	jmp    80106c61 <uartinit+0x10e>
  uart = 1;
80106bf7:	c7 05 48 b6 10 80 01 	movl   $0x1,0x8010b648
80106bfe:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106c01:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106c08:	e8 0b ff ff ff       	call   80106b18 <inb>
  inb(COM1+0);
80106c0d:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106c14:	e8 ff fe ff ff       	call   80106b18 <inb>
  picenable(IRQ_COM1);
80106c19:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106c20:	e8 c6 d1 ff ff       	call   80103deb <picenable>
  ioapicenable(IRQ_COM1, 0);
80106c25:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c2c:	00 
80106c2d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106c34:	e8 23 be ff ff       	call   80102a5c <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c39:	c7 45 f4 78 8b 10 80 	movl   $0x80108b78,-0xc(%ebp)
80106c40:	eb 15                	jmp    80106c57 <uartinit+0x104>
    uartputc(*p);
80106c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c45:	0f b6 00             	movzbl (%eax),%eax
80106c48:	0f be c0             	movsbl %al,%eax
80106c4b:	89 04 24             	mov    %eax,(%esp)
80106c4e:	e8 10 00 00 00       	call   80106c63 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c53:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c5a:	0f b6 00             	movzbl (%eax),%eax
80106c5d:	84 c0                	test   %al,%al
80106c5f:	75 e1                	jne    80106c42 <uartinit+0xef>
    uartputc(*p);
}
80106c61:	c9                   	leave  
80106c62:	c3                   	ret    

80106c63 <uartputc>:

void
uartputc(int c)
{
80106c63:	55                   	push   %ebp
80106c64:	89 e5                	mov    %esp,%ebp
80106c66:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80106c69:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80106c6e:	85 c0                	test   %eax,%eax
80106c70:	75 02                	jne    80106c74 <uartputc+0x11>
    return;
80106c72:	eb 4b                	jmp    80106cbf <uartputc+0x5c>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106c7b:	eb 10                	jmp    80106c8d <uartputc+0x2a>
    microdelay(10);
80106c7d:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106c84:	e8 9f c3 ff ff       	call   80103028 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c89:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c8d:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106c91:	7f 16                	jg     80106ca9 <uartputc+0x46>
80106c93:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106c9a:	e8 79 fe ff ff       	call   80106b18 <inb>
80106c9f:	0f b6 c0             	movzbl %al,%eax
80106ca2:	83 e0 20             	and    $0x20,%eax
80106ca5:	85 c0                	test   %eax,%eax
80106ca7:	74 d4                	je     80106c7d <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106ca9:	8b 45 08             	mov    0x8(%ebp),%eax
80106cac:	0f b6 c0             	movzbl %al,%eax
80106caf:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cb3:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106cba:	e8 76 fe ff ff       	call   80106b35 <outb>
}
80106cbf:	c9                   	leave  
80106cc0:	c3                   	ret    

80106cc1 <uartgetc>:

static int
uartgetc(void)
{
80106cc1:	55                   	push   %ebp
80106cc2:	89 e5                	mov    %esp,%ebp
80106cc4:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80106cc7:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80106ccc:	85 c0                	test   %eax,%eax
80106cce:	75 07                	jne    80106cd7 <uartgetc+0x16>
    return -1;
80106cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cd5:	eb 2c                	jmp    80106d03 <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80106cd7:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106cde:	e8 35 fe ff ff       	call   80106b18 <inb>
80106ce3:	0f b6 c0             	movzbl %al,%eax
80106ce6:	83 e0 01             	and    $0x1,%eax
80106ce9:	85 c0                	test   %eax,%eax
80106ceb:	75 07                	jne    80106cf4 <uartgetc+0x33>
    return -1;
80106ced:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cf2:	eb 0f                	jmp    80106d03 <uartgetc+0x42>
  return inb(COM1+0);
80106cf4:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106cfb:	e8 18 fe ff ff       	call   80106b18 <inb>
80106d00:	0f b6 c0             	movzbl %al,%eax
}
80106d03:	c9                   	leave  
80106d04:	c3                   	ret    

80106d05 <uartintr>:

void
uartintr(void)
{
80106d05:	55                   	push   %ebp
80106d06:	89 e5                	mov    %esp,%ebp
80106d08:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106d0b:	c7 04 24 c1 6c 10 80 	movl   $0x80106cc1,(%esp)
80106d12:	e8 d9 9a ff ff       	call   801007f0 <consoleintr>
}
80106d17:	c9                   	leave  
80106d18:	c3                   	ret    

80106d19 <vector0>:
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 00                	push   $0x0
80106d1d:	e9 94 f9 ff ff       	jmp    801066b6 <alltraps>

80106d22 <vector1>:
80106d22:	6a 00                	push   $0x0
80106d24:	6a 01                	push   $0x1
80106d26:	e9 8b f9 ff ff       	jmp    801066b6 <alltraps>

80106d2b <vector2>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	6a 02                	push   $0x2
80106d2f:	e9 82 f9 ff ff       	jmp    801066b6 <alltraps>

80106d34 <vector3>:
80106d34:	6a 00                	push   $0x0
80106d36:	6a 03                	push   $0x3
80106d38:	e9 79 f9 ff ff       	jmp    801066b6 <alltraps>

80106d3d <vector4>:
80106d3d:	6a 00                	push   $0x0
80106d3f:	6a 04                	push   $0x4
80106d41:	e9 70 f9 ff ff       	jmp    801066b6 <alltraps>

80106d46 <vector5>:
80106d46:	6a 00                	push   $0x0
80106d48:	6a 05                	push   $0x5
80106d4a:	e9 67 f9 ff ff       	jmp    801066b6 <alltraps>

80106d4f <vector6>:
80106d4f:	6a 00                	push   $0x0
80106d51:	6a 06                	push   $0x6
80106d53:	e9 5e f9 ff ff       	jmp    801066b6 <alltraps>

80106d58 <vector7>:
80106d58:	6a 00                	push   $0x0
80106d5a:	6a 07                	push   $0x7
80106d5c:	e9 55 f9 ff ff       	jmp    801066b6 <alltraps>

80106d61 <vector8>:
80106d61:	6a 08                	push   $0x8
80106d63:	e9 4e f9 ff ff       	jmp    801066b6 <alltraps>

80106d68 <vector9>:
80106d68:	6a 00                	push   $0x0
80106d6a:	6a 09                	push   $0x9
80106d6c:	e9 45 f9 ff ff       	jmp    801066b6 <alltraps>

80106d71 <vector10>:
80106d71:	6a 0a                	push   $0xa
80106d73:	e9 3e f9 ff ff       	jmp    801066b6 <alltraps>

80106d78 <vector11>:
80106d78:	6a 0b                	push   $0xb
80106d7a:	e9 37 f9 ff ff       	jmp    801066b6 <alltraps>

80106d7f <vector12>:
80106d7f:	6a 0c                	push   $0xc
80106d81:	e9 30 f9 ff ff       	jmp    801066b6 <alltraps>

80106d86 <vector13>:
80106d86:	6a 0d                	push   $0xd
80106d88:	e9 29 f9 ff ff       	jmp    801066b6 <alltraps>

80106d8d <vector14>:
80106d8d:	6a 0e                	push   $0xe
80106d8f:	e9 22 f9 ff ff       	jmp    801066b6 <alltraps>

80106d94 <vector15>:
80106d94:	6a 00                	push   $0x0
80106d96:	6a 0f                	push   $0xf
80106d98:	e9 19 f9 ff ff       	jmp    801066b6 <alltraps>

80106d9d <vector16>:
80106d9d:	6a 00                	push   $0x0
80106d9f:	6a 10                	push   $0x10
80106da1:	e9 10 f9 ff ff       	jmp    801066b6 <alltraps>

80106da6 <vector17>:
80106da6:	6a 11                	push   $0x11
80106da8:	e9 09 f9 ff ff       	jmp    801066b6 <alltraps>

80106dad <vector18>:
80106dad:	6a 00                	push   $0x0
80106daf:	6a 12                	push   $0x12
80106db1:	e9 00 f9 ff ff       	jmp    801066b6 <alltraps>

80106db6 <vector19>:
80106db6:	6a 00                	push   $0x0
80106db8:	6a 13                	push   $0x13
80106dba:	e9 f7 f8 ff ff       	jmp    801066b6 <alltraps>

80106dbf <vector20>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	6a 14                	push   $0x14
80106dc3:	e9 ee f8 ff ff       	jmp    801066b6 <alltraps>

80106dc8 <vector21>:
80106dc8:	6a 00                	push   $0x0
80106dca:	6a 15                	push   $0x15
80106dcc:	e9 e5 f8 ff ff       	jmp    801066b6 <alltraps>

80106dd1 <vector22>:
80106dd1:	6a 00                	push   $0x0
80106dd3:	6a 16                	push   $0x16
80106dd5:	e9 dc f8 ff ff       	jmp    801066b6 <alltraps>

80106dda <vector23>:
80106dda:	6a 00                	push   $0x0
80106ddc:	6a 17                	push   $0x17
80106dde:	e9 d3 f8 ff ff       	jmp    801066b6 <alltraps>

80106de3 <vector24>:
80106de3:	6a 00                	push   $0x0
80106de5:	6a 18                	push   $0x18
80106de7:	e9 ca f8 ff ff       	jmp    801066b6 <alltraps>

80106dec <vector25>:
80106dec:	6a 00                	push   $0x0
80106dee:	6a 19                	push   $0x19
80106df0:	e9 c1 f8 ff ff       	jmp    801066b6 <alltraps>

80106df5 <vector26>:
80106df5:	6a 00                	push   $0x0
80106df7:	6a 1a                	push   $0x1a
80106df9:	e9 b8 f8 ff ff       	jmp    801066b6 <alltraps>

80106dfe <vector27>:
80106dfe:	6a 00                	push   $0x0
80106e00:	6a 1b                	push   $0x1b
80106e02:	e9 af f8 ff ff       	jmp    801066b6 <alltraps>

80106e07 <vector28>:
80106e07:	6a 00                	push   $0x0
80106e09:	6a 1c                	push   $0x1c
80106e0b:	e9 a6 f8 ff ff       	jmp    801066b6 <alltraps>

80106e10 <vector29>:
80106e10:	6a 00                	push   $0x0
80106e12:	6a 1d                	push   $0x1d
80106e14:	e9 9d f8 ff ff       	jmp    801066b6 <alltraps>

80106e19 <vector30>:
80106e19:	6a 00                	push   $0x0
80106e1b:	6a 1e                	push   $0x1e
80106e1d:	e9 94 f8 ff ff       	jmp    801066b6 <alltraps>

80106e22 <vector31>:
80106e22:	6a 00                	push   $0x0
80106e24:	6a 1f                	push   $0x1f
80106e26:	e9 8b f8 ff ff       	jmp    801066b6 <alltraps>

80106e2b <vector32>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	6a 20                	push   $0x20
80106e2f:	e9 82 f8 ff ff       	jmp    801066b6 <alltraps>

80106e34 <vector33>:
80106e34:	6a 00                	push   $0x0
80106e36:	6a 21                	push   $0x21
80106e38:	e9 79 f8 ff ff       	jmp    801066b6 <alltraps>

80106e3d <vector34>:
80106e3d:	6a 00                	push   $0x0
80106e3f:	6a 22                	push   $0x22
80106e41:	e9 70 f8 ff ff       	jmp    801066b6 <alltraps>

80106e46 <vector35>:
80106e46:	6a 00                	push   $0x0
80106e48:	6a 23                	push   $0x23
80106e4a:	e9 67 f8 ff ff       	jmp    801066b6 <alltraps>

80106e4f <vector36>:
80106e4f:	6a 00                	push   $0x0
80106e51:	6a 24                	push   $0x24
80106e53:	e9 5e f8 ff ff       	jmp    801066b6 <alltraps>

80106e58 <vector37>:
80106e58:	6a 00                	push   $0x0
80106e5a:	6a 25                	push   $0x25
80106e5c:	e9 55 f8 ff ff       	jmp    801066b6 <alltraps>

80106e61 <vector38>:
80106e61:	6a 00                	push   $0x0
80106e63:	6a 26                	push   $0x26
80106e65:	e9 4c f8 ff ff       	jmp    801066b6 <alltraps>

80106e6a <vector39>:
80106e6a:	6a 00                	push   $0x0
80106e6c:	6a 27                	push   $0x27
80106e6e:	e9 43 f8 ff ff       	jmp    801066b6 <alltraps>

80106e73 <vector40>:
80106e73:	6a 00                	push   $0x0
80106e75:	6a 28                	push   $0x28
80106e77:	e9 3a f8 ff ff       	jmp    801066b6 <alltraps>

80106e7c <vector41>:
80106e7c:	6a 00                	push   $0x0
80106e7e:	6a 29                	push   $0x29
80106e80:	e9 31 f8 ff ff       	jmp    801066b6 <alltraps>

80106e85 <vector42>:
80106e85:	6a 00                	push   $0x0
80106e87:	6a 2a                	push   $0x2a
80106e89:	e9 28 f8 ff ff       	jmp    801066b6 <alltraps>

80106e8e <vector43>:
80106e8e:	6a 00                	push   $0x0
80106e90:	6a 2b                	push   $0x2b
80106e92:	e9 1f f8 ff ff       	jmp    801066b6 <alltraps>

80106e97 <vector44>:
80106e97:	6a 00                	push   $0x0
80106e99:	6a 2c                	push   $0x2c
80106e9b:	e9 16 f8 ff ff       	jmp    801066b6 <alltraps>

80106ea0 <vector45>:
80106ea0:	6a 00                	push   $0x0
80106ea2:	6a 2d                	push   $0x2d
80106ea4:	e9 0d f8 ff ff       	jmp    801066b6 <alltraps>

80106ea9 <vector46>:
80106ea9:	6a 00                	push   $0x0
80106eab:	6a 2e                	push   $0x2e
80106ead:	e9 04 f8 ff ff       	jmp    801066b6 <alltraps>

80106eb2 <vector47>:
80106eb2:	6a 00                	push   $0x0
80106eb4:	6a 2f                	push   $0x2f
80106eb6:	e9 fb f7 ff ff       	jmp    801066b6 <alltraps>

80106ebb <vector48>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	6a 30                	push   $0x30
80106ebf:	e9 f2 f7 ff ff       	jmp    801066b6 <alltraps>

80106ec4 <vector49>:
80106ec4:	6a 00                	push   $0x0
80106ec6:	6a 31                	push   $0x31
80106ec8:	e9 e9 f7 ff ff       	jmp    801066b6 <alltraps>

80106ecd <vector50>:
80106ecd:	6a 00                	push   $0x0
80106ecf:	6a 32                	push   $0x32
80106ed1:	e9 e0 f7 ff ff       	jmp    801066b6 <alltraps>

80106ed6 <vector51>:
80106ed6:	6a 00                	push   $0x0
80106ed8:	6a 33                	push   $0x33
80106eda:	e9 d7 f7 ff ff       	jmp    801066b6 <alltraps>

80106edf <vector52>:
80106edf:	6a 00                	push   $0x0
80106ee1:	6a 34                	push   $0x34
80106ee3:	e9 ce f7 ff ff       	jmp    801066b6 <alltraps>

80106ee8 <vector53>:
80106ee8:	6a 00                	push   $0x0
80106eea:	6a 35                	push   $0x35
80106eec:	e9 c5 f7 ff ff       	jmp    801066b6 <alltraps>

80106ef1 <vector54>:
80106ef1:	6a 00                	push   $0x0
80106ef3:	6a 36                	push   $0x36
80106ef5:	e9 bc f7 ff ff       	jmp    801066b6 <alltraps>

80106efa <vector55>:
80106efa:	6a 00                	push   $0x0
80106efc:	6a 37                	push   $0x37
80106efe:	e9 b3 f7 ff ff       	jmp    801066b6 <alltraps>

80106f03 <vector56>:
80106f03:	6a 00                	push   $0x0
80106f05:	6a 38                	push   $0x38
80106f07:	e9 aa f7 ff ff       	jmp    801066b6 <alltraps>

80106f0c <vector57>:
80106f0c:	6a 00                	push   $0x0
80106f0e:	6a 39                	push   $0x39
80106f10:	e9 a1 f7 ff ff       	jmp    801066b6 <alltraps>

80106f15 <vector58>:
80106f15:	6a 00                	push   $0x0
80106f17:	6a 3a                	push   $0x3a
80106f19:	e9 98 f7 ff ff       	jmp    801066b6 <alltraps>

80106f1e <vector59>:
80106f1e:	6a 00                	push   $0x0
80106f20:	6a 3b                	push   $0x3b
80106f22:	e9 8f f7 ff ff       	jmp    801066b6 <alltraps>

80106f27 <vector60>:
80106f27:	6a 00                	push   $0x0
80106f29:	6a 3c                	push   $0x3c
80106f2b:	e9 86 f7 ff ff       	jmp    801066b6 <alltraps>

80106f30 <vector61>:
80106f30:	6a 00                	push   $0x0
80106f32:	6a 3d                	push   $0x3d
80106f34:	e9 7d f7 ff ff       	jmp    801066b6 <alltraps>

80106f39 <vector62>:
80106f39:	6a 00                	push   $0x0
80106f3b:	6a 3e                	push   $0x3e
80106f3d:	e9 74 f7 ff ff       	jmp    801066b6 <alltraps>

80106f42 <vector63>:
80106f42:	6a 00                	push   $0x0
80106f44:	6a 3f                	push   $0x3f
80106f46:	e9 6b f7 ff ff       	jmp    801066b6 <alltraps>

80106f4b <vector64>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	6a 40                	push   $0x40
80106f4f:	e9 62 f7 ff ff       	jmp    801066b6 <alltraps>

80106f54 <vector65>:
80106f54:	6a 00                	push   $0x0
80106f56:	6a 41                	push   $0x41
80106f58:	e9 59 f7 ff ff       	jmp    801066b6 <alltraps>

80106f5d <vector66>:
80106f5d:	6a 00                	push   $0x0
80106f5f:	6a 42                	push   $0x42
80106f61:	e9 50 f7 ff ff       	jmp    801066b6 <alltraps>

80106f66 <vector67>:
80106f66:	6a 00                	push   $0x0
80106f68:	6a 43                	push   $0x43
80106f6a:	e9 47 f7 ff ff       	jmp    801066b6 <alltraps>

80106f6f <vector68>:
80106f6f:	6a 00                	push   $0x0
80106f71:	6a 44                	push   $0x44
80106f73:	e9 3e f7 ff ff       	jmp    801066b6 <alltraps>

80106f78 <vector69>:
80106f78:	6a 00                	push   $0x0
80106f7a:	6a 45                	push   $0x45
80106f7c:	e9 35 f7 ff ff       	jmp    801066b6 <alltraps>

80106f81 <vector70>:
80106f81:	6a 00                	push   $0x0
80106f83:	6a 46                	push   $0x46
80106f85:	e9 2c f7 ff ff       	jmp    801066b6 <alltraps>

80106f8a <vector71>:
80106f8a:	6a 00                	push   $0x0
80106f8c:	6a 47                	push   $0x47
80106f8e:	e9 23 f7 ff ff       	jmp    801066b6 <alltraps>

80106f93 <vector72>:
80106f93:	6a 00                	push   $0x0
80106f95:	6a 48                	push   $0x48
80106f97:	e9 1a f7 ff ff       	jmp    801066b6 <alltraps>

80106f9c <vector73>:
80106f9c:	6a 00                	push   $0x0
80106f9e:	6a 49                	push   $0x49
80106fa0:	e9 11 f7 ff ff       	jmp    801066b6 <alltraps>

80106fa5 <vector74>:
80106fa5:	6a 00                	push   $0x0
80106fa7:	6a 4a                	push   $0x4a
80106fa9:	e9 08 f7 ff ff       	jmp    801066b6 <alltraps>

80106fae <vector75>:
80106fae:	6a 00                	push   $0x0
80106fb0:	6a 4b                	push   $0x4b
80106fb2:	e9 ff f6 ff ff       	jmp    801066b6 <alltraps>

80106fb7 <vector76>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	6a 4c                	push   $0x4c
80106fbb:	e9 f6 f6 ff ff       	jmp    801066b6 <alltraps>

80106fc0 <vector77>:
80106fc0:	6a 00                	push   $0x0
80106fc2:	6a 4d                	push   $0x4d
80106fc4:	e9 ed f6 ff ff       	jmp    801066b6 <alltraps>

80106fc9 <vector78>:
80106fc9:	6a 00                	push   $0x0
80106fcb:	6a 4e                	push   $0x4e
80106fcd:	e9 e4 f6 ff ff       	jmp    801066b6 <alltraps>

80106fd2 <vector79>:
80106fd2:	6a 00                	push   $0x0
80106fd4:	6a 4f                	push   $0x4f
80106fd6:	e9 db f6 ff ff       	jmp    801066b6 <alltraps>

80106fdb <vector80>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	6a 50                	push   $0x50
80106fdf:	e9 d2 f6 ff ff       	jmp    801066b6 <alltraps>

80106fe4 <vector81>:
80106fe4:	6a 00                	push   $0x0
80106fe6:	6a 51                	push   $0x51
80106fe8:	e9 c9 f6 ff ff       	jmp    801066b6 <alltraps>

80106fed <vector82>:
80106fed:	6a 00                	push   $0x0
80106fef:	6a 52                	push   $0x52
80106ff1:	e9 c0 f6 ff ff       	jmp    801066b6 <alltraps>

80106ff6 <vector83>:
80106ff6:	6a 00                	push   $0x0
80106ff8:	6a 53                	push   $0x53
80106ffa:	e9 b7 f6 ff ff       	jmp    801066b6 <alltraps>

80106fff <vector84>:
80106fff:	6a 00                	push   $0x0
80107001:	6a 54                	push   $0x54
80107003:	e9 ae f6 ff ff       	jmp    801066b6 <alltraps>

80107008 <vector85>:
80107008:	6a 00                	push   $0x0
8010700a:	6a 55                	push   $0x55
8010700c:	e9 a5 f6 ff ff       	jmp    801066b6 <alltraps>

80107011 <vector86>:
80107011:	6a 00                	push   $0x0
80107013:	6a 56                	push   $0x56
80107015:	e9 9c f6 ff ff       	jmp    801066b6 <alltraps>

8010701a <vector87>:
8010701a:	6a 00                	push   $0x0
8010701c:	6a 57                	push   $0x57
8010701e:	e9 93 f6 ff ff       	jmp    801066b6 <alltraps>

80107023 <vector88>:
80107023:	6a 00                	push   $0x0
80107025:	6a 58                	push   $0x58
80107027:	e9 8a f6 ff ff       	jmp    801066b6 <alltraps>

8010702c <vector89>:
8010702c:	6a 00                	push   $0x0
8010702e:	6a 59                	push   $0x59
80107030:	e9 81 f6 ff ff       	jmp    801066b6 <alltraps>

80107035 <vector90>:
80107035:	6a 00                	push   $0x0
80107037:	6a 5a                	push   $0x5a
80107039:	e9 78 f6 ff ff       	jmp    801066b6 <alltraps>

8010703e <vector91>:
8010703e:	6a 00                	push   $0x0
80107040:	6a 5b                	push   $0x5b
80107042:	e9 6f f6 ff ff       	jmp    801066b6 <alltraps>

80107047 <vector92>:
80107047:	6a 00                	push   $0x0
80107049:	6a 5c                	push   $0x5c
8010704b:	e9 66 f6 ff ff       	jmp    801066b6 <alltraps>

80107050 <vector93>:
80107050:	6a 00                	push   $0x0
80107052:	6a 5d                	push   $0x5d
80107054:	e9 5d f6 ff ff       	jmp    801066b6 <alltraps>

80107059 <vector94>:
80107059:	6a 00                	push   $0x0
8010705b:	6a 5e                	push   $0x5e
8010705d:	e9 54 f6 ff ff       	jmp    801066b6 <alltraps>

80107062 <vector95>:
80107062:	6a 00                	push   $0x0
80107064:	6a 5f                	push   $0x5f
80107066:	e9 4b f6 ff ff       	jmp    801066b6 <alltraps>

8010706b <vector96>:
8010706b:	6a 00                	push   $0x0
8010706d:	6a 60                	push   $0x60
8010706f:	e9 42 f6 ff ff       	jmp    801066b6 <alltraps>

80107074 <vector97>:
80107074:	6a 00                	push   $0x0
80107076:	6a 61                	push   $0x61
80107078:	e9 39 f6 ff ff       	jmp    801066b6 <alltraps>

8010707d <vector98>:
8010707d:	6a 00                	push   $0x0
8010707f:	6a 62                	push   $0x62
80107081:	e9 30 f6 ff ff       	jmp    801066b6 <alltraps>

80107086 <vector99>:
80107086:	6a 00                	push   $0x0
80107088:	6a 63                	push   $0x63
8010708a:	e9 27 f6 ff ff       	jmp    801066b6 <alltraps>

8010708f <vector100>:
8010708f:	6a 00                	push   $0x0
80107091:	6a 64                	push   $0x64
80107093:	e9 1e f6 ff ff       	jmp    801066b6 <alltraps>

80107098 <vector101>:
80107098:	6a 00                	push   $0x0
8010709a:	6a 65                	push   $0x65
8010709c:	e9 15 f6 ff ff       	jmp    801066b6 <alltraps>

801070a1 <vector102>:
801070a1:	6a 00                	push   $0x0
801070a3:	6a 66                	push   $0x66
801070a5:	e9 0c f6 ff ff       	jmp    801066b6 <alltraps>

801070aa <vector103>:
801070aa:	6a 00                	push   $0x0
801070ac:	6a 67                	push   $0x67
801070ae:	e9 03 f6 ff ff       	jmp    801066b6 <alltraps>

801070b3 <vector104>:
801070b3:	6a 00                	push   $0x0
801070b5:	6a 68                	push   $0x68
801070b7:	e9 fa f5 ff ff       	jmp    801066b6 <alltraps>

801070bc <vector105>:
801070bc:	6a 00                	push   $0x0
801070be:	6a 69                	push   $0x69
801070c0:	e9 f1 f5 ff ff       	jmp    801066b6 <alltraps>

801070c5 <vector106>:
801070c5:	6a 00                	push   $0x0
801070c7:	6a 6a                	push   $0x6a
801070c9:	e9 e8 f5 ff ff       	jmp    801066b6 <alltraps>

801070ce <vector107>:
801070ce:	6a 00                	push   $0x0
801070d0:	6a 6b                	push   $0x6b
801070d2:	e9 df f5 ff ff       	jmp    801066b6 <alltraps>

801070d7 <vector108>:
801070d7:	6a 00                	push   $0x0
801070d9:	6a 6c                	push   $0x6c
801070db:	e9 d6 f5 ff ff       	jmp    801066b6 <alltraps>

801070e0 <vector109>:
801070e0:	6a 00                	push   $0x0
801070e2:	6a 6d                	push   $0x6d
801070e4:	e9 cd f5 ff ff       	jmp    801066b6 <alltraps>

801070e9 <vector110>:
801070e9:	6a 00                	push   $0x0
801070eb:	6a 6e                	push   $0x6e
801070ed:	e9 c4 f5 ff ff       	jmp    801066b6 <alltraps>

801070f2 <vector111>:
801070f2:	6a 00                	push   $0x0
801070f4:	6a 6f                	push   $0x6f
801070f6:	e9 bb f5 ff ff       	jmp    801066b6 <alltraps>

801070fb <vector112>:
801070fb:	6a 00                	push   $0x0
801070fd:	6a 70                	push   $0x70
801070ff:	e9 b2 f5 ff ff       	jmp    801066b6 <alltraps>

80107104 <vector113>:
80107104:	6a 00                	push   $0x0
80107106:	6a 71                	push   $0x71
80107108:	e9 a9 f5 ff ff       	jmp    801066b6 <alltraps>

8010710d <vector114>:
8010710d:	6a 00                	push   $0x0
8010710f:	6a 72                	push   $0x72
80107111:	e9 a0 f5 ff ff       	jmp    801066b6 <alltraps>

80107116 <vector115>:
80107116:	6a 00                	push   $0x0
80107118:	6a 73                	push   $0x73
8010711a:	e9 97 f5 ff ff       	jmp    801066b6 <alltraps>

8010711f <vector116>:
8010711f:	6a 00                	push   $0x0
80107121:	6a 74                	push   $0x74
80107123:	e9 8e f5 ff ff       	jmp    801066b6 <alltraps>

80107128 <vector117>:
80107128:	6a 00                	push   $0x0
8010712a:	6a 75                	push   $0x75
8010712c:	e9 85 f5 ff ff       	jmp    801066b6 <alltraps>

80107131 <vector118>:
80107131:	6a 00                	push   $0x0
80107133:	6a 76                	push   $0x76
80107135:	e9 7c f5 ff ff       	jmp    801066b6 <alltraps>

8010713a <vector119>:
8010713a:	6a 00                	push   $0x0
8010713c:	6a 77                	push   $0x77
8010713e:	e9 73 f5 ff ff       	jmp    801066b6 <alltraps>

80107143 <vector120>:
80107143:	6a 00                	push   $0x0
80107145:	6a 78                	push   $0x78
80107147:	e9 6a f5 ff ff       	jmp    801066b6 <alltraps>

8010714c <vector121>:
8010714c:	6a 00                	push   $0x0
8010714e:	6a 79                	push   $0x79
80107150:	e9 61 f5 ff ff       	jmp    801066b6 <alltraps>

80107155 <vector122>:
80107155:	6a 00                	push   $0x0
80107157:	6a 7a                	push   $0x7a
80107159:	e9 58 f5 ff ff       	jmp    801066b6 <alltraps>

8010715e <vector123>:
8010715e:	6a 00                	push   $0x0
80107160:	6a 7b                	push   $0x7b
80107162:	e9 4f f5 ff ff       	jmp    801066b6 <alltraps>

80107167 <vector124>:
80107167:	6a 00                	push   $0x0
80107169:	6a 7c                	push   $0x7c
8010716b:	e9 46 f5 ff ff       	jmp    801066b6 <alltraps>

80107170 <vector125>:
80107170:	6a 00                	push   $0x0
80107172:	6a 7d                	push   $0x7d
80107174:	e9 3d f5 ff ff       	jmp    801066b6 <alltraps>

80107179 <vector126>:
80107179:	6a 00                	push   $0x0
8010717b:	6a 7e                	push   $0x7e
8010717d:	e9 34 f5 ff ff       	jmp    801066b6 <alltraps>

80107182 <vector127>:
80107182:	6a 00                	push   $0x0
80107184:	6a 7f                	push   $0x7f
80107186:	e9 2b f5 ff ff       	jmp    801066b6 <alltraps>

8010718b <vector128>:
8010718b:	6a 00                	push   $0x0
8010718d:	68 80 00 00 00       	push   $0x80
80107192:	e9 1f f5 ff ff       	jmp    801066b6 <alltraps>

80107197 <vector129>:
80107197:	6a 00                	push   $0x0
80107199:	68 81 00 00 00       	push   $0x81
8010719e:	e9 13 f5 ff ff       	jmp    801066b6 <alltraps>

801071a3 <vector130>:
801071a3:	6a 00                	push   $0x0
801071a5:	68 82 00 00 00       	push   $0x82
801071aa:	e9 07 f5 ff ff       	jmp    801066b6 <alltraps>

801071af <vector131>:
801071af:	6a 00                	push   $0x0
801071b1:	68 83 00 00 00       	push   $0x83
801071b6:	e9 fb f4 ff ff       	jmp    801066b6 <alltraps>

801071bb <vector132>:
801071bb:	6a 00                	push   $0x0
801071bd:	68 84 00 00 00       	push   $0x84
801071c2:	e9 ef f4 ff ff       	jmp    801066b6 <alltraps>

801071c7 <vector133>:
801071c7:	6a 00                	push   $0x0
801071c9:	68 85 00 00 00       	push   $0x85
801071ce:	e9 e3 f4 ff ff       	jmp    801066b6 <alltraps>

801071d3 <vector134>:
801071d3:	6a 00                	push   $0x0
801071d5:	68 86 00 00 00       	push   $0x86
801071da:	e9 d7 f4 ff ff       	jmp    801066b6 <alltraps>

801071df <vector135>:
801071df:	6a 00                	push   $0x0
801071e1:	68 87 00 00 00       	push   $0x87
801071e6:	e9 cb f4 ff ff       	jmp    801066b6 <alltraps>

801071eb <vector136>:
801071eb:	6a 00                	push   $0x0
801071ed:	68 88 00 00 00       	push   $0x88
801071f2:	e9 bf f4 ff ff       	jmp    801066b6 <alltraps>

801071f7 <vector137>:
801071f7:	6a 00                	push   $0x0
801071f9:	68 89 00 00 00       	push   $0x89
801071fe:	e9 b3 f4 ff ff       	jmp    801066b6 <alltraps>

80107203 <vector138>:
80107203:	6a 00                	push   $0x0
80107205:	68 8a 00 00 00       	push   $0x8a
8010720a:	e9 a7 f4 ff ff       	jmp    801066b6 <alltraps>

8010720f <vector139>:
8010720f:	6a 00                	push   $0x0
80107211:	68 8b 00 00 00       	push   $0x8b
80107216:	e9 9b f4 ff ff       	jmp    801066b6 <alltraps>

8010721b <vector140>:
8010721b:	6a 00                	push   $0x0
8010721d:	68 8c 00 00 00       	push   $0x8c
80107222:	e9 8f f4 ff ff       	jmp    801066b6 <alltraps>

80107227 <vector141>:
80107227:	6a 00                	push   $0x0
80107229:	68 8d 00 00 00       	push   $0x8d
8010722e:	e9 83 f4 ff ff       	jmp    801066b6 <alltraps>

80107233 <vector142>:
80107233:	6a 00                	push   $0x0
80107235:	68 8e 00 00 00       	push   $0x8e
8010723a:	e9 77 f4 ff ff       	jmp    801066b6 <alltraps>

8010723f <vector143>:
8010723f:	6a 00                	push   $0x0
80107241:	68 8f 00 00 00       	push   $0x8f
80107246:	e9 6b f4 ff ff       	jmp    801066b6 <alltraps>

8010724b <vector144>:
8010724b:	6a 00                	push   $0x0
8010724d:	68 90 00 00 00       	push   $0x90
80107252:	e9 5f f4 ff ff       	jmp    801066b6 <alltraps>

80107257 <vector145>:
80107257:	6a 00                	push   $0x0
80107259:	68 91 00 00 00       	push   $0x91
8010725e:	e9 53 f4 ff ff       	jmp    801066b6 <alltraps>

80107263 <vector146>:
80107263:	6a 00                	push   $0x0
80107265:	68 92 00 00 00       	push   $0x92
8010726a:	e9 47 f4 ff ff       	jmp    801066b6 <alltraps>

8010726f <vector147>:
8010726f:	6a 00                	push   $0x0
80107271:	68 93 00 00 00       	push   $0x93
80107276:	e9 3b f4 ff ff       	jmp    801066b6 <alltraps>

8010727b <vector148>:
8010727b:	6a 00                	push   $0x0
8010727d:	68 94 00 00 00       	push   $0x94
80107282:	e9 2f f4 ff ff       	jmp    801066b6 <alltraps>

80107287 <vector149>:
80107287:	6a 00                	push   $0x0
80107289:	68 95 00 00 00       	push   $0x95
8010728e:	e9 23 f4 ff ff       	jmp    801066b6 <alltraps>

80107293 <vector150>:
80107293:	6a 00                	push   $0x0
80107295:	68 96 00 00 00       	push   $0x96
8010729a:	e9 17 f4 ff ff       	jmp    801066b6 <alltraps>

8010729f <vector151>:
8010729f:	6a 00                	push   $0x0
801072a1:	68 97 00 00 00       	push   $0x97
801072a6:	e9 0b f4 ff ff       	jmp    801066b6 <alltraps>

801072ab <vector152>:
801072ab:	6a 00                	push   $0x0
801072ad:	68 98 00 00 00       	push   $0x98
801072b2:	e9 ff f3 ff ff       	jmp    801066b6 <alltraps>

801072b7 <vector153>:
801072b7:	6a 00                	push   $0x0
801072b9:	68 99 00 00 00       	push   $0x99
801072be:	e9 f3 f3 ff ff       	jmp    801066b6 <alltraps>

801072c3 <vector154>:
801072c3:	6a 00                	push   $0x0
801072c5:	68 9a 00 00 00       	push   $0x9a
801072ca:	e9 e7 f3 ff ff       	jmp    801066b6 <alltraps>

801072cf <vector155>:
801072cf:	6a 00                	push   $0x0
801072d1:	68 9b 00 00 00       	push   $0x9b
801072d6:	e9 db f3 ff ff       	jmp    801066b6 <alltraps>

801072db <vector156>:
801072db:	6a 00                	push   $0x0
801072dd:	68 9c 00 00 00       	push   $0x9c
801072e2:	e9 cf f3 ff ff       	jmp    801066b6 <alltraps>

801072e7 <vector157>:
801072e7:	6a 00                	push   $0x0
801072e9:	68 9d 00 00 00       	push   $0x9d
801072ee:	e9 c3 f3 ff ff       	jmp    801066b6 <alltraps>

801072f3 <vector158>:
801072f3:	6a 00                	push   $0x0
801072f5:	68 9e 00 00 00       	push   $0x9e
801072fa:	e9 b7 f3 ff ff       	jmp    801066b6 <alltraps>

801072ff <vector159>:
801072ff:	6a 00                	push   $0x0
80107301:	68 9f 00 00 00       	push   $0x9f
80107306:	e9 ab f3 ff ff       	jmp    801066b6 <alltraps>

8010730b <vector160>:
8010730b:	6a 00                	push   $0x0
8010730d:	68 a0 00 00 00       	push   $0xa0
80107312:	e9 9f f3 ff ff       	jmp    801066b6 <alltraps>

80107317 <vector161>:
80107317:	6a 00                	push   $0x0
80107319:	68 a1 00 00 00       	push   $0xa1
8010731e:	e9 93 f3 ff ff       	jmp    801066b6 <alltraps>

80107323 <vector162>:
80107323:	6a 00                	push   $0x0
80107325:	68 a2 00 00 00       	push   $0xa2
8010732a:	e9 87 f3 ff ff       	jmp    801066b6 <alltraps>

8010732f <vector163>:
8010732f:	6a 00                	push   $0x0
80107331:	68 a3 00 00 00       	push   $0xa3
80107336:	e9 7b f3 ff ff       	jmp    801066b6 <alltraps>

8010733b <vector164>:
8010733b:	6a 00                	push   $0x0
8010733d:	68 a4 00 00 00       	push   $0xa4
80107342:	e9 6f f3 ff ff       	jmp    801066b6 <alltraps>

80107347 <vector165>:
80107347:	6a 00                	push   $0x0
80107349:	68 a5 00 00 00       	push   $0xa5
8010734e:	e9 63 f3 ff ff       	jmp    801066b6 <alltraps>

80107353 <vector166>:
80107353:	6a 00                	push   $0x0
80107355:	68 a6 00 00 00       	push   $0xa6
8010735a:	e9 57 f3 ff ff       	jmp    801066b6 <alltraps>

8010735f <vector167>:
8010735f:	6a 00                	push   $0x0
80107361:	68 a7 00 00 00       	push   $0xa7
80107366:	e9 4b f3 ff ff       	jmp    801066b6 <alltraps>

8010736b <vector168>:
8010736b:	6a 00                	push   $0x0
8010736d:	68 a8 00 00 00       	push   $0xa8
80107372:	e9 3f f3 ff ff       	jmp    801066b6 <alltraps>

80107377 <vector169>:
80107377:	6a 00                	push   $0x0
80107379:	68 a9 00 00 00       	push   $0xa9
8010737e:	e9 33 f3 ff ff       	jmp    801066b6 <alltraps>

80107383 <vector170>:
80107383:	6a 00                	push   $0x0
80107385:	68 aa 00 00 00       	push   $0xaa
8010738a:	e9 27 f3 ff ff       	jmp    801066b6 <alltraps>

8010738f <vector171>:
8010738f:	6a 00                	push   $0x0
80107391:	68 ab 00 00 00       	push   $0xab
80107396:	e9 1b f3 ff ff       	jmp    801066b6 <alltraps>

8010739b <vector172>:
8010739b:	6a 00                	push   $0x0
8010739d:	68 ac 00 00 00       	push   $0xac
801073a2:	e9 0f f3 ff ff       	jmp    801066b6 <alltraps>

801073a7 <vector173>:
801073a7:	6a 00                	push   $0x0
801073a9:	68 ad 00 00 00       	push   $0xad
801073ae:	e9 03 f3 ff ff       	jmp    801066b6 <alltraps>

801073b3 <vector174>:
801073b3:	6a 00                	push   $0x0
801073b5:	68 ae 00 00 00       	push   $0xae
801073ba:	e9 f7 f2 ff ff       	jmp    801066b6 <alltraps>

801073bf <vector175>:
801073bf:	6a 00                	push   $0x0
801073c1:	68 af 00 00 00       	push   $0xaf
801073c6:	e9 eb f2 ff ff       	jmp    801066b6 <alltraps>

801073cb <vector176>:
801073cb:	6a 00                	push   $0x0
801073cd:	68 b0 00 00 00       	push   $0xb0
801073d2:	e9 df f2 ff ff       	jmp    801066b6 <alltraps>

801073d7 <vector177>:
801073d7:	6a 00                	push   $0x0
801073d9:	68 b1 00 00 00       	push   $0xb1
801073de:	e9 d3 f2 ff ff       	jmp    801066b6 <alltraps>

801073e3 <vector178>:
801073e3:	6a 00                	push   $0x0
801073e5:	68 b2 00 00 00       	push   $0xb2
801073ea:	e9 c7 f2 ff ff       	jmp    801066b6 <alltraps>

801073ef <vector179>:
801073ef:	6a 00                	push   $0x0
801073f1:	68 b3 00 00 00       	push   $0xb3
801073f6:	e9 bb f2 ff ff       	jmp    801066b6 <alltraps>

801073fb <vector180>:
801073fb:	6a 00                	push   $0x0
801073fd:	68 b4 00 00 00       	push   $0xb4
80107402:	e9 af f2 ff ff       	jmp    801066b6 <alltraps>

80107407 <vector181>:
80107407:	6a 00                	push   $0x0
80107409:	68 b5 00 00 00       	push   $0xb5
8010740e:	e9 a3 f2 ff ff       	jmp    801066b6 <alltraps>

80107413 <vector182>:
80107413:	6a 00                	push   $0x0
80107415:	68 b6 00 00 00       	push   $0xb6
8010741a:	e9 97 f2 ff ff       	jmp    801066b6 <alltraps>

8010741f <vector183>:
8010741f:	6a 00                	push   $0x0
80107421:	68 b7 00 00 00       	push   $0xb7
80107426:	e9 8b f2 ff ff       	jmp    801066b6 <alltraps>

8010742b <vector184>:
8010742b:	6a 00                	push   $0x0
8010742d:	68 b8 00 00 00       	push   $0xb8
80107432:	e9 7f f2 ff ff       	jmp    801066b6 <alltraps>

80107437 <vector185>:
80107437:	6a 00                	push   $0x0
80107439:	68 b9 00 00 00       	push   $0xb9
8010743e:	e9 73 f2 ff ff       	jmp    801066b6 <alltraps>

80107443 <vector186>:
80107443:	6a 00                	push   $0x0
80107445:	68 ba 00 00 00       	push   $0xba
8010744a:	e9 67 f2 ff ff       	jmp    801066b6 <alltraps>

8010744f <vector187>:
8010744f:	6a 00                	push   $0x0
80107451:	68 bb 00 00 00       	push   $0xbb
80107456:	e9 5b f2 ff ff       	jmp    801066b6 <alltraps>

8010745b <vector188>:
8010745b:	6a 00                	push   $0x0
8010745d:	68 bc 00 00 00       	push   $0xbc
80107462:	e9 4f f2 ff ff       	jmp    801066b6 <alltraps>

80107467 <vector189>:
80107467:	6a 00                	push   $0x0
80107469:	68 bd 00 00 00       	push   $0xbd
8010746e:	e9 43 f2 ff ff       	jmp    801066b6 <alltraps>

80107473 <vector190>:
80107473:	6a 00                	push   $0x0
80107475:	68 be 00 00 00       	push   $0xbe
8010747a:	e9 37 f2 ff ff       	jmp    801066b6 <alltraps>

8010747f <vector191>:
8010747f:	6a 00                	push   $0x0
80107481:	68 bf 00 00 00       	push   $0xbf
80107486:	e9 2b f2 ff ff       	jmp    801066b6 <alltraps>

8010748b <vector192>:
8010748b:	6a 00                	push   $0x0
8010748d:	68 c0 00 00 00       	push   $0xc0
80107492:	e9 1f f2 ff ff       	jmp    801066b6 <alltraps>

80107497 <vector193>:
80107497:	6a 00                	push   $0x0
80107499:	68 c1 00 00 00       	push   $0xc1
8010749e:	e9 13 f2 ff ff       	jmp    801066b6 <alltraps>

801074a3 <vector194>:
801074a3:	6a 00                	push   $0x0
801074a5:	68 c2 00 00 00       	push   $0xc2
801074aa:	e9 07 f2 ff ff       	jmp    801066b6 <alltraps>

801074af <vector195>:
801074af:	6a 00                	push   $0x0
801074b1:	68 c3 00 00 00       	push   $0xc3
801074b6:	e9 fb f1 ff ff       	jmp    801066b6 <alltraps>

801074bb <vector196>:
801074bb:	6a 00                	push   $0x0
801074bd:	68 c4 00 00 00       	push   $0xc4
801074c2:	e9 ef f1 ff ff       	jmp    801066b6 <alltraps>

801074c7 <vector197>:
801074c7:	6a 00                	push   $0x0
801074c9:	68 c5 00 00 00       	push   $0xc5
801074ce:	e9 e3 f1 ff ff       	jmp    801066b6 <alltraps>

801074d3 <vector198>:
801074d3:	6a 00                	push   $0x0
801074d5:	68 c6 00 00 00       	push   $0xc6
801074da:	e9 d7 f1 ff ff       	jmp    801066b6 <alltraps>

801074df <vector199>:
801074df:	6a 00                	push   $0x0
801074e1:	68 c7 00 00 00       	push   $0xc7
801074e6:	e9 cb f1 ff ff       	jmp    801066b6 <alltraps>

801074eb <vector200>:
801074eb:	6a 00                	push   $0x0
801074ed:	68 c8 00 00 00       	push   $0xc8
801074f2:	e9 bf f1 ff ff       	jmp    801066b6 <alltraps>

801074f7 <vector201>:
801074f7:	6a 00                	push   $0x0
801074f9:	68 c9 00 00 00       	push   $0xc9
801074fe:	e9 b3 f1 ff ff       	jmp    801066b6 <alltraps>

80107503 <vector202>:
80107503:	6a 00                	push   $0x0
80107505:	68 ca 00 00 00       	push   $0xca
8010750a:	e9 a7 f1 ff ff       	jmp    801066b6 <alltraps>

8010750f <vector203>:
8010750f:	6a 00                	push   $0x0
80107511:	68 cb 00 00 00       	push   $0xcb
80107516:	e9 9b f1 ff ff       	jmp    801066b6 <alltraps>

8010751b <vector204>:
8010751b:	6a 00                	push   $0x0
8010751d:	68 cc 00 00 00       	push   $0xcc
80107522:	e9 8f f1 ff ff       	jmp    801066b6 <alltraps>

80107527 <vector205>:
80107527:	6a 00                	push   $0x0
80107529:	68 cd 00 00 00       	push   $0xcd
8010752e:	e9 83 f1 ff ff       	jmp    801066b6 <alltraps>

80107533 <vector206>:
80107533:	6a 00                	push   $0x0
80107535:	68 ce 00 00 00       	push   $0xce
8010753a:	e9 77 f1 ff ff       	jmp    801066b6 <alltraps>

8010753f <vector207>:
8010753f:	6a 00                	push   $0x0
80107541:	68 cf 00 00 00       	push   $0xcf
80107546:	e9 6b f1 ff ff       	jmp    801066b6 <alltraps>

8010754b <vector208>:
8010754b:	6a 00                	push   $0x0
8010754d:	68 d0 00 00 00       	push   $0xd0
80107552:	e9 5f f1 ff ff       	jmp    801066b6 <alltraps>

80107557 <vector209>:
80107557:	6a 00                	push   $0x0
80107559:	68 d1 00 00 00       	push   $0xd1
8010755e:	e9 53 f1 ff ff       	jmp    801066b6 <alltraps>

80107563 <vector210>:
80107563:	6a 00                	push   $0x0
80107565:	68 d2 00 00 00       	push   $0xd2
8010756a:	e9 47 f1 ff ff       	jmp    801066b6 <alltraps>

8010756f <vector211>:
8010756f:	6a 00                	push   $0x0
80107571:	68 d3 00 00 00       	push   $0xd3
80107576:	e9 3b f1 ff ff       	jmp    801066b6 <alltraps>

8010757b <vector212>:
8010757b:	6a 00                	push   $0x0
8010757d:	68 d4 00 00 00       	push   $0xd4
80107582:	e9 2f f1 ff ff       	jmp    801066b6 <alltraps>

80107587 <vector213>:
80107587:	6a 00                	push   $0x0
80107589:	68 d5 00 00 00       	push   $0xd5
8010758e:	e9 23 f1 ff ff       	jmp    801066b6 <alltraps>

80107593 <vector214>:
80107593:	6a 00                	push   $0x0
80107595:	68 d6 00 00 00       	push   $0xd6
8010759a:	e9 17 f1 ff ff       	jmp    801066b6 <alltraps>

8010759f <vector215>:
8010759f:	6a 00                	push   $0x0
801075a1:	68 d7 00 00 00       	push   $0xd7
801075a6:	e9 0b f1 ff ff       	jmp    801066b6 <alltraps>

801075ab <vector216>:
801075ab:	6a 00                	push   $0x0
801075ad:	68 d8 00 00 00       	push   $0xd8
801075b2:	e9 ff f0 ff ff       	jmp    801066b6 <alltraps>

801075b7 <vector217>:
801075b7:	6a 00                	push   $0x0
801075b9:	68 d9 00 00 00       	push   $0xd9
801075be:	e9 f3 f0 ff ff       	jmp    801066b6 <alltraps>

801075c3 <vector218>:
801075c3:	6a 00                	push   $0x0
801075c5:	68 da 00 00 00       	push   $0xda
801075ca:	e9 e7 f0 ff ff       	jmp    801066b6 <alltraps>

801075cf <vector219>:
801075cf:	6a 00                	push   $0x0
801075d1:	68 db 00 00 00       	push   $0xdb
801075d6:	e9 db f0 ff ff       	jmp    801066b6 <alltraps>

801075db <vector220>:
801075db:	6a 00                	push   $0x0
801075dd:	68 dc 00 00 00       	push   $0xdc
801075e2:	e9 cf f0 ff ff       	jmp    801066b6 <alltraps>

801075e7 <vector221>:
801075e7:	6a 00                	push   $0x0
801075e9:	68 dd 00 00 00       	push   $0xdd
801075ee:	e9 c3 f0 ff ff       	jmp    801066b6 <alltraps>

801075f3 <vector222>:
801075f3:	6a 00                	push   $0x0
801075f5:	68 de 00 00 00       	push   $0xde
801075fa:	e9 b7 f0 ff ff       	jmp    801066b6 <alltraps>

801075ff <vector223>:
801075ff:	6a 00                	push   $0x0
80107601:	68 df 00 00 00       	push   $0xdf
80107606:	e9 ab f0 ff ff       	jmp    801066b6 <alltraps>

8010760b <vector224>:
8010760b:	6a 00                	push   $0x0
8010760d:	68 e0 00 00 00       	push   $0xe0
80107612:	e9 9f f0 ff ff       	jmp    801066b6 <alltraps>

80107617 <vector225>:
80107617:	6a 00                	push   $0x0
80107619:	68 e1 00 00 00       	push   $0xe1
8010761e:	e9 93 f0 ff ff       	jmp    801066b6 <alltraps>

80107623 <vector226>:
80107623:	6a 00                	push   $0x0
80107625:	68 e2 00 00 00       	push   $0xe2
8010762a:	e9 87 f0 ff ff       	jmp    801066b6 <alltraps>

8010762f <vector227>:
8010762f:	6a 00                	push   $0x0
80107631:	68 e3 00 00 00       	push   $0xe3
80107636:	e9 7b f0 ff ff       	jmp    801066b6 <alltraps>

8010763b <vector228>:
8010763b:	6a 00                	push   $0x0
8010763d:	68 e4 00 00 00       	push   $0xe4
80107642:	e9 6f f0 ff ff       	jmp    801066b6 <alltraps>

80107647 <vector229>:
80107647:	6a 00                	push   $0x0
80107649:	68 e5 00 00 00       	push   $0xe5
8010764e:	e9 63 f0 ff ff       	jmp    801066b6 <alltraps>

80107653 <vector230>:
80107653:	6a 00                	push   $0x0
80107655:	68 e6 00 00 00       	push   $0xe6
8010765a:	e9 57 f0 ff ff       	jmp    801066b6 <alltraps>

8010765f <vector231>:
8010765f:	6a 00                	push   $0x0
80107661:	68 e7 00 00 00       	push   $0xe7
80107666:	e9 4b f0 ff ff       	jmp    801066b6 <alltraps>

8010766b <vector232>:
8010766b:	6a 00                	push   $0x0
8010766d:	68 e8 00 00 00       	push   $0xe8
80107672:	e9 3f f0 ff ff       	jmp    801066b6 <alltraps>

80107677 <vector233>:
80107677:	6a 00                	push   $0x0
80107679:	68 e9 00 00 00       	push   $0xe9
8010767e:	e9 33 f0 ff ff       	jmp    801066b6 <alltraps>

80107683 <vector234>:
80107683:	6a 00                	push   $0x0
80107685:	68 ea 00 00 00       	push   $0xea
8010768a:	e9 27 f0 ff ff       	jmp    801066b6 <alltraps>

8010768f <vector235>:
8010768f:	6a 00                	push   $0x0
80107691:	68 eb 00 00 00       	push   $0xeb
80107696:	e9 1b f0 ff ff       	jmp    801066b6 <alltraps>

8010769b <vector236>:
8010769b:	6a 00                	push   $0x0
8010769d:	68 ec 00 00 00       	push   $0xec
801076a2:	e9 0f f0 ff ff       	jmp    801066b6 <alltraps>

801076a7 <vector237>:
801076a7:	6a 00                	push   $0x0
801076a9:	68 ed 00 00 00       	push   $0xed
801076ae:	e9 03 f0 ff ff       	jmp    801066b6 <alltraps>

801076b3 <vector238>:
801076b3:	6a 00                	push   $0x0
801076b5:	68 ee 00 00 00       	push   $0xee
801076ba:	e9 f7 ef ff ff       	jmp    801066b6 <alltraps>

801076bf <vector239>:
801076bf:	6a 00                	push   $0x0
801076c1:	68 ef 00 00 00       	push   $0xef
801076c6:	e9 eb ef ff ff       	jmp    801066b6 <alltraps>

801076cb <vector240>:
801076cb:	6a 00                	push   $0x0
801076cd:	68 f0 00 00 00       	push   $0xf0
801076d2:	e9 df ef ff ff       	jmp    801066b6 <alltraps>

801076d7 <vector241>:
801076d7:	6a 00                	push   $0x0
801076d9:	68 f1 00 00 00       	push   $0xf1
801076de:	e9 d3 ef ff ff       	jmp    801066b6 <alltraps>

801076e3 <vector242>:
801076e3:	6a 00                	push   $0x0
801076e5:	68 f2 00 00 00       	push   $0xf2
801076ea:	e9 c7 ef ff ff       	jmp    801066b6 <alltraps>

801076ef <vector243>:
801076ef:	6a 00                	push   $0x0
801076f1:	68 f3 00 00 00       	push   $0xf3
801076f6:	e9 bb ef ff ff       	jmp    801066b6 <alltraps>

801076fb <vector244>:
801076fb:	6a 00                	push   $0x0
801076fd:	68 f4 00 00 00       	push   $0xf4
80107702:	e9 af ef ff ff       	jmp    801066b6 <alltraps>

80107707 <vector245>:
80107707:	6a 00                	push   $0x0
80107709:	68 f5 00 00 00       	push   $0xf5
8010770e:	e9 a3 ef ff ff       	jmp    801066b6 <alltraps>

80107713 <vector246>:
80107713:	6a 00                	push   $0x0
80107715:	68 f6 00 00 00       	push   $0xf6
8010771a:	e9 97 ef ff ff       	jmp    801066b6 <alltraps>

8010771f <vector247>:
8010771f:	6a 00                	push   $0x0
80107721:	68 f7 00 00 00       	push   $0xf7
80107726:	e9 8b ef ff ff       	jmp    801066b6 <alltraps>

8010772b <vector248>:
8010772b:	6a 00                	push   $0x0
8010772d:	68 f8 00 00 00       	push   $0xf8
80107732:	e9 7f ef ff ff       	jmp    801066b6 <alltraps>

80107737 <vector249>:
80107737:	6a 00                	push   $0x0
80107739:	68 f9 00 00 00       	push   $0xf9
8010773e:	e9 73 ef ff ff       	jmp    801066b6 <alltraps>

80107743 <vector250>:
80107743:	6a 00                	push   $0x0
80107745:	68 fa 00 00 00       	push   $0xfa
8010774a:	e9 67 ef ff ff       	jmp    801066b6 <alltraps>

8010774f <vector251>:
8010774f:	6a 00                	push   $0x0
80107751:	68 fb 00 00 00       	push   $0xfb
80107756:	e9 5b ef ff ff       	jmp    801066b6 <alltraps>

8010775b <vector252>:
8010775b:	6a 00                	push   $0x0
8010775d:	68 fc 00 00 00       	push   $0xfc
80107762:	e9 4f ef ff ff       	jmp    801066b6 <alltraps>

80107767 <vector253>:
80107767:	6a 00                	push   $0x0
80107769:	68 fd 00 00 00       	push   $0xfd
8010776e:	e9 43 ef ff ff       	jmp    801066b6 <alltraps>

80107773 <vector254>:
80107773:	6a 00                	push   $0x0
80107775:	68 fe 00 00 00       	push   $0xfe
8010777a:	e9 37 ef ff ff       	jmp    801066b6 <alltraps>

8010777f <vector255>:
8010777f:	6a 00                	push   $0x0
80107781:	68 ff 00 00 00       	push   $0xff
80107786:	e9 2b ef ff ff       	jmp    801066b6 <alltraps>

8010778b <lgdt>:
8010778b:	55                   	push   %ebp
8010778c:	89 e5                	mov    %esp,%ebp
8010778e:	83 ec 10             	sub    $0x10,%esp
80107791:	8b 45 0c             	mov    0xc(%ebp),%eax
80107794:	83 e8 01             	sub    $0x1,%eax
80107797:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
8010779b:	8b 45 08             	mov    0x8(%ebp),%eax
8010779e:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801077a2:	8b 45 08             	mov    0x8(%ebp),%eax
801077a5:	c1 e8 10             	shr    $0x10,%eax
801077a8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
801077ac:	8d 45 fa             	lea    -0x6(%ebp),%eax
801077af:	0f 01 10             	lgdtl  (%eax)
801077b2:	90                   	nop
801077b3:	c9                   	leave  
801077b4:	c3                   	ret    

801077b5 <ltr>:
801077b5:	55                   	push   %ebp
801077b6:	89 e5                	mov    %esp,%ebp
801077b8:	83 ec 04             	sub    $0x4,%esp
801077bb:	8b 45 08             	mov    0x8(%ebp),%eax
801077be:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801077c2:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077c6:	0f 00 d8             	ltr    %ax
801077c9:	90                   	nop
801077ca:	c9                   	leave  
801077cb:	c3                   	ret    

801077cc <loadgs>:
801077cc:	55                   	push   %ebp
801077cd:	89 e5                	mov    %esp,%ebp
801077cf:	83 ec 04             	sub    $0x4,%esp
801077d2:	8b 45 08             	mov    0x8(%ebp),%eax
801077d5:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801077d9:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077dd:	8e e8                	mov    %eax,%gs
801077df:	90                   	nop
801077e0:	c9                   	leave  
801077e1:	c3                   	ret    

801077e2 <lcr3>:
801077e2:	55                   	push   %ebp
801077e3:	89 e5                	mov    %esp,%ebp
801077e5:	8b 45 08             	mov    0x8(%ebp),%eax
801077e8:	0f 22 d8             	mov    %eax,%cr3
801077eb:	90                   	nop
801077ec:	5d                   	pop    %ebp
801077ed:	c3                   	ret    

801077ee <seginit>:
801077ee:	55                   	push   %ebp
801077ef:	89 e5                	mov    %esp,%ebp
801077f1:	53                   	push   %ebx
801077f2:	83 ec 14             	sub    $0x14,%esp
801077f5:	e8 6d b7 ff ff       	call   80102f67 <cpunum>
801077fa:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107800:	05 20 38 11 80       	add    $0x80113820,%eax
80107805:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107808:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010780b:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107811:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107814:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
8010781a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010781d:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107821:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107824:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107828:	83 e2 f0             	and    $0xfffffff0,%edx
8010782b:	83 ca 0a             	or     $0xa,%edx
8010782e:	88 50 7d             	mov    %dl,0x7d(%eax)
80107831:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107834:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107838:	83 ca 10             	or     $0x10,%edx
8010783b:	88 50 7d             	mov    %dl,0x7d(%eax)
8010783e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107841:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107845:	83 e2 9f             	and    $0xffffff9f,%edx
80107848:	88 50 7d             	mov    %dl,0x7d(%eax)
8010784b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010784e:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107852:	83 ca 80             	or     $0xffffff80,%edx
80107855:	88 50 7d             	mov    %dl,0x7d(%eax)
80107858:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010785b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010785f:	83 ca 0f             	or     $0xf,%edx
80107862:	88 50 7e             	mov    %dl,0x7e(%eax)
80107865:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107868:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010786c:	83 e2 ef             	and    $0xffffffef,%edx
8010786f:	88 50 7e             	mov    %dl,0x7e(%eax)
80107872:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107875:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107879:	83 e2 df             	and    $0xffffffdf,%edx
8010787c:	88 50 7e             	mov    %dl,0x7e(%eax)
8010787f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107882:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107886:	83 ca 40             	or     $0x40,%edx
80107889:	88 50 7e             	mov    %dl,0x7e(%eax)
8010788c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010788f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107893:	83 ca 80             	or     $0xffffff80,%edx
80107896:	88 50 7e             	mov    %dl,0x7e(%eax)
80107899:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010789c:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
801078a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a3:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801078aa:	ff ff 
801078ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078af:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801078b6:	00 00 
801078b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078bb:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801078c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c5:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078cc:	83 e2 f0             	and    $0xfffffff0,%edx
801078cf:	83 ca 02             	or     $0x2,%edx
801078d2:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078db:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078e2:	83 ca 10             	or     $0x10,%edx
801078e5:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ee:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078f5:	83 e2 9f             	and    $0xffffff9f,%edx
801078f8:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107901:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107908:	83 ca 80             	or     $0xffffff80,%edx
8010790b:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107911:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107914:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010791b:	83 ca 0f             	or     $0xf,%edx
8010791e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107924:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107927:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010792e:	83 e2 ef             	and    $0xffffffef,%edx
80107931:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107937:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793a:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107941:	83 e2 df             	and    $0xffffffdf,%edx
80107944:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010794a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010794d:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107954:	83 ca 40             	or     $0x40,%edx
80107957:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010795d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107960:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107967:	83 ca 80             	or     $0xffffff80,%edx
8010796a:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107970:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107973:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
8010797a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797d:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107984:	ff ff 
80107986:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107989:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107990:	00 00 
80107992:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107995:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010799c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010799f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079a6:	83 e2 f0             	and    $0xfffffff0,%edx
801079a9:	83 ca 0a             	or     $0xa,%edx
801079ac:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b5:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079bc:	83 ca 10             	or     $0x10,%edx
801079bf:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c8:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079cf:	83 ca 60             	or     $0x60,%edx
801079d2:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079db:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079e2:	83 ca 80             	or     $0xffffff80,%edx
801079e5:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ee:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801079f5:	83 ca 0f             	or     $0xf,%edx
801079f8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801079fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a01:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a08:	83 e2 ef             	and    $0xffffffef,%edx
80107a0b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a14:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a1b:	83 e2 df             	and    $0xffffffdf,%edx
80107a1e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a27:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a2e:	83 ca 40             	or     $0x40,%edx
80107a31:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a3a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a41:	83 ca 80             	or     $0xffffff80,%edx
80107a44:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a4d:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
80107a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a57:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107a5e:	ff ff 
80107a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a63:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107a6a:	00 00 
80107a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a6f:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a79:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a80:	83 e2 f0             	and    $0xfffffff0,%edx
80107a83:	83 ca 02             	or     $0x2,%edx
80107a86:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a8f:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a96:	83 ca 10             	or     $0x10,%edx
80107a99:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa2:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107aa9:	83 ca 60             	or     $0x60,%edx
80107aac:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab5:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107abc:	83 ca 80             	or     $0xffffff80,%edx
80107abf:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ac8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107acf:	83 ca 0f             	or     $0xf,%edx
80107ad2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107adb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ae2:	83 e2 ef             	and    $0xffffffef,%edx
80107ae5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aee:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107af5:	83 e2 df             	and    $0xffffffdf,%edx
80107af8:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107afe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b01:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b08:	83 ca 40             	or     $0x40,%edx
80107b0b:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b14:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b1b:	83 ca 80             	or     $0xffffff80,%edx
80107b1e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b27:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
80107b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b31:	05 b4 00 00 00       	add    $0xb4,%eax
80107b36:	89 c3                	mov    %eax,%ebx
80107b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b3b:	05 b4 00 00 00       	add    $0xb4,%eax
80107b40:	c1 e8 10             	shr    $0x10,%eax
80107b43:	89 c2                	mov    %eax,%edx
80107b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b48:	05 b4 00 00 00       	add    $0xb4,%eax
80107b4d:	c1 e8 18             	shr    $0x18,%eax
80107b50:	89 c1                	mov    %eax,%ecx
80107b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b55:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107b5c:	00 00 
80107b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b61:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6b:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b74:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107b7b:	83 e2 f0             	and    $0xfffffff0,%edx
80107b7e:	83 ca 02             	or     $0x2,%edx
80107b81:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107b87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8a:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107b91:	83 ca 10             	or     $0x10,%edx
80107b94:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107b9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b9d:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107ba4:	83 e2 9f             	and    $0xffffff9f,%edx
80107ba7:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb0:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bb7:	83 ca 80             	or     $0xffffff80,%edx
80107bba:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107bca:	83 e2 f0             	and    $0xfffffff0,%edx
80107bcd:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd6:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107bdd:	83 e2 ef             	and    $0xffffffef,%edx
80107be0:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107be6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be9:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107bf0:	83 e2 df             	and    $0xffffffdf,%edx
80107bf3:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bfc:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c03:	83 ca 40             	or     $0x40,%edx
80107c06:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0f:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c16:	83 ca 80             	or     $0xffffff80,%edx
80107c19:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c22:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
80107c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c2b:	83 c0 70             	add    $0x70,%eax
80107c2e:	83 ec 08             	sub    $0x8,%esp
80107c31:	6a 38                	push   $0x38
80107c33:	50                   	push   %eax
80107c34:	e8 52 fb ff ff       	call   8010778b <lgdt>
80107c39:	83 c4 10             	add    $0x10,%esp
80107c3c:	83 ec 0c             	sub    $0xc,%esp
80107c3f:	6a 18                	push   $0x18
80107c41:	e8 86 fb ff ff       	call   801077cc <loadgs>
80107c46:	83 c4 10             	add    $0x10,%esp
80107c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4c:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
80107c52:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107c59:	00 00 00 00 
80107c5d:	90                   	nop
80107c5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107c61:	c9                   	leave  
80107c62:	c3                   	ret    

80107c63 <walkpgdir>:
80107c63:	55                   	push   %ebp
80107c64:	89 e5                	mov    %esp,%ebp
80107c66:	83 ec 18             	sub    $0x18,%esp
80107c69:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c6c:	c1 e8 16             	shr    $0x16,%eax
80107c6f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107c76:	8b 45 08             	mov    0x8(%ebp),%eax
80107c79:	01 d0                	add    %edx,%eax
80107c7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107c7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c81:	8b 00                	mov    (%eax),%eax
80107c83:	83 e0 01             	and    $0x1,%eax
80107c86:	85 c0                	test   %eax,%eax
80107c88:	74 14                	je     80107c9e <walkpgdir+0x3b>
80107c8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c8d:	8b 00                	mov    (%eax),%eax
80107c8f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c94:	05 00 00 00 80       	add    $0x80000000,%eax
80107c99:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c9c:	eb 42                	jmp    80107ce0 <walkpgdir+0x7d>
80107c9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107ca2:	74 0e                	je     80107cb2 <walkpgdir+0x4f>
80107ca4:	e8 28 af ff ff       	call   80102bd1 <kalloc>
80107ca9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107cac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107cb0:	75 07                	jne    80107cb9 <walkpgdir+0x56>
80107cb2:	b8 00 00 00 00       	mov    $0x0,%eax
80107cb7:	eb 3e                	jmp    80107cf7 <walkpgdir+0x94>
80107cb9:	83 ec 04             	sub    $0x4,%esp
80107cbc:	68 00 10 00 00       	push   $0x1000
80107cc1:	6a 00                	push   $0x0
80107cc3:	ff 75 f4             	pushl  -0xc(%ebp)
80107cc6:	e8 ee d4 ff ff       	call   801051b9 <memset>
80107ccb:	83 c4 10             	add    $0x10,%esp
80107cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cd1:	05 00 00 00 80       	add    $0x80000000,%eax
80107cd6:	83 c8 07             	or     $0x7,%eax
80107cd9:	89 c2                	mov    %eax,%edx
80107cdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cde:	89 10                	mov    %edx,(%eax)
80107ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ce3:	c1 e8 0c             	shr    $0xc,%eax
80107ce6:	25 ff 03 00 00       	and    $0x3ff,%eax
80107ceb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107cf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cf5:	01 d0                	add    %edx,%eax
80107cf7:	c9                   	leave  
80107cf8:	c3                   	ret    

80107cf9 <mappages>:
80107cf9:	55                   	push   %ebp
80107cfa:	89 e5                	mov    %esp,%ebp
80107cfc:	83 ec 18             	sub    $0x18,%esp
80107cff:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d07:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d0a:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d0d:	8b 45 10             	mov    0x10(%ebp),%eax
80107d10:	01 d0                	add    %edx,%eax
80107d12:	83 e8 01             	sub    $0x1,%eax
80107d15:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107d1d:	83 ec 04             	sub    $0x4,%esp
80107d20:	6a 01                	push   $0x1
80107d22:	ff 75 f4             	pushl  -0xc(%ebp)
80107d25:	ff 75 08             	pushl  0x8(%ebp)
80107d28:	e8 36 ff ff ff       	call   80107c63 <walkpgdir>
80107d2d:	83 c4 10             	add    $0x10,%esp
80107d30:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107d33:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107d37:	75 07                	jne    80107d40 <mappages+0x47>
80107d39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d3e:	eb 47                	jmp    80107d87 <mappages+0x8e>
80107d40:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d43:	8b 00                	mov    (%eax),%eax
80107d45:	83 e0 01             	and    $0x1,%eax
80107d48:	85 c0                	test   %eax,%eax
80107d4a:	74 0d                	je     80107d59 <mappages+0x60>
80107d4c:	83 ec 0c             	sub    $0xc,%esp
80107d4f:	68 80 8b 10 80       	push   $0x80108b80
80107d54:	e8 09 88 ff ff       	call   80100562 <panic>
80107d59:	8b 45 18             	mov    0x18(%ebp),%eax
80107d5c:	0b 45 14             	or     0x14(%ebp),%eax
80107d5f:	83 c8 01             	or     $0x1,%eax
80107d62:	89 c2                	mov    %eax,%edx
80107d64:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d67:	89 10                	mov    %edx,(%eax)
80107d69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d6c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107d6f:	74 10                	je     80107d81 <mappages+0x88>
80107d71:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107d78:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
80107d7f:	eb 9c                	jmp    80107d1d <mappages+0x24>
80107d81:	90                   	nop
80107d82:	b8 00 00 00 00       	mov    $0x0,%eax
80107d87:	c9                   	leave  
80107d88:	c3                   	ret    

80107d89 <setupkvm>:
80107d89:	55                   	push   %ebp
80107d8a:	89 e5                	mov    %esp,%ebp
80107d8c:	53                   	push   %ebx
80107d8d:	83 ec 14             	sub    $0x14,%esp
80107d90:	e8 3c ae ff ff       	call   80102bd1 <kalloc>
80107d95:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107d98:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107d9c:	75 07                	jne    80107da5 <setupkvm+0x1c>
80107d9e:	b8 00 00 00 00       	mov    $0x0,%eax
80107da3:	eb 6a                	jmp    80107e0f <setupkvm+0x86>
80107da5:	83 ec 04             	sub    $0x4,%esp
80107da8:	68 00 10 00 00       	push   $0x1000
80107dad:	6a 00                	push   $0x0
80107daf:	ff 75 f0             	pushl  -0x10(%ebp)
80107db2:	e8 02 d4 ff ff       	call   801051b9 <memset>
80107db7:	83 c4 10             	add    $0x10,%esp
80107dba:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107dc1:	eb 40                	jmp    80107e03 <setupkvm+0x7a>
80107dc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc6:	8b 48 0c             	mov    0xc(%eax),%ecx
80107dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dcc:	8b 50 04             	mov    0x4(%eax),%edx
80107dcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd2:	8b 58 08             	mov    0x8(%eax),%ebx
80107dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd8:	8b 40 04             	mov    0x4(%eax),%eax
80107ddb:	29 c3                	sub    %eax,%ebx
80107ddd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107de0:	8b 00                	mov    (%eax),%eax
80107de2:	83 ec 0c             	sub    $0xc,%esp
80107de5:	51                   	push   %ecx
80107de6:	52                   	push   %edx
80107de7:	53                   	push   %ebx
80107de8:	50                   	push   %eax
80107de9:	ff 75 f0             	pushl  -0x10(%ebp)
80107dec:	e8 08 ff ff ff       	call   80107cf9 <mappages>
80107df1:	83 c4 20             	add    $0x20,%esp
80107df4:	85 c0                	test   %eax,%eax
80107df6:	79 07                	jns    80107dff <setupkvm+0x76>
80107df8:	b8 00 00 00 00       	mov    $0x0,%eax
80107dfd:	eb 10                	jmp    80107e0f <setupkvm+0x86>
80107dff:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107e03:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107e0a:	72 b7                	jb     80107dc3 <setupkvm+0x3a>
80107e0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107e12:	c9                   	leave  
80107e13:	c3                   	ret    

80107e14 <kvmalloc>:
80107e14:	55                   	push   %ebp
80107e15:	89 e5                	mov    %esp,%ebp
80107e17:	83 ec 08             	sub    $0x8,%esp
80107e1a:	e8 6a ff ff ff       	call   80107d89 <setupkvm>
80107e1f:	a3 a4 65 11 80       	mov    %eax,0x801165a4
80107e24:	e8 03 00 00 00       	call   80107e2c <switchkvm>
80107e29:	90                   	nop
80107e2a:	c9                   	leave  
80107e2b:	c3                   	ret    

80107e2c <switchkvm>:
80107e2c:	55                   	push   %ebp
80107e2d:	89 e5                	mov    %esp,%ebp
80107e2f:	a1 a4 65 11 80       	mov    0x801165a4,%eax
80107e34:	05 00 00 00 80       	add    $0x80000000,%eax
80107e39:	50                   	push   %eax
80107e3a:	e8 a3 f9 ff ff       	call   801077e2 <lcr3>
80107e3f:	83 c4 04             	add    $0x4,%esp
80107e42:	90                   	nop
80107e43:	c9                   	leave  
80107e44:	c3                   	ret    

80107e45 <switchuvm>:
80107e45:	55                   	push   %ebp
80107e46:	89 e5                	mov    %esp,%ebp
80107e48:	56                   	push   %esi
80107e49:	53                   	push   %ebx
80107e4a:	e8 58 d2 ff ff       	call   801050a7 <pushcli>
80107e4f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e55:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e5c:	83 c2 08             	add    $0x8,%edx
80107e5f:	89 d6                	mov    %edx,%esi
80107e61:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e68:	83 c2 08             	add    $0x8,%edx
80107e6b:	c1 ea 10             	shr    $0x10,%edx
80107e6e:	89 d3                	mov    %edx,%ebx
80107e70:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e77:	83 c2 08             	add    $0x8,%edx
80107e7a:	c1 ea 18             	shr    $0x18,%edx
80107e7d:	89 d1                	mov    %edx,%ecx
80107e7f:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107e86:	67 00 
80107e88:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107e8f:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107e95:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107e9c:	83 e2 f0             	and    $0xfffffff0,%edx
80107e9f:	83 ca 09             	or     $0x9,%edx
80107ea2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ea8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107eaf:	83 ca 10             	or     $0x10,%edx
80107eb2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107eb8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ebf:	83 e2 9f             	and    $0xffffff9f,%edx
80107ec2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ec8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ecf:	83 ca 80             	or     $0xffffff80,%edx
80107ed2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ed8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107edf:	83 e2 f0             	and    $0xfffffff0,%edx
80107ee2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107ee8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107eef:	83 e2 ef             	and    $0xffffffef,%edx
80107ef2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107ef8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107eff:	83 e2 df             	and    $0xffffffdf,%edx
80107f02:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f08:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f0f:	83 ca 40             	or     $0x40,%edx
80107f12:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f18:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f1f:	83 e2 7f             	and    $0x7f,%edx
80107f22:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f28:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
80107f2e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f34:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f3b:	83 e2 ef             	and    $0xffffffef,%edx
80107f3e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f44:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f4a:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
80107f50:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f56:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107f5d:	8b 52 08             	mov    0x8(%edx),%edx
80107f60:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107f66:	89 50 0c             	mov    %edx,0xc(%eax)
80107f69:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f6f:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
80107f75:	83 ec 0c             	sub    $0xc,%esp
80107f78:	6a 30                	push   $0x30
80107f7a:	e8 36 f8 ff ff       	call   801077b5 <ltr>
80107f7f:	83 c4 10             	add    $0x10,%esp
80107f82:	8b 45 08             	mov    0x8(%ebp),%eax
80107f85:	8b 40 04             	mov    0x4(%eax),%eax
80107f88:	85 c0                	test   %eax,%eax
80107f8a:	75 0d                	jne    80107f99 <switchuvm+0x154>
80107f8c:	83 ec 0c             	sub    $0xc,%esp
80107f8f:	68 86 8b 10 80       	push   $0x80108b86
80107f94:	e8 c9 85 ff ff       	call   80100562 <panic>
80107f99:	8b 45 08             	mov    0x8(%ebp),%eax
80107f9c:	8b 40 04             	mov    0x4(%eax),%eax
80107f9f:	05 00 00 00 80       	add    $0x80000000,%eax
80107fa4:	83 ec 0c             	sub    $0xc,%esp
80107fa7:	50                   	push   %eax
80107fa8:	e8 35 f8 ff ff       	call   801077e2 <lcr3>
80107fad:	83 c4 10             	add    $0x10,%esp
80107fb0:	e8 48 d1 ff ff       	call   801050fd <popcli>
80107fb5:	90                   	nop
80107fb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107fb9:	5b                   	pop    %ebx
80107fba:	5e                   	pop    %esi
80107fbb:	5d                   	pop    %ebp
80107fbc:	c3                   	ret    

80107fbd <inituvm>:
80107fbd:	55                   	push   %ebp
80107fbe:	89 e5                	mov    %esp,%ebp
80107fc0:	83 ec 18             	sub    $0x18,%esp
80107fc3:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107fca:	76 0d                	jbe    80107fd9 <inituvm+0x1c>
80107fcc:	83 ec 0c             	sub    $0xc,%esp
80107fcf:	68 9a 8b 10 80       	push   $0x80108b9a
80107fd4:	e8 89 85 ff ff       	call   80100562 <panic>
80107fd9:	e8 f3 ab ff ff       	call   80102bd1 <kalloc>
80107fde:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107fe1:	83 ec 04             	sub    $0x4,%esp
80107fe4:	68 00 10 00 00       	push   $0x1000
80107fe9:	6a 00                	push   $0x0
80107feb:	ff 75 f4             	pushl  -0xc(%ebp)
80107fee:	e8 c6 d1 ff ff       	call   801051b9 <memset>
80107ff3:	83 c4 10             	add    $0x10,%esp
80107ff6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ff9:	05 00 00 00 80       	add    $0x80000000,%eax
80107ffe:	83 ec 0c             	sub    $0xc,%esp
80108001:	6a 06                	push   $0x6
80108003:	50                   	push   %eax
80108004:	68 00 10 00 00       	push   $0x1000
80108009:	6a 00                	push   $0x0
8010800b:	ff 75 08             	pushl  0x8(%ebp)
8010800e:	e8 e6 fc ff ff       	call   80107cf9 <mappages>
80108013:	83 c4 20             	add    $0x20,%esp
80108016:	83 ec 04             	sub    $0x4,%esp
80108019:	ff 75 10             	pushl  0x10(%ebp)
8010801c:	ff 75 0c             	pushl  0xc(%ebp)
8010801f:	ff 75 f4             	pushl  -0xc(%ebp)
80108022:	e8 61 d2 ff ff       	call   80105288 <memmove>
80108027:	83 c4 10             	add    $0x10,%esp
8010802a:	90                   	nop
8010802b:	c9                   	leave  
8010802c:	c3                   	ret    

8010802d <loaduvm>:
8010802d:	55                   	push   %ebp
8010802e:	89 e5                	mov    %esp,%ebp
80108030:	83 ec 18             	sub    $0x18,%esp
80108033:	8b 45 0c             	mov    0xc(%ebp),%eax
80108036:	25 ff 0f 00 00       	and    $0xfff,%eax
8010803b:	85 c0                	test   %eax,%eax
8010803d:	74 0d                	je     8010804c <loaduvm+0x1f>
8010803f:	83 ec 0c             	sub    $0xc,%esp
80108042:	68 b4 8b 10 80       	push   $0x80108bb4
80108047:	e8 16 85 ff ff       	call   80100562 <panic>
8010804c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108053:	e9 8f 00 00 00       	jmp    801080e7 <loaduvm+0xba>
80108058:	8b 55 0c             	mov    0xc(%ebp),%edx
8010805b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010805e:	01 d0                	add    %edx,%eax
80108060:	83 ec 04             	sub    $0x4,%esp
80108063:	6a 00                	push   $0x0
80108065:	50                   	push   %eax
80108066:	ff 75 08             	pushl  0x8(%ebp)
80108069:	e8 f5 fb ff ff       	call   80107c63 <walkpgdir>
8010806e:	83 c4 10             	add    $0x10,%esp
80108071:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108074:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108078:	75 0d                	jne    80108087 <loaduvm+0x5a>
8010807a:	83 ec 0c             	sub    $0xc,%esp
8010807d:	68 d7 8b 10 80       	push   $0x80108bd7
80108082:	e8 db 84 ff ff       	call   80100562 <panic>
80108087:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010808a:	8b 00                	mov    (%eax),%eax
8010808c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108091:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108094:	8b 45 18             	mov    0x18(%ebp),%eax
80108097:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010809a:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010809f:	77 0b                	ja     801080ac <loaduvm+0x7f>
801080a1:	8b 45 18             	mov    0x18(%ebp),%eax
801080a4:	2b 45 f4             	sub    -0xc(%ebp),%eax
801080a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801080aa:	eb 07                	jmp    801080b3 <loaduvm+0x86>
801080ac:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
801080b3:	8b 55 14             	mov    0x14(%ebp),%edx
801080b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b9:	01 d0                	add    %edx,%eax
801080bb:	8b 55 e8             	mov    -0x18(%ebp),%edx
801080be:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801080c4:	ff 75 f0             	pushl  -0x10(%ebp)
801080c7:	50                   	push   %eax
801080c8:	52                   	push   %edx
801080c9:	ff 75 10             	pushl  0x10(%ebp)
801080cc:	e8 2b 9d ff ff       	call   80101dfc <readi>
801080d1:	83 c4 10             	add    $0x10,%esp
801080d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801080d7:	74 07                	je     801080e0 <loaduvm+0xb3>
801080d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801080de:	eb 18                	jmp    801080f8 <loaduvm+0xcb>
801080e0:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801080e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ea:	3b 45 18             	cmp    0x18(%ebp),%eax
801080ed:	0f 82 65 ff ff ff    	jb     80108058 <loaduvm+0x2b>
801080f3:	b8 00 00 00 00       	mov    $0x0,%eax
801080f8:	c9                   	leave  
801080f9:	c3                   	ret    

801080fa <allocuvm>:
801080fa:	55                   	push   %ebp
801080fb:	89 e5                	mov    %esp,%ebp
801080fd:	83 ec 18             	sub    $0x18,%esp
80108100:	8b 45 10             	mov    0x10(%ebp),%eax
80108103:	85 c0                	test   %eax,%eax
80108105:	79 0a                	jns    80108111 <allocuvm+0x17>
80108107:	b8 00 00 00 00       	mov    $0x0,%eax
8010810c:	e9 ec 00 00 00       	jmp    801081fd <allocuvm+0x103>
80108111:	8b 45 10             	mov    0x10(%ebp),%eax
80108114:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108117:	73 08                	jae    80108121 <allocuvm+0x27>
80108119:	8b 45 0c             	mov    0xc(%ebp),%eax
8010811c:	e9 dc 00 00 00       	jmp    801081fd <allocuvm+0x103>
80108121:	8b 45 0c             	mov    0xc(%ebp),%eax
80108124:	05 ff 0f 00 00       	add    $0xfff,%eax
80108129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010812e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108131:	e9 b8 00 00 00       	jmp    801081ee <allocuvm+0xf4>
80108136:	e8 96 aa ff ff       	call   80102bd1 <kalloc>
8010813b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010813e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108142:	75 2e                	jne    80108172 <allocuvm+0x78>
80108144:	83 ec 0c             	sub    $0xc,%esp
80108147:	68 f5 8b 10 80       	push   $0x80108bf5
8010814c:	e8 77 82 ff ff       	call   801003c8 <cprintf>
80108151:	83 c4 10             	add    $0x10,%esp
80108154:	83 ec 04             	sub    $0x4,%esp
80108157:	ff 75 0c             	pushl  0xc(%ebp)
8010815a:	ff 75 10             	pushl  0x10(%ebp)
8010815d:	ff 75 08             	pushl  0x8(%ebp)
80108160:	e8 9a 00 00 00       	call   801081ff <deallocuvm>
80108165:	83 c4 10             	add    $0x10,%esp
80108168:	b8 00 00 00 00       	mov    $0x0,%eax
8010816d:	e9 8b 00 00 00       	jmp    801081fd <allocuvm+0x103>
80108172:	83 ec 04             	sub    $0x4,%esp
80108175:	68 00 10 00 00       	push   $0x1000
8010817a:	6a 00                	push   $0x0
8010817c:	ff 75 f0             	pushl  -0x10(%ebp)
8010817f:	e8 35 d0 ff ff       	call   801051b9 <memset>
80108184:	83 c4 10             	add    $0x10,%esp
80108187:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010818a:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80108190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108193:	83 ec 0c             	sub    $0xc,%esp
80108196:	6a 06                	push   $0x6
80108198:	52                   	push   %edx
80108199:	68 00 10 00 00       	push   $0x1000
8010819e:	50                   	push   %eax
8010819f:	ff 75 08             	pushl  0x8(%ebp)
801081a2:	e8 52 fb ff ff       	call   80107cf9 <mappages>
801081a7:	83 c4 20             	add    $0x20,%esp
801081aa:	85 c0                	test   %eax,%eax
801081ac:	79 39                	jns    801081e7 <allocuvm+0xed>
801081ae:	83 ec 0c             	sub    $0xc,%esp
801081b1:	68 0d 8c 10 80       	push   $0x80108c0d
801081b6:	e8 0d 82 ff ff       	call   801003c8 <cprintf>
801081bb:	83 c4 10             	add    $0x10,%esp
801081be:	83 ec 04             	sub    $0x4,%esp
801081c1:	ff 75 0c             	pushl  0xc(%ebp)
801081c4:	ff 75 10             	pushl  0x10(%ebp)
801081c7:	ff 75 08             	pushl  0x8(%ebp)
801081ca:	e8 30 00 00 00       	call   801081ff <deallocuvm>
801081cf:	83 c4 10             	add    $0x10,%esp
801081d2:	83 ec 0c             	sub    $0xc,%esp
801081d5:	ff 75 f0             	pushl  -0x10(%ebp)
801081d8:	e8 5e a9 ff ff       	call   80102b3b <kfree>
801081dd:	83 c4 10             	add    $0x10,%esp
801081e0:	b8 00 00 00 00       	mov    $0x0,%eax
801081e5:	eb 16                	jmp    801081fd <allocuvm+0x103>
801081e7:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801081ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081f1:	3b 45 10             	cmp    0x10(%ebp),%eax
801081f4:	0f 82 3c ff ff ff    	jb     80108136 <allocuvm+0x3c>
801081fa:	8b 45 10             	mov    0x10(%ebp),%eax
801081fd:	c9                   	leave  
801081fe:	c3                   	ret    

801081ff <deallocuvm>:
801081ff:	55                   	push   %ebp
80108200:	89 e5                	mov    %esp,%ebp
80108202:	83 ec 18             	sub    $0x18,%esp
80108205:	8b 45 10             	mov    0x10(%ebp),%eax
80108208:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010820b:	72 08                	jb     80108215 <deallocuvm+0x16>
8010820d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108210:	e9 9c 00 00 00       	jmp    801082b1 <deallocuvm+0xb2>
80108215:	8b 45 10             	mov    0x10(%ebp),%eax
80108218:	05 ff 0f 00 00       	add    $0xfff,%eax
8010821d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108222:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108225:	eb 7b                	jmp    801082a2 <deallocuvm+0xa3>
80108227:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010822a:	83 ec 04             	sub    $0x4,%esp
8010822d:	6a 00                	push   $0x0
8010822f:	50                   	push   %eax
80108230:	ff 75 08             	pushl  0x8(%ebp)
80108233:	e8 2b fa ff ff       	call   80107c63 <walkpgdir>
80108238:	83 c4 10             	add    $0x10,%esp
8010823b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010823e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108242:	75 09                	jne    8010824d <deallocuvm+0x4e>
80108244:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
8010824b:	eb 4e                	jmp    8010829b <deallocuvm+0x9c>
8010824d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108250:	8b 00                	mov    (%eax),%eax
80108252:	83 e0 01             	and    $0x1,%eax
80108255:	85 c0                	test   %eax,%eax
80108257:	74 42                	je     8010829b <deallocuvm+0x9c>
80108259:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010825c:	8b 00                	mov    (%eax),%eax
8010825e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108263:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108266:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010826a:	75 0d                	jne    80108279 <deallocuvm+0x7a>
8010826c:	83 ec 0c             	sub    $0xc,%esp
8010826f:	68 29 8c 10 80       	push   $0x80108c29
80108274:	e8 e9 82 ff ff       	call   80100562 <panic>
80108279:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010827c:	05 00 00 00 80       	add    $0x80000000,%eax
80108281:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108284:	83 ec 0c             	sub    $0xc,%esp
80108287:	ff 75 e8             	pushl  -0x18(%ebp)
8010828a:	e8 ac a8 ff ff       	call   80102b3b <kfree>
8010828f:	83 c4 10             	add    $0x10,%esp
80108292:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108295:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010829b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801082a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082a8:	0f 82 79 ff ff ff    	jb     80108227 <deallocuvm+0x28>
801082ae:	8b 45 10             	mov    0x10(%ebp),%eax
801082b1:	c9                   	leave  
801082b2:	c3                   	ret    

801082b3 <freevm>:
801082b3:	55                   	push   %ebp
801082b4:	89 e5                	mov    %esp,%ebp
801082b6:	83 ec 18             	sub    $0x18,%esp
801082b9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801082bd:	75 0d                	jne    801082cc <freevm+0x19>
801082bf:	83 ec 0c             	sub    $0xc,%esp
801082c2:	68 2f 8c 10 80       	push   $0x80108c2f
801082c7:	e8 96 82 ff ff       	call   80100562 <panic>
801082cc:	83 ec 04             	sub    $0x4,%esp
801082cf:	6a 00                	push   $0x0
801082d1:	68 00 00 00 80       	push   $0x80000000
801082d6:	ff 75 08             	pushl  0x8(%ebp)
801082d9:	e8 21 ff ff ff       	call   801081ff <deallocuvm>
801082de:	83 c4 10             	add    $0x10,%esp
801082e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801082e8:	eb 48                	jmp    80108332 <freevm+0x7f>
801082ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801082f4:	8b 45 08             	mov    0x8(%ebp),%eax
801082f7:	01 d0                	add    %edx,%eax
801082f9:	8b 00                	mov    (%eax),%eax
801082fb:	83 e0 01             	and    $0x1,%eax
801082fe:	85 c0                	test   %eax,%eax
80108300:	74 2c                	je     8010832e <freevm+0x7b>
80108302:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108305:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010830c:	8b 45 08             	mov    0x8(%ebp),%eax
8010830f:	01 d0                	add    %edx,%eax
80108311:	8b 00                	mov    (%eax),%eax
80108313:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108318:	05 00 00 00 80       	add    $0x80000000,%eax
8010831d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108320:	83 ec 0c             	sub    $0xc,%esp
80108323:	ff 75 f0             	pushl  -0x10(%ebp)
80108326:	e8 10 a8 ff ff       	call   80102b3b <kfree>
8010832b:	83 c4 10             	add    $0x10,%esp
8010832e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108332:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108339:	76 af                	jbe    801082ea <freevm+0x37>
8010833b:	83 ec 0c             	sub    $0xc,%esp
8010833e:	ff 75 08             	pushl  0x8(%ebp)
80108341:	e8 f5 a7 ff ff       	call   80102b3b <kfree>
80108346:	83 c4 10             	add    $0x10,%esp
80108349:	90                   	nop
8010834a:	c9                   	leave  
8010834b:	c3                   	ret    

8010834c <clearpteu>:
8010834c:	55                   	push   %ebp
8010834d:	89 e5                	mov    %esp,%ebp
8010834f:	83 ec 18             	sub    $0x18,%esp
80108352:	83 ec 04             	sub    $0x4,%esp
80108355:	6a 00                	push   $0x0
80108357:	ff 75 0c             	pushl  0xc(%ebp)
8010835a:	ff 75 08             	pushl  0x8(%ebp)
8010835d:	e8 01 f9 ff ff       	call   80107c63 <walkpgdir>
80108362:	83 c4 10             	add    $0x10,%esp
80108365:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108368:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010836c:	75 0d                	jne    8010837b <clearpteu+0x2f>
8010836e:	83 ec 0c             	sub    $0xc,%esp
80108371:	68 40 8c 10 80       	push   $0x80108c40
80108376:	e8 e7 81 ff ff       	call   80100562 <panic>
8010837b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010837e:	8b 00                	mov    (%eax),%eax
80108380:	83 e0 fb             	and    $0xfffffffb,%eax
80108383:	89 c2                	mov    %eax,%edx
80108385:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108388:	89 10                	mov    %edx,(%eax)
8010838a:	90                   	nop
8010838b:	c9                   	leave  
8010838c:	c3                   	ret    

8010838d <copyuvm>:
8010838d:	55                   	push   %ebp
8010838e:	89 e5                	mov    %esp,%ebp
80108390:	83 ec 28             	sub    $0x28,%esp
80108393:	e8 f1 f9 ff ff       	call   80107d89 <setupkvm>
80108398:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010839b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010839f:	75 0a                	jne    801083ab <copyuvm+0x1e>
801083a1:	b8 00 00 00 00       	mov    $0x0,%eax
801083a6:	e9 eb 00 00 00       	jmp    80108496 <copyuvm+0x109>
801083ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801083b2:	e9 b7 00 00 00       	jmp    8010846e <copyuvm+0xe1>
801083b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083ba:	83 ec 04             	sub    $0x4,%esp
801083bd:	6a 00                	push   $0x0
801083bf:	50                   	push   %eax
801083c0:	ff 75 08             	pushl  0x8(%ebp)
801083c3:	e8 9b f8 ff ff       	call   80107c63 <walkpgdir>
801083c8:	83 c4 10             	add    $0x10,%esp
801083cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
801083ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801083d2:	75 0d                	jne    801083e1 <copyuvm+0x54>
801083d4:	83 ec 0c             	sub    $0xc,%esp
801083d7:	68 4a 8c 10 80       	push   $0x80108c4a
801083dc:	e8 81 81 ff ff       	call   80100562 <panic>
801083e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801083e4:	8b 00                	mov    (%eax),%eax
801083e6:	83 e0 01             	and    $0x1,%eax
801083e9:	85 c0                	test   %eax,%eax
801083eb:	75 0d                	jne    801083fa <copyuvm+0x6d>
801083ed:	83 ec 0c             	sub    $0xc,%esp
801083f0:	68 64 8c 10 80       	push   $0x80108c64
801083f5:	e8 68 81 ff ff       	call   80100562 <panic>
801083fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
801083fd:	8b 00                	mov    (%eax),%eax
801083ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108404:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108407:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010840a:	8b 00                	mov    (%eax),%eax
8010840c:	25 ff 0f 00 00       	and    $0xfff,%eax
80108411:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108414:	e8 b8 a7 ff ff       	call   80102bd1 <kalloc>
80108419:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010841c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108420:	74 5d                	je     8010847f <copyuvm+0xf2>
80108422:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108425:	05 00 00 00 80       	add    $0x80000000,%eax
8010842a:	83 ec 04             	sub    $0x4,%esp
8010842d:	68 00 10 00 00       	push   $0x1000
80108432:	50                   	push   %eax
80108433:	ff 75 e0             	pushl  -0x20(%ebp)
80108436:	e8 4d ce ff ff       	call   80105288 <memmove>
8010843b:	83 c4 10             	add    $0x10,%esp
8010843e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108441:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108444:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010844a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010844d:	83 ec 0c             	sub    $0xc,%esp
80108450:	52                   	push   %edx
80108451:	51                   	push   %ecx
80108452:	68 00 10 00 00       	push   $0x1000
80108457:	50                   	push   %eax
80108458:	ff 75 f0             	pushl  -0x10(%ebp)
8010845b:	e8 99 f8 ff ff       	call   80107cf9 <mappages>
80108460:	83 c4 20             	add    $0x20,%esp
80108463:	85 c0                	test   %eax,%eax
80108465:	78 1b                	js     80108482 <copyuvm+0xf5>
80108467:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010846e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108471:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108474:	0f 82 3d ff ff ff    	jb     801083b7 <copyuvm+0x2a>
8010847a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010847d:	eb 17                	jmp    80108496 <copyuvm+0x109>
8010847f:	90                   	nop
80108480:	eb 01                	jmp    80108483 <copyuvm+0xf6>
80108482:	90                   	nop
80108483:	83 ec 0c             	sub    $0xc,%esp
80108486:	ff 75 f0             	pushl  -0x10(%ebp)
80108489:	e8 25 fe ff ff       	call   801082b3 <freevm>
8010848e:	83 c4 10             	add    $0x10,%esp
80108491:	b8 00 00 00 00       	mov    $0x0,%eax
80108496:	c9                   	leave  
80108497:	c3                   	ret    

80108498 <uva2ka>:
80108498:	55                   	push   %ebp
80108499:	89 e5                	mov    %esp,%ebp
8010849b:	83 ec 18             	sub    $0x18,%esp
8010849e:	83 ec 04             	sub    $0x4,%esp
801084a1:	6a 00                	push   $0x0
801084a3:	ff 75 0c             	pushl  0xc(%ebp)
801084a6:	ff 75 08             	pushl  0x8(%ebp)
801084a9:	e8 b5 f7 ff ff       	call   80107c63 <walkpgdir>
801084ae:	83 c4 10             	add    $0x10,%esp
801084b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801084b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084b7:	8b 00                	mov    (%eax),%eax
801084b9:	83 e0 01             	and    $0x1,%eax
801084bc:	85 c0                	test   %eax,%eax
801084be:	75 07                	jne    801084c7 <uva2ka+0x2f>
801084c0:	b8 00 00 00 00       	mov    $0x0,%eax
801084c5:	eb 22                	jmp    801084e9 <uva2ka+0x51>
801084c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084ca:	8b 00                	mov    (%eax),%eax
801084cc:	83 e0 04             	and    $0x4,%eax
801084cf:	85 c0                	test   %eax,%eax
801084d1:	75 07                	jne    801084da <uva2ka+0x42>
801084d3:	b8 00 00 00 00       	mov    $0x0,%eax
801084d8:	eb 0f                	jmp    801084e9 <uva2ka+0x51>
801084da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084dd:	8b 00                	mov    (%eax),%eax
801084df:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084e4:	05 00 00 00 80       	add    $0x80000000,%eax
801084e9:	c9                   	leave  
801084ea:	c3                   	ret    

801084eb <copyout>:
801084eb:	55                   	push   %ebp
801084ec:	89 e5                	mov    %esp,%ebp
801084ee:	83 ec 18             	sub    $0x18,%esp
801084f1:	8b 45 10             	mov    0x10(%ebp),%eax
801084f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801084f7:	eb 7f                	jmp    80108578 <copyout+0x8d>
801084f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801084fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108501:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108504:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108507:	83 ec 08             	sub    $0x8,%esp
8010850a:	50                   	push   %eax
8010850b:	ff 75 08             	pushl  0x8(%ebp)
8010850e:	e8 85 ff ff ff       	call   80108498 <uva2ka>
80108513:	83 c4 10             	add    $0x10,%esp
80108516:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108519:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010851d:	75 07                	jne    80108526 <copyout+0x3b>
8010851f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108524:	eb 61                	jmp    80108587 <copyout+0x9c>
80108526:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108529:	2b 45 0c             	sub    0xc(%ebp),%eax
8010852c:	05 00 10 00 00       	add    $0x1000,%eax
80108531:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108534:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108537:	3b 45 14             	cmp    0x14(%ebp),%eax
8010853a:	76 06                	jbe    80108542 <copyout+0x57>
8010853c:	8b 45 14             	mov    0x14(%ebp),%eax
8010853f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108542:	8b 45 0c             	mov    0xc(%ebp),%eax
80108545:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108548:	89 c2                	mov    %eax,%edx
8010854a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010854d:	01 d0                	add    %edx,%eax
8010854f:	83 ec 04             	sub    $0x4,%esp
80108552:	ff 75 f0             	pushl  -0x10(%ebp)
80108555:	ff 75 f4             	pushl  -0xc(%ebp)
80108558:	50                   	push   %eax
80108559:	e8 2a cd ff ff       	call   80105288 <memmove>
8010855e:	83 c4 10             	add    $0x10,%esp
80108561:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108564:	29 45 14             	sub    %eax,0x14(%ebp)
80108567:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010856a:	01 45 f4             	add    %eax,-0xc(%ebp)
8010856d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108570:	05 00 10 00 00       	add    $0x1000,%eax
80108575:	89 45 0c             	mov    %eax,0xc(%ebp)
80108578:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010857c:	0f 85 77 ff ff ff    	jne    801084f9 <copyout+0xe>
80108582:	b8 00 00 00 00       	mov    $0x0,%eax
80108587:	c9                   	leave  
80108588:	c3                   	ret    
